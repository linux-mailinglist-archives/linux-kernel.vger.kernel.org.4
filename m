Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADFBE6C133B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 14:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjCTN0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 09:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjCTN0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:26:40 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4767F24BDC;
        Mon, 20 Mar 2023 06:26:38 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r11so46715238edd.5;
        Mon, 20 Mar 2023 06:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679318797;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDfXw8n+plfaogBjIL2pZ2EWfG8n/n4snUHtV8b5Viw=;
        b=TK24hBgvtg6ItCpuhcywrfVa7qGcJHXRiQu+H4BC19kNZKV80fTwXzNZXYs/MGtsSL
         xidhfMRdQ3Ow/iOcTrVtdIRkil7Ie339b+l+4SQepJ89IPiS0i6ZWwGDtIADlUTEjqZ6
         1lnplEniFlBc1neWPlpkXoYwVSG91v+zR7GlmDjH/xe3bsSm40Mxh9cJND0Qc0HlFETe
         KE5zHnaSzvHAKC2WMpPwWKHwBuf2X3LcOV1bkP0d7aiZ2a90r02UbrwOubsO1YuOzz1I
         kLuFJE+OdglrKxyMYRdTVm9VR6QZyz08ShJOTHcTh5GL5koIapzUvqRdQ7yjQVrD0VVB
         9xsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679318797;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDfXw8n+plfaogBjIL2pZ2EWfG8n/n4snUHtV8b5Viw=;
        b=lsxbNWzI2joXD/gnAISqo59Lo437XoVPwhofm+/wqsv4+Ei/wB6a5Madu9veXXspP9
         Lp8joffiRzVBfHEQlq1dWTRpe7RwmaNrAu1zvLI21jDXw78vRMwomgP2Iq1IPvLRXffV
         pCsXQg/lky2AWBEQXu4gyv+M5R3c0bDUxFvXB/vwkER/G8bDoQg2L+6c53pVDkeqkZkY
         1xW5Jkihu7VQGyyJDpjezhbKu69Cd/zLicOTyH5uZVyv1/wl6qIW8ch3FaS+xuBdyhJL
         jijB5GCbOOx5mvxcWPs5ehcTsbUEA9Jtj7iIM9Pmc3FnsHgaqGfY6IJkW3uqJ/IPW8zB
         ZVlw==
X-Gm-Message-State: AO0yUKU9Q7DmlXEXcwhll6nCf8gQgJeLFl0+SHlPwX1Yf480RF/U1bYa
        /zjPwz72tuVuWKZL9VT5VWnzS0dhS6XBQQ==
X-Google-Smtp-Source: AK7set9LYsrc6rSGVPOo2WixyVETc+tPy5GdWlw9Og9E8PmO2dLEFAp0dxhnAFPXzTX++ZwHvPz24g==
X-Received: by 2002:aa7:c1d6:0:b0:4fb:78a0:eac2 with SMTP id d22-20020aa7c1d6000000b004fb78a0eac2mr12517447edp.31.1679318796724;
        Mon, 20 Mar 2023 06:26:36 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:394b:6c53:31d8:7b18])
        by smtp.gmail.com with ESMTPSA id sd24-20020a170906ce3800b00931024e96c5sm4492691ejb.99.2023.03.20.06.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 06:26:36 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] ARM: mediatek: Remove unused configs MACH_MT6592 and MACH_MT6592
Date:   Mon, 20 Mar 2023 14:26:34 +0100
Message-Id: <20230320132634.17331-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit ad8a221e1f49 ("ARM: mediatek: Add config options for mediatek SoCs.")
adds four configs MACH_MT6592, MACH_MT6592, MACH_MT8127 and MACH_MT8127 for
foreseen future use in the MediaTek pinctrl driver. As of now, nine years
after that commit, the configs MACH_MT8127 and MACH_MT8127 are used for
that purpose, but tconfigs MACH_MT6592 and MACH_MT6592 have not been used.

Remove the unused configs MACH_MT6592 and MACH_MT6592.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/arm/mach-mediatek/Kconfig | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-mediatek/Kconfig b/arch/arm/mach-mediatek/Kconfig
index 35a3430c7942..521af13a79d8 100644
--- a/arch/arm/mach-mediatek/Kconfig
+++ b/arch/arm/mach-mediatek/Kconfig
@@ -15,14 +15,6 @@ config MACH_MT2701
 	bool "MediaTek MT2701 SoCs support"
 	default ARCH_MEDIATEK
 
-config MACH_MT6589
-	bool "MediaTek MT6589 SoCs support"
-	default ARCH_MEDIATEK
-
-config MACH_MT6592
-	bool "MediaTek MT6592 SoCs support"
-	default ARCH_MEDIATEK
-
 config MACH_MT7623
 	bool "MediaTek MT7623 SoCs support"
 	default ARCH_MEDIATEK
-- 
2.17.1

