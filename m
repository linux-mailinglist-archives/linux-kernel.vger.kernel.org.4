Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870EE613363
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 11:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbiJaKNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 06:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbiJaKNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 06:13:43 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7772D125;
        Mon, 31 Oct 2022 03:13:41 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 3C5EA80CD;
        Mon, 31 Oct 2022 10:04:12 +0000 (UTC)
Date:   Mon, 31 Oct 2022 12:13:39 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>, tomba@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        merlijn@wizzup.org
Subject: Re: [PATCH 3/3] drm: omapdrm: Do no allocate non-scanout GEMs
 through DMM/TILER
Message-ID: <Y1+f0zG50ZR4aWGX@atomide.com>
References: <1642587791-13222-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1642587791-13222-4-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <4B3F8E50-3472-4AED-9A77-3E265DF8C928@goldelico.com>
 <0000784a-ae89-1081-0ec7-fc77d3381545@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0000784a-ae89-1081-0ec7-fc77d3381545@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com> [221031 06:55]:
> On 31.10.22 г. 0:08 ч., H. Nikolaus Schaller wrote:
> > [   39.419846] WARNING: CPU: 0 PID: 3673 at drivers/bus/omap_l3_noc.c:139 l3_interrupt_handler+0x23c/0x330
> > [   39.429914] 44000000.l3-noc:L3 Custom Error: MASTER MPU TARGET GPMC (Idle): Data Access in Supervisor mode during Functional access
> > ...
> > 
> 
> I have no idea what that error is supposed to mean. @Tony?

The error above is GPMC related. It means GPMC is not properly clocked or powered
while trying to access it's IO range.

Maybe DSS is somehow trying to access GPMC address space registers with DMA? The
GPMC address space starts at 0. Maybe the DSS DMA address is 0 somwhere?

Regards,

Tony
