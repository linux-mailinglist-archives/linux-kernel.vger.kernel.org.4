Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1CE6243E4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 15:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbiKJOMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 09:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiKJOME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 09:12:04 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C716DCDD;
        Thu, 10 Nov 2022 06:12:01 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id cn2-20020a056830658200b0066c74617e3dso1176492otb.2;
        Thu, 10 Nov 2022 06:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qgitUI25orkTm6hu0BUf7qb2z/SQWHD4V7BDy7lOFss=;
        b=Qof1BVpWA73p43EjL/UhEFiBNyunqnZqTW6lqveRYVwSClwz/+4OgDagYm/Y/HTo6P
         7gjv9jwo33AqRRMr+wMHHTJoHOf4SitbCZkUE+m55SEVJ+QMkdU/LUXuTG5H/iDdX5J9
         FPXdjzUiIbYoDm4puM5xAAz8BcmDoU9OoMbabL5N0P8k+CKhlOnCs7xY2I/RpJ90klFV
         gaAIF1VM0RTZ5zy7qO4cre9azbyyFpZL8sSzav8lMaj08Bq+NGs9w4k8oNhwVIFajlev
         t0AGRjEsO6Da9ZDq3xdxIWXaA84ZInMkPkBx3s+MEJW4sK+5EtQKBXxdTyI+ilCRkD+j
         kYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qgitUI25orkTm6hu0BUf7qb2z/SQWHD4V7BDy7lOFss=;
        b=7bZ0b3UJRiJ5/FqVfyQTb256ClhHw53UG5wBdQC/WCy6OCAyskW1+P4GmkhgrCIXHm
         yfxbbvQDjGjEXL+gb4W91xJG2xxRwYXsmSxqFXbnyRhnIJ1DlySr86P71LLhPA5BSKFV
         FPBztgKsPWSU9qRRaD4Mewr0M265JJo2thU9pk3/PRSF/ZjTHvILvS1t2eV6Ma2+xHAX
         OsOhlV3m8c+5yrxj2SGwXl9HZA+Q0gs9m63VJBY0oyrvKW1cCEoohIUlcwYnhaFhdnJf
         eH5bgHS/k6zsLjWFN/IyfQlhgnBXWtitLRTTPaXj5+ABcgiiRYl2ApVQKVtMWmSuVndh
         /J5g==
X-Gm-Message-State: ACrzQf1QYtIXKmS4Yvfj/ZdRjm1L0gWQQ5WY4cpaq48R60Cpr5Rkumlk
        0EGa7zBA5/lcDq63A1sbZIc=
X-Google-Smtp-Source: AMsMyM6FNRRmBkuiFe5OHi2HI6hH6b6xDPmqXhlZK1d0kjPEzn36ZBwt9Wvr5U0KJY6mtYfj7evr5Q==
X-Received: by 2002:a9d:1aa:0:b0:66c:6922:8640 with SMTP id e39-20020a9d01aa000000b0066c69228640mr1402503ote.34.1668089520403;
        Thu, 10 Nov 2022 06:12:00 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x66-20020acae045000000b0034d8abf42f1sm5709639oig.23.2022.11.10.06.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 06:11:59 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 10 Nov 2022 06:11:57 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] thermal/core: Introduce locked version of
 thermal_zone_device_update
Message-ID: <20221110141157.GA2404288@roeck-us.net>
References: <20221017130910.2307118-1-linux@roeck-us.net>
 <20221017130910.2307118-6-linux@roeck-us.net>
 <CAJZ5v0hO9_95uD1qY8aBe094JWsxPrba2wk_PchKHmVqRj0CHw@mail.gmail.com>
 <20221110002549.GA3550654@roeck-us.net>
 <CAJZ5v0je2QSUhU8Knk9UsboGLRpk2sNqE6U4X6eGAe+NUxZt_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0je2QSUhU8Knk9UsboGLRpk2sNqE6U4X6eGAe+NUxZt_Q@mail.gmail.com>
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

On Thu, Nov 10, 2022 at 02:01:49PM +0100, Rafael J. Wysocki wrote:
> On Thu, Nov 10, 2022 at 1:25 AM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > On Wed, Nov 09, 2022 at 08:15:17PM +0100, Rafael J. Wysocki wrote:
> > > On Mon, Oct 17, 2022 at 3:09 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > >
> > > > In thermal_zone_device_set_mode(), the thermal zone mutex is released only
> > > > to be reacquired in the subsequent call to thermal_zone_device_update().
> > > >
> > > > Introduce __thermal_zone_device_update() as locked version of
> > >
> > > Did you mean "unlocked"?
> > >
> > No, I did mean "locked", as in "must be called with thermal zone device
> > mutex acquired".
> >
> > locked:
> >
> > void __thermal_zone_device_update(struct thermal_zone_device *tz,
> >                                   enum thermal_notify_event event)
> > {
> >         ...
> > }
> >
> > unlocked:
> >
> > void thermal_zone_device_update(struct thermal_zone_device *tz,
> >                                 enum thermal_notify_event event)
> > {
> >         mutex_lock(&tz->lock);
> >         if (device_is_registered(&tz->device))
> >                 __thermal_zone_device_update(tz, event);
> >         mutex_unlock(&tz->lock);
> > }
> 
> Thanks for the explanation.
> 
> > Should I phrase or explain it differently ?
> 
> I would rather say "bare" or something like that so it is all clear to
> people like me, but it is your call.

I updated the commit description to use "must be called with thermal
device mutex held". I kept 'locked' in the subject; I don't think using
'bare' there would add any clarity. Hope that is ok.

Thanks,
Guenter
