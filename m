Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57AE678741
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232984AbjAWUJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjAWUJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:09:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D2D7A9C
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 12:09:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7922FB80DE1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 20:09:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078FDC4339B;
        Mon, 23 Jan 2023 20:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674504566;
        bh=If0sFz25p6CYDx2nh3Dqk80gAUpAtfBAbUC6NI2O118=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h52U9TKXbtKOhYFOTbEEIPdNQQV1L2z4m7iqqQMV4mfdcE4Dhev4c1g8e0bz2DGoy
         5jBM+eM971XkFrC7xKhIuRP5zTwvd4AB/nKHGWDbm+C5+WCyrFSlsrnx00cgoYXPLX
         kHlnMv9NMJ1D6LBHZWgQO4gSbIKiXiypggqF4n6lG5qTOPUwzpyu1aT9HK++n6yauh
         l4T533cyVVX1HaNvCP7TWrm+1AiUVhubsVWdr1N9TVJDe/RDyjPpZq1c0wRPuRaeJs
         eTp41BUSYq/VOPjSEHi11uHCP1yzzSTWRekWn/QLJKiMBjUNchtce5dQaj9GW5ReEF
         ACltEd3Lgb3nw==
Received: by pali.im (Postfix)
        id 1BFAE7FA; Mon, 23 Jan 2023 21:09:23 +0100 (CET)
Date:   Mon, 23 Jan 2023 21:09:22 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Scott Wood <oss@buserror.net>, Sinan Akman <sinan@writeme.com>,
        Martin Kennedy <hurricos@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/8] powerpc/85xx: p2020: Create one unified machine
 description
Message-ID: <20230123200922.scnwgne3dsip24lg@pali>
References: <20221224211425.14983-1-pali@kernel.org>
 <20230122111631.dgw5uwtfjsqack57@pali>
 <22db0b5a-1b7f-a94b-1092-a314d57dedf5@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22db0b5a-1b7f-a94b-1092-a314d57dedf5@csgroup.eu>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 23 January 2023 14:32:36 Christophe Leroy wrote:
> Le 22/01/2023 à 12:16, Pali Rohár a écrit :
> > Hello! Do you have any comments for this patch series?
> 
> 
> I think patches 1 and 2 could be a single patch.

Well, if you want to have them in single patch, it could be easily
squashed during applying. I thought that it is better to have them
separated because of different boards, files, etc...:
https://lore.kernel.org/linuxppc-dev/5bf1f2fc-a1de-d873-7d1b-0058ff8b9aa2@csgroup.eu/

> I'm having hard time understanding how things are built. Patch 3 
> introduces 273 lines of new code in a file named p2020.c while only 
> removing 23 lines and 44 lines from mpc85xx_{ds/rdb}.c.

In v1 I generated that patch with git -M, -C and other options which
detects copy and renames. But I had an impression that it is less readable:
https://lore.kernel.org/linuxppc-dev/20220819191557.28116-4-pali@kernel.org/

So I tried to describe all changes in commit message and generated that
patch without copy options (so it is plain patch with add lines).

This patch moves all p2020 boards from mpc85xx_rdb.c and mpc85xx_ds.c
files into new p2020.c file, and plus it copies all helper functions
which p2020 boards requires. This patch does not introduce any new code
or functional change. It should be really plain copy/move.

> Then patches 4, 
> 5 and 6 exclusively modify p2020.c which was a completely new file added 
> by patch 3.

In later patches is then that moved/copied code improved and cleaned.

> Why not making it correct from the beginning, that is merge 
> patches 4, 5 and 6 in patch 3 ?

I wanted to separate logical changes into separate commits. So first
just moves/copy code (which should be noop) and then do functional
changes in followup patches. I like this progress because for me it is
easier for reviewing. Important parts are functional changes, which are
in separated commits and it is visually separated from boring move/copy
code changes.

> Or maybe p2020.c is not really new but is a copy of some previously 
> existing code ? In that case it would be better to make it explicit, for 
> history.

Yes. Do you have any suggestion how to make it _more_ explicit? I tried
to explain it in commit message (but I'm not sure if it is enough). And
when viewing via git show, it is needed to call it with additional -M
and -C options to see this. git does not do it automatically.

> 
> Christophe
> 
> 
> > 
> > On Saturday 24 December 2022 22:14:17 Pali Rohár wrote:
> >> This patch series unifies all P2020 boards and machine descriptions into
> >> one generic unified P2020 machine description. With this generic machine
> >> description, kernel can boot on any P2020-based board with correct DTS
> >> file.
> >>
> >> Tested on CZ.NIC Turris 1.1 board with has Freescale P2020 processor.
> >> Kernel during booting correctly detects P2020 and prints:
> >> [    0.000000] Using Freescale P2020 machine description
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
> >>   arch/powerpc/boot/dts/turris1x.dts        |   2 +-
> >>   arch/powerpc/platforms/85xx/Kconfig       |  22 ++-
> >>   arch/powerpc/platforms/85xx/Makefile      |   1 +
> >>   arch/powerpc/platforms/85xx/mpc85xx_ds.c  |  25 +--
> >>   arch/powerpc/platforms/85xx/mpc85xx_rdb.c |  46 +-----
> >>   arch/powerpc/platforms/85xx/p2020.c       | 193 ++++++++++++++++++++++
> >>   6 files changed, 215 insertions(+), 74 deletions(-)
> >>   create mode 100644 arch/powerpc/platforms/85xx/p2020.c
> >>
> >> -- 
> >> 2.20.1
> >>
