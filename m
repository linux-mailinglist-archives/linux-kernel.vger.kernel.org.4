Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2539A6C2325
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 21:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjCTUw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 16:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCTUwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:52:25 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E008DBD1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 13:52:21 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id i5so5061245eda.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 13:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679345539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nMkyKaBF1NH7XDsykqLPFfK55LraDVcpYKZcvVEU3WY=;
        b=lOJjKk9zO+FkAD8VnA6Zeq9pRfXsjdkf3kmK68gBqFYSC6fOqduGaFUVSLTXCxxtaE
         sPv2hutFQz6SkUUTM4zvF21hL0XlKpA//LHJV+aGlY9kylMmMrBxoFop6Kz3IAU3V2pT
         XEeHLbIP2l9YyZeFCi7DeBJVzJwsnBS2JixfRp8eYPJSfsWkL4QSqfo06ol5uYNz1hTa
         WVhAzI8/p5CNt/MaW8lro6sqIUaZeweNiKiRHC3enudKBULvDRnMZRJDU+taOrBvRcJk
         JbIB+PMwMH5MLpc2GWqLW5L4baJA7aReNXX/CeGFGTzhsfcVacnw7V0w6Uhloj9WvlQ1
         gG5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679345539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nMkyKaBF1NH7XDsykqLPFfK55LraDVcpYKZcvVEU3WY=;
        b=NT0cqqslx9hm4MiZ55JEMbMWTbTqa3NaqaRWKSL4WJV2v2z5PrpriwVfec/Y3aMh63
         tVmrxD/K4HuwgFVekeYHXEWsXWEz7aJkqlonK4Bgf2NsEQmIlpDM7+qscTg2CR8bJGqP
         FNGEQewKh+5Le9cA3Ttfbz5QJpL/oJhgjvYMTEaiQAwANsTzK2yjOaIDtNQGEYW3ABdj
         7IYey+bjnaHBWshUvW97KeJ+NvqNiDovyecRjQBo3hqtnTnkWEY/a0jbsnk/UrrJDi9R
         32LMlXGa14Of+G9AndwXFqTb38L4Ii6M5d8wdJa4mXnggxUxnSEuwhKJ0L0BVsQZTEEI
         VfcA==
X-Gm-Message-State: AO0yUKVXghGueB5693mZMSNysvVc4BPJebnHwNS3uzOyim6JTqWpRoQ4
        Lb8IinGvKWxgq7v7V+k3Pc/NdGnq348=
X-Google-Smtp-Source: AK7set9G2kN3KW3MddP41mpzya4DIMERV5fuWbVb3zzbOemTkFnyi/mm+7sdjvjl3EL4n5W4ikHN1A==
X-Received: by 2002:a17:906:7e14:b0:928:c92e:d112 with SMTP id e20-20020a1709067e1400b00928c92ed112mr385173ejr.50.1679345539624;
        Mon, 20 Mar 2023 13:52:19 -0700 (PDT)
Received: from alaa-emad.. ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id g7-20020a1709061c8700b0091f5e98abd5sm4881925ejh.133.2023.03.20.13.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 13:52:19 -0700 (PDT)
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     outreachy@lists.linux.dev, parthiban.veerasooran@microchip.com,
        christian.gromm@microchip.com, drv@mailo.com, dave@stgolabs.net,
        yang.lee@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, eng.mennamahmoud.mm@gmail.com,
        Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH v2] staging: most: use inline functions for iface_to_hdm
Date:   Mon, 20 Mar 2023 22:52:07 +0200
Message-Id: <20230320205207.20062-1-eng.mennamahmoud.mm@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Convert `iface_to_hdm` macro into a static inline function.
it is not great to have macro that use `container_of` macro,
because from looking at the definition one cannot tell
what type it applies to.

One can get the same benefit from an efficiency point of view
by making an inline function.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
---
change in v2:
	edit subject line.
---
 drivers/staging/most/dim2/dim2.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/most/dim2/dim2.c b/drivers/staging/most/dim2/dim2.c
index b8bd01ca1f11..21d1c9f24c3d 100644
--- a/drivers/staging/most/dim2/dim2.c
+++ b/drivers/staging/most/dim2/dim2.c
@@ -108,7 +108,10 @@ struct dim2_platform_data {
 	u8 fcnt;
 };
 
-#define iface_to_hdm(iface) container_of(iface, struct dim2_hdm, most_iface)
+static inline struct dim2_hdm *iface_to_hdm(struct most_interface *iface)
+{
+	return container_of(iface, struct dim2_hdm, most_iface);
+}
 
 /* Macro to identify a network status message */
 #define PACKET_IS_NET_INFO(p)  \
-- 
2.34.1

