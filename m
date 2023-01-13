Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626226694D0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 11:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241404AbjAMKx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 05:53:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241318AbjAMKxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 05:53:12 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5155559FE;
        Fri, 13 Jan 2023 02:51:33 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sendonly@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 6F5D84246A;
        Fri, 13 Jan 2023 10:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1673607092; bh=A2h7FS9AJveuBG3f5UyHHSkomslFvPl7IFUApfSLWMk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=xyLudfF3SSpo3ECqJvj5Hi8pOwBb7KLucNJ3AaAYPm3EYOUrEeZ0p9W3YFTmzhMvo
         qX58ZE3QLKkag6q5Dh3rn+ZFj1tApyDTe7xnWkS5gO4pn0VPal8tHuXiLJBNY+WVin
         sgxBc037JhT62inxYIK0FA6V6XLR7Udh1YTDRiGvMAdnzrE2maSAsQpScpBm03iVet
         yhoZpT1J/NUB5u4CGizFm1K/2sA+sP/2z7PYfWt632uiWoAh+EuoX/uIOodpmbPnWl
         EpHiW8mQpf9Ijr2ObyGcFjh1pfIO4bEZ+ajf5sB0m+E0+99AlKS1qZVqcwQPCyewGE
         EJYXmjqFb+jpA==
From:   Hector Martin <marcan@marcan.st>
To:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Janne Grunau <j@jannau.net>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, iommu@lists.linux.dev,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/7] dt-bindings: iommu: dart: add t8110 compatible
Date:   Fri, 13 Jan 2023 19:50:24 +0900
Message-Id: <20230113105029.26654-2-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230113105029.26654-1-marcan@marcan.st>
References: <20230113105029.26654-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

t600x SoCs use this DART style for the Thunderbolt ports, and t8112 SoCs
use them everywhere. Add a compatible for it. No other binding changes
necessary.

Reviewed-by: Sven Peter <sven@svenpeter.dev>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 Documentation/devicetree/bindings/iommu/apple,dart.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/iommu/apple,dart.yaml b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
index 06af2bacbe97..903edf85d72e 100644
--- a/Documentation/devicetree/bindings/iommu/apple,dart.yaml
+++ b/Documentation/devicetree/bindings/iommu/apple,dart.yaml
@@ -24,6 +24,7 @@ properties:
   compatible:
     enum:
       - apple,t8103-dart
+      - apple,t8110-dart
       - apple,t6000-dart
 
   reg:
-- 
2.35.1

