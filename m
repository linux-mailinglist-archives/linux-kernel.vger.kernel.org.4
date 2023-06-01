Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510A9719899
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbjFAKLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbjFAKKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:10:42 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACD310D5
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:10:03 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f6042d605dso6465785e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 03:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685614202; x=1688206202;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F7oPRb56xxOFhyPPW7r8Cl13Ie6RSoTMualjqBVrsIs=;
        b=BNQvvGLR8AIkT/AqxSdai2eFt3LbdlfiOBZrnmbspzeK9DMwMDi/LSRWKm7S5cJpCj
         5NbUyvSuBvXy6Vl9h6iFC9+zZInNHm5TiHAYwn3LHWFBA/QFIuawaCai/3oa1+QJSQep
         MT34mdnK9NV/452bXVlcH7wGq0H7RAxvrEm/G1AjNtM7WeI6UPw4HYEW515uSZNvPUOs
         FUSORe1Vej/YpkVEgWxhwI3oFedPhz+Jz/sygQte+YIk4wjWTWsUtBJ33eMhapRbwJyN
         iejuh+b5JKc3m7MQK9s340IelAASZ8PoYshk1SZ87JBerLLtuj0Sjh6GnBPMe2tv9Mbf
         NrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685614202; x=1688206202;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F7oPRb56xxOFhyPPW7r8Cl13Ie6RSoTMualjqBVrsIs=;
        b=IMG9vx9dnCIkfQcbbOEgcismbqjx4qhJ7/khvzqs3BBQttPFBsEN0dKpBXJdE2hp3D
         2Q13cYP7LO0qqQjf2ICukdbmKdvBERGP9PASidXbiqz1lsRKEvUcuZzsoqFAO2uElBNz
         C7qyEyRgD/8UPw2y+2+UgScpnEXQMRw1yhmNGeW+uwWBm/U4fRiJtqe93Y82jx5xjqiB
         aanFmTAw7wzS6KkdcimofTvriLjz1aVEtfRCR7eEin1dMlTUYbSOKI6ZYDKoCkqYcB8t
         vzjKmGXOfQeuP7o7Qkw4Hkn36S2idpXnLGLHaLUnz9Izs+sUpIRnYrbPidLQKEgRAx6z
         Q38g==
X-Gm-Message-State: AC+VfDzXIgG/VG1eq08QA1T1B/LYWUSoES2+bE0JAzgYARS+CzUwWcXm
        3VyGZfjnQIUGFXcK0yC5FSyBgg==
X-Google-Smtp-Source: ACHHUZ473fmdIHtT9A4as6dePNfSRbK0nYDXhQAFl9rWDDAhXfxdKeqPuqISRhtrj+hJ/MyRmg69GQ==
X-Received: by 2002:a7b:cd15:0:b0:3f7:19f9:4c4f with SMTP id f21-20020a7bcd15000000b003f719f94c4fmr1544487wmj.21.1685614202461;
        Thu, 01 Jun 2023 03:10:02 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id u6-20020adfeb46000000b0030ae53550f5sm9683845wrn.51.2023.06.01.03.10.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 03:10:02 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/3] arm64: dts: qcom: add DP Controller to SM8550 DTS
Date:   Thu, 01 Jun 2023 12:09:46 +0200
Message-Id: <20230601-topic-sm8550-upstream-dp-v2-0-e8778109c757@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGpueGQC/42NSw6DIBRFt2IY9zWAwU9H3UfjAPCpJArkoaaNc
 e+lrqDDc5J7z8ESksPEHsXBCHeXXPAZ5K1gdtJ+RHB9Zia5LHnFBawhOgtpaZTisMW0EuoF+gi
 mFqXRslZ9bVmeG50QDGlvp3zgt3nOMhIO7n31Xl3myaU10OfK7+Jn/yjtAjjIFgeUVdMqVT5n5
 zWFe6CRded5fgE4SEkF1gAAAA==
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1123;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=iL7lzn9jXBeXGB9m4il+iznwNTKa8/E0w6IARZqYybU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkeG53ed4YWRTgqTjNqXEAeNxvfooFfW8lapHGUozL
 MkqbFzuJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZHhudwAKCRB33NvayMhJ0YcGEA
 C91t1BSYpxwVVwzULJmQ9vu5fzT93CzP4v9TO5xoakQb4KC9rU8EcY5MnS8nQPHduPR7YA6/XuMcI2
 ToWlkc3kHf543U9fQHa0/esSYNChAsKmXlnmDYFOvM/TiWLwMcyU+/ZEei9Lx+xmK4yk4bPR6yVGiz
 IC3glQ0JAVmCejnMuo1sOpy4HRcQEVJFBg5NMNwh1w14wN/yeESHb3jTH14IF6g6bqyK1k4V0rzJzN
 2LD/Z4tLsolNDvvl1wQOtT97qnWCxklhm1AbYeZ6sAcgwnnvOW+ew8NlcgcWmU45felC/HPmYw/QIc
 QRALqjPZMaxkfA8P6/c+VcoWcy+LNgHKhOo9jcWCYdRTnleLzIdowrtXeWF6wGDpyv0I9KaxcFgPL5
 dC4tyvLM69xwZ7/YaJg0N0d3Wzp2MgFuaVJ6H2vzBzRi4OCMB9K1D8tSagV8bfJWfTjlLgUPyqdaQG
 50krHycEGtIMcU4qaEpoKycl2ROt4gRHnH6MIlBs8IYz6qRIwYtkQE0bZYka/cw0AGR5Qn/KCrOi1F
 gAMtuTxMr5YGTmmg7Vc4sg39ApTcN7upaI9E5cS2SFg6206bzk9mVblxM4nYbcO1yKwvvF3hpf3874
 QQpTfLlrXe+yWHybSqSCZxktvPwyf7iHXW3A8aW4lAATUtbRwxKxDSkRCamQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DP output is shared with the USB3 SuperSpeed lanes and is
usually connected to an USB-C port which Altmode is controlled
by the PMIC Glink infrastructure.

DT changes tying the DP controller to the USB-C port on the QRD
board will be sent later.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Added review tags
- s/lov_svs/low_svs/
- Applied fixes suggested from Konrad
- Link to v1: https://lore.kernel.org/r/20230601-topic-sm8550-upstream-dp-v1-0-29efe2689553@linaro.org

---
Neil Armstrong (3):
      dt-bindings: display: msm: dp-controller: document SM8550 compatible
      arm64: dts: qcom: sm8550: fix low_svs RPMhPD labels
      arm64: dts: qcom: sm8550: add display port nodes

 .../bindings/display/msm/dp-controller.yaml        |  1 +
 arch/arm64/boot/dts/qcom/sm8550.dtsi               | 95 ++++++++++++++++++++--
 2 files changed, 91 insertions(+), 5 deletions(-)
---
base-commit: d4cee89031c80066ec461bb77b5e13a4f37d5fd2
change-id: 20230601-topic-sm8550-upstream-dp-b713ba275d7c

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

