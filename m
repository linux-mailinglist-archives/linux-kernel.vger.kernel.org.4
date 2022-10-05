Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD465F50C2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 10:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiJEIYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 04:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiJEIYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 04:24:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3562F6CF5E
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 01:24:02 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1ofzh0-0001Di-0Z; Wed, 05 Oct 2022 10:23:50 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1ofzgy-0003id-U8; Wed, 05 Oct 2022 10:23:48 +0200
Date:   Wed, 5 Oct 2022 10:23:48 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     Peng Fan <peng.fan@nxp.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com
Subject: Re: [RFC PATCH 0/2] Propose critical clocks
Message-ID: <20221005082348.v43xbjrhbdlbaohv@pengutronix.de>
References: <20220913102141.971148-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913102141.971148-1-m.felsch@pengutronix.de>
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

Hi Stephen, Michael,

I know it is a busy time right now, but maybe you have a few minutes for
this RFC. I know it is incomplete, but the interessting part is there
and it would fix a real issue we encountered on the imx8mm-evk's.

Regards,
  Marco

On 22-09-13, Marco Felsch wrote:
> Hi,
> 
> this proposal is to mark clocks as critical. It is somehow inspired by
> the regulator-always-on property. Since sometimes we can end in circular
> dependcies if we wanna solve the dependcies for a specific clock
> provider.
> 
> The property is generic so it can be used by every hw clock provider. So
> it can be seen as generic implementation to [1].
> 
> [1] https://lore.kernel.org/linux-clk/20220913092136.1706263-1-peng.fan@oss.nxp.com/
> 
> Marco Felsch (2):
>   clk: add support for critical always-on clocks
>   arm64: dts: imx8mm-evk: mark 32k pmic clock as always-on
> 
>  arch/arm64/boot/dts/freescale/imx8mm-evk.dtsi |  1 +
>  drivers/clk/clk.c                             | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+)
> 
> -- 
> 2.30.2
> 
> 
> 
