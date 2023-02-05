Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A468968AD8D
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 01:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjBEAOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 19:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjBEAOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 19:14:16 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7955F1E2A0
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 16:14:15 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id hx15so24913368ejc.11
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 16:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qjRTcAwvizSrldTVDXNqkh4xAee6ddjrgFnaGK7k4GY=;
        b=KrAaGzHg5ZVNEIUHq4Lv46fQi3zcGcV7z3QnuHIG32zrrcnmr8hxxio3idmnLnjXEQ
         n2SeqHrlx4qCgVek88ckBUZjMrJMPPhe5bjH4xvk0JThjqKpw3MOCu6R/KVue3V/Dhpq
         CS12/KjPRxLFIpxn7H1saK2j8mfdsp2YbfjpOUDqeiYeRcIRcoKlQuTZMcthkCVS1KZI
         IqcILwygUjWjtjDxFkWwaKmk8zzIJ1V3wgkhXrRtOb0KzrPdJimIinAaSJh2TydOdWBu
         GBC/e4s3jwaDohzx7YjwjJ4V09IMWDg3ZG8bPTZmvz031gAcaaAk4a4ekxh+RnqPv5XP
         YVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjRTcAwvizSrldTVDXNqkh4xAee6ddjrgFnaGK7k4GY=;
        b=uCYsPekeJ151BnN88w0OpBZJCZYzHsnoLEDrg1OOSYL+EaIaaaTDXiRCfSNnmigjao
         bgAOBf1gn74Rlehpe8MGAv3gH8QoXPYjX7deYNNFEhXr1sOWQuSBMvn+hNTJ/pvPdNox
         L78XJ89WiVwFO4MyCyRhXqeyKn3Mf221n37gNQvwD6Cas2MGEZSL7Md1HiWpSoKF6JI4
         HSQ0HM4IV9kVsBGRiN4cP2xpA+a2RQIJg8wNz8FUFMol5X/4QZZUzSi3udrFW3jrEhC/
         HeUAmn5Cs0k4hSyR7mfceJwTdECZgE5HCwxUPDaiFtqA2kCTAtFOag5NgOPDDy8T0wLo
         uPMA==
X-Gm-Message-State: AO0yUKXjvt7n2l4NJIZtWLvKChvbjYWPwg9GO0Ae2pxhr1nqCBnsjdLe
        xLN0OFacGAOry37YUsRdstY=
X-Google-Smtp-Source: AK7set8WLerYJAW6HtJNzL8h3IJvLOEfyASOfPRDAUgw5uJlouaoingiW1zQSkTTic0z1rW0b4vf3A==
X-Received: by 2002:a17:906:1810:b0:885:5682:7e52 with SMTP id v16-20020a170906181000b0088556827e52mr13801398eje.13.1675556053917;
        Sat, 04 Feb 2023 16:14:13 -0800 (PST)
Received: from combine-ThinkPad-S1-Yoga (c-8ff371d5.879159-0-69706f6e6c79.bbcust.telenor.se. [213.113.243.143])
        by smtp.gmail.com with ESMTPSA id f21-20020a056402195500b0049be07c9ff5sm3144294edz.4.2023.02.04.16.14.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 16:14:13 -0800 (PST)
Date:   Sun, 5 Feb 2023 01:14:11 +0100
From:   Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6655: Add braces to macro parameter 'iobase'
Message-ID: <Y97006iBeoRV7I8b@combine-ThinkPad-S1-Yoga>
References: <Y93WEZGlT5Vmeb50@combine-ThinkPad-S1-Yoga>
 <Y94PXceerdFTBg5e@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y94PXceerdFTBg5e@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 04, 2023 at 08:55:09AM +0100, Greg Kroah-Hartman wrote:
> On Sat, Feb 04, 2023 at 04:50:41AM +0100, Guru Mehar Rachaputi wrote:
> > This patch is to fix checkpatch warning: "Macro argument 'iobase' may be better
> > as '(iobase)' to avoid precedence issues.
> > 
> > Signed-off-by: Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
> > ---
> >  drivers/staging/vt6655/mac.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
> > index acf931c3f5fd..a33af2852227 100644
> > --- a/drivers/staging/vt6655/mac.h
> > +++ b/drivers/staging/vt6655/mac.h
> > @@ -537,9 +537,9 @@
> >  
> >  /*---------------------  Export Macros ------------------------------*/
> >  
> > -#define VT6655_MAC_SELECT_PAGE0(iobase) iowrite8(0, iobase + MAC_REG_PAGE1SEL)
> > +#define VT6655_MAC_SELECT_PAGE0(iobase) iowrite8(0, (iobase) + MAC_REG_PAGE1SEL)
> 
> This change really doesn't make much sense, right?  How about turning
> these into an inline function instead?  That would be the correct thing
> to do overall, right?
> 
> thanks,
> 
> greg k-h

Thanks for the reply and advice.
I have modified accordingly and sending in as a v2 patch for the above.

--
Thanks & Regards,
Guru
