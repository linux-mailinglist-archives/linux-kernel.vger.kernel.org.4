Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908C36A1978
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:04:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjBXKEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:04:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbjBXKED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:04:03 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93279168A3;
        Fri, 24 Feb 2023 02:03:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 76149CE22D5;
        Fri, 24 Feb 2023 10:03:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96115C433EF;
        Fri, 24 Feb 2023 10:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677232998;
        bh=+IVRztdAGMoZDxrDulaf2DrIWp7EopXbsY/1jwlxfcM=;
        h=From:To:Cc:Subject:Date:From;
        b=UfyoQf2ZOJqG42jFJhb/apxaR80/ef3UrYYl26wt15avL2IVbfXj+oU4oHCA9Hhd5
         lrPiBLI0jfuwIh1ZtDK8q5jytemsTWX4lVEkCk0mljjj6p5P6DWrqoRp8GSn+87vCK
         dmgLSaVzku5bqQt3HAw+3XgYEscL5u/Ud6Nz9WJt7AsCOweT7sfdo+baEBbJnw2xu/
         1pRRV8gPxoh/dJli4sVBIITSbR9zKM6epZ2+4qSsetLUWBCZkZ22Ctt/EHFfHBylBj
         wTZZQimnpYLIIvGUojzlklhd/ZYQnbPdbqYvJTTfDvc7WPZsPPF5+mmETyASOjaXgl
         ewXBPiwzAHtNA==
From:   Mike Rapoport <rppt@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     kernel test robot <lkp@intel.com>, Mike Rapoport <rppt@kernel.org>,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] docs/mm: Physical Memory: fix a reference to a file that doesn't exist
Date:   Fri, 24 Feb 2023 12:03:05 +0200
Message-Id: <20230224100306.2287696-1-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

kbuild reports:

>> Warning: Documentation/mm/physical_memory.rst references a file that doesn't exist: Documentation/admin-guide/mm/memory_hotplug.rst

Fix the filename to be 'Documentation/admin-guide/mm/memory-hotplug.rst'.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202302231311.567PAoS2-lkp@intel.com/
Fixes: 353c7dd636ed ("docs/mm: Physical Memory: remove useless markup")
Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 Documentation/mm/physical_memory.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/mm/physical_memory.rst b/Documentation/mm/physical_memory.rst
index f9d7ea4b9dca..1bc888d36ea1 100644
--- a/Documentation/mm/physical_memory.rst
+++ b/Documentation/mm/physical_memory.rst
@@ -66,7 +66,7 @@ one of the types described below.
   also populated on boot using one of ``kernelcore``, ``movablecore`` and
   ``movable_node`` kernel command line parameters. See
   Documentation/mm/page_migration.rst and
-  Documentation/admin-guide/mm/memory_hotplug.rst for additional details.
+  Documentation/admin-guide/mm/memory-hotplug.rst for additional details.
 
 * ``ZONE_DEVICE`` represents memory residing on devices such as PMEM and GPU.
   It has different characteristics than RAM zone types and it exists to provide
-- 
2.35.1

