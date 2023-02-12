Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14066693728
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 13:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjBLMOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 07:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjBLMOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 07:14:31 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23751CA0B;
        Sun, 12 Feb 2023 04:14:30 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id s11so1801098edd.10;
        Sun, 12 Feb 2023 04:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lkVRJ9xqkrjXW8zGj3W60LSQ5OKgvmhXVCbi/Dr6uXo=;
        b=TS3G1yE/apRlRoXVSwpEfjuqpPQlZmaIH/tRFqKpIP3AeMFB9G7cb5qODKZ9JXAk8c
         IkS18fCvKP/EkcJEuwInxnr6l0O2kTOBmlQ4eCVx/JjUcAsvYPYLccDterVJNDc8Iun8
         6FOZhiwPvPvzqf20mq+gTl8C6JW0Z8njMGvPA0WmUicZFh8AZTlb0Bb9xvU5ReySprfX
         ycOdFuAwcCw5+fhbrmEAlCI5rzK7xVNaWuHG3VxySLRp2GE2Qf1SnKoICpL54e5137uy
         tavVZKvWyxcZ2hRbRxV5BTtukk0lmDttNpcXQ3mt0iwx8y1WuOyoTX0TTYxt02I1546K
         HKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lkVRJ9xqkrjXW8zGj3W60LSQ5OKgvmhXVCbi/Dr6uXo=;
        b=5F/KWLQ2H8SHE7JAYmmwSP6r2ogL31RY9O5wCcoImR8L/I61Ayh4S2EnBAnb7nVAa0
         0j7nCuN0oYe1/AVrFJxHyb1GPubtbicDNm+onzgnehdvU4sBDntNCI1uFG2lFytJXiBx
         wumyivfnNO2+2PouVjCiJGwFLYiQfD/3R2VWH6qekcEDI/OjWczLNa3VypO2BjbZhE8g
         6mzBwQ4rxzCOnq5iWHTALPUdHw8iwnHBcbMWwVrRM1ALU1+tiuvRF69t4g0KH0j6AhDk
         3gKa/vrr6aJwpWQS0uwP8WDmpcfpjZ9Nm779O/yWgLKCBL9Tj+DR2K+auE+sxD90+RrN
         AkXg==
X-Gm-Message-State: AO0yUKWMaN/muCHC8OPuFPBv9B2Tn4AiRLD/pHHcYp4hqplKnfnwWwmK
        qYuRuo/zakZ+4oTiGEUdKFk=
X-Google-Smtp-Source: AK7set9DUjDRrLSFJk9iyTooW+hGLFtMZQ1i/na/cPtoXKwQn43tVDK7EiCsSnmEB7z8BRUOTuRwEQ==
X-Received: by 2002:a50:aad4:0:b0:4ab:4d55:6f74 with SMTP id r20-20020a50aad4000000b004ab4d556f74mr7792798edc.13.1676204068620;
        Sun, 12 Feb 2023 04:14:28 -0800 (PST)
Received: from arinc9-PC.lan ([37.120.152.236])
        by smtp.gmail.com with ESMTPSA id a14-20020a50c30e000000b004ab4c28a967sm2976320edb.44.2023.02.12.04.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Feb 2023 04:14:28 -0800 (PST)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        erkin.bozoglu@xeront.com
Subject: [PATCH] arm: dts: mt7623: disable home key on Bananapi BPI-R2
Date:   Sun, 12 Feb 2023 15:13:54 +0300
Message-Id: <20230212121354.44590-1-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Arınç ÜNAL <arinc.unal@arinc9.com>

There's no home key on Bananapi BPI-R2. Disable it.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
index 642b1c0a96ba..a37f3fa223c7 100644
--- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
+++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
@@ -345,6 +345,12 @@ &mmc1 {
 	vqmmc-supply = <&reg_3p3v>;
 };
 
+&mt6323keys {
+	home {
+		status = "disabled";
+	};
+};
+
 &mt6323_leds {
 	status = "okay";
 
-- 
2.37.2

