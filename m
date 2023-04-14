Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFB66E1B5F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 06:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjDNE7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 00:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjDNE7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 00:59:08 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A3F44B2;
        Thu, 13 Apr 2023 21:59:07 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id xi5so42696223ejb.13;
        Thu, 13 Apr 2023 21:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681448345; x=1684040345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JYs4X/cHVaQ4OsoLQeKiZlQ/sz76dJL60RQrChG+avM=;
        b=MUE+EmqdKmfgI4I5aNbVYFhO87BatVBWQQRMy2LBUKj/auXVnR80y/rR3Ex84amKHA
         DU7eIt0EKDhI49FGNaHklV/NpJTHI7V5wOoyqpFCSGNOUdlIyafj7Om0HNfNLDv8aLuC
         EHk0Ar83DmZCn89YXoRjsAQzmssBDCSdqyfGF5+OvcZGQ5UutgPZCqNst/8oa78Dbgbe
         rHPtljSq9NguVoLAS0z8YdAt6oTP7Tdf5RnP6cERJgxsV40m7Lv5GgYmurxGZUIYTuOD
         sGFK4viYLOKWIgpr5uCseyZsGdZ7xn7Z2pKkKi52HL8s9kwfnAsS2SCeh0+vGoDe6vYT
         kXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681448345; x=1684040345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JYs4X/cHVaQ4OsoLQeKiZlQ/sz76dJL60RQrChG+avM=;
        b=SkEUzL5rT+N/JGJm3qAHXeLzQtZXA+PU/oqgx5KH57HytdEu+gp/ntlwTgMf41VmP9
         mTGwqw1LeDbpS/jnbp0zhJE170MItqQquup2WlZi4RerJqQWZ/Nv5CciryBFEFyfof/+
         CdYUsyJ05TMAgHbGgle4kzJMcW/G9r+vIbZB+Mg/xhNenCskiArZpsx3QVg9o95WQhDh
         253AIW204C+FvOAHsznwnC3MXcExbeNfplMKjXSnRwDNmbZy1XsPvrrl29U/3IgxhKE6
         OBw7vw6igmzrB+s+DvdYjTSRYI7yMv8JnsRz89j0UVa9GIx/gsWA1fOGy1CjOm8vrHGn
         /e7A==
X-Gm-Message-State: AAQBX9cD4c/HGDpOGdNYf30p1TjiqVZwzj9wdkuQodU4PudyV+Qe75Q7
        EFoAOfCX3fuyuSlfklUOEUiHx2+uQQQjrg==
X-Google-Smtp-Source: AKy350bvu0DNMbDQ4DT7gskdAsna8gD1Ujp/pq8fgr7712VXWm8+xybgxHbxElno2WmurNHS5kWeJg==
X-Received: by 2002:a17:906:9f0d:b0:94e:baaf:3c39 with SMTP id fy13-20020a1709069f0d00b0094ebaaf3c39mr2568345ejc.46.1681448345417;
        Thu, 13 Apr 2023 21:59:05 -0700 (PDT)
Received: from xps13.. (77.241.128.176.mobile.3.dk. [77.241.128.176])
        by smtp.gmail.com with ESMTPSA id h23-20020aa7c957000000b005066ca60b2csm1621979edt.63.2023.04.13.21.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 21:59:04 -0700 (PDT)
From:   Bruno Thomsen <bruno.thomsen@gmail.com>
To:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Bruno Thomsen <bruno.thomsen@gmail.com>,
        Stefano Bossi <stefano.bossi@gmail.com>
Subject: [PATCH] dt-bindings: vendor-prefixes: Add KUNBUS GmbH
Date:   Fri, 14 Apr 2023 06:57:47 +0200
Message-Id: <20230414045747.5499-1-bruno.thomsen@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KUNBUS GmbH created the modular DIN-rail mounted open source hardware
platform called Revolution Pi for automation and IIoT projects.
https://www.kunbus.com/

Signed-off-by: Bruno Thomsen <bruno.thomsen@gmail.com>
Reviewed-by: Stefano Bossi <stefano.bossi@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ed64e06ecca4..f5e48b49b208 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -707,6 +707,8 @@ patternProperties:
     description: Kontron S&T AG
   "^kosagi,.*":
     description: Sutajio Ko-Usagi PTE Ltd.
+  "^kunbus,.*":
+    description: KUNBUS GmbH
   "^kvg,.*":
     description: Kverneland Group
   "^kyo,.*":

base-commit: de4664485abbc0529b1eec44d0061bbfe58a28fb
-- 
2.39.2

