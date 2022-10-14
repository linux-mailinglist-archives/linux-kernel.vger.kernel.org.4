Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2165FF3D3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 20:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbiJNSuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 14:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiJNSuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 14:50:21 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AD8C90F3;
        Fri, 14 Oct 2022 11:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1665773410;
        bh=ZtvchjV4WF9IiOG5tVyll+Nvgxr9HV1SgnVf5l+pb4k=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=ItMTyvFc7np40tDJTJxjwPACVJyITg/E3doYWZc5pJ36Ru2iEjDti1hkzIcAJ7SMh
         meY29eaSVeLdFW3A+nKWlb7eCRNiJVtqFWRAFDnr4jpHDf0evHFrCIY2xcEAY8O8Ou
         L+zHn7Zb4aBg0aeBYdBzwCoOEnz3zQKBlRfBKgOs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p100 ([92.116.188.185]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOzSu-1oVBja0kyS-00PQ5k; Fri, 14
 Oct 2022 20:50:10 +0200
Date:   Fri, 14 Oct 2022 20:50:05 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fixes and enhancements for v6.1-rc1
Message-ID: <Y0mvXY9NMPyBfsNF@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:QC+wHL94T091S0BdNNtUDz++md9KCSVZn1vVw1OOoCb7sp9g/Yw
 YbhDneydG2YxbAwzZNFvk/2dUNA7/wcynq/Iw4OQ0Qx4WiJxHinVTwsSM9H+DBsOudb++hx
 nPomaZj+dbnJP0O90lhX9D5KbZhkfMIxzYVjpHB0dkM6XcLJrzDqIUONBrr6Kik/nG9923/
 +hXVCU8CPNEI09NQjdEiw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:y2cT5wqOBvc=:BIkSbCpMqe82yfNq7nZR6N
 aeqoRxl0ENvwVPC8xsMr+J/p2XCUNQdvo5b2yGfXfH5tVPD4BYmsmlODQEzNBYFO9yrWPvmTv
 okECehcEDxP3DYHhbo50PRe9PrEYHLY76ggLYL55jt5aGPkP2kRO7HUw1xNYNg3xZ2FxTQssu
 kQEwN+8+dOO1b2DQC4OGajEn+Tk4p4WqDr38gZT0vhbtD5khWk95WABvXMhMPur2eZYhTyX8j
 pygK15/Jt3oyjWLTdtLeg6JsyYHvYqmwh1n+FD2WWCreG9SMUU9VDk0aVM68aGbyThZK+JOE8
 YRKisTfg68BNZP8EiBTtEjCWs0YMD1vB/NcqSPvuwWhCSj35S//76Hb8RlGk+9zKuIXltLDQm
 hhKUgiD6xAc2KPDSVbrzc8spCzNOBpEqq3piDuAMnbchIksexfPuhTg5OCkBGf+Zg2BLmDM4n
 X27zHKdxDlY9ylydL89Ge2FXVubLz3egBmodC1prE+DRI03thJtN1J16nFMuEfE8bUGSwl1Nj
 avJ0WusluZSED7loI9TnmQMkLdorH50KWVK5vqvl1xF+0UfYSdYybowQsqwpv7q73582R8sz1
 2Unvw0VjFOCwuISPzNur14Gzm3c6/A38Mk2zRtn0y+EdkhKhJKIUyvqL+QRun5gqALUvsUWBb
 E0wBTRcGVYS4X2md6QoKyHxNkGTdH1mZdoLMJ+VvggxJ1SZMm19uihzEB2u3hNT2cUoRp+zjW
 nDQt6bmEZIzaL33Ij8wo6Fsv+RltrspRuGnoA5MAwftQuvyt5D4RfXD61U2Ii07kpaNDbddXt
 HmWDs/GcopdF7kYbZkSxZ6bgrFtR1HaZfbU1Kwrkv/FzvZBcll5ytP/k5J3mH+kWbbW5XvR3J
 xmKMcRV46nEUk/E4WuXvq0FAXT1yp0c+Bky0C36wnN2dkeYfTRNuaVr7s1P2qwTvZtPwxBPRW
 Gex6vjDQDrhsLvbQ4UvVuOWu98e/0rBXUIEf96B1+QeaE8dwnHnWFpLjavK75+kxfBZez9nJS
 KH9gmcU/UFa7B/OdUGVXtNsF7G171gp4djDXGKvwIfgfTxTv6P7mbSse2zHhli11Maalv14Bd
 /Cvgr03Tj/+JBFaUhl2QlZ02NQ6Ckhcbxa8OBF4ySceIDYEARGLOrw/PEcKKT7xKXBWglAZ5l
 FWKHmQUO0ljaM95dNkd07hke5tEFoRUpM9fHlwui1vD/rU7LUcZpKha2HxhtjiRrtVa2gfzUP
 Uw1mIxusYKJAK5EL4LFcQgYNPVHZnkUrRDMVakueIMRi8qTcfaOFp/znkAdlmQLOiRSybZvc5
 o38lZ7DsCudmfWSUN3Pa0lXsbg/aEPeHhcHmTOjw4bumGywCr5U0zatNg0ySXukelzXtVxnbe
 wCM4Z0e02Wr6nA5Jgp8pIL7kiJtpUsjXMQYYorMYLi9smSqQPhDnd0Qgq7NBqK/uB832mSav4
 098lNPw/XHsh8hsTTJKXeimP7fyTxgKVnEd3mO/RigeUadwP3ufsUHOLFRfpkG9WdQHfROVga
 q6LHxVNA7UPlXL2ZO7Hmo/bc8EijNm0kAafHq+W+7h0VJ
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the following set of fixes and enhancements for the
parisc architecture for 6.1-rc1:

Fixes:
- When we added basic vDSO support in kernel 5.18 we introduced a bug
  which prevented a mmap() of graphic card memory. This is because we
  used the DMB (data memory break trap bit) page flag as special-bit, but
  missed to clear that bit when loading the TLB.
- Graphics card memory size was not correctly aligned
- Spelling fixes (from Colin Ian King)

Enhancements:
- PDC console (which uses firmware calls) now rewritten as early console
- Reduced size of alternative tables

Thanks,
Helge

---

The following changes since commit 4fe89d07dcc2804c8b562f6c7896a45643d34b2f:

  Linux 6.0 (2022-10-02 14:09:07 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.1-1

for you to fetch changes up to 34314cd615af5036e582fad14f2bb13e4383bfe1:

  parisc: Fix spelling mistake "mis-match" -> "mismatch" in eisa driver (2022-10-14 20:06:30 +0200)

----------------------------------------------------------------
parisc architecture fixes and updates for kernel v6.1-rc1:

* Convert the PDC console to an early console
* Unbreak mmap() of graphics card memory due to PAGE_SPECIAL pgtable flag
* Reduce the size of the alternative tables
* Align stifb graphics card memory size to 4MB
* Spelling fixes

----------------------------------------------------------------
Colin Ian King (1):
      parisc: Fix spelling mistake "mis-match" -> "mismatch" in eisa driver

Helge Deller (4):
      parisc: Reduce kernel size by packing alternative tables
      parisc: Convert PDC console to an early console
      parisc: fbdev/stifb: Align graphics memory size to 4MB
      parisc: Fix userspace graphics card breakage due to pgtable special bit

 arch/parisc/include/asm/alternative.h |  21 +--
 arch/parisc/include/asm/pdc.h         |   3 -
 arch/parisc/include/asm/pgtable.h     |   7 +-
 arch/parisc/kernel/alternative.c      |   7 +-
 arch/parisc/kernel/entry.S            |   8 ++
 arch/parisc/kernel/pdc_cons.c         | 240 ++++------------------------------
 arch/parisc/kernel/setup.c            |   6 +-
 arch/parisc/kernel/traps.c            |  15 +--
 drivers/parisc/eisa_enumerator.c      |   8 +-
 drivers/tty/serial/Kconfig            |  15 ---
 drivers/video/fbdev/stifb.c           |   2 +-
 lib/Kconfig.kgdb                      |   2 +-
 12 files changed, 67 insertions(+), 267 deletions(-)
