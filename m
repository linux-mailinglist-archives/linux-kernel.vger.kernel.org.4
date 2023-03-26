Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 985E66C92D8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 08:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjCZGi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 02:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjCZGi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 02:38:27 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF625B9B
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 23:38:26 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j13so5044692pjd.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 23:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679812706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fpnznd8HIBj/YyF7nBj1pjhAkQmyxPKeuTzOkbCCpVY=;
        b=MnBT6y2yik85UnuTYFGwPL7lzLIfWSQes5d4v/idNXpl9OmxO/y9EmQWgHOpZwmfCu
         T9pIsU/rSwKQn3A7Xprx7EKALM8Xjo+jNcQracBGR+J1KNKzEbKkaHhRu4f9MlDWWqDK
         af96g/Pn17A7VWds2dECE/EnQswIaksYNYFdK/wj7Pezl0RwcwNwgPS03aIA+jHfq3u9
         fYmzFFsXBsrdVXYCzO2TKMQOcallDoftVKKwipsWtaNmQd3Ls8xeNEEudO0tUiTbzBlM
         NcmH1N0qAncy++npDmMZfxmrX6T+iCLSChKoBRdEUb1piPDLSa++vBoL2311ELj+Sfrg
         GEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679812706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fpnznd8HIBj/YyF7nBj1pjhAkQmyxPKeuTzOkbCCpVY=;
        b=Maue3jutSjmTShN/v03p9gee6hnz4S4THbtBrqocS41b00luqZDeGejAgFMj5UCKJn
         WhTRsKHqq040lDEDSbdadF2b7PfMgNzv7KwFIVJzaS1yaHdkNUYt1LQqQhOf1pp9JPMo
         NBp4VwZBkHCBwlVmqYC1M21mEYF/rsrNDgRql+Mx1Cv5DcX/AzaUHVpl2DcmJKr7MnTK
         aqraRKePscDUmoj7NXmbNmLlnrnKnXKmP5MEEPHnHGIVv+qrh1RgD5j+yES+lNbCeWzB
         Z3m7giPOTV91oUg86XNX5xUa7iYfCyBewUZ4Ry8a4bpsaEpa0+5ixWzbYJb0QIBAHsXf
         abDg==
X-Gm-Message-State: AAQBX9cvmZRp4u3Qr5IfRPZ+3Fnr4maMLXzu0tZhNONVSm++arhmb9Yt
        raE00EFSYXhtVqQ8qhfRy/moF8J80p9NdgGk
X-Google-Smtp-Source: AKy350ZQTAKWUVqZbn1jWD7iQjFbevcIgu9cZUcwBEJCkqMtLL4syvXldrH8UlzaHVEFZdXQtqye2A==
X-Received: by 2002:a17:903:228f:b0:1a2:185f:f199 with SMTP id b15-20020a170903228f00b001a2185ff199mr8976293plh.63.1679812705804;
        Sat, 25 Mar 2023 23:38:25 -0700 (PDT)
Received: from sumitra.com ([117.212.89.150])
        by smtp.gmail.com with ESMTPSA id p6-20020a1709028a8600b00194c2f78581sm16847621plo.199.2023.03.25.23.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 23:38:25 -0700 (PDT)
Date:   Sat, 25 Mar 2023 23:38:19 -0700
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Greg KH <gregkh@linuxfoundation.org>, outreachy@lists.linux.dev,
        johan@kernel.org, elder@kernel.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] staging: greybus: Inline pwm_chip_to_gb_pwm_chip()
Message-ID: <20230326063819.GC179105@sumitra.com>
References: <cover.1679732179.git.sumitraartsy@gmail.com>
 <f1ef1b643840e74f211264dda0c590f8458618f6.1679732179.git.sumitraartsy@gmail.com>
 <ZB63EVLK6/29UUi0@kroah.com>
 <20230326052420.GA179105@sumitra.com>
 <alpine.DEB.2.22.394.2303260751290.3294@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2303260751290.3294@hadrien>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 26, 2023 at 07:51:50AM +0200, Julia Lawall wrote:
> 
> 
> On Sat, 25 Mar 2023, Sumitra Sharma wrote:
> 
> > On Sat, Mar 25, 2023 at 09:55:45AM +0100, Greg KH wrote:
> > > On Sat, Mar 25, 2023 at 01:31:10AM -0700, Sumitra Sharma wrote:
> > > > Convert 'pwm_chip_to_gb_pwm_chip' from a macro to a static
> > > > inline function, to make the relevant types apparent in the
> > > > definition and to benefit from the type checking performed by
> > > > the compiler at call sites.
> > > >
> > > > Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
> > > > ---
> > > >  drivers/staging/greybus/pwm.c | 6 ++++--
> > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/staging/greybus/pwm.c b/drivers/staging/greybus/pwm.c
> > > > index 3fda172239d2..88da1d796f13 100644
> > > > --- a/drivers/staging/greybus/pwm.c
> > > > +++ b/drivers/staging/greybus/pwm.c
> > > > @@ -21,9 +21,11 @@ struct gb_pwm_chip {
> > > >  	struct pwm_chip		chip;
> > > >  	struct pwm_chip		*pwm;
> > > >  };
> > > > -#define pwm_chip_to_gb_pwm_chip(chip) \
> > > > -	container_of(chip, struct gb_pwm_chip, chip)
> > > >
> > > > +static inline struct gb_pwm_chip *pwm_chip_to_gb_pwm_chip(struct pwm_chip *chip)
> > > > +{
> > > > +	return container_of(chip, struct gb_pwm_chip, chip);
> > > > +}
> > > >
> > > >  static int gb_pwm_count_operation(struct gb_pwm_chip *pwmc)
> > > >  {
> > > > --
> > > > 2.25.1
> > > >
> > > >
> > >
> > > This patch didn't apply due to changes made in my tree by a patch from
> > > someone else before yours.  Can you rebase it and resend?
> > >
> >
> > Hi greg,
> >
> > I am confused, will that be a totally new patch or a new version(v4 in
> > this case)?
> 
> New version.
>

Thank you julia.

Regards
Sumitra

> julia
> 
> >
> > Regards,
> >
> > Sumitra
> >
> > > thanks,
> > >
> > > greg k-h
> >
> >
