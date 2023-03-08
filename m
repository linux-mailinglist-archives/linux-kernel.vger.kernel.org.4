Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E476B0CCF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjCHPc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:32:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbjCHPc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:32:27 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B609ADB6E6;
        Wed,  8 Mar 2023 07:32:20 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 88D64FF80F;
        Wed,  8 Mar 2023 15:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678289539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kNiQMRKKx1J0SGYw53QECnkbm/nX4KdsySOgD3rc51A=;
        b=ValhiiyM6SrLcoaOkM/zLc3zSvIrFPsSi3EARKIksMyS0+MUjkweSlzGiCM+ExWEznf+QP
        PspMCW7aXdpMsaUEOj0R5BHSRwlyb6Yfa9mQWbJJbCJIX/o+EAH9QshOvovWEE3aYem2nb
        wzwp1xPwquUnPXXAv97IUOp+ZsLVYT7ggvQb1NUXkEHyX8R7fXw2oVFe3pp9QrHZtlpN5+
        MEgRtSZK0YB7fm/1Nvjvlmo5bOQgDRMH7hnrfcALLUe9ph1ErPt+6sXpTCYYHH7NquSTyQ
        iu68y8atPAAtonP0CvDcfv5EbrKG9DQ1OnGtI3JunJz2axuqhSESvS99osDrUA==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        Colin Ian King <colin.i.king@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 08/20] dt-bindings: nvmem: Fix spelling mistake "platforn" -> "platform"
Date:   Wed,  8 Mar 2023 16:31:48 +0100
Message-Id: <20230308153200.682248-9-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230308153200.682248-1-miquel.raynal@bootlin.com>
References: <20230308153200.682248-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.i.king@gmail.com>

There is a spelling mistake in platforn-name. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml      | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml b/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml
index 5a0e7671aa3f..714a6538cc7c 100644
--- a/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml
+++ b/Documentation/devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml
@@ -61,7 +61,7 @@ properties:
     type: object
     additionalProperties: false
 
-  platforn-name:
+  platform-name:
     type: object
     additionalProperties: false
 
-- 
2.34.1

