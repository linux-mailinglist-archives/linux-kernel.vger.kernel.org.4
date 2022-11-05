Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5147961DF13
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 23:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiKEWe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 18:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbiKEWe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 18:34:56 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED9B11154;
        Sat,  5 Nov 2022 15:34:54 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id h12so11098835ljg.9;
        Sat, 05 Nov 2022 15:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6CtIVQWP+Kxh/6X4LVIIdMYVxRHCgpX/NmfsfTqOY7k=;
        b=UIPJcAD9s4TdNFm9zVg2P/mZ0ZQlI3XcjxuMV21bO0DdBw8M8wwStfipvihaD7rtzP
         wPxH4DYR2D+cPmO8gtC7VZWSws0s4qrsYx+bX7Ae0OGPG/FsKehC2JrCAxN18j6W7ruK
         We3u1M3asut7zASyfQQCdHGSXNFekALPKrkk4xcxxJU55Tazs+Do521YzUXAUyejbTCZ
         6AGybtRgYLe4i/iftNdP6mWQZweqeuDvOy9nYjHLsGg2vBBqhAyaXRlN+R1TxEDGcVGN
         lYTukvEUbEfVVwrzJyk7Mr8kPoazydoMbe0/zf19ZWVlZH5YleOzwwZ8SusyMZCh2dNV
         tMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6CtIVQWP+Kxh/6X4LVIIdMYVxRHCgpX/NmfsfTqOY7k=;
        b=B59rtbnHfX/BhoRjMhBqWt3pK4q5/6nx0jEtAsap8hrCuRE6kbBpAcBP5nLpAUPU1H
         1kHYQ3xzOlHuzMtv2OWWeJ1wbIYsIWrBd64xrS2l7Ku7F/qpgWUdEeDE2Zh6BV26PLdb
         Xb4ctxf0NPvvvNt5xwPF98e1GjPtgejlS38a+FpHFYGWJVLx/14jfBaqs+SNCBbjQ6T1
         Jzqief3SRJURQYk/IJsKAd+NZD3scfNGNuoamJo23nizIv5170Apo+ydeDHAFNRXvNfV
         3iUefPQ8Go9EvOvwLzF+/XZ0ME+rEXMrgUZX0xxacBiVrHR6vRb9jtghScwrr/IgSi89
         kAjw==
X-Gm-Message-State: ACrzQf0XVMBE1MTooZXnJK9dGvIAp3/vcuNlHcpbIhdM488kCyAjVSNp
        2VnVwJuMdxDlQpjALsoUg9cWqwJ4xyg=
X-Google-Smtp-Source: AMsMyM6BXFpVv8PLWvJZIV2gTYX18Gxsz76ZzOnmTC4d4zkF5p/PE4dhpWDIvZ9P4Zm3JHlPuMbMag==
X-Received: by 2002:a2e:94cf:0:b0:26c:5d14:6ec7 with SMTP id r15-20020a2e94cf000000b0026c5d146ec7mr16455809ljh.237.1667687692019;
        Sat, 05 Nov 2022 15:34:52 -0700 (PDT)
Received: from localhost.localdomain (cl-78-158-27-188.fastlink.lt. [78.158.27.188])
        by smtp.gmail.com with ESMTPSA id a5-20020ac25e65000000b0049a5a59aa68sm447889lfr.10.2022.11.05.15.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 15:34:50 -0700 (PDT)
Received: from jek by localhost.localdomain with local (Exim 4.96)
        (envelope-from <jekhor@gmail.com>)
        id 1orRkX-001kZF-2v;
        Sun, 06 Nov 2022 00:34:49 +0200
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Jiri Kosina <jikos@kernel.org>,
        Yauhen Kharuzhy <jekhor@gmail.com>
Subject: [PATCH] HID: hid-sensor-custom: Allow more than one hinge angle sensor
Date:   Sun,  6 Nov 2022 00:34:22 +0200
Message-Id: <20221105223422.417316-1-jekhor@gmail.com>
X-Mailer: git-send-email 2.38.1
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

Some devices has two sets of accelerometers and the sensor hub exports
two hinge angle 'sensors' based on accelerometer values. To allow more
than one sensor of the same type, use PLATFORM_DEVID_AUTO instead of
PLATFORM_DEVID_NONE when registering platform device for it.

Checked on the Lenovo Yoga Book YB1-X91L tablet.

Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
---
 drivers/hid/hid-sensor-custom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index 32c2306e240d6..a6fc89ee1287c 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -862,7 +862,7 @@ hid_sensor_register_platform_device(struct platform_device *pdev,
 		return ERR_PTR(-ENOMEM);
 
 	custom_pdev = platform_device_register_data(pdev->dev.parent, dev_name,
-						    PLATFORM_DEVID_NONE, hsdev,
+						    PLATFORM_DEVID_AUTO, hsdev,
 						    sizeof(*hsdev));
 	kfree(dev_name);
 	return custom_pdev;
-- 
2.38.1

