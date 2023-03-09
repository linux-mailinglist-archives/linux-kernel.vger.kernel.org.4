Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5F66B2D32
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 19:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbjCISxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 13:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjCISxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 13:53:11 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FDC2B9D9
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 10:53:08 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-536bbe5f888so52091027b3.8
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 10:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678387987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fc1im8WIXCLJ3aPuivNhaqWtiUsYGYkccGBgkVEOYUY=;
        b=x6CDd5mP5J/JBVh4mnPCHLqh8hQWA28uorc+A/RWDI1ZVEFG7QIm6K4Zws1Mw6VljT
         stcYK5OfjQiiNtVP9o1XRdTP+/ZpQPbX9cqfNXTN7iOP0tPZUSxj/t134hduT4pPjv9z
         p8aSyMXlJ6lNMZm/5wH67RyBwMui0IZWN1ItqoakktmbR2Ly+ZtBBG4UdZOgogFaBr6C
         cVpjCO6GdrxuThuBeeTqlOwc4draaD1eLj9pryQVPT831GYqmQt1yCupnjtopoBBy57h
         bW4eMuWPQTYernzLmQxsC+rwkeHzznl+ljl2QmWejZo1R7EvrtEPTFWeVNWGDTg5iAK/
         xRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678387987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fc1im8WIXCLJ3aPuivNhaqWtiUsYGYkccGBgkVEOYUY=;
        b=oM6jlikg5P64jvDKSFRf7A8dq9EwTTUjLJlEJd76TexKdXhLJvtyECJxPhW3QR3MXJ
         RMPbWe9hzTflbBSyda0YR0PUj2NGGjqayHxOC75DyUgQqyX79PHslt3MoYDfDMRapfjU
         +P+V0Nzlri7IxkTSM9cjRvSz6kZ57AVT+DqKpmch1vZ6UHcy1AhapZovRMfEUZNqNAVr
         abMyEYelmY9saaeXRUVZ1EXTnZ5qxk5syT/DbSTPldYMQgDLIj36J4DgwndnrD9lvs6j
         ICXrxNECKbi6xQQIAm2rCMYfW9DLKw65DgA1g0lpCV57lGvjACebBMY9xnA/KRy6Srg9
         fktg==
X-Gm-Message-State: AO0yUKWPDoRM8BrCEmi3Kg6DG8sY5flMzUeb5I8Zz0bly0n7S3p2Snhw
        CHu1LuRqqLrL3hCRgCaptCa+ElddA/Bq6buxsyGaDw==
X-Google-Smtp-Source: AK7set8h6m/poIJaA1MSLpGytsT0tAbgxqFVpSfZhGBN7LyhbfaAFg6sbwjUUfvQLIAFIBRZ02I8DXPipcyzpkjgOXg=
X-Received: by 2002:a81:af59:0:b0:535:5e8c:65ef with SMTP id
 x25-20020a81af59000000b005355e8c65efmr14048163ywj.6.1678387987553; Thu, 09
 Mar 2023 10:53:07 -0800 (PST)
MIME-Version: 1.0
References: <20230301214952.2190757-1-saravanak@google.com> <CAGETcx_DTHW4-WMK4qRhvhxiunUB2f79cpXSfQ1x-hifZQ+tgw@mail.gmail.com>
In-Reply-To: <CAGETcx_DTHW4-WMK4qRhvhxiunUB2f79cpXSfQ1x-hifZQ+tgw@mail.gmail.com>
From:   Yongqin Liu <yongqin.liu@linaro.org>
Date:   Fri, 10 Mar 2023 02:52:56 +0800
Message-ID: <CAMSo37XuNaV4Y3+ExrUjNzPDRD_BNSn1258Ve3We+qtbsO7qEw@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Remove use of fw_devlink_purge_absent_suppliers()
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Saravana

Sorry for the lateness, I was just aware of this today.

I tested with the ACK android-mainline branch + the 12 commits ending
with fb42378dcc7f
+ the 4 commits of this series + hikey960 AOSP Master userspace.
The hikey960 Android build could boot to the home screen, no stuck there,

Here is the link of the logat in case you want to check some message here:
https://gist.github.com/liuyq/6525af08c547cd2e494af5d1c8b181b5

Thanks,
Yongqin Liu
On Fri, 10 Mar 2023 at 02:05, Saravana Kannan <saravanak@google.com> wrote:
>
> Greg,
>
> Don't pull in this series please. It needs more testing from the folks
> I cc'ed and it's already breaking things for Martin. This needs more
> revisions.
>
> -Saravana
>
> On Wed, Mar 1, 2023 at 1:49=E2=80=AFPM Saravana Kannan <saravanak@google.=
com> wrote:
> >
> > Yongqin, Martin, Amelie,
> >
> > We recent refactor of fw_devlink that ends with commit fb42378dcc7f
> > ("mtd: mtdpart: Don't create platform device that'll never probe"),
> > fw_devlink is smarter and doesn't depend on compatible property. So, I
> > don't think these calls are needed anymore. But I don't have these
> > devices to test on and be sure and the hardware I use to test changes
> > doesn't have this issue either.
> >
> > Can you please test these changes on the hardware where you hit the
> > issue to make sure things work as expected?
> >
> > Yongqin, If you didn't have the context, this affected hikey960.
> >
> > Greg,
> >
> > Let's wait for some tests before we land these.
> >
> > Thanks,
> > Saravana
> >
> > Cc: Yongqin Liu <yongqin.liu@linaro.org>
> > Cc: Sumit Semwal <sumit.semwal@linaro.org>
> > Cc: Martin Kepplinger <martin.kepplinger@puri.sm>
> > Cc: Amelie Delaunay <amelie.delaunay@foss.st.com>
> >
> > Saravana Kannan (4):
> >   usb: typec: stusb160x: Remove use of
> >     fw_devlink_purge_absent_suppliers()
> >   usb: typec: tipd: Remove use of fw_devlink_purge_absent_suppliers()
> >   usb: typec: tcpm: Remove use of fw_devlink_purge_absent_suppliers()
> >   driver core: Delete fw_devlink_purge_absent_suppliers()
> >
> >  drivers/base/core.c           | 16 ----------------
> >  drivers/usb/typec/stusb160x.c |  9 ---------
> >  drivers/usb/typec/tcpm/tcpm.c |  9 ---------
> >  drivers/usb/typec/tipd/core.c |  9 ---------
> >  include/linux/fwnode.h        |  1 -
> >  5 files changed, 44 deletions(-)
> >
> > --
> > 2.39.2.722.g9855ee24e9-goog
> >



--=20
Best Regards,
Yongqin Liu
---------------------------------------------------------------
#mailing list
linaro-android@lists.linaro.org
http://lists.linaro.org/mailman/listinfo/linaro-android
