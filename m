Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175AE6F20C4
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 00:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346479AbjD1WY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 18:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345675AbjD1WYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 18:24:53 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A8A3584
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 15:24:52 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-32e74139877so206465ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 15:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1682720692; x=1685312692;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GSa5C8E2SSwvtXOZwEpISMIP6D9rG0L5OGPU9rvOevs=;
        b=ajL+QEPgpYNE/ZKmEbXLNEHYE3KPm8MVfR7XdDnwFhRJFsEOfi/DpdnnO3bfMoOZhb
         H/yVjchU3lGio3YeOP0TQT/6Md2CF0SK0BUrvnhTurm9WFyt3XMYDm7+im1+OqciNboz
         cgvQWNMdTS6vnqe0eGciT5uBpqYhSs7qxaBGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682720692; x=1685312692;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GSa5C8E2SSwvtXOZwEpISMIP6D9rG0L5OGPU9rvOevs=;
        b=JMidauc5LAflvGfDQnqQc92kT7pXUbaPwo8D9zluLRBxjd/8tGg+vtJ2QdcM5s0u0X
         glrOUH02ICy1abIkNJmFau26Wc/64er1hRKRmooLaQ3gyC859nWHlB/qkwsDaWHAJF3R
         LWZBKwLq0UkJDO73N2QZ9iIjmFpGS3aUt8VfyiiJzYwdf0QZZxS0ldQSe4FgeRBZPAIu
         bIzsulmlNsiyNL7kRvpnPG0FE4QgYS8z0yRDj4YHzt8NR6dFeD6RE4toojPCiVpdXwib
         yAlMmNRvB1iCE8W+NXYImnfojewiCso5cqLXdz8Zb21kzU/fm6k8Q0IYAhjlSMCEMYkB
         YcJA==
X-Gm-Message-State: AC+VfDz4i5nAdYeyjupiQ5jxxlYeRAki9sHZMtEjtj4NiThcV0itGOTv
        4JgHqq0+mkZSf5SEpIu2Z5HuQA==
X-Google-Smtp-Source: ACHHUZ4Ja6I1jRQPtE/UAHztRHGhUOjd7MUxetmgc7IDRvXMw4BgJ6SErt1GVfNc91GwFa7gA1NpZA==
X-Received: by 2002:a05:6602:3425:b0:760:f7e4:7941 with SMTP id n37-20020a056602342500b00760f7e47941mr3561634ioz.0.1682720691718;
        Fri, 28 Apr 2023 15:24:51 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id t32-20020a05663836e000b0041284223319sm2772267jau.88.2023.04.28.15.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 15:24:51 -0700 (PDT)
Message-ID: <5995e300-1b3e-eab8-a258-beb667504cec@linuxfoundation.org>
Date:   Fri, 28 Apr 2023 16:24:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 6.3 00/11] 6.3.1-rc1 review
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
References: <20230428112039.886496777@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230428112039.886496777@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/23 05:27, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.1 release.
> There are 11 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 30 Apr 2023 11:20:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
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
