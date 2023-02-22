Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 684F569FDDF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 22:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbjBVVrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 16:47:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjBVVrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 16:47:15 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DD83800A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 13:47:13 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id i9so11714741lfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 13:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LtV4gYlZb6movFpbhLNmgY7hQ5iw08LpCzFT54yrzAs=;
        b=xvsApw/xe6eVzMexS8gyRb6PnkjYi1+vYZLtmPdAbOIy6zgwklwpIdeAXa9DXgEkDz
         CfaOV8wYg5bcvQTLuWodJRkW5QgnXUZafwwLZmgQwWn98oXneVQGqapGcvtfPoWtfsDl
         wLqjjFlhJ1SD305vnKdaKkAQNc/yLQTru/SqkDujMAvIgA9ssESu9k/iZeSfs4z4PKX5
         pdi/G9vqxjcpB1gJhm1RBslHkg0dZAZzvwuPMeTC7mr/ALQNkPxJdVE5seFij5pIg/06
         Dy1imCqafD3J75cmgT6WdXXQwBMcRpY7O3iJH0jYLnVo1xqjinWY/YliM09JkylO0hmI
         Kw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LtV4gYlZb6movFpbhLNmgY7hQ5iw08LpCzFT54yrzAs=;
        b=wO+tPrIJ5T6jGvS7pn5wDm95mpqY/taTrX8NUwZTroD7E7DXWV1/OJIVwdCnrRgBly
         7QpZFw9x6ljm0IAvi3KmosNZcXU6qEGfaUVNScJMCml9eruBWKhxCa7iWAHFuQQb+4xI
         1+7eRdRO+ZpiptVD9J5pmAm+AkdwRXg44LrizaKbp3X6l7klvrAR6SN8/zltvXP172ZR
         YGmxykaDMUxUUguCQcY9BC81CyDNM18v/yAjkNLK2XJT1zLEcYRCZbekhG6MTXsRZgJF
         fknIexkobVZaScljGPMHSeYzsC7xL+Ll8gi7xRgQBBB3QDHnXko4tuXmWAdkLNEi5z7e
         cAMg==
X-Gm-Message-State: AO0yUKXx4WaiOsQGF5nn4LCVx/Z7tb0Wbn6FUnn6E6+R+r/okYQ/ewmi
        QJTUSDVBHN7vm+Z74QUObHnEgQ==
X-Google-Smtp-Source: AK7set/RP4wCH5nANpTc//nQoM25cOa7FJpbemhgSn3yJ/9VpW6trH+TvUn2C8GStdji/Y+bwdm9gQ==
X-Received: by 2002:ac2:5202:0:b0:4dd:749b:2d5e with SMTP id a2-20020ac25202000000b004dd749b2d5emr3245594lfl.13.1677102431997;
        Wed, 22 Feb 2023 13:47:11 -0800 (PST)
Received: from [192.168.1.101] (abxi151.neoplus.adsl.tpnet.pl. [83.9.2.151])
        by smtp.gmail.com with ESMTPSA id c23-20020ac244b7000000b004db5081e3f7sm505126lfm.46.2023.02.22.13.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 13:47:11 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/5] OPP and devfreq for all Adrenos
Date:   Wed, 22 Feb 2023 22:47:09 +0100
Message-Id: <20230222-konrad-longbois-next-v1-0-01021425781b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF2N9mMC/x2N0QrCMAwAf2Xk2cCW4VB/RXxI27gFSyrplMHYv
 1t8vIPjdqjiKhVu3Q4uX61arMFw6iAubLOgpsZAPY09EeGrmHPCXGwORSuabCtepjTwdD2PFAl
 aGrgKBmeLS4vtk3OTb5enbv/X/XEcP343Cs57AAAA
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677102430; l=2087;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ocr3jeuvoRq3y9CSWJWmDlXSkvIkpCb9rcZR7Ldt8y0=;
 b=GnX5hx4k4NEFLxBrvnFkBrpW7jm1Yg1bxr4NqiOJ1CEFH/5VtjvD1XT/pHQKEdLz6RaWIHFdv0a9
 l2zbUi+tB7Th6+9ZQ07IS4Xo5xNTXebzV60EY+88yeyROg2CK1qd
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is a combination of [1] and a subset of [2] and some new
stuff.

With it, devfreq is used on all a2xx-a6xx (including gmu and
gmu-wrapper) and all clk_set_rate(core clock) calls are dropped in
favour of dev_pm_opp_set_rate, which - drumroll - lets us scale
the voltage domain. DT patches making use of that will be sent
separately.

On top of that, a5xx gets a call to enable icc scaling from the OPP
tables. No SoCs implementing a2xx have icc support yet and a3/4xx
SoCs have separate logic for that, which will be updated at a later
time.

Getting this in for 6.4 early would be appreciated, as that would
allow for getting GMU wrapper GPUs up (without VDD&icc scaling they
can only run at lower freqs, which is.. ehhh..)

Changes:
- a3xx busy: use the _1 counter as per msm-3.x instead of _0
- a6xx-series-opp: basically rewrite, ensure compat with all gens
- a2/4xx busy: new patch
- a5xx icc: new patch

[1] https://lore.kernel.org/linux-arm-msm/20230130093809.2079314-1-konrad.dybcio@linaro.org/
[2] https://lore.kernel.org/linux-arm-msm/20230214173145.2482651-1-konrad.dybcio@linaro.org/

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (5):
      drm/msm/adreno: Use OPP for every GPU generation
      drm/msm/a2xx: Implement .gpu_busy
      drm/msm/a3xx: Implement .gpu_busy
      drm/msm/a4xx: Implement .gpu_busy
      drm/msm/a5xx: Enable optional icc voting from OPP tables

 drivers/gpu/drm/msm/adreno/a2xx_gpu.c   | 28 ++++++++++
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c   | 11 ++++
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c   | 11 ++++
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c   |  4 ++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 94 +++++++++++++++------------------
 drivers/gpu/drm/msm/msm_gpu.c           |  4 +-
 drivers/gpu/drm/msm/msm_gpu_devfreq.c   |  2 +-
 7 files changed, 99 insertions(+), 55 deletions(-)
---
base-commit: f4ed0868966d96203fee6f2782508746ded2ce3f
change-id: 20230222-konrad-longbois-next-86d1a69532c2

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

