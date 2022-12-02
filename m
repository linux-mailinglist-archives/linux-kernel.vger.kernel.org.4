Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D645D640BC6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 18:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbiLBRIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 12:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbiLBRIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 12:08:34 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFB1D11FD
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 09:08:31 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id b2so12988357eja.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 09:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TCQ9M8MyOEnK5pTEhdeO3mymMoTWGn8RzIavHlNHD6M=;
        b=R/oMM0lWUbfpFHh0O9/+DBNeQs4nbkDIDSrNwITxX3+i2Myafv0d25iU65xGMgf4IW
         XKMysLO0P36sYbZ+nT5P+83p3R96mmLyFvA9BKQ5cmt16CFcazjSE3qiUF2E4Nv6vZos
         HxqQPrOoyOiv43k+qZMxhGjrFKrW92au0ZVYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCQ9M8MyOEnK5pTEhdeO3mymMoTWGn8RzIavHlNHD6M=;
        b=4N2uYmzBeAsOKaxrHs8B5dynsQsf7/ubBCDyWgXA0cZgk8Mdt9nQZR4ACaQlIwvW7B
         HsntTiXbEdqySj9qVPXyw3c4SQGOFEculveyPIy27kayU3mOtrQtSafUqezFKlKfzThy
         yLT5+qiNbpv7+s3qdhyVwvycWHpmok/CnygE+V3lo5kkmXOnFUsaQgTQKKsDhaGTMPc5
         ebFswj1AN3xomeaS8BKo7D/TcRpefWNamK10cG5rVPRsIgob0ItAWLLrp9ZnAJ+o34ur
         yDXHzpP+ULZLwdcmHjvMCyfUWm3dBodMRCunuXTb3lrapkSrQWMdl4fndvWO70DXPRRU
         GsFQ==
X-Gm-Message-State: ANoB5pn62pNgWjfBA/wwWCeUwYKF3Dy3+kIPbkFCYGy2HDZ/ga76fRHY
        mCiqbgKEPz+7us3lSm+91/gCTA==
X-Google-Smtp-Source: AA0mqf5qFfbKizkTww9gVuZZ6Lx0NduaYRmhqu+8NUTsfvjbqXxLawqkwYIEziC8u0/Af27zMXSlkA==
X-Received: by 2002:a17:907:77ce:b0:7c0:8225:54d with SMTP id kz14-20020a17090777ce00b007c08225054dmr16814628ejc.286.1670000910178;
        Fri, 02 Dec 2022 09:08:30 -0800 (PST)
Received: from alco.roam.corp.google.com (80.71.134.83.ipv4.parknet.dk. [80.71.134.83])
        by smtp.gmail.com with ESMTPSA id p23-20020aa7d317000000b00461cdda400esm3168080edq.4.2022.12.02.09.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 09:08:29 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Fri, 02 Dec 2022 18:08:18 +0100
Subject: [PATCH v4 2/3] media: Documentation/driver-api: Document device name
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20220920-resend-meta-v4-2-3ac355b66723@chromium.org>
References: <20220920-resend-meta-v4-0-3ac355b66723@chromium.org>
In-Reply-To: <20220920-resend-meta-v4-0-3ac355b66723@chromium.org>
To:     Yunke Cao <yunkec@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.11.0-dev-696ae
X-Developer-Signature: v=1; a=openpgp-sha256; l=1173; i=ribalda@chromium.org;
 h=from:subject:message-id; bh=SfUbFly0L3KPaCuRZ5w00Du+lIHrvLRHPtWI2RZZpxM=;
 b=owEBbQKS/ZANAwAKAdE30T7POsSIAcsmYgBjijEJTiEOmUITGiLvUCgkbCs81Q810EX+dXH3NyaT
 mXwvuGGJAjMEAAEKAB0WIQREDzjr+/4oCDLSsx7RN9E+zzrEiAUCY4oxCQAKCRDRN9E+zzrEiH+6D/
 4yIlInPaIUb3c4STKRJvD4EWozBosI6T/1nKVk3G6TFxnh9oizy6AXNbJLZrwtOJpKqkj9Ks5ICQ6B
 lqFTWpjvhnfKcrVV0ToMygkwju67mqgUSm6PfTUhWhLbxk25i6+luvVtnkJfunw6W46/rU+9YNFs5c
 w08uwPEckBTM6bciZkTrY7F27fpe6Hf7nW6J/a6gScSnQh7es6pdBrK/xAncOGTE9+SsQJPVvu0LvO
 tDVnhPz1aV+BYYUCLE+Es/rJcGVBnxw+a+kZXQDqKQBCq2h6m1yThavXXHOh061luADcr0d6wHaIgY
 g8OoMWu9bnT2QQmADG4cmgTDcM1OfBDXZhDzD/CCuCUEAhiqVYAOB/urPfyIfrFHq8jPhgVv3ws1T6
 FPTJj7yvCgHG2tL4oSTVRFX46NiEm/311whLXSBchnQ0zg8VS3paWWhJy5/G/l6lE8tf7yZ37kmf12
 6kTAd5Q/WHYXdblAs3uFZs1+Z9NN0VNNJGVmek4sEyv9IrDtAopL2DqRjTxlY8iY8rHsD1hdag7ssg
 +K+3ZLlfdwsRZyQtHdf1KwYxZrqRzq4wfL1u+Ds+hs5IkmIAlCWQFJyB9chP271obMkui7lUoKlJe+
 XehpqL57Kfg8oqOuCmImjeMkOVT8RdJWrmv7yMKLImBs+fvBpOT0Oe6kH62w==
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

Document how the name of the metadata devices is modified.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 Documentation/driver-api/media/v4l2-dev.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/driver-api/media/v4l2-dev.rst b/Documentation/driver-api/media/v4l2-dev.rst
index 99e3b5fa7444..935a46e29c5e 100644
--- a/Documentation/driver-api/media/v4l2-dev.rst
+++ b/Documentation/driver-api/media/v4l2-dev.rst
@@ -42,7 +42,9 @@ You should also set these fields of :c:type:`video_device`:
 - :c:type:`video_device`->v4l2_dev: must be set to the :c:type:`v4l2_device`
   parent device.
 
-- :c:type:`video_device`->name: set to something descriptive and unique.
+- :c:type:`video_device`->name: set to something descriptive and unique. If the
+  device has the `V4L2_CAP_META_CAPTURE` or `V4L2_CAP_META_OUTPUT` capabilities,
+  the string `Meta:` will be inserted before the original name.
 
 - :c:type:`video_device`->vfl_dir: set this to ``VFL_DIR_RX`` for capture
   devices (``VFL_DIR_RX`` has value 0, so this is normally already the

-- 
2.39.0.rc0.267.gcb52ba06e7-goog-b4-0.11.0-dev-696ae
