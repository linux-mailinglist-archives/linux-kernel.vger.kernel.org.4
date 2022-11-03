Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAC5617D43
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbiKCNBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiKCNB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:01:27 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96B51408F;
        Thu,  3 Nov 2022 06:01:17 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id f7so2866887edc.6;
        Thu, 03 Nov 2022 06:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9sx36prwxLbye8vg1FZsE+HqNZsZkJYCt0cI8Qm494=;
        b=KTiaba50N29jX2UkZnmaka1xRvjrcNtTCGvO3h91tgkH3BhhNk0oyZ6V37fdBIqEoZ
         plMlJjWQGcfusNqMaPDp5x5FMjoyvADXYq1G8ibCspG4W+M26v2dD1vPqDPPz3mYRk+3
         REAtdTfrM98hIwqld8A0Rk2pYA/SAqctrMOXLwLhMxC5FQg1RRndW94RAphXBoLB6azU
         DRrF0Et2P7Oh86ZG+609nNg5n9iVHduxTxOV4k5w7uqrniiw1G5Y653rJcJeCUDU4ILE
         f8E83PR8pWVoGmBcM0ZYCYzeRw1+RVx3+/tsxnIZUbp3tQL3g4dglcMjfnc+NoMvXxq0
         qn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9sx36prwxLbye8vg1FZsE+HqNZsZkJYCt0cI8Qm494=;
        b=DEhXRS7in24pMvs6t2XKQSbeO+n7C295Tf2TMR1Oft62WPY8a5UBFOKc/mcOf65EsT
         TFSkx8dy39S+tI6bmlgqtG+5FOcJy1XnhGV3Obl8tXQcx2eY5dD/kh8me1ZyQZHvf/15
         Ed61+CfDIddJph16AHfM/Ige3VzEFBmUpLChDK7Fr2FH5aL9Pucq7v3xsmP9rwVjHp6A
         qs3U7LFlsc3HSFS+BkOoNa/l/3zoiAScITtnnT//CmgtFPKjMAuKOtqLb7PZnznbTmDa
         rMx0nvUpd+erMDmqWdSfN/0B+POOty1guU7IgQpC8036DbCmo7VSuCxMTQVp/++uPOhA
         NzEA==
X-Gm-Message-State: ACrzQf2dkVDT7h2FlRHhjJspSJXa3+peBkm225L2KJAo2I5hGs0ySuaI
        8mcDBCyhd3Yjis8/Y9UDpTQ=
X-Google-Smtp-Source: AMsMyM4544HZ76Tphf61ukxzTc2C9Oij+slH/HIi1GJQHThrY/UDu9jklvdIez5gXI4jvYq4dSKCqA==
X-Received: by 2002:a50:ec0a:0:b0:461:c0ca:a0bc with SMTP id g10-20020a50ec0a000000b00461c0caa0bcmr30078641edr.306.1667480475556;
        Thu, 03 Nov 2022 06:01:15 -0700 (PDT)
Received: from localhost.localdomain ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090676cc00b00779a605c777sm451829ejn.192.2022.11.03.06.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 06:01:15 -0700 (PDT)
From:   Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: [PATCH v4 04/13] dt-bindings: iio: temperature: ltc2983: remove qutations from phandle ref
Date:   Thu,  3 Nov 2022 15:00:32 +0200
Message-Id: <20221103130041.2153295-5-demonsingur@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221103130041.2153295-1-demonsingur@gmail.com>
References: <20221103130041.2153295-1-demonsingur@gmail.com>
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

From: Cosmin Tanislav <cosmin.tanislav@analog.com>

Not needed, so why have them?

Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
---
 .../devicetree/bindings/iio/temperature/adi,ltc2983.yaml    | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
index 29f6fa5e2529..6b3a20448f78 100644
--- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
@@ -112,7 +112,7 @@ patternProperties:
         description:
           Phandle which points to a sensor object responsible for measuring
           the thermocouple cold junction temperature.
-        $ref: "/schemas/types.yaml#/definitions/phandle"
+        $ref: /schemas/types.yaml#/definitions/phandle
 
       adi,custom-thermocouple:
         description:
@@ -204,7 +204,7 @@ patternProperties:
       adi,rsense-handle:
         description:
           Phandle pointing to a rsense object associated with this RTD.
-        $ref: "/schemas/types.yaml#/definitions/phandle"
+        $ref: /schemas/types.yaml#/definitions/phandle
 
       adi,number-of-wires:
         description:
@@ -288,7 +288,7 @@ patternProperties:
         description:
           Phandle pointing to a rsense object associated with this
           thermistor.
-        $ref: "/schemas/types.yaml#/definitions/phandle"
+        $ref: /schemas/types.yaml#/definitions/phandle
 
       adi,single-ended:
         description:
-- 
2.38.1

