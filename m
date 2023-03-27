Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2184F6CA4FA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 14:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbjC0M5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 08:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbjC0M51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 08:57:27 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB064C1E;
        Mon, 27 Mar 2023 05:56:58 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id g7so5603507pfu.2;
        Mon, 27 Mar 2023 05:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679921801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3Bli4V9RIcx7UIAAcKmOg4gk20edyuK7KxYvBcBo2/s=;
        b=jodiJ0ntyL5ba/T4VD5IGVaQlJRrrRDzihZjn4ZvRBcTojE2v2Ic21kZCH0MD4s8ze
         YH8J0TYa9mOOz8Up855s2k7g5LBgAtpCiG4OIFr2C3RePRp+GHKy+S8VwADG7ffsTNtI
         9BlL3ek+numxs0HIMy9J9tFJ9Ts+71muo/9LvL0pJcD2gOHJCwAfbQUtQd2bFhstafTp
         XQQN4QgLlrOnBzG+weTYs9jjomv5ZNEu+nQd/sTP0f8dSFEDA69O2kjnrWS1w0CL0WDY
         +8mBUGJ/391KeDSAJK+rD+tEN8gMVc0ntQXKVb7xS8KcuBM5BNdQ7n+SERuwKTlsZaF8
         53ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679921801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Bli4V9RIcx7UIAAcKmOg4gk20edyuK7KxYvBcBo2/s=;
        b=DXq72y6DWO24+BIYeRs1YGlot0JqU6LOXT0oQqvg7iDCR7Zos0xWP5wSepZlI/eaz9
         eB4vaBHK2NNnLfEXbd9xnvxPS/Je9m1yFKUidb4tCZeZgacQDOrjTbVViQBMlTu6m9ax
         wnXROAOYRtuOSctwa8oDy+JZRECRMQm4laaAubrUPrM9OGnVOUJ/DzUp6m2ren2EgjOu
         ZLdT6gYvLlSzd0knICut8H9OYzW3ktUiZUA2GNT7ZvhuZDCBV1jTTvlXBBZ9F27Hme8p
         UCGCFJwOSxWeLHroq0aYnBkXqRf434hJFRlBR06DUb727+iYRamxMbzHMcE8gL8va+93
         WEzQ==
X-Gm-Message-State: AAQBX9did6G/eMFyhUgufDDv/S6YDIsWA4JaWv13RWUt83r9g0dJGazZ
        BCfHHo5XF4D2SUEQsmCUC5lMl1YTkuk=
X-Google-Smtp-Source: AKy350Yoyz4kcVvwb/1HTF/W3bhYGDsm8hEwXmFNpmsEJUFltsJpQI9QraUnPyysozLnAEE/38XQvQ==
X-Received: by 2002:a62:184e:0:b0:622:bbad:a2f3 with SMTP id 75-20020a62184e000000b00622bbada2f3mr11231919pfy.9.1679921801491;
        Mon, 27 Mar 2023 05:56:41 -0700 (PDT)
Received: from localhost.localdomain ([175.210.40.96])
        by smtp.gmail.com with ESMTPSA id j11-20020a62e90b000000b005825b8e0540sm1375344pfh.204.2023.03.27.05.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 05:56:41 -0700 (PDT)
From:   Jason Kim <sukbeom.kim@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Kim <sukbeom.kim@gmail.com>
Subject: [PATCH] media: mc-device: remove unnecessary __must_check
Date:   Mon, 27 Mar 2023 20:29:52 +0900
Message-Id: <20230327112952.12287-1-sukbeom.kim@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the file mc-device.c, the function
media_device_register_entity_notify() does not need to have the
__must_check attribute since it returns only a value of 0.
Therefore, we can remove this attribute and change the function's
return type.

Signed-off-by: Jason Kim <sukbeom.kim@gmail.com>
---
 drivers/media/mc/mc-device.c           | 3 +--
 drivers/media/usb/au0828/au0828-core.c | 9 ++-------
 include/media/media-device.h           | 5 ++---
 3 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/media/mc/mc-device.c b/drivers/media/mc/mc-device.c
index 9e56d2ad6b94..0259ffbdcbc2 100644
--- a/drivers/media/mc/mc-device.c
+++ b/drivers/media/mc/mc-device.c
@@ -770,13 +770,12 @@ int __must_check __media_device_register(struct media_device *mdev,
 }
 EXPORT_SYMBOL_GPL(__media_device_register);
 
-int __must_check media_device_register_entity_notify(struct media_device *mdev,
+void media_device_register_entity_notify(struct media_device *mdev,
 					struct media_entity_notify *nptr)
 {
 	mutex_lock(&mdev->graph_mutex);
 	list_add_tail(&nptr->list, &mdev->entity_notify);
 	mutex_unlock(&mdev->graph_mutex);
-	return 0;
 }
 EXPORT_SYMBOL_GPL(media_device_register_entity_notify);
 
diff --git a/drivers/media/usb/au0828/au0828-core.c b/drivers/media/usb/au0828/au0828-core.c
index a8a72d5fbd12..64739f403663 100644
--- a/drivers/media/usb/au0828/au0828-core.c
+++ b/drivers/media/usb/au0828/au0828-core.c
@@ -627,14 +627,9 @@ static int au0828_media_device_register(struct au0828_dev *dev,
 	/* register entity_notify callback */
 	dev->entity_notify.notify_data = (void *) dev;
 	dev->entity_notify.notify = (void *) au0828_media_graph_notify;
-	ret = media_device_register_entity_notify(dev->media_dev,
+	media_device_register_entity_notify(dev->media_dev,
 						  &dev->entity_notify);
-	if (ret) {
-		dev_err(&udev->dev,
-			"Media Device register entity_notify Error: %d\n",
-			ret);
-		return ret;
-	}
+
 	/* set enable_source */
 	mutex_lock(&dev->media_dev->graph_mutex);
 	dev->media_dev->source_priv = (void *) dev;
diff --git a/include/media/media-device.h b/include/media/media-device.h
index 1345e6da688a..5fa89baf9666 100644
--- a/include/media/media-device.h
+++ b/include/media/media-device.h
@@ -373,7 +373,7 @@ void media_device_unregister_entity(struct media_entity *entity);
  *    media_entity_notify callbacks are invoked.
  */
 
-int __must_check media_device_register_entity_notify(struct media_device *mdev,
+void media_device_register_entity_notify(struct media_device *mdev,
 					struct media_entity_notify *nptr);
 
 /**
@@ -453,11 +453,10 @@ static inline int media_device_register_entity(struct media_device *mdev,
 static inline void media_device_unregister_entity(struct media_entity *entity)
 {
 }
-static inline int media_device_register_entity_notify(
+static inline void media_device_register_entity_notify(
 					struct media_device *mdev,
 					struct media_entity_notify *nptr)
 {
-	return 0;
 }
 static inline void media_device_unregister_entity_notify(
 					struct media_device *mdev,
-- 
2.34.1

