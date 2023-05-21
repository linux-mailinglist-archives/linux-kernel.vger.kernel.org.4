Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D592E70AC14
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 04:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjEUCsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 22:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjEUCsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 22:48:10 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4EA107;
        Sat, 20 May 2023 19:48:09 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5144a9c11c7so4320886a12.2;
        Sat, 20 May 2023 19:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684637289; x=1687229289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a79Vo58JHfGLRFzTXzs92sJx4IbsuI16qLQD+jJeNPA=;
        b=VcUmjPfbxHa8Y8zJZxES3rJVjF2vnytlrj62kXk/JM/oI0QIAO1B2/OX5zBcPA7d55
         VWNPwFwLr5l8DqK0NFllNCV00YbN1XGamRoNNwG7yYaltB9aCuHgdHYQTNUZkleTTpLA
         GbzcE84jggJH/xwkRfTSpBYXiWcoQ89r6RbhpIh3Cx0bXbzcO3yIV/Xqdyqd2CTT38cg
         B/FUSz5x03Q5zT1B71YIfvfDaOSlDCQ61m+WfzG/J+wijsvsxIzmTqqdWw0iCY5NdVsb
         /ejGy4suawhHWpt8XfBIOrPyuQhE4UMWFxb3cpvC8gVxW14N6OBNK33IcoQDSIHNNEWQ
         JRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684637289; x=1687229289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a79Vo58JHfGLRFzTXzs92sJx4IbsuI16qLQD+jJeNPA=;
        b=f3vsLHnMyG/cLnqvwMogbUmqAv2X46oFc3JNJBT6mcVxP+nUNVxwc4TuRfD263L1Cf
         fbUQ/rIwCWLZMnkPioi1BeUb1w/rBNJckjPSJVuz4XeNMyjDV/jsTeGR8vfDLNWsSUpK
         LcR8/wJ2/Uls5OFyRifyu5y2njtMWEUMwmovB5iYqT8Mqy+qnw7mUe/tx2VvI7lrhVeS
         x/zrZAH9Qzz/W0S2Qb+gQHxSo9WcArFPBlmyuEcsPDf3QYWvxcg5DERJBd636w2yxV9A
         pJAAaHoloxQSQVTbWzCvvF1dyAULusQiOl8K/LloCG9kfYmgqZeNrkVhutoShHdPWLKQ
         dMRw==
X-Gm-Message-State: AC+VfDw0dDnP+vqxpEnJ5oMCG/QAyLU5k8m06oXozbpjajg2fPkunSDM
        Y1U1F9Q6ZJnBEo0maV+671c=
X-Google-Smtp-Source: ACHHUZ4BD05o4GzaiREoSuGK621jLhb8v4fkssb2Er1Fg6IRWkbz9g67DxnIRLx8LWlWW8AbGx/aGw==
X-Received: by 2002:a17:902:d345:b0:1a2:6257:36b9 with SMTP id l5-20020a170902d34500b001a2625736b9mr7604627plk.31.1684637288836;
        Sat, 20 May 2023 19:48:08 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id jh9-20020a170903328900b001a6f7744a27sm2191910plb.87.2023.05.20.19.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 May 2023 19:48:08 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sat, 20 May 2023 16:48:07 -1000
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Finn Thain <fthain@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH RESEND 01/13] scsi: ncr53c8xx: Use default @max_active for
 hostdata->work_q
Message-ID: <ZGmGZxYmN0En7wAB@slm.duckdns.org>
References: <20230509015032.3768622-1-tj@kernel.org>
 <20230509015032.3768622-2-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230509015032.3768622-2-tj@kernel.org>
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

From: Tejun Heo <tj@kernel.org>
Subject: scsi: ncr53c8xx: Use default @max_active for hostdata->work_q

hostdata->work_q only hosts a single work item, hostdata->main_task, and
thus doesn't need explicit concurrency limit. Let's use the default
@max_active. This doesn't cost anything and clearly expresses that
@max_active doesn't matter.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Finn Thain <fthain@linux-m68k.org>
Cc: Michael Schmitz <schmitzmic@gmail.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
Hello,

Resending because I screwed up the cc list in the original posting. The
whole series can be viewed at:

  http://lkml.kernel.org/r/20230509015032.3768622-1-tj@kernel.org

It's not a must but it'd be great if I can route this through the workqueue
tree so that it can go together with other related and followup cleanups.

Thanks.

 drivers/scsi/NCR5380.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/NCR5380.c
+++ b/drivers/scsi/NCR5380.c
@@ -417,7 +417,7 @@ static int NCR5380_init(struct Scsi_Host
 	INIT_WORK(&hostdata->main_task, NCR5380_main);
 	hostdata->work_q = alloc_workqueue("ncr5380_%d",
 	                        WQ_UNBOUND | WQ_MEM_RECLAIM,
-	                        1, instance->host_no);
+				0, instance->host_no);
 	if (!hostdata->work_q)
 		return -ENOMEM;
 
