Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2AB654316
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbiLVObf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235708AbiLVOb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:31:26 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97822B61F;
        Thu, 22 Dec 2022 06:31:25 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id d20so3229912edn.0;
        Thu, 22 Dec 2022 06:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bW6Hd9ovFsWCrzyECcvTbdEVVhvmMqsQBtWMpTHrRQw=;
        b=UmrBHX+ITAjCTD/jraE2nPoYqi2kuyYlYfiftb7UsxEAzRved4jYSoN7MtzbLKlQ7q
         3r53gXkAk2BWdao1WBouYq2dGLCwiPVivXB2b2w5mYlcCbVF/h1p2/VuCPmwbYNDTQP+
         h21Tk3n1RBmFMl3w/jJO6robuO6aJPcmb1Fzzov8vVF34+DfxTTMm7XPZWJBpQNtqvzO
         M/sUL9BdGiOAJFiHoWfrMZ5Gz/632NoFvw4gTUEhJCYiwVMnoAJjbPrjxaW1022PXZJv
         +H8HUyTXy660waa7WqWynKpwzT2G4bqMvmg8jeGlBLqt32JkkUgjFK70+h6Dfxqqe4jD
         a0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bW6Hd9ovFsWCrzyECcvTbdEVVhvmMqsQBtWMpTHrRQw=;
        b=EJl47ch5vUPfRr6lij8a3K9MzaBX4F9XlP0flv/RedP6ik1ZFqs0mbTv5D/9HdC2DN
         Wjkme4gZWRKkkAnDTPXvL4RyZIdmKvfxaPGH3RDmfHK4RV9zz+2//rUjqMmzt0qqtP+l
         9//nSP0O435PFP99TwjiriLTIJrM/lRVx9c6l6VKEf9dndPWZcxLVqLdIWCxZRRrlYeC
         tSKED8pSntogns2ePasZ8hen6QzIRDYVhh1sP0tOLtbLx6qtB2sN+W67Jsyb0u6iBe/m
         cQGm4IyRveCqGwWXnKilQ0GvFA47CHbY1WSgX0K8itZ8od0Cs66TWlKetCwbQnNDkhjH
         iTaw==
X-Gm-Message-State: AFqh2kojxwHucxNdczeqgCJoijse+Qrc99EeR0mYSfOw1uUIGqfIQcir
        TwEr4XGjwQFSDpggg8wYGJ0=
X-Google-Smtp-Source: AMrXdXtxHQQvzCNkSik7yX/z0ueyYewn5n5Af67lZrnJ1cWnklfdFv33LN/MI7hUA3CP1NUEgPRCSg==
X-Received: by 2002:a05:6402:2a04:b0:461:de81:d194 with SMTP id ey4-20020a0564022a0400b00461de81d194mr9671100edb.31.1671719484507;
        Thu, 22 Dec 2022 06:31:24 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id i5-20020a05640200c500b00463c5c32c6esm417648edu.89.2022.12.22.06.31.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 06:31:24 -0800 (PST)
Message-ID: <99895a4b-25c4-4b64-42ac-6f70940ab56e@gmail.com>
Date:   Thu, 22 Dec 2022 15:31:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v6 12/17] arm64: dts: rockchip: px30: fix lvds node
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

