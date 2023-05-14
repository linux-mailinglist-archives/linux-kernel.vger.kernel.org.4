Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FEF701D7E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 14:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233804AbjENMzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 08:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbjENMzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 08:55:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998D62D65;
        Sun, 14 May 2023 05:55:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36F4C60B62;
        Sun, 14 May 2023 12:55:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 696FFC433D2;
        Sun, 14 May 2023 12:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684068929;
        bh=zyrVl49gatbpdoyxUqY9Op5aqtBdGQ/MqV19IVBst3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cb7T+VVlg6XH+XL3dOxyGQzTpXpeKujMc8FF/uAEp/STS05L6xPay96qAkTYU1CaP
         gz8bGBCngVQTIy3hEweJ4QgqgOSddr6XAUJ1GfX6sH6Gd4Uyg2EAcQyw1FDUiS4+Iv
         b5NI+SvD8BECmUu31yb7wbNFKIVg/uYdzY6Uas4KKUHT2JS8cV44yZsXeEOJ5hrygG
         awz698aa+PlMEGNwmIY5pdRglTsZ2VfbHo2Fjvj2YTdoLD31Bo27kC1MBa8665iLFd
         Py8z3rObvulPrAaKcT7iqW7Wh1QGpm5olVyOCbKV5HAzFf3qtgnxUVLmwK7TIS7tLN
         z0CaKWpjmniBQ==
Date:   Sun, 14 May 2023 20:55:11 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: imx8mn-var-som: add SOM EEPROM
Message-ID: <20230514125511.GT727834@dragon>
References: <20230501170250.2960997-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230501170250.2960997-1-hugo@hugovil.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2023 at 01:02:50PM -0400, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> The 4Kbit EEPROM located on the SOM contains hardware configuration
> options, manufacturing infos and ethernet MAC address.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Applied, thanks!
