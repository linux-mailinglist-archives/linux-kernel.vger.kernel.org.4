Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2C86B32C3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 01:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjCJAYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 19:24:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjCJAYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 19:24:44 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E23EE484E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 16:24:42 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id fa28so2624490pfb.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 16:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678407881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+V3aYlmwqb5X0ONYtzyuh6v2xQDgHWPmfFHQGk3o8g=;
        b=hR+qhxvvS3eP36MtryvpNULln5F1Yw4KWdRZ6I9J38LvCOg2aWXhv+uSpCy0/bg6jA
         RNlV8WtFbYxVJbPjnJuC4dsHEdxYp0G8DO/SPhpM9UePjnvActuq8JBYvqhTp7Vwc5u6
         F23dLvj9l4WuEk5x4ZNSnkcwzzgxJ0N//KeCNR5Mzni9ZvXU3OS8h7/a2GtKXw4/Mk9g
         QBD3BZctdd5RNbkubQZC0JBLFkPhFCJH6zP0lSVPZVjLPCMP4ezmnWv9lwxkTaVIFMYo
         bd8YlwSORTpsUk6Cf8ybmH8gT4Qy8S6G4Qnn1NJYF5vF/Ay2SkI5ZH1mGwe93QmzSy3f
         2tiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678407881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+V3aYlmwqb5X0ONYtzyuh6v2xQDgHWPmfFHQGk3o8g=;
        b=0Jw00h5SSkJLMEDSRMmOwBDwTGPna8N+SIPu4MEQvHwfrY7lCTWc7KUiMoKalrR7RX
         AvVRhlWIViLjQk5aobJGttXZI2a/KZTwdqMv6Fu8JK75SDOZm1j8iqB4okmIlVNZ1MAp
         8Ra3c2q6qc/+LeNNjzAnKrIUj5ouFbs7jmzHyTEtImwPcHbaai5ozbrTIlI1SXFzu+hB
         qaUQK/+upr+x8pKJlkSx5UeJWTtMHV0F/5xPkvoAh+qU8NYjp9+jxVQ9QOSkGfQEeu0L
         p86wGuHNIc8YnB4ohVxMauUuO3UsSztF+mJFBvaY6nL/c+aeLcVxmAQXpH7GMooH9fwa
         GTZg==
X-Gm-Message-State: AO0yUKWY8li45oGItFuUF3ufNqNlBo2YjEtDbqOQMOKMNL4h0XAQQiZ/
        QtqbpkC1ZSIDYewbao9YBT8q7NZyWgGLFrZ6mYEAgA==
X-Google-Smtp-Source: AK7set9ORvroYLFAXYpfLQXjWnnjDaxY+n0btSLbGMHX5m3kutUt6364A93lcXxwEwJIKyvmvltfUJuODMWNMCE7GaI=
X-Received: by 2002:a63:2950:0:b0:4fd:5105:eb93 with SMTP id
 bu16-20020a632950000000b004fd5105eb93mr7766307pgb.3.1678407881336; Thu, 09
 Mar 2023 16:24:41 -0800 (PST)
MIME-Version: 1.0
References: <20230301214952.2190757-1-saravanak@google.com>
 <2a8e407f4f18c9350f8629a2b5fa18673355b2ae.camel@puri.sm> <e65e08c13885468675af527ffa2ab882cc9e682d.camel@puri.sm>
In-Reply-To: <e65e08c13885468675af527ffa2ab882cc9e682d.camel@puri.sm>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 9 Mar 2023 16:24:05 -0800
Message-ID: <CAGETcx93K1VjAosX9NDEyLVLPK2utPSUV6dwzdAT-Dc5BfmhzQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Remove use of fw_devlink_purge_absent_suppliers()
To:     Martin Kepplinger <martin.kepplinger@puri.sm>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Yongqin Liu <yongqin.liu@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 2, 2023 at 1:41=E2=80=AFAM Martin Kepplinger
<martin.kepplinger@puri.sm> wrote:
>
> Am Donnerstag, dem 02.03.2023 um 10:12 +0100 schrieb Martin Kepplinger:
> > Am Mittwoch, dem 01.03.2023 um 13:49 -0800 schrieb Saravana Kannan:
> > > Yongqin, Martin, Amelie,
> > >
> > > We recent refactor of fw_devlink that ends with commit fb42378dcc7f
> > > ("mtd: mtdpart: Don't create platform device that'll never probe"),
> > > fw_devlink is smarter and doesn't depend on compatible property.
> > > So,
> > > I
> > > don't think these calls are needed anymore. But I don't have these
> > > devices to test on and be sure and the hardware I use to test
> > > changes
> > > doesn't have this issue either.
> > >
> > > Can you please test these changes on the hardware where you hit the
> > > issue to make sure things work as expected?
> > >
> > > Yongqin, If you didn't have the context, this affected hikey960.
> > >
> > > Greg,
> > >
> > > Let's wait for some tests before we land these.
> > >
> > > Thanks,
> > > Saravana
> >
> > hi Sravana,
> >
> > I picked the 12 commits leading up to commit fb42378dcc7f ("mtd:
> > mtdpart: Don't create platform device that'll never probe") (
> > https://source.puri.sm/martin.kepplinger/linux-next/-/commits/test_fw_d=
evlink
> > ) and included the tipd patch below to test it.
> >
> > With that, I get the following errors:
> >
> > [    0.237931] imx-uart 30890000.serial: Failed to create device link
> > with regulator-gnss
> > [    0.334054] nwl-dsi 30a00000.mipi-dsi: Failed to create device
> > link
> > with regulator-lcd-1v8
> > [    0.346964] nwl-dsi 30a00000.mipi-dsi: Failed to create device
> > link
> > with backlight-dsi
> >
> > but they are independent of this final tipd patch below. I'll test a
> > real linux-next tree soon, for completeness, maybe I missed
> > something?
> >
> > Anyways, on that tree, your tipd removal patch breaks type-c still
> > for
> > me, imx8mq-librem5.dtsi
> >
> > just to give a first reply quickly... thanks,
> >
> >                              martin
> >
>
> just confirming: it's the same as above on next-20230302 + this patch (
> https://source.puri.sm/martin.kepplinger/linux-next/-/commits/test_fw_dev=
link_next-20230302
> ) with the errors already independent from the patch. I should have
> tested earlier patches -.-

Thanks a lot for testing Martin!

Your email is a little ambiguous to me. With the 12 refactor commits +
the 4 patches in this series, things are breaking for you. But if you
drop the 4 patches in this series, things work again. Is that right?

Let's ignore the "Failed to create device link" errors for now -- it's
not related to this usb-c-connector series. It's basically pointing
out issues that we ignored silently in the past -- it's basically
pointing out holes in fw_devlink's visibility of devices. I'll get to
them later.

-Saravana
