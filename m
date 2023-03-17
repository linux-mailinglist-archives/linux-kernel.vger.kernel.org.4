Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9B76BF4AE
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 22:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbjCQVyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 17:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbjCQVyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:54:41 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCC0AF1F;
        Fri, 17 Mar 2023 14:54:18 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id k15so2947238pgt.10;
        Fri, 17 Mar 2023 14:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679090057;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QgWoxlECZXdVrynxfG/iUFVQwxWjeSo565mClnIZWnc=;
        b=YaTxmeYgjyyGDmiFAS7L+PljTKNdLcc5nol9+/wEE4H/wa86Znz2DX0ZJfrJwf3NQn
         mi3C91RvdtoBgNdOgNPzvLFxbkHQkvXTlyahrA98EeV9jXJbi9Sf/XEa9/M9qyswTCDW
         D99bJK6fLSCVJlxECISp5CFXVVNG2U3nnd/arcWTtrF02mJTSLao1RZSGb5ddQAsDtD0
         V/Kg+cT9lPI18ueEdAm4jK/b8QlthdZ8NjbUa5tvX9L4AXpUzN7XDHJnLEp7WPDEa0Vo
         rMhgXgfShXbVMEgHkEdJHLTq9hSBwCIDpZz3rogKfyxXw7dAmr6u14NdJ5LyUmR3w+3T
         PuPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679090057;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QgWoxlECZXdVrynxfG/iUFVQwxWjeSo565mClnIZWnc=;
        b=1QN89Y+2vIkEyIxSCLPLnH6F4dehA9JFpJQDEn6TGwR/mQm2eZIb05GvkXtJatv+qN
         VRDVkKm6WQfM4P2tO0/fpPz/68zgBD+WhQWdMm5d69r602tGUYDt3OrVDkEP/ZecGrKx
         xxZa81e+UDtnaw2xz1/rNWKKalD7mLMtcV9JGz55HS1UV3AQBI3sxhSeup/o0e1XQTw8
         iiGzYu6gt+7S2d2MWhN5wNIU+GrUcC06pH7+zJviJVY52Za8sk/W5fmZDdRMe9Yn22D7
         U+TJPB6YSqXQw1IninFfNJPx9YA/X4cbhX2rzG/LR0Mmyy5BjNybNbB+Fqam1WzjVd5f
         kvNQ==
X-Gm-Message-State: AO0yUKU/6/l8vrpFz1Q3BRVI68fR2yK8Im5xX+kZcD2dmJqXHLOFx1yD
        JWPqUbKASYyPaFOBxFtQVvI=
X-Google-Smtp-Source: AK7set++51QrZc9ogfyZzZlsl7EgVQqsEkLr7zb0xLfkGDusnfnLbtVRqFamGeYkvD60E3j8n/6MAg==
X-Received: by 2002:a62:520f:0:b0:5cd:d766:8a2b with SMTP id g15-20020a62520f000000b005cdd7668a2bmr6584338pfb.6.1679090057160;
        Fri, 17 Mar 2023 14:54:17 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 22-20020aa79256000000b00582f222f088sm1998885pfp.47.2023.03.17.14.54.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 14:54:16 -0700 (PDT)
Message-ID: <0bbaa346-edbf-a1b9-3c95-5a1aacaf0c44@gmail.com>
Date:   Fri, 17 Mar 2023 14:54:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: Probing devices by their less-specific "compatible" bindings
 (here: brcmnand)
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        "William (Zhenghao) Zhang" <william.zhang@broadcom.com>
References: <399d2f43-5cad-6c51-fe3a-623950e2151a@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <399d2f43-5cad-6c51-fe3a-623950e2151a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+William,

On 3/17/23 03:02, Rafał Miłecki wrote:
> Hi, I just spent few hours debugging hidden hw lockup and I need to
> consult driver core code behaviour.
> 
> I have a BCM4908 SoC based board with a NAND controller on it.
> 
> 
> ### Hardware binding
> 
> Hardware details:
> arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi
> 
> Relevant part:
> nand-controller@1800 {
>      compatible = "brcm,nand-bcm63138", "brcm,brcmnand-v7.1", 
> "brcm,brcmnand";
>      reg = <0x1800 0x600>, <0x2000 0x10>;
>      reg-names = "nand", "nand-int-base";
> }:
> 
> Above binding is based on the documentation:
> Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml
> 
> 
> ### Linux drivers
> 
> Linux has separated drivers for few Broadcom's NAND controller bindings:
> 
> 1. drivers/mtd/nand/raw/brcmnand/bcm63138_nand.c for:
> brcm,nand-bcm63138
> 
> 2. drivers/mtd/nand/raw/brcmnand/brcmnand.c for:
> brcm,brcmnand-v2.1
> brcm,brcmnand-v2.2
> brcm,brcmnand-v4.0
> brcm,brcmnand-v5.0
> brcm,brcmnand-v6.0
> brcm,brcmnand-v6.1
> brcm,brcmnand-v6.2
> brcm,brcmnand-v7.0
> brcm,brcmnand-v7.1
> brcm,brcmnand-v7.2
> brcm,brcmnand-v7.3
> 
> 3. drivers/mtd/nand/raw/brcmnand/brcmstb_nand.c for:
> brcm,brcmnand
> 
> 
> ### Problem
> 
> As first Linux probes my hardware using the "brcm,nand-bcm63138"
> compatibility string driver bcm63138_nand.c. That's good.
> 
> It that fails however (.probe() returns an error) then Linux core starts
> probing using drivers for less specific bindings.

Why does it fail?

> 
> In my case probing with the "brcm,brcmnand" string driver brcmstb_nand.c
> results in ignoring SoC specific bits and causes a hardware lockup. Hw
> isn't initialized properly and writel_relaxed(0x00000009, base + 0x04)
> just make it hang.

Well, the missing piece here is that brcmnand.c is a library driver, 
therefore it needs an entry point, the next one that matches is 
brcmstb_nand.c.

> 
> That obviously isn't an acceptable behavior for me. So I'm wondering
> what's going on wrong here.
> 
> Should Linux avoid probing with less-specific compatible strings?
> Or should I not claim hw to be "brcm,brcmnand" compatible if it REQUIRES
> SoC-specific handling?
> 
> An extra note: that fallback probing happens even with .probe()
> returning -EPROBE_DEFER. This actually smells fishy for me on the Linux
> core part.
> I'm not an expect but I think core should wait for actual error without
> trying less-specific compatible strings & drivers.
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/

-- 
Florian

