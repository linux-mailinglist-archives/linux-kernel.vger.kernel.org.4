Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9236418DF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiLCUYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiLCUYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:24:24 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CECE1EC60;
        Sat,  3 Dec 2022 12:23:37 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id v7so5942235wmn.0;
        Sat, 03 Dec 2022 12:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yGu+s4Pu9a4tLzAuom+09NeeuomIRjTH9Rj3bVpG0fs=;
        b=J69ihXbzW/Acb6B1q2X6yzBe8LerDj3kSWcLU8fMKgGpKIKK8zr9jJeVaApqO0++Uo
         nUn5exfVbPOn5QCsRzhKgI6XUwvhboBzChDaUErpt1D/YWxsOXe/djUhxGDmmPTFawDI
         FlyoJ6aw/ZzMewo7UCBiuiOdicHcxJ147CRJAuPjUmH0/dQQzKzwB0+VmrBi1iaxUPaa
         glIRCtuV/mVD3/7a5PnFbpGUXp9OWJKM47jXzhqzGYHsqoQ52EsCz7/6m14TlEXLHaHn
         uCtgybC5vYZXZ+CA0RunNcvXhGtKuSr5yyOisSr07cqg6ksiEdQuLXhvxEFyw4hCO5Er
         mNxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yGu+s4Pu9a4tLzAuom+09NeeuomIRjTH9Rj3bVpG0fs=;
        b=kQGhRTYbZPfjjK3zA1mevzGxGpovCva8LS5gxhfWDcJcAKzTmYdpdhpKPq4HGISsGl
         Qq3s/Q5WqSHEQU99whZg0BaDgjqqhvknwfYUtJux1toBFNdF6usjTCem0M8sszNkFHgH
         uwLvyH4lUYJJTdxW7KJXEgqO9RG4o87zPriLhe/LOjgnH+v0h/4yhFFPnTzd51XoFznG
         SRjSYbmuRXjPe4Vv51f042R64h9b2IKmVQOi7iAT8+fTTZJN9ebHvSgtB596bsP0tx67
         aW7TpYPl8eIKLK3XjM7SE422J2maraupWsJ6mycgL07C2NMkTwHTCPQgAEmJ0eVeQA4Y
         jKtQ==
X-Gm-Message-State: ANoB5pkcePS9uFLCVkm4JWZlZUUTniz0rG9c7KwcVxVCLL+xSEy7y09Z
        M+85+4giZDSu1GsvSK75PnlfvPqlfIA=
X-Google-Smtp-Source: AA0mqf7ms10CYiN9HKJSKx8ihGaBtA0IR2IqL8Knx1J9a6uPScR2iNV0AMbzqK0/wh8zBC1Xt8F3Bw==
X-Received: by 2002:a05:600c:2284:b0:3d0:88b4:9cee with SMTP id 4-20020a05600c228400b003d088b49ceemr4934097wmf.203.1670099016008;
        Sat, 03 Dec 2022 12:23:36 -0800 (PST)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id p17-20020a5d68d1000000b002420cfcd13dsm10064481wrw.105.2022.12.03.12.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 12:23:35 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
X-Google-Original-From: Alejandro Colomar <alx@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx@kernel.org>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 22/41] quotactl.2: SYNOPSIS: Add _Nullable
Date:   Sat,  3 Dec 2022 21:22:58 +0100
Message-Id: <20221203202317.252789-23-alx@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221203202317.252789-1-alx@kernel.org>
References: <20221203202317.252789-1-alx@kernel.org>
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

Signed-off-by: Alejandro Colomar <alx@kernel.org>
---
 man2/quotactl.2 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/man2/quotactl.2 b/man2/quotactl.2
index e5c6a5ea6..9fb81801b 100644
--- a/man2/quotactl.2
+++ b/man2/quotactl.2
@@ -17,8 +17,8 @@ .SH SYNOPSIS
 " constants"
 .RB    "                        (or " <linux/dqblk_xfs.h> "; see NOTES) */"
 .PP
-.BI "int quotactl(int " cmd ", const char *" special ", int " id \
-", caddr_t " addr );
+.BI "int quotactl(int " cmd ", const char *_Nullable " special ", int " id ,
+.BI "             caddr_t " addr );
 .fi
 .SH DESCRIPTION
 The quota system can be used to set per-user, per-group, and per-project limits
-- 
2.38.1

