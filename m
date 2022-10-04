Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B18B5F45B4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiJDOjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiJDOig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:38:36 -0400
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AE761D80;
        Tue,  4 Oct 2022 07:38:03 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id f14so5160902qvo.3;
        Tue, 04 Oct 2022 07:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0tq+lwgHeKe9ZEpNEwTleguXL2tPURFAUhqfHkBwFlw=;
        b=mPvWR1aCarVY7v50N0js8x7if3TttcOzMlJiq9522DSA9ccF4nLq1t5salXg0oUr59
         bJKttjVJ/hW9SDt4Djlp+6eHumq19uU9B1v1RRJ0UzFAd4WnFHNzFbqMPNBUZep28qV5
         bo2kHufbSopFm+ZAhA4feu7GGsXAelyqJUHH4JDqQRvfgqGSvSUdCVopCQ7s4p0koFwz
         XZ6v6xqnzsl3XGFw2ZkcebjIPIZMK0cfFwUOlUOe9Jk/cWgGRZhAXA53bTRO7Mo7o7Gk
         FaSkxPYFDzu3K9KaH0HErAV1qh6tYnVwVc9Gm0dLXbhpmbDuCkH9P48nKuFPMI+LhBSb
         DBwQ==
X-Gm-Message-State: ACrzQf3C4NB10p9b198tl65m8jo8SKrhppoN9S0W/p0Vwdfc9AxU3bkM
        SUHIk1Mqc+IiOnh7VngZSuK867d/rjsfx9+dzL0=
X-Google-Smtp-Source: AMsMyM7yFlHiL+sI7j4Ub5ZjA4FyKBT3aTmWcTO6lNleYm9lwLAw5dQLfBLY2tg18a4muBm9y1eIG4XsUxTTx3Ksth0=
X-Received: by 2002:a05:6214:f24:b0:4ac:a9fd:8b42 with SMTP id
 iw4-20020a0562140f2400b004aca9fd8b42mr19995382qvb.22.1664894282139; Tue, 04
 Oct 2022 07:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <58a7d685-e9e9-e47a-1e20-41b18302e6a7@linaro.org> <CAJZ5v0iMkQNwWPBegwpsr+CTtaUr_Eq=_CsQG3QSwdWEmOmPCA@mail.gmail.com>
In-Reply-To: <CAJZ5v0iMkQNwWPBegwpsr+CTtaUr_Eq=_CsQG3QSwdWEmOmPCA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 4 Oct 2022 16:37:51 +0200
Message-ID: <CAJZ5v0irzxkQSNi5dmnKzLUn_LWsE=JazkUYxdmjXk9FQ=xnvA@mail.gmail.com>
Subject: Re: [GIT PULL] thermal drivers for v6.1-rc1
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Tue, Oct 4, 2022 at 4:36 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Oct 4, 2022 at 11:41 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
> >
> >
> > Hi Rafael,
> >
> > this is a pull request for more thermal material for v6.1. I've dropped
> > the trip point rework as a lock issue has been spotted on exynos.
> >
> > Most of the changes are fixes. There are more pending changes for the
> > thermal drivers on the mailing list but they require some more review,
> > so they will have to wait for v6.2
> >
> > Thanks
> >    -- Daniel
> >
> > The following changes since commit 2e70ea7fb9873e642982f166bf9aaa4a6206fbec:
> >
> >    Merge branches 'thermal-intel' and 'thermal-drivers' (2022-10-03
> > 20:43:32 +0200)
> >
> > are available in the Git repository at:
> >
> >    ssh://git@git.linaro.org/people/daniel.lezcano/linux.git
> > tags/thermal-v6.1-rc1-2
>
> I don't think I can pull over SSH from a host where I don't have an account.
>
> Did you mean git.kernel.org?

Or gitolite.kernel.org even?
