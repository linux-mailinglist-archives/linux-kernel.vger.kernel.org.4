Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5EA5F45EE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiJDOxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiJDOxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:53:05 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE76631C5;
        Tue,  4 Oct 2022 07:52:58 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id o7so8477696qkj.10;
        Tue, 04 Oct 2022 07:52:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZnypjS4X7nnRh4uFNA5toA2V4KS7S4Gx8cnNdA6YV18=;
        b=0rgUnxI/rz4EDao0UVxrt/LjrKKQRgstnh5AO8TTdY8OgAnHEp2FRs5WQ2UjxsJeu2
         itXNhQsCFwmf/XuF67hrhN1dwnUUtpBYUKwbdfM403Ac0zAKOvqBvQ+ZzsKedSAEv1Q8
         r3zq/3r2aFxc1eLHSWDWdcgvGR+SBw0yBQKAJetYYlGSz9ULHBpUYm+D1x9H5HyHnmE3
         u/Wn3qdhOkMr3IjZwmxqc7b7Jx17FAc473TRr/f8kZBJpZuibbvJVi5q21BSbkMRLjRU
         6/qIEx3s84ZSHjbO7FUytW9IZfItjms4IRpL8lt+ep1HbSGSan0NnFcWiP4uwjOL+1kn
         Czlg==
X-Gm-Message-State: ACrzQf2zKnbRr63l96LNf81pjMFeW2TssyQ2uLIeOtTUVMWuez5lngc8
        BgQO5SV7yTp49AuiGwarX37T7L9yb0zb4pnC+IQ=
X-Google-Smtp-Source: AMsMyM6FmGy9ZWqaGtaBKRddF5SBzP/2Z8HC74/h9LDUzIhLMMJ4di2D2e+i+Xj9IQv7bETgUTU0XVtIkIKsMgc+wQ0=
X-Received: by 2002:ae9:e50e:0:b0:6e0:c985:6383 with SMTP id
 w14-20020ae9e50e000000b006e0c9856383mr1106719qkf.505.1664895177291; Tue, 04
 Oct 2022 07:52:57 -0700 (PDT)
MIME-Version: 1.0
References: <58a7d685-e9e9-e47a-1e20-41b18302e6a7@linaro.org>
 <CAJZ5v0iMkQNwWPBegwpsr+CTtaUr_Eq=_CsQG3QSwdWEmOmPCA@mail.gmail.com> <088a8367-5ca4-674d-9d2f-411840d5a883@linaro.org>
In-Reply-To: <088a8367-5ca4-674d-9d2f-411840d5a883@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 4 Oct 2022 16:52:46 +0200
Message-ID: <CAJZ5v0jkbjogL79R2SOVvUVq1dRpYEGGeFS9Z_Gpd=OeKM9_bw@mail.gmail.com>
Subject: Re: [GIT PULL] thermal drivers for v6.1-rc1
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>
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

On Tue, Oct 4, 2022 at 4:43 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 04/10/2022 16:36, Rafael J. Wysocki wrote:
> > On Tue, Oct 4, 2022 at 11:41 AM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >>
> >> Hi Rafael,
> >>
> >> this is a pull request for more thermal material for v6.1. I've dropped
> >> the trip point rework as a lock issue has been spotted on exynos.
> >>
> >> Most of the changes are fixes. There are more pending changes for the
> >> thermal drivers on the mailing list but they require some more review,
> >> so they will have to wait for v6.2
> >>
> >> Thanks
> >>     -- Daniel
> >>
> >> The following changes since commit 2e70ea7fb9873e642982f166bf9aaa4a6206fbec:
> >>
> >>     Merge branches 'thermal-intel' and 'thermal-drivers' (2022-10-03
> >> 20:43:32 +0200)
> >>
> >> are available in the Git repository at:
> >>
> >>     ssh://git@git.linaro.org/people/daniel.lezcano/linux.git
> >> tags/thermal-v6.1-rc1-2
> >
> > I don't think I can pull over SSH from a host where I don't have an account.
> >
> > Did you mean git.kernel.org?
>
> Yes, indeed :)
>
> https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git/tag/?h=thermal-v6.1-rc1-2

Well, that still didn't work, but I used this tag:

https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
tags/thermal-v6.1-rc1-2

and it worked.

So pulled, but let's make sure next time it's better, OK?
