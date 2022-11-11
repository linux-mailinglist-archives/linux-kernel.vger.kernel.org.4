Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1A062638B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 22:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbiKKV2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 16:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbiKKV2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 16:28:46 -0500
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0ED10B5C;
        Fri, 11 Nov 2022 13:28:42 -0800 (PST)
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-13d9a3bb27aso6683626fac.11;
        Fri, 11 Nov 2022 13:28:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a9IWXVJO7FCfYbdDLeNc5y7EDDRr0wMjZ75A9nG5cpU=;
        b=zk9iDq4DRkff3JSjfKAxYmgG+ul2MoD2OevOaqoJ+jGaGW4AomCRh5CixCMBxptHB1
         gvgVetrBQPmagMTdYDH/RjUfFbmHfSMKp3vBY/pvgPanV+tkplucARzkAfao3XQQEGpK
         hVNJe2d6byVFEHWuSU6nvZ/7sLtOuo+9PY7SyRxiL1gDfhwlLG7EJ5F9ixYwWbj7eVGJ
         Wv/lu2m5NnTASx5CPWN2dFpui9b/FJWTN00dRAwRCG5d4Ckm1VZtWHVpxH9rV+jAi4j4
         wfaGQztcyq4Aa5tGOfeaXMf1j3/s5mO52dTOVznFrB0nsaGQ4S5Td4cy6oeyfTRKh6yt
         px2g==
X-Gm-Message-State: ANoB5pnR4Bq1xhK/JzAjbEL1ZYFDGQLr8zxe+Hy7izNUrFINSdnRJFh/
        N5xOP8OfMpN3iMbMeEd6oO/cMFHLrQ==
X-Google-Smtp-Source: AA0mqf7qza00MxfRDpxW6kAteViq0Xda0ZdehJkcfO/3K+a/O01/4Wv8KeSIDtxEH1rNIHYOfRtLsg==
X-Received: by 2002:a05:6870:ac88:b0:13b:29b7:e1a5 with SMTP id ns8-20020a056870ac8800b0013b29b7e1a5mr2017586oab.100.1668202121401;
        Fri, 11 Nov 2022 13:28:41 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g4-20020a9d6a04000000b00637032a39a3sm1433579otn.6.2022.11.11.13.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 13:28:40 -0800 (PST)
Received: (nullmailer pid 4103969 invoked by uid 1000);
        Fri, 11 Nov 2022 21:28:42 -0000
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Peter Korsgaard <jacmet@sunsite.dk>
Cc:     linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: serial: xlnx,opb-uartlite: Drop 'contains' from 'xlnx,use-parity'
Date:   Fri, 11 Nov 2022 15:28:38 -0600
Message-Id: <20221111212838.4103828-1-robh@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'contains' applies to arrays, but 'xlnx,use-parity' is a scalar. So drop
'contains' from the 'if' schema.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/serial/xlnx,opb-uartlite.yaml          | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml b/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml
index f7617b88c7c3..2f4390e8d4e8 100644
--- a/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml
+++ b/Documentation/devicetree/bindings/serial/xlnx,opb-uartlite.yaml
@@ -67,8 +67,7 @@ allOf:
   - if:
       properties:
         xlnx,use-parity:
-          contains:
-            const: 1
+          const: 1
     then:
       required:
         - xlnx,odd-parity
-- 
2.35.1

