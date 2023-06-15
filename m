Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D20D731E4B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237827AbjFOQvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbjFOQvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:51:07 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE352700;
        Thu, 15 Jun 2023 09:51:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686847854; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=WZWd7Gl/e+4dCnuTPOnZzwtcCG0Og+xPH/+GuAJHhkZXvYaUWsETWHTOyTz5UK2x/Z
    +yO+ojjnfrrcvaec2jkBWl72SEEBHIvcA48Gad4I41Jz6YQvR/kf31rTOxo+W3HAHY5J
    rb24knGAWoen2fQXci+0z1fS7K8vurO1ENC+jb2DiygjEFtH1hrS0S7fPneIYlMlsGon
    K+Bk+Kz9UMmHxYrSTz6EhgsE+KQqTpXJtmeGZZKd+93Km3tWS9CV1y1RgS+cnbvgwuEq
    6QCmFrCxd+wieqXJLT1RILGAtk1nu2LVE8T7kCE84dBS6HcikBs1tLtcWikU6cw+Y6eH
    0fug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686847854;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=9/8QJ+83SZcgzyzGg/ZFQUfcHWHODKJgtfjIafRsPyA=;
    b=BGIuokiT9kjWQkSo+wAoJ//TZD20eiI37QPFtpJxUvDWBV4N5Otwga35iHmVwNwUw7
    5DbG5Yhb2VgBn8nYCoHFWeN6NVjl+BpPgRAy1QKkRIiF2ma+hlNi8ai/9SMLjOfHUuYo
    4NffxUr9O6c9wuOj++3lijWkaRueoz1acQpHg/gV2pSF0mtM7dx+sIWrRANj9jHG12L/
    5qjcHntDbr7XUezlsJPkHc7WHkUAGfLjQwU49Rm5ShbIoqFR3UV1e0/NoGJnwFa7e0Gq
    1zMCujDMgrF07zU5I2Yw4HFX/cENhRiXL469+WhfDavIwI3preUN0pv/PSxdruJw00Y3
    yjkA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686847854;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=9/8QJ+83SZcgzyzGg/ZFQUfcHWHODKJgtfjIafRsPyA=;
    b=oBIXHM/sdqjI9z21xotX84DseviHVTpW4k7xCGTIRY2y4O7Jv+bQjxelfD9qedze5i
    FPvEDFpazpW4pGbEQfMlKV7zV4wdmK+3p/Jr7lxmD1T1UtkWQennsHjzfZj/xlytJkSj
    EnnADF1PIe+UgbHAYA7NFUoucFJtU45HXfq2MVeSTa9J+7q71mk2mATB9LWVO4nqA5cT
    mqqHD4Rk0++aFYwatwQtOMoULzIDX5Crm1MctZXx3bW6FsnaRKgW0DHoiyJTcbtwy0Cm
    3ELud1s3i87QnJ66W8ctLIb886yvNCBgO4QUrsG7avTqi10HuGg3xYX8E7ucj0BBOeKQ
    RKtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686847854;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:Message-Id:Date:Subject:From:Cc:Date:From:Subject:Sender;
    bh=9/8QJ+83SZcgzyzGg/ZFQUfcHWHODKJgtfjIafRsPyA=;
    b=k2QyQAiSYag3CntnROxXNGAizBsC7HYHpctzhG4w9q2W6C4+xndI7rx3u4TgwvsODi
    MyIf57S4i7+J7NK0eUBw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOf59w=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z5FGos42b
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 15 Jun 2023 18:50:54 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v3 00/13] Add dedicated device tree node for RPM
 processor/subsystem
Date:   Thu, 15 Jun 2023 18:50:33 +0200
Message-Id: <20230531-rpm-rproc-v3-0-a07dcdefd918@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFlBi2QC/3WNyw7CIBBFf6VhLYZHi9WV/2FcUJgWkgoNVKJp+
 u9OuzPRxSzOzZx7F5IhecjkUi0kQfHZx4AgDxUxTocBqLfIRDAhWSM5TdMDL0VDT00rVd3Ks7G
 W4H+nM9Au6WAcGuE5jhhOCXr/2gdud2Tn8xzTe98rfEt/VRdOGQWmZacs8J7X1wGSi6M9BpjJ1
 lPEX1eg2yhda8ZMKxT7dtd1/QDD2RAo9QAAAA==
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Changes in v3:
- Rename "glink-rpm" -> "glink-edge" for consistency
- Add extra patch that drops $nodename from qcom,glink-edge.yaml to 
  allow using the same node name for glink-rpm-edge (Krzysztof)
- Link to v2: https://lore.kernel.org/r/20230531-rpm-rproc-v2-0-56a4a00c8260@gerhold.net

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
Stephan Gerhold (13):
      dt-bindings soc: qcom: smd-rpm: Fix sort order
      dt-bindings: soc: qcom: smd-rpm: Add MSM8909 to qcom,smd-channels
      dt-bindings: soc: qcom: smd-rpm: Add some more compatibles
      soc: qcom: smd-rpm: Match rpmsg channel instead of compatible
      dt-bindings: remoteproc: glink-rpm-edge: Use "glink-edge" as node name
      dt-bindings: remoteproc: Add Qualcomm RPM processor/subsystem
      soc: qcom: smem: Add qcom_smem_is_available()
      rpmsg: qcom_smd: Use qcom_smem_is_available()
      soc: qcom: Add RPM processor/subsystem driver
      arm64: dts: qcom: Add rpm-proc node for SMD platforms
      arm64: dts: qcom: Add rpm-proc node for GLINK gplatforms
      ARM: dts: qcom: Add rpm-proc node for SMD platforms
      ARM: dts: qcom: apq8064: Drop redundant /smd node

 .../bindings/remoteproc/qcom,glink-edge.yaml       |   3 -
 .../bindings/remoteproc/qcom,glink-rpm-edge.yaml   |   2 +-
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
 31 files changed, 1162 insertions(+), 905 deletions(-)
---
base-commit: d89ca618c27b9720f40c7f2b0cde673b51583059
change-id: 20230531-rpm-rproc-758364839cdd

Best regards,
-- 
Stephan Gerhold <stephan@gerhold.net>

