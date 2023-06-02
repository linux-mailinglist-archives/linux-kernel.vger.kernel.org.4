Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEBCE71FDF5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbjFBJeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234455AbjFBJeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:34:07 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A7E6CCE;
        Fri,  2 Jun 2023 02:34:06 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 9D5DE8111;
        Fri,  2 Jun 2023 09:34:05 +0000 (UTC)
Date:   Fri, 2 Jun 2023 12:34:04 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Franziska Naepelt <franziska.naepelt@googlemail.com>
Cc:     linux-omap@vger.kernel.org, paul@pwsan.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Franziska Naepelt <franziska.naepelt@gmail.com>
Subject: Re: [PATCH] ARM: omap2: Fix checkpatch issues
Message-ID: <20230602093404.GQ14287@atomide.com>
References: <20230531170427.42199-1-franziska.naepelt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531170427.42199-1-franziska.naepelt@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Franziska Naepelt <franziska.naepelt@googlemail.com> [230531 20:04]:
> The following checkpatch issues have been resolved:
> 
> arch/arm/mach-omap2/omap-wakeupgen.c
> WARNING: Missing a blank line after declarations
> 
> arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
> ERROR: space prohibited before that ',' (ctx:WxE)
> WARNING: Use lore.kernel.org archive links when possible
> 
> arch/arm/mach-omap2/omap_phy_internal.c
> WARNING: Block comments should align the * on each line
> 
> arch/arm/mach-omap2/sdrc2xxx.c
> WARNING: It's generally not useful to have the filename in the file
> 
> arch/arm/mach-omap2/ti81xx-restart.c
> ERROR: trailing statements should be on next line

Thanks applying into omap-for-v6.5/cleanup.

Tony
