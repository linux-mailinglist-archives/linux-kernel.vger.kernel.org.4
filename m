Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7AE691D67
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 11:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjBJK6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 05:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbjBJK6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 05:58:51 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EC75AB38
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 02:58:50 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id ay1so3220828pfb.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 02:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b7phvD7nK4kIvx8H59seUFTQxz++eLDaRYRm9yYwBI8=;
        b=DEK0/LavcptJVJudPdJlVORLyZbyT0qPiqw+oN4lY78JSSVALFlA7GVEyX/2A0g53t
         oC0a5UJUXOMvC6lZg4TAo76W16Xd2ihd8YR6hlrAwZUFpB1em9T1/RpQsUZ3f7IfD69C
         DurLMUloA9oodlSGARuZ6g+gWDixmzaqroEQNkyw988QvRyev+HR+/EoG0/vabPiNKzD
         b4E+rDYwZ848wVQZhmykJdRBFvtTCDQftoWbVYH4tIikx9zr149DeB7gRbyDjtYM76j/
         aMAL7FxKVQ+HJiYqUKsvOyRSJhTtK5Aujpq9L4N0IsZ1TosO3MuPMugVBAmYqIEMDAEH
         gu1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7phvD7nK4kIvx8H59seUFTQxz++eLDaRYRm9yYwBI8=;
        b=jZh/damxlh/YLy++OeZnwAXRtRDlfUll/lvp98/DC/mXiGUCM3/JRoHTgT6xmue5oB
         OP5UAghwL7WQdqXpdbJw9vTKfSvcUYm8eEmfw3B3xcgNC7s8UusA9hTlcY7uPcN/h5rO
         2+Mn36G9Qm0jxhxrUm5XKzQ9o61P38ZCRdi+8jWV6Bhmye1hCgPBuI4mwmeJZqYfFSyh
         nVHcoXZjv0Tao5RNePjIdIvJRNyOIPLJ3TDdz4wZOurMaPW0tjT6DQpOzYacTPyiZx3J
         PJ5ewjXei3VPohp0YDaXC/22jkHhXemYIjeBiv+h0XAi5K43ln6epLaHHBlovM77UaZt
         a5XQ==
X-Gm-Message-State: AO0yUKXe8i4z70a0gXf4iLGl3gZ/0UMX68Oxv64LeXwuaOasWsNf5qb6
        v6QRpWXj1xanqIo/Ih2Fvo1hpH7LM/eHlnp1klQw8w==
X-Google-Smtp-Source: AK7set9pOsGmIRmKHTcj+Z9vPSqM9Hmvj3TE4cl4sbWD/hRxU8GKzJ1TzKjpm9UN4xknw+vhoxstLWE8ZzdNLDQ1oTs=
X-Received: by 2002:aa7:95b8:0:b0:593:9029:fcf6 with SMTP id
 a24-20020aa795b8000000b005939029fcf6mr3016644pfk.52.1676026730179; Fri, 10
 Feb 2023 02:58:50 -0800 (PST)
MIME-Version: 1.0
References: <20230209152123.3186930-1-jaz@semihalf.com> <20230209152123.3186930-2-jaz@semihalf.com>
 <Y+VlCWwn35ECE9iz@google.com>
In-Reply-To: <Y+VlCWwn35ECE9iz@google.com>
From:   Grzegorz Jaszczyk <jaz@semihalf.com>
Date:   Fri, 10 Feb 2023 11:58:39 +0100
Message-ID: <CAH76GKPTzAn==B_v9VfR0rPR-u2VBNZ7F07oyw1k_-O2=mmCPQ@mail.gmail.com>
Subject: Re: [RESEND RFCv2 1/1] platform/x86: Add virtual PMC driver used for S2Idle
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org, dmy@semihalf.com,
        tn@semihalf.com, dbehr@google.com,
        zide.chen@intel.corp-partner.google.com, upstream@semihalf.com,
        hdegoede@redhat.com, markgross@kernel.org, dtor@google.com,
        mario.limonciello@amd.com, linux-pm@vger.kernel.org,
        x86@kernel.org, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 9 lut 2023 o 22:26 Sean Christopherson <seanjc@google.com> napisa=C5=
=82(a):
>
> On Thu, Feb 09, 2023, Grzegorz Jaszczyk wrote:
> > Virtual PMC driver is meant for the guest VMs for the S2Idle
> > notification. Its purpose is to register S2Idle dev ops check handler,
> > which will evaluate ACPI _DSM just before the guest enters S2Idle power
> > state.
> >
> > This allows to trap on MMIO access done as a consequence of _DSM
> > evaluation and therefore notify the VMM about the guest entering S2Idle
> > state.
> >
> > Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
> > ---
> > Changelog v1..v2:
> > - Take advantage of acpi_s2idle_dev_ops's check() instead of notify()
> > ---
> >  drivers/platform/x86/Kconfig    |  7 ++++
> >  drivers/platform/x86/Makefile   |  3 ++
> >  drivers/platform/x86/virt_pmc.c | 73 +++++++++++++++++++++++++++++++++
> >  3 files changed, 83 insertions(+)
> >  create mode 100644 drivers/platform/x86/virt_pmc.c
> >
> > diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfi=
g
> > index 5692385e2d26..b7c3f98031d7 100644
> > --- a/drivers/platform/x86/Kconfig
> > +++ b/drivers/platform/x86/Kconfig
> > @@ -1099,6 +1099,13 @@ config WINMATE_FM07_KEYS
> >         buttons below the display. This module adds an input device
> >         that delivers key events when these buttons are pressed.
> >
> > +config VIRT_PMC
> > +     tristate "Virt PMC"
>
> Maybe spell out "Virtual Power Management Controller"?  See below.

Sure, it makes sense to be more verbose here.

>
> > +     depends on ACPI && SUSPEND
>
> I think it makes sense to take a dependency on HYPERVISOR_GUEST.  It's no=
t strictly
> required, but taking that dependency helps clarify that this is a guest-s=
ide thing,
> e.g. "virtual PMC" in KVM-land means "virtual performance monitoring coun=
ter".
>
> And IMO, disabling HYPERVISOR_GUEST should disable these type of guest-sp=
ecific
> features.

Ok, thank you
