Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2809A6380C5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 23:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbiKXWCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 17:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiKXWB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 17:01:58 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98A881F8F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 14:01:56 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id r12so4269750lfp.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 14:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hiaWqrX53hfzzHEps4oYeXEWJEP8SB8VJFJPlW92C7M=;
        b=q0uH/ZH2T9mzxpMxhmCPh++U8bgQ9REutxmlKqmCJio79K/P50x0nyM1hskgpEfSbj
         ndkwKcE25OKhBQZ0OF0VtgOVseaVw/IDnbZogy0P5hDxrfU20scFX3VI59fQpuy8eNhU
         dCwL3pdyXH1QisiCfEQM6zhIQREEWoXZyadP5rN/hTdyzR8E8u88eppWKZrE9MgMT3ox
         1gA1o34PELNPWcggHLZCDpzIjKWz2PJCt4YgvFTdncu9zECYCThQNYqzjzY/opwfhkco
         JptHAyNMgHVOSZjGWLhstXzCFZ4+H3+KaCqUiIBQ/Rxfb4jPJefd1xdEK8jWUP3AMZjb
         DnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hiaWqrX53hfzzHEps4oYeXEWJEP8SB8VJFJPlW92C7M=;
        b=xpqbBfq5eXRjUG+Obevts2UiJmVhfHp/r3xZw1nWmLD7sC6QX1yG/TEu/Fto6Kzmjf
         NVvJqy+u/cFrokTaUuyEwl7BJn90GEzUJ7R9cFp+YzWNMWIw/Mpwg4hXOkjV9pKu2JQ3
         LwTH91Rw35kndTPb/2OYsGT1JqYBVvRxESoUOijvseC5tsvukNh7clyzbsN2ybRJiPH3
         nqML3UFbq4bsRDRtSTQ6vf1vFTd/KhDFgghmkedjHqIWZdX9JQhoJEYAqUoZWC9u2EI6
         iltPQXP4+i/gnsViR5aismG3CCQkZTMZqjx+999jFhzJ6WJxwJhR8Hweplytu/MRNzjd
         +hbg==
X-Gm-Message-State: ANoB5pmiuLXh1B5nXQ3JX7UPfofop9EuY3eiyqlTojrXlppwhJcT/cYl
        XH9xUNk9N6UDV93RSNg02kqMIg==
X-Google-Smtp-Source: AA0mqf6M2JO3ZaRg2fRcCaXkasdBXbmKGbXblw9MdQ8zbe7LrcKxTEI6W6xRCIPHk0xgrXN6LtIS6Q==
X-Received: by 2002:a05:6512:3992:b0:4ae:5dc5:82c5 with SMTP id j18-20020a056512399200b004ae5dc582c5mr13244750lfu.2.1669327315153;
        Thu, 24 Nov 2022 14:01:55 -0800 (PST)
Received: from localhost.localdomain (95.49.32.48.neoplus.adsl.tpnet.pl. [95.49.32.48])
        by smtp.gmail.com with ESMTPSA id p11-20020a05651212cb00b00497feee98basm246933lfg.274.2022.11.24.14.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 14:01:54 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: msm8996-tone: Fix USB taking 6 minutes to wake up
Date:   Thu, 24 Nov 2022 23:01:47 +0100
Message-Id: <20221124220147.102611-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hardware turns out to be pretty sluggish at assuming it can only
do USB2 with just a USB2 phy assigned to it - before it needed about
6 minutes to acknowledge that.

Limit it to USB-HS explicitly to make USB come up about 720x faster.

Fixes: 9da65e441d4d ("arm64: dts: qcom: Add support for SONY Xperia X Performance / XZ / XZs (msm8996, Tone platform)")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
No words.

 arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi b/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
index 12a7b6d91dbe..0ab9687f3406 100644
--- a/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996-sony-xperia-tone.dtsi
@@ -991,10 +991,6 @@ touch_int_sleep: touch-int-sleep-state {
 	};
 };
 
-/*
- * For reasons that are currently unknown (but probably related to fusb301), USB takes about
- * 6 minutes to wake up (nothing interesting in kernel logs), but then it works as it should.
- */
 &usb3 {
 	status = "okay";
 	qcom,select-utmi-as-pipe-clk;
@@ -1003,6 +999,7 @@ &usb3 {
 &usb3_dwc3 {
 	extcon = <&usb3_id>;
 	dr_mode = "peripheral";
+	maximum-speed = "high-speed";
 	phys = <&hsusb_phy1>;
 	phy-names = "usb2-phy";
 	snps,hird-threshold = /bits/ 8 <0>;
-- 
2.38.1

