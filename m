Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20E4B687A6F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 11:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjBBKkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 05:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjBBKkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 05:40:31 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79525C0C5
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 02:40:30 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id rm7-20020a17090b3ec700b0022c05558d22so1386787pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 02:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PexX/V0c+w21JwIUEKWHSc7QoYhjon5sMZqAPNZ76zo=;
        b=DSuetR/giXwCr7xl33WxRX4Hvfsvzbp00ZCg/YSjdN59Da6JVxqgvCvj75vLHYOwOH
         ltR2lE/nv3y8xMordBsJkMhC+SwyN0Z4Lod37n8akuTFQ6P8lxDmG4ljBUXUe9IP+sU6
         IB38AJQ9pTHm5zxM34c1mAK1pHIn9Y40T5m+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PexX/V0c+w21JwIUEKWHSc7QoYhjon5sMZqAPNZ76zo=;
        b=cN1a4BmAsBJSjXWBPAMDzhH3gANgla7T1C5Ye8Slc+HuTHNWcA5yhf/j23kXUBQKQZ
         d9RxxWDrgdfBBOKH90g6B0FvUyPBO/68yvq5vTSEdIYWqjRNAALV2bY1l/TbqO7EJjIj
         Tf+RKi9iCZaHFiRFOVeFpPeBkoSrmZfGM2V5OnKR83AkNMI1ZrOwzIMXABIXxMCjcIhQ
         nm4da5GK4EU6HopEQXnsyQ+4G3DQ29RZtDY1/dy3ZaX3QTBOJpZThnhWBBQtqVOk/19x
         5RLENM8T1lK0P8LUICsC5AJOMG1xB85ENgusFXTRP/Ot8wXSfX/6wbBIsIB84rCIiX7U
         Dh/w==
X-Gm-Message-State: AO0yUKXSyu2ZHpsGbpCdyhpICLIYF6svMkJhNm1qNJwTIEBhY98EzzXd
        n2Q9LtEwv4nL4Aj78VGy40GJxA==
X-Google-Smtp-Source: AK7set+sw1iMXd99AlKQYQp6TJaHlmdMupoaYMb79i2bbcIgiPzqroi3GNubMJIp+d05hWuhQI1HZw==
X-Received: by 2002:a17:903:32c9:b0:196:2e92:e546 with SMTP id i9-20020a17090332c900b001962e92e546mr7508552plr.44.1675334430339;
        Thu, 02 Feb 2023 02:40:30 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:68a6:9bbd:a36a:4d1f])
        by smtp.gmail.com with ESMTPSA id jk22-20020a170903331600b00194c82c2a7bsm13365706plb.224.2023.02.02.02.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 02:40:30 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= 
        <nfraprado@collabora.com>, soc@kernel.org
Subject: [PATCH] arm64: dts: mediatek: mt8195: Fix vdosys* compatible strings
Date:   Thu,  2 Feb 2023 18:40:14 +0800
Message-Id: <20230202104014.2931517-1-wenst@chromium.org>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When vdosys1 was initially added, it was incorrectly assumed to be
compatible with vdosys0, and thus both had the same mt8195-mmsys
compatible attached.

This has since been corrected in commit b237efd47df7 ("dt-bindings:
arm: mediatek: mmsys: change compatible for MT8195") and commit
82219cfbef18 ("dt-bindings: arm: mediatek: mmsys: add vdosys1 compatible
for MT8195"). The device tree needs to be fixed as well, otherwise
the vdosys1 block fails to work, and causes its dependent power domain
controller to not work either.

Change the compatible string of vdosys1 to "mediatek,mt8195-vdosys1".
While at it, also add the new "mediatek,mt8195-vdosys0" compatible to
vdosys0.

Fixes: 6aa5b46d1755 ("arm64: dts: mt8195: Add vdosys and vppsys clock nodes")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---

Since we are at -rc6 and Matthias already sent out pull requests, I've
CC-ed soc@ so that this may be picked up directly on top of them. This
should be merged for -next.

Thanks

 arch/arm64/boot/dts/mediatek/mt8195.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
index 5ffcfd8da31d..93ba274c3f42 100644
--- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
@@ -2439,7 +2439,7 @@ vencsys_core1: clock-controller@1b000000 {
 		};
 
 		vdosys0: syscon@1c01a000 {
-			compatible = "mediatek,mt8195-mmsys", "syscon";
+			compatible = "mediatek,mt8195-vdosys0", "mediatek,mt8195-mmsys", "syscon";
 			reg = <0 0x1c01a000 0 0x1000>;
 			mboxes = <&gce0 0 CMDQ_THR_PRIO_4>;
 			#clock-cells = <1>;
@@ -2625,7 +2625,7 @@ larb1: larb@1c019000 {
 		};
 
 		vdosys1: syscon@1c100000 {
-			compatible = "mediatek,mt8195-mmsys", "syscon";
+			compatible = "mediatek,mt8195-vdosys1", "syscon";
 			reg = <0 0x1c100000 0 0x1000>;
 			#clock-cells = <1>;
 		};
-- 
2.39.1.456.gfc5497dd1b-goog

