Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C906C7DF8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 13:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbjCXMXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 08:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231866AbjCXMXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 08:23:34 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E935D12CC4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 05:23:30 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 388B85C0004;
        Fri, 24 Mar 2023 08:23:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 24 Mar 2023 08:23:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1679660608; x=1679747008; bh=aD
        2UA5E29QEfByv64DrI/4DS7DP5G4kjTU4vbcnxAMY=; b=CxQ52tws/Yua7iK8ll
        Q+RQR5xnFC/zioBSW82xyHQRx0EF3u4V9KDfLTfkQXdeNFx8j4BMmdVX2QTKn6SI
        aM/zQJ8VmNa4lC4wwngAbxgAnIVD+ySzoz5eeTj3G5XXtrBsNVLsqX2MJuIPT/F3
        Y+UHbLJJFw99T6NGS644IwmDhdIwftvNINY8e33c0IP3JdjL/s14LNNuHgvzEdz6
        PAzCARQFkag3o0ufrxupWAt6llB1p+nMOWhO1O7Ql4GnICuvrCv93EGJ7DqnDb2C
        gszsqc1h4aOSb7SREsIcsfcz0B9lW+q09RRq19TTj7MjngLaVyNpoQI/t5vIf9WB
        CqIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679660608; x=1679747008; bh=aD2UA5E29QEfB
        yv64DrI/4DS7DP5G4kjTU4vbcnxAMY=; b=smQnfMlmvrOH/xYHLNdWQu3WDuAnY
        tnVAsQtGJaYnbxLxl+cx/T34Gof/xQGYL+CoCIqrKBPgEM3IvDsS3BTQ7ux71Ecq
        tt4DIk5wGheqUBsKWFNcb7jAYHz7whHqd9eTPDGiUCOQPaWvMzabD21agO7TjBqP
        oNhY9Iio59a2LL2ZEWxbpHQFKb6QcRq10rKed5mx3ppDAeoVKfKQyt9NKGz3TYtU
        kjm/LCn1Pj9LVzHpgHkotGcrvFDTtIYmapR/v/w3CbaDE9tu8VseosV1+6PQT0XY
        r9akZ7ZVvORR2M7Usjx3wGjozJQjisMiRtZp5tevjGI0brfXMz4t1lheA==
X-ME-Sender: <xms:QJYdZJd6WI8mWicyPruxWQXBO6VSM3y_V6D8PsiQFKSbgY2vBeaUGw>
    <xme:QJYdZHP4-cNhrZpnmE1rukcqRlNUXfclrcfSQYDPIx9XyggT7bDAK83GsAijevPA9
    bf1htuNauQcMA>
X-ME-Received: <xmr:QJYdZChzCsJfrX3RQx2x8AWrj9PcxxwmRJv9OYzjkdj7CyvfIuLGE2oFU9pFh8TYHnyQ1Ja0skp5txdjNZj0LMzqh8DWhfvkBwoPlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegiedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepfdhgrhgv
    gheskhhrohgrhhdrtghomhdfuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrg
    htthgvrhhnpedvffejjeekfeeiudffkeeigedvvdfggefhtdeujeelfeekheehkeegveei
    hfeukeenucffohhmrghinhepkhgvrhhnvghlnhgvfigsihgvshdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgr
    hhdrtghomh
X-ME-Proxy: <xmx:QJYdZC9krB911JEb-7qqLorMEfaOhtR2eid24nsX52dQRJwI-PgLfA>
    <xmx:QJYdZFumALhfcJ59K9NENKUx_8r7BeFVGHeyKHu-z8QC8uGgVaabDQ>
    <xmx:QJYdZBEzh7SIGcSKmCOUM13_lxs9dlsra7pxkXALqFtyGtLQj72xSA>
    <xmx:QJYdZJizRe4rMwDphQ4ny5ufPAyQMh-VXIEmL8g0i7iPXNc23uUrbA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Mar 2023 08:23:27 -0400 (EDT)
Date:   Fri, 24 Mar 2023 13:23:25 +0100
From:   "greg@kroah.com" <greg@kroah.com>
To:     Gary Rookard <garyrookard@linuxmail.org>
Cc:     "abbotti@mev.co.uk" <abbotti@mev.co.uk>,
        "hsweeten@visionengravers.com" <hsweeten@visionengravers.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: comedi
Message-ID: <ZB2WPf5fvNTDjQJJ@kroah.com>
References: <B0081165-3F00-46D9-BD46-CB5A07D988BB@getmailspring.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B0081165-3F00-46D9-BD46-CB5A07D988BB@getmailspring.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 07:51:18AM -0400, Gary Rookard wrote:
> >From ff0a68124526ea1ac003fbfdd4de47e347881dfe Mon Sep 17 00:00:00 2001
> From: Gary Rookard <garyrookard@linuxmail.org>
> Date: Thu, 23 Mar 2023 16:10:12 -0400
> Subject: [PATCH] Staging: comedi: comedi_fops: fixed missing blank line coding
> style issues
> 
> Fixed/added 3 blank lines to resolve issues, comedi_fops is checkpatch clean.
> Signed-off-by: Gary Rookard <garyrookard@linuxmail.org>

As Ian pointed out, this was fixed a very long time ago.  Please always
work against the latest kernel tree so you don't duplicate work that was
already done.

I suggest going through the tutorial on kernelnewbies.org as well, this,
and the previous submission, had a number of problems (hint, this patch
was corrupted and couldn't be applied.)

good luck!

greg k-h
