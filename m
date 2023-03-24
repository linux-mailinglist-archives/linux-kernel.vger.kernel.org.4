Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1BFE6C7B64
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 10:29:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjCXJ3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 05:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbjCXJ2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 05:28:54 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A3730F3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 02:28:53 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o24-20020a05600c511800b003ef59905f26so502262wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 02:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679650132;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rm2CqI1B2hHOJ8Hl9EI4NwacgguNWTWv0kuPmfPl+UI=;
        b=t284nf1k9sv2iMsS86WPPjUxEiH7BfXG4hgg1nU4y34toO5vT/a29fpKktjfH8TRsX
         WKS6kJIznte2assEdru4gLMRsF3SWOdyLZVAPvXs43YUPEJ6n/F3NeWexEsAsRSwLrjw
         yUe0h3iuWuWqj/y+rA/I6HWd8vBmb0mOTGWWwN4mJBYJW4HB6pZNgUEubzJjcRK3VcDd
         iO6F6pGXhkfM8SABVu1qJyxt6EVoCVNfLUy6euuvpGLWqWgVRN60CyjxP2KyXqqYLg5m
         w0cnrdp2AZ/VPL9p0K2LTKSn0J6qztMZzMMnWlY3wkduF9xXg2lB1uQz9pWgTv7ClySz
         PlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679650132;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rm2CqI1B2hHOJ8Hl9EI4NwacgguNWTWv0kuPmfPl+UI=;
        b=MWkhyCgoWrSbzMzC6I5yV2FNl+5YSAAubkePcfCdx2vMdsrDFxyAVnTBs5tvVMVvJx
         jKKWUkScfDVu/2r3ru8sxxBOtQ4sRpsUQFgCInsfVGAG8OrOv212GtAiHgxwjpRjsWJp
         EI7E1G3WIk2ETMJ47D7FApitavGluLGDto+MPbS30DEm+FoqV9Mmkjr0QpEiU3edv8Ui
         Kr42Vj0lCrAXp7Nbrhbho1bmakcNktPiyMnEOJKVHAz3FNr1lr+Oxx3WGptAyi2FNxsp
         kMJRr7gXKxStp7EA7RtJpjoAxXVpZFUYz9ROZll1kVjRPEed4SD6wLP8ZaAx/ZyuqEbQ
         LZ3A==
X-Gm-Message-State: AO0yUKWuo+iNIcmmqZHTPvVfVJyPzjpuF5NKZgBEGTgU6uydJrH6BSj2
        b+UmYuOTzH0HvJu1PK+2nnwNRdn+dmmGLuAfDsRRjw==
X-Google-Smtp-Source: AK7set/KO0ZKtP+ZNvxHzZXCh5+l/McQL+zEOhxzhknt4p1EcpvbrKTkz/jkNtk7LgYtfkCuZ5V61A==
X-Received: by 2002:a05:600c:28b:b0:3ed:5cf7:3080 with SMTP id 11-20020a05600c028b00b003ed5cf73080mr1917189wmk.5.1679650131787;
        Fri, 24 Mar 2023 02:28:51 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id v14-20020adfe28e000000b002c5a790e959sm18029980wri.19.2023.03.24.02.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 02:28:51 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 24 Mar 2023 10:28:47 +0100
Subject: [PATCH v2 2/4] arm64: dts: qcom: sm8450: remove invalid properties
 in cluster-sleep nodes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230323-topic-sm8450-upstream-dt-bindings-fixes-v2-2-0ca1bea1a843@linaro.org>
References: <20230323-topic-sm8450-upstream-dt-bindings-fixes-v2-0-0ca1bea1a843@linaro.org>
In-Reply-To: <20230323-topic-sm8450-upstream-dt-bindings-fixes-v2-0-0ca1bea1a843@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following DT bindings check error:
domain-idle-states: cluster-sleep-0: 'idle-state-name', 'local-timer-stop' do not match any of the regexes:
'pinctrl-[0-9]+'
domain-idle-states: cluster-sleep-1: 'idle-state-name', 'local-timer-stop' do not match any of the regexes:
'pinctrl-[0-9]+'

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 78fb65bd15cc..ff55fcfdd676 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -255,22 +255,18 @@ BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
 		domain-idle-states {
 			CLUSTER_SLEEP_0: cluster-sleep-0 {
 				compatible = "domain-idle-state";
-				idle-state-name = "cluster-l3-off";
 				arm,psci-suspend-param = <0x41000044>;
 				entry-latency-us = <1050>;
 				exit-latency-us = <2500>;
 				min-residency-us = <5309>;
-				local-timer-stop;
 			};
 
 			CLUSTER_SLEEP_1: cluster-sleep-1 {
 				compatible = "domain-idle-state";
-				idle-state-name = "cluster-power-collapse";
 				arm,psci-suspend-param = <0x4100c344>;
 				entry-latency-us = <2700>;
 				exit-latency-us = <3500>;
 				min-residency-us = <13959>;
-				local-timer-stop;
 			};
 		};
 	};

-- 
2.34.1

