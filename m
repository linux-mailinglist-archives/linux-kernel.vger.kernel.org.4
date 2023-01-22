Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25296772C8
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 22:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjAVVhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 16:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjAVVhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 16:37:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1B316AEB;
        Sun, 22 Jan 2023 13:37:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C998B80B6C;
        Sun, 22 Jan 2023 21:37:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2520EC433EF;
        Sun, 22 Jan 2023 21:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674423418;
        bh=o9lSawkK9T9fjfOX0fWqWjbaWCpSn2+Q+PHaC6zmQqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=In8f5LKtFJjMF53bp3P5vB+XosPascOJa/K698RcXjJ8XqQ88Wu9/fnSC+e3gTj2v
         /HouLaxlABhcbyBFBepEagG1qDRFDUsV+0qnVKL4bc91rqwPMJdicduv+Bm/fjy/+C
         nvSy3mZzeVM3l3l7qcQkFCreLXxLATI4/s7PSrXOAqkGFGUdtGmC4D1uLJUVqilayL
         oqMZwyc567b2Ja1j6yXG1rwzUVFOVZV2xxCxj/wuxBb+6V9n7urPo3+MdihYDOyN/x
         KDA1YsyQ4X8iJBwrK0lwIV9yGdis1t0Newc/KmuJhMwRl3LRo5Dtuq8pmA4vKk5j2+
         LvGTKuf+byr8A==
From:   SeongJae Park <sj@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     SeongJae Park <sj@kernel.org>, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/8] Docs/hwmon/index: Add missing SPDX License Identifier
Date:   Sun, 22 Jan 2023 21:36:46 +0000
Message-Id: <20230122213650.187710-5-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230122213650.187710-1-sj@kernel.org>
References: <20230122213650.187710-1-sj@kernel.org>
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

Add missing SPDX License Identifier for hwmon documentation index file.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/hwmon/index.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
index c2b3c1a822dd..2186d732654f 100644
--- a/Documentation/hwmon/index.rst
+++ b/Documentation/hwmon/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ===================
 Hardware Monitoring
 ===================
-- 
2.25.1

