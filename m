Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA7D6D31A5
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 16:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjDAOx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 10:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjDAOx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 10:53:26 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031FC18838;
        Sat,  1 Apr 2023 07:53:23 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id C607E5C0095;
        Sat,  1 Apr 2023 10:53:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 01 Apr 2023 10:53:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1680360800; x=1680447200; bh=os
        h0QUHcMMAqD5b2lxUL3ZPOtpTu3lTXFN7owj4dApo=; b=N7N93ljthaL7TEmJCL
        zSyiAprYP5Wf96tmmrVOOiIzj+L6fIzW7EjAD9TD79CSn35KBjC64aryxWPFRFTm
        JDm7bt7YIY7J1jVwlXDAE18WKWc8pdRePUWyFO9ArN6/8XVNE3mnwwTIsD1HupBl
        GoEpFYE+0LI8WR/V3rahm0kbNTk9imouMFM9+HcihArKxDR02Ww3Nyj+Hn6hhTJv
        ce5emFQlvWOYRyiKx4i3gi+b9cHgeCqYBaRNdCwTYnz1EfMh0JWvy3wgsE8kSRyC
        Z/iNWzJTde+J+iJqzDK2j2xmAcVlIG+28hkse4AW7HyENbj0z1SEuv1/8f4G4Rsq
        lEfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680360800; x=1680447200; bh=osh0QUHcMMAqD
        5b2lxUL3ZPOtpTu3lTXFN7owj4dApo=; b=c+sqZSFmV3d7NAYxSa2FS1s4bTf3o
        7z853q71A3qTFHYCHK6tyo4mtOWksh581+uAfjjzB2CZVsaieCZGuwmm9Am59zwy
        TJnNrzdFnD2WR3oTCS6O7lee8NepMc1KlF+Z8jHODY5PI6ouX9vAlvGWqthffkmc
        hTT4bYcqSDUAeW5kCGUASM5CiZBb7eAXNB2y7YNRswu1CdcLzSC0V3D9BbYl68tQ
        K07M8vuNwat+vlabMkp6VQKy2xF6YNuIUiy5gijq1wkj03VPDeiW+Xu+GLaiRL2B
        TVzWb9ssSZHTKyha9RiOsVKBXpijgJU8YIzoAqisip8pbzUE8xGpsbPVA==
X-ME-Sender: <xms:YEUoZEGWlSsS9ub5Fniv2zhXyzmIMd65JGnHMY2nzVMfMuW2zi3sOA>
    <xme:YEUoZNV7kR1UOLW_AEBBAK-mud4TAYwQYJNI5BPs2hijhUDC1Ce-dz8MY5Pzr1GoN
    ZSLMOvG5hovIA>
X-ME-Received: <xmr:YEUoZOJv7yHEQOV9JxacecS4zlQKYuHvnco64J9nDEgWUOH0IyZs0FoO5MMOH5zodQdbToTt00kThuHJmuEyV0Za6kdMuVexkIIlRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeifedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepleevve
    dtvdfhheefuddvffdthedutddvfeektdekvedvueegudfffefhieetfeevnecuffhomhgr
    ihhnpehshiiikhgrlhhlvghrrdgrphhpshhpohhtrdgtohhmpdhkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgv
    gheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:YEUoZGEbs_ZamwMJ0NVGqwfzKVf0cW_jt9UDrZM-4y6AyyBOdBb34Q>
    <xmx:YEUoZKWSi4wt5XyGoJPPPM_11TdwpzGFgBemi8p4eMlImahAQbeAKQ>
    <xmx:YEUoZJNKMASDrC_c2ZubyKtTHgOyrMX6LUaD50w_Vwb9rlXBocTlrw>
    <xmx:YEUoZLulogowGSzxJpQ48eG-IreIbi5Cufvv9bbYQZ-es9bm18oaHg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 1 Apr 2023 10:53:20 -0400 (EDT)
Date:   Sat, 1 Apr 2023 16:53:17 +0200
From:   Greg KH <greg@kroah.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        syzbot <syzbot+4b3f8190f6e13b3efd74@syzkaller.appspotmail.com>,
        syzbot <syzbot+1cb937c125adb93fad2d@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in shark_write_reg/usb_submit_urb, WARNING in
 shark_write_val/usb_submit_urb
Message-ID: <2023040148-aground-cornbread-84e2@gregkh>
References: <00000000000096e4f905f81b2702@google.com>
 <e382763c-cf33-4871-a761-1ac85ae36f27@rowland.harvard.edu>
 <8896f261-9602-4663-aa87-1feb9bf3ec0f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8896f261-9602-4663-aa87-1feb9bf3ec0f@redhat.com>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 01, 2023 at 12:48:07PM +0200, Hans de Goede wrote:
> Hi Alan,
> 
> On 3/30/23 22:10, Alan Stern wrote:
> > Reference: https://syzkaller.appspot.com/bug?extid=4b3f8190f6e13b3efd74
> > Reference: https://syzkaller.appspot.com/bug?extid=1cb937c125adb93fad2d
> > 
> > The radio-shark driver just assumes that the endpoints it uses will be
> > present, without checking.  This adds an appropriate check.
> > 
> > Alan Stern
> > 
> > #syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ v6.2
> 
> Thank you for working on this!
> 
> Both the core changes and the 2 radio-shark driver changes look good to me.
> 
> Please add my:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> 
> When submitting these upstream.
> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> 
> > 
> >  drivers/usb/core/usb.c |   70 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/usb.h    |    7 ++++
> >  2 files changed, 77 insertions(+)
> > 
> > Index: usb-devel/drivers/usb/core/usb.c
> > ===================================================================
> > --- usb-devel.orig/drivers/usb/core/usb.c
> > +++ usb-devel/drivers/usb/core/usb.c
> > @@ -207,6 +207,76 @@ int usb_find_common_endpoints_reverse(st
> >  EXPORT_SYMBOL_GPL(usb_find_common_endpoints_reverse);
> >  
> >  /**
> > + * usb_find_endpoint() - Given an endpoint address, search for the endpoint's
> > + * usb_host_endpoint structure in an interface's current altsetting.
> > + * @intf: the interface whose current altsetting should be searched
> > + * @ep_addr: the endpoint address (number and direction) to find
> > + *
> > + * Search the altsetting's list of endpoints for one with the specified address.
> > + *
> > + * Return: Pointer to the usb_host_endpoint if found, %NULL otherwise.
> > + */
> > +struct usb_host_endpoint __must_check *usb_find_endpoint(
> > +		const struct usb_interface *intf, unsigned int ep_addr)
> > +{
> > +	int n;
> > +	struct usb_host_endpoint *ep;
> > +
> > +	n = intf->cur_altsetting->desc.bNumEndpoints;
> > +	ep = intf->cur_altsetting->endpoint;
> > +	for (; n > 0; (--n, ++ep)) {
> > +		if (ep->desc.bEndpointAddress == ep_addr)
> > +			return ep;
> > +	}
> > +	return NULL;
> > +}
> > +EXPORT_SYMBOL_GPL(usb_find_endpoint);
> > +
> > +/**
> > + * usb_check_bulk_endpoint - Check whether an interface's current altsetting
> > + * contains a bulk endpoint with the given address.
> > + * @intf: the interface whose current altsetting should be searched
> > + * @ep_addr: the endpoint address (number and direction) to look for
> > + *
> > + * Search for an endpoint with the specified address and check its type.
> > + *
> > + * Return: %true if the endpoint is found and is bulk, %false otherwise.
> > + */
> > +bool usb_check_bulk_endpoint(
> > +		const struct usb_interface *intf, unsigned int ep_addr)
> > +{
> > +	const struct usb_host_endpoint *ep;
> > +
> > +	ep = usb_find_endpoint(intf, ep_addr);
> > +	if (!ep)
> > +		return false;
> > +	return usb_endpoint_xfer_bulk(&ep->desc);
> > +}
> > +EXPORT_SYMBOL_GPL(usb_check_bulk_endpoint);
> > +
> > +/**
> > + * usb_check_int_endpoint - Check whether an interface's current altsetting
> > + * contains an interrupt endpoint with the given address.
> > + * @intf: the interface whose current altsetting should be searched
> > + * @ep_addr: the endpoint address (number and direction) to look for
> > + *
> > + * Search for an endpoint with the specified address and check its type.
> > + *
> > + * Return: %true if the endpoint is found and is interrupt, %false otherwise.
> > + */
> > +bool usb_check_int_endpoint(
> > +		const struct usb_interface *intf, unsigned int ep_addr)
> > +{
> > +	const struct usb_host_endpoint *ep;
> > +
> > +	ep = usb_find_endpoint(intf, ep_addr);
> > +	if (!ep)
> > +		return false;
> > +	return usb_endpoint_xfer_int(&ep->desc);
> > +}
> > +EXPORT_SYMBOL_GPL(usb_check_int_endpoint);

Shouldn't you use the usb_find_bulk_in_endpoint() and friends functions
instead of these?  Many drivers hard-coded their "I know this endpoint
is this type" which breaks in fuzzing as you know (and see here), which
is why those functions were created to be used.

I think just using them in the probe function would fix this issue
instead of these functions which would only be used by that one driver.

thanks,

greg k-h
