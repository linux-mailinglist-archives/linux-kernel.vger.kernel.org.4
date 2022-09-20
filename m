Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35E35BE81A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231510AbiITOIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbiITOIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:08:31 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D6F5465D
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:08:29 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id y3so6509709ejc.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date;
        bh=GNRZeqqBofwFFgvrtZo64pHwe4vN8QcPuwanc3P7m18=;
        b=dnl1UAEIow118xOMF3d6RV2uDS3Ampdbfn1MZ3MdrPkxuKps/M901LSwgUR2f7gSnx
         Aqs9MQURHmRNMKI3ptqiA5ssM3VAnUCI2/E+Gqnc9KxiVfJ7pqRU6QsdWr5LYXTyvyVS
         avsZfKcyJwxWSCWuBvLqgXVSUib0DJUHZ5MBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=GNRZeqqBofwFFgvrtZo64pHwe4vN8QcPuwanc3P7m18=;
        b=LMmITFUUC9/bXfDe0l/NuC4+DBl8Pproz1ykPwRK5wcFReNATrsL8LYnw3mtOf0lEs
         02zf0juLXyDOfyZ4EaDCuyi1JszKNPh2LCUs5+IAIeSYR7Xydi8KLwOxXz7d4nfK5gCk
         O2u5pBYG1i+lGjr/eG7gTZ76qJb+OknzgA73+g1/6OGZiNo/lyHLYpRY0v+fwdxcx/0b
         SyT8iMhFJ3xCUz2JRVGB+gs56t/S6dwKe1Wi56fuxlvgaOflxBTpLxMp5Yp0UHONyYqh
         yK082r4zcR7nHxx3GS2zDobDlpbJcq359JLg4z5BC5xpOzsYboDemI6q6gUqqQvxKwv5
         Bsjg==
X-Gm-Message-State: ACrzQf0smpXrRy9cV/mojiIbdlt2Tjh32Aw5KuAJMvik/sH9GeIkruEZ
        etkxRxFnTT2JK2ODKvxZrIc0nw==
X-Google-Smtp-Source: AMsMyM5NcNM0Hllkv6SuG/1QMVy1P2GJGEUX/BF/5aVADEeqmQHmsphKLxgXR1Wte8bFdAGpZWm95A==
X-Received: by 2002:a17:907:3f09:b0:780:330d:d907 with SMTP id hq9-20020a1709073f0900b00780330dd907mr17967603ejc.23.1663682907241;
        Tue, 20 Sep 2022 07:08:27 -0700 (PDT)
Received: from alco.roam.corp.google.com ([2620:0:1059:10:935d:52b0:7461:88e1])
        by smtp.gmail.com with ESMTPSA id j17-20020a17090623f100b0077016f4c6d4sm936564ejg.55.2022.09.20.07.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:08:26 -0700 (PDT)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Tue, 20 Sep 2022 16:08:07 +0200
Subject: [PATCH v1 1/8] media: uvc: Extend documentation of uvc_video_clock_decode()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220920-resend-hwtimestamp-v1-1-e9c14b258404@chromium.org>
References: <20220920-resend-hwtimestamp-v1-0-e9c14b258404@chromium.org>
In-Reply-To: <20220920-resend-hwtimestamp-v1-0-e9c14b258404@chromium.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     "hn.chen" <hn.chen@sunplusit.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
X-Mailer: b4 0.11.0-dev-d93f8
X-Developer-Signature: v=1; a=openpgp-sha256; l=962; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=HA7gMmyIlso0y4JghGpn78Jy/w8ZP1mfGIQm1eY7vlA=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjKclLuC0+GprVRxBvAJv8LhmrYKAks0uKapIO0d7+
 k/bas+eJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCYynJSwAKCRDRN9E+zzrEiK66D/
 0eAwIh96q1kC3kaW1GM7CZDtt98KXc5Fyz2oK4QdJdaRA2/zxVxQ3lnLFw6cvs/XI4nawjYU4prYEt
 b6gYhY7vPvLyoWbigdRjcwSxxj9Bn9B+p34lMimLLV+sTw0MVlDdf84xLmSxeFffg+89JaJl62Cs+o
 Gc3notu6stl92B4UP6bsueh/XsifvFj/EqGYO5crJBUawtuF2CHrJomFRvNfmul72kockWrm12nFSS
 nmga38/SDIz+IyubUOfV1feuhA/VC/Q45Lith1ezwQNgUFCLPcAVJ6hQj+DeWnWL0sJQyV73NwO3yq
 tRgZaHwHz/VjBBQ8IpVB7e38+a4v+mQILoO58jRaT/NYeHqLS9HpA4DoyyrxlCdxw6sFAsi11CZ6GX
 HkwdVX2A7CBgEQGXfjHLsYjWoy0kP/EDlECWDtoCwVx2eWO/gKPopJI7rzY+j2GLPRgqNyPKJHK5zI
 83WXnMdvWu2RgBRsO8BFonmUgEl1Gka2T4/g2l0HgSJTYcHxDLuGX0yDNqDBltuKJIlREgyz6AoeO3
 CptJ/WVpT6rEE04NDCvX5xXe0Ze/zP7C9rHkegbbj7epu7TC+f/n0LglqBG9ousJZTb78lmoOlcqKz
 pPtsHvkicSFlDeD6F/qKk6kCuxYkHQr2CxPb39ALNuFQrcXI7wFXqOAu37rg==
X-Developer-Key: i=ribalda@chromium.org; a=openpgp;
 fpr=9EC3BB66E2FC129A6F90B39556A0D81F9F782DA9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make a explicit reference to uvc 1.5, explaining how the algorithm
supports the different behaviour of uvc 1.1 and 1.5.

Tested-by: hn.chen <hn.chen@sunplusit.com>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

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
b4 0.11.0-dev-d93f8
