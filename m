Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F176AA09A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 21:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbjCCU3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 15:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjCCU3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 15:29:18 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24939EF84
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 12:29:17 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id x10so2432501ill.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 12:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1677875356;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e0LzGjIMPosJSmf+/sQBmlwLSdpWvs5gZiiybS0LDqs=;
        b=GYG5pMHfASSwZJbwRW5683/5cOuRhHCi8afcHqjQV/i4zixiw6DGQV9zshhp2737/F
         OGKCM1QFKZinO3EC+KUcCxQ3r22zeyId8R3n13oW2iwCbreGS+00RLeLW2sq6LZ6broi
         d/oHuroYQ4xN6Q+7pDB9B6Nn8tWikD4gzmGlI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677875356;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e0LzGjIMPosJSmf+/sQBmlwLSdpWvs5gZiiybS0LDqs=;
        b=wXKjiywYF6PtE05iMZUd2XL/w6d2TFeZPTI1SS++RRo3qHvdXvId75JKvhxRR9LkBE
         JPe7l9Xs8Je3g3w6PJVlbK26n/IZGlPuHRCZ4KJ5mlC6PCLDuJ1kOxi0bGSAVdBzECXE
         UB27Ua6Vh+NofWkHhjDuBrdvaHG8uNXgrQMmdHJK05GMTE0FD01GggHbC+Y0CLcDQ1Yc
         vloeTjkCB62FnZ5cmhS1ky4Hj99pzn3q8rkMK/wrqu3rxsMXGBorhR+4Lktq7gGKU8Qk
         Gs43JaAxJBbHvgAtVuLHaTHa5znfzq5qZIRCc/G3Sewn3aNhj+VgxANxvvE2gC3Aacdg
         cbew==
X-Gm-Message-State: AO0yUKUNKwazc1PGEYeeOPzE+evbKZ467o05gSiUCyP8DdeAzfDAEYpB
        XVN6pRcQkZIfrix36PPy8cZQYscXkYQh1mWt8Oc=
X-Google-Smtp-Source: AK7set+v5vOte2RN0n2pqz7cfxz2xavYFisT3AmMBWRTKSs3pvHhcztEKGHHBlYWdj74NFDldWHoHA==
X-Received: by 2002:a05:6e02:13f4:b0:317:16bc:dc97 with SMTP id w20-20020a056e0213f400b0031716bcdc97mr1753665ilj.3.1677875356468;
        Fri, 03 Mar 2023 12:29:16 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id q22-20020a02cf16000000b0039e89ea68f9sm920025jar.135.2023.03.03.12.29.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 12:29:15 -0800 (PST)
Message-ID: <3d051308-382f-0f90-41b3-e1ffdd6f11f7@linuxfoundation.org>
Date:   Fri, 3 Mar 2023 13:29:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] selftests: amd-pstate: fix TEST_FILES
Content-Language: en-US
To:     Huang Rui <ray.huang@amd.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        "Meng, Li (Jassmine)" <Li.Meng@amd.com>,
        Doug Smythies <dsmythies@telus.net>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernelci@lists.linux.dev" <kernelci@lists.linux.dev>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230204133454.260066-1-guillaume.tucker@collabora.com>
 <ZAGOQznWjSNuhn73@amd.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ZAGOQznWjSNuhn73@amd.com>
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

On 3/2/23 23:05, Huang Rui wrote:
> On Sat, Feb 04, 2023 at 09:34:54PM +0800, Guillaume Tucker wrote:
>> Bring back the Python scripts that were initially added with
>> TEST_GEN_FILES but now with TEST_FILES to avoid having them deleted
>> when doing a clean.  Also fix the way the architecture is being
>> determined as they should also be installed when ARCH=x86_64 is
>> provided explicitly.  Then also append extra files to TEST_FILES and
>> TEST_PROGS with += so they don't get discarded.
>>
>> Fixes: ba2d788aa873 ("selftests: amd-pstate: Trigger tbench benchmark and test cpus")
>> Fixes: ac527cee87c9 ("selftests: amd-pstate: Don't delete source files via Makefile")
>> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
> 
> Acked-by: Huang Rui <ray.huang@amd.com>
> 

Thank you both. I will pick this up for 6.3-rc2

thanks,
-- Shuah

