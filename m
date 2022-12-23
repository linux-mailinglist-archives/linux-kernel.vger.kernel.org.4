Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14F1654E73
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 10:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236016AbiLWJer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 04:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiLWJen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 04:34:43 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CDEA140C4;
        Fri, 23 Dec 2022 01:34:42 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1p8eRs-0003Qe-00; Fri, 23 Dec 2022 10:34:40 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 2DC68C254F; Fri, 23 Dec 2022 10:34:31 +0100 (CET)
Date:   Fri, 23 Dec 2022 10:34:31 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     torvalds@linux-foundation.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] MIPS fixes for v6.2
Message-ID: <20221223093431.GA4961@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 4c587a982603d7e7e751b4925809a1512099a690:

  MIPS: OCTEON: warn only once if deprecated link status is being used (2022-12-09 23:37:46 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips_6.2_1

for you to fetch changes up to 24b333a866a10d4be47b9968b9c05a3e9f326ff5:

  MIPS: dts: bcm63268: Add missing properties to the TWD node (2022-12-21 10:46:10 +0100)

----------------------------------------------------------------
Fixes due to DT changes

----------------------------------------------------------------
Florian Fainelli (1):
      MIPS: dts: bcm63268: Add missing properties to the TWD node

Sergio Paracuellos (1):
      MIPS: ralink: mt7621: avoid to init common ralink reset controller

 arch/mips/boot/dts/brcm/bcm63268.dtsi | 2 ++
 arch/mips/ralink/of.c                 | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
