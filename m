Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2A16BD1EC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbjCPONN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230466AbjCPONH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:13:07 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C04618B2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:13:04 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id y14so1843968ljq.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678975983;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LOCr/dp56x8yfPg236tQnpLOuN8kndNbHP2o7x5RuGY=;
        b=Lc5KcKlhDqHl1KpuuZ5W/BnHDClDtmGbyEhuFN4hZOfZ9bBf7AybyTkPQP6acCDk0R
         xzM+c6wqXxJEobg0Doo9IL43MP54R23YEd4gcmN98ufUr65okpYDbxZhaxEcgEeAbztC
         52xVsAbOE8CHnWzLYFc7D8LFa1iIJ67q3080VG8pH5UR/05IvRt7lB18tin793Ao5AzS
         E+JAL6rFweGo8cKtN3n1pa2Y3QKbuZIEpmzbvm8fmv0NZtLT5VJJAowjNQC7PJE4pxWl
         PtXb7ViNNvLLQzMhkaLGwHk5isGRJibcHQ105pe+StMNpF2HninSAWfNu5r2FLWOxxPZ
         jbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678975983;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LOCr/dp56x8yfPg236tQnpLOuN8kndNbHP2o7x5RuGY=;
        b=FWDJVsWHFUP1v4LAHhIN4G3u4zP8H0EZ0bmdN6mQiKOW7BVMWpSWD/yLxzoE93rmxj
         4j7qKNZbZXvKPCwyoPk1B8UZATrVNrv+Pdd04e7F1oLJ9LAZwclbjawOXd214UrZkpfN
         e0m2KPJrcOOCxolnfYK+cekJ32FPiymaNZWN/ytTv3xVuUg3wOofKZhxPM7347iwXXDG
         GR+crSeVSbjTwcbBHpZl/dmFRJ9jlFcV+rSm0oFdRQQ0/Vl3K97sx/dk3aVg1hDKrQdT
         p6l5zJYT0NGS7o1rqhQV7svll4CWq1QgyGKSL9QBswOuhEogEpkip9DQ/51rDCdRfFzh
         vOAw==
X-Gm-Message-State: AO0yUKWQ3SMz9dRq43hYrnz0toCPFH2jjvXOre0uvKwGcSJA2rF9QpEX
        i9uuONDSHAuMPGZx3RTC4JiF0w==
X-Google-Smtp-Source: AK7set83wVWsxOA+7q+2KuVzmbpaqw5DKO4c5CtIJKIJi3/iEalYzjMBNHw0lq5cNzgNDxd96vigHQ==
X-Received: by 2002:a05:651c:1993:b0:293:5f35:d68f with SMTP id bx19-20020a05651c199300b002935f35d68fmr3014299ljb.31.1678975983034;
        Thu, 16 Mar 2023 07:13:03 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id a9-20020a2eb549000000b00295735991edsm1261639ljn.38.2023.03.16.07.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 07:13:02 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 16 Mar 2023 15:12:51 +0100
Subject: [PATCH v2 02/14] dt-bindings: interconnect: OSM L3: Add SM6375
 CPUCP compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-topic-sm6375_features0_dts-v2-2-708b8191f7eb@linaro.org>
References: <20230303-topic-sm6375_features0_dts-v2-0-708b8191f7eb@linaro.org>
In-Reply-To: <20230303-topic-sm6375_features0_dts-v2-0-708b8191f7eb@linaro.org>
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
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678975978; l=1087;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=T2UOT192UwWYD42jhZA6LPQhbEe5pwQ77s6b/5s/QFI=;
 b=dZYzKfGZGus6e9MJbhUWopp854ldx9ddjnWZSnzdTnqz5qI1VR7IgwTWMT8ycCzFTlctd6pn0S4u
 oS5Uv1p4BxViuyMsoJvaQKwRm80YQXR1ZmH+qAPqtkcxBIktbFfM
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM6375 includes a CPUCP block responsible for managing different APSS-
related tasks, such as scaling the voltage and frequency of the
components within the ARM DSU cluster. Add a compatible for the L3 cache
DVFS scaler within.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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

