Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C11628C6D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 23:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237481AbiKNW5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 17:57:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237808AbiKNW5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 17:57:16 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBEE1B7A3;
        Mon, 14 Nov 2022 14:57:12 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 06BD5240003;
        Mon, 14 Nov 2022 22:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668466631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M3hQEMxlrNK+06eeO3xPT9LuLj4yjY7yvIvmM3pxtPo=;
        b=bj9eV86lzO2PB1EMaUD1jpebxgmKDCSQHfN4vnk2N7CP9Sp0BntWcEb+LscO0TFl27SYbq
        huthOt1QjAWLQOuK0MIdUHuitTti2lkheZnVDX42rOeEYo5Sm8oZ0DuvabkKthMx+xwbcF
        kCAvB1k8/torNFRFnIY9JZHj8HWVEhjl7HceyIKCpMQrFwIMYKAH7oUxmmcYVPDWsFwvO2
        FBjK1SdraumjMSx5Q5n3Qtrx1IUB6h6/TZ/+qh3zrAlZgZIRDPdDN6e+W4Kn/gm8idNiFP
        ia/ECYj9ZldDZoWIuYzpmRzn0N89TSslCE+21uX6IQiQclrzRGWOLvTwmEjnFg==
Date:   Mon, 14 Nov 2022 23:57:08 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Fabien Parent <fabien.parent@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Pavel Machek <pavel@ucw.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-rtc@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: Re: [PATCH v4 2/9] dt-bindings: rtc: mediatek: convert MT6397 rtc
 documentation
Message-ID: <Y3LHxDIzfZWhnQJN@mail.local>
References: <20221005-mt6357-support-v4-0-5d2bb58e6087@baylibre.com>
 <20221005-mt6357-support-v4-2-5d2bb58e6087@baylibre.com>
 <20221109222916.GA2985917-robh@kernel.org>
 <Y2wwUOJ0KZdt1tZ6@mail.local>
 <adf8bc44-4cbc-af2a-4ec8-1859a98146d7@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adf8bc44-4cbc-af2a-4ec8-1859a98146d7@linaro.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2022 15:14:01+0100, Krzysztof Kozlowski wrote:
> On 09/11/2022 23:57, Alexandre Belloni wrote:
> > On 09/11/2022 16:29:16-0600, Rob Herring wrote:
> >> On Tue, Nov 08, 2022 at 07:43:37PM +0100, Alexandre Mergnat wrote:
> >>> - Convert rtc/rtc-mt6397.txt to rtc/mt6397-rtc.yaml
> >>> - Add mediatek,mt6357-rtc compatible.
> >>> - Add maintainer
> >>> - Remove the .txt binding file
> >>>
> >>> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> >>> ---
> >>>  Documentation/devicetree/bindings/mfd/mt6397.txt   |  2 +-
> >>>  .../bindings/rtc/mediatek,mt6397-rtc.yaml          | 40 ++++++++++++++++++++++
> >>>  .../devicetree/bindings/rtc/rtc-mt6397.txt         | 31 -----------------
> >>>  3 files changed, 41 insertions(+), 32 deletions(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
> >>> index 0088442efca1..79aaf21af8e9 100644
> >>> --- a/Documentation/devicetree/bindings/mfd/mt6397.txt
> >>> +++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
> >>> @@ -33,7 +33,7 @@ Optional subnodes:
> >>>  		- compatible: "mediatek,mt6331-rtc"
> >>>  		- compatible: "mediatek,mt6358-rtc"
> >>>  		- compatible: "mediatek,mt6397-rtc"
> >>> -	For details, see ../rtc/rtc-mt6397.txt
> >>> +	For details, see ../rtc/mediatek,mt6397-rtc.yaml
> >>>  - regulators
> >>>  	Required properties:
> >>>  		- compatible: "mediatek,mt6323-regulator"
> >>> diff --git a/Documentation/devicetree/bindings/rtc/mediatek,mt6397-rtc.yaml b/Documentation/devicetree/bindings/rtc/mediatek,mt6397-rtc.yaml
> >>> new file mode 100644
> >>> index 000000000000..bb48c0150f95
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/rtc/mediatek,mt6397-rtc.yaml
> >>> @@ -0,0 +1,40 @@
> >>> + # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/rtc/mediatek,mt6397-rtc.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: MediaTek MT6397/MT6366/MT6358/MT6357/MT6323 RTC
> >>> +
> >>> +maintainers:
> >>> +  - Alexandre Mergnat <amergnat@baylibre.com>
> >>> +
> >>> +description: |
> >>> +  MediaTek PMIC based RTC is an independent function of MediaTek PMIC that works
> >>> +  as a type of multi-function device (MFD). The RTC can be configured and set up
> >>> +  with PMIC wrapper bus which is a common resource shared with the other
> >>> +  functions found on the same PMIC.
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    enum:
> >>> +      - mediatek,mt6323-rtc
> >>> +      - mediatek,mt6357-rtc
> >>> +      - mediatek,mt6358-rtc
> >>> +      - mediatek,mt6366-rtc
> >>> +      - mediatek,mt6397-rtc
> >>
> >> As this is only a compatible string, just fold this into the MFD schema 
> >> doc.
> > 
> > Actually, it probably also supports the start-year property
> 

I checked and it doesn't support it but this needs to be fixed.

> What about rest of rtc.yaml schema?
> 

wakeup-source would make sense but the driver doesn't support it yet.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
