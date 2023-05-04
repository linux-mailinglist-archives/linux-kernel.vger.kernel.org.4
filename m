Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5CB6F71F6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 20:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjEDS23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 14:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjEDS2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 14:28:21 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4F565BA;
        Thu,  4 May 2023 11:28:19 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-94f1a6e66c9so149165266b.2;
        Thu, 04 May 2023 11:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683224898; x=1685816898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JcA+xZ7GzTut5Al/Cmyht6lL+VTimHlVjEwSzMJHdQQ=;
        b=a/QwQltR/+44GHanDTDx9RELumbiG1SywyThiaMbF+savjoZOpr4stUidnheJiS6w5
         DNoFuqNy/qE+EORJOnk/5bYxi4AtDSSZ+UKCjIQ2VVXht3D2oxfilJ29HQb+0iyqEouT
         M8+sQQlKjPmBvywyso+kTzaik0Xfdz48zAcmMiVszVBnl8cBw+yZO4/Vg32Y6kyWGS7k
         cCJTIT5BmtSppdGsubIzxxWyJVMn9sI9jrMBjNng9Aiuc+rpwwnKT2IVEbRY555KCJR3
         Ldp0zO5FTpTnAq0H0Cwq0uEHtTKYXdIVFYkLnXIL1Fm3mhT/Q8Mb6H3ePdFs8Yly6ORu
         Wsfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683224898; x=1685816898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JcA+xZ7GzTut5Al/Cmyht6lL+VTimHlVjEwSzMJHdQQ=;
        b=UPIEv9OB/gRxISJakG/rLKF5GRd3n9KHdPk0SH63w6oFYVTGgXOfxD4jMT2hp5w44Z
         PJRQh/e0SBbOSaKvzdcVLBjLANkeyrsTZHTIWch/EOL+AYTGDF2lCMW1GBFPj1lOdOol
         3Apk1o3pH0S1c4ENyAvZs2Zt7yKs207zKkMsHD14UTynXB/3uDghQI+qFTxgxUg3c6og
         tkOCosI9djx4kUa3PCarEozqwsXhBZL/TYlS9aYds6A1rCctWHQD1CUK//8L8bH7qgUe
         i/pCXktPvSr84RkXzDJ2X5W/11MimYa4a2j2Nq7oV70xjn5A6rKf0TWHDdDNwySGf1ul
         8xlA==
X-Gm-Message-State: AC+VfDx6VpDizpEDxuLGOXEYunIH4Pb7kxi1M5HeUH3fbAzSJycdUzH3
        cm1TKaBu+OIVSeewikYQ/4Ew12ioQEA=
X-Google-Smtp-Source: ACHHUZ4DBN7xp3KylVxRV3bnbRWG2CNp+kif7KTxhmuzBTWZ/Rvtfy5t8T1e8TBTjnzqOfug5rKxCw==
X-Received: by 2002:a17:907:5c5:b0:94a:82ca:12e5 with SMTP id wg5-20020a17090705c500b0094a82ca12e5mr7743374ejb.45.1683224898075;
        Thu, 04 May 2023 11:28:18 -0700 (PDT)
Received: from zambezi.redhat.com (ip-94-112-104-28.bb.vodafone.cz. [94.112.104.28])
        by smtp.gmail.com with ESMTPSA id lw6-20020a170906bcc600b00965c076133esm529035ejb.176.2023.05.04.11.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 11:28:17 -0700 (PDT)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph updates for 6.4-rc1
Date:   Thu,  4 May 2023 20:28:10 +0200
Message-Id: <20230504182810.165185-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 457391b0380335d5e9a5babdec90ac53928b23b4:

  Linux 6.3 (2023-04-23 12:02:52 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-6.4-rc1

for you to fetch changes up to db2993a423e3fd0e4878f4d3ac66fe717f5f072e:

  ceph: reorder fields in 'struct ceph_snapid_map' (2023-04-30 12:37:28 +0200)

----------------------------------------------------------------
A few filesystem improvements, with a rather nasty use-after-free fix
from Xiubo intended for stable.

----------------------------------------------------------------
Christophe JAILLET (1):
      ceph: reorder fields in 'struct ceph_snapid_map'

Xiubo Li (4):
      ceph: do not print the whole xattr value if it's too long
      ceph: implement writeback livelock avoidance using page tagging
      ceph: fix potential use-after-free bug when trimming caps
      ceph: pass ino# instead of old_dentry if it's disconnected

 fs/ceph/addr.c       | 11 +++++++-
 fs/ceph/caps.c       |  2 +-
 fs/ceph/debugfs.c    | 18 ++++++++----
 fs/ceph/dir.c        | 13 +++++++--
 fs/ceph/mds_client.c | 78 ++++++++++++++++++++++++++++++++++------------------
 fs/ceph/mds_client.h |  5 ++--
 fs/ceph/super.h      |  2 ++
 fs/ceph/xattr.c      | 20 +++++++++-----
 8 files changed, 102 insertions(+), 47 deletions(-)
