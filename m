Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24166D8685
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 21:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234129AbjDETGZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 5 Apr 2023 15:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbjDETGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 15:06:21 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BEF7680;
        Wed,  5 Apr 2023 12:06:17 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-93071f06a94so78127766b.3;
        Wed, 05 Apr 2023 12:06:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680721575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UqPE+VsezJu1sT8pjVClWCXUPjj5biVgYCKxxXHmRWg=;
        b=fctSuF2xZC+3AM3O5Yp0NtQcfg/79M9j+VYdz8H85TjmBgjv+ESzxiF45hJjz+0pGA
         aTS7KdZ7xIOE8ShdR6GNh/XBrA5WQQUtPz3HKInyctbnVIO+LzPt/W8X2tWieR5cSTdO
         CVH2yvzCi7/BXWt0BCbz9nyemXrr6NU0EjtZ1qUpTTzs9t23OvOQOc72jLFRi1mxuDdO
         2DuuYil2vKa6PGaKPUIJsEbQfmGq09IS2YaVBThmdTvkcWIcw4dJ84kFEu3IhoBiPYH2
         UzlntgrZnY/UKryQwunqr6eZpDxjbMrLGpE1ly0qgvX5k73Hch3OYd8WTFl6Z6gcLWKV
         Vibw==
X-Gm-Message-State: AAQBX9e03KmlycgXNi8PpjsMZKzxlh9nLoX502CX6uCiIHsl5+43wcRM
        J47HvQAUYjCt+O7gOPsbjykQ7YyTw2Qfz7jVHF4=
X-Google-Smtp-Source: AKy350Y80I6880YLrHP7PPgcAVKjvTCVhNk/vd5i7fl3nIU0ixeZoDUWpo2wJthv7JKqw0ZTFdpaZVmgaWyMxaK8U7w=
X-Received: by 2002:a50:9984:0:b0:4fb:f19:87f with SMTP id m4-20020a509984000000b004fb0f19087fmr1678246edb.3.1680721575410;
 Wed, 05 Apr 2023 12:06:15 -0700 (PDT)
MIME-Version: 1.0
References: <ab323c72-61f9-9ac6-48ce-366f62e82091@linaro.org>
 <3e64e6b2-7c3f-d149-2f7d-6c41be4c4d14@linaro.org> <CAJZ5v0ji6SxrgiMRMwNDwGspxifo0FSi3d5+2O02SKM_q_OaFA@mail.gmail.com>
 <CAJZ5v0iNbA0rt3QyaFA7ved19yK8-nabyJi7yCfbnVKQaMPCmA@mail.gmail.com> <c230ab3a-9cc3-e989-1e49-7d38be471a5c@linaro.org>
In-Reply-To: <c230ab3a-9cc3-e989-1e49-7d38be471a5c@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 5 Apr 2023 21:06:04 +0200
Message-ID: <CAJZ5v0i95D_duiEnBiTgCSGTJ9_q7VYmb9y8O6yuPQ7Yp=BD3Q@mail.gmail.com>
Subject: Re: [GIT PULL] thermal for v6.4-rc1
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Wed, Apr 5, 2023 at 9:03 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 05/04/2023 20:48, Rafael J. Wysocki wrote:
> > On Wed, Apr 5, 2023 at 8:39 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >>
> >> On Wed, Apr 5, 2023 at 8:32 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >>>
> >>>
> >>> Hi Rafael,
> >>>
> >>> just a gentle reminder
> >>
> >> This is in my linux-next branch, I'll merge it into thermal tomorrow.
> >>
> >>>   because more material will come in the next days
> >>
> >> So why can't it wait?
> >
> > BTW, I get a merge conflict in
> > drivers/thermal/mediatek/auxadc_thermal.c on an attempt to merge
> > thermal/linux-next into my linux-next branch.
>
> Ah?
>
> I did an update and rebased thermal/linux-next on top of
> linux-pm/thermal without conflict
>
> Is it possible you have a change in a different branch conflicting with it ?

It is not impossible, but quite unlikely.

I'll see what's going on tomorrow.
