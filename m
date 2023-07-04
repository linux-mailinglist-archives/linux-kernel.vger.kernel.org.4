Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42607472BE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231453AbjGDN3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjGDN3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:29:37 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DAE99;
        Tue,  4 Jul 2023 06:29:36 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id ada2fe7eead31-440c5960b58so1708419137.3;
        Tue, 04 Jul 2023 06:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688477375; x=1691069375;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XmB7Lt1kdBVFrZQRN7GBaRqYcNVkYfgU/8oYqlFezt4=;
        b=ajJ4UiuFndj1QghyWQgPkL/JxKC3j1CBoSonKOyfUJJL7j07mh4qPoGIsk56/chegt
         xpzBz4hA+2qF8Iyg+suTKjFLkDI9hiAyA43m8+N0/78KMweoPyissSbRCxDPlEZlbe9B
         QQq2iQaIM63wFhEmEq36Es23XFItAVroZiyNHk0nsjNxChQS4gcw5rx0S+jPQJsKNUDF
         qgt/yD4FKjpTxS/+okX250KkIfpcfwON3oS8NF1OyVkfF/+c6WS0nNI/C+dSZIpBKbWs
         v+0j+vAEGllmImrMMhN+l6gMWa+85tjTmTlkC8lX6fitTHJJ5jx3Q8ckwwVni/moruf8
         7wBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688477375; x=1691069375;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XmB7Lt1kdBVFrZQRN7GBaRqYcNVkYfgU/8oYqlFezt4=;
        b=e+Koq5aAylfI7xnJ926pmdLcIdmzAJSjU4xzn7pr7q1l+Epx1cHbeWCO+C5BFcQQkm
         F4n2PfUrcgBhXBXbpa1IhSIbuaKqZWMtuNJ7EbEIpElATRrWJWNNt3AxyU73B65lftVa
         nSGfpx/kVFewdX+1DimJPJ2+83JIFC4KA6eietr8dTof8aflqckPhKaOJA1I/zt0ATGm
         8I46Yvlfm6EwBHint1mIGWUDVV87UlayCl4Lwr/EyhKoQ+NzSBHQSBGNWZxl9sa56iNU
         rv/1ekCYnfabx/uSev+nKCZSoDcxToynaepV7LoefeWJ3G0++vI7FA9OwJCIsTxITCRk
         Kw9A==
X-Gm-Message-State: ABy/qLaRKz+3vMgrZgtwIvMAN/F3etnBz24wKOmZ1m8rI1BYCiDJbPMH
        b+mD/BA40cSJLSvC5LdmcDA=
X-Google-Smtp-Source: APBJJlG6UXeTK7QCoVEmWgU5r0gDS1LYzy0V2HuWLufr6jmxSy6vhodnImbYXmBhc6oWC5DcwYECTg==
X-Received: by 2002:a05:6102:50d:b0:443:92af:a851 with SMTP id l13-20020a056102050d00b0044392afa851mr5784886vsa.32.1688477375412;
        Tue, 04 Jul 2023 06:29:35 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id v13-20020a67ac0d000000b00440978082a6sm3673732vse.8.2023.07.04.06.29.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 06:29:34 -0700 (PDT)
Message-ID: <5164d21e-1ceb-35cf-1d1d-6c32fcdcc4c5@gmail.com>
Date:   Tue, 4 Jul 2023 10:29:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] btf, scripts: rust: drop is_rust_module.sh
To:     Andrea Righi <andrea.righi@canonical.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev
References: <20230704052136.155445-1-andrea.righi@canonical.com>
Content-Language: en-US
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230704052136.155445-1-andrea.righi@canonical.com>
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

On 7/4/23 02:21, Andrea Righi wrote:
> With commit c1177979af9c ("btf, scripts: Exclude Rust CUs with pahole")
> we are now able to use pahole directly to identify Rust compilation
> units (CUs) and exclude them from generating BTF debugging information
> (when DEBUG_INFO_BTF is enabled).
> 
> And if pahole doesn't support the --lang-exclude flag, we can't enable
> both RUST and DEBUG_INFO_BTF at the same time.
> 
> So, in any case, the script is_rust_module.sh is just redundant and we
> can drop it.
> 
> NOTE: we may also be able to drop the "Rust loadable module" mark
> inside Rust modules, but it seems safer to keep it for now to make sure
> we are not breaking any external tool that may potentially rely on it.

Keep it, I think it can be useful with tooling like kmod.

> 
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
