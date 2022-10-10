Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427A25FA67A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 22:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiJJUm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 16:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJJUmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 16:42:54 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D791F63B;
        Mon, 10 Oct 2022 13:42:53 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id bg9-20020a05600c3c8900b003bf249616b0so7035770wmb.3;
        Mon, 10 Oct 2022 13:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u/zjrPM4sNknl8XTBzbDlg/Q+HLxCFkTbmgtCGwYBHk=;
        b=KKPxJv6SV9HsZ09QwvfdK69dFND+G1OUuGsx3d8DvkmsHoRnYmCXmBtpwfghxexejw
         3zlbakUYxmsFTL8eJtOXVSu+OLV7TQzK+M8GAQ55gEs1QBXbi9xQuzNZQjRDXvo8hMPT
         Uji8+tZB8p7YeoFur9A1Lsl4q1UGvp4ISfrs4cCeI/YPG3Av7Rho5AdjnNRFn5K/fbDE
         GjUT2wdPnRLbdAziXIBi90f2gnZXhshOJBFbJ60o33EMIcpclJmJYbq7mkEPj+Cm1ffb
         0BhX+yP4lcIY9TYvmYco22tVNmR0+ismjmmghM2YwvKo6icP6sfplJjpZX8OeCflXXvW
         08Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u/zjrPM4sNknl8XTBzbDlg/Q+HLxCFkTbmgtCGwYBHk=;
        b=QKTsnKVLQWkrXPu7TdBFbTjq3upISmv3Xu7eM+RpYWDKLJLri/wx54WQPZXqifLCY+
         mXZnxJ/arMr6HP6fpndHTMIAZK07zmONypYjRZDV91nBvWrRzJVZi1r6X2ZGhxofpbIy
         1ZXZYaCVYzJscufTA1TLRXsdPC8OfRSAu0fii9fzaAyTO+mYL/zxVvY8XVw425dJ3Gnt
         CCPzOGQT/p/T5azRxOtpXAF/zU37+JVkHzoH8XfOCePs6QUc8Xsh1pQAVhcUC5Isrxxp
         Tqd9uAm/nsvU3O2zpeiUTJ012FZSYY8hIuodAytjA2HSbm0eHn/+Wa4CAkn+HYUz/z23
         Psug==
X-Gm-Message-State: ACrzQf1GnkQaCPzNWkMN5PgPJ2TrB8iReu2D7o/6agoatEQFL7OlSBiL
        VUOaNkUfH0ReTYhR9ZuemHI=
X-Google-Smtp-Source: AMsMyM4CgN/n3mCOI+B/OTAyFkbP5fzJgTOH0iMlwkS8pL3QzoOzJN3XUzGAdPd/RAKwtc5V7Uq7nQ==
X-Received: by 2002:a7b:c01a:0:b0:3b4:a61c:52d1 with SMTP id c26-20020a7bc01a000000b003b4a61c52d1mr14368366wmb.146.1665434572082;
        Mon, 10 Oct 2022 13:42:52 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id d4-20020adffbc4000000b00225307f43fbsm7599775wrs.44.2022.10.10.13.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 13:42:51 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] lib/oid_registry.c: Remove redundant assignment to variable num
Date:   Mon, 10 Oct 2022 21:42:50 +0100
Message-Id: <20221010204250.3223617-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

The variable num is being assigned a value that is never read, it
is being re-assigned a new value in both paths of the following if/else
statement. The assignment is redundant, remove it.

Cleans up clang-scan warning:
warning: Value stored to 'num' is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 lib/oid_registry.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/oid_registry.c b/lib/oid_registry.c
index e592d48b1974..fe6705cfd780 100644
--- a/lib/oid_registry.c
+++ b/lib/oid_registry.c
@@ -146,7 +146,6 @@ int sprint_oid(const void *data, size_t datasize, char *buffer, size_t bufsize)
 	bufsize -= count;
 
 	while (v < end) {
-		num = 0;
 		n = *v++;
 		if (!(n & 0x80)) {
 			num = n;
-- 
2.37.3

