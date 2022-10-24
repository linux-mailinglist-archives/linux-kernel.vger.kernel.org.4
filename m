Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0AB60BD0D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbiJXWFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiJXWET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:04:19 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BBD2FBDE3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:18:25 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id h185so9581605pgc.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=68E5Ha7/DS7qwEFnJjSfWPZzK2S5tKKTKIK0mHztCMQ=;
        b=IKCTEnaYAHL4RZpwBlyQw/sXYB7OTDQkhlcWXL0C4dC/df5OC2THSFbh78WKdyi5BP
         gYqnCJclhBI4ZspWE/iHY+USq9at9lEbPb4fa6nGCfk++KtWFBroh97X7pr68rBu23IP
         LoCeCrSiI4c/VaHdCf/Jo/FG6gA0rbB/1XfLx5oKhcCEbYmo626mOerRSlgXexMSuilS
         WRw0PuOzz2X/eRkbx/d4kT0GnBJrZmyw0ECy6obwQa4x45PdaV9ImnZdb6ChjtDR/etO
         XXET59rN48cajLfRmeZj7K8705GGX3+ubggeUg2ca/V9Y4t0PoKSFAwQ2EeP6llLp6gh
         uqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=68E5Ha7/DS7qwEFnJjSfWPZzK2S5tKKTKIK0mHztCMQ=;
        b=P7QirY+eA/14omVX2x8NikVCJI50P58OAL/oPBoyI+kDTevM3n5cnWzVSdgtwm4yap
         6vrhB1zRQHcv6l0U0PQRDlw455oisHIiG+3jJqIvCpE2qOyHdVo5n6tCXfVwDSUvlvfl
         xpkQ/UUkofirXskU3kC7YqyZyMA0K2ZXTX+Nsr8Jh0q42odAfvYCfe7TediAaqcc+YzY
         1W/IhGPuhXNg+l88v37FI7NHnmmLBXPyUus0fgET/0JFWcs3+61n4XBN++7/eKDHkHLg
         qcJC5XHvP4AlSV3Q6rP2t+9M/38ePM1qOn3EAz0ffjBgzz5UcQTUHQWvPHw/AGDcr6+a
         HcNw==
X-Gm-Message-State: ACrzQf0sH/UfVCn+f1xUeVix/rX51FG7AZRDnK0v/tCZW8AI+spZKIgp
        z+YwUQYtauSDt9M8bd3nrQ4=
X-Google-Smtp-Source: AMsMyM5S+IGQLtSOvb+c2AGI5lcOKOn4ZtqaDUqUl0LF4sxJtC2mZjhf1JeomV7qjiWFyZC9+xn4zw==
X-Received: by 2002:a05:6a00:4396:b0:563:6fd7:9c98 with SMTP id bt22-20020a056a00439600b005636fd79c98mr35750833pfb.13.1666642607816;
        Mon, 24 Oct 2022 13:16:47 -0700 (PDT)
Received: from localhost.localdomain (c-98-35-160-214.hsd1.ca.comcast.net. [98.35.160.214])
        by smtp.gmail.com with ESMTPSA id k14-20020aa7972e000000b0056bb4dc8164sm173518pfg.193.2022.10.24.13.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 13:16:47 -0700 (PDT)
From:   Nick Terrell <nickrterrell@gmail.com>
To:     Nick Terrell <terrelln@fb.com>
Cc:     linux-kernel@vger.kernel.org,
        Nick Terrell <nickrterrell@gmail.com>,
        =?UTF-8?q?Andr=C3=A9=20Goddard=20Rosa?= <andre.goddard@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Sam Hardeman <natrox@outlook.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: [PATCH 0/2] zstd: Update to upstream v1.5.2
Date:   Mon, 24 Oct 2022 13:26:04 -0700
Message-Id: <20221024202606.404049-1-nickrterrell@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Terrell <terrelln@fb.com>

This series first prepares the kernel's zstd for the update and then updates to
upstream zstd v1.5.2. I've separated the first patch out because it is a change
for the kernel build system, and I want to make sure it can be separately
reviewed.

The latest upstream release is v1.5.2, and I am targeting this patch for the v6.2
kernel. We will be working on a new upstream release later this year. If it is
ready by the team the v6.2 merge window rolls around, I will add another update
patch to this series.

I will be merging this into my `zstd-next` branch [0] which gets pulled into
`linux-next` for testing. So this patch series will also be available here:

  https://github.com/terrelln/linux.git tags/zstd-v1.5.2-v1

Best,
Nick Terrell

[0] https://github.com/terrelln/linux/tree/zstd-next

Nick Terrell (2):
  zstd: Move zstd-common module exports to zstd_common_module.c
  zstd: import usptream v1.5.2

 include/linux/zstd_lib.h                      |  479 ++--
 lib/zstd/Makefile                             |    1 +
 lib/zstd/common/bitstream.h                   |    9 +
 lib/zstd/common/compiler.h                    |   67 +-
 lib/zstd/common/entropy_common.c              |   11 +-
 lib/zstd/common/error_private.h               |   81 +-
 lib/zstd/common/fse.h                         |    3 +-
 lib/zstd/common/fse_decompress.c              |    2 +-
 lib/zstd/common/huf.h                         |   46 +-
 lib/zstd/common/mem.h                         |    2 +
 lib/zstd/common/portability_macros.h          |   93 +
 lib/zstd/common/zstd_common.c                 |   10 -
 lib/zstd/common/zstd_internal.h               |  175 +-
 lib/zstd/compress/clevels.h                   |  132 ++
 lib/zstd/compress/fse_compress.c              |   83 +-
 lib/zstd/compress/huf_compress.c              |  644 +++++-
 lib/zstd/compress/zstd_compress.c             | 2000 +++++++++++++----
 lib/zstd/compress/zstd_compress_internal.h    |  375 +++-
 lib/zstd/compress/zstd_compress_literals.c    |    9 +-
 lib/zstd/compress/zstd_compress_literals.h    |    4 +-
 lib/zstd/compress/zstd_compress_sequences.c   |   31 +-
 lib/zstd/compress/zstd_compress_superblock.c  |  295 +--
 lib/zstd/compress/zstd_cwksp.h                |  225 +-
 lib/zstd/compress/zstd_double_fast.c          |  413 +++-
 lib/zstd/compress/zstd_fast.c                 |  441 ++--
 lib/zstd/compress/zstd_lazy.c                 | 1352 ++++++++---
 lib/zstd/compress/zstd_lazy.h                 |   38 +
 lib/zstd/compress/zstd_ldm.c                  |   76 +-
 lib/zstd/compress/zstd_ldm.h                  |    1 +
 lib/zstd/compress/zstd_ldm_geartab.h          |    5 +-
 lib/zstd/compress/zstd_opt.c                  |  402 ++--
 lib/zstd/decompress/huf_decompress.c          |  912 ++++++--
 lib/zstd/decompress/zstd_decompress.c         |   80 +-
 lib/zstd/decompress/zstd_decompress_block.c   | 1022 +++++++--
 lib/zstd/decompress/zstd_decompress_block.h   |   10 +-
 .../decompress/zstd_decompress_internal.h     |   38 +-
 lib/zstd/decompress_sources.h                 |    6 +
 lib/zstd/zstd_common_module.c                 |   32 +
 lib/zstd/zstd_compress_module.c               |    6 +-
 39 files changed, 6988 insertions(+), 2623 deletions(-)
 create mode 100644 lib/zstd/common/portability_macros.h
 create mode 100644 lib/zstd/compress/clevels.h
 create mode 100644 lib/zstd/zstd_common_module.c

--
2.38.1

