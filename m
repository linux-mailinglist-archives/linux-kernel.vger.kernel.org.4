Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD996418CA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiLCUYC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:24:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiLCUXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:23:31 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6511D678;
        Sat,  3 Dec 2022 12:23:29 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id u12so11988208wrr.11;
        Sat, 03 Dec 2022 12:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6SAPNlYy4/4oIAE/X/j8E6sMMy4fbSi3qHB2oPK8tQ=;
        b=Sqy2f9Kw45B5LtVREcmFtXC6kgOLM9z/DKy9vepDUw0iUxVJiLKsT9adVNnceCqTQQ
         SGdx/urpUwx95yxvhAH53tFmDc5C171SgOTLkKruPw5oe7anHVhBHft5foZZLRj/Es3m
         Pzycwr7ynq7Hp6AWWTtygZHLWDgytB7W46CD1kdUxnZiHixc6kgOdHJYLpkxI3TgsDf+
         huWR84ydXCG9gefI15SoPHagIj/oXYU8qiquyrMDlh6htLGmbr2U3lo3RmOZPVGrEXEO
         wPHjo5OB4nAu2U55mDVtyxIiKDq4PPbhIdQQvtXeqmIPCdmbWcerNzPXoVW9ZSKj694B
         3MnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6SAPNlYy4/4oIAE/X/j8E6sMMy4fbSi3qHB2oPK8tQ=;
        b=mztV/jtntleFSeGi8YD+sZuVjiHLoyqdFPB9ML0AzvITZEtHwdSBJDrn4IET7iSGNX
         5Tgy5H+8Dli3DKFVstv1ZH2aYZE9n7rjpSUEN6buocRi2Byl6Qwo9wuG6790IZITTEHM
         iMFja+Qt0qe9SBM6RTpXzrt3Ndlx3yRiUoe4csjOusFIfUabhblSzI+vAqa0ELSuXDRq
         YGl1gMgFnzmUiA5uaMFYXPeflrwz41Sd9cQiDQwFsaCKn1Ygbv52eblTcUugVeEyxVz5
         VQSgF6imbE4NGtIwO5CMH11tbQxql3goZkcdDPDse4ASMHx9hkASacfCi7QujIf4AmcC
         EOLg==
X-Gm-Message-State: ANoB5pm9BatI5qZ3UyGLqYzLUiPmoeYDTHqc/ST+aKSjYRxhpeIjvKuU
        5n/KjEYMkAYZyqQ48Lxtf0IPnMYweP4=
X-Google-Smtp-Source: AA0mqf6TucN44gqORc68LHwv0vYrNPbZYj+mlwER3DRefzVBV04j1lBdMRURqmcTesK+IHOmFcfmRg==
X-Received: by 2002:adf:ff88:0:b0:242:4a32:900e with SMTP id j8-20020adfff88000000b002424a32900emr3807744wrr.129.1670099009334;
        Sat, 03 Dec 2022 12:23:29 -0800 (PST)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id p17-20020a5d68d1000000b002420cfcd13dsm10064481wrw.105.2022.12.03.12.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 12:23:29 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
X-Google-Original-From: Alejandro Colomar <alx@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx@kernel.org>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 13/41] getgroups.2: SYNOPSIS: Add _Nullable
Date:   Sat,  3 Dec 2022 21:22:49 +0100
Message-Id: <20221203202317.252789-14-alx@kernel.org>
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
 man2/getgroups.2 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man2/getgroups.2 b/man2/getgroups.2
index 7ec9e5a68..f0687018d 100644
--- a/man2/getgroups.2
+++ b/man2/getgroups.2
@@ -23,7 +23,7 @@ .SH SYNOPSIS
 .PP
 .B #include <grp.h>
 .PP
-.BI "int setgroups(size_t " size ", const gid_t *" list );
+.BI "int setgroups(size_t " size ", const gid_t *_Nullable " list );
 .fi
 .PP
 .RS -4
-- 
2.38.1

