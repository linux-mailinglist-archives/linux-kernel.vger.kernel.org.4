Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1159F62785C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbiKNJAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236662AbiKNJAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:00:05 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5631CFFC;
        Mon, 14 Nov 2022 01:00:04 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 21A033200919;
        Mon, 14 Nov 2022 04:00:03 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 14 Nov 2022 04:00:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1668416402; x=1668502802; bh=mVnSj1iJ99
        XRSH8Flsh+M/LkbPmD6UmUFvX6v++TUpU=; b=a378pGvuyqgTQZMPJ5Ie0bWA+S
        9tu8Bkh1p30mk6d6j01puqm61I1ytb1aXPmWMIRYJD2daavESZTmcvj34348tikd
        SpKk4yGahMSWbP1m4LR553pEc9i5hLdXTtl+v2i+srD6qAq/XfBfUiDjfmMrgiAK
        mmUrywWza5dgttnfmAmNLVmIF4H6EIWf70WvaFrO3EsyamVdONlOg0bXt1T+NEEf
        n+/TQV7ZgMIrlvUX6jarNJk32Vv7ksTbTkVODWfuokB0apx0wFEvly95M1qikl2l
        zWBOJ7t1kdIVMD958rxXGSG8NTUhsI9R9C4NgGQ8u4ijUk3yCWcrTaToTsTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668416402; x=1668502802; bh=mVnSj1iJ99XRSH8Flsh+M/LkbPmD
        6UmUFvX6v++TUpU=; b=fCJ9vVBwAqFvg+iKECAeJX0pPiIPwvr2MPRiCCeeA7P7
        yPwl9h1bzgrYLoChxID3UqZare+3OwcgeH0HHX+4C1su8318+H+sUqqYbEW8NCXu
        8Fy+YfL0LTwKxzhfk9BwyR4oqmCKkzYBzZnc8MukbXilOn5wgUjcaLXcCEJNQn0e
        cCKp7PvfU5AWTR5YhfC+nm82lhKggjdFiNILs+5IaOgJ+LEcmcJyOzysUdk36Q5h
        mkMfew8AEso8hPP8gYrbsYX2Ke9NR+ugNt3w0icPNeMT7FkYaOMjGYQFqG10tu7l
        L/II/95/8ab9dvAyWWcn/QEPX5TDePZLKQn5RtWQfg==
X-ME-Sender: <xms:kQNyY8JT6EDXLsCMPf8b-Q-ekPhlF-9hbn1GqQwGe_3gxwoH5aD-wA>
    <xme:kQNyY8IR-hg2ImWGZQGSYqAsWYVc-W3gsrpu_oDQgyGneyJYg3x3d-TrFgN3s3IvE
    dzq_ZuHxdw_9w>
X-ME-Received: <xmr:kQNyY8szpuDUZLyUREPSV26pYKg4CTXZrY6nXbZQnaU1_k2v9u9vIfVsBNVImSHw6qv_iy_DTlZOF3mboNd1voB29SVeRXfs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedugdduvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgeehue
    ehgfdtledutdelkeefgeejteegieekheefudeiffdvudeffeelvedttddvnecuffhomhgr
    ihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:kQNyY5bbUwcc3UujRnqSwJj53__8IjCnVR3ePaPe_TyIK_vOz6zbQQ>
    <xmx:kQNyYzYHiTTgZsDNdroHxzrT6-Ynws6-aUfre350bc9MfKwzaJGISw>
    <xmx:kQNyY1AygXWvN-Wv_WmtGZe2y6oJ_42cz_NrC6RfZpI-t8cNW7OrmQ>
    <xmx:kgNyY4Mt-qoJUKBkhwhl-bIynzd3pPsYZYr3P7L6u3k_wqqEQ94ttQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Nov 2022 04:00:01 -0500 (EST)
Date:   Mon, 14 Nov 2022 09:59:57 +0100
From:   Greg KH <greg@kroah.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the driver-core tree
Message-ID: <Y3IDjSYTeC0xt/Cw@kroah.com>
References: <20221114151235.01e5ff3b@canb.auug.org.au>
 <Y3IASgDYdKElTfIa@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3IASgDYdKElTfIa@smile.fi.intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 10:46:02AM +0200, Andy Shevchenko wrote:
> On Mon, Nov 14, 2022 at 03:12:35PM +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the driver-core tree, today's linux-next build (arm
> > multi_v7_defconfig) failed like this:
> > 
> > drivers/mfd/vexpress-sysreg.c:64:51: error: initializer element is not constant
> >    64 |                 .resources = (struct resource []) {
> >       |                                                   ^
> > drivers/mfd/vexpress-sysreg.c:64:51: note: (near initialization for 'vexpress_sysreg_cells[0]')
> > drivers/mfd/vexpress-sysreg.c:73:51: error: initializer element is not constant
> >    73 |                 .resources = (struct resource []) {
> >       |                                                   ^
> > drivers/mfd/vexpress-sysreg.c:73:51: note: (near initialization for 'vexpress_sysreg_cells[1]')
> > drivers/mfd/vexpress-sysreg.c:82:51: error: initializer element is not constant
> >    82 |                 .resources = (struct resource []) {
> >       |                                                   ^
> > drivers/mfd/vexpress-sysreg.c:82:51: note: (near initialization for 'vexpress_sysreg_cells[2]')
> > drivers/mfd/vexpress-sysreg.c:90:51: error: initializer element is not constant
> >    90 |                 .resources = (struct resource []) {
> >       |                                                   ^
> > drivers/mfd/vexpress-sysreg.c:90:51: note: (near initialization for 'vexpress_sysreg_cells[3]')
> > 
> > Caused (probably) by commit
> > 
> >   52c4d11f1dce ("resource: Convert DEFINE_RES_NAMED() to be compound literal")
> > 
> > I have used the driver-core tree from next-20221111 for today.
> 
> Fix is available here:
> https://lore.kernel.org/lkml/20221113191027.2327-1-andriy.shevchenko@linux.intel.com/

Thanks, I'll pick that up now.

greg k-h
