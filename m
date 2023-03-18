Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 004956BFB72
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 17:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjCRQMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 12:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjCRQMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 12:12:08 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E4D1EFD8;
        Sat, 18 Mar 2023 09:12:07 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z21so31513110edb.4;
        Sat, 18 Mar 2023 09:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679155925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yDOQo2oi01br/hq0Q8teN7ROHv1Pi/RknnKhbHvLQ04=;
        b=hgLbXmJrfSUpdCdlq6mrDkRiNsJXXXMhNzi5UYUskhpvkA+Yh+E9aeaZkC8yOvi+3h
         kg65zIGj0l7lRcQE7Qf6v+hwZS5RRolgfPdTURBNAIl2dy0nwfkVceX9auXIEblK2AOg
         EBE4uIhP2YYzi5P/cxP50uZXgYgZOF9Lz3chIT19djjPU3Br+Fz+ZjGA0pFi2W6uIAKV
         nINcdCNJqacxep5u8UXUkGZLw20rEXzMF3X/sI5EnxzogM94ioqWzwMIE2qC1uf7PCft
         qha8VN3HoNk+C5WDM/jASK62mnRWcAZGg7GVaB+bYnb0Q3G9rbDmjYokTGfw7/YMTWn4
         tA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679155925;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yDOQo2oi01br/hq0Q8teN7ROHv1Pi/RknnKhbHvLQ04=;
        b=M3iXfAE7olpNIi+bY1J9ziOEQeE4BYw9c9XqPu7a9JYyV1AHvK53ASLM1r8bRce5X/
         Scg/X3FT9MhIPfZxXcXYFhnaW+V7bR3aXWSbYgmelKj3wpb4DY3sJsdDEoiiEYSnljgI
         T2CjQO9pdYN+26TWJratdKFIAl46tC4x4GbvJb1M1mTW48KX9evWhQuEKpAYcdQVNcNb
         uHZaqy8nzZNdUJV0NJPPM48Xd7OBrxmP2iv427eOnRu4uQoOpRA6QkHHeeNPpSMW3vqZ
         9b0vKHhM9SPaPXAbnGUJsCqeKBVIdsF3e4GpsEeQWqziwWj6DYIOsSzVCDV6rXf8kfVz
         75pA==
X-Gm-Message-State: AO0yUKUiLjhKihIDSA9D4/e1ee1vu2409NMe+Gctwyz5GLS8c7KmW2FY
        F9uG/OQ8FUJbep76LeFqitg=
X-Google-Smtp-Source: AK7set/rc+rM+znYsJq2SQJj4XR4rOcdBb+eKAHgbkBpmBxGOghVKizBEcTMViBwFihuJpYQgtBQVw==
X-Received: by 2002:a17:906:b1d6:b0:8b1:3467:d71b with SMTP id bv22-20020a170906b1d600b008b13467d71bmr3432056ejb.48.1679155925482;
        Sat, 18 Mar 2023 09:12:05 -0700 (PDT)
Received: from carbian ([2a02:8109:aa3f:ead8::a9c0])
        by smtp.gmail.com with ESMTPSA id g19-20020a17090613d300b00931db712768sm2130526ejc.4.2023.03.18.09.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 09:12:05 -0700 (PDT)
Date:   Sat, 18 Mar 2023 17:12:03 +0100
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     jic23@kernel.org, mazziesaccount@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: accel: kionix-kx022a: Add chip_info structure
Message-ID: <ZBXi05HpZSHYs2wm@carbian>
References: <cover.1679009443.git.mehdi.djait.k@gmail.com>
 <3ddca10a4c03c3a64afb831cc9dd1e01fe89d305.1679009443.git.mehdi.djait.k@gmail.com>
 <ZBRXzymSWZaRDyhq@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBRXzymSWZaRDyhq@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Fri, Mar 17, 2023 at 02:06:39PM +0200, Andy Shevchenko wrote:
> On Fri, Mar 17, 2023 at 12:48:36AM +0100, Mehdi Djait wrote:
> > Refactor the kx022a driver implementation to make it more
> > generic and extensible.
> > Add the chip_info structure will to the driver's private
> > data to hold all the device specific infos.
> > Move the enum, struct and constants definitions to the header
> > file.
> 
> Please, compile and test before sending.

My bad, I ignored the warnings... 
I will fix it.

> 
> ...
> 
> >  	.driver = {
> > -		.name   = "kx022a-spi",
> > +		.name	= "kx022a-spi",
> >  		.of_match_table = kx022a_of_match,
> >  	},
> 
> What was changed here?

Nothing. I will fix it

> 
> ...
> 
> > -	.id_table = kx022a_id,
> > +	.id_table = kx022a_spi_id,
> 
> Why do we need this change?
> 

For consistency:
i2c: .id_table = kx022a_i2c_id,
spi: .id_table = kx022a_spi_id,

> ...
> 
> > -	name = devm_kasprintf(data->dev, GFP_KERNEL, "%s-kx022a",
> > +	name = devm_kasprintf(data->dev, GFP_KERNEL, "%s-accel",
> >  			      dev_name(data->dev));
> 
> Shouldn't you use the name from chip info?

I can use the name from chip info. 
dev_name(data->dev) is the original implementation

> 
> ...
> 
> > +#define KX_MASK_BRES16			    BIT(6)
> > +
> > +
> 
> One blank line is enough.

I will change it in v2

--
Kind Regards
Mehdi Djait
