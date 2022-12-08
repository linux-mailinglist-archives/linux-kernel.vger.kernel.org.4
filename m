Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1031664761D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 20:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiLHTUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 14:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbiLHTUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 14:20:35 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A22F99533
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 11:20:34 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so2537613pjo.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 11:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RXZFKzf8SEbO5MJF/tbRe/Hy6ddvI0OXNJGHZyfmauA=;
        b=RtJ6gvU4u20lqWyhOPFyXMpF2NNgS93C/PcBqKyQgBoFU/M+fleiQZVu+iLC5JcJ7M
         k1BnmfKE+l26w6sOkxNlZblsmHXxnqW6B51hWf7K1Fx8xpIAta67G1itL2XTPNVkTqMF
         rTDYvm+ygXrkJIXQrKCfRD4GXpt6a3f9bTeSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RXZFKzf8SEbO5MJF/tbRe/Hy6ddvI0OXNJGHZyfmauA=;
        b=JaQXfQsAj9LYONy2IyIkV+veu4HEybxQLW8/tn0xIGCyMoosNT+KsY2c94ePEdbdH0
         z+1ntE5MYWwpyk6GEuwHdZUHOC5ucCy9g5SV5OdcNS7M7UgKJe1lbBjwUQoSTNVJMcgy
         xfT29qxbA+ataLrz9vadjkpl4quzAdTCSwPGnX0HMicDBIF5ApD4xV/OZMvAmDm1ALdr
         5q9c4kSdxD9zaehYSv3c7kx7wBwYC5j4LVGBXQPu6Zdw7KuG8dS8OwRu9oWwIgNtPxwT
         CTgtowrp1vgWgD4pvzjTs7bBEcfKG7gbiHR8UvFvjmXZKXxZtE9gOFJRvgYpv6firUfC
         cUGQ==
X-Gm-Message-State: ANoB5pm86hzV0MTnJTyTJdnCwo77mPnoGEc5ZpepOPEODEe2a+TMrmdZ
        RU7dQ3owsdtVIMXFoxK96n4MSA==
X-Google-Smtp-Source: AA0mqf6oAueA5N3ojF9g2UU8lo98Akl0XQg6efVKCgb/OgaGdyGx3oRASvhK8156nzOWVHnnI212Nw==
X-Received: by 2002:a17:902:ab57:b0:189:4de5:6c7f with SMTP id ij23-20020a170902ab5700b001894de56c7fmr2866574plb.3.1670527233568;
        Thu, 08 Dec 2022 11:20:33 -0800 (PST)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:3aa1:2c62:9ac:4468])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902e5c500b00186a2274382sm17112019plf.76.2022.12.08.11.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 11:20:33 -0800 (PST)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     mka@chromium.org, swboyd@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org,
        Yunlong Jia <ecs.beijing2022@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] arm64: dts: qcom: sc7180: Add trogdor eDP/touchscreen regulator off-on-time
Date:   Thu,  8 Dec 2022 11:20:03 -0800
Message-Id: <20221208111910.2.I65ac577411b017eff50e7a4fda254e5583ccdc48@changeid>
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
In-Reply-To: <20221208192006.1070898-1-dianders@chromium.org>
References: <20221208192006.1070898-1-dianders@chromium.org>
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

In general, the timing diagrams for components specify a minimum time
for power cycling the component. When we remove power from a device we
need to let the device fully discharge and get to a quiescent state
before applying power again. If we power a device on too soon then it
might not have fully powered off and might be in a weird in-between /
invalid state.

eDP panels typically have a time that's at least 500 ms here. You can
see that in Linux's panel-edp driver that nearly every device
specifies a "unprepare" time of at least 500 ms. This is a common
minimum and the 500 ms is even in the example in the eDP spec.

In Linux, the "panel-edp" driver enforces this delay for its own
control of the regulator, but the "panel-edp" driver can't do anything
about other control of the regulator (for instance, by the touchpanel
driver).

Let's add 500 ms as a board constraint for the regulator that's used
for eDP/touchpanel on trogdor boards. If a given trogdor board stuffs
only panels that can use a shorter time or stuff some panels that need
a larger time then they can manually adjust this timing.

We'll only do this minimum delay for trogdor devices with eDP (ones
that use either bridge chip), not for devices with MIPI panels. MIPI
panels could have similar constraints but the 500 ms isn't necessarily
as standard and there are no known cases where this delay is needed.

For most trogdor boards, this doesn't actually seem to affect anything
when testing against shipping Linux. However, with pazqel360 it seems
that this does make a difference. It seems that the touchscreen on
this board _also_ needs some time for the regulator to discharge. That
time is much less than 500 ms, so we'll just put the eDP panel 500 ms
in there since the board constraint should be the "max" of the
components.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 .../boot/dts/qcom/sc7180-trogdor-parade-ps8640.dtsi  | 12 ++++++++++++
 .../boot/dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi   | 12 ++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-parade-ps8640.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-parade-ps8640.dtsi
index ebd6765e2afa..e27a769f8cd4 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-parade-ps8640.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-parade-ps8640.dtsi
@@ -26,6 +26,18 @@ pp3300_brij_ps8640: pp3300-brij-ps8640-regulator {
 	};
 };
 
+/*
+ * ADDITIONS TO FIXED REGULATORS DEFINED IN PARENT DEVICE TREE FILES
+ *
+ * Sort order matches the order in the parent files (parents before children).
+ */
+
+&pp3300_dx_edp {
+	off-on-delay-us = <500000>;
+};
+
+/* ADDITIONS TO NODES DEFINED IN PARENT DEVICE TREE FILES */
+
 &dsi0_out {
 	remote-endpoint = <&ps8640_in>;
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi
index 65333709e529..3188788306d0 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-ti-sn65dsi86.dtsi
@@ -7,6 +7,18 @@
 
 #include <dt-bindings/gpio/gpio.h>
 
+/*
+ * ADDITIONS TO FIXED REGULATORS DEFINED IN PARENT DEVICE TREE FILES
+ *
+ * Sort order matches the order in the parent files (parents before children).
+ */
+
+&pp3300_dx_edp {
+	off-on-delay-us = <500000>;
+};
+
+/* ADDITIONS TO NODES DEFINED IN PARENT DEVICE TREE FILES */
+
 &dsi0_out {
 	remote-endpoint = <&sn65dsi86_in>;
 };
-- 
2.39.0.rc1.256.g54fd8350bd-goog

