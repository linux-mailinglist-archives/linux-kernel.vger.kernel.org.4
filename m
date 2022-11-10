Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53FFF6243F0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 15:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbiKJONy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 09:13:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbiKJONh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 09:13:37 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13EAD6DCEB;
        Thu, 10 Nov 2022 06:13:04 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-13bef14ea06so2284521fac.3;
        Thu, 10 Nov 2022 06:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DYJeoXlm3yi8zCQziAodIBu91C3vT3wnxmJjU1RBcLg=;
        b=ZW7iTIRo+gVE9j2/T/pKdnJRA/34++TOOpF9qgmCWUQ7kzL6Bd8WEWkXEqZRv4TYSD
         kvRVOaDbJe+sjksGPjNA8o48CcucZ/CsceiwbOBYPGy3hbgh+PE1rcdFr3ewnYueU4hU
         4pyOEgFNsfaG5FEXOjDbRsmMXtb1OaTvDQ0IBVcIxPx+PCgB5zlWmCGJZbWM5FFhnC4a
         Gl4Lwg9XHT83A74S0QCdCyca+4VUsckvXZN7Zb1FhQmuplYvbSBKtv1fwfLvxbkbLcX+
         zsDk1f7RgcDLzJw9kOL10QJNTzK6nSh7MXWRRJSV6Iy8iPeCk+DF5AEoGOE0i4DUYe56
         ai3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DYJeoXlm3yi8zCQziAodIBu91C3vT3wnxmJjU1RBcLg=;
        b=5/sgvuZfrAn9JIuArsUCgFsSV/VA75LO7yMoAi/raixM7GN7CG/sfUsRhYILftdUe+
         Lh2UsaTcc617mGSiQQt9lxeE4c0I5kd/Zob9dKGn/lseX63FL9skA2R1UxOKn1akceGu
         CyErIi71/10ai55aNSVk8bGzRWmnaqYM0+YtbY4R2x1boNJasMBe22veXPSYIBoLer/Z
         DhCgMINtn2DnEDB9AIjfbilkX2xWKT2luQuI5eIKuMyx58jk1kWOCdydiX/7gT2IzEbA
         48PPf6GLVLivJtngZmFSc59F4k4aQ57HY40uay7mKjB+NDDrW+gLHQt0MP2mgUN4t4tQ
         LSUA==
X-Gm-Message-State: ACrzQf3JpA3q0Im9kg8pr3FYjy2JLiLwiQeD4mKcl3yaKzMqogCFwo3Q
        SYL8V946w7gCsT3J3iFbeBfgnkuFbYc=
X-Google-Smtp-Source: AMsMyM7FQFew3dlfaZXqZS5BVhdMDahkep5gSS4N1Xn19p40y7TLcmiZuzAVJtpozekQ7qZgYgfOsA==
X-Received: by 2002:a05:6870:cb8b:b0:13b:c9b3:1508 with SMTP id ov11-20020a056870cb8b00b0013bc9b31508mr1576255oab.236.1668089583423;
        Thu, 10 Nov 2022 06:13:03 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z20-20020a9d62d4000000b0066c34486aa7sm6341956otk.73.2022.11.10.06.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 06:13:03 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 10 Nov 2022 06:13:02 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/9] thermal/core: Ensure that thermal device is
 registered in thermal_zone_get_temp
Message-ID: <20221110141302.GB2404288@roeck-us.net>
References: <20221017130910.2307118-1-linux@roeck-us.net>
 <20221017130910.2307118-4-linux@roeck-us.net>
 <CAJZ5v0hcwCqfSh32U5zVnpBxmziJHYYCfhJ9uJLJ0gVvkrP-5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hcwCqfSh32U5zVnpBxmziJHYYCfhJ9uJLJ0gVvkrP-5w@mail.gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 08:07:48PM +0100, Rafael J. Wysocki wrote:
[ ... ]
> >
> > diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
> > index c65cdce8f856..3bac0b7a4c62 100644
> > --- a/drivers/thermal/thermal_helpers.c
> > +++ b/drivers/thermal/thermal_helpers.c
> > @@ -115,7 +115,12 @@ int thermal_zone_get_temp(struct thermal_zone_device *tz, int *temp)
> >         int ret;
> >
> >         mutex_lock(&tz->lock);
> > +       if (!device_is_registered(&tz->device)) {
> > +               ret = -ENODEV;
> > +               goto unlock;
> > +       }
> >         ret = __thermal_zone_get_temp(tz, temp);
> > +unlock:
> 
> I would do it this way:
> 
> if (device_is_registered(&tz->device))
>         ret = __thermal_zone_get_temp(tz, temp);
> else
>         ret = -ENODEV;
> 
Done in all patches. Agreed, that looks much better.

Thanks,
Guenter
