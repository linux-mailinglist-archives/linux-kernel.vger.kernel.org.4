Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953F46AA43E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 23:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbjCCWZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 17:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbjCCWYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 17:24:22 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F1A6702C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 14:16:56 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id s11so15943710edy.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 14:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677881747;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jhGUt/9ikay0wTYED+3dM9XZOHe6xmGcq8vv+hJG3wQ=;
        b=wbLL4JeX2NLWfzjFi6/3gm9XcUgeHgP9XfRIiR3GatkWbcfMYP3NjIJYQGgOblC6NE
         Wnotnq28RaVNmmuog+tjVAdCJmV5N0OOrO9fkvrcauTq4C1nLr1NO2O7qk1kHcKnNeuT
         mL6ai/kF+ws/jHSSm9E73WZ0shAud6hChY7+LqG9Us3tZ/AMZWJJogh8qzpZ07BSPZGd
         K5zTKLItu43utT57LP5jw4mtKdwpByFDJR3SpIZBahIkPtKMYsHxPKK9k50GOT5kRdx4
         wuDuSFSNj5qE0mlNguHHpliArRokgkSnShEBXLRnPApvSrmDYxcmLQue5279C3d53MUD
         MiBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677881747;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jhGUt/9ikay0wTYED+3dM9XZOHe6xmGcq8vv+hJG3wQ=;
        b=goNelwJGJKVv5SBZsbY/FIoS4xAkwIKm11f1Kgv2ImxrCg2WK7XPHQtOaLimumgorP
         lLLP7ymSd22Paho4vPNAe5K2N3lz/5jFs6vrVz7Tt4sAojeCaiRv3shr7+c62U9HeG4h
         SMyNFkB5pwZktm0LzNDEP8mFPfn4l3DBy4NZOEsex7c85YPi89POfr6L/aVTgrHth7cY
         0HZzifyTl3oBSnTU1pcgkdS+nujawCGBwBFv4QN7DvMfbCWgrhP1unVZzWoxylZ7HwVP
         DBeM4+SqDBRmcqXmHpjMkxONOqZJu/Fp2uaLrNZMq4H0VLW8w7vvK5SeVIOolHQ5WVFD
         MFvA==
X-Gm-Message-State: AO0yUKUaQFTtMhCvP3tBDWhhyLGEHWHFiBdOyBP7vqH+D6F84IoF7mqn
        Y8/lUAQP4D5+c5Asx8Epuyaxhnh7oe8CKGpwVkQ=
X-Google-Smtp-Source: AK7set8pPjvldoS8xXTKdDcigJ9ekZ/v6oJanh8BYj0ZKLtRmyIkKc1mwDwannJBT4gGPqDdYCaXpw==
X-Received: by 2002:ac2:5582:0:b0:4db:2876:f9aa with SMTP id v2-20020ac25582000000b004db2876f9aamr1003092lfg.68.1677880694430;
        Fri, 03 Mar 2023 13:58:14 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id e27-20020ac2547b000000b004cafa01ebbfsm552670lfn.101.2023.03.03.13.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 13:58:14 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 03 Mar 2023 22:58:02 +0100
Subject: [PATCH 02/15] dt-bindings: interconnect: OSM L3: Add SM6375 CPUCP
 compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-topic-sm6375_features0_dts-v1-2-8c8d94fba6f0@linaro.org>
References: <20230303-topic-sm6375_features0_dts-v1-0-8c8d94fba6f0@linaro.org>
In-Reply-To: <20230303-topic-sm6375_features0_dts-v1-0-8c8d94fba6f0@linaro.org>
To:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677880689; l=926;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=3kDftpNu/Ozls1NqMhqLW9oX8DcWVaXf4fhj5FEZN3g=;
 b=X36jcdTP0r3fGsHBtrklmVLjJUipWiwhCrV1ouBP4WX74fvOr6l46fLr0hR9NdVHr1Z0tc8K9pEO
 iPI5qPGDB1C/WTTNfpN/J94euo176d2KctXe7SL56uAW+gk9GQd2
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM6375 has a CPUCP block (which for all Linux can tell is really rebadged
EPSS) responsible for scaling L3. Add a compatible for it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
index 576992a6dc5a..9d0a98d77ae9 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
@@ -29,6 +29,7 @@ properties:
           - enum:
               - qcom,sc7280-epss-l3
               - qcom,sc8280xp-epss-l3
+              - qcom,sm6375-cpucp-l3
               - qcom,sm8250-epss-l3
               - qcom,sm8350-epss-l3
           - const: qcom,epss-l3

-- 
2.39.2

