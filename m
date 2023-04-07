Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C81D6DAAFA
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 11:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240696AbjDGJe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 05:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240583AbjDGJec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 05:34:32 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57EB69768
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 02:34:31 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id y14so41882166wrq.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 02:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680860069; x=1683452069;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=70JWiI3ir/yodHMirtpCr960hDJucp8ZmgOAZyHHfjo=;
        b=QONjcM29kV4dmGB3rYEiONRK5cMaa6iuyKF2F42L3XXJJguLusSxoZpsDfEYzNHrJQ
         PCve/XJithRyJlBCCehKo5C6uADcrcFyBiWsUjesvvs4csM2RJExdrtZYgQfAlS/TcwH
         WquiPJgyLMhp05XnzHIPk2z2kmkrURr0wmt+FjT5EDEFe33tw1gD12kt1YM2kZiQahuz
         bH9IW8UsgdOR3nDyEOrUTw6pHBetJKgliKfuDtgtbZp8tYaefzJniFSkwJay4GbQoMYi
         f3guY3mNKfR7mBcXVNDqoK3oE9uz2POBhXN7jkoXhB1BE0gmhzupPCK7QE7nhD9t2ugg
         VzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680860069; x=1683452069;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=70JWiI3ir/yodHMirtpCr960hDJucp8ZmgOAZyHHfjo=;
        b=vdfjBfy6Pj8PKCEhmMPN2ZLX9wsUXKhIrhHE7jCMgzb3lHOjE81UKFI0gubE7eJyVU
         bSy1fkg1+9+FdFfgzIt8V/K+qRglq+CX4A1GK9+V6eb2CRTljZiGq/fjj6f8J+RXm8Di
         ZUDN8hVNXp1KSrvCO7sRpOSdCZCpHm+UWeCygWGGoi1dmykZnnbDvSK+UKfOzqno4U7N
         En6whRN1BBL8vsXAGLK8iph6GN7mLiPymVXTllYkBFajF46fCMeLrgGAbKf+PEXWGMaf
         V2kUDxrenms/1UcPKp5JlnJDRfUEirtNz3klqdNttKga2QSEO+pD8bVELYa0V3odd8ED
         Aadg==
X-Gm-Message-State: AAQBX9e2Tfzn1Y3ez3PNZ9Fy4gk2dtgj6YYCqQspfNnVhdv7VwD5dN4K
        LOsdT6wG6keAP8DxXi/TyEsz02zYbgusYpHixyo=
X-Google-Smtp-Source: AKy350YypaAVLJKTn67bZFSJ5w+Bznsf6177h4pS/ayorAldv93lbe3E88jagS9SiBVOi3W60rfOng==
X-Received: by 2002:a5d:51d1:0:b0:2ce:a30d:f764 with SMTP id n17-20020a5d51d1000000b002cea30df764mr942043wrv.21.1680860069489;
        Fri, 07 Apr 2023 02:34:29 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id s13-20020a5d510d000000b002d64fcb362dsm4020432wrt.111.2023.04.07.02.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 02:34:29 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 07 Apr 2023 11:34:14 +0200
Subject: [PATCH v3 3/7] arm64: dts: mediatek: add apu support for mt8365
 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230207-iommu-support-v3-3-97e19ad4e85d@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1091; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=xWFAj8fuPjSh5BRKLkeGKOoKQ305/M/G1EGxpvjOkWE=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkL+Ohlg4spt+Ph+OrbPJZKpEpJNrFe4L6RjUFlhcD
 044pvFCJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZC/joQAKCRArRkmdfjHURZK/D/
 wIztu59Z6cma4MWtA5B7NQozRNiJHyTE/Kl8Z5vijoZ0nE/K4GDnlyrtym6yebHm/EehfkJMuhrphg
 Zz/cf/vxh+FX92tn4pfkqQlub9u2mz2eULkvrtNnCzTUaI/XdQXpGKfzxUF0mCHf75z919RvnzWNab
 RyHSvxl806VvR1jKbt62bbdDzwuFOENhrp0O1kJ8dQdNOU9DnXtZFRopBkQxYSXC/gLoD22MprXA9O
 z+5NDatU/AD6FiV+w7K4Di3a+mj/uCc9EWM0f65ekcXGhbyVb5bDeAW2tXrVoqtdAvy4caoDEbW5wD
 ELHrZ3k08yu0/pb8b1FUT253Tl9/wioZ0vMy+CXcdBpsG4cBb/+Ko53Nbvd1Ba7tNn9Blkh3NA5E8b
 ViVV0vL4qIBvhddGJX2urR3FA25LZbpxGGC8/2msWAuzwm09IoyrA6rCUo9k28nL3Y0QZe4dOygoHh
 7gkUD/rtJ8/0C8XvT9aQbP4Ex5KqI3E9qvVlsDmUUnq163orhqdlXe2dwnhX3p2WrlFhMPBA2HhKVG
 xfhjzTKz44L+AyJ+KaJkEQLYKyLf9Tw14jO58hnx4Zi9VsUUxSgepunXgeocs5rHE47ygwGnj9lA7g
 xHgG6kPUFdRkYhaM6suBRYQTzpMmyU61mTNkUAxFMuNVY8PHgzFCmEwRS9Iw==
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

AI Processor Unit System (APUSYS) is a highly efficient computing unit
system which is most suitable for AI/CV algorithms. It includes one
programmable AI processor (Cadence VP6) for both AI and CV algorithms,
and an eDMA engine for data movement between external DRAM and VP6
internal memory.

For more detail, ask Mediatek for the MT8365 AIoT application processor
functional specification.

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/boot/dts/mediatek/mt8365.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8365.dtsi b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
index 73cb10d296fa..386ab8902b55 100644
--- a/arch/arm64/boot/dts/mediatek/mt8365.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8365.dtsi
@@ -604,6 +604,12 @@ camsys: syscon@15000000 {
 			reg = <0 0x15000000 0 0x1000>;
 			#clock-cells = <1>;
 		};
+
+		apu: syscon@19020000 {
+			compatible = "mediatek,mt8365-apu", "syscon";
+			reg = <0 0x19020000 0 0x1000>;
+			#clock-cells = <1>;
+		};
 	};
 
 	timer {

-- 
2.25.1

