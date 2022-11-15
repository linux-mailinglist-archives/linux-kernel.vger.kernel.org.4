Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1694E6292E6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 09:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbiKOIFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 03:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiKOIFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 03:05:32 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D24A12092;
        Tue, 15 Nov 2022 00:05:29 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 2E076FF806;
        Tue, 15 Nov 2022 08:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668499528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eEbSHKHGRpbb9PgZ/zPz2mmQi5ODZU5r5BMBef00TwA=;
        b=pfBhwswO4mTb4ORezuGnVBW6MsdaRQQTND2iQzNEIYu47J5OLZJsz4OHV3j/FjxNBuMYef
        iJjRCOWK/PyfCQGtnGR0CuKFbskranGo0cuchaIxNkEeSbbdkKfojCVcthAKVeDOwdhU/L
        gWud8NSqWFagejFW3AO3F2D8U4SL/Ww/X6f+4BCzcRCZUzXUtCk7C8ET5CQTo2vpW914Ic
        QcA4ZrxVTTcWncMysRsk1wtnYCnAONud/7rUdjeU3ZLSoiYvjaDP0CVAqYAnAJv8zg0hZC
        kMDafJXoF9EPqIzvvB6V9t9O4NUTNnp9WeBZr7NPzqBJdh2f1x7oKmn1rP/2zg==
Date:   Tue, 15 Nov 2022 09:05:25 +0100
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
Message-ID: <Y3NIRbyirJjT7xay@mail.local>
References: <20221005-mt6357-support-v4-0-5d2bb58e6087@baylibre.com>
 <20221005-mt6357-support-v4-2-5d2bb58e6087@baylibre.com>
 <20221109222916.GA2985917-robh@kernel.org>
 <Y2wwUOJ0KZdt1tZ6@mail.local>
 <adf8bc44-4cbc-af2a-4ec8-1859a98146d7@linaro.org>
 <Y3LHxDIzfZWhnQJN@mail.local>
 <37dc4e39-8033-a40f-edd7-4bd30f841e23@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37dc4e39-8033-a40f-edd7-4bd30f841e23@linaro.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2022 08:56:40+0100, Krzysztof Kozlowski wrote:
> On 14/11/2022 23:57, Alexandre Belloni wrote:
> 
> >>>> As this is only a compatible string, just fold this into the MFD schema 
> >>>> doc.
> >>>
> >>> Actually, it probably also supports the start-year property
> >>
> > 
> > I checked and it doesn't support it but this needs to be fixed.
> > 
> >> What about rest of rtc.yaml schema?
> >>
> > 
> > wakeup-source would make sense but the driver doesn't support it yet.
> 
> The question is about hardware - does hardware support waking up the
> system via interrupt? This is usually a domain of PMICs which still are
> powered on when system sleeps.
> 

I'd say that it is possible that a PMIC is able to wake up the system
with or without having an interrupt wired to the SoC so wakeup-source
makes sense. We don't need it if it is interrupt only.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
