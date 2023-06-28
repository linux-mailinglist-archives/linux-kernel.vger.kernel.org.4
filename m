Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930C27419A0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 22:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjF1Ufj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 16:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbjF1Uf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 16:35:29 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D751FFA
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:35:28 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f8775126d3so101407e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 13:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687984526; x=1690576526;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+wRQYdXn3x7iIszNaVENCFzwMuf2uBkWw5PZau30MuI=;
        b=RiFTPc7UsojgzUuT8i+bbCX1wYS/u2oYh0TjpifxhtmQxHaCoH58VnyiQ6UyX6ETIE
         ZxJlLgetRmZ2IYsy4/SNeN9nEhRlD5nOnTbppfE2yadro6mJITmJr0ijrF4A0YB/jdTq
         tPWzgSW49ubQ0xMU8Ky1dFwKagKA7D5MGEkZmmcirr+eJL4boES/GmnKzV+qh0GtrRZr
         RbPAVoMdKG65cbFqWKSWgoKNIlM1oLlj1U+cu0c6bPRR60agw64xf6QiyFnmsUFBnEwu
         bfS2WiERtuAQvTH4/HZNble2AdUqn/Vc2/nfJdFPZ/v5BmuKxTA2EDYyTqBfDUzAqzr0
         rhrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687984526; x=1690576526;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+wRQYdXn3x7iIszNaVENCFzwMuf2uBkWw5PZau30MuI=;
        b=ZAGQ0CwQEqszxICLjvWiriPWg3LUSm2mMF5331Avwp9DHQ2C90UUFVm3zYuLejOw1T
         Z//sqkJkTQTrJe6U/krOA0nn3U8jTb4BF1+ejUcAc+1Pk2N3C35Q0TnIi3UMwiN6eaJU
         KshJXRREgT0xBk4lRVtGt9uzmmHROEmVTceSrSRlaAfKTmO4Nv9biyEHsB/SGCYsZ9U+
         Rp7ZnAyr6TGP5ZAl9/7cvO4fNuHnRlnJa1owO0PXM6f4nuQdZHpTfNS8tvPOVh2oCipM
         KdNeLDYeFBbY0wsRgasmNNqnjJkQ+D1giUIO5z6lEAdhwOUcbAzRnmuhwi2wh7AHbgNK
         QxQA==
X-Gm-Message-State: AC+VfDwKEsCo3qMMSYvnZ3Pa+2EBb4++0pLfwv5E7/zCTTE6Vqii4viy
        OlgBqJ+EwqJC8mErHpXRPQM+Dw==
X-Google-Smtp-Source: ACHHUZ4S7zlUew/DrF2BCfNDFKw1yLf33etTDm+4V2SeTYD2znuosgGBEs30tSa6rP3t8JMlUMFzcg==
X-Received: by 2002:a05:6512:ea7:b0:4f4:c6ab:f119 with SMTP id bi39-20020a0565120ea700b004f4c6abf119mr27288580lfb.64.1687984526179;
        Wed, 28 Jun 2023 13:35:26 -0700 (PDT)
Received: from [192.168.1.101] (abyk82.neoplus.adsl.tpnet.pl. [83.9.30.82])
        by smtp.gmail.com with ESMTPSA id m25-20020a056512015900b004fb86c89fa1sm753363lfo.135.2023.06.28.13.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 13:35:25 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 00/14] A7xx support
Date:   Wed, 28 Jun 2023 22:35:00 +0200
Message-Id: <20230628-topic-a7xx_drmmsm-v1-0-a7f4496e0c12@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHSZnGQC/x2N0QrDIAwAf6XkeQGrUMd+ZYxhNa6BakuyDaH03
 yd7vIPjDlASJoXbcIDQl5W32mG8DBCXUF+EnDqDNdaZyV7xve0cMfjWnklK0YKjddmZ5KeYPfR
 uDko4S6hx6WX9rGuXu1Dm9h/dH+f5A4Pr46t4AAAA
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687984524; l=3802;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Z7jlwfWNBT9lUj5uikuMSfyXKZlfykMWYJqb93QRUjU=;
 b=Q9rGg7Lhf4vvAUnJ5JxpZ6ePIoqS150jNswvaYQhFXC6Ahuv7pG7/pAt5+m37hrpvjgkiuh9d
 qc1sm3bLa18AyDZyFvwwgOJPi2swBJyqfTXz6ChV8R0YYgND10NVwq+
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

This series attempts to introduce Adreno 700 support (with A730 and A740
found on SM8450 and SM8550 respectively), reusing much of the existing
A6xx code. This submission largely lays the groundwork for expansion and
more or less gives us feature parity (on the kernel side, that is) with
existing A6xx parts.

On top of introducing a very messy set of three (!) separate and
obfuscated deivce identifiers for each 7xx part, this generation
introduces very sophisticated hardware multi-threading and (on some SKUs)
hardware ray-tracing (not supported yet).

After this series, a long-overdue cleanup of drm/msm/adreno is planned
in preparation for adding more features and removing some hardcoding.

The last patch is a hack that may or may not be necessary depending
on your board's humour.. eh.. :/

Developed atop (and hence depends on) [1]

The corresponding devicetree patches are initially available at [2] and
will be posted after this series gets merged. To test it, you'll also need
firmware that you need to obtain from your board (there's none with a
redistributable license, sorry..). Most likely it will be in one of
these directories on your stock android installation:

* /vendor/firmware
* /vendor/firmware_mnt
* /system

..but some vendors make it hard and you have to do some grepping ;)

Requires [3] to work on the userspace side. You'll almost cerainly want
to test it alongside Zink with a lot of debug flags (early impl), like:

TU_DEBUG=sysmem,nolrz,flushall,noubwc MESA_LOADER_DRIVER_OVERRIDE=zink kmscube

[1] https://lore.kernel.org/linux-arm-msm/20230517-topic-a7xx_prep-v4-0-b16f273a91d4@linaro.org/
[2] https://github.com/SoMainline/linux/commits/topic/a7xx_dt
[3] https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/23217

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (14):
      dt-bindings: display/msm/gmu: Add Adreno 7[34]0 GMU
      dt-bindings: display/msm/gmu: Allow passing QMP handle
      dt-bindings: display/msm/gpu: Allow A7xx SKUs
      drm/msm/a6xx: Add missing regs for A7XX
      drm/msm/a6xx: Introduce a6xx_llc_read
      drm/msm/a6xx: Move LLC accessors to the common header
      drm/msm/a6xx: Bail out early if setting GPU OOB fails
      drm/msm/a6xx: Add skeleton A7xx support
      drm/msm/a6xx: Send ACD state to QMP at GMU resume
      drm/msm/a6xx: Mostly implement A7xx gpu_state
      drm/msm/a6xx: Add A730 support
      drm/msm/a6xx: Add A740 support
      drm/msm/a6xx: Vastly increase HFI timeout
      [RFC] drm/msm/a6xx: Poll for GBIF unhalt status in hw_init

 .../devicetree/bindings/display/msm/gmu.yaml       |  47 +-
 .../devicetree/bindings/display/msm/gpu.yaml       |   4 +-
 drivers/gpu/drm/msm/adreno/a6xx.xml.h              |   9 +
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              | 188 ++++--
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h              |   3 +
 drivers/gpu/drm/msm/adreno/a6xx_gmu.xml.h          |   8 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              | 658 ++++++++++++++++++---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h              |  15 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c        |  52 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.h        |  61 +-
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c              |  90 ++-
 drivers/gpu/drm/msm/adreno/adreno_device.c         |  26 +
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |   7 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h            |  24 +-
 drivers/gpu/drm/msm/msm_ringbuffer.h               |   2 +
 15 files changed, 1070 insertions(+), 124 deletions(-)
---
base-commit: 6f9b660e9cbb30669fcfec83288d527c0844717d
change-id: 20230628-topic-a7xx_drmmsm-123f30d76cf7

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

