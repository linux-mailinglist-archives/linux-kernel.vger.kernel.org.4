Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8507765DFC9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 23:19:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240319AbjADWTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 17:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240296AbjADWTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 17:19:01 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129E41A069
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 14:19:01 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id d10so20216403ilc.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jan 2023 14:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i9BlOiL77Oo4B1mcjX14fa9JpTQNEvWKGZU06kIV2Hs=;
        b=QIrmCoTMBrmM8m3Fg5thWfAsOAOgSVllMY3qewjxg/yVBW2SAxxpA31l3fDfcw2Y5S
         f8zLtaxp82NoEhMVdL46rQkCvpHS0J/G/QT+3DNGsXMcSi4q85FdGTC+6Bxc7N7z+TCd
         MItouIzNJyqNPf8VcTwsjs/Sq3q28deqIPplM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i9BlOiL77Oo4B1mcjX14fa9JpTQNEvWKGZU06kIV2Hs=;
        b=JifjH8CHt+oLd1mLFee9y9/iPsEhRU90nsHcMBfis9qHmw87DIKFQzmKW9A8x6tC3W
         q17qmelWt7TESTIALeozU5LBy6jwffNNlnkJh+G8dfAguV2n9N+k2mmN80GBg7DEd4qz
         0tTSFNpibTgzLQfOkh/h1Vok/etsnZKTXduyup7pNk2nNX3ORcuFQ6b0Iu4bZ4BKoyJ0
         a/kQ2swvhqSJPQAbmU6Kuu8IX4IeGEP2cToPart5zCwtz3oLHmFsAI8LASJCGAN/3ERL
         aiaz/jYk/0TFKeevaOCQ9Q7jahpTH8ix2iX16nIc5Gx6tIyxwn7H4J99l1iogyDNjX/J
         6Hag==
X-Gm-Message-State: AFqh2koMf6pc7YAaCrzeL9aERklaV+RhgGYNfjErBKk2a0dxvqdAR2CJ
        5bVBgwI8beBsdLgPJWPyqZjO9DeUZUWxsyGL
X-Google-Smtp-Source: AMrXdXs5C/FwD16ZdQeI6tKZs+J/MHTBONi71FWqitB2h3qPJBhAOH+K7MhOPPce9tqtO3AXTalxCA==
X-Received: by 2002:a05:6e02:12af:b0:30b:fe91:35ed with SMTP id f15-20020a056e0212af00b0030bfe9135edmr4591692ilr.1.1672870740408;
        Wed, 04 Jan 2023 14:19:00 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id q11-20020a92c00b000000b0030d7c4bc3aesm172215ild.72.2023.01.04.14.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 14:18:59 -0800 (PST)
Message-ID: <7681dd79-ba01-edb9-bb64-cacceabd35c0@linuxfoundation.org>
Date:   Wed, 4 Jan 2023 15:18:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 6.0 000/177] 6.0.18-rc1 review
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
References: <20230104160507.635888536@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230104160507.635888536@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/4/23 09:04, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.0.18 release.
> There are 177 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 06 Jan 2023 16:04:29 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.0.18-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.0.y
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
