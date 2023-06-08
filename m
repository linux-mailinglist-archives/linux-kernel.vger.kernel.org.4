Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8DA728086
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 14:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236456AbjFHMxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 08:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236560AbjFHMx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:53:26 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F112D75
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 05:53:20 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f730c1253fso3659915e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 05:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686228799; x=1688820799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QQqUodnKFRw5PuAn21ea5xgnb65xZ+y7rpLRNAHSBq0=;
        b=QARtFkl3BE7pv0WEI9bFBrivf3G3ykvKP6HcVtAaKp7FW1zn+ez91HsWbb4gcuR5Ky
         RfFFdspFIb+3wCKDqFS64Hc+PvfsN3mM3Jr1S72xl97mQA6j/X2/tX+Gqombh8PmSKLh
         3RH+enwKKNPsKb0N48d5ULAyacpWwDviKbopWQ4iNsLvrIStbOdTsh46TMZMVu0r6xvq
         CUAONNr824F+e5kIObinwqNt/VuKzRvpY/sjdWzNKi/52FQfRBfkz/uRxLUrPyJIQJCe
         W872jVlnM+QkP/tSxOGAboG9PwkG3E5IPuq0yEn50zJgjL2oujbA/TJGZ66G2GCGhumC
         PdfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686228799; x=1688820799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QQqUodnKFRw5PuAn21ea5xgnb65xZ+y7rpLRNAHSBq0=;
        b=T5VMpPG4jRJtEPPceajvrATuMpKpNYg/Tq583099sUf5Wzkyixdz8l1SZyBpoIFZL0
         5znblwDIsL33tcdcg6QF174j8xvW/r+9nev2ggPEOAPL+DmQz29wtHorV9pml5Cp5VKO
         L14BHNz3NoooOoz+7CkhZvmythXHa3CV24AXPzrXp2SInlAPHChmLDBfSLwBrMp6e7cN
         EOVsoL2ZSK5tcEkecA2q4V9R18MbdF3M8ZCScgz2JEzoWP20B+C2ARoiMfXHNoZLEBjf
         MdYviqpDDJV+uPIl0AiRPvtsbGIBawRUaTKfBOyAthA7HTYY6TrsvZn4zHS9w8qaA04X
         VJyA==
X-Gm-Message-State: AC+VfDxTrfOR5iqTeNM3aRD+3oM/e1uwIrBd9S3bixcIUarPTLKfwy3y
        I2CUEt5F1RoxkiOJ77tZX9CLlg==
X-Google-Smtp-Source: ACHHUZ4ru1zt3M7bVlzAGdqtRefGHALasJmz6KndsByVBcsJZDFjMn5AzZvwh1kkEygV4dHKKqhlMw==
X-Received: by 2002:a7b:cbc6:0:b0:3f6:2ee:6993 with SMTP id n6-20020a7bcbc6000000b003f602ee6993mr1538418wmi.4.1686228799390;
        Thu, 08 Jun 2023 05:53:19 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id m22-20020a7bce16000000b003f7e4d143cfsm1894032wmc.15.2023.06.08.05.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 05:53:18 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     johan+linaro@kernel.org, agross@kernel.org,
        konrad.dybcio@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 0/6] clk: qcom: sc8280xp: add lpasscc reset control
Date:   Thu,  8 Jun 2023 13:53:09 +0100
Message-Id: <20230608125315.11454-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On SC8280XP, LPASS IP is controlled by q6dsp, however the reset lines
required by some of the IPs like Soundwire still need to be programmed from
Apps processor. This patchset adds support to reset controller on LPASS
CC and LPASS AudioCC.

Tested on X13s.

Thanks,
Srini

Changes since v2:
	- removed qcom,adsp-pil-mode bindings, can be added when
	 we have a variant of this SoC without dsp control
	- added compile check in Kconfig
	- fix variable naming to reflect correct cc.
	- few minor style related changes

Srinivas Kandagatla (6):
  dt-bindings: clock: Add LPASSCC and reset controller for SC8280XP
  dt-bindings: clock: Add LPASS AUDIOCC and reset controller for
    SC8280XP
  clk: qcom: Add lpass clock controller driver for SC8280XP
  clk: qcom: Add lpass audio clock controller driver for SC8280XP
  arm64: dts: qcom: sc8280xp: add resets for soundwire controllers
  arm64: defconfig: Enable sc828x0xp lpasscc clock controller

 .../bindings/clock/qcom,sc8280xp-lpasscc.yaml | 60 +++++++++++++
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi        | 21 +++++
 arch/arm64/configs/defconfig                  |  1 +
 drivers/clk/qcom/Kconfig                      |  9 ++
 drivers/clk/qcom/Makefile                     |  1 +
 drivers/clk/qcom/lpasscc-sc8280xp.c           | 87 +++++++++++++++++++
 .../dt-bindings/clock/qcom,sc8280xp-lpasscc.h | 17 ++++
 7 files changed, 196 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sc8280xp-lpasscc.yaml
 create mode 100644 drivers/clk/qcom/lpasscc-sc8280xp.c
 create mode 100644 include/dt-bindings/clock/qcom,sc8280xp-lpasscc.h

-- 
2.25.1

