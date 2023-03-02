Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368386A84BB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjCBO7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:59:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbjCBO7K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:59:10 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AD42D65;
        Thu,  2 Mar 2023 06:59:06 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id c184-20020a4a4fc1000000b005250b2dc0easo2677106oob.2;
        Thu, 02 Mar 2023 06:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qEpgxeitDDP5Tn7uIim35FMdWdclFw2u8SG1VaCEidM=;
        b=YVCcOaNBTMmoAfpjjDb1z/1tHgiRHg7yxRnpeWD4pDu1+2dpzchhQKceqHJV8rJJSm
         EzDLN+F1CbjibolcjaOiNgSGhV0Z64p+Yjj1+mGInnL679FELNsJdEN85NUuXFDGjugN
         oJj45qgnI2DWoyuPc/No9P1BfvELrrbCeV6dhFM+zVIGOgorZVxOipoHB3hW7unamk4J
         GQmFkA3zfn0p0o/YrWOFAyEIiFouGhjCcx6roAvtNQKioZrGfrIeloXpwHoZjqeWIDia
         Xj2ZCJq6ZCdRRhZEPQliQglQPrhWW/19xapVoCn5BRS45AcirO9QBHx6oBZKene1sP3O
         TkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qEpgxeitDDP5Tn7uIim35FMdWdclFw2u8SG1VaCEidM=;
        b=ZCgEhp5jCD77bu6uudZl3zjdUK/Y0XhOcfVSfjRqFr6n3v9oddMfw4fvXm4vUQEdWg
         lQmG91/54i/YxkWlbO6x0GUySR0cqnzgsd4A4jcJejKlmpSK71NWE3kUpYPGu/za7DJ7
         j1KDtDyPIYOXLJOd2iipYOOE86hxHtKh7pKDxdgkGf0Tc3Jnnt/ojk7FAg0xmviWQKDl
         a9kTp5lNoPELXFadcvU9T57BzMl38pYRAR7tMsdEr4qGEa/hU70/EHKf1iwWOY1kCjiF
         ifY9NS9ngDlhpQ259Edyg6VNHWBunqWU/sov4vBGgI9eSQkJ/EA2d3WYPWZfXmSX0ue3
         sIGQ==
X-Gm-Message-State: AO0yUKUcjhP3E+rkiXzluWi8eLtgtPR3ZS0KH5MRSFFU26nVgPWzVp1P
        LwRJECSkDGYc/vXwe9zMn5c=
X-Google-Smtp-Source: AK7set+SJASFyhOWznnJ//RCUCO/aNdtnRCrVi/mLeEWl1GBQgyJvXjf1BvjxCiPKvsrCpnZfTrlFQ==
X-Received: by 2002:a4a:a689:0:b0:525:58f7:cbef with SMTP id f9-20020a4aa689000000b0052558f7cbefmr4911251oom.2.1677769145410;
        Thu, 02 Mar 2023 06:59:05 -0800 (PST)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id v17-20020a4ae051000000b0051ac0f54447sm6076252oos.33.2023.03.02.06.59.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 06:59:05 -0800 (PST)
Message-ID: <37578649-c696-f3b5-a216-196e210929e5@gmail.com>
Date:   Thu, 2 Mar 2023 11:59:00 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/1] rust: bindgen: Add `alt_instr` as opaque type
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Derek Barbosa <debarbos@redhat.com>,
        rust-for-linux@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <ZACvxNOuuyifQ9Nx@kernel.org>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <ZACvxNOuuyifQ9Nx@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/23 11:16, Arnaldo Carvalho de Melo wrote:
> To address this build error:
> 
>     BINDGEN rust/bindings/bindings_generated.rs
>     BINDGEN rust/bindings/bindings_helpers_generated.rs
>     EXPORTS rust/exports_core_generated.h
>     RUSTC P rust/libmacros.so
>     RUSTC L rust/compiler_builtins.o
>     RUSTC L rust/alloc.o
>     RUSTC L rust/bindings.o
>     RUSTC L rust/build_error.o
>     EXPORTS rust/exports_alloc_generated.h
>   error[E0588]: packed type cannot transitively contain a `#[repr(align)]` type
>        --> /var/home/acme/git/linux/rust/bindings/bindings_generated.rs:10094:1
>         |
>   10094 | / pub struct alt_instr {
>   10095 | |     pub instr_offset: s32,
>   10096 | |     pub repl_offset: s32,
>   10097 | |     pub __bindgen_anon_1: alt_instr__bindgen_ty_1,
>   10098 | |     pub instrlen: u8_,
>   10099 | |     pub replacementlen: u8_,
>   10100 | | }
>         | |_^
>         |
>   note: `alt_instr__bindgen_ty_1__bindgen_ty_1` has a `#[repr(align)]` attribute
>        --> /var/home/acme/git/linux/rust/bindings/bindings_generated.rs:10111:1
>         |
>   10111 | / pub struct alt_instr__bindgen_ty_1__bindgen_ty_1 {
>   10112 | |     pub _bitfield_1: __BindgenBitfieldUnit<[u8; 4usize], u16>,
>   10113 | | }
>         | |_^
>   note: `alt_instr` contains a field of type `alt_instr__bindgen_ty_1`
>        --> /var/home/acme/git/linux/rust/bindings/bindings_generated.rs:10097:9
>         |
>   10097 |     pub __bindgen_anon_1: alt_instr__bindgen_ty_1,
>         |         ^^^^^^^^^^^^^^^^
>   note: ...which contains a field of type `alt_instr__bindgen_ty_1__bindgen_ty_1`
>        --> /var/home/acme/git/linux/rust/bindings/bindings_generated.rs:10104:9
>         |
>   10104 |     pub __bindgen_anon_1: alt_instr__bindgen_ty_1__bindgen_ty_1,
>         |         ^^^^^^^^^^^^^^^^
> 

Reading the kernel sources this field corresponds to an u16 which indeed
represents a bit set and it says so in a comment on the field. I
couldn't replicate this issue, though, because this struct is used only
inside arch pretty much internally, then there's no problem to make it
opaque. Still, we have to be careful if these kind of things appear in
the future.

And I notice that You haven't mentioned the version of Bindgen that
You've used, including its linked libclang too. Otherwise I think this
could be accepted.

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

>   error: aborting due to previous error
> 
>   For more information about this error, try `rustc --explain E0588`.
>   make[1]: *** [rust/Makefile:389: rust/bindings.o] Error 1
>   make: *** [Makefile:1293: prepare] Error 2
> 
> Cc: Derek Barbosa <debarbos@redhat.com>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  rust/bindgen_parameters | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters
> index be4963bf720304da..552d9a85925b9945 100644
> --- a/rust/bindgen_parameters
> +++ b/rust/bindgen_parameters
> @@ -6,6 +6,7 @@
>  --opaque-type local_apic
>  
>  # Packed type cannot transitively contain a `#[repr(align)]` type.
> +--opaque-type alt_instr
>  --opaque-type x86_msi_data
>  --opaque-type x86_msi_addr_lo
>  
