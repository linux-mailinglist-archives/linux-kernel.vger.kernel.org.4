Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB3D5F9EEA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 14:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiJJMyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 08:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbiJJMyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 08:54:19 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF46D6BCEB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 05:54:17 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r13so16877538wrj.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 05:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date:message-id:reply-to;
        bh=Lojkaj6JUR8NyKzpyCgf7aYSFB/ui7IP7hjT3HzGmaA=;
        b=2ZVTfASKsVZRl4/2uxi09rzItvsxEmUaSC6u4Utu/B/bHQB90LPh3Wdj1roBQdV2us
         dfWvNaLI16Bg1Djx1qzyPkXWIMN8XwBCChGgnBFQ8xFfaZDIxoIT122x5mtJcDziLXLs
         U3DP2l/8XvMF+FDqz93DqxmgpIE2edQNVidX0P6X04cyEcX5FXPAWYHFUkXDr0EUoqkj
         VbVHTe2/W5VVWC2LaodYp78M5UdITPrFhbCy7cKOAGaPuXNGLpjpewKfM0ns2Dt5xco2
         tF/XwTI4VbqPcXTBOHThczPRDzcW1gh+6BCBeTEwmofEBo/RA22GhQ/Ler4YtUBnJ8Jv
         hIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lojkaj6JUR8NyKzpyCgf7aYSFB/ui7IP7hjT3HzGmaA=;
        b=lPO7e+2AIbLcp3ox2bapjSVA0mDmrWIMRn/iccn8dQK0OMOph65GLeeyAXXD2ZaC4H
         Fq3Kk32TikWT7GSEB4uxkCADfUZY2b8oBdNcm+eEKPopM6hE4qxw743IJQwq/LUCLdPQ
         exxUcvrKBYjRU4TWyzlhmIu1LPDrA37JysQ2KMLXyu5TmNx5zr/JKB2X7oIE/d4Dgdfd
         RONjEE/EswpeUj+Lb5TXhrj5yTT3X0rBRE79uX4vDaSaMLPCwPIt1eazz+rTIyDfcDt2
         EoSbSH80ykHPmvM0igEgoVfvAllUlkjFc7OwSzjopymDZqookQnG9OHrTHRbmmOjy4+4
         k0Zw==
X-Gm-Message-State: ACrzQf2qGqfQrCH+CA1IDaYj7kF6s44x4btoCxTf2BKUvUwcy5eagMN8
        TgHiZiB46UPpbm4gndPMWje8/g==
X-Google-Smtp-Source: AMsMyM4XniwUCqXkT/kyXAQIx7tOlQsLDaDX9ILnMkLAe9rrtg3Kg5KL/zu92SdukYFKEL6OAoBQCg==
X-Received: by 2002:a05:6000:1087:b0:22e:3731:e6d with SMTP id y7-20020a056000108700b0022e37310e6dmr12059977wrw.614.1665406455931;
        Mon, 10 Oct 2022 05:54:15 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id v24-20020a1cf718000000b003a6125562e1sm9767020wmh.46.2022.10.10.05.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 05:54:15 -0700 (PDT)
Subject: [PATCH v3 0/3] iommu/mediatek: Add mt8365 iommu support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAO4VRGMC/32OwarCMBBFf0WyNhKnabWu/A9x0UlubaBtJLEFkf67897uPbSr4V44585LZaSArE
 6bl0qYQw5xlFBsN8p1zXiDDl6yIkO0N2avQxyGSefpfo/poVtraneAqS0qJQw3GZpTM7pOqHHqeym7
 kB8xPX83ZpJz+aabSRtd1cwHX3ljqDxz8+wDJ+xcHH4G1kDPLVoCwK7+C16FnIvV5UIE7lgwWjgi+A 8CuyqwIoCr5IfSgkv+J1iW5Q3CS3zibQEAAA==
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Mon, 10 Oct 2022 14:54:06 +0200
Message-Id: <20221001-iommu-support-v3-0-c7b3059b0d16@baylibre.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     iommu@lists.linux.dev,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        linux-mediatek@lists.infradead.org
X-Mailer: b4 0.10.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2223; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=XUk8/lOWPvVlbar9Sj5jb7E2IzZ+DCs5b4DX9AOqtU8=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBjRBX2CvJiV0u11Odk4wfnnsc0QlUSNAIRzMiBf9FW
 lPHO9ESJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCY0QV9gAKCRArRkmdfjHURc8kEA
 CmDE5S4KSKuL571DM65xTKRR7BeNwAxstvQDxxvLvkU3wxrntz5KQSdxjrxvnsLywQmGQswkytyGg1
 TDK+cLya1B+U+Dui/pRnIEryMbPPmyMkaQ/6M16zOjQqP70m82NS/SXJ90k7aoG7p/hGRbVdqwLLpB
 GA7T8yaiLZ+6ph6fgWRDyeqvQoFKtW80qznkbGXubfEM2V2pCB14v3tX6Q9mnH31aRJgSvEXemi32v
 bkbemnbBnEAELnqJqddn3f/pRh0eoVbO9+ft6kJDOGMUnGKWmmUDCEesf+DrpCUVt23zF7lH15tEsx
 RecUB8GI+1SBeEW7D7JurBJAn7P96WHbtdI8QGS0xQ4VV6cWg8iF5G7x9tcTMkKlg3jQevEnUqUB/w
 NrGP/81wNRc6bTv4Q/7KrzhtD+qNHJbdYkHNn5Aa6hgYFNyyiB+35PmpOECbEvLBJdJpt5o6D8weKC
 EngaDSNXu5UNwvncvRBP8Mv/SWvn/rRE69gDGjUp7nPUuB79kfBOawwQCflozcTNAW8NKaEIfi+6BS
 6sy+b9wk4eB1meYPcEbrqzXNLeXvviaJQPYqdWh8prbW8sGg11bsHWYNgi5BisDRUaPHoVlO3iWLkd
 2qhYVeRhp6uqQ0PDtcq2Pm76E9pddyliIq3p2PgWWsStwSzt6OuXxNPzv1xg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series contains patches related to the support of mt8365 iommu.
Thanks for your feedback so far.

Regards,
Alex

Changes in v3:
- Rename "mt8365-larb-port.h" to "mediatek,mt8365-larb-port.h"
- Rework the macros which retrieve larb/port ID to improve human readability
- Link to v2: https://lore.kernel.org/r/20221001-iommu-support-v2-0-dbfef2eeebc9@baylibre.com

Changes in v2:
- Rebase.
- Change M4U_PORT_APU_READ & M4U_PORT_APU_WRITE port to avoid display
  conflict in larb0. These definitions are used for vpu0 device node.
- Add dual license.
- Retitle commit.
- Rename to int_id_port_width for more detail.
- Fix typo.
- Set banks_enable and banks_num in mt8365_data to fix kernel panic at boot.
- Link to v1 - https://lore.kernel.org/lkml/20220530180328.845692-1-fparent@baylibre.com/

To: Yong Wu <yong.wu@mediatek.com>
To: Joerg Roedel <joro@8bytes.org>
To: Will Deacon <will@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: iommu@lists.linux.dev
Cc: linux-mediatek@lists.infradead.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Fabien Parent <fparent@baylibre.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Amjad Ouled-Ameur <aouledameur@baylibre.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

---
Fabien Parent (3):
      dt-bindings: iommu: mediatek: add binding documentation for MT8365 SoC
      iommu/mediatek: add support for 6-bit encoded port IDs
      iommu/mediatek: add support for MT8365 SoC

 .../devicetree/bindings/iommu/mediatek,iommu.yaml  |  2 +
 drivers/iommu/mtk_iommu.c                          | 30 +++++++-
 .../dt-bindings/memory/mediatek,mt8365-larb-port.h | 90 ++++++++++++++++++++++
 3 files changed, 120 insertions(+), 2 deletions(-)
---
base-commit: 11082343e3bf2953a937509f0316cabf69dbf908
change-id: 20221001-iommu-support-f409c7e094e6

Best regards,
-- 
Alexandre Mergnat <amergnat@baylibre.com>
