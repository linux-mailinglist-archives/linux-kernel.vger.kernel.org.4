Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5559760EBFE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 01:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbiJZXB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 19:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234068AbiJZXB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 19:01:29 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8B069BF7;
        Wed, 26 Oct 2022 16:00:40 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id k2so25703679ejr.2;
        Wed, 26 Oct 2022 16:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QDnwRNSvILxD4k9pcL4E1+s2WIr1eI7KS5V5B2hV+gw=;
        b=OZri08sC3H4NhbuF2t777h2w0nJU42EHf88jSJxwBiXid44X+DoiRTD2iuTX84q8Ne
         5u5OZBnJF4wbYBYSCT0DosCyZnfODHZ21wjDv4YxESxguroiXZ6gSNjND/fNxT1NisTc
         OkGgbuV0ExZw5EOG1PCWrAEifdEDEOuwv4zfMvuADsGQeaLFFkskS8DV/tvJytN3L1Tu
         6TROGFhgqadljW9oKaNcrnzmpR3s3pdfWzgsXiAFSURTce6J4F0HAk5q4tbkWjj/AC2p
         yFPc5UrbEtCxBuqQIelOnUtVkiOXrEqwSS+ag9tTB7zQZ1XOqPeqb+4kDC2BmuIdhvcL
         Sy+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QDnwRNSvILxD4k9pcL4E1+s2WIr1eI7KS5V5B2hV+gw=;
        b=0ZY/H2KnJC1dU52yvd3CQN2t0JrbN5kMMsFK6tkd+zKgKV17yutr+DM+MrkgqqtRxj
         faat1mdCYHWwIGd/L79EUxyZRngkXb03zVmbaqJpDorc2ZFjHK9JjEbMqmd1zxEB48Em
         +g3+SCZLu2utDamqOSyL+9h+iym4uH/CPMP7aqF/0ow/lQ/d5PVy6QqtpCkBCryrHtPR
         Kgs0dTInvfCmXLxNHS0Q6Pm+OqTQrZ2L/FdY7QGYjXNFGe6j1GtdSEYsjrJnw0P42Uva
         fJpT04isyCgegtPhKacdFD7m/Co4ZuCA5JcXGI3Ms5x6ARqls70w+lleHVe23lcNVrBE
         D5zg==
X-Gm-Message-State: ACrzQf3lays5GCIslK5JTUiNLCALgE5kxtVGyMIFqyyEGQ+PUChfF8uM
        T8uqZKGFPn77eCC9g90ZGTo=
X-Google-Smtp-Source: AMsMyM6WkfKw92SRZVxTuuDFP0qLNx9+SU/w1+k6OaO/N5MWqBFb40Iwy8t6K0T2FMIlRjvdFepiIg==
X-Received: by 2002:a17:907:2e01:b0:78d:f24b:7330 with SMTP id ig1-20020a1709072e0100b0078df24b7330mr39087661ejc.604.1666825239392;
        Wed, 26 Oct 2022 16:00:39 -0700 (PDT)
Received: from [192.168.2.2] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id 13-20020a170906318d00b007317f017e64sm3546886ejy.134.2022.10.26.16.00.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 16:00:39 -0700 (PDT)
Message-ID: <8facb161-44cd-4cd1-93ec-468fa3164ed4@gmail.com>
Date:   Thu, 27 Oct 2022 01:00:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 3/3] arm64: dts: rockchip: rename "haoyu,hym8563" rtc nodes
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <f7127f87-05fd-5e20-eb2d-a3fd04674229@gmail.com>
Content-Language: en-US
In-Reply-To: <f7127f87-05fd-5e20-eb2d-a3fd04674229@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "haoyu,hym8563" RTC node names should be generic,
so change them.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts | 2 +-
 arch/arm64/boot/dts/rockchip/rk3368-r88.dts            | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts    | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts b/arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts
index 7f5bba0c6..0e88e9592 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-orion-r68-meta.dts
@@ -208,7 +208,7 @@
 		vin-supply = <&vcc_sys>;
 	};

-	hym8563: hym8563@51 {
+	hym8563: rtc@51 {
 		compatible = "haoyu,hym8563";
 		reg = <0x51>;
 		#clock-cells = <0>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3368-r88.dts b/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
index 38d757c00..e147d6f8b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-r88.dts
@@ -192,7 +192,7 @@
 		vin-supply = <&vcc_sys>;
 	};

-	hym8563: hym8563@51 {
+	hym8563: rtc@51 {
 		compatible = "haoyu,hym8563";
 		reg = <0x51>;
 		#clock-cells = <0>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts
index 5a2661ae0..18b5050c6 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-roc-pc-plus.dts
@@ -98,7 +98,7 @@
 };

 &i2c0 {
-	hym8563: hym8563@51 {
+	hym8563: rtc@51 {
 		compatible = "haoyu,hym8563";
 		reg = <0x51>;
 		interrupt-parent = <&gpio0>;
--
2.20.1

