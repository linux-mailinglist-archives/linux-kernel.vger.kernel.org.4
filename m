Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2054E5ED330
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 04:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbiI1CzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 22:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiI1CzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 22:55:12 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586CAD5885
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 19:55:11 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id x18so17653893wrm.7
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 19:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date;
        bh=CA0Sf4NkMdTBmWM3MUFgBlhaxh3xzNxEsXwC7LIKo2o=;
        b=YyeUCLu/P9eHDehQY7vklUqfXtM+ueB3VwU3ayivqKXGCTX/Hpks16+VQeFhrUQatL
         aZKAapwRHxh1ExGcRUV1ZlDWhZFfbIwq6Uj5Yjt6DNVFOajESuPkNOU4gzC7HO/z5pZt
         YidNjn4HirNxMLKLe+mvii9/hIHFzePpLmKjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=CA0Sf4NkMdTBmWM3MUFgBlhaxh3xzNxEsXwC7LIKo2o=;
        b=lQWxkitZhRVIigHMWTaE4VNeoReXpnjeIre3dBUktWCgTX9NDh3zh//mhue3V7/Ty9
         kmuSg7EFnmHSkxpIQzHn6jXKFcP8C6Hn6Zk564ci1dy1qSZvqSKrtdla8NFAJpm5s6M1
         uFGyN8SO1EMI8vs6d1APb/hAyxDMGJ3YmoRVjnc3sPcDiFIdogp4dRX+MkrWl0whv6qW
         qSOLi4nH23OpbCrjF8HeU85g4dDACcwOJ3NVywlzTfv7l0jdZ3yhCWi8UE+Q5oYbbK0u
         GNS84gG0k16dDFLTamon2N4Lzgh6X++E8yM5JijArx9j9f4CfTqCQyzJlybFcta1fwkN
         sSpQ==
X-Gm-Message-State: ACrzQf3rfk5zuEoOsRjnIvfBJUids0aBF9uB+/BoRosVnv50grc30yyb
        TGNXc4eh7+sWWzjtRJUXvLD1dBVvuHKlK0oqLd0=
X-Google-Smtp-Source: AMsMyM7jagCJRLtNkHZo+wgJYjNzNCKWi3VSYaHPw3vLt5DKHTuVLuicUN8ADPKvKpTlK+D3kFOUvV+bTKxLDkiGv7Y=
X-Received: by 2002:a05:6000:1a8e:b0:22a:f55a:94d6 with SMTP id
 f14-20020a0560001a8e00b0022af55a94d6mr17766566wry.606.1664333709657; Tue, 27
 Sep 2022 19:55:09 -0700 (PDT)
MIME-Version: 1.0
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 28 Sep 2022 02:54:58 +0000
Message-ID: <CACPK8Xf+F9JYQpbKHLPeey-DjQJBY-82KQ7XRyaOeMu_HhEBig@mail.gmail.com>
Subject: [GIT PULL] fsi changes for v6.1
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
by the maintainer.

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/joel/fsi.git tags/fsi-for-v6.1

for you to fetch changes up to 992a78d616f19144c14fd35011e4a5f5e506584f:

  fsi: core: Check error number after calling ida_simple_get
(2022-09-28 12:07:56 +0930)

----------------------------------------------------------------
FSI changes for v6.1

 * Fix a OCC hwmon userspace compatibility regression that was
   introduced in v5.19

 * Device tree bindings for the OCC

 * A bunch of janitor type fixes

----------------------------------------------------------------
Eddie James (7):
      fsi: occ: Fix checksum failure mode
      hwmon (occ): Retry for checksum failure
      fsi: occ: Prevent use after free
      dt-bindings: hwmon: Add IBM OCC bindings
      fsi: occ: Support probing the hwmon child device from dts node
      hwmon: (occ) Check for device property for setting OCC active during probe
      hwmon (occ): Fix response length in checksum retry

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
