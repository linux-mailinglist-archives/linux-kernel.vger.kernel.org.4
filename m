Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4656D7D9E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238012AbjDENWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:22:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237096AbjDENW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:22:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C4426A4;
        Wed,  5 Apr 2023 06:22:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C20163C85;
        Wed,  5 Apr 2023 13:22:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994ECC433EF;
        Wed,  5 Apr 2023 13:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680700946;
        bh=SzrVJig1uDAsMGbP2sWNBvQA42iXXjERJtwuQUlNJ5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BkujqyIb6uWTBnMCAlsT0wY3WNMrW0s7cBQe3kQkvCMdtAtdEDIGiyZw2ZwmG9yXh
         wbV0iNaKU38EvVNtSjCB2vVIJwkSlwludLVRaosPnV/6QfXFbCYGMP4ZayrpkkM0rG
         YVvIrov41DBOeu7FvVnBp4PLS1EiEcPSCDD/oIh2hqmj+aSa7wGbqMFXbyWZF0vVpP
         jtIMlgCwBx4Ib2+G2yCoUZelvIO4IQW+42Y//I0I5AXUi4BmtncFpfdnqCH8YBE1cr
         9aV7RbPbZDZH795tfYZDiZzaKcLaP4BZ43pHE+06gdVEAIXPW8/PBFEWngcO0WxsYh
         UZGL/3UveyUXw==
Date:   Wed, 5 Apr 2023 21:22:17 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx8mm-evk: correct pmic clock source
Message-ID: <20230405132217.GC11367@dragon>
References: <20230327100321.1682333-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230327100321.1682333-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 06:03:21PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The osc_32k supports #clock-cells as 0, using an id is wrong, drop it.
> 
> Fixes: a6a355ede574 ("arm64: dts: imx8mm-evk: Add 32.768 kHz clock to PMIC")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks!
