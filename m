Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26AC640B9D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbiLBRDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbiLBRDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:03:03 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70956403
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:03:01 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id gu23so12919552ejb.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 09:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KTzGbELlKza/9kwevLALsVHryAN8WDcrHC7w5wg6Na4=;
        b=S1W+HUREYDZKrxoEwQlXVCBdLqkRqdX82DIpktGpRdIUD37IVAzsh6+SFRkd53Gehp
         wrD3D9qdP8ZtQsarb+lyYS+HWHIa9Dc5HCWTWNabZZ4dOINTJeNiBDLfqhVW39NAc5j9
         KwMeED/SfoGbr4LxJhamZkhandaEf2or7m48A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KTzGbELlKza/9kwevLALsVHryAN8WDcrHC7w5wg6Na4=;
        b=3lIlJcMyxX7YwRVOjz6/c5AqAJM1NCUi8Eywe941+rjWOUfuMvQmzVIlu4yr+BaYWy
         XyFpLsz9a9Cq4p7OIN5TdiXWpchI6+WgOAi7aBValasBgNzquj/NFsr1sxUCfG9I5qoh
         EQ7g0V/b+5aArAX07D04hnUC2QBdxe8xzWSxHgTEHuTI3UiNpSeZ45ZQL1ZTFNN1N8Yq
         31bfWj1Bmiz3KXnnbyFKB82592Cti+MKQ86uOpFS2wndm1RrkduRDSeYO4tzHiUB1IQP
         0kyqn7zFyGp0JL7LyjckCZnndr/4RfrpqllR88lB1yGaj/TGd8ZyuxeQD6wUoJNMNhe9
         4sqQ==
X-Gm-Message-State: ANoB5plgv7JMSsuGxlNY83Ns5fulfjkjeOfV+SGXHjTm36RXBZyV7vdK
        xBSu79qTAuGP9pgi1neYAjwVXQ==
X-Google-Smtp-Source: AA0mqf74vRoxIe4aNEmMo2oxp30TopAL+kIpKPU6F86E0C2ECj0n+2PIVpWwNrkTsEScDuTNKHz8aA==
X-Received: by 2002:a17:907:6744:b0:7c0:8d04:d1f1 with SMTP id qm4-20020a170907674400b007c08d04d1f1mr14711050ejc.208.1670000580335;
        Fri, 02 Dec 2022 09:03:00 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id sa22-20020a170906edb600b0073d7ab84375sm3249133ejb.92.2022.12.02.09.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 09:02:59 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 02 Dec 2022 18:02:41 +0100
Subject: [PATCH RESEND v2 1/8] media: uvc: Extend documentation of
 uvc_video_clock_decode()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-hwtimestamp-v2-1-0d7978a817cc@chromium.org>
References: <20220920-resend-hwtimestamp-v2-0-0d7978a817cc@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v2-0-0d7978a817cc@chromium.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     "hn.chen" <hn.chen@sunplusit.com>, linux-media@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1083; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=7/FBms1zVY/y54Npj9F3M2JJkIZ6gxgY9l354aVjRxo=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjii+3/p+J4BSKRQ04UFfbXKbXXmgs+tPfyCpseQQV
 RMSUzwuJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4ovtwAKCRDRN9E+zzrEiDUBD/
 4xijQ+AnWrIOeimoMQ3X5ag4tK54eZT+YleK8V+KtwjkDWV0CKU+NO/1q1gnHw5F6Lo1e8Z1doB/cX
 i/COrdCCXiY5W3bWii+riMj9si4YupbU5L/xZpk9V5aVDrqS0yT5KDdboPm7I20/T5k6HcP/DNgR8p
 DaWbTWQpthqQk8yYnOjqL/7LsWISKFQZ5v5/zoIdnv9qT5iwiWn5owJ2Ba3BBvYZjk46gKVpVhUZqM
 a0bYJKvo7AMpS6coBbYSfsox7ob9+3KihZUyuTpt6xARPteYa8ltiXbY+E91LeI+ECzrklNLQ6Kj38
 HJoIjsqqckzN/bfGY0tgGQsyA+hMudrXFOv1UjSdmP0RkFWUqcV1Nch2rThr21N7bBVut8W1WGuUeI
 dsqk9RIHvb0VYV5jc9HZCV/PLFIZ/jy9JjndXnQ7qRo+86gIfZBJqy9C9U6BgHfKyXis2l5HJa/TQt
 DQKCBYwwFmjLtUqw3dzx7VvFhe5zxl+hXwKLK1fABr8mRkJ0Yo+05a/voyD4WnySlNuewhxAaCDb9n
 XZe992z4le/DZq6Xt+LlrSkkTlqpFm1dJFxEVLw4c5BhODyJhMS39lbJLJkMyx/xqZAn0aKhY9CSTu
 x1cOQTBoFizuVkAGMqGCmCjvN3pdhMgvpd7kZIXlaeOS3VuTwbxU2aMVI/Rg==
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

Make a explicit reference to uvc 1.5, explaining how the algorithm
supports the different behaviour of uvc 1.1 and 1.5.

Tested-by: HungNien Chen <hn.chen@sunplusit.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/usb/uvc/uvc_video.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
index 170a008f4006..ab56e65ca324 100644
--- a/drivers/media/usb/uvc/uvc_video.c
+++ b/drivers/media/usb/uvc/uvc_video.c
@@ -517,6 +517,9 @@ uvc_video_clock_decode(struct uvc_streaming *stream, struct uvc_buffer *buf,
 	/*
 	 * To limit the amount of data, drop SCRs with an SOF identical to the
 	 * previous one.
+	 * This filtering is also needed for supporting UVC 1.5. Where all the
+	 * data packages of the same frame contains the same sof. In that case
+	 * only the first one will match the host_sof.
 	 */
 	dev_sof = get_unaligned_le16(&data[header_size - 2]);
 	if (dev_sof == stream->clock.last_sof)

-- 
2.39.0.rc0.267.gcb52ba06e7-goog-b4-0.11.0-dev-696ae
