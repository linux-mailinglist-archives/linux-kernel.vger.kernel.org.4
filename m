Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 413A462E6E6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234884AbiKQV0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240440AbiKQVZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:25:27 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26189490B1;
        Thu, 17 Nov 2022 13:25:12 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id z20so2984664edc.13;
        Thu, 17 Nov 2022 13:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oU6+NWXiirNKO91d9UkWcSIMp+tEBOA5tR6DkQ1aDDE=;
        b=nzBKCbQBrjKuQuHTPy79NcF0/Dfqi78pbRoaklORZhc5GKyofiiz3BFqAwg8Agx3N/
         d925nZLfa6SU5OGGVn1HOI9iU2PtKJr9+Ifv9d8ipgmqkDUNVFcH1lhG5UHH9LKW5Zy/
         nKH8NgUKWEF7KxHT97rFbDdRT31nsSk81rO4WJ5wE3zbhbXqMHOz8YZSp624EtB35z29
         PvwH6/tVTdkiTB00xGqGaLUuKd+Gg4DskqnP+mX/TsRbKnKVjS7MXJdWJ1oZazArYx6O
         zEKdxNgI0uVuAOJJfAzswYUdJfGhx2teq3luz3CYtEMr+Mi5SOUaPHmvifSeHbkYR1Vv
         yjuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oU6+NWXiirNKO91d9UkWcSIMp+tEBOA5tR6DkQ1aDDE=;
        b=T+aH1fzylQkjK+0dPPoTVfOMe62Z97uisWn2QHNIinaz+CV9H7qhUSrjrJ/kGUL6Is
         10mFImHRKRZ3yc2S8E/iRmeehio8vlu/dFnkuuS9xN9fPxERKMmKijG1QyMYhOnYFCjf
         2484+i2hsfUafibicPwcWQXxzyR1yLuNsFFg8ciNhEyA0o/MTnOjgtJHl/Jcv/hKm0GP
         tFxQl+djhTb1gNR7AX+QIUDdC/bO2JdGRoUFN/3jwl6cDklC0XvPkVHb+voAjE/VaO21
         3HBSAeKu9VJDWx3Tm0l/cYqYVNQTht1dBGUS2fP6ml3wLEnthi2FhyU7MTBb1uJRQHqM
         hX9g==
X-Gm-Message-State: ANoB5plc0QR2iyuSVZP7kV3n1M7iNlgV+zTc066EDMmmw0WNloEx+mbS
        3joLtaPHT4aFFhIlbaaLOf0=
X-Google-Smtp-Source: AA0mqf5UpDZAPngi7cXAWO8WVzHLKdvbweuIjP2hfb7wzr4+wfOKcKnbO6nlR67kJKELatq0xc9RrA==
X-Received: by 2002:a05:6402:3644:b0:45f:c7f2:297d with SMTP id em4-20020a056402364400b0045fc7f2297dmr3784522edb.266.1668720310563;
        Thu, 17 Nov 2022 13:25:10 -0800 (PST)
Received: from zambezi.local (ip-94-112-104-28.bb.vodafone.cz. [94.112.104.28])
        by smtp.gmail.com with ESMTPSA id p21-20020a17090664d500b0078d9c2c8250sm840936ejn.84.2022.11.17.13.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 13:25:09 -0800 (PST)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fixes for 6.1-rc6
Date:   Thu, 17 Nov 2022 22:24:43 +0100
Message-Id: <20221117212443.16138-1-idryomov@gmail.com>
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

Hi Linus,

The following changes since commit 094226ad94f471a9f19e8f8e7140a09c2625abaa:

  Linux 6.1-rc5 (2022-11-13 13:12:55 -0800)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-6.1-rc6

for you to fetch changes up to 5bd76b8de5b74fa941a6eafee87728a0fe072267:

  ceph: fix NULL pointer dereference for req->r_session (2022-11-14 10:29:05 +0100)

----------------------------------------------------------------
Three filesystem bug fixes, intended for stable.

----------------------------------------------------------------
Dan Carpenter (1):
      ceph: fix a NULL vs IS_ERR() check when calling ceph_lookup_inode()

Palmer Dabbelt (1):
      MAINTAINERS: git://github.com -> https://github.com for ceph

Xiubo Li (2):
      ceph: avoid putting the realm twice when decoding snaps fails
      ceph: fix NULL pointer dereference for req->r_session

 MAINTAINERS     |  6 +++---
 fs/ceph/caps.c  | 48 ++++++++++++------------------------------------
 fs/ceph/inode.c |  2 +-
 fs/ceph/snap.c  |  3 ++-
 4 files changed, 18 insertions(+), 41 deletions(-)
