Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA4767AAD1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 08:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234806AbjAYH03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 02:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233356AbjAYH01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 02:26:27 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A5A3E0BB;
        Tue, 24 Jan 2023 23:26:26 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id m11so5773660pji.0;
        Tue, 24 Jan 2023 23:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MrcqHhD2+Ap5Bl+Zx7RGd/oyh/FJKuuqv3NrFr1ehPI=;
        b=ocZ/KjqngVGxbaFaf8AN+goK1ALPcix9vF6lbKS6xA/YoMyIq0zw++PbElTo5vOQWG
         NtZYwHOmKLoZ/tHdJgLknvRXiZL7mAmW4yteSJVX7BoQ/AVrZvUjJb4HEdHvz09acMFy
         bOiaoaZtqTtHcf2qA2vEC+sNaKyZQPMJO0zhQ3Gr8hGeF0FIHVcS8UugCumfHz7td1FE
         5mq85VcQN74YVMaEl8kxQLntGcMYspXZbYW04tEFA5PixehE+adArvshnY2mjV42LeoR
         vZ1KB5fcy+6vx2BJ6Yh/Y8Pdxhle3PwO0JIisr5IUvdpTwMhWrYlFkOlJUABtgYgcNkk
         UL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MrcqHhD2+Ap5Bl+Zx7RGd/oyh/FJKuuqv3NrFr1ehPI=;
        b=EsKosvezcmeobWoT95qiEAeGOELqHW703C+hJiTOof0aoHvTd9Fozkx/DfqWcp7hd+
         I3SBLkS2CuSxsvoPuJ1NQTsMR8jJqwTi23DKIWCwPi8VJ5MTqO8yDKVSxSKOyLSGJoPo
         tv2QMZXytGhIGasdZM7UxuMBGL/+HjQjyCaivd3bsuvz1dmRKwBpxsGqFnMR271LOb2s
         9qnRLBTjVnzjVgvhVqOtEMoGLS1S+v/QzEzsvDpFe7dX0O3sHFOGV7lFmBsxelmZEVKI
         iqAZHyQBS/bANxQ6iKlE+CYTBNDboDqaG3ddNhHSAQNG+I1Xz/+3eT2KRt0aZshYtmPN
         wxUg==
X-Gm-Message-State: AO0yUKUIt8l4h66LIy175xat+Vgqt1bMY2/ajJP08v8FB+4dHNZjW6HJ
        TLkUSBnnBcxFqrGwKm3912Y=
X-Google-Smtp-Source: AK7set+32z0yoQc/52Fw/h6yeVulJGKjyhJwUOJPsX1NqHN7mNu/ZvGuX04IBHFjnqplABvjQhJ+/A==
X-Received: by 2002:a17:903:41c5:b0:196:2347:ede2 with SMTP id u5-20020a17090341c500b001962347ede2mr3342915ple.5.1674631585779;
        Tue, 24 Jan 2023 23:26:25 -0800 (PST)
Received: from localhost.localdomain ([45.112.3.15])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902f54600b001769e6d4fafsm2902500plf.57.2023.01.24.23.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 23:26:25 -0800 (PST)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND linux-next v4 1/4] ARM: dts: amlogic: Drop superfluous dr_mode in usb node on odroid C1
Date:   Wed, 25 Jan 2023 07:26:01 +0000
Message-Id: <20230125072605.1121-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230125072605.1121-1-linux.amoon@gmail.com>
References: <20230125072605.1121-1-linux.amoon@gmail.com>
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

Drop superfluous dr_mode="host" as it is the default in meson.dtsi

Fixes: 3325f3e4534c ("ARM: dts: amlogic: Used onboard usb hub reset to enable usb hub")
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm/boot/dts/meson8b-odroidc1.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
index 941682844faf..1097b35b7a49 100644
--- a/arch/arm/boot/dts/meson8b-odroidc1.dts
+++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
@@ -368,7 +368,6 @@ &usb1_phy {
 };
 
 &usb1 {
-	dr_mode = "host";
 	#address-cells = <1>;
 	#size-cells = <0>;
 	status = "okay";
-- 
2.38.1

