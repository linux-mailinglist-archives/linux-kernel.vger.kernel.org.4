Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245BE6C5C32
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 02:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjCWBhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 21:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjCWBhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 21:37:02 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B814218A9F;
        Wed, 22 Mar 2023 18:37:01 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so460783pjt.5;
        Wed, 22 Mar 2023 18:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679535421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d+nLoNSamCdcaSuM8a5raHPPptoIUI/NpNVM0KOw2DY=;
        b=igo+EYJZj9Np8pmWxTIn1kf2XAEW2zxstGeyuKelxBCvfczgFrvrCzyb+kYTqsyTK9
         p0Fivn8BjAiA58T466deaGhokx2UXFJQDDANtf9WrLVKU7DzP1DZd+2ZpQsqQBbm1+dk
         hCESdEfZ4NEsBAGmRrnW+eZrV946jVwdlm43vgDX9e8qrEoNLT1+mW6cDtCWxYiuU71A
         AQkoVx8zHRZjfyV1G2Zi1QsDdrG1z0Fe6hChGJ8H84GZb+EzxC+n5ASBWnxLAgD628YJ
         +RAWaOpCa6mQFIXfyxrtN2hhtcLxGRsX0fqJS0p6S5hPKsayjWTOi0nH410x2wa0gGIZ
         ZLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679535421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d+nLoNSamCdcaSuM8a5raHPPptoIUI/NpNVM0KOw2DY=;
        b=WWir4/OY10NfzhR3xmArMCroaXkbyLpD7o4AE/bG/Bp0nwqU2JdTcWc/CSfcsJF9JB
         qiHqEJ8YHatxSRmHkAqJjMCftVBcydOhsFAaxo4oFhBaKHlyxXjQQ0p2yvIH7PjldpdY
         73YbSRVaeV4gHNY1W1AKevtZ1JD1UxUS0bsxXgn+3s/ZyQNWgwNGS+SbJVEKbvBnqM2d
         UX4+fQqAETpGnzOJfrQ7r7XbAIsWsmkflkHa1puuBgGxu/NpoWoJGqUaxB1m7BegRtn2
         Ck/In1CX9uzoJcxO32OoKWeisco94PRE83wMi9VrJM8P4O9iQAYS/lXgBXgfu8pB5QFy
         /1zg==
X-Gm-Message-State: AO0yUKUC2sI/CUjwwS3SyWzTUNnOhELkqi9xVykJg/8nhDEqMUcI2F1l
        +QLuBUAa4ZCvGYQEdGEHGH4=
X-Google-Smtp-Source: AK7set8Uogh7PBV2UJKv6iAnGMwOTFkAHfIjqn/Z6asXmPCu4qRi/1TxsnLRD96NHYtfEdj7PVTuwg==
X-Received: by 2002:a05:6a20:89a8:b0:dc:4369:16a4 with SMTP id h40-20020a056a2089a800b000dc436916a4mr945762pzg.19.1679535421067;
        Wed, 22 Mar 2023 18:37:01 -0700 (PDT)
Received: from DESKTOP-HTCHK5O.localdomain ([219.254.222.254])
        by smtp.gmail.com with ESMTPSA id t13-20020a62ea0d000000b005a87d636c70sm10652102pfh.130.2023.03.22.18.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 18:37:00 -0700 (PDT)
From:   Sangsup Lee <k1rh4.lee@gmail.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sangsup lee <k1rh4.lee@gmail.com>
Subject: [PATCH v2] misc: fastrpc: Fix a Use after-free-bug by race condition
Date:   Thu, 23 Mar 2023 10:36:55 +0900
Message-Id: <20230323013655.366-1-k1rh4.lee@gmail.com>
X-Mailer: git-send-email 2.25.1
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

From: Sangsup lee <k1rh4.lee@gmail.com>

This patch adds mutex_lock for fixing an Use-after-free bug.
fastrpc_req_munmap_impl can be called concurrently in multi-threded environments.
The buf which is allocated by list_for_each_safe can be used after another thread frees it.

Signed-off-by: Sangsup lee <k1rh4.lee@gmail.com>
---
 V1 -> V2: moving the locking to ioctl.

 drivers/misc/fastrpc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 93ebd174d848..aa1cf0e9f4ed 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -1901,7 +1901,9 @@ static long fastrpc_device_ioctl(struct file *file, unsigned int cmd,
 		err = fastrpc_req_mmap(fl, argp);
 		break;
 	case FASTRPC_IOCTL_MUNMAP:
+		mutex_lock(&fl->mutex);
 		err = fastrpc_req_munmap(fl, argp);
+		mutex_unlock(&fl->mutex);
 		break;
 	case FASTRPC_IOCTL_MEM_MAP:
 		err = fastrpc_req_mem_map(fl, argp);
-- 
2.25.1

