Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FED72A141
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 19:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjFIRcQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 9 Jun 2023 13:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjFIRcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 13:32:13 -0400
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9C5B5;
        Fri,  9 Jun 2023 10:32:10 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-974539fd9f0so44081766b.0;
        Fri, 09 Jun 2023 10:32:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686331928; x=1688923928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mz2NAkBwWInLTRnhBItxSjdZwAej06KnEQlNhNDiMzU=;
        b=bdSEu8Uk88I4VIgFP778xgYl4y1kEMJMBApitRFZ9Ao+/jvXSg23SEbvu7MULKSkir
         GjVPuxdNVKY1IljiTDCqN8xqeeNm2NeCyO0Mg3DGam1Nzn8PUv0874FXOPBW6z+2qAcm
         n6r6M9gVJEzFkyZb2oGutb35JJH9/rz2e85+9aFZ9XqgZtOdyIYxCzvC3UE+1mZeLgqH
         UuY7bXAXTlfYFKoyIMD9mOvM5zGDJuLcLytrRrc6Xdvxnot1bGRV0hpodwregrzRbSPZ
         r+VCiNTp/7Z/EJUewdC2eI0MvR/KD4+Cu2tue3bJ4HbWXtrA6ZnAsHvcDqghqujTP1TU
         +0sw==
X-Gm-Message-State: AC+VfDw+3lkPBrKSeBaxO9P/Qz9DMeEg5UyvdMnIldPSZFT4E0p0P1kJ
        PZWsu9WazetGZWMmlQztvqDrwDS6OFf7lOqikzmEN22G
X-Google-Smtp-Source: ACHHUZ5OaGdB05ChwNZQ4cQ75bLTHgnrmXTnPEkkZPdRUy+ZUO6zSsEBqeNRBlA4zNxMgZnkabgDqFyCdAOU2Z02w9s=
X-Received: by 2002:a17:906:7a41:b0:974:5de8:b5ce with SMTP id
 i1-20020a1709067a4100b009745de8b5cemr1928770ejo.2.1686331927848; Fri, 09 Jun
 2023 10:32:07 -0700 (PDT)
MIME-Version: 1.0
References: <13276375.uLZWGnKmhe@kreacher> <CAJZ5v0gKaheHVfRcgFx_3JdBp9bw5nUQXYp9vZP4RVVXzdb7uw@mail.gmail.com>
 <ZIL2CPyNpy4xCfdn@kekkonen.localdomain>
In-Reply-To: <ZIL2CPyNpy4xCfdn@kekkonen.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 9 Jun 2023 19:31:53 +0200
Message-ID: <CAJZ5v0j_a3RagmX3pRqof_2h6NRUwQffPmsZVx9oKP4KE6JOgw@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] ACPI: scan: MIPI DiSco for Imaging support
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On Fri, Jun 9, 2023 at 11:51 AM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Rafael,
>
> On Wed, May 24, 2023 at 08:06:09PM +0200, Rafael J. Wysocki wrote:
> > On Wed, May 24, 2023 at 1:48 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > >
> > > Hi Folks,
> > >
> > > This basically is a re-write of a recent patch series from Sakari:
> > >
> > > https://lore.kernel.org/linux-acpi/20230329100951.1522322-1-sakari.ailus@linux.intel.com
> > >
> > > The general idea is the same - CSI-2 resource descriptors, introduced in
> > > ACPI 6.4 and defined by
> > >
> > > https://uefi.org/specs/ACPI/6.5/06_Device_Configuration.html#camera-serial-interface-csi-2-connection-resource-descriptor
> > >
> > > are found and used for creating a set of software nodes that represent the CSI-2
> > > connection graph.
> > >
> > > These software nodes need to be available before any scan handlers or ACPI drivers
> > > are bound to any struct acpi_device objects, so all of that is done at the early
> > > stage of ACPI device enumeration, but unnecessary ACPI namespace walks are avoided.
> > >
> > > The CSI-2 software nodes are populated with data extracted from the CSI-2 resource
> > > descriptors themselves and from device properties defined by the MIPI DiSco for
> > > Imaging specification (see https://www.mipi.org/specifications/mipi-disco-imaging).
> > >
> > > Patches [4,6/6] come from the original series directly, but the other patches have
> > > been changes substantially, so I've decided to re-start patch series versioning from
> > > scratch.
> > >
> > > This series is based on the patch at
> > >
> > > https://patchwork.kernel.org/project/linux-acpi/patch/12223415.O9o76ZdvQC@kreacher/
> > >
> > > applied on top of 6.4-rc3.
> > >
> > > Later on, I'll put all of this material into a special git branch for easier
> > > access.
> >
> > The patches are now available from the acpi-mipi-disco-imaging branch
> > in the linux-pm.git tree at kernel.org.
>
> I've been doing some testing on this version.

Thanks for testing!

> It oopses and that's relatively easy to fix by removing the kfree() that
> releases memory of the software nodes and properties.

It would be good to check which of the patches introduces the crash.

> It doesn't work with that change either, it would seem like that the _CRS
> CSI2 data is (most of the time) released before it gets used for creating
> the software nodes, leading node registration to fail. This appears to be
> taking place in different processes --- there's a work queue.
>
> Moving the release of the _CRS CSI-2 resources to where they are no longer
> needed makes the system crash early at boot. I've yet to debug this
> further.

OK, thanks!

I think that the way to go would be to check if the results of the
first patch are as expected and if so, move to the next one etc.
