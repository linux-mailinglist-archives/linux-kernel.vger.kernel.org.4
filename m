Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B2E56F2566
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Apr 2023 19:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjD2ROq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 13:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjD2ROo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 13:14:44 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8405199B;
        Sat, 29 Apr 2023 10:14:43 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-51fdc1a1270so648434a12.1;
        Sat, 29 Apr 2023 10:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682788483; x=1685380483;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CNntHbXC3KisuUZTZB42fQ54DMYWor62BVWmA9HgpkM=;
        b=LpjSU1aZKzOY6dbXM3xDEZZyveLWsKDCEKnmVUuhAi0XccmogbroPfxIjZTiEISSXF
         Y17w5jOyBCP53YVX6nnayDKKsB1RUAOYAhWRGBf1AweD3oAXexBMxRaauxUeKS34o7r0
         B775rPsQ5jxfPcJNUNrdzhVv9CljB655sjZH7x/xPfN2q2eFREvMwfijthwbxGSaGv8x
         9pLYfwaQxwUpmhmfpsjlYH07e8Z5qp5M1lOYWPunb85EIQ51rsFPkcmortcm0HCVORak
         hsfzlj9owr1XrPuS18LI83a9DsPE+XD8PzPLxYRDNzsfGGFYkKJyB7vHcMtP4+szwd+7
         AN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682788483; x=1685380483;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CNntHbXC3KisuUZTZB42fQ54DMYWor62BVWmA9HgpkM=;
        b=a0tJSsDwPvfHiOUZoHDqJ2noO3wu8b+g21hz6olQDf0sBWMyMz6MaHACEfOzw8ZUh4
         m/tF7qswY54OCmThlW13fiYXwYEGMe08lrD6Gy0DoCBYbdQNVEm1xmtk5N4FiO3fN40D
         O/oNXmB3PmnACfua4gQ2ol/58Pr9LORIzHEujD+nRS8N8+qaq14eURcvleamKYPdHpF7
         hDJlvI35ND77lqbDUtDMEAN1pNJsDFgXSWUYOOfdbypgCbofxAumIXfnR0pzsgoKoxVC
         BGMxDs/cj3L/ZVTHyndcM/yXwO+EUmx4yvE1ugmpiwhjcBuPFylQfAEAF9WCraDQYyp8
         YakQ==
X-Gm-Message-State: AC+VfDwv5YYbueY+wIN45i3S8dpmK063oUdwOizX3+6cfVMIU8+IORye
        ULpPDVOO7xwYDy7a9H11rDGbs14xGJHI7Q==
X-Google-Smtp-Source: ACHHUZ5VOCZLhARVzo4w7nhi7d37cdIbOxmUukkZlkV6hjVg4bxeiwhuYlRAVCEtYCBPRZ2L25ruyQ==
X-Received: by 2002:a17:903:1c3:b0:1a9:80a0:47dc with SMTP id e3-20020a17090301c300b001a980a047dcmr9116397plh.3.1682788483171;
        Sat, 29 Apr 2023 10:14:43 -0700 (PDT)
Received: from ?IPV6:2600:8802:b00:4a48:1c98:2538:93cd:aefb? ([2600:8802:b00:4a48:1c98:2538:93cd:aefb])
        by smtp.gmail.com with ESMTPSA id bh7-20020a170902a98700b001a19cf1b37esm15112497plb.40.2023.04.29.10.14.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Apr 2023 10:14:42 -0700 (PDT)
Message-ID: <7dc812da-6006-7909-e079-4543b0458080@gmail.com>
Date:   Sat, 29 Apr 2023 10:14:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 6.2 00/15] 6.2.14-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
References: <20230428112040.137898986@linuxfoundation.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230428112040.137898986@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/28/2023 4:27 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.2.14 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 30 Apr 2023 11:20:30 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.2.14-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.2.y
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
