Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701DE5E6052
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 13:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbiIVLAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 07:00:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiIVLAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 07:00:36 -0400
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [IPv6:2001:4b98:dc4:8::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D614AB1A9
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 04:00:33 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 9C663200012;
        Thu, 22 Sep 2022 11:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663844431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2+nyFk2NJkNoRqs5e6/bwgAMbNi2C5Vm0aE+Pl9rCjE=;
        b=MDAG17QzbvHP42JmcgWqzsOvs/qxifFFrqjd+GElfynyKohV5yjQnVzFvEXgHQUjrYFupm
        T1me0476TdqxUe6/AO2tOJzmamFhTXBBCm6+rbFJeO/7LuqzPNHLfp+5ii+Ell3cvHHqfw
        /3skeryiskRlj+LjQAYq+N1bpy2V8jL+lj1HrBnYcAmB7l0GwcyJjZzS54xG4sa9sN/+8q
        BYKKX542XJ2j7bsnUdy3veWQUlaVdR38hZAheWW38B+o7PTyj/xGxPK1VHCzxPKelv18QD
        C6O+9J63+i2gR5sH95uKoNEvy3s5NsOZbZXUbnTrDJ3E4LnOyGOLF7Nc5SYXYg==
Date:   Thu, 22 Sep 2022 13:00:28 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Arnd Bergmann" <arnd@arndb.de>
Cc:     "Valentin Korenblit" <vkorenblit@sequans.com>,
        "kernel test robot" <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [mtd:nand/next 11/31]
 drivers/mtd/nand/raw/cadence-nand-controller.c:1893:4: error: implicit
 declaration of function 'ioread64_rep' is invalid in C99
Message-ID: <20220922130028.67657957@xps-13>
In-Reply-To: <01210adb-ff77-4ec5-8d10-ab56ae986d58@www.fastmail.com>
References: <202209210641.MziHAbW7-lkp@intel.com>
        <20220921104002.226ff3f6@xps-13>
        <ffde44bc-d4ae-4052-c60c-35c8775a5101@sequans.com>
        <7074197c-aa8d-f763-cb0f-03ea5335b923@sequans.com>
        <20220921164720.6bbc56d5@xps-13>
        <ef9a2618-2dd0-4d1b-b9d2-37d59506f004@www.fastmail.com>
        <20220921183807.241e2518@xps-13>
        <b7e5ebb4-0de8-4958-9bc4-fe06ec4c3635@www.fastmail.com>
        <6b5a2b19-39c6-5116-60c2-d292ae2e7bae@sequans.com>
        <20220922113613.4d7273c8@xps-13>
        <01210adb-ff77-4ec5-8d10-ab56ae986d58@www.fastmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

arnd@arndb.de wrote on Thu, 22 Sep 2022 12:52:36 +0200:

> On Thu, Sep 22, 2022, at 11:36 AM, Miquel Raynal wrote:
> > vkorenblit@sequans.com wrote on Thu, 22 Sep 2022 10:18:46 +0200: =20
> >>=20
> >> Correct, this was my initial idea. However, this driver should work
> >> with every architecture or do we limit the scope to arm/arm64/x86_64? =
=20
> >
> > The driver should work on ARM and aarch64, I'm not aware of other
> > architectures with this IP.
> >
> > The driver should compile when COMPILE_TEST=3Dy. =20
>=20
> It should also be written in a way that makes it plausible to
> use elsewhere. Since this is just a licensed IP core, there is
> a good chance that someone reused it on mips or riscv, or
> anything else.

Fair enough.

> >> >> I believe what Valentin wanted to achieve in the first place, was to
> >> >> use 64-bit accesses when relevant (otherwise it does not work).   =
=20
> >> > The width is read from a device specific register at
> >> > runtime, it is not related to the architecture you are
> >> > running on, presumably this is hardwired during the
> >> > design of an SoC, based on the capabilities of the DMA
> >> > engine: =20
> >
> > Well, yes, but in the mean time 64-bit DMA width will never be
> > used on 32-bit platforms. =20
>=20
> Why? Most architectures (including x86 and arm) allow you to
> run a 32-bit kernel on a 64-bit SoC. While this is almost always
> a bad idea to actually do, a driver should be written to
> work correctly in this setup.

Oh right, I forgot about that.

> >> > This usually means the largest access that is valid for
> >> > reading from the FIFO, but usually smaller accesses work
> >> > as well, just slower.   =20
> >
> > Mmh, ok, that's interesting, thanks for the pointer.
> >
> > But in the mean time I am only half satisfied, because we plan to do
> > twice more accesses than needed _just_ because of a the COMPILE_TEST
> > constraint. =20
>=20
> In my example, I had an #ifdef so it would only fall back
> to 32-bit accesses on the 64-bit register when running an
> actual 32-bit kernel, but leaving the 64-bit case efficient.

All right, thanks for all your valuable feedback Arnd!

Cheers,
Miqu=C3=A8l
