Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED59E62170F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 15:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbiKHOnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 09:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbiKHOnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 09:43:21 -0500
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2102631ECF;
        Tue,  8 Nov 2022 06:43:20 -0800 (PST)
Received: by mail-qk1-f178.google.com with SMTP id p18so4626390qkg.2;
        Tue, 08 Nov 2022 06:43:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=chPq10Gzwk+MmB+dQBE8YARzKswl0L8S0c4cotUK9Yo=;
        b=Nel+RCouuBuJs1TaAED5Cvd/nfznpqnUTi9Q0+X++UdFTeQ4MNw88NfXMK0pdiBLVp
         xr4K+7kkKqYRk4HW5P2C7UsMk6UT9ghbd++Z0KEBUNJFPHGzJ3t1Whmuzz+oybC8xZQQ
         xURZD392gkNacpyQ3UPKy7LPBjh5/BRtiqEbdAGRoEWuiViwRRuw+Cm+elPpe5V0rvG/
         hsUAC/lkUEcKXq9GgtvdSke5QkeKvzTVxPjutX5/MzFbrqWD7cKyWZynmc5oI4MiLiNN
         XOI/y1sJDeroHBMAOocVfr5t+RXxtTj73YRUz8PDlgKSMy+Qb93ohs0WFYBlSRA3GVGq
         Y7lA==
X-Gm-Message-State: ACrzQf0yBEiLduDrjmQczD9clJEByYdLMt414dNPUvhaFomUL06dYzzr
        N55IUZIiIeP9qF3VU9aF3v4FAKoixSJiuwjHbzI=
X-Google-Smtp-Source: AMsMyM61bIp/lkNqz9d4L2NL67oaG2AS8g2ED2d2BN7jytLEkidQhYJsMKVpa/kDJFQhN8K4Q8s3uCUrZF8Mm0Ykuqc=
X-Received: by 2002:a05:620a:d89:b0:6cf:c98b:744c with SMTP id
 q9-20020a05620a0d8900b006cfc98b744cmr38559368qkl.443.1667918599300; Tue, 08
 Nov 2022 06:43:19 -0800 (PST)
MIME-Version: 1.0
References: <2276401.ElGaqSPkdT@kreacher> <8155359.T7Z3S40VBb@kreacher> <Y2l21CkXvm7mkONq@smile.fi.intel.com>
In-Reply-To: <Y2l21CkXvm7mkONq@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 8 Nov 2022 15:43:08 +0100
Message-ID: <CAJZ5v0j1zeucPOrSa9buYoUms7M9rPAQqo7g50hS2SeyBy63HQ@mail.gmail.com>
Subject: Re: [PATCH v1 4/5] rtc: rtc-cmos: Rename ACPI-related functions
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alessandro Zummo <a.zummo@towertech.it>
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

On Mon, Nov 7, 2022 at 10:22 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Nov 07, 2022 at 09:01:50PM +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > The names of rtc_wake_setup() and cmos_wake_setup() don't indicate
> > that these functions are ACPI-related, which is the case, and the
> > former doesn't really reflect the role of the function.
> >
> > Rename them to acpi_rtc_event_setup() and cmos_acpi_wake_setup(),
> > respectively, to address this shortcoming.
>
> Hmm... I'm not sure I understand why in one case acpi is a prefix and
> in the other is kinda mid-suffix?

Because the former installs an ACPI RTC fixed event handler and the
latter populates the cmos_rtc data structure in the ACPI case.

Maybe it would be better to call the latter cmos_wake_setup_acpi().
