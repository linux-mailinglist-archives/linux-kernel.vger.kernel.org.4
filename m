Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674C05BEEE9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 23:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbiITVDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 17:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiITVDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 17:03:36 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38E96C13C;
        Tue, 20 Sep 2022 14:03:35 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id d17so2616388qko.13;
        Tue, 20 Sep 2022 14:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=ieFEp27enLLW1YRt8hFgW1d22vjbfRN/33CRdKnr53c=;
        b=dzszvBr4MnEJFPO50R43Xr0nrNZ1o1jR+JFpeutvryRVA4YaSZkot6Sodrtjt0bEPs
         3nLMu4YL6el05lZre5J6TLsWPGqjPHTH3gyBwVpCCmeFulGQqZoaFwfdkHb44l6WLC5q
         xLsBJj8fKVjkR42/4vAAwZ266d37wp7Q8rc9iADCzSvJfAl4p0Fw6v+EjRl/Ya79wyoi
         p+A+NUN7YehH6uAWhLYBl9ce+VGpsat2Jdlp8qrZ79VU8VG7iAHb51R/d8WKi9gUuO7X
         LOlUffOh37Ee+Le6u88CmjZ8blADxRbk3vme5Txr2f9yChyj8csUK6rxoDW0r1C/AK2J
         SCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=ieFEp27enLLW1YRt8hFgW1d22vjbfRN/33CRdKnr53c=;
        b=guV89Z53T55Qr0potDFYLdPC+sKBuvPjsqzV+vKdGLa+SBPY+7kPxJhWZzYCF+s32S
         bHVOknOC76y1DG/osPXljLs7kQROlN+joVdTWXStS0wwshZDIJHHICpQ+XUsSG7ozt45
         c+s7UYAkrkQY5ri5ZUgR8yB1Et7z8uNCf5ZZi3dPUGAq2uZ2MYDhGtkaP9yP6RtIF5O7
         7649hImir252Aw55vFvsHzg//H2DN6ki6ch6nvZG5wy9tV+p6XK/mycikCKTbaz5EPlA
         jQSHHFr5/R44j1g+LUOqMxzXFjsT6ihVc0RhcKa0DgvM5Z6lY/Tf/rHB9We1UXswalBu
         OMUw==
X-Gm-Message-State: ACrzQf2KfOaCo6kYLCj3R5GhJYeVq2b/CRqOZH66ZD7rZREP1MrSncP7
        sD4Ma9dtMhk6PWcFrjYMlNg=
X-Google-Smtp-Source: AMsMyM6JbDRyjJgQqZZsqINSR6faoG94Db/3KeE4Vy4U1nvgR2/MzmItrNj6Ja3PwO0Xm+V4xLOokw==
X-Received: by 2002:a05:620a:4382:b0:6ce:2761:28d0 with SMTP id a2-20020a05620a438200b006ce276128d0mr17355528qkp.329.1663707815018;
        Tue, 20 Sep 2022 14:03:35 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id g24-20020ac870d8000000b0031eb5648b86sm398589qtp.41.2022.09.20.14.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 14:03:34 -0700 (PDT)
Message-ID: <d372ddef-4f8c-041c-a48b-26e491d19bbe@gmail.com>
Date:   Tue, 20 Sep 2022 14:03:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ARM: dts: BCM5301X: Add missing "ranges property for PCIe
 nodes
Content-Language: en-US
To:     linux-arm-kernel@lists.infradead.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220920210213.3268525-1-f.fainelli@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220920210213.3268525-1-f.fainelli@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/22 14:02, Florian Fainelli wrote:
> Add empty ranges properties to silence such warnings:
> 
> arch/arm/boot/dts/bcm5301x.dtsi:240.21-246.5: Warning (pci_bridge): /axi@18000000/pcie@12000: missing ranges for PCI bridge (or not a bridge)
> arch/arm/boot/dts/bcm5301x.dtsi:248.21-254.5: Warning (pci_bridge): /axi@18000000/pcie@13000: missing ranges for PCI bridge (or not a bridge)
> arch/arm/boot/dts/bcm5301x.dtsi:256.21-262.5: Warning (pci_bridge): /axi@18000000/pcie@14000: missing ranges for PCI bridge (or not a bridge)
> 
> to silence warnings. This is not a functional issue since the driver does not
> make use of the OF infrastructure for registering the PCIe controller(s) on
> this chip, but uses the BCMA bus.
> 
> Fixes: 61dc1e3850a6 ("ARM: dts: BCM5301X: Add basic PCI controller properties")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> Change-Id: Ia4eba6d21b72620d2fd8d5c3548c1777d3c1c357

If this is OK, I will fix up the subject and the commit message to not 
have the Change-Id and avoid repeating the "silence such warnings". Thanks!
-- 
Florian
