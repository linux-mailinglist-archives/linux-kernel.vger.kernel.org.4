Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07376C118E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbjCTMKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjCTMKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:10:42 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D83F113D4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 05:10:39 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id t5so9003917edd.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 05:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679314237;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lejGXvtxYXPbRbirbLrzty70j8ZQG2QJS1aPe94BDQ0=;
        b=JsaW7C+nAECp/HhGauljm8wmqVzAsC/nrlVXgaaVojvuNY08+jfmVumCbRqCi1cShv
         D46LiHX02jZ1AhFY4aRc6qhjdoNU/v1xjyt6RYmFGMNn7cz56B53GUIomyHDc1ZhIFT1
         a0ly2IFDqA8zI3nZdGNvM70XSD+lX4BMAgndCw1pC68obu20QjYQBxC9KFtEwgbKuTVI
         FyJko3QWQwu49mF3HzXJB8ojP+ec9Jp5nK1vnLPURfrQft5jkDbn3CyLho3FxZ9BUVza
         mqZD+m/s5KnSGn1QVZ8dhHSDdFHHOEIaPDj6NI/PMOGYLL5SUiUsJoAPbSOs/bUPoAuM
         6WFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679314237;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lejGXvtxYXPbRbirbLrzty70j8ZQG2QJS1aPe94BDQ0=;
        b=o88pDaWzxpF7ypVpY60s2kbScSkESh7Zv/L5n2gZAyXDBGoIZ6XOTZczha8KhXgRZO
         +5krLk9M0uDkSEQ0kdZ6pJyUbtfILeyMO17lP83pRssrw+t5M5A8RSUP9470ptqUULor
         jwqU6VRKXcgSuW8AfiwhyffpLoMxtJwsVRL6yqJG4STsdEi3TTPucdzm7e3CAr4j+aSQ
         6rXsVG0KOF/2JmdZUa2ZisuxlwVSe8o68MKYxZ0LihJczdTPFP86UGLeGWf5cpPAkN3u
         +m9M/NfTCmqdzKTTldEDL+QeGeRRsy2I5J1hFHsvqWgoYeBv7ZP9q893uJZqP8JtO4c2
         /zfQ==
X-Gm-Message-State: AO0yUKVzS5GMgqbjUC+GkUcRD3+M5Jr9LH3OlBV5cC5HtvE0Z20XNAXK
        9v8Fd7w4/urKyH2E3bLCHJ62CqjI3/6lr+Pmmh8=
X-Google-Smtp-Source: AK7set9IVH1ZPd+u+qXJXskzpIA4kaSshW23le6se8QUxh4nKLX0DNUggBx6rPK4R2KEJ8bchoKneg==
X-Received: by 2002:a17:906:bcf4:b0:920:7a99:dcd4 with SMTP id op20-20020a170906bcf400b009207a99dcd4mr9151233ejb.62.1679314237193;
        Mon, 20 Mar 2023 05:10:37 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id e14-20020a170906044e00b0093204090617sm4059402eja.36.2023.03.20.05.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 05:10:36 -0700 (PDT)
Date:   Mon, 20 Mar 2023 17:10:34 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: greybus: fix line ending with '('
Message-ID: <ZBhNOkQbG4ygNF98@khadija-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Splitting function header to multiple lines because of 80 characters per
line limit, results in ending the function call line with '('.
This leads to CHECK reported by checkpatch.pl

Move the first parameter right after the '(' in the function call line.
Align the rest of the parameters to the opening parenthesis.

Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
---
 drivers/staging/greybus/audio_topology.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/greybus/audio_topology.c b/drivers/staging/greybus/audio_topology.c
index 62d7674852be..08e6a807c132 100644
--- a/drivers/staging/greybus/audio_topology.c
+++ b/drivers/staging/greybus/audio_topology.c
@@ -24,9 +24,8 @@ struct gbaudio_ctl_pvt {
 	struct gb_audio_ctl_elem_info *info;
 };

-static struct gbaudio_module_info *find_gb_module(
-					struct gbaudio_codec_info *codec,
-					char const *name)
+static struct gbaudio_module_info *find_gb_module(struct gbaudio_codec_info *codec,
+						  char const *name)
 {
 	int dev_id;
 	char begin[NAME_SIZE];
--
2.34.1

