Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFC461FB67
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbiKGRa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbiKGRaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:30:25 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677701F9FC;
        Mon,  7 Nov 2022 09:30:19 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id bk15so17259678wrb.13;
        Mon, 07 Nov 2022 09:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBJ6jWsnCmjINjKUCMEXLUFRQqsk1nKd3YYbN6OJUh0=;
        b=I1arPQYxJjLmhPOdpF6GuXQSbMwuzKlQmW08ebW6xlmPdMZo1up7C8pTQaOx5OzPta
         xtOd+9Z9bO2paf8C32/S6xppuZ19TgR1MB0p4/jgGYLnX/B72KGP3wthIb7YfdwA7xFR
         c+I0S/dGchyYGjl3bSYmZCnYkQQpQQYaGvx4byeSA+jQD4tWyPX8+uVTSFnlIySPcOcc
         Tti8YySUCsdlXEnO0VwbcgjZj32z66gSYhNfNmWjiJFjd02QQ/P8Oyl6MXNFa/LBaker
         /Iv3Nl4DrYdNSKHKw6UsZKCAXoZkGsX91aeHa5OcU4NZE21ZoHxU/GGOumxbn8uhTuMJ
         nccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eBJ6jWsnCmjINjKUCMEXLUFRQqsk1nKd3YYbN6OJUh0=;
        b=3blZ9OFf410tvSoo3vUKU/IjrpCqDSm7cgT7zgAMRkqL4BDzQo8qdH8bv+NpTvBQoC
         T3yV4EfmfMvIbdgslIQjw9BbRErDzWWqSBVLDGTIP+TdZ99yuIqmiFsc8yamEcAZ8Y+V
         yqQANU+ebjydLoh4cR76FDoDFQBX54Z1J3n8WjVksWXLY8Zgh8lleHp7u+J8ytkiXFwP
         Z7c/sLQq6VXtrJSf6TLeSTyq5peVTeg17xmCE9+biRlw/AEXGtczg4ChuHqxBEHpxpFq
         jdsTAvru08v8eE43O6G6udRRXFokBqQCE51fKOanN8ckiUllRwLcXykbuZ1Kmge6GsLt
         JHjA==
X-Gm-Message-State: ACrzQf1u2UsWPQPbDDVhi8K8x7JYTTjJ3FdrQjYBgH5X3JWgixQrQeji
        UejPDXQ7Zcg2OBJRJ3KhyTin6p/I8zlrvg==
X-Google-Smtp-Source: AMsMyM4OMrrUzgSfjH90dpLje1+f7nojx7H+/9mNKn9+yOvbOuC1Hfy+cvHK+oAiNJ6fOGLNPZA+/g==
X-Received: by 2002:adf:eac6:0:b0:238:6b48:4bb6 with SMTP id o6-20020adfeac6000000b002386b484bb6mr15672186wrn.34.1667842217882;
        Mon, 07 Nov 2022 09:30:17 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2501:c701:9c45:7ed3:c12e:e25b])
        by smtp.gmail.com with ESMTPSA id k4-20020a05600c1c8400b003b4cba4ef71sm13148496wms.41.2022.11.07.09.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 09:30:17 -0800 (PST)
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
Subject: [PATCH] arm64: dts: renesas: r9a07g054: Drop #address-cells from pinctrl node
Date:   Mon,  7 Nov 2022 17:29:53 +0000
Message-Id: <20221107172953.63218-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221107172953.63218-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20221107172953.63218-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

arch/arm64/boot/dts/renesas/r9a07g054l2-smarc.dtb: pinctrl@11030000: #address-cells: 'anyOf' conditional failed, one must be fixed:
    [[2]] is not of type 'object'
    From schema: Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml

Drop #address-cells property from pinctrl node as it has no child nodes in it.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r9a07g054.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
index 7c7bbe377699..2459e40a208a 100644
--- a/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
+++ b/arch/arm64/boot/dts/renesas/r9a07g054.dtsi
@@ -650,7 +650,6 @@ pinctrl: pinctrl@11030000 {
 			reg = <0 0x11030000 0 0x10000>;
 			gpio-controller;
 			#gpio-cells = <2>;
-			#address-cells = <2>;
 			#interrupt-cells = <2>;
 			interrupt-parent = <&irqc>;
 			interrupt-controller;
-- 
2.25.1

