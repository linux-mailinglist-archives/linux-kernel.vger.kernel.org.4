Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9CF6FCE1B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 20:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjEIS6F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 14:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjEIS6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 14:58:03 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26E830E8;
        Tue,  9 May 2023 11:58:02 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-61b5da092dfso29372716d6.0;
        Tue, 09 May 2023 11:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683658682; x=1686250682;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8V0E9Malroc1TAAMIhSlx3NR6ZiF6osX3Y+HgRDRWIU=;
        b=EKdXpy+TDI36sZFladBF1FqrjwDHHhsXhtm7iOmlR0wlSFsmMzWqRF1SJEJK2ttv/O
         aN+wyiybvF1K4JEE3rQc3NT2QyThbRx3hd+yrThMcQvsZ3MV51zk5Bmv5XAveuRYWY09
         r+rIs3qdFRv4nUII7YEMkXNh2Mu4QYL0w5d3cgMn52K5fhXVeR3HeMmX1sU/Yv2eExEa
         SFf2L0y54DbtpteS9gYdgbG/TL1WIZZFwFgpvRxQWbHI4id551l0G+Qshr7d5p/cjH8r
         zAuHducVa5hL8ohdaKRSWEKETYhOj+C5bLfNQC0Tm9GJxv+wt8dn3ZgtZAGYowCOsH2p
         +e7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683658682; x=1686250682;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8V0E9Malroc1TAAMIhSlx3NR6ZiF6osX3Y+HgRDRWIU=;
        b=G/GKqXXp4FQPvlN83a7Xj7QDxs/imE0lm56G82o+r68pids7tQSztSvOBM1mhqCyYd
         Z0X9Z3MT1YV5y3qz2BjBVYDNkQlsF2aYKI6OwicExKyjmoHCNfvkRo263o+udzIO8kdX
         RIKkgIcamCq/A3l6gImxFpXA8CviZWY3bnagzCIVE9fVflbJeErAb2tvBTFs8kJ6xjqf
         SKdTFiZ7NPjmfy6HshR+B3SOP6MQVhBCMIfaJ8HHyeVDuIwD+kWEs2l+EGoMWO+wbL1M
         HKpULHblP/W5FDe09lI5FQFX9mxE/+ZXEwfTh9GH0Dn41W4sLxgE3ik7kPUSZqLtpwue
         fB7g==
X-Gm-Message-State: AC+VfDx6P8MKW4LXhw9YBoDUUk3s+paPI7xdIvpJzaSdOvlJb0AWIeYh
        OV7n5hpGDhgiQvhqS8MMwP+StdZvpRU=
X-Google-Smtp-Source: ACHHUZ4lO26t9a0WZcv3QwzPYHouOsySIPYTsmuuRK+H5FjT9oKHesprwuGdQbezOkPDDXOQhTYPWQ==
X-Received: by 2002:a05:6214:62b:b0:621:431e:5409 with SMTP id a11-20020a056214062b00b00621431e5409mr3646779qvx.16.1683658681904;
        Tue, 09 May 2023 11:58:01 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id jy13-20020a0562142b4d00b005dd8b9345dbsm955831qvb.115.2023.05.09.11.57.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 11:57:59 -0700 (PDT)
Message-ID: <858f43fb-65b1-3b75-129b-ad8fc3d6bb15@gmail.com>
Date:   Tue, 9 May 2023 11:57:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 6.3 000/694] 6.3.2-rc2 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
References: <20230509030705.399628514@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230509030705.399628514@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/23 20:26, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.2 release.
> There are 694 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 11 May 2023 03:05:05 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.2-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

