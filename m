Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB66A69C0A2
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 15:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjBSOU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 09:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBSOU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 09:20:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516B8EF8D;
        Sun, 19 Feb 2023 06:20:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0223FB802C8;
        Sun, 19 Feb 2023 14:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2BAC433D2;
        Sun, 19 Feb 2023 14:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676816422;
        bh=FB3Y/kfHLJ/r2h8QI0rWOOJJsPc/twutba2eFYVvvT8=;
        h=From:To:Cc:Subject:Date:From;
        b=a5jEy1stwoReIxzO1ESQUvYgyztINiIvV+tbGS+B5I5c4Et2ODKf1+EHFDwpg1rJw
         SN5ORhEQnqEW7ww4ylr6cAAoKxMjbB5cEevDUKejq54IcwZSdBYQ02S7Nl0Lu2S7FX
         rNGxMoX+AMTLpaOOTnd+HTDZY/q9MpKhw2NL4JBmPrrW4FvrPWqqmGwwKcHt9ZWQI6
         nApsnYw+85eOn1PQF2CiZcfRNPjIakg18IzaxrRax2xSaCCrBMJWO1tK/0BvuS96UL
         2nCFnQFmyt79bUX8oLQ+RABBwju3mes16uCVdDOITAlIzreQRfPs3RTiFchNcLLX5O
         lQu2SQvgf+tOQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2] .gitattributes: use 'dts' diff driver for *.dtso files
Date:   Sun, 19 Feb 2023 23:20:11 +0900
Message-Id: <20230219142011.2309026-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
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

Now we have the third extension for DT source files (overlay).
Give the diff=dts attribute to *.dtso as well.

While I was here, I merged *.c and *.o into *.[ch].

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - Slightly shorten the code

 .gitattributes | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/.gitattributes b/.gitattributes
index 4b32eaa9571e..3471356b2387 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -1,4 +1,3 @@
-*.c   diff=cpp
-*.h   diff=cpp
-*.dtsi diff=dts
-*.dts  diff=dts
+*.[ch] diff=cpp
+*.dts diff=dts
+*.dts[io] diff=dts
-- 
2.34.1

