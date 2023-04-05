Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235126D7FD5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 16:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238451AbjDEOoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 10:44:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238532AbjDEOor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 10:44:47 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403EFFB;
        Wed,  5 Apr 2023 07:44:43 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 7F8C85C020C;
        Wed,  5 Apr 2023 10:44:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 05 Apr 2023 10:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1680705882; x=1680792282; bh=E6
        DttPKIAkYtM9DtOnAsbVOxX0PkhYz8tu5+srYClwg=; b=m9lHysEQ5s/W4FDdkp
        UqmtjQ6Vk/FWndvjtjAbtr1aLYAEhKP2mD7OZZnu0/d7dqNpZuKwl/mIbdjEDmPZ
        25AMo+i7LmPIfSSEASojMyUzXlX50D42qZVq+pxoEsoujb5hRZHiljm5LMXnGq+j
        wlpS5Z8a0WCCoPHcZCBXt+v7eaiMvx1oUs/SjJFYNn/Ftaip8JhLFB/gGLDMYosO
        XGc1vAuse002hKJqgkHc9UMvdqufuk63Vb/iJYL08SpzqEvMz5aMy5h8r36bC7xs
        9xKtw9Le6NVuOx7Pq0WCfPHeOHsxILRFjxTPQqDQ4H4yhIwW7dT13SNTB9WfKth8
        C3Ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680705882; x=1680792282; bh=E6DttPKIAkYtM
        9DtOnAsbVOxX0PkhYz8tu5+srYClwg=; b=YkkZC8vOTPAiljHleKVuwZwtRjBxN
        ywaQSRS2bcKyXhRoPg7omfSnnhLihLTHEZwXGVuJpWPVPriX5kGxD0EouYUD0/ne
        zpDz894PuWpHeHXHGeSWHi8jhSzP5pf+HmDu0ragIv6HYM/MKvyhvqpqE04M20cR
        a9Egr7MZmPm1tXQmuFITrghcRtM5aZot4rjtMBoqbrU8/mjtwJvdWrQMl/ku6dYC
        jO0vjtjQTC45SyTMfvoeKnbs0r+/r1wqsXcbYGPt/aOB4vn5K/Hvm+1hZv1xnm4Q
        ij2WNXKsxyksnUxf12BB2Je4D7Zq7n7gjJ/zup3gFXKMbwIxqWnPihkkw==
X-ME-Sender: <xms:WoktZL7VjvtfnU4IuOnYl5-oa9mmdX5TSmBjHelJDK0sdNjaDn9GOA>
    <xme:WoktZA7S94YInoo1xT7zijfdvDFR7NUuGph2WxGklK92xSEo6yfktl-Qd1Zpytlwk
    AAmipQHkP6Vcw>
X-ME-Received: <xmr:WoktZCdchd6OR1ScB0f5_iFl_UZFKHMPtonrfkxzDmWmXmlYbtHZuM3bZmZydWxwUnlffu5jKsadyeK3j3OL3YvY1eCxJhwsAeav3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejuddgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepleevve
    dtvdfhheefuddvffdthedutddvfeektdekvedvueegudfffefhieetfeevnecuffhomhgr
    ihhnpehshiiikhgrlhhlvghrrdgrphhpshhpohhtrdgtohhmpdhkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgv
    gheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:WoktZMKyapo-8IhIaYdJGmuNMMP98dpb9vQUt7qEFdqpAIutiGOgsQ>
    <xmx:WoktZPIsJN_q-Ouqpozo7u_VJU9Dn1-ACe5ZVeB9_CL4emy0UNHnKQ>
    <xmx:WoktZFwrx04h7F6suebRMVa8gAlEVsR9qUDsCrSXUFyLjYrt0KDuzw>
    <xmx:WoktZJAAz911wnoH-2IQsIr0vb-EZ3imXTyBpi1GX69pdgID8PKuBw>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Apr 2023 10:44:41 -0400 (EDT)
Date:   Wed, 5 Apr 2023 16:44:37 +0200
From:   Greg KH <greg@kroah.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        syzbot <syzbot+4b3f8190f6e13b3efd74@syzkaller.appspotmail.com>,
        syzbot <syzbot+1cb937c125adb93fad2d@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in shark_write_reg/usb_submit_urb, WARNING in
 shark_write_val/usb_submit_urb
Message-ID: <2023040544-cuddly-glancing-f577@gregkh>
References: <00000000000096e4f905f81b2702@google.com>
 <e382763c-cf33-4871-a761-1ac85ae36f27@rowland.harvard.edu>
 <8896f261-9602-4663-aa87-1feb9bf3ec0f@redhat.com>
 <2023040148-aground-cornbread-84e2@gregkh>
 <f764a19d-858e-408c-a5f5-d6fe7306c4cb@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f764a19d-858e-408c-a5f5-d6fe7306c4cb@rowland.harvard.edu>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 01, 2023 at 02:38:39PM -0400, Alan Stern wrote:
> On Sat, Apr 01, 2023 at 04:53:17PM +0200, Greg KH wrote:
> > On Sat, Apr 01, 2023 at 12:48:07PM +0200, Hans de Goede wrote:
> > > Hi Alan,
> > > 
> > > On 3/30/23 22:10, Alan Stern wrote:
> > > > Reference: https://syzkaller.appspot.com/bug?extid=4b3f8190f6e13b3efd74
> > > > Reference: https://syzkaller.appspot.com/bug?extid=1cb937c125adb93fad2d
> > > > 
> > > > The radio-shark driver just assumes that the endpoints it uses will be
> > > > present, without checking.  This adds an appropriate check.
> > > > 
> > > > Alan Stern
> > > > 
> > > > #syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ v6.2
> > > 
> > > Thank you for working on this!
> > > 
> > > Both the core changes and the 2 radio-shark driver changes look good to me.
> > > 
> > > Please add my:
> > > 
> > > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > > 
> > > When submitting these upstream.
> > > 
> > > Regards,
> > > 
> > > Hans
> > > 
> > > 
> > > 
> > > 
> > > 
> > > > 
> > > >  drivers/usb/core/usb.c |   70 +++++++++++++++++++++++++++++++++++++++++++++++++
> > > >  include/linux/usb.h    |    7 ++++
> > > >  2 files changed, 77 insertions(+)
> > > > 
> > > > Index: usb-devel/drivers/usb/core/usb.c
> > > > ===================================================================
> > > > --- usb-devel.orig/drivers/usb/core/usb.c
> > > > +++ usb-devel/drivers/usb/core/usb.c
> > > > @@ -207,6 +207,76 @@ int usb_find_common_endpoints_reverse(st
> > > >  EXPORT_SYMBOL_GPL(usb_find_common_endpoints_reverse);
> > > >  
> > > >  /**
> > > > + * usb_find_endpoint() - Given an endpoint address, search for the endpoint's
> > > > + * usb_host_endpoint structure in an interface's current altsetting.
> > > > + * @intf: the interface whose current altsetting should be searched
> > > > + * @ep_addr: the endpoint address (number and direction) to find
> > > > + *
> > > > + * Search the altsetting's list of endpoints for one with the specified address.
> > > > + *
> > > > + * Return: Pointer to the usb_host_endpoint if found, %NULL otherwise.
> > > > + */
> > > > +struct usb_host_endpoint __must_check *usb_find_endpoint(
> > > > +		const struct usb_interface *intf, unsigned int ep_addr)
> > > > +{
> > > > +	int n;
> > > > +	struct usb_host_endpoint *ep;
> > > > +
> > > > +	n = intf->cur_altsetting->desc.bNumEndpoints;
> > > > +	ep = intf->cur_altsetting->endpoint;
> > > > +	for (; n > 0; (--n, ++ep)) {
> > > > +		if (ep->desc.bEndpointAddress == ep_addr)
> > > > +			return ep;
> > > > +	}
> > > > +	return NULL;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(usb_find_endpoint);
> > > > +
> > > > +/**
> > > > + * usb_check_bulk_endpoint - Check whether an interface's current altsetting
> > > > + * contains a bulk endpoint with the given address.
> > > > + * @intf: the interface whose current altsetting should be searched
> > > > + * @ep_addr: the endpoint address (number and direction) to look for
> > > > + *
> > > > + * Search for an endpoint with the specified address and check its type.
> > > > + *
> > > > + * Return: %true if the endpoint is found and is bulk, %false otherwise.
> > > > + */
> > > > +bool usb_check_bulk_endpoint(
> > > > +		const struct usb_interface *intf, unsigned int ep_addr)
> > > > +{
> > > > +	const struct usb_host_endpoint *ep;
> > > > +
> > > > +	ep = usb_find_endpoint(intf, ep_addr);
> > > > +	if (!ep)
> > > > +		return false;
> > > > +	return usb_endpoint_xfer_bulk(&ep->desc);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(usb_check_bulk_endpoint);
> > > > +
> > > > +/**
> > > > + * usb_check_int_endpoint - Check whether an interface's current altsetting
> > > > + * contains an interrupt endpoint with the given address.
> > > > + * @intf: the interface whose current altsetting should be searched
> > > > + * @ep_addr: the endpoint address (number and direction) to look for
> > > > + *
> > > > + * Search for an endpoint with the specified address and check its type.
> > > > + *
> > > > + * Return: %true if the endpoint is found and is interrupt, %false otherwise.
> > > > + */
> > > > +bool usb_check_int_endpoint(
> > > > +		const struct usb_interface *intf, unsigned int ep_addr)
> > > > +{
> > > > +	const struct usb_host_endpoint *ep;
> > > > +
> > > > +	ep = usb_find_endpoint(intf, ep_addr);
> > > > +	if (!ep)
> > > > +		return false;
> > > > +	return usb_endpoint_xfer_int(&ep->desc);
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(usb_check_int_endpoint);
> > 
> > Shouldn't you use the usb_find_bulk_in_endpoint() and friends functions
> > instead of these?  Many drivers hard-coded their "I know this endpoint
> > is this type" which breaks in fuzzing as you know (and see here), which
> > is why those functions were created to be used.
> 
> It's true, we could use the existing functions in this case.  I'm not sure 
> which approach would be better; it's probably mostly a matter of taste.
> 
> Using the existing functions, the probe function would get additional code 
> something like this:
> 
> 	struct usb_endpoint_descriptor *ep;
> 
> 	if (!(usb_find_int_in_endpoint(intf->cur_altsetting, &ep) == 0 &&
> 			usb_endpoint_num(&ep->desc) == SHARK_IN_EP) ||
> 	    !(usb_find_int_out_endpoint(intf->cur_altsetting, &ep) == 0 &&
> 			usb_endpoint_num(&ep->desc) == SHARK_OUT_EP)) {
> 		dev_err(...
> 
> Using the new functions (with a revised API, see the patch below) we would 
> instead add this:
> 
> 	static const u8 ep_addresses[] = {
> 		SHARK_IN_EP | USB_DIR_IN,
> 		SHARK_OUT_EP | USB_DIR_OUT,
> 		0};
> 
> 	if (!usb_check_int_endpoints(intf, ep_addresses)) {
> 		dev_err(...
> 
> In this case the difference is not particularly meaningful.  With the new 
> functions, the amount of code added to the driver is smaller, but of 
> course that's offset by adding the new functions themselves to the core.  
> (On the other hand there's probably a bunch of drivers that could stand 
> to be fixed up this way, which would amortize the cost to the core.)
> 
> The difference becomes a lot more noticeable with the sisusbvga driver 
> [1].  It has six endpoints that need to be checked: four bulk-OUT and two 
> bulk-IN.  While usb_find_common_endpoints() would be able to find them, 
> it's not well suited for checking that they have the expected addresses.  
> With the new functions, all the work can be done with a single call.
> 
> > I think just using them in the probe function would fix this issue 
> > instead of these functions which would only be used by that one driver.
> 
> It wouldn't be used just by these two drivers.  The new routines are 
> ideally suited for doing the checking in old drivers that have their 
> endpoint numbers and directions built-in, like these do.  While I haven't 
> looked to see, there must be quite a few of them.

Ok, fair enough, let's take this and see what other drivers can be fixed
up this way.

thanks,

greg k-h
