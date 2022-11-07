Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 050DD61FB64
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbiKGRaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbiKGRaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:30:23 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF6F1EAD9;
        Mon,  7 Nov 2022 09:30:18 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso8686748wmb.0;
        Mon, 07 Nov 2022 09:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1zLkiIKtBP3G4ennZ6Vxv24S0jhOjjTrjkyB/yfOimU=;
        b=hp3xfUHV3oC8hoVExev+Eo7bg8c8ycNRkOMIzYMpu4kyTDsoRBf0g597WfCtcPOK2t
         Lj5fNmL2gm9yspO2JwmcKhJ5hB2JspDqFb0ZN1P5yRxNf4yEfFMb8r6t1E9RsQLJe1d9
         nhy/3bcuL0oyo5EAa1/2JpNVKPNlUQKvqKH7jLqDVqtvvdJl+EDn3q7fof040Y+oOXt/
         VZDe2arD/+DRDIs+AgDvssfHcZR8vyQoRvEBurJiAyd0UGday4vamRjuM1bfUu0mlFMg
         zOum3WzSmdRBWtC5likFCurJr9t2zWcEodfr2JSu5VBnsPVO11HySj88MqHcJH3su9Zq
         SUwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1zLkiIKtBP3G4ennZ6Vxv24S0jhOjjTrjkyB/yfOimU=;
        b=GgUpHVM7cgQy1KuZJJodlBo4pKdw4xVw3kTc5hHL2CpC5naj152Flsme+aXrTO61nQ
         UB/NziJGOMs8PGbx8jd/XPGRYjBicFPaDfgVOkc16iNNm7tPy+T2PvanGy4YPHLI07j6
         tX9iKJBpE9Ld22bak/YQ7bcPhsZ6tpdgtesoC8NcKT5C0CAO89I9QhFZkcD+7NGJsgzP
         i7xYcEd9ZZI+7k92V99qYG1G021vYKS/EtUGYiFh0AteWOXlKhEEAt6yCt2EspBDS8Nr
         HWm/inj5uzA8KpJDTFxdKsD498/HHLAgQvoVG7Z5vGcCGk86tYVrYpvyTHzCMyHZu7mH
         9Kfw==
X-Gm-Message-State: ACrzQf3a5eXOqKUNBF+hhjZrdvj2O0Pt1qD6PhnmmZM4QM4gfOxZin6Q
        BI/H3h5ZEMi0KBIUOJD5/oQ=
X-Google-Smtp-Source: AMsMyM5k1QUgtjwOK7TlRtz4flyEgBb6Fjwo6nhhBvpHKqaYnoZnz0LRHVIZbfDl+9/DFWFGBb5b2A==
X-Received: by 2002:a05:600c:5114:b0:3c7:8eb:fb1c with SMTP id o20-20020a05600c511400b003c708ebfb1cmr44055192wms.204.1667842216808;
        Mon, 07 Nov 2022 09:30:16 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:9c45:7ed3:c12e:e25b])
        by smtp.gmail.com with ESMTPSA id k4-20020a05600c1c8400b003b4cba4ef71sm13148496wms.41.2022.11.07.09.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 09:30:16 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] arm64: dts: renesas: r9a07g044: Drop #address-cells from pinctrl node
Date:   Mon,  7 Nov 2022 17:29:52 +0000
Message-Id: <20221107172953.63218-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

This fixes the below dtbs_check warning:

arch/arm64/boot/dts/renesas/r9a07g044c2-smarc.dtb: pinctrl@11030000: #address-cells: 'anyOf' conditional failed, one must be fixed:
    [[2]] is not of type 'object'
    From schema: Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
arch/arm64/boot/dts/renesas/r9a07g044l2-smarc.dtb: pinctrl@11030000: #address-cells: 'anyOf' conditional failed, one must be fixed:
    [[2]] is not of type 'object'
    From schema: Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml

Drop #address-cells property from pinctrl node as it has no child nodes in it.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g044.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
index c606d9ef5991..53e9c0df59f4 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g044.dtsi
@@ -644,7 +644,6 @@ pinctrl: pinctrl@11030000 {
 			reg = <0 0x11030000 0 0x10000>;
 			gpio-controller;
 			#gpio-cells = <2>;
-			#address-cells = <2>;
 			#interrupt-cells = <2>;
 			interrupt-parent = <&irqc>;
 			interrupt-controller;
-- 
2.25.1

