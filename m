Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C23966D1BC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 23:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjAPWXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 17:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjAPWXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 17:23:00 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755039EDC
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 14:22:59 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id kt14so12271908ejc.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 14:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:signed-off-by:description:mime-version
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YgDWNeE96SrbLbTQHlbYU4O20crViR5uokOI2E0+L5o=;
        b=emOmAKxJNNYM6w58Loqc05/Eyvsg+VqCtKwjheNLhur/lHMQ8bEehXI/BzJA9HJtUZ
         X9Q3wUH/F3zyMUq+S2cUTRrSXIrvya+Xeyo3B5zmnbyvUQsm4r7sg0TvzYAV8ZtiV1LC
         oV17lnEFtmcmPMCanhs90pmLtZr9VehynvkJEFT3v//bh8BsbKHUrgBbIVMIUFZWMlAl
         mfkR6iuQy2WIKIh3xW95ugbXO+Kynp9vgSeCFd0lxAvq2oVmvGShIdTKV6H2zQtcxhfR
         5PDDOAuN6TsleASqVu6uUqbMcW+eKbAh50EqEyFBqZAW3g54nOCCC40Wus1LrWfGxon8
         LhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:signed-off-by:description:mime-version
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgDWNeE96SrbLbTQHlbYU4O20crViR5uokOI2E0+L5o=;
        b=PuGknIyYnlb4y7Db8y/Zm+rZ0pOS/RLrD6PTWcYHH/vt+a1Viop/YFnR1wlMz4pyzX
         Sv7zicxhg8ABAYpzXAXPnvsMHwEAdVc17pzhjLIqylEmBea1uTvEq4olpW+JENIGl9CQ
         Ns78TIkpmGA+ddIpfCHP6KMkbu1UpiEqrPvVnWvAseMJVTuRj3H+uAJPrGawrRb2kNs7
         1JJH4KwrC3MydPrdAlphIgC/6WemmEn4z9+Te948pXLWUpBi9h660a11/xmF3Jq3ejeL
         P/brw/nBHpEPlhM7/qK1NxLWTGh0oM2wVtbUEM7RdFnWuh9tS5ljB94z0yfbn+D6xREq
         fqlQ==
X-Gm-Message-State: AFqh2korEM8rlSvnIp3eBVRIT7rar6o6BNrcp3sYFycdC7OSTle/hZ/t
        I6FxA+A848zYlSytV5TAiNc3/7kEN6g=
X-Google-Smtp-Source: AMrXdXtzT4/FofDI1qPMJ3YvAKLR1AZC3nXT+1yJyfHHmJvzWKiq3J08pzryQO3rf/eAyqDwnxYl1w==
X-Received: by 2002:a17:907:c08c:b0:870:3c70:8c8d with SMTP id st12-20020a170907c08c00b008703c708c8dmr5883612ejc.17.1673907777838;
        Mon, 16 Jan 2023 14:22:57 -0800 (PST)
Received: from Semens-MBP.fritz.box (84-87-100-184.fixed.kpn.net. [84.87.100.184])
        by smtp.gmail.com with ESMTPSA id la17-20020a170907781100b0084d3f3f9984sm10597281ejc.114.2023.01.16.14.22.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Jan 2023 14:22:57 -0800 (PST)
From:   Semen Zhydenko <semen.zhydenko@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Semen Zhydenko <semen.zhydenko@gmail.com>
Subject: [PATCH] Fixed typo in comments
Date:   Mon, 16 Jan 2023 23:22:54 +0100
Message-Id: <20230116222254.74479-1-semen.zhydenko@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
MIME-Version: 1.0
Description: Fixed typo: aquisition -> acquisition
Signed-off-by: Semen Zhydenko <semen.zhydenko@gmail.com>
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

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 63a8ce7177dd..6430c00b05a9 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1324,7 +1324,7 @@ static int __timer_delete(struct timer_list *timer, bool shutdown)
 	 * If @shutdown is set then the lock has to be taken whether the
 	 * timer is pending or not to protect against a concurrent rearm
 	 * which might hit between the lockless pending check and the lock
-	 * aquisition. By taking the lock it is ensured that such a newly
+	 * acquisition. By taking the lock it is ensured that such a newly
 	 * enqueued timer is dequeued and cannot end up with
 	 * timer->function == NULL in the expiry code.
 	 *
-- 
2.37.1 (Apple Git-137.1)

