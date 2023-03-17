Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 365F56BE628
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 11:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjCQKCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 06:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjCQKCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 06:02:21 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8473B4ECE0;
        Fri, 17 Mar 2023 03:02:19 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id o8so5850001lfo.0;
        Fri, 17 Mar 2023 03:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679047338;
        h=content-transfer-encoding:subject:from:to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9eeXpy6H8yVQu/J+zK/P14XqNfA5ICBlylety0kmfWE=;
        b=l2+3ZGioV/xd27HWk9bsZkZkPdhI6AhBmPEmeRC82rB4jTJegJ9NW9u0PO3cGe7OMW
         sFv4nK/WLCon2YDFH7p7e7F4IIipCh6ZTUG/rQcWhUoT/3inDK6JVyQPSINmYYalK2f6
         CeC4zD8yGHghiidpu6Bt3AalJBP9HlYOu2kRoc/GG80268Dx289dspxbeanOz1y0b0LH
         vnSFmDjkQiDpu6E9mXcqvq1bcRsQctP8DQGZyQgqpcqtvZukiPpRcjW9pwNYQj7IwsFQ
         Tor9ln0+hqmrpEdoPciQfxG5ZcBPJz7IbC4eRonjxOY6abdY0sO/tkRfCtavsb7Zjn4c
         hTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679047338;
        h=content-transfer-encoding:subject:from:to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9eeXpy6H8yVQu/J+zK/P14XqNfA5ICBlylety0kmfWE=;
        b=w59wkdS9uMJ1RAqR7JzQJVU5pfCUqluIBZ/LaZPJbCvyuVGI2GqKrnnXgb6yf1UekT
         +8PBSJ+Ra7BBTyAVrh+KzY6iydLDuGDpHDUsbcNGwuTDRyFI3euahrQofKLCLGYC+n6t
         GonpAST/yQJMVR3YcsgGUz8uuVWE3yoZZnMLlgMPiF01VhIcRDtDWAeJYa1IpYKaxNsO
         SXC0IW6Jn40Owby5g0BZlxp3OlhdssSTOzmlH1enj9Atx/RA02DkBg2aDcunAes09fQU
         Lv5p5uQjKiAU+JmupBWTN8oSuK6/iQJrOL3BAsPdiQiIjBgFPLggF0fvUHAeg9vNNQZD
         nTFw==
X-Gm-Message-State: AO0yUKXWYJSWADT7hBs2ABYjyih3/FcifXctTPGhvKyIVUeFCulVqh/x
        PNKODlkH0GHsXKgwAJGrVd8=
X-Google-Smtp-Source: AK7set8Tm3fHhcsR2/TeyQWDbWsJv4+LyPW4hXo1mqVZCmpRzAmSuYWWRt1LllYOjcSFxxf+5B/YCA==
X-Received: by 2002:a19:7512:0:b0:4dd:99cf:8788 with SMTP id y18-20020a197512000000b004dd99cf8788mr3991527lfe.54.1679047337504;
        Fri, 17 Mar 2023 03:02:17 -0700 (PDT)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id t27-20020ac243bb000000b004cc9c2932a9sm297228lfl.302.2023.03.17.03.02.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 03:02:17 -0700 (PDT)
Message-ID: <399d2f43-5cad-6c51-fe3a-623950e2151a@gmail.com>
Date:   Fri, 17 Mar 2023 11:02:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Probing devices by their less-specific "compatible" bindings (here:
 brcmnand)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I just spent few hours debugging hidden hw lockup and I need to
consult driver core code behaviour.

I have a BCM4908 SoC based board with a NAND controller on it.


### Hardware binding

Hardware details:
arch/arm64/boot/dts/broadcom/bcmbca/bcm4908.dtsi

Relevant part:
nand-controller@1800 {
	compatible = "brcm,nand-bcm63138", "brcm,brcmnand-v7.1", "brcm,brcmnand";
	reg = <0x1800 0x600>, <0x2000 0x10>;
	reg-names = "nand", "nand-int-base";
}:

Above binding is based on the documentation:
Documentation/devicetree/bindings/mtd/brcm,brcmnand.yaml


### Linux drivers

Linux has separated drivers for few Broadcom's NAND controller bindings:

1. drivers/mtd/nand/raw/brcmnand/bcm63138_nand.c for:
brcm,nand-bcm63138

2. drivers/mtd/nand/raw/brcmnand/brcmnand.c for:
brcm,brcmnand-v2.1
brcm,brcmnand-v2.2
brcm,brcmnand-v4.0
brcm,brcmnand-v5.0
brcm,brcmnand-v6.0
brcm,brcmnand-v6.1
brcm,brcmnand-v6.2
brcm,brcmnand-v7.0
brcm,brcmnand-v7.1
brcm,brcmnand-v7.2
brcm,brcmnand-v7.3

3. drivers/mtd/nand/raw/brcmnand/brcmstb_nand.c for:
brcm,brcmnand


### Problem

As first Linux probes my hardware using the "brcm,nand-bcm63138"
compatibility string driver bcm63138_nand.c. That's good.

It that fails however (.probe() returns an error) then Linux core starts
probing using drivers for less specific bindings.

In my case probing with the "brcm,brcmnand" string driver brcmstb_nand.c
results in ignoring SoC specific bits and causes a hardware lockup. Hw
isn't initialized properly and writel_relaxed(0x00000009, base + 0x04)
just make it hang.

That obviously isn't an acceptable behavior for me. So I'm wondering
what's going on wrong here.

Should Linux avoid probing with less-specific compatible strings?
Or should I not claim hw to be "brcm,brcmnand" compatible if it REQUIRES
SoC-specific handling?

An extra note: that fallback probing happens even with .probe()
returning -EPROBE_DEFER. This actually smells fishy for me on the Linux
core part.
I'm not an expect but I think core should wait for actual error without
trying less-specific compatible strings & drivers.
