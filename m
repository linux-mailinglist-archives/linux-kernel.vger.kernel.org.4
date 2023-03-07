Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16986AD8A5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCGIDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 03:03:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjCGIDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:03:03 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62092A5CC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 00:03:01 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id i34so48849015eda.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 00:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678176180;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BxAx4EOZkORfMAuWzs/JeH95t2w3qag+oWdfBBUB6kM=;
        b=k6qUSNUP5FIr5//lJqSzfDw8dAo+4mGZob4nifmlU4RIezSarEnISfZjWdqDQajZD0
         OlcVD3xWG6LD32IzSm0tQH8wbmLFTcqWKCJwny0uz4ZUhZcocOifM2ajaJw1R0nV5e5g
         vFwwCDa6KhmrfDPX7+DorqMCoagTEvzFRIvowRr4hLLeZ3cIgnLaS+0dIWDGl9TFnjK4
         fGQF0THtFFKGeRBSYLaUxYJbVavU3jm/SeaCT9jcFCIV494BnmmXmXgyZxQ7uYGbx7Zt
         B4aQPCQ+x14gXVZ6X1MbNBzeXf9fSA0Nk6Cdx4m+WR3qrICHq6FQVsgINN23f77E1ujE
         jg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678176180;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BxAx4EOZkORfMAuWzs/JeH95t2w3qag+oWdfBBUB6kM=;
        b=hrN/GUPVgWJQkSHCO/txIyHK0wlQYlNHlL7bq4jGb/+9jSUvRhRLc929/T9FSro/DE
         BZZE0dVjfEr6OhLvzENYxnsuQDlkFvaCZuizFP0feUT34dBuhcvpHaiGNu9HqlPAtne4
         2GRRXHYsapgdBBtAggUvuwHcPUE9aeWZiI3iaw9xmOSQNSOOPwto3SOEhaq08P8vzL3f
         31SEsNjLZ9JDtfCJpzjO41GsbLXPJkFT0cmaP7PT6M5G8col/Agi8GAMI9bX6BaK/vlH
         Rd9vO9GH8AUgy0JuV5gy9QDa3a9x32beQxiMyBPkdsf8w6MFEZTquvQpytvQ/rEvpuq9
         1XJA==
X-Gm-Message-State: AO0yUKXZC5NLPrGUrAHHjGPKqDyRwlHX+fuwv7O/I3VsCmj2DPcgNQ6F
        Goybph7UVsOaCmI+Yph70L8=
X-Google-Smtp-Source: AK7set+8cHBD27Iu+YNHySdZ5+dPJGiRTjIFL911INFsD9S3odCQdHolzXA55Tet0gebjTUnFCAFbg==
X-Received: by 2002:a05:6402:14ce:b0:4ac:b528:5727 with SMTP id f14-20020a05640214ce00b004acb5285727mr14070114edx.1.1678176179879;
        Tue, 07 Mar 2023 00:02:59 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id y26-20020a170906519a00b008e53874f8d8sm5678108ejk.180.2023.03.07.00.02.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 00:02:59 -0800 (PST)
Date:   Tue, 7 Mar 2023 11:02:55 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Khadija <kamrankhadijadj@gmail.com>, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: axis-fifo: alignment should match opening
 parenthesis in axis-fifo.c
Message-ID: <78d1ea82-ef18-42b2-8a8e-27ee3c7ad55f@kili.mountain>
References: <ZAZSmPpB6fcozGa4@khadija-virtual-machine>
 <alpine.DEB.2.22.394.2303062202500.3050@hadrien>
 <CACcTnM5GR0ZM5WBaL+BDEK_0QJGr6h2t4tnsnjerHta_nq6Tmg@mail.gmail.com>
 <ab0fd80-22c-d982-2f4-6fa5f43f858@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab0fd80-22c-d982-2f4-6fa5f43f858@inria.fr>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 08:49:55AM +0100, Julia Lawall wrote:
> 
> 
> On Tue, 7 Mar 2023, Khadija wrote:
> 
> > Hey Julia! Thank you for the feedback. I will make the following changes and
> > resend the patch:
> > 1. Correct the patch description that is right under the subject line (make
> > it precise and imperative) and make sure that it does not have more than 70
> > characters per line.
> > 2. Adjust all the arguments of wait_event_interruptible_timeout so that they
> > are lined up. All of them should begin right under ( .
> 
> The problem here is that the ( is really far to the right.  My opinion is
> that the position of the second argument (ie the first one that is on a
> line of its own) is ok in this case.  So you can leave that one where it
> is and line up the other one.
> 

I kind of like lining things up like this.  I think if you can't align
things with the parens, then it's nice to at least use two tabs.  It's
not kernel style or anyone's style explicitly, but I kind of like it.

It doesn't make checkpatch happy.

I guess I probably wouldn't bother sending this patch.  To controversial.
I'd just move on to something else.  It's not like there is a shortage
of stuff to do.  One idea in this file is that you could use
sysfs_emit() in sysfs_read() and get rid of char tmp[32]; buffer.

regards,
dan carpenter

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index dfd2b357f484..0bf180cf44a6 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -383,10 +383,10 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 		 */
 		mutex_lock(&fifo->read_lock);
 		ret = wait_event_interruptible_timeout(fifo->read_queue,
-			ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
-				 (read_timeout >= 0) ?
-				  msecs_to_jiffies(read_timeout) :
-				  MAX_SCHEDULE_TIMEOUT);
+				ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
+				(read_timeout >= 0) ?
+					msecs_to_jiffies(read_timeout) :
+					MAX_SCHEDULE_TIMEOUT);
 
 		if (ret <= 0) {
 			if (ret == 0) {
