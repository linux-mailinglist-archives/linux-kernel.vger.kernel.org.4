Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF286492DD
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 07:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiLKGUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 01:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiLKGTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 01:19:25 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F9E13D49
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 22:17:58 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id w26so502324pfj.6
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 22:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qD4L3LDicZTOzxJnDXtBbvdNu/zbVvqwzPUbFJq+3mk=;
        b=DfXj82oQ+MvqrS0ZFdXMpYknFiNYMi5weeP7wE3AJ2GBnOAng+9aExOC71260PuMrX
         vwK11iG/lMGfvV6W4Mv4u1r3DIvuuHMMaI2Q0HVcLEoDMpafmG+fY3s96XjNtkNAcMEC
         87OPaQtoVBoN+afYhhB07HT14QjF3qwqa8xJKuVV1WPGUBfGeL1aLnnxpHMce/FcXdZG
         0JeHf1UaRBzn1qgwZacemIgee6sKEP5Yu3Kn8jhbFTaIiTnlI9knDLEhDYLm5OVHaN27
         eizAeA8BmugKtvx1WnZBp1DcrpYVWy3/Xmdj9TDyeb1+Fqx0EPM+LWb3C8Dsoms7lvRZ
         +bAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qD4L3LDicZTOzxJnDXtBbvdNu/zbVvqwzPUbFJq+3mk=;
        b=BTX0ZoXS3FGKY4nqgQSpkeGoUrgThiOu25JVfHQHdNJN7jg92iQcbdDfiUJumi7GlB
         /Kcv+TW5YNqTp1BlIWpXzbjGJzuyeXMDUzbCMn3/OS0rnGehM4KajtfsCN1tJDVMUFXZ
         bh+wTKZtyrk4xAxVFhEM7fq+Pn1AwUO388IdSicucOOQ7i9f3OAe+s4HmHs5GMqtOHFv
         4iH5aZHVeuW7fZu45fX3I099zmz2qe+Kq8u+k522OPDGLVwuHyGGf65vvj4D0yab8hg0
         Mw3ViZjwfX5Hi0EP+vz9mYomYTdJ7CHQqI4ktANxxg1oXC3gOZpdyYAf7XKSuCcwGRWM
         9KfQ==
X-Gm-Message-State: ANoB5pm1sOO4RIi3VrnVY6GWpkCX6lkocsvMBGaSTbLTsh68R6aUoq92
        eCnEi0Gy+WWH4L07ur4yy8CTzQ==
X-Google-Smtp-Source: AA0mqf4HZYLNI/fZfR4Hs2tOKznu/BLWDbm+J9VoH6dj6erkss8EyiSewoCxlHBBjxEFcclp+JUcTQ==
X-Received: by 2002:a62:cd0c:0:b0:577:2a9:96ef with SMTP id o12-20020a62cd0c000000b0057702a996efmr12892481pfg.28.1670739472058;
        Sat, 10 Dec 2022 22:17:52 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id g204-20020a6252d5000000b00561d79f1064sm3513372pfb.57.2022.12.10.22.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 22:17:51 -0800 (PST)
Subject: [PATCH v2 19/24] parisc: Remove empty <uapi/asm/setup.h>
Date:   Sat, 10 Dec 2022 22:13:53 -0800
Message-Id: <20221211061358.28035-20-palmer@rivosinc.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221211061358.28035-1-palmer@rivosinc.com>
References: <20221211061358.28035-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/parisc/include/uapi/asm/setup.h | 5 -----
 1 file changed, 5 deletions(-)
 delete mode 100644 arch/parisc/include/uapi/asm/setup.h

diff --git a/arch/parisc/include/uapi/asm/setup.h b/arch/parisc/include/uapi/asm/setup.h
deleted file mode 100644
index bfad89428e47..000000000000
--- a/arch/parisc/include/uapi/asm/setup.h
+++ /dev/null
@@ -1,5 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-#ifndef _PARISC_SETUP_H
-#define _PARISC_SETUP_H
-
-#endif /* _PARISC_SETUP_H */
-- 
2.38.1

