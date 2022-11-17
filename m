Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2130062DD32
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 14:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239716AbiKQNug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 08:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239841AbiKQNuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 08:50:32 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0499165FE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:50:31 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so1169936wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 05:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bkweVlMZ0g0+u7fAZmYu/Pqe+/vJOvCRgkDADGgIA2s=;
        b=iJErqAPL10YQES5nboDu00n0QHsr9m4pN7t6xt4KI04Mz+DP7wuasgAh2j2ltzCP7P
         fbniCxcdL0NkfwMQoE99Pj9zmUXLDPDT3R6K6p13KyhzVYaKQwJpMWrpG3yn0nxVIsPO
         hICRLxHlr/hxX/h9x9nxYuVzsZI+aUqWWOhIem0U/TeB8i7xrljLnMRdnsxMVn+rAC+6
         i2QyMpIte+Tdfes76l9WVet1zrSFBmN+ibKexVtjOdfBhthB5FtSSHDD2t4+OFCMJNr7
         27HUbFg9xFyyN7mlaz0e39o+8rNa/0vDhU9BgUsDllr+H49glFZ+Jx4zyZWdz7d2e/gB
         zaoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkweVlMZ0g0+u7fAZmYu/Pqe+/vJOvCRgkDADGgIA2s=;
        b=Jd7Fm93V3Y8NHq5wtg5fIf0NXGwYrxIr4x2glegh2txnrS7PiQTJJGlQYeslrqJmM8
         863VZAQMR+FkESNAOEW/S4Nh+VIPV0T8fgG/lJXcv3y6PPceYPkD0gDo197fkTmtNf/G
         tArnbKgy533EGKZVdS8Q99/8bPl1mREpDDSEjHul8BTq8JS9e4ligC2/pe3zaxIoSBXP
         +E05n97hX7+WA+boqtWkgFt3mdzkUayNlAgk0yMjUcZzjJNtMDKdGPZ0q0foiW3JhOTX
         oW4hXakxJAWvoQDiGfEHT6dIgMDQ2wbaoeL6tsWrR8ICioRfvFpVryUcP/U9YFuLvvHT
         1IoQ==
X-Gm-Message-State: ANoB5pk9MACuYKK4kTFd/vUR6Uc4eBT1Gdd8yTIF8JPkemlT5Skv5v2n
        lrIhdXS0YBqB0JyvjVtfQaQ=
X-Google-Smtp-Source: AA0mqf7iBPPgpyhI2Y14QqG2ZA1qB6Du3tc53khekXZEK+mYE7Ut5oqgY1wpI9Q2tux1n5o87QHlkA==
X-Received: by 2002:a05:600c:188a:b0:3cf:8e62:f769 with SMTP id x10-20020a05600c188a00b003cf8e62f769mr5426381wmp.52.1668693029460;
        Thu, 17 Nov 2022 05:50:29 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p11-20020a05600c468b00b003c65c9a36dfsm1369329wmo.48.2022.11.17.05.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 05:50:29 -0800 (PST)
Date:   Thu, 17 Nov 2022 16:50:24 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kieran.bingham@ideasonboard.com
Subject: Re: [PATCH 1/2] staging: vc04_services: mmal-vchiq: Do not assign
 bool to u32
Message-ID: <Y3Y8II27ncbz0bLy@kadam>
References: <20221117125953.88441-1-umang.jain@ideasonboard.com>
 <20221117125953.88441-2-umang.jain@ideasonboard.com>
 <Y3Yziqaj9majJlNl@kroah.com>
 <5f139eeb-24cc-85c1-34b6-f1334313839f@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f139eeb-24cc-85c1-34b6-f1334313839f@ideasonboard.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 06:57:07PM +0530, Umang Jain wrote:
> Hi Greg,
> 
> Thanks for the comment,
> 
> On 11/17/22 6:43 PM, Greg Kroah-Hartman wrote:
> > On Thu, Nov 17, 2022 at 06:29:52PM +0530, Umang Jain wrote:
> > > From: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > > 
> > > struct vchiq_mmal_component.enabled is a u32 type. Do not assign
> > > it a bool.
> > > 
> > > Fixes: 640e77466e69 ("staging: mmal-vchiq: Avoid use of bool in structures")
> > > Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > > Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> > > ---
> > >   drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> > > index cb921c94996a..17f8ceda87ca 100644
> > > --- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> > > +++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
> > > @@ -1773,7 +1773,7 @@ int vchiq_mmal_component_enable(struct vchiq_mmal_instance *instance,
> > >   	ret = enable_component(instance, component);
> > >   	if (ret == 0)
> > > -		component->enabled = true;
> > > +		component->enabled = 1;
> > Why not make enabled a bool instead?
> 
> Makes sense. It would probably require reverting the 640e77466e69 ("staging:
> mmal-vchiq: Avoid use of bool in structures")
> 

Reverting that patch seems like a good idea.

regards,
dan carpenter

