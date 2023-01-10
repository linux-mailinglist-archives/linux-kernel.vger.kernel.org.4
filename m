Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC3C664BF7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 20:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239835AbjAJTFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 14:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239669AbjAJTEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 14:04:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150F3C2C
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:04:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C47E3B8197A
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 19:04:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235EAC433D2;
        Tue, 10 Jan 2023 19:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673377448;
        bh=yhlx99wApZuf1+oxV+tS5tr85ZKJgTLb2t8Dhjj3q6I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fw8T8JX5qowhaM7imY0QxW2TLNYGjTeDjVNkpnJQmEbxf5CNLt8o+rYHK3k4Db4Ct
         JdhmGxrvKh46Iz1btrYZ2FRwg6N3qPm9NMLs8Ocpt7517+bN7F4lVHnKks+XUAqqsk
         f/2Tas3X/hU7xq+zQwB5Hj76Z6YB4voWxzE+Ql6Hbcytnpo4Qt6IWBimgn+D0cxp/4
         ijA/gPb95yECvGpimIHZChLCYtAfHO59f1Hyh+cvixYJyYwUWlM/W4e2JX54hUXYL6
         cWm5irf5P0+fa+F7BOltbdvyueoCHNnKyEtHSkMGWBFwM+4mMSf/F/L9Ln4J/tzmoP
         EYy2wqxHACKIA==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] MAINTAINERS/DAMON: link maintainer profile, git trees, and website
Date:   Tue, 10 Jan 2023 19:03:58 +0000
Message-Id: <20230110190400.119388-7-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230110190400.119388-1-sj@kernel.org>
References: <20230110190400.119388-1-sj@kernel.org>
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

Add links to below DAMON development related resource to DAMON section
in MAINTAINERS file.

- The basic policies and expectations of DAMON development,
- DAMON development trees, and
- DAMON introduction website.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a0c3d3b9093..4b222f67663a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5790,6 +5790,11 @@ M:	SeongJae Park <sj@kernel.org>
 L:	damon@lists.linux.dev
 L:	linux-mm@kvack.org
 S:	Maintained
+W:	https://damonitor.github.io
+P:	Documentation/mm/damon/maintainer-profile.rst
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
+T:	quilt git://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/sj/linux.git damon/next
 F:	Documentation/ABI/testing/sysfs-kernel-mm-damon
 F:	Documentation/admin-guide/mm/damon/
 F:	Documentation/mm/damon/
-- 
2.25.1

