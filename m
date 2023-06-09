Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EE1729D10
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241520AbjFIOi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241526AbjFIOiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:38:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8471D358E;
        Fri,  9 Jun 2023 07:38:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B92B8658AB;
        Fri,  9 Jun 2023 14:38:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7BAC433EF;
        Fri,  9 Jun 2023 14:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686321501;
        bh=f+fQv+upRjx2w7c5bcBW2it7gWiYnokP+mGVW6jLa4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V4P4J6gaolPwKhAxmWgzUczzx90Q8+dfYX3FByErMoG6vnvQsgg1CelsVPrkXcUqD
         GRXon+Q+VUjJLlb1gF2x/QJ0zc36IrDA3UNycSa5TplJnQgfoQZDFOxm81Pc2TXyfv
         fPoNSG9l46OJ6fR3Sqj6K/Lr460OWxFb1XbiDUZHgBbq3GY6+kL0hKimbqU3h/OCki
         dP2uU0r6a//Q2m4n1iqa3ZfVGyZNjgfaDizLVCpfMlgbW2Pbdlm6jn9iG7+bN9/+uw
         z6KeN0qkHpdPN3HDvSzUr3LmQMCC2//VhRTilZKC9Fc6T+rkynROO7qE96caTewbJ4
         XqxdoDu0uTvHg==
Date:   Fri, 9 Jun 2023 22:38:03 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: imx8mp-venice-gw74xx: update to revB PCB
Message-ID: <20230609143803.GC4199@dragon>
References: <20230606152652.1447659-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606152652.1447659-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 08:26:52AM -0700, Tim Harvey wrote:
> Update the imx8mp-venice-gw74xx for revB:
>  - add CAN1
>  - add TIS-TPM on SPI2
>  - add FAN controller
>  - fix PMIC I2C bus (revA PMIC I2C was non-functional so no need for
>    backward compatible option)
>  - M2 socket GPIO's moved
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

../arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts:402.4-17: Warning (reg_format): /soc@0/bus@30800000/i2c@30a20000/gsc@20/fan-controller@a:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
../arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts:400.20-403.5: Warning (avoid_default_addr_size): /soc@0/bus@30800000/i2c@30a20000/gsc@20/fan-controller@a: Relying on default #address-cells value
../arch/arm64/boot/dts/freescale/imx8mp-venice-gw74xx.dts:400.20-403.5: Warning (avoid_default_addr_size): /soc@0/bus@30800000/i2c@30a20000/gsc@20/fan-controller@a: Relying on default #size-cells value

Shawn
