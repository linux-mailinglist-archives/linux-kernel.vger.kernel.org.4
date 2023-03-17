Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D256BE669
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 11:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjCQKSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 06:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjCQKS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 06:18:26 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFC22915D;
        Fri, 17 Mar 2023 03:18:24 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id d13so4635712pjh.0;
        Fri, 17 Mar 2023 03:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679048304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jNrsgXJ/NWO4n3wCF2k2m7jKTXJyy3MF3Cvwg3Uy3NA=;
        b=mk9iZOkddVyJfCp7Olo5O4XCEMgkl8jh1V5YMscOlraSfjEF/wccoTP68bDcicVXyQ
         RAP3yxKQRZ+O78429GJgP6YG4Z1Nt2Hzh2GUza/Y4asXFsXcJkvm2HJZNoauqvEEvCY5
         018PkqnBT8h75JM0XCItIKm0Wc0hnfQWaAJy6e2G0CCEFbp5tVZ6yR4eiU907ZyJzUIS
         QbwfHFL8wNT1F6bXwgd5h9sbFyT0kZc8e384khSAzwHoNOgV6RcbjoCajuPQqX0QDVbr
         DXQ5Z+/mP1Yk5/s3SiUf183M0mtVV/LZM5h2be0oMbUERiogv1atqPn8USMwsKPNPHhE
         q3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679048304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNrsgXJ/NWO4n3wCF2k2m7jKTXJyy3MF3Cvwg3Uy3NA=;
        b=eWX45yeBb6CsOLsT78o46rtaNB0knR8mxKZViG6HxIiepmLToA7GAjSUUPZAZhpq6z
         YxZYFJ+E38XRF7xAtdek0aMTGQ2QB1ikKt885bteErN3lwnAFS9VXQZy7GYDwTKBG+9U
         b4wl23XPthyEIkeqtjtXbt8eIoCY2uLnxCz946tM6xvH8m834R7XAbtri2ZdDMtlrIGS
         4Jm65PKJRpC54taX2ff9yvUxtHsEOioQ8sOOcF5ZR2gCCwPgmkLzDprneVzrSUZcerUG
         Nz+ZiiwISWeqLwAgRi0K+l9r+7k/Zn71lETBfJzZROCmLzqRiGjSPZb85+YSXWZHnFln
         LHtg==
X-Gm-Message-State: AO0yUKWfYREtQEFEn2NyxXae7R6fP/dOScY3yYo3Uj0+Mxck8RbatTd+
        i6PxWqhhJefd5FNGN0H1AXgmZ5uQEicelA==
X-Google-Smtp-Source: AK7set8pf1fpeZS0Pk0HI6/6Rximln0raPIwWyOapFyANc7AXiUJSM5N8CDaSqrCWVUzh8kvSzjY6A==
X-Received: by 2002:a17:902:e883:b0:19a:75b8:f50c with SMTP id w3-20020a170902e88300b0019a75b8f50cmr8519707plg.31.1679048304190;
        Fri, 17 Mar 2023 03:18:24 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:d084:8252:e846:af61])
        by smtp.gmail.com with ESMTPSA id 17-20020a170902c11100b0019ee045a2b3sm1187843pli.308.2023.03.17.03.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 03:18:23 -0700 (PDT)
Date:   Fri, 17 Mar 2023 03:18:20 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andi Shyti <andi.shyti@kernel.org>
Cc:     Igor Artemiev <Igor.A.Artemiev@mcst.ru>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [lvc-project] [PATCH] Input: trackpoint - remove unreachable code
Message-ID: <ZBQ+bJQkcZREArAq@google.com>
References: <20230314122714.1494260-1-Igor.A.Artemiev@mcst.ru>
 <20230314131356.cwb4nd7i43sws75j@intel.intel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314131356.cwb4nd7i43sws75j@intel.intel>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 02:13:56PM +0100, Andi Shyti wrote:
> Hi Igor,
> 
> On Tue, Mar 14, 2023 at 03:27:14PM +0300, Igor Artemiev wrote:
> > The trackpoint_sync() function always returnd 0.
> > And there is no need to check its result.
> > 
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > 
> > Fixes: 2a924d71794c ("Input: trackpoint - only expose supported controls for Elan, ALPS and NXP")
> > Signed-off-by: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
> 
> I don't think it requires the Fixes tag... it's not really
> broken.
> 
> > ---
> >  drivers/input/mouse/trackpoint.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/input/mouse/trackpoint.c b/drivers/input/mouse/trackpoint.c
> > index 4a86b3e31d3b..561a4d2d81ff 100644
> > --- a/drivers/input/mouse/trackpoint.c
> > +++ b/drivers/input/mouse/trackpoint.c
> > @@ -386,9 +386,7 @@ static int trackpoint_reconnect(struct psmouse *psmouse)
> >  	was_reset = tp->variant_id == TP_VARIANT_IBM &&
> >  		    trackpoint_power_on_reset(&psmouse->ps2dev) == 0;
> >  
> > -	error = trackpoint_sync(psmouse, was_reset);
> > -	if (error)
> > -		return error;
> > +	trackpoint_sync(psmouse, was_reset);
> 
> what worries me here is that if this returns always '0' who tells
> me that it will always return '0'?
> 
> One day someone might add an error return path and you would miss
> it here.
> 
> Would it make sense to make the trackpoint_sync() a void function
> as well?

Yes if we are dropping the check we should also change the function to
not return anything.

Thanks.

-- 
Dmitry
