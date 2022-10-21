Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F72607AA0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 17:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiJUP3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 11:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbiJUP2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 11:28:43 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E674279D60
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 08:27:57 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id v1so5364077wrt.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 08:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=Ykf9HWPkQddpY0wzWOTNMdHcI+0FLQ+ZFPIJCxSFMvY=;
        b=wNU5j3vfnVig9JLrA+OOPWyaVwQi2WEInCO54P+B9TG66cgx5kHTonqdWyRC9hCEtR
         SAAD2VAWWfwVOzprh1AgTPS278M3br03Zp3f8u8iMnLMy4EGEDlid3wjwdVKtFKwzL9B
         cHkhdIWgM0Peh3/Ahj/1pH9uXXa4C7NMyQ6W4cSgwMLxYP1dF0x61t6nbtteqMBUXffR
         BYVxIqMGgg4RhodL2dOL+/0pjtYenAwc5+ptbWFmbfxNXS1lSxMdc6WWrAwNKKzpz8oR
         WJ4qvb3OkN8rPSfAzYmWcXUWMNYhLZXHb7EfVb9odwz2SpK4jDUxWcJkyLGI8QguY76l
         pcvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ykf9HWPkQddpY0wzWOTNMdHcI+0FLQ+ZFPIJCxSFMvY=;
        b=A9RxdIBHlxoLTmmwJ+AxMB2iYuJYx5/67hIHaKCXA2dee2BvNe/yYpaIOFWlfJ3h20
         dYcbiQ9byQWouqP8TAySx/uxxemxgPz7RYg8NaOprFV9RMWgzsw7V3PZ4T3Jc+hQfpIO
         Ibt0EO9BXPd1OfZgUKSQe4Bkb+s7mIzEElgnrVkdpFopvfede5ZHi79LGU5bC29tbJKn
         30P/Qut/MJB0KO0HSPYU7Grzp3uQv15+102DaEQN9KRSSWESXOrFokazNwGze/3NPjlP
         xaUEaR6c9sNCkMlFzQrnifBKJHbKtm8NpLAC4CCfWZ05mKl9c7L/aGEZnditiDrVNtvN
         t52w==
X-Gm-Message-State: ACrzQf1bpWPnPhyZlONY71hvlmYbJN4dvU87/RTHHSORGg9GRNSXLha4
        O7kKS/dnZGdm4fw3y8HJwKoCzQ==
X-Google-Smtp-Source: AMsMyM43ZN0lBozH8SQQXg1i9ZhUI7Lb/oIHhMsRUEoatIC3ZMKV1RQf2rJHTbiqdgXkUHkH94EvlQ==
X-Received: by 2002:a5d:47c7:0:b0:22e:37c6:3d7d with SMTP id o7-20020a5d47c7000000b0022e37c63d7dmr12548369wrc.163.1666366075694;
        Fri, 21 Oct 2022 08:27:55 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id j8-20020a05600c1c0800b003c6b7f5567csm10706169wms.0.2022.10.21.08.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 08:27:55 -0700 (PDT)
Subject: [PATCH v3 0/5] arm: qcom: mdm9615: second round of bindings and DT fixes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAHi6UmMC/43NQQ7CIBAF0KsY1o4ZoEXrynsYFwOlLQkFA5WkaXp3iTtXupr8n/w3G8s2OZvZ9b
 CxZIvLLoYa5PHAzERhtOD6mplAIThiC3M/d4q38HTBLMnDSrMHLofW8As1vSRWp5qyBZ0omKmOw8v7
 Wk4uLzGtn1eF13P/oRYOCGi0QVRWkMSbd4FSPMU0skcVi/hHEVVRshusOhM22n4p+76/ARRIk0AEAQ AA
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 21 Oct 2022 17:27:52 +0200
Message-Id: <20221005-mdm9615-pinctrl-yaml-v3-0-e5e045644971@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a second round of bindings & DT fixes for the MDM9615 platform.

This second round focuses on less trivial changes like pinctrl & regulators bindings,
the remaining work will mainly be fixing the qcom,kpss-timer/qcom,msm-timer situation and
add bindings for qcom,lcc-mdm9615, qcom,kpss-gcc & swir,mangoh-iotport-spi.

Dependencies:
- patch 1,3-4: None
- patch 2: bindings dependency on 20221005-mdm9615-sx1509q-yaml-v2-0-a4a5b8eecc7b@linaro.org

To: Bjorn Andersson <andersson@kernel.org>
To: Andy Gross <agross@kernel.org>
To: Konrad Dybcio <konrad.dybcio@somainline.org>
To: Linus Walleij <linus.walleij@linaro.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Lee Jones <lee@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

---
Changes in v3:
- Path 1: Removed from serie because applied
- Path 2: None
- Path 3: Added reviewed-by tag
- Path 4: Fixed dt-schema title and added unevaluatedProperties
- Path 5: Various schema fixes, uses same naming as other dt-schema for qcom regulators
- New patch added changing regulators names of msm8660 to conform to bindings
- Link to v2: https://lore.kernel.org/r/20221005-mdm9615-pinctrl-yaml-v2-0-639fe67a04be@linaro.org

Changes in v2:
- Rebased on v6.1-rc1
- Patch 1: Fixed bindings and aligned with Krysztof's series
- Patch 2: Rewrote patch title and added reviewed-by tag
- Patch 3: Added reviewed-by tag
- Patch 4: Moved to end, added support for (regulators|-regulators) sudnode
- Patch 5: Fixed schema description and added missing unevaluatedProperties in patternProperties
- Patch 6: Dropped & squashed with patch 4
- Link to v1: https://lore.kernel.org/r/20221005-mdm9615-pinctrl-yaml-v1-0-0cbc006e2a30@linaro.org

---
Neil Armstrong (5):
      arm: dts: qcom: mdm9615: align pinctrl subnodes with dt-schema bindings
      arm: dts: qcom: mdm9615: wp8548-mangoh-green: fix sx150xq node names and probe-reset property
      dt-bindings: regulators: convert non-smd RPM Regulators bindings to dt-schema
      dt-bindings: soc: qcom: convert non-smd RPM bindings to dt-schema
      arm: dts: qcom-msm8660: align RPM regulators node name with bindings

 Documentation/devicetree/bindings/mfd/qcom-rpm.txt | 283 ---------------------
 .../bindings/regulator/qcom,ipc-rpm-regulator.yaml | 128 ++++++++++
 .../devicetree/bindings/soc/qcom/qcom,ipc-rpm.yaml | 101 ++++++++
 .../boot/dts/qcom-mdm9615-wp8548-mangoh-green.dts  |  20 +-
 arch/arm/boot/dts/qcom-mdm9615-wp8548.dtsi         |  22 +-
 arch/arm/boot/dts/qcom-msm8660.dtsi                |   4 +-
 6 files changed, 252 insertions(+), 306 deletions(-)
---
base-commit: 19d64985796125c5e3820c3db995c5df6d13d6dc
change-id: 20221005-mdm9615-pinctrl-yaml-13f5c18a4d3a

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>
