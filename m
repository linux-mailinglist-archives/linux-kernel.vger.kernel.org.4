Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E743161376B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 14:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbiJaNIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 09:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbiJaNI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 09:08:26 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3902ADF
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 06:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667221691; x=1698757691;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+6grI54YyHwnooy5K/Se5RAGbjZAcCC4g4XU08B+FhM=;
  b=mt0nd2QaHLyHzpkWx/dy31eSzJAnKh/TlENsNndez/GxOUnSxeLcgdvb
   kWGa26EXbMDCVR9LZ68/xF3jhwOxpy7eOdqIbIRnTBIcbx1sG/fwyLKRu
   Y7M3miMIxQ7a6dewbfhOJA6G9UQsl2Ty0uW5K4c39gTibrZu65/B7Tkmm
   LirWcmFEJlassWwqKcVZ4JxFJYKvyoLDxp1N7l/i6EdnnCnDKcy9r2zl7
   bJmwq0VfBypRpjWZKVA6AeLwRCihyQT3vkAthtsh8V2FYtxmDEL/VXfLd
   z8RHp4DM8FPsdQgSlSIwGBxh6u8nPK6XbM/v8r0F3eWxxPIuegEusROtG
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="289281966"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="289281966"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 06:07:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="628235362"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="628235362"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.191])
  by orsmga007.jf.intel.com with SMTP; 31 Oct 2022 06:07:44 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 31 Oct 2022 15:07:43 +0200
Date:   Mon, 31 Oct 2022 15:07:43 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     jim.cromie@gmail.com
Cc:     Jason Baron <jbaron@akamai.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>, daniel.vetter@ffwll.ch,
        intel-gfx@lists.freedesktop.org, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        seanpaul@chromium.org, dri-devel@lists.freedesktop.org,
        joe@perches.com, intel-gvt-dev@lists.freedesktop.org
Subject: Re: [Intel-gfx] [PATCH v7 0/9] dyndbg: drm.debug adaptation
Message-ID: <Y1/In+ZBzNguVNoy@intel.com>
References: <20220912052852.1123868-1-jim.cromie@gmail.com>
 <Yy7/6oTBW2lqVSK1@kroah.com>
 <Y1Fyuh12g/gt3Izn@intel.com>
 <87a65pfsbq.fsf@intel.com>
 <c1807585-f6c8-c05d-bc20-c6a540e59814@akamai.com>
 <CAJfuBxxWVBxL29sXS3XoE5Es9HTbVyFUi9bQFYNupJAERffAew@mail.gmail.com>
 <Y1qqurH/lG0u+3ky@intel.com>
 <CAJfuBxzpG+C1ARLs3c_znXECEU7Ldg8RhruLMUXA67w+DwcrOQ@mail.gmail.com>
 <Y1rllFeOnT9/PQVA@intel.com>
 <CAJfuBxw_YFvCtHMwVE0K0fa5GJbrZy4hTOSS9FebeDs6fxUUCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJfuBxw_YFvCtHMwVE0K0fa5GJbrZy4hTOSS9FebeDs6fxUUCA@mail.gmail.com>
X-Patchwork-Hint: comment
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2022 at 08:42:52AM -0600, jim.cromie@gmail.com wrote:
> On Thu, Oct 27, 2022 at 2:10 PM Ville Syrjälä
> <ville.syrjala@linux.intel.com> wrote:
> >
> > On Thu, Oct 27, 2022 at 01:55:39PM -0600, jim.cromie@gmail.com wrote:
> > > On Thu, Oct 27, 2022 at 9:59 AM Ville Syrjälä
> > > <ville.syrjala@linux.intel.com> wrote:
> > > >
> > > > On Thu, Oct 27, 2022 at 09:37:52AM -0600, jim.cromie@gmail.com wrote:
> > > > > On Thu, Oct 27, 2022 at 9:08 AM Jason Baron <jbaron@akamai.com> wrote:
> > > > > >
> > > > > >
> > > > > >
> > > > > > On 10/21/22 05:18, Jani Nikula wrote:
> > > > > > > On Thu, 20 Oct 2022, Ville Syrjälä <ville.syrjala@linux.intel.com> wrote:
> > > > > > >> On Sat, Sep 24, 2022 at 03:02:34PM +0200, Greg KH wrote:
> > > > > > >>> On Sun, Sep 11, 2022 at 11:28:43PM -0600, Jim Cromie wrote:
> > > > > > >>>> hi Greg, Dan, Jason, DRM-folk,
> > > > > > >>>>
> > > > > > >>>> heres follow-up to V6:
> > > > > > >>>>   rebased on driver-core/driver-core-next for -v6 applied bits (thanks)
> > > > > > >>>>   rework drm_debug_enabled{_raw,_instrumented,} per Dan.
> > > > > > >>>>
> > > > > > >>>> It excludes:
> > > > > > >>>>   nouveau parts (immature)
> > > > > > >>>>   tracefs parts (I missed --to=Steve on v6)
> > > > > > >>>>   split _ddebug_site and de-duplicate experiment (way unready)
> > > > > > >>>>
> > > > > > >>>> IOW, its the remaining commits of V6 on which Dan gave his Reviewed-by.
> > > > > > >>>>
> > > > > > >>>> If these are good to apply, I'll rebase and repost the rest separately.
> > > > > > >>>
> > > > > > >>> All now queued up, thanks.
> > > > > > >>
> > > > > > >> This stuff broke i915 debugs. When I first load i915 no debug prints are
> > > > > > >> produced. If I then go fiddle around in /sys/module/drm/parameters/debug
> > > > > > >> the debug prints start to suddenly work.
> > > > > > >
> > > > > > > Wait what? I always assumed the default behaviour would stay the same,
> > > > > > > which is usually how we roll. It's a regression in my books. We've got a
> > > > > > > CI farm that's not very helpful in terms of dmesg logging right now
> > > > > > > because of this.
> > > > > > >
> > > > > > > BR,
> > > > > > > Jani.
> > > > > > >
> > > > > > >
> > > > > >
> > > > > > That doesn't sound good - so you are saying that prior to this change some
> > > > > > of the drm debugs were default enabled. But now you have to manually enable
> > > > > > them?
> > > > > >
> > > > > > Thanks,
> > > > > >
> > > > > > -Jason
> > > > >
> > > > >
> > > > > Im just seeing this now.
> > > > > Any new details ?
> > > >
> > > > No. We just disabled it as BROKEN for now. I was just today thinking
> > > > about sending that patch out if no solutin is forthcoming soon since
> > > > we need this working before 6.1 is released.
> > > >
> > > > Pretty sure you should see the problem immediately with any driver
> > > > (at least if it's built as a module, didn't try builtin). Or at least
> > > > can't think what would make i915 any more special.
> > > >
> > >
> > > So, I should note -
> > > 99% of my time & energy on this dyndbg + drm patchset
> > > has been done using virtme,
> > > so my world-view (and dev-hack-test env) has been smaller, simpler
> > > maybe its been fatally simplistic.
> > >
> > > ive just rebuilt v6.0  (before the trouble)
> > > and run it thru my virtual home box,
> > > I didnt see any unfamiliar drm-debug output
> > > that I might have inadvertently altered somehow
> > >
> > > I have some real HW I can put a reference kernel on,0
> > > to look for the missing output, but its all gonna take some time,
> > > esp to tighten up my dev-test-env
> > >
> > > in the meantime, there is:
> > >
> > > config DRM_USE_DYNAMIC_DEBUG
> > > bool "use dynamic debug to implement drm.debug"
> > > default y
> > > depends on DRM
> > > depends on DYNAMIC_DEBUG || DYNAMIC_DEBUG_CORE
> > > depends on JUMP_LABEL
> > > help
> > >   Use dynamic-debug to avoid drm_debug_enabled() runtime overheads.
> > >   Due to callsite counts in DRM drivers (~4k in amdgpu) and 56
> > >   bytes per callsite, the .data costs can be substantial, and
> > >   are therefore configurable.
> > >
> > > Does changing the default fix things for i915 dmesg ?
> >
> > I think we want to mark it BROKEN in addition to make sure no one
> 
> Ok, I get the distinction now.
> youre spelling that
>   depends on BROKEN
> 
> I have a notional explanation, and a conflating commit:
> 
> can you eliminate
> git log -p ccc2b496324c13e917ef05f563626f4e7826bef1
> 
> as the cause ?

Reverting that doesn't help.

> 
> 
> 
> commit ccc2b496324c13e917ef05f563626f4e7826bef1
> Author: Jim Cromie <jim.cromie@gmail.com>
> Date:   Sun Sep 11 23:28:51 2022 -0600
> 
>     drm_print: prefer bare printk KERN_DEBUG on generic fn
> 
>     drm_print.c calls pr_debug() just once, from __drm_printfn_debug(),
>     which is a generic/service fn.  The callsite is compile-time enabled
>     by DEBUG in both DYNAMIC_DEBUG=y/n builds.
> 
>     For dyndbg builds, reverting this callsite back to bare printk is
>     correcting a few anti-features:
> 
>     1- callsite is generic, serves multiple drm users.
>        it is soft-wired on currently by #define DEBUG
>        could accidentally: #> echo -p > /proc/dynamic_debug/control
> 
>     2- optional "decorations" by dyndbg are unhelpful/misleading here,
>        they describe only the generic site, not end users
> 
>     IOW, 1,2 are unhelpful at best, and possibly confusing.
> 
> 
> This shouldnt have turned off any debug of any kind
> (drm.debug nor plain pr_debug)
> 
> but that former callsite no longer does the modname:func:line prefixing
> that could have been in effect and relied upon (tested for) by your CI
> 
> 
> I do need to clarify, I dont know exactly what debug/logging output
> is missing such that CI is failing

CI isn't failing. But any logs it produces are 100% useless,
as are any user reported logs.

The debugs that are missing are anything not coming directly
from drm.ko.

The stuff that I see being printed by i915.ko are drm_info()
and the drm_printer stuff from i915_welcome_messages(). That
also implies that drm_debug_enabled(DRM_UT_DRIVER) does at
least still work correctly.

I suspect that the problem is just that the debug calls
aren't getting patched in when a module loads. And fiddling
with the modparam after the fact does trigger that somehow.

-- 
Ville Syrjälä
Intel
