Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18795F427B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 13:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiJDL44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 07:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiJDL4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 07:56:48 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF691CFCE
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 04:56:47 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id f37so2442585lfv.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 04:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=jko8CACmQdyH7KyTrf/qnIJsFbwoqds1JxVgFKlDoJI=;
        b=eqMZrlTZoKxHhQtUEUf1645E0mKMAjbR7pCLbL1nG/4vORnzhsn4r5YM1uk+cNtZgS
         5+pAIR04kpZM0kANkSzdAICYh/Z7WpBsRsjhUT5PDZmxJCtMwwV6yFrujojsXUCgkD4l
         k6IjIZMsQrNUSBMymlYgAh8j4Ri2WnONfIVADvaiH/kMg94W03faoDZ99kwCow0/o15e
         YydCkEXWXVCcn+jUUBdhzYJhZEgZnlTaERIQiUBXCGWgXxDtt1YeK3qlkFNKKf4tE9E5
         Zuf/TQA/KNXTyciBOS85G3k2eiY0ZTOunmxfiNSyrZA4ranKlDd+qXE7bzRKmkgdQTow
         Yqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=jko8CACmQdyH7KyTrf/qnIJsFbwoqds1JxVgFKlDoJI=;
        b=KU93kHi6ubhfEfFCoXjz2oatZEiCHFl6fwEQBHCsGZ3Q4eDmKzu40TzvGUndtaKnFw
         j/mA/H+n5VtQ2iexzzC9wwiWDT6VvIvvoFWp6O5wa62MBWJUkcTDgMj/3By0vDgFAYsh
         kvcU30PWpHtTqo9R6wjFGnHRFLjrFGU8uX11NxpVRxQMHS76/fK6ln18p9jBcI6xaOE0
         lQN0JOTxiAvTvsG8R+nbVwATglI8QMGnV3WqImNBn1hW8+8WYCGOWatrq3pFNUBBgVZ5
         zpTFLEsCDSwhGeC8DEp8lXTAXAk5eZaFbICQO+uVigWqw5TBvp0g7nZUl6RKSC5RcePl
         wWZA==
X-Gm-Message-State: ACrzQf0cc/0vPPchsmVrhdhxVxnEcauzDkqWTDIR5KQj21Uqz1+lgEKl
        owr2mO6iDRkiRHkty+urTsbagg==
X-Google-Smtp-Source: AMsMyM5TiCfrSWojaKL8yKcKCS4JnJI9c+RTAWdhLYBoUWbuT2QKjcuB1gsdR5aAxRK/k6oedqd3lA==
X-Received: by 2002:ac2:4e88:0:b0:4a2:2fa8:9bd8 with SMTP id o8-20020ac24e88000000b004a22fa89bd8mr3737735lfr.621.1664884605512;
        Tue, 04 Oct 2022 04:56:45 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w8-20020a05651204c800b004a03fd4476esm1878971lfq.287.2022.10.04.04.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 04:56:45 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Nishant Malpani <nish.malpani25@gmail.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Nuno Sa <nuno.sa@analog.com>,
        Cristian Pop <cristian.pop@analog.com>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/8] dt-bindings: iio: addac: adi,ad74413r: use spi-peripheral-props.yaml
Date:   Tue,  4 Oct 2022 13:56:35 +0200
Message-Id: <20221004115642.63749-1-krzysztof.kozlowski@linaro.org>
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

Reference the spi-peripheral-props.yaml schema to allow using all
properties typical for SPI-connected devices, even these which device
bindings author did not tried yet.

While changing additionalProperties->unevaluatedProperties, put it in
typical place, just before example DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/iio/addac/adi,ad74413r.yaml        | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
index 03bb90a7f4f8..2e8dad9278f2 100644
--- a/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
+++ b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
@@ -58,8 +58,6 @@ required:
   - spi-cpol
   - refin-supply
 
-additionalProperties: false
-
 patternProperties:
   "^channel@[0-3]$":
     type: object
@@ -103,6 +101,11 @@ patternProperties:
     required:
       - reg
 
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
+
 examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
-- 
2.34.1

