Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618F05F8620
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 18:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiJHQ4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 12:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiJHQ4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 12:56:35 -0400
Received: from mxout1.routing.net (mxout1.routing.net [IPv6:2a03:2900:1:a::a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81628422EB;
        Sat,  8 Oct 2022 09:56:34 -0700 (PDT)
Received: from mxbox4.masterlogin.de (unknown [192.168.10.79])
        by mxout1.routing.net (Postfix) with ESMTP id EC62640111;
        Sat,  8 Oct 2022 16:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1665248193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PxYWFX8wCCX5TIRd759yMnx9+aLLuhcGAlrlR4XDq00=;
        b=wlqox1OxxXXKN4y1VQOL06YBn/nBSQur9WYOzYOoOuTHQMMRA/SAcOgDgGU3/gdiVYrfEa
        JOWQqswxM5HZYH9YOrIYC103WToXXstWKZVf6lgyGymyPeFQEEGSowu3xQLInqMOQNydbg
        Anew5fK/zQUDrpUClkhRTcFMyfdOX/0=
Received: from frank-G5.. (fttx-pool-217.61.149.60.bambit.de [217.61.149.60])
        by mxbox4.masterlogin.de (Postfix) with ESMTPSA id 39A7680098;
        Sat,  8 Oct 2022 16:56:32 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sam Shih <sam.shih@mediatek.com>
Subject: [PATCH 1/2] dt-bindings: mmc: Add compatible for Mediatek MT7986
Date:   Sat,  8 Oct 2022 18:56:26 +0200
Message-Id: <20221008165627.114782-2-linux@fw-web.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221008165627.114782-1-linux@fw-web.de>
References: <20221008165627.114782-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: f541c1fc-30e9-4eac-a260-8ab51a93bbef
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sam Shih <sam.shih@mediatek.com>

This commit adds dt-binding documentation of mmc for Mediatek MT7986 SoC
Platform.

Signed-off-by: Sam Shih <sam.shih@mediatek.com>
Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
index d8e1e2e9adf2..3cbf0208f1b4 100644
--- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
@@ -23,6 +23,7 @@ properties:
           - mediatek,mt6795-mmc
           - mediatek,mt7620-mmc
           - mediatek,mt7622-mmc
+          - mediatek,mt7986-mmc
           - mediatek,mt8135-mmc
           - mediatek,mt8173-mmc
           - mediatek,mt8183-mmc
-- 
2.34.1

