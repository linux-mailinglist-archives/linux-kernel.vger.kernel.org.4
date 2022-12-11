Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8716492DA
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 07:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbiLKGUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 01:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiLKGTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 01:19:24 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3227713D3A
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 22:17:56 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id m4so8966193pls.4
        for <linux-kernel@vger.kernel.org>; Sat, 10 Dec 2022 22:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0IGz3udF13u9xcCDpbGAjcYJk/g8vrZZv/DcYG4s+G4=;
        b=enGLQOUwKDyu0qinligm4kc/92RLUm9j/ii0NoT+i1uLG2QjM5HOVPKCXawkGXQ+0v
         ba3R4BzfLZKK/N0sz/Rprc5aTjLTjNcRQOSCxc/bWkJgAuv1gZv7s3VLVhxZ56FKmSe/
         HtLFKxm5wOKwk3vQ6/u3Mr/fdvMCqSCoD4aLlhXt0MEhgr0ZOkcC7Cxd0Fbo/QF8ZSzn
         c18kll7bVxj7MnPR2VUsDosDAJfLAWX+mvXHRZqM3qNjNciPVJG/vhkcW+6TpWqzJFey
         yS/hGwZAENgNDmBuD6fzegf9ScBA8+JVHeEMmwO7/oL/xvHovTGf6gcvS/RgGJdvv29N
         GwHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:cc:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0IGz3udF13u9xcCDpbGAjcYJk/g8vrZZv/DcYG4s+G4=;
        b=GYSrU+lIY+MP52JKejbbBz++ZclCilGdv0JgeLiFBXlr233TA52frSYgaqxJabWDps
         Mb1fn46dGqsFNMn8IRkhOu8vVV/caF5jYuLqER8piY6T7DsJTbdp5eTPanOe7Xzqr8i5
         DXM34/CDFXkNDudjMe3fB4J990Gzm5rRjSvnkL0HxE5CUmHgjBXeXEyi2HUvnGuvr+bL
         /N9gUBZySniGMeV5b1To3I2gbFEXeqkiuoAYW0s1AJGMa06CobImQUkF+mytfjQlS/eh
         CF0jUAAQGdLY9r/mDW60xfXV4e1y9w5c8qNgMsJ+Xq0RiTVLi7ve4G5Ovq9/j3pt+QdN
         vZSw==
X-Gm-Message-State: ANoB5plqiR59ThoGMMmZPMVjO26GZkH6hbEekmcl7rvbZvZ+0+5bRVVK
        K8w6NvaGXMVAMb1IuUcC0SGt0Q==
X-Google-Smtp-Source: AA0mqf47op0v+60AWV+AomEgdSEMXXTn2WC66WNap3eEXjRHx0WZYOvSC7ryzhKQcQ7KYY/PJXw3fQ==
X-Received: by 2002:a17:902:7001:b0:189:760d:c5ed with SMTP id y1-20020a170902700100b00189760dc5edmr12075930plk.28.1670739475707;
        Sat, 10 Dec 2022 22:17:55 -0800 (PST)
Received: from localhost ([135.180.226.51])
        by smtp.gmail.com with ESMTPSA id d9-20020a170903230900b00188f8badbcdsm3808270plh.137.2022.12.10.22.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 22:17:55 -0800 (PST)
Subject: [PATCH v2 22/24] sparc: Remove empty <uapi/asm/setup.h>
Date:   Sat, 10 Dec 2022 22:13:56 -0800
Message-Id: <20221211061358.28035-23-palmer@rivosinc.com>
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
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/sparc/include/uapi/asm/setup.h | 9 ---------
 1 file changed, 9 deletions(-)
 delete mode 100644 arch/sparc/include/uapi/asm/setup.h

diff --git a/arch/sparc/include/uapi/asm/setup.h b/arch/sparc/include/uapi/asm/setup.h
deleted file mode 100644
index c3cf1b0d30b3..000000000000
--- a/arch/sparc/include/uapi/asm/setup.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
-/*
- *	Just a place holder. 
- */
-
-#ifndef _UAPI_SPARC_SETUP_H
-#define _UAPI_SPARC_SETUP_H
-
-#endif /* _UAPI_SPARC_SETUP_H */
-- 
2.38.1

