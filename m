Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22435FDDDF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 18:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiJMQCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 12:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiJMQCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 12:02:05 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBCD104526;
        Thu, 13 Oct 2022 09:02:03 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id s30so3298757eds.1;
        Thu, 13 Oct 2022 09:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i0F2oICNNjCBsoL5fs6l6db9fkLD0EJdXecM8PpjA+g=;
        b=jLWNzxCq8cXHFa+RJftXtWav9bZ8JdZZ5+4qE74RzBc46FPQlJfGhzdoVu9XPHxxTq
         J/hmttj7Acis0PnBqCGVy73rG1f8kjb5hIRnSIApJcsDLxVcyZgHV7au7ANErMoFGHay
         6NS0UQSngqCUvhALVMuQX978Ka7PGoy5Me1ItyikvKm1CoZgJKUgKPeK6tTPZUij6KTv
         SV67XlXaQyBplXdO7kcfVBExhpsnF19eA3nDA+0nJxKj4FjfSl+FHfyHU0DOpvpX/Klj
         VVJS597FU4WMT7piGywgFBIAcgSfpfvTr/7diTq2gZes1aMYhwqcjkSpn/2eWxhhxob0
         APvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i0F2oICNNjCBsoL5fs6l6db9fkLD0EJdXecM8PpjA+g=;
        b=NPM7H5dJ7nHAa93KUAPg3Y4xy7Q8irYYFW7foKsxvMUtrm6GNn1lEvNY4I2kuPW8iD
         rBBhR/UoXaagIYaRcydsllvSIbjKR5M+7w+YWw48X5LucGHvjgABAO/3j8A9BDjHOpck
         0Gp26+eKrZGICqsyx4d4UA0wriT7zQ63p+1Y7IynfSLGScrsWRkObXADzxQh/MEp1/mO
         tZTI8VlqgIZjsxBXLpyTxAIbi2qDfl3ggg/eggpv7P2WcVqWVnsXZ7CmzCFBOly9RB8W
         hPhglL/1xRO7yB3XBoolDX4W+Ek/u1OEOAzEhpDHHIHtHtle145CMRsBvwkLkWGwi/O7
         D7qw==
X-Gm-Message-State: ACrzQf1+zVGXj349vD7y7Znchg69ZUPo+ktVENCrcMHyMBCLsxedQ/H9
        7qZ7EDqlyY+uXgRzAHSUjBSdXrtTMjDZRg==
X-Google-Smtp-Source: AMsMyM5G8ivyL2PPCUiu15dZtPg4w+Lv0Wj/Wg/vb+TcACZF0lU9PhfKGQ6GXZqx4YhTEkADneyLJw==
X-Received: by 2002:aa7:df16:0:b0:45b:f51f:ab73 with SMTP id c22-20020aa7df16000000b0045bf51fab73mr413883edy.366.1665676922271;
        Thu, 13 Oct 2022 09:02:02 -0700 (PDT)
Received: from zambezi.redhat.com (ip-94-112-104-28.bb.vodafone.cz. [94.112.104.28])
        by smtp.gmail.com with ESMTPSA id gc37-20020a1709072b2500b0077d6f628e14sm62107ejc.83.2022.10.13.09.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 09:02:01 -0700 (PDT)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph updates for 6.1-rc1
Date:   Thu, 13 Oct 2022 18:01:53 +0200
Message-Id: <20221013160153.100941-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.37.3
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

Hi Linus,

The following changes since commit 4fe89d07dcc2804c8b562f6c7896a45643d34b2f:

  Linux 6.0 (2022-10-02 14:09:07 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-6.1-rc1

for you to fetch changes up to 71cf0c1c4f9f8e42c84ca53a5ca7091e4eea7f6a:

  ceph: remove Sage's git tree from documentation (2022-10-04 19:18:08 +0200)

----------------------------------------------------------------
A quiet round this time: several assorted filesystem fixes, the most
noteworthy one being some additional wakeups in cap handling code, and
a messenger cleanup.

----------------------------------------------------------------
Jeff Layton (2):
      libceph: drop last_piece flag from ceph_msg_data_cursor
      ceph: increment i_version when doing a setattr with caps

Kenneth Lee (1):
      ceph: Use kcalloc for allocating multiple elements

Tiezhu Yang (1):
      ceph: remove Sage's git tree from documentation

Xiubo Li (5):
      ceph: wake up the waiters if any new caps comes
      ceph: fail the request if the peer MDS doesn't support getvxattr op
      ceph: no need to wait for transition RDCACHE|RD -> RD
      ceph: fail the open_by_handle_at() if the dentry is being unlinked
      ceph: fix incorrectly showing the .snap size for stat

 Documentation/filesystems/ceph.rst |  1 -
 fs/ceph/caps.c                     | 14 ++++++++++---
 fs/ceph/export.c                   |  3 ++-
 fs/ceph/inode.c                    | 29 +++++++++++++++++++++++----
 fs/ceph/mds_client.c               | 11 +++++++++++
 fs/ceph/mds_client.h               |  6 +++++-
 include/linux/ceph/messenger.h     |  4 +---
 net/ceph/messenger.c               | 40 +++++---------------------------------
 net/ceph/messenger_v1.c            |  6 +++---
 net/ceph/messenger_v2.c            |  2 +-
 10 files changed, 64 insertions(+), 52 deletions(-)
