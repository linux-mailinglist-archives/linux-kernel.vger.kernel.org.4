Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC9865363C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 19:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbiLUSZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 13:25:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbiLUSZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 13:25:24 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9780724F01;
        Wed, 21 Dec 2022 10:25:23 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id e13so23193450edj.7;
        Wed, 21 Dec 2022 10:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bW6Hd9ovFsWCrzyECcvTbdEVVhvmMqsQBtWMpTHrRQw=;
        b=c6PLr84dzk55g4TInxedeMSL6DbBADfkbaE+qIPw3Qn+5j/qhJXOmQTG6hY/PcWH8g
         aDf37hQlbTXxU9q/kwcsm9XhbVdr6PkKPBho3MCvFt6nuKNekmSjx8t9XxODZFvuUK/1
         v01moJBqkKUha+/niV0yAX4n3hegzpLt3xRcCzlpONPs6QRfL7QilSk3U9Q7JsL0QQgI
         j0nk5iTi4emDiCAp3FxPXwq6zpfy+/nHAhnPn4Z7ujR1zKW0js/54wGdhh7RdpN7W9ma
         vWBzBfy1d24O388Zv6R7p804WcYvsE853PdgOReHLNwpHaExWEUqprsJZ86m0XDSTEda
         ePAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bW6Hd9ovFsWCrzyECcvTbdEVVhvmMqsQBtWMpTHrRQw=;
        b=TOq8KDH9HCoSWpXXDdVfKggy4SsnHSl9RH85c5wwmcOnk/O0/fjjfl5jvV2EGu3IiY
         7q0hieWPJL45n583vO/hM0PNfaKPUNaEnedW818H0AS/pAw/EtFh15SqS6miAloltgfQ
         PZhE8Fmh/PCnRdVdl8IKWxr88DPWatETF0Uh6ibSJKzXb8bybdcBkUZSnPOrmMLoXe3i
         zNwp3NnJfWyJBd29si82ZasXJB2hdSbrWCUWpxOq6n+LpFagSe7oWyyhagPfqzVU3S4a
         xV9I4N2Ic7MRVJsVZyjGhCHHjktXnykHtDnxVNANn8qIxUY8gVwZQb6xXzrwJfFlENFT
         herQ==
X-Gm-Message-State: AFqh2kq/l3aLBQzpq4aTHkIYHyxE7kWeCzkBbv6USDMzNgqf2O5cGlfl
        6XnncMa5XcREvoqPnjk4fDY=
X-Google-Smtp-Source: AMrXdXvTC/4eIpPvqgKcBGiKaMezF5TmdklRaodynC+6Ax6UhTecCm8Kbwq4bFPQzwHpDW5kOEXcrA==
X-Received: by 2002:aa7:cd04:0:b0:46f:a70d:fef2 with SMTP id b4-20020aa7cd04000000b0046fa70dfef2mr2382224edw.35.1671647122248;
        Wed, 21 Dec 2022 10:25:22 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id d30-20020a056402401e00b0046b25b93451sm7255607eda.85.2022.12.21.10.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 10:25:21 -0800 (PST)
Message-ID: <76fea2e4-f298-19d6-69b0-d99dcfb142ed@gmail.com>
Date:   Wed, 21 Dec 2022 19:25:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v5 08/12] arm64: dts: rockchip: px30: fix lvds node
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        airlied@gmail.com, daniel@ffwll.ch, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, robert.foss@linaro.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, philippe.cornu@foss.st.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org
References: <7f883643-c796-029f-ba38-73532325632d@gmail.com>
Content-Language: en-US
In-Reply-To: <7f883643-c796-029f-ba38-73532325632d@gmail.com>
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

With the conversion of rockchip,lvds.yaml a port@1 node
is required, so add a node with label lvds_out.
Also add label lvds_in to port@0.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V5:
  rename title
  add label lvds_in
---
 arch/arm64/boot/dts/rockchip/px30.dtsi | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index bfa358042..e34d81f29 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -453,7 +453,7 @@
 				#address-cells = <1>;
 				#size-cells = <0>;

-				port@0 {
+				lvds_in: port@0 {
 					reg = <0>;
 					#address-cells = <1>;
 					#size-cells = <0>;
@@ -468,6 +468,10 @@
 						remote-endpoint = <&vopl_out_lvds>;
 					};
 				};
+
+				lvds_out: port@1 {
+					reg = <1>;
+				};
 			};
 		};
 	};
--
2.20.1

