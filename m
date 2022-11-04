Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BA5619D80
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 17:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbiKDQjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 12:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbiKDQiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 12:38:46 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBCA31225;
        Fri,  4 Nov 2022 09:38:43 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id DB6B3C0011;
        Fri,  4 Nov 2022 16:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667579922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:  content-type:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PH1TaWI18OK/TWX9eI82Zyj07sQxLoh1aLVV4ESIk3Q=;
        b=SLh2eLlfTwj2dq8weIWYhj9eufTMcwyCVjLoNGaJy0mY3UKlduSu6IfqCJABSeyVD/40Co
        Dn/v8MmHHvRigdRxEdWOMTv1myK7fp3FJB+8EcKQNY0CPzVHcECfV4HFuBaP68yCRURLdh
        ISSrMP2LYlfAakrpBdn2eGFfvmu+SRxqcEjw1+Re4H5NOTmqNUu3KZq4p5UXK/a+eyasYe
        iNQdFn2wRQBlsmGr++iKEFHeyMHQUi1qqf2ePQ45xlJdyn9yxTNOonlSDjCA1XidJa2Yg2
        AQ2PyFoMIwgVzqCNrJXuwoSjtAZiHZdCQUQUuOl2tcYN+NiQSEgg8ydgBIud9w==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Christian Eggers <ceggers@arri.de>,
        Cory Tusar <cory.tusar@pid1solutions.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 5/6] dt-bindings: vendor-prefixes: Add ONIE
Date:   Fri,  4 Nov 2022 17:38:32 +0100
Message-Id: <20221104163833.1289857-6-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221104163833.1289857-1-miquel.raynal@bootlin.com>
References: <20221104163833.1289857-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As described on their website (see link below),

   "The Open Network Install Environment (ONIE) is an open source
    initiative that defines an open “install environment” for modern
    networking hardware."

It is not a proper corporation per-se but rather more a group which
tries to spread the use of open source standards in the networking
hardware world.

Link: https://opencomputeproject.github.io/onie/
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 6e323a380294..65a74026cf2b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -927,6 +927,8 @@ patternProperties:
     description: One Laptop Per Child
   "^oneplus,.*":
     description: OnePlus Technology (Shenzhen) Co., Ltd.
+  "^onie,.*":
+    description: Open Network Install Environment group
   "^onion,.*":
     description: Onion Corporation
   "^onnn,.*":
-- 
2.34.1

