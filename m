Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD526A9B06
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 16:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjCCPsA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 3 Mar 2023 10:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbjCCPr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 10:47:57 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B470F1711;
        Fri,  3 Mar 2023 07:47:52 -0800 (PST)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1pY7dO-0005tb-P2; Fri, 03 Mar 2023 16:47:50 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     rafael@kernel.org, daniel.lezcano@linaro.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH v5 06/18] thermal: Remove debug or error messages in get_temp()
 ops
Date:   Fri, 03 Mar 2023 16:47:55 +0100
Message-ID: <1753720.VLH7GnMWUR@diego>
In-Reply-To: <20230301201446.3713334-7-daniel.lezcano@linaro.org>
References: <20230301201446.3713334-1-daniel.lezcano@linaro.org>
 <20230301201446.3713334-7-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 1. März 2023, 21:14:34 CET schrieb Daniel Lezcano:
> Some get_temp() ops implementation are showing an error or a debug
> message if the reading of the sensor fails.
> 
> The debug message is already displayed from the call site of this
> ops. So we can remove it.
> 
> On the other side, the error should not be displayed because in
> production that can raise tons of messages.
> 
> Finally, some drivers are showing a debug message with the
> temperature, this is also accessible through the trace from the core
> code in the temperature_update() function.
> 
> Another benefit is the dev_* messages are accessing the thermal zone
> device field from the structure, so we encapsulate even more the code
> by preventing these accesses.
> 
> Remove those messages.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com> #Armada
> Acked-by: Florian Fainelli <f.fainelli@gmail.com> #brcmstb_thermal.c

Acked-by: Heiko Stuebner <heiko@sntech.de> #rockchip


