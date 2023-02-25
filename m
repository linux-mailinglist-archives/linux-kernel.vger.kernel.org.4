Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B79E6A28E7
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 11:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjBYKRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 05:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjBYKRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 05:17:15 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11A0231F8;
        Sat, 25 Feb 2023 02:17:11 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id ee7so6994443edb.2;
        Sat, 25 Feb 2023 02:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SNOc3+gSr8ZmR62uYnPdP5co5re0OgpLu9vaZLf178E=;
        b=EiIvBQ4GbWPFzedJeC8giVvUC0oKHukVPsn13/vJOzDFgYuk80Nj1emClZAr1NBI5V
         vBSlUbVdniHkVoWAd7+a5EoAqbIsd/DdcIBm/RkxtLzG7vcANrDA7zMMv3b0WauIMF7Z
         JWSa5UxGl2kTnwB6MBqRpZW2/baw2wscfSiKVTVY+mVtJ1eLbq6oTiJ4CHiYmf1/nGzT
         QmdOrMAPFLOo1/cvrUQ8dwoQ8pGovqfNAR3mOWbYuQB1ACk1EBzGKCJBLBaesFSUvtIs
         C21sBYrpDoKjUqxe2gUfk+Uf7445uuZqw0hyhTwv223q+TDv3Cm9IfY7WTUMwKgaSLwf
         RWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNOc3+gSr8ZmR62uYnPdP5co5re0OgpLu9vaZLf178E=;
        b=L4bpgER1d5aPoNJ+Bxc6tILjdqU5Q/XxhUkjnK8nlINHgqPgJsCAgdF3uOP4xRMvrl
         eSBHBDGb6pdY/TX/t7TARdcqxZKqlK+jt96T3X7YghGYjR9nt42lIfDG/URN4vtHi9j1
         5gis0jzu+aM+rw+ivJW4nnewQ7m9J/MBNa9Lm/w6J5YkV3p/ejvajMish0GxbOv4sPJ4
         pEekbDNmUD8naB5ExwYA+/HXA9dra0nNKv5kssLeGyOYfcAa5dLY23liLPJSt5VBFhrq
         bKbAGpk6YVwPldbtExODunAhStai1Jbx0deJBB/C4OQe7j4GcAnXS6Hy26rGq4nrwP9V
         EuHQ==
X-Gm-Message-State: AO0yUKXivu3Qos2louwvewgJZzHH+W9xUmYYbfNSJg+IkLW0Ge2QiCH+
        ykF5zfBqcMDhbymKHJKt8s0=
X-Google-Smtp-Source: AK7set/K6P2ZaMdb52XoOkvgi1/h1i47RQzA9sBuj1bguB5r7y/Kmiv984/NFZkpd2u9AUu9BAVqTw==
X-Received: by 2002:a05:6402:b04:b0:4ae:f496:10ac with SMTP id bm4-20020a0564020b0400b004aef49610acmr17413203edb.0.1677320230397;
        Sat, 25 Feb 2023 02:17:10 -0800 (PST)
Received: from localhost.localdomain ([95.183.227.97])
        by smtp.gmail.com with ESMTPSA id y23-20020a50ce17000000b004af6163f845sm677722edi.28.2023.02.25.02.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 02:17:10 -0800 (PST)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 1/3] dt-bindings: power: Add bindings for MediaTek MT6735
Date:   Sat, 25 Feb 2023 13:16:27 +0300
Message-Id: <20230225101629.264206-2-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230225101629.264206-1-y.oudjana@protonmail.com>
References: <20230225101629.264206-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
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

From: Yassine Oudjana <y.oudjana@protonmail.com>

Add DT bindings for MediaTek MT6735 SCPSYS.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
---
 include/dt-bindings/power/mediatek,mt6735-scpsys.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 include/dt-bindings/power/mediatek,mt6735-scpsys.h

diff --git a/include/dt-bindings/power/mediatek,mt6735-scpsys.h b/include/dt-bindings/power/mediatek,mt6735-scpsys.h
new file mode 100644
index 000000000000..5124cdee9dc7
--- /dev/null
+++ b/include/dt-bindings/power/mediatek,mt6735-scpsys.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _DT_BINDINGS_POWER_MEDIATEK_MT6735_SCPSYS_H
+#define _DT_BINDINGS_POWER_MEDIATEK_MT6735_SCPSYS_H
+
+#define MT6735_POWER_DOMAIN_MD1		0
+#define MT6735_POWER_DOMAIN_CONN	1
+#define MT6735_POWER_DOMAIN_DIS		2
+#define MT6735_POWER_DOMAIN_MFG		3
+#define MT6735_POWER_DOMAIN_ISP		4
+#define MT6735_POWER_DOMAIN_VDE		5
+#define MT6735_POWER_DOMAIN_VEN		6
+
+#endif
-- 
2.39.2

