Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B181573E5C3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 18:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjFZQto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 12:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjFZQtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 12:49:42 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07A51B1;
        Mon, 26 Jun 2023 09:49:40 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6b78916ea66so145476a34.1;
        Mon, 26 Jun 2023 09:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687798180; x=1690390180;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0D9OFT0J8N9jcY4CKBEcVZQgCuAlL3uNYGNYsazarPM=;
        b=CzMQI/kBYO1ahWW1DLWuET26J2pDpVuK2Hi9YxFHx6A4MNbjwbA4XhQ2Tj6DjP9yhw
         djXxiFtW+QxF/hsN7AD/6l2z+qUVtJg20yxsUR/9ac5MvFg0fzpnGpXVDKLdKh41BHdH
         vnZ6UdTFiEhf+gzmFdLwlvxxLHeHfX3Q9072zc8qAl+Oj9hw3ouJeLPI8Xo03n6kCg5y
         WVDQZpOCzfZcuHf+67JOr6+LUaAQS5d6u8YwaWrAO/qjoRXYdVA67w5gsVT4d9aVnIBr
         c8fT/JkIM7hNaOoat0aslSzya0m+9PLqcRrgqeHr/MKaMNPzN1ggelFyzwLdNwVlLBk6
         ZSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687798180; x=1690390180;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0D9OFT0J8N9jcY4CKBEcVZQgCuAlL3uNYGNYsazarPM=;
        b=j9Pbbkd4x+DsBzjO4GitYRALbEHtOjVjWhYyGsr2kYFcEzN3ZgfF8bKqjSjSk2n1Rh
         ohxF0DRJE8eWE4jpj2vQQz+ztlWOtFRZamst3+HftRs7ykV67ilrjxFgvGoWu+H0PLe2
         GV2abF+Yf1sJruFc0iudqv7F3iOUqd/LqmrxYdv4yIo8LJQrqiCrFBMuEPVaXzsfaGH9
         W8ReopKZLrZD4/g+B49HCYjjn2T+Nphop2pAY/QrcZCPwb+1n8hPxBxhzkt4EbgV8uM5
         63RiYGZd2/TiBDKl92lYgtxhNNq7tQp68ibS3tG/7V1yPSfg5AHqfqsGiYWQnWgVZJp6
         Uyvw==
X-Gm-Message-State: AC+VfDw9XlnLfhSV2ScXpBOUDShERoz8lujWjmH2j/T5JjKm6F+Im3Q2
        joka/Id4Wh4bMA5kTnrmMFii7D3+dr4=
X-Google-Smtp-Source: ACHHUZ4puXRreohcxKytYSV9RgTThgR/wnT9ek9sbNxxw6ZZogB+bcYRFthdPDuvWBzSiSsoStuSZQ==
X-Received: by 2002:a9d:4f01:0:b0:6b7:52ce:ff38 with SMTP id d1-20020a9d4f01000000b006b752ceff38mr1748306otl.16.1687798179865;
        Mon, 26 Jun 2023 09:49:39 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id dj23-20020a0568303a9700b006b469ace1b1sm2775637otb.22.2023.06.26.09.49.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 09:49:39 -0700 (PDT)
Message-ID: <743b4c1f-6c46-6d5d-24e9-b286d021389b@gmail.com>
Date:   Mon, 26 Jun 2023 13:49:35 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/1] rust: macros: fix redefine const_name in `vtable`
Content-Language: en-US
To:     Qingsong Chen <changxian.cqs@antgroup.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?B?55Sw5rSq5Lqu?= <tate.thl@antgroup.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        =?UTF-8?Q?Sergio_Gonz=c3=a1lez_Collado?= <sergio.collado@gmail.com>,
        rust-for-linux@vger.kernel.org
References: <20230626074242.3945398-1-changxian.cqs@antgroup.com>
 <20230626074242.3945398-2-changxian.cqs@antgroup.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230626074242.3945398-2-changxian.cqs@antgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/26/23 04:42, Qingsong Chen wrote:
> If the trait has same function name, the `vtable` macro
> will redefine its `gen_const_name`, e.g.:
> ```rust
>      #[vtable]
>      pub trait Foo {
>          #[cfg(CONFIG_X)]
>          fn bar();
> 
>          #[cfg(not(CONFIG_X))]
>          fn bar(x: usize);
>      }
> ```
> Use `HashSet` to avoid this.
> 
> Signed-off-by: Qingsong Chen <changxian.cqs@antgroup.com>
> ---
> [...]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
