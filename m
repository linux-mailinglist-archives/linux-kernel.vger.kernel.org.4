Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE7662D7D2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 11:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239349AbiKQKR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 05:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiKQKRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 05:17:24 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85EEB2AC73
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 02:17:23 -0800 (PST)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1ovbxO-0007XT-JL; Thu, 17 Nov 2022 11:17:18 +0100
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1ovbxN-00032J-R4; Thu, 17 Nov 2022 11:17:17 +0100
Date:   Thu, 17 Nov 2022 11:17:17 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        Peng Fan <peng.fan@nxp.com>, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V6 07/12] arm64: dts: imx8mn-evk: update vdd_soc dvs
 voltage
Message-ID: <20221117101717.sjxgu3niip2wxjwo@pengutronix.de>
References: <20221117095403.1876071-1-peng.fan@oss.nxp.com>
 <20221117095403.1876071-8-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117095403.1876071-8-peng.fan@oss.nxp.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-11-17, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Per schematic, BUCK1 is for VDD_SOC&DRAM&PU_0V9. The nxp,dvs-run-voltage
> and nxp,dvs-standby-voltage need set for BUCK1, not BUCK2.
> BUCK2 is for A53, which is handled by DVFS, so no need dvs property.
> nxp,dvs-run-voltage is not needed, since bootloader must configure
> voltage to make system boot well.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Acked-by: Marco Felsch <m.felsch@pengutronix.de>

> ---
>  arch/arm64/boot/dts/freescale/imx8mn-evk.dts | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
> index 4eb467df5ba7..4839a962a170 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
> @@ -47,6 +47,7 @@ buck1: BUCK1{
>  				regulator-boot-on;
>  				regulator-always-on;
>  				regulator-ramp-delay = <3125>;
> +				nxp,dvs-standby-voltage = <750000>;
>  			};
>  
>  			buck2: BUCK2 {
> @@ -56,8 +57,6 @@ buck2: BUCK2 {
>  				regulator-boot-on;
>  				regulator-always-on;
>  				regulator-ramp-delay = <3125>;
> -				nxp,dvs-run-voltage = <950000>;
> -				nxp,dvs-standby-voltage = <850000>;
>  			};
>  
>  			buck4: BUCK4{
> -- 
> 2.37.1
> 
> 
> 
