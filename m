Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6A95F3715
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 22:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiJCU2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 16:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiJCU23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 16:28:29 -0400
X-Greylist: delayed 152 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 03 Oct 2022 13:28:27 PDT
Received: from resqmta-h1p-028596.sys.comcast.net (resqmta-h1p-028596.sys.comcast.net [IPv6:2001:558:fd02:2446::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A7B28E29
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 13:28:27 -0700 (PDT)
Received: from resomta-h1p-027913.sys.comcast.net ([96.102.179.200])
        by resqmta-h1p-028596.sys.comcast.net with ESMTP
        id fKgDoBHsy4RFhfS0fox5TB; Mon, 03 Oct 2022 20:25:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20211018a; t=1664828753;
        bh=sSK/2hKHyH3SFlM85+1nh0ZaqIwSaRS3+OpWNmPHmsI=;
        h=Received:Received:From:To:Subject:Date:Message-Id:MIME-Version;
        b=aAbluPrixdJDEykjKkqO3YoGYPvsrhYka7lWnwXgN66tD1r8hjU8wpJN5fx5xg7ON
         79fJhf0KEzjgk6JGkk+C2SNhZ0FML+snhy0pPkZ3z7e0LVcxzCnrsuGY8s1rmnu+wc
         KVSYi4jBVuNDtDFpUfkrQQl56slOKQ+lJGmgmK+3MXzlHCoXI8ZNs+JpvPjmWUFuzU
         M/bQzO/qTP9pSYh+m7PMtT3NZQsbLRbVOY6pESEOpv22bvgueMG98MdcwjEASfIme7
         TFCIjRB2u687OZ8ed+oRZIbooGOyvMhwVAlXchtzTg11O4/ZiUkusAII+J18wn9YMN
         yyYQTtDgJcJjg==
Received: from DESKTOP-2K9CI8E.localdomain ([71.205.181.50])
        by resomta-h1p-027913.sys.comcast.net with ESMTPA
        id fS00oXCiSvH2AfS0HoqRcg; Mon, 03 Oct 2022 20:25:30 +0000
X-Xfinity-VAAS: gggruggvucftvghtrhhoucdtuddrgedvfedrfeehledgudegkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucevohhmtggrshhtqdftvghsihdpqfgfvfdppffquffrtefokffrnecuuegrihhlohhuthemuceftddunecunecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheplfhonhgrthhhrghnucffvghrrhhitghkuceojhhonhgrthhhrghnrdguvghrrhhitghksehlihhnuhigrdguvghvqeenucggtffrrghtthgvrhhnpedvtdejiefgueelteevudevhfdvjedvhfdtgfehjeeitdevueektdegtedttdehvdenucfkphepjedurddvtdehrddukedurdehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopeffgffumffvqffrqddvmfelvefkkefgrdhlohgtrghlughomhgrihhnpdhinhgvthepjedurddvtdehrddukedurdehtddpmhgrihhlfhhrohhmpehjohhnrghthhgrnhdruggvrhhrihgtkheslhhinhhugidruggvvhdpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdgslhhotghksehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprgigsghovgeskhgvrhhnvghlrdgukhdprhgtphhtthhopehjohhnrghthhgrnhdruggvrhhrihgtkheslhhinhhugidruggvvh
X-Xfinity-VMeta: sc=0.00;st=legit
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
To:     linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, axboe@kernel.dk,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: [PATCH] MAINTAINERS: Update SED-Opal Maintainers
Date:   Mon,  3 Oct 2022 14:25:11 -0600
Message-Id: <20221003202511.5124-1-jonathan.derrick@linux.dev>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add my new email address and remove Revanth

Signed-off-by: Jonathan Derrick <jonathan.derrick@linux.dev>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f9be379f5..5aad8c528 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18316,8 +18316,7 @@ S:	Maintained
 F:	drivers/mmc/host/sdhci-esdhc-imx.c
 
 SECURE ENCRYPTING DEVICE (SED) OPAL DRIVER
-M:	Jonathan Derrick <jonathan.derrick@intel.com>
-M:	Revanth Rajashekar <revanth.rajashekar@intel.com>
+M:	Jonathan Derrick <jonathan.derrick@linux.dev>
 L:	linux-block@vger.kernel.org
 S:	Supported
 F:	block/opal_proto.h
-- 
2.25.1

