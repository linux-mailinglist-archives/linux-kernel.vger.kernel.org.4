Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931477226D7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233883AbjFENFW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233720AbjFENEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:04:48 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A186CD;
        Mon,  5 Jun 2023 06:04:38 -0700 (PDT)
X-GND-Sasl: alexandre.belloni@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685970277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Opg2+jWVs0W7tfe9P4gJ/SIM6FCQK0Ho4WgIqLLU0Ow=;
        b=LukbBwm6elO0tpONiMDeHF4pYr6U4PvbsvMdHp99wOb9TcTReyrNlKhydcfUM7+RONNq9X
        hal4PyWx2JCo2lJaFzWfjJxEaKKs9bR4MGIQ2YoAsJr1F21iBnhhNXeUWPDCNumnBOmTr+
        /jc9uZO5dupdqRCFk/ekCyMFYENttt5pr4pEUxVo3qYdv8a3nPhMWai4Z3exnC1vhri/mq
        aaFn4mJqPTmSsDkp6+2wgs6vhfT39yuwexBnWA7Q+0bEegaQHbE2eF/RjtMmjbQ6Qm735l
        q5xbLg1GmgRcOA/a4k9jhfcCkFzKKeL8QA8OLZWoY3QoMOPKguyFuuwtyBJTgw==
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
Received: by mail.gandi.net (Postfix) with ESMTPSA id 513104000C;
        Mon,  5 Jun 2023 13:04:35 +0000 (UTC)
Date:   Mon, 5 Jun 2023 15:04:35 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Wolfram Sang <wsa@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        devicetree@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Subject: Re: [PATCH v6 00/11] Add Renesas PMIC RAA215300 and built-in RTC
 support
Message-ID: <202306051304351d588a1a@mail.local>
References: <20230602142426.438375-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602142426.438375-1-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 02/06/2023 15:24:15+0100, Biju Das wrote:
> Logs:
> [   15.447305] rtc-isl1208 3-006f: registered as rtc0
> [   15.479493] rtc-isl1208 3-006f: setting system clock to 2023-04-27T19:31:02 UTC (1682623862)
> 
> root@smarc-rzv2l:~# hwclock -r
> 2023-04-27 19:33:05.499001+00:00
> root@smarc-rzv2l:~# hwclock -r
> 2023-04-27 19:33:06.936688+00:00
> root@smarc-rzv2l:~#

You should probably run rtc-test if you want to ensure it is working
properly.

What is the expectation, can I apply the rtc patches once they are ready
or are there dependencies?

> 
> Biju Das (11):
>   i2c: Enhance i2c_new_ancillary_device API
>   regulator: dt-bindings: Add Renesas RAA215300 PMIC bindings
>   regulator: Add Renesas PMIC RAA215300 driver
>   arm64: dts: renesas: rzg2l-smarc-som: Enable PMIC and built-in RTC
>   dt-bindings: rtc: isl1208: Convert to json-schema
>   dt-bindings: rtc: isil,isl1208: Document clock and clock-names
>     properties
>   rtc: isl1208: Drop name variable
>   rtc: isl1208: Make similar I2C and DT-based matching table
>   rtc: isl1208: Drop enum isl1208_id and split isl1208_configs[]
>   rtc: isl1208: Add isl1208_set_xtoscb()
>   rtc: isl1208: Add support for the built-in RTC on the PMIC RAA215300
> 
>  .../bindings/regulator/renesas,raa215300.yaml |  85 ++++++++++
>  .../devicetree/bindings/rtc/isil,isl1208.txt  |  38 -----
>  .../devicetree/bindings/rtc/isil,isl1208.yaml | 100 ++++++++++++
>  .../boot/dts/renesas/rzg2l-smarc-som.dtsi     |  18 +++
>  drivers/gpu/drm/bridge/adv7511/adv7511_drv.c  |   6 +-
>  drivers/i2c/i2c-core-base.c                   |  91 +++++++----
>  drivers/media/i2c/adv748x/adv748x-core.c      |   2 +-
>  drivers/media/i2c/adv7604.c                   |   3 +-
>  drivers/regulator/Kconfig                     |   7 +
>  drivers/regulator/Makefile                    |   1 +
>  drivers/regulator/raa215300.c                 |  92 +++++++++++
>  drivers/rtc/rtc-isl1208.c                     | 150 ++++++++++++++----
>  include/linux/i2c.h                           |   3 +-
>  13 files changed, 490 insertions(+), 106 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/regulator/renesas,raa215300.yaml
>  delete mode 100644 Documentation/devicetree/bindings/rtc/isil,isl1208.txt
>  create mode 100644 Documentation/devicetree/bindings/rtc/isil,isl1208.yaml
>  create mode 100644 drivers/regulator/raa215300.c
> 
> -- 
> 2.25.1
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
