Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57EE269EF98
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 08:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbjBVHwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 02:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBVHwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 02:52:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 182DE34C35
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 23:52:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99F7461233
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 07:52:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07B6C433EF;
        Wed, 22 Feb 2023 07:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677052332;
        bh=Q6MpegLZ7hvRsEJn9E5XiR3pk6kDq97l8mmk1IxS4jw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZL/mY3v0VrgfRh/fc8Gd4q6ik5wCwKGEMMRTE6NsX/lanXF93MtDLcOfe3VgyMKyt
         sFcMQQz1Aw90mRQq6hOFmeVgg/kAXGhILS39FOMmy2PoxyyAmBO8prKpKQOH2X6+Hj
         PDd4tCZx619r45mlac19eRpd9AsCU8sg+l8yqRFfLY3UO+C6ZBxrc17atssSDH/r2C
         ZbY2NtN1TZmSUvLjrgbp8ncirFL046t403RuhxvaN8WWk5w9RyX5fNcQv3q0bkEthP
         RZpAkuuRIaSc7aIppUhsiM5ZjZ8Gj3FzKdN1KFdnFrB5aeKguzS6kioCK1r5eNDq/U
         J7S8+9DWq7IvA==
Received: by pali.im (Postfix)
        id 6C79172C; Wed, 22 Feb 2023 08:52:08 +0100 (CET)
Date:   Wed, 22 Feb 2023 08:52:08 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Scott Wood <oss@buserror.net>, Sinan Akman <sinan@writeme.com>,
        Martin Kennedy <hurricos@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/8] powerpc/85xx: p2020: Create one unified machine
 description
Message-ID: <20230222075208.y2nxqttaxfwsd4ye@pali>
References: <20230218111405.27688-1-pali@kernel.org>
 <20230221220714.pm64kwsnf3erdjcm@pali>
 <a692823b-eada-3072-c9e9-83877480454f@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a692823b-eada-3072-c9e9-83877480454f@csgroup.eu>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 22 February 2023 06:39:07 Christophe Leroy wrote:
> Hi,
> 
> Le 21/02/2023 à 23:07, Pali Rohár a écrit :
> > Hello Christophe! Could you look at this v3 series?
> > I addressed those small issues and hopefully it should be ready.
> > It would be great to have this finally in v6.3 release.
> 
> I started looking at your series and I will try to provide a feedback 
> within a few days.
> 
> By the way I see that Paul Gortmaker has started removal of several 85xx 
> boards. Should we first take Paul's removal series then see what remains 
> before applying yours ? That would make your series even more efficient.

I have already replied to Paul patch series. The important thing is that
we are touching different files, so patch series should be independent.

> Christoph
> 
> > 
> > On Saturday 18 February 2023 12:13:57 Pali Rohár wrote:
> >> This patch series unifies all P2020 boards and machine descriptions into
> >> one generic unified P2020 machine description. With this generic machine
> >> description, kernel can boot on any P2020-based board with correct DTS
> >> file.
> >>
> >> Tested on CZ.NIC Turris 1.1 board with has Freescale P2020 processor.
> >> Kernel during booting correctly detects P2020 and prints:
> >> [    0.000000] Using Freescale P2020 machine description
> >>
> >> Changes in v3:
> >> * Use 'if (IS_ENABLED(CONFIG_PPC_I8259))' instead of '#ifdef CONFIG_PPC_I8259'
> >> * Simplify p2020_probe()
> >> * Patches generated by -M and -C git options
> >>
> >> Link to v2: https://lore.kernel.org/linuxppc-dev/20221224211425.14983-1-pali@kernel.org/
> >>
> >> Changes in v2:
> >> * Added patch "p2020: Move i8259 code into own function" (separated from the next one)
> >> * Renamed CONFIG_P2020 to CONFIG_PPC_P2020
> >> * Fixed descriptions
> >>
> >> Link to v1: https://lore.kernel.org/linuxppc-dev/20220819191557.28116-1-pali@kernel.org/
> >>
> >> Pali Rohár (8):
> >>    powerpc/85xx: Mark mpc85xx_rdb_pic_init() as static
> >>    powerpc/85xx: Mark mpc85xx_ds_pic_init() as static
> >>    powerpc/85xx: p2020: Move all P2020 machine descriptions to p2020.c
> >>    powerpc/85xx: p2020: Move i8259 code into own function
> >>    powerpc/85xx: p2020: Unify .setup_arch and .init_IRQ callbacks
> >>    powerpc/85xx: p2020: Define just one machine description
> >>    powerpc/85xx: p2020: Enable boards by new config option
> >>      CONFIG_PPC_P2020
> >>    powerpc: dts: turris1x.dts: Remove "fsl,P2020RDB-PC" compatible string
> >>
> >>   arch/powerpc/boot/dts/turris1x.dts            |   2 +-
> >>   arch/powerpc/platforms/85xx/Kconfig           |  22 ++-
> >>   arch/powerpc/platforms/85xx/Makefile          |   1 +
> >>   arch/powerpc/platforms/85xx/mpc85xx_ds.c      |  25 +---
> >>   arch/powerpc/platforms/85xx/mpc85xx_rdb.c     |  46 +-----
> >>   .../platforms/85xx/{mpc85xx_ds.c => p2020.c}  | 135 ++++++------------
> >>   6 files changed, 68 insertions(+), 163 deletions(-)
> >>   copy arch/powerpc/platforms/85xx/{mpc85xx_ds.c => p2020.c} (52%)
> >>
> >> -- 
> >> 2.20.1
> >>
