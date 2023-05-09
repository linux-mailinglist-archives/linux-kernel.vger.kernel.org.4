Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC0B6FBCC2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 03:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234284AbjEIBvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 21:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234167AbjEIBvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 21:51:31 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCF59EF3;
        Mon,  8 May 2023 18:50:59 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64395e2a715so5178880b3a.3;
        Mon, 08 May 2023 18:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683597057; x=1686189057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4f4E1+rA4dHfPSu/M3jA+g54pakUhc0stJxnLeN1Fs=;
        b=BlC5e7sLPZcdnhGY9IdaZcf6A0c4mdvoKJTXiiChnnwy3x5RM8qM7xkAP0OVbMQaeW
         MR3fcwXTNXAnyJWfklwKLK4Wets4jaq7tMX/6qGkC4e/KnUzhIGo1LMHJmvqaWpg7H6t
         EJ2KqP10bIIhBuEDZiZ1yF5VKoXCvdV7bJ/oy/AttGnBg+cQJPeS91PtzTDi35LMH3/n
         sRRodVOwL/YgILFkdVlMafLyauE+lc+mS/5klszWC3n+YKzsk4YJ/gSU044e6RMak5bG
         GyZCnUUHTd5XJZDOH68e1lXrcHLBvLzB2hlUojtfAuupnCfaVlkmlCHj1tAjl7u8UdoT
         27nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683597057; x=1686189057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r4f4E1+rA4dHfPSu/M3jA+g54pakUhc0stJxnLeN1Fs=;
        b=TtJBBCrkFVWzxUhNNynjjB4fkk/xoGh1OkctoYFwVtKUEw1yOHXnww5hHv5t2nL27U
         f1pK1C3wIH7lwPsx2DyTdxiDGz/SZNIRsxtmQzCLrTBNFzZYd83TvD8w9rXp1I/MRQtI
         9TtJw/UDm0Rw8dCg3HnwfXnaiDmA6p4C468Q2kOoxBGgSPGZRurr/oDmJfurF/HBDvuq
         IW54p8PiEbTmEx5lDkn6uCGZLqlL1IFfgeCAk0XutKXiigDwtR/dZPxIA3vUtn/HAeYh
         yjLSlrpHh7tRv3pqwCjz1gtWM9EH90UrQyEm/Zbx5O++ivjqwwx08fF4FU1HGzROCzTF
         6QrQ==
X-Gm-Message-State: AC+VfDyN5OsY50FuLzdexjot5/GDe9HWURv2GZyjJG1D++MI3B8dvZtL
        WJk1ViNGKp9n6vnSy8c6auE=
X-Google-Smtp-Source: ACHHUZ78UP2KJlfYM2yhQBOhZcrpnls7iwQOh8gZKajnLTG0xzmGlHeQE6xKDmmCEP5FF6c1tSzwWw==
X-Received: by 2002:a05:6a00:2310:b0:642:fbed:2808 with SMTP id h16-20020a056a00231000b00642fbed2808mr16104761pfh.25.1683597056841;
        Mon, 08 May 2023 18:50:56 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id y9-20020a62b509000000b0063f0c9eadc7sm534263pfe.200.2023.05.08.18.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 18:50:56 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Arnaud Ebalard <arno@natisbad.org>,
        Srujana Challa <schalla@marvell.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Shijith Thotton <sthotton@marvell.com>,
        Vladis Dronov <vdronov@redhat.com>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Alexander Lobakin <alobakin@pm.me>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        ye xingchen <ye.xingchen@zte.com.cn>,
        linux-crypto@vger.kernel.org
Subject: [PATCH 11/13] crypto: octeontx2: Use alloc_ordered_workqueue() to create ordered workqueues
Date:   Mon,  8 May 2023 15:50:30 -1000
Message-Id: <20230509015032.3768622-12-tj@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509015032.3768622-1-tj@kernel.org>
References: <20230509015032.3768622-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BACKGROUND
==========

When multiple work items are queued to a workqueue, their execution order
doesn't match the queueing order. They may get executed in any order and
simultaneously. When fully serialized execution - one by one in the queueing
order - is needed, an ordered workqueue should be used which can be created
with alloc_ordered_workqueue().

However, alloc_ordered_workqueue() was a later addition. Before it, an
ordered workqueue could be obtained by creating an UNBOUND workqueue with
@max_active==1. This originally was an implementation side-effect which was
broken by 4c16bd327c74 ("workqueue: restore WQ_UNBOUND/max_active==1 to be
ordered"). Because there were users that depended on the ordered execution,
5c0338c68706 ("workqueue: restore WQ_UNBOUND/max_active==1 to be ordered")
made workqueue allocation path to implicitly promote UNBOUND workqueues w/
@max_active==1 to ordered workqueues.

While this has worked okay, overloading the UNBOUND allocation interface
this way creates other issues. It's difficult to tell whether a given
workqueue actually needs to be ordered and users that legitimately want a
min concurrency level wq unexpectedly gets an ordered one instead. With
planned UNBOUND workqueue updates to improve execution locality and more
prevalence of chiplet designs which can benefit from such improvements, this
isn't a state we wanna be in forever.

This patch series audits all callsites that create an UNBOUND workqueue w/
@max_active==1 and converts them to alloc_ordered_workqueue() as necessary.

WHAT TO LOOK FOR
================

The conversions are from

  alloc_workqueue(WQ_UNBOUND | flags, 1, args..)

to

  alloc_ordered_workqueue(flags, args...)

which don't cause any functional changes. If you know that fully ordered
execution is not ncessary, please let me know. I'll drop the conversion and
instead add a comment noting the fact to reduce confusion while conversion
is in progress.

If you aren't fully sure, it's completely fine to let the conversion
through. The behavior will stay exactly the same and we can always
reconsider later.

As there are follow-up workqueue core changes, I'd really appreciate if the
patch can be routed through the workqueue tree w/ your acks. Thanks.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Boris Brezillon <bbrezillon@kernel.org>
Cc: Arnaud Ebalard <arno@natisbad.org>
Cc: Srujana Challa <schalla@marvell.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Shijith Thotton <sthotton@marvell.com>
Cc: Vladis Dronov <vdronov@redhat.com>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Alexander Lobakin <alobakin@pm.me>
Cc: Minghao Chi <chi.minghao@zte.com.cn>
Cc: ye xingchen <ye.xingchen@zte.com.cn>
Cc: linux-crypto@vger.kernel.org
---
 drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c | 12 ++++++------
 drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c |  6 +++---
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c b/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
index ddf6e913c1c4..30e6acfc93d9 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptpf_main.c
@@ -357,9 +357,9 @@ static int cptpf_vfpf_mbox_init(struct otx2_cptpf_dev *cptpf, int num_vfs)
 	u64 vfpf_mbox_base;
 	int err, i;
 
-	cptpf->vfpf_mbox_wq = alloc_workqueue("cpt_vfpf_mailbox",
-					      WQ_UNBOUND | WQ_HIGHPRI |
-					      WQ_MEM_RECLAIM, 1);
+	cptpf->vfpf_mbox_wq =
+		alloc_ordered_workqueue("cpt_vfpf_mailbox",
+					WQ_HIGHPRI | WQ_MEM_RECLAIM);
 	if (!cptpf->vfpf_mbox_wq)
 		return -ENOMEM;
 
@@ -453,9 +453,9 @@ static int cptpf_afpf_mbox_init(struct otx2_cptpf_dev *cptpf)
 	resource_size_t offset;
 	int err;
 
-	cptpf->afpf_mbox_wq = alloc_workqueue("cpt_afpf_mailbox",
-					      WQ_UNBOUND | WQ_HIGHPRI |
-					      WQ_MEM_RECLAIM, 1);
+	cptpf->afpf_mbox_wq =
+		alloc_ordered_workqueue("cpt_afpf_mailbox",
+					WQ_HIGHPRI | WQ_MEM_RECLAIM);
 	if (!cptpf->afpf_mbox_wq)
 		return -ENOMEM;
 
diff --git a/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c b/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
index 392e9fee05e8..6023a7adb70c 100644
--- a/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
+++ b/drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c
@@ -75,9 +75,9 @@ static int cptvf_pfvf_mbox_init(struct otx2_cptvf_dev *cptvf)
 	resource_size_t offset, size;
 	int ret;
 
-	cptvf->pfvf_mbox_wq = alloc_workqueue("cpt_pfvf_mailbox",
-					      WQ_UNBOUND | WQ_HIGHPRI |
-					      WQ_MEM_RECLAIM, 1);
+	cptvf->pfvf_mbox_wq =
+		alloc_ordered_workqueue("cpt_pfvf_mailbox",
+					WQ_HIGHPRI | WQ_MEM_RECLAIM);
 	if (!cptvf->pfvf_mbox_wq)
 		return -ENOMEM;
 
-- 
2.40.1

