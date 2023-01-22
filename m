Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42996772CD
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 22:37:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231514AbjAVVhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 16:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjAVVhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 16:37:07 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC40216AF7;
        Sun, 22 Jan 2023 13:37:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1C95ECE0FAB;
        Sun, 22 Jan 2023 21:37:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A919FC433A0;
        Sun, 22 Jan 2023 21:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674423421;
        bh=ZUIDqsXYDWng6KDCJdrB2KTu4/airR/GrI1+yJu4p2s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XsrsXrKIAUtZmAAMreBA5zeu9qGmaIvptQd7BHSUVq3oZ/dBinIaw/laDwuNGtxCk
         V8jLuMzBCJRH8j4EHUHJ7B/DhbmQPERpsNPiqYGOet2oMlXP9rfILrnX5riPIEQ/MC
         jJ4CHWE5psudgqzE936x5NsC3Mv3rYsO0ioeuBnRJdLTVTl3a4M4hYVjVkK8Pk0qfA
         Nv3yUdMwhOhdlytomyynx1raLjLjMd3TPixFv/Q/WZLWm62BfhCGibjqNlSW43C8mY
         9O0x6RnIAVlNSgLiy4AXLlb6Yxb0T21TDYwX4RGAp/h+fmj8PJeRivKq6vtb71PtQm
         ERx5nm3QuhOBQ==
From:   SeongJae Park <sj@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     SeongJae Park <sj@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] Docs/sound/index: Add missing SPDX License Identifier
Date:   Sun, 22 Jan 2023 21:36:50 +0000
Message-Id: <20230122213650.187710-9-sj@kernel.org>
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

Add missing SPDX License Identifier for sound documentation index file.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/sound/index.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/sound/index.rst b/Documentation/sound/index.rst
index 5abed5fc6485..7e67e12730d3 100644
--- a/Documentation/sound/index.rst
+++ b/Documentation/sound/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 =============================
 Sound Subsystem Documentation
 =============================
-- 
2.25.1

