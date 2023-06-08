Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00BF72784C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbjFHHLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbjFHHLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:11:17 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31E41FDA;
        Thu,  8 Jun 2023 00:11:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686208271; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=EyXGzWk5qOg4GSCIAy3lW2UQjI1xBH2mtBGSiS4lAzSs70HXRrgkzrOFuoIki3D83d
    YDiuh0FKR2xi8o6wGSFKiRGJUOsnDAuPapmnB/Vc2hqOTMOo0cyUEMJceQZYS5vNaghk
    h9Gh6MDkEH6vOJLlMlrriJbRcrNR1yI1OjVOhq2TsfCrsZOAuNFydsJcxqgAQozLdmuY
    AYtlaCGXeAnpYg9qxYTJqIRb/7vb7olEiEgaONeXhfCxvDujh4eRqsTQa1WpPODoZukP
    XtpK2YNe8ClKjoqXEDUnU89pdqDfQc9HcRAGezrOnrE2eEX7kHVK8H2CVRPJrA/4pWpm
    oFuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686208271;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=e94V8Kezz3qtY3xLT9x24/ZhCtGOkVTLukjovOp8Io0=;
    b=ODlssyIGnyL66sBAo+w/jXpRmaHUtTrPofEfinPuvGX8T2jlAhXOiRG89gAv59D9At
    F6RWqNNNdkld7jIJIVgXqhKeBGN4+7KljMcU/aVv41l8+Wv7QFBFeYv4he4hDSjZpRO5
    tr9unK0eIzISlHaCyTrw6nnTefDb9hHoc4iLNeuwo6UcqABkEmASMmKJglb54keWytmJ
    +m4tH/WervtCk55XT2PlZCFILogmY/mjM345Vgsos+TVZ1hWQgM1gyCwEkPG7BODlvk2
    rxlV5LJjDRZ5QY7a3hGiHXIoui/wL/1mW4Awee69vKK+ndVod4ft+xuo3DGKtlfvSTef
    QtKg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686208271;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=e94V8Kezz3qtY3xLT9x24/ZhCtGOkVTLukjovOp8Io0=;
    b=o9PYSaDyoBym2xOkZGzTgE5tTfSTI0LWSonNqs8FenqHEjukJPato+qEE/D8FHdcOQ
    vtGPl2R1kMob6gwsEI9evgnCCJjsTOFUkzYgSg/M8bEeWsFl9CGgroi/qxPJHPiz1Pwx
    PcnZrBMU17zwL/fe/k8ZksCH9bU5QA/U8xFoNDEIOit6i31Joz2lLqgDJ6LtP4mBLnwp
    tMfL50LCDcPFWiMl+Dny0nDFLmN+bHQpnqc0XhnejVPwXUqUyqNDuQc3OjWMMUdRFx11
    f+h1CZ8wzF+DjC2gmIqXFpX03wttEOcMWlarP0LXdqdePxDwuxZIVOqS69in/tYEuaHd
    UjRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686208271;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=e94V8Kezz3qtY3xLT9x24/ZhCtGOkVTLukjovOp8Io0=;
    b=h3+wXnICtH32yfWZObSS2Lj1ds/ix142rEBxSZwxwrVU0kTqtoPhzVeX+AUJBiT/DH
    qLCL9glieObTZivubxDA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4ly9TY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z587BBKHt
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 8 Jun 2023 09:11:11 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v2 00/12] Add dedicated device tree node for RPM
 processor/subsystem
Date:   Thu, 08 Jun 2023 09:10:20 +0200
Message-Id: <20230531-rpm-rproc-v2-0-56a4a00c8260@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANx+gWQC/22NTQ6CMBCFr0JmbU1LAdGV9zAsSjvQJtiSKRIN4
 e6OrF28xffyfjbISAEz3IoNCNeQQ4oM5akA600cUQTHDKUstay1EjQ/WZSsuNStbqpWX61zwPn
 eZBQ9mWg9N+JrmticCYfwPg4eHbMPeUn0Of5W9XP/Ta9KSIHS6L5xqAZV3UcknyZ3jrhAt+/7F
 ylWJ+q5AAAA
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Resource Power Manager (RPM) currently does not have a dedicated 
device tree node that represents the remoteproc/subsystem. The 
functionality exposed through the SMD/GLINK channels is described in 
top-level nodes of the device tree. This makes it hard to group other 
functionality provided by the RPM together in the device tree. This 
series adds a single top-level remoteproc-rpm/rpm-proc device tree node 
that groups all RPM functionality together.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Changes in v2:
- Pick up review/test tags from Konrad and Krzysztof
- Rename "remoteproc-rpm" -> "remoteproc" everywhere (Krzysztof/Konrad)
- "dt-bindings: remoteproc: Add Qualcomm RPM processor/subsystem"
  - Squash with other dt-bindings changes to have atomic refactoring (Krzysztof)
  - Add diagrams from discussion as clarification
- "soc: qcom: smem: Add qcom_smem_is_available()"
  - Add return documentation in qcom_smem_is_available() (Konrad)
- "soc: qcom: Add RPM processor/subsystem driver"
  - Add missing of_node_put(), fix children (Konrad)
  - Add depends on RPMSG_QCOM_SMD || RPMSG_QCOM_SMD=n to fix build 
    error in weird kernel configurations (kernel test robot)
- Link to v1: https://lore.kernel.org/r/20230531-rpm-rproc-v1-0-e0a3b6de1f14@gerhold.net

---
Stephan Gerhold (12):
      dt-bindings soc: qcom: smd-rpm: Fix sort order
      dt-bindings: soc: qcom: smd-rpm: Add MSM8909 to qcom,smd-channels
      dt-bindings: soc: qcom: smd-rpm: Add some more compatibles
      soc: qcom: smd-rpm: Match rpmsg channel instead of compatible
      dt-bindings: remoteproc: Add Qualcomm RPM processor/subsystem
      soc: qcom: smem: Add qcom_smem_is_available()
      rpmsg: qcom_smd: Use qcom_smem_is_available()
      soc: qcom: Add RPM processor/subsystem driver
      arm64: dts: qcom: Add rpm-proc node for SMD platforms
      arm64: dts: qcom: Add rpm-proc node for GLINK gplatforms
      ARM: dts: qcom: Add rpm-proc node for SMD platforms
      ARM: dts: qcom: apq8064: Drop redundant /smd node

 .../bindings/remoteproc/qcom,rpm-proc.yaml         | 171 +++++++++++++++++++++
 .../devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml |  23 ++-
 .../devicetree/bindings/soc/qcom/qcom,smd.yaml     |   7 +
 arch/arm/boot/dts/qcom-apq8064.dtsi                |  40 -----
 arch/arm/boot/dts/qcom-apq8084.dtsi                |   6 +-
 arch/arm/boot/dts/qcom-msm8226.dtsi                |  38 ++---
 arch/arm/boot/dts/qcom-msm8974.dtsi                |  44 +++---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi              |  48 +++---
 arch/arm64/boot/dts/qcom/ipq9574.dtsi              |  28 ++--
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |   6 +-
 arch/arm64/boot/dts/qcom/msm8939.dtsi              | 112 +++++++-------
 arch/arm64/boot/dts/qcom/msm8953.dtsi              | 136 ++++++++--------
 arch/arm64/boot/dts/qcom/msm8976.dtsi              | 152 +++++++++---------
 arch/arm64/boot/dts/qcom/msm8994.dtsi              |  99 ++++++------
 arch/arm64/boot/dts/qcom/msm8996.dtsi              | 113 +++++++-------
 arch/arm64/boot/dts/qcom/msm8998.dtsi              |  98 ++++++------
 arch/arm64/boot/dts/qcom/qcm2290.dtsi              | 126 +++++++--------
 arch/arm64/boot/dts/qcom/qcs404.dtsi               | 152 +++++++++---------
 arch/arm64/boot/dts/qcom/sdm630.dtsi               | 132 ++++++++--------
 arch/arm64/boot/dts/qcom/sm6115.dtsi               | 128 +++++++--------
 arch/arm64/boot/dts/qcom/sm6125.dtsi               | 140 +++++++++--------
 arch/arm64/boot/dts/qcom/sm6375.dtsi               | 126 +++++++--------
 drivers/rpmsg/qcom_smd.c                           |  10 +-
 drivers/soc/qcom/Kconfig                           |   1 +
 drivers/soc/qcom/Makefile                          |   2 +-
 drivers/soc/qcom/rpm-proc.c                        |  77 ++++++++++
 drivers/soc/qcom/smd-rpm.c                         |  35 ++---
 drivers/soc/qcom/smem.c                            |  11 ++
 include/linux/soc/qcom/smem.h                      |   1 +
 29 files changed, 1161 insertions(+), 901 deletions(-)
---
base-commit: 8d5a57ea6a0b1722725170e32e511701ca7c454c
change-id: 20230531-rpm-rproc-758364839cdd

Best regards,
-- 
Stephan Gerhold <stephan@gerhold.net>

