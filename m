Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F244068B66D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 08:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjBFHbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 02:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjBFHbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 02:31:13 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25EC1D917;
        Sun,  5 Feb 2023 23:30:34 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 0AAD532001C6;
        Mon,  6 Feb 2023 02:29:53 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 06 Feb 2023 02:29:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1675668593; x=1675754993; bh=fiqx19znL1
        IjOv95/GPeYngB8bz9vW8hRvhO1w0WvC8=; b=IRb65Q6oUQ+jfDdGkGmHbKkk+M
        oCqH6UCQa0odDTY0grDIZugsBZ1UbLA7faHgRJxxAdeX4AH6U0SOQSavTGYFU5CN
        9oKtxASxHhtuXLu+HQx7tcvlw/qlNZVjgH1hRKX9l3uyezL/VXem8gGJJL8xrMpf
        VgiX+9J5jnA406MlzQbe06HEJco5q+U30Pf9mD9SBQFXusodhyT8FB+AHhPsZZJE
        zgNUkBCTFuAQ6TXL0ShA1Tn+3ot5888tIMwcM7aHTm2FifXyzXVxRDs4DgG8ANPn
        aiQrFI7C8FqhpM078F8E1YhzJ5YC3BRKlPpcPSukrxrpM9bwaSTwPJJQm2Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1675668593; x=1675754993; bh=fiqx19znL1IjOv95/GPeYngB8bz9
        vW8hRvhO1w0WvC8=; b=WTz/ZzfTR3GmBU3rXCwQ92DMxQJtpZWWLgDjpVxOKCsA
        YnWBpIK+XbOyORpV4EdiHKhU+4uGsj2R0WnxoaL1N5alO495+im2RTqYRh1s/86W
        VVLihCFh/5qknxp45rqGUs8dQC+vekVE5KMUIRbh5SJXm43aIZBmEN/9/JD9n7By
        BEEy24FNxT/SSEhx341YVYzotzZlPBJ9unAQJ9JmkrW1VHFnDYmm+mMj3qwQq67B
        fsjcfNfR0ndVvoYfGcaptFo/o02DwulVCZKn3QVEv5ZXdA3CebReLqdKpTuk07H/
        GBHaBI+htAkLPzyvgvY9Be4H1ZydQU8Ezf/7spLRFg==
X-ME-Sender: <xms:cazgYxtrg4ZIOY_9aqjSNJfbdxxm1oWLjPF2fck4BC87lkCvUOv5WA>
    <xme:cazgY6f4CMfuk_QnT95udCiGOqTD9m8WGclvomef5DYgTLs0iZnBwZwDXbMUYzxmA
    MI_4PINwal_SA>
X-ME-Received: <xmr:cazgY0xBjNEmRdT09D_RQCb0x4CyZlbKpNzC-yQzJA2w09mDA6S5MZmCmXBmiJHwic2sS-g64uLLpqthCdsn1pjyieHY9J2Z3RH8pg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeghedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgv
    ghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucggtffrrghtthgvrhhnpeehge
    dvvedvleejuefgtdduudfhkeeltdeihfevjeekjeeuhfdtueefhffgheekteenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhroh
    grhhdrtghomh
X-ME-Proxy: <xmx:cazgY4OBVZq9SRKXzjQ3bM2excSmAqobWs-jbFWO1WaIZ1lvFbEvTQ>
    <xmx:cazgYx-by8Oe_vO-mR5UDqmDcfljncCSgsUehbpky5-ZJkODRI8jfA>
    <xmx:cazgY4WCia63Sd6XtYPuQZ4htV-mp7w7QQNFQVJqIK5d8lC8OtmYuQ>
    <xmx:cazgYxzN3YGYjHKUN62SCD77XrRNQGJgjYIrgXTNhOWvg6WAw_mThA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Feb 2023 02:29:52 -0500 (EST)
Date:   Mon, 6 Feb 2023 08:29:49 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Scally <dan.scally@ideasonboard.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the usb tree
Message-ID: <Y+CsbZTTPGWLnRAA@kroah.com>
References: <20230206145004.6e043ed3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206145004.6e043ed3@canb.auug.org.au>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 02:50:04PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the usb tree, today's linux-next build (htmldocs) produced
> this warning:
> 
> Documentation/ABI/testing/configfs-usb-gadget-uvc:14: ERROR: Malformed table.
> Text in column margin in table line 4.
> 
> ================        =============================
> bInterfaceNumber        USB interface number for this
>                         streaming interface
> enable_interrupt_ep     flag to enable the interrupt
>                         endpoint for the VC interface
> ================        =============================
> 
> Introduced by commit
> 
>   a36afe780461 ("usb: gadget: uvc: Add new enable_interrupt_ep attribute")

Sorry about this, it's been reported for a while and I think we have a
working patch for this in my review queue.  I'll push it out soon.

thanks,

greg k-h
