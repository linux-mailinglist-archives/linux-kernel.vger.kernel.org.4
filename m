Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3034B6D19EB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 10:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjCaIdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 04:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjCaIdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 04:33:45 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8789C2129;
        Fri, 31 Mar 2023 01:33:43 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1piACX-0003qa-00; Fri, 31 Mar 2023 10:33:37 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id C5446C1ED0; Fri, 31 Mar 2023 10:33:30 +0200 (CEST)
Date:   Fri, 31 Mar 2023 10:33:30 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     torvalds@linux-foundation.org
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] MIPS fixes for v6.3
Message-ID: <20230331083330.GA6643@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.7 required=5.0 tests=RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit eeac8ede17557680855031c6f305ece2378af326:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes_6.3_1

for you to fetch changes up to ab327f8acdf8d06601fbf058859a539a9422afff:

  mips: bmips: BCM6358: disable RAC flush for TP1 (2023-03-18 14:36:06 +0100)

----------------------------------------------------------------
Fix to avoid crash on BCM6358 platforms

----------------------------------------------------------------
Álvaro Fernández Rojas (1):
      mips: bmips: BCM6358: disable RAC flush for TP1

 arch/mips/bmips/dma.c   | 5 +++++
 arch/mips/bmips/setup.c | 8 ++++++++
 2 files changed, 13 insertions(+)

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
