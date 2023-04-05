Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D866D863D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 20:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233939AbjDESsY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 5 Apr 2023 14:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjDESsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 14:48:22 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7110F5589;
        Wed,  5 Apr 2023 11:48:21 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-502a9a5769fso723459a12.0;
        Wed, 05 Apr 2023 11:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680720500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=67fV9I5I66Rtlizh+eEB91Qx22aI651awT8qt0NxLiM=;
        b=Havt3C34yVT8OdzuFBWJ2oQ/vLNkZ6NfChvSV69ONuRt2VCoRBVxAIVUH7tLx0SD5p
         92Opcvvbf3vCh50PLfIU4bJJkBRizXfuwrft2CkPAeeArkbO6nhgnqaZfWGVcKFlcIac
         Tl9Dj9OMtgy5W6yA0eBqbjO9GHZQwU/qYcSVroZNHrAbRRNByr7hivVLv6AUxLwTXjT9
         E3A/GJzgf1pGoh/BmFyKojytHRiQT6XX8mRquZ0ZU4S4Es+Iky7gnCmTrv3cUsqtkrMh
         8twDE9efS0IGLaQlfWeeeol4MJYgNKWrZtSzGlJUbyprglI4XIre8TuPYQmh9jekrhlJ
         0ARw==
X-Gm-Message-State: AAQBX9drBg/brcRuyIEra/dB78ZKPnKhCyA17NUfBDjv9oo6H+m1x3ib
        9Ss/kPsdA9cmOxZ8iy1FsPSLne5N9s6iFyg5arL6z4iESow=
X-Google-Smtp-Source: AKy350afGseDTvgP0P0rMFW2L1TF3FKQo72LCTM5A8Y8LIjGFZf8kMZTrFjMv0JSLW31Acq/pmbqbk1oWP64qZZ40y8=
X-Received: by 2002:a50:aa93:0:b0:4fb:2593:846 with SMTP id
 q19-20020a50aa93000000b004fb25930846mr1715812edc.3.1680720499981; Wed, 05 Apr
 2023 11:48:19 -0700 (PDT)
MIME-Version: 1.0
References: <ab323c72-61f9-9ac6-48ce-366f62e82091@linaro.org>
 <3e64e6b2-7c3f-d149-2f7d-6c41be4c4d14@linaro.org> <CAJZ5v0ji6SxrgiMRMwNDwGspxifo0FSi3d5+2O02SKM_q_OaFA@mail.gmail.com>
In-Reply-To: <CAJZ5v0ji6SxrgiMRMwNDwGspxifo0FSi3d5+2O02SKM_q_OaFA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 5 Apr 2023 20:48:08 +0200
Message-ID: <CAJZ5v0iNbA0rt3QyaFA7ved19yK8-nabyJi7yCfbnVKQaMPCmA@mail.gmail.com>
Subject: Re: [GIT PULL] thermal for v6.4-rc1
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 5, 2023 at 8:39 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Apr 5, 2023 at 8:32 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >
> >
> > Hi Rafael,
> >
> > just a gentle reminder
>
> This is in my linux-next branch, I'll merge it into thermal tomorrow.
>
> >  because more material will come in the next days
>
> So why can't it wait?

BTW, I get a merge conflict in
drivers/thermal/mediatek/auxadc_thermal.c on an attempt to merge
thermal/linux-next into my linux-next branch.
