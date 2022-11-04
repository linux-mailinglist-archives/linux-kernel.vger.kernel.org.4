Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2C2619833
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 14:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbiKDNfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 09:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiKDNfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 09:35:13 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976982E6B3;
        Fri,  4 Nov 2022 06:35:12 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C24D96602996;
        Fri,  4 Nov 2022 13:35:10 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667568911;
        bh=Ma41/FJNPLklLxOhFEXoQUZzfqxZx3g2ujIOTbQMhEc=;
        h=From:To:Cc:Subject:Date:From;
        b=SG05sZnA0QSM7y0w4Blq9SAIVRFchpO/EFbHYcIGyYdvBFlWGXNVWmasrxcZYGZ/M
         sBqsJ2lG3/KaKaZGF86yMWZWVWwCbrPNZc3d9K2HFBw/9zEzOb2eS7gc5fYCz7hK1k
         D8bz+pb7X7yXf1DZ7hiBRbY1ONtMwcd/I1T9JY9makE04CygXNkbKK+gGqT4RgOlDe
         F0uxMzq5JI3kb6S0XK4nNFXw1pGVdYPD15+NlF3w8n1CLlgrT7pdTMhbhQSbm34jiu
         SzBeMcygIOzsYmpgtD2H717dAtP2V7571FtAQSkqW93CQ+c1sQK4a8oC5dP+AACSmG
         TiWy3mLkfY91w==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, marijn.suijten@somainline.org,
        kernel@collabora.com
Subject: [PATCH 0/2] Qualcomm Ramp Controller and MSM8976 config
Date:   Fri,  4 Nov 2022 14:35:04 +0100
Message-Id: <20221104133506.131316-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds the Qualcomm Ramp Controller driver, necessary on
various legacy Qualcomm SoCs to enable CPU DVFS by programming said
controller with the right values, where the bootloader doesn't do
that before booting the kernel.

At least MSM8976 and MSM8956 require this initial programming to be
performed on Linux.

AngeloGioacchino Del Regno (2):
  dt-bindings: soc: qcom: Add bindings for Qualcomm Ramp Controller
  soc: qcom: Add Qualcomm Ramp Controller driver

 .../soc/qcom/qcom,ramp-controller.yaml        |  42 +++
 drivers/soc/qcom/Kconfig                      |   9 +
 drivers/soc/qcom/Makefile                     |   1 +
 drivers/soc/qcom/ramp_controller.c            | 330 ++++++++++++++++++
 4 files changed, 382 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,ramp-controller.yaml
 create mode 100644 drivers/soc/qcom/ramp_controller.c

-- 
2.37.2

