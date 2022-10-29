Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C9D611EF9
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 03:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbiJ2BQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 21:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiJ2BPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 21:15:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08C91C9071;
        Fri, 28 Oct 2022 18:15:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A30E5B82DFA;
        Sat, 29 Oct 2022 01:15:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18489C433D6;
        Sat, 29 Oct 2022 01:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667006150;
        bh=G5DfkOYR4GEKvpQ1aCgkGIW+8LgRyBABtCSTZJPZAeU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U2QnWe2DTnTz3ta8WVtIq72nabdAL4o7okHGbi0zmiAfLniXSF9Xp+IZnwvwADb+R
         qyzHeIg0H1kRbScHfs22K1zH5ovxWYgiVetcyhl3XmgVHcXF+Vbef5qEglI4c+sCZU
         ldA42qH2n+hNavq57A15lP1Acxz6sYBd0EA4wOPcnQ8w8ddZ5X8TgVnOL49LMmAzud
         ipqAYh4Zsd0y3xCM5yBGYxExevxI0NyCESXtP8AYjkHwkNf1ngVRtx+Dqgzo3IYsTp
         JcUY4F23bSdLKXvKcZ2/V4uhSTMnL28Cr7HMdc6IyittAS+guOK4RxHr/0pq7rlD+l
         I1TjKpo0jJNcw==
Date:   Sat, 29 Oct 2022 09:15:40 +0800
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
Subject: Re: [PATCH v1 2/3] arm64: dts: librem5-devkit: Make LED use PWM
Message-ID: <20221029011540.GF125525@dragon>
References: <cover.1665318256.git.agx@sigxcpu.org>
 <fac9bc2b1a7c5505d863783726a9b4110e518a8f.1665318256.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fac9bc2b1a7c5505d863783726a9b4110e518a8f.1665318256.git.agx@sigxcpu.org>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 09, 2022 at 02:26:54PM +0200, Guido Günther wrote:
> We can use PWM instead of just GPIO allowing us to control brightness.
> 
> Signed-off-by: Guido Günther <agx@sigxcpu.org>

Applied, thanks!
