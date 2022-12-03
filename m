Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94F186418EC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 21:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230177AbiLCUZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 15:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiLCUYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 15:24:31 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9E71DF3E;
        Sat,  3 Dec 2022 12:23:40 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso8935117wme.5;
        Sat, 03 Dec 2022 12:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K72bk8ch74Z9wRgp/NDEAG/pkbMJvv5eJRt1Gu/GiLI=;
        b=lJq+NL/N49FP0i8FtUHq+hQA+zZFC4y8rTABZuWIxEzM6Gn5q3VyohVcTtl2yhOX6N
         C7T1BvxCqoYeFdjPf/u4TWGdg388lXeL+NM5nVqZVWMtUtAnjCBhYrrIoL1pnvtiuKPu
         PstjY4o82bts8Rwa9aMFGFMEI2qY5fdRLoWtaJpcjwpXTfCDYT9zo08cb51THLvR8r63
         0TeZTRgTfsNonQYppb4VNMzP0Fn8nDaEU6dDL1TMsOCc3JQzwN+bIStDf0XF6ACl8s6v
         MiV/huhUd75LZhqChH4H57b56g141zK3Ymd78EBdQf3rLeQEmwrGtD3MNhA3IN5VnJie
         cMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K72bk8ch74Z9wRgp/NDEAG/pkbMJvv5eJRt1Gu/GiLI=;
        b=Yw89kaQJqURE6IWCBeS0plfenKU3MROKpY0Fjp4k/iRXLdYdVHdXCe0gWo8THTZ84s
         jkr++gMAJhGIa5uWoJJ3NGxI8VLlTOxHVdMywR1vTi3CmSJ6nU+JOpvtne8pdzBQuB3a
         CkYE0SXjvSYAsj9YByryNQHFPQKxJonoe35eUKY9NWgbQgPm4jTP5sc0N7Nk5GACoTJO
         pfspIcxf0ytDwLfJwsQH5+m1lqB8QGStRwDMlXmewcp3iaCjFcaVE8MYNFN2D5xemBV7
         P2cnqz5T6yhGat5xzPiVNyXY2CBSiYmiHOlnBy7Q8j4S+9EMFnGvuCiHGS3Z+PIgRC5/
         tL2A==
X-Gm-Message-State: ANoB5pkLxYMM47CxU8G9/qR8lUYV7FlcEOBbTLk5Y/Ris7oFUxdhYvTY
        ocEPQdVapOIYl5Ypy+z1C7FH9/ZxhQM=
X-Google-Smtp-Source: AA0mqf6rsTwV7xkalhEXWb7tLJe5FcTJQrrz4M7EfA+HCxJR9Ct54dPdmGmPbpdYHgPJVMIhTxsZCw==
X-Received: by 2002:a05:600c:5113:b0:3cf:77c0:48ea with SMTP id o19-20020a05600c511300b003cf77c048eamr58295605wms.130.1670099020214;
        Sat, 03 Dec 2022 12:23:40 -0800 (PST)
Received: from asus5775.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id p17-20020a5d68d1000000b002420cfcd13dsm10064481wrw.105.2022.12.03.12.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Dec 2022 12:23:39 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
X-Google-Original-From: Alejandro Colomar <alx@kernel.org>
To:     linux-man@vger.kernel.org
Cc:     Alejandro Colomar <alx@kernel.org>, libc-alpha@sourceware.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 28/41] shmop.2: SYNOPSIS: Add _Nullable
Date:   Sat,  3 Dec 2022 21:23:04 +0100
Message-Id: <20221203202317.252789-29-alx@kernel.org>
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
 man2/shmop.2 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/man2/shmop.2 b/man2/shmop.2
index e5a0ae814..cd91c9931 100644
--- a/man2/shmop.2
+++ b/man2/shmop.2
@@ -27,7 +27,8 @@ .SH SYNOPSIS
 .nf
 .B #include <sys/shm.h>
 .PP
-.BI "void *shmat(int " shmid ", const void *" shmaddr ", int " shmflg );
+.BI "void *shmat(int " shmid ", const void *_Nullable " shmaddr ", \
+int " shmflg );
 .BI "int shmdt(const void *" shmaddr );
 .fi
 .SH DESCRIPTION
-- 
2.38.1

