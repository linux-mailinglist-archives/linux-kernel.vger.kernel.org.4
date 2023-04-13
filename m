Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DF76E0CDC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 13:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjDMLnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 07:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjDMLnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 07:43:14 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52CF1DE;
        Thu, 13 Apr 2023 04:43:12 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id k22-20020a9d7016000000b006a43382e5b9so424326otj.3;
        Thu, 13 Apr 2023 04:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681386191; x=1683978191;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mtkxny2XQ1LJCG2ofJudelWHLWK11yhtce+Fr/hSPn8=;
        b=oXjbFJvk92wtbyCcl59f74SM1mU4r5QhoXD8WwDF5VnGA0gYWNUw/ZTzhjZp7Gt5T8
         DTKAzl1FIuBZ/JcyGWZEO9j1jr844bTUfa+rnFDx8ijPSkwqCYe+yPipv3IFsySaa2cD
         Srql1CUGrCo25m+nxA5Os4/G2ciOKszpPW5EUWpwzyqTTyWmMws1U/DSqbvogFACFnBr
         qO+hc6kcMnaHDXnCSh6cObRJL8ICMvRJOV8BgNKdQhIER+60oAU2YA0c6OOwtcGRwsJj
         XYbwWAo3T/QFgUIRB6QYa4gOfgO65t/pJiJ7qNn3d/KfDkaNG1/yFL4bNl0NmwrjIljk
         Ujqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681386191; x=1683978191;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mtkxny2XQ1LJCG2ofJudelWHLWK11yhtce+Fr/hSPn8=;
        b=bE9PPhp2lCtVOUAHwPbAQzu+CIdmBu9vxVKGls/RQKiE25rZ4FAqpGPf02jft6qHzL
         1IHYSiOSgCYHvxGsmFhaoyJvm37asaENwTkpthkEMYLJJRdt1u5FOnfK1iYEzTF8yRPX
         7hqc87ANy39UqPSdHDjAkeWCS4ypyXhv19G7p4/mEAW48p8Yao/0KdUQldt53QjdaObf
         hyrkO5FF4jT7chMEbLdvmMmgM74OxRZqkV83wqQRtspUuSlRHUgN21yfV6Ne1t5eF7fS
         Ondhy+W/pcH8DniQWbGhMne866xZAJ/BdcogFT/Tp/686c07tYtAVxbQwjl6Qqr/9O1I
         JtHA==
X-Gm-Message-State: AAQBX9dffxyjOUQyxxU32bO84DIgVpeREOYmq8V2p0NpcZ8jp/3kjSk1
        OzVtId0i6vOwcBj3Z6dr23wAve3wDwI=
X-Google-Smtp-Source: AKy350YZTDJKV+tiTbQnkjJAINUoycnSG+9D+G9cnYQXR8TK/HyVLbFOZpwTulkcVVsHrnC6L0M7PQ==
X-Received: by 2002:a9d:6c55:0:b0:6a3:c51c:e615 with SMTP id g21-20020a9d6c55000000b006a3c51ce615mr797209otq.8.1681386191480;
        Thu, 13 Apr 2023 04:43:11 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id w24-20020a9d6758000000b006a11dd6d2c1sm597872otm.29.2023.04.13.04.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 04:43:11 -0700 (PDT)
Message-ID: <1b61b5dc-a006-3307-b478-baa5520cb8af@gmail.com>
Date:   Thu, 13 Apr 2023 08:43:07 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] rust: init: broaden the blanket impl of `Init`
To:     Benno Lossin <benno.lossin@proton.me>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
References: <20230413100157.740697-1-benno.lossin@proton.me>
Content-Language: en-US
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230413100157.740697-1-benno.lossin@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/23 07:02, Benno Lossin wrote:
> This makes it possible to use `T` as a `impl Init<T, E>` for every error
> type `E` instead of just `Infallible`.
> 
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---
> 
> @Miguel: you can squash this patch into 90e53c5e70a69 or put it on top of
> rust-next.
> 
>  rust/kernel/init.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> index a1298c8bbda0..4ebfb08dab11 100644
> --- a/rust/kernel/init.rs
> +++ b/rust/kernel/init.rs
> @@ -1190,8 +1190,8 @@ pub fn uninit<T, E>() -> impl Init<MaybeUninit<T>, E> {
>  }
> 
>  // SAFETY: Every type can be initialized by-value.
> -unsafe impl<T> Init<T> for T {
> -    unsafe fn __init(self, slot: *mut T) -> Result<(), Infallible> {
> +unsafe impl<T, E> Init<T, E> for T {
> +    unsafe fn __init(self, slot: *mut T) -> Result<(), E> {
>          unsafe { slot.write(self) };
>          Ok(())
>      }
> 
> base-commit: 1944caa8e8dcb2d93d99d8364719ad8d07aa163f
> --
> 2.39.2
> 
> 

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
