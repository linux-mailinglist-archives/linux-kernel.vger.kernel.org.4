Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0897134F1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 15:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjE0NU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 09:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjE0NU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 09:20:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D49A6;
        Sat, 27 May 2023 06:20:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 137B56123A;
        Sat, 27 May 2023 13:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28594C433EF;
        Sat, 27 May 2023 13:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685193625;
        bh=mM2xTR+09PSynb9NopjB/TNGUqHvXwrqo39ZZjAIock=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kAT270zoNyle+BweOrvXhLgkDRVc9aodShD9aKdBZlDqhcu3cCDHbQPPk5AMbNKEs
         VY5GuwIRQl/wZ/IFSdtjd7f/uTkzqHls/XwcSmT8ZLEx+TWP4tiHPAgm/IjLu+Cdob
         Pg5pOgWzsjE9eEzCNyxic3MTA0y65GRFQ7qDvnhg6nQsYQmP4iI8BkSV0yGu8ZA2oo
         xO0oSyKWBsJjzzmEPwG5JOn85lKg378h811MbhX+eyU6A4Bt7ZX4BdrBQ/r8Aafbkf
         ElTjph0cPKpf09Fst+uqfXiV5msFj3WZ9n6kMy8GlvrPT1/fQxtsSxeBNoDfHfN0zw
         AJtmZCrS4lDoA==
Date:   Sat, 27 May 2023 21:20:12 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     wei.fang@nxp.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx93: add fsl,stop-mode property to support
 WOL
Message-ID: <20230527132012.GC560301@dragon>
References: <20230525080825.513707-1-wei.fang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525080825.513707-1-wei.fang@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 04:08:25PM +0800, wei.fang@nxp.com wrote:
> From: Wei Fang <wei.fang@nxp.com>
> 
> Add fsl,stop-mode property for FEC to support Wake-on-LAN (WOL)
> feature. Otherwise, the WOL feature of FEC does not work.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Applied, thanks!
