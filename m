Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930A55F3411
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 19:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiJCRCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 13:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiJCRCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 13:02:50 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7018277
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 10:02:49 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id bu5-20020a17090aee4500b00202e9ca2182so11744130pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 10:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=9vOhtQ1zdbdAF04wXNpGz65uN7mAyi80gk0Gz1MHVUQ=;
        b=NOzTHX1+WflQiXf4YT/13FuqQBXRX3V8TZIWfVfDBTPA8+BcPNzdbFnWg6NBEcw1jX
         4Wq3QDAsZ8wpXHvUp4K6I2vWsamYzCMnauarc5KcJ7VdrjIShmDFz5VhFW460sALRpje
         TzxLLeMnzDxjgLsJyMARi7OZOl3DcFoQXP0D3j2zx/iTnaQpZdY+hU6RVhGy8//NsUrc
         Y9iYmwAyGcFScur+bx3nTbIjwNNrlb3+GeDgNCubG3pXZkfyuHkZPDDT7SZ7UlR+SG5V
         cc0kYtu6uLAoVYVkCH/P+kYGxAJ3IaxSGAIwxY9ZpNVdYrZFSz4pYk5LMSfoxFkwpgLg
         +RoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=9vOhtQ1zdbdAF04wXNpGz65uN7mAyi80gk0Gz1MHVUQ=;
        b=XbMtARLkGx55v/lnuYzEWfLde2YtZdzSfRUTePrcnaS26294/usnPLhjU6j9vBHp8P
         Ygba4aIuF1/QhOAj/XCMuEe2vpw6E997zl71RfWT+jbGhrJYGA0ChAnUJwK4ziCviBaq
         vk1XTSLtkqDYELrklKYU5LSZa7SQ2OYP0FE8/eQNnlFpAgJv3IYM2Q9qDG6nuDneZTiN
         x1H9dXk8pZzlQO5d9cxEbA79pbD1iIIvqi2iUQI4vcnhpblZGXVfMgL/6hawij0zATlh
         ccDnHyRZ5ox5xL630hUyZmERnv5E4HwOlAPztTsP+kmkTZWb/O2mtxymjSRfdye36JYP
         kL2A==
X-Gm-Message-State: ACrzQf1MFsnGO0xVHNfP0E++5AnggmiumS4PPrspmubKYG5fCBb/bnSX
        qX+fyLyH4oh0FfysTdqZMnhj4KyJuOP8uTsYW+c+OA==
X-Google-Smtp-Source: AMsMyM5mkY/btCr0hnTSYGoGJFxTNKtLTcARhYGWy26FU9PyltsSB+N1/RyVMVsPo1TzdJ//lMBdmNHaBwoZIVlMTwM=
X-Received: by 2002:a17:90b:3c90:b0:20a:b964:b879 with SMTP id
 pv16-20020a17090b3c9000b0020ab964b879mr3209351pjb.52.1664816569293; Mon, 03
 Oct 2022 10:02:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220926214157.843812-1-wonchung@google.com> <YzK9Wq1qniDcwtkN@kuha.fi.intel.com>
In-Reply-To: <YzK9Wq1qniDcwtkN@kuha.fi.intel.com>
From:   Won Chung <wonchung@google.com>
Date:   Mon, 3 Oct 2022 10:02:38 -0700
Message-ID: <CAOvb9yibj=c_R7iAZBoJm8wNEgUT-hHzg21mY0XL4KkOTqrjaQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/sysfs: Link DRM connectors to corresponding Type-C connectors
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     bleung@google.com, pmalani@chromium.org, imre.deak@intel.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 2:07 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Mon, Sep 26, 2022 at 09:41:57PM +0000, Won Chung wrote:
> > Create a symlink pointing to USB Type-C connector for DRM connectors
> > when they are created. The link will be created only if the firmware is
> > able to describe the connection beween the two connectors.
> >
> > Signed-off-by: Won Chung <wonchung@google.com>
>
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>
> > ---
> > Changes from v1:
> > - Fix multiple lines to single line
> >
> >
> >  drivers/gpu/drm/drm_sysfs.c | 40 +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
> > index 430e00b16eec..6a9904fa9186 100644
> > --- a/drivers/gpu/drm/drm_sysfs.c
> > +++ b/drivers/gpu/drm/drm_sysfs.c
> > @@ -11,12 +11,14 @@
> >   */
> >
> >  #include <linux/acpi.h>
> > +#include <linux/component.h>
> >  #include <linux/device.h>
> >  #include <linux/err.h>
> >  #include <linux/export.h>
> >  #include <linux/gfp.h>
> >  #include <linux/i2c.h>
> >  #include <linux/kdev_t.h>
> > +#include <linux/property.h>
> >  #include <linux/slab.h>
> >
> >  #include <drm/drm_connector.h>
> > @@ -95,6 +97,34 @@ static char *drm_devnode(struct device *dev, umode_t *mode)
> >       return kasprintf(GFP_KERNEL, "dri/%s", dev_name(dev));
> >  }
> >
> > +static int typec_connector_bind(struct device *dev,
> > +     struct device *typec_connector, void *data)
> > +{
> > +     int ret;
> > +
> > +     ret = sysfs_create_link(&dev->kobj, &typec_connector->kobj, "typec_connector");
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = sysfs_create_link(&typec_connector->kobj, &dev->kobj, "drm_connector");
> > +     if (ret)
> > +             sysfs_remove_link(&dev->kobj, "typec_connector");
> > +
> > +     return ret;
> > +}
> > +
> > +static void typec_connector_unbind(struct device *dev,
> > +     struct device *typec_connector, void *data)
> > +{
> > +     sysfs_remove_link(&typec_connector->kobj, "drm_connector");
> > +     sysfs_remove_link(&dev->kobj, "typec_connector");
> > +}
> > +
> > +static const struct component_ops typec_connector_ops = {
> > +     .bind = typec_connector_bind,
> > +     .unbind = typec_connector_unbind,
> > +};
> > +
> >  static CLASS_ATTR_STRING(version, S_IRUGO, "drm 1.1.0 20060810");
> >
> >  /**
> > @@ -355,6 +385,13 @@ int drm_sysfs_connector_add(struct drm_connector *connector)
> >       if (connector->ddc)
> >               return sysfs_create_link(&connector->kdev->kobj,
> >                                &connector->ddc->dev.kobj, "ddc");
> > +
> > +     if (dev_fwnode(kdev)) {
> > +             r = component_add(kdev, &typec_connector_ops);
> > +             if (r)
> > +                     drm_err(dev, "failed to add component\n");
> > +     }
> > +
> >       return 0;
> >
> >  err_free:
> > @@ -367,6 +404,9 @@ void drm_sysfs_connector_remove(struct drm_connector *connector)
> >       if (!connector->kdev)
> >               return;
> >
> > +     if (dev_fwnode(connector->kdev))
> > +             component_del(connector->kdev, &typec_connector_ops);
> > +
> >       if (connector->ddc)
> >               sysfs_remove_link(&connector->kdev->kobj, "ddc");
> >
>
> thanks,
>
> --
> heikki

Hi upstream DRM maintainers,

Can one of you take a look at this patch for a review when you have
time? Thank you!

Won
