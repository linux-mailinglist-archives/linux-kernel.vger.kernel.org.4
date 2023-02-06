Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF0D68C070
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 15:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjBFOss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 09:48:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjBFOsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 09:48:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1EE1BAF2;
        Mon,  6 Feb 2023 06:48:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6325B811C7;
        Mon,  6 Feb 2023 14:48:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679EFC433A4;
        Mon,  6 Feb 2023 14:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675694921;
        bh=HYdJr2k8xDsH9UDytuxcvFsS8NUtWpMmOCXLy/R0vfY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rnFXM4aISGhBNRn4hSR7eWhrhUqOEbjjg0C59+ZDrMmpa6Z2I+6ozrRA3B3/LaJe7
         l7ensMX+XxaF70p6LE0yuz2OhGFl1TRO3OZdO/SdM6rOYOYCgOANjgFL0UzXqJ8fk9
         jdD8/8lPphHo5p8hX7WNdKxFydlozOzAANzbjpStLNaYJRGJh05lAnThIHisKH/xoh
         8b2+oVcz/19f/Iv/vTSe/PEmm2vZiXoZIgMpHlHrTzmNV4QdhlPFWUj/KFs+vR/+Fs
         o+k9HqBv+NhmKQM17nj1JEjTet1QUV/a0q9wnES2mYnMaVZfZJFfD2ShnrziZQXQgJ
         AlL8iaN2xotAw==
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-527979e8670so71235887b3.10;
        Mon, 06 Feb 2023 06:48:41 -0800 (PST)
X-Gm-Message-State: AO0yUKVRs544xkv7gmFfGxWpMdESa/uvHXloWArv72IJVy3QZQjLcZ8Q
        5fDy01lJ5Vih7NZTm0y6b7+GA0pdgi5h0SB0RNg=
X-Google-Smtp-Source: AK7set8XPchtwOOx5zc+24WB7S/trNyqjWhqIRW0/wKJiCz5RqFF+C1SwTDZZC/hmiQNqmKeHvc18dggdQwMcgaP/lU=
X-Received: by 2002:a81:7c84:0:b0:52a:76d3:27fe with SMTP id
 x126-20020a817c84000000b0052a76d327femr275586ywc.487.1675694920333; Mon, 06
 Feb 2023 06:48:40 -0800 (PST)
MIME-Version: 1.0
References: <db4fa0fc-c9a6-9a48-c45f-1d655b30aff9@amd.com> <02b0bcb8-f69f-93cf-1f56-ec883cb33965@redhat.com>
 <3602500f-05f5-10b8-5ec6-0a6246e2bb6b@amd.com> <bcbef353-f579-4e90-1c77-be36bbe61c0f@redhat.com>
 <CADnq5_PGaXFW-z3gt+R+W+vBVdeuL4wMuMOQh4muxU13Bemy3A@mail.gmail.com>
 <0f2d6e1a-a3b5-f323-a29d-caade427292c@redhat.com> <CADnq5_Nh-1esiHzvTG+qFBCfMjy21efX-YN2jfGG=WC+-4LwLQ@mail.gmail.com>
 <CAPM=9txMZO1uYj+kVdTfmCwV2Fq8uu_b3i4eq4xhqPEPKBW8Eg@mail.gmail.com>
 <7839c47e-6692-b93b-69a8-9584193cb07d@amd.com> <6566870d-6256-8eef-5879-cb13711e4bed@redhat.com>
 <Y8jT1TazLddqZjG4@DUT025-TGLU.fm.intel.com>
In-Reply-To: <Y8jT1TazLddqZjG4@DUT025-TGLU.fm.intel.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Mon, 6 Feb 2023 16:48:13 +0200
X-Gmail-Original-Message-ID: <CAFCwf10BAfg+_JGzyV0Rgx3WHaOR4vv9hvRXm0b0wW9U6tHSOA@mail.gmail.com>
Message-ID: <CAFCwf10BAfg+_JGzyV0Rgx3WHaOR4vv9hvRXm0b0wW9U6tHSOA@mail.gmail.com>
Subject: Re: [PATCH drm-next 00/14] [RFC] DRM GPUVA Manager & Nouveau VM_BIND UAPI
To:     Matthew Brost <matthew.brost@intel.com>
Cc:     Danilo Krummrich <dakr@redhat.com>, tzimmermann@suse.de,
        linux-doc@vger.kernel.org, nouveau@lists.freedesktop.org,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, bskeggs@redhat.com,
        jason@jlekstrand.net, airlied@redhat.com,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 7:24 AM Matthew Brost <matthew.brost@intel.com> wro=
te:
>
> On Thu, Jan 19, 2023 at 05:04:32AM +0100, Danilo Krummrich wrote:
> > On 1/18/23 20:48, Christian K=C3=B6nig wrote:
> > > Am 18.01.23 um 20:17 schrieb Dave Airlie:
> > > > On Thu, 19 Jan 2023 at 02:54, Alex Deucher <alexdeucher@gmail.com> =
wrote:
> > > > > On Wed, Jan 18, 2023 at 11:50 AM Danilo Krummrich
> > > > > <dakr@redhat.com> wrote:
> > > > > >
> > > > > >
> > > > > > On 1/18/23 17:30, Alex Deucher wrote:
> > > > > > > On Wed, Jan 18, 2023 at 11:19 AM Danilo Krummrich
> > > > > > > <dakr@redhat.com> wrote:
> > > > > > > > On 1/18/23 16:37, Christian K=C3=B6nig wrote:
> > > > > > > > > Am 18.01.23 um 16:34 schrieb Danilo Krummrich:
> > > > > > > > > > Hi Christian,
> > > > > > > > > >
> > > > > > > > > > On 1/18/23 09:53, Christian K=C3=B6nig wrote:
> > > > > > > > > > > Am 18.01.23 um 07:12 schrieb Danilo Krummrich:
> > > > > > > > > > > > This patch series provides a new UAPI for the Nouve=
au driver in
> > > > > > > > > > > > order to
> > > > > > > > > > > > support Vulkan features, such as
> > > > > > > > > > > > sparse bindings and sparse
> > > > > > > > > > > > residency.
> > > > > > > > > > > >
> > > > > > > > > > > > Furthermore, with the DRM GPUVA
> > > > > > > > > > > > manager it provides a new DRM core
> > > > > > > > > > > > feature to
> > > > > > > > > > > > keep track of GPU virtual address
> > > > > > > > > > > > (VA) mappings in a more generic way.
> > > > > > > > > > > >
> > > > > > > > > > > > The DRM GPUVA manager is indented to help drivers i=
mplement
> > > > > > > > > > > > userspace-manageable
> > > > > > > > > > > > GPU VA spaces in reference to the Vulkan API. In or=
der to achieve
> > > > > > > > > > > > this goal it
> > > > > > > > > > > > serves the following purposes in this context.
> > > > > > > > > > > >
> > > > > > > > > > > >        1) Provide a dedicated range allocator to tr=
ack GPU VA
> > > > > > > > > > > > allocations and
> > > > > > > > > > > >           mappings, making use of the drm_mm range =
allocator.
> > > > > > > > > > > This means that the ranges are allocated
> > > > > > > > > > > by the kernel? If yes that's
> > > > > > > > > > > a really really bad idea.
> > > > > > > > > > No, it's just for keeping track of the
> > > > > > > > > > ranges userspace has allocated.
> > > > > > > > > Ok, that makes more sense.
> > > > > > > > >
> > > > > > > > > So basically you have an IOCTL which asks kernel
> > > > > > > > > for a free range? Or
> > > > > > > > > what exactly is the drm_mm used for here?
> > > > > > > > Not even that, userspace provides both the base
> > > > > > > > address and the range,
> > > > > > > > the kernel really just keeps track of things.
> > > > > > > > Though, writing a UAPI on
> > > > > > > > top of the GPUVA manager asking for a free range instead wo=
uld be
> > > > > > > > possible by just adding the corresponding wrapper functions=
 to get a
> > > > > > > > free hole.
> > > > > > > >
> > > > > > > > Currently, and that's what I think I read out of
> > > > > > > > your question, the main
> > > > > > > > benefit of using drm_mm over simply stuffing the
> > > > > > > > entries into a list or
> > > > > > > > something boils down to easier collision detection and iter=
ating
> > > > > > > > sub-ranges of the whole VA space.
> > > > > > > Why not just do this in userspace?  We have a range manager i=
n
> > > > > > > libdrm_amdgpu that you could lift out into libdrm or some oth=
er
> > > > > > > helper.
> > > > > > The kernel still needs to keep track of the mappings within the=
 various
> > > > > > VA spaces, e.g. it silently needs to unmap mappings that are ba=
cked by
> > > > > > BOs that get evicted and remap them once they're validated (or =
swapped
> > > > > > back in).
> > > > > Ok, you are just using this for maintaining the GPU VM space in
> > > > > the kernel.
> > > > >
> > > > Yes the idea behind having common code wrapping drm_mm for this is =
to
> > > > allow us to make the rules consistent across drivers.
> > > >
> > > > Userspace (generally Vulkan, some compute) has interfaces that pret=
ty
> > > > much dictate a lot of how VMA tracking works, esp around lifetimes,
> > > > sparse mappings and splitting/merging underlying page tables, I'd
> > > > really like this to be more consistent across drivers, because alre=
ady
> > > > I think we've seen with freedreno some divergence from amdgpu and w=
e
> > > > also have i915/xe to deal with. I'd like to at least have one place
> > > > that we can say this is how it should work, since this is something
> > > > that *should* be consistent across drivers mostly, as it is more ab=
out
> > > > how the uapi is exposed.
> > >
> > > That's a really good idea, but the implementation with drm_mm won't w=
ork
> > > like that.
> > >
> > > We have Vulkan applications which use the sparse feature to create
> > > literally millions of mappings. That's why I have fine tuned the mapp=
ing
>
> Is this not an application issue? Millions of mappings seems a bit
> absurd to me.
If I look at the most extreme case for AI, assuming 256GB of HBM
memory and page mapping of 2MB, we get to 128K of mappings. But that's
really the extreme case imo. I assume most mappings will be much
larger. In fact, in the most realistic scenario of large-scale
training, a single user will probably map the entire HBM memory using
1GB pages.

I have also a question, could this GPUVA code manage VA ranges
mappings for userptr mappings, assuming we work without svm/uva/usm
(pointer-is-a-pointer) ? Because then we are talking about possible
4KB mappings of 1 - 1.5 TB host server RAM (Implied in my question is
the assumption this can be used also for non-VK use-cases. Please tell
me if I'm totally wrong here).

Thanks,
Oded
