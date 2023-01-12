Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863E5668478
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 21:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbjALUxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 15:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232842AbjALUwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 15:52:55 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3102FACF;
        Thu, 12 Jan 2023 12:26:31 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id y18so17022596ljk.11;
        Thu, 12 Jan 2023 12:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ToTfVSINCq1vTbWWorTxY4lvCe0zPhUxxrJQUXc5LXA=;
        b=acPEpDRXzH90lhTZpws66xzyETCAdqnXYU4zKZ/GBkFvtb0p8VVCVBTFIERI+zOanq
         8bZGhNjoBcN/tehvpEGcHTJWqwyi9t/oo50SfJ5K01FeVBYD8tVPPOy8zovBQkXGNNZZ
         WmrPHKoDkez4++vTlmxQ8jpsQTJ0uJpmQGkj9/t8KKRj/q17Bx9BtOqFXvyJjZZps5Fs
         JPS/7YKKfEKmlC4c3lp37CcrD3VK7RSyy3GbM/sNzzMnU8tir2Ded9q+tTQa+9nYEObs
         c/xjbHIL+FU+dQc89FC6JQSxbOUs4Bb5d05bv3yPEMRnuc0QCQEFVJ31LOjQ7Vfb2i1L
         dr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ToTfVSINCq1vTbWWorTxY4lvCe0zPhUxxrJQUXc5LXA=;
        b=5RQ7b7PSqSYGAXAEfmlGF0X/ByoVlNAkIIaLr1hSJORV/4rIiv4OXuilYSpckGRuwF
         jTYoG6QOqK4Qrmm+JAZFVNyCGlnfb9cPNYaitqLzS8REJoioHIfmEzmaYAzChOsZwTjf
         RskczWaj4uJBy/e9urQlq0D3SzZJx0U5ICKvbwDSZh8j5gom5jG3NyGuxXr8gJgIUKLV
         5QdDO2Q15Ukt6t/mKBSBSmQtnwJay0EQjYKHjbfzu6QusPjnXSMB9lZkWf5qLcOlxyYE
         ckOUFfut/sQ83l+x/At0HGTureOlwDVUuvjETznS6AzwPMtEJskjPqLNNU5qnjvICjVr
         2KFA==
X-Gm-Message-State: AFqh2kpQjf/qeLuDk8xnRx3MXGF/JOmAs2LKBYjAJvrBaZuj5cu4LbDe
        6cCwKaFe18xMOmbwOeP3+Ka6texX/OqBLA==
X-Google-Smtp-Source: AMrXdXut4N+CpUE1lMni2KHSS6cVLYele0wJZLAJwuq4e6x9vskSIev04DYrFG1JwlB57moeHEEQdw==
X-Received: by 2002:a2e:bf1e:0:b0:27b:65e3:3e93 with SMTP id c30-20020a2ebf1e000000b0027b65e33e93mr25222636ljr.45.1673555190105;
        Thu, 12 Jan 2023 12:26:30 -0800 (PST)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id k6-20020a2eb746000000b00281350bb5fbsm2346731ljo.2.2023.01.12.12.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 12:26:29 -0800 (PST)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH 0/8] Modem support for MSM8226
Date:   Thu, 12 Jan 2023 22:26:03 +0200
Message-Id: <20230112202612.791455-1-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This series adds support for modem remoteproc found on MSM8226.
It also adds needed device tree nodes and enables modem used for
location service on matisse-wifi.

Luca Weiss (3):
  remoteproc: qcom_q6v5_mss: Handle platforms with only single power
    domain
  remoteproc: qcom_q6v5_mss: Add modem support on MSM8226
  ARM: dts: qcom: msm8226: Add modem remoteproc node

Matti Lehtimäki (5):
  dt-bindings: remoteproc: qcom,msm8916-mss-pil: Add MSM8226
  dt-bindings: mfd: qcom,tcsr: Add compatible for MSM8226
  ARM: dts: qcom: msm8226: Add node for TCSR halt regs
  ARM: dts: qcom: msm8226: Add smsm node
  ARM: dts: qcom: apq8026-samsung-matisse-wifi: Enable modem

 .../devicetree/bindings/mfd/qcom,tcsr.yaml    |   1 +
 .../remoteproc/qcom,msm8916-mss-pil.yaml      |  41 +++++-
 .../dts/qcom-apq8026-samsung-matisse-wifi.dts |  13 +-
 arch/arm/boot/dts/qcom-msm8226.dtsi           | 127 ++++++++++++++++
 drivers/remoteproc/qcom_q6v5_mss.c            | 137 ++++++++++++++++++
 5 files changed, 313 insertions(+), 6 deletions(-)

-- 
2.34.1

