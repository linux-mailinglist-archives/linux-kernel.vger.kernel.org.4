Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F481629A85
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238345AbiKONcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238409AbiKONcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:32:00 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AAB329342;
        Tue, 15 Nov 2022 05:31:39 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id 130so14097234pfu.8;
        Tue, 15 Nov 2022 05:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SDCfTqp5RHmpPPiYAMZqgPg+FlYe7rD3rpk+dlOlmrs=;
        b=KrwYvRnprSGRln3TvOkC1YiP6Df+3DLqQfIYTk2EiIbrltz1T4KtUySjLgIBWDzDcb
         cVg5xSn7ARmm4NQ3818YdLO3qynehO02Svna5kXSG8afMINz3ycoBmCeiJqH8UlkEC+o
         1vyNhVAtowXtOKXPwT4e8ZUetr1cWzWKL+TfSqssgLWsAPZRAUmziml9jJXaEBLfJwcc
         Q5KXTWE13kC4/6tvcIxv8ToSD4WDfbFAtEbjqyn7343Q/9VmUZxCdG0CD5BcCWarKb+V
         SY0H/OW7Fiy0y/0nKLdoLVC0/99/3negtgyRr4/cirsfLrPnMGYZmnI1Z0NXMFu9H5Wy
         oKag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SDCfTqp5RHmpPPiYAMZqgPg+FlYe7rD3rpk+dlOlmrs=;
        b=U05mLKhK1jbGS0CET/i5tE8U/JvnQ6dTnqabCXvq8WhLbmnRDO9No3s3PFNiCo6ODV
         pfE0sEvOYkao02nWGNzRCWxJKc6T28vcXpuV5C7EyFMb0MM2gTITg969585WGO7GyzJE
         w1ZW9IWDSPvjVTtBvz7iHI2eYx/cyXbJc602j1qa2a8ShZm4yRNZJZdx6rGiBXBjd4+l
         r6hlfSGU+O8qCsfm9SpPOY11AeyZ0+knEVxsMUHx/Bw0RGDV5bZeroGyD13H6hM5OtsK
         ekptxUWRERmb68O4kfbrMhNfSUCP7Ra66k82rkJGW78GCY1Oesx3kZda63/soIZN4PYI
         xPCA==
X-Gm-Message-State: ANoB5pkSVyt0Q9DRNTZForL+3g26TA7hUtOhzGqoEftanahkIlsQnwuH
        YZWcxc0wvGNMYezgEwPPzdM=
X-Google-Smtp-Source: AA0mqf6ovMAjD8mvMI4/+0p+hFXFvgTHeISLflHSnHfj/zqnwHHXWaPzQysZQnFtnWXnoEXHS5IMYQ==
X-Received: by 2002:a05:6a00:26c4:b0:563:b88c:8d34 with SMTP id p4-20020a056a0026c400b00563b88c8d34mr18459182pfw.68.1668519098569;
        Tue, 15 Nov 2022 05:31:38 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i65-20020a628744000000b0056b6c7a17c6sm9085486pfe.12.2022.11.15.05.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 05:31:37 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 15 Nov 2022 05:31:36 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/9] thermal/core: Protect thermal device operations
 against removal
Message-ID: <20221115133136.GC4189373@roeck-us.net>
References: <20221110152500.3032655-1-linux@roeck-us.net>
 <CAJZ5v0j50TWszcRWkb_m4BDQ_gEpCuJDR2EuOJWN8zvBf_KkUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0j50TWszcRWkb_m4BDQ_gEpCuJDR2EuOJWN8zvBf_KkUw@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 07:06:57PM +0100, Rafael J. Wysocki wrote:
> On Thu, Nov 10, 2022 at 4:25 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Accesses to thermal zones, and with it to thermal zone device operations,
> > are still possible after the thermal zone device has been unregistered.
> > For example, thermal_zone_get_temp() can be called from temp_show()
> > in thermal_sysfs.c if the sysfs attribute was opened before the thermal
> > device was unregistered. This is problematic and may result in crashes
> > since the operations data structure and the underlying code may be gone
> > when the calls are made.
> >
> > The following series solves the problem by protecting accesses to thermal
> > device operations with the thermal device mutex, and by verifying that the
> > thermal device is still registered after the mutex has been acquired.
> >
> > This was previously sent as RFC/RFT as single patch [1]. The code was reworked
> > to match thermal subsystem changes made between v6.0 and v6.1, and it was
> > split into several patches to simplify review.
> >
> > [1] https://lore.kernel.org/linux-pm/20221004033936.1047691-1-linux@roeck-us.net/
> >
> > v2: Improved documentation, rearranged code.
> >     No functional changes. See individual patches for details.
> >
> > ----------------------------------------------------------------
> > Guenter Roeck (9):
> >       thermal/core: Destroy thermal zone device mutex in release function
> >       thermal/core: Delete device under thermal device zone lock
> >       thermal/core: Ensure that thermal device is registered in thermal_zone_get_temp
> >       thermal/core: Move parameter validation from __thermal_zone_get_temp to thermal_zone_get_temp
> >       thermal/core: Introduce locked version of thermal_zone_device_update
> >       thermal/core: Protect hwmon accesses to thermal operations with thermal zone mutex
> >       thermal/core: Protect sysfs accesses to thermal operations with thermal zone mutex
> >       thermal/core: Remove thermal_zone_set_trips()
> >       thermal/core: Protect thermal device operations against thermal device removal
> >
> >  drivers/thermal/thermal_core.c    | 76 +++++++++++++++++++++++--------------
> >  drivers/thermal/thermal_core.h    |  3 +-
> >  drivers/thermal/thermal_helpers.c | 67 +++++++++++++++++++++------------
> >  drivers/thermal/thermal_hwmon.c   | 10 ++++-
> >  drivers/thermal/thermal_sysfs.c   | 79 ++++++++++++++++++++++++++++++++-------
> >  5 files changed, 168 insertions(+), 67 deletions(-)
> 
> All applied as 6.2 material, thanks!

Thanks a lot!

Guenter
