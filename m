Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40180641EDF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 19:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiLDSdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 13:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiLDSdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 13:33:33 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661BB5FBF
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 10:33:32 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id s8so15356783lfc.8
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 10:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p4HiZrmP91AmMj4d8UedSi3BmABLAWdvsExg9IBBapU=;
        b=kQkwigcLVDD4q086rMvI559/ptg+3bu09/+yhIn7hJTF9nfRU2bZZZhxSE+cXpCes0
         6zdbGfizeRvWP7LzJBR7Kq30Yc8lyIPO1QN0mGhFc6/x2TNnXDqD7nFe+iCWtXELKrsk
         0r+rgxtvbBSvxYymvSBW+OjBApmyFtno8zrORqvYLGUVqsU6tR2fxCWd+q6NlIJczSub
         LqpDeu8Z6KvfPXZHLaUm9yYJMUyK1eg5aBJ46aggu1+XWpGnGQHGXmDcUhhCIqHdLDAE
         DHiieNZlwrSYrrVTdOcIVhTJd+X0/3GudVK3pQxRczBerqNm/YCRntNKnD8xqG9GdzET
         PVUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p4HiZrmP91AmMj4d8UedSi3BmABLAWdvsExg9IBBapU=;
        b=Q1greuDaK75M+twaF8KBzM4Il5RiZADV7E20i6541zm5HFdMu5N0EX14+MqjiCo3Al
         EVU4woKKgZtWYNizPo2Xf+RrjSM0YJiNJZFn08Xp05Ab5EwN+vhoIKci0JRWMv+TFUvh
         h3DN4icBmy8hAn7UgsM4Req3BYxyYYKRRKdLmfKvOk3aHsdsy6PuAYf15d8GZRaluAMV
         Dk1SI6eRyt0sPy8w9rLnoP3Vn2HnHMPpOTIm+PQX823rkzoF/XHt7PUUPlyD+Ql6yRHr
         rKnuJHVXsiTpVugQRN/knvFBxCs/8AEEPMFz76QJ+OuT1/q5iX9zgNYvZBBuWs876iOC
         HBsA==
X-Gm-Message-State: ANoB5pmSphZwkr5hw2lCiaUpyRHw+nBZYPnMghEAz4BfdeBcVx9MlgH6
        4Dpl2zlUZqSHwL/TVbNGGkwAEw==
X-Google-Smtp-Source: AA0mqf5moR5qk2MbOUrHN9+Z5FjC6mU34oMB2642J9yC2PKvMo8TCGuiGmwoBdWY7Q2L6eU2cs9S5g==
X-Received: by 2002:a19:501c:0:b0:4b1:82c6:295b with SMTP id e28-20020a19501c000000b004b182c6295bmr24947891lfb.67.1670178810840;
        Sun, 04 Dec 2022 10:33:30 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id b8-20020a2eb908000000b00279c4736f51sm1191529ljb.127.2022.12.04.10.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 10:33:30 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] docs: admin-guide: media: align HDMI CEC node names with dtschema
Date:   Sun,  4 Dec 2022 19:33:26 +0100
Message-Id: <20221204183326.139876-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The bindings expect "cec" for HDMI CEC node.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

See also:
https://lore.kernel.org/all/20221204182908.138910-3-krzysztof.kozlowski@linaro.org/
---
 Documentation/admin-guide/media/cec.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/media/cec.rst b/Documentation/admin-guide/media/cec.rst
index 5c7259371494..14ec3ff317c2 100644
--- a/Documentation/admin-guide/media/cec.rst
+++ b/Documentation/admin-guide/media/cec.rst
@@ -340,14 +340,14 @@ and IO24. Monitoring the HPD an 5V lines is not necessary, but it is helpful.
 This kernel patch will hook up the cec-gpio driver correctly to
 e.g. ``arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts``::
 
-	cec-gpio@7 {
+	cec@7 {
 		compatible = "cec-gpio";
 		cec-gpios = <&gpio 7 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
 		hpd-gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
 		v5-gpios = <&gpio 22 GPIO_ACTIVE_HIGH>;
 	};
 
-	cec-gpio@8 {
+	cec@8 {
 		compatible = "cec-gpio";
 		cec-gpios = <&gpio 8 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
 		hpd-gpios = <&gpio 27 GPIO_ACTIVE_HIGH>;
-- 
2.34.1

