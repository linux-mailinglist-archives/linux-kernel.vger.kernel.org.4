Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299AE6C3726
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 17:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbjCUQlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 12:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbjCUQlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:41:24 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730A45293F;
        Tue, 21 Mar 2023 09:41:01 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id cn12so16487763edb.4;
        Tue, 21 Mar 2023 09:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679416844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrlZjsekimYZz2rusTzf5CWJE1JU9y76N7MnQtLQqd8=;
        b=XHiOY/mfOqvXk4Ag+FACvgulRCUOH59TQOQG7rMtHMGVjKwqVHAwlkPH6nXoEyF6fm
         MSY+z+pb1Gd7om8MSBHKvSlZOppnTarPtColtqLG6Z0EU22PV394Wq0ctnQfog+uvrXT
         VrYYj+/vG3J8pfanual0EW5LHlgy7Ks12/X2ZnuxicSPuH+laZ70GKIFq5OKEzS542pL
         WMBWeBJsLJG+inw9E8uPFbWtQvRwibydjz4lS8iR1t2nSvZQPpceMh9hhGnyGguH+fea
         7bQm4dMth22PGIiFZwsMLuupOppws2lOKEqmtuDvSTcmpUiF6c5m6u82zAkAa+BiWoPt
         yT6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679416844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrlZjsekimYZz2rusTzf5CWJE1JU9y76N7MnQtLQqd8=;
        b=e3ajRBZ3vec5c80u+r+kH08kZqbMXeSsYFOJ4TqBuO5Jf1+bKDrkHP4Lfj0Gl39pyc
         NeYZ7SGBw/MDIoYtxXrj8QqvL2uCdmGdPy8F7A0/gFG8XOEsmTOn1YerkJamoC8LZBqM
         W1rv2MPDE0q3fBcx6HVMxf7dQ8bhlqhiIP8YnqkEvAMJjJhGoeRJ+vdEqa1zUsmu9PGi
         u5xKWx35agJmhxknogwm+0WwFSdcBjIuO97aB1iixGvdKBPqgCy/9dM0dJYYygze0leI
         ejAlD3xyDJ4r17sI7SbrS4otkP1uFHHm1hCIb5XwPThRyAh+2dudIiC9zwO1/2L2YjP4
         +l9w==
X-Gm-Message-State: AO0yUKVM6YB7zyg+8LHUJ6yJLBUnIVUu0Y7J68zoCoxvLTYGBtlDv2Y1
        bc+Ra6z9DJWPd+WlpJY7SCzY2ZvxRgir5XOe
X-Google-Smtp-Source: AK7set/KvDidl1A0DDtGzN2QPf7Ud1/aoKKKDxJURSPbZfTSD2dnlvBJwIC1KUPCJkCH0jQvggCX8w==
X-Received: by 2002:a17:906:11d0:b0:926:320c:cd98 with SMTP id o16-20020a17090611d000b00926320ccd98mr3511021eja.36.1679416844594;
        Tue, 21 Mar 2023 09:40:44 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id e6-20020a170906748600b008bfe95c46c3sm6045983ejl.220.2023.03.21.09.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 09:40:44 -0700 (PDT)
Date:   Tue, 21 Mar 2023 21:40:38 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     outreachy@lists.linux.dev, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: remove camel case
Message-ID: <ZBneBozTNWpsfqcL@khadija-virtual-machine>
References: <ZBiPlhkqHUegMRAb@khadija-virtual-machine>
 <ZBlKijo6zLsE8jUx@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBlKijo6zLsE8jUx@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 07:11:22AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Mar 20, 2023 at 09:53:42PM +0500, Khadija Kamran wrote:
> > Several variables and functions were named Camel Case. This resulted in
> > checks pointed by checkpatch.pl
> > 
> > Avoid camel case by changing names.
> > 
> > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> > ---
> >  drivers/staging/iio/addac/adt7316.c | 64 ++++++++++++++---------------
> 
> This has nothing to do with "greybus" :(
>

Hi Greg!

I am sorry about making a really silly mistake here.
I will try not to make a mistake like this again.

> >  1 file changed, 32 insertions(+), 32 deletions(-)
> > 
> > diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> > index 79467f056a05..49702beeac30 100644
> > --- a/drivers/staging/iio/addac/adt7316.c
> > +++ b/drivers/staging/iio/addac/adt7316.c
> > @@ -672,7 +672,7 @@ static IIO_DEVICE_ATTR(da_high_resolution, 0644,
> >  		adt7316_store_da_high_resolution,
> >  		0);
> > 
> > -static ssize_t adt7316_show_AIN_internal_Vref(struct device *dev,
> > +static ssize_t adt7316_show_AIN_internal_vref(struct device *dev,
> 
> "Vref" is correct, please keep it as is.
> 

Okay understood.
Thank you.

Regards,
Khadija


> thanks,
> 
> greg k-h
