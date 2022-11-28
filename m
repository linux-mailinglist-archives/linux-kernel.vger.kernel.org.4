Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B331363AD99
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 17:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbiK1QXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 11:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbiK1QW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 11:22:59 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B97EC778;
        Mon, 28 Nov 2022 08:22:57 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 371325C013B;
        Mon, 28 Nov 2022 11:22:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 28 Nov 2022 11:22:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1669652577; x=1669738977; bh=gOI9d57EdP
        pv6R/HBMFQvc3Ijzcm6PPOdLdQVSYXR7Q=; b=U62U+7g9MfACOzEN/A7jq/hEYG
        KnmW/AitoSBncHwujWeHpbxXNqAZCCgDu/L9zib5XS0a3O5lWZq5XhJl1P0O5Pld
        9O4WPaeoh0TyI2tWEmr4m2l6u+ZbCE0PQw0gkaRIEIkwemm8rKVgByGsI8gnpeC7
        Y3qKO3t+zFDhbLCD1nOmHybY3Bn8Pa9fuqSMgJL0sB8VMr6XewFbLiIBj2z30rXx
        50tSsyVw1HTtQ0ZbVDtxmHuzA2XT+ryT5EtGjBsfW7hRJfAjlBN2I4I+u29LmAuN
        qfDsw+bxmcYJIvEhDl1OksrN/bAciGTzSD0aEOc5RKUOsWB3GtQyQC/eyRpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669652577; x=1669738977; bh=gOI9d57EdPpv6R/HBMFQvc3Ijzcm
        6PPOdLdQVSYXR7Q=; b=rRCFsx4FtY3+6IVFqDDWWFn4Sr1e3OdB1LXIk+TOnAvx
        0XY2dY/xdA1I9+qpRKjnCkLJw40OrCDsLOOFpPTG1qbRZ0ZII92LO75nc52tHsKv
        aKvbVlNSJ409eyYPoMeTzctWkF7vhcju4Z1+nJnNZd9t7jVVvnpbWES6fJzefAUp
        XCRLyRXyRgggsY9KQM+6SqTrr9eCe0IM8KEGnWbGuIF/cfVM3CdybYAyygDWPVdr
        NcJPsOIcM8uIt4cg+u/pPpo1Q4ZAgTFy5yh1oytMAZQZ8sZBC+dybZEHAt+jUonu
        nS+5v+xlM8FY0eiE6TJmpSiuPaC/sID2UN9v6klgbA==
X-ME-Sender: <xms:YOCEYzltBQJyPJHHMOOt-k-ZyoQwhI3ZOvEdhO7vTQKXcnSJL9JAPg>
    <xme:YOCEY23T8iJzub16qx3DPejQiHgIwNk41nFkulkYrOdGElKcCq70jJJfgBqRPIm3F
    _qs68-T4TyG3g>
X-ME-Received: <xmr:YOCEY5pLNHFf0T0imMs_TOqKpYAcVmh6Dcyc4Vyh4kIyspyHvHDpzo7ng6GKn2oFMw5i9TQEkKHfHojp1LkuSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrjedvgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvve
    dvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:YOCEY7n4C7JsOQVS82ceo0nQINa-Gy39fvPEkB7SPdl0ILt_9LFLDQ>
    <xmx:YOCEYx3hXoXoHBTpwKJYp3PLCNL1IRROE4McUmHrfg3xedgptTK-wg>
    <xmx:YOCEY6uDSDVbMhOTeMnyfbmZYv0ZBj01A85XkoGAw74aT1uP6-9WIA>
    <xmx:YeCEY8QHIjo_-KtV4A50XwOqeWouIHbqCheKfbNQkBgjVfCaB1TuAA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Nov 2022 11:22:55 -0500 (EST)
Date:   Mon, 28 Nov 2022 17:22:52 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the driver-core tree
Message-ID: <Y4TgXLb4EweoJb0k@kroah.com>
References: <20221128133600.14ce44bf@canb.auug.org.au>
 <Y4Sga+ONeDe9Q7yz@kroah.com>
 <20221128234408.7a4dec34@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128234408.7a4dec34@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 11:44:08PM +1100, Stephen Rothwell wrote:
> Hi Greg,
> 
> On Mon, 28 Nov 2022 12:50:03 +0100 Greg KH <greg@kroah.com> wrote:
> >
> > On Mon, Nov 28, 2022 at 01:36:00PM +1100, Stephen Rothwell wrote:
> > > 
> > > After merging the driver-core tree, today's linux-next build (powerpc
> > > ppc64_defconfig) failed like this:
> > > 
> > > arch/powerpc/platforms/book3s/vas-api.c: In function 'vas_register_coproc_api':
> > > arch/powerpc/platforms/book3s/vas-api.c:590:38: error: assignment to 'char * (*)(const struct device *, umode_t *)' {aka 'char * (*)(const struct device *, short unsigned int *)'} from incompatible pointer type 'char * (*)(struct device *, umode_t *)' {aka 'char * (*)(struct device *, short unsigned int *)'} [-Werror=incompatible-pointer-types]
> > >   590 |         coproc_device.class->devnode = coproc_devnode;
> > >       |                                      ^
> > > drivers/misc/cxl/file.c: In function 'cxl_file_init':
> > > drivers/misc/cxl/file.c:687:28: error: assignment to 'char * (*)(const struct device *, umode_t *)' {aka 'char * (*)(const struct device *, short unsigned int *)'} from incompatible pointer type 'char * (*)(struct device *, umode_t *)' {aka 'char * (*)(struct device *, short unsigned int *)'} [-Werror=incompatible-pointer-types]
> > >   687 |         cxl_class->devnode = cxl_devnode;
> > >       |                            ^
> > > 
> > > Caused by commit
> > > 
> > >   ff62b8e6588f ("driver core: make struct class.devnode() take a const *")
> > > 
> > > I have used the driver-core tree from next-20221125 for today.  
> > 
> > Hm, how do we resolve problems like this where an api changes in my
> > branch but needs to be updated in another branch that is not in Linus's
> > tree yet?
> 
> That is not the case here:
> 
> $ git show ff62b8e6588f:arch/powerpc/platforms/book3s/vas-api.c | grep coproc_devnode
> static char *coproc_devnode(struct device *dev, umode_t *mode)
> 	coproc_device.class->devnode = coproc_devnode;
> $ git show ff62b8e6588f:drivers/misc/cxl/file.c | grep cxl_devnode
> static char *cxl_devnode(struct device *dev, umode_t *mode)
> 	cxl_class->devnode = cxl_devnode;
> 
> You just need to add a commit to your tree that updates the missed cases.

Odd, why is 0-day not triggering on any of these in my tree?   Anyway,
I'll go fix it up, thanks...

greg k-h
