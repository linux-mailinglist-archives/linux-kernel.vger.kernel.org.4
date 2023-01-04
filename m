Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967C065DC4B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 19:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239938AbjADSkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 13:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240083AbjADSkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 13:40:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDB717078
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 10:40:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A7F9617DC
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 18:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29394C433EF;
        Wed,  4 Jan 2023 18:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672857622;
        bh=AgvoIicDbAjL2bIqMGzkHa0bmy6gZFwnYg4LrDuPsQM=;
        h=From:To:Cc:Subject:Date:From;
        b=EpRhy+a7/4yoq6kipl8jUSnNFF4cG2nAdzmg5hL+Mm02MbR6wGEINkdQWR5Zy8CZn
         femonJMDRwCDZmFt0kyj0QL+l0cNPSEq2DKq+dChdd6PJVRKp0KzN3vvZ7ojnvkhVu
         Md2NrrhmeQMdU2nHx0bmBgkqHGnEHD3fjCuvXdN5/kA9MjXYhq5vNcgG9A5GcfWCB2
         ioUjA73HIGfQ+Pao8wl8xsdClGyripYq3wQUXp7cpFUOx0zyfUsS2QeOob2FVpJx/w
         sEe7ES6WqygtUuKDXciSxC32lqu+GcxcX5sNGYmLG1+ZrcyqVr/deDrZ5N0zwSOehg
         vn5KXce/G+I4g==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     colin.i.king@gmail.com, dfustini@baylibre.com, joe@perches.com,
        rdunlap@infradead.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH v2] scripts/spelling: add a few more typos
Date:   Wed,  4 Jan 2023 18:40:17 +0000
Message-Id: <20230104184017.1724-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
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

Add a few more typos that found from real patches[1,2] to 'spelling'
file.

[1] https://lore.kernel.org/linux-mm/4bc4ab74-3ccd-f892-b387-d48451463d3c@huawei.com/
[2] https://lore.kernel.org/damon/20221228174621.34868-1-sj@kernel.org/

Signed-off-by: SeongJae Park <sj@kernel.org>
---
Changes from v1
(https://lore.kernel.org/lkml/20230103175901.128262-1-sj@kernel.org/)
- Remove the line adding covert as a typo of convert (Randy Dunlap, Joe
  Perches)

 scripts/spelling.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/spelling.txt b/scripts/spelling.txt
index ded8bcfc0247..a2ef42eb70d9 100644
--- a/scripts/spelling.txt
+++ b/scripts/spelling.txt
@@ -664,11 +664,13 @@ feauture||feature
 feautures||features
 fetaure||feature
 fetaures||features
+fetcing||fetching
 fileystem||filesystem
 fimrware||firmware
 fimware||firmware
 firmare||firmware
 firmaware||firmware
+firtly||firstly
 firware||firmware
 firwmare||firmware
 finanize||finalize
@@ -1558,6 +1560,7 @@ tunning||tuning
 ture||true
 tyep||type
 udpate||update
+updtes||updates
 uesd||used
 unknwon||unknown
 uknown||unknown
-- 
2.25.1

