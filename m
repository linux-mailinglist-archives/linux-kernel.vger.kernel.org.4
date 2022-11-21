Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1515631A0F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 08:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbiKUHQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 02:16:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKUHQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 02:16:08 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C4F13DFB
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 23:16:06 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id y10so8614594plp.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 23:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=07BnDwCzQtGxJqu7WmxiQvLbKkkvRQG8oAd9NqGojZc=;
        b=lxHru+v025FemK23WUln+D51enXsc33BTttn49z6Kxv53bk3XaWQFiFB5bTLFDPp9s
         7jdV5g1dBLVgQcjS3jqdpexiM2SWIouxEY1TnGybPwNHvGUlY4+PajNJOUoSrFVsN5iZ
         o8f2b/mgDa4g8Rc1qtktZQcJHb2+s5vqcW5vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07BnDwCzQtGxJqu7WmxiQvLbKkkvRQG8oAd9NqGojZc=;
        b=YIR4vDZCrJcx/419rkUIkAOs7D+it3pODIZ7y/HnpYclZVjeG1vElc4WL8unq19h2b
         bXIpS3tHkf9tB6xDECLCOmkgrttCbB/UT0Lc9xZKFz/t3wECGhTKQ1DaCumjTF2FFclJ
         3Mzt6VloWIUJSEEjk4gDIaIbKxkO8lvMU5utQaP69bAcWfUU5jmYexztlcpWBpA3rbNT
         j0lAHNsgIeDkV49u3TEsQidx7Knb3/YP9FDqCfKRHC2FRQOxDfxfqonAnnnv93lPylIk
         oNuYOe8cHtLf+bfY16bge6FTBYsSq3JAtLwzXNfDMJWSnh4gjSfC8GOLg4P8cOViwrXE
         Q2dA==
X-Gm-Message-State: ANoB5pnnKxpcGoDOT6koWUufjXiPJT7VJr+woguRX3A8CHuDFzVMeUjT
        kMdO02Jja5b+k2S//P/gu3gsEyLbzM2ltONQ
X-Google-Smtp-Source: AA0mqf4EhghUMVNc51VNS/NIi+XBfMwfWwUy19qDUwJ56WfjZh8p2tRJFlyeizVQ/NVPIlRH853GzQ==
X-Received: by 2002:a17:90a:9c18:b0:212:fa9a:12df with SMTP id h24-20020a17090a9c1800b00212fa9a12dfmr25358105pjp.231.1669014965900;
        Sun, 20 Nov 2022 23:16:05 -0800 (PST)
Received: from chromium.org (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id f9-20020a17090a120900b00218722ecac2sm7457867pja.18.2022.11.20.23.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Nov 2022 23:16:05 -0800 (PST)
Date:   Mon, 21 Nov 2022 07:16:03 +0000
From:   Prashant Malani <pmalani@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Benson Leung <bleung@chromium.org>
Subject: Re: [PATCH] usb: typec: pd: Add symlink to linked device
Message-ID: <Y3sls9+NcQrdjb9y@chromium.org>
References: <20221121062106.2569297-1-pmalani@chromium.org>
 <Y3scND+8DVe8SGeD@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3scND+8DVe8SGeD@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thanks for reviewing the patch.

On Nov 21 07:35, Greg Kroah-Hartman wrote:
> On Mon, Nov 21, 2022 at 06:20:39AM +0000, Prashant Malani wrote:
> >  
> > +What:		/sys/class/usb_power_delivery/.../device
> > +Date:		November 2022
> > +Contact:	Prashant Malani <pmalani@chromium.org>
> > +Description:
> > +		Symbolic link to the directory of the device to which the USB PD object is linked.
> 
> Line is way too long.

Sorry about that. I'll try to make it more concise in the next version.

> 
> But wait, a "device" has a specific meaning in a sysfs file, and that is
> not what is happening here.
> 
> Please don't make fake "device" symlinks when these are not really using
> a device here.  Either fix it up to properly use the device structures
> in the code, or call this something else.

Got it, sorry about using that specific term. How about:
1. "linked_device"
2. "base_device" ?

I prefer 1.) but happy to use the other, or any other suggestion.

> 
> What in userspace wants to see this symlink?

ChromeOS's userspace Type-C daemon. It listens for Type-C partner uevents, but the PD objects
can be created later (and destroyed and then recreated again, for PD chargers which dynamically
change their source caps), and this helps determine which partner does those events apply to.

Thanks,

-Prashant
