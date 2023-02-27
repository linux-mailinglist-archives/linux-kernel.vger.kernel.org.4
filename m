Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889A76A4C19
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 21:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbjB0UP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 15:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjB0UPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 15:15:53 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FCE9222F8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 12:15:51 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id q16so7531516wrw.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 12:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yHMEHKILiiMNAn32hEbqUJ6Nz+hg+0h7JBpl+fv8vVY=;
        b=SW0NupvsCXRK7Q09FsqxGaTq8+CZFzc2wHglM6UE8DHafFDsgn9qct7O3hkit2Jz5X
         GJUKLyursl3y06qghY8OssX8koEiEP9ACgqbaC8dTDwvM2saKkLhSlP6eCXGw2vN1Afb
         fynrqjdTd/+Av4vI59VYOWpi7bXq9akWwN8cnEXxNJ+0QfcxXdqUVo3HGWHFdKOPLJTC
         Vp8pw9qMGh3npKzrR5oP1bnyFh2cKciajF747h6H0JPdzyVSHQbdnjEph3u1QSrYmyrF
         2LZEBEjCT66EXJZzk+0hSw7CTaEmzNgHkkRiJPrqdBkJu0YH+8a/uU3iEExg95z68LrA
         7gBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yHMEHKILiiMNAn32hEbqUJ6Nz+hg+0h7JBpl+fv8vVY=;
        b=LS3BH+enzDfdJ/HVxOlbyhVwJJfcXO1Tt7y+SfilPQQXmPBwjlQWmXfkEkSfLBKl3l
         Teh2NOo5pi1DG1WwMDDWDvK12KvvHiPN4jhRKuQLkuSy2+62OzwygM+sI9n4k4MGt4iw
         i7LcWjaFU2I6WIK21s6GoL24HXaPGtaiBI855ZQ0EcnZfzr5+A4Oh54SCEQgogMRW71u
         de4N6Dm/7mhthX2JdYT07x+xjEJoUf5L6GY1kg7zx04L4yC9/kQtsC9W3xaZoJ1f/e2G
         MlGlHnbwjTHmecJXjJjoIivvbnwa1S+UVY0JWpuLo5KrDV9D1FJH68JIJUQHz1uKPDr3
         RZ7Q==
X-Gm-Message-State: AO0yUKXIQEnKXr0taVcw4Gymz+soXHSCo2tSSK7q4L0kSRD3svvrXcW9
        SgccfFPEfVc8FrHs/sUmfnk=
X-Google-Smtp-Source: AK7set/a5AOhsTiiLLeagKqNQ5jYs5mkw5VKY53jbTpum2lA/CXvN3SNGLGhGzAvvLTcrDqrnvkU2w==
X-Received: by 2002:a5d:564c:0:b0:2c9:1542:ffdb with SMTP id j12-20020a5d564c000000b002c91542ffdbmr277272wrw.66.1677528949358;
        Mon, 27 Feb 2023 12:15:49 -0800 (PST)
Received: from ducanhle-OMEN-16n0.home (2a01cb058424d400651762a3c5a0ed78.ipv6.abo.wanadoo.fr. [2a01:cb05:8424:d400:6517:62a3:c5a0:ed78])
        by smtp.gmail.com with ESMTPSA id t3-20020a5d49c3000000b002c5804b6afasm8137384wrs.67.2023.02.27.12.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 12:15:48 -0800 (PST)
From:   Duc Anh Le <lub.the.studio@gmail.com>
To:     broonie@kernel.org
Cc:     linux-kernel@vger.kernel.org, Duc Anh Le <lub.the.studio@gmail.com>
Subject: [PATCH] Add HP OMEN 16-n0xxx into DMI table
Date:   Mon, 27 Feb 2023 21:12:50 +0100
Message-Id: <20230227201250.5752-1-lub.the.studio@gmail.com>
X-Mailer: git-send-email 2.37.2
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

---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 36314753923b..baad3bce3b7c 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -255,6 +255,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "15NBC1011"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8A43"),
+		}
+	},
 	{}
 };
 
-- 
2.37.2

