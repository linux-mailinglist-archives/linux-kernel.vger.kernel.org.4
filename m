Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B295A63C98D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 21:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236156AbiK2Uq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 15:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234987AbiK2Uqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 15:46:55 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C795B264AE;
        Tue, 29 Nov 2022 12:46:53 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id f13so23876119lfa.6;
        Tue, 29 Nov 2022 12:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9nBlhEXGFP581Y5583VUeZuiA62uk4fX/W8dDpQUeXY=;
        b=UM37Cd47j+DlXqKSgZOHsv26pCEotZ/Wrxx95lPNw8D+tAVl3/a8Zfw1MEbFyBhP7c
         WzQWuQ0N0dSCvZOFOb18luPjCy5fJCR9uccqUhb9KcbB8PUo84+5/pM8L43Q+67Z5Htq
         IgMFP6W/BwjPenEaxLsODAvjIEBB3j7OUJjIO49RA/zAkP6045pqMi4oOH5mL+J8hjl7
         ZMs9wbzfL5xc11ueLLi5UF+NYOqCCS8yeM/3H1GAf8o7n6O6+MUwKs1c+LybnHa+FkWy
         KphPYXOXOUDnycBrvlHY0woHxGslNgvljLQt4irjB/fRt0r9lHpxK4uRFNgM7OzXm1Do
         jx9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9nBlhEXGFP581Y5583VUeZuiA62uk4fX/W8dDpQUeXY=;
        b=QW7mrcpL2AwbwVqVrEFttxydG5qZ5EYJHD9TYlEXAZUYQcAtkqUWNJNBDEUUiHn4PR
         usE847nmXQKfzQ0wMM0BJFgzAlNyq5RIACk51oNrPHulsT7ygOiSrNNQaenpv2yhgFBf
         9ODm7eJaw6M3/IFprvSS+3Pk0QbNKhh463rcoZvNLHj63S0y5LKW4FN4gTlGsY2WHmn6
         GjNKBaQEUHBtEyaMcePe0vT6tg85siPh+Vf7lBMg17tjNsXAJGi4NZ8MUi+gyBBoPWTj
         NBXH2+NEWAnGJeR4xylrjWTjv9kU5COkFLzwtM7ITNNSbbRXFt5MI+cRBbOEdBBvAz8y
         mqsg==
X-Gm-Message-State: ANoB5pmeIDEBBtUzQ5c4VU5BC2KXLDTwNJAo5rmr6KFQBBLGJVRfynV2
        T7mCO5lQ1MWeE6pyHjMSk+VtbsJgG/s=
X-Google-Smtp-Source: AA0mqf4Mv1+eooDcZ78yPM1Tk5qnDC5+ZsfajUK8m+kcJhpput/JgZy0e4DzicKvHFPPgRSezFRQTA==
X-Received: by 2002:a05:6512:3187:b0:4b3:ec7a:6752 with SMTP id i7-20020a056512318700b004b3ec7a6752mr17419404lfe.79.1669754812055;
        Tue, 29 Nov 2022 12:46:52 -0800 (PST)
Received: from localhost.localdomain (ccy110.neoplus.adsl.tpnet.pl. [83.30.148.110])
        by smtp.gmail.com with ESMTPSA id o11-20020ac24e8b000000b004ae24368195sm2325620lfr.233.2022.11.29.12.46.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 12:46:51 -0800 (PST)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 00/12] SM6115 DTS changes
Date:   Tue, 29 Nov 2022 21:46:04 +0100
Message-Id: <20221129204616.47006-1-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
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

This patch series adds bunch of new nodes
also it fixes some small nitpicks in yamls and adds compatible.

Adam Skladowski (12):
  dt-bindings: display: msm: Replace mdss with display-subsystem
  dt-bindings: thermal: tsens: Add SM6115 compatible
  arm64: dts: qcom: sm6115: Add cpufreq-hw support
  arm64: dts: qcom: sm6115: Add TSENS node
  arm64: dts: qcom: sm6115: Add PRNG node
  arm64: dts: qcom: sm6115: Add rpm-stats node
  arm64: dts: qcom: sm6115: Add dispcc node
  arm64: dts: qcom: sm6115: Add mdss/dpu node
  arm64: dts: qcom: sm6115: Add GPI DMA
  arm64: dts: qcom: sm6115: Add i2c/spi nodes
  arm64: dts: qcom: sm6115: Add WCN node.
  arm64: dts: qcom: sm6115: Fallback smmu to qcom generic compatible

 .../display/msm/qcom,qcm2290-mdss.yaml        |   2 +-
 .../display/msm/qcom,sm6115-mdss.yaml         |   2 +-
 .../bindings/thermal/qcom-tsens.yaml          |   1 +
 arch/arm64/boot/dts/qcom/sm6115.dtsi          | 562 +++++++++++++++++-
 4 files changed, 564 insertions(+), 3 deletions(-)

-- 
2.25.1

