Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D62630AEE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 04:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbiKSDDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 22:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbiKSDDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 22:03:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12275AF0A1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 19:03:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CD5162762
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 03:03:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8321DC433D6;
        Sat, 19 Nov 2022 03:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668826981;
        bh=W/h+IWugdowyQxdwHWm5dgMcLt6jNYoL6KZ0glOxdLA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j1fSFXzgAMc0PSgtGpSxyh7Rv8FEsQA2oyNLXUaQqkiU0c5FcvUXNruxYtEMLMhgf
         r3zbuY7F3698HXW3ao6M15Mt1h9FHyRPzKipwUqbr7dclR0AAR2+4M/Jpbom8kWRZi
         0VICZO5m/XITvnfVi52QW8nD50Qaukm9QZnMoNwMuELBz1ms5yyP+ougoluCceuvRD
         NUSEsWzpVo7dUgqnkMsiHGiZ6ixdaIfaexGCigbEalzY86gjvvWqnasGYsNsluzOA5
         v1623z8LarD5l9+vbEf5q04nAR0F8iPM3I9TygHonaFUsiTsmolsd9bSa3YqSdcT4n
         aERcJ6do4+l+g==
Date:   Sat, 19 Nov 2022 11:02:55 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Clark Wang <xiaoning.wang@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH V6 03/12] ARM64: dts: imx8mp-evk: add pwm support
Message-ID: <20221119030254.GD16229@T480>
References: <20221117095403.1876071-1-peng.fan@oss.nxp.com>
 <20221117095403.1876071-4-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117095403.1876071-4-peng.fan@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 05:53:54PM +0800, Peng Fan (OSS) wrote:
> From: Clark Wang <xiaoning.wang@nxp.com>
> 
> Enable pwm1/2/4 support.
> Enable pwm1 on pin GPIO1_IO01 for DSI_BL_PWM
>        pwm2 on pin GPIO1_IO11 for LVDS_BL_PWM
>        pwm4 on pin SAI5_RXFS for J21-32
> 
> Acked-by: Fugang Duan <fugang.duan@nxp.com>
> Signed-off-by: Clark Wang <xiaoning.wang@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

Applied, thanks!
