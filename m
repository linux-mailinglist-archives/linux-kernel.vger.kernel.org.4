Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79ADB5F3614
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 21:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiJCTGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 15:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiJCTGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 15:06:05 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8293FD6A;
        Mon,  3 Oct 2022 12:06:03 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id z23so7476289ejw.12;
        Mon, 03 Oct 2022 12:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=nFbiDq33o+/1OOLfenDeUoeiwYc5KoMc/vKWkTFD+pM=;
        b=SmFGVQpo8SVBvZ9HYu8x94c+ExMpdiZEDCd+x/hlO0mOYrqoHm2/AL+TUw3d05Ix8y
         e0W9s0rUmC+FqjcvZNdl1Z19GZBNoLzr3eKD9WDGoF2NQwg913wVH4wRPVKFwLWZqzpg
         uJem3uxhyCTyEgY7ksDBUbTn7fgMMnNXKcRtUwEhfpg/WEJbNawUgDIOZm1bIPFkINKq
         DhRcneZjp9iF898wfBT8gIHEb06tDbm5dOQ9qJ8RgUjN8y5vDZ3L3QNgtiKn20XlIlYC
         gN1w1L2OKJTXTCbbNj3KnXRbPIUGCoU/Gl8Xb76Apz3DIMxwn9VGoGeMEazPXtj/VhFV
         JZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=nFbiDq33o+/1OOLfenDeUoeiwYc5KoMc/vKWkTFD+pM=;
        b=QvVcr9fvJIQy7Llq2UhzWOylxd3b6IzbL0NY9wRHoq4inf4gmcASPoaUto8tpCNKY/
         lr+AwoMM+JRyGHjlghsRKFx06Dcn7KLip9PDpLoSH0ktqCCd9tG2kZR2cDbclugETmld
         vK4FKdkRGgtElF1lzNtML1+cTFxvgK46My0CfUgE+TG4xUq9EyTkFWOMwdF6c+SC1ckO
         18R6StKkQepZM1whCM56CtxupwI3bQ5beZ3JWLAiKxwaOvaXhOQyuSM7kaBujBbwYDO3
         U4lFTcADa+DpOhcsPCJYjMZ2n6xMv1buqJ55OxswDWq/qfOj+mc4lbE8ZjGdPl9FVifo
         e08w==
X-Gm-Message-State: ACrzQf0B7URmyErGqVY+1Nix8kJ6j/SxLNXx/p8yoR5BpOd5O0oRqRxM
        PTDtNeaSVU6x3BTaUDAhHKl9Ce9pUzU=
X-Google-Smtp-Source: AMsMyM6zkPkaPbVBAgDGtaXPb0pWvwwQByZuhQ1hXUGwGP+kTXtiXIiRFgm30E/xqvw5Gs4LSpjSaw==
X-Received: by 2002:a17:907:7245:b0:782:331b:60f4 with SMTP id ds5-20020a170907724500b00782331b60f4mr16341067ejc.594.1664823962198;
        Mon, 03 Oct 2022 12:06:02 -0700 (PDT)
Received: from localhost.localdomain ([46.216.9.29])
        by smtp.googlemail.com with ESMTPSA id lc23-20020a170906dff700b00787f91a6b16sm5883975ejc.26.2022.10.03.12.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 12:06:01 -0700 (PDT)
From:   Dzmitry Sankouski <dsankouski@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dzmitry Sankouski <dsankouski@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Subject: [PATCH v4 0/2] add device Xiaomi Mi 6 (codename sagit) and board binding
Date:   Mon,  3 Oct 2022 22:05:54 +0300
Message-Id: <20221003190556.931678-1-dsankouski@gmail.com>
X-Mailer: git-send-email 2.30.2
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

Add initial support for Xiaomi Mi 6 phone (codename sagit)

Dzmitry Sankouski (2):
  arm64: dts: qcom: sagit: add initial device tree for sagit
  dt-bindings: arm: add xiaomi,sagit board based on msm8998 chip

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/msm8998-xiaomi-sagit.dts    | 689 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/pm8998.dtsi          |   6 +
 4 files changed, 697 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts

-- 
2.30.2

