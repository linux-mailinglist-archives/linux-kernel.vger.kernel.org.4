Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF276FC070
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 09:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbjEIH3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 03:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbjEIH3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 03:29:00 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC40210D;
        Tue,  9 May 2023 00:28:58 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-306281edf15so5095545f8f.1;
        Tue, 09 May 2023 00:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683617337; x=1686209337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TZ9NuQkeXU4fNX7iBYzOS07LZkDDq4TEk1a9dRD5OwI=;
        b=WuM5pudY0UqsP46LjTI8WpnLOV8nN2P+Qon8Lyta6Mr/3rEJHnoJBlFaw2vhAL48mC
         voOwJ6181tWnwuyAgPn+V0EcNkd3MlB10CzlY4+tNaxMA9CPFqMnw6SMNvINi0kNQv6y
         6W8X3pRPQIVvakeu2uLtI2s6BU3HO8DiJPiAEop463HKeqCyvLcZJN62f/WaVaygXth7
         1cjk4MGdIUaI//1oY/VbQJOZt9xCOrmv9d4SKI+3TNdbVhxp/ggghajkFa6JQ7tSoFAr
         9XYYZD6x8VaM8aDOAe8spO1er3riawEbhfroBAABSo2eeG1gyholwPqAXNv+aRJk3AGD
         BUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683617337; x=1686209337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TZ9NuQkeXU4fNX7iBYzOS07LZkDDq4TEk1a9dRD5OwI=;
        b=WKpNW4hrCKWBPG5NEC4httV1kC588Yc3P1YClQqjsAS4I8p4G2L4ZutaQ44H4vJkac
         dDFXUlSJYE2sRXelGzYP0QhSdsSU0RGgeDaNZdXMM0i52ar2c8tdxnw9ipy8/9PJygAq
         MK3vzhbo8d2IJvws37AOos4Pv8Di1174tPnSE4XfmzyP7jaqVGhP3I0kAUJq53/RHfoO
         HilJAa4KYaoUmz1fEXhJodu8VKNLV/DScEZjXfSMuRt0/I0ARMYURm2zXLDs1cJkHVNt
         XZZCp8Us6/HjdvO81rMluFQ9h2qWtoQRvtmkJaFe0GvxKHW6AaAvyDMkLIr7nUF9fBZ5
         jMUw==
X-Gm-Message-State: AC+VfDzGwibD5L7NBjvZGErus+EN/qMwBtlqB9ccCibWHOn42uv6LwvQ
        CB8DaB/+C6GpLmn0t7hxEfQgFFfPmHI=
X-Google-Smtp-Source: ACHHUZ4aprA8jaV+02OALul3CdrPdHuejsbTRnfgW+TaIxH+q45taetODg6awx4MtB1jJAj852Yabg==
X-Received: by 2002:a05:6000:c1:b0:307:9473:fe26 with SMTP id q1-20020a05600000c100b003079473fe26mr4379251wrx.26.1683617337199;
        Tue, 09 May 2023 00:28:57 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id t9-20020a7bc3c9000000b003f1958eeadcsm784243wmj.17.2023.05.09.00.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 00:28:56 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] fs/ntfs3: Fix spelling mistake "recommened" -> "recommended"
Date:   Tue,  9 May 2023 08:28:55 +0100
Message-Id: <20230509072855.2908731-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in a ntfs_info message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/ntfs3/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index e36769eac7de..8323911fe274 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -1191,7 +1191,7 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	sbi->volume.ni = ni;
 	if (info->flags & VOLUME_FLAG_DIRTY) {
 		sbi->volume.real_dirty = true;
-		ntfs_info(sb, "It is recommened to use chkdsk.");
+		ntfs_info(sb, "It is recommended to use chkdsk.");
 	}
 
 	/* Load $MFTMirr to estimate recs_mirr. */
-- 
2.30.2

