Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7CD64F676
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 01:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiLQArO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 19:47:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiLQArJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 19:47:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1544A582
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 16:47:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4B9CB81E4B
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 00:47:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64066C433EF;
        Sat, 17 Dec 2022 00:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671238025;
        bh=RcsuFo8KYXcA03TEr9Mq5ANGUIZxFkfKFOpi/1eHeRM=;
        h=From:To:Cc:Subject:Date:From;
        b=S72RlySVGVPRDL/AKYB7DNR8UK3pvepkv3/9VhwzFXHvfIqExsZxQVYjVND9MjwWg
         dij+k1nrbvdKZeOftBV55V2JewouAYed9Eg1+w9qE/raifQO2iiZg1Ls+91nscZ+1o
         sh8ZEHH03k4hIOEAme9PSkpmcaAUHGwwltB1TQ+LmTNE8OpVEfYwRvuX3iSToPS6wL
         HSCy2eDGzDDlv5PxRYmQ/FJyQNeQFaCMJT2jL3BuCZuZzPG0q2eyiAP1ZVxkvfjokT
         V06ytkm5JFNekj+iK4d5UsQFGtAe/++WTwE5KSJz9buOwxUneuibFrjwrlH6kynygK
         I/k8iSbYmc3xA==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 0/3] fix per-block age-based extent_cache
Date:   Fri, 16 Dec 2022 16:46:56 -0800
Message-Id: <20221217004659.2092427-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up and one bug fix.

Jaegeuk Kim (3):
  f2fs: initialize extent_cache parameter
  f2fs: don't mix to use union values in extent_info
  f2fs: should use a temp extent_info for lookup

 fs/f2fs/data.c         |  2 +-
 fs/f2fs/extent_cache.c | 31 ++++++++++++++++---------------
 fs/f2fs/file.c         |  2 +-
 fs/f2fs/segment.c      |  2 +-
 4 files changed, 19 insertions(+), 18 deletions(-)

-- 
2.39.0.314.g84b9a713c41-goog

