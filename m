Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7433624ECD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 01:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbiKKATB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 19:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiKKAS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 19:18:57 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F01013CC4;
        Thu, 10 Nov 2022 16:18:55 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id y6so2583859iof.9;
        Thu, 10 Nov 2022 16:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OOo4SlvSYIOiiuy0BanXYMqfarUb0SF2ty1xhFNdmnE=;
        b=nRFIY9VGGIOwfnuPc6t4kHopKZPYwsMGQDje5X+2U1KHyRLZWmVn0hTFyuuMnRkUR+
         XRiS7uWCIRwCgBcL4iJ9+/HNKgFjJPHSDm/BE3CzEyvQJMOJaK6mf6/YbcpJKllPR9WB
         tDJ0+9RZ4wUtXfl5P8jZBSgKwlw/BX5rdxmy+h9V/+4YBL139DhH/ufI7ZojN7iZM2pz
         /QasToHzjwq0gFD2/tfAwetCkcCxR8Egt5Y2LzWTqaidA4q4/+fTMTt+Gp16PSEZgpw6
         s6ZsTn1q3FPk346veNFGDsEUijk7McA5ARD+CNdiZv32TubMnKxDwPBW+TN67TZlKfAq
         tyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OOo4SlvSYIOiiuy0BanXYMqfarUb0SF2ty1xhFNdmnE=;
        b=7ko/ZA72ckzgUc5E2E8eM6Fjg4HtC1GnR7w51FpNkWZs/+gtJOugNZhNdZksB1Bqwo
         DKDqqQGdiZrqdrhxJxJMF4QSTH1NO1yCuCPqaxs79mJlgUmHvlvwJ+mE+4/9rVnnlkRW
         kvQBAtWn46xxGV0tBhnoa9R1t5duUimlJpOh+nPqfrQmts4WX+Q7q/kb3Q0hSS7J+7kZ
         BAwXMLspWYUAMvrIKg0Fz4P4iyqOe8d+XmePK308Ycq5Hy1Sc8+836XDhCQCa5hAR2be
         EXAc9x0lW4hF9Rcvr3yCJeTLCd3cJomLNCMz0uvy4wHsAAP9harwJaeCS0HWOKQKICDx
         1EpQ==
X-Gm-Message-State: ACrzQf1sPtFaUDZD0SfbT6XipsEM3ePEaqrHunQsQB2i7fSr0G7UBysX
        QHnMq4mBL+QLLn5C8gr3p4Q=
X-Google-Smtp-Source: AMsMyM7JYY2ROReRJCPYMJwG9O0lZeX7mP1eBDVcFq2I+Puc6oRTV+TaW8GTwMDOcvv6vB90mGdFgQ==
X-Received: by 2002:a02:740b:0:b0:375:b32f:7c75 with SMTP id o11-20020a02740b000000b00375b32f7c75mr3680131jac.162.1668125934657;
        Thu, 10 Nov 2022 16:18:54 -0800 (PST)
Received: from localhost ([2607:fea8:a2e2:2d00::61cc])
        by smtp.gmail.com with ESMTPSA id v5-20020a056602058500b00688faad4741sm236050iox.24.2022.11.10.16.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 16:18:54 -0800 (PST)
From:   Richard Acayan <mailingradian@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Chanho Park <chanho61.park@samsung.com>,
        Thierry Reding <treding@nvidia.com>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
        Richard Acayan <mailingradian@gmail.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: [PATCH v4 0/4] Initial SDM670 and Pixel 3a support
Date:   Thu, 10 Nov 2022 19:18:15 -0500
Message-Id: <20221111001818.124901-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes since v3:
 - remove qcom,msm-id and qcom,board-id (4/4)

Changes since v2:
 - remove intc address and size cells (4/4)
 - move apps_rsc label property down (4/4)
 - move properties in intc (4/4)
 - remove leading zeroes in iommus (4/4)
 - change 0x0 to 0 in regs except cpu (4/4)
 - change 0 to 0x0 in memory regs (4/4)
 - convert hex to decimal in rmi4 #cells properties (4/4)

Changes since v1:
 - remove i2c interconnects (4/4)
 - change regulator phandle names (4/4)
 - change regulators node names (4/4)
 - remove clock-output-names from xo-board (4/4)
 - remove vdd-supply from touchscreen (4/4)
 - move clocks to device dts (4/4)
 - reorder pmic nodes, root nodes, and phandle references in dts (4/4)
 - move status properties to bottom of nodes (4/4)
 - accumulate commit message tags (1-3/4)

Do not apply this series yet. It is only for review comments. It can be
applied once the "qcom,sdm670-smmu-500" compatible string gets added (or
now if you don't care about handling an unnecessary quirk).

This adds the device trees and bindings to support the Qualcomm
Snapdragon 670 and Google Pixel 3a. This patch series, specifically the
last patch, depends on:

[PATCH v4 0/3] SDM670 Global Clocks
  https://lore.kernel.org/all/20220914013922.198778-1-mailingradian@gmail.com/T/
[PATCH v2 0/2] RPMh Support for PM660 and PM660L
  https://lore.kernel.org/all/20220920223331.150635-1-mailingradian@gmail.com/T/
[PATCH v2 0/2] SDM670 RPMh Clocks
  https://lore.kernel.org/all/20220920223734.151135-1-mailingradian@gmail.com/T/
[PATCH v2 0/2] SDM670 USB 2.0 support
  https://lore.kernel.org/all/20220922024656.178529-1-mailingradian@gmail.com/T/
[PATCH 0/2] SDM670 SDHCI support
  https://lore.kernel.org/all/20220923014322.33620-1-mailingradian@gmail.com/T/
[PATCH v2 0/2] SDM670 Power Domains
  https://lore.kernel.org/all/20221004221130.14076-1-mailingradian@gmail.com/T/
[PATCH v10 0/3] SDM670 Pin Control Driver
  https://lore.kernel.org/all/20221014001934.4995-1-mailingradian@gmail.com/T/
[PATCH v6 0/4] SDM670 GPI DMA support
  https://lore.kernel.org/all/20221018005740.23952-1-mailingradian@gmail.com/T/
[RFC PATCH v2 0/11] iommu/arm-smmu-qcom: Rework Qualcomm SMMU bindings and implementation
  https://lore.kernel.org/linux-arm-msm/20221102184420.534094-1-dmitry.baryshkov@linaro.org/T/
[PATCH v4 0/1] iommu: SMMU for SDM670
  https://lore.kernel.org/linux-arm-msm/20221108025847.58352-1-mailingradian@gmail.com/T/

Richard Acayan (4):
  dt-bindings: arm: cpus: add qcom kryo 360 compatible
  dt-bindings: arm: qcom: add sdm670 and pixel 3a compatible
  dt-bindings: firmware: scm: add sdm670 compatible
  arm64: dts: qcom: add sdm670 and pixel 3a device trees

 .../devicetree/bindings/arm/cpus.yaml         |    1 +
 .../devicetree/bindings/arm/qcom.yaml         |    6 +
 .../bindings/firmware/qcom,scm.yaml           |    1 +
 arch/arm64/boot/dts/qcom/Makefile             |    1 +
 .../boot/dts/qcom/sdm670-google-sargo.dts     |  531 ++++++++
 arch/arm64/boot/dts/qcom/sdm670.dtsi          | 1160 +++++++++++++++++
 6 files changed, 1700 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts
 create mode 100644 arch/arm64/boot/dts/qcom/sdm670.dtsi

P.S.: Thank you to all the maintainers and reviewers who went through
everything and made helpful comments!

-- 
2.38.1

