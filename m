Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3C0644204
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 12:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbiLFLXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 06:23:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbiLFLXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 06:23:40 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B31E2E0;
        Tue,  6 Dec 2022 03:23:38 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E248F6602AB2;
        Tue,  6 Dec 2022 11:23:35 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1670325816;
        bh=pflO3+JjfuOlmrDrXsHRzLY1ckIT51oZKH69uJ2/kFU=;
        h=From:To:Cc:Subject:Date:From;
        b=LeQ+CAX+P1ud0kPdsRBQmDFhAqHBbFW4Zh8RcIWbavEG1VjhQDyBLHrj0q9nfb0bH
         itWZKgMIxdt0/yTsPLZnfHV9TnFyqKl+9neL+agkl4WD/niF+U/gzJ/PaIyQv33QRq
         M9I7urg7N6pTH9lCc4iaHwp1fpSJ1spx8/YOsRi0hFDOxidhbXJv3+KGWBNvhxrG6c
         kl5DdLs6QjjyhA8tLTgGv0ek9um1CSjKejrSTADqVDY36Js+q+xMvAQzdQwuvYwAAP
         e244za1/0O3BU6v2zo1ZPqlRhnb+xJCIY/fVfCcjMO2l6yib9vUuDFwodbkqaL25wI
         CjkB7ECDlx2og==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        nfraprado@collabora.com, kernel@collabora.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 0/5] Add CPU caches information for some MediaTek SoCs
Date:   Tue,  6 Dec 2022 12:23:25 +0100
Message-Id: <20221206112330.78431-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.38.1
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

In devicetrees for MediaTek SoCs the CPU caches information, if
present, is incomplete as it misses cache size, cache line size
and number of cache sets which, in turn, will also prevent any
cache associativity calculation.

For all of the SoCs that I know and/or I have information for,
I've added the right information for I/D, L2 and L3 where present.
This will also make the cacheinfo driver to correctly export the
CPU cache information to sysfs.

AngeloGioacchino Del Regno (5):
  arm64: dts: mt8195: Add complete CPU caches information
  arm64: dts: mt8192: Add complete CPU caches information
  arm64: dts: mt8186: Add complete CPU caches information
  arm64: dts: mt8183: Add complete CPU caches information
  arm64: dts: mt6795: Add complete CPU caches information

 arch/arm64/boot/dts/mediatek/mt6795.dtsi | 50 ++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi | 74 ++++++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8186.dtsi | 58 +++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 58 +++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 58 +++++++++++++++++++
 5 files changed, 298 insertions(+)

-- 
2.38.1

