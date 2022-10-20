Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9084605E6A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbiJTLE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbiJTLEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:04:54 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA216BCDB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:04:52 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1olTLy-0004hW-7z; Thu, 20 Oct 2022 13:04:46 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1olTLx-0003SY-N8; Thu, 20 Oct 2022 13:04:45 +0200
Date:   Thu, 20 Oct 2022 13:04:45 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        linux-kernel@vger.kernel.org, Clark Wang <xiaoning.wang@nxp.com>,
        linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 04/15] ARM64: dts: imx8mp-evk: add pwm support
Message-ID: <20221020110445.2xsmdybyhhaaasgx@pengutronix.de>
References: <20221020095934.1659449-1-peng.fan@oss.nxp.com>
 <20221020095934.1659449-5-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020095934.1659449-5-peng.fan@oss.nxp.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On 22-10-20, Peng Fan (OSS) wrote:
> From: Clark Wang <xiaoning.wang@nxp.com>

...

>  &iomuxc {
> +	pinctrl_pwm1: pwm1grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO01__PWM1_OUT	0x116
> +		>;
> +	};
> +
> +	pinctrl_pwm2: pwm2grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_GPIO1_IO11__PWM2_OUT	0x116
> +		>;
> +	};
> +
> +	pinctrl_pwm4: pwm4grp {
> +		fsl,pins = <
> +			MX8MP_IOMUXC_SAI5_RXFS__PWM4_OUT	0x116
> +		>;
> +	};

Please sort them alphabetical into the iomuxc node and do not break that
sort.

Regards,
  Marco
