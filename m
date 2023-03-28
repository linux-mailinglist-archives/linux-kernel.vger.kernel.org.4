Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4F76CBCB6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjC1KmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 06:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjC1KmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 06:42:09 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13197A83;
        Tue, 28 Mar 2023 03:42:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 3462F4249A;
        Tue, 28 Mar 2023 10:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1680000126; bh=X+tCJwEj9E9W5KH6sDGJVxL3ZFMhOCSdA9qiC4FHZCA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=y7p3piqtNVcGIRvZvwDOzg/QOazozDCPCqTl8XI8mPFrKB5F7STzIWsavZwEEK24I
         Y/c3fy4wjFU6iassJOlse8hveY8I7QSM1QgNNX9a2hUxQVDR2C5gMhg8VmSvBH3uc+
         e5HsAF10N8nszHerOL5tADZTfNPYGXL4kpkcrkqQmM/yy/wiWlxWw+vQvu6ke2ANYw
         gPN34xstMjBtwAsoecua3MiSQy3eet/suVSoa2pjT7MT9etXRa7SxYdjxOcCz33WpT
         sCDXDhySFmWwPmdnRf2Dm4SiiuiKvUgeaAJPHX9DfBNVaeNHvmk69scME9YO8HvOwy
         pRaB+Y+cYLRDA==
Message-ID: <d0480cda-ffd5-582d-7258-69f0a2b6f947@marcan.st>
Date:   Tue, 28 Mar 2023 19:42:00 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 00/15] Device trees for Apple M2 (t8112) based devices
Content-Language: en-US
To:     Janne Grunau <j@jannau.net>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa@kernel.org>,
        =?UTF-8?Q?Martin_Povi=c5=a1er?= <povik+lin@cutebit.org>,
        Vinod Koul <vkoul@kernel.org>
References: <20230202-asahi-t8112-dt-v3-0-d1a5f6383d95@jannau.net>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <20230202-asahi-t8112-dt-v3-0-d1a5f6383d95@jannau.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2023 21.10, Janne Grunau wrote:
> This series contains dt-bindings updates and device trees for Apple
> silicon devices based on the M2 SoC (t8112).
> 
> Device tree validation depends on the dart-t8110 bindings queued in
> the iommu tree for 6.3 [1], PMU updates [2] and support for
> "local-mac-address" for brcm,bcm4329-fmac based devices [3]. The latter
> fixes validation errors for the existing M1 and M1 Pro/Max/Ultra device
> trees.
> 
> The device trees are tested with the downstream Asahi Linux kernel and
> on top of v6.2-rc5. The hardware is of limited use with the upstream
> kernel. The notebooks miss keyboard/trackpad drivers and usb support.
> The Mac mini does not yet have a boot framebuffer and lacks usb support
> as well.
> 
> 1: https://lore.kernel.org/linux-iommu/20230113105029.26654-1-marcan@marcan.st/
> 2: https://lore.kernel.org/linux-devicetree/20230214-apple_m2_pmu-v1-1-9c9213ab9b63@jannau.net/
> 3: https://lore.kernel.org/linux-devicetree/20230203-dt-bindings-network-class-v2-2-499686795073@jannau.net/
> 
> The dt-binding changes in this series are documentation only. All
> drivers are compatible with the HW on the M2 SoC and are probed based
> on generic compatibles. The t8112 specific compatibles are added to
> address t8112 specific quirks in the case they become required.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>

Thanks, applied everything except #13 to asahi-soc/dt.

- Hector

