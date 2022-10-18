Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92783603139
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 18:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiJRQ7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 12:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiJRQ6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 12:58:53 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DE8ED980;
        Tue, 18 Oct 2022 09:58:29 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id g27so21401659edf.11;
        Tue, 18 Oct 2022 09:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=siBPcYsCfbgitX+AQjieJu8JYh/+uUDCJkJNpknXFJ4=;
        b=wL0T0K/L/3noK56uA7NScOSvAQYLo4US44uVGEcZugl0BIXbD3dxzcN7NH0njDYLDp
         YfQofxB2xlBY0sSI1Dbi3knbAtUOyXUjIUjMUuSWGnWwxuhQDVIHgqpRSr3286fwY8oO
         2mp8Pihf27XasSGuXX1BFSo+FbAkPel2kB0grT7fUxJvhp4CFvr7RnJaXFGxp89BqAzu
         picZAZrRZNXiwtmpW9gqtunPiOmk7GS+oaepirfLcYvrvgpcNMkq8x9RoRvAX86+PXZG
         EkJUhE5iwRHXknjigONTgUl5f4WEkD1IDrZTokK6T6o4qtYpt1uUJBmDsO/bJAU+Nods
         E4kQ==
X-Gm-Message-State: ACrzQf0FJrXCG3wGkUO4y2gjDLgks5maVF1IrAIK2z5WZ2O1LqJbUsVX
        Byz3YzDm9cFM5ANrUlYHzp4HGp0oZUJw//liZQc=
X-Google-Smtp-Source: AMsMyM6hk5JmXwWKZXrHq2Dku1MYgmqWKxWbuxNPlgQQSM/zUNSd9wVd16CI1pqLl5EjNqIX4+djNCeijdTLG26GVV4=
X-Received: by 2002:a05:6402:4302:b0:45d:c9b4:c007 with SMTP id
 m2-20020a056402430200b0045dc9b4c007mr3515568edc.328.1666112293447; Tue, 18
 Oct 2022 09:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <5887691.lOV4Wx5bFT@kreacher> <166611112152.2353171.9661532286339710942.b4-ty@bootlin.com>
In-Reply-To: <166611112152.2353171.9661532286339710942.b4-ty@bootlin.com>
From:   Len Brown <lenb@kernel.org>
Date:   Tue, 18 Oct 2022 18:58:01 +0200
Message-ID: <CAJvTdKnNM=bT9q=Ypv9FESBLSo0GOViRFn=SOUz_pYk3dFvBaQ@mail.gmail.com>
Subject: Re: [PATCH] rtc: rtc-cmos: Fix wake alarm breakage
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Todd Brandt <todd.e.brandt@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Works for me!

Tested-by: Len Brown <len.brown@intel.com>

On Tue, Oct 18, 2022 at 6:39 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On Tue, 18 Oct 2022 18:09:31 +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Commit 4919d3eb2ec0 ("rtc: cmos: Fix event handler registration
> > ordering issue") overlooked the fact that cmos_do_probe() depended
> > on the preparations carried out by cmos_wake_setup() and the wake
> > alarm stopped working after the ordering of them had been changed.
> >
> > [...]
>
> Applied, thanks!
>
> [1/1] rtc: rtc-cmos: Fix wake alarm breakage
>       commit: 0782b66ed2fbb035dda76111df0954515e417b24
>
> Best regards,
>
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com



-- 
Len Brown, Intel
