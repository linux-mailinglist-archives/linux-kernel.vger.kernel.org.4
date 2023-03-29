Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665AD6CEC15
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjC2Oso (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 10:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjC2Os0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:48:26 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36B1189;
        Wed, 29 Mar 2023 07:47:42 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id bm2so11762623oib.4;
        Wed, 29 Mar 2023 07:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680101262;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OXBqzVlrFRt5YtMWe/wv26dM8rUqdeUJBzFLACIXocU=;
        b=h8dOBgu5K5HtZFYHFm7gq4Ng+p4q+BT6YRGX0QCSa9PR/lBjQdMhr56cHlFRmPOcwM
         jEFGueBVPNeP38jfo/uYdMo0VY8fxG3l30CJSKb047fTxjJEcyoP0AeKU097gVPhNdcL
         UnutSu7hssch1ZespwaVB0CS6B32PXQlB/WFWqKmxT1zqc0NZ4wA7EnzmmhHx8XHQ8nv
         SB7ky8Hp22VUF1weadMY6LShg4J5RyViSSeyidqV1U1U7iDb5xTpngLl7lZ0kmZCas8y
         d/OUrY1nTjo207/0SjaHgPF63j4FIh1uXgF8Kp+f441DEdH3gzkGtcjmWrt8+oazbkVF
         rKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680101262;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OXBqzVlrFRt5YtMWe/wv26dM8rUqdeUJBzFLACIXocU=;
        b=e592kz5w4QWY1YYC2SYYyEk+ipfAbasLD6id/RtiUVQdItb0zPgIi0z0BvWvZE5+K8
         m6qar786+/UMBCj0E5+wY/uZNhMJTFTVVRpBuWNlrD+nsel/271jATD4PbKCsLcIL5Wb
         NQsFEikopd/tX2FmOtMm8j/NgEC/a2RfOsfkVk8qH0Kb2c1Wy8MImDA02So4HE//waJN
         zTAF0ZLosAp3bdTw7181MYYPTKBczEiPnoZbdqAakYs+DzIiXR5WjXM5Mo9FE4Id/X32
         J/elvEjOVIUUWjggHVZrNfhscJS5Zkm7DIWOKeKHK0X7LnnWW7/7Qw/Y+vU3l9lquvI7
         TqiQ==
X-Gm-Message-State: AO0yUKWu7fjYSKEw9V3d2j2EVRPula8Ddg3hCgR0K5gF0Xm15ANrTQ67
        Jjtro9DYi4cTZ3yMa45wADw=
X-Google-Smtp-Source: AK7set9pyV7+2EOOD9QC0w1Kjlj4Nucya/1GCIeVTBAJw811qo3Fxz9RUqKEsBnwjcQbApog1WUJ2g==
X-Received: by 2002:a05:6808:659:b0:383:e7c8:4000 with SMTP id z25-20020a056808065900b00383e7c84000mr8531757oih.13.1680101261977;
        Wed, 29 Mar 2023 07:47:41 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id s186-20020acac2c3000000b00383cc29d6b2sm13506162oif.51.2023.03.29.07.47.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 07:47:41 -0700 (PDT)
Message-ID: <0849f870-2d95-8c3a-c7dc-2b18dcee4c65@gmail.com>
Date:   Wed, 29 Mar 2023 11:47:37 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/6] rust: error: Rename to_kernel_errno() ->
 to_errno()
To:     Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Fox Chen <foxhlchen@gmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
References: <20230224-rust-error-v2-0-3900319812da@asahilina.net>
 <20230224-rust-error-v2-1-3900319812da@asahilina.net>
Content-Language: en-US
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230224-rust-error-v2-1-3900319812da@asahilina.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/23 09:04, Asahi Lina wrote:
> This is kernel code, so specifying "kernel" is redundant. Let's simplify
> things and just call it to_errno().
> 
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
>  rust/kernel/error.rs  | 2 +-
>  rust/macros/module.rs | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 5b9751d7ff1d..35894fa35efe 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -73,7 +73,7 @@ pub struct Error(core::ffi::c_int);
>  
>  impl Error {
>      /// Returns the kernel error code.
> -    pub fn to_kernel_errno(self) -> core::ffi::c_int {
> +    pub fn to_errno(self) -> core::ffi::c_int {
>          self.0
>      }
>  }
> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> index a7e363c2b044..143336543866 100644
> --- a/rust/macros/module.rs
> +++ b/rust/macros/module.rs
> @@ -258,7 +258,7 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
>                          return 0;
>                      }}
>                      Err(e) => {{
> -                        return e.to_kernel_errno();
> +                        return e.to_errno();
>                      }}
>                  }}
>              }}
> 

Reviewed-by: Martin Rodriguez Reboredo
