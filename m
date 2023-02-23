Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB6FC6A0A91
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 14:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbjBWNei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 08:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjBWNeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 08:34:37 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A5DC30B0D;
        Thu, 23 Feb 2023 05:34:36 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id h14so12990229plf.10;
        Thu, 23 Feb 2023 05:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YucSFMzOaP6rQ1I9goNSPpJZR4YBxlBHlZdkbdFqLc8=;
        b=cUIt+J9nKvD9QMd1RX5Pz4xsSRT/RvVz0OVBkVtGy3HKG7GXFyxOg4RDaQ8HFfcfDz
         nLLV5kRZCti4vkSpPW3HliZ0neKtfl9FLdrGioCYLnIdtb30lAHVc2jYPoakhBbfQ7rF
         NBUllTgmlK3+i0C7GekuBIvSbqrNtLcsOZUZIPgyOeedzNKjWZA2iE3ldiJjzhWvfk4X
         Som7WefNtlHu14J8qzaUA00ZRTA0dYDOHnl3WXo7Ptf0/jJO+W/wG2wLgw7XkmI58uFe
         /atl7Uww/k3xUV59cQ/sxptIgES2NPPr1CyoVGb+BAgfzmpyosVUS9dg5j9OnVHC+tFf
         Vu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YucSFMzOaP6rQ1I9goNSPpJZR4YBxlBHlZdkbdFqLc8=;
        b=jpnfEr9srjWNfR1aGm3ucqZzGeCFKe06WcGEIxVQr1rjGhTVGea8aG5kwNnmhTVh95
         0kMRbNjIJZY/X04dl5Dh++jPhk/MV9UFuzLrJifQtx6qylXOZb8GamYONp0LLEA1emhe
         vZQ76+RyU4bEGA4v9UBd6f3/G2I1SvPYHMofoqgWqOSvMxdx1TyQEhBccS+Rg3/UUJNe
         +bRHSTrwllQcIVHoV7B0ejMtr3Z+JPUK5IucYLOjxyUN6dl2EbkL07+TP1CQqmGaCFBE
         ikYCSuCTH4DwHiEvMmw0z+ULKfnhlAYAL7B3D6z1dILdLRsXr/BZyM5ijAsGt/qb6EeX
         s+3A==
X-Gm-Message-State: AO0yUKW9Il7FBeGxRqmpmuse2AbvyAeDLfchC7HTBU3c68+IPIXIITQd
        AQsfE/LK0JZjNT7iAfRAhuV1WtvjphY=
X-Google-Smtp-Source: AK7set+lS/+q0ucop5kqa68ZtSLRGPJcJV1s7Jqd2yr8Ei5wPLgofjxOLQB+EClMwVRg4A4WYs/7QA==
X-Received: by 2002:a17:902:c40d:b0:19a:8284:83a2 with SMTP id k13-20020a170902c40d00b0019a828483a2mr14378142plk.10.1677159275487;
        Thu, 23 Feb 2023 05:34:35 -0800 (PST)
Received: from localhost.localdomain (M014008005000.v4.enabler.ne.jp. [14.8.5.0])
        by smtp.gmail.com with ESMTPSA id t13-20020a1709028c8d00b0019a96a6543esm6030254plo.184.2023.02.23.05.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 05:34:35 -0800 (PST)
From:   INAGAKI Hiroshi <musashino.open@gmail.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     INAGAKI Hiroshi <musashino.open@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH 1/2] dt-bindings: vendor-prefixes: add Internet Initiative Japan Inc.
Date:   Thu, 23 Feb 2023 22:25:01 +0900
Message-Id: <20230223132502.2045-1-musashino.open@gmail.com>
X-Mailer: git-send-email 2.39.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Internet Initiative Japan Inc. (IIJ) is a developer of network equipment
and a provider of network-related services.
https://www.iij.ad.jp/en/

Add a vendor prefix for it.

Signed-off-by: INAGAKI Hiroshi <musashino.open@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 85bb190cdd2f..ddb31e2078fe 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -601,6 +601,8 @@ patternProperties:
     description: Integrated Device Technologies, Inc.
   "^ifi,.*":
     description: Ingenieurburo Fur Ic-Technologie (I/F/I)
+  "^iij,.*":
+    description: Internet Initiative Japan Inc.
   "^ilitek,.*":
     description: ILI Technology Corporation (ILITEK)
   "^imagis,.*":
-- 
2.25.1

