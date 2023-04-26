Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B896EF2A5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 12:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240562AbjDZKtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 06:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjDZKtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 06:49:42 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9FE1992
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 03:49:40 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-2f3fe12de15so4228910f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 03:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1682506179; x=1685098179;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KPpAdhSm4CJD/pgk6jTskL1NGIM3f3MtmEm7eXNsMmc=;
        b=h8t3mOk1DY13CsWSJvSQLRak2mrfZKHeeT4GR393Ga032pReV4vlUkdVhUo1CqXNK3
         cRIc0qtPx4p4Fze4D0s9gGQ7i+emYWhu2bs+YDQ+8GxEoweG99yX0OCyvWwggC1jZeWM
         d9vSWdWy7zB0DdBzlbJsEZIEsy703GY87jJ++wz1ZwqYPAPGXghcXItMGAhUWaXPOXpx
         i/6YR8dywf+Ma+iXJU9AVz6S1IhDPjliWT0MCfClE00SebboN85a76g/PIZqmxiTGr7W
         j84/A3oQt+95M/e+nUkETVsbOpfzrwLGiC2zxmn6TyyIH16C9k5b3nOOW+LMRc4o3vfk
         zwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682506179; x=1685098179;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KPpAdhSm4CJD/pgk6jTskL1NGIM3f3MtmEm7eXNsMmc=;
        b=Gf6kul7kKaEIeLkewZ3WVZHh2tKgBmWnm4+yhlolQDxL3V9y+iheozLmpGU/MTFIdt
         unT5YW/gVXvLBMU7tN0lMsJu9DEY93WS5BuMgNzbDxN3lvISMcWA27HpqZFOZreExLyq
         Gm0GDySZRjNFv71AL0KxkN01ogkmRGZsun2I23GwL6gho+YiglLKD99xx2OtzDiWvoHO
         KrMF3I5rbMSCoY4+z1cwYVrFp6uC2ggoehltfWUtlRltni3SygBqq4NVtgQ7+cFzZlA1
         RN/YFKoXHcUQWniN47yjrpMQqwIw82I99BSjK2P+dZTTkFQlQPKRzgAFSW94K+qcWjRu
         YOyw==
X-Gm-Message-State: AAQBX9eR+8hiesUgUFOUuKmLSsLSINCYn28/kmcZFHBcevH9Y21vmzZR
        R1Y20x8QXh7cb/S7AYcrl9NtmA==
X-Google-Smtp-Source: AKy350aTontAhbh5/FKzND2ZbdcpHG6W0NonLo78fbx14JplajvW2ZLTYIjXkLeUV543VHR06kgiLA==
X-Received: by 2002:a5d:5957:0:b0:2f4:3b2c:1b2e with SMTP id e23-20020a5d5957000000b002f43b2c1b2emr14997388wri.31.1682506178885;
        Wed, 26 Apr 2023 03:49:38 -0700 (PDT)
Received: from [127.0.1.1] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.googlemail.com with ESMTPSA id 25-20020a05600c025900b003ed2c0a0f37sm17601988wmj.35.2023.04.26.03.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 03:49:38 -0700 (PDT)
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Wed, 26 Apr 2023 12:49:02 +0200
Subject: [PATCH v6 02/12] arm64: defconfig: enable Mediatek PMIC key
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230203-evk-board-support-v6-2-8d6b1cfe7f29@baylibre.com>
References: <20230203-evk-board-support-v6-0-8d6b1cfe7f29@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v6-0-8d6b1cfe7f29@baylibre.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=794; i=amergnat@baylibre.com;
 h=from:subject:message-id; bh=k532urY0g0V1o02FuoDf+quB6H4pbB8k/wwqhAx1hVA=;
 b=owEBbQKS/ZANAwAKAStGSZ1+MdRFAcsmYgBkSQG/E5aHHBqCCuaioO8fxvJXXol/Q6XwEd52YIOD
 cKygCWSJAjMEAAEKAB0WIQQjG17X8+qqcA5g/osrRkmdfjHURQUCZEkBvwAKCRArRkmdfjHUReACEA
 CbQfWLBQ0a8kH4g5vbThuYhFwqe1JQiv5flAnX7LXAZGSQy5M3ts6LLb1jsnXZk8NnJLcrZglc+SSs
 vZPml1Moe2faBlLDnGn4LtxZtPHIGnDB3SPB/Ns503pTsz9YWE5SkPVFZZb3VifUzflhpdtyg+09GK
 wyVc7bfegYDa5XhoC7MD10ifHM/YICo+M0KcSTR+lI8E+V68lOCmrxm77kgj0oqMsrKLBz102sDp9y
 Qv9S1urL5Xlgyj+SQ0lndl+2RYUk7zbv0EDROmFJ0eyU25zH1pRWyBberZrFP8AhY1d08Zt5iz0fOx
 l8ddAfnqWmHgsBsyXmzqouY4GaJXc8+nsIZnAIMpIFnZDgRYMG4b0qukFhT5uA/LqDiNJVy4R6jvml
 xepyJ0wW8mxxfavRDFR2srZIVtftrM0fFBeGR85ifSUibyT6M4OMhkZ8Z7sSNglO8SfFHVDq3cF2LU
 AgwdoHivc6tghEl5EcZDgraY3bGT+x6z8oXpAo2JINz49IvOvnTsgkQtV65pPQOJxoHLdkP2th80N+
 tUrMiYYEn5+PLyMs2Z9JScjdWBaYpJuD/1oZEbs1lC/Wzzl9bLy3whNjV3jQCv/K2e2syJmbtVzpL9
 O7JhubUvP3L9ACz/nxBwnlIOV8LsJD5ggqcpCykJDWjwfii6i6LgIjvbfGOw==
X-Developer-Key: i=amergnat@baylibre.com; a=openpgp;
 fpr=231B5ED7F3EAAA700E60FE8B2B46499D7E31D445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some Mediatek PMIC devices can manage Power and Home keys (buttons).
This patch enable the driver which handle the 2 keys managed by the
Mediatek PMIC.

Tested-by: Kevin Hilman <khilman@baylibre.com>
Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e4cb65889ae6..4a100f147de4 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -409,6 +409,7 @@ CONFIG_KEYBOARD_GPIO=y
 CONFIG_KEYBOARD_SNVS_PWRKEY=m
 CONFIG_KEYBOARD_IMX_SC_KEY=m
 CONFIG_KEYBOARD_CROS_EC=y
+CONFIG_KEYBOARD_MTK_PMIC=m
 CONFIG_MOUSE_ELAN_I2C=m
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_TOUCHSCREEN_ATMEL_MXT=m

-- 
2.25.1

