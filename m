Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FDF5BB611
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 06:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiIQEXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 00:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbiIQEXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 00:23:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A591A345B;
        Fri, 16 Sep 2022 21:23:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9565360CF8;
        Sat, 17 Sep 2022 04:23:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0A7C433C1;
        Sat, 17 Sep 2022 04:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663388595;
        bh=g68woSZKFuF62rUzciY5W5N09Ak5gQyrGTNNyviddFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tsgMyYSoe9DakxpGJw9pda1guutQZ/Lle9AmRrGavTup4LnbEwLfh3fCrKoohUiPE
         bAbsE2qqzQpK5VcZvOe7awXBQKmsU2rb3BOzqiIgcvdYLpq3qrChnWvbRYQeWiVbI+
         g8X74EBFHWGgTVeg7GHwIJZhc+wmLRR6qDy9pLAaXFIQFTpz+lIGNAk5lbeZlNZ/tf
         c00w4dbOX5HyrnYRRMnxLdbw2LDDGuF6zeLct6oV1hWCPaFPrUn+3QQ+Cu+/S/0gJ+
         efJW7qt7mBMCBgxHUPDO1hZEWFpLQudixMR48z9UVeiHZcYi7mx8nxYSsg07Au9mpA
         YSL0Bng4lCLzw==
Date:   Sat, 17 Sep 2022 12:23:09 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2] ARM: dts: imx6qdl-gw54xx: add CAN regulator
Message-ID: <20220917042309.GS1728671@dragon>
References: <20220916153107.1802079-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916153107.1802079-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 16, 2022 at 08:31:07AM -0700, Tim Harvey wrote:
> The GW54xx has a transceiver with a STBY pin connected to an IMX6 GPIO.
> Configure this as a regulator to drive it low when CAN is in use.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied, thanks!
