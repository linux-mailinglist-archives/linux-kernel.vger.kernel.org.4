Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A74630AEB
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 04:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbiKSDCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 22:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbiKSDBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 22:01:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254ADA4655
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 19:01:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7C0E6281A
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 03:01:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5D8C433C1;
        Sat, 19 Nov 2022 03:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668826883;
        bh=CuqFKxcMvNpKzKMC/PGpg11NdqA4AQSRArnNogLjUIE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XPlj4Vx+3aGvPedeYppNZfmGWfyQS7R7gBM8Ejpqfc+/bFUJae4SKMYr7rLv7VuX3
         sfMqQceRnQY2Tjfue1U2K6n0Zj0hprT42+C0lD3Pqnr53OVqfDPLevTprEHyrK+WbW
         u4rrBl/9Fw6LTwIZmOZHNzfZbcHJiC/n3V/+VoosOVFmfVszCcO7YlqcydfuYtrxzL
         DfpFnYLWfI0Uy79nZ7j9kylz83ujnilLn0+yyzJIme4GnUvRx7o5Zjnya0/KTdMcTy
         ClUqZSeiSTd+P4NQOEJhAWsF5DnkMKQdJ+Aql5SnLvFMKuiznF6uZNf/OkDw6g30VH
         Ob6MLZmXZxo5Q==
Date:   Sat, 19 Nov 2022 11:01:17 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Subject: Re: [PATCH V6 02/12] arm64: dts: imx8mp-evk: correct pcie pad
 settings
Message-ID: <20221119030117.GC16229@T480>
References: <20221117095403.1876071-1-peng.fan@oss.nxp.com>
 <20221117095403.1876071-3-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117095403.1876071-3-peng.fan@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 05:53:53PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> According to RM bit layout, BIT3 and BIT0 are reserved.
>   8  7   6   5   4   3  2 1  0
>   PE HYS PUE ODE FSEL X  DSE  X
> 
> Although function is not broken, we should not set reserved bit.
> 
> Fixes: d50650500064 ("arm64: dts: imx8mp-evk: Add PCIe support")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

Applied, thanks!
