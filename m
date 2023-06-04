Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D1A721706
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 14:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbjFDMle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 08:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjFDMlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 08:41:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774F7B8;
        Sun,  4 Jun 2023 05:41:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C22961793;
        Sun,  4 Jun 2023 12:41:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF9AC433D2;
        Sun,  4 Jun 2023 12:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685882490;
        bh=c3zQhXlEbenAsUWsWRIn4i4KxdSSZNpYHV7hoFF7MNM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LzVIdGldIKFkbEzym4Yw2LY8+HrtjxA3wFft1bNG8yIoq6RJB2gez6uA9Xmue4UaJ
         4f2hqiOTvhHbRlmA4BxEFZvnFICtjXKPqmZLtbAYgwHM+1WukHv3ngyBTXOPZeWGT3
         KYA/hGKuYHfZUnaYVnTEICut2b2Wflz7V0EWCTtb1sBHUEnrL32Rs1o5eiIZTi9H8d
         l+vuVJh1JxXX7IPRIQ7JP0BT22QzNO5pJkJOuyEatpliDeptt17DLAy2gkh0HoW/VY
         ynjA7Qe402WX5qQBiooebTPp61Fgc04XmTacFC+nsrXEiSZ2/iTPHuIMt9/Jdfujza
         ++6ESEO7eBtzw==
Date:   Sun, 4 Jun 2023 20:41:19 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] arm64: dts: imx8mp-msc-sm2s: Add sound card
Message-ID: <20230604124119.GK4199@dragon>
References: <20230529095728.83993-1-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529095728.83993-1-luca.ceresoli@bootlin.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 11:57:28AM +0200, Luca Ceresoli wrote:
> The MSC SM2-MB-EP1 carrier board for the SM2S-IMX8PLUS SMARC module has an
> NXP SGTL5000 audio codec connected to I2S-0 (sai2).
> 
> This requires to:
> 
>  * add the power supplies (always on)
>  * enable sai2 with pinmuxes
>  * reparent the CLKOUT1 clock that feeds the codec SYS_MCLK to
>    IMX8MP_CLK_24M in order it to generate an accurate 24 MHz rate
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Applied, thanks!
