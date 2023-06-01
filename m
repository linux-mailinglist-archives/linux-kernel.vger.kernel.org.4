Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E4271F2E3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 21:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjFAT2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 15:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjFAT2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 15:28:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745EC186;
        Thu,  1 Jun 2023 12:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1685647707; x=1686252507; i=deller@gmx.de;
 bh=95xZi3c0zdCPEBKapIlN/abEMmJTEkPxC05zhfjB1nI=;
 h=X-UI-Sender-Class:Date:From:To:Subject;
 b=e+BOwJPsM1V+EPmIoDwLYh3XBZkCX7K4rbwI+cSKndnzNC6V+nFAQZRFT70FGQ3UTCn9j0R
 wOHLne68BxNHhy3H8QNpk/yHMc0N8dW7/vqqHEvl1jmWj5+b4/QfH4Z32OUToQmNPNadgw7j5
 jwYIgiWti4xWjnp3LaFe8y/qpGQPCvitWfJTMcqc+cS2k6JDrBsv9BXzpuQ5VFqNCJkBjRB+H
 2uzZf+zNuBnZ3OJgvfdhrwYDpQCegd/W6MhbuRJqUx8KepLlJgDy/tjQ8/uldEPurpilKoMJN
 OCj3VjHidd4zil824cOTeh4oaZqTl/HareIMm8ElrV2+ssAn+/5Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ls3530 ([109.43.49.30]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1psI-1q2c6t1cxk-002DzB; Thu, 01
 Jun 2023 21:28:27 +0200
Date:   Thu, 1 Jun 2023 21:28:24 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [GIT PULL] fbdev fixes for v6.4-rc5
Message-ID: <ZHjxWNRjTIk6HyT5@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tMC3QL7tU5dhhqXf5Ri3NzMwcNVaPxfW6hk3Tq8abKk2RWjhEnF
 2BZrVLNfZzqZQBEtrUVfjWo20GLXPIApZmsORnVCB/GWTRphu5LEK5aHT4rw5WhMkEcGkox
 NmCnXO5s4O2r3sm/uzMOoaWo/GEx/rzr51pnnMhBRCMcrBS8MveTFQym8naxCVHkfJxXbdO
 oN6BQwD0sU7eH5JE8FwqQ==
UI-OutboundReport: notjunk:1;M01:P0:3z3eF5z7XD4=;VsJ34xVH0nS6mJxG1O4h6LFSpec
 FoSdw3ai3d4nK5egTnFX5CnV5ElqClnhGo1iTVEwghS5pBfjxuHIKoJwRtRr8vznbUqLvx5V+
 k0v63/JFavdUMhQxmqb4Q+I7+j0zdeIAn9A2KUkIOYXq+vZ5p7zzGs44wvjAcPGfbLOY27hgW
 zpa6kDuQqIbBCsWcB0JZOO+GxMf8zuFHj+vH5pcGUHPivkdppPKKqgoUtj45ljuBtTdy1hF6b
 c6LxeEYuYKrek5S/aAtutrln3L20D/ptL948UOUKmXrtxRm/JINPfKFi638/iCcIcldwJUHOe
 cspQGjGN/0Y1EttP6UjSCGK7yTLbE0M7Jjpj1kBUtCgcvAYmLD7s3N1zojHylDDwB+z6v9PdJ
 P1x2dS7lKWNT66kiAz1CrYRcYUYVMEvCX0/N+jdELotzpardD7oRfw+NjibVdrebobv2Xa6Go
 afJ5NLv/uFSkFxthKuew0JolIaInB726KHp/lYYgJHDBCZqFF88+oLdXtXa6jshjfvPkExcf4
 gGh3vLMfAklNtG+CO/eekp2jGK8Jv7V7EPDd1E9WrXjwxGHN8QhIxbBl6SOWMHRgJAQl0zoyM
 YnKvau8Q0wcHZ3LRamgrZttcLE3DxU75x2//Du++lYdo5R0X9trWktuxj++6Gpa4PAGhaawFs
 bsKRB5kV2ZyXulyj0yMD0NVYmPyMHiGVuj3alzuc9R9iB/All80wxz999kDsHfo99yH3o3LWS
 hiMhwqVkyQirjRcVcRhyZrTOaG8Uj29bxis6eiy/CylznU0ClF2YkAxpu6ZlA86zHD+ByuWmd
 a49J/VmxqD5NQSfdRNsAV2ntnA8c+gEj/J80Y7GSjK+jCzh1yDa1el6A/ku8N2BJpeSWPtoxj
 h1LL3Li/ckz+QCw9eAa85aaqeeDup50ASCHC1JoqWicdNsCKwpyIfOiQ66xRVqw/vEUGV2l1V
 xkteBg==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull some fbdev fixes & cleanups for kernel 6.4-rc5.
Most noteably is a fix for a null-ptr-deref in fbcon's soft_cursor functio=
n
which was found by syzbot.

Thanks!
Helge

=2D-------------

The following changes since commit 44c026a73be8038f03dbdeef028b642880cf151=
1:

  Linux 6.4-rc3 (2023-05-21 14:05:48 -0700)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git ta=
gs/fbdev-for-6.4-rc5

for you to fetch changes up to d19663edc91de65ae85eea9902addc9d04b0ceb6:

  fbdev: bw2: Convert to platform remove callback returning void (2023-05-=
30 18:33:25 +0200)

=2D---------------------------------------------------------------
fbdev fixes for kernel 6.4-rc5:

- Fix null-ptr-deref in soft_cursor
- various remove callback conversions
- error path fixes in imsttfb

=2D---------------------------------------------------------------
Helge Deller (3):
      fbdev: imsttfb: Release framebuffer and dealloc cmap on error path
      fbdev: imsttfb: Fix error path of imsttfb_probe()
      fbcon: Fix null-ptr-deref in soft_cursor

Uwe Kleine-K=F6nig (7):
      fbdev: matroxfb ssd1307fb: Switch i2c drivers back to use .probe()
      fbdev: au1100fb: Drop if with an always false condition
      fbdev: arcfb: Convert to platform remove callback returning void
      fbdev: au1100fb: Convert to platform remove callback returning void
      fbdev: au1200fb: Convert to platform remove callback returning void
      fbdev: broadsheetfb: Convert to platform remove callback returning v=
oid
      fbdev: bw2: Convert to platform remove callback returning void

 drivers/video/fbdev/arcfb.c                 |  5 ++---
 drivers/video/fbdev/au1100fb.c              | 11 +++--------
 drivers/video/fbdev/au1200fb.c              |  6 ++----
 drivers/video/fbdev/broadsheetfb.c          |  5 ++---
 drivers/video/fbdev/bw2.c                   |  6 ++----
 drivers/video/fbdev/core/bitblit.c          |  3 +++
 drivers/video/fbdev/imsttfb.c               | 12 +++++++++---
 drivers/video/fbdev/matrox/matroxfb_maven.c |  2 +-
 drivers/video/fbdev/ssd1307fb.c             |  2 +-
 9 files changed, 25 insertions(+), 27 deletions(-)
