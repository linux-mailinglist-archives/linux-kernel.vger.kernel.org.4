Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630205BE832
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbiITOKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbiITOJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:09:53 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DD26051F
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:09:18 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id go34so6505393ejc.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=R397pNu5OW1HkILIkUc6nGWe9PVD3IFnLlOQRGYZFcI=;
        b=NBMdFpgLA8Okognl7qlVYIM27sOXWyrEdnUq++1OSXrohmtQeJTbxYgy8EzpxJks+s
         3Tf+fpDjzCNJc8B9uzO8zDqpoFXxMwXJMb/j5uHdj7qZ6iGm7nuMdavpHViUvIVH+RpE
         d6VNkKf0+gQrxH2HZP+dlwBX18+GIE7bSh30U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=R397pNu5OW1HkILIkUc6nGWe9PVD3IFnLlOQRGYZFcI=;
        b=wo03TPfwQuGiLd+kklgsbiDtjVYc/11uE9qABWKMjFSgf5AgpPMiP9YrZQ6wJ0CYph
         D2qe6WK9nPF+n4IFXXJOuhwLxqeQLH9YyAMoDWvbMkHnBprrsnzRw73QjN0i4trMTGtn
         Mh04rEWxXOfBGls4Aced12BsJm5Q6vXSuPzCwTwRbSoFpOS2zcznaPfy7mPlK3eqPrPN
         lJQcdCOx5xBVxYIjopBJNbjQUvdAcdlQv1TuaFg9TlmFHr62tnJK6/AYSkIcmmxko7aX
         LbMTMQQhKBj2ArPqAvjJ2I3D+8c8sVDcJkpPkyDN5uljtLPLmMBFUmEZHn+hW8d8936f
         EXbA==
X-Gm-Message-State: ACrzQf1wnILOGhcqnnueEVyWIrG7/gXS7tubqh0kD7kmOyp6o1TYPXXD
        xJZJL5Sa2hlLrxbS2atvD8odHw==
X-Google-Smtp-Source: AMsMyM7Ar/sE/fCWqnil0n3UehAjTzYKB0JCiIZlolnVrjjtrNxGD41fkBtNyZw4fZLjuRzitqjeqw==
X-Received: by 2002:a17:907:9619:b0:77f:6796:dcb9 with SMTP id gb25-20020a170907961900b0077f6796dcb9mr17025174ejc.7.1663682956651;
        Tue, 20 Sep 2022 07:09:16 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:935d:52b0:7461:88e1])
        by smtp.gmail.com with ESMTPSA id l10-20020a1709063d2a00b0077f324979absm927133ejf.67.2022.09.20.07.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:09:16 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 20 Sep 2022 16:09:05 +0200
Subject: [PATCH v1 3/3] media: uvcvideo: Add a unique suffix to camera names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-resend-meta-v1-3-dfcfba923204@chromium.org>
References: <20220920-resend-meta-v1-0-dfcfba923204@chromium.org>
In-Reply-To: <20220920-resend-meta-v1-0-dfcfba923204@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1065; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=LqqKR6cu2xAjH4lzsAYqiGP5U8CacElJsizHM8iayoQ=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjKcmHfWFxkufRfT4VEkNWqqzKR+Klx5MmXKaFPBcu
 Oo/i3LCJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCYynJhwAKCRDRN9E+zzrEiK6XEA
 CD4tmawtJcGv4W0UbQl4Ojt61/WVT2gFa+w++PEFWS6N2DTUSwZQAGLY8TQQ+v5SQb3GtRC7xsdZ8i
 cFhbBMU0BE6VcsO5bpPFI4d/kfVsXPZTVyK73mPp62yM8WEh9lY2g0N59zm4E5pwyULl1beuBp6dF/
 u4OVgnrt4nH84oINZ/JnD0lx2XlCAP/R/zyWSaX2O9iXcVHkSeSzmMzSQPwl9M9aXrN1aHfIJ9wMR9
 0agMcwe31isSDGnpO6eudAzNDSulZbZ01oAUJXmpf7si8fyk0W/N//HLmANdrQca+ACTPc3PPthAYP
 ZZZDaOP8ZitxiHG1YvezyT40ZF8zLjFn5z2rASp412v0vfWLQ4nSyOOy0PpVT4L2JU7pQEbtaQvk57
 Cy+XOv1HrIB3AuXi435x9/iXIMkwJak2I3mC3I0baOt7x3bBt3roZv8XVtNIGjXZCCGBIp98j2Fyhp
 VZK7grqOX4rJD1RFsLUOEO7TjfKzvGJ/HSzrj+MfD/shg6MB7P0rKXRH1EzoFnWquPIZ/36GAoBjdc
 jQvlH5Dz9nl5vRXwJdldWL7Xg3TOz13Thp8Sy+VkTlPDm1P35Bs5+1UTvA6i+9WOnRKLL7EaiXiuKR
 X301i8ijqcAS3hJI0ELwSUbpnC+edkbvFzEG1ytB7720wF7RCGx1Xz5nLCVQ==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some cameras have multiple data inputs (i.e. IR sensor and RGB sensor),
append a unique number to the device name.

Fixes v4l2-compliance:
    Media Controller ioctls:
         fail: v4l2-test-media.cpp(205): v2_entity_names_set.find(key) != v2_entity_names_set.end()
       test MEDIA_IOC_G_TOPOLOGY: FAIL
         fail: v4l2-test-media.cpp(394): num_data_links != num_links
       test MEDIA_IOC_ENUM_ENTITIES/LINKS: FAIL

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
index 9c05776f11d1..0f0e200a345e 100644
--- a/drivers/media/usb/uvc/uvc_driver.c
+++ b/drivers/media/usb/uvc/uvc_driver.c
@@ -2251,7 +2251,8 @@ int uvc_register_video_device(struct uvc_device *dev,
 		break;
 	}
 
-	strscpy(vdev->name, dev->name, sizeof(vdev->name));
+	snprintf(vdev->name, sizeof(vdev->name), "%s %u", dev->name,
+		 stream->header.bTerminalLink);
 
 	/*
 	 * Set the driver data before calling video_register_device, otherwise

-- 
b4 0.11.0-dev-d93f8
