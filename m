Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9E070AD00
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 10:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjEUIba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 04:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjEUI2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 04:28:22 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EA8ED
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 01:28:21 -0700 (PDT)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 888BF3F4F7
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 08:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684657698;
        bh=JDxwondAh/OUHugni3ivKWRUI1pwMRnCsBuB/co2xpE=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=TgERYlQJWvrZw7gHn3ucr5v6Nsd0NPB6uVbqs6k+qlDRmOiBwA+YCgNvgKKN2htlj
         Lglx3xdXLUG+JjpvwJOL2XDX88f4LQc6C12su5kUVlO8wIOkprSj39FAH1dCBu1HJS
         BFD+gl1ECGerPKif+P5j6wuIlTgkCsR0R8j4T+8kDxuVs3KUuF4FpMPLnehtEcRWk4
         yWHy+ZV02QDXg1le5Gulw5oES5qrEbkHF8kNaxHyRKbpb65rSsQCOH4FjYe7G2fvZC
         LDotCl7ELbaD99OHxLBepkHJmAq1952gy9yymZNgPUMNJtofHVujJCu/Dy6u2NAbLU
         KQ3EZBc0ExEZQ==
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-510b714821fso3139021a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 01:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684657698; x=1687249698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JDxwondAh/OUHugni3ivKWRUI1pwMRnCsBuB/co2xpE=;
        b=JadZMG4DvCfDwoJQFoTGOVrR/35faz6whgBul6CeP2erxJhd1Wsn0VPzKPNbrU3LY1
         MJCDdU/wu5xcQ/DKajqdagMezILqPaHYrYAmc1KLbocBj2SfBS38vlvNyrMc7dyu1aE7
         g8v5Zk85oyQuPamgxte/Fneg3xuCh8Q3/9yRoXQNg6HgXtUYPm2VkjYt5pS4FoOlZd/q
         ouDjoR3XcSWq+sN6Liha8pRINGXLZ8y3BW8ZZSMWRifoHxk0alcHNddo1TbmuPHU1QOM
         k93ywdY83CdIrhOZX/Si+vUPJLaHA7N6KpTSrnqYIdcLmof/MTcHeosykQpQ19s6Oum6
         0aUg==
X-Gm-Message-State: AC+VfDyeWbfAOo/Rsr5BgJBrjakxTptXb2hveb/qDX72lQNuYrCn0jaY
        L+rp8hiN2kOwcCJEI+vNYzHFP/g5epmZWJpNhgoCZPxSZyeX3hkGwi8XQbwamW5YJnkrpJe7PMm
        fgrj3xS/zACFFxQgCWnZsRznP9PR6TAVkIjglD4QAZQ==
X-Received: by 2002:a50:ed09:0:b0:50c:161b:9154 with SMTP id j9-20020a50ed09000000b0050c161b9154mr6988440eds.11.1684657698395;
        Sun, 21 May 2023 01:28:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ZOrhcJoW7hdR/JwsluZvVPpD3I9c6Xd7IgooNQQzahawcWHebG+MovffeT+18V5hGxmKYpQ==
X-Received: by 2002:a50:ed09:0:b0:50c:161b:9154 with SMTP id j9-20020a50ed09000000b0050c161b9154mr6988428eds.11.1684657698143;
        Sun, 21 May 2023 01:28:18 -0700 (PDT)
Received: from righiandr-XPS-13-7390.homenet.telecomitalia.it (host-87-10-127-160.retail.telecomitalia.it. [87.10.127.160])
        by smtp.gmail.com with ESMTPSA id z17-20020aa7cf91000000b004c2158e87e6sm1656646edx.97.2023.05.21.01.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 01:28:17 -0700 (PDT)
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] ovl: validate superblock in OVL_FS()
Date:   Sun, 21 May 2023 10:28:13 +0200
Message-Id: <20230521082813.17025-4-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230521082813.17025-1-andrea.righi@canonical.com>
References: <20230521082813.17025-1-andrea.righi@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_OVERLAY_FS_DEBUG is enabled add an explicit check to make
sure that OVL_FS() is always used with a valid overlayfs superblock.
Otherwise trigger a WARN_ON_ONCE().

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 fs/overlayfs/ovl_entry.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index b32c38fdf3c7..e156649d9c71 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -97,8 +97,20 @@ static inline struct mnt_idmap *ovl_upper_mnt_idmap(struct ovl_fs *ofs)
 
 extern struct file_system_type ovl_fs_type;
 
+static inline bool is_ovl_fs_sb(struct super_block *sb)
+{
+	return sb->s_type == &ovl_fs_type;
+}
+
+#ifdef CONFIG_OVERLAY_FS_DEBUG
+#define OVL_VALIDATE_SB(__sb)	WARN_ON_ONCE(!is_ovl_fs_sb(__sb))
+#else
+#define OVL_VALIDATE_SB(__sb)
+#endif
+
 static inline struct ovl_fs *OVL_FS(struct super_block *sb)
 {
+	OVL_VALIDATE_SB(sb);
 	return (struct ovl_fs *)sb->s_fs_info;
 }
 
-- 
2.39.2

