Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521986AAAFC
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 16:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjCDPzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 10:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjCDPzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 10:55:49 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9A61EBF4
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 07:55:46 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id i28so7418308lfv.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 07:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677945345;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jvBErRoqm3lY280h1zXnp9L55kLV0ZvERd9QGERMZk0=;
        b=O530C15Dk5P92Jyc3p754/LTxJVuxXzxfVdSo1CceSiZ/uBmenRkTTdU83CHpJ/W8S
         pGGCOnbWB8HZJjqI5XMICGE79iumctyUb2u0wWzDhAmfgf/CVQouUXTbrxnIHh12rWwE
         n0jtCTrElZ4nZdboOkfB9EAkx0c4vFPUN9Gnxan+pS9t0VGfq8vcGour3VzFPa7LGrrI
         sBhkopkkyhIxvWEidc7Bt+gR2W3dTMt7JSieXjp03D6JexqKMs+sHCkbh5wZNek8zBti
         +fZqPsfnEydAVqe+LibzGtxO02dR/nocuUoG7xzM9OgIlvTH8XB7dyIXI+zqef4ZD4ZD
         umkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677945345;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jvBErRoqm3lY280h1zXnp9L55kLV0ZvERd9QGERMZk0=;
        b=3Y4Q7e1TuRKQrnl7BNtyfEzGwgLkUlJD+xBsUIxG/Ul+PXuo1GSqd4TkO6e/FVHMCY
         vcd8LLPGaLvwfnOm+CKTPRyKe9aYgQ1XcF2KbXhMzRzNxO3u1WO95xdeeTEmZYHhRHL6
         OFcNJOX5qwqsgt1iP8WEdOVMevIGreLiN//f2SxmkYoq5UMsv5gckZS/Ybq3q5BH5Dt9
         pKfKYzFQMOMkvphyzk2Adelwtugb/CmrhfIZTHSlo693xgd8LTZqYv34sDloKBe8RB2n
         4s40pVG9lbYp6+9c7fmAdHuMZxk9BpubkuJ+OxeO6SO7CG/WsOdRJyo0I0euGAUTjk5u
         bp1g==
X-Gm-Message-State: AO0yUKVGg9+MLknrNIACAiqKdDyajOsnT19X/q+iXVhAx9K01rlMXuKk
        l3LSJ4s4sLtlrq7NSAZdfF0/8A==
X-Google-Smtp-Source: AK7set8KOZTcrEgSViYUT8+/JuiRsQF2/CWi9cU07gaiHA9gzo1vPwHlvZYKzCpHuhYNq0l4GhCh8A==
X-Received: by 2002:ac2:539a:0:b0:4cc:b784:c47e with SMTP id g26-20020ac2539a000000b004ccb784c47emr1347925lfh.62.1677945344811;
        Sat, 04 Mar 2023 07:55:44 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id n10-20020a19550a000000b004b40c2fccfdsm864128lfe.59.2023.03.04.07.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 07:55:44 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v3 0/2] Fix up Qualcomm DSI bindings
Date:   Sat, 04 Mar 2023 16:55:33 +0100
Message-Id: <20230304-topic-dsi_fixup-v3-0-b8565944d0e6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPVpA2QC/x2NWwqFMAwFtyL5NlCsKLgVuVz6iBqQWhoVQdy7w
 c8ZznBuECpMAkN1Q6GThbekYOsKwuLSTMhRGRrTWGNNi/uWOWAU/k98HRkpuMn4aH3f9aCVd0L
 oi0th0S4d66oyF9L1dzP+nucFYN0nX3YAAAA=
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677945343; l=977;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=sojen1tNSazgZyI7QKDlibLxXXzdkvEAKi6a519TMNU=;
 b=DKUQEnpcLchWHA3fR4VGAWDLMwMgmJZgjmhoXi4gGhRHfaX1rBfihIbshAJ1iH2WVCqIUs2bIqh5
 U+rtbkY2AE/yWv+BKxOOkjb5jk+DIae25uRNI8senvOGM+qPizP9
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

v2 -> v3:
- Deprecate "qcom,mdss-dsi-ctrl" correctly instead of removing it [1/2]
- Remove the note about separate driver logic, as it's gone now [2/2]

Depends on:
https://lore.kernel.org/linux-arm-msm/20230213121012.1768296-1-konrad.dybcio@linaro.org/

Link to v2:
https://lore.kernel.org/linux-arm-msm/20230217111316.306241-1-konrad.dybcio@linaro.org/

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      dt-bindings: display/msm: dsi-controller-main: Fix deprecated compatible
      dt-bindings: display: msm: sm6115-mdss: Fix DSI compatible

 .../devicetree/bindings/display/msm/dsi-controller-main.yaml      | 2 +-
 .../devicetree/bindings/display/msm/qcom,sm6115-mdss.yaml         | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)
---
base-commit: 9a33780f72f64c1cd151d84a9959f58a13b0c970
change-id: 20230304-topic-dsi_fixup-ecaf0bd3b767

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

