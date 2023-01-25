Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8C267B62A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 16:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235694AbjAYPox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 10:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbjAYPov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 10:44:51 -0500
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014D63D92E;
        Wed, 25 Jan 2023 07:44:51 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id hw16so48680064ejc.10;
        Wed, 25 Jan 2023 07:44:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dQKz1ivfeZseau89f0LUWH5dfS4HbVoU1vZsEoHnerc=;
        b=7AuxjUMONQ9fw+WuDum+arJeiAmMatMaa2vpx+0m/4HPF9nAgMahX/V1yL5XfXMm45
         KK6GJbo8JLdQ1+hmOmNBvIzwpfB8arbDbKT8apqJpE9/YbFNA3Qs38MRmFEHA2OpePaJ
         BBdztG/7QVwstXkPSZxiQw2c+J7ANfstwa8SiCJYpwJam1ChxUqVwE4Xm+pEvvNB8VHp
         TNE5ezIPdOg260jFMLF74BYhRQrLNnZn0vT/eYY72iEy+S3y41YCOgjKL4gEgWaw5vdU
         qKcPSlP/QEamx+p3LlIZASIBCXgUOh08bfJ0QLKl2/7sq+S+z4JB+hmLZ+aWxmdE9Xye
         PP8g==
X-Gm-Message-State: AFqh2kqxzeOOuDQcFNzhcl5CC3IsKfLctkZZB76q6Z4gHyRAopwx4swl
        e9T3ckoew2Qzc2vmLZEiLlmfC+9ls630jZ6sgl2uZzOD
X-Google-Smtp-Source: AMrXdXvzX7gr0fDhtGa4jw4p2Q6w6svVgIxpCUCQw2/uvb5zgGMPUvySpvTP/WAbAseD31o4y6y6K1MM6eexUvC5r5I=
X-Received: by 2002:a17:906:d101:b0:84d:3813:fb8 with SMTP id
 b1-20020a170906d10100b0084d38130fb8mr4575168ejz.384.1674661489604; Wed, 25
 Jan 2023 07:44:49 -0800 (PST)
MIME-Version: 1.0
References: <20230123152756.4031574-1-daniel.lezcano@linaro.org>
 <3e2c6c44-f562-28ff-26cc-933f386e9719@linaro.org> <CAJZ5v0iH283yXWdzTN1Gb2xBUjy0E04zEgrny1N6QcsAwsJyyg@mail.gmail.com>
In-Reply-To: <CAJZ5v0iH283yXWdzTN1Gb2xBUjy0E04zEgrny1N6QcsAwsJyyg@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 Jan 2023 16:44:38 +0100
Message-ID: <CAJZ5v0i8H0mY4+voOgbDKS15zVq6AsJ6Uoco94Tc6fUxzvVEbg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Misc thermal cleanup and fixes
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, rui.zhang@intel.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 3:03 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Jan 25, 2023 at 12:16 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> >
> >
> > Hi Rafael,
> >
> > will you take this series on your branch ?
>
> Yes, I'm planning to do that, if I don't find any issues with it (not
> likely though).

I've just queued it up for 6.3.

> > On 23/01/2023 16:27, Daniel Lezcano wrote:
> > > This series is based on linux-pm/thermal
> > >
> > > It unregisters the netlink generic family for thermal in case the thermal
> > > framework fails to initialize, removes a unneeded ida_destroy() call and moves
> > > the thermal trip code in a separate file.
> > >
> > > A couple of changes have been removed from the previous version:
> > >
> > >   - Ordering the trip points. Some consolidation is needed in the set_trip_temp
> > >     ops before ordering the trip points, so this change is postpone
> > >
> > >   - Remove the mutex destroy call. Even if the call is not needed, the
> > >     justification of the change is not accurate. So it is postponed also.
> > >
> > >   V2:
> > >     - Removed ordering the trip points change
> > >     - Removed mutex destroy change
> > >     - Added "No functional change intented" as requested by Rui
> > >     - Added the function declaration for_each_thermal_trip
> > >
> > > Daniel Lezcano (3):
> > >    thermal/core: Fix unregistering netlink at thermal init time
> > >    thermal/core: Remove unneeded ida_destroy()
> > >    thermal/core: Move the thermal trip code to a dedicated file
> > >
> > >   drivers/thermal/Makefile          |   4 +-
> > >   drivers/thermal/thermal_core.c    |  93 +--------------
> > >   drivers/thermal/thermal_core.h    |   4 +
> > >   drivers/thermal/thermal_helpers.c |  62 ----------
> > >   drivers/thermal/thermal_netlink.c |   5 +
> > >   drivers/thermal/thermal_netlink.h |   3 +
> > >   drivers/thermal/thermal_trip.c    | 182 ++++++++++++++++++++++++++++++
> > >   7 files changed, 199 insertions(+), 154 deletions(-)
> > >   create mode 100644 drivers/thermal/thermal_trip.c
> > >
> >
> > --
