Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A766231DE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 18:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiKIRt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 12:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbiKIRtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 12:49:43 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FC0656A;
        Wed,  9 Nov 2022 09:49:34 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 94A33240002;
        Wed,  9 Nov 2022 17:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668016172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O7d9XV6IsnIwU7Gj07fwE3ldNBJ/qjfOW6mSWa+l8tI=;
        b=CLipaJKhG3s+/op4L0NtH9sjz2WfwiRqjsKDlScPaX0KdHktmnWhIGym0rK890RfIxNJKK
        MLUF4Xl0RxHIqQtYZ5p5uBz7pl4+/Vj1yucDRer129pJAruTVoQ3dc55nGhoi2O/ZZvtYy
        0QOYI5PoA9Ri918CkMmOi0zIf5yl7udtNc3QCrOAvYlTUpdGDVxispUsZ3D6wxtIBLEb7j
        6kPYFE+xx55WzPq7oiXWScyfMSDZL8I3v9OVlxct0YVUKmTcn9glcAm9rBc+aRgd54n4bH
        Zpd32cL6D4eyMhWabFPmWEOczgX5rfFuJugIMBT8yZ3UUaJ9yx9IoaeKImPTQA==
Date:   Wed, 9 Nov 2022 18:49:30 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Alexandre Mergnat <amergnat@baylibre.com>,
        Fabien Parent <fabien.parent@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Lee Jones <lee@kernel.org>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>,
        linux-rtc@vger.kernel.org, Rob Herring <robh@kernel.org>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: Re: [PATCH v4 2/9] dt-bindings: rtc: mediatek: convert MT6397 rtc
 documentation
Message-ID: <Y2voKqz1zRg32jaJ@mail.local>
References: <20221005-mt6357-support-v4-0-5d2bb58e6087@baylibre.com>
 <20221005-mt6357-support-v4-2-5d2bb58e6087@baylibre.com>
 <ed298a3e-25dd-af19-437c-f27c160788b3@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed298a3e-25dd-af19-437c-f27c160788b3@collabora.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2022 10:40:39+0100, AngeloGioacchino Del Regno wrote:
> Il 08/11/22 19:43, Alexandre Mergnat ha scritto:
> > - Convert rtc/rtc-mt6397.txt to rtc/mt6397-rtc.yaml
> > - Add mediatek,mt6357-rtc compatible.
> > - Add maintainer
> > - Remove the .txt binding file
> > 
> > Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> > ---
> >   Documentation/devicetree/bindings/mfd/mt6397.txt   |  2 +-
> >   .../bindings/rtc/mediatek,mt6397-rtc.yaml          | 40 ++++++++++++++++++++++
> >   .../devicetree/bindings/rtc/rtc-mt6397.txt         | 31 -----------------
> >   3 files changed, 41 insertions(+), 32 deletions(-)
> > 
> 
> Please split the txt->yaml conversion in one commit and the addition of the
> new mt6357-rtc compatible in another commit.
> 
> Also, isn't the original maintainer of rtc-mt6397 supposed to be...
> Tianping Fang <tianping.fang@mediatek.com> ?
> 
> You can add yourself to the list of maintainers, though, unless Tianping
> explicitly says that he doesn't want to maintain this driver anymore?
> 

This is not about the maintenance of the driver but of the device tree
bindings for the IP

> Regards,
> Angelo
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
