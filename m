Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6A3626391
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 22:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbiKKV3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 16:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbiKKV3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 16:29:00 -0500
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A455F14D23;
        Fri, 11 Nov 2022 13:28:52 -0800 (PST)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-13bef14ea06so6734648fac.3;
        Fri, 11 Nov 2022 13:28:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0bHkUTUyhnUWblPSY7Vk1oCHAcUZEF1ZecefasIeWrk=;
        b=vAH+upY4i5CloFUaJeof0FZLJe93FW4qtln1NCqNU0fszppmtTl2aBptQ/Mpjg1+kG
         aSyJ23Kb6nyO34Xt3MUdAjzDejLL69n84//rxTbjBsvdj2/L3Z/ZmIsonT4+ppabfkBD
         f1KDDNW8gBLzJ4EYYl/qIsL9V1ouBeR//D+p7TmPUNrAnSZJcvloS6bg+Qxmr6+eknXH
         X+a6F2CYPCG1hLkRLChPksufnIpGQd/kJjhxGkhPTrWxC3xVC1tfTQrijU/aTlfT2IMV
         HOCOImzIs3SnCgyQpbwZDq7XnbfcWr78XGNGhMj9ktKvOXH5flaQR9sNQRCfdtd8oDoH
         UQuA==
X-Gm-Message-State: ANoB5pk15whrH/fIocE1FBSuoIiuITaqx+TkN5LbPdyhxgIMJycBRwMM
        YnOqZzAxBcvkFXn7cI/7mHohLGRauA==
X-Google-Smtp-Source: AA0mqf7oOrVOnnJdeIvis7NmPa3kpHLUadgHo2lC5hsNZhiwHV9ekfCzvBUWLKJ1W0pgYxxZQ1s3eA==
X-Received: by 2002:a05:6870:a111:b0:13d:9bde:b315 with SMTP id m17-20020a056870a11100b0013d9bdeb315mr2057022oae.141.1668202131886;
        Fri, 11 Nov 2022 13:28:51 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c15-20020a056808138f00b0035173c2fddasm1232714oiw.51.2022.11.11.13.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 13:28:51 -0800 (PST)
Received: (nullmailer pid 4104218 invoked by uid 1000);
        Fri, 11 Nov 2022 21:28:53 -0000
From:   Rob Herring <robh@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: iio: dac: adi,ad5758: Drop 'contains' from 'adi,dc-dc-mode'
Date:   Fri, 11 Nov 2022 15:28:46 -0600
Message-Id: <20221111212846.4104059-1-robh@kernel.org>
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

'contains' applies to arrays, but 'adi,dc-dc-mode' is a scalar. So drop
'contains' from the 'if' schema.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml
index e49e7556175d..4e508bfcc9d8 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml
@@ -102,8 +102,7 @@ allOf:
   - if:
       properties:
         adi,dc-dc-mode:
-          contains:
-            enum: [1, 3]
+          enum: [1, 3]
     then:
       properties:
         adi,range-microvolt: false
-- 
2.35.1

