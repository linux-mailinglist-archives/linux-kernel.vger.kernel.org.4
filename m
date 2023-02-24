Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10DE86A1A98
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:51:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjBXKvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjBXKvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:51:00 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CEC915885
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:51:00 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so29042pjp.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dW3qXQYpmNKcqlh4A0ERoGNSnFf2SSyTXbPFz2Oak8Y=;
        b=ks/XSPw525h+Cz4ygu0GbROT6kca0MC6o5cU/AR01Dv5hyZpWjF80YHJBuakUdTUjE
         NPObc8ulfp41MfLiOgPbbcLfi1qsLGHA4bAKFYAq/9WKpLshkLVNHEX1maRZy45vvQOd
         /K+Xp/Of+dwZjFSHrB4HdtFjiOx181IHaoT0zNCfIWkRyGtSr83ewtz8j/uiwCvoHR6Q
         SO5TQbZa4jgqrQnaVk9k9GvwAZxVWFLTGjxiAf0D8zTj+BxWuMwBUz5CyKGtuvy9FUT/
         PJ+3mrzzHIvpd93Jk296ibq8EDyn/IgTRbdy+ht484QIglJAuMrzMAkKfteFZndxmqW+
         M5kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dW3qXQYpmNKcqlh4A0ERoGNSnFf2SSyTXbPFz2Oak8Y=;
        b=m5dePKghzK0wHm4BDJW+hrFdXB6tNWYfYE0IHQd5xZbrwi6dhoZCTvqfV19/2jzZ36
         mwcHr6ZR6BveB2dgk3v8WnIrvjyVLTDo7eu/OMEBc/CTMfIpJ7CZaqmUoJheriBD8X37
         XsuJio4zBYa41GzKXHYqJ2ByMrMIIQfeZSeBdRmCKfdVeFxpiHxUzbO2hqrK6crc75+A
         aQhXD4f30lggWT7G4zJmffrKI+Uaqi6+wV7ug8CjLwjhZ+0i++HaY5la0yF/Y4pUvJCg
         wNPKa/7O0HWyua06ePBgoCI5mMcLT/j2UScznbKkP4UwLCOjpYbwVjX4GKn+kGss/In+
         Csbw==
X-Gm-Message-State: AO0yUKXlgHhsoAGY9NxEmpLCwyGtes/aorXNkYjuzrbmp4Mj6KK70Uhk
        JTMvHsnSoAVUUX3vYZmPy3E=
X-Google-Smtp-Source: AK7set/Wm8ZkZur4lZZ/ZSqtkJF98/L27AWp2UMInfRwraO3lAO9xpUHtwt95ROYV3/Y6bEpftzFBg==
X-Received: by 2002:a17:902:ce8d:b0:19c:da68:337b with SMTP id f13-20020a170902ce8d00b0019cda68337bmr775918plg.16.1677235859176;
        Fri, 24 Feb 2023 02:50:59 -0800 (PST)
Received: from XHD-CHAVAN-L1.amd.com ([103.115.201.82])
        by smtp.gmail.com with ESMTPSA id be1-20020a170902aa0100b00194d14d8e54sm7827461plb.96.2023.02.24.02.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 02:50:58 -0800 (PST)
From:   Rohit Chavan <roheetchavan@gmail.com>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Cc:     Rohit Chavan <roheetchavan@gmail.com>
Subject: [PATCH] staging: vme: remove unnecessary parentheses
Date:   Fri, 24 Feb 2023 16:20:48 +0530
Message-Id: <20230224105048.758-1-roheetchavan@gmail.com>
X-Mailer: git-send-email 2.30.2
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

This patch removes unnecessary parentheses in order to fix a checkpatch issue.

Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>
---
 drivers/staging/vme_user/vme_user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vme_user/vme_user.c b/drivers/staging/vme_user/vme_user.c
index 4e533c0bfe6d..5027d91d7038 100644
--- a/drivers/staging/vme_user/vme_user.c
+++ b/drivers/staging/vme_user/vme_user.c
@@ -506,7 +506,7 @@ static int vme_user_match(struct vme_dev *vdev)
 	int cur_slot = vme_slot_num(vdev);
 
 	for (i = 0; i < bus_num; i++)
-		if ((cur_bus == bus[i]) && (cur_slot == vdev->num))
+		if (cur_bus == bus[i] && cur_slot == vdev->num)
 			return 1;
 
 	return 0;
-- 
2.30.2

