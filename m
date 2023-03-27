Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D166C996C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 03:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjC0Bxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 21:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjC0Bxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 21:53:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31A955B8
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 18:53:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F91760F91
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:53:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D809C433EF;
        Mon, 27 Mar 2023 01:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679882021;
        bh=4upYYzM6YBGbNm2pxz5vkbMZGWLCj58bWA01y4LnSZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ys44L3My8aBiO80AY0ihHBt6EaXB7hVn4yEMbSCiAhDA3axwiKPlhbfDqjGgzVDUQ
         LkOdlmEN8VrrtRf4V05z5xD1hVC+qgbJdE3Ush6mraJpJcfXWwOjHr5OsuWLOQIKd7
         BteGVcQSE4eImHxrj7t/dHG66yNOCmzDyfoQiCEUMPfKa4RBrV3ExdbOqbYpLee5cN
         iN4W6FyXMClSpiiHCmAy73Yv6eKoysBQorkffu3WIqLQFtPAsy9BJ+vu0ruP5GYlQs
         07ubQIRTQ0bU9mVzp99Dq+jwreP4g4Vo2+rKpREwp4SZ5GtVvOH/ooXp/T70JmwRwF
         rwNW0QGt1wAOA==
Date:   Mon, 27 Mar 2023 09:53:34 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] soc: imx: imx8m-blk-ctrl: reordering the fields
Message-ID: <20230327015334.GB3364759@dragon>
References: <20230313004903.1997375-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313004903.1997375-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 08:49:03AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The clang-analyzer reports:
> "Excessive padding in 'struct imx8m_blk_ctrl_domain_data'
> (12 padding bytes, where 4 is optimal). Optimal fields order: name,
> clk_names, path_names, gpc_name, num_clks, num_paths, rst_mask, clk_mask,
> mipi_phy_rst_mask, consider reordering the fields or adding explicit
> padding members [clang-analyzer-optin.performance.Padding]
>    struct imx8m_blk_ctrl_domain_data {"
> 
> So reordering the fields.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks!
