Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3AAF5BA59B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 06:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiIPEEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 00:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiIPEEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 00:04:40 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB805FDB;
        Thu, 15 Sep 2022 21:04:37 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id v4so19178400pgi.10;
        Thu, 15 Sep 2022 21:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=VrgSKop653uzbaesHvcljAJltI+axahl5nYIdGS3Efo=;
        b=lWJ80eZ9CT92Tfh/L0WSsneWuoKkY7Rzn8CKtuL2AGRirYrAXb7YbF1YFk0xWzCIib
         RQc3dAcCvCVPZ9KtN41YwgT3WVw0ki8Ng193Lu4Yb33NNwDpkPXC34rObNcYlnR1b9gW
         tsviT4PmOelgsw2YtY7RLjTCaZ8Dp3CDChvtTPNtU3904A/WSUR6TwodZCVHZ8Ua/7E+
         XwQdJCrgMK6eEokGu+ZJ72uJe8T1wdm2rxQBSF9CTG+En8PQ99LKtaz9PyLHqyE6sFHV
         bxF6k1A7u4PWLn5BkOnDyPNKswqXOP0oo9j3QebGKe4EnDge7WDDFhnBhRkOVTyO+tpq
         tBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=VrgSKop653uzbaesHvcljAJltI+axahl5nYIdGS3Efo=;
        b=uwUO7+7g6yU6u5RpS5+OEqQA6CSiP1V3VAYzO4GVS1XCMg82K0BD2bYRn9aVv65Rwn
         XkZGnMqZaGYnHHV0qpSWU2sz/wkt75S/LEaayRQejsFWP3w23PpgV+ltrDYCY/8PZtSv
         qOADY7G8HZkUMdU+A95Yh7FJ5n0JbbEexowW0lUR1Q1wLbj5BfPWJR+GiKeCvacTZlxz
         Hd+wG7TBqpLYgxKGYSzLq9KSZmZ4LMsQB1m5qVFjCWhvl/wZvL1vycQKaQo4F4TdGr3v
         Jlv/z4pXifGPLJScMSfK/9tjbdEFoaoVU+v7ZK1+/fNMVxEAxCdBvda1+od6azrRYe9B
         vyLg==
X-Gm-Message-State: ACrzQf09oXyO3GZRfBsSj96k/yu7N0nokhS/zCzb9dNvGj8GIMCcvBGQ
        GJf4NtN+5bxpX8d7Omx3fB6Nha7UeZHP49Q+
X-Google-Smtp-Source: AMsMyM7u93ksKvcY3eedDx54QSCHLbx2y+4hH8cSnbWk95Fkf832yMYYpz5pgVztACyipQgXo0YQpQ==
X-Received: by 2002:a63:2c8:0:b0:439:3806:32f6 with SMTP id 191-20020a6302c8000000b00439380632f6mr2815202pgc.217.1663301076458;
        Thu, 15 Sep 2022 21:04:36 -0700 (PDT)
Received: from localhost.localdomain ([103.150.184.130])
        by smtp.gmail.com with ESMTPSA id p18-20020a170902e75200b0017849a2b56asm7286423plf.46.2022.09.15.21.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 21:04:35 -0700 (PDT)
From:   Yunlong Jia <ecs.beijing2022@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Henry Sun <henrysun@google.com>,
        Yunlong Jia <yunlong.jia@ecs.com.tw>,
        Bob Moragues <moragues@chromium.org>,
        Yunlong Jia <ecs.beijing2022@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: Add touchscreen for pazquel360
Date:   Fri, 16 Sep 2022 04:04:20 +0000
Message-Id: <20220916040330.1.Ia3be91283bd937d08e7321140c89e4a0e2b78cf6@changeid>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The model used is elan ekth3915, compatible with ekth3500.

Signed-off-by: Yunlong Jia <ecs.beijing2022@gmail.com>

---

 .../dts/qcom/sc7180-trogdor-pazquel360.dtsi   | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi
index 5702325d0c7b..14ea94ce90c1 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pazquel360.dtsi
@@ -14,6 +14,28 @@
 	realtek,dmic-clk-rate-hz = <2048000>;
 };
 
+ap_ts_pen_1v8: &i2c4 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	ap_ts: touchscreen@10 {
+		compatible = "elan,ekth3500";
+		reg = <0x10>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ts_int_l>, <&ts_reset_l>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <9 IRQ_TYPE_LEVEL_LOW>;
+
+		hid-descr-addr = <0x0001>;
+
+		vcc33-supply = <&pp3300_ts>;
+		vccio-supply = <&pp1800_l10a>;
+		reset-gpios = <&tlmm 8 GPIO_ACTIVE_LOW>;
+	};
+};
+
+
 &keyboard_controller {
 	function-row-physmap = <
 		MATRIX_KEY(0x00, 0x02, 0)	/* T1 */
-- 
2.17.1

