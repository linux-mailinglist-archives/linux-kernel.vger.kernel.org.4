Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12CB56813D4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 15:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237879AbjA3Oy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 09:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235737AbjA3OyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 09:54:23 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C2813DCB
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 06:54:22 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id w6-20020a17090ac98600b0022c58cc7a18so6847083pjt.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 06:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+BBqBT0HGvJ5fM5NjJNYKAjnUfe83s3wOG0YkaJDBKo=;
        b=MfO4g0soFD+s9UBY8DGPLOrEAp89kHff56SdYEuwxPkhGljtk60aHGvfmjb8/J0ZFA
         oC7GsyQv+I4CyJSU736PnDEGkBgg+yj5ZkFhxm8g47PxmDJl4RerKDukaXJmz/j05euM
         9pWBT4uD5MonP8YuG1NezefrSbrju11G3o5mGmrV+iiVYELMdpE4l4CQVVILNsACgXiO
         I1T+MrPvGgU+WgaqYOQ7NnqfumUYSRPI7StBY6OXIfTAIO0WAkoKyFb31kEiTGimB+Wb
         SxkVeXVoF3IHl+o9wGyQ4hetA9Sjd4PIDemw7euBaPcM5nZdEVqyh78e4TZdsGFvCqF/
         8ydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+BBqBT0HGvJ5fM5NjJNYKAjnUfe83s3wOG0YkaJDBKo=;
        b=XjMarFVKJQntSzHC2VvL8T12NxaP0TFl64V40T6sb0Pvf4EyfgMvkQH8x58KBU8Z5C
         +Y4Akxs1CMAvhtCoXiJzO7JnElzvAaOlrGmOmHEhfa6a001t6hThFh3okXFb88+fZpUH
         v6+++EZcjB+aNEca8ABvxNkJRt1Fl54hQuel4sLaN08hk0FqaUX1wnk9VrNie0IE5vMW
         kKEAtZ4d1auyXHueo0v6+bKiftX9Eu+smkHkdG+9gVJQAHJz3lPY6rMfobYPeR9lxVEi
         +oTPTUKn9bBKeN9pgHuhPVY7BJK5JWt22BVFMlvtILjk1u2LQ2X+ZlLix/nbcpUnxboZ
         4y1Q==
X-Gm-Message-State: AFqh2kpptaxEpNF47rCDmbTabg0GCMXCxsg1zQ6WKaeD5YyTUTv+kL6M
        yuCFhtNHFK4jhG+uOkJZC1M=
X-Google-Smtp-Source: AMrXdXuDJriVvew8ATjDcfZodcYxnnQsgqzfsHxQxfi1D4k8QTSW533li6h9+jlEJzKIcdBwp6l1Gw==
X-Received: by 2002:a05:6a21:1643:b0:a3:8eb5:6869 with SMTP id no3-20020a056a21164300b000a38eb56869mr43932998pzb.14.1675090462432;
        Mon, 30 Jan 2023 06:54:22 -0800 (PST)
Received: from localhost.localdomain ([112.212.226.173])
        by smtp.gmail.com with ESMTPSA id l13-20020a170902d34d00b00194caf3e975sm7923861plk.208.2023.01.30.06.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 06:54:22 -0800 (PST)
From:   Jongwoo Han <jongwooo.han@gmail.com>
To:     f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        gregkh@linuxfoundation.org, jongwooo.han@gmail.com
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] vc04_services: mmal-vchiq: fix typo in comment
Date:   Mon, 30 Jan 2023 23:54:00 +0900
Message-Id: <20230130145400.40890-1-jongwooo.han@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Signed-off-by: Jongwoo Han <jongwooo.han@gmail.com>
---
 drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
index 294b184d4..e318f3609 100644
--- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
+++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
@@ -245,7 +245,7 @@ static void event_to_host_cb(struct vchiq_mmal_instance *instance,
 /* workqueue scheduled callback
  *
  * we do this because it is important we do not call any other vchiq
- * sync calls from witin the message delivery thread
+ * sync calls from within the message delivery thread
  */
 static void buffer_work_cb(struct work_struct *work)
 {
-- 
2.34.1

