Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8819F70B2A4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 02:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjEVAzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 20:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjEVAzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 20:55:12 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8A4DC;
        Sun, 21 May 2023 17:55:11 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ae851f2a7dso17835395ad.0;
        Sun, 21 May 2023 17:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684716911; x=1687308911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4AoXr37i/ZwN1X5gidgoTPwPH/KAkAnTc2FPMBhYuQ=;
        b=O4wSjabUzEc/uZJVqzDt9YXeJ+paHWszNbTKjwh0x8uPzl9KTjYQhc8zoj6zt2rlfW
         A6rt38NKcswHswGTvRzus7RraIEAJKOWIdRqSM1/b/qOqhJIwi437Za/M+7f0wadGUeH
         sfLYDvZ0bEe2iIfoX74ZbXQw17nK+hjDr6J8uetC9Dd4gWK9T7eR4epfTsdw8jADJSIN
         7LEbOJ+XRbnOqL4ICWRSSbafFSIMg/TvgXefGMsx+nLHoPLFQC1ybxbIadwiqGn8sG9m
         O1YwbhJ8YZH6dbNYgUF7DMvZ8/WF4v9wmQxsAykVSSx7rQwZJFyMA7dKpdtr06WhJyrm
         d3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684716911; x=1687308911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4AoXr37i/ZwN1X5gidgoTPwPH/KAkAnTc2FPMBhYuQ=;
        b=V7aquG++GB7BHEIeGyplg9rkLjTQ81bs43CexrfAcOoqkB0fqmQMQp0wb+0vvYg9vH
         lBaqWeLuYM47MDzO/A5uwevfLb6K/mhlSKcpMrt0ZTM/kH3epz4yqBgiADObsMQhHbEY
         CaTxJV7bKDRP1/MmI3muBzLOVeE7zpzWbOModuJ7HErJfILoApFEGK53Bc+U9S0LbukC
         H8+iXXmrNif0t3rgfoVo5Z2LNGAkl6TfXaWPLTEAwCOZMXaSvuCN0ETKGvzjjRVsO0Au
         llinrylOK4I0FruwkPszO1rTvuTZiO8QC+lr+OaxVJ1NsLD0c3Z/0XbeSkmSVaoPRIGX
         yf+A==
X-Gm-Message-State: AC+VfDzxgjJuBDdUfth6OezmBnB7DyXKPbOmRuTZXgMbbDKms6UknVaf
        bgbP3P1g1Rp1huvfhvcFrTw=
X-Google-Smtp-Source: ACHHUZ48Gg5LUE0V3aVhomWb2AkSelTqz29RfUVKIMu4pHJXb0iZqzzueFGjPcrVTHDjhUxO82XUbQ==
X-Received: by 2002:a17:902:d48b:b0:1ae:9105:10a5 with SMTP id c11-20020a170902d48b00b001ae910510a5mr7494868plg.2.1684716910783;
        Sun, 21 May 2023 17:55:10 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-10.three.co.id. [180.214.232.10])
        by smtp.gmail.com with ESMTPSA id c18-20020a170902d49200b00192aa53a7d5sm3541801plg.8.2023.05.21.17.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 17:55:09 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 0E6E910621A; Mon, 22 May 2023 07:55:05 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Linux SPDX Licenses <linux-spdx@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Actions <linux-actions@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Cc:     Jan Kara <jack@suse.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Diederik de Haas <didi.debian@cknow.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Paul Eggert <eggert@twinsun.com>,
        Richard Fontana <rfontana@redhat.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: [PATCH v2 2/2] fs: udf: udftime: Replace LGPL boilerplate with SPDX identifier
Date:   Mon, 22 May 2023 07:54:35 +0700
Message-Id: <20230522005434.22133-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522005434.22133-1-bagasdotme@gmail.com>
References: <20230522005434.22133-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1744; i=bagasdotme@gmail.com; h=from:subject; bh=a6SevDQ/wq1dLRU2UD1c2AM2JD3LjPnSvIfHI987ZZk=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDClZe72e3v8ecf1s/+Hn2sbv5cKvrL5/59TizWdmhu9Ns +Xd8GHFzo5SFgYxLgZZMUWWSYl8Tad3GYlcaF/rCDOHlQlkCAMXpwBMJOkhwz+NaTMbLFtK/nlW bTp36f1lP0fhGO9pKz+tebtew7ytVu8aI8PM9yrmyv5Lv2+8d/fqFdbLxhw3lu0KEFm3qy1Uu/f VqV5WAA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace license boilerplate in udftime.c with SPDX identifier for
LGPL-2.0.

Cc: Paul Eggert <eggert@twinsun.com>
Cc: Richard Fontana <rfontana@redhat.com>
Cc: Pali Rohár <pali@kernel.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 fs/udf/udftime.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/fs/udf/udftime.c b/fs/udf/udftime.c
index fce4ad976c8c29..758163af39c262 100644
--- a/fs/udf/udftime.c
+++ b/fs/udf/udftime.c
@@ -1,21 +1,7 @@
+// SPDX-License-Identifier: LGPL-2.0+
 /* Copyright (C) 1993, 1994, 1995, 1996, 1997 Free Software Foundation, Inc.
    This file is part of the GNU C Library.
-   Contributed by Paul Eggert (eggert@twinsun.com).
-
-   The GNU C Library is free software; you can redistribute it and/or
-   modify it under the terms of the GNU Library General Public License as
-   published by the Free Software Foundation; either version 2 of the
-   License, or (at your option) any later version.
-
-   The GNU C Library is distributed in the hope that it will be useful,
-   but WITHOUT ANY WARRANTY; without even the implied warranty of
-   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-   Library General Public License for more details.
-
-   You should have received a copy of the GNU Library General Public
-   License along with the GNU C Library; see the file COPYING.LIB.  If not,
-   write to the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
-   Boston, MA 02111-1307, USA.  */
+   Contributed by Paul Eggert (eggert@twinsun.com). */
 
 /*
  * dgb 10/02/98: ripped this from glibc source to help convert timestamps
-- 
An old man doll... just what I always wanted! - Clara

