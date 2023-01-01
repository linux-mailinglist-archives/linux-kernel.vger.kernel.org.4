Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F5D65A912
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 06:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjAAFly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 00:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjAAFlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 00:41:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0D65FB1
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 21:41:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7694760D27
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 05:41:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51C7C433EF;
        Sun,  1 Jan 2023 05:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672551710;
        bh=dCVuRyuyCjXKh29lB46cBhEc/Cq/Vt2gBzWQ1/5X6rI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AE+HDqCeDKzR2TFXxVOwopgEO4det9TLFdUMLf7a9RgRrH9mglde4uPrFzF1xThfO
         MxkRcOY2f1w7a+AQYJotslepzebufFwPt2M8GHUHe0Bmcmg9RKq2lOqmSkDsV0P2D/
         oCtmV5y4ol/5vKCM3aie1/PLftGvzZ+ZD5EscpLNscJyBHB6cjxtEnmv/ACBFaFbSt
         V5kxtVw0DM/QeO8lONbX3QScIbGy4CeTWj7pM2i6AhAMWxUFywTu/zgTvYUiWbq/Xa
         bS+piZgg63wwHRjWe45gpSGvBSi/QJOO2IHe0/gDg04DHt9oXQ1WjCqwbTQHwlmVn9
         4ro2Cu/TGL05g==
Date:   Sun, 1 Jan 2023 13:41:43 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx8mm-venice-gw7901: fix USB2 controller OC
 polarity
Message-ID: <20230101054142.GC6112@T480>
References: <20221228202606.2572716-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221228202606.2572716-1-tharvey@gateworks.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2022 at 12:26:06PM -0800, Tim Harvey wrote:
> The GW7901 has USB2 routed to a USB VBUS supply with over-current
> protection via an active-low pin. Define the OC pin polarity properly.
> 
> Fixes: 2b1649a83afc ("arm64: dts: imx: Add i.mx8mm Gateworks gw7901 dts support")
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks!
