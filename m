Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE09D643AEB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 02:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbiLFBnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 20:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiLFBnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 20:43:51 -0500
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1958F12AED;
        Mon,  5 Dec 2022 17:43:51 -0800 (PST)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1445ca00781so9136062fac.1;
        Mon, 05 Dec 2022 17:43:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WE/56drUub5l27DT6adFLlBDy7V4AZnT7PqdeQupGTI=;
        b=LOxdVg5k8AjYuHzwS3QyJDswbWnei6bn4kCqMJdjvMDiSNPYGAEJ6Ajw4wMR2VSK9/
         sxg5lwhbksm/rXlov+gtAQNk7bu3fYrDer3geTjKjwVQmePAmEhuCMWoTXtAmI8tlfzO
         gRgnWshiebqPzMoCLqqUzvmS0aD421ZQTxlSrt61idOgwBJX+sjc8vd5Ls6K50+mr9+X
         mna3OWSrq9N8b3DzHBgOgKUNMc63vrl55vHtgXRG5B+UfhcrCmSeCMs5wAUQm9qeA628
         TkOC05qcnnfWgxvCIKkJToMScyF/MRsxit2rcBYAzZx0b2dtFs72m0zMfHpye9NRRrWd
         mTJg==
X-Gm-Message-State: ANoB5pnBi+EJ27WiZm84dJOOWzyVBbZiqq6I2ng4sDPOpoZU57mS9G/K
        U3F9NQtPk7EiFYcstOW9oaVweH2fPw==
X-Google-Smtp-Source: AA0mqf6KtQSHv2VW8CORYTaiJzjyq9QpIzlg3AWtrSvtcvOefZLnjzHUKgkZI/Hs/sX4+jzk837utQ==
X-Received: by 2002:a05:6870:3a0a:b0:144:c192:d9fe with SMTP id du10-20020a0568703a0a00b00144c192d9femr1116053oab.221.1670291030279;
        Mon, 05 Dec 2022 17:43:50 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q4-20020a4a3304000000b004a3543fbfbbsm509618ooq.14.2022.12.05.17.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 17:43:50 -0800 (PST)
Received: (nullmailer pid 3117258 invoked by uid 1000);
        Tue, 06 Dec 2022 01:43:49 -0000
From:   Rob Herring <robh@kernel.org>
To:     Ilia Lin <ilia.lin@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: opp: opp-v2-kryo-cpu: Add missing 'cache-unified' property in example
Date:   Mon,  5 Dec 2022 19:43:43 -0600
Message-Id: <20221206014343.3117101-1-robh@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The examples' cache nodes are incomplete as 'cache-unified' is a
required cache property for unified caches which an L2 cache certainly
is.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
index a202b6c6561d..27412c2cfc0f 100644
--- a/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
+++ b/Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
@@ -106,6 +106,7 @@ examples:
                 L2_0: l2-cache {
                     compatible = "cache";
                     cache-level = <2>;
+                    cache-unified;
                 };
             };
 
@@ -140,6 +141,7 @@ examples:
                 L2_1: l2-cache {
                     compatible = "cache";
                     cache-level = <2>;
+                    cache-unified;
                 };
             };
 
-- 
2.35.1

