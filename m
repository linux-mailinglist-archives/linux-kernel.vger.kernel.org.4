Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C760363A760
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 12:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiK1LuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 06:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbiK1LuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 06:50:12 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03AB13E8A;
        Mon, 28 Nov 2022 03:50:11 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 037093200908;
        Mon, 28 Nov 2022 06:50:08 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 28 Nov 2022 06:50:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1669636208; x=1669722608; bh=wtIBsaHA3J
        ecaBQ+MxbdbPF8tvV/uo7IabJxbgjL8HE=; b=GD1zytP23/kdQ3fmF383F9qTNz
        /MFsiT9Ul8jn681zGlzd4rrp565x3cilHuV3Za1aN0Qi9tlOvLd91+zS74YA95PG
        8+GMIm0lIenjsvQsgwLiRsMkb3IkIv91xjOGMkmSHZFpJTg5f3d3KAa1c5dP0UU1
        V29/8RyzGfOgH32ywxne/RBKg5Cm+BUXD+8YDCzTlENFi7ZgYvNlS3HVbjBd0f2s
        cmln8T9bhW2tII0f7ncd0tiwMl7VQzUIVYejCquTNCrVMsuRYdGc09M98G8jiiKs
        lrpOCmujOJPHC/yKnM3eaiYA+w0wqC+8Ze8pZ826j3WKQlFuvv7SzzyAmOeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669636208; x=1669722608; bh=wtIBsaHA3JecaBQ+MxbdbPF8tvV/
        uo7IabJxbgjL8HE=; b=R5iD66YkdV72T3S5qp28jgaE1fXvL+aklXoU8PXsa9Tq
        5SaLwhdkyniwKJqE80DbLg4xfm3aKc5o/DjD7gL4UcB0znog2Ugh1uKLCGvVXYDR
        B/5o6PsI/0AWsP1oFZzsRVFBKyyHRiJvLKmHvE7qR9Z76PRgioORGh/Mw7R9iF83
        V/8acV8CXCXg/KkL6nndcWtSjTlqiMbI6jPjZNQHAHGnultYYYUUYwWZ6JwRGCdz
        w0U81snpTTfAEv6Dgm5YrNhid3P5bbmMlbMVhQPsP21YZARGnnT0y19H3OpuKQ/t
        sZr46GE35dLRserEPiDxz0zGPuHqwUkJXoj6cIXDTg==
X-ME-Sender: <xms:cKCEY5od_1Pgllv3hSPxO33j1K-T3LdFdfbwKN22bt1TF228EUhBQQ>
    <xme:cKCEY7oSJhat0c02h3ewiL6KN0DVHLjtV9zP6jVHVUaN_gAlB8A9m6SBTdK7su230
    SiGN98rOtTmEA>
X-ME-Received: <xmr:cKCEY2Nt4SnoL_skIjCJfr-neIOA45VYFUclCb9TWrBlgQgpRvgUEAnXbnW_fZne_5HKV3SxpAbUkBtybXscvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrjedvgdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvve
    dvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhh
    drtghomh
X-ME-Proxy: <xmx:cKCEY07xaVNekpRWerJk72qWO0f1BN483i7H9wl_c2MpgTWp6HddGw>
    <xmx:cKCEY46WEweKBiYDCLApcekYkm95uH5UzR30zIQPcnXyLNysl6iHPQ>
    <xmx:cKCEY8hKaQz174EPb863U7FCIMG-W1KRYOgA1xK31cZqfBq5Xlf7gw>
    <xmx:cKCEYz3PsJor8-hvCypkWG7MolTpKmV8Gl3MbBukhg_QPEtgFIH_cQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Nov 2022 06:50:07 -0500 (EST)
Date:   Mon, 28 Nov 2022 12:50:03 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the driver-core tree
Message-ID: <Y4Sga+ONeDe9Q7yz@kroah.com>
References: <20221128133600.14ce44bf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128133600.14ce44bf@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 01:36:00PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the driver-core tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> arch/powerpc/platforms/book3s/vas-api.c: In function 'vas_register_coproc_api':
> arch/powerpc/platforms/book3s/vas-api.c:590:38: error: assignment to 'char * (*)(const struct device *, umode_t *)' {aka 'char * (*)(const struct device *, short unsigned int *)'} from incompatible pointer type 'char * (*)(struct device *, umode_t *)' {aka 'char * (*)(struct device *, short unsigned int *)'} [-Werror=incompatible-pointer-types]
>   590 |         coproc_device.class->devnode = coproc_devnode;
>       |                                      ^
> drivers/misc/cxl/file.c: In function 'cxl_file_init':
> drivers/misc/cxl/file.c:687:28: error: assignment to 'char * (*)(const struct device *, umode_t *)' {aka 'char * (*)(const struct device *, short unsigned int *)'} from incompatible pointer type 'char * (*)(struct device *, umode_t *)' {aka 'char * (*)(struct device *, short unsigned int *)'} [-Werror=incompatible-pointer-types]
>   687 |         cxl_class->devnode = cxl_devnode;
>       |                            ^
> 
> Caused by commit
> 
>   ff62b8e6588f ("driver core: make struct class.devnode() take a const *")
> 
> I have used the driver-core tree from next-20221125 for today.

Hm, how do we resolve problems like this where an api changes in my
branch but needs to be updated in another branch that is not in Linus's
tree yet?

Want me to make a patch for this for you to apply after the driver-core
merge?

thanks,

greg k-h
