Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8115474975F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 10:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbjGFIUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 04:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjGFIUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 04:20:37 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A038E10F7
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 01:20:35 -0700 (PDT)
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 319203F125
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 08:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1688631634;
        bh=Mc09Q0aiju92Qfy7nDEKyfEwnxyYr4WtsvBD4qdO1Co=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=LeYr0lzf7x7mThhbdwOquSkkYXCruFYUVTGXcxHknkZxyyIZqhnh3Cniytr8gC1LS
         UkltCErlsGulmCV78qQaVJYuNM1xBCjhbRwabRd5XrwWaXva5hrHKsBXF6YbeCKymi
         q9RvAS4igXxRv/HA9uo8271S2HGzSY7j6BlGJ2Z0ljz5pA48vSCSnc+rzD0Zjmshc7
         Rh9U5en+M5revteuRmemgKI2UyYsYtylgcasQ6n45399lo+voFrD1YQ+PzLPJioQCJ
         PeYuNest/FXA5BHi0LZhptvDyvR0iw6qsWmAWORcmLQ0FGj758Gf/ZmEElpqSPpshW
         /1CQbU8rYvPDA==
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-66870a96b89so553668b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 01:20:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688631632; x=1691223632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mc09Q0aiju92Qfy7nDEKyfEwnxyYr4WtsvBD4qdO1Co=;
        b=FiJMZGAafBlSzYIFz/GiD+5tFMUEAs7S1KN6xkXdYWGV1eTySxqXJ+31snmXDAlInz
         LUDYDatBAT71Yw/pa1F1Y0zupp2VbbA2Cp8C7vxMURqdqmKhWwF0dBgs9eB8FfCS7XAA
         J5JEXYkXoU5p1HX5oYrIBMCG1e2HyQtBIYzrnpX0djtmdKUSQeOWeUEfBBX7cni4MEeb
         tnxS9FAVvxTTsKEmWWswceQdxEnaGzF6xeaIRdBtX7xZeGhT+DLg3ZJ3b221ejkB34CS
         FvoN1nTaOS2J1fd/SCNBz6InHecomc78e9GZ3D1zj23ezIud1hKmOAVJFNBii6qfUbRf
         Yq9Q==
X-Gm-Message-State: ABy/qLZsAMMo7GaR+Q50qtXQSYDJVtVVM2ridJN7P9Q5YmjX0wUjFsXi
        sHZnEVRU8ZenbEGK1dwi+aPhN2D4fG7Npoe+W4TmxkbPJUsxQoiNyu5/YZ39FkNGm8eeIIXRP+D
        Pyl12PLv0pPqbWHgzNZ0U6tMIHoBaxCr8ew1Uu4OXznnFYZaX9vDR1Ds4Hw==
X-Received: by 2002:a05:6a00:24d5:b0:682:bd6e:b16a with SMTP id d21-20020a056a0024d500b00682bd6eb16amr873300pfv.14.1688631632420;
        Thu, 06 Jul 2023 01:20:32 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGv0aUJCc57ozulJCmVrpQYfmvxqvUTQCxXCLBL62lCOHE93OKdkeac5ePyoPreCQ+QjXP98radX5YgY5RmrGQ=
X-Received: by 2002:a05:6a00:24d5:b0:682:bd6e:b16a with SMTP id
 d21-20020a056a0024d500b00682bd6eb16amr873296pfv.14.1688631632050; Thu, 06 Jul
 2023 01:20:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230704074506.2304939-1-kai.heng.feng@canonical.com>
 <CAJZ5v0jwO1NJ_x2t3RV-kYDmVY9UtyexznCSZMAmQ-gK4dWCmA@mail.gmail.com> <f5a4f802-d6a1-050e-ec70-701048ab1a2f@redhat.com>
In-Reply-To: <f5a4f802-d6a1-050e-ec70-701048ab1a2f@redhat.com>
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Date:   Thu, 6 Jul 2023 16:20:21 +0800
Message-ID: <CAAd53p5nkE+QdxJwF_mEsNiEHvRwg+4D7yP77H6CDrMWPOX_zQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: video: Invoke _PS0 at boot for ACPI video
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 5, 2023 at 6:33=E2=80=AFPM Hans de Goede <hdegoede@redhat.com> =
wrote:
>
> Hi,
>
> On 7/4/23 18:58, Rafael J. Wysocki wrote:
> > On Tue, Jul 4, 2023 at 9:46=E2=80=AFAM Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:
> >>
> >> Screen brightness can only be changed once on some HP laptops.
> >>
> >> Vendor identified the root cause as Linux doesn't invoke _PS0 at boot
> >> for all ACPI devices:
> >
> > This part of the changelog is confusing, because the evaluation of
> > _PS0 is not a separate operation.  _PS0 gets evaluated when devices
> > undergo transitions from low-power states to D0.
> >
> >>     Scope (\_SB.PC00.GFX0)
> >>     {
> >>         Scope (DD1F)
> >>         {
> >>             Method (_PS0, 0, Serialized)  // _PS0: Power State 0
> >>             {
> >>                 If (CondRefOf (\_SB.PC00.LPCB.EC0.SSBC))
> >>                 {
> >>                     \_SB.PC00.LPCB.EC0.SSBC ()
> >>                 }
> >>             }
> >>             ...
> >>         }
> >>         ...
> >>     }
> >>
> >> _PS0 doesn't get invoked for all ACPI devices because of commit
> >> 7cd8407d53ef ("ACPI / PM: Do not execute _PS0 for devices without _PSC
> >> during initialization").
>
> So this _PS0 which seems to be the one which needs to run here,
> is not the _PS0 for the GFX0 ACPI device, but rather for a child ACPI dev=
ice-node which describes the connector (assumed based on the small part of =
quoted DSDT, the actual definition of the DD1F device-node is missing).

I'll file a bugzilla and attach a full acpidump there.

>
> Having a _PS0 method on a connector object is really weird IMHO. But if w=
e need to invoke such a _PS0 method then IMHO that really should be done in=
 the drm/kms driver. E.g. at least the i915 code already contains code to m=
ap the ACPI connector objects to the drm_connector objects, so it should be=
 relatively easily to make that try and do a power-transition to D0 when en=
abling the connector.

Or put all ACPI devices to D0 at boot?
According to the BIOS folks that's what Windows does.
This way we can drop acpi_device_fix_up_power* helpers altogether.

>
> Also can you provide some more info on the hw on which this is being seen=
:
>
> 1. What GPU(s) is/are being used

Intel GFX.

AFAIK AMD based laptops also require this fixup too.

> 2. If there is a mux for hybrid gfx in which mode is the mux set ?

No. This happens to mux-less and dGPU-less laptops.

> 3. Wjich method is used to control the brightness (which backlight-class-=
devices show up under /sys/class/backlight) ?

intel_backlight.

>
> And can you add this info to the commit msg for the next version of the p=
atch ?

Sure.
Can putting all devices to D0 be considered too? It's a better
solution for the long wrong.

Kai-Heng

>
> Regards,
>
> Hans
>
>
>
>
> >
> > And yes, Linux doesn't put all of the ACPI devices into D0 during
> > initialization, but the above commit has a little to do with that.
> >
> >> For now explicitly call _PS0 for ACPI video to workaround the issue.
> >
> > This is not what the patch is doing.
> >
> >> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >> ---
> >>  drivers/acpi/acpi_video.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
> >> index 62f4364e4460..793259bd18c8 100644
> >> --- a/drivers/acpi/acpi_video.c
> >> +++ b/drivers/acpi/acpi_video.c
> >> @@ -2027,6 +2027,8 @@ static int acpi_video_bus_add(struct acpi_device=
 *device)
> >>         if (error)
> >>                 goto err_put_video;
> >>
> >> +       acpi_device_fix_up_power_extended(device);
> >> +
> >
> > I would like to know what Hans thinks about this.
> >
> >>         pr_info("%s [%s] (multi-head: %s  rom: %s  post: %s)\n",
> >>                ACPI_VIDEO_DEVICE_NAME, acpi_device_bid(device),
> >>                video->flags.multihead ? "yes" : "no",
> >> --
> >
>
