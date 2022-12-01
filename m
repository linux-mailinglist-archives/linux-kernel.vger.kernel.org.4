Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1F163E961
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 06:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiLAFi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 00:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiLAFi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 00:38:57 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E8B6E57D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 21:38:56 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 3-20020a17090a098300b00219041dcbe9so905829pjo.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 21:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oregonstate-edu.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qzd7T7c88aZQcOpjF7mk1g5wAmp98SNe8kgkrI3AbJ0=;
        b=CedsK0vqoJwz3a+jhzg3J8h8zWDk2DCZ7uK/Exfjsb2mwChoCqRBmA9xfSyhlU8LBI
         P5p9gzV3GijCYxamcfjA9HtwH9ydD9QJVwIOOf9iQLHK+6p9kWpnq3CSNXAALX1MUr/u
         xnlN5q3tQVkjnLb8sVb2pquxr9u1ehlXqTAiii42IQrYezYHThzHWKQDhfsvFNBmWA28
         Z6wrzATv5RJeXzI/oZ8CdPm35tO3VYs8wi83Pgn0ueMIpYmg69JtFOWRi7Uj6r3cQwxa
         LJcNI30UPOx976SMtIXgHuewxr9pufXw/iUV6Rlg6QRSuf/QkDdtPo8+vPFQjAXS/ezo
         /VXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qzd7T7c88aZQcOpjF7mk1g5wAmp98SNe8kgkrI3AbJ0=;
        b=F0On65lJaHoFdyhg92DDeJY2zsM7ezYDuXADaEMXNgCkauTSr5sxzEWWngzjVC5E9H
         epHeu17XhB4jrONbvYXt5XG0N2yQwSgUgl1Xy+8CZ5PrmEMZj6YHt20/IhT7az5f8UMB
         FkSpELGvM94/vcRuei5M4THIwhfgnJiTA70d/ttJgkc5lY9d/EeUi3DCWZRUxYcxO/Pf
         lAPDtyIIVRbmiwFj+dwWAli1RF7N/EccCnNVwdk4qggr0Aj+GqLHKaLKgXQUrQAEt7YJ
         yA2iBC1Cw4THLyp25A52SElrFCeRShy2Cofo6kuFBqNMuzF/daN7i4WNNHghOx0wrGM5
         vHjQ==
X-Gm-Message-State: ANoB5pmbNMLBA1nqTVU3fEyTvxWKhrZMAlaG6gujJjeORDDupCz91lY7
        sfBPjw7f3Ha58FkrOgXtpC5maXBf+x8UJcJUNDg=
X-Google-Smtp-Source: AA0mqf5ve22NoC+ei00xHE87/cE+o70Wl9tMVVuhnNNHbKszB3a5kdKZGtJoN+bGghrhf1a7C/Nb2w==
X-Received: by 2002:a17:90a:930f:b0:218:9107:381b with SMTP id p15-20020a17090a930f00b002189107381bmr62438828pjo.75.1669873136401;
        Wed, 30 Nov 2022 21:38:56 -0800 (PST)
Received: from ubu ([76.27.231.73])
        by smtp.gmail.com with ESMTPSA id 17-20020a170902e9d100b0018997f6fc88sm2523547plk.34.2022.11.30.21.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 21:38:56 -0800 (PST)
From:   Jack Schofield <schofija@oregonstate.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Jack Schofield <schofija@oregonstate.edu>
Subject: [PATCH 1/3] staging: greybus: loopback_test: Add blank line after declaration.
Date:   Wed, 30 Nov 2022 21:38:50 -0800
Message-Id: <048967b5c3b157e19ccf4608f71da8418fc31877.1669872193.git.schofija@oregonstate.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1669872193.git.schofija@oregonstate.edu>
References: <cover.1669872193.git.schofija@oregonstate.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Declarations are to be followed by a blank line. Add to follow Linux
Kernel coding style. Issue reported by checkpatch.

Signed-off-by: Jack Schofield <schofija@oregonstate.edu>
---
 drivers/staging/greybus/tools/loopback_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/greybus/tools/loopback_test.c b/drivers/staging/greybus/tools/loopback_test.c
index 4c42e393cd3d..242138c4f6cf 100644
--- a/drivers/staging/greybus/tools/loopback_test.c
+++ b/drivers/staging/greybus/tools/loopback_test.c
@@ -675,6 +675,7 @@ static int open_poll_files(struct loopback_test *t)
 static int close_poll_files(struct loopback_test *t)
 {
 	int i;
+
 	for (i = 0; i < t->poll_count; i++)
 		close(t->fds[i].fd);
 
-- 
2.25.1

