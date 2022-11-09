Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FED62331B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 20:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbiKITAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 14:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiKITAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 14:00:36 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6EA1A3B8;
        Wed,  9 Nov 2022 11:00:34 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id gw22so17581271pjb.3;
        Wed, 09 Nov 2022 11:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xAtfUGAzFgcNBnIbSWDsNJ1US/mY0mv1SDKeGTpMFnc=;
        b=M12WA5jstlEU37vqEZqQvYN2fOKWK4EhddWc3WwseBsnDLnJ+3S+TA4+cBgWZAkuWw
         qopSMSvT1UeUdPMsRY92q2lXMLvQTjYVtGrBhYVo02CFboXysPpn+gIsN4Pm13lG/WDz
         WfL8pm149rlrh8YPSjfSFJCgvYT6eQDqlVD9/TFuYeGGvpwfMBC6YWqFYmyixVf4WggQ
         dG9im4tAISZi9QibM7ivOvSwLHtDUId2eSHpbXWqZpkrTarSdZf8/GZqDZ77Wz0nfC1G
         9oE/JKTn7QVfnWjIH8rQDII4fC83iaj0qwna/sMgKXwhGbVClqb4xhulZSWzZJj/Wi28
         +X6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xAtfUGAzFgcNBnIbSWDsNJ1US/mY0mv1SDKeGTpMFnc=;
        b=x0hNSdcL/bxnbZQvYsLZmLqz7rWKB0JVC7G7nPlgv4WorG4dsSpwmnBaWLQjz0ldnD
         qKC4MDqx3eKL2ju9QLAaskMFEmw6YY9mvU5WptTr/cTj6uJbXfqmjM6cChX5u4Sy4UNR
         AP6xT4qk/FgrSdISNSajlbbCQNjPGj61ZEtlCBRYlPTVdXkRMqnSKAlKqH5MGlo/oOpp
         Q7M9esOvdpOuSPqDDjI2Oh7XLcBssFUFUppSl4dCdJ+KjZr9WVAVQiZvtlr62EznKiPy
         NuKIhCG+WBpFtrwfDc5iOBYSXDmhdLzSFrnb3sBO4yGpzPEiY3hylUa5BRgKIJu1Cu6/
         8Mmw==
X-Gm-Message-State: ACrzQf0Jv47J6XESzK0aFPLMX5+qodoLiB/4Iqil5va90OtOu87HM8UM
        4cTMKCdyVP02jyf3gCzaJmY=
X-Google-Smtp-Source: AMsMyM5EgFkoZv9A+1YW81vdlp0hVYvECWFfUwWH8to7ophfb+qijhzGq+eVO3KIW/KjFBqsgCn6IA==
X-Received: by 2002:a17:90a:d493:b0:213:ce33:4a4d with SMTP id s19-20020a17090ad49300b00213ce334a4dmr56294701pju.140.1668020433698;
        Wed, 09 Nov 2022 11:00:33 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:9f46:7242:26:f220])
        by smtp.gmail.com with ESMTPSA id r29-20020aa79edd000000b0056e32a2b88esm8623930pfq.219.2022.11.09.11.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 11:00:32 -0800 (PST)
Date:   Wed, 9 Nov 2022 11:00:29 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] gpiolib: consolidate GPIO lookups
Message-ID: <Y2v4ze4y8qDThjrv@google.com>
References: <20221031-gpiolib-swnode-v2-0-81f55af5fa0e@gmail.com>
 <20221031-gpiolib-swnode-v2-5-81f55af5fa0e@gmail.com>
 <Y2uOEhib5dvIcobF@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2uOEhib5dvIcobF@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 01:25:06PM +0200, Andy Shevchenko wrote:
> On Tue, Nov 08, 2022 at 04:26:50PM -0800, Dmitry Torokhov wrote:
> > Ensure that all paths to obtain/look up GPIOD from generic
> > consumer-visible APIs go through the new gpiod_find_and_request()
> > helper, so that we can easily extend it with support for new firmware
> > mechanisms.
> > 
> > The only exception is OF-specific [devm_]gpiod_get_from_of_node() API
> > that is still being used by a couple of drivers and will be removed as
> > soon as patches converting them to use generic fwnode/device APIs are
> > accepted.
> 
> ...
> 
> > +static struct gpio_desc *gpiod_find_by_fwnode(struct fwnode_handle *fwnode,
> > +					      struct device *consumer,
> > +					      const char *con_id,
> > +					      unsigned int idx,
> > +					      enum gpiod_flags *flags,
> > +					      unsigned long *lookupflags)
> >  {
> > -	unsigned long lflags = GPIO_LOOKUP_FLAGS_DEFAULT;
> 
> > -	struct gpio_desc *desc = ERR_PTR(-ENODEV);
> 
> Not sure why this is needed. Now I see that else branch has been changed,
> but looking closer to it, we can drop it completely, while leaving this
> line untouched, correct?

Yes. I believe removing an initializer and doing a series of if/else
if/else was discussed and [soft] agreed-on in the previous review cycle,
but I can change it back.

I think we still need to have it return -ENOENT and not -ENODEV/-EINVAL
so that we can fall back to GPIO lookup tables when dealing with an
unsupported node type.

> 
> > -	int ret;
> > +	struct gpio_desc *desc;
> >  
> > +	dev_dbg(consumer, "GPIO lookup for consumer %s in node '%pfw'\n",
> > +		con_id, fwnode);
> > +
> > +	/* Using device tree? */
> >  	if (is_of_node(fwnode)) {
> > -		desc = gpiod_get_from_of_node(to_of_node(fwnode),
> > -					      propname, index,
> > -					      dflags,
> > -					      label);
> > -		return desc;
> > +		dev_dbg(consumer, "using device tree for GPIO lookup\n");
> > +		desc = of_find_gpio(to_of_node(fwnode),
> > +				    con_id, idx, lookupflags);
> 
> At least con_id can be placed on the previous line.

OK, I made it all 1 line.

> 
> >  	} else if (is_acpi_node(fwnode)) {
> > -		desc = acpi_node_get_gpiod(fwnode, propname, index,
> > -					   &lflags, &dflags);
> > -		if (IS_ERR(desc))
> > -			return desc;
> > +		dev_dbg(consumer, "using ACPI for GPIO lookup\n");
> > +		desc = acpi_find_gpio(fwnode, con_id, idx, flags, lookupflags);
> >  	} else {
> > -		return ERR_PTR(-EINVAL);
> > +		desc = ERR_PTR(-ENOENT);
> >  	}
> >  
> > -	/* Currently only ACPI takes this path */
> > +	return desc;
> > +}
> 
> ...
> 
> > +	struct gpio_desc *desc = ERR_PTR(-ENOENT);
> > +	unsigned long lookupflags;
> > +	int ret;
> 
> > +	if (!IS_ERR_OR_NULL(fwnode))
> 
> I think this is superfluous check.
> 
> Now in the form of this series, you have only a single dev_dbg() that tries to
> dereference it. Do we really need to have it there, since every branch has its
> own dev_dbg() anyway?

As I mentioned, I like to keep this check to show the reader that we
should only descend into gpiod_find_by_fwnode() if we have a valid
fwnode. It is less about code generation and more about the intent.

I did change the logging to remove extra dev_dbg(). We will lose message
when dealing with unsupported node type, but that should not really
happen in practice.

> 
> > +		desc = gpiod_find_by_fwnode(fwnode, consumer, con_id, idx,
> > +					    &flags, &lookupflags);
> 
> > +
> 
> This blank line can be dropped after addressing above.
> 
> > +	if (gpiod_not_found(desc) && platform_lookup_allowed) {
> > +		/*
> > +		 * Either we are not using DT or ACPI, or their lookup did not
> > +		 * return a result. In that case, use platform lookup as a
> > +		 * fallback.
> > +		 */
> > +		dev_dbg(consumer, "using lookup tables for GPIO lookup\n");
> > +		desc = gpiod_find(consumer, con_id, idx, &lookupflags);
> > +	}
> > +
> > +	if (IS_ERR(desc)) {
> > +		dev_dbg(consumer, "No GPIO consumer %s found\n", con_id);
> > +		return desc;
> > +	}
> 
> ...
> 
> > +	return gpiod_find_and_request(NULL, fwnode, con_id, index, flags, label,
> > +				      false);
> 
> One line?

OK :)

> 
> ...
> 
> > +	return gpiod_find_and_request(dev, fwnode, con_id, idx, flags, label,
> > +				      true);
> 
> One line?

OK.

Thanks,

-- 
Dmitry
