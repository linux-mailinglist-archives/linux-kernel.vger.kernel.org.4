Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411536C3281
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 14:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjCUNWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 09:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjCUNWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 09:22:02 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D824928846
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 06:21:44 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id p34so4524280wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 06:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679404903;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x7qEp4ijrbwAJaZu+DVD/1qkBYaBwVY033kbAkhbKBY=;
        b=tSs6jwFUXQM60idPU7SVCBTnfUOzac3Lbf3ozVkv1AW/hhL3UZn6BJTea0xIjACEtg
         zJQByD8nwd6l9n/sM5wjU1/DQStMgEXVuxmn+Jq8m4te/j4kHdd7b/VGSP5Hkuidj+Vi
         T44rZOW3BK3qQWR0D/ujPWsIdnPakB9zNkHOQq3BUNROi7NNoWuhad7B+4fnSYQ8WjQB
         kt/EsDJaJJ+lsT4ht23wpMMfjo/2aksNl9LVww/dRZ1992Uz6QQqiIZfTDzZajggqmDz
         LJhl2UXVoYwpH7lFjG0qOBejNlYtRlvV8cZ1bKxEirGZM/00pxx6Oft7zuYOtmsufU6z
         wOxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679404903;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x7qEp4ijrbwAJaZu+DVD/1qkBYaBwVY033kbAkhbKBY=;
        b=Mmm6oawSf9SMFiZchiXbU75zwTqxo1A06DrSajuCCcEKvsF/uO0R4BvRn11uha/suo
         3QwQWJ8UAt9kgYm1/K/aZJ0mGmiW3YF5uiMUMNMRu5gtLMSBePyD0DMmxpHnihQ2/PhG
         CfKw0CIXHCjXp0bsLoFLIdSoiSfIlAGJZsAoOHvjRcKUPhxl8WOLnmTJ1cr1KWZAb56H
         +v8C11XAmLAsbFUipI/MY+v6XeVbsvx4C8GanKQtIuGYo68J9CnFEXVdLb0FKd+zPN4P
         ex0Pl/tsGyT/C617EAHT95pESC3f3QPOKHhd6O5RSnwlw6jIpmrGONrjVRLWw5CIRCBY
         5DWg==
X-Gm-Message-State: AO0yUKWo+4GEGUEmZsNqbepMSJagxSDase3w68W476FCTYxFn10kvczd
        5jQJxjiwRcRr7jr+CWW2/QaRZg==
X-Google-Smtp-Source: AK7set+I4hdq2gUlIjlYISBAK6GqiK/l8EYqTCGWNLDEDwKzOgN3Z6OGVolWCzPurJlfw1ZgjS+q8Q==
X-Received: by 2002:a7b:c841:0:b0:3ee:392:3a00 with SMTP id c1-20020a7bc841000000b003ee03923a00mr2584535wml.16.1679404902803;
        Tue, 21 Mar 2023 06:21:42 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id v26-20020a05600c215a00b003eafc47eb09sm13393016wml.43.2023.03.21.06.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 06:21:42 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v5 00/12] soc: qcom: add UCSI function to PMIC GLINK
Date:   Tue, 21 Mar 2023 14:21:40 +0100
Message-Id: <20230130-topic-sm8450-upstream-pmic-glink-v5-0-552f3b721f9e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGSvGWQC/5XOS46DMBAE0KtEXk9HjT+AZpV7RFn4C1bARjZBM
 4q4+3SyG2XFskrqV/1k1ZfoK/s+PVnxW6wxJwrq68TsqNPgITrKjCMX2AiENS/RQp17qRAeS12
 L1zMsM5XDFNMdhBEaTWesE4IRY3T1YIpOdiQoPaaJyqX4EH/eu9cb5THWNZff9xtb82oPLG4NI
 KBBbYN2dOMvVOuSz7kM7KVv/KjISeya4DVXrexk+BDFUVGQKG3fouOtcrz/EOVRUZIoehMwKIe
 dcf/Efd//AEsP6pzcAQAA
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMIC GLINK interface offers an UCSI endpoint for newer
SoCs, the UCSI exchange is necessary to configure the USB-C
port USB role and altmode on the SM8450 HDK and SM8550 MTP
boards.
Since the DT description is the same, support for SM8350 HDK
is also added.

This patchset focuses on USB and disables altmode support
on those 2 SoCs until DP altmode over the combo phy is
supported.

Depends on PMIC Glink patchset at [1].

[1] https://lore.kernel.org/all/20230130042003.577063-1-quic_bjorande@quicinc.com/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v5:
- added review tag on patch 1
- fixed patch 9, remove useless port nodes added in patch 6
- Link to v4: https://lore.kernel.org/r/20230130-topic-sm8450-upstream-pmic-glink-v4-0-38bf0f5d07bd@linaro.org

Changes in v4:
- Handle remove for UCSI driver
- Fixup client mask match data handling
- Added USB ports bindings review tag
- Link to v3: https://lore.kernel.org/r/20230130-topic-sm8450-upstream-pmic-glink-v3-0-4c860d265d28@linaro.org

Changes in v3:
- Fixed patch 1 by moving mask to pmic_glink_of_match
- Fixed patch 8 by adding back hsphy
- Add bindings change to dwc3 to support separate HS & SS OF graph links
- Link to v2: https://lore.kernel.org/r/20230130-topic-sm8450-upstream-pmic-glink-v2-0-71fea256474f@linaro.org

Changes in v2:
- Moved the dwc3 port subnodes to dtsi
- Added SM8350 HDK support
- Added help about ucsi module name
- Added bindings acks
- Fixed sm8550 pmic glink compatible
- Added more description in config update patch
- Link to v1: https://lore.kernel.org/r/20230130-topic-sm8450-upstream-pmic-glink-v1-0-0b0acfad301e@linaro.org

---
Neil Armstrong (12):
      usb: typec: ucsi: add PMIC Glink UCSI driver
      dt-bindings: soc: qcom: qcom,pmic-glink: document SM8450 compatible
      dt-bindings: soc: qcom: qcom,pmic-glink: document SM8550 compatible
      soc: qcom: pmic_glink: register ucsi aux device
      dt-bindings: usb: snps,dwc3: document HS & SS OF graph ports
      arm64: dts: qcom: sm8350: add port subnodes in dwc3 node
      arm64: dts: qcom: sm8450: add port subnodes in dwc3 node
      arm64: dts: qcom: sm8550: add port subnodes in dwc3 node
      arm64: dts: qcom: sm8350-hdk: add pmic glink node
      arm64: dts: qcom: sm8450-hdk: add pmic glink node
      arm64: dts: qcom: sm8550-mtp: add pmic glink node
      arm64: defconfig: add PMIC GLINK modules

 .../bindings/soc/qcom/qcom,pmic-glink.yaml         |   2 +
 .../devicetree/bindings/usb/snps,dwc3.yaml         |  16 +
 arch/arm64/boot/dts/qcom/sm8350-hdk.dts            |  46 ++-
 arch/arm64/boot/dts/qcom/sm8350.dtsi               |  19 ++
 arch/arm64/boot/dts/qcom/sm8450-hdk.dts            |  45 ++-
 arch/arm64/boot/dts/qcom/sm8450.dtsi               |  19 ++
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts            |  45 ++-
 arch/arm64/boot/dts/qcom/sm8550.dtsi               |  19 ++
 arch/arm64/configs/defconfig                       |   4 +
 drivers/soc/qcom/pmic_glink.c                      |  65 +++-
 drivers/usb/typec/ucsi/Kconfig                     |  10 +
 drivers/usb/typec/ucsi/Makefile                    |   1 +
 drivers/usb/typec/ucsi/ucsi_glink.c                | 345 +++++++++++++++++++++
 13 files changed, 621 insertions(+), 15 deletions(-)
---
base-commit: 6f72958a49f68553f2b6ff713e8c8e51a34c1e1e
change-id: 20230130-topic-sm8450-upstream-pmic-glink-3b3a0b7bcd33

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

