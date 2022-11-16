Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A400262C2C5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 16:40:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiKPPjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 10:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKPPjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 10:39:41 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA30B0F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 07:39:40 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id r81so13490061iod.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 07:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iMHx/vokz1k7Wi/WEPw4ZBS5/lU9XgdBjxag6InAIZ4=;
        b=DwJ7hMNROVizE3VYQayvOB3lrUO4Ntzene33dYvnRElQEo6fK+RVv8KLSVJYQqCp4M
         ENmC1LPpvw7ZFxFQNkcRWsgJiYooh/5LAuFQv45l59cFD9OyDe8CxcMZmoeEYmKpIKAG
         1As1retSSkaP0sIxQRKqY5QeYyX1hm+z+u4gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iMHx/vokz1k7Wi/WEPw4ZBS5/lU9XgdBjxag6InAIZ4=;
        b=C4mUQu8w1dlU3gGXuLUKAoIhlxe9qDspmnQVsX1htblZLPq8YAexLLqhus3SqNRjeD
         5pqMGwUJQzRHKUyqvmJcBrYZVB0kLkpSEJ7U9J24Lsd0n1+Vw2bL1D0C5/FLtVz8d73i
         mEnCAJaGzdGA0msBhFOju3H8TrDz5DVeZ3zeFdFo1nPlmc0P32R82c7qda3B0j3BrYgC
         smgdjYoxQqKs4sUuMqHAGVvorf00tbybFFzHhxlm6My/Ylds3SMnNcnTzUu8vgoU1NkF
         RIL4EQyoAq3MOBg3GwuzqSfM3u0y+ApBKqtDa1Gpd/vZ+NKqyke97ae4r/08F6ory8nV
         lu+Q==
X-Gm-Message-State: ANoB5pkPaCOvYM0z3xntVvOIrAg3tjUcMmfKl0e3dOvbYSPhz8tFaLJZ
        lk7TdE0hZ3Jnk1zyr5pACp0uJEWQxfylag==
X-Google-Smtp-Source: AA0mqf5SKAevvFFIk+N9V3OXEB2aBc2fZTBUxlBo1JB4Ii9eJjuTyonpWTSfyVaJIMFnO+gttF8Bnw==
X-Received: by 2002:a02:c6bc:0:b0:375:bc14:b202 with SMTP id o28-20020a02c6bc000000b00375bc14b202mr9760162jan.244.1668613180182;
        Wed, 16 Nov 2022 07:39:40 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id o195-20020a0222cc000000b00363f8e0ab41sm5840761jao.152.2022.11.16.07.39.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Nov 2022 07:39:39 -0800 (PST)
Message-ID: <2ab19d48-57e2-ba0e-6d36-431acc26dec3@linuxfoundation.org>
Date:   Wed, 16 Nov 2022 08:39:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] cpufreq: amd-pstate: fix spdxcheck warnings for
 amd-pstate-ut.c
To:     Meng Li <li.meng@amd.com>, Huang Rui <ray.huang@amd.com>,
        linux-kselftest@vger.kernel.org
Cc:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Shimmer Huang <shimmer.huang@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221114054037.2962372-1-li.meng@amd.com>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221114054037.2962372-1-li.meng@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/13/22 22:40, Meng Li wrote:
> spdxcheck warnings: (new ones prefixed by >>)
>>> drivers/cpufreq/amd-pstate-ut.c: 1:28 Invalid License ID:
> GPL-1.0-or-later
>     drivers/spi/spi-gxp.c: 1:35 Invalid token: =or-later
> 
> Signed-off-by: Meng Li <li.meng@amd.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>   drivers/cpufreq/amd-pstate-ut.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
> index e4a5b4d90f83..7f3fe2048981 100644
> --- a/drivers/cpufreq/amd-pstate-ut.c
> +++ b/drivers/cpufreq/amd-pstate-ut.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-1.0-or-later
> +// SPDX-License-Identifier: GPL-2.0-or-later
>   /*
>    * AMD Processor P-state Frequency Driver Unit Test
>    *

Thank you. Applied to linux-kselftest next for Linux 6.2-rc1

thanks,
-- Shuah
