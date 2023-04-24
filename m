Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8975B6EC83C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 11:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjDXJAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 05:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjDXJAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 05:00:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 161AD10CC;
        Mon, 24 Apr 2023 02:00:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6A806137C;
        Mon, 24 Apr 2023 09:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 862C3C433EF;
        Mon, 24 Apr 2023 08:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682326817;
        bh=wR67sHnfAWD61UY2/6LLn6GjwksJh2dH/l18sPo/gNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dxxTN6KccHqX2+mFxLZ1vSCpxC1nO2QkKA2kc4n5lhUlWDIR4LFiw+81LRYw52Ad5
         66gQS+ujD5w53YNGywPXDVpusW2cgJk9OnfSH4Gyn6CaYFSmi9npcdwjSgyaI4AeZ+
         UOWF3SSjQPJ4oIQk5Ry6RFkpFLZVOwO7SGbOpXko1ATzqbvVSx2+PfXHRtUCtwLszk
         AG8OQOZ/59/TcEJJApKe3KdHb3+HBbt3Qwl/sKFiEXDuARaxGismV+1swYRLvgLpGq
         62gqS17MHOiAScB8lTe6V1RTEkGjfXUlgF30qQFdjkX/5YNCKmJIbc5Y4UTNsltZzV
         m0TbFWtPG4sVw==
Date:   Mon, 24 Apr 2023 09:59:42 +0100
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
Message-ID: <20230424085942.GA8035@google.com>
References: <20230322055628.4441-1-Zeynep.Arslanbenzer@analog.com>
 <20230322055628.4441-9-Zeynep.Arslanbenzer@analog.com>
 <20230330123136.GF434339@google.com>
 <DM6PR03MB519577728975E086D8EB20F38B669@DM6PR03MB5195.namprd03.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DM6PR03MB519577728975E086D8EB20F38B669@DM6PR03MB5195.namprd03.prod.outlook.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Apr 2023, Arslanbenzer, Zeynep wrote:

> On Thu, 30 Mar 2023, Lee Jones wrote:
> 
> >On Wed, 22 Mar 2023, Zeynep Arslanbenzer wrote:
> >
> >> MFD driver for MAX77643/MAX77654/MAX77658/MAX77659 to enable its sub
> >
> >Please drop all references to 'MFD'.
> >
> >What are these devices, really?  I suspect they are PMICs?
> >
> >> devices.
> >>
> >> The MAX77643 is a multi-function devices. It includes regulator.
> >>
> >> The MAX77654 is a multi-function devices. It includes regulator and 
> >> charger.
> >>
> >> The MAX77658 is a multi-function devices. It includes regulator, 
> >> charger and battery.
> >>
> >> The MAX77659 is a multi-function devices. It includes regulator and 
> >> charger.
> >>
> >> Signed-off-by: Nurettin Bolucu <Nurettin.Bolucu@analog.com>
> >> Signed-off-by: Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
> >> ---
> >>  drivers/mfd/Kconfig          |  15 ++
> >>  drivers/mfd/Makefile         |   1 +
> >>  drivers/mfd/max77658.c       | 448 +++++++++++++++++++++++++++++++++++
> >>  include/linux/mfd/max77658.h |  88 +++++++
> >>  4 files changed, 552 insertions(+)
> >>  create mode 100644 drivers/mfd/max77658.c  create mode 100644 
> >> include/linux/mfd/max77658.h
> >>
> >> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig index 
> >> 8b93856de432..7b4be7fb8662 100644
> >> --- a/drivers/mfd/Kconfig
> >> +++ b/drivers/mfd/Kconfig
> >> @@ -821,6 +821,21 @@ config MFD_MAX77650
> >>  	  the following functionalities of the device: GPIO, regulator,
> >>  	  charger, LED, onkey.
> >>
> >> +config MFD_MAX77658
> >> +	tristate "Analog Devices MAX77643/MAX77654/MAX77658/MAX77659 PMIC Support"
> >> +	depends on I2C
> >> +	depends on OF
> >> +	select MFD_CORE
> >> +	select REGMAP_I2C
> >> +	select REGMAP_IRQ
> >> +	help
> >> +	  Say Y here to add support for Analog Devices
> >> +	  MAX77643/MAX77654/MAX77658/MAX77659 Power Management IC.
> >
> >"MAX776xx series"?
> 
> As I realized later, max77620, max77650, max77686, and max77693 drivers were merged to Linux before our patch. They are also PMIC devices and our patch does not cover them. Therefore, I think it would not be appropriate to use MAX776xx.

Perhaps you can come up with something a little more scalable then.

What if you added support for another 10 devices?

-- 
Lee Jones [李琼斯]
