Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D08673830
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 13:18:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjASMSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 07:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjASMSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 07:18:00 -0500
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C527CC646;
        Thu, 19 Jan 2023 04:17:42 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id rl14so1828589ejb.2;
        Thu, 19 Jan 2023 04:17:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HtpmlB8McVRoQ6HtPysr/zkpr2aEvec+90xBPvPorAE=;
        b=faujHa8O2xrDhMPr9vTVPwGsYj0y+2FQGUnxdsARnU1a39tw+/ho0GUX6hU64gMpc1
         EzPbY7SXMdDHmB0o9ksoGPwAstJDY9U7q5noiSI3WL1RQONGpq3FNiY8Y+9KSMP7tfbS
         w12PmOmx0AXOfTRCH1K2DXDw5r5npYk4No3iarIUIqRnp11qJJd8ZTA+zBdvjxODAwBP
         pxWCXX61QhAQyjgGdeERvtT6O50i99yHPkVGmDb/EHh+F9FL7+fwf4e9Tm02gd9TTOFI
         f6qXbO+7yECKq/yTtxddV63TYH8k7WRZyQRbjnq3Ju1hoDk8vXgzZyHhozXv3Jhw6xHh
         cQDQ==
X-Gm-Message-State: AFqh2kqa+fmsZPLSQnpDE9dBmNBmKUabXmICoOReVDRS0eQ+LvZB+thB
        D8r65+a0pyqJUT81u0YPGHCz2DTG2AdfMKbAMQw=
X-Google-Smtp-Source: AMrXdXsE9kLda+v2YxV3tijWgD7lqhc0wx3Wx5Tdo5nIEuiTjFHcl2R32wakKpBIF+ECdaPJ1lIftCeB615RIkrPq4Y=
X-Received: by 2002:a17:906:d971:b0:84d:381c:bdaa with SMTP id
 rp17-20020a170906d97100b0084d381cbdaamr1155247ejb.79.1674130660879; Thu, 19
 Jan 2023 04:17:40 -0800 (PST)
MIME-Version: 1.0
References: <20230113180235.1604526-1-daniel.lezcano@linaro.org>
 <f76c13de-d250-ebc0-d234-ccb3a9ce3c28@linaro.org> <2627c37e07dce6b125d3fea3bf38a5f2407ad6a1.camel@intel.com>
 <5aabdd3010a02e361fbbe01f4af0e30d11f0ae6b.camel@linux.intel.com>
 <c7abcce47df0aaa55f1e6c65f501bc691d35eae8.camel@linux.intel.com>
 <c210542f-0a71-15f2-c58f-ec607e60b06d@linaro.org> <8547963350fb3bdb09a4693f0eb80c7199ab6f21.camel@linux.intel.com>
 <87627e1f-322c-a195-8ce6-8922d9787ff0@linaro.org> <340f3ecdaddb2c422dcbe3df712a082f333eab0d.camel@linux.intel.com>
 <d6f71181-1de4-7937-eda0-8805d9dfc3b4@linaro.org> <b51ecbb8ac774efc4fb4ac1349585b486303f86f.camel@linux.intel.com>
In-Reply-To: <b51ecbb8ac774efc4fb4ac1349585b486303f86f.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 19 Jan 2023 13:17:29 +0100
Message-ID: <CAJZ5v0hYMPkGuJnOBkr+nRX4yny2wa6toPVbhbipRRKyS4Ei4g@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Thermal ACPI APIs for generic trip points
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 12:04 AM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Wed, 2023-01-18 at 23:14 +0100, Daniel Lezcano wrote:
> > On 18/01/2023 22:16, srinivas pandruvada wrote:
> > > On Wed, 2023-01-18 at 22:01 +0100, Daniel Lezcano wrote:
> > > > On 18/01/2023 21:53, srinivas pandruvada wrote:
> > > > > On Wed, 2023-01-18 at 21:00 +0100, Daniel Lezcano wrote:
> > > > > > On 18/01/2023 20:16, srinivas pandruvada wrote:
> > > > > >
> > > > > > [ ... ]
> > > > > >
> > > > > > > > > But we'd better wait for the thermald test result from
> > > > > > > > > Srinvias.
> > > > > > > >
> > > > > > > > A quick test show that things still work with thermald
> > > > > > > > and
> > > > > > > > these
> > > > > > > > changes.
> > > > > > >
> > > > > > > But I have a question. In some devices trip point
> > > > > > > temperature
> > > > > > > is
> > > > > > > not
> > > > > > > static. When hardware changes, we get notification. For
> > > > > > > example
> > > > > > > INT3403_PERF_TRIP_POINT_CHANGED for INT3403 drivers.
> > > > > > > Currently get_trip can get the latest changed value. But if
> > > > > > > we
> > > > > > > preregister, we need some mechanism to update them.
> > > > > >
> > > > > > When the notification INT3403_PERF_TRIP_POINT_CHANGED
> > > > > > happens, we
> > > > > > call
> > > > > > int340x_thermal_read_trips() which in turn updates the trip
> > > > > > points.
> > > > > >
> > > > >
> > > > > Not sure how we handle concurrency here when driver can freely
> > > > > update
> > > > > trips while thermal core is using trips.
> > > >
> > > > Don't we have the same race without this patch ? The thermal core
> > > > can
> > > > call get_trip_temp() while there is an update, no ?
> > > Yes it is. But I can add a mutex locally here to solve.
> > > But not any longer.
> > >
> > > I think you need some thermal_zone_read_lock/unlock() in core,
> > > which
> > > can use rcu. Even mutex is fine as there will be no contention as
> > > updates to trips will be rare.
> >
> > I was planning to provide a thermal_trips_update(tz, trips) and from
> > there handle the locking.
> >
> > As the race was already existing, can we postpone this change after
> > the
> > generic trip points changes?
> I think so.

Well, what if this bug is reported by a user and a fix needs to be
backported to "stable"?

Are we going to backport the whole framework redesign along with it?

Or is this extremely unlikely?
