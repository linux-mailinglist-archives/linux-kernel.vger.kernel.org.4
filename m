Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFA26D6E67
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 22:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236345AbjDDUuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 16:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236326AbjDDUuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 16:50:20 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C23B7;
        Tue,  4 Apr 2023 13:50:20 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id l18so25186782oic.13;
        Tue, 04 Apr 2023 13:50:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680641419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whW3z4bTfKVvXB+tqmvO6N+K4v/ynODppCdzbzwFkuk=;
        b=lLs5sBfal3O3O39GTctJ3IwqOea2SgRXL6nSOqVEdNXhCcRcuUcIQE++f4RUlxjIN+
         QoK1I2EScYjXYucCzDscGHDLhbvTsHqK8BTZCoVzTVWgJWJvBZIm0WwGobiY0+ejlnXW
         oSv+DFX4/wySX6yk45TlKNTC9U95pP7tXWNza2ts3sqltn85TW4QQjFFqvC9njHPxFaC
         34a7FCGBZZ8lhaMCql5HSSbUmiNswnHg8NGG/wsHn3N0qxMTG0F4Y47w+zjtOdFDKF2m
         0+BD1OVMj++dGX5nlduVFB69O4PHHojmA/6XHqvPMLwYSrgUHUKY7hAnta3ryH/VZFhh
         fdjw==
X-Gm-Message-State: AAQBX9cHcMNFOTWSmlIjto5Gy4lcrchGx3jCeqVb767YG68Xwo3f6xLl
        3StJAkjHDzCxp37ncEujUA==
X-Google-Smtp-Source: AKy350ZGY4Gq8rqUno/qIE5NqYr/8S8BjM2PulPS2I1ezrdDu1OCZ9o51R5T8hMfIboqblERIqzz9Q==
X-Received: by 2002:a05:6808:1a8a:b0:386:c7b4:461f with SMTP id bm10-20020a0568081a8a00b00386c7b4461fmr1769272oib.59.1680641419214;
        Tue, 04 Apr 2023 13:50:19 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r204-20020acadad5000000b00383eaf88e75sm5645144oig.39.2023.04.04.13.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 13:50:18 -0700 (PDT)
Received: (nullmailer pid 644432 invoked by uid 1000);
        Tue, 04 Apr 2023 20:50:17 -0000
From:   Rob Herring <robh@kernel.org>
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: iio: temperature: ltc2983: Make 'adi,custom-thermocouple' signed
Date:   Tue,  4 Apr 2023 15:50:14 -0500
Message-Id: <20230404205014.644336-2-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230404205014.644336-1-robh@kernel.org>
References: <20230404205014.644336-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'adi,custom-thermocouple' property is signed based on the example
and driver, so it's type should be int64-matrix rather than
uint64-matrix.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/iio/temperature/adi,ltc2983.yaml        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
index e04f961ab92c..dbb85135fd66 100644
--- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
@@ -127,7 +127,7 @@ patternProperties:
         description:
           Used for digitizing custom thermocouples.
           See Page 59 of the datasheet.
-        $ref: /schemas/types.yaml#/definitions/uint64-matrix
+        $ref: /schemas/types.yaml#/definitions/int64-matrix
         minItems: 3
         maxItems: 64
         items:
-- 
2.39.2

