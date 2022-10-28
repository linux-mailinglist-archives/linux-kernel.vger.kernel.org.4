Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F70610C42
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 10:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiJ1Ici (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 04:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJ1Icc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 04:32:32 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028C91C491A
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 01:32:32 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id z3so4028841iof.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 01:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySka4Xz8oYpVMJmGs1uWrHr/m2OpCyAifeU/LNLCiHQ=;
        b=nS/yCaXKm38e/A6crGMFTj32mUFQxrwTaGmc83TsgD15qCCKSstQnCRiFCqAy7NK1q
         lRpNoN34XkxNEbzDXLIa0ACcbGEdrw0h1uzEUReP8xcS58AXn1zupTR6ukCfJ5Dqop02
         f8IYIcZJwp8jGgs8EuyruLxrIleE6PjEhwUMkA6UlAYCbhp+mt6YIXdqzZNlDeHvLHBp
         VgFO9uiSyCAldjV4s9nJQyIry3dpahwbenCpkCFB4Fc7LnL/YevfXJ1cVx9fvDkrqLLF
         QTViOSPo65F41rSbKojWt8i+mtyWVa7bzNAtE7lPHlgdRGfdybny7kXI/NjocnGAxIHY
         vmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ySka4Xz8oYpVMJmGs1uWrHr/m2OpCyAifeU/LNLCiHQ=;
        b=lYMt8qcLI/cordr4jX020PN1/SUyWm/q+YxlapsNt6srfhi9ZUvqO2pme8SDMPw7Ex
         8Bde04vQQqZVViwUHsLJtCiK1Jx3axMYIyzDpN3FGbSiAzi74Ky3yItrYmxwgNKBxPqw
         NHc+O55pCySMyDsBF01uzmBWCjueVP5Hko/mL2jDPi++E0mLSAM6LFRDcOTgs0OF95+t
         FjskVAJZ/K+uKCZDr1/OUi9uPpLKiTNEFLhb9eZH3H2DN0DkT3+cLHURa7JU5ecGXoib
         B3UTxjQP5kmDxWUV3EDB2rLjhfY1D/2nJdZQftsG2HxVoPAMxKapj5JyQxs7uNgZqQxn
         2WNA==
X-Gm-Message-State: ACrzQf3DcuAgCJFN9XspMGdpZgIumdhgcRJlbiAGH3LHUGbCKfN6gXKr
        Vh7GQeoN1UuRPeX2NaP5NluIltKcSNskPziMGgARiw==
X-Google-Smtp-Source: AMsMyM51sozT/gA64vP0ymR3Y6Oto4SSOJ35sjJUGTSOsHrNeF9UsC7inflk5k18GHUAHdbMkRjJY3T41f9faJhlGlU=
X-Received: by 2002:a02:cc51:0:b0:36d:df36:fcb1 with SMTP id
 i17-20020a02cc51000000b0036ddf36fcb1mr19474070jaq.51.1666945951384; Fri, 28
 Oct 2022 01:32:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAOtMz3Pgh+cERiXVetDZJrQa9C0kUUbZ9dRRhdghgm5Or8kwhg@mail.gmail.com>
 <YytwNvSyhq380YNT@zn.tnic> <60a52348-7d50-1056-a596-e154f87c99d2@amd.com>
 <Yyt5LSxSz+6QeWF1@zn.tnic> <YywvmueFj/ibyZdf@smile.fi.intel.com>
 <YywwEvkZK1R9mJfE@smile.fi.intel.com> <c0c8bdce-26a0-ad3f-749b-7585d947608b@redhat.com>
 <YyxrdpUyc+kp48kX@zn.tnic> <33d5cc27-474b-fdec-a6b0-84ac16f7d386@redhat.com>
 <CAOtMz3M=BTZUTRMHWGULwMDWmGdOzHKo=UcZeg3sP8_ndVYk2g@mail.gmail.com> <YzG657ZFeEvLd6hm@zn.tnic>
In-Reply-To: <YzG657ZFeEvLd6hm@zn.tnic>
From:   =?UTF-8?B?SmFuIETEhWJyb8Wb?= <jsd@semihalf.com>
Date:   Fri, 28 Oct 2022 10:32:20 +0200
Message-ID: <CAOtMz3MWnmdMbw_CKxBKVt=TJpLNJuZUzpxvnDi+QnigaLozLA@mail.gmail.com>
Subject: Re: [PATCH -next 1/2] i2c: designware: Switch from using MMIO access
 to SMN access
To:     Borislav Petkov <bp@suse.de>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Limonciello, Mario" <mario.limonciello@amd.com>,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        jarkko.nikula@linux.intel.com, wsa@kernel.org,
        rrangel@chromium.org, upstream@semihalf.com,
        Muralidhara M K <muralimk@amd.com>,
        Naveen Krishna Chatradhi <nchatrad@amd.com>
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

Hi,

Sorry for a late reply. I did some research and experiments and right
now got stuck with this problem.

It's not enough for running init_amd_nbs() to have only
pci_arch_init() done. We need the pci bus to be created and registered
with all devices found on the bus. We are traversing through them and
trying to find northbridge VID/DID. Due to the above, we need to run
init_amd_nbs() only after acpi_scan_init() that is invoked from
acpi_init() which is registered as subsys_initcall. That's why the
trick with switching init_amd_nbs() to arch_initcall_sync will not
work.

So to summarize everything, I would like below order:

acpi_init() -> init_amd_nbs() -> dw_i2c_init_driver()
^--subsys_initcall   ^--fs_initicall            ^--subsys_initcall

but I don't have a clear idea how to achieve this in a clean way.

The only option seems to be to register init_amd_nbs() as
subsys_initcall and force it to execute after acpi_init() and before
dw_i2c_init_drvier(). However the only option (if I'm not mistaken)
for forcing order on initcalls placed on the same level is to modify
their order within Makefile, so that linker puts them in the "init"
section with addresses in desired order. This doesn't seem to be an
option for upstream.

Do you have any clue how to solve this problem?

Best Regards,
Jan


pon., 26 wrz 2022 o 16:45 Borislav Petkov <bp@suse.de> napisa=C5=82(a):
>
> On Mon, Sep 26, 2022 at 02:49:12PM +0200, Jan D=C4=85bro=C5=9B wrote:
> > What do you think about this?
>
> I don't mind as long as it is tested properly so that nothing breaks
> - I can help out on my end as I have a lot of AMD hw - and then
> properly documented in a comment above it *why* it needs to be
> arch_initcall_sync().
>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> SUSE Software Solutions Germany GmbH
> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
> (HRB 36809, AG N=C3=BCrnberg)
