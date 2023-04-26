Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F192B6EF680
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 16:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241420AbjDZOcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 10:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241417AbjDZOcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 10:32:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43DA449D;
        Wed, 26 Apr 2023 07:32:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 269D160FFF;
        Wed, 26 Apr 2023 14:32:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9186C433D2;
        Wed, 26 Apr 2023 14:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682519556;
        bh=ktz/8GLqpT56U4gXrVOtMd/vE5Ej8x9fgSw4ZRKKRzQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DWZUNmrp1J9T6wNU1LEPJCjB+nApZmfTZ04NMqqug6Y6YiRzcUhqf2OkhtWrJKAKL
         2DQX9k7HxknJDrAjHxV0O8AdGQOdx1oRZJpJIRgRiYsEWpqMonm6ffFVwAY2Jj2jt8
         rf0MSMcNZ1nBa1f0JvNdy5fZHPrr10LBvsHupZ1bBtiq21JexplffLnKNEWOS+OB7p
         Y1HZIV5w23IM5ZYWqoMJNAdB09YCxL5P3s4R/HFARtYUvm451mdcVoIV5chtAurXEZ
         9PdDBQuaTepgyyAVYEM2YMlB7XRDcK8E+7C9gni+l0Cj2OHPnKObUTg82dOYAr+lS+
         QoZ/k3B9/24xg==
Date:   Wed, 26 Apr 2023 15:32:31 +0100
From:   Lee Jones <lee@kernel.org>
To:     "Arslanbenzer, Zeynep" <Zeynep.Arslanbenzer@analog.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 8/8] mfd: max77658: Add ADI MAX77643/54/58/59 MFD
 Support
Message-ID: <20230426143231.GP50521@google.com>
References: <20230322055628.4441-1-Zeynep.Arslanbenzer@analog.com>
 <20230322055628.4441-9-Zeynep.Arslanbenzer@analog.com>
 <20230330123136.GF434339@google.com>
 <DM6PR03MB519577728975E086D8EB20F38B669@DM6PR03MB5195.namprd03.prod.outlook.com>
 <20230424085942.GA8035@google.com>
 <MN2PR03MB51973EDD4FEDA00200B61C6A8B649@MN2PR03MB5197.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MN2PR03MB51973EDD4FEDA00200B61C6A8B649@MN2PR03MB5197.namprd03.prod.outlook.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Apr 2023, Arslanbenzer, Zeynep wrote:

> On Mon, 24 Apr 2023, Lee Jones wrote:
> >
> >On Sun, 23 Apr 2023, Arslanbenzer, Zeynep wrote:
> >
> >> On Thu, 30 Mar 2023, Lee Jones wrote:
> >> 
> >> >On Wed, 22 Mar 2023, Zeynep Arslanbenzer wrote:
> >> >
> >> >> MFD driver for MAX77643/MAX77654/MAX77658/MAX77659 to enable its 
> >> >> sub
> >> >
> >> >Please drop all references to 'MFD'.
> >> >
> >> >What are these devices, really?  I suspect they are PMICs?
> >> >
> >> >> devices.
> >> >>
> >> >> The MAX77643 is a multi-function devices. It includes regulator.
> >> >>
> >> >> The MAX77654 is a multi-function devices. It includes regulator and 
> >> >> charger.
> >> >>
> >> >> The MAX77658 is a multi-function devices. It includes regulator, 
> >> >> charger and battery.
> >> >>
> >> >> The MAX77659 is a multi-function devices. It includes regulator and 
> >> >> charger.
> >> >>
> >> >> Signed-off-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
> >> >> Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> >> >> ---
> >> >>  drivers/mfd/Kconfig          |  15 ++
> >> >>  drivers/mfd/Makefile         |   1 +
> >> >>  drivers/mfd/max77658.c       | 448 +++++++++++++++++++++++++++++++++++
> >> >>  include/linux/mfd/max77658.h |  88 +++++++
> >> >>  4 files changed, 552 insertions(+)  create mode 100644 
> >> >> drivers/mfd/max77658.c  create mode 100644 
> >> >> include/linux/mfd/max77658.h
> >> >>
> >> >> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig index
> >> >> 8b93856de432..7b4be7fb8662 100644
> >> >> --- a/drivers/mfd/Kconfig
> >> >> +++ b/drivers/mfd/Kconfig
> >> >> @@ -821,6 +821,21 @@ config MFD_MAX77650
> >> >>  	  the following functionalities of the device: GPIO, regulator,
> >> >>  	  charger, LED, onkey.
> >> >>
> >> >> +config MFD_MAX77658
> >> >> +	tristate "Analog Devices MAX77643/MAX77654/MAX77658/MAX77659 PMIC Support"
> >> >> +	depends on I2C
> >> >> +	depends on OF
> >> >> +	select MFD_CORE
> >> >> +	select REGMAP_I2C
> >> >> +	select REGMAP_IRQ
> >> >> +	help
> >> >> +	  Say Y here to add support for Analog Devices
> >> >> +	  MAX77643/MAX77654/MAX77658/MAX77659 Power Management IC.
> >> >
> >> >"MAX776xx series"?
> >> 
> >> As I realized later, max77620, max77650, max77686, and max77693 drivers were merged to Linux before our patch. They are also PMIC devices and our patch does not cover them. Therefore, I think it would not be appropriate to use MAX776xx.
> >
> >Perhaps you can come up with something a little more scalable then.
> >
> >What if you added support for another 10 devices?
> >
> For now, we have no plans to add any new device support to this driver. We named the driver max77658 because it has the most inclusive feature among the supported devices. We can shorten it to MAX77643/54/58/59 or just type max77658 in Kconfig and specify other supported devices in the device tree. Would one of these be a more suitable solution?

The former looks like a nice middle-ground.

-- 
Lee Jones [李琼斯]
