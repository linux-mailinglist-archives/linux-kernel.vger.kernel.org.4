Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98386CB62D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 07:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjC1Flp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 01:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjC1Fln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 01:41:43 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BEB742D4C;
        Mon, 27 Mar 2023 22:41:27 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 004588108;
        Tue, 28 Mar 2023 05:41:27 +0000 (UTC)
Date:   Tue, 28 Mar 2023 08:41:25 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Tero Kristo <t-kristo@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm: omap2: remove obsolete config OMAP3_SDRC_AC_TIMING
Message-ID: <20230328054125.GJ7501@atomide.com>
References: <20230320083806.9545-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320083806.9545-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Lukas Bulwahn <lukas.bulwahn@gmail.com> [230320 10:38]:
> Commit d42f265a5d7a ("ARM: OMAP3: clock: remove un-used core dpll
> re-program code") removes arch/arm/mach-omap2/sram34xx.S, which
> implemented the effect of the config OMAP3_SDRC_AC_TIMING. Since then, the
> OMAP3_SDRC_AC_TIMING config was hanging around without effect.
> 
> Remove this obsolete config.

Thanks applying into omap-for-v6.4/cleanup.

Tony
