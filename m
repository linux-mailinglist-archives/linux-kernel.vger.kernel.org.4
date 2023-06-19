Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5040E735DEF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 21:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbjFSTnJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 15:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjFSTnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 15:43:06 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EED11A;
        Mon, 19 Jun 2023 12:43:05 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id 5614622812f47-38dec65ab50so2862776b6e.2;
        Mon, 19 Jun 2023 12:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687203785; x=1689795785;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GMRLY2j+IAS7ISAiw0R05ZGvFawTOjh4yP2LDnudezY=;
        b=c4940YOE6lC4WLcpyNG1SzkRuwK56KRqkCHnfj73sNBcqvvOCBP4HtZvyzR5iI+dT6
         JUNcqUKno3vGxTXWyCKlk7qoQoMIVXv1eQRqFkCuxBeyvJsdagBBnqZdvcI2w0KWg21G
         15R/crgx+370LKofABEqLtjp7ln7QqkDFqxx3Rql4WmATHLaRnajEMtKHVpDI2Ls9Fch
         pYS3nmKeSDINZPfxXlkMRMBnMmA/8+aZQZ237yfiMucPJiVeXcRlBPoCCODa2rH0Ux9z
         eA7WHOxhRiH5G2XfR945tQGBd4uNhPHrgUt3ge/hkeuz9T9rwsfjKp8xLSzgQsd6B91z
         Ny0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687203785; x=1689795785;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GMRLY2j+IAS7ISAiw0R05ZGvFawTOjh4yP2LDnudezY=;
        b=MNAhLi8zjco/eCfi6vYhSL6pskDPCoAD6eK4J1FG/lNPARHS1WImZLaRulTactQ8oH
         pAYlQnqpU/8POLfqNaL0z7EtJLR1O6RSdaumpGMZh+cqTDeZLvGWGFfkF1Blo766hbiP
         Hz8/lwogM/+gekLdBgT10eTdiyh7rkKIM8N88TwbCISdKCxO5LOU7UARqwlgAt3GNHOU
         4mAlOG5CT/1KLXNJphViWVXtqq5PLWaC0t+uCfT4PvjKF6M/5Slt5eDrHkckX1wKHp/M
         fROmSFM7wH+LZSQctg3JcBluTfHFIvx2Zp014IaO+ka15Y6tdrvoQLvGu/CtTN6MeSaP
         aNhQ==
X-Gm-Message-State: AC+VfDwC/RlmHpBOefQNZKx3j1vFIHjme+o5sr6C/MDcHOCCk2b4nY6+
        49aFhHDiEU4UmEatrBWx+pM=
X-Google-Smtp-Source: ACHHUZ5LEzTKiHDX05E7U2SS9tQva5v1sd1qAMHrZlJEr1RiYXXQiSMcIYUYIhl4ZdGn5Mz/lJt/RQ==
X-Received: by 2002:a05:6808:6243:b0:394:45ad:3ea7 with SMTP id dt3-20020a056808624300b0039445ad3ea7mr11202863oib.5.1687203784829;
        Mon, 19 Jun 2023 12:43:04 -0700 (PDT)
Received: from [10.230.29.214] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id j4-20020a17090a694400b0025c1fbc9984sm5937690pjm.19.2023.06.19.12.43.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 12:43:04 -0700 (PDT)
Message-ID: <deace106-94b8-8cc0-efae-2c77aa97dd0e@gmail.com>
Date:   Mon, 19 Jun 2023 20:42:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.3 000/187] 6.3.9-rc1 review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
References: <20230619102157.579823843@linuxfoundation.org>
Content-Language: en-US
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/19/2023 11:26 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.9 release.
> There are 187 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 21 Jun 2023 10:21:12 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.3.9-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.3.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

