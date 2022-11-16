Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC05662C4CA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 17:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237845AbiKPQik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 11:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbiKPQiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 11:38:11 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B719A5E9E8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:32:29 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id n20so24817002ejh.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 08:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1QOj2w1cuKEuCIniHGOx+eV8LLJOHngxV7TUVqDlP5I=;
        b=u2k7Aq29+rEZRuq5H9ipwm5MwIJyfeSnavYzCbkSR9sRcej5GhYU7gxUCwFnNRXOwu
         cOeAxAiSan/C9H+9EzluRSKGEbbdZd6Y3cf5ck+dK4fm4E4Z8GSuOY+Xgy/N1G8tqzTl
         aDuRuoDAZiJEMaghbnstJRqW+IByKbn7exB6kMzRdpYqIZhyUNjuwqt4wdHuFPHa8uow
         YraOE1CTGUZcqDYovZ1qetd8lK79fd7kFoZHfoAeRYo4GyPKb6eaby4vcU8jfZXx/fNR
         JhKwb7S/Qcnn9Sulgb0GCCykyBjNiz+sm0GGGD9egaJr8ltxpCYQVK9cpma1vSOR7A7C
         zMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1QOj2w1cuKEuCIniHGOx+eV8LLJOHngxV7TUVqDlP5I=;
        b=CAPBY6+eJDHkLaZC5An7FT5mJ5pgXj3u4uqRpfwmWIYvcQQr0jAhaRgE9M4mkgb7Hq
         2q4Oa23M/7cmlIdTlGI5A1VihYr6lq+GxTkcdIVJMXrP42vw1tNs4IlkT0yYkXBgSewg
         /aj7pd14m+DR2w6G9PDhBKYsqX7ujyPBHYiPcigiBWzBG8UKQwycy/ZQy0q6F3tnsqLw
         V39zDvW56NaaIdsMpOX4ZLkUrAh/h7ru5a2Ss4N1Du3qBN3eAXzi5SHq3ZzRzUeFSmIW
         HeSm+ZIR8EYMZXonoixM+3IYwSpK2CNt+fGAubPiHq4oGBis95Vm4VanE9K9CzSbfpjK
         2Ocg==
X-Gm-Message-State: ANoB5pkWT1FoYYLe1Xj/sCPjzQUWXE6SXFOn0TslO+1i4QKm/TjDdVJ3
        YTM8So3xwyZfBAGR+xE2V20AWg==
X-Google-Smtp-Source: AA0mqf4jxfP9I6wfX2k/5npoUZddyBUv0XsHwgJSeKCwsjhDVGtEdz+uFqYxcGQVmf4awiHn7Q/UFg==
X-Received: by 2002:a17:906:c18b:b0:789:d2fc:41d1 with SMTP id g11-20020a170906c18b00b00789d2fc41d1mr17987998ejz.642.1668616348355;
        Wed, 16 Nov 2022 08:32:28 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id hw20-20020a170907a0d400b007add62dafb7sm7082093ejc.5.2022.11.16.08.32.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Nov 2022 08:32:27 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: msm/dsi: Don't require vdds-supply on 10nm PHY
Date:   Wed, 16 Nov 2022 17:32:18 +0100
Message-Id: <20221116163218.42449-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
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

On some SoCs (hello SM6350) vdds-supply is not wired to any smd-rpm
or rpmh regulator, but instead powered by the VDD_MX/mx.lvl line,
which is voted for in the DSI ctrl node.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml b/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml
index d9ad8b659f58..3ec466c3ab38 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-phy-10nm.yaml
@@ -69,7 +69,6 @@ required:
   - compatible
   - reg
   - reg-names
-  - vdds-supply
 
 unevaluatedProperties: false
 
-- 
2.38.1

