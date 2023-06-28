Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97C3741680
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 18:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232265AbjF1Qap (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 12:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232262AbjF1Q3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 12:29:55 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DD02690
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 09:29:54 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f766777605so8457343e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 09:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687969793; x=1690561793;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9eMvEkJ/XegETFODHiz62mk7KCxYtx3hl5+l1ieaHBA=;
        b=M2eG9b/rwLJbJ+ZYensGn99Z3sahqkhwgsICE+uWcaeCOhsMZixj0R91WrZhWHqvcT
         n077rgit6FDUr5nM+sZR6cA1yP9+24oT3o4DzuvO5+NGFm2ZSHsfTWKQSmmq2ClZweEH
         KU0lHXDJObPPbiBqKhxzrEB2ZPPFI8it67dn8IqsxVpiJmTQKFanRhkpwsx3UmQuQV6P
         FN0/+23yrw/BmMu+s+bAodxLNjgUYIK6dwYMMOG3TsEfZ5zhdfnvcisUm26xEq+oBd6v
         SElLQ5rIRNneoicmeE1ikfUOSowdZa11gUYoCWgqZo6j/h6BHzPhG0Fh1tzyJAUjIspc
         lUWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687969793; x=1690561793;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9eMvEkJ/XegETFODHiz62mk7KCxYtx3hl5+l1ieaHBA=;
        b=YoUrEgkrAD2IzoqD0VVrTy/9eUF3fLnhksa9JiHSZqEC2d9XcZ0fkMNl5E9ZiE1RsI
         khCQ5us23zhyu835TO/Wxz45mlExd3AVJhdS1Py/Ykr4QTJvSF2TiSa668ecZfkamCg8
         acsYvYM+WQyhwKQVLun0eKpvEW1eMgsJlgefSII5e9En5RUjhiU/v8SYj28FT59H8W+b
         pNYad7W2N62sVKM8Ptpgz5V9hXV9bkNxIGq/DfoxqjBwI1bjRlbw2FbJFbMTGEqK6BBo
         AebS07FU3Lfw1ZYm/uH2fABj1lDYYTSj9OFWs8xhHhmBNdFEYMbmO82qyQeqwillfQAd
         MAbw==
X-Gm-Message-State: AC+VfDzFTQSfXnaoP/Kewpnr8Y6HK+ztfo0GlSP5kbrKFzCFGxwg4WIB
        Uael9ZGA35fBIdzm9KUvCJtzgw==
X-Google-Smtp-Source: ACHHUZ51B3mrrRAOt7s7WF2oHJ0SQg/cpfsp3d3HETCr5iBgITcho1tWvUElbupu3H1F3zZdBZLC2g==
X-Received: by 2002:a05:6512:2024:b0:4f9:dac6:2f41 with SMTP id s4-20020a056512202400b004f9dac62f41mr6940702lfs.2.1687969792904;
        Wed, 28 Jun 2023 09:29:52 -0700 (PDT)
Received: from [192.168.1.101] (abyk82.neoplus.adsl.tpnet.pl. [83.9.30.82])
        by smtp.gmail.com with ESMTPSA id v28-20020a056512049c00b004faeedbb29dsm1678783lfq.64.2023.06.28.09.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 09:29:52 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 28 Jun 2023 18:29:47 +0200
Subject: [PATCH 3/4] dt-bindings: display/msm: dsi-controller-main: Allow
 refgen-supply
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230628-topic-refgen-v1-3-126e59573eeb@linaro.org>
References: <20230628-topic-refgen-v1-0-126e59573eeb@linaro.org>
In-Reply-To: <20230628-topic-refgen-v1-0-126e59573eeb@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687969785; l=919;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=PSg1b4zAMPXvW/Hco4OyLK9NQz9E7zBcyA/3he+DDzs=;
 b=+OPEQNKdq4VxxdpETYujbLytJ4CfZJo5uT5nocAXxJ+Eyh9ZqgvBwYThV/7U27B/FHOT38/Me
 IiuUpQ7aMsjCNHKV40ETBzW3EwM7J1JB/Vf8qqxL5H0O4LwU2c1qKah
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DSI host needs REFGEN to be enabled (if it's present on a given platform).
Allow consuming it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/display/msm/dsi-controller-main.yaml          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
index 01848bdd5873..76270992305a 100644
--- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
@@ -166,6 +166,10 @@ properties:
     description:
       Phandle to vdd regulator device node
 
+  refgen-supply:
+    description:
+      Phandle to REFGEN regulator device node
+
   vcca-supply:
     description:
       Phandle to vdd regulator device node

-- 
2.41.0

