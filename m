Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9DA7461DF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 20:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbjGCSNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 14:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbjGCSNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 14:13:10 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB35E5B;
        Mon,  3 Jul 2023 11:13:09 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-345c1ed760aso26111565ab.1;
        Mon, 03 Jul 2023 11:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688407988; x=1690999988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tmRRo6z0XJwtogTJmOfSjBRBDz+vO2d86DnPaoTj2os=;
        b=N7LftLLzwG4FVV8gMviY4BSuVmH2NBnGjrtgBbKWD7zYoAWyMb7QwJslEfKQUQLbu9
         iniHAJ0Zk22a9thimxyXsSBxGXNjg65+6NGwNR1u1c9UNtBtSfDMBWdHnznK/D5XEWnu
         7+ZdqdQTRMiqHfMUR4L3Yp2glX5KEwWrZ9NaiH4gdJ0Hg4aG3tjVp0VPorbiGX5wP5aF
         NdF/cSK/wT3uwDsgeSm+T3IKtjzdRXENsygoZnWLO/hKPqWhWZZ5SbCwbulWSbipepqD
         gfdZivKdwSJsRr81JE80w+x7ImxLr2iyPXG5ul/IpdIVO5v7iwR8ihrS2ki5/weLD3j/
         8VTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688407988; x=1690999988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tmRRo6z0XJwtogTJmOfSjBRBDz+vO2d86DnPaoTj2os=;
        b=UGIanFBKzXzymUTL52zmHbr7o71M/w+tR8aD5FhxnJCTA0ndjqfCuo6n+DUAbPsnZc
         tLXcQeHNKadOBzFVzk6FQfB8OnnMcSPOa0azGt0PzEd5P1my0IkYOp6OnuSoG3c+E4VU
         euISvDi5v0yy2L6PaH5cv/5HCy2a9rfeTy2nDxGcKdNoMRPhhSmainh1eJ/euZUz9e82
         f2ApXccKBt5g9NiXasPNuWe1e81thOzQWN9AFKV6yMVt9H/kPcsd7cADanNLCxKrRHYH
         X/L289io4ZyxPiMQ74gbaIaTPmt12Vxn014U0fD85gFfz2QpjlDWHtqfEqbegDXkWWkU
         y0kQ==
X-Gm-Message-State: ABy/qLZpHyqDly/xzdU9IK9oVoyPZzYOwzS6MJw7TlKNxErXJHnUjstp
        nxmw9hb3UaWoOpeewwbN+x0=
X-Google-Smtp-Source: APBJJlGlnasrPWopRlCXCRRfFTTSXyyifBfokHy4PV4SWPr4ghDQfwib3FELtUGie/MRK29F5WunCw==
X-Received: by 2002:a92:d7cc:0:b0:345:c1cb:864d with SMTP id g12-20020a92d7cc000000b00345c1cb864dmr10631401ilq.23.1688407988396;
        Mon, 03 Jul 2023 11:13:08 -0700 (PDT)
Received: from azeems-kspp.c.googlers.com.com (54.70.188.35.bc.googleusercontent.com. [35.188.70.54])
        by smtp.gmail.com with ESMTPSA id h2-20020a02c4c2000000b00411bdcdc488sm6276548jaj.173.2023.07.03.11.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 11:13:08 -0700 (PDT)
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Cc:     linux-hardening@vger.kernel.org,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] wifi: mt76: Replace strlcpy with strscpy
Date:   Mon,  3 Jul 2023 18:12:56 +0000
Message-ID: <20230703181256.3712079-1-azeemshaikh38@gmail.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strlcpy() reads the entire source buffer first.
This read may exceed the destination size limit.
This is both inefficient and can lead to linear read
overflows if a source string is not NUL-terminated [1].
In an effort to remove strlcpy() completely [2], replace
strlcpy() here with strscpy().

Direct replacement is safe here since DEV_ASSIGN is only used by
TRACE macros and the return values are ignored.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
[2] https://github.com/KSPP/linux/issues/89

Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615_trace.h | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_trace.h       | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921_trace.h | 2 +-
 drivers/net/wireless/mediatek/mt76/trace.h               | 2 +-
 drivers/net/wireless/mediatek/mt76/usb_trace.h           | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615_trace.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615_trace.h
index d3eb49d83b98..9be5a58a4e6d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615_trace.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615_trace.h
@@ -14,7 +14,7 @@
 
 #define MAXNAME		32
 #define DEV_ENTRY	__array(char, wiphy_name, 32)
-#define DEV_ASSIGN	strlcpy(__entry->wiphy_name,	\
+#define DEV_ASSIGN	strscpy(__entry->wiphy_name,	\
 				wiphy_name(mt76_hw(dev)->wiphy), MAXNAME)
 #define DEV_PR_FMT	"%s"
 #define DEV_PR_ARG	__entry->wiphy_name
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_trace.h b/drivers/net/wireless/mediatek/mt76/mt76x02_trace.h
index 6a98092e996b..11d119cd0f6f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_trace.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_trace.h
@@ -14,7 +14,7 @@
 
 #define MAXNAME		32
 #define DEV_ENTRY	__array(char, wiphy_name, 32)
-#define DEV_ASSIGN	strlcpy(__entry->wiphy_name,	\
+#define DEV_ASSIGN	strscpy(__entry->wiphy_name,	\
 				wiphy_name(mt76_hw(dev)->wiphy), MAXNAME)
 #define DEV_PR_FMT	"%s"
 #define DEV_PR_ARG	__entry->wiphy_name
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921_trace.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921_trace.h
index 9bc4db67f352..887d5cfddd01 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921_trace.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921_trace.h
@@ -14,7 +14,7 @@
 
 #define MAXNAME		32
 #define DEV_ENTRY	__array(char, wiphy_name, 32)
-#define DEV_ASSIGN	strlcpy(__entry->wiphy_name,	\
+#define DEV_ASSIGN	strscpy(__entry->wiphy_name,	\
 				wiphy_name(mt76_hw(dev)->wiphy), MAXNAME)
 #define DEV_PR_FMT	"%s"
 #define DEV_PR_ARG	__entry->wiphy_name
diff --git a/drivers/net/wireless/mediatek/mt76/trace.h b/drivers/net/wireless/mediatek/mt76/trace.h
index c3d0ef8e2890..109a07f9733a 100644
--- a/drivers/net/wireless/mediatek/mt76/trace.h
+++ b/drivers/net/wireless/mediatek/mt76/trace.h
@@ -14,7 +14,7 @@
 
 #define MAXNAME		32
 #define DEV_ENTRY	__array(char, wiphy_name, 32)
-#define DEVICE_ASSIGN	strlcpy(__entry->wiphy_name,	\
+#define DEVICE_ASSIGN	strscpy(__entry->wiphy_name,	\
 				wiphy_name(dev->hw->wiphy), MAXNAME)
 #define DEV_PR_FMT	"%s"
 #define DEV_PR_ARG	__entry->wiphy_name
diff --git a/drivers/net/wireless/mediatek/mt76/usb_trace.h b/drivers/net/wireless/mediatek/mt76/usb_trace.h
index f5ab3215af80..7b261ddb2ac6 100644
--- a/drivers/net/wireless/mediatek/mt76/usb_trace.h
+++ b/drivers/net/wireless/mediatek/mt76/usb_trace.h
@@ -14,7 +14,7 @@
 
 #define MAXNAME		32
 #define DEV_ENTRY	__array(char, wiphy_name, 32)
-#define DEV_ASSIGN	strlcpy(__entry->wiphy_name,	\
+#define DEV_ASSIGN	strscpy(__entry->wiphy_name,	\
 				wiphy_name(dev->hw->wiphy), MAXNAME)
 #define DEV_PR_FMT	"%s "
 #define DEV_PR_ARG	__entry->wiphy_name
-- 
2.41.0.255.g8b1d071c50-goog

