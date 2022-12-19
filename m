Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B74A6510C9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 17:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbiLSQ5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 11:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232332AbiLSQ5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 11:57:19 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA7513DE7;
        Mon, 19 Dec 2022 08:57:14 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id d14so13709626edj.11;
        Mon, 19 Dec 2022 08:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kIy5s7RC8AaxDeyaGvZlKmpgc7tJJq7KaYed9ZtIYzo=;
        b=iKglceLNmpm1irnAm5RRAj07Ddb4fMJSondsKNS6Q31RnxA8mjeoWTv6oPmtfqvrXc
         j+ERWlUSshlqypOamf447O77jGgCATSNtECUyqesnW9GNPJEhaQwX3I+3T6c581L1gmR
         rQBBEnGzFmnuS1L7pSOYV8iyuZaOTDG9znMOmEeUkXUT9Xo6UngJSlH4dks4no9bhcNb
         onO+u+VuKPpvBkj/RgVPmB4HjhkufowWX0duOABfKzf7V1GN4asTERAcgrgJstNB8tGa
         YefUQtkW8GN5c4BH0cmiji2JGw4XI4LfieNbIc/GE6E7UJgQ2FNH1XjoF3Sm2AljlgwW
         oMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kIy5s7RC8AaxDeyaGvZlKmpgc7tJJq7KaYed9ZtIYzo=;
        b=z+Sk9p6Xsb+YvpF+Uz0cDEqyHgxHCaqO1ynp3Cv1FX0P3NbWaQl0WAFq3mIHQ78VF3
         7m6yPqD0Y2Br6d2mW9jSdt/n2ZQM1jigMHfwD964S5LF2lqC1Ny4kT0h8jInKI7+Vu4i
         Ruch8wL/vB2tb8L9+t5Ugs2e8WM2F5BhZIAY3AV1+bNhs0AepdijjidAPbRNFMutAmGm
         ffEgFOABogxhf3RtDWLg9Zu8oyHcm0+d7sxdjDpR/3q16ZJT9IuvQATXpJyAPQ3z43Ym
         YR3MadjODPu4aycb7dZGm/vC19IenyGG8YwLVl74K4V7ZJQ8FPgC0lp6V4DaRg/htevp
         KFCw==
X-Gm-Message-State: ANoB5pndVzRNGkzpvn/nBWl2k+N+X5b/cWZuBgNUaGLoSMiBP331fERv
        +enVEWohYVagKsK4hrdmhk0=
X-Google-Smtp-Source: AA0mqf61S7E1RbeVtjJAtBhuPuDmJprWomDuF86gXwRAGuXm7fqejx+R0qp9CgFeOJLF3abeDp9+qA==
X-Received: by 2002:a05:6402:5511:b0:45c:835c:c6d3 with SMTP id fi17-20020a056402551100b0045c835cc6d3mr31251129edb.4.1671469032996;
        Mon, 19 Dec 2022 08:57:12 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id l20-20020aa7d954000000b0045ce419ecffsm4619030eds.58.2022.12.19.08.57.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 08:57:12 -0800 (PST)
Message-ID: <460f4012-7a99-ae6a-ccdf-459773944998@gmail.com>
Date:   Mon, 19 Dec 2022 17:57:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v4 4/5] ARM: dts: rockchip: rk3288: add lvds_out node
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
 arch/arm/boot/dts/rk3288.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 487b0e03d..60207136f 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -1170,6 +1170,10 @@
 					remote-endpoint = <&vopl_out_lvds>;
 				};
 			};
+
+			lvds_out: port@1 {
+				reg = <1>;
+			};
 		};
 	};

--
2.20.1

