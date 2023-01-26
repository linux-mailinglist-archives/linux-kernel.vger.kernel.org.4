Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9660767C9D5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 12:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236961AbjAZL0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 06:26:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjAZLZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 06:25:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B882762250
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 03:25:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 545926179F
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:25:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FDC4C433EF;
        Thu, 26 Jan 2023 11:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674732357;
        bh=JoabR+++RxhrcCHB0mJ50geN70BYH09P7RyfL/rYQHw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iMVhCZaAVu/O1DdJn9Fy2mLp5eHt3sWQwLNJg1DN8TnVhQ86WtiORPafAUE6+8hxQ
         q6lXVIAd5GhMTitWwRe7ZvhztZMjO2yY/3UX/j+6g7m3+cyu5sZeP4TZw4vCo4v9IX
         mgS7aV54MyXRTkJUAUdj9pMvv5vO3C7x5JOQCl4BMTilfZA/Qg1E8lg1lSYflD3y3l
         4z+WX3NHu8CLxidut13/ESc/dd3/HyL5zgTPbIghSB+rE1FErM/p+XtbQ2g7+gRnSD
         NXfgM+aEJQbfXgb+v+0XWyiAgs/n9ytnsR3lCJx5AlCnIy5lOL/NLPJf1dGI+5BeAB
         1EO8K0RpBg0Dg==
Date:   Thu, 26 Jan 2023 19:25:50 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Pierluigi Passaro <pierluigi.p@variscite.com>
Cc:     linux@armlinux.org.uk, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        eran.m@variscite.com, nate.d@variscite.com,
        francesco.f@variscite.com, pierluigi.passaro@gmail.com
Subject: Re: [PATCH] ARM: imx: mach-imx6ul: add imx6ulz support
Message-ID: <20230126112549.GG20713@T480>
References: <20230121145242.6969-1-pierluigi.p@variscite.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230121145242.6969-1-pierluigi.p@variscite.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2023 at 03:52:42PM +0100, Pierluigi Passaro wrote:
> imx6ulz is derived SoC from imx6ull.
> Currently, the boards based on imx6ulz are correctly recognized only if
> the compatible includes "fsl,imx6ull", while "fsl,imx6ulz" is ignored.
> 
> Signed-off-by: Pierluigi Passaro <pierluigi.p@variscite.com>

Applied, thanks!
