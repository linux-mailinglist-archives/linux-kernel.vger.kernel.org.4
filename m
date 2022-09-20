Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8F55BE849
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbiITON0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiITONG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:13:06 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F154260E0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:11:21 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id hy2so2777287ejc.8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:from:to:cc:subject:date;
        bh=bFMsn9IXp+cM8Xxf88ZnEOGeS0ZEgVNFdUByyRlVn/c=;
        b=i8T0IsM040S+4+Q52a3mWpzwMZ1cbf7eY4BLl9gtzcl6GE/Do4yr6d3SUfozzk51tO
         9Q08Yeo+VBgRzG3woUAS2tnNpRcPi7PiZ8ELKwncAIh2wTIoznzbyTdSB5dVn9r81XLP
         uemK6wMlkHTaGKHf5I5srrugFcRkWh34xih2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:date:from:content-transfer-encoding:mime-version
         :subject:x-gm-message-state:from:to:cc:subject:date;
        bh=bFMsn9IXp+cM8Xxf88ZnEOGeS0ZEgVNFdUByyRlVn/c=;
        b=3G6k7KZHMPd6K0Ml0tI7soG1TMiPKYEq/6n8bLVIjNgoDr50hxOFpelK/ZuDY92hlm
         Lu7UXVxvLKQBeREt5rB0tZpo+UvopruGc0WSpJpvl4ybwaHU5f8ChIQVqCHuLeGXecf9
         dH6w116MP1bsvLLlFNIyUvVNJthVwJ3HxBnnxIVb/W4aFUuNq78tjh2u7dY9WFLsY2/P
         SPwGDoExpj2xP/s+iA/ZeKlXKROgsX9J9UbzR0lNtNrL/yaBQvfBhQO/p4QqVLf4B2oQ
         WgLJ1JaHnY5VR8DufIo3Zp+HAh5IoGB1YhGMzBlHXtj6GwkAbn+QIdXOYZY66lZbaWw9
         Z44A==
X-Gm-Message-State: ACrzQf2vbSN+cLxo6B6RBoZM6KI31FqZrPPNhltwtazrbrKkg9swnzQY
        bj1bh7PMH5rlrHa02A5D7FQs2/Qady9H7p+3MxE=
X-Google-Smtp-Source: AMsMyM4Ho6pr29m/1ijxxiBDUN8EVn8puqAJWn8FfcfHS4/YN3iowuqJpfIHpmwvY6K0Mw7NVLpnbA==
X-Received: by 2002:a17:906:5d05:b0:781:be1b:f4cd with SMTP id g5-20020a1709065d0500b00781be1bf4cdmr2849604ejt.408.1663683079606;
        Tue, 20 Sep 2022 07:11:19 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:935d:52b0:7461:88e1])
        by smtp.gmail.com with ESMTPSA id b24-20020aa7c918000000b004518ee90b4dsm129668edt.1.2022.09.20.07.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:11:19 -0700 (PDT)
Subject: [PATCH v1 0/5] [RESEND] Follow-up patches for uvc v4l2-compliance
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-b4-tracking: H4sIAPfJKWMC/w3L0QqDMAxA0V+RPC/QhQ7Z/qZp4wzUOBrmi/jv5vFwuSe4DBWHz3TCkENddws8Hx
 PUtdhXUFsYKBGlNyUc4mINj9wJ6779uhargnlpLHnhNvMLYubigjyirbHbv/frugH+5RqmbQAAAA==
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 20 Sep 2022 16:11:03 +0200
Message-Id: <20220920-resend-v4l2-compliance-v1-0-81364c15229b@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1405; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=vXDfBohc5Z0VLN/PTxvaQLPipSrV30lwRF0Q4M3859Q=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjKcn5LZHNQuM/RYopZSq6YXToyduKFQV3qGvvS3YT
 aXzNBsuJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCYynJ+QAKCRDRN9E+zzrEiK1mD/
 9QTmV8UzAzzAVUsZXTKnnsWkq5xriX5vtZNw0faaE0jftrQcdOpPCcwOS9EsCaD3ZaZ6GC5xSMLT2W
 bBM1bmKdpRkQh0CsVL1Y1wZ+HJti2dgipM6BVGl6Ba3KGsWvF0AqEL4u6Tje+dzvUiolY1rTF9qgdE
 ShWwidg5W7ToHgYGXVBH+G+8J2nuwIpxvvwx2HAg9bAFfg2c12dbNRmN2AzxyCclk7gEdBqJn+MgWN
 +Z36t/T34jFuMBfouUusqV/2i3vr14V5NWzUfMAUgAwEa1EmYZH/xHqwXh+EeXFNvJ0kF3sd1T9uPz
 LkrhEsDcVUN28PoKk1tAvijw5tiMr+fnaYmHWxsdA4MN+9SfO32k4avBIaVqKQJnvGBtEjhhuuigyt
 buDCB9G51jEy1HOFvworDbc4DqaAIjSWVg/2p/ViiNqewvJb7hHA8CmBxPZT0k28G2yt199keT2B9c
 +/yU3JJoSy9t49HcEc0TiTv4l/Dk8u/satoSm1Hzh5yAIyfT7g3RmoxwtW+kdFmLGJkKXvTjze+c/j
 iUytBk+4B3Tnr6ZYyt5lZ8VHl1W3vivVjjPmE52JhJ9L6PeTzKHDG+VGvOuBrb+XCs9BnDf5ws3b3Y
 SsDDcnncERHuO56uxwit+gZqitR/ngtQRONCb3+hv1Kc7LeeBV+dCwFnFPlg==
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

This patchset contains the fixes for the comments on "v10 of Fix
v4l2-compliance errors series". In particular to the patches

-uvcvideo: uvc_ctrl_is_accessible: check for INACTIVE
-uvcvideo: improve error handling in uvc_query_ctrl()

And the patch:
-uvcvideo: Fix handling on Bitmask controls

To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

---
Hans Verkuil (2):
      media: uvcvideo: uvc_ctrl_is_accessible: check for INACTIVE
      media: uvcvideo: improve error logging in uvc_query_ctrl()

Ricardo Ribalda (3):
      media: uvcvideo: Return -EACCES for Wrong state error
      media: uvcvideo: Do not return positive errors in uvc_query_ctrl()
      media: uvcvideo: Fix handling on Bitmask controls

 drivers/media/usb/uvc/uvc_ctrl.c  | 100 +++++++++++++++++++++++++++++++++-----
 drivers/media/usb/uvc/uvc_v4l2.c  |   4 +-
 drivers/media/usb/uvc/uvc_video.c |  15 +++---
 drivers/media/usb/uvc/uvcvideo.h  |   3 +-
 4 files changed, 99 insertions(+), 23 deletions(-)
---
base-commit: 521a547ced6477c54b4b0cc206000406c221b4d6
change-id: 20220920-resend-v4l2-compliance-4fdbe4fbd7b5

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>
