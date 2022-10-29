Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CE6611EFF
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 03:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiJ2BS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 21:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiJ2BSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 21:18:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C040B20FB09;
        Fri, 28 Oct 2022 18:18:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AA6762976;
        Sat, 29 Oct 2022 01:18:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307D0C433B5;
        Sat, 29 Oct 2022 01:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667006330;
        bh=/2Wc5OD2XyLapd2X9sypJNrvSP9/MDQPgKJDh6cmt4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uZU700ClSKx8vyyx0hwxnB66BGCZoqFeSLwpoHV03ZeESVdjpjGHSn+ok3GTXpkf9
         42J0jk/0QmoU4AVxUgyHav1d9pQDqdpz7EH/nk9lZ23mTXx2ovbHMGSaX2hO5toSKV
         Wtoh8WfBwyJ8nvozDkgMl47lpKgIaRSuEIm6wYQh8p+n8ab2x5aofw5BLb+MUhIs34
         m5NOWxqefGBWDBNA/VeUQ3s79WM+2NROAeEnx16GuC47rIToBHuW0HfcsgKkdXop6L
         FnjwVs99ZgqUbYutDmVogUWLGwA4ZB8zfsAoB2soHcshQPtnHbJd4Mp1EAeVWLFFjz
         dd/FPUFqfLcSg==
Date:   Sat, 29 Oct 2022 09:18:41 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Vinod Koul <vkoul@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        phone-devel@vger.kernel.org, kernel@puri.sm
Subject: Re: [PATCH v1 3/3] arm64: dts: librem5-devkit: Use function and
 color rather than label
Message-ID: <20221029011841.GG125525@dragon>
References: <cover.1665318256.git.agx@sigxcpu.org>
 <2d249e5fbb3a77a6ca8eb6ecbbf97ac8ce3ef371.1665318256.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d249e5fbb3a77a6ca8eb6ecbbf97ac8ce3ef371.1665318256.git.agx@sigxcpu.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 09, 2022 at 02:26:55PM +0200, Guido Günther wrote:
> Use predefined colors and function rather than making up a random label.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>

Applied, thanks!
