Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF5573D51F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 00:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjFYW7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 18:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjFYW7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 18:59:18 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF531A3;
        Sun, 25 Jun 2023 15:59:16 -0700 (PDT)
X-GND-Sasl: alexandre.belloni@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1687733954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KFR20bnGdcCIhIEUWg9VDBjzYhckIwBEXgB7df3zsmA=;
        b=N7SNr1RhuigsLxZpkYrHUFUOScvsx13mafZFqh0eU1CvUdSpInau7LindICuvV729cvw/e
        nPa8HEfI3RdTWMI5EQZ1D6vwYbGyWyKw1u7Jv6/WIqdx7qf1+Xb7DPvpl2lFJBexc+/kCI
        yOVGvuYW8OtYlDl55rS6NvMJ7/uMkrmh0DhTGTjTlu/pTf6c1WArgGtefDtGVy/LWPu4jl
        X9lbJ+tSLYt1Ak9OwLo2VMj1fY8uGt3Rluls4iR8yK+NghmCljMY2B3V1WS9CF1orb0SWd
        xW8zSOJx4mv+t67xp3EQCWnL8n2WYhCiqv9iocy4Rd6pWNwDLPCVgqnGzJdRXA==
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E5DF540003;
        Sun, 25 Jun 2023 22:59:12 +0000 (UTC)
Date:   Mon, 26 Jun 2023 00:59:12 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Wolfram Sang <wsa@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Trent Piepho <tpiepho@gmail.com>, devicetree@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: (subset) [PATCH v7 00/10] Add Renesas PMIC RAA215300 and
 built-in RTC support
Message-ID: <168773392610.111997.16021927718782550143.b4-ty@bootlin.com>
References: <20230623140948.384762-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623140948.384762-1-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 23 Jun 2023 15:09:38 +0100, Biju Das wrote:
> This patch series aims to add support for Renesas PMIC RAA215300 and
> built-in RTC found on this PMIC device.
> 
> The details of PMIC can be found here[1].
> 
> Renesas PMIC RAA215300 exposes two separate i2c devices, one for the main
> device and another for rtc device.
> 
> [...]

Applied, thanks!

[04/10] dt-bindings: rtc: isl1208: Convert to json-schema
        commit: ac739bac5201d4308cba2525dacb5da654b3ff31
[05/10] dt-bindings: rtc: isil,isl1208: Document clock and clock-names properties
        commit: 138f352556d791d7e0ca3ac9a4f4815123af8c82
[06/10] rtc: isl1208: Drop name variable
        commit: 380960c40a1d106bba3476c9a010eaf28195115d
[07/10] rtc: isl1208: Make similar I2C and DT-based matching table
        commit: fbc06a53561c64ec6d7f9a1b3bc04597de4cbb2d
[08/10] rtc: isl1208: Drop enum isl1208_id and split isl1208_configs[]
        commit: 5923fc75d0dfcebce53894ddada7e2440d756f8b
[09/10] rtc: isl1208: Add isl1208_set_xtoscb()
        commit: 262f72b4656e182eefaab91ab24a7575dda5524f
[10/10] rtc: isl1208: Add support for the built-in RTC on the PMIC RAA215300
        commit: fdd63f65ac25d0851dade4c7ba94a7a882b8d9c2

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
