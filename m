Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08116621DA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236757AbjAIJm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjAIJlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:41:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 735689FC4;
        Mon,  9 Jan 2023 01:41:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BB4360F9A;
        Mon,  9 Jan 2023 09:41:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F00CC433EF;
        Mon,  9 Jan 2023 09:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673257301;
        bh=QF4ZJReaQYBRFbMV6685kSf7SQRUb2qQBc23gK9PSyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MKtnQHwZLzMDsuoCgVBQuwnbW2HoawmAyFtHO1US7G45IhbSC3Nm1Dwpeqrdta6iS
         xfuLy0TZBmVopBkRgB74ijrCPRp41HOVAxenKQebnuFLilvN7Y1bgxE1FGwXr9OD59
         PfXEP4lculUns3IV/WtUc2wVfk0L9oigVhiWMpSfpmkX8H49puPA/x+cq0n0IaUZM4
         9c6Rq3emIXk4poc3gKNRlOvFpPqWh9K613ivnlBDb+1kaXPHkp5Pc+uaCqronfI/WS
         OqFMQropL9HjPZ64PooPGBuQ35tvk5H28r6NWA66BJALtU3r5yltLxq65G/byx4PPO
         R/KbhFSIe7C2g==
Date:   Mon, 9 Jan 2023 17:41:32 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Han Xu <han.xu@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] arm64: dts: freescale: imx8dxl: fix sc_pwrkey's
 property name linux,keycode
Message-ID: <20230109094131.GK18301@T480>
References: <20230104210744.2357777-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104210744.2357777-1-Frank.Li@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2023 at 04:07:40PM -0500, Frank Li wrote:
> linux,keycode should be "linux,keycodes" according binding-doc
> Documentation/devicetree/bindings/input/fsl,scu-key.yaml
> 
> Fixes: f537ee7f1e76 ("arm64: dts: freescale: add i.MX8DXL SoC support")
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied, thanks!
