Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1C95EE9EA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 01:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbiI1XJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 19:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiI1XJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 19:09:52 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87291839A
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 16:09:49 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id x18so21955947wrm.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 16:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=v3fJhagLE36rGR54NwPOhOt7QwIfeKYQbnzWU0Q2+ZI=;
        b=I/C/DdBQwZN1Bc9cE8bDjg7b2EriIT/NmHFf85mTHupWAe/akEI5dDilJXTjwIiieo
         +IuW8ubrkASN15XBmBU1b1V9WjjixixB0foj5sGluEqWKhWpf22V5Pisz3gPMDZWhwnO
         edxuAckOBi1deWTU+Iy3dOd36AsWr2Qa5zILo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=v3fJhagLE36rGR54NwPOhOt7QwIfeKYQbnzWU0Q2+ZI=;
        b=2GRxeBijPPOJ4YwCRRx4SE3b6nAYmBVrELKFGrcWdMp88P98Ge48K+T6OIZKkgva9N
         Pem+DY3WudqzV4t/AdLpgl25+nmlaHAbV16CS5w2f6ZGUlIZtZ1tTUVPXd9T3HxWu//L
         63Q5wOX+7JCFug+WkRv5UIcG3/B8Xk8/GfzbDTNgF2oAlmqEiQqW5U1v+Ju7O1WYl84p
         7aFwCMVgPw8mouF+YltkJdipbOdfuFCRn3oqgcn/WWSdcku+e7SUZn0TFqDTl59JJxQM
         4A1mTWaSA+JpaFRabx8ri3vpBBbyuI8fcIdt9sferZ27gHwyHt41am+KTKdZ9chn9Zjk
         ACmg==
X-Gm-Message-State: ACrzQf16XeAFJooELc2biZVlX76mNxF7YeMj/ejh7B+KW8/gIYE9JL5e
        /OmG1sxgd+7EoeGUrMHrZ1xPNPzGlVwVza5dO1IKrGqnLoA=
X-Google-Smtp-Source: AMsMyM4P6+JjHWQtiju/5hzONGZu5lVEesEILkj0pzZx29hh5gAQEt/r+qbl/ufz7vT/Rim29ihIPVDgSkBOPeXkTp8=
X-Received: by 2002:a5d:4bc3:0:b0:22a:4b7a:6f60 with SMTP id
 l3-20020a5d4bc3000000b0022a4b7a6f60mr95462wrt.549.1664406588408; Wed, 28 Sep
 2022 16:09:48 -0700 (PDT)
MIME-Version: 1.0
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 28 Sep 2022 23:09:36 +0000
Message-ID: <CACPK8Xf8FrRmiZphxF1eoqcE_0CVOsxSv9SmUGHrfdKH6p0oRA@mail.gmail.com>
Subject: [GIT PULL] fsi changes for v6.1, second try
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-fsi@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Eddie James <eajames@linux.ibm.com>,
        Andrew Jeffery <andrew@aj.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

Here are some FSI updates for v6.1. The hwmon changes have been acked
by the maintainer., and the commit with the incorrect Fixes line has
been merged into the patch that it fixes.

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/fsi.git tags/fsi-for-v6.1-2

for you to fetch changes up to 35af9fb49bc5c6d61ef70b501c3a56fe161cce3e:

  fsi: core: Check error number after calling ida_simple_get
(2022-09-28 21:10:57 +0930)

----------------------------------------------------------------
FSI changes for v6.1

 * Fix a OCC hwmon userspace compatibility regression that was
   introduced in v5.19

 * Device tree bindings for the OCC

 * A bunch of janitor type fixes

----------------------------------------------------------------
Eddie James (6):
      fsi: occ: Fix checksum failure mode
      hwmon (occ): Retry for checksum failure
      fsi: occ: Prevent use after free
      dt-bindings: hwmon: Add IBM OCC bindings
      fsi: occ: Support probing the hwmon child device from dts node
      hwmon: (occ) Check for device property for setting OCC active during probe

Jiasheng Jiang (1):
      fsi: core: Check error number after calling ida_simple_get

Joel Stanley (1):
      fsi: sbefifo: Add detailed debugging information

Luo Xueqin (1):
      fsi: Fix typo in comment

Lv Ruyi (1):
      fsi: master-ast-cf: Fix missing of_node_put in fsi_master_acf_probe

Tom Rix (1):
      fsi: cleanup extern usage in function definition

 drivers/fsi/fsi-master.h                           |  2 +-
 drivers/fsi/fsi-core.c                             | 11 ++--
 drivers/fsi/fsi-master-ast-cf.c                    |  2 +
 drivers/fsi/fsi-occ.c                              | 66 ++++++++++++++++++----
 drivers/fsi/fsi-sbefifo.c                          | 15 +++--
 drivers/hwmon/occ/common.c                         | 11 +++-
 drivers/hwmon/occ/p9_sbe.c                         | 26 +++++++--
 .../devicetree/bindings/hwmon/ibm,occ-hwmon.yaml   | 39 +++++++++++++
 8 files changed, 143 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ibm,occ-hwmon.yaml
