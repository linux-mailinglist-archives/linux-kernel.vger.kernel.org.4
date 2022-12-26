Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB666564B5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 19:57:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232250AbiLZS5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 13:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbiLZS5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 13:57:03 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EADCE61
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 10:57:03 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id x22so27424358ejs.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 10:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kk5Kn+NKT0dobWdbPezaQgFMp07l88kGoz9x5FWJG7c=;
        b=S2FGABrjPaYmwOzF2y2PDvR/36JwO/YCzCBTCjTLqefY8LjT6iOLfUXxqs2xBbHCjP
         XgBE1630FYtTNt1rEd/9kMKbGSbqXwIoYYE7qyl0jgh65C9T6gfDhCNTq1F+fZ7JLI+T
         tiNknamVzTzMXEyS7vak89L2rv+nbzo5ie3LX32GYXiD0sxMAUvgusTP1DZFSciEMu5g
         X/r3mCqLARXIGWOBYBghRycG4xxPUO+v4FNsRWMeW+dKgSZnfO1J2kXOdrwSt5hsl3LP
         uocXaVqMZlEF5DaqWM3stykB4BIEpKy0QGZuapPacCahJ5VnLH8g7WoAldWqnc9sjvku
         DFWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:date:to:from
         :subject:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kk5Kn+NKT0dobWdbPezaQgFMp07l88kGoz9x5FWJG7c=;
        b=CTSEbpoMeL320kGnqKRuUVK7RYykIYOUj+trIdbCr76ht1pDPfFwrEBVcfDAA5rPdM
         xMrm0dHeVTVqH+XthfDXkRj5BuUl75JFNH2CwC4EN2fQZ5g1jHVrHqXdCcZHml4wy5Zu
         RLV6w/IDVUDCAiATGiLw9qewSWpTg+OJoekrsludTHsmRXb81ZFDIWrYjzG+SIeJ9ev0
         ARnbhUxaJmPR2awbluY+lM+DXAojSbs1uFh8CSBHQqwlJ0FPZo/egxp/hwkYOwFPVX2S
         9RuykdQcdrwSwdvOB2JqmpsG6eBHhEoRMz9Xc40Kz2foNPBhcBup5hf6THa/exOpjdKh
         7qNw==
X-Gm-Message-State: AFqh2kq0snLSouuHmf0LUBHbwvzfOy4J3SWtdWZE9bhPdUDekUFlwQ+V
        BELAJ8RfIAOxy+IDYD3ezeRSCuOwSZc=
X-Google-Smtp-Source: AMrXdXtLjiKH7ERr/PJrrKB0HeKXIIt1QRC2AOLIHqvokKveXxjaqgfmen+P42vCRMa6SFqrozgFIA==
X-Received: by 2002:a17:907:d045:b0:7c1:5464:3360 with SMTP id vb5-20020a170907d04500b007c154643360mr23197003ejc.65.1672081021599;
        Mon, 26 Dec 2022 10:57:01 -0800 (PST)
Received: from [192.168.0.239] (ip5f5ad5e2.dynamic.kabel-deutschland.de. [95.90.213.226])
        by smtp.gmail.com with ESMTPSA id vb4-20020a170907d04400b0078db18d7972sm5075773ejc.117.2022.12.26.10.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 10:57:01 -0800 (PST)
Message-ID: <bf7ba34700b1e96a27a031316e811be4d2accfbd.camel@gmail.com>
Subject: [PATCH] udf: Initialize newblock variable COVERITY: 1530250
From:   Tanmay Bhushan <007047221b@gmail.com>
To:     Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org
Date:   Mon, 26 Dec 2022 19:57:00 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From 21f30c35ba12c939da0990a8527790408276aaee Mon Sep 17 00:00:00 2001
From: Tanmay Bhushan <007047221b@gmail.com>
Date: Mon, 26 Dec 2022 18:54:13 +0100
Subject: [PATCH] udf: Initialize newblock variable COVERITY: 1530250

When getting newblock the variable returned is not initialized.
Coverity informs this as a high risk impact because variable may
contain an arbitrary value left from earlier computations. Newblock
is initialized to avoid this issue.

Signed-off-by: Tanmay Bhushan <007047221b@gmail.com>
---
 fs/udf/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 1d7c2a812fc1..71bc4de38ad2 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -684,7 +684,7 @@ static sector_t inode_getblk(struct inode *inode,
sector_t block,
 	struct kernel_lb_addr eloc, tmpeloc;
 	int c =3D 1;
 	loff_t lbcount =3D 0, b_off =3D 0;
-	udf_pblk_t newblocknum, newblock;
+	udf_pblk_t newblocknum, newblock =3D 0;
 	sector_t offset =3D 0;
 	int8_t etype;
 	struct udf_inode_info *iinfo =3D UDF_I(inode);
--=20
2.34.1


