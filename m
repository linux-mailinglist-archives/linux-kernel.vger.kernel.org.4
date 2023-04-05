Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFE5E6D765C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237359AbjDEIIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237324AbjDEIHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:07:54 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C6E30ED
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 01:07:53 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id l10-20020a05600c1d0a00b003f04bd3691eso6548269wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 01:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680682071;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jxn+TRsbL2lgiHIWio+0AzhmetW3gojePjlFvN063GE=;
        b=2v2OkzuuRJUu9wxcmBUvP6r1Ba/rQXyGTl1m7nRsAgncDGjyZFyyPANu4Sa9nSrD2I
         Z93ydPgaLwV7l2g+UkGJuLEOmmGAxYqPnYFSfODuVU93UPuzy1FMj70KZENcVAJQWFZk
         9aQ40WYBL9K5zEzAASv+K+WTicxyh4Fa33+49yzEyte7lCa5M/JHTL877KG2NQ6rzmz+
         u6UzZX4N7bRCGIgE6oO58Rx6atmumxXdOkXYdFSVxgogyL07fuyLm16k8m6sSaP75nbT
         cu4YazLcBEeX5O3yEHgiLmUN/OOtf/cbG5u7MuinZBBnn072Ell3lqCEzbqzOY5aM1wd
         dlsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680682071;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jxn+TRsbL2lgiHIWio+0AzhmetW3gojePjlFvN063GE=;
        b=jA0mTLXCX/10WidrMnPMOt/6ktt/T+JiummzUHYxfgoMlYEvGarRgLuC4ZMVA742bL
         iu1negxRDWtez8Gn0nlVMOuL36i0LEe5u7ctRsbqCgqJNsPdZxOHxi86sOg4+Hv0+ELR
         +USTOVpFQwgMD7YTW0+zQ3wsjpvWntcU2ywcMrQuijqz6kpnYYAOiShgzJP6JEVTAjIq
         5TR7CFeyPGRJXntG4vpNyLvnpbpMG2OQW05qnBlqY5nzwXgkRex4NElI6arCaYz6XRZx
         YWS3yEJkizXhtnwJEHDX4SUUZ41meJkax598btqyCxz8TxdzdXCLKM37nhML2QbkLUMD
         rS6A==
X-Gm-Message-State: AAQBX9cpqLcqbw4yA8L6jjULUO6/YVnnwLIxT9zJ/LHXfAxRnNWxTmgR
        nZhzxlnRrJONg+AyFuOMY6xGvg==
X-Google-Smtp-Source: AKy350aYDMtAB7RImq+NzJ4YbsijUmKh0Ml1+EpsWBdmk7p/N5nqTXdoB3dxjZQSC2MXwRfJjGumrQ==
X-Received: by 2002:a7b:c4d5:0:b0:3ed:f5d4:3bff with SMTP id g21-20020a7bc4d5000000b003edf5d43bffmr4357607wmk.38.1680682071679;
        Wed, 05 Apr 2023 01:07:51 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id d4-20020a05600c3ac400b003ee8a1bc220sm1378395wms.1.2023.04.05.01.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 01:07:51 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 05 Apr 2023 10:06:45 +0200
Subject: [PATCH v2 03/10] arm64: dts: mediatek: add mmsys support for
 mt8365 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-iommu-support-v2-3-60d5fa00e4e5@baylibre.com>
References: <20230207-iommu-support-v2-0-60d5fa00e4e5@baylibre.com>
In-Reply-To: <20230207-iommu-support-v2-0-60d5fa00e4e5@baylibre.com>
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
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkLSxSrgcqG1djcTNTRWOYYHbrXdoDcKGVNBJ0hN1w
 z6uDJSOJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZC0sUgAKCRArRkmdfjHURcs1D/
 9TQt78ycBkdpek0sI0bzfJTzN1K8RDJsz6H5yJheKmAHtsXfZ0Xf8ORFzRdvanX6ghoOqhXt/MrOux
 2ONo8GnccerLEzb3vbB8OTYpmjaLvlZfb2bUy8uzs7b8oYCU0amvDKJwj4J8zT5ovjNk/M91W/OkUm
 kI4dcgGHuPl7G5ErWQILWyGFGnnR41XBrnZzgJ/BALNGc38U4XDLobA1hJiG8zXB9JaCfbUOmHTk/g
 W3ygKXXzVTnOOjuN/tSstD/P8lsdRS/58mcVfR23FYcM/c4YavuLiEMjhHsimgnqofltoitI+8o+/m
 39ALvcIIC1YzkOX1uMx9Kvl8WCV0yoxZDJ8w2XPodTpmm1EMNtvVpJSxwPwnQmVmj/tKMJbH5yRWZC
 7sTSBM48hmNkK7J3cUzgkoiSGVY48jDurXJ1MPWfnAy2TQwN3Is3IwngHbs9OUHYofLxe0qQ+Kxt8B
 5q7AxhAEyxeq1UooNM0TnyJiGhRisx0e0DAHLx/7QYVLJ6xoORG2COtBtcSv4vJNiNjcTYyoiDrq1E
 JtcU5fkr/EkT/sTzIvujXn4MPnA1W8mjNNTa9z2Kqx6OrEfv0iqqaaf4ageee3g1/IqB8F3osz0dWh
 j8gtTbTZu/mWTkbhYNdk79iUc6hlVyLP25PQHyaSSUUHQITRGV/gin3DVlZQ==
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

