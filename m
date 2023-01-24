Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A80678D1E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 02:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbjAXBFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 20:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjAXBFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 20:05:51 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E0330B1C
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 17:05:51 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id g16so970077ilr.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 17:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s93ZKJi/eyAuvTHK5GSRYNYk2jtuLDZoKO9TCFwwVLQ=;
        b=Fg+kpPe+pheuW1fV4nyazNl4T2zPM0uBxI/8MU8sMc0Tq0v9TuEyQ1l6KUxXZW+pr8
         KLY2Xmir95LDiU57+//hr4EfiuEZeVpIYsRKRwV6VNQ8Dw8YAXhlbHXZ+sCj4qe1GKeJ
         6AdmbRXMVrR3NidbR9kVTigJY1KrhSaRuFKBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s93ZKJi/eyAuvTHK5GSRYNYk2jtuLDZoKO9TCFwwVLQ=;
        b=6xC4KtgJJ+MoQo6uXnA7EpuWRb+H31PMOJjNOU1ubHKK7rYxssGlXKj9tk7yxO7JJC
         qNXuc153tbJX+BVigXkU57scioCR7IFgVNmtyDwc7I1hI0oFUGucN+9Q0KYd1d8r6uuQ
         wqKNA81BVwQwUUspG2NwD810LpRfU1qaihe8CA3NwN1CH+HiSesQpRiOO6wgUZg3trHR
         IawYIszo0G6HAVziDDkEyK8Bsey7PzivduuGUBKXZc55c7miet7wAOHnNxC2b1R2Mle9
         kSpSRJ8Dzdi2hl4wQT305Rht8EU3MZ4EJsT50OI0pVJKLRbd06sINNfqdJrczesAtav3
         CWQQ==
X-Gm-Message-State: AO0yUKXEcyf0dBOB6Q35Yxd8NlRHPnNliDvvr8yMWYgFCTba6kyHj4en
        YYYAHdbRDXtrKIQkzym4FhRnpg==
X-Google-Smtp-Source: AK7set/40nqpQdiITXp6tF4Med5qx27LNaaTtVfCmd0pU4hd5Ibomho1jstcrmf9F/fBrhsUMyudrA==
X-Received: by 2002:a05:6e02:1184:b0:30f:a889:2145 with SMTP id y4-20020a056e02118400b0030fa8892145mr207150ili.2.1674522350241;
        Mon, 23 Jan 2023 17:05:50 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id ce21-20020a0566381a9500b003a484df1652sm223150jab.55.2023.01.23.17.05.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 17:05:49 -0800 (PST)
Message-ID: <6570e849-aedd-245f-163c-208a9bdfaf9d@linuxfoundation.org>
Date:   Mon, 23 Jan 2023 18:05:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 5.15 000/117] 5.15.90-rc2 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230123094918.977276664@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230123094918.977276664@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/23 02:52, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.90 release.
> There are 117 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Jan 2023 09:48:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.90-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
