Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0821F69C609
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 08:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjBTHcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 02:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjBTHcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 02:32:06 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B91FF15;
        Sun, 19 Feb 2023 23:32:03 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 06273320098A;
        Mon, 20 Feb 2023 02:32:01 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 20 Feb 2023 02:32:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1676878321; x=1676964721; bh=QmsxFiI9TW
        RYTK8/oytqmph5JE3ZSRn6T6cWX9i06Ng=; b=s7CzRLkKC31c1SHI0oCfPzQHmy
        3Elt8J4nUZgdyAZ4w7V4VxzpHtJyLZxInuZZDDElirZRSFid4kvBnU+MQwXb5F5E
        hijqGmdk/FvDmanOE/XLSxPuTflZrptsUKUpfn0xsh4RA3189FP8ey9U3lEoYdqh
        60/cbsQ1k6MBrGFb77GJ1e0YnjZlO40kswWG+3Fl1/fRHawQexe1J7Z3PYs9o9+r
        9glsrnKWBtrajNm6MD/t0kZQjicyKsT6V/GWbjJQBFvuyqsSHL6aNCXYBXc6g2Mr
        vejiUxU8kf8r/v2+DWrJK+sbHxsi39V704WT8V6Pht/tflQizrdvA5mU/sdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1676878321; x=1676964721; bh=QmsxFiI9TWRYTK8/oytqmph5JE3Z
        SRn6T6cWX9i06Ng=; b=PplZfJb9YPyASvJXG3B1OV5usR0o3ho1oBJkd55j8ZTW
        CooYXde7duDl4DIjWmZoKTD5blpXDGZMDrNPK8sLHOO2Ec0pqiDSLmDBwI5ipSvt
        SXS1uhuvm3P369RwLx1FRYfXHd8KPAufcmsnPULWlff1Xf6cnVh0WxBVATLAON5e
        wdNbfXuzTtFXs7THw+Jkx2Fa56W7CAacKxY3B0iUo7uWC25rjttBxiKXRL2wS+rF
        sDw2AkSGaDA5KPfQ40tasSDbNU/Mx29S6KECa++EUTExN0t054NhMntFBhJ7IOcd
        RLKS258uW9xk2UHHNhQR9Pnl/kxR2rGDTA4k/c5eaA==
X-ME-Sender: <xms:8SHzY8lgREgTkCqWcNZIciwLTMrGvrrmjYibskL43oOPzqD_S5RFOg>
    <xme:8SHzY73nUwMig7qCWK4SnsEjtJxWPlEY9QGKI0erkQU7KxlUzr6-epkFOWi9-qkzT
    MkUC9olTH81hA>
X-ME-Received: <xmr:8SHzY6rRiUwSR9mJ8OxGkSqKSMc9VKd11WsUOyAOH8zqMRqqyxs3IOeeM7w_5jltjBZSbyib4pWHW54hNbGR80N3umLVgZpop1i5Gw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejgedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:8SHzY4ltqGIEyQe3RO1Trd3u8kP-fBy0vYxlCFbpLWjXt-j-jZSeXw>
    <xmx:8SHzY619r1jfeb4WKwwef6hH0xHLeqE8gTKO5ilhwbBn8G0fp9iPvg>
    <xmx:8SHzY_uMBNB29a-3FK3oUoZp1mGCq1VRsuPaDyf_FWnPftp104i4Rw>
    <xmx:8SHzY0qKn8jw1sNypNLj3gcs5njfnNaPUZgCRymXRPYTcWYExSZ2XQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Feb 2023 02:32:00 -0500 (EST)
Date:   Mon, 20 Feb 2023 08:31:58 +0100
From:   Greg KH <greg@kroah.com>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the driver-core tree
Message-ID: <Y/Mh7uA61KMvMHAt@kroah.com>
References: <20230220163133.481e43d8@canb.auug.org.au>
 <896c1146-21bb-35bb-dc25-a12014eb5ccd@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <896c1146-21bb-35bb-dc25-a12014eb5ccd@bytedance.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 03:26:41PM +0800, Qi Zheng wrote:
> 
> 
> On 2023/2/20 13:31, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the driver-core tree, today's linux-next build
> > (htmldocs) produced this warning:
> > 
> > Documentation/filesystems/api-summary:146: fs/debugfs/inode.c:804: WARNING: Inline literal start-string without end-string.
> > 
> > Introduced by commit
> > 
> >    d3002468cb5d ("debugfs: update comment of debugfs_rename()")
> 
> This is just a comment modification. Didn't see where my modification
> caused this WARNING. :(

Yeah, I don't understand either, here's the diff, what's wrong with it?


--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -802,8 +802,8 @@ EXPORT_SYMBOL_GPL(debugfs_lookup_and_remove);
  * exist for rename to succeed.
  *
  * This function will return a pointer to old_dentry (which is updated to
- * reflect renaming) if it succeeds. If an error occurs, %NULL will be
- * returned.
+ * reflect renaming) if it succeeds. If an error occurs, %ERR_PTR(-ERROR)
+ * will be returned.
  *
  * If debugfs is not enabled in the kernel, the value -%ENODEV will be
  * returned.
