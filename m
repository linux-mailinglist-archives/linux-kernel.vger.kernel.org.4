Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0846630AF8
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 04:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbiKSDIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 22:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbiKSDIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 22:08:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240CCCE29
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 19:08:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66233B82523
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 03:08:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F210C433D6;
        Sat, 19 Nov 2022 03:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668827318;
        bh=Aa/UzsuEa2XC5pnHqhdLpclcpJ30O7MVovQPv+tNr0o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OYCVa7yGEVkkapypRtLw7cQWBpshoMXdQFiWnH3V/QgCxu+SL3ICcaacEjjm0FzGt
         wnp7E69VWQnp8a6a/vw5ZJ/z+jN1Vbt0MnQML9Bjsj4ADQxUUiSRyJTMQbhfZIq8Bi
         Ae1aLXyxRpe1Qufk2ZbfueVN9hjnpwfwLshSVU3Rm9i5FLb/YseNWIlFTk3egh52qh
         6zmbtBOuBgSPiYFjq0z+6WtBMUCmNk5BkBGLMEYCU56MgiGxx/QGsMUx5xXG5XqtLy
         OA59uxYAGCzBdIeJvJimdaB2ZkK8NYFrRx3rxfyW7ez05cHcdHos3Had+ol4XQ6yxm
         3HWu+AZ36xr9Q==
Date:   Sat, 19 Nov 2022 11:08:31 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH V6 08/12] arm64: dts: imx8mn-evk: set off-on-delay-us in
 regulator
Message-ID: <20221119030830.GI16229@T480>
References: <20221117095403.1876071-1-peng.fan@oss.nxp.com>
 <20221117095403.1876071-9-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117095403.1876071-9-peng.fan@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 05:53:59PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Some SD Card controller and power circuitry has increased capacitance,
> so the usual toggling of regulator to power the card off and on
> is insufficient.
> 
> According to SD spec, for sd card power reset operation, the sd card
> supply voltage needs to be lower than 0.5v and keep over 1ms, otherwise,
> next time power back the sd card supply voltage to 3.3v, sd card can't
> support SD3.0 mode again.
> 
> This patch add the off-on-delay-us, make sure the sd power reset behavior
> is align with the specification. Without this patch, when do quick system
> suspend/resume test, some sd card can't work at SD3.0 mode after system
> resume back.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

Applied, thanks!
