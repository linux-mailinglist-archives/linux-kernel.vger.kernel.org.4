Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46AFA6FBCC0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 03:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbjEIBvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 21:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234169AbjEIBvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 21:51:31 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BD9D07E;
        Mon,  8 May 2023 18:51:01 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64115e652eeso39074740b3a.0;
        Mon, 08 May 2023 18:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683597059; x=1686189059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6dC7RqULScM3cUuSiw/pxvquCOcwrRPE1SiWm7WCEb0=;
        b=HXZsHlbIhzqti5tgJYiPvXUl+AJNb4YJD4WPyehn7JumU60rY1LJ19vOZkS4pTR4SH
         uvPKNk2AWKs4sMWXJSu4YHq2V9fL93fJOqYK4AM2vL2/0T2a0p0gKZvwHXwwinBnTGyv
         xm1MMLptr/rfEVaC1aP7K2emb+bC2ZTUkMgStaekVIeNPN2lsAgv87HG8vPxFtW6WomP
         y9+8YGpZ+c6cN2/hklGRg49a20646oWxbJZdKscD6gX81fndKjQ4GE1nuG6fXr+a+uoh
         z7UcCDvFyHbd9N/7u/MGcE3yXRzfOALk5il1nxfU4SKdmMTDwIjlPXv78NXQRhips99r
         4QBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683597059; x=1686189059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6dC7RqULScM3cUuSiw/pxvquCOcwrRPE1SiWm7WCEb0=;
        b=DdvOwwGIOsB/X9P93PiCqeV2VcmjPEzJ3vBLY0lL0H7ht9OV0YZCxIEM4z5D8CA2n2
         7LUZmct8iXiXOKqE+5np0RVoK238opzUslu6LKCMj+ZqIKevSxgECjUpVZeoX0Qy4abG
         KsRgocOiXc9A4UeNC0jVvHnlWsj2Xu00jSGu+NWya7+90FN06aIsLkDT0evk86raWuA0
         83Msl5v8qTlOr1897i3SYfKovLZfxFARPtrKKCCIe3rY4OPJGsL8+nars5l2A5H0vNzi
         YCCjLzS3cQRRa2CPC5Vgdp2CyJDdxDYlydMpl4BPUKZ67yrIYF6rXNeaGzbqVSoXP9tB
         OVjg==
X-Gm-Message-State: AC+VfDxI8CO6q6g/COzXdlfmGFwQDe9oWLSOMYHoOjaKzQXUeEk0aqOr
        NgD1uIe+tpFxo03S7hQ8CRDXE0MLPgA=
X-Google-Smtp-Source: ACHHUZ4O20Bayud9t8g10s/GUlyir7MjD8/LL/ukziPWc7W0njWQGjmCOGPwCusOrDQ+OK8FsxPTFA==
X-Received: by 2002:a05:6a20:5495:b0:100:6a95:c288 with SMTP id i21-20020a056a20549500b001006a95c288mr6154056pzk.7.1683597058725;
        Mon, 08 May 2023 18:50:58 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id p5-20020aa78605000000b006438898ce82sm589449pfn.140.2023.05.08.18.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 18:50:58 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: [PATCH 12/13] media: coda: Use alloc_ordered_workqueue() to create ordered workqueues
Date:   Mon,  8 May 2023 15:50:31 -1000
Message-Id: <20230509015032.3768622-13-tj@kernel.org>
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
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org
---
 drivers/media/platform/chips-media/coda-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/chips-media/coda-common.c b/drivers/media/platform/chips-media/coda-common.c
index d013ea5d9d3d..ac9a642ae76f 100644
--- a/drivers/media/platform/chips-media/coda-common.c
+++ b/drivers/media/platform/chips-media/coda-common.c
@@ -3268,7 +3268,7 @@ static int coda_probe(struct platform_device *pdev)
 						       &dev->iram.blob);
 	}
 
-	dev->workqueue = alloc_workqueue("coda", WQ_UNBOUND | WQ_MEM_RECLAIM, 1);
+	dev->workqueue = alloc_ordered_workqueue("coda", WQ_MEM_RECLAIM);
 	if (!dev->workqueue) {
 		dev_err(&pdev->dev, "unable to alloc workqueue\n");
 		ret = -ENOMEM;
-- 
2.40.1

