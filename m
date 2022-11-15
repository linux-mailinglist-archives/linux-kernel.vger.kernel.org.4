Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48099629D39
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiKOPUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:20:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbiKOPUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:20:10 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBAEF2D1D8;
        Tue, 15 Nov 2022 07:20:09 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id x2so22367061edd.2;
        Tue, 15 Nov 2022 07:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zHKFp4Zv5CVjtabEP39vE06DfOwlzuV6r4Axs6FpoFA=;
        b=B0wo68rV6SQCMqa8nmCYfzq9lPHIK+/pb+dfyMj0M+1H1WN88OQaLvEuXBrop8MsYU
         aBZREh0subeFpKoniosRAZcSq7vPZpLXf/L4nI6/SuIJzOSiLEoYrvPkds/16q4o2Thv
         zpd4GgYdhNKTEhOm6a44IVBr/Br+DHBNRWI4GO1YuC7CseH7GLNgT27430vLOsyNddoW
         PBMA8zUTrOXEClkkd2WWnBCSwpOxrLkUctG80V2zaQNxXErMlvcox2ayRRe5l5RUoVHD
         r4TUGmzJhABSOJAIydAMUtE8nuwmONjvwaexFFnr+1mRXwfxWIVUeraXJU7iXOUqpE/I
         X4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zHKFp4Zv5CVjtabEP39vE06DfOwlzuV6r4Axs6FpoFA=;
        b=GvfKig5KwFyS35Ky3OdkE74KhSIXrPybZKfVDKR0dODTr8nLyue7Dd1+TmlcGUeXvu
         y7x4ASiwcebKuUWmK73DmFWw/a3y4vKJbpN2ykDMENxOTKHkpMPxmRrize5Htic+JkWg
         rAxnBtvDFWOHpzsHYqP/jioJmudfKBOrsxcHFf/viF+xVt+JRqXF0QuN8lFmXqtZFPNB
         hmlTQ1K7gq3EOACy50dPf6KGeWfImkNnDzeP+ix2tGGjYcrGkVDYECJ3VybEcd9Ax5F+
         vcoP5Lq8bGJPUQKuSkNBjnBFPSxulvzJ/I9YVzIkVGs5cY0JutWLN9N1MBb2J5p0Uhgm
         MA5Q==
X-Gm-Message-State: ANoB5plZ336o1XChhdILImOPkSF7YOUYLJptkWJrrDzNxTLE/VBhth0b
        AUQkkfWE7OXZqQzCVfvLoB0=
X-Google-Smtp-Source: AA0mqf7w1WRb3wluumbypK8INPQl+HGec6+C8VLH5trnxvZ5TPCT/fb07a7GQtW/NQdt+c4KCb/R/w==
X-Received: by 2002:aa7:c0c9:0:b0:467:a8cb:10c9 with SMTP id j9-20020aa7c0c9000000b00467a8cb10c9mr10477759edp.123.1668525608389;
        Tue, 15 Nov 2022 07:20:08 -0800 (PST)
Received: from localhost.localdomain ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709060cc900b0078ddb518a90sm5648350ejh.223.2022.11.15.07.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 07:20:08 -0800 (PST)
From:   Cosmin Tanislav <demonsingur@gmail.com>
X-Google-Original-From: Cosmin Tanislav <cosmin.tanislav@analog.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: iio: adc: ad4130: use spi-peripheral-props.yaml
Date:   Tue, 15 Nov 2022 17:19:55 +0200
Message-Id: <20221115151955.394030-1-cosmin.tanislav@analog.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reference the "spi-peripheral-props.yaml" schema to allow using
all SPI device properties.

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
index 28ebd38b9db4..d00690a8d3fb 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
@@ -190,7 +190,10 @@ patternProperties:
       - reg
       - diff-channels
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.38.1

