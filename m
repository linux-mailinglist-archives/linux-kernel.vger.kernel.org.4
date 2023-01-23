Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0508A6775B3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 08:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjAWHhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 02:37:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjAWHhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 02:37:50 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A172A2738
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 23:37:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1674459414; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=ENFX1yHNWKJt3MvijNcFGzW1KEGk49LqiDlRgJARj7tNqg1v6DaVslLorO9/t6BMjqHYbQFWpElwYiDFMgt693Kbcz/SthGgBcLi8ombCVnPVMyOm8mLC2HeL1NFIUaSfdGGDDkKaFdL7A+1RjvIVCi0nh0GUdDOlhvvYgNvRSc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1674459414; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=1BtIJKfLM92e7NVeISj8Ye8jiXofJIV0qJHWd0Dlm8s=; 
        b=GKctKxEIdZVt2XuGt+N6MFu/CJr/mFQ7qA3iqdY0hr2ASwA8n5IG9WTamxQne+MWo7c1/RGnce2LFsCGqCgLLDNKXwVE5BAt4G9z+qFyfrxOBOrP/6bwWmcYXNvN+vjfAb0QZ9nFfoXIYyI7N+AFpiwS0O1mKhzYCTvFN+7QS6o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<lchen@ambarella.com>
Received: from shbuild9.ambarella.net (116.246.37.178 [116.246.37.178]) by mx.zohomail.com
        with SMTPS id 1674459412452324.8123027854384; Sun, 22 Jan 2023 23:36:52 -0800 (PST)
From:   Li Chen <lchen@ambarella.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Li Chen <lchen@ambarella.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 02/15] dt-bindings: vendor-prefixes: add Ambarella prefix
Date:   Mon, 23 Jan 2023 15:32:17 +0800
Message-Id: <20230123073305.149940-3-lchen@ambarella.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123073305.149940-1-lchen@ambarella.com>
References: <20230123073305.149940-1-lchen@ambarella.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for Ambarella, Inc.

Signed-off-by: Li Chen <lchen@ambarella.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 70ffb3780621..97bfd98fcae1 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -89,6 +89,8 @@ patternProperties:
     description: Amarula Solutions
   "^amazon,.*":
     description: Amazon.com, Inc.
+  "^ambarella,.*":
+    description: Ambarella, Inc.
   "^amcc,.*":
     description: Applied Micro Circuits Corporation (APM, formally AMCC)
   "^amd,.*":
-- 
2.34.1

