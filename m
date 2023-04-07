Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216CA6DACEF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 15:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240708AbjDGM75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 08:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239695AbjDGM7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 08:59:44 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279657ABA
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 05:59:43 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d17so42227096wrb.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 05:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680872381; x=1683464381;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jv6uesjmZKFlcTpR6W4nlDS/ErUwCnhH53sWS64Er7Y=;
        b=A4jWSwGhGdz3yvWFgpqe9NlDODCzwwx6DOkR9O2UY4Yrxy8/9kLzreZ3L6bbXD+Ae/
         sFCTqVlYSMyMMTmgSI3sJRi3qrDakv9CUBLVEaTMAyr+ojkyy2JpxsKZkaS1K9NpK3mN
         pI477JBg4osigvpTiX7ys+Jp/b/r8TzrdP2Q5AnOS1ZO3xU4KZF3j0zHC55bMY1GA4rv
         DH0SwlR10edgD28Eh8mpLyjKVPLRLya/1w8QexMl34AgIa9FlzqWv39f8mjqgQuyvMVm
         PNEld+aLyOlYKthMU+MhbPRJCzpaL6wDkqa1kJiWGSrp5xM0XmiL7gB3VAE92bNKKQnC
         J3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680872381; x=1683464381;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jv6uesjmZKFlcTpR6W4nlDS/ErUwCnhH53sWS64Er7Y=;
        b=aaGW0Wxjd/lTLyPJQ3Ye8rRDGbx8QkitT6molgFmbNzPlD+6md8XxNQjl9qchOG8O6
         enBVzcNh4VejleDfSfC8ba/PXmQtqMHXSSdCdZhlS/KLxd/aStbxg4J8td33s2pRJbGf
         TdgMn+aNiYYKtcm58OciJGCq1g2YnWINBh4cH2kq3qZ6GkppuIREKcyXWEii0hrJiLGh
         FFT3HzThuRhp9vewAcgF38kMYR5geb0DRpJvvs85213FW3CqDqGAgEMK8clptukb5ARZ
         ubfcbmPa1+n5SLMRO5NFXMMBMR8cHFMSK7+f+WCj30ZMeXNZftGzDKEaQloBkR12+azc
         3tiw==
X-Gm-Message-State: AAQBX9d0ulUMF7mY+J/NxCXHqcDV6fo87SUcr2bHMJlqNDdQluM+Tesj
        sjjJh2fLflxINlPQ925Z5AJZ7Q==
X-Google-Smtp-Source: AKy350ZaLC8TwIDCmSoJ6SvrwuhOk/cXz0vgHxCRAEK5iSsV3euYHNdphxuidvBWfdm0bgUek9GLgQ==
X-Received: by 2002:a5d:5383:0:b0:2d8:82f9:9dbd with SMTP id d3-20020a5d5383000000b002d882f99dbdmr1333922wrv.11.1680872381567;
        Fri, 07 Apr 2023 05:59:41 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id t4-20020a5d6a44000000b002e558f1c45fsm4471446wrw.69.2023.04.07.05.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 05:59:41 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 07 Apr 2023 14:59:20 +0200
Subject: [PATCH v5 01/12] arm64: defconfig: enable MT6357 regulator
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v5-1-1883c1b405ad@baylibre.com>
References: <20230203-evk-board-support-v5-0-1883c1b405ad@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v5-0-1883c1b405ad@baylibre.com>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?utf-8?q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Alexandre Mergnat <amergnat@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=583; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=sS9Bqjy2f/wrV6dRVMTpSR6wSBcC15zFUiRoUmJvDA4=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkMBO60PeWsaAgjDgdQZqw9UM2aDFQwIk354Xe6wol
 CMWufB2JAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZDATugAKCRArRkmdfjHURUwiD/
 432JUu5PRVuk/Ky8foy11MAu6x4+2Jz5kyX0fIx8QccHaDynhPpyfkh90nbmjpkJlYhaBw4A6WREt6
 RklRROJLK2wqYHMw4GAKXkar26H5sz8Re9qJghzBJ9VKr7r1OHolgHE6Ky0SGsIE2H+3oWjOxeTjLE
 kUiwv5ALamsdrFm8EJKTRUAiG4mOLp44lKXI/AimkQ8OWrjfhM0KuKBPoqMxdNkiBk60a5/k1UA6v7
 iJr2+TZw+/tVL4ZLVgq9j81hBHWdbRN7isFoQXmWfnNZ0rcrV4vxgEARZ0HHFxisWo9UemYUveMu14
 gpc96Vk9GKqmIUsIEf74yrKV4Jnc7Cxwl0QPtQUUblsfE8noSobQOYW+JslYOslrDrMyjI6FtXM6nO
 Q6Zm1CIqxrOTivgnNWx3jmXr59yEZ0Wd39mOooAwvO8PvOq/dpxz360q/I+/v4aGM4s+gziUXVcTt9
 OQt+yrdSYxB4UyA1Jzit4/q/ZlCFo6Q9pN/T6N82OY/lhU6OvyugB/pTWVVyHE0iXV8i5FGECEC7Rr
 eSwZ9GNJKzHZn2oCJSUOBx7043b84zmNUOzD38EQRyi5je6vGWxuegxhRtuzWyjF0zdDE49adCH8O9
 +N6XoUXjCS3k8Ze1qkblfSHW1wYotVpgo1CT8HnQ7IXp38UyQkgcKs95WxJg==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7790ee42c68a..e4cb65889ae6 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -685,6 +685,7 @@ CONFIG_REGULATOR_MAX77620=y
 CONFIG_REGULATOR_MAX8973=y
 CONFIG_REGULATOR_MP8859=y
 CONFIG_REGULATOR_MT6315=m
+CONFIG_REGULATOR_MT6357=y
 CONFIG_REGULATOR_MT6358=y
 CONFIG_REGULATOR_MT6359=y
 CONFIG_REGULATOR_MT6360=y

-- 
2.25.1

