Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C7065A8C1
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 04:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjAADhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 22:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjAADhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 22:37:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD79763FB;
        Sat, 31 Dec 2022 19:37:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65C67B80819;
        Sun,  1 Jan 2023 03:37:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E08EC433D2;
        Sun,  1 Jan 2023 03:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672544259;
        bh=NP+GI5dzNYRCBDfzWKyIXXEAj9BmDnzW9+Yyc9TMCuY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sUCk5+746nq2DrdYI7330443XXCMwE3W/8qDBsDP1JeQAHL7itcYQohCW7yQD/PUN
         9/5emqBhaRh0b/CSkiYUvnroChQiSxoyFffj1abm6rl/szteECw1c2MSrpxXmPZ+rU
         sLXErleU0CMiZV3NwHfNNJuT1oRRJHcM/tRAUGYeK/WaQSKDeZ03vfLaYnYkDcVRCG
         45MDt136P1Ou33BqMGiezguliIPDTsVwxHWesO+/zr+mbSE8U6GDDa0tM/z0CNmxav
         awDF4M37izBusvsw+CE1TwckwFofY6eKoevCQZXqBlcGNLWbzRsLJVvyz4ZIYsofO6
         kFeZPal6+mR7w==
Date:   Sun, 1 Jan 2023 11:37:32 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: imx8mp: Fix missing GPC Interrupt
Message-ID: <20230101033731.GT6112@T480>
References: <20221217180849.775718-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221217180849.775718-1-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2022 at 12:08:48PM -0600, Adam Ford wrote:
> The GPC node references an interrupt parent, but it doesn't
> state the interrupt itself.  According to the TRM, this IRQ
> is 87. This also eliminate an error detected from dt_binding_check
> 
> Fixes: fc0f05124621 ("arm64: dts: imx8mp: add GPC node with GPU power domains")
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied both, thanks!
