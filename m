Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F36064F7D7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 06:53:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiLQFxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 00:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiLQFxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 00:53:41 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EF42AE0A;
        Fri, 16 Dec 2022 21:53:40 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id g7so4437085qts.1;
        Fri, 16 Dec 2022 21:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OoyMtZ1MGVIXMyNe/QVcXhYxTfq6io5cKjfH+n3OcNU=;
        b=freOt5GoyDBFgGQ47nRW7HkafqJAoc96TQbjA/YTOR0bYN6rGGfLM7Z1WmsvwyipeJ
         liitXMJ795PWnmgHWUnPEYYgr+MX1rpmmXzR+quAuvR8xHiUBnJR0VXNQP8zuokmwCAQ
         kLvQ60VeYYhk6ry0ndAELJ5zTjnhquaPod/+1Ydau0dNzeWo3jB/1yjS43iHOMG1t90j
         NfHyuAl7T2FJ8dqOM3OSirVJuhSZbHroQqY1FM0r5zZyrDPFjvf3XSs/DiKt3ZShf6rY
         2qf8VY9syOq6iCSFDf/efXTEgXueEbFOvNEdD5kcNKInZDrNPfm8V87tS77ipJ+r8gbe
         LDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OoyMtZ1MGVIXMyNe/QVcXhYxTfq6io5cKjfH+n3OcNU=;
        b=nyEYvHM4i5+2jzmsInpN6AvK/BMCRJjhd+Dee362qDEUzEkuDZeBwkx3YSNuQ40uS0
         F6MP5Ek//C30CBkI5qGhj+zTDs7jDczVrW31Xw3XRB/9tVrDWLvV7iZkToWfEhIIl9bD
         JKvhgAbiYJG6wf0n+OYbZZMg5sml7hPJf0i2ETwzX4KBQegkH/2VydrXOg0r4z5vPfEM
         caMzCyrUIdgjJXnZVueVa6ouE4F0qzI9XcWMVJ1YxqpETpbrj95RbgQsYGMdl6YXhyua
         nKRgk0M+dTVFgOGasBf5D121ww8uDgIIoqe7pmS89/1IlscYiWvRTc1bpZzwRt94VI/S
         4oyw==
X-Gm-Message-State: ANoB5pkEdiaXcSnX7uqThAOsOZubuO8cEmj1B+RHBAeDnwyrZAGQr7Rz
        ItF2WsNaB3u8k70dbQrezug=
X-Google-Smtp-Source: AA0mqf51MMnu5Rb/Z+CbfvFeSPVpbLSk5Mw+Y+eKQIgm3jpkefzD4AA1Hyl07jbzXzkr2m9XBhmYqA==
X-Received: by 2002:a05:622a:58b:b0:3a5:c8c6:a889 with SMTP id c11-20020a05622a058b00b003a5c8c6a889mr64397721qtb.22.1671256419299;
        Fri, 16 Dec 2022 21:53:39 -0800 (PST)
Received: from Slackware.localdomain ([191.96.227.93])
        by smtp.gmail.com with ESMTPSA id w8-20020a05620a444800b006fc92cf4703sm2980496qkp.132.2022.12.16.21.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 21:53:38 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     masahiroy@kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH V3]  scripts: kconfig: Added static text for search information in help menu
Date:   Sat, 17 Dec 2022 11:21:48 +0530
Message-Id: <20221217055148.28914-1-unixbhaskar@gmail.com>
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

Reconstructed the sentence for the better readability.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
  Changes from V2: Inducted Randy's suggestion to make it more readable.
 scripts/kconfig/mconf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/kconfig/mconf.c b/scripts/kconfig/mconf.c
index 9d3cf510562f..760ebf6c20b1 100644
--- a/scripts/kconfig/mconf.c
+++ b/scripts/kconfig/mconf.c
@@ -161,6 +161,12 @@ static const char mconf_readme[] =
 "(especially with a larger number of unrolled categories) than the\n"
 "default mode.\n"
 "\n"
+
+"Search\n"
+"-------\n"
+"Pressing the forward-slash (/) anywhere brings up a search dialog box.\n"
+"\n"
+
 "Different color themes available\n"
 "--------------------------------\n"
 "It is possible to select different color themes using the variable\n"
--
2.38.1

