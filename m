Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D95A679F69
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 18:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbjAXRCD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 12:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbjAXRCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 12:02:00 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CBE4B1BE;
        Tue, 24 Jan 2023 09:01:59 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id C5B285C0316;
        Tue, 24 Jan 2023 12:01:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 24 Jan 2023 12:01:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1674579717; x=1674666117; bh=xbrz6SCwKn
        Yqh4vhdua4HKD2oPexvSgzujn4R8eXrRY=; b=lktfyKWnLsOfxuZm6d1r3UqsGj
        TFcPh6CWNVJMTRdyMmwU+mcBY8xbUjn2hoowcrgSazmDvnnlp+9N009Y7KHrdwFv
        EsPDjchnCQCZKfPQJS7uPNtXh3GkUQrC94bH4ZChwwq9GTLUptZh0521i+d7looT
        rEflRKLhCPbBG9c3Y5lOkPJOBe5yU9MgjyBMwoLbNc0YSSHwFA2sgX+kvL0dKqJ/
        YciAbNT0dngH89zy0uFc65mLuuO/32C/njCRn+7jGWkrcvJxo84yVngEVs+Yud6m
        Fn+vqvIbsOHpAV/b1Jn4f15dEzktcK55m5TcnuiQeQkW0yevf+Oj1x7HtGlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674579717; x=1674666117; bh=xbrz6SCwKnYqh4vhdua4HKD2oPex
        vSgzujn4R8eXrRY=; b=j+vrakw/uFZ7OAPzq23SNPkXYxs8qXAtxzDdZDtsTzrF
        HOKg3EhetiCw2UxHFlV0Qw5xBG8RLWCJk4KS+d1jzS5nLMfjnFvDx3E8/BLHmX/C
        vocf+0Ua+lsU7IxVabQ29Pk5E9D1ECuzF6IJo61z/sr5NrAMD5DAGaznGTGsTnIV
        2wPA+Bn3MVkNaTK0lOS5K7yChUFU9KZhDRMXhyBoEHuLEOTulvbyGGvRucRuoDso
        PD1cIEoKM0b+7IydfvD+it2PgCu9qOfNDzA4GeOs9YLFJ4015apr7gY9MDTYObIY
        H6ATrUL8RVOtA3Pl3VVRvugoumyf62U1a0KwrZvRUw==
X-ME-Sender: <xms:BQ_QY-vA4sBpwTp9LB1Dfxb1wQjpreJUfaBgh-DxUKR3wHIrQVXZUg>
    <xme:BQ_QYzdiecTKUrs0SXqbjKMVm3BKcQSWh34yxbr6RLqIlRLKp2myNZjIJ-dma71R-
    rxFyWMsP69QGg>
X-ME-Received: <xmr:BQ_QY5yTAOrJIWhvBPixchU9Dw4gnpqIPt66VlB4jN8R9LCN3jnF_orZIXQ7hmRc5avCqxgEa30FuUM29L47nksToqDpnHx2UK912fk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvtddgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:BQ_QY5NtkMflpbJF71AzyCG4pgOfrkOwzMjNvoqE91SQZ3_3Xtebgg>
    <xmx:BQ_QY-99uHRxDFI9hnc-fm_SzgAqy8fy8jlYXGU0D61bJuIUvsVDJg>
    <xmx:BQ_QYxX17E7aTfnTkbn_lE0pYZbJc784saKgj7HiS0VXW-VPMVpUwQ>
    <xmx:BQ_QYyWQ8CpE7x8sA-PFMhGAIBQjhzx-_JHeptofHfI2KumjZ3fU8A>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Jan 2023 12:01:56 -0500 (EST)
Date:   Tue, 24 Jan 2023 18:01:55 +0100
From:   Greg KH <greg@kroah.com>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: manual merge of the fpga tree with the tty tree
Message-ID: <Y9APAw4CoA31ubtb@kroah.com>
References: <20230123124502.725e8700@canb.auug.org.au>
 <Y9AKa/MU2EJPgQXS@yilunxu-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9AKa/MU2EJPgQXS@yilunxu-OptiPlex-7050>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 12:42:19AM +0800, Xu Yilun wrote:
> On 2023-01-23 at 12:45:02 +1100, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Today's linux-next merge of the fpga tree got conflicts in:
> > 
> >   drivers/fpga/dfl.c
> >   drivers/fpga/dfl.h
> > 
> > between commit:
> > 
> >   4747ab89b4a6 ("fpga: dfl: add basic support for DFHv1")
> > 
> > from the tty tree and commits:
> > 
> >   3afe90d5b7a4 ("fpga: dfl: kernel-doc corrections")
> >   e5541aae450e ("fpga: dfl: more kernel-doc corrections")
> > 
> > from the fpga tree.
> 
> 
> Hi Greg:
> 
> I could re-apply the 2 FPGA patches based on the following series on
> tty-next tree:
> 
> 46879f71061a ("Documentation: fpga: dfl: Add documentation for DFHv1")
> 0926d8d52d42 ("fpga: dfl: Add DFHv1 Register Definitions")
> 4747ab89b4a6 ("fpga: dfl: add basic support for DFHv1")
> e34a79d0b320 ("tty: serial: 8250: add DFL bus driver for Altera 16550")
> 
> Then there will be no conflict for my pull request.

Ok, that seems reasonable.  If there's anything you think I should
change in the tty tree, please let me know.

thanks,

greg k-h
