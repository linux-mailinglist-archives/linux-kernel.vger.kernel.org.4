Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04C85BF5A5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 06:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiIUE4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 00:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiIUE4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 00:56:15 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A887C1AF
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 21:56:14 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id p18so4492717plr.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 21:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=uLS0pqX8ABlHPyY6IrFy7TWkhrlEvTMPKR/GQlZ1z0w=;
        b=hNex4eY8EhXjnt1674fczrOqm70GjFPvOV1SNGPjimcyMKTk2Jh5me9A1MpxXqw39r
         iJf0sJrHHqz3rzTJF2FltTmteto7EU4nfh7HfjIxFcvLwG7fwnIju+VC/A+F98h+h0cD
         l/v2jC3fOkRIpIvZn/3DxFbtwM8d6gVOyqVYrRFJ2JlXWjl1vpxg92Dg+SGtWK39Affi
         eSMBCnqEPlb/VDKmziCuN8m5R41/EhIlES8lhm/qPqIBHGZ81VifTJpnEbEUTHwsd6PR
         lK1wo0ZqJL2G9RktxofIa1MhsrRxrS0ZZXtmRvAHObgrI8nBfZ36SSYjncl6g7KL58+H
         PDIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=uLS0pqX8ABlHPyY6IrFy7TWkhrlEvTMPKR/GQlZ1z0w=;
        b=67zCpw/9z4THgxgvcXYnG/jP3IqMqeWxq3/odW/kAsUcOWwV8+7MXB3XL8K26JTzCA
         8OnbdzRZlQW+IoS18QPWJnWWEFazmRmLq3EenFLv9fULAFtKkXiwCi2BxO+DuX0a3MW3
         F4dCG1GYT59I4hdzzUz9/+M+QXjVIqm3355lqK8sz69VtwTUWkned0csgU5sO+zpztGZ
         4YYHt3md2I7p2FBIyaMm7OGZK58UsND9Q0K1kZ0vz8W29TCGfrKrTXYCmCSk/b1gBaOS
         p3pmiWtINUGnBpPlr9So9GRbyvn9xwGIEkepmL3LJkeOZg5brrxgFkWQCrCMLkq4+Dzb
         SiOg==
X-Gm-Message-State: ACrzQf1SXaepc0WcOv7WIvQJEUTwKfSKUPJ5m74G4+tYqOAPSr+uY1U6
        U9z0mmJ+xuPJXedVUCZPid9DaA==
X-Google-Smtp-Source: AMsMyM5nWzgZ2Rl60J9B4u0WHGfzX97RusUs4fUlT2dpP12UcASoz+ZehA35R85RZDRSQO/R+ynJRg==
X-Received: by 2002:a17:902:b7c6:b0:178:b625:e9f7 with SMTP id v6-20020a170902b7c600b00178b625e9f7mr2959524plz.128.1663736173521;
        Tue, 20 Sep 2022 21:56:13 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c61:8e50:8ba8:7ad7:f34c:2f5])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902e74c00b00176e2fa216csm871829plf.52.2022.09.20.21.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 21:56:12 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     agross@kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, thara.gopinath@gmail.com,
        devicetree@vger.kernel.org, robh@kernel.org,
        krzysztof.kozlowski@linaro.org, andersson@kernel.org,
        bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        Jordan Crouse <jorcrous@amazon.com>
Subject: [PATCH v7 0/4] ARM: dts + defconfig: Add support for Qualcomm QCE block on new SoCs and in defconfig
Date:   Wed, 21 Sep 2022 10:25:58 +0530
Message-Id: <20220921045602.1462007-1-bhupesh.sharma@linaro.org>
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

Changes since v6:
=================
- v6 can be seen here: https://lore.kernel.org/linux-arm-msm/30756e6f-952f-ccf2-b493-e515ba4f0a64@linaro.org/
- No code changes since v6.
- As per Krzysztof's suggestion on v6, clubbed the crypto driver and
  dt-bindings changes together. Now the overall v5 patchset into 3
  separate patchsets, one each for the following areas to allow easier
  review and handling from the maintainer:
        arm-msm, crypto and dma 
- This patch targets the arm/arm-msm tree specifically.
- This patchset is dependent on the crypto + dt-binding patchset, which
  can be seen here:  https://lore.kernel.org/linux-arm-msm/20220920114051.1116441-1-bhupesh.sharma@linaro.org/

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

[1]. https://linux.die.net/man/8/cryptsetup

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

