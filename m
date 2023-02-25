Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D09A6A27AD
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 08:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjBYHMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 02:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjBYHMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 02:12:52 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861E565323;
        Fri, 24 Feb 2023 23:12:48 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h14so1366236wru.4;
        Fri, 24 Feb 2023 23:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwUMRpPc5U7rZDxlVxKljUDuecRcZEbjlnEYRDIWwXw=;
        b=JppGw366kKSEZKIU8AAFhCztDGknHyRyL+un1P/+O+ikK4GUnon1qqmsUoVeB33U47
         r7I05lE/xff9PhFoSnC6o1iayBSElSWu5T+7g/WYge6coAf6PRgR+NbtxKmssqBj5CDc
         hKZ29biW3eifnDaW5r9my1rHHOh4v808wx5M+gwV1dbViMolxPXZytaVhLBNjZCvTK1f
         gZEyhN7Cowc8THPl94hDH181VwaBuaQ5bXFdOREItZuucsBFQfuj+u+gIJytvkW8sEoY
         sfuYKNAnKAJLeqbaDJM+/Jja08eXoSkvy4y5Ala4lAaRATFoHV8Zc8QFTfPOqrqfNxTO
         Wr3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwUMRpPc5U7rZDxlVxKljUDuecRcZEbjlnEYRDIWwXw=;
        b=upr52S0qmM4aag3OBvoyLBpVb3dIe+WIIvh03bFkNXZsigRqkdGJ8QyqMZhAKuA4pc
         wui5gNVs4GDDLdGYgbGD+dGLh4omVWtGi/v8M/Y1hvsJ0Jj8y2JPSIimhuOdOeEa1947
         qr58bjz+Pno0w4OsPg0YYoh6V+tI5gBQ/AquufYnAwckuxUcbxyjwWvPLoBCVWV3dna7
         LqBOvEeF+YnCIywt8d34m9rcGQuHFy2irx1grrt3czBtxdewzu0zHQMKYkmSx5BDhjQG
         xOourOj7RmpoE/dWpI4+MScqAduDUHouvNSeRCtkH219ZVurWb6m3wTT2QvwfpQ76Us1
         UkDA==
X-Gm-Message-State: AO0yUKVewXKDhe1DLaPFm5lNAkCWrGwzMLR+gcuXC6f5F3M/c+zv4zeL
        ujoja9EbI7jnxBoJQexoxjY=
X-Google-Smtp-Source: AK7set/UdIdQnB7/VDov91pjJwha+d0oEignFHaQl4D0FTgSboqNza5ICHUljSwlCH5bR6DhAcfkbQ==
X-Received: by 2002:a5d:5383:0:b0:2c7:169b:c56d with SMTP id d3-20020a5d5383000000b002c7169bc56dmr6828640wrv.17.1677309166586;
        Fri, 24 Feb 2023 23:12:46 -0800 (PST)
Received: from localhost.localdomain ([20.208.58.248])
        by smtp.gmail.com with ESMTPSA id j1-20020a5d4521000000b002c573cff730sm913798wra.68.2023.02.24.23.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Feb 2023 23:12:46 -0800 (PST)
From:   Nikita Romanyuk <ufh8945@gmail.com>
To:     deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kelvium@yahoo.com, Nikita Romanyuk <ufh8945@gmail.com>
Subject: [PATCH 2/2] drivers: video: logo: add SPDX comment, remove GPL notice in pnmtologo.c
Date:   Sat, 25 Feb 2023 10:12:29 +0300
Message-Id: <20230225071230.11494-2-ufh8945@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230225071230.11494-1-ufh8945@gmail.com>
References: <20230225071230.11494-1-ufh8945@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Nikita Romanyuk <ufh8945@gmail.com>
---
 drivers/video/logo/pnmtologo.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/video/logo/pnmtologo.c b/drivers/video/logo/pnmtologo.c
index 7e7cb4210..9623040ca 100644
--- a/drivers/video/logo/pnmtologo.c
+++ b/drivers/video/logo/pnmtologo.c
@@ -1,14 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  *  Convert a logo in ASCII PNM format to C source suitable for inclusion in
  *  the Linux kernel
  *
  *  (C) Copyright 2001-2003 by Geert Uytterhoeven <geert@linux-m68k.org>
- *
- *  --------------------------------------------------------------------------
- *
- *  This file is subject to the terms and conditions of the GNU General Public
- *  License. See the file COPYING in the main directory of the Linux
- *  distribution for more details.
  */
 
 #include <ctype.h>
-- 
2.39.2

