Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FFB6D0908
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 17:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232710AbjC3PFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 11:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbjC3PFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 11:05:33 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D43D7D83
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 08:05:32 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h17so19407202wrt.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 08:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680188730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mHqk1nTzV7ycjwFvCpLIMeUZdQ/ws/pWquuHos3UlIA=;
        b=H3KCxqCfCflzl6WHwZA0TMDFrBJHXqEMMqT0wYP7XswonsCIKoyB5NhweiLlSjr0/8
         7MHImaSCADouon+KDq2VQ6cR0OoDubQ2P4GyBUtXDkieXZMCpsRzIvWpPVkPr1jXKCSn
         6NkjtQCtRkkYmPvGG1oVBc/DBmZ+jjIIsPZZ7YI+G6BngLtwzKftHsYTIjQ2HSay0HEx
         RjSiRArTl4TQ5LY+nkAiqWhvlrDRd9VKRkQiql525/O3GJLXcrKY4bmwkjmb+/4bqV3c
         8QGw4L04ctbEdh9ji4zYUSPBkOdvhxuGOOQPi2S4c9gtmUmymh0h7Pe7JePN38YjIw1I
         4uYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680188730;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHqk1nTzV7ycjwFvCpLIMeUZdQ/ws/pWquuHos3UlIA=;
        b=CaItfgv7hoGvO/LbmTv28aRfmu+yzmRmlXu+hkvUqIBIjM17qXKswOj37CbHj0WrKz
         x8KN3tU0GbepHLLYSCMBE5X7TBRZthtD1AcfRzAaMUTGWg/NA6U4swLE8qs3s5Ytcn9P
         wTj7nQec+A5JNcOdgsy6catAa6hKj/PrmfpA47lzHMYKd6YeOwruyXt12QPrmu267O8L
         h2D/x5uLI4AkesLiCOuZNWACUJy9Br6x7Jyz5KXJ9jS4ImTOguKoCQsYn3KG3pVyYHTa
         ZDEFLbOfn6s7kmkECt80PScOvlV8DuWAW6kqaolos0Pv+zUV0Gv4V756B/iNovC4buoM
         RrUQ==
X-Gm-Message-State: AAQBX9dBJSvK+45ZgBUktF/C6LwlGk4EA3bk5jhUA+uT+Oc7lEyPD8cK
        3s6TqW2FN5BYRkLhaI+Ge65uBD8dhqlnpAfu
X-Google-Smtp-Source: AKy350Y8+wmYVIjBkMYJaXy9cmGuAKT6zNtAMxk8kgmxBbAZAy2HIfR+trzIeOaI1D60yObiOTQxTA==
X-Received: by 2002:a5d:4fd0:0:b0:2cc:459b:8bc8 with SMTP id h16-20020a5d4fd0000000b002cc459b8bc8mr18152437wrw.6.1680188730219;
        Thu, 30 Mar 2023 08:05:30 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id k16-20020a5d6d50000000b002cff0e213ddsm33005646wri.14.2023.03.30.08.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 08:05:29 -0700 (PDT)
Date:   Thu, 30 Mar 2023 20:05:27 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     Dan Carpenter <error27@gmail.com>, outreachy@lists.linux.dev,
        Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: refactor arche_platform_wd_irq()
 function
Message-ID: <ZCWlNxAObqge3AB6@khadija-virtual-machine>
References: <ZCH6LV5XU0FBlW7Y@khadija-virtual-machine>
 <a64ad550-9991-4f54-8e09-735133422291@kili.mountain>
 <ZCNygZ8aPsElfTK6@aschofie-mobl2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCNygZ8aPsElfTK6@aschofie-mobl2>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 04:04:33PM -0700, Alison Schofield wrote:
> On Tue, Mar 28, 2023 at 10:33:23AM +0300, Dan Carpenter wrote:
> > On Tue, Mar 28, 2023 at 01:18:53AM +0500, Khadija Kamran wrote:
> > > Refactor function by adding goto statement. This reduces the
> > > indentation and fixes the issue reported by checkpatch.pl script.
> > > 
> > > "CHECK: line length of 101 exceeds 100 columns"
> > > 
> > > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> > > ---
> > >  drivers/staging/greybus/arche-platform.c | 11 ++++++-----
> > >  1 file changed, 6 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
> > > index fcbd5f71eff2..c7d3b6f7368f 100644
> > > --- a/drivers/staging/greybus/arche-platform.c
> > > +++ b/drivers/staging/greybus/arche-platform.c
> > > @@ -178,11 +178,7 @@ static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
> > >  				 */
> > >  				if (arche_pdata->wake_detect_state !=
> > >  						WD_STATE_COLDBOOT_START) {
> > > -					arche_platform_set_wake_detect_state(arche_pdata,
> > > -									     WD_STATE_COLDBOOT_TRIG);
> > > -					spin_unlock_irqrestore(&arche_pdata->wake_lock,
> > > -							       flags);
> > > -					return IRQ_WAKE_THREAD;
> > > +					goto out;
> > 
> > I don't like this goto.
> > 
> > It suggests that calling arche_platform_set_wake_detect_state(arche_pdata, WD_STATE_COLDBOOT_TRIG);
> > is a part of a shared exit path when that is not true so it is sort of
> > lying to the reader and making things harder to understand.
> > 
> > Unlocking is shared.  goto unlock is fine.  But that doesn't help with
> > the very long lines.  (I am not saying that goto unlock is a worthwhile
> > patch to send but I would definitely have found it tolerable).
> > 
> > regards,
> > dan carpenter
> 
> 
> Khadija,
> While you are reworking this, just wanted to note that, once 'out:'
> becomes the single exit path for the function, it won't be a lie
> any more. So you will have addressed Dan's concern.
> Alison
>

Hey Alison,

Yes, I understand. Thank you. :)

Regards,
Khadija

> 
> > 
> > >  				}
> > >  			}
> > >  		}
> > > @@ -205,6 +201,11 @@ static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
> > >  	spin_unlock_irqrestore(&arche_pdata->wake_lock, flags);
> > >  
> > >  	return IRQ_HANDLED;
> > > +
> > > +out:
> > > +	arche_platform_set_wake_detect_state(arche_pdata, WD_STATE_COLDBOOT_TRIG);
> > > +	spin_unlock_irqrestore(&arche_pdata->wake_lock, flags);
> > > +	return IRQ_WAKE_THREAD;
> > >  }
> > >  
> > >  /*
> > > -- 
> > > 2.34.1
> > > 
> > 
