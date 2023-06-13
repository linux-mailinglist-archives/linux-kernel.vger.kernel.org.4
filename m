Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A22E72EC8A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjFMUKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbjFMUKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:10:32 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEAB11FC7;
        Tue, 13 Jun 2023 13:10:23 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-77af8476cd4so149590739f.1;
        Tue, 13 Jun 2023 13:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686687023; x=1689279023;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=exFjk9YFmKjn7DoaqlYF8HkermSR0gG7YSmA9ZFUaQg=;
        b=gbWVsSaqXUKazCLL8VFVG9t7MxKh19QMZ1e/1t+lCSoiQbeRmjV0G0xyPimJg4x86r
         Q8X1XWE3QPxEwuc/Kw8jhclw9ZZiayPP/cJ9IkG3X0l6Uc30HOsxywQRBR6BdbHRCkLp
         uoPgelUIjxUJjYr4DxDTg11vMKg+VtFWJnyOzq9I2uGHoRlPmV2uLbwcxPk4EJ12d+Sm
         FS6GSfnmw0mxdxI/WrRMNh0yc+zhb0IGl6J4t/6K9d978O7LUL+Iq3j4PO7j0XcKifHx
         VipAUA3PskhiLACdfJ1DNDxnCufjHBvYqhw7nDtD009V8ql8pXuJvRjmwNFMCo9OVjKu
         gqaw==
X-Gm-Message-State: AC+VfDwoa2gBnOZiT79mvkvl8x+A6POsmnTIOy+aD23RlqpVSa/oMLCp
        lTMz39p/1lNd++2Iku0AkQ==
X-Google-Smtp-Source: ACHHUZ4Pk+jA7WRJB+MQQATfRhL3bfkT++75DkNeNxkkrB7Myk6RWS7rs/nRHqI0HCTmrjKdglzKyw==
X-Received: by 2002:a6b:ea08:0:b0:774:9394:b473 with SMTP id m8-20020a6bea08000000b007749394b473mr12621972ioc.7.1686687022923;
        Tue, 13 Jun 2023 13:10:22 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id q15-20020a0566380ecf00b0041684163ee1sm2462910jas.146.2023.06.13.13.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 13:10:22 -0700 (PDT)
Received: (nullmailer pid 2823344 invoked by uid 1000);
        Tue, 13 Jun 2023 20:10:20 -0000
From:   Rob Herring <robh@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: mtd: partition: Add missing type for "linux,rootfs"
Date:   Tue, 13 Jun 2023 14:10:14 -0600
Message-Id: <20230613201014.2823185-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"linux,rootfs" is missing a type, add it.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mtd/partitions/partition.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
index cdffbb9cedc2..1ebe9e2347ea 100644
--- a/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
+++ b/Documentation/devicetree/bindings/mtd/partitions/partition.yaml
@@ -55,6 +55,7 @@ properties:
   linux,rootfs:
     description: Marks partition that contains root filesystem to mount and boot
       user space from
+    type: boolean
 
 if:
   not:
-- 
2.39.2

