Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B21B16C0EF0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 11:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjCTKea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 06:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjCTKeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 06:34:01 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F38158AC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:33:41 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id b20so11760306edd.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 03:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679308419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tOFujwsyOGt9GhsEE3aCRDS72GxoqdMqe3lDud64Beo=;
        b=Gk7ccBxsShpdxS6FXvhbKAh73kN/5Tc3xOjfDW5oi3gXvHmQbSDk7n6W4LOZKHjIIs
         RBdruB+/XXmxL8QGWThTnPXoNWleXrgIvmXcuRoukPz6GjhBsaxME9Nsbhv0yGbW+J1W
         VR9gIPbUUkwxgL1plZivKsEsrseNozuKDgKbkeOQPAFrXl2YwIP+7MMtOYWdBrqBVt00
         rjxUuiQYbl5kIvBBIThkPi34XQ6D6jbTkUMgTtf4oQWNEpbnFGhtDGW87bLPgN4ADUM6
         HhRCAAoOEHHvlkntmLLIm6nYyac9KQV+EOSxcu0EhkCsGiMzUpwGvdAi83I3o02pe8pD
         LB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679308419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tOFujwsyOGt9GhsEE3aCRDS72GxoqdMqe3lDud64Beo=;
        b=h/tyB+3j4nw++LhY28EU1WK08g/eBhSDEXEakkNotswj8kPhYkorVsNCkvUrKkKxg3
         W2C9ndek7echGb+GYjE6kUeLEZhzywdlmldn0OWcRzd6uspfXDRLm/s1SfszRsqQcnIC
         QCUhxpumF7z0Nt9M3LWPG/iVsHup/AaeJRsAeLankV4DXO4k0rDgEfMHMSEGZHmTd9ET
         KWYlxPLjcOMpBL5IRA0JUI8o9Cpl7vVtIpyFeVwsmvnXwKy10AiIrxlBVURIACpNE1Gn
         oMWLgFRFin1QdhuaWN9NUVO5G0pkLK3Bee1b9iuPZraFGXOlabWwJaorw4Iw18LMsgBP
         jAlg==
X-Gm-Message-State: AO0yUKWdMEA0W41UTta0HPo1mkFSk6WstCJIt6cKFe1CyjwEROULVM4t
        c+Fkb/+rNjUISvs86VaLEjw=
X-Google-Smtp-Source: AK7set9nSQeA7JRgDmJtrT7oBHU1y5S0GSXNbV7CoIzE5A2XY8Zuhoz7zDNsfREy+xLY504f2j3XbA==
X-Received: by 2002:a05:6402:110c:b0:500:4062:99f7 with SMTP id u12-20020a056402110c00b00500406299f7mr11263028edv.32.1679308419433;
        Mon, 20 Mar 2023 03:33:39 -0700 (PDT)
Received: from alaa-emad.. ([41.42.177.251])
        by smtp.gmail.com with ESMTPSA id x92-20020a50bae5000000b004fa19f5ba99sm4687710ede.79.2023.03.20.03.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 03:33:39 -0700 (PDT)
From:   Menna Mahmoud <eng.mennamahmoud.mm@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     outreachy@lists.linux.dev, parthiban.veerasooran@microchip.com,
        christian.gromm@microchip.com, drv@mailo.com, dave@stgolabs.net,
        yang.lee@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, eng.mennamahmoud.mm@gmail.com,
        Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH] staging: most:  use inline functions for iface_to_hdm
Date:   Mon, 20 Mar 2023 12:33:35 +0200
Message-Id: <20230320103335.6479-1-eng.mennamahmoud.mm@gmail.com>
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

