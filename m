Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0175BD706
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 00:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiISWPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 18:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiISWPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 18:15:23 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA7840E1D
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 15:15:21 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id o99-20020a17090a0a6c00b002039c4fce53so3350582pjo.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 15:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=hFNxb6Whue0oJiz38AdcZGTZ6n+cVRFbGd4gEmlGGD0=;
        b=jP7rxFieQRiXFRZ2axWLx3gqRhoWsQMcKRvVznGi22vxx5FOla3IqFrAKL61+6a2xE
         tPNaZQwXIy7FPgRF+KnuVXptIEBAJfZRsxqTd8R0NciWeRILAQg4cw90+rxZ+rL+E6m+
         hrf9wgJpWDOBtK4nbyUzn9b/tN0wvAYldTkVCJK/pwZ1Xqrhi6MnRLQSUnGb6kJMl3x/
         6+Sp6lghVOHbRBX3+463BzQNN2z9tazJdl3VIWuyGLM+duRdIqfeQiyRdDPaEGOQT7uk
         bgYoy7W3H39Ilh8s7fo3YA9lRweXp3I4EMtwVykO0c2LCndnD1BH6Zd9tz94EBw+06k8
         GGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=hFNxb6Whue0oJiz38AdcZGTZ6n+cVRFbGd4gEmlGGD0=;
        b=tJu9PVpbXjbwgAHwMFkUZ6JzyVfQgilgQo073gjNCXZ0fkziz3EcSVOdeJ9QanVUbW
         xa0FbOuaHev77ZdOxqXhHu7mhmEWXgAU4vCOH8QZf0ldnBwjLVl5aqd++DBIrlrRwASh
         pqN3ZoHQ4+ntklja6RPFfURG6VIZF84qEE/w90L1rI/cFEDU0SSY7IYX/owBcDzB7NU2
         I6VD75/QsDOqQKo8yKpGXfx/mkE1p2jLGKWwlR3FZbtpkGziai5X8sA91Yr0Uh4zS6dh
         IXZ9IuW+uLtwDQGiDgc2sFnWnuWbgdzgAg0hfK+7O4pfde+yjjpRVi3Ve01Uygjd8krd
         VnSg==
X-Gm-Message-State: ACrzQf34Aq83boKOYXyQOGEgra4AWNSiHEK9EqaoSQfdDFB9rWLUIEoR
        5LY8I4BjUdwbxBs8Gv1KGFsTew==
X-Google-Smtp-Source: AMsMyM72ogfym/DpKOSsJCPhbYyEwdEP7gIqbiSDRSy1NmPzDyV2igPP4gYre6FfScxr//+w3eB4Pg==
X-Received: by 2002:a17:902:d54e:b0:178:2da7:1bea with SMTP id z14-20020a170902d54e00b001782da71beamr1797101plf.161.1663625721063;
        Mon, 19 Sep 2022 15:15:21 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c61:6535:ca5f:67d1:670d:e188])
        by smtp.gmail.com with ESMTPSA id b22-20020a170902d89600b00176ab6a0d5fsm16198966plz.54.2022.09.19.15.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 15:15:20 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, thara.gopinath@gmail.com,
        devicetree@vger.kernel.org, robh@kernel.org,
        krzysztof.kozlowski@linaro.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        Jordan Crouse <jorcrous@amazon.com>
Subject: [PATCH v6 0/4 RESEND] ARM: dts + defconfig: Add support for Qualcomm QCE block on new SoCs and in defconfig
Date:   Tue, 20 Sep 2022 03:45:05 +0530
Message-Id: <20220919221509.1057574-1-bhupesh.sharma@linaro.org>
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

Fixed the typos in the cover letter while resending this version.

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

Tested the enabled crypto algorithms with cryptsetup test utilities
on sm8150-mtp, sa8155p-adp, sm8250-mtp and RB5 boards (see [1]) and
also with crypto self-tests, including the fuzz tests
 (CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y).

Note that this patchset is dependent on the dt-bindings patchset (see [2]) sent to devicetree list.

[1]. https://linux.die.net/man/8/cryptsetup
[2]. https://lore.kernel.org/linux-arm-msm/20220919195618.926227-1-bhupesh.sharma@linaro.org/

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

