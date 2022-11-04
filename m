Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9276261982A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 14:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbiKDNfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 09:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiKDNfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 09:35:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A072654F;
        Fri,  4 Nov 2022 06:35:05 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EFEA46602983;
        Fri,  4 Nov 2022 13:35:02 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667568903;
        bh=5zVFbOlZO3cpcZegyOO2ArKFxcWAE4CtGWVYB50hZew=;
        h=From:To:Cc:Subject:Date:From;
        b=Ld2rBMNvLghpIDMDNnghqQHt5xz818bqJMmAkHKiZQCeX/uL2vmOhOa4a4aGeWry9
         HWm4u0V+SzuIOr7KMfVjPjzcED5SJDJ45oxK6U4p09vhqAZPDEZwpd3sq9QY4KoggU
         KLEVtIzFy1JoFDRF88pBBYy7f8ruz6pitTUm354JEvAGbO+KIul08As8MxjMJXFLs5
         qaDsAuoKtNs4yhrT2EOlDlunOHotbXloqgGISC+WKqqzfT4zJ/SSU7xKz/0ELsX+1p
         g0lpQDmFItZSH+UGW1Mhn0xjr4d9VyDP8lY5QFXiqdqRQMuSzShe3pB48x6Gv5s6tQ
         vv7G4+6OuHy/g==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, marijn.suijten@somainline.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 0/2] Support MSM8976 SAW2 for both clusters
Date:   Fri,  4 Nov 2022 14:34:50 +0100
Message-Id: <20221104133452.131227-1-angelogioacchino.delregno@collabora.com>
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

This series adds support for the L2 cache SAW2 on MSM8976,
required to configure sleep modes and managing part of DVFS.

AngeloGioacchino Del Regno (2):
  dt-bindings: soc: qcom: spm: Add compatibles for MSM8976 L2
  soc: qcom: spm: Implement support for SAWv2.3, MSM8976 L2 PM

 .../bindings/soc/qcom/qcom,spm.yaml           |  2 ++
 drivers/soc/qcom/spm.c                        | 33 +++++++++++++++++++
 2 files changed, 35 insertions(+)

-- 
2.37.2

