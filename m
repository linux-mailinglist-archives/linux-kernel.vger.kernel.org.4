Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3753E6F1F5B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 22:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346220AbjD1UbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 16:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjD1UbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 16:31:01 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E7D5589
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 13:30:29 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-247296def99so289379a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 13:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682713828; x=1685305828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5BBSaM4viJse91izjI7kqxRyJnpTb5xhj5RhMLOsisI=;
        b=Iyf1MyFQjkZvjPsBoNrzcGAw7Bq5xbB4PiSYUTEMKCIRkHQEPR2fXwmCq1F8ryDMJ1
         xQdL4ueYMrjlqepGS0eB1psFE7yNC1sgSAosDtcelE7Z7oNW9PGzoMLotqB0LYRRa2Ob
         lcu4oYCnv6y7MB/tx40sjK6/Wtp2ilTk4RcY0szl73r1SBJdhpwzPCANh/y4P7kBIlyY
         0HE4kMYmug/memLIlI/1NxtjJvL63jFhzlZOABPjhbmbPCU4wzeRQjSDHr5olnhRB842
         9HJcS6JiF7rIe0bhoK9+3naB7dXPxRQkcCkafNS4It2flZlYr0+9zpjF7X5XnEgtiO79
         Mn/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682713828; x=1685305828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5BBSaM4viJse91izjI7kqxRyJnpTb5xhj5RhMLOsisI=;
        b=GVVVUt3lChtFNEJ4q1lY4Q0hOxXdCnxAyukZlnP1bPrX5CUY80a/55a9Tnz6h6O6LH
         VOeoh1lBRGjRIOmNrfUBToEkpB6EYnzlRLhRRUEE2Bj90PMYqY3A6WyI+yvo7z7RQRnH
         2/ZdwFUepfzyfydkabfMl5M2/RWSgDXDDnAdXUuenYc4OCkAvMpsrfhggxH078WU/nhD
         lctKwGOfj9rIJklS2eJQyBKjqn52QJtj5GVq95hh/PkEDQdRAm2YuvL/gnnaE5PDVHVZ
         VE+gVy6z1+D6mn84uRnNjxQRtcMHd9vf8K7ssnTMGqDF7THgLQxu3LiYmCDqCdQvwHMi
         NqSw==
X-Gm-Message-State: AC+VfDwvZzGFlgE2ILjvx3Anw8HSGn6CYgkuijvN75d1BcDkSsQ3jbN7
        pp43useRVhH06Y9e8jvN+1bsWRY1hK34uvku+0m+Yw==
X-Google-Smtp-Source: ACHHUZ7QGJcZJActleLC+67XkcEQINvuEAKkRYu+dP1dV1iQpDn3+MrobU9vljU6I+TUwbLnn2AdH9EU0yxRTo99Nu8=
X-Received: by 2002:a17:90b:3e8e:b0:247:2152:6391 with SMTP id
 rj14-20020a17090b3e8e00b0024721526391mr6188228pjb.17.1682713827919; Fri, 28
 Apr 2023 13:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230427165813.2844530-1-wonchung@google.com>
In-Reply-To: <20230427165813.2844530-1-wonchung@google.com>
From:   Manasi Navare <navaremanasi@google.com>
Date:   Fri, 28 Apr 2023 13:30:17 -0700
Message-ID: <CAMNLLoToZrKHq3mdSsGErLJndQhZD8A+oyOzmvHUUV8XHqz8qw@mail.gmail.com>
Subject: Re: [PATCH v6] drm/sysfs: Link DRM connectors to corresponding Type-C connectors
To:     Won Chung <wonchung@google.com>
Cc:     bleung@google.com, pmalani@chromium.org,
        heikki.krogerus@linux.intel.com, imre.deak@intel.com,
        gildekel@chromium.org, seanpaul@chromium.org, daniel@ffwll.ch,
        navaremanasi@chromium.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Won,

Thanks for the patch, patch now merged to drm-misc-next

Regards
Manasi


On Thu, Apr 27, 2023 at 9:58=E2=80=AFAM Won Chung <wonchung@google.com> wro=
te:
>
> Create a symlink pointing to USB Type-C connector for DRM connectors
> when they are created. The link will be created only if the firmware is
> able to describe the connection beween the two connectors.
>
> Currently, even if a display uses a USB Type-C port, there is no way for
> the userspace to find which port is used for which display. With the
> symlink, display information would be accessible from Type-C connectors
> and port information would be accessible from DRM connectors.
>
> Associating the two subsystems, userspace would have potential to expose
> and utilize more complex information. ChromeOS intend to use this
> information for metrics collection. For example, we want to tell which
> port is deriving which displays. Also, combined with USB PD information,
> we can tell whether user is charging their device through display.
> Chromium patch for parsing the symlink from the kernel is at
> http://crrev.com/c/4317207.
>
> We already have a framework in typec port-mapper.c where it goes through
> component devices and runs the bind functions for those with matching
> _PLD (physical location of device).
> https://elixir.bootlin.com/linux/v5.18.1/source/drivers/usb/typec/port-ma=
pper.c
> Since _PLD is ACPI specific field, this linking would only work on ACPI
> x86 as long as _PLD field for Type-C connectors and DRM connectors are
> correctly added to the firmware.
>
> Currently, USB ports and USB4 ports are added as components to create a
> symlink with Type C connector.
> USB:
> https://lore.kernel.org/all/20211223082349.45616-1-heikki.krogerus@linux.=
intel.com/
> USB4:
> https://lore.kernel.org/all/20220418175932.1809770-3-wonchung@google.com/
> So, we follow the same pattern in this patch.
>
> Signed-off-by: Won Chung <wonchung@google.com>
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Reviewed-by: Manasi Navare <navaremanasi@chromium.org>
> ---
> Changes from v5:
> - Add more details to the error message
>
> Changes from v4: (4 months ago)
> - Update commit message with an actual use case from cros userspace
> - Move component_add to before ddc check which possibly returns
> - Rebased
>
> Changes from v3:
> - Append to the commit message on why this patch is needed
>
> Changes from v2:
> - Resend the patch to dri-devel list
>
> Changes from v1:
> - Fix multiple lines to single line
>
>
>  drivers/gpu/drm/drm_sysfs.c | 40 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
> index 183130355997..bc869c6fa420 100644
> --- a/drivers/gpu/drm/drm_sysfs.c
> +++ b/drivers/gpu/drm/drm_sysfs.c
> @@ -11,12 +11,14 @@
>   */
>
>  #include <linux/acpi.h>
> +#include <linux/component.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/export.h>
>  #include <linux/gfp.h>
>  #include <linux/i2c.h>
>  #include <linux/kdev_t.h>
> +#include <linux/property.h>
>  #include <linux/slab.h>
>
>  #include <drm/drm_accel.h>
> @@ -96,6 +98,34 @@ static char *drm_devnode(const struct device *dev, umo=
de_t *mode)
>         return kasprintf(GFP_KERNEL, "dri/%s", dev_name(dev));
>  }
>
> +static int typec_connector_bind(struct device *dev,
> +       struct device *typec_connector, void *data)
> +{
> +       int ret;
> +
> +       ret =3D sysfs_create_link(&dev->kobj, &typec_connector->kobj, "ty=
pec_connector");
> +       if (ret)
> +               return ret;
> +
> +       ret =3D sysfs_create_link(&typec_connector->kobj, &dev->kobj, "dr=
m_connector");
> +       if (ret)
> +               sysfs_remove_link(&dev->kobj, "typec_connector");
> +
> +       return ret;
> +}
> +
> +static void typec_connector_unbind(struct device *dev,
> +       struct device *typec_connector, void *data)
> +{
> +       sysfs_remove_link(&typec_connector->kobj, "drm_connector");
> +       sysfs_remove_link(&dev->kobj, "typec_connector");
> +}
> +
> +static const struct component_ops typec_connector_ops =3D {
> +       .bind =3D typec_connector_bind,
> +       .unbind =3D typec_connector_unbind,
> +};
> +
>  static CLASS_ATTR_STRING(version, S_IRUGO, "drm 1.1.0 20060810");
>
>  /**
> @@ -353,9 +383,16 @@ int drm_sysfs_connector_add(struct drm_connector *co=
nnector)
>
>         connector->kdev =3D kdev;
>
> +       if (dev_fwnode(kdev)) {
> +               r =3D component_add(kdev, &typec_connector_ops);
> +               if (r)
> +                       drm_err(dev, "failed to add component to create l=
ink to typec connector\n");
> +       }
> +
>         if (connector->ddc)
>                 return sysfs_create_link(&connector->kdev->kobj,
>                                  &connector->ddc->dev.kobj, "ddc");
> +
>         return 0;
>
>  err_free:
> @@ -371,6 +408,9 @@ void drm_sysfs_connector_remove(struct drm_connector =
*connector)
>         if (connector->ddc)
>                 sysfs_remove_link(&connector->kdev->kobj, "ddc");
>
> +       if (dev_fwnode(connector->kdev))
> +               component_del(connector->kdev, &typec_connector_ops);
> +
>         DRM_DEBUG("removing \"%s\" from sysfs\n",
>                   connector->name);
>
> --
> 2.40.1.495.gc816e09b53d-goog
>
