Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CADE71348C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 13:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbjE0LvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 07:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjE0LvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 07:51:20 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D54F7
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 04:51:19 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-64d41763796so1361255b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 04:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685188279; x=1687780279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ps7W4euBnPTypuQ48jqWiVzSPldfhUMwv3snwxq59YY=;
        b=AqYl7ViqxvBn8HqG78gKCD/7rKL7HfBq1/pAor38gVc2DQg5wu3paaZGGxS4V7ZXlS
         2jedEA59iAcVm+XTq+abpom59mTFsWn9Faeodygf0CuJjOohBCvIds+IGzzMGs+xVbil
         Z3UNroBt9DysnC6W+qovqNd+CTCvW/e+abPur5uFCWAqnrV4wLz5dLSdyxreUll9Ww/N
         YwSHPevF6IFrhRlMqtXCErTxxkG+KurtaHOuzZCd9sCUKeDncUTIgMgFWoZtxopNwmmw
         8jYDOnkRLvJ4qXiOMrsCF34giu8WNZ2fuGm1QvE5N3/dr+/U1plyjdDbR03S7rAzWeK1
         dC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685188279; x=1687780279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ps7W4euBnPTypuQ48jqWiVzSPldfhUMwv3snwxq59YY=;
        b=iLl4eZniywEnTcTd4kbLmBfczSvnIwpB6f6Aw79hh99vffDud9zSA8wS7ehwyHzrp7
         jq17tn+r+7dOMTE6bdN/H/+RUCtCRk0gj1pQKATnfjPjMd3w8d2RqwAmM+ijq57LP8tW
         OyCI8MuEN6CirxoAhTP7qgKa3+EhPDLAhnU9Iuzsi6cxEqSRpUeoeobit3z/qzIX0mZE
         JG9ngYpkIpyBLX7vYeusDh4YGkTn7WuN1+h9z2vawZHST3RAYIS+YeZMXnoDsloXIHNz
         zx5GBsnBvy0jypzjFSheMEquxeh2XDp0GsRswRXKTVDc+GMsyFXQoVVgWgCTiDZ6G6jZ
         iQVw==
X-Gm-Message-State: AC+VfDzyIjEbM0ihjeB3eb49DJXTYYM6vZtSqJqFeREEPokv+9lP22jn
        e4tT2++10/oy7v4B2lgyskk=
X-Google-Smtp-Source: ACHHUZ5zF+iygF5B/re2qY7V3eQMYr1cqIGaEaq0niqW5MExwb/4oKb4QmWjit3DZrE+2rrXv+iuSg==
X-Received: by 2002:a05:6a20:5493:b0:10e:d90f:35d5 with SMTP id i19-20020a056a20549300b0010ed90f35d5mr2847160pzk.51.1685188278759;
        Sat, 27 May 2023 04:51:18 -0700 (PDT)
Received: from redkillpc.. ([49.207.219.227])
        by smtp.gmail.com with ESMTPSA id x19-20020aa793b3000000b0064f97ff4506sm2988098pff.68.2023.05.27.04.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 May 2023 04:51:18 -0700 (PDT)
From:   Prathu Baronia <prathubaronia2011@gmail.com>
To:     prathubaronia2011@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Khadija Kamran <kamrankhadijadj@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, error27@gmail.com, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, oe-kbuild@lists.linux.dev
Subject: [PATCH v4 3/3] axis-fifo: cleanup space issues with fops struct
Date:   Sat, 27 May 2023 17:21:00 +0530
Message-Id: <20230527115101.47569-3-prathubaronia2011@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230527115101.47569-1-prathubaronia2011@gmail.com>
References: <ZHHE/H2p4Go/Igc/@redkillpc>
 <20230527115101.47569-1-prathubaronia2011@gmail.com>
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

Add required spaces for proper formatting of fops members for better
readability.

Signed-off-by: Prathu Baronia <prathubaronia2011@gmail.com>
---
 drivers/staging/axis-fifo/axis-fifo.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index d71bdc6dd961..59e962467a3d 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -716,11 +716,11 @@ static int axis_fifo_close(struct inode *inod, struct file *f)
 }
 
 static const struct file_operations fops = {
-	.owner = THIS_MODULE,
-	.open = axis_fifo_open,
+	.owner   = THIS_MODULE,
+	.open    = axis_fifo_open,
 	.release = axis_fifo_close,
-	.read = axis_fifo_read,
-	.write = axis_fifo_write
+	.read    = axis_fifo_read,
+	.write   = axis_fifo_write
 };
 
 /* read named property from the device tree */
-- 
2.34.1

