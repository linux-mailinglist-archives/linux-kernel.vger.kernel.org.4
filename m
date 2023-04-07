Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE51E6DAAF3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 11:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240629AbjDGJep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 05:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239692AbjDGJea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 05:34:30 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 841784C32
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 02:34:29 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r11so41834611wrr.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 02:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680860068; x=1683452068;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jxn+TRsbL2lgiHIWio+0AzhmetW3gojePjlFvN063GE=;
        b=By+OkSQYatYSmT0Asjzri42rnDJ/FSFLdzIdKg27fdQtM6xcwmX/Y1cKgbaOI1nmKg
         +zgdg4qKlrE+Uixyd5mZ4owRbgTx1MpRUrk5faSksRknDJXvJfoCVxVj4DyfESvmTtQP
         v8kjifyj1toYv1OMUcmP0+ckJ/Ortic2SK8w1KiGaPTtwrem1fzyg6daBX61DkIgaums
         j6CKJz2kQ/wESuOW387iuXS/YH16sXDPBX5rdtvPekdMwlFq0rkyk0CH8f7asLgLfbWR
         z7k1b8Nq0asISiWH2NN2yLr6ODwp85FsDpSNmx61HlnVs7OcBYOM6D6u/FuAlmieK+Vc
         kVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680860068; x=1683452068;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jxn+TRsbL2lgiHIWio+0AzhmetW3gojePjlFvN063GE=;
        b=jXLTXQlccSa6lvmaqrPJNWsGx+PdpPDd9hGp1m43NGXSlCQyl8IX2n7wweq0FdxVj9
         ZlwFfeYACVUA6WxNPujbj/Fl2kzyD9Z7Y2Tykgb9OClPvSFnONESBHof3ujzML/J256E
         sSohmeXzG8vgyFz1p5t95fmBiQ9+IkO2PotKO3OQouizXMDYjzo77DbhbDWg1qMRNrJJ
         HGPn6jMEd1T7Rv6kC+2npAE5lXUpfnvZ3CtI5Gm9z4MPJDCV9DG6i92hcVdz1vK2BJeg
         A8AUW6SY8EE94xJSN10pXHqhx1WoL0y2Jlxb+3Mh4dVwaphXK9Rtcl7Fx4Wmtk3N1T2D
         71YA==
X-Gm-Message-State: AAQBX9e8Tl6orN/pcRqVCmK/U5meUB8izwe8JZXV292XhaX6LDgv/n7u
        MASI0DYv1Sez0tt48pEOc4Iu5Fupkd3cSY0uQe0=
X-Google-Smtp-Source: AKy350YPtB2qqm/tfTf6wiR6eAJjclFxqHTy0s9UDld4/0zfFwB9yighmvTC2robN+fnfpNzduPjDQ==
X-Received: by 2002:a05:6000:12cb:b0:2d7:89ce:8319 with SMTP id l11-20020a05600012cb00b002d789ce8319mr764774wrx.27.1680860067647;
        Fri, 07 Apr 2023 02:34:27 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id s13-20020a5d510d000000b002d64fcb362dsm4020432wrt.111.2023.04.07.02.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 02:34:27 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 07 Apr 2023 11:34:12 +0200
Subject: [PATCH v3 1/7] arm64: dts: mediatek: add mmsys support for mt8365
 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-iommu-support-v3-1-97e19ad4e85d@baylibre.com>
References: <20230207-iommu-support-v3-0-97e19ad4e85d@baylibre.com>
In-Reply-To: <20230207-iommu-support-v3-0-97e19ad4e85d@baylibre.com>
To:     Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1181; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=IIlOfZtAZXJ+CTRWdZTf7MxepUo9ZjXmi2nPi0PBDfE=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkL+OhO5K9POZkm9D2W6JnijLrtwGC3rjMNLpfW/d/
 KZhoB1mJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZC/joQAKCRArRkmdfjHURdJ+D/
 9r9/Te9R69K349jViT+g4eRJgaXBXVs80vgLPMlbqBtrKR6AJ/XtQSM9ikDUQiUAarWTTTzVOwDPGy
 l+qc87ZFJkzn7YqK7Dn7/MMW6aXqTQv7pvB/jAtYrU2QPh+ALxyP2ryt0iQuI+snYSIoL368FTQbP8
 WXdBnr57VMR90WF8bDnpNFcx0q9s4FyaT6kgAXA2jI0VTAuUukRXFLMjYjK7oK5/ELDMKiUjMlIV8Q
 7lmjfRsotV5FnzNVe7C1NFtzn64X6htj/j2UqrA5NzPFhMAnzTm6sROLwhJjy8+nJyPkAjn1MyP/Jh
 gd97AZD9YVV855UR8X0dGgc3d9siodpUy6Wa8uZRY8i81gxqKjZv+ayHLUjMT1snW/ooEmy+8d/hJi
 OWTlAnNqgUC+ZLI5wV1Nf/NqZqdvJjKgVLB7z+0zyz1CQCSuP4tnQUTw0dzVkDtapdqO0BC6zB7+jN
 rs0DFJ49b2kFQF+jNqd9/X4LAA4t8SZ98T3Sb05RSaiVAbPWNuZ99VxICE8qY4d6+Jg8BhTy3wMFhw
 B7/xbdkRDtOP51uwSNyXjhVbFj0NvhODIZYtEEF2VYfadF5cM2wNEJsr76wUHEMMQY/CaoOhmxqIvW
 QnMbChzx7QkYAlSwdPVeNVoSbQAvk20iTHi0cCMDJQbZM4pUJVhdrBzwfMsg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multimedia subsystem (MMsys) contains multimedia controller, Multimedia
Data Path v2.0 (MDP 2.0) and Display (DISP). The multimedia controller
includes bus fabric control, Smart Memory Interface (SMI) control,
memory access second-level arbiter, and multimedia configuration. It
plays the key role in handling different handshakings between infra
subsystem, video subsystem, image subsystem and G3D subsystem.

For more detail, ask Mediatek for the MT8365 AIoT application processor
functional specification.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index b5f5c77f7f84..db9ab538c34d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -592,6 +592,12 @@ u2port1: usb-phy@1000 {
 				#phy-cells = <1>;
 			};
 		};
+
+		mmsys: syscon@14000000 {
+			compatible = "mediatek,mt8365-mmsys", "syscon";
+			reg = <0 0x14000000 0 0x1000>;
+			#clock-cells = <1>;
+		};
 	};
 
 	timer {

-- 
2.25.1

