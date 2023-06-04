Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6EF7216F4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 14:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjFDMdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 08:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFDMdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 08:33:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1812CA;
        Sun,  4 Jun 2023 05:33:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AC6360CF9;
        Sun,  4 Jun 2023 12:33:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16753C433EF;
        Sun,  4 Jun 2023 12:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685881983;
        bh=ZKl8AHXFpU+GegW3V/WCBn2zAiMinYPo4ep6qsk84Ew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GCMtkHsdLlodxs99cE4PLBMcRIpwlHtjBdeeMsuB/4Wl5wgxGGVY3z6fAWG/uEJMY
         mazndFF9YBK5rKxvw0NQ2lPEwm8+qK1dVqbLq9rhDKy2sRfPUa5OtSRz7BEOVWX23o
         YVfiC3FwN7jk/mElY1J7pffr7u/+Wp30t5l1BLDxabdcthoTKIXEL/UAch/Q7Ne1DJ
         fICp6MzRGUG19eXQI3mnpJ12gbnrpodMnbae3BLh+Ds5TNSYbU3z7APMyjX2E8EVQl
         J863JEw6zJ0Bwo+NQh2sQhlFxx1t8uw44A++InFJTeY4iXH4+qs+pvJ8pmTL3VyNo7
         Xcmeid3Aeebnw==
Date:   Sun, 4 Jun 2023 20:32:51 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/2] arm64: dts: imx8mn-beacon: Migrate sound card to
 simple-audio-card
Message-ID: <20230604123251.GI4199@dragon>
References: <20230528112254.2634028-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230528112254.2634028-1-aford173@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28, 2023 at 06:22:53AM -0500, Adam Ford wrote:
> Instead of using a custom glue layer connecting the wm8962 CODEC
> to the SAI3 sound-dai, migrate the sound card to simple-audio-card.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied both, thanks!
