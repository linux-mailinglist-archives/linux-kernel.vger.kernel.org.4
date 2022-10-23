Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8923B609341
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 15:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiJWNJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 09:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiJWNJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 09:09:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E2D6FA24;
        Sun, 23 Oct 2022 06:09:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C559C60E14;
        Sun, 23 Oct 2022 13:09:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4A5C433C1;
        Sun, 23 Oct 2022 13:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666530552;
        bh=n1oyFE1/y4FaMt4hNDhYCm6OT6xQZKVnwG2w8UcMBkE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LLyle91TEBa86piVt43HACWBUafC9i5QSSebMpv1FTMw8W/Hb3ZvzRop8RlcybGC4
         V5ZliGnzT1ORcvUdZdvojXcFb0eXbRkYVEY/6CLwUGRJy5vWqF7UtnQtYw80b7JYxs
         yW+Eyl/kGw9qrMnT/fhqGr0R3jQR16/+OhWnGsv26TnmYl079N76Z3yvuyuyhePQp3
         mdUum0Kb0Kca9BcVbcAtL1z9lfr4vyM0IayFgi6t5UkaMzypPJMPhE+PeucMXY1Zl3
         z/kpU73hTLy12UhjQbm7EA5IrLg5oA3JsTpA+NPUV3hmVMH3Z/1h/RVB1U7WhC9do1
         z0L1zvtgLax7g==
Date:   Sun, 23 Oct 2022 21:09:04 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/8] arm64: dts: verdin-imx8mm: verdin-imx8mp: improve
 include notation
Message-ID: <20221023130904.GJ125525@dragon>
References: <20220922162925.2368577-1-marcel@ziswiler.com>
 <20220922162925.2368577-3-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922162925.2368577-3-marcel@ziswiler.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 06:29:19PM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Improve include notation. Usually only dtsi files from the same location
> are included with an absolute path in quotes. Others should use a
> relative path enclosed in angle brackets.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Applied, thanks!
