Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AED16C9AD4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 07:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjC0FPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 01:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0FPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 01:15:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0837A11A
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 22:15:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86B7660ED4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 05:15:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0BEC433D2;
        Mon, 27 Mar 2023 05:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679894147;
        bh=2NL6ej2T3YPJJuKklwH5wDQkuLW04Kd19aMftfrb9dQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iF6RfIly/L83jxybhI9NWSrrAxTPU4HpqJNBhnSYJ/BCQ4oLUALeDxKK3GXw+bhM1
         PeyQYx5EBx5X3pDVgcRfPOwCi8K844onFAqn6s74PeCq6g4so9/xvGndYiR7IHGhvX
         dSN1tyO3Qo26Cxk4j6TMjCd0Yp+xO+4jEJow98WZt48tCpHHjv/2j6NNxaPXwY5F73
         tcUHCfsIhJSFmSDi5/LieDFdPwQV3+9Q3oUgAgthv0o65V3h1pAMjydjqAusALtday
         wZff/n7NuAYHBXnLjayiuRamzxuqpquxLDaC9UNa+Zd7J5i+0WekZksjqw7UGdQfb+
         nDZ6+Y98/fLLw==
Date:   Mon, 27 Mar 2023 13:15:21 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx8dxl: drop clocks from scu clock
 controller
Message-ID: <20230327051521.GP3364759@dragon>
References: <20230323111951.102620-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323111951.102620-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2023 at 07:19:51PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The clocks and clock-names are not documented and not used, drop them.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks!
