Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FAF6F80BC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 12:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjEEKYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 06:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbjEEKY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 06:24:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7A619427
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 03:24:28 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pusbq-00080v-Gd; Fri, 05 May 2023 12:24:18 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1pusbp-0007F2-4a; Fri, 05 May 2023 12:24:17 +0200
Date:   Fri, 5 May 2023 12:24:17 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: nvmem: add binding doc for i.MX
 OCOTP/ELE
Message-ID: <20230505102417.vtluekzx2oqsbcux@pengutronix.de>
References: <20230505091733.1819521-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505091733.1819521-1-peng.fan@oss.nxp.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23-05-05, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>

...

> +examples:
> +  - |
> +    #include <dt-bindings/clock/imx6sx-clock.h>
> +
> +    ocotp: efuse@21bc000 {
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        compatible = "fsl,imx6sx-ocotp", "syscon";
> +        reg = <0x021bc000 0x4000>;
> +        clocks = <&clks IMX6SX_CLK_OCOTP>;

Nit: the "compatible" should be the first property followed by the "reg"
property.

Regards,
  Marco

> +
> +        cpu_speed_grade: speed-grade@10 {
> +            reg = <0x10 4>;
> +        };
> +
> +        tempmon_calib: calib@38 {
> +            reg = <0x38 4>;
> +        };
> +
> +        tempmon_temp_grade: temp-grade@20 {
> +            reg = <0x20 4>;
> +        };
> +    };
> +
> +...
> -- 
> 2.37.1
> 
> 
> 
