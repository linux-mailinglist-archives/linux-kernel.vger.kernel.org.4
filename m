Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BE566D8A5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 09:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236228AbjAQIuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 03:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236233AbjAQIt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:49:58 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6813193DD
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 00:49:54 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id j17so3115095wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 00:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Km72Ozc/Vyrr+VItW0cIHsd+mEJlhUZtzVcHQEBHbFs=;
        b=n4vNbGfK5yIRIrJ7BDPqX63H6uYWeoZyYRGtVklWvA9PhGfM3w7Ee+JhxK/Sl4zc6H
         HPN04G4R0M0gvg8RWqPkTL+gXCRONRFd/JnKiZDKyTSuE8ZK8d5ezCL+0Ls4OEtmrw3t
         EtJsvGVvlfYftDXeQAZWOpNFdEjMQgFdOPaiT1BQrm38mQaaRbWutoC0M5vxmFEAkaqB
         o8r8OhRTqZ3q0YLTeJVAiWaOQQif5AOLtyPFJ5Nzqtj3/QkfWGmCshaLmZZ7yx/eoFoa
         raojrixCerAWcnK6YqR8KQA+liKnjfrzDE9dkqjQHSHfaYseHsjeh45hDUJh1/RZa3pK
         rqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Km72Ozc/Vyrr+VItW0cIHsd+mEJlhUZtzVcHQEBHbFs=;
        b=Cg0wxIYjyKNVQ0V4eXJJOJcjxxg1IUSOwvXmNgpyIYftllbxnACIQXSYkk/5/F0KlA
         U0YtiCYMzbezWjkFe+O0e8fq8DnspXect4CBpQHq3ZDShh3KMXPh9CVpOW5ujGo2sPM0
         phs9ucAbw2QF26tQ3H7wdjdNY3XgQx23QVMJIXqon00yvze7n6oJENSICJ1dM4CjsZdA
         ff92kGaVIfE+N1XAsfo2IiDV1moZKS1wjNVPoBOjyFb72skjnGeJ+9oBNmvFE3zQ7Mr7
         2mNXY0v2tRNENzUa7n1jFb/K6C+SirdTWvP7WTJWRrZGhvkVp8AhG9T3CXVMPk9fX3Mc
         WWtQ==
X-Gm-Message-State: AFqh2ko/2JXBaLsCK2VDl9EuQXkgtkeqSFsyn9D66NOC+ijjEKU2G5nq
        9EqXDiLKy94kptP2lQebfUaDVw==
X-Google-Smtp-Source: AMrXdXu9bt+xPzypGl/F+mIIgonOm1sPTgpGAOgsT1pbkfhhzXESU+etGoaF9tltTxf7OMxdMv8YSA==
X-Received: by 2002:a05:600c:4b9a:b0:3da:fcdc:cafd with SMTP id e26-20020a05600c4b9a00b003dafcdccafdmr2228805wmp.13.1673945393232;
        Tue, 17 Jan 2023 00:49:53 -0800 (PST)
Received: from [127.0.1.1] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id i14-20020a05600c354e00b003d1d5a83b2esm45040928wmq.35.2023.01.17.00.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 00:49:52 -0800 (PST)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Tue, 17 Jan 2023 09:49:39 +0100
Subject: [PATCH 1/4] dt-bindings: i2c: i2c-mt65xx: add binding for MT8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221122-mt8365-i2c-support-v1-1-4aeb7c54c67b@baylibre.com>
References: <20221122-mt8365-i2c-support-v1-0-4aeb7c54c67b@baylibre.com>
In-Reply-To: <20221122-mt8365-i2c-support-v1-0-4aeb7c54c67b@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>, Qii Wang <qii.wang@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-i2c@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=964; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=0qPQE4yGfoxCGQFTIge9uLlrCOrdE3u8zE/R7eutZWA=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjxmEuhQT6QRyWEmit8/G/GCW6H47F2HxOTGT1ZSuo
 cCY6uaaJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY8ZhLgAKCRArRkmdfjHURfVYD/
 wPXcEZODLRlSW4k/1YFHhTcK/f/a+xBbyKmw7B+fxBkQshi6gAAca4Vx1oQP8hItEnTBMh1H0MjQrk
 cuom0S7kl6s2OSi99RSu0Jm6lNzfEYsuqy0goln16eaBQWfHegUSut6ijRDixWoR0dI2qspXDlTGwE
 D4+A2ziNmP6ZWD1b8Io0wn7Zj+jOobK0ua+K4QJamBy607Ud5yIDdujnxd49aByRs2M6vq3+VFNGK2
 w2hR7m/kcjOFKJBaTKPRH2qqy8q4g6XnBlywN3UddrYZd3AX78aili1D2Nz5iRQfxbS4QUyuIhOi/h
 STjL9hoD7IFDAVHme3rCR1pivB3P6yJ4MeTD8Qq1abKY9EVn8IqGClDKkUt5kwdepHbNKT5HZeEXVM
 AJsd0f58rNZ9a9Z7Ch5oLrfEHfAl+w4huIGNe7gOxG+C+hubVq5wC5ITKA3DzYM/WC5s9d54L9TN9i
 JQvddXyndMunjjA5QHEH/MP3m2tqQ8/Yaawx2MjJzHLdRnUZ6nqPrSHOYsNdI/5+doCYK15T2Hn+JZ
 Vwlw4tj2pzfCBfOveUX2c3cGCQ0UJnZ4yaS6d8X8kiEw4hQlrtoZIQn0DFNsliEde1L8nkk0pcHvPU
 jDsePkJb43AtoIavas5keLUwk9oe26laD4onZtjTszzuuJZyntve4KFxoeMQ==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Parent <fparent@baylibre.com>

Add binding documentation for the MT8365 I2C controllers.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 Documentation/devicetree/bindings/i2c/i2c-mt65xx.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mt65xx.yaml b/Documentation/devicetree/bindings/i2c/i2c-mt65xx.yaml
index 421563bf576c..72ae2e01cf22 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mt65xx.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-mt65xx.yaml
@@ -41,6 +41,10 @@ properties:
               - mediatek,mt6797-i2c
               - mediatek,mt7623-i2c
           - const: mediatek,mt6577-i2c
+      - items:
+          - enum:
+              - mediatek,mt8365-i2c
+          - const: mediatek,mt8168-i2c
       - items:
           - enum:
               - mediatek,mt8195-i2c

-- 
b4 0.10.1
