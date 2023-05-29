Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72867149A7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 14:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjE2MrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 08:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjE2MrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 08:47:18 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8DCC7;
        Mon, 29 May 2023 05:47:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685364425; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=A/LJrk9NnckQbTcjwlOGxmm5gwhKaaKqNu34+CS61n0tGP1obPbnBzyEUzaN1C3AqY
    XZeZkrDVExHCiMnt0ghem/qgdfCApatCqhMBBAQQz+3zpm5BobWqTISiatrC5jrvumC4
    yxde40NAN/GU5SBNWDYZxBYCOPlxVNHiYoztMOq/4K/xqH0lUtAuffpCRZNm3eLWIy28
    0iD2lpzoSDHsowB6/kO+nDt7cuIEoQ8Nv0qGXm+M2Qqg1nq2lVZ3kxiAa3h+fy98t0hK
    TvunHaVqwMKPlwdGE9vrREkE7SfiEOrLNZsKT18nmmdH52lsb8um8F9bQ97ClM3ogdkm
    gYnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685364425;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=6/CMisvfnMRE8G0DiZyOyMITYBIkvc89VlwZlZVc3Co=;
    b=e/fH7v+yOBwf5C7EDahzWhvuJxeTIt+4Q8yqfQmXKtrwhtBKE4GkiXiiJoURpx8Xip
    VnCegt80bmWuL4Mwo81pZjkUPijVMLz3RRSrHdqNyJf6V4K+do6K4YayO4jBlme0S3u+
    zse/fZV2y0QbCQFuuYcQbcl18heoAkWrhpTUXfaXpIlY7yLW9E7S4QB5+7Lblj88jPod
    UZ7BnUI0AZr5/6/PJBNnQ5H/cUKTtgJmxNWGPGpTJcwjyOgCYtBAHbOrxwk+4h9OW7JF
    dMOFZej3sK2YumvOrYeyaA9AFqxTWczWEb+Yuy7DMh9oFcvFdkRimmNq11KzKacSNOYl
    YgZw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685364425;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=6/CMisvfnMRE8G0DiZyOyMITYBIkvc89VlwZlZVc3Co=;
    b=YBqrV46LQa+GW0EUWPS7q+6ojEdln9VoQZVif7oR1+iycvUdfe7zXszGHr5u9dj+zK
    5yMzaa2ydaCd1SOXHgD0tMqiUBeOKRJ9p9dzb8NPMA5Bqf7k5JwbejidtNTNIwO7NmIj
    wwNOf/90m/pPYkSIpSFkWZYd8tIneDQ7d9uORQawiGnP6Jy++fJe3FYZns7y45Zontrw
    vomIQchqjYNwbvLP8/mutXrct0UwZwrvhQtsvoTCWsxswUvbfuRFCFSIESFBDkFwVEPr
    J3JO2F8vO+S2ZbQ+SAOK2yOD9LxYyD18rPRIHXpuAddMnm/nuZKt8e44syiUPuSfmsdr
    VpSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685364425;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=6/CMisvfnMRE8G0DiZyOyMITYBIkvc89VlwZlZVc3Co=;
    b=6A917zZ7joHwYfu69AqpBfiprfuK3neISzqlWFH56UOO+p034iTlLLHwZTXZD3i3bc
    W6ZoQ8vVos5SdJawzNAw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOH8mT0="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az4TCl5f8Z
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 29 May 2023 14:47:05 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Mon, 29 May 2023 14:47:03 +0200
Subject: [PATCH 6/6] arm64: dts: qcom: msm8916: Move aliases to boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230525-msm8916-labels-v1-6-bec0f5fb46fb@gerhold.net>
References: <20230525-msm8916-labels-v1-0-bec0f5fb46fb@gerhold.net>
In-Reply-To: <20230525-msm8916-labels-v1-0-bec0f5fb46fb@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSM8939 has the aliases defined separately for each board (because
there could be (theoretically) a board where the slots are numbered
differently. To make MSM8916 and MSM8939 more consistent do the same
for all MSM8916 boards and move aliases there.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts                   | 2 ++
 arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts           | 2 ++
 arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts       | 2 ++
 arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts             | 2 ++
 arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts         | 2 ++
 arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts             | 2 ++
 arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts       | 2 ++
 arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts       | 2 ++
 arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi | 2 ++
 arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi   | 2 ++
 arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi    | 2 ++
 arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts     | 2 ++
 arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi                  | 1 +
 arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts      | 2 ++
 arch/arm64/boot/dts/qcom/msm8916.dtsi                      | 5 -----
 15 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index 923646766ef1..56dfca61253e 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -18,6 +18,8 @@ / {
 	compatible = "qcom,apq8016-sbc", "qcom,apq8016";
 
 	aliases {
+		mmc0 = &sdhc_1; /* eMMC */
+		mmc1 = &sdhc_2; /* SD card */
 		serial0 = &blsp_uart2;
 		serial1 = &blsp_uart1;
 		usid0 = &pm8916_0;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts b/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
index c864ce12c1f1..5025c08e4817 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
@@ -22,6 +22,8 @@ / {
 	chassis-type = "tablet";
 
 	aliases {
+		mmc0 = &sdhc_1; /* eMMC */
+		mmc1 = &sdhc_2; /* SD card */
 		serial0 = &blsp_uart2;
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
index 47580bd243eb..7b629243ef0d 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
@@ -13,6 +13,8 @@ / {
 	chassis-type = "handset";
 
 	aliases {
+		mmc0 = &sdhc_1; /* eMMC */
+		mmc1 = &sdhc_2; /* SD card */
 		serial0 = &blsp_uart2;
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts b/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
index ad71695652c2..b8c217b04a3b 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
@@ -13,6 +13,8 @@ / {
 	chassis-type = "handset";
 
 	aliases {
+		mmc0 = &sdhc_1; /* eMMC */
+		mmc1 = &sdhc_2; /* SD card */
 		serial0 = &blsp_uart2;
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts b/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
index a2be985052a5..56c42b0c9733 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-gplus-fl8005a.dts
@@ -14,6 +14,8 @@ / {
 	chassis-type = "tablet";
 
 	aliases {
+		mmc0 = &sdhc_1; /* eMMC */
+		mmc1 = &sdhc_2; /* SD card */
 		serial0 = &blsp_uart2;
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
index 1334bfcf3cee..175ca011998c 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
@@ -26,6 +26,8 @@ / {
 	chassis-type = "handset";
 
 	aliases {
+		mmc0 = &sdhc_1; /* eMMC */
+		mmc1 = &sdhc_2; /* SD card */
 		serial0 = &blsp_uart2;
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
index facb44892dd5..9560ba632c6f 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
@@ -14,6 +14,8 @@ / {
 	chassis-type = "handset";
 
 	aliases {
+		mmc0 = &sdhc_1; /* eMMC */
+		mmc1 = &sdhc_2; /* SD card */
 		serial0 = &blsp_uart2;
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
index 707288b7eca8..f23cfb2bf793 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
@@ -13,6 +13,8 @@ / {
 	chassis-type = "handset";
 
 	aliases {
+		mmc0 = &sdhc_1; /* eMMC */
+		mmc1 = &sdhc_2; /* SD card */
 		serial0 = &blsp_uart2;
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
index b1af9c5d07b2..895036fb6eb8 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
@@ -8,6 +8,8 @@
 
 / {
 	aliases {
+		mmc0 = &sdhc_1; /* eMMC */
+		mmc1 = &sdhc_2; /* SD card */
 		serial0 = &blsp_uart2;
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
index 82d94d62fbe6..94cfb3200496 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-gt5-common.dtsi
@@ -9,6 +9,8 @@
 
 / {
 	aliases {
+		mmc0 = &sdhc_1; /* eMMC */
+		mmc1 = &sdhc_2; /* SD card */
 		serial0 = &blsp_uart2;
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
index 78935205ea9d..f2a5800f1605 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5-common.dtsi
@@ -7,6 +7,8 @@
 
 / {
 	aliases {
+		mmc0 = &sdhc_1; /* eMMC */
+		mmc1 = &sdhc_2; /* SD card */
 		serial0 = &blsp_uart2;
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
index bd1e1e1153c0..3637e7d80d0a 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
@@ -28,6 +28,8 @@ / {
 	chassis-type = "handset";
 
 	aliases {
+		mmc0 = &sdhc_1; /* eMMC */
+		mmc1 = &sdhc_2; /* SD card */
 		serial0 = &blsp_uart2;
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
index ac39ac6a21c1..dafa5bd82328 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
@@ -9,6 +9,7 @@ / {
 	chassis-type = "embedded";
 
 	aliases {
+		mmc0 = &sdhc_1; /* eMMC */
 		serial0 = &blsp_uart2;
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
index 930318a443a8..733917531218 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
@@ -16,6 +16,8 @@ / {
 	chassis-type = "handset";
 
 	aliases {
+		mmc0 = &sdhc_1; /* eMMC */
+		mmc1 = &sdhc_2; /* SD card */
 		serial0 = &blsp_uart2;
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 0028a405e3ec..9494b6512d87 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -18,11 +18,6 @@ / {
 	#address-cells = <2>;
 	#size-cells = <2>;
 
-	aliases {
-		mmc0 = &sdhc_1; /* SDC1 eMMC slot */
-		mmc1 = &sdhc_2; /* SDC2 SD card slot */
-	};
-
 	chosen { };
 
 	memory@80000000 {

-- 
2.40.1

