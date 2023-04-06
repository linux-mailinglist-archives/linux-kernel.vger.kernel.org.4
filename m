Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9776DA04F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 20:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240288AbjDFSs5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 Apr 2023 14:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240521AbjDFSsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 14:48:24 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CFCBDD8;
        Thu,  6 Apr 2023 11:47:55 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id sg7so3670676ejc.9;
        Thu, 06 Apr 2023 11:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680806858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4jRBHVfxgd+JT9UVreLLErHTyZCuz18QSEV4mFOIkQ=;
        b=InXbHioYHWlvl/G3VAAqJegJELLT5rQ6pkkt7J/7nVl4yKxe9f3vOG8tOMYBah5B6w
         xbix92NfikTfyLTXgT2qftp5hNmsNNXN/VnZrvKx0VFExYxjgeTE2D7lg3Mn3hVR/XbY
         /cb1I0IsQjz9r0s4+rni2OslJEP5bl/Q00f4XzKccTOxq7GHVDISzQEvyHQ4mom1uLTZ
         KPFLrkMD0sTBPx+Uhap6kYKQLPZts14DTK6SOLWzectKsRPXpg+9EtIE2/EjpGd+W8EN
         84vQhBmPntPUFzTBlMh0HJB4Iw6iAQ6Jgxizkgc7w3ofP6kThjCxq3uIKBleseziWRRS
         sYsQ==
X-Gm-Message-State: AAQBX9e2sIt+2Ersg4ePXP9y+C22Di969maFSMqxLGw3gM5TLG8vzx9w
        V8C8IEi6GyEVzpLm24KKR5R0Se5wgKRisiM9l/g=
X-Google-Smtp-Source: AKy350YPsdcxvCg4deshFZnM74wm0klT6PPQimXSIdAeXq/d+BizHedGmZ+YEm9sTp5GnxySPCZun6L5K/fHSriW+/o=
X-Received: by 2002:a17:906:73d8:b0:939:a51a:dc30 with SMTP id
 n24-20020a17090673d800b00939a51adc30mr5153717ejl.2.1680806857947; Thu, 06 Apr
 2023 11:47:37 -0700 (PDT)
MIME-Version: 1.0
References: <ab323c72-61f9-9ac6-48ce-366f62e82091@linaro.org>
 <3e64e6b2-7c3f-d149-2f7d-6c41be4c4d14@linaro.org> <CAJZ5v0ji6SxrgiMRMwNDwGspxifo0FSi3d5+2O02SKM_q_OaFA@mail.gmail.com>
 <CAJZ5v0iNbA0rt3QyaFA7ved19yK8-nabyJi7yCfbnVKQaMPCmA@mail.gmail.com>
 <c230ab3a-9cc3-e989-1e49-7d38be471a5c@linaro.org> <CAJZ5v0i95D_duiEnBiTgCSGTJ9_q7VYmb9y8O6yuPQ7Yp=BD3Q@mail.gmail.com>
In-Reply-To: <CAJZ5v0i95D_duiEnBiTgCSGTJ9_q7VYmb9y8O6yuPQ7Yp=BD3Q@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 6 Apr 2023 20:47:26 +0200
Message-ID: <CAJZ5v0jhK431LMObxQ2seNGGQEPd2tQHhRmbeWG1b=yzSO6gKA@mail.gmail.com>
Subject: Re: [GIT PULL] thermal for v6.4-rc1
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Zhang Rui <rui.zhang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yang Li <yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 5, 2023 at 9:06 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Apr 5, 2023 at 9:03 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >
> > On 05/04/2023 20:48, Rafael J. Wysocki wrote:
> > > On Wed, Apr 5, 2023 at 8:39 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > >>
> > >> On Wed, Apr 5, 2023 at 8:32 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> > >>>
> > >>>
> > >>> Hi Rafael,
> > >>>
> > >>> just a gentle reminder
> > >>
> > >> This is in my linux-next branch, I'll merge it into thermal tomorrow.
> > >>
> > >>>   because more material will come in the next days
> > >>
> > >> So why can't it wait?
> > >
> > > BTW, I get a merge conflict in
> > > drivers/thermal/mediatek/auxadc_thermal.c on an attempt to merge
> > > thermal/linux-next into my linux-next branch.
> >
> > Ah?
> >
> > I did an update and rebased thermal/linux-next on top of
> > linux-pm/thermal without conflict
> >
> > Is it possible you have a change in a different branch conflicting with it ?
>
> It is not impossible, but quite unlikely.
>
> I'll see what's going on tomorrow.

Confirmed, thermal/linux-next merges on top of the current
linux-pm/thermal (just pushed out) without conflicts.

There is a conflict between linux-pm/bleeding-edge and
thermal/bleeding-edge, but it's easy to resolve.

Thanks!
