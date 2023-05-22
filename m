Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE6270B8EB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232022AbjEVJaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbjEVJaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:30:12 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26752A8;
        Mon, 22 May 2023 02:30:10 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CAC3E66032CE;
        Mon, 22 May 2023 10:30:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684747808;
        bh=GxVItKEsT8c0ceF0ObJivEmeAbzK49Pu38oLODBmZgU=;
        h=From:To:Cc:Subject:Date:From;
        b=Sftz555q5xVRiBE6mu/zf5/4HJFfQCqQWGJFWQ2mJbK4OaSCeQb/SHrYZcTsKuMj/
         JBsbX3w2jF+Yd6Y9VHyh5x09NYfjcscXzx0ZGjewKVEMWbkbqh0zc1eMKQ3oCnAxD7
         rcqUBboits9kJ8TuYmnbzlR/flqoj1ypGFurmEbIR1gm6UaLdhnsFT8bEMQopnLIMs
         ss+sh9o2HzdOsUG1s3icAcu2/8KUwz7EsPLw64FycXXNsD4QZQW6Z7RK7etk6Qowr7
         0P7UfzqLuvLj/KkqEgp6iYCGK0Qz071FXloUtnOddYE0gKngqAxKRp3VjLyBj8ZCMt
         3CalOoiVs5TqQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, weiyi.lu@mediatek.com, ikjn@chromium.org,
        chun-jie.chen@mediatek.com, tinghan.shen@mediatek.com,
        seiya.wang@mediatek.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 0/2] MT8192/95: Set correct MSDCPLL rate
Date:   Mon, 22 May 2023 11:30:00 +0200
Message-Id: <20230522093002.75137-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series improves both stability/reliability and performance for
eMMC and SD cards on MT8192 and MT8195, where the PLL may be set at
a sub-optimal rate from the bootloader.

This was tested on MT8192 Asurada Spherion and MT8195 Cherry Tomato
Chromebooks.

AngeloGioacchino Del Regno (2):
  arm64: dts: mediatek: mt8192: Make sure MSDCPLL's rate is 400MHz
  arm64: dts: mediatek: mt8195: Make sure MSDCPLL's rate is 400MHz

 arch/arm64/boot/dts/mediatek/mt8192.dtsi | 2 ++
 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 2 ++
 2 files changed, 4 insertions(+)

-- 
2.40.1

