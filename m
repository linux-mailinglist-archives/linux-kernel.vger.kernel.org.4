Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FFB65431B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235754AbiLVOcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235762AbiLVOcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:32:00 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DF92CC90;
        Thu, 22 Dec 2022 06:31:55 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id bj12so5239584ejb.13;
        Thu, 22 Dec 2022 06:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lFvMuvMh7YEjHgfoyUurfQAp5Ldp3Bc2q4aAnoQCwkM=;
        b=UEIhkKWoFeB7/VD8t9PzUu7vtS7TIeFsilzBgAB+93Xv4bZU2aqtdrqCrWaiHn8/4k
         Gqh3MnUWes3mh8RfOzl03vepj6GNVlTp02NM6MqPWLBnNWGRJ9nYtO1Tpl1NexYFKloS
         nlqlVa7LeTwImrSwsFeLkQ6mKkMY0O+/IYfklKN3B7Tr7u4TRRrxseriD9tWFMJ6Jhu8
         kyOLooolnbzf5hlim0TLVJx3hUziFlKSLWEkAVBaWXLGSaqgjV06UIWBcnv66dqdP6M5
         WY+jyRVrmwHqCY+D8blj2xmpEW7w6ddmIj6vSvOO9kXz+3V+do9PePr6DQY3c/NToSRd
         XS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lFvMuvMh7YEjHgfoyUurfQAp5Ldp3Bc2q4aAnoQCwkM=;
        b=vjWOAp/mQOwjoMql2qODi8NVe+8kOCcfuN+p0ErEoyX21xnrZb261kQzKzz0HfgNwY
         kVWr2j2WSnpSX5O+XQ+3EMkmVt84vfAJUtc7hTFeEiOTmWgVpzy28mEnMbArXs6PpWdA
         PajZAuS5vXwc9dnFZOHsNNsRyiGO+Dwui1D0GkpXvCOu44ee55+TQvucA6xnV0P19xgl
         W979OEwc1n8WqccxwBjthBi6LCsJbvmtRZpC+LPzZn4BBuVFFi3sf9z1CRAmsSXnd0LX
         NVLHHZhzXinzPQaGlC8dqUO5y4e4TGk3LG9tWJI8CB+QE2Cy4pwc4TtkNbRr9ciX0RGa
         WBNQ==
X-Gm-Message-State: AFqh2krX1kO0WXwsu1Oe+bZJ2+mRpxmw6IuPRldPV5/MtVgHWJOYwtH7
        eRnQWaPnZIrf3vd9MlqtnVQ=
X-Google-Smtp-Source: AMrXdXuKo0y+jgpQ4XMYoeRlNa+3DJD1h+IM0SCflvH2n8L7F0YnfErTLmj2vVioQdYM4xGprfD/AA==
X-Received: by 2002:a17:906:b150:b0:7c1:2931:2263 with SMTP id bt16-20020a170906b15000b007c129312263mr4906531ejb.71.1671719514446;
        Thu, 22 Dec 2022 06:31:54 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id k8-20020a17090632c800b007c0f2c4cdffsm312593ejk.44.2022.12.22.06.31.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 06:31:54 -0800 (PST)
Message-ID: <1ee3e676-aef4-f464-82b0-8fb39ba5c60d@gmail.com>
Date:   Thu, 22 Dec 2022 15:31:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v6 13/17] arm64: dts: rockchip: px30: fix dsi node
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        airlied@gmail.com, daniel@ffwll.ch, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, philippe.cornu@foss.st.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org,
        linus.walleij@linaro.org, inki.dae@samsung.com,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com,
        alim.akhtar@samsung.com, linux-samsung-soc@vger.kernel.org
References: <67771143-fd83-383d-41b2-68e8707134e8@gmail.com>
Content-Language: en-US
In-Reply-To: <67771143-fd83-383d-41b2-68e8707134e8@gmail.com>
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

With the conversion of rockchip,dw-mipi-dsi.yaml a port@1 node
is required, so add a node with label dsi_out.
Also add label dsi_in to port@0.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/px30.dtsi | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index e34d81f29..272b01154 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -1117,7 +1117,7 @@
 			#address-cells = <1>;
 			#size-cells = <0>;

-			port@0 {
+			dsi_in: port@0 {
 				reg = <0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -1132,6 +1132,10 @@
 					remote-endpoint = <&vopl_out_dsi>;
 				};
 			};
+
+			dsi_out: port@1 {
+				reg = <1>;
+			};
 		};
 	};

--
2.20.1

