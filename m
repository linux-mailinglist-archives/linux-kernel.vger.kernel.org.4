Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18145BD6D7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 00:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiISWIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 18:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiISWIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 18:08:17 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8AF48EB7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 15:08:16 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id fs14so1034882pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 15:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=gz59VWx5nz0YJXzmCogPNEDPJtcNnH5l3T4l3SeJhzY=;
        b=OuJs8yBRQWHb2NNqUrbybvk2KaJ1FDQfcfkl1NAvGr9+CfaVcOx/3meKK+mdxorsAu
         0+iy9Yg+b1sX53SW6lGS/rvME6GBW/dMU5TuA9ru5JBGfGsXnRcgRtwIjpAumbAyauSH
         2D1bZ0qe7uhLduo8ieOEvXolioYAnEeK7Z6XarRJFoUymkbXrfGJcXAgxRIlckUp6cBF
         pka+XnDagpnMKezgG37TW8+jElG8UY1K/kWWrY5sHW/rI5/SLJou/zZbOUPPfHBJmvq/
         mehkinxDWq/KhvF3t3ExhSi0vVQnDYiP3xfyxaijJKEdWep8nK1lwbvaOL3w8hS77Xl3
         Yntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=gz59VWx5nz0YJXzmCogPNEDPJtcNnH5l3T4l3SeJhzY=;
        b=r4adompz0zF+TPJrvneyoHoZ8dEUnPzx9AGWbrLuCrdQuXHhY0IJs5GC6XT5BOiFwe
         TYY5vAfZ7ZxTnKsu/h29nks1Usr0Kgiy7cHLGkyp3rDbR7t4df6IKFstWZCjkdoQ9Wdh
         nKigOI3LyVOM1v1nUb60FOm3w9bwBV38muf0GkGZABONS4RlW2Kcr4HjP5MuNsEG7LQf
         NnBVQCc+Ny0Liewux+qbWRoGL0Ntgkzp+d/K/pR+rgb25Q/Cbu9qVAFSSsfYRIC9y0QP
         jHXDxIPXJijsv6seU56rAPtcxkrOhgSGj4t2sMvuhczBKxoQEUn+BOD4SMetE2CULIau
         F2AA==
X-Gm-Message-State: ACrzQf0B31yf7fSud44rdbqpYshlFYJPJPMnYh9SNH+CadwLRMeJEBSJ
        bIYTV3ff6D5AgMEaqEAlzBwNog==
X-Google-Smtp-Source: AMsMyM4pSjyZ5qg7zSrfTDX5bHgJiiwtzrg6V1QbSsP0WB2GdJV0uFPLZit4s/1EDdY19ktUMClZFw==
X-Received: by 2002:a17:903:1c4:b0:176:e348:c386 with SMTP id e4-20020a17090301c400b00176e348c386mr1804453plh.3.1663625295495;
        Mon, 19 Sep 2022 15:08:15 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c61:6535:ca5f:67d1:670d:e188])
        by smtp.gmail.com with ESMTPSA id u2-20020a17090a6a8200b001eee8998f2esm7068167pjj.17.2022.09.19.15.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 15:08:15 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, thara.gopinath@gmail.com,
        devicetree@vger.kernel.org, robh@kernel.org,
        krzysztof.kozlowski@linaro.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        Jordan Crouse <jorcrous@amazon.com>
Subject: [PATCH v6 0/4] dt-bindings: qcom-qce: Convert bindings to yaml & related changes 
Date:   Tue, 20 Sep 2022 03:38:00 +0530
Message-Id: <20220919220804.1047292-1-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.37.1
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

Changes since v5:
=================
- v5 can be seen here: https://lore.kernel.org/lkml/20211110105922.217895-1-bhupesh.sharma@linaro.org/
- As per Bjorn's suggestion on irc, broke down the patchset into 4
  separate patchsets, one each for the following areas to allow easier
  review and handling from the respective maintainer(s):
        'arm-msm', 'crypto', 'dma' and 'devicetree'
  This patchset is directed for the 'arm-msm' tree / area.
- Addressed Rob's, Vladimir's and Bjorn's review comments on v5.
- Added Tested-by from Jordan received on the v5.
- Also added a 'defconfig' change where I enabled the QCE block as a module.

Changes since v4:
=================
- v4 for sm8250 can be seen here: https://lore.kernel.org/linux-arm-msm/20211013105541.68045-1-bhupesh.sharma@linaro.org/
- v1 for sm8150 qce enablement can be seen here: https://lore.kernel.org/linux-arm-msm/20211013165823.88123-1-bhupesh.sharma@linaro.org/
- Merged the sm8150 and sm8250 enablement patches in the same patchset,
  as per suggestions from Bjorn.
- Dropped a couple of patches from v4, as these have been picked by
  Bjorn already via his tree.
- Addressed review comments from Vladimir, Thara and Rob.
- Collect Reviewed-by from Rob and Thara on some of the patches from the
  v4 patchset.

Changes since v3:
=================
- v3 can be seen here: https://lore.kernel.org/linux-arm-msm/20210519143700.27392-1-bhupesh.sharma@linaro.org/
- Dropped a couple of patches from v3, on basis of the review comments:
   ~ [PATCH 13/17] crypto: qce: core: Make clocks optional
   ~ [PATCH 15/17] crypto: qce: Convert the device found dev_dbg() to dev_info()
- Addressed review comments from Thara, Rob and Stephan Gerhold.
- Collect Reviewed-by from Rob and Thara on some of the patches from the
  v3 patchset.

Changes since v2:
=================
- v2 can be seen here: https://lore.kernel.org/dmaengine/20210505213731.538612-1-bhupesh.sharma@linaro.org/
- Drop a couple of patches from v1, which tried to address the defered
  probing of qce driver in case bam dma driver is not yet probed.
  Replace it instead with a single (simpler) patch [PATCH 16/17].
- Convert bam dma and qce crypto dt-bindings to YAML.
- Addressed review comments from Thara, Bjorn, Vinod and Rob.

Changes since v1:
=================
- v1 can be seen here: https://lore.kernel.org/linux-arm-msm/20210310052503.3618486-1-bhupesh.sharma@linaro.org/ 
- v1 did not work well as reported earlier by Dmitry, so v2 contains the following
  changes/fixes:
  ~ Enable the interconnect path b/w BAM DMA and main memory first
    before trying to access the BAM DMA registers.
  ~ Enable the interconnect path b/w qce crytpo and main memory first
    before trying to access the qce crypto registers.
  ~ Make sure to document the required and optional properties for both
    BAM DMA and qce crypto drivers.
  ~ Add a few debug related print messages in case the qce crypto driver
    passes or fails to probe.
  ~ Convert the qce crypto driver probe to a defered one in case the BAM DMA
    or the interconnect driver(s) (needed on specific Qualcomm parts) are not
    yet probed.

Qualcomm crypto engine (qce) is available on several Snapdragon SoCs.
The qce block supports hardware accelerated algorithms for encryption
and authentication. It also provides support for aes, des, 3des
encryption algorithms and sha1, sha256, hmac(sha1), hmac(sha256)
authentication algorithms.

Note that this patchset is dependent on the dt-bindings patchset (see [1]) sent to devicetree list.

[1]. https://lore.kernel.org/linux-arm-msm/20220919195618.926227-1-bhupesh.sharma@linaro.org/

Cc: thara.gopinath@gmail.com
Cc: robh@kernel.org
Cc: andersson@kernel.org
Tested-by: Jordan Crouse <jorcrous@amazon.com>

Bhupesh Sharma (4):
  ARM: dts: qcom: Use new compatibles for crypto nodes
  arm64: dts: qcom: sm8250: Add dt entries to support crypto engine.
  arm64: dts: qcom: sm8150: Add dt entries to support crypto engine.
  arm64: defconfig: Enable Qualcomm QCE crypto

 arch/arm/boot/dts/qcom-ipq4019.dtsi   |  2 +-
 arch/arm64/boot/dts/qcom/ipq6018.dtsi |  2 +-
 arch/arm64/boot/dts/qcom/ipq8074.dtsi |  2 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi |  2 +-
 arch/arm64/boot/dts/qcom/sdm845.dtsi  |  2 +-
 arch/arm64/boot/dts/qcom/sm8150.dtsi  | 28 +++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8250.dtsi  | 28 +++++++++++++++++++++++++++
 arch/arm64/configs/defconfig          |  1 +
 8 files changed, 62 insertions(+), 5 deletions(-)

-- 
2.37.1

