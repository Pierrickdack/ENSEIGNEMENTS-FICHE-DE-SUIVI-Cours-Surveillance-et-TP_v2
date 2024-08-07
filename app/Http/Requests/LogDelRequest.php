<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class LogDelRequest extends FormRequest {

    public function authorize(): bool {
        return true;
    }

    public function rules(): array {
        return [
            'emailDel' => 'required|email',
            'mdpDel' => 'required|min:6|max:15',
        ];
    }


}
