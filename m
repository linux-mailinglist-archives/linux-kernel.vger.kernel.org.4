Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2D863AEFB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 18:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbiK1RgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 12:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbiK1RgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 12:36:05 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47EA24962;
        Mon, 28 Nov 2022 09:36:01 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id E006A5C00DB;
        Mon, 28 Nov 2022 12:35:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 28 Nov 2022 12:35:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1669656958; x=1669743358; bh=aKzeEdpO8C
        H2HdtCvIgLs+oL7GmiAQ4112GY4wqfTWI=; b=VaJI7QNb/7jTI79BIHjdowt7vX
        RdUnTi2zZ3sdgDH5DXzo+Zo54MSE533K4dP6tgNAunpVKTLjRKP9Ev2UJb8ksMsf
        V2b8fHdsNQWL00cv0oTNUVLCQ47jcZZ7rdyAPhS6dlJngXvdp0LxfNcjLKEJb/lZ
        8my5ZIlYhe7rsFPDahpKqQYXFMHbSjDK8XJP9vsHeXIsrL8EVoXfHKqXr4zzJBju
        iG6ibrFspKUoVxYHYchnPHoM4CJo5aNyV1whZQBUTw9meTW/VFXrZA6aFwX6+vPb
        /cVyLhP9S+FN+Z6AoPJ8p7JOIuhL6QsCfTR8FmXfSgpCPEf7IelssomyoaNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669656958; x=1669743358; bh=aKzeEdpO8CH2HdtCvIgLs+oL7Gmi
        AQ4112GY4wqfTWI=; b=f1yRnY6YIPO+eGpZwJ2dDhzN5NsfAWDVCFLu7llhxFQK
        pxF7WqSzQmop2S4fQpGbCeWTgejZaDxvhh4f4JDkTmnPyxOEzNKgDEI1zT+6lWFr
        UXfF8Gc5ZoWFUsNyqQpjOBw4D/Svz0eudlN/gffMUu/0VVKmoxIWHyrFbe2n6P+O
        NZN2A50J3qibGqAcBONiEmzjdbyod04FJtT32NLqzGrfGBgErcwUP7x0mya6mt74
        O/okDfGw0cwpM24Vbu3+AoOAFM5FvcDd+hFx8FV+64d/SPqfe9jbnuAg65r9uIMy
        bSZAB2r/V1vlVGGAQN5GJYDN+0YsPSwEG2TEIov8xQ==
X-ME-Sender: <xms:fvGEY4gWfV0CvjuvAIoQwPPzCqMepYewStgsvKQ_Tp-fGzb6P1rasg>
    <xme:fvGEYxDk1i032FP_264JlWdq7NqIXkdnOWvQuppPIs8NUd-chqzMTRykcsLIdEwBx
    ZIRZrRpuEWm3w>
X-ME-Received: <xmr:fvGEYwHThauLr3zT9qfwb8PWXM5hHhLQ96l9DV_jzxsY7gSOL5WKqhJohp8GDStzmfqRUnDMjnRjNSlQH--tOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrjedvgddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:fvGEY5QpXevNtDvl2KVGxQgUf-1POuYwHKRTsXoeangq-QQ5A9yVVQ>
    <xmx:fvGEY1xwudIgkaCCbdbCyLly6Ljn5EJ2ceBORjWImF_s7y_ZoJVgCQ>
    <xmx:fvGEY34bnjFq4HNWf8EEoYptaMcTXk91X-7qz76Ei2pRWDXNmM1_oA>
    <xmx:fvGEY3uiSMgp5Af3I3ZZiSjA4nNlfFyblURULTCgPodorhv9avtc5w>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Nov 2022 12:35:57 -0500 (EST)
Date:   Mon, 28 Nov 2022 18:35:56 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the driver-core tree
Message-ID: <Y4TxfIFxbhciz9TJ@kroah.com>
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

Ok, patch sent out, let's see if 0-day objects...

thanks,

greg k-h
