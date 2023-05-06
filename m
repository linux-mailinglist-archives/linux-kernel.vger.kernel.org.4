Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 301EA6F9090
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 10:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjEFIZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 04:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjEFIZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 04:25:32 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850068F;
        Sat,  6 May 2023 01:25:31 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3064099f9b6so1671481f8f.1;
        Sat, 06 May 2023 01:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683361530; x=1685953530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAG11WhA1HXvQIF+mSp0DLYzC7zL0QVffaPND8UKw2Y=;
        b=lILooLTDbz66qVPSPD7HHx6/1X+eW9A1ysaNySwn1Livh+Uhp1cDkVl6hpzFMiFxp2
         g9W0gH/QgjOYoX1BamTHKbo0LrdOUaFzUrCC8GIPMcNIIqjD1ea8QLTNePPyiGsYtiDZ
         leIP1YRoEDV+o+u49Lx5yb1DgJU26jqdpMyNHCjZX8PecdWb0qKJ2VXpUYNNQ403v0Xc
         MiFIQCRX4zdp45GH9KJoNkzdiAR4mo7BWLrUMcnLs4kdP+eQAJuZAkh/2NuLHkfje6Br
         PPqstCtwdc2ucLUnHjV2/vp5xaSddDYZiPR1OBQdNLg3mVOEGE1zCcVj5Kd57L6yLGxE
         UL1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683361530; x=1685953530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uAG11WhA1HXvQIF+mSp0DLYzC7zL0QVffaPND8UKw2Y=;
        b=JyXOB1/PNfu7pe2n1HWgclNYJuBaYlXGUNGVzI/La45JgG1meUUJR8XWFeJRzdBpAi
         77agPHwgxWKXgyHrnh8Y6NAxpK+muWer/iRHpZM9K8HrXIrsl4rCbhl+1KLNkDw5qxmn
         Ln3TTgouCF5IVJ7gThp/fKPZcRxEjNdNgCBkFOIR2iuP+d8qVafCIL8n2bZR+dTX8yWV
         17tjTIpm7wQgOdtKsmiAFABviA7Bmdye28ghsuvuWI1ArJK99zFtwSaPU08zZ7zFgxX8
         jItxPsNoiue23MdbyW41di13F1HmGz776wtXB4zYrH/pcPzm7Hv9iTY5WOEy1kHHMMGf
         TbXQ==
X-Gm-Message-State: AC+VfDzyMXKvrr+bkAqfJ5KnhUdMFGLIX+Ndbeyex+lPoXuETa+epuct
        6rypU7bWjrnJlLdmG5DyWDztEEWBZWcJCZ5/wZE=
X-Google-Smtp-Source: ACHHUZ6IdbgpYJm/lb3Z7bSaP10+Kh1tYLIA1fmy0q5Xmn96YsWSpNkfbWQJfplXgFzUCQhFe5ib01IdJKdtzydFYHQ=
X-Received: by 2002:a5d:40cf:0:b0:306:39a8:6fa2 with SMTP id
 b15-20020a5d40cf000000b0030639a86fa2mr2361800wrq.61.1683361529811; Sat, 06
 May 2023 01:25:29 -0700 (PDT)
MIME-Version: 1.0
References: <01ea5c8e-ed2f-7568-f6ed-896329e7b673@leemhuis.info> <68d017d9-d815-01d4-23c1-49c0aaf5f20b@amd.com>
In-Reply-To: <68d017d9-d815-01d4-23c1-49c0aaf5f20b@amd.com>
From:   Chuanhong Guo <gch981213@gmail.com>
Date:   Sat, 6 May 2023 16:25:17 +0800
Message-ID: <CAJsYDVKY0V4V5fCseGJ7SPW6+-4r7d04RTgkF82VgYcNLk5DtQ@mail.gmail.com>
Subject: Re: [regression] Bug 217394 - IRQ override skipping breaks the Aya
 Neo Air Plus 6800U keyboard buttons
To:     "Limonciello, Mario" <mlimonci@amd.com>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        linux-input@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario!

On Thu, May 4, 2023 at 12:11=E2=80=AFAM Limonciello, Mario <mlimonci@amd.co=
m> wrote:
>
> +linux-input
>
> On 5/3/2023 7:58 AM, Linux regression tracking (Thorsten Leemhuis) wrote:
> > Hi, Thorsten here, the Linux kernel's regression tracker.
> >
> > I noticed a regression report in bugzilla.kernel.org. As many (most?)
> > kernel developers don't keep an eye on it, I decided to forward it by m=
ail.
> >
> > Chuanhong Guo, apparently it's cause by a change of yours.
> >
> > Note, you have to use bugzilla to reach the reporter, as I sadly[1] can
> > not CCed them in mails like this.
> >
> > Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=3D217394 :
> >
> >>   Matthew 2023-05-03 02:28:33 UTC
> >>
> >> Reverting the changes found in this patch fixes the issue:
> >>> https://lore.kernel.org/all/20220712020058.90374-1-gch981213@gmail.co=
m/
> >> With that patch the AT Translated Set 2 Keyboard doesn't show up with =
the evtest and is not usable.
> >>
> >> Hardware:
> >>
> >> Aya Neo Air Plus
> >> AMD Ryzen 7 6800U
> > See the ticket for more details.
> >
> > BTW: there apparently is another IRQ override needed for a different
> > machine. See https://bugzilla.kernel.org/show_bug.cgi?id=3D216804#c8 fo=
r
> > details (ignore the comments before that, the quirk entry for that
> > machine was merged; comment 8 and all related to it really should have =
a
> > separate bug; that's also why this partly fall through the cracks here
> > :-/ ). The user is currently trying to create a patch.
> >
> Something I'm wondering about is if it's possible for i8042 to detect
> the polarity is incorrect when it probes and
> to try to correct it.
>
> If we could do that we can probably drop 9946e39fe8d0 ("ACPI: resource:
> skip IRQ override on AMD Zen platforms")
> to fix this issue along with all the other quirks that have collected
> over time on i8042 polarity issues.
>

I don't really understand why there are more and more new laptops
appearing with broken IRQ settings in ACPI, especially considering
the fact that some of these laptops were released after the original
problem was already identified almost a year ago.
What exactly was the solution when AMD internally discovered this IRQ
mismatch problem? Did you guys changed the emulated IRQ polarity
without updating the ACPI table with the corresponding polarity
description in your reference design?

--=20
Regards,
Chuanhong Guo
