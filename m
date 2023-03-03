Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEBE6A8DF3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 01:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjCCAa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 19:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjCCAaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 19:30:24 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38210580DF;
        Thu,  2 Mar 2023 16:30:08 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id b13so755938ljf.6;
        Thu, 02 Mar 2023 16:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677803406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKy0/EJpfLjoekqVRMjvk2kg/XF7h2p24q53aPNe7AU=;
        b=acK4qqSKf20QVJyPIbAhfQyTqip4UmKrLYAgN/Ll7dD7jOyu1/lXP8SccQHw0azBhP
         /AEH9ueSYSKarCeZJfROCDNy3lL+zcHi4Ow6B5n0ukSo07DO5s2N9JSvcpQcFSG+xAhZ
         pW8+HcLwln5AXAZRuCdOPn1I43dIPtnlrAsheGFyxmI/mnzn5hEXtPAlJskQV1kUFX+b
         nzRtDyKuRRhRWw6n0OziglaNQFh8ytUrhoKU1bm46cOTblV41MTMQ9XjLXpUWrt7SMUU
         gjCLoZliXavRi3lqGhjQSqsjkTotuyCxSmJR9krDcjq+2Gp+Ik2MbA7g6wdipbgl3jaI
         ZIIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677803406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKy0/EJpfLjoekqVRMjvk2kg/XF7h2p24q53aPNe7AU=;
        b=Xikw6Ug7ctoUn1A+8VSL6P46dNlwc/LVe+hxEQMQ8MTeykp2UTHJ6Gx5rQUIddROIq
         Zc2z+3SvBGMUAunMELeqOKXQeevuc+QbUREm1jYpTjOJFSOE7aqtIDop71zZtdaq4IY/
         UGWKoUJ9YtDrGD1Lo7olmGRf0sD7MWQ9iiWEiA0qQbon5+hcGmeVt/AeFguYbkslaRgJ
         AO+H21k+jZUwXyLkPXqooZ0RnTW6XDGpkSPmmkJEQnD7cwyh1lhonx4wX+Hl6oZtBFi8
         EhvBC14njvpEIwqFVK5JWAOF79LFPrkFzpKMVqoLVOba3+ihjduILE3lfVYzZohQl1NE
         veHQ==
X-Gm-Message-State: AO0yUKW91yauXs0Gjn9UQNIl2fxErccekwq96VVAKuDa4OHKUL4QYFhB
        O+8bKgWQ+Tv4RWDZa/j0NM0=
X-Google-Smtp-Source: AK7set8tavXUlxbw0lEjlPRImcDRr9AOHEPmhatXmmtIizKc5CCyFfRLT40arWAn3qXv6wOUz+8WVA==
X-Received: by 2002:a2e:7e07:0:b0:294:6ef3:c2bc with SMTP id z7-20020a2e7e07000000b002946ef3c2bcmr2914567ljc.53.1677803406207;
        Thu, 02 Mar 2023 16:30:06 -0800 (PST)
Received: from arinc9-PC.lan ([212.68.60.226])
        by smtp.gmail.com with ESMTPSA id v19-20020a2e9f53000000b002932b817990sm64901ljk.31.2023.03.02.16.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 16:30:05 -0800 (PST)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com
Subject: [PATCH 06/20] pinctrl: mediatek: remove OF_GPIO as reverse dependency
Date:   Fri,  3 Mar 2023 03:28:35 +0300
Message-Id: <20230303002850.51858-7-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230303002850.51858-1-arinc.unal@arinc9.com>
References: <20230303002850.51858-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arınç ÜNAL <arinc.unal@arinc9.com>

The OF_GPIO option is enabled by default when GPIOLIB is enabled, and
cannot be disabled. Remove it as a reverse dependency where GPIOLIB is also
set as a reverse dependency.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/pinctrl/mediatek/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index 2eeb55010563..7af287252834 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -17,7 +17,6 @@ config PINCTRL_MTK
 	select GENERIC_PINCONF
 	select GPIOLIB
 	select EINT_MTK
-	select OF_GPIO
 
 config PINCTRL_MTK_V2
 	tristate
@@ -35,7 +34,6 @@ config PINCTRL_MTK_MOORE
 	select GENERIC_PINCTRL_GROUPS
 	select GENERIC_PINMUX_FUNCTIONS
 	select GPIOLIB
-	select OF_GPIO
 	select EINT_MTK
 	select PINCTRL_MTK_V2
 
@@ -46,7 +44,6 @@ config PINCTRL_MTK_PARIS
 	select GENERIC_PINCONF
 	select GPIOLIB
 	select EINT_MTK
-	select OF_GPIO
 	select PINCTRL_MTK_V2
 
 # For MIPS SoCs
-- 
2.37.2

