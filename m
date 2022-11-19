Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645D2630AFD
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 04:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbiKSDMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 22:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiKSDMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 22:12:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AB184307
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 19:12:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A14BE60B35
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 03:12:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45FDC433C1;
        Sat, 19 Nov 2022 03:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668827570;
        bh=9u7FFkbLCU0GIxmHoZiZUFQJt4L4M9Ggm2TVHNstRyw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PN4wt5Q91TGT8V4DqaaJRk/Q8V8euCUWfZXehf4qflVXVVLuT7fcpRLLtVP4YmLjP
         vGGpREDVtFiRCuOcyij5TxCv2mGuZY0X/UMO6xs2k3YOF05Xqy2TzbZM/3HPF73L0Q
         LrHRkCihLhlmR9w27ig2t9JKG4D2OYeX/PTp1rOVbKaEYUigJA5j0N2tuzr6k6VhKL
         F8vcGIgUH9cxVlj06U/7HsDNpxrobLzxavmfULxnwvlZ72hgOVqv9SLcR8pKRkBXdk
         rUmCh7VxcGq2Dyl614iWmeaPdCOQpA1r4UTWE8OlbDMxNV4yrhKtoK3QUOiiOMXi+y
         9EZUhOqS+H1nw==
Date:   Sat, 19 Nov 2022 11:12:42 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Adrian Alonso <adrian.alonso@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH V6 12/12] arm64: dts: imx8mm-evk: add vcc supply for
 pca6416
Message-ID: <20221119031241.GM16229@T480>
References: <20221117095403.1876071-1-peng.fan@oss.nxp.com>
 <20221117095403.1876071-13-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117095403.1876071-13-peng.fan@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 05:54:03PM +0800, Peng Fan (OSS) wrote:
> From: Adrian Alonso <adrian.alonso@nxp.com>
> 
> pca6146 requires vcc-supply to work on i.MX8MM-EVK board.
> 
> Reviewed-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Adrian Alonso <adrian.alonso@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

Applied, thanks!
