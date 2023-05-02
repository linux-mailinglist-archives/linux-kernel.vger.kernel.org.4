Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D620C6F3BFC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 04:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbjEBCNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 22:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjEBCNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 22:13:19 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539943AA1;
        Mon,  1 May 2023 19:13:15 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 6761C32009C1;
        Mon,  1 May 2023 22:13:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 01 May 2023 22:13:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1682993592; x=1683079992; bh=Zw
        QOGXyH976reVvtHf/drdDDqvM/gzeddwkfAWhnysg=; b=iYnrUyMaKRRDLpli1p
        okM2naedtNZKVePrq0/f2NPcT9DS/NSiwp5a19fEyhIoxtBWSr+4hnE3g6YQ/pYw
        JZU0Rj9kwnaTnEgtsM7hVIZ6NIhnEa1MJDwtYbCOK3sPpkPUx3J6xLMSbryoWTXn
        K19eWQ7DM2Et7nFa9zQ5lZoupii42bReJw+JPrPqr0b1WKuF0a2IPsxx6A+K6+IM
        Bn2uVfVXGwWyoXENbmMUKzLw6QQIlTzfwCYwWI1GRt5zlNvTbT0kT/myZlaI31pe
        NDbLPvnwPIDI5+DkKUVwuWuZR3ytHkaK59aYQg6l9W7tYwrHqJR90UZ6i2LW5mhX
        XXhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682993592; x=1683079992; bh=ZwQOGXyH976re
        VvtHf/drdDDqvM/gzeddwkfAWhnysg=; b=IWQD49l/9/wpBAbKvFo0iCH4lqJ4i
        9Cur5dQJjUSwd6/d6DkrdztdAlXNS/7bRhNTlc7Bw5blrs111zdbtZ1Td2JcWJEz
        m+6ooDW/fQkvNt4f4Aq5JDBsqGAmdGO7/HpIYtfTTsDyUKKudQghPBV4s+JkpkMZ
        AsTCqopwtbNdk3KVRLHtChP8ITEUmKVVge02mT9OkZEHzCSLwWLi4s97P9aAOkjI
        cJ2UyuUCJh9YPASPZI480HGrq0VmsMZlIz7fLBhSHh40Fb+7H/yiYds3B9FRb1iV
        s2yYSG9yQxfeqaXeYKgOqcq86GYifc/iyYeRQ1dzuJHXbBf8Ao3ExUG+A==
X-ME-Sender: <xms:t3FQZHEGWcDEVllbpJQrbk1ln2qjrZcxjPiocvc2QPxFfv9aVyrxgw>
    <xme:t3FQZEVg0xewT9z1UZUG0uhclRy1LW5Ps-ErNhH5u-awBMr2KEOaH4ATgQ90MlPXM
    FGYCFDbq4GUtctj01c>
X-ME-Received: <xmr:t3FQZJJTepqOtLidERGkJ5625tps85BahwwObptvktU5OrPdCAtQimNlRDwe3yFgtoLXcQCvPFy7NoScQmZ77hoQ7LBY18XT_ETj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvhedgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgvthgv
    rhcujfhuthhtvghrvghruceophgvthgvrhdrhhhuthhtvghrvghrseifhhhoqdhtrdhnvg
    htqeenucggtffrrghtthgvrhhnpeekvdekgeehfeejgfdvudffhfevheejffevgfeigfek
    hfduieefudfgtedugfetgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpvghtvghrrdhhuhhtthgvrhgvrhesfihhohdqthdrnhgvth
X-ME-Proxy: <xmx:t3FQZFEtpph31Hwr6PUl0v-F_wiUIFqjvtKSkmdQgUOC08KYkhxw_g>
    <xmx:t3FQZNXVZ4zBB4hSDALTYXEZud2LbzuOGHJMjVZ8jzMAtduYwCaTHw>
    <xmx:t3FQZAMGlmmlxnmr4Q5lsOSo3J5UVMgDISp-0qo_3PPZyHwOvHMgBg>
    <xmx:uHFQZAQJKmsB1X6e2NYYJ2D-rxu1UhWhKecq9e3BnV27HQLN8xWcwA>
Feedback-ID: i7ce144cd:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 May 2023 22:13:09 -0400 (EDT)
Date:   Tue, 2 May 2023 12:13:05 +1000
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Biswarup Pal <biswarupp@google.com>, kernel-team@android.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Call input_set_timestamp for events injected using uinput
Message-ID: <20230502021305.GA798180@quokka>
References: <20230427000152.1407471-1-biswarupp@google.com>
 <ZFBh948No3IAV2hf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFBh948No3IAV2hf@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the CC, I would've missed that.

On Mon, May 01, 2023 at 06:05:59PM -0700, Dmitry Torokhov wrote:
> On Thu, Apr 27, 2023 at 12:01:51AM +0000, Biswarup Pal wrote:
> > Currently, uinput doesn't use the input_set_timestamp API, so any
> > event injected using uinput is not accurately timestamped in terms of
> > measuring when the actual event happened. Hence, call the
> > input_set_timestamp API from uinput in order to provide a more
> > accurate sense of time for the event. Propagate only the timestamps
> > which are a) positive, b) within a pre-defined offset (10 secs) from
> > the current time, and c) not in the future.
> 
> This makes sense to me. Peter, do you see any issues?

nope, this looks good and has my 
Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net> 

afaict any code that has compiler warnings enabled should have this on
zero anyway. It'd be really nice to pass a timestamp down to uinput but
that's obviously a lot more involved.

Cheers,
  Peter

> 
> Thanks!
> 
> > 
> > Signed-off-by: Biswarup Pal <biswarupp@google.com>
> > ---
> >  drivers/input/misc/uinput.c | 34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> > 
> > diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
> > index f2593133e524..d98212d55108 100644
> > --- a/drivers/input/misc/uinput.c
> > +++ b/drivers/input/misc/uinput.c
> > @@ -33,6 +33,7 @@
> >  #define UINPUT_NAME		"uinput"
> >  #define UINPUT_BUFFER_SIZE	16
> >  #define UINPUT_NUM_REQUESTS	16
> > +#define UINPUT_TIMESTAMP_ALLOWED_OFFSET_SECS 10
> >  
> >  enum uinput_state { UIST_NEW_DEVICE, UIST_SETUP_COMPLETE, UIST_CREATED };
> >  
> > @@ -569,11 +570,40 @@ static int uinput_setup_device_legacy(struct uinput_device *udev,
> >  	return retval;
> >  }
> >  
> > +/*
> > + * Returns true if the given timestamp is valid (i.e., if all the following
> > + * conditions are satisfied), false otherwise.
> > + * 1) given timestamp is positive
> > + * 2) it's within the allowed offset before the current time
> > + * 3) it's not in the future
> > + */
> > +static bool is_valid_timestamp(const ktime_t timestamp)
> > +{
> > +	ktime_t zero_time;
> > +	ktime_t current_time;
> > +	ktime_t min_time;
> > +	ktime_t offset;
> > +
> > +	zero_time = ktime_set(0, 0);
> > +	if (ktime_compare(zero_time, timestamp) >= 0)
> > +		return false;
> > +
> > +	current_time = ktime_get();
> > +	offset = ktime_set(UINPUT_TIMESTAMP_ALLOWED_OFFSET_SECS, 0);
> > +	min_time = ktime_sub(current_time, offset);
> > +
> > +	if (ktime_after(min_time, timestamp) || ktime_after(timestamp, current_time))
> > +		return false;
> > +
> > +	return true;
> > +}
> > +
> >  static ssize_t uinput_inject_events(struct uinput_device *udev,
> >  				    const char __user *buffer, size_t count)
> >  {
> >  	struct input_event ev;
> >  	size_t bytes = 0;
> > +	ktime_t timestamp;
> >  
> >  	if (count != 0 && count < input_event_size())
> >  		return -EINVAL;
> > @@ -588,6 +618,10 @@ static ssize_t uinput_inject_events(struct uinput_device *udev,
> >  		if (input_event_from_user(buffer + bytes, &ev))
> >  			return -EFAULT;
> >  
> > +		timestamp = ktime_set(ev.input_event_sec, ev.input_event_usec * NSEC_PER_USEC);
> > +		if (is_valid_timestamp(timestamp))
> > +			input_set_timestamp(udev->dev, timestamp);
> > +
> >  		input_event(udev->dev, ev.type, ev.code, ev.value);
> >  		bytes += input_event_size();
> >  		cond_resched();
> > -- 
> > 2.40.1.495.gc816e09b53d-goog
> > 
> 
> -- 
> Dmitry
