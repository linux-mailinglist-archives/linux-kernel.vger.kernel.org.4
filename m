Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3AF6F6037
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 22:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjECUi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 16:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjECUiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 16:38:24 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C434D1BFA;
        Wed,  3 May 2023 13:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1683146295; i=deller@gmx.de;
        bh=WbtO82rvqnofg6Vql73giIKq0gCF5O63zgx51A8dv+M=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=t8eFN1/soQoxV2k6EbqzLLQjTpnYT7WEvWezF9lj5DDdsjOis8gPlnk90ynu7Bmak
         X6fPMp299A7yxHNYAZpDFxCS5ONByfy+B3nYyCutK22uPKg7dk4uowxXdowbr4/ixm
         7Tu+fhL2RsPMsFLx3j7mEmGUcQDUbqG2OHY7B0fLq/1rpg8FTa/poHfs3USz0w7ZRi
         1FtsFKGIQMxFmyMPLabQOVUDABB61QUsvqWHofeAIO4hga9AcrtmFk+BNl7Tlbd95W
         9FbILiT9RkV99RBkvD+qWBvcuVD4wkOXhmJXc0D1yTiO5seZJ4aeAkirPvs18oxi5E
         BWWsJKOFBuLZw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100 ([94.134.144.191]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtOGU-1qESFs3lsM-00urGn; Wed, 03
 May 2023 22:38:14 +0200
Date:   Wed, 3 May 2023 22:38:12 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fixes for v6.4-rc1
Message-ID: <ZFLGNBvD7LbjKbu7@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:L9QAoakUzGLtfuJV6bQ+Z3SzhASXhY/jccPnTXcTJCxCTuNjA2r
 WMes8FnIqZzU07QM1Ofc6/11R8WVM4ZgJJmAxlvsgSV/trl8+eUY74f5GTwVb88+9t6kqgm
 B7UKWP1TW/FkTPCwr39Y5fjDGscblXwMVPNNn/jrITj7kxObga71mwUPkyJDEe1E0jQTfBN
 l7MfcenDFCDbXmYtn6riA==
UI-OutboundReport: notjunk:1;M01:P0:JrosATKi0uE=;Xf3ry0Cp2bNnZsUfwKWjMXujoqy
 ZLFHiRinkyOsujCljBXMPpOwtnG9X0rphfVsSP1iuqev8/+SGTq8K1P8lBEO1LN6iNc8kZf7r
 Z4apKCqyTZDYs1AOfnBC3/6yyxsz+zkUetcNfs1peOUCApYO7J3XKkSF0jCK+4F+zZ0GrZGBM
 B7Ml9PlJ8jtzJanbIQ6S6lrwy0i9FqivEjFQE/hK0SPURcMsWeg6gJgmFAzzSI0cYFIN6C514
 jwsxAGmgKOkSCiTC2BgmPMEQvw65OnKcU0OevB4GeeONAbwGaxVQDNDW9Auxr8rLiuuDWUSwC
 eRORKaV4E7dAeHDMGFyvEK8NvhPsV7D6c3g/0G6S/PUsPcEk7+PXFsmIxconlVCWeYE99IsJJ
 vfoQrtLfYVmcp0/x1RzzmflOTE++v2PYIC9HVyVWtQmQ9iHOso4stWczDcvD6aOHFbiRslic2
 ppDlkBWcTBTw76dEpZzfmRp42xa2R/SVSHzDbev5HtJsf/XuovQILkLNSRl7f5pZTfkxeYwSP
 n9I8P+4rpsX1UAWmrL8E2O6gDGD3hlLtVQtWkeS+zuG86fsFcvKLqX79Fqb7X/G327X+Nibwg
 V70t47j4Yr+mvWgZW7B3KJA2KfPdAfds2+wHWeTXH3/BbVc/W/wh9Zk+RZHWccS//z+YVIJ2/
 uN+R+qxz3jBafD/nAlAd2RgZ4sTtGG6e4nxA7YvxdCnmTdNzEtzHTbNU9hEsdRogbdDE0MeOU
 cufN4hQVXD3BvprpJdZr9iVSON06d5aoQBEV/ZXv/caq9GDbiFZGfEFQ1pOGYUFnXP5mBvdeU
 8/fdSAlIHSAI6H8IsAmCljLKfPppRDJnsEmX6KmI1TYKP8CShsvCulJ55gGKaYMCIMpFlXxG1
 zL84HYY3beuSbdYgmnSklni62nLz/DCOevqpHmRWbVdcdrsDxQuA848RvIM58/vqZxFOoCngA
 oqKmzlrm0lI3ZWBzRWW1G/QL1hY=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the parisc architecture updates and fixes for 6.4-rc1:

Two important fixes in here:
* The argument pointer register was wrong when calling 64-bit firmware
  functions, which may cause random memory corruption or crashes.
* Ensure page alignment in cache flush functions, otherwise not all
  memory might get flushed.

The other patches are cleanups (mmap implementation, panic path) and
usual smaller updates.

All patches, with the execption of the argument pointer patch, have been
in stable since weeks. I rebased to fix a small conflict in the
docs to make pulling easier for you.

Thanks,
Helge

=2D--
The following changes since commit 348551ddaf311c76b01cdcbaf61b6fef06a4914=
4:

  Merge tag 'pinctrl-v6.4-1' of git://git.kernel.org/pub/scm/linux/kernel/=
git/linusw/linux-pinctrl (2023-05-02 15:40:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git ta=
gs/parisc-for-6.4-1

for you to fetch changes up to 6e3220ba3323a2c24be834aebf5d6e9f89d0993f:

  parisc: Fix argument pointer in real64_call_asm() (2023-05-03 17:43:26 +=
0200)

=2D---------------------------------------------------------------
parisc architecture updates and fixes for kernel v6.4-rc1:

- Calculate correct argument pointer in real64_call_asm()
- Cleanup mmap implementation regarding color alignment (John David Anglin=
)
- Spinlock fixes in panic path (Guilherme G. Piccoli)
- build doc update for parisc64 (Randy Dunlap)
- Ensure page alignment in flush functions

=2D---------------------------------------------------------------
Guilherme G. Piccoli (1):
      parisc: Replace regular spinlock with spin_trylock on panic path

Helge Deller (4):
      parisc: Limit amount of kgdb breakpoints on parisc
      parisc: Ensure page alignment in flush functions
      parisc: Drop HP-UX constants and structs from grfioctl.h
      parisc: Fix argument pointer in real64_call_asm()

John David Anglin (1):
      parisc: Cleanup mmap implementation regarding color alignment

Randy Dunlap (1):
      parisc: update kbuild doc. aliases for parisc64

 Documentation/kbuild/kbuild.rst    |   1 +
 arch/parisc/include/asm/grfioctl.h |  38 ---------
 arch/parisc/include/asm/kgdb.h     |   2 +
 arch/parisc/include/asm/pdc.h      |   1 +
 arch/parisc/kernel/firmware.c      |  27 +++++-
 arch/parisc/kernel/pacache.S       |   2 +
 arch/parisc/kernel/real2.S         |   5 +-
 arch/parisc/kernel/sys_parisc.c    | 166 ++++++++++++++------------------=
-----
 drivers/parisc/power.c             |  16 ++--
 9 files changed, 104 insertions(+), 154 deletions(-)
