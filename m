Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB80960935E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 15:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiJWNLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 09:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiJWNLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 09:11:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765844CA16;
        Sun, 23 Oct 2022 06:10:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 321C8B80BFF;
        Sun, 23 Oct 2022 13:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C6BC433C1;
        Sun, 23 Oct 2022 13:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666530630;
        bh=AQMiTU+StuRXMixrJ3ZVPdXLCXLIubgy4o+L7HDJn48=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qj92iXA63qVGoRC/rPvdoPPBy7Eag/9ZfwtY2in+5LhAmaIdXbeJpXazPgeSygPuq
         DYdksuEkTxVj/Qwfb/MOzP+VWqxzrGRvakqA6u4cqcCFUCRjSSai4AeWG/duIH37ug
         JZ6+nheU39TBI01TBnBEZI7/7PYjVapkdSsnKSYtxvx3LN86M/l20AC2K9tc+blVUJ
         e/sfpFZvF0zhIen/Ln2VBxJGGZNIjP40F6nFA33AZIycoRtCckTDyPjpkvDF5POOqb
         h14CVcQsEiGGI8XiKLq9Ja2rEk6Yjf5spQ/gnbzE5Uv2Z68m5VHaZCCgHd3f15pMw/
         MbB22yMOrneJQ==
Date:   Sun, 23 Oct 2022 21:10:22 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/8] arm64: dts: verdin-imx8mm: verdin-imx8mp: rename
 sn65dsi83 to sn65dsi84
Message-ID: <20221023131022.GL125525@dragon>
References: <20220922162925.2368577-1-marcel@ziswiler.com>
 <20220922162925.2368577-5-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922162925.2368577-5-marcel@ziswiler.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 06:29:21PM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Rename sn65dsi83 to sn65dsi84 as that is the exact chip used on the
> Verdin DSI to LVDS Adapter.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Applied, thanks!
