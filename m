Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9B8609345
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 15:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiJWNJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 09:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiJWNJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 09:09:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC6C2124F;
        Sun, 23 Oct 2022 06:09:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F2190B80D4F;
        Sun, 23 Oct 2022 13:09:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D43C433C1;
        Sun, 23 Oct 2022 13:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666530586;
        bh=xUOgNHW9gzoMjPok3VMVXwFwOQukUWzJUhatMGIh2Hc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FHHYrmLpjSm8u4zw/G0IT8/Lx+igIYt2rtd7r70vR3MX/HH6F2nK5dTImKna4793d
         feSXlmEfBtUV/lQaSclR+yy2+tSY+psayErr80hJCrddpXJgNWATtfZBQsZJy21U8u
         AwxQL6sfvv8x7VWR55p0pZD5y+5L8aCUgr4MC/pcCg+5RZYO0WDYRFT3jbNyQQ/Da/
         K83vvLviD0lKFpX85FcGsMHpKUesG/CTziSUPsJto+kv0a9vwus5meqtu/Q6CxrZ6q
         bXtx5eHhLr0IdzXCU1AmSieDRAcTk+/9sI3EU+Ya9xRvEj6CD+Abx3t8K9RYFLXcVy
         M0E0WCbNyvoXw==
Date:   Sun, 23 Oct 2022 21:09:39 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 3/8] arm64: dts: colibri-imx8x: improve include
 notation
Message-ID: <20221023130939.GK125525@dragon>
References: <20220922162925.2368577-1-marcel@ziswiler.com>
 <20220922162925.2368577-4-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922162925.2368577-4-marcel@ziswiler.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 06:29:20PM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Improve include notation. Usually only dtsi files from the same location
> are included with an absolute path in quotes. Others should use a
> relative path enclosed in angle brackets.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Applied, thanks!
