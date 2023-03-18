Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A31B6BFC0D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 18:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjCRRzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 13:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjCRRzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 13:55:44 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D141F5F1;
        Sat, 18 Mar 2023 10:55:41 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id h8so8416289plf.10;
        Sat, 18 Mar 2023 10:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679162141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=81qaQdBcBEP2jHfYRJB7eE244mJTlBVviRI7USBuECw=;
        b=AK7708FUtr5f/inCfiB0yMc0/h3V8fqEYmQnW0dtGVhFsTxuLGkAXuxMFjDK3z3PSh
         SFbLz2DmNOczUkpncbTl8uftF4cQ7yThClmt3P/70TNVlcG2XF+SW+/gv49pnuDbecE8
         sGgk6zihg2H2Oh4BdHDi436izZltHaRKiOrN1ta9V2h5aYoa1pcmCfG6XPE28VhuIg0P
         7AeG2IkR24bqU+uG3Qk4tBO2nIUlO3VYmdovXyKpbZae5w2ur7BA3pjNG+mb9yv6PhBT
         3dxAULCVXyXEM6lTAQI+e2YvTIX1RtF5gQH4K22JQE2dNClQkdXE9Oy9kLok/olDMb9d
         6ORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679162141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=81qaQdBcBEP2jHfYRJB7eE244mJTlBVviRI7USBuECw=;
        b=O5eLim1OC3zsv/uoXCJx8iPOA/j2GuAaTJd7MPaJW08fFN/guptEcFEo9YZrjNKUWG
         i2sl3+JOkvj23eLk7WyjLUFp1OKC/R9cf+cHNZPFPwxDRyd/jDSxCpPphspT2Z1txkGz
         Ke6gj7WM3haaiiiForCbaYPul1ORMGxp9W2MuthMvq7QPxV4LqmcULuFtKdGQfxFA34V
         G60ho+TBlcyWJ+EqHjc5yguyz57684Q8c8L2uKpMkXIIiKTsJ5+yQUaW/2vfasdXdwYO
         By78k8rEYkjTbPsD5s8QEgKZ/3Qah4LAr8j8VM4DndGZSApGnVs9O1nrah5dD4o5ltrT
         aCxA==
X-Gm-Message-State: AO0yUKVAYDvK3w2Lc9tZ/piKI6qAgRDKOWgNVWlsEViscQ+6/IJV4rMy
        drriNSBYn1pvoc0r3QdVTrs=
X-Google-Smtp-Source: AK7set/hbzhTcYbmFLhKb0SHtB97paH+z56ao+FfTyjpzr2In6PrTz9qj8HLnFeT69UAeY0frWIJkw==
X-Received: by 2002:a17:90a:1903:b0:23b:2963:ec94 with SMTP id 3-20020a17090a190300b0023b2963ec94mr12832199pjg.29.1679162141142;
        Sat, 18 Mar 2023 10:55:41 -0700 (PDT)
Received: from sumitra.com ([117.199.163.158])
        by smtp.gmail.com with ESMTPSA id b17-20020a631b51000000b004e28be19d1csm3439677pgm.32.2023.03.18.10.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 10:55:40 -0700 (PDT)
Date:   Sat, 18 Mar 2023 10:55:32 -0700
From:   Sumitra Sharma <sumitraartsy@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Marc Dietrich <marvin24@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ac100@lists.launchpad.net, linux-tegra@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH] Staging: nvec: Change container_of macro to an inline
 function.
Message-ID: <20230318175532.GA49651@sumitra.com>
References: <20230318170514.GA49181@sumitra.com>
 <alpine.DEB.2.22.394.2303181811260.2914@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2303181811260.2914@hadrien>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 18, 2023 at 06:14:50PM +0100, Julia Lawall wrote:
> 
> 
> On Sat, 18 Mar 2023, Sumitra Sharma wrote:
> 
> > The macro has the drawback that one cannot determine
> > what type it applies to by looking at the definition.
> > Hence this macro definition is not type-safe.
> >
> > The inline function gives the same benefits as the
> > macro and only accepts the specific type of arguments.
> > Use static because the definition only requires it to be
> > visible in the current file.
> 
> Sumitra,
> 
> The subject line and log message could be a little less generic.  For the
> subject line, one has the impression that you are changing the definition
> of container_of itself.
> 
> The log message is also a bit wordy.  Something like the following would
> be more concise and still present the issue:
>

Okay. I will focus more on writing better patch subject and description.

Thanks.

Regards,

Sumitra

> Convert to_nvec_led from a macro to an inline function, to make the
> relevant types apparent in the definition and to benefit from the type
> checking performed by the compiler at call sites.
> 
> julia
> 
> 
> >
> > Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
> > ---
> >  drivers/staging/nvec/nvec_paz00.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/staging/nvec/nvec_paz00.c b/drivers/staging/nvec/nvec_paz00.c
> > index 8b4da95081c8..9573ba762cdd 100644
> > --- a/drivers/staging/nvec/nvec_paz00.c
> > +++ b/drivers/staging/nvec/nvec_paz00.c
> > @@ -14,8 +14,10 @@
> >  #include <linux/platform_device.h>
> >  #include "nvec.h"
> >
> > -#define to_nvec_led(led_cdev) \
> > -	container_of(led_cdev, struct nvec_led, cdev)
> > +static inline struct nvec_led *to_nvec_led(struct led_classdev *led_cdev)
> > +{
> > +	return container_of(led_cdev, struct nvec_led, cdev);
> > +}
> >
> >  #define NVEC_LED_REQ {'\x0d', '\x10', '\x45', '\x10', '\x00'}
> >
> > --
> > 2.25.1
> >
> >
> >
