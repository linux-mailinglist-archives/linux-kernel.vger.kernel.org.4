Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1177042DB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 03:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjEPBZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 21:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjEPBZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 21:25:05 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A121BEF
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 18:25:04 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-33569035746so1640175ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 18:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1684200304; x=1686792304;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+efH+wqHkT7+fyuI18fo7OAWpc4YEP1OK/0TkaDdqhI=;
        b=iaQ65w2VFr/eYZpJulNIgQiLDQn05zHgQc7a7ZRIWYdlPcEuq3rv/2F+iPwlzoRxrS
         C2EyGH0JuE+fmBeaAYdWeUBRBtB6goptsRpDQ5jfufiSWRLfh6Sd/wybx4aIvxydta0k
         Xuk/y+Z6K6p8bYpLGA/CqHgTxqSqh1N7K0eb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684200304; x=1686792304;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+efH+wqHkT7+fyuI18fo7OAWpc4YEP1OK/0TkaDdqhI=;
        b=RH7Ngm0srBfjJk/eRXbcf5+OVDwDwH+hjppztyV6rgOQH4XAV4z8fu9U2/mG6PObjY
         m8Kzpx7MQK+n3Lg96QR8RlNP6sw7wztvw+gcLVfBLeWnkeXw7kG6Uh8ktQXyhkgwMlch
         ZAML16wZanRf3b20T3BxuJMjtW3Z9noiJBwJKvdSjPzqgy7ekPQJIf4vkYChSLCz4Yp0
         BhcP2pCeOxdAuXFOWYyCUXnwd8v81c2NywLDS6pgeHwVl+ymwrkVrdpREEGA0iFIRxbd
         JazlHkV2ofuWIVN2erW1ZMPykCB7s0CtTF2i0iIuiVca7NdfvzmzkQXeNAxS7zi++Yvp
         S/kQ==
X-Gm-Message-State: AC+VfDy60jv36cVtPlNQfhBqcuRXMkpj198fS6dX+UrwTRsqwazzDM6c
        uFeY2PiUm0nLvvKUCdQtQj33eJWtAYeKbuLU40M=
X-Google-Smtp-Source: ACHHUZ4qiOpmikVK+acNLXYo7sXRdIyQ18cwYvi62CnMqTTbBlCQFXLf0hSW8w7axt3wtnFqXTZXZg==
X-Received: by 2002:a05:6e02:f53:b0:331:832b:fb90 with SMTP id y19-20020a056e020f5300b00331832bfb90mr581043ilj.2.1684200303908;
        Mon, 15 May 2023 18:25:03 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id m1-20020a02c881000000b0041407c67451sm7470760jao.165.2023.05.15.18.25.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 18:25:03 -0700 (PDT)
Message-ID: <7226d16c-095d-2c0f-56dc-5240baf15fa2@linuxfoundation.org>
Date:   Mon, 15 May 2023 19:25:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 6.1 000/239] 6.1.29-rc1 review
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
References: <20230515161721.545370111@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/23 10:24, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.29 release.
> There are 239 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 17 May 2023 16:16:37 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.29-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
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
