Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2766E7F03
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 17:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbjDSP7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 11:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbjDSP7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 11:59:43 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7FA976C;
        Wed, 19 Apr 2023 08:59:33 -0700 (PDT)
Received: from [192.168.178.23] (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id B2BC1CCC24;
        Wed, 19 Apr 2023 15:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1681919941; bh=29YVH+wvkFvIAvk+OfYcMsg5UAxmZflvPbyzwpWUGyQ=;
        h=From:Date:Subject:To:Cc;
        b=duRjoaqxMd7KrFKsjgT67DBKCWOxdg/jdBNp7W8PhjFQdLnJ2R1R/lFMXgi8iUVF8
         aXOREQ1KusvTKm//ik6F5YjJ/Ar6EiuctAWb4XI/R2GXfIq87G/OBJBohMaYn81XVb
         ZwZtGYTsvGHj1mh3V1OhDCcDlNSmHPGb8kpwfO6Q=
From:   Luca Weiss <luca@z3ntu.xyz>
Date:   Wed, 19 Apr 2023 17:58:27 +0200
Subject: [PATCH] media: dt-bindings: ov2685: Correct data-lanes attribute
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230419-ov2685-dtschema-fixup-v1-1-c850a34b3a26@z3ntu.xyz>
X-B4-Tracking: v=1; b=H4sIAKIPQGQC/x2NQQqDMBBFryKz7kCMiTW9inSRxKkJ2CiZKgXx7
 h26fI//+Ccw1UwMj+aESkfmvBaB9tZATL7MhHkSBq10p0zrcD10P1icPhwTvT2+8nffMChjjTO
 2c/cBpA2eCUP1JSapy74sIrdKsv6fjc/r+gEiwFSQfAAAAA==
To:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1066; i=luca@z3ntu.xyz;
 h=from:subject:message-id; bh=29YVH+wvkFvIAvk+OfYcMsg5UAxmZflvPbyzwpWUGyQ=;
 b=owEBbQKS/ZANAwAIAXLYQ7idTddWAcsmYgBkQA/AGCGc9DMo94kVXJSlJG96EBN28m/8t+QV6
 UejZ8C/SLuJAjMEAAEIAB0WIQQ5utIvCCzakboVj/py2EO4nU3XVgUCZEAPwAAKCRBy2EO4nU3X
 VjHFD/49kidiQBIqLlqC+lb1EDiZ2QcJjSo5jVbuq06TLSkUJxLM2ualY8+mmAW3rbb94+Lcjkp
 RQI1df1oFgCjro+rKx2PaodK6J5OedHu20hdzYFnJX9iuYKpzTR4gkBmHEooL6tdTOTXWw7IvQB
 8ShoWNrVLXXyaEk1BaPimWKBHhuHmEOo2v71LOiYYRoOoAoMeDNPP0boDf6asKuwIBPGtkakqw9
 1FNpi1C5CP/UViBXYIXTUjgh52Rd4VII7X/HCsP1MnSawft6QrasAK7+VFY5Y8C+aIaGJrJPvII
 l+pv0cIhRKCpGPL2N41umQWDXL4HCZIIwuLkL5ELhbsX8lN3XSHwlCej3XESoE9S1mTO36YA5v9
 q4XSbP4xZuh300KwtNQKtY7niXiaS0ZXvcVuFJew9QCr2efnb5n3EwCe5egPiVTz/CrB/E3oJL1
 gRzWehmdQ8Z6mbCsFQzV2rSs3IwQBPn2Kkdps2kUTuIxO1FP7aYTo0Gncem/6ylOUrMl/OLBFNH
 ASh4RWAMtMJT6TA4xSQiydGWKzAABsuR5uYq0tRen131ntw4EaJCZyvXHZUsR9T+e1hlClZ1NMi
 OTEgJuM5DWTQl26Jb2jD1aiS1hYpKDO9zjZA2C/0ZoEdVjBitygDZVOXiB0tZj8KI5GcS80l864
 6ok4pzXgIsLs+Lg==
X-Developer-Key: i=luca@z3ntu.xyz; a=openpgp;
 fpr=BD04DA24C971B8D587B2B8D7FAF69CF6CD2D02CD
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When adapting the original doc conversion to support 2 lanes, minItems
should've been added as well since the sensor supports either 1 or 2
lanes. Add minItems to make the validation happy again.

Fixes: 8d561d78aeab ("media: dt-bindings: ov2685: convert to dtschema")
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
index 8b389314c352..e2ffe0a9c26b 100644
--- a/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
+++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml
@@ -49,6 +49,7 @@ properties:
 
         properties:
           data-lanes:
+            minItems: 1
             maxItems: 2
 
         required:

---
base-commit: 4aa1da8d99724f6c0b762b58a71cee7c5e2e109b
change-id: 20230419-ov2685-dtschema-fixup-b04549453978

Best regards,
-- 
Luca Weiss <luca@z3ntu.xyz>

