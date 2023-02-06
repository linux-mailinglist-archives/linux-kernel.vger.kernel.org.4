Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E62868B885
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 10:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjBFJWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 04:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjBFJWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 04:22:17 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9DD12F0D;
        Mon,  6 Feb 2023 01:22:16 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 059213200893;
        Mon,  6 Feb 2023 04:22:12 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 06 Feb 2023 04:22:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1675675332; x=1675761732; bh=UJlSYL8iAd
        ZRUEnmeceouGRnmyPNqtL4GO+XJHrDYyM=; b=MPqhc+DAylZiGml17sGwbhAHoX
        xy1Rs92FM2mHJm9n4/hTa8H7EL1v23XBD/sYMzVdhUhr4yJijK0cLSOcjDbU6GgG
        xYKhNtjQu7FqKvSWzbJUwLxXgk3hRH7oTKR8Wd6aUahB4aKNQAWQM3B/M0e5fndL
        a47Q4EBOtohe+N2wksL1D8j+6/tH1HyAKX/r/TDJmti9vr1Xup8XzFAcYIsv01n5
        hj2TvuYTASlJJPgqW/tW8HD00yHmbF0td+ipBxX80i96scvjEn/fYBFwg7tB6HQA
        UINEI1jzDKgVCCigXwgAVvayGuE3XrqL4RsAMCSe3vTLGHpqecJK9RLH/lAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675675332; x=1675761732; bh=UJlSYL8iAdZRUEnmeceouGRnmyPN
        qtL4GO+XJHrDYyM=; b=qAQLaZrzIFOszomSPCQq2wBRJ3BgvNkKxM7dcXjuFwEy
        ce4M//OyBhWy9Tyc28uw1GZJ7Ga8bhXiGyhvEZDsXoa0Zmp7sTEPwi2lr1WPqL2J
        J6XK1u/68UGnZwJmIWHM9kbrMJRdeSkEqvwCk5JSOo7FwsssSzIj7SyR2BA3LfyL
        PpCnQPIJa/HA4ke/o93L1+rEstW9XvcaZhk761wYcIbjFD3dzOMqqzzOJe2Jtowo
        LXvpmuRkmBbnZhJ/JDzUSLl9jbI4tbjLR450gvVN9YdIaRyt+PAtcBGeMAE6Di+T
        Rk57BT/0Na3kofCuXYPIwrhc3bRe6BIqxN3i+X+RUg==
X-ME-Sender: <xms:w8bgY4AYm_vuH3e1QYjw4tVR_8YP4AU21x3B8DFUE9J8KbDRAMQlkg>
    <xme:w8bgY6iKAleaUf7OC2_mexkqKqF5zvVxQUE1VHLEEkxHTnwJW_XHxgxr3kVE6EHjm
    p1lwhOO4CqTtA>
X-ME-Received: <xmr:w8bgY7lR6M7VEbY4uCqrRk9ZUNCoXgNOU7oBOYfRmXYeR_PPOxSYkCqYeqcSlIJfjVgGF1WvStmL9XNGYGfEPrz898sYUXkLtVGorg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudegiecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcumffj
    uceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehgedvvedvle
    ejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtg
    homh
X-ME-Proxy: <xmx:w8bgY-xtxttRBy5nsTNi1SVZJIKW8d6MEYMq7kV9oP-f0fQzKKGj1g>
    <xmx:w8bgY9SZEhR8dB4u4ndRxSeJV1JGWlZ6tV6_RzgtE4OgcvEKs8KSEg>
    <xmx:w8bgY5aTdmqsjwqub8dUBoMaDYDS5WVhAfODwAv4dWk833jTHVkEgA>
    <xmx:xMbgY8Gd_91e__BKuSJu79tirhir-ZtPUxbMdSbs8La3XtRixEBeLQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Feb 2023 04:22:11 -0500 (EST)
Date:   Mon, 6 Feb 2023 10:22:07 +0100
From:   Greg KH <greg@kroah.com>
To:     Dan Scally <dan.scally@ideasonboard.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the usb tree
Message-ID: <Y+DGv3CkAg4uEt+D@kroah.com>
References: <20230206145004.6e043ed3@canb.auug.org.au>
 <93b56558-b25c-401a-031d-971fc644054b@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93b56558-b25c-401a-031d-971fc644054b@ideasonboard.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 07:45:54AM +0000, Dan Scally wrote:
> Thanks Stephen, and sorry Greg - I should have noticed that, I'll figure out
> why I didn't. Does this just need a patch on top or some other process to be
> fixed?
> 
> On 06/02/2023 03:50, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the usb tree, today's linux-next build (htmldocs) produced
> > this warning:
> > 
> > Documentation/ABI/testing/configfs-usb-gadget-uvc:14: ERROR: Malformed table.
> > Text in column margin in table line 4.
> > 
> > ================        =============================
> > bInterfaceNumber        USB interface number for this
> >                          streaming interface
> > enable_interrupt_ep     flag to enable the interrupt
> >                          endpoint for the VC interface
> > ================        =============================
> > 
> > Introduced by commit
> > 
> >    a36afe780461 ("usb: gadget: uvc: Add new enable_interrupt_ep attribute")
> > 

Oops, this is a different error than my original response, I don't have
a patch for this :(

Dan, just send a follow-on patch for this and I'll queue it up.

thanks,

greg k-h
