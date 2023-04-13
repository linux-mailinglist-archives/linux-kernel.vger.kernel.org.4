Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199FC6E1419
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 20:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjDMSZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 14:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjDMSZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 14:25:35 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E4AAF2D;
        Thu, 13 Apr 2023 11:25:01 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id d1so475219oiw.13;
        Thu, 13 Apr 2023 11:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681410300; x=1684002300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQCnllSH7dJftTfgmLw0TzuSKV0B8nJdoGs2gjaL+i4=;
        b=N6pZLwyscFiPf1D5pZRoS9kQtl4f3jSthuAV/hFZG6acaUdKqRkNFkvrgZTfNfx18r
         J+O0r5kreAQRSZSORRSe/stzKtT3EsIIDjlmmbl/S8771W30VZV8E6jiW1TAfJuldW6a
         59h1TrNtv4rX+0iqkq5m4ovLHEtgkawmYFUDoVFN5jy++vLOPg8/BYthRa2r68AG9dsP
         WPSTWvH/HHBJDR0IS/CLGuvq6oh+lZ5RA7ingTM5oHZ4/lI5M2bBHW/qhxzFxT4e8R6g
         mjMP//s44BQBNez5b88Lq1+WyIUAZxnOuYuAJyxpeYQpalSasoSBRZEqF2T5274JwNNT
         LoMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681410300; x=1684002300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQCnllSH7dJftTfgmLw0TzuSKV0B8nJdoGs2gjaL+i4=;
        b=XgF4lfXta48STrB39x1JGi0ynZiyg0VzFtd6TtbgyW9k2hmp8pn9CkxtrXtNoOXGKk
         16jtO443UO5GW1PhCszhFeZPHH1e/vNwGzT6asRVBjz+cy7weKrappKolsFgIgjHTa3o
         8vz+FE8g3baL3pRAU2WvFb5sVu84lAtE9UeihAXgJx/pSKQJXLjht3vpb9eb6iIJzP21
         QVcZzUzuNF5diKy/EumRPMM05iCTtgs9cjUOWWr9/TqwJ14NplWcBxg9rp2HOSsNgAm3
         xe+AoxSL3ySbi7nPiuPyi6luuEScACcatFkY4ZEBSzRRjrEZdzQkh90OO90aINdHpKBf
         xQWg==
X-Gm-Message-State: AAQBX9ffS9u3Onw4MC95kOfqZDFcdB1p5aXgVB/aC1XMGUvgJy6+aWoG
        +k31HmmX4bDPC1EBYgxr28ZyHh8xlHeRJ2G6PXo=
X-Google-Smtp-Source: AKy350Z3R1cZpqQ5DUGc7rHLGwOILPl+j/ncSvFrW1UKSFd/144WTOdC049sErW5ynp2FdIklif7/8ljxSaHQE3ErZo=
X-Received: by 2002:a05:6808:14f:b0:36e:f6f7:bb1a with SMTP id
 h15-20020a056808014f00b0036ef6f7bb1amr862590oie.5.1681410300524; Thu, 13 Apr
 2023 11:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230411225725.2032862-1-robdclark@gmail.com> <20230411225725.2032862-7-robdclark@gmail.com>
 <29a8d9aa-c6ea-873f-ce0b-fb8199b13068@linux.intel.com> <CAF6AEGsZsMx+Vy+4UQSx3X7w_QNvvjLqWxx=PnCLAOC9f-X2CQ@mail.gmail.com>
 <ZDb1phnddSne79iN@phenom.ffwll.local> <CAF6AEGvBeDVM12ac0j_PKSdcY83hNDhyrQs9-=h=dx_7AoMXLw@mail.gmail.com>
 <ZDcEGoSPGr/oRLas@phenom.ffwll.local> <c82fd8fa-9f4b-f62f-83be-25853f9ecf5e@linux.intel.com>
 <ZDgDQ1PqtXwu8zqA@phenom.ffwll.local> <ad8f2793-c1b3-a505-e93f-6cc52fded86d@linux.intel.com>
In-Reply-To: <ad8f2793-c1b3-a505-e93f-6cc52fded86d@linux.intel.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 13 Apr 2023 11:24:49 -0700
Message-ID: <CAF6AEGtTze668idO-ghyN5PHodk-f2eNc7yuhgett-LuaHLWSQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] drm: Add fdinfo memory stats
To:     Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Christopher Healy <healych@amazon.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 9:40=E2=80=AFAM Tvrtko Ursulin
<tvrtko.ursulin@linux.intel.com> wrote:
>
>
> On 13/04/2023 14:27, Daniel Vetter wrote:
> > On Thu, Apr 13, 2023 at 01:58:34PM +0100, Tvrtko Ursulin wrote:
> >>
> >> On 12/04/2023 20:18, Daniel Vetter wrote:
> >>> On Wed, Apr 12, 2023 at 11:42:07AM -0700, Rob Clark wrote:
> >>>> On Wed, Apr 12, 2023 at 11:17=E2=80=AFAM Daniel Vetter <daniel@ffwll=
.ch> wrote:
> >>>>>
> >>>>> On Wed, Apr 12, 2023 at 10:59:54AM -0700, Rob Clark wrote:
> >>>>>> On Wed, Apr 12, 2023 at 7:42=E2=80=AFAM Tvrtko Ursulin
> >>>>>> <tvrtko.ursulin@linux.intel.com> wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>> On 11/04/2023 23:56, Rob Clark wrote:
> >>>>>>>> From: Rob Clark <robdclark@chromium.org>
> >>>>>>>>
> >>>>>>>> Add support to dump GEM stats to fdinfo.
> >>>>>>>>
> >>>>>>>> v2: Fix typos, change size units to match docs, use div_u64
> >>>>>>>> v3: Do it in core
> >>>>>>>>
> >>>>>>>> Signed-off-by: Rob Clark <robdclark@chromium.org>
> >>>>>>>> Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>
> >>>>>>>> ---
> >>>>>>>>     Documentation/gpu/drm-usage-stats.rst | 21 ++++++++
> >>>>>>>>     drivers/gpu/drm/drm_file.c            | 76 +++++++++++++++++=
++++++++++
> >>>>>>>>     include/drm/drm_file.h                |  1 +
> >>>>>>>>     include/drm/drm_gem.h                 | 19 +++++++
> >>>>>>>>     4 files changed, 117 insertions(+)
> >>>>>>>>
> >>>>>>>> diff --git a/Documentation/gpu/drm-usage-stats.rst b/Documentati=
on/gpu/drm-usage-stats.rst
> >>>>>>>> index b46327356e80..b5e7802532ed 100644
> >>>>>>>> --- a/Documentation/gpu/drm-usage-stats.rst
> >>>>>>>> +++ b/Documentation/gpu/drm-usage-stats.rst
> >>>>>>>> @@ -105,6 +105,27 @@ object belong to this client, in the respec=
tive memory region.
> >>>>>>>>     Default unit shall be bytes with optional unit specifiers of=
 'KiB' or 'MiB'
> >>>>>>>>     indicating kibi- or mebi-bytes.
> >>>>>>>>
> >>>>>>>> +- drm-shared-memory: <uint> [KiB|MiB]
> >>>>>>>> +
> >>>>>>>> +The total size of buffers that are shared with another file (ie=
. have more
> >>>>>>>> +than a single handle).
> >>>>>>>> +
> >>>>>>>> +- drm-private-memory: <uint> [KiB|MiB]
> >>>>>>>> +
> >>>>>>>> +The total size of buffers that are not shared with another file=
.
> >>>>>>>> +
> >>>>>>>> +- drm-resident-memory: <uint> [KiB|MiB]
> >>>>>>>> +
> >>>>>>>> +The total size of buffers that are resident in system memory.
> >>>>>>>
> >>>>>>> I think this naming maybe does not work best with the existing
> >>>>>>> drm-memory-<region> keys.
> >>>>>>
> >>>>>> Actually, it was very deliberate not to conflict with the existing
> >>>>>> drm-memory-<region> keys ;-)
> >>>>>>
> >>>>>> I wouldn't have preferred drm-memory-{active,resident,...} but it
> >>>>>> could be mis-parsed by existing userspace so my hands were a bit t=
ied.
> >>>>>>
> >>>>>>> How about introduce the concept of a memory region from the start=
 and
> >>>>>>> use naming similar like we do for engines?
> >>>>>>>
> >>>>>>> drm-memory-$CATEGORY-$REGION: ...
> >>>>>>>
> >>>>>>> Then we document a bunch of categories and their semantics, for i=
nstance:
> >>>>>>>
> >>>>>>> 'size' - All reachable objects
> >>>>>>> 'shared' - Subset of 'size' with handle_count > 1
> >>>>>>> 'resident' - Objects with backing store
> >>>>>>> 'active' - Objects in use, subset of resident
> >>>>>>> 'purgeable' - Or inactive? Subset of resident.
> >>>>>>>
> >>>>>>> We keep the same semantics as with process memory accounting (if =
I got
> >>>>>>> it right) which could be desirable for a simplified mental model.
> >>>>>>>
> >>>>>>> (AMD needs to remind me of their 'drm-memory-...' keys semantics.=
 If we
> >>>>>>> correctly captured this in the first round it should be equivalen=
t to
> >>>>>>> 'resident' above. In any case we can document no category is equa=
l to
> >>>>>>> which category, and at most one of the two must be output.)
> >>>>>>>
> >>>>>>> Region names we at most partially standardize. Like we could say
> >>>>>>> 'system' is to be used where backing store is system RAM and othe=
rs are
> >>>>>>> driver defined.
> >>>>>>>
> >>>>>>> Then discrete GPUs could emit N sets of key-values, one for each =
memory
> >>>>>>> region they support.
> >>>>>>>
> >>>>>>> I think this all also works for objects which can be migrated bet=
ween
> >>>>>>> memory regions. 'Size' accounts them against all regions while fo=
r
> >>>>>>> 'resident' they only appear in the region of their current placem=
ent, etc.
> >>>>>>
> >>>>>> I'm not too sure how to rectify different memory regions with this=
,
> >>>>>> since drm core doesn't really know about the driver's memory regio=
ns.
> >>>>>> Perhaps we can go back to this being a helper and drivers with vra=
m
> >>>>>> just don't use the helper?  Or??
> >>>>>
> >>>>> I think if you flip it around to drm-$CATEGORY-memory{-$REGION}: th=
en it
> >>>>> all works out reasonably consistently?
> >>>>
> >>>> That is basically what we have now.  I could append -system to each =
to
> >>>> make things easier to add vram/etc (from a uabi standpoint)..
> >>>
> >>> What you have isn't really -system, but everything. So doesn't really=
 make
> >>> sense to me to mark this -system, it's only really true for integrate=
d (if
> >>> they don't have stolen or something like that).
> >>>
> >>> Also my comment was more in reply to Tvrtko's suggestion.
> >>
> >> Right so my proposal was drm-memory-$CATEGORY-$REGION which I think al=
igns
> >> with the current drm-memory-$REGION by extending, rather than creating
> >> confusion with different order of key name components.
> >
> > Oh my comment was pretty much just bikeshed, in case someone creates a
> > $REGION that other drivers use for $CATEGORY. Kinda Rob's parsing point=
.
> > So $CATEGORY before the -memory.
> >
> > Otoh I don't think that'll happen, so I guess we can go with whatever m=
ore
> > folks like :-) I don't really care much personally.
>
> Okay I missed the parsing problem.
>
> >> AMD currently has (among others) drm-memory-vram, which we could defin=
e in
> >> the spec maps to category X, if category component is not present.
> >>
> >> Some examples:
> >>
> >> drm-memory-resident-system:
> >> drm-memory-size-lmem0:
> >> drm-memory-active-vram:
> >>
> >> Etc.. I think it creates a consistent story.
> >>
> >> Other than this, my two I think significant opens which haven't been
> >> addressed yet are:
> >>
> >> 1)
> >>
> >> Why do we want totals (not per region) when userspace can trivially
> >> aggregate if they want. What is the use case?
> >>
> >> 2)
> >>
> >> Current proposal limits the value to whole objects and fixates that by
> >> having it in the common code. If/when some driver is able to support s=
ub-BO
> >> granularity they will need to opt out of the common printer at which p=
oint
> >> it may be less churn to start with a helper rather than mid-layer. Or =
maybe
> >> some drivers already support this, I don't know. Given how important V=
M BIND
> >> is I wouldn't be surprised.
> >
> > I feel like for drivers using ttm we want a ttm helper which takes care=
 of
> > the region printing in hopefully a standard way. And that could then al=
so
> > take care of all kinds of of partial binding and funny rules (like mayb=
e
> > we want a standard vram region that addds up all the lmem regions on
> > intel, so that all dgpu have a common vram bucket that generic tools
> > understand?).
>
> First part yes, but for the second I would think we want to avoid any
> aggregation in the kernel which can be done in userspace just as well.
> Such total vram bucket would be pretty useless on Intel even since
> userspace needs to be region aware to make use of all resources. It
> could even be counter productive I think - "why am I getting out of
> memory when half of my vram is unused!?".
>
> > It does mean we walk the bo list twice, but *shrug*. People have been
> > complaining about procutils for decades, they're still horrible, I thin=
k
> > walking bo lists twice internally in the ttm case is going to be ok. If
> > not, it's internals, we can change them again.
> >
> > Also I'd lean a lot more towards making ttm a helper and not putting th=
at
> > into core, exactly because it's pretty clear we'll need more flexibilit=
y
> > when it comes to accurate stats for multi-region drivers.
>
> Exactly.

It could also be that the gem->status() fxn is extended to return
_which_ pool that object is in.. but either way, we aren't painting
ourselves into a corner

> > But for a first "how much gpu space does this app use" across everythin=
g I
> > think this is a good enough starting point.
>
> Okay so we agree this would be better as a helper and not in the core.
>
> On the point are keys/semantics good enough as a starting point I am
> still not convinced kernel should aggregate and that instead we should
> start from day one by appending -system (or something) to Rob's proposed
> keys.

I mean, if addition were expensive I might agree about not aggregating ;-)

BR,
-R

> Regards,
>
> Tvrtko
