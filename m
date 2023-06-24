Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FFC73CBF6
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 19:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjFXRIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 13:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFXRId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 13:08:33 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4975F1A4;
        Sat, 24 Jun 2023 10:08:32 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5705386cfa3so1082667b3.1;
        Sat, 24 Jun 2023 10:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687626511; x=1690218511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L67IGZMeFq5syFvEsERJ4iNX2S9oc5dwGEC3VfRdfUA=;
        b=mrIHvbvRgw28TdwdnedIVAvp0PRHSEWCItaBIAHwRPWtGb44akoAMpDBDzcsqN1Vy4
         eNIE+UgJoTaVImXcnnHjbci5d/4pfjJJm+mNug6BqmX+WePPHmDQ2j5AFMSOSo5d99iQ
         J5t55nGC3akSvaSS0t5cvd5nNWv5ZYFVZP7R82/WEvzSZZU2nUTU8sZPpm/SKOD/Bw30
         +GTzii0JROvF3xYJ9Cu/L4Nd29VkYWsV+YmVfuSySKalWEU1Vis1NMJqrUUfQsArM2IZ
         ZJ1SXTEWhne/yNojsRxOKp/cXHs/aDvhv3hPK10LviAjfBMJIp0JQFKb99SN+e2rrv66
         zpPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687626511; x=1690218511;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L67IGZMeFq5syFvEsERJ4iNX2S9oc5dwGEC3VfRdfUA=;
        b=MLeYybazocIgr+chGoHTmpNZi+6jQwDeWHQU46lZ/zrwjCv/IlWCh7f9VhqnCcozNr
         lGKWJD4sskjlC1CfbbWCC2budGu70eB7EuIzrojhXzhSVgGL9KUHSwXv2F0C4lPAGxE7
         UIaxO/F02Pd2Ic/2EV4mnJ9HawPbBzuLz5yfpyYr2lowkgTLEC2EJdTDSNj1fqZZMzMh
         F6hbNP6tCzwA0WwkrMbXRLP7xVuXP7t3Kwj+j+4LeoAj/A9XQxfzHpfL314JHjb5Ki/z
         XsWRHXNzsE9e1Abwa4CM471sFyM0PDiICyFDnWHquf87JOTJ8zDLQkFWD3fgLCruJzpU
         rKXA==
X-Gm-Message-State: AC+VfDzstQ8mw6t5v6SZC5n+aFu8aM4HxQh7tQtW5CcghBToImCwUAhI
        3BThN6cg5N1m/Od4vcKK2Qo=
X-Google-Smtp-Source: ACHHUZ7BV+fWrIAgQhDxV9DPUEAaSr3Eao2EvYsYEk1Hrw3c07VuB7rF4BaNNOboIfJe8mxLyWDpSA==
X-Received: by 2002:a81:9a17:0:b0:569:322b:d067 with SMTP id r23-20020a819a17000000b00569322bd067mr13854203ywg.4.1687626511329;
        Sat, 24 Jun 2023 10:08:31 -0700 (PDT)
Received: from localhost.localdomain ([173.23.87.62])
        by smtp.gmail.com with ESMTPSA id l67-20020a819446000000b0057031fa8c08sm423110ywg.14.2023.06.24.10.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 10:08:30 -0700 (PDT)
From:   Matthew Anderson <ruinairas1992@gmail.com>
To:     marcel@holtmann.org
Cc:     johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Anderson <ruinairas1992@gmail.com>
Subject: [PATCH] Bluetooth: btusb: Add MT7922 bluetooth ID for the Asus Ally
Date:   Sat, 24 Jun 2023 12:08:10 -0500
Message-ID: <20230624170810.298776-1-ruinairas1992@gmail.com>
X-Mailer: git-send-email 2.41.0
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

Adding the device ID from the Asus Ally gets the bluetooth working
on the device.

Signed-off-by: Matthew Anderson <ruinairas1992@gmail.com>
---
 drivers/bluetooth/btusb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 2a8e2bb038f5..7427da184fe0 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -613,6 +613,9 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0489, 0xe0d9), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
+	{ USB_DEVICE(0x0489, 0xe0f5), .driver_info = BTUSB_MEDIATEK |
+						     BTUSB_WIDEBAND_SPEECH |
+						     BTUSB_VALID_LE_STATES },
 	{ USB_DEVICE(0x13d3, 0x3568), .driver_info = BTUSB_MEDIATEK |
 						     BTUSB_WIDEBAND_SPEECH |
 						     BTUSB_VALID_LE_STATES },
-- 
2.41.0

