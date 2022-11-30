Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C08D63DC4B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 18:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiK3Rqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 12:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiK3Rqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 12:46:31 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D22D0578CB;
        Wed, 30 Nov 2022 09:46:30 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 3C39D5C0062;
        Wed, 30 Nov 2022 12:46:30 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 30 Nov 2022 12:46:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1669830390; x=1669916790; bh=AX14omH+eL
        twVKen9On23t4YSDHGeBv/Kh1/CUrTnIE=; b=O/Ta0QsZss2vz+iVG6ZFk4XXs1
        3KefWo7WgGzXkwfy2IGOUZ9HJdDpF3HIzYmomQsfzLRMQm+S3+yJ4GFM5FjZLl1E
        qb6ryyTEqiYcTauXClTMld7WpmB78Frfgr32WjGSZoz6EYWO/MjalWJiLE15F1zY
        XF22uosHneUcpsa2UeifUTh4j7GvRpnbGOqL2yJSn+KoCkrDMnMvxH/zMM76SH3X
        aCN2ap8jJW5LGodllfPUH24wsgN48gr0N5D+pRNsItcIt6NzHjg5iLC/ITiwDb5m
        0DVj8MiBFnqtaKltVqRkDZ9Dli9g9/wIrOCmBcPL7Y29x/s6+Bhn9WqT90Ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669830390; x=1669916790; bh=AX14omH+eLtwVKen9On23t4YSDHG
        eBv/Kh1/CUrTnIE=; b=d0VMU6HOV6XtYFycWXYUSdlOw+P3pqKVfd4cmBXRXDhk
        +SrfJgJh3Sj/cz2dGBs7hW2xnLbZZ7Lmi/MnEIElyA5mWNMdDOXsDGblp1/d0e09
        /472B6YkP+0qvDh+zDgOVoC9wbchl+J2Rhtt66By3og3T2voZI0+nbgA09dV/GUB
        KMAqCI4xFPcj5ouKxrpStGgOTn5DLnuQElKuow6q504aCa7La2pBxj08vVffYOke
        DTlFGiYv4GSijFLTSmMyNBw1IiOqHmxWa1Fd+m1kTEtQYvY5jnzwPyS4F+5CwtbC
        hNhYrQDnbxgJEhvlnemC06coByK8SqDNzrVnuAIMig==
X-ME-Sender: <xms:9ZaHY7wzDMdfFiffrdhhQJ5fs6PND2OJrkgwrmjgE7gre4Ddd5NRrg>
    <xme:9ZaHYzQL87dx5rPEzGL-KLjTKYTZPcOejfUcOPF2DNhCupzskEQYCbmiyENJfwbj2
    S4XntlmWaDHxQ>
X-ME-Received: <xmr:9ZaHY1XV3BH3mOk4_n7N1doloqaw2_RRtpDn2dVRZWdJEAjTVccFFPlFKmaL2sWkqJHFtFVX3ugP6Q2lC9eszQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtdefgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:9ZaHY1if8KdKzbqyXIJXseNVsoW2TKua_qa_yEwFQpdM9zWW_mLm8A>
    <xmx:9ZaHY9CsACLOS9Vlrtc1UvP-JEioZdjX1N8SeVTb9eZjovxkjnniRw>
    <xmx:9ZaHY-IQM0bYxibdlP0sMKFjkN0kV6h5p0qhd-tdL6-umctimXPiig>
    <xmx:9paHY_3_HT9TFk0e134-fO1FPgC2xu4KdPf8CWb-sDZ20nFF3UugHg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Nov 2022 12:46:29 -0500 (EST)
Date:   Wed, 30 Nov 2022 18:46:26 +0100
From:   Greg KH <greg@kroah.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the usb tree
Message-ID: <Y4eW8vv2yeyDkAiF@kroah.com>
References: <20221130131854.35b58b16@canb.auug.org.au>
 <Y4c11VtMQ64W1U+i@kroah.com>
 <Y4c3YwZqFGhJZN1L@smile.fi.intel.com>
 <Y4eWVSmMjmntrq3U@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4eWVSmMjmntrq3U@smile.fi.intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 07:43:49PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 30, 2022 at 12:58:43PM +0200, Andy Shevchenko wrote:
> > On Wed, Nov 30, 2022 at 11:52:05AM +0100, Greg KH wrote:
> > > On Wed, Nov 30, 2022 at 01:18:54PM +1100, Stephen Rothwell wrote:
> 
> ...
> 
> > > Andy, I'm going to revert this series from the USB tree now, please fix
> > > it up and resend.
> > 
> > Sure. I think I will rename in my series list_count() to list_count_nodes().
> > This will be less invasive and should solve the issue(s).
> > 
> > $ git grep -n -lw list_count
> > drivers/block/z2ram.c
> > drivers/gpu/drm/i915/gt/intel_engine_cs.c
> > drivers/scsi/hptiop.c
> > drivers/scsi/hptiop.h
> > drivers/xen/unpopulated-alloc.c
> > 
> > $ git grep -n -lw list_count_nodes
> 
> v5 had been sent.

Thanks, I'll get to it in a few days when I catch up on USB changes.

greg k-h
