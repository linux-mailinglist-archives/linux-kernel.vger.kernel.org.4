Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3E1681625
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 17:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237454AbjA3QPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 11:15:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237444AbjA3QPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 11:15:17 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F245B440
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 08:15:16 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id m15so679040ilh.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 08:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tbIfAPj8k3uAOfr6K6aV9Bn5Ex894pB/ynQWAG7cJCk=;
        b=W1rtBHWJIYrDQcCGaXClUseLHHT2TWbOGLDzod8YJNm3us/beADICNR+4dbAtjSzBG
         /c/GAfIj+07BnG+v8sNKobcCJM3fb2swCjsWAZctkWspeYnGVU8tqRMDVhgCsDhXSLbD
         gF0IRvdG+v6Sn0CJMLUd4KMB8IjsrUkRo4GeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tbIfAPj8k3uAOfr6K6aV9Bn5Ex894pB/ynQWAG7cJCk=;
        b=urVkVfULn/rYyIV77iEyF26Rd9rWJuPpXkTJ/rFNypWFCfyaWrYQfAfH5xbfsKQ/aE
         k0iSSG9DDpliSdF2lwA9pCWIssPyFtYQpKMG5GKy3lEcpnnhk/QEx20QHH8H5fPxoy/m
         Mj6LeFgqmo+JoYH43EhiUDJewOYAqZZlxl+/tX8UmeI/TXlpVGaVhN53qOyMIgb88OY4
         aSbFqjcLL2a6kkM+/MiVg0y5D/X8yq/30UJGGJmyWors6f6ZprzPaPAMCfl/s3acajYC
         IVcKBrtJYqUF1fVqg2p/iUbWYfxxxK94DRul2du4Iyg5XrreDZmjx6wB3G2CMKezqdwG
         bXzg==
X-Gm-Message-State: AO0yUKVSWukjTI67mKmOx0g3oSzByvgbH+/h2WeLLLcr186sYnMLq7qN
        G4Vbo/I9+PNrYS6rBgUacU9vnw==
X-Google-Smtp-Source: AK7set/LFwFC3JVPAN6fcoQmUXscy/Y836Xioz7r0Ts0cHqMF74X6bIGv/Rldthdjkm8BclJB39NKA==
X-Received: by 2002:a05:6e02:54c:b0:310:57cd:2728 with SMTP id i12-20020a056e02054c00b0031057cd2728mr3758909ils.3.1675095315362;
        Mon, 30 Jan 2023 08:15:15 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id e2-20020a056638020200b003a9515b47ebsm4892341jaq.68.2023.01.30.08.15.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 08:15:14 -0800 (PST)
Message-ID: <3e0af0da-a248-ea7a-e401-c1f3c01e7c75@linuxfoundation.org>
Date:   Mon, 30 Jan 2023 09:15:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 03/34] selftests: clone3: Fix incorrect kernel headers
 search path
Content-Language: en-US
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230127135755.79929-1-mathieu.desnoyers@efficios.com>
 <20230127135755.79929-4-mathieu.desnoyers@efficios.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230127135755.79929-4-mathieu.desnoyers@efficios.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/23 06:57, Mathieu Desnoyers wrote:
> Use $(KHDR_INCLUDES) as lookup path for kernel headers. This prevents
> building against kernel headers from the build environment in scenarios
> where kernel headers are installed into a specific output directory
> (O=...).
> 
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: linux-kselftest@vger.kernel.org
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: <stable@vger.kernel.org>    [5.18+]
> ---
>   tools/testing/selftests/clone3/Makefile | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/clone3/Makefile b/tools/testing/selftests/clone3/Makefile
> index 79b19a2863a0..84832c369a2e 100644
> --- a/tools/testing/selftests/clone3/Makefile
> +++ b/tools/testing/selftests/clone3/Makefile
> @@ -1,5 +1,5 @@
>   # SPDX-License-Identifier: GPL-2.0
> -CFLAGS += -g -std=gnu99 -I../../../../usr/include/
> +CFLAGS += -g -std=gnu99 $(KHDR_INCLUDES)
>   LDLIBS += -lcap
>   
>   TEST_GEN_PROGS := clone3 clone3_clear_sighand clone3_set_tid \

+ brauner@kernel.org

Hi Christian,

Would you me to take this patch through kselftest tree? If you
decide to take this through yours:

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

