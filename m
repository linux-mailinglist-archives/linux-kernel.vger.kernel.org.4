Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14656AE372
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjCGO4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:56:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjCGOxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:53:49 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA63867F5;
        Tue,  7 Mar 2023 06:40:11 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id g3so53265060eda.1;
        Tue, 07 Mar 2023 06:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678200009;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ffyuxsjxwRhSg2GhzeH8tqKDCwlIQld/SCdHJpBH2gE=;
        b=FL1DCLJ8QssMQC9Zk1WCpjYxPUrnj2VhJaLyKwYlK5B3yiutHaW4GMzsQM8UVJ43A/
         cOMmqWE1OVIfI4gVMXvgtj6rRKfLJErJ8exczL9IlQymmovf4KmRKPmQpp9qGAGTKZ5i
         En7mCAji6D1Ng6F72dbeWjQ7U2LWqVAs/o6jiNSrGxRYHwyMEIUwzVFH18qpagGGoAHb
         gHwNBGXi09PwLbdOnlcJEuYDz6Sp4TXoCPda4Z/lzcUsTZxb+nkF/Y1/DtPHb2F1yG4v
         nEpxsZ/gp4Voh740Xp9dlVTB5QNkFFRwyIGIX6vI1nGxRNpjvQXBv7hACTKzR4DU6rch
         rMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678200009;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ffyuxsjxwRhSg2GhzeH8tqKDCwlIQld/SCdHJpBH2gE=;
        b=o6XHiW75pUqYLfjY4YTtx1B6s6/5OgV71ENPLT/hOnAGXEylUEWQ0Ve1Zd/+w2/HMp
         Ah35P+Cgv5tOiOXTvNLlVr9NaIaIsAzLLyY66DAl+bHy6eecUvTrcgjVuuqlJnbu/bOo
         fY0PDZhx5CwiY7etD5l/+CkahZDpGfK6jhqinOy/JTqLfVBVBxm56V9fjjlHHbarL0i+
         UDj75SKA83FwhmTtmDLmBjuzamFjsa4OcxGpwd5XmZBJJpKHEHrMA6cyv5yqhcC2sWvx
         97ZARSQE+pUWwh3rnEsbLgEEjb6e2v0e8htWv9ttuMMqPiieX7/od96l1doUEO2oKfsN
         8cOg==
X-Gm-Message-State: AO0yUKUHo7l6jn0vJChZMOQ5VESrkJJRYx48vHB3oHvufpj2eJc6iaNj
        M2mngfdlDsDyUBIYuXjuZKhyt3rRZtwvJg==
X-Google-Smtp-Source: AK7set9AIv2ityQc09l8G8Eel3DdJ5gKJFHeg31rT7c1BM9g2nMHdCB5QHufFFiVI3FZvg3ttpedHQ==
X-Received: by 2002:a17:906:224d:b0:8f4:732e:40bf with SMTP id 13-20020a170906224d00b008f4732e40bfmr16114397ejr.16.1678200009590;
        Tue, 07 Mar 2023 06:40:09 -0800 (PST)
Received: from felia.fritz.box ([2a02:810d:2a40:1104:a517:a52e:cdbc:e30d])
        by smtp.gmail.com with ESMTPSA id pv16-20020a170907209000b009079442dd11sm6183861ejb.154.2023.03.07.06.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 06:40:09 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        device@lanana.org, unicode@lanana.org,
        "H . Peter Anvin" <hpa@zytor.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 2/2] docs: admin: unicode: update information on state of lanana.org document
Date:   Tue,  7 Mar 2023 15:40:00 +0100
Message-Id: <20230307144000.29539-3-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230307144000.29539-1-lukas.bulwahn@gmail.com>
References: <20230307144000.29539-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace link to a non-existing page with a note that lanana.org does not
maintain Linux Zone Unicode Assignments anymore.

Remove the reference to H. Peter Anvin and the unicode lanana.org email as
the maintainer of this file, as at this point, this is all maintained by
the general kernel community.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 Documentation/admin-guide/unicode.rst | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/unicode.rst b/Documentation/admin-guide/unicode.rst
index 290fe83ebe82..cba7e5017d36 100644
--- a/Documentation/admin-guide/unicode.rst
+++ b/Documentation/admin-guide/unicode.rst
@@ -3,11 +3,10 @@ Unicode support
 
 		 Last update: 2005-01-17, version 1.4
 
-This file is maintained by H. Peter Anvin <unicode@lanana.org> as part
-of the Linux Assigned Names And Numbers Authority (LANANA) project.
-The current version can be found at:
-
-	    http://www.lanana.org/docs/unicode/admin-guide/unicode.rst
+Note: The original version of this document, which was maintained at
+lanana.org as part of the Linux Assigned Names And Numbers Authority
+(LANANA) project, is no longer existent.  So, this version in the
+mainline Linux kernel is now the maintained main document.
 
 Introduction
 ------------
-- 
2.17.1

