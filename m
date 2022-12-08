Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A12E6468DB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 07:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiLHGEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 01:04:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiLHGEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 01:04:38 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45657BC17;
        Wed,  7 Dec 2022 22:04:37 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id cm20so682119pjb.1;
        Wed, 07 Dec 2022 22:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BLHfW6s0354dS6xMkZ1vVfUR8MGj8TL54fGBDhGzvJ8=;
        b=d26yQEkZprDklFdMN/SqemVEjPBMHYFNwVRyHcVEpIZ83UkINmO8hMAq6pgD4dOG77
         o2k1QM2OGXaQS3+e799eboI6qVY4LmJlVlsArryUe81L9fDXDRM/WnZH300gZaoJctX8
         rxjjsvK5juVw6/rXrEGRSJPN5n/bg5ZuMNFOReSiZCDob/AsTZJNIKoOT/cEgwBHxg+p
         cvNRLR+ZblsjlYCq3ecn9W3E5TJsvwyn1yHJzRf141dEfPsUzScmLwbBKG/UuEAP82+a
         X7tr/Y6oVIsLLxaCpFZUWIwz8igAJwv8TxZoLdOy1W9un5iQGyx1o3X6HNPR7bXwu+Pg
         TskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BLHfW6s0354dS6xMkZ1vVfUR8MGj8TL54fGBDhGzvJ8=;
        b=PNnT49o8tLPbS6YScfod25jQ+sr3vxTaMoBtcNDg8TZ5ck1+LqPH2dq6OoPlgd20pa
         /sBXAfXuWtopL4JGqulJ51K0pFBK/yGeCXi5xKSOSLyJa5wMzrufV1crTuioDCi8xVhz
         zteJmJFbGZOloRddvL30E6KL9DN56AZFf/nDTnWdXZjbvwqXAlvJWJRpFq+Ik8Ajm9go
         Gp1tpfgESeg4EIZFd2cCbfht9az3xEfWL5ii/8jzveqAnnfi3WumwCNv62gUHxjTR5G4
         3Xpsg/P/K8AhvBjVw9DlEtm0o4lKqrX9fFlv4RK27b1M/jk/28wLWVInlGcNHhYq1CMt
         VYpA==
X-Gm-Message-State: ANoB5pk9EDnLzTKglrY9a26debBBYqtTjnVsU6vxDxgZ9NjtKC3qaqWG
        6PC81SWOptdLlGgeU6K6Jm5mahCBzytMNDgghEw=
X-Google-Smtp-Source: AA0mqf6QMmz/LGOX9ZEkvJy2MiF1cIIeYLu6y9UsW7STbhaIpA7MaxSFZVRDSQFR1bDr5yz7NChqOQ==
X-Received: by 2002:a05:6a20:691a:b0:9d:efbf:6607 with SMTP id q26-20020a056a20691a00b0009defbf6607mr2898747pzj.21.1670479477109;
        Wed, 07 Dec 2022 22:04:37 -0800 (PST)
Received: from PS-CAN-014uA51.localdomain ([58.63.247.51])
        by smtp.googlemail.com with ESMTPSA id p2-20020a622902000000b0056e8eb09d58sm14966949pfp.170.2022.12.07.22.04.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Dec 2022 22:04:36 -0800 (PST)
From:   Chen Xiao <abigwc@gmail.com>
To:     corbet@lwn.net
Cc:     akpm@linux-foundation.org, yejiajian2018@email.szu.edu.cn,
        caoyixuan2019@email.szu.edu.cn, zhangyinan2019@email.szu.edu.cn,
        akiyks@gmail.com, rppt@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen Xiao <abigwc@gmail.com>
Subject: [PATCH] docs: mm/page_owner: fix spelling mistakes
Date:   Thu,  8 Dec 2022 14:04:03 +0800
Message-Id: <1670479443-8484-1-git-send-email-abigwc@gmail.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix several spelling mistakes in page_owner documentation.

Signed-off-by: Chen Xiao <abigwc@gmail.com>
---
 Documentation/mm/page_owner.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/mm/page_owner.rst b/Documentation/mm/page_owner.rst
index 1275149..0f4cb59 100644
--- a/Documentation/mm/page_owner.rst
+++ b/Documentation/mm/page_owner.rst
@@ -52,7 +52,7 @@ pages are investigated and marked as allocated in initialization phase.
 Although it doesn't mean that they have the right owner information,
 at least, we can tell whether the page is allocated or not,
 more accurately. On 2GB memory x86-64 VM box, 13343 early allocated pages
-are catched and marked, although they are mostly allocated from struct
+are caught and marked, although they are mostly allocated from struct
 page extension feature. Anyway, after that, no page is left in
 un-tracking state.
 
@@ -178,7 +178,7 @@ STANDARD FORMAT SPECIFIERS
 	at		alloc_ts	timestamp of the page when it was allocated
 	ator		allocator	memory allocator for pages
 
-  For --curl option:
+  For --cull option:
 
 	KEY		LONG		DESCRIPTION
 	p		pid		process ID
-- 
1.8.3.1

