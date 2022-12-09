Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60AC8648772
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 18:13:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiLIRN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 12:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiLIRNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 12:13:21 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2E9419B5
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 09:13:14 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id a9so5528994pld.7
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 09:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M88P4SMh5VCPJCyuLc/w2B8fWJUsM71IvdRT7VAjmHQ=;
        b=fGd3e82N31A7l0GFrD4RELU4+SmeP8YESrYNFW7YbDq/1R5jPqb8HNf+yew8ZNCRFM
         C7/4ccIgu7oVj7ehikAIRQtjKtveYz2hYbWdeapMVOiPP2ZlFmwVaQBpTsw0kUPnRo+M
         A6RKaIjdiuS+DXbkVcxHNSKfFI/mfyREzSE9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M88P4SMh5VCPJCyuLc/w2B8fWJUsM71IvdRT7VAjmHQ=;
        b=50Fe9Kh5Zk6YwCZSn3SbmTL9jU+38HWKkMJ9M8KoNiuZXWB+ZNgcNHysHj92e4Ra7k
         0HJeu9LoNjm0oPuCj+QOqX1P3f6ADtich1YSl9UvFv8deDtFB3R4wNIerVhhpPpUfaMV
         AfwGfrDYYVPJvb+LZrfX1jMkqAbUByyUVqHW7xJTBGBk/ubHux0EMt+LEcT8WigrFZrA
         Ft4j9ykofBuQLeTemShyf3sFh0LyhEVQ2bThEhzPlnEkhc/joQIb7+2NJt0fM1Bs1Td4
         SitE7h6oO4clQLhdwb5fb0fj3jVH4YP1nH14+ldHIqgiiT5y7wh9UztlEvk49q5u94zW
         lz3w==
X-Gm-Message-State: ANoB5pmGG5eK2s1A/nsV534XbLhscNp50MBOAaFy4D5lEBFVdc1c+WR8
        A+q0crcOP0KlK/+yetzcBQHXfg==
X-Google-Smtp-Source: AA0mqf5o0cdOIYZpQg4mEqTBzOqbSQQI2YnX0/UwHmDG/Y+0EqLsG00JvO50nunOCSXjjf7bSa5orQ==
X-Received: by 2002:a17:902:aa08:b0:189:fb78:a7d4 with SMTP id be8-20020a170902aa0800b00189fb78a7d4mr6267571plb.21.1670605994046;
        Fri, 09 Dec 2022 09:13:14 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:9a82:7898:7bf4:b4f])
        by smtp.gmail.com with ESMTPSA id j16-20020a170902da9000b00189c62eac37sm1597503plx.32.2022.12.09.09.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 09:13:13 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     swboyd@chromium.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        mka@chromium.org, Yunlong Jia <ecs.beijing2022@gmail.com>,
        linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-input@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] arm64: dts: qcom: sc7180: Bump up trogdor ts_reset_l drive strength
Date:   Fri,  9 Dec 2022 09:12:37 -0800
Message-Id: <20221209091234.v3.1.I39c387f1e3176fcf340039ec12d54047de9f8526@changeid>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
In-Reply-To: <20221209171240.1614904-1-dianders@chromium.org>
References: <20221209171240.1614904-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On at least one board (pazquel360) the reset line for the touchscreen
was scoped and found to take almost 2 ms to fall when we drove it
low. This wasn't great because the Linux driver for the touchscreen
(the elants_i2c driver) thinks it can do a 500 us reset pulse. If we
bump the drive strength to 8 mA then the reset line went down in ~421
us.

NOTE: we could apply this fix just for pazquel360, but:
* Probably other trogdor devices have similar timings and it's just
  that nobody has noticed it before.
* There are other trogdor boards using the same elan driver that tries
  to do 500 us reset pulses.
* Bumping the drive strength to 8mA across the board won't hurt. This
  isn't a high speed signal or anything.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---

(no changes since v1)

 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index f1defb94d670..ff1c7aa6a722 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -1376,7 +1376,15 @@ ts_reset_l: ts-reset-l-state {
 		pins = "gpio8";
 		function = "gpio";
 		bias-disable;
-		drive-strength = <2>;
+
+		/*
+		 * The reset GPIO to the touchscreen takes almost 2ms to drop
+		 * at the default drive strength. When we bump it up to 8mA it
+		 * falls in under 500us. We want this to be fast since the Elan
+		 * datasheet (and any drivers written based on it) talk about using
+		 * a 500 us reset pulse.
+		 */
+		drive-strength = <8>;
 	};
 
 	sdc1_on: sdc1-on-state {
-- 
2.39.0.rc1.256.g54fd8350bd-goog

