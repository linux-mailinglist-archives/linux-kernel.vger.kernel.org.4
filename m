Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7610663AA26
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbiK1NyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbiK1NyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:54:19 -0500
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73DBD66;
        Mon, 28 Nov 2022 05:54:17 -0800 (PST)
Received: by mail-qk1-f178.google.com with SMTP id k2so7200929qkk.7;
        Mon, 28 Nov 2022 05:54:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mhpwzb170HD9ZoLWi4u/Hbo7xH+NenOLfdRLL8Ga/W4=;
        b=zLK535hSHtzFHMUW15p0jqZXj0yv+BWwR1bIXuRTcS4cnW43o/3zqaGmaiXfw/XH7h
         5g8lmKLDac3P84miZ6Ga7U0B1H7jdjLbq0IY/6tBxStm/PTuP6z1+s64C9NMcdK0rETu
         uzIEjepGMMdYZzo4TSIfXcv8YdQL1OfwUm3i0vTqbLefLtj6KS3n6/bbHN0fo/Jgbw68
         D6Mub7GsEzYV+SYOXCoZqVtCWaELkUxjNEX7CZERKxpANA0DjlboLtcc9Eks724gs7RJ
         v7Y7Nkke4qxTDiydGkV4BvV4yPeJvJ+iA/hfNTdACoXn0ksWBjpCqXlAmhPbd0M2ldeE
         EIUQ==
X-Gm-Message-State: ANoB5pkKOQe4v3D15X0ic26UpIUjKO7qXbvREseYRcx9rwzAqlHSUGCV
        EmHcdxFw2YCeumEhC2S3d6dybG/HuuZrnX3x6sA=
X-Google-Smtp-Source: AA0mqf5BP1RwSK8wuyMUkYiuewje17S+ol5TdCh/rsMAdpCSCB/moLDi2JIks2Yfmz/l6v2DjSBNlWF8ZpbrOdztEBQ=
X-Received: by 2002:a05:620a:51ca:b0:6ec:fa04:d97c with SMTP id
 cx10-20020a05620a51ca00b006ecfa04d97cmr29006601qkb.764.1669643657059; Mon, 28
 Nov 2022 05:54:17 -0800 (PST)
MIME-Version: 1.0
References: <20221117122904.6759427e@canb.auug.org.au> <20221128102212.39f90b0c@canb.auug.org.au>
 <1a60d0b2-c020-4fce-d7f2-3534c9e14c84@intel.com> <9ac3a182-fc30-0834-8555-a4ec334531ae@linaro.org>
 <Y4S8H/hn1EJzw8fL@debian.me>
In-Reply-To: <Y4S8H/hn1EJzw8fL@debian.me>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 28 Nov 2022 14:54:05 +0100
Message-ID: <CAJZ5v0gL35QJXECJGnSwPbC3RFWoAD=KGpPdJ0YA1VAPtP1A+Q@mail.gmail.com>
Subject: Re: linux-next: manual merge of the thermal tree with the pm tree
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        rafael@kernel.org
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

On Mon, Nov 28, 2022 at 2:48 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> On Mon, Nov 28, 2022 at 02:22:27PM +0100, Daniel Lezcano wrote:
> >
> > Hi,
> >
> > On 28/11/2022 13:51, Rafael J. Wysocki wrote:
> > > Sorry about this, but I cannot fix it myself and Daniel is on an
> > > extended leave.
> > >
> > > Can you just drop it permanently from linux-next and we'll sort this out
> > > when Daniel is back?
> >
> > Yes sorry for that, I'll go back in a couple of days and sort this out
> >
>
> What about the upcoming merge window? At worst Linus has to figure
> out how to solve this complex conflict when pulling either tree...
>
> Linus has already said that there's likely -rc8 of current cycle [1],
> so we have about two weeks to try sorting out the conflict and be ready
> for PR to him.

As I said before, the thermal tree is merged through the PM tree
anyway, so it needs to be addressed in the thermal tree or worked
around somehow.  Linus will not see this conflict.

Worst-case I can apply patches directly with an ACK from Daniel.

Thanks!
