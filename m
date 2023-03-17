Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3516E6BF3F8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 22:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbjCQVa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 17:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjCQVat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 17:30:49 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0011DCC2E;
        Fri, 17 Mar 2023 14:30:30 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id ek18so25428718edb.6;
        Fri, 17 Mar 2023 14:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679088629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gB9wsR/QejWKnTpjqpalvhn0ClVxLzlxnCNLg5LJDYI=;
        b=DeEVrrd12HU2BAG6cPFbACSL4/hWSMKzky1XNI+Efkafor07HEaRDFq/E128YGgf2C
         zNjp4F2Ls3MSXdI4ClYk2mXmcL04SPTUNpQH/xFA3c4RM8Yt2LdS0/zLfv4c2HMBUkXD
         z5ha+4wbHknDdoU69qzbdpMwQIoQrKIHUR4yWFaSv+sgQWSjkEJWk03aj/CfkF6Rpniw
         wOm90IAoZ2aD7TVsfb1dAfmL5R67VyTgKfIYUnnAQZzkyLHZDcGc/oLpUj4b2X+xQNdd
         ecuMxnMIBf2zX+HNIU4LTCTg7VbtZ0ABEoOWWhVtyZ3zRiAU5LbxfmgpK+BfBVwAuzLy
         ftjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679088629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gB9wsR/QejWKnTpjqpalvhn0ClVxLzlxnCNLg5LJDYI=;
        b=JfedRP5j401mzqyEHJbqeScBXkU8eIgBMByoPC3kNbNUrNd1UwrNVwKhBhAcCbrXUw
         rVFiFwUuXXRx2+lBZmoHQQ8aAtbTg4Ui7xZY2yD6Nz1qYN+slV01GoSI124JPt+ZVLti
         tXt/dUfGdG0gihnPFJbeN0mMO5jHrnKj/c9ebtf8jZKHyX6plAcCfA7GDB7CSaY8Wjpf
         +qZPVpAjiLJk+kZ3w3QBOEg6Zy2dBo0tA7baqttCCAgn161XRK4qMysQfQ1YolmWnkAs
         OMn5km/Ja6WDeaj+7GDI05azD+1AjSVkhoJSt0JXkhsV8kQEQjPuYgQzKoWW3gewgHwH
         DfKQ==
X-Gm-Message-State: AO0yUKVC+03pZxMZISlX0zJbg3hHON+dvtaqjlwo7knmV2AxIpcrrbhL
        RJOOI7hRQbC85pNMB0mTsE4=
X-Google-Smtp-Source: AK7set9ZDd1hJkSDFx7yupS27zfy8fGrjwhkV7qA9C6gFSRh6OVgFYg7DSrCVPDblSg/8gD6iJ6iFw==
X-Received: by 2002:a17:907:31cd:b0:8e1:12b6:a8fc with SMTP id xf13-20020a17090731cd00b008e112b6a8fcmr954836ejb.4.1679088629209;
        Fri, 17 Mar 2023 14:30:29 -0700 (PDT)
Received: from arinc9-PC.lan ([149.91.1.15])
        by smtp.gmail.com with ESMTPSA id v19-20020a17090651d300b0092b86d41dbasm1404683ejk.114.2023.03.17.14.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 14:30:28 -0700 (PDT)
From:   arinc9.unal@gmail.com
X-Google-Original-From: arinc.unal@arinc9.com
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        William Dean <williamsukatube@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        Del Regno <angelogioacchino.delregno@collabora.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Hui Liu <hui.liu@mediatek.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org
Subject: [PATCH v3 05/21] pinctrl: mediatek: remove OF_GPIO as reverse dependency
Date:   Sat, 18 Mar 2023 00:29:55 +0300
Message-Id: <20230317213011.13656-6-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230317213011.13656-1-arinc.unal@arinc9.com>
References: <20230317213011.13656-1-arinc.unal@arinc9.com>
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
Reviewed-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/pinctrl/mediatek/Kconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index ba21a599953c..ee04b1af36dd 100644
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

