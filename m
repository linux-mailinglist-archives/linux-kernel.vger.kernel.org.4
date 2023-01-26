Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C858E67CD33
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 15:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjAZOAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 09:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjAZN7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:59:44 -0500
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B21822DCF;
        Thu, 26 Jan 2023 05:59:21 -0800 (PST)
Received: by mail-ej1-f54.google.com with SMTP id ss4so5191812ejb.11;
        Thu, 26 Jan 2023 05:59:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=43F6h9YunM+69Z36jRkqCn+nLpqlYVOHKUoqzV2k/mo=;
        b=2nCbX8lD16bxO5PHW25XvIE1BBpSUg0VuU53xdFLWWVoo+vJnqhNjegS6ffc6f/O7T
         2Ji2XMsuqskKR2uwBR2We2F/dC4/pCJLdgr0yrYV3OymRlslOXtmIFfnQ25NY8hHUD3/
         wC6vpC0keOq29mEs70+CiMwVGsu75uw+r9kLCre1yrAU3aPh396xDZV082tz4u74aUeg
         mUx+dYenQs6XNu4QZnXxr7DmtQYIWD2L9Da4/fcDh/gaPaDD1XCGNzEwfgg6pmlmwf/t
         RfoUE1vQwf1diwWRXyo07ftUHXnW9FKhvm8PuP7qRjOMJfiw70Lk2Ln0g7okUj1I+45n
         Fdjw==
X-Gm-Message-State: AFqh2kpEN6cp260zFj21dbQXgF4Xf/w4zR2GRlkhsf572GwYU+QqA97c
        iB/D60pQODRkKJTUed+oeV1tFhGaqSXWz6vHKhRVedCc
X-Google-Smtp-Source: AMrXdXs3IwC1anuKCeyYYqZfq6z9Rl0mHJUq4BdORfmnCA++koi3DqsJV3RYLkO4CWSrVye6YFZivh1BFsazPB+wg48=
X-Received: by 2002:a17:907:d10f:b0:872:be4b:1b65 with SMTP id
 uy15-20020a170907d10f00b00872be4b1b65mr5179111ejc.125.1674741557984; Thu, 26
 Jan 2023 05:59:17 -0800 (PST)
MIME-Version: 1.0
References: <20230123163046.358879-1-srinivas.pandruvada@linux.intel.com>
 <CAJZ5v0iK-ob4Mhh-Upq01gq6SPsYuAD22E-o0zwcoL1hLiP3JQ@mail.gmail.com>
 <1b9aa29a3c217eed97e2a732ba94bfc03f95f320.camel@linux.intel.com> <CAJZ5v0hGPYfJ_H-+PWTaSPc3DjNDt4O5AWsGJUxjtU3jgDtktw@mail.gmail.com>
In-Reply-To: <CAJZ5v0hGPYfJ_H-+PWTaSPc3DjNDt4O5AWsGJUxjtU3jgDtktw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 26 Jan 2023 14:59:06 +0100
Message-ID: <CAJZ5v0gaY3itbQLEVGXjBfZBQbHAZ7Yp2e0yES=GYzaoVd_9zw@mail.gmail.com>
Subject: Re: [PATCH v3] thermal: int340x_thermal: Add production mode attribute
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     rui.zhang@intel.com, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 5:20 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Jan 24, 2023 at 5:10 PM srinivas pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
> >
> > On Tue, 2023-01-24 at 15:22 +0100, Rafael J. Wysocki wrote:
> > > On Mon, Jan 23, 2023 at 5:31 PM Srinivas Pandruvada
> > > <srinivas.pandruvada@linux.intel.com> wrote:
> > > >
> > > > It is possible that the system manufacturer locks down thermal
> > > > tuning
> > > > beyond what is usually done on the given platform. In that case
> > > > user
> > > > space calibration tools should not try to adjust the thermal
> > > > configuration of the system.
> > > >
> > > > To allow user space to check if that is the case, add a new sysfs
> > > > attribute "production_mode" that will be present when the ACPI DCFG
> > > > method is present under the INT3400 device object in the ACPI
> > > > Namespace.
> > > >
> > > > Signed-off-by: Srinivas Pandruvada
> > > > <srinivas.pandruvada@linux.intel.com>
> > > > ---
> > > > v3:
> > > > Build warning reported by for missing static
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > >
> > > > v2
> > > > Addressed comments from Rafael:
> > > > - Updated commit excatly same as Rafael wrote
> > > > - Removed production_mode_support bool
> > > > - Use sysfs_emit
> > > > - Update documentation
> > > >
> > > >  .../driver-api/thermal/intel_dptf.rst         |  3 ++
> > > >  .../intel/int340x_thermal/int3400_thermal.c   | 48
> > > > +++++++++++++++++++
> > > >  2 files changed, 51 insertions(+)
> > > >
> > > > diff --git a/Documentation/driver-api/thermal/intel_dptf.rst
> > > > b/Documentation/driver-api/thermal/intel_dptf.rst
> > > > index 372bdb4d04c6..f5c193cccbda 100644
> > > > --- a/Documentation/driver-api/thermal/intel_dptf.rst
> > > > +++ b/Documentation/driver-api/thermal/intel_dptf.rst
> > > > @@ -84,6 +84,9 @@ DPTF ACPI Drivers interface
> > > >         https:/github.com/intel/thermal_daemon for decoding
> > > >         thermal table.
> > > >
> > > > +``production_mode`` (RO)
> > > > +       When different from zero, manufacturer locked thermal
> > > > configuration
> > > > +       from further changes.
> > > >
> > > >  ACPI Thermal Relationship table interface
> > > >  ------------------------------------------
> > > > diff --git
> > > > a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > > > b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > > > index db8a6f63657d..23ea21238bbd 100644
> > > > --- a/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > > > +++ b/drivers/thermal/intel/int340x_thermal/int3400_thermal.c
> > > > @@ -60,6 +60,7 @@ struct int3400_thermal_priv {
> > > >         int odvp_count;
> > > >         int *odvp;
> > > >         u32 os_uuid_mask;
> > > > +       int production_mode;
> > > >         struct odvp_attr *odvp_attrs;
> > > >  };
> > > >
> > > > @@ -315,6 +316,44 @@ static int int3400_thermal_get_uuids(struct
> > > > int3400_thermal_priv *priv)
> > > >         return result;
> > > >  }
> > > >
> > > > +static ssize_t production_mode_show(struct device *dev, struct
> > > > device_attribute *attr,
> > > > +                                    char *buf)
> > > > +{
> > > > +       struct int3400_thermal_priv *priv = dev_get_drvdata(dev);
> > > > +
> > > > +       return sysfs_emit(buf, "%d\n", priv->production_mode);
> > > > +}
> > > > +
> > > > +static DEVICE_ATTR_RO(production_mode);
> > > > +
> > > > +static int production_mode_init(struct int3400_thermal_priv *priv)
> > > > +{
> > > > +       unsigned long long mode;
> > > > +       acpi_status status;
> > > > +       int ret;
> > > > +
> > > > +       priv->production_mode = -1;
> > > > +
> > > > +       status = acpi_evaluate_integer(priv->adev->handle, "DCFG",
> > > > NULL, &mode);
> > > > +       /* If the method is not present, this is not an error */
> > > > +       if (ACPI_FAILURE(status))
> > > > +               return 0;
> > > > +
> > > > +       ret = sysfs_create_file(&priv->pdev->dev.kobj,
> > > > &dev_attr_production_mode.attr);
> > > > +       if (ret)
> > > > +               return ret;
> > > > +
> > > > +       priv->production_mode = mode;
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +static void production_mode_exit(struct int3400_thermal_priv
> > > > *priv)
> > > > +{
> > > > +       if (priv->production_mode >= 0)
> > > > +               sysfs_remove_file(&priv->pdev->dev.kobj,
> > > > &dev_attr_production_mode.attr);
> > >
> > > Isn't it OK to call sysfs_remove_file() if the given attribute is not
> > > there?
> > >
> > I think it will be OK. But remove call will traverse 6 levels of
> > function taking semaphores and finally call into kernfs_find_ns(),
> > where it will search a hash table and fail. So much more processing
> > than checking one if() condition.
>
> Fair enough.

So applied as 6.3 material, thanks!
