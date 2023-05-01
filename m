Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234D56F3032
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 12:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbjEAK3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 06:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbjEAK3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 06:29:36 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF0B135
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 03:29:34 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-2f55ffdbaedso1295015f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 03:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20221208.gappssmtp.com; s=20221208; t=1682936973; x=1685528973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rWWgbJng3QlsGMyIJqreh5oaPIaSgIU51OJYfzdQOEs=;
        b=Parphb/6pDkmvdzTHfBkKhRuyFB2PBQ7wnTzGkzoiSyHwidlGuqZhQOYEpzt2Dnwzq
         MAWgBgYPIkEwtzFC2PgDixd0LijCGaD4BwAAkynUl674eKsVSKKOY8EADXToyaK4EWn0
         W3mUyEcbedVNbYazYflgDeAhnmsJHq9d/WJDDwjQWBYvZz5F5yiTdmVcZJgOVMTAO1CU
         NUI40aeRyGsjAPjF+C2W9G0I4nlAmPyWBNRYB4fDfiHuv4QyzDxPeNqjMIswoApQV1YB
         jH+OUvE71SF4/dMeMeCVOtbS/bbJzzPE1O+kpIAkFcvaPaiN8J9HB+Eqyk7KeHpz4xA2
         tHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682936973; x=1685528973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rWWgbJng3QlsGMyIJqreh5oaPIaSgIU51OJYfzdQOEs=;
        b=k0S0Ud/7E3mds58ZiyKJLIxGBHAif7gZ0MX+w46ODoNwhD9EoPbkcDivwsry6JplL8
         BGaYxcDUFjxFhgkflbESENn8UIMHwkJx0aAOR7IFiiPL9RTVQoHSL4naS/6sMNeGJXio
         4+cbwtWj7Lvw5CflzY4A07KrYBt3K6PCBKreCrJ3nw6soRHNGzO+YOPrDq41W+H8Z6Ra
         nRqnL4VNVMXTlUBMlQumnQ1AGXro+iUWGSOeYMsmXXf6xXGIW0oF7X7F+TKnz71Hl2g1
         EjMNGyizKFeymdQT40C/tuRbzX3HUnpSMCX9S3eoS2wIgvUgZddB2vOZpXNDNzexzC9R
         uoeQ==
X-Gm-Message-State: AC+VfDxGvpUwoFHcEM8WDAWLnCGRgRSPSWeNt8mZy77pWD5dOi5QzqcQ
        5kL+cVsZzaAzu78IWIXuVz2encBvpkTZWUjKftfYdg==
X-Google-Smtp-Source: ACHHUZ4/5DlSz4ZKMdiwfULaU9Jzfkp7OiWVIIfSpb+pzBRWZYW11FoDM126mfYFtjemcBUjFPagMttEJCEYqwgNt1I=
X-Received: by 2002:a5d:5703:0:b0:306:2c01:4f08 with SMTP id
 a3-20020a5d5703000000b003062c014f08mr2844543wrv.21.1682936972778; Mon, 01 May
 2023 03:29:32 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1681898595.git.petr.tesarik.ext@huawei.com>
 <CAHbf0-HwQhFsYW8cp0t9660877b9tTxZBego7VSfx0ayAwKePQ@mail.gmail.com> <20230428110735.4348511d@meshulam.tesarici.cz>
In-Reply-To: <20230428110735.4348511d@meshulam.tesarici.cz>
From:   Mike Lothian <mike@fireburn.co.uk>
Date:   Mon, 1 May 2023 11:29:21 +0100
Message-ID: <CAHbf0-HnctoNN3AQoCeCfd-d7ppKBhWJHD+EbfmbfeTkbS1jqg@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Allow dynamic allocation of software IO TLB bounce buffers
To:     =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
Cc:     Petr Tesarik <petrtesarik@huaweicloud.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Borislav Petkov <bp@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Kim Phillips <kim.phillips@amd.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Muchun Song <muchun.song@linux.dev>,
        Ondrej Zary <linux@zary.sk>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Petr Tesarik <petr.tesarik.ext@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Won Chung <wonchung@google.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I've not had any issues since using this, but I imagine most people
won't know how to set swiotlb=3Ddynamic if they start seeing this (when
it lands)

Any clue as to why this broke last cycle?

Thanks

Mike

On Fri, 28 Apr 2023 at 10:07, Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> wro=
te:
>
> On Fri, 28 Apr 2023 09:53:38 +0100
> Mike Lothian <mike@fireburn.co.uk> wrote:
>
> > On Wed, 19 Apr 2023 at 11:05, Petr Tesarik <petrtesarik@huaweicloud.com=
> wrote:
> > >
> > > From: Petr Tesarik <petr.tesarik.ext@huawei.com>
> > >
> > > The goal of my work is to provide more flexibility in the sizing of
> > > SWIOTLB.
> > >
> > > The software IO TLB was designed with these assumptions:
> > >
> > > 1. It would not be used much, especially on 64-bit systems.
> > > 2. A small fixed memory area (64 MiB by default) is sufficient to
> > >    handle the few cases which require a bounce buffer.
> > > 3. 64 MiB is little enough that it has no impact on the rest of the
> > >    system.
> > >
> > > First, if SEV is active, all DMA must be done through shared
> > > unencrypted pages, and SWIOTLB is used to make this happen without
> > > changing device drivers. The software IO TLB size is increased to
> > > 6% of total memory in sev_setup_arch(), but that is more of an
> > > approximation. The actual requirements may vary depending on the
> > > amount of I/O and which drivers are used. These factors may not be
> > > know at boot time, i.e. when SWIOTLB is allocated.
> > >
> > > Second, other colleagues have noticed that they can reliably get
> > > rid of occasional OOM kills on an Arm embedded device by reducing
> > > the SWIOTLB size. This can be achieved with a kernel parameter, but
> > > determining the right value puts additional burden on pre-release
> > > testing, which could be avoided if SWIOTLB is allocated small and
> > > grows only when necessary.
> > >
> > > Changes from v1-devel-v7:
> > > - Add comments to acquire/release barriers
> > > - Fix whitespace issues reported by checkpatch.pl
> > >
> > > Changes from v1-devel-v6:
> > > - Provide long description of functions
> > > - Fix kernel-doc (Returns: to Return:)
> > > - Rename __lookup_dyn_slot() to lookup_dyn_slot_locked()
> > >
> > > Changes from RFC:
> > > - Track dynamic buffers per device instead of per swiotlb
> > > - Use a linked list instead of a maple tree
> > > - Move initialization of swiotlb fields of struct device to a
> > >   helper function
> > > - Rename __lookup_dyn_slot() to lookup_dyn_slot_locked()
> > > - Introduce per-device flag if dynamic buffers are in use
> > > - Add one more user of DMA_ATTR_MAY_SLEEP
> > > - Add kernel-doc comments for new (and some old) code
> > > - Properly escape '*' in dma-attributes.rst
> > >
> > > Petr Tesarik (7):
> > >   swiotlb: Use a helper to initialize swiotlb fields in struct device
> > >   swiotlb: Move code around in preparation for dynamic bounce buffers
> > >   dma-mapping: introduce the DMA_ATTR_MAY_SLEEP attribute
> > >   swiotlb: Dynamically allocated bounce buffers
> > >   swiotlb: Add a boot option to enable dynamic bounce buffers
> > >   drm: Use DMA_ATTR_MAY_SLEEP from process context
> > >   swiotlb: per-device flag if there are dynamically allocated buffers
> > >
> > >  .../admin-guide/kernel-parameters.txt         |   6 +-
> > >  Documentation/core-api/dma-attributes.rst     |  10 +
> > >  drivers/base/core.c                           |   4 +-
> > >  drivers/gpu/drm/drm_gem_shmem_helper.c        |   2 +-
> > >  drivers/gpu/drm/drm_prime.c                   |   2 +-
> > >  include/linux/device.h                        |  12 +
> > >  include/linux/dma-mapping.h                   |   6 +
> > >  include/linux/swiotlb.h                       |  54 ++-
> > >  kernel/dma/swiotlb.c                          | 382 ++++++++++++++++=
--
> > >  9 files changed, 443 insertions(+), 35 deletions(-)
> > >
> > > --
> > > 2.25.1
> > >
> >
> > Hi
> >
> > Is this a potential fix for
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D217310 where I'm manually
> > setting bigger buffers to keep my wifi working?
>
> Yes. With these patches applied, your system should run just fine with
> swiotlb=3Ddynamic. However, keep in mind that this implementation adds a
> bit of overhead. In short, it trades a bit of performance for not
> having to figure out the optimal swiotlb size at boot time.
>
> Petr T
