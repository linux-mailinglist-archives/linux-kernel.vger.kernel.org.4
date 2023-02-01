Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC2D686E7E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 19:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbjBAS5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 13:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbjBAS5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 13:57:13 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8D47F303;
        Wed,  1 Feb 2023 10:57:11 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id bk15so54230959ejb.9;
        Wed, 01 Feb 2023 10:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yR+4t71uvOrNwbzfT6rMlJz6ZARDL9nMPAtxzDTp2O8=;
        b=hAE9xFTNI1lnwpIuE40P7XM3zdPBSWs6oC1K4LIIIi3QjXVHNPzxV0kaKrVltoyw1a
         nr3pcOkDNFrPu6kunubdEh0/jBS5AkgdI0jnU/1TadEQm4SFGN5nsqT9v90fjBmd/mU+
         jK2DrE/mUYa5oJaoSnXXmTh3BpKMu3qRl2gegfK/I51wfNok4JCz0nijSTBHqkQJ1KMr
         QC9X1Oj0ZBCu6aglye0rahH1MWdFaacyXZQOVt9GC7g0mGMOfYoxEJL/UtylpGx9nfA9
         /0hqC4xxAMVvUIuY4PDD1KDCzYcgI1jUPwxHYRWBC/zfce2oh62xKctLUcE0wYrVyY2A
         94Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yR+4t71uvOrNwbzfT6rMlJz6ZARDL9nMPAtxzDTp2O8=;
        b=bZ26BUng2jOzIidDsqmkLQLfFUCNhdCdNeZYcybP3CLWDcbhq/NSZEwnifFG9D180l
         IMPJZf6klhIeIqC727rPNnPhVuR7IyP/WJThLJufJvzA9FbjHcx9Y6QvDJP2BF3wfZVF
         LMJRjuCIS9tAMVbIvtU7KgcNaYtXMmYbJuTJo3FZaldgGRO/U3jQVu37L+JfUMbivB89
         LSnFuB1qoX0tXMc9j1/zOsvL+Tsk/brSFZPhAxk3ru9Z6u/ruxkjVdlhOUz8zq873sYu
         +Xic2YouW96obLzudcX9tAz3+BYIm7oYFKwx9g1M27XyAW0tJqsNbT/0fv6f0tycjGjd
         StFg==
X-Gm-Message-State: AO0yUKUmb/V9GHLy29Z/+b0EiUw0uSk/vWNWQVvWVGEh3Z1VNP+ML2ht
        bq8AKYUkH72jWY0xrrT7Z5M=
X-Google-Smtp-Source: AK7set8Vhjr4qyafeIDSZSc3Eb1qSQaqtTm5MaSmxLU9rQXRso14GgRsj8YWD3pwarp3ZDG7RMCdYw==
X-Received: by 2002:a17:906:34d3:b0:82e:a57b:cc9b with SMTP id h19-20020a17090634d300b0082ea57bcc9bmr7270754ejb.24.1675277830106;
        Wed, 01 Feb 2023 10:57:10 -0800 (PST)
Received: from arinc9-PC.lan ([37.120.152.236])
        by smtp.gmail.com with ESMTPSA id dy25-20020a05640231f900b0049e210884dasm10100883edb.15.2023.02.01.10.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 10:57:09 -0800 (PST)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Frank Wunderlich <frank-w@public-files.de>,
        erkin.bozoglu@xeront.com, Sean Wang <sean.wang@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>
Subject: [PATCH v2 4/5] arm: dts: mt7623: mux phy0 on Bananapi BPI-R2
Date:   Wed,  1 Feb 2023 21:56:55 +0300
Message-Id: <20230201185656.17164-5-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230201185656.17164-1-arinc.unal@arinc9.com>
References: <20230201185656.17164-1-arinc.unal@arinc9.com>
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

Mux the MT7530 switch's phy0 to gmac5 which is wired to the SoC's gmac1.
This achieves 2 Gbps total bandwidth to the CPU using the second RGMII.

With this, the interface name to access phy0 changes from wan to eth1.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
index dc9b4f99eb8b..64700253fd35 100644
--- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
+++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
@@ -182,6 +182,12 @@ fixed-link {
 	};
 };
 
+&gmac1 {
+	status = "okay";
+	phy-mode = "rgmii";
+	phy-handle = <&ethphy0>;
+};
+
 &eth {
 	status = "okay";
 
@@ -189,6 +195,10 @@ mdio-bus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		ethphy0: ethernet-phy@0 {
+			reg = <0>;
+		};
+
 		switch@1f {
 			compatible = "mediatek,mt7530";
 			reg = <0x1f>;
@@ -200,11 +210,6 @@ ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
-				port@0 {
-					reg = <0>;
-					label = "wan";
-				};
-
 				port@1 {
 					reg = <1>;
 					label = "lan0";
-- 
2.37.2

