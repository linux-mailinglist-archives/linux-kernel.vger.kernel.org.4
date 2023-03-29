Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8DA26CF593
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 23:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjC2Vtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 17:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC2Vts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 17:49:48 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61C8BD;
        Wed, 29 Mar 2023 14:49:47 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-544f7c176easo319128127b3.9;
        Wed, 29 Mar 2023 14:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680126587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bLzqW9E7Vje/S3+bqfoRtQwKEl51pj+2gVk1LfZ98d0=;
        b=hq3Qkjo7hoaxe1Ytv160du/memvuvOZPoKAd23HeI40umX0qtkw8qW1Hccs3T5kLp9
         /OwaRrs5jOUiBA+thGKMaxyJQ5YtWAtWSTToUFBMjqa/gVsz3dHKEp3e9dc/f8PbfafC
         0M8nz9W90RRJ4ByzLGrC8B54RqMkWtarGI+RHA4XIG6WlqPdSon354gUwNGDCdk11g+/
         DrodG03cx/TlS1yktXLFoI81etmNn9HJ0wNuxIoKsUGaVlxluJCL3rQmI6f50FTYf7r4
         tlwF0YCD5oyIHZNcElgDn2gHwGkeBHLkwEMOUQ2BIQ0eNuY0s4+i6xSV7yw+xcZSqEi8
         JJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680126587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bLzqW9E7Vje/S3+bqfoRtQwKEl51pj+2gVk1LfZ98d0=;
        b=4RlEodEsWl0wLSahSJECNI+YN8QD7hO3JRePJKRU8mofOygsnzkrlCKdnrneHgnG8u
         VLnTn4VQfpxvzH9VkVo2GzpEo6bwqpB9XkehYRRW2iN7nhj4NScAh3BS4UiDRTKWNOt/
         9ZW1k/5HfBfirjMV9Rjov2CNMzjlpKZg5ptlCYyjxo2MgwTHHFZSukV6Cy8hPPnNkXL5
         Al/4k8bK+/qR53kBelIsEMvy16xThjByyQyQo3E2RdfquGgz3D6FTanks0sKAsNka9xf
         bRcAT06omxG9sPLdCRWPdIafsnbUndt7vvFwuJjli17zy4Igo+J0gMnbujItQpacFGLq
         fx8g==
X-Gm-Message-State: AAQBX9elwZHzyGjb2K7bNB03+1DyA6mlZRrdnlmR9itzw0yS4jyYXC+0
        wsGPMX3GnPHwQcsEoB8tXvU=
X-Google-Smtp-Source: AKy350bi0gvarik5Vm5wxsu4GMrTawQ/RK/k/eub3gc/hasypwv/XXmclMYglYfJgkNe5I5IcRqmog==
X-Received: by 2002:a81:d550:0:b0:541:6d91:fb5d with SMTP id l16-20020a81d550000000b005416d91fb5dmr18025640ywj.13.1680126587048;
        Wed, 29 Mar 2023 14:49:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i82-20020a25d155000000b00b7767ca7480sm3684829ybg.29.2023.03.29.14.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 14:49:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 29 Mar 2023 14:49:45 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "peter.ganzhorn@gmail.com" <peter.ganzhorn@gmail.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] coretemp: Fix spamming of ring buffer
Message-ID: <6e96d2b8-d64c-417c-bbcb-4aa59921c9db@roeck-us.net>
References: <CA+3fRbFzq38sQomFM7xJt-UoeLv_ZZbQ2uaHZ+8J_5ntweJ7TA@mail.gmail.com>
 <7e821f80b7700fcf1fb26f40bde8397f0e5e6d7e.camel@intel.com>
 <aeed703c-5dbb-4a6f-a4d7-3c6a55d99e9e@roeck-us.net>
 <51b2d540c174690a8e460ecba53b0195c4b01294.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51b2d540c174690a8e460ecba53b0195c4b01294.camel@intel.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 02:11:36PM +0000, Zhang, Rui wrote:
> On Wed, 2023-03-29 at 05:47 -0700, Guenter Roeck wrote:
> > On Wed, Mar 29, 2023 at 03:43:58AM +0000, Zhang, Rui wrote:
> > > Hi, Peter,
> > > 
> > > CC the list.
> > > 
> > > On Tue, 2023-03-28 at 22:37 +0200, Peter Ganzhorn wrote:
> > > > Dear Mr. Rui,
> > > > Dear Mr. Roeck,
> > > > 
> > > > please consider accepting the attached patches or
> > > > modifying the coretemp code to stop spamming my syslog.
> > > > I would appreciate it very much if you can accept the patches.
> > > > 
> > > > coretemp: Improve dynamic changes of TjMax
> > > > After introduction of dynamic TjMax changes in commit
> > > > c0c67f8761cec1fe36c21d85b1a5400ea7ac30cd
> > > > my syslog gets spammed with "TjMax is ... degrees C"
> > > > messages.
> > > > If TjMax is subject to change at any time, it won't be
> > > > set in tdata anymore and re-read every time from MSR.
> > > > This causes quite a lot of dev_dbg() messages to be issued.
> > > > 
> > > > The following patches change the code to read TjMax
> > > > from the MSRs into tdata->tjmax (again) but allow for a
> > > > dynamic update at any time as well. (Patches 1 and 2)
> > > > This way a message will only be issued after actual changes.
> > > > Also I replaced the dev_dbg() with dev_notice (Patch 3) and
> > > > added a additional dev_notice for the case where TjMax is
> > > > set based on assumptions. (Patch 4)
> > > > 
> > > > 
> > > > If you do not want to accept my patches, removing the
> > > > dev_dbg() in get_tjmax() would be the most simple
> > > > solution I guess.
> > > > 
> > > Please check if below patch solves your problem or not.
> > > 
> > > From 9370ee5163a85f65230b5222f1f4dece59ce078a Mon Sep 17 00:00:00
> > > 2001
> > > From: Zhang Rui <rui.zhang@intel.com>
> > > Date: Wed, 29 Mar 2023 11:35:18 +0800
> > > Subject: [PATCH] hwmon: (coretemp) Avoid duplicate debug messages
> > > 
> > > Avoid duplicate dev_dbg messages when tjmax value retrieved from
> > > MSR
> > > does not change.
> > > 
> > > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > > ---
> > >  drivers/hwmon/coretemp.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> > > index 30d77f451937..809456967b50 100644
> > > --- a/drivers/hwmon/coretemp.c
> > > +++ b/drivers/hwmon/coretemp.c
> > > @@ -267,6 +267,7 @@ static int get_tjmax(struct temp_data *tdata,
> > > struct device *dev)
> > >  	int err;
> > >  	u32 eax, edx;
> > >  	u32 val;
> > > +	static u32 tjmax;
> > 
> > That would apply to every instance of this driver, meaning to every
> > CPU core. Is that really appropriate ?
> > 
> > Guenter
> > 
> Good point.
> 
> MSR_IA32_TEMPERATURE_TARGET is package scope, and the cached tjmax
> should also be package scope, or else this message is shown for each
> cpu when tjmax changes in one package.
> 
> Previously, the message is printed only once during driver probing time
> thus I'm wondering how useful this is.
> 
> Maybe we can just delete it?
> 
Personally I would delete it. I don't see the value of clogging the kernel
log with it.

Guenter
