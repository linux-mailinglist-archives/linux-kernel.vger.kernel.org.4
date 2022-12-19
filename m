Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366EB6510CC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 17:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbiLSQ5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 11:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbiLSQ52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 11:57:28 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F98525C3;
        Mon, 19 Dec 2022 08:57:27 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id i15so13811831edf.2;
        Mon, 19 Dec 2022 08:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PhS7akt6/5GjmmwqRvvKx92tJjukY5PHM/MpxFGF9Zc=;
        b=O6tqEZsEXSBDdaMX34qiTVIG/tCQZf3MHEbs5did8QH3VP+2Jlcupm0+WKd90mIeiy
         Bk65T3wxesG04szD7+xUhDEaB6cQnlihEjONTv6S5QnHc+ctVfPYu7I2hJhJQ/3V2beQ
         PWCqYW5ZJYFoc5QxT5/8l9lRQcgdTT8oi0X/OSCLH8jFhP8lZjSCD6pdopivuC0sSvaa
         hQND66rxBh6Pzr7nA8ECL5hW53QBPaP25K7LmWnw1l0zdwhP+6aQNHHBdM/aEEKWZ9kL
         xJzCfBCN4X7O2LWbYIEFPRaZb/NaaMkZtQSjQ+2EaAbkt6FRNmgI+JLc9E8yTVjV4Dye
         x2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PhS7akt6/5GjmmwqRvvKx92tJjukY5PHM/MpxFGF9Zc=;
        b=PmKyJzy13o4jxcLUTdcxOOfQTYgf2iJyYFlDTCutRwjnv+/E8Z6WrFbPqTKaaEgr4D
         Y1eOtVFy0j1CjKx7e8i92RM3u9zHhfERDdOHd9T5qAZDPSqEd91N9/VP9wZPVy+52yzW
         sLXtPiNpSkQd9hVLpFnbWpOeY4wI3BcXDSsLzkUg3sy8QAc7nUL+yhOh1+8pndNybzZd
         TxA+FPbSNwjDFwBvt0GPzLvGeMEVAg3yt5xp+Sqa8zGkswxLYV+ic6b8tZXxQKgpDtQK
         JtKYRq7JUJvFSLq4JhRXifZr2QqWWvXStyBCyriJlcWRIAHjb26GyWPnpdFOZcYla5q/
         yfWA==
X-Gm-Message-State: ANoB5plpuOdAWN1yuArwV8iQs8ZC+6alN+wgSSJgd+mminsbMFfXvtGB
        x3dx3pbXTw0FquAGiEbaMg8=
X-Google-Smtp-Source: AA0mqf5amfEQflBYCgdGYyKTURYwp0xR5McAfORx30XNSIPPpUGv8Jy8egORwKoegqp/8goadXoj7g==
X-Received: by 2002:a05:6402:289c:b0:461:bf47:ba43 with SMTP id eg28-20020a056402289c00b00461bf47ba43mr50547191edb.28.1671469046095;
        Mon, 19 Dec 2022 08:57:26 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id b23-20020a056402139700b0046c4553010fsm4633925edv.1.2022.12.19.08.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 08:57:25 -0800 (PST)
Message-ID: <cde111a8-2a0f-74bb-9a0a-653091fd3788@gmail.com>
Date:   Mon, 19 Dec 2022 17:57:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4 5/5] arm64: dts: rockchip: px30: add lvds_out node
To:     heiko@sntech.de
Cc:     hjc@rock-chips.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, airlied@gmail.com,
        daniel@ffwll.ch, vkoul@kernel.org, kishon@kernel.org,
        linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <7f38e245-4fc0-1754-e75c-10c1e31bbd4d@gmail.com>
Content-Language: en-US
In-Reply-To: <7f38e245-4fc0-1754-e75c-10c1e31bbd4d@gmail.com>
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

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/px30.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index bfa358042..eb414d0f8 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
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

