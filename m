Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2BEB6CEC1E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjC2Ot7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 10:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjC2Ot4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:49:56 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8901D196;
        Wed, 29 Mar 2023 07:49:49 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id r14so6075831oiw.12;
        Wed, 29 Mar 2023 07:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680101389;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vRqpC2pNLFE0BwqBPX96lUg22eDDLB+g7ixyozfNakU=;
        b=iMG/FLKtqXGOz1EhsGEHAlEIa33i0ikt2fvQ9xAImPoNz8MT1oWTcp4cAcDKRjhjO8
         zsPV4Pc2bo17qw2PI7BD+NYAkDBxCFbmZ20eGUWLomD0TCJZ0M7/SYJkNrf369ybiQxx
         6/KTfQQxvAzeeGZ9emrm8EpyKFvzqX59A/NdQiPML8pxM61+ktxZrTg8sRSlCzKMJKBZ
         TPmyYsVrdG8yYU8Y/oiNuMS8zy3EIqyB17m/6alrn/HKl/CSj6cFX3EOgkcoiMgSuZGX
         EFCWfi4Q+ma447ADUJjewkpeY7vMDtCzmOM8iRG7TxDOqm0uoos94PH4AMRiunZx7hTl
         lWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680101389;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vRqpC2pNLFE0BwqBPX96lUg22eDDLB+g7ixyozfNakU=;
        b=cefY7mKfiGnsV0lmbmWy/c4sHjydSEsKWCym9ZpPCnwO5EbgBZ+oPoMQI3iMN5UQLs
         ORFIKkj3wHYz5mxdyV0oIpP2usIA7dYeexjRx85khhnYWBh1PiuvVP9hciiEgg9jHLnv
         gUFEt68XxSrMwUbLmteq8PjGavUs9Ec6EiiHA8qCqCQ3A5iII8ENFICofXbT2vEUJtpB
         x0voV/5LJISByFHEBrdhl51tkvv+i4M1BCE8LIFM0ju/T+qDaX06uNXfsNEFy0sUYjkq
         pT0PKXEJxTGJaVYV2aQzfn4ahJXKzd5Vrub0pRavtkCxXUl4xfkgP6a1VTNVbShwJIuB
         /p9Q==
X-Gm-Message-State: AO0yUKVFtraSu236PhpTSTweb3E3MeppUbS97pIedjKoRlYbGOqQfVls
        e+l3P2ojQRKEYjIiZOjAdzg=
X-Google-Smtp-Source: AK7set9TgXi4XHJUWaDV/8TsTUYmyeTkMiwiPoODzO+yO5pUgrzeWwxA555ocT8N3LcxNIfdR/bH+Q==
X-Received: by 2002:aca:2b0a:0:b0:386:d4f7:6791 with SMTP id i10-20020aca2b0a000000b00386d4f76791mr8510594oik.37.1680101388925;
        Wed, 29 Mar 2023 07:49:48 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id e62-20020acab541000000b0038694b7dc09sm4621956oif.55.2023.03.29.07.49.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 07:49:48 -0700 (PDT)
Message-ID: <64a4a0fe-d364-4cd0-e2e5-8e7cfd782ee6@gmail.com>
Date:   Wed, 29 Mar 2023 11:49:44 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/6] rust: error: Add Error::to_ptr()
Content-Language: en-US
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
 <20230224-rust-error-v2-2-3900319812da@asahilina.net>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230224-rust-error-v2-2-3900319812da@asahilina.net>
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
> [...]
> 
> +
> +    /// Returns the error encoded as a pointer.
> +    #[allow(dead_code)]
> +    pub(crate) fn to_ptr<T>(self) -> *mut T {
> +        // SAFETY: Valid as long as self.0 is a valid error
> +        unsafe { bindings::ERR_PTR(self.0.into()) as *mut _ }
> +    }
>  }
>  
>  impl From<AllocError> for Error {
> 

Reviewed-by: Martin Rodriguez Reboredo
