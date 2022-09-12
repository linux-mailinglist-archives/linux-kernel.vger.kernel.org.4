Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5735B57B5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiILKAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiILKAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:00:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A178512D3A
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 03:00:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64BBFB80CB6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 10:00:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDF7C433D6;
        Mon, 12 Sep 2022 10:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662976803;
        bh=ugQagfvsp+qZUJ76KrnJT+JGU0a1DjAZxSAn1VpurfI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pYbHxPHDEFuoZ0rjph4+v4ElRkOskSydsBmKhiw+4R0UYvo0h48oqedJAfU97Unyk
         43PyuzNwKgCLVntg4jbs6d/h76RAh4kskmg5GxnPUgpft1neNL0dKxR7W9k1eE9wDW
         xvzyIk/GxhGu923Mt2/uXjXi9Z1Ac18C9oT9wSz1E+luGBq5C2QItHjpYG3E4K8u5m
         hg64+oo6s98KwdCc9SJG+U4M97S/+evtNjEyiYV9qgh8bsp+x/+2PR6j2NwrYO9ssr
         8VMnVig3sr7OycFBvMIn/UryZFgzdZ9IDLfLsxenY3rMyPyOmCcqRsMQlhR8ADsVOP
         wMboVR1ewImeA==
Date:   Mon, 12 Sep 2022 17:59:56 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, l.stach@pengutronix.de, aford173@gmail.com,
        laurent.pinchart@ideasonboard.com, m.felsch@pengutronix.de,
        marex@denx.de, paul.elder@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] soc: imx: imx8m-blk-ctrl: Use genpd_xlate_onecell
Message-ID: <20220912095956.GX1728671@dragon>
References: <20220906033943.2184844-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906033943.2184844-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 11:39:43AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Simplify driver by using genpd_xlate_onecell instead of
> driver specific xlate function.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks!
