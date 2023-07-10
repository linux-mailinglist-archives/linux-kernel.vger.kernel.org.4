Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D575C74E0FC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 00:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjGJWYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 18:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjGJWYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 18:24:01 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC5B1BC
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 15:23:58 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-307d58b3efbso4964043f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 15:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20221208.gappssmtp.com; s=20221208; t=1689027837; x=1691619837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k+uRSZaNW94drRfaP5L/VJThT+qbzWt+a4m0PC1+H4c=;
        b=BGJwtu/eYDeeRz6gd9DW/1dlrKmdKTY5LkPMrD8VqiQjMxN7JoO9VdAeSxsct2N1AA
         RHztHsO/Ag4ji7+SPc/aVGU+ioISxQDSctgi4qfPKB/qChuM1/SUco0pTqNmKQbWdbyo
         7fDfQpW7AE7IIJpAdBuwj+QuXBAiNXIjBDr73NztsSaHYezINnldgNhJBcd0qYW5vmEY
         +4G/hVixr3YySmX+NrwspZKpNocBFDbfCCAZadUYle20SqmBqPXX91t6M23ZcsnE/P09
         wEEBJYThW/kn39pNb0v7acrw5izKLcx3fgmiSgQ3Y9cAMSokLMrSpnv6a5acp4nvaACs
         GFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689027837; x=1691619837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+uRSZaNW94drRfaP5L/VJThT+qbzWt+a4m0PC1+H4c=;
        b=M7OawgJDMQF7n0/48U5w6fJAjs+je7vqXGmcQsu444B+R5QBNuVNu5UDUuSbt7tx0s
         w0hpjOlBVl+rwF8WExcOQF+ahd1Unr2hXXp7VLkvIeeeKoc/KX9yBa5n5jLXfzXyFNtU
         j19PTC19Cc+RSwqGAJlWQ+naXyyccUSF1ZE0SPUMDA8B0cCnPvWtKjlzbxsJbdgKW27c
         ZWkc5WHk8xADrjpcZHR/RAzZ5xs4quu8CD7UP/PViEDHKgwi8s9/FaTNGgpl/ufAnbNc
         0egjUNAPcjAL4EhPZOYD8wHZ/QwNoNy9tVmKwWPvAa95kD2Qb1/AZLKuIGV5O/nSS9vA
         HIzA==
X-Gm-Message-State: ABy/qLaETWH/O0nATKycsMs5xgVUl67SL6xJPr55E164HD+YLyOdry0P
        GWuRDPQqh7mymZs3AigkKKZ+jzfrNyBsS0KDWRYm3A==
X-Google-Smtp-Source: APBJJlGWtw8f4A2ctcC8tl3oCSE31f33fxmAUGJnr4OHt+wZ4ekqgW0g26gHvys0bWgym34SFWrWokUD9oDJHrFTQP0=
X-Received: by 2002:a5d:614b:0:b0:314:7487:96a3 with SMTP id
 y11-20020a5d614b000000b00314748796a3mr10923400wrt.52.1689027836873; Mon, 10
 Jul 2023 15:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1681898595.git.petr.tesarik.ext@huawei.com>
 <20230426141520.0caf4386@meshulam.tesarici.cz> <2023042617-wobble-enlighten-9361@gregkh>
 <20230426144439.5674f8bc@meshulam.tesarici.cz> <20230509091635.27450bd9@meshulam.tesarici.cz>
 <2023050949-grueling-verify-a43b@gregkh>
In-Reply-To: <2023050949-grueling-verify-a43b@gregkh>
From:   Mike Lothian <mike@fireburn.co.uk>
Date:   Mon, 10 Jul 2023 23:23:45 +0100
Message-ID: <CAHbf0-HY0-u4MwgU39b53hjOM+bWfGmOEYQuvHARjV+6j+O7Kg@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Allow dynamic allocation of software IO TLB bounce buffers
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Muchun Song <muchun.song@linux.dev>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        Kim Phillips <kim.phillips@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
        Borislav Petkov <bp@suse.de>, Won Chung <wonchung@google.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Tesarik <petr.tesarik.ext@huawei.com>,
        Kees Cook <keescook@chromium.org>, Ondrej Zary <linux@zary.sk>,
        Petr Tesarik <petrtesarik@huaweicloud.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        open list <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I was hoping this might land for 6.5-rc1, is there a new version that
might apply against 6.5?

Cheers

Mike

On Tue, 9 May 2023 at 08:32, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, May 09, 2023 at 09:16:35AM +0200, Petr Tesa=C5=99=C3=ADk wrote:
> > On Wed, 26 Apr 2023 14:44:39 +0200
> > Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> wrote:
> >
> > > Hi Greg,
> > >
> > > On Wed, 26 Apr 2023 14:26:36 +0200
> > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > >
> > > > On Wed, Apr 26, 2023 at 02:15:20PM +0200, Petr Tesa=C5=99=C3=ADk wr=
ote:
> > > > > Hi,
> > > > >
> > > > > On Wed, 19 Apr 2023 12:03:52 +0200
> > > > > Petr Tesarik <petrtesarik@huaweicloud.com> wrote:
> > > > >
> > > > > > From: Petr Tesarik <petr.tesarik.ext@huawei.com>
> > > > > >
> > > > > > The goal of my work is to provide more flexibility in the sizin=
g of
> > > > > > SWIOTLB.
> > > > > >
> > > > > > The software IO TLB was designed with these assumptions:
> > > > > >
> > > > > > 1. It would not be used much, especially on 64-bit systems.
> > > > > > 2. A small fixed memory area (64 MiB by default) is sufficient =
to
> > > > > >    handle the few cases which require a bounce buffer.
> > > > > > 3. 64 MiB is little enough that it has no impact on the rest of=
 the
> > > > > >    system.
> > > > > >
> > > > > > First, if SEV is active, all DMA must be done through shared
> > > > > > unencrypted pages, and SWIOTLB is used to make this happen with=
out
> > > > > > changing device drivers. The software IO TLB size is increased =
to
> > > > > > 6% of total memory in sev_setup_arch(), but that is more of an
> > > > > > approximation. The actual requirements may vary depending on th=
e
> > > > > > amount of I/O and which drivers are used. These factors may not=
 be
> > > > > > know at boot time, i.e. when SWIOTLB is allocated.
> > > > > >
> > > > > > Second, other colleagues have noticed that they can reliably ge=
t
> > > > > > rid of occasional OOM kills on an Arm embedded device by reduci=
ng
> > > > > > the SWIOTLB size. This can be achieved with a kernel parameter,=
 but
> > > > > > determining the right value puts additional burden on pre-relea=
se
> > > > > > testing, which could be avoided if SWIOTLB is allocated small a=
nd
> > > > > > grows only when necessary.
> > > > >
> > > > > Now that merging into 6.4 has begun, what about this patch series=
? I'm
> > > > > eager to get some feedback (positive or negative) and respin the =
next
> > > > > version.
> > > >
> > > > It's the merge window, we can't add new things that haven't been in
> > > > linux-next already.
> > >
> > > This is understood. I'm not asking for immediate inclusion.
> > >
> > > >   Please resubmit it after -rc1 is out.
> > >
> > > If you can believe that rebasing to -rc1 will be enough, then I will
> > > also try to believe I'm lucky. ;-)
> > >
> > > The kind of feedback I really want to get is e.g. about the extra
> > > per-device DMA-specific fields. If they cannot be added to struct
> > > device, then I'd rather start discussing an interim solution, because
> > > getting all existing DMA fields out of that struct will take a lot of
> > > time...
> >
> > All right, 6.4-rc1 is out now. The patch series still applies cleanly.
> >
> > Any comments what must be changed (if anything) to get it in?
>
> Try resending it, it's long out of my review queue...
>
> thanks,
>
> greg k-h
