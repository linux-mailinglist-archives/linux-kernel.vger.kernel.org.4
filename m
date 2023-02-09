Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C2568FFAD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 06:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjBIFMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 00:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjBIFMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 00:12:16 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894352B298
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 21:12:15 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id w5so1645777plg.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 21:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/zmyB5ed7X1QuJ3E3Pi4MYoQa0o5KmmlWf5Y2v7TIw=;
        b=KoxOwAfB2evDlwQdC43RR3+cvwXl+CsNC6c5ASdcFA88hHBZAb2JGL+SUEr6MwRZA1
         gkVsEeNFr6rOHIeNcjL6Jy3Ego+8VfORmEsufcLyu+D9q2bI4JWAr8PxVRj3DW47eTWn
         H2Ju4G8oDpPmZhXBDmDLA1F0+Mtv8OlMt8xyJhl5VK28btX6Wb+kb3lU8FdEDB6G1DKu
         /qN5wTdBUkJT7qezEklgq2kCqkmqu3inMC41/FfVPEP5jD9KRf3jYWAqJiSRtlwWQ4cO
         abq6xWHJqq2U5WEiVoZsS+A3ZGM+DU+xKP3L0O4nGlz+4mXpKfy4UWFksWXYdjcvGfFA
         mU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/zmyB5ed7X1QuJ3E3Pi4MYoQa0o5KmmlWf5Y2v7TIw=;
        b=lBEYPBPE/bHzwVh4gztK/g8faARQtgZHZevjmv5+mjG+IFwRifpV1/M11pWReO1kXe
         YGk5vUP8SjfOvKXPqYVtCUj8iwBGKpGZOvqEIPg9L2TZE99wzhrslGFQf1e0chshPBLu
         IoJQiIhqEgW3Ph8kyfFH+nSDZ3R6bspkxDkbXEbvg/4r8wP8i268djod7py6Rhzg5mw2
         SLhb8pNic6c04lfg4SUcVrbBAfFzT/t5hdOr17yWsTlreZ7nyChLuQ6RA9XBPXcpRt7q
         Fe9P+9V/dSohSb1O7jsjQj0BeYtNr9q7CR+gHD8UA21EdmRPpMoUPnzxsayxw9/UDDIX
         3fMQ==
X-Gm-Message-State: AO0yUKX3nTwHsr2269FmYnlDh9lhuxtv2imI7MB/AgUVoQurWcPkJSmD
        LkDYKT6BdNll7DKDKrwQhdxo8IaLEYI=
X-Google-Smtp-Source: AK7set85mRngGbLrqjwx1O+DEVdLiY/kT/apfyuSlakyXvcI9AVxfkuo2PRWjoBZ/zKfJ3O8qxh68Q==
X-Received: by 2002:a05:6a20:e40d:b0:be:96d4:f863 with SMTP id nh13-20020a056a20e40d00b000be96d4f863mr7500208pzb.18.1675919535038;
        Wed, 08 Feb 2023 21:12:15 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id n25-20020aa79059000000b005882b189a44sm356207pfo.104.2023.02.08.21.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 21:12:14 -0800 (PST)
From:   Yue Hu <zbestahu@gmail.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, huyue2@coolpad.com,
        zhangwen@coolpad.com
Subject: [PATCH] Documentation/ABI: sysfs-fs-erofs: update supported features
Date:   Thu,  9 Feb 2023 13:11:28 +0800
Message-Id: <20230209051128.10571-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@coolpad.com>

Add missing feaures for sysfs-fs-erofs feature doc.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 Documentation/ABI/testing/sysfs-fs-erofs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
index bb4681a01811..284224d1b56f 100644
--- a/Documentation/ABI/testing/sysfs-fs-erofs
+++ b/Documentation/ABI/testing/sysfs-fs-erofs
@@ -4,7 +4,8 @@ Contact:	"Huang Jianan" <huangjianan@oppo.com>
 Description:	Shows all enabled kernel features.
 		Supported features:
 		zero_padding, compr_cfgs, big_pcluster, chunked_file,
-		device_table, compr_head2, sb_chksum.
+		device_table, compr_head2, sb_chksum, ztailpacking,
+		dedupe, fragments.
 
 What:		/sys/fs/erofs/<disk>/sync_decompress
 Date:		November 2021
-- 
2.17.1

