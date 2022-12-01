Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FC063E6D5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 02:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiLABAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 20:00:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiLABAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 20:00:30 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D5056574
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 17:00:30 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id g26so116481iob.11
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 17:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gq418pOxGsBTfRyr8gCSPbFR3N09kGLIlLy3UXEsQeM=;
        b=L3Xy+1GjYg6llIu1tdWJwoUyaSwgJMiWCAIHwKXgf4CWBAxkskW84a7pOq1CxpUStK
         tTcmTQbCzmwIYPDWOtM+iwWzkWcCGYYiNNzEeoRTFQ8gz8LOMoSQKKNZyS0wdZOMDrQ2
         oHVg9MVdMQe8C7gdWEpGZAmlabz4c4+yMVHSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gq418pOxGsBTfRyr8gCSPbFR3N09kGLIlLy3UXEsQeM=;
        b=Ix45TlheVCzw6URifBh5zlDorL5tm9xROXQf02h6dA/3UhqHdswejIkJkJqqs6CIFN
         qrvC4HgB9vVONMzESzqP1XfZdUX1e6FKiRk9rvrm1riu/ZiGscUsxHD0qvWs9ZUgv4N/
         xFP+t6kYfMUnwubfjZXxkaM7mG522qlJStNEwCxK//y+ZOj4gj8LxW6HFfr5UNjTDWSz
         /sHGti4Tja7PmMkwWoXureXX9uZtlgzw1U2r3/slP4iPgb8ETXnz4anfQQ4g2iw36ItX
         Fv72Sybwt/ZvryDDQhySlKIVxODHNWTSmm+VzEScfzRTT4kQiMewpVpFo+Dz7K+eRSEv
         WJNA==
X-Gm-Message-State: ANoB5pnMNTwQfzRABAUpqQmyuhkAR6rKfYbpTi6zIGTdC52HTj86EsSz
        SOSTVssQ8/5eeetiv1mPCciYJSmNh0g6Vg==
X-Google-Smtp-Source: AA0mqf6D3VNev1EHeQDCHM26HLKhO/W02AerFY7qEtCLM4S7Cr2KVt4WH6uXCoIVBlnC5RdCVHs0Ig==
X-Received: by 2002:a02:3f60:0:b0:375:2d83:f970 with SMTP id c32-20020a023f60000000b003752d83f970mr29200510jaf.205.1669856429573;
        Wed, 30 Nov 2022 17:00:29 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id o1-20020a027401000000b00375126ae55fsm1104248jac.58.2022.11.30.17.00.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 17:00:29 -0800 (PST)
Message-ID: <58bf2dab-0832-86f9-9cee-c1900c862cda@linuxfoundation.org>
Date:   Wed, 30 Nov 2022 18:00:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 5.15 000/206] 5.15.81-rc1 review
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
References: <20221130180532.974348590@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221130180532.974348590@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/22 11:20, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.81 release.
> There are 206 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 02 Dec 2022 18:05:05 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.81-rc1.gz
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
