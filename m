Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C5C5BBF3E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 20:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiIRSFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 14:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiIRSFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 14:05:38 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7C62BD0;
        Sun, 18 Sep 2022 11:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1663524326;
        bh=b9NLG4/rXSyl6ELbnsuQDkNh+2YYhHdjnBP89/yusbI=;
        h=X-UI-Sender-Class:Date:From:To:Subject;
        b=N42O2RMYa+9u9o4Ve3DkurfHAxBBwtImsiBWuHOO0hXl+0D6ngUQ64bi9/bRSLrWW
         IKhdCmX1IbP+Ky7rx/VdDOquQN4+u+tU8wWkBdPYbuLiTj3MMsvuhKK5gPPdoX0a0e
         vN9v7JTlt3fMqhDZRXY8ZbyrlItYYIOLbbU/OJ/8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from p100 ([92.116.165.224]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MG9kC-1oWgLS225E-00GW3u; Sun, 18
 Sep 2022 20:05:26 +0200
Date:   Sun, 18 Sep 2022 20:05:22 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fixes for v6.0-rc6
Message-ID: <Yydd4mNkcfXRDK4b@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:+EdoBbCYdxz03lsqwPpS/dnXzVuy/zdoZSA1Yy9UXFKS4CEnJ/S
 tUxGD2xETPBiZBdUpfSCOGuF9D+c5k3sbgJ3LiIjqtL9kjV57AwG1gasj4mySG5JJVCrXtF
 FmawU27Bf5rbzIIeMPF4YuGkKO/jWpE0ss+pNxXydFeR9l2sLA0HYqMkhz7K9DU+5/PcExX
 0t36n7fcejxDXzuV8xBoA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gh/lsEZg+h0=:JK4pHTqaTu70vE2jmtTHWO
 h4PjyKGxpui9m4swEwyzDLCY1qxbr3fYy1gLGaKVwZRC+7kfRhNy81pDwH70wkvCBh5mVVahY
 Zy+xLwXmkaJotRQIasFvOII9tIWJZz6aiXUAkD8rll5h8VrNjroFZkJVafnenhmSSG5EHdKZf
 BgYTkuz4wiW+Ko/Z1Gx9+69XasRdJYhslq8GqyYsM2NVrwQG/0q0PYXTbBXwVUhBZ0GnXLgoM
 pu18ojoTU+sxitJ1YMCopWVSpIRInQqpjdwnvjrLiAfLI8jazq3MbfLPzI48XGqfXEx44no2G
 kcP/M96QenFqBoXflAvET8HfuVkJpOom7EiYl/zd3QnEPyuqmWu3iWkzWdtfZzSj0Er0VKbAm
 Sg999WEcpNJIsnKVornB7QUziXlBs/7B+iK74MmNFC3VhsglXddHW1shWUcS5uEqBllFoOZF3
 O4KUmWucQ8XTjqYPE4ixcFcfH8SzVczKzb8KprR8OnIaGjC+UtbP6y0Z67ItleDtN15nTUz2Q
 Hnt7Wee8s/hghkR/YZFWU7NPSdHuQoORG9g5n3Lx5xU6X7mMXL75LMZyYsHSaprB1hsEoedsg
 6m5WeXN8uHqJ+6I0aIzaMjNtY8MEy3CWtqmbPf0SFGvJopvo2iRw5rKmwhs/5IXO+amYzcq5e
 mUq9XWAYBFOfSkSGe+j2ctsz4c0dpX6o6Xo/sQoph9sjsDk+6CDDRw2x3h62a2Pmw4YoLtCZF
 QQwUq+ZI7o3CM5+6k/zPW9eQmoAA5D2pl8wOHiOBy9JqgPr9bqcqIzt6WqzmbYAR03ZmSf7wv
 UfeC0AjVRQ32cnfcMTonNDRqpOw3Oox99UXJDeAiKKWmTgzMcyGLsHYFarQ8YImNbZ8OrOGDN
 bQGxk6DU89CfDNuOdxvo9qL9MXiJYYDtml3TP8re14jknkicaiaVZzKn/hIqxudICLgFaxVjR
 kn1o7kIrbQIgJzWkeCUHCADvBxcX20FtXy/dyS8eN0Q7chg3oKw/IKEtwrGWD24SAnksC/YUE
 Xh2b2DT9/ddoRTdUVgkNR9FI+yCB5tggKfbSXH2WNGcExovBm0sdRPsDxDJgMW3E/4D+DDnat
 m/cHqnP/wqKh4aNZrH29e1l7cAGEJZBfcscWcPMxoX/eB6mJmpETm740t/5PXUExvs8AAH0yC
 HWp8qwF1uq83EkMNmuolW2BuBi
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull some small parisc architecture fixes for 6.0-rc6:

One patch lightens up a previous commit and thus unbreaks building the deb=
ian
kernel, which tries to configure a 64-bit kernel with the ARCH=3Dparisc
environment variable set.

The other patches fixes asm/errno.h includes in the tools directory and cl=
eans
up memory allocation in the iosapic driver.

Thanks,
Helge



The following changes since commit 80e78fcce86de0288793a0ef0f6acf37656ee4c=
f:

  Linux 6.0-rc5 (2022-09-11 16:22:01 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git ta=
gs/parisc-for-6.0-3

for you to fetch changes up to 805ce8614958c925877ba6b6dc26cdf9f8800474:

  parisc: Allow CONFIG_64BIT with ARCH=3Dparisc (2022-09-15 07:59:37 +0200=
)

=2D---------------------------------------------------------------
parisc architecture fixes for kernel v6.0-rc6:

* Allow to configure for 64-bit kernel with ARCH=3Dparisc
* Fix asm/errno.h includes in tools directory for parisc and xtensa
* Clean up iosapic memory allocation
* Minor typo and spelling fixes

=2D---------------------------------------------------------------
Ben Hutchings (1):
      tools/include/uapi: Fix <asm/errno.h> for parisc and xtensa

Helge Deller (1):
      parisc: Allow CONFIG_64BIT with ARCH=3Dparisc

Jiangshan Yi (1):
      Input: hp_sdc: fix spelling typo in comment

Rolf Eike Beer (1):
      parisc: remove obsolete manual allocation aligning in iosapic

Yang Yingliang (1):
      parisc: ccio-dma: Add missing iounmap in error path in ccio_probe()

 arch/parisc/Kconfig            | 12 +++++++++++-
 drivers/parisc/ccio-dma.c      |  1 +
 drivers/parisc/iosapic.c       | 11 +----------
 include/linux/hp_sdc.h         |  2 +-
 tools/include/uapi/asm/errno.h |  4 ++--
 5 files changed, 16 insertions(+), 14 deletions(-)
