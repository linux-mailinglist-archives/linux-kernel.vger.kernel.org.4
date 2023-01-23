Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94462677961
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 11:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjAWKnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 05:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjAWKnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 05:43:12 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784ED3C29;
        Mon, 23 Jan 2023 02:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1674470590; x=1706006590;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ftrLOapE8X/AL1SAQ688IF8Fm8u4vt9qnGeGJj65ZsU=;
  b=jrr7J/3QHhAjT4sVhuBqvkrmEW4e9+4lohmJskDq8uPuz1vXOg556E/e
   yPrtzexOSfAUwz7i2uZV7KsYgB8/ZN2FMl76XENi1EILKNCWepnQLw6Kl
   bkODmtM8y3ZNKND9xazbVGW7srTgdjiyZT1N+IhJcfQya8sMlqnmSm30P
   zNLm8PZ5Fg1z0vjPGfBYJyhmkWO+zyp/0QFf85n9NnxZY7ZElYToRVNop
   iHJth9Nkl3vKRHbbTDfXElZEQzbu75S+LpEDqI079c0M6E4yN7UnZJf/S
   t9cKmbd7VRXV8CFT3yqxLoUwxb9RKoZc0xb2/5DdfxLoUj1GQAH6VhlR6
   A==;
X-IronPort-AV: E=Sophos;i="5.97,239,1669046400"; 
   d="scan'208";a="219870565"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jan 2023 18:43:09 +0800
IronPort-SDR: DR4jMV06odpn7JF+pohxiTwE7kTuYrVLineSBu80IrQk5HQuYRzlwBoT2dbgA/AtLNuuNgachz
 67r8wgT9/xeZkNkUcMJnSR2l/7w8smAJnie/LnGDRceIvS9oLHzwusVNOmJa+gQtIHDBAbnuDr
 YeY9NVD/sR3DVYr4QYlmGCWeNAjHKkrHghIsRQpu512Gt9kUY7ut++1DpuiWxJy1KD9FSAN1VL
 lQuQUU1ooeReZotYmqbjpm4Mh5L5FxC7iK3iQimhuS+WdMg7OlbQ+MRU/LlAIGW8OFZh+qeMFI
 oOM=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jan 2023 02:00:44 -0800
IronPort-SDR: CSSc5BTgEWfyuKxskiEVPQ0zdi3jTs7E/bTYPczVptwTHjILRHVbEkDLQGOGNtPpK+K7PC8u6U
 5K3nzt9JPK+NGikkDeRuc74BB54DAIgMfDyYZvzXnrnZqqRe4xGUHQG5uVnDzuE8kGl4fm6DVB
 hmOQCjd4T9UEQrtq/p+H81kBlb6oRjywN4OTJp7rLluwLObESrt+tw8zLPj9kUBjGINpHQos3s
 VAz50rNt3H7fQQsQSU0g55sMOrQw2Ef0sL/+B3YnaZokx+/0K+xW5nClJtMydCDGQeHNiNjJof
 wJE=
WDCIronportException: Internal
Received: from unknown (HELO x1-carbon.lan) ([10.225.164.48])
  by uls-op-cesaip01.wdc.com with ESMTP; 23 Jan 2023 02:43:08 -0800
From:   Niklas Cassel <niklas.cassel@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, Niklas Cassel <nks@flawful.org>,
        Niklas Cassel <niklas.cassel@wdc.com>
Subject: [PATCH] MAINTAINERS: Update qcom CPR maintainer entry
Date:   Mon, 23 Jan 2023 11:43:05 +0100
Message-Id: <20230123104305.44641-1-niklas.cassel@wdc.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Cassel <nks@flawful.org>

I do no longer have access to qcom CPR hardware, nor the documentation for
said hardware.

Based on past and recent activity, I propose Bjorn and Konrad as the new
qcom CPR maintainers.

Signed-off-by: Niklas Cassel <nks@flawful.org>
Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f781f936ae35..fe2606727966 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17261,7 +17261,8 @@ F:	drivers/clk/qcom/
 F:	include/dt-bindings/clock/qcom,*
 
 QUALCOMM CORE POWER REDUCTION (CPR) AVS DRIVER
-M:	Niklas Cassel <nks@flawful.org>
+M:	Bjorn Andersson <andersson@kernel.org>
+M:	Konrad Dybcio <konrad.dybcio@linaro.org>
 L:	linux-pm@vger.kernel.org
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
-- 
2.39.1

