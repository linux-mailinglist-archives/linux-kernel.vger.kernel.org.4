Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEBC66C9293
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 07:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbjCZFYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 01:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjCZFY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 01:24:28 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC01A5B91
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 22:24:27 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id l7so4966321pjg.5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 22:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679808267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l8eM3auEURf5Yz74B4xS+px+Zq3swgYLBvUD75GaNMk=;
        b=TjpZI22arNu77KtHiNIoBJMxYSrvrLnM4V1z+nkoSbUOf/MobLcMMgdIWv2KOi0IDE
         hiVzQbyC38iOh6EMT8wKVBBYIjcjXtWskrmokuAc6a3eAzlrxz1YfNGGx7xRZ8YDsXR6
         MpJqfhrDwsYk/VBEEpOSVoQjwgwIbx6i4Oy6RVtmVZDqD/bEMHAqPSEbJGk1Bib93ALQ
         MfcsfetV7TCRLfhxsXq5rWvAdF1uHGF8haCGG5Rb0buhFpCZJ+bJQndZdXG6sFkKfvsl
         m/KKoKBZ8WG9YxuTYJRoK7R108iV5Dlh3E/FhSYTg1SBBXBKSN7m2soVJDAdi+sMOw6V
         Atbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679808267;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8eM3auEURf5Yz74B4xS+px+Zq3swgYLBvUD75GaNMk=;
        b=ccT/J9dmoYuv421RKa4jtXiVKOpw5YJ1ec3awZHrLRL9KkN4262ccgMa5AVlSpYNgC
         xJWPEUEUvPUA2ygcyGt10zo5FSws/rhn7rUIhKhuijcPZrtrwcoSrgo88htILAkIBdjx
         7RP/cQ2XSd8JuSOG41sHD4a7jvyq5bykradqE2r71AiF+X+Z/OfsufMElZedHtrhNfYn
         ar0ZEHpB3uLP0ITXInZNjBjc0kKsFOmW4Cwgc9fXhQsrQZfOFb5QgRsJZF0WhxtFCeR4
         +RBVKIXKcZ7+MIj3Q/XdH2yTg2EmjX9aFgarD0pgo/Muq09qTZbFbjHG6Q8opTlN8Ben
         yxzQ==
X-Gm-Message-State: AAQBX9c91oTu16NwaTudPR+C/eOJnbrxcTeMoWF1D1KzaQ1akz4OJdxU
        H+VIr2cE55GT4+NW6Vp0pAw=
X-Google-Smtp-Source: AKy350afbQeZdtfvWlHEvJm+uzLq1lMd+sTHnS43/LWxSyyeRaiQgF8Oz/euRtOQDIkIXC1I4lZb5A==
X-Received: by 2002:a17:902:d482:b0:19f:27fe:95c3 with SMTP id c2-20020a170902d48200b0019f27fe95c3mr8903964plg.41.1679808267235;
        Sat, 25 Mar 2023 22:24:27 -0700 (PDT)
Received: from sumitra.com ([117.212.89.150])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902704200b001a21cde3458sm3675111plt.90.2023.03.25.22.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 22:24:26 -0700 (PDT)
Date:   Sat, 25 Mar 2023 22:24:20 -0700
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     outreachy@lists.linux.dev, johan@kernel.org, elder@kernel.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] staging: greybus: Inline pwm_chip_to_gb_pwm_chip()
Message-ID: <20230326052420.GA179105@sumitra.com>
References: <cover.1679732179.git.sumitraartsy@gmail.com>
 <f1ef1b643840e74f211264dda0c590f8458618f6.1679732179.git.sumitraartsy@gmail.com>
 <ZB63EVLK6/29UUi0@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZB63EVLK6/29UUi0@kroah.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2023 at 09:55:45AM +0100, Greg KH wrote:
> On Sat, Mar 25, 2023 at 01:31:10AM -0700, Sumitra Sharma wrote:
> > Convert 'pwm_chip_to_gb_pwm_chip' from a macro to a static
> > inline function, to make the relevant types apparent in the
> > definition and to benefit from the type checking performed by
> > the compiler at call sites.
> > 
> > Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
> > ---
> >  drivers/staging/greybus/pwm.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/greybus/pwm.c b/drivers/staging/greybus/pwm.c
> > index 3fda172239d2..88da1d796f13 100644
> > --- a/drivers/staging/greybus/pwm.c
> > +++ b/drivers/staging/greybus/pwm.c
> > @@ -21,9 +21,11 @@ struct gb_pwm_chip {
> >  	struct pwm_chip		chip;
> >  	struct pwm_chip		*pwm;
> >  };
> > -#define pwm_chip_to_gb_pwm_chip(chip) \
> > -	container_of(chip, struct gb_pwm_chip, chip)
> >  
> > +static inline struct gb_pwm_chip *pwm_chip_to_gb_pwm_chip(struct pwm_chip *chip)
> > +{
> > +	return container_of(chip, struct gb_pwm_chip, chip);
> > +}
> >  
> >  static int gb_pwm_count_operation(struct gb_pwm_chip *pwmc)
> >  {
> > -- 
> > 2.25.1
> > 
> > 
> 
> This patch didn't apply due to changes made in my tree by a patch from
> someone else before yours.  Can you rebase it and resend?
>

Hi greg,

I am confused, will that be a totally new patch or a new version(v4 in
this case)?

Regards,

Sumitra

> thanks,
> 
> greg k-h
