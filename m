Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CAF721F25
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 09:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjFEHLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 03:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbjFEHKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 03:10:20 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5349CE44;
        Mon,  5 Jun 2023 00:09:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685948952; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Ds03rjV6L/KUIbJVzZE7Et2ppDS6H8wuSRxoK+oNodpqehWOWIgHR486H2PT/Y0LZ+
    egR8u58m0m2XId0tGiiuFUxoQ/Lmrymq5weSX9dqE73CHk51XYBa7+Jm1F8HEsNu5l/X
    lUWv2Ye+G2C01z2oikAuWrATJGmrMh+kG11kIXqtag/8jT76o5yrZAeM/alnABJ815MF
    ty83DPXGJZwYradkFO+oVoTLIvtA8+RyA6qH827O/GMgYl9tPoFl1GPB0XYefLGAds0n
    apnvkH+g126ARsFf0nUnGrVdQHbchSoyUNYXTkqhoIvpkpodm7L/qzwwEjFEzuJnXy2j
    dWfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685948952;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=tDXvQyb9TQPL8CACuByqs5ZpebJ2G7D0n7f+VTZmq0c=;
    b=io1O51LPqSWDMVtTWZSWW39+xLcVUoX5H1sE/1UWMV4ag/wbj3NJC01YQfKJlVjhqP
    iwoSOMhkOLNXOUEoPL76iFG/SdZSGsvM1Hni5kXHwoeLDnUw9Obp4HpBqi04Vz3y/rWG
    YWx6ThwqsiNgWF5AyshoslY2MR7066DRcqmXObrfFFIkZ1cgy68MpVul3+mk/R5ePKTX
    W/7Ze9cztd+MiZYMYO6FilcdFv6dFWjy6vOK9HEx5W0jHtJxFk+P2GX6ogl3CsY/7Ebx
    6uJuPq3+WV4j+gr7auZVgoHCQq/9pHzeOdYNrPQpSAV3Y8ukbjmgVYgyZhtAfgGXst58
    j38g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685948952;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=tDXvQyb9TQPL8CACuByqs5ZpebJ2G7D0n7f+VTZmq0c=;
    b=lIDu3s9pNBzuwt23zQerZtAxwimNIctDaOiO43KimHgQRnsusWVkK1n4VuJ576NX8J
    hMolD5bER7Lng4bCURA6DbqhzATp4+PgcxOAR+SY7n0JjgKiWM9SCo6jjh4HNl116lN7
    QWjq9yQoY5LvEkGkRB9PckkS8F7Ytfvaj/2naOC/59zTQjGVwTexr3uS0GFIxMUMoOzY
    5eANVpmC3OryIsRENprkXlNxnImVzBGQZ4LdNIU9x0VPbSZPYpEvydc70XlszNXSVr1u
    4TV9DXyplI1HIJ2U5tNrQZfAZQ6pjDjvV0y+AgiW+vR3oGjyHjlHWzq8AlBGOMaeTkzD
    LzKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685948951;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=tDXvQyb9TQPL8CACuByqs5ZpebJ2G7D0n7f+VTZmq0c=;
    b=nse4l3nSLDuEdniyfJ7hh1KGvUPLA3FAHwMvdFVBRVMK32m4fJfuZAb7JTUiAvg4J0
    svoj2NGEgnRARZg3ZKCQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOL5nz0="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5579B8Zy
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 5 Jun 2023 09:09:11 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 00/14] Add dedicated device tree node for RPM
 processor/subsystem
Date:   Mon, 05 Jun 2023 09:08:16 +0200
Message-Id: <20230531-rpm-rproc-v1-0-e0a3b6de1f14@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOCJfWQC/x2NSwqAMAxEryJZW1Dr/yriorZRA1olRRGKdze4m
 MUb3jARAjJhgD6JwHhToMML5GkCdjV+QUVOGIqs0Fmlc8XnLuHDqqZqdV22urPOgfiTCagmNt6
 usvDXtkl5Ms70/AfD+L4f1PcCn3AAAAA=
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
Stephan Gerhold (14):
      dt-bindings  soc: qcom: smd-rpm: Fix sort order
      dt-bindings: soc: qcom: smd-rpm: Add MSM8909 to qcom,smd-channels
      dt-bindings: soc: qcom: smd-rpm: Add some more compatibles
      soc: qcom: smd-rpm: Match rpmsg channel instead of compatible
      dt-bindings: remoteproc: Add Qualcomm RPM processor/subsystem
      dt-bindings: soc: qcom: smd-rpm: Use qcom,rpm-proc in example
      dt-bindings: qcom: smd: Mark as deprecated
      soc: qcom: smem: Add qcom_smem_is_available()
      rpmsg: qcom_smd: Use qcom_smem_is_available()
      soc: qcom: Add RPM processor/subsystem driver
      arm64: dts: qcom: Add rpm-proc node for SMD platforms
      arm64: dts: qcom: Add rpm-proc node for GLINK gplatforms
      ARM: dts: qcom: Add rpm-proc node for SMD platforms
      ARM: dts: qcom: apq8064: Drop redundant /smd node

 .../bindings/remoteproc/qcom,rpm-proc.yaml         | 125 +++++++++++++++++
 .../devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml |  23 +++-
 .../devicetree/bindings/soc/qcom/qcom,smd.yaml     |   7 +
 arch/arm/boot/dts/qcom-apq8064.dtsi                |  40 ------
 arch/arm/boot/dts/qcom-apq8084.dtsi                |   6 +-
 arch/arm/boot/dts/qcom-msm8226.dtsi                |  38 +++---
 arch/arm/boot/dts/qcom-msm8974.dtsi                |  44 +++---
 arch/arm64/boot/dts/qcom/ipq6018.dtsi              |  48 ++++---
 arch/arm64/boot/dts/qcom/ipq9574.dtsi              |  28 ++--
 arch/arm64/boot/dts/qcom/msm8916.dtsi              |   6 +-
 arch/arm64/boot/dts/qcom/msm8939.dtsi              | 112 +++++++--------
 arch/arm64/boot/dts/qcom/msm8953.dtsi              | 136 +++++++++---------
 arch/arm64/boot/dts/qcom/msm8976.dtsi              | 152 ++++++++++-----------
 arch/arm64/boot/dts/qcom/msm8994.dtsi              |  99 +++++++-------
 arch/arm64/boot/dts/qcom/msm8996.dtsi              | 113 +++++++--------
 arch/arm64/boot/dts/qcom/msm8998.dtsi              |  98 ++++++-------
 arch/arm64/boot/dts/qcom/qcm2290.dtsi              | 126 ++++++++---------
 arch/arm64/boot/dts/qcom/qcs404.dtsi               | 152 +++++++++++----------
 arch/arm64/boot/dts/qcom/sdm630.dtsi               | 132 +++++++++---------
 arch/arm64/boot/dts/qcom/sm6115.dtsi               | 128 ++++++++---------
 arch/arm64/boot/dts/qcom/sm6125.dtsi               | 140 ++++++++++---------
 arch/arm64/boot/dts/qcom/sm6375.dtsi               | 126 ++++++++---------
 drivers/rpmsg/qcom_smd.c                           |  10 +-
 drivers/soc/qcom/Makefile                          |   2 +-
 drivers/soc/qcom/rpm-proc.c                        |  76 +++++++++++
 drivers/soc/qcom/smd-rpm.c                         |  35 ++---
 drivers/soc/qcom/smem.c                            |   9 ++
 include/linux/soc/qcom/smem.h                      |   1 +
 28 files changed, 1111 insertions(+), 901 deletions(-)
---
base-commit: 8d5a57ea6a0b1722725170e32e511701ca7c454c
change-id: 20230531-rpm-rproc-758364839cdd

Best regards,
-- 
Stephan Gerhold <stephan@gerhold.net>

