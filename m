Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A858F70AA8D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 20:41:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjETSlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 14:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjETSlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 14:41:21 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2D929D
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 11:41:19 -0700 (PDT)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 570AE3F22E
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 18:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684608078;
        bh=C/qPwdzE2G8bmRC9cyFwLOXABhp9l9ZfW4+oqS1kXSE=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=XKXu1tvIPc358yamsTwgxwV0M0AR6Dz5xWkdMCR4vjO3W4DFtykUPcH3eg6KtVJa0
         uAiHiKV2id5UnMOrpdCb75d0MEO+kjOPPimPVTxSFYd5NysHGeVVSVIFuZa0LlgQxT
         qt/gKoFaTU6W2GjWT1ULF9Sb7iHS+nZFql9JDo40mwBsdcWpIBOe0+ImLXRKw8n7sX
         NAp60+T0c59JbyoXpi1nKFBzpi2AhAkadnRSb2rOLDVcVmWAlbgM4KT3YMsQIYJrto
         wOAQsCw7usKj4L9nWmEYptxpUEoc/oB/pOrYRuy960sgsFKLjJDYmQL5i28pJUfP8B
         fDjPOlHqjiGAA==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9663552473fso573785066b.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 11:41:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684608078; x=1687200078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C/qPwdzE2G8bmRC9cyFwLOXABhp9l9ZfW4+oqS1kXSE=;
        b=koJ6xiwblK6nREO+rnX9SbXXbM80R7CuGCLu7fFVAkCXP2/jrfA5IaxqDMT50OjEY6
         FdxG0eZMAK/poG9kwLfYZbv6ISgs420eQKianvECyZX6TbU/4mzfyxaDgUJM4hQuMVdv
         QdxT2sWbfnzk6mBYCNhqlu7Tn2S5gZT2eU5T2MT7UcqapLv+eI3wrU/EhKRkfVbeNWm1
         ZoL0u4ge351T1vIRMMzOvZsedUq9lUaYB52nqD/z7Llmnr3lRPqFi0JmTo6YcHcwZa6e
         EiRvvu5zsUvcx69ab0eVYhSh5tmP3VDXvgVN8Kj9EpF/uoNIdmztOKKyKT30X78wohAq
         4Nkw==
X-Gm-Message-State: AC+VfDw1aaDSfUllIRgugxL4qfnpDJaww+fkcPUB3iQovW9mPly6Zgli
        VctFGIJVTLAgt6m/G0A5aWQf8eVJDHJj5tBS0eTqG89RE3a5VkyL1BVM1fHJhKxnEr09ce/cVPF
        YR+HEpayMPi7XF5wmzJWCWOIZlPgrTC/K8MqZM79ykQ==
X-Received: by 2002:a17:906:4fd0:b0:94f:36a0:da45 with SMTP id i16-20020a1709064fd000b0094f36a0da45mr6744526ejw.29.1684608077966;
        Sat, 20 May 2023 11:41:17 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6Xoe3IyQTapTDN6XUEY4kDd0qIfZg0/ZY+peJltZTxeQjT+uu29NTmJQOVkcaER0JvBQaGfQ==
X-Received: by 2002:a17:906:4fd0:b0:94f:36a0:da45 with SMTP id i16-20020a1709064fd000b0094f36a0da45mr6744513ejw.29.1684608077668;
        Sat, 20 May 2023 11:41:17 -0700 (PDT)
Received: from righiandr-XPS-13-7390.homenet.telecomitalia.it (host-87-10-127-160.retail.telecomitalia.it. [87.10.127.160])
        by smtp.gmail.com with ESMTPSA id x6-20020a1709065ac600b009663115c8f8sm1046294ejs.152.2023.05.20.11.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 11:41:17 -0700 (PDT)
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] overlayfs: debugging check for valid superblock
Date:   Sat, 20 May 2023 20:41:12 +0200
Message-Id: <20230520184114.77725-1-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

OVL_FS() is used to get a struct ovl_fs from a sturct super_block, but
we don't have any check to determine if the superblock is valid or not.

This can lead to unexpected behaviors or bugs that are pretty hard to
track down.

Add an explicit WARN_ON_ONCE() check to OVL_FS() to make sure it's
always used with a valid overlayfs superblock.

To avoid enabling this additional pendatic check everywhere, introduce
the new config option CONFIG_OVERLAY_FS_DEBUG, that can be used in the
future also for other additional debugging checks.

Maybe a nicer solution could be to return an error from OVL_FS() when
it's used with an invalid superblock and propagate the error in the rest
of overlayfs code, but for now having at least the possibility to
trigger a warning can help to catch potential bugs in advance.

Changelog (v1 -> v2):
 - replace BUG_ON() with WARN_ON_ONCE()
 - introduce CONFIG_OVERLAY_FS_DEBUG

Andrea Righi (2):
      ovl: Kconfig: introduce CONFIG_OVERLAY_FS_DEBUG
      ovl: make consistent use of OVL_FS()

 fs/overlayfs/Kconfig     |  9 +++++++++
 fs/overlayfs/copy_up.c   |  2 +-
 fs/overlayfs/export.c    | 10 +++++-----
 fs/overlayfs/inode.c     |  8 ++++----
 fs/overlayfs/namei.c     |  2 +-
 fs/overlayfs/ovl_entry.h | 16 ++++++++++++++++
 fs/overlayfs/super.c     | 12 ++++++------
 fs/overlayfs/util.c      | 18 +++++++++---------
 8 files changed, 51 insertions(+), 26 deletions(-)

