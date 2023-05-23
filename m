Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DFE70E214
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjEWQmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjEWQmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:42:00 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1F2E5;
        Tue, 23 May 2023 09:41:59 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-19cf62eb14aso1429814fac.3;
        Tue, 23 May 2023 09:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684860119; x=1687452119;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UGIAcK//rWFEB52G558om/gyBjR/E70Z681VXJvEV7Q=;
        b=Lv8JXm0M39MGa8L2iwrHyTeoixTXheqlvWR2nOc9xEuyBESJ2cICWfTFj+iDvvT71n
         Ox44V/OpikZ3IzC4LvN5VcHgN5a742UW5bN0u6r9iVKNEyhK8ZE1EHDhfvSglbeV1ap6
         faQc546Ef/EFw5SSH3Gs4BkYMmsQ0ycm6I2ncUEvSSCUCkndvce5k4/pXaOdP31qd0bQ
         gsFb8t0Pta0E0tPKT2ZdkPsUla94eyf9J8pMU2c6ObH3UmlaGvfB53pcO0o7UjAasly5
         NlaAz0uaJu1C1QRFVNd7OtZwTthbJel09z2nsEmJ5pAi7XWS/tvQk07VeSxMnJOiuKo0
         HDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684860119; x=1687452119;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UGIAcK//rWFEB52G558om/gyBjR/E70Z681VXJvEV7Q=;
        b=BnW7AyfgjbkPoDQ0CW/r4A+6nFvoQX32kKjzLizJDrw1qhI+E2oFenO8/FBWJQ7ypi
         HdNDroSeJ6vhJbK2ax+2gl/xiavfYntEAiY9djnXY8+jNxOmnk4j9mQaBPQdkrrnGr6d
         1hv8lXeIACgxli54pWgOLwtXMiV8/cyx61Rf2b3Xkldf9GvNRA0bY+obBbkwRV1CSdon
         0umW603BOCKaa+t04FFdERRPU4OIWuEvoUuJhxdinFkpwJWei2o0r1uQOJWgQJaLh8uL
         vQU49Quvy218pKc+bvPOIlU3YBLvMHoXaui5U7nbq5AOgJ1/7lsYfkccNBp7ur8Up0tk
         shZQ==
X-Gm-Message-State: AC+VfDyKQBqHfX70h+0073FRAlNujX1MT4AvtZljudo3sLzoTByNBLe7
        gJaWK5S1bH6/XtJiM/se+g3q5tuwzNA=
X-Google-Smtp-Source: ACHHUZ7AtLXNniWbdzOItGmRZcOSmZZWunEFBvWSHA1VuhlUWncUxZXs6FsTtfiArz0xnvGEsCcC9w==
X-Received: by 2002:a05:6808:1cf:b0:38e:54ef:47fb with SMTP id x15-20020a05680801cf00b0038e54ef47fbmr6747774oic.48.1684860118720;
        Tue, 23 May 2023 09:41:58 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id j185-20020aca3cc2000000b003983f683f41sm478479oia.21.2023.05.23.09.41.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 09:41:58 -0700 (PDT)
Message-ID: <640a6624-73d9-5650-4570-d822e7515900@gmail.com>
Date:   Tue, 23 May 2023 13:27:46 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/4] rust: sync: reword the `Arc` safety comment for
 `Send`
To:     Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Andreas Hindborg <a.hindborg@samsung.com>
References: <20230523144418.1250547-1-aliceryhl@google.com>
 <20230523144418.1250547-2-aliceryhl@google.com>
Content-Language: en-US
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230523144418.1250547-2-aliceryhl@google.com>
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

On 5/23/23 11:44, Alice Ryhl wrote:
> The safety comment on `impl Send for Arc` talks about "directly"
> accessing the value, when it really means "accessing the value with a
> mutable reference". This commit clarifies that.
> 
> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> ---
> [...]
>   
>   // SAFETY: It is safe to send `Arc<T>` to another thread when the underlying `T` is `Sync` because
>   // it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally, it needs
> -// `T` to be `Send` because any thread that has an `Arc<T>` may ultimately access `T` directly, for
> -// example, when the reference count reaches zero and `T` is dropped.
> +// `T` to be `Send` because any thread that has an `Arc<T>` may ultimately access `T` using a
> +// mutable reference, for example, when the reference count reaches zero and `T` is dropped.
>   unsafe impl<T: ?Sized + Sync + Send> Send for Arc<T> {}
>   
>   // SAFETY: It is safe to send `&Arc<T>` to another thread when the underlying `T` is `Sync` for the

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
