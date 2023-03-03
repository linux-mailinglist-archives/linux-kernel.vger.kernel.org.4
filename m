Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34F56AA3F1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 23:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbjCCWKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 17:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbjCCWJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 17:09:27 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F606782C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 13:59:57 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id x6so3804139ljq.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 13:59:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677880713;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N1o/g/RY/F8tw5gI99MfNC1MgutCzKG48oc2MA5z/Ao=;
        b=bpsywCmv25hwZdzAh1PCeTfTnQ8M9UQyOZLcAniWppQtbBrGizltd2VSk9gn0Y4W0Q
         yzdNQaxAnFvqFLXGWRKFxCIhP0BFTzdfULNUTPwhgUB4xN8zBhsJCfMbOjpNVLP8IrTr
         XRLZO/3/frAk/71BTSeqKr6YdlNbaufBAvczrkBwpoIedcVrAMcAgnyjXZJjw4xZy7zg
         OPi3NXwqi3rM98FxJWQcHp12RjDYHlO/9TIZ5qk4cgZa3qr+G9h0MFwpNuBJuc6sQBrz
         qQvUzANF+qbtVzPY6wXdS4y0VeAcPdQ9Y1KP8+qYIT+6u5UV2d/4ESux7EUS1P0rfVB5
         pAIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677880713;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1o/g/RY/F8tw5gI99MfNC1MgutCzKG48oc2MA5z/Ao=;
        b=xXY6Vl4dI+aWFSEYP3kZDafRrmYzs2PXQEWOmmidbyMSY4LkEyqzIJLGX4TwTi/xEQ
         +IZPg9Rezp0WyL0Loealv8umhqibWjjA/D+eBx0jE0vMgpTMXJfdutUViutQ7ELMg7z+
         DjZuZROsRA9JKtPL3CYEw9KmR4LRXoJDXKhFdh35TBzJK7hn6WvnxUFE5E4I4dN3zwfH
         cEHnh9RxbLRhHeXK/kdvDBUPRaB2rDD5GLrye8JLj11lm1AWlpERDheGf1KM02iLSDPC
         Al9Gvse1C7fZGUZwxMMBVtbISG97YEp9X9O+qAAlz+FlXqifPbeTpvuB+q0P6W17t3AO
         zVtg==
X-Gm-Message-State: AO0yUKVAYViTMAj/Vbyw41xbz8LeyeZloU/vaim1WgHCmrE3JbVttJdB
        B6S+QR8i6QL18anY12/VCY5c4Q==
X-Google-Smtp-Source: AK7set8HY/ZWvMDmsFszJ46x+D2bfFXOLEt62IWqldbD7EeuilM2sEPe1aGzehsz3IInfUfazDl8uQ==
X-Received: by 2002:a2e:8e8c:0:b0:295:9f20:bf16 with SMTP id z12-20020a2e8e8c000000b002959f20bf16mr834883ljk.51.1677880713790;
        Fri, 03 Mar 2023 13:58:33 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id e27-20020ac2547b000000b004cafa01ebbfsm552670lfn.101.2023.03.03.13.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 13:58:33 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 03 Mar 2023 22:58:15 +0100
Subject: [PATCH 15/15] arm64: dts: qcom: sm6375-pdx225: Add volume down
 GPIO key
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230303-topic-sm6375_features0_dts-v1-15-8c8d94fba6f0@linaro.org>
References: <20230303-topic-sm6375_features0_dts-v1-0-8c8d94fba6f0@linaro.org>
In-Reply-To: <20230303-topic-sm6375_features0_dts-v1-0-8c8d94fba6f0@linaro.org>
To:     Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677880689; l=1409;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=lUoSxwe6wDxHMv1iTDzFHuYZxKLyt1OMfELUkCo9Rp0=;
 b=2D1FYt5g9zW3UaMoHWv3uq5a3I+XMRqi4xOdzwph644K+Ge2XkqIHBvdS5lQ6HhN8VB5CAELrLkC
 Mc12VKGIBVJrmmDYy3Plyso23gn9bU4RYdv5EBTyg4dMyi2kUOIU
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the required nodes to enable the volume down key on the Sony
Xperia 10 IV.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../dts/qcom/sm6375-sony-xperia-murray-pdx225.dts  | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
index b691c3834b6b..8220e6f44117 100644
--- a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
+++ b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
@@ -46,6 +46,23 @@ framebuffer: framebuffer@85200000 {
 		};
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+		label = "gpio-keys";
+
+		pinctrl-0 = <&vol_down_n>;
+		pinctrl-names = "default";
+
+		key-volume-down {
+			label = "Volume Down";
+			linux,code = <KEY_VOLUMEDOWN>;
+			gpios = <&pmr735a_gpios 1 GPIO_ACTIVE_LOW>;
+			debounce-interval = <15>;
+			linux,can-disable;
+			wakeup-source;
+		};
+	};
+
 	reserved-memory {
 		cont_splash_mem: memory@85200000 {
 			reg = <0 0x85200000 0 0xc00000>;
@@ -133,6 +150,16 @@ &pmk8350_rtc {
 	status = "okay";
 };
 
+&pmr735a_gpios {
+	vol_down_n: vol-down-n-state {
+		pins = "gpio1";
+		function = "normal";
+		power-source = <1>;
+		bias-pull-up;
+		input-enable;
+	};
+};
+
 &pon_pwrkey {
 	status = "okay";
 };

-- 
2.39.2

