Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAFE5E5FD5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 12:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiIVK04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 06:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiIVK0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 06:26:54 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BD3B6558
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 03:26:51 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id f193so8742477pgc.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 03:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=xLfLo0ZPeXVxwm2h7aL1qAz2Lkv/DY55+uBYVdnrEtg=;
        b=ZahKk0C60LN/QSh1eQ1torRKog1RnrZ3jPQn2B3NaArxAjGtrZrDt+3aiK/Wk/WN6X
         AhoLXAf2bF775y9BdOX6atK+EnTjnHP0Jh0o4QDw6vbutu56s6iWUmpeOyb8X19a6fTj
         sMiHc0nLWqarZMFs8oS4hNnFnLmlwGlOwXd4ebu5R1zVd8sWep23OFN+xd1cMFMcwNNB
         Tu7QxhsrwxTeGg8h3jKT/maWsu9ApCaADOO7Z8AkGany51Y2F0f+toN7FF9Ale3NuB2S
         PRliUb9O88Bd5WenGet1AiOKJZ7jCQtz4qM0yVjZyhC+oxOHd5TMVtxhA1ERn5qkkIsC
         pyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=xLfLo0ZPeXVxwm2h7aL1qAz2Lkv/DY55+uBYVdnrEtg=;
        b=ani+uJsuYogNLtw8ecfFeSVZBlv+vM8MI96Dlkp1KtOIoIoHzS54BlNqKR3O60HV5Q
         Mz1m1o8J1xIlN5o7P91Sw0z7BsYwmPqBcJdZIWvW+avyqRzSCKnhorbeUJSlrjT0pWGp
         NOv+3a+E/jGc+kSWE25spj/4dXRjeZ/QySg0a6J+Siw6Dv9KAWWHJ0DjoLf7nzs2kieP
         IjtRwJMAJ1UgNvRxvgd3OKLeNh4+eivvhJmNaqmX7QR3KcQlEbvBeUdgGW+fzQvoVDzf
         9cY3oXz9t3HwfoQkPVL6LijLqAe8aH24wgwDUaQFeKKyGrDrWT1LpGucP17FJfRWRYuo
         jV+Q==
X-Gm-Message-State: ACrzQf1yb8krFivsI41KK31c3rIRQ+bJi/WhHWAOug8LvqqzZz9q1VXZ
        /kWrASs4RPNDArScqugm4eOBZ0DNZ9g=
X-Google-Smtp-Source: AMsMyM4nvSAem/EzJLIcx2ZphyvWT/2t5XTIa72rhvUDzYPz27JWfB4zSOVn3dx5EEF5DnmioP+VHw==
X-Received: by 2002:aa7:859a:0:b0:549:e89d:5ead with SMTP id w26-20020aa7859a000000b00549e89d5eadmr3015567pfn.63.1663842410345;
        Thu, 22 Sep 2022 03:26:50 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id i4-20020a17090a718400b002029e3d5cb8sm3416572pjk.34.2022.09.22.03.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 03:26:49 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.panda@zte.com.cn
To:     linux-kernel@vger.kernel.org
Cc:     Xu Panda <xu.panda@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] scripts/extract_xc3028: use absolute path for which
Date:   Thu, 22 Sep 2022 10:26:25 +0000
Message-Id: <20220922102624.236308-1-xu.panda@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Xu Panda <xu.panda@zte.com.cn>

Not using absolute path when invoking which can lead to serious security
issues.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
---
 scripts/extract_xc3028.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/extract_xc3028.pl b/scripts/extract_xc3028.pl
index e1c9af25a595..c9ddcba07550 100755
--- a/scripts/extract_xc3028.pl
+++ b/scripts/extract_xc3028.pl
@@ -29,7 +29,7 @@ sub verify ($$)
        my ($filename, $hash) = @_;
        my ($testhash);

-       if (system("which md5sum > /dev/null 2>&1")) {
+       if (system("/usr/bin/which md5sum > /dev/null 2>&1")) {
                die "This firmware requires the md5sum command - see http://www.gnu.org/software/coreutils/\n";
        }

-- 
2.15.2
