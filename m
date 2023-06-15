Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7916D731548
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245066AbjFOK2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239010AbjFOK2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:28:41 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA681B2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:28:31 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-39ce64700cbso2959284b6e.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686824911; x=1689416911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ucx4JyNaJjDbrzVBkD86w96Kw83IyLRW7oxLIVIfgdE=;
        b=7ouIaWsiVZWKgSkwmCl8oevPpiNq4nqms8IeYNg+qOmi/9peaOvhuoanUlG2xuC2j9
         xBY5MwOuOQ8Ii9mXEfXqNUe1crHWg7UhoUi3iTZ75qSE5KE3bDDeSQddj+HWmSy8+q8T
         bPEpjE86b9PH8T6W8Q9mhxUwOQbFV9GPjqUbeR2+in+Rf3Pk/LeT4VJb8Q66Dp6iiLnR
         C35enh/NYvi7dfcxL8MS8WAF1NheuSvd5OVgHuYXG5ac66LEJzcBbBv3fcnOCm3H7geO
         xrNKoN1eLYHTlm+chXtZHNKOoZx2trrTUbop4Kak1v1rRL/hQ0Wc0Fgyz6liAaZCK/qi
         ItLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686824911; x=1689416911;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ucx4JyNaJjDbrzVBkD86w96Kw83IyLRW7oxLIVIfgdE=;
        b=EzvhaMWneE7PV9taaPggbcntyrxc4wXmtCkgirEo8E/DuWTaUjeeF6TAT4Duv0cw+t
         OoSgJfG1jMV27dFJJ5QUgIIFO+jYQdZl6gSSDJ06alNHRztpjDnHjgMOfBNjB9bN3FWc
         w5oLmDV/hNV4hrnvcam3YUqkpbE9li1RIHV2+k5aJg+xAbEeyi3DtpkvzrBJMVHBEbrD
         XGIbxvXWyupirZvypZAXQBh168ycj+tIS81Mk+A+MNRizEyF3U/rlUXJnvhVJb4aYuXC
         +7ZfE1URQJwbQmiK0vY/6HsW2MG4Pnz3BemgG5K5UqiNe3PWmnBAWEYJVhCq1A09ReNV
         9Chw==
X-Gm-Message-State: AC+VfDyEkJHS6Vm6g8O7krWpn99ytKetMikH9y/RW4HC0SLRfIbd9emS
        qj3VNt+G7boms6wLcy7ssLOjCYyfyc8RQCZygPFf/vDzv7ESheub5mnMkQ==
X-Google-Smtp-Source: ACHHUZ7G7Ng2XZijVQUl0Q3ancRaxI2gIYm17R9eKrVRa+k96JaJPFBd2+XLSr1KgIiM2dL3jgWZgdY2TEEPqJ9yDUg=
X-Received: by 2002:a05:6808:209f:b0:398:bd63:b5fe with SMTP id
 s31-20020a056808209f00b00398bd63b5femr14802291oiw.18.1686824910847; Thu, 15
 Jun 2023 03:28:30 -0700 (PDT)
MIME-Version: 1.0
References: <CADyq12w_c=pq5sph9Ne+nshz2haeYK-kGYVwQTUqSb3W_kzrdA@mail.gmail.com>
 <20230615044905.GU45886@black.fi.intel.com>
In-Reply-To: <20230615044905.GU45886@black.fi.intel.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Thu, 15 Jun 2023 06:27:54 -0400
Message-ID: <CADyq12xEfTO6akSO5LqyGnF9vBQyptAXsFT7ZbaBjijVEJkU5A@mail.gmail.com>
Subject: Re: thunderbolt: resume from hibernation CPUs racing in tb_ring_start
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Takashi Iwai <tiwai@suse.de>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Matthias Kaehlcke <mka@google.com>, linux-usb@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 12:49=E2=80=AFAM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi,
>
> On Wed, Jun 14, 2023 at 04:26:49PM -0400, Brian Geffon wrote:
> > Hi,
> > On ChromeOS we're running a 5.15 kernel patched up to 6.4-rc6 w.r.t to
> > drivers/thunderbolt code and we're seeing a similar issue to the one
> > discussed in https://lore.kernel.org/lkml/20230421140725.495-1-mario.li=
monciello@amd.com/T/#
> > / https://bugzilla.kernel.org/show_bug.cgi?id=3D217343 where when
> > resuming from hibernation you'll see warnings along the lines of
> >
> > [  126.292769] thunderbolt 0000:00:0d.3: interrupt for RX ring 0 is
> > already enabled
> >
> > The thing that's odd is it appears three CPUs are racing through this c=
ode path:
> >
> > [  126.292076] ------------[ cut here ]------------
> > [  126.292077] thunderbolt 0000:00:0d.2: interrupt for TX ring 0 is
> > already enabled
> > [  126.292080] proc_thermal_pci 0000:00:04.0: PM:
> > pci_pm_thaw_noirq+0x0/0x7c returned 0 after 606 usecs
> > [  126.292086] ------------[ cut here ]------------
> > [  126.292087] thunderbolt 0000:00:0d.3: interrupt for TX ring 0 is
> > already enabled
> > [  126.292089] WARNING: CPU: 6 PID: 7879 at
> > drivers/thunderbolt/nhi.c:138 ring_interrupt_active+0x1cd/0x225
> > [  126.292092] Modules linked in:
> > [  126.292091] WARNING: CPU: 0 PID: 175 at
> > drivers/thunderbolt/nhi.c:138 ring_interrupt_active+0x1cd/0x225
> > [  126.292157] CPU: 0 PID: 175 Comm: kworker/u24:2 Tainted: G     U
> >         5.15.116-19568-g766d8095041b #24
> > fdadcb2517d1d37363ad385ffddbc1ad5dc72550
> > [  126.292158]  lzo_rle zram joydev
> > [  126.292159] Hardware name: Google Anahera/Anahera, BIOS
> > Google_Anahera.14505.143.0 06/22/2022
> > [  126.292159]
> > [  126.292160] Workqueue: events_unbound async_run_entry_fn
> > [  126.292160] CPU: 6 PID: 7879 Comm: kworker/u24:13 Tainted: G     U
> >           5.15.116-19568-g766d8095041b #24
>
> Do you have this one?
>
> https://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git/c=
ommit/?h=3Dfixes&id=3D9f9666e65359d5047089aef97ac87c50f624ecb0

Thank you for pointing me to this, we do not have that in our tree yet
since it's not upstream. I'll apply it and see if it resolved the
issue.

Thanks!
Brian
