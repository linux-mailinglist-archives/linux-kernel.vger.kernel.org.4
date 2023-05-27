Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E2071340F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 12:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjE0Kjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 06:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbjE0Kjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 06:39:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9C7D8
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 03:39:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 89FAD60B81
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 10:39:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3AB2C433EF;
        Sat, 27 May 2023 10:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685183982;
        bh=E3WOLvJadGXbkoAYGWHyi2puLCmDE4Z7uFpCrOB7pro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DeBJkcrz50jLyKXg2evvDjrcZ/oG5V4V9kjRZmVQwiFOjPA3uOwxT2RBeMHp7pOYY
         0zVbPiFbDBhmBBwM1Z5Whlx2PYOimvRQI93ZppX7sD3ho6ewgvsIC/hluHoE+RdUpY
         iSwaY4DWugCf/DivOiJBqGf1E4RE79S76qs+Z2MSfq3PvJuKd/qegNWmDvngXGP0M0
         H56XFjNJLfw7qxcjkKuFcYiYeVRA81OuFJqkKLGV0Wl/Jpl7swUi8onJYYeenuZGRU
         eY+SraIaYI3w3mbBIFHDKeE2M86LhIpu/DnIyPxPjyYgEE6hArZ91pTiSZ2rka778k
         r55hW8Q5Ee/Sg==
Date:   Sat, 27 May 2023 18:39:29 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 4/5] irqchip: mxs: include linux/irqchip/mxs.h
Message-ID: <20230527103929.GK528183@dragon>
References: <20230516200516.554663-1-arnd@kernel.org>
 <20230516200516.554663-4-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516200516.554663-4-arnd@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 10:05:07PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This header contains the definition for icoll_handle_irq(), which
> is used in arch/arm/mach-mxs/mach-mxs.c, without this we get a warning
> about a missing prototype when building with W=1.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Shawn Guo <shawnguo@kernel.org>

> ---
>  drivers/irqchip/irq-mxs.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/irqchip/irq-mxs.c b/drivers/irqchip/irq-mxs.c
> index 55cb6b5a686e..b3b1fba871c1 100644
> --- a/drivers/irqchip/irq-mxs.c
> +++ b/drivers/irqchip/irq-mxs.c
> @@ -9,6 +9,7 @@
>  #include <linux/init.h>
>  #include <linux/irq.h>
>  #include <linux/irqchip.h>
> +#include <linux/irqchip/mxs.h>
>  #include <linux/irqdomain.h>
>  #include <linux/io.h>
>  #include <linux/of.h>
> -- 
> 2.39.2
> 
