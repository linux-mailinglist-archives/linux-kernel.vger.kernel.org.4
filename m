Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77E16AB53F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 05:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjCFEBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 23:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjCFEAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 23:00:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25040F95E;
        Sun,  5 Mar 2023 20:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=HPz4kPYhPZpQlfeOL2Al6sQo7BQmMegqzbJMsm991po=; b=kx8YsC+c/ytuN48zbGnBp9LIjb
        yBCqh9LU1+Z3QYjzA2niS9adPj3dkCNPK9Ym8Od1Wr/BDHhrVVmDTWC0xkP4G4qNnSWNWP+q80HfG
        f9lcxp240fKH5Z0CiTMK2JrECS3tK7Cr20AVXhTf0JqTPDcIVXplGJyHtvltgNahJ5xiSs11FIMPv
        JgFX+62AKl2B9WxOmH3L7lLmiJWWwxADL57F961nZ5jfdby36oX0ExO1CuGi8lxT59Q9QxCoElI+8
        0IiD724fEv9Hiqae7coN1EvEDNi4U+Dd9Wsie/jb8hAAE4xo5aZb1LljZxEVolHeppY9jfwQHA8qY
        3iSISszQ==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZ21e-00B9yD-PB; Mon, 06 Mar 2023 04:00:38 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>,
        linux-sh@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/7 v4] sh: various doc, build, init fixes
Date:   Sun,  5 Mar 2023 20:00:30 -0800
Message-Id: <20230306040037.20350-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of these patches have been sent previously, anywhere from
one to 3 times.  All patches are now called "v4".

This refresh/resend is to assist the new SH maintainer.

 [PATCH 1/7 v4] sh: SH2007: drop the bad URL info
 [PATCH 2/7 v4] sh: nmi_debug: fix return value of __setup handler
 [PATCH 3/7 v4] sh: init: use OF_EARLY_FLATTREE for early init
 [PATCH 4/7 v4] sh: math-emu: fix macro redefined warning
 [PATCH 5/7 v4] sh: remove sh5/sh64 last fragments
 [PATCH 6/7 v4] sh: fix Kconfig entry for NUMA => SMP
 [PATCH 7/7 v4] sh: mcount.S: fix build error when PRINTK is not enabled

diffstat:
 Documentation/kbuild/kbuild.rst                           |    1 -
 Documentation/scheduler/sched-arch.rst                    |    2 --
 Documentation/translations/zh_CN/scheduler/sched-arch.rst |    2 --
 arch/sh/Kconfig                                           |    4 ++++
 arch/sh/Kconfig.debug                                     |    2 +-
 arch/sh/boards/Kconfig                                    |    1 -
 arch/sh/kernel/head_32.S                                  |    6 +++---
 arch/sh/kernel/nmi_debug.c                                |    4 ++--
 arch/sh/kernel/setup.c                                    |    4 ++--
 arch/sh/math-emu/sfp-util.h                               |    4 ----
 scripts/checkstack.pl                                     |    7 -------
 tools/perf/arch/common.c                                  |    2 --
 tools/scripts/Makefile.arch                               |    5 -----
 tools/testing/selftests/mm/Makefile                       |    2 +-
 tools/testing/selftests/mm/run_vmtests.sh                 |    2 +-
 15 files changed, 14 insertions(+), 34 deletions(-)

Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
Cc: linux-sh@vger.kernel.org
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: devicetree@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
