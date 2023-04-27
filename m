Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46636EFE8E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 02:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242812AbjD0AiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 20:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjD0AiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 20:38:21 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FD630CD;
        Wed, 26 Apr 2023 17:38:19 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-38ea3f8e413so3035077b6e.2;
        Wed, 26 Apr 2023 17:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682555899; x=1685147899;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FXSGyzqzHrWcVHyNcC7kfb6NKeRaDisdljRhjdUUNL0=;
        b=LgIdeytWNuXZTzJoZs5h76BKIwHFy1naVz7vS6/z/Zdxt2YaVONEt3nKqAHX+scJR5
         IPGvY5e2tBxuzs+i98vy+aZZxB7+1Tj8vExorqu/UbzBG1Euj5dU/1xzAOzKMWVdJBFn
         LsznATIZy7Yklbspo1AxdNT8knB7j6ruFEWtOmCBt12n9unikjWsOcyXDWgJdknt6EkN
         ovlnFrMFAaakFd66yGXZY5Yv7XO1wQF4DeTyh554JAQY6DcNlXZWyutZku2SdvoUxraq
         vfVsrfY/XvOnWE/MyYsf+pTkYDHuB2hoQcoaDLfXqoGxPon9SD26P2536JlX1a14tKLU
         TRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682555899; x=1685147899;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FXSGyzqzHrWcVHyNcC7kfb6NKeRaDisdljRhjdUUNL0=;
        b=M0gkf3RKFJH+MG+pw/wHE/5OKSmlwyFiAWIRzy0p/BevFGS4r934w/NOWOEtBxPm4k
         V0NCmB522W7QisNTWOjMKROI2jkaa9iYiKRj5+d8YkZJd8M0mE+Feufg5EBsywSblLU7
         6vRnpiapkoZaUQEyB3d4VVJPVXSDMmY2bvvfhBeIgRfgrP1jpPTaK1bAY+lXSJyx3S3F
         wNMQ0FkN3D5YAnWzfcFsW3oqiA9ARwR1PJZvBHgLVJ2lUVA1MMhwhKgFUq2czDYuIVLm
         /Q1hLyglr3aLps8Izn8vd9ShWTGDiRUE1uMcPjh7kDzBEi9w4C+aKCcu5yJtLAovJhVb
         CmsA==
X-Gm-Message-State: AAQBX9eWB+3lunKZR3nxNQ+IMQvTD/Qb/6i6NEKKGBdOQshycEgSCgho
        37x5IWTlOx9nckM3ioXOcdLSGPjNlaw=
X-Google-Smtp-Source: AKy350Y0l/UiTP0RXIY4Yjty2Mv10dl80GbsJEY4rwiSy1nUbOup2T6In3Rf0PdwUQ6b+zXo/G3gcA==
X-Received: by 2002:a05:6808:1146:b0:38b:d002:274f with SMTP id u6-20020a056808114600b0038bd002274fmr13222157oiu.11.1682555898968;
        Wed, 26 Apr 2023 17:38:18 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id j130-20020aca3c88000000b00383ef58c15bsm7222627oia.28.2023.04.26.17.38.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 17:38:18 -0700 (PDT)
Message-ID: <54523420-3705-25d9-2b32-1bef98f4f89e@gmail.com>
Date:   Wed, 26 Apr 2023 21:38:06 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] rust: bindings: fix sorting of
 rust/bindings/bindings_helper.h's #includes
Content-Language: en-US
To:     materoy@proton.me
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230426224748.34056-1-materoy@proton.me>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230426224748.34056-1-materoy@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/23 19:57, materoy@proton.me wrote:
> From: Roy Matero <materoy@proton.me>
> 
> Fix sorting of rust/bindings/binding_helper.h's includes,
> to maintain consistency and rust idoms
> 
> Suggested-by: Miguel Ojeda <ojeda@kernel.org>
> Link: https://github.com/Rust-for-Linux/linux/issues/1002
> 
> Signed-off-by: Roy Matero <materoy@proton.me>
> ---
>  rust/bindings/bindings_helper.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 50e7a76d5455..dc8d97272e71 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -6,10 +6,10 @@
>   * Sorted alphabetically.
>   */
> 
> -#include <linux/slab.h>
>  #include <linux/refcount.h>
> -#include <linux/wait.h>
>  #include <linux/sched.h>
> +#include <linux/slab.h>
> +#include <linux/wait.h>
> 
>  /* `bindgen` gets confused at certain things. */
>  const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
> --
> 2.40.1
> 
> 

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
