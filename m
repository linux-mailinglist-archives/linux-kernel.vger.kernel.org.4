Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89117630AF7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 04:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbiKSDHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 22:07:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbiKSDH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 22:07:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67EF2B8FBF
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 19:07:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28DCBB82523
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 03:07:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B135C433D6;
        Sat, 19 Nov 2022 03:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668827246;
        bh=eE6fldbzjOXwdlDqQiShbtRhA7KDxRvPy6kYqvwKQVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VzpA2yHJTs+DYZ1gURC6BJBCDxpsMdWsI7ZZk6IM1nD2FFRx5fSAzMhR9BAcf7Krz
         FNWAgcOnPE6GmXF4O3NaJYUAzRcQxcP/asHsUr2LbIT6ktCY7DjOQfDbhncUZGoGtS
         5Qc4dPG32DqWLnFrNU6PQzbSC9CQou+v+Vuzud6e+u4XMfF0JMtTbYRyX433Dzf4e8
         Dkfi2PqdgucKOwRTnoRfJSznRxf5WU+ukcTrU6fg+rALxsoss5gu22e7pJT3Y7SdVr
         G1kii1cWhHkNd8Mmv+f3lck7mXd4mY8zGPdl9PoiJljvUd/m3RSUZkfs8P1FbtWTev
         Kh87ODiJvRPxw==
Date:   Sat, 19 Nov 2022 11:07:21 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V6 07/12] arm64: dts: imx8mn-evk: update vdd_soc dvs
 voltage
Message-ID: <20221119030720.GH16229@T480>
References: <20221117095403.1876071-1-peng.fan@oss.nxp.com>
 <20221117095403.1876071-8-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117095403.1876071-8-peng.fan@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 05:53:58PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Per schematic, BUCK1 is for VDD_SOC&DRAM&PU_0V9. The nxp,dvs-run-voltage
> and nxp,dvs-standby-voltage need set for BUCK1, not BUCK2.
> BUCK2 is for A53, which is handled by DVFS, so no need dvs property.
> nxp,dvs-run-voltage is not needed, since bootloader must configure
> voltage to make system boot well.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks!
