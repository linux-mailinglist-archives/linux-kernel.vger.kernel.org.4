Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E288E5BE82C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbiITOKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbiITOJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:09:57 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3FD5FF4C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:09:17 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id sb3so6419292ejb.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=gTdEV0vsY3y0x6LHB6IcVQo9mK20RFAoNv/l6xzHAV8=;
        b=Iko5BaPWfpeumHHO+MrhcmVJI5HXlXLMO/hmCtFvoy0VsaW188D8b+FKtA7qiCmROW
         06ySSV2gLg8IxiMS8+oUwV+hEse3Q8I9Qk92+QwH74j4IRqf1O1rO1SCi4Q9J8I+ojiA
         bVecTVBbgZKzWxvTnGZBCoJplrBAVXx19lJNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=gTdEV0vsY3y0x6LHB6IcVQo9mK20RFAoNv/l6xzHAV8=;
        b=GGBMBmCq4loRUqf9x87Pvo68tia7eRFYbuNlwRF+xW17XzWCafzIqo1dC/XJQ1V54c
         eUpNv7grG2jEVLTHVBSt2EwY64uf9Je7HypcfIUMACoHCUZNUpucirS4GyYveAuYM/iG
         fYW9F9DOW3mltl2KSw5q3VQ5q38qPTf+QWagizmfHKchFBwjn8WD7FQxQhx6rpD1dXpL
         jYUvq4Ume9z68H8uViRJ2fKsnHJoxbjhEkD8SsfNJWYmOyytDrGFq88uzmQNRHf0tCUg
         H+gl3+kisZo1aDBl4ix4KDkoTxz8jVrlaF/gx2vE0VnfBmOUV8JFmAydWIIzEOB3G/z/
         KT7Q==
X-Gm-Message-State: ACrzQf0559+u81Jc5fvU7DcdYuX00vpy8W+hTCzqKSL/2oaQ6waUQ1Mk
        zDLtbnPg/Tz3+2gPOdIK2o3O0g==
X-Google-Smtp-Source: AMsMyM612EXNrWlvaTUjI2w3I3GZsEXDzwNYpHmvhMt/gl6SRK6cCl+ue4dVjejA/nFailUSOEF8Cg==
X-Received: by 2002:a17:907:3d86:b0:780:2e5b:58e0 with SMTP id he6-20020a1709073d8600b007802e5b58e0mr16838888ejc.312.1663682955030;
        Tue, 20 Sep 2022 07:09:15 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:935d:52b0:7461:88e1])
        by smtp.gmail.com with ESMTPSA id l10-20020a1709063d2a00b0077f324979absm927133ejf.67.2022.09.20.07.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:09:14 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 20 Sep 2022 16:09:03 +0200
Subject: [PATCH v1 1/3] media: v4l2-dev.c: Add Meta: to the name of metadata devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-resend-meta-v1-1-dfcfba923204@chromium.org>
References: <20220920-resend-meta-v1-0-dfcfba923204@chromium.org>
In-Reply-To: <20220920-resend-meta-v1-0-dfcfba923204@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1448; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=bV8W+YuXfvWe/X5JvjObDusJi2H14+the+IwKiTlJYE=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjKcmEc8le88r7+R4L1gdXBcnasGlzIeKJq+DbxQXY
 H9c+qdaJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCYynJhAAKCRDRN9E+zzrEiDYGD/
 4yrtVCChIfENsWdbtJGsffgk9tXjfPKCzDVQTo8x+fwjzZtk2kyOEbew1XDF7hBMD8zqEc7Di1fhS6
 MDbwUZESJ/j7G9OjXHXdBnQxOlhkX4f0xXwuxs7bKBH2xfpVoma47cj2sSGRu5WPgh42Pzsm9OfTTd
 i0TvyPN/01zB0xXTaBJ47fBQgLyC9AUCz1EkON1J0rSe8X9VTpP0k6jNGvBQ25l7RzNIa/bZGoZDcI
 yC9DBRlVEbXXOcRtdAZvV4sSEVRv0lNi9lt6SoTWrSqTjKhxAzS1ID4Vloig88MCn/R/oLQ7ujRyyb
 UWZZtOVHKB8M+KdK/mmvE2xmuCNaN/g5BHiCC+93lTy9/9W+p8ufJNOEYbtBVr2bDm61eOXn86a1DO
 LrhulSP2gZzsqWFh0ktpA/COmeFoZ5wgso1kuKPpJ2paxrf/vaOxTcH5/wU6c7P2HFxuk4yFFCfEwx
 BnISymk7Cr1E0gm4CT7qtcUCiZbYiO4MtQ/xIJg2CeNbfvSFRFbarzQbFJFyGrpGdQUmfzTb1Yrlh3
 J/j0GGtV8Z5PD14b8Zhfqgi5kD/aZPqcX7N6M3x8zD/NnKo7l3PNpyAtDAj+SpOivd4xAsFCu9CKKk
 LbM9NMLlZHg0Nyaly8q7zJMCFdamJkXjCi0AuxnSoAKTCg8cDyB42RW8hdrA==
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

Devices with Metadata output (like uvc), create two video devices, one
for the data itself and another one for the metadata.

Add a "Meta: " to the beginning of the device name, as suggested by Mauro,
to avoid having multiple devices with the same name.

Fixes v4l2-compliance:
Media Controller ioctls:
     fail: v4l2-test-media.cpp(205): v2_entity_names_set.find(key) != v2_entity_names_set.end()
   test MEDIA_IOC_G_TOPOLOGY: FAIL
     fail: v4l2-test-media.cpp(394): num_data_links != num_links
   test MEDIA_IOC_ENUM_ENTITIES/LINKS: FAIL

Suggested-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

diff --git a/drivers/media/v4l2-core/v4l2-dev.c b/drivers/media/v4l2-core/v4l2-dev.c
index d00237ee4cae..da97572953af 100644
--- a/drivers/media/v4l2-core/v4l2-dev.c
+++ b/drivers/media/v4l2-core/v4l2-dev.c
@@ -901,6 +901,15 @@ int __video_register_device(struct video_device *vdev,
 	if (WARN_ON(type != VFL_TYPE_SUBDEV && !vdev->device_caps))
 		return -EINVAL;
 
+	/* Add Meta: to metadata device names */
+	if (vdev->device_caps &
+	    (V4L2_CAP_META_CAPTURE | V4L2_CAP_META_OUTPUT)) {
+		char aux[sizeof(vdev->name)];
+
+		snprintf(aux, sizeof(aux), "Meta: %s", vdev->name);
+		strscpy(vdev->name, aux, sizeof(aux));
+	}
+
 	/* v4l2_fh support */
 	spin_lock_init(&vdev->fh_lock);
 	INIT_LIST_HEAD(&vdev->fh_list);

-- 
b4 0.11.0-dev-d93f8
