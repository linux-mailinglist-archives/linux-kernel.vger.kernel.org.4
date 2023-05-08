Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46646FB626
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 20:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbjEHSBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 14:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjEHSBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 14:01:33 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E3035AA;
        Mon,  8 May 2023 11:01:31 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-52caed90d17so2430868a12.0;
        Mon, 08 May 2023 11:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683568891; x=1686160891;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CxYhKZWcTM6D0zvItXjXfl3kEr6BBDEZH2De/KsXnU0=;
        b=RjE9Zy5bFl7s5q/SOisMx8EM08G+BB800LBMmnQcnf1FZjwKN50ndFOsk9R1TgrV8g
         Dmqzc+GfiroxjQ5hUQWqtifI0c4ccQfLTfTok398wwKSZGcHwYQx9WfudqNGJeBedwPf
         6vI8A0qFgL0V/K8ICs7Wo9MlspJ/SRQh1yEcsByHY+R37+oS+44jhc8cfOcQ/zNCJmOl
         bYoBXrch2J8kTWBecgEY/6NePkXV5Zc9mo8/IWlKqS1wW85Z51EbOJC2M3/HmJfQ/Moc
         Cf9sRBJWXz1B5/GSWaGmNfRCF+U6nv9hVEJP7UxNMinhuZJfxz2gNubNBY93vT/WW2SE
         /m5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683568891; x=1686160891;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CxYhKZWcTM6D0zvItXjXfl3kEr6BBDEZH2De/KsXnU0=;
        b=Gzf5LaSnXJ8V0to1mJFsX86zHN4B47FRD9P4HIQioxC80FjXRFpYPweqOyfu7ApwW2
         0KycHEGR3kqXzJEKHAD9SFECio0/b5+HxmQKr9ndUHi8FB0Ypr/mYQtyolE73OXFHw9p
         Bc5EwhYfJ7YqnV6OcGCynKxNoWbwOopG+7NWOhRuDgRgmJy+RFG5kVwLtG4Nqz7S5CqR
         61E1w0QSZR2LV5KjfDtRVbdZPNVLQN55vUxrqlw8UhcDgVKN4siK0OIAYzFMixvAlz3O
         whCmWl1MZHGB6L3UX31/hMrCpHGvPN7D6vIhPsoNM2m1NyCwWIJFpMReiEYRGAhAzji6
         wjfA==
X-Gm-Message-State: AC+VfDyeU3WyLVTcZ2hAm0fanYkHzGdTygOtWd5Mh2rW+qf7BO7stkcQ
        HH/cAoKKHzPITtzaoY6Ro3o=
X-Google-Smtp-Source: ACHHUZ4SQsmgQ9UWv9tiEpgxGofTIxrtbBNrMqUq9CdvGszWhGb6ZM87uyYI4/mets9p8H9kHSOdvA==
X-Received: by 2002:a05:6a20:3d27:b0:100:99a:7f71 with SMTP id y39-20020a056a203d2700b00100099a7f71mr8042018pzi.2.1683568890882;
        Mon, 08 May 2023 11:01:30 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id k11-20020a63ff0b000000b00528af015a8dsm6566447pgi.14.2023.05.08.11.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 11:01:29 -0700 (PDT)
Message-ID: <b082ef46-a26d-db65-81cf-42f6f694de58@gmail.com>
Date:   Mon, 8 May 2023 11:01:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 5.15 000/371] 5.15.111-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
References: <20230508094811.912279944@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/23 02:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.111 release.
> There are 371 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 10 May 2023 09:47:07 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.111-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
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

