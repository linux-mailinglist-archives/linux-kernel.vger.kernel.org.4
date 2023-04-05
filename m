Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4BAF6D83EB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbjDEQlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbjDEQlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:41:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A92E75
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 09:41:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C51A62A73
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 16:41:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383CDC433EF;
        Wed,  5 Apr 2023 16:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680712870;
        bh=DV0/yjdD/+FEcW0k9WYhDje1AP1oYkbQXJY73iIbEvo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=giYLlI6EETXpR4/c/J+NZDFti5eGPMXnL6nscnQvcZ8jeUSYsW1ZEGGF0czEZS22d
         /r4CLg1kygBtLNHI+7wzGWnyahOQGSZx3F1jDEZdUKNCgPdS16gP3gYlqKIx3PfY69
         s6L/US5Ybq3zUF6uEaT3SQSLZVnqFGyNFDpe5LCYHT6MbWrQS3e23pVfOGMKIgxTgX
         ircGp63ITTW4MY6W9Whg7k+PWvnLYEjRL86gNGUffCcDrU0zpi929kilLSyzpSvwEK
         HTFl5T0Oo4KC2SV5vhA96xXfpAKScaHHyhDI+J6Mef5Tq8WxkC3UBc2gLzVYY/hGYC
         v792PEs4N65UA==
Date:   Wed, 5 Apr 2023 17:41:05 +0100
From:   Lee Jones <lee@kernel.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 01/19] drm/i915/i915_scatterlist: Fix kerneldoc
 formatting issue - missing '@'
Message-ID: <20230405164105.GU8371@google.com>
References: <20230331092607.700644-1-lee@kernel.org>
 <20230331092607.700644-2-lee@kernel.org>
 <87jzyt0yil.fsf@intel.com>
 <20230403162059.GC8371@google.com>
 <878rf80ynz.fsf@intel.com>
 <20230405134526.GE8371@google.com>
 <87jzyqz52y.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jzyqz52y.fsf@intel.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Apr 2023, Jani Nikula wrote:

> On Wed, 05 Apr 2023, Lee Jones <lee@kernel.org> wrote:
> > On Tue, 04 Apr 2023, Jani Nikula wrote:
> >
> >> On Mon, 03 Apr 2023, Lee Jones <lee@kernel.org> wrote:
> >> > On Mon, 03 Apr 2023, Jani Nikula wrote:
> >> >
> >> >> On Fri, 31 Mar 2023, Lee Jones <lee@kernel.org> wrote:
> >> >> > Fixes the following W=1 kernel build warning(s):
> >> >> >
> >> >> >  drivers/gpu/drm/i915/i915_scatterlist.c:62: warning: Function parameter or member 'size' not described in 'i915_refct_sgt_init'
> >> >> >
> >> >> > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> >> >> > Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> >> >> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> >> >> > Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
> >> >> > Cc: David Airlie <airlied@gmail.com>
> >> >> > Cc: Daniel Vetter <daniel@ffwll.ch>
> >> >> > Cc: intel-gfx@lists.freedesktop.org
> >> >> > Cc: dri-devel@lists.freedesktop.org
> >> >> > Signed-off-by: Lee Jones <lee@kernel.org>
> >> >>
> >> >> Thanks for the patches!
> >> >>
> >> >> Applied all but one of the drm/i915 patches to drm-intel-next or
> >> >> drm-intel-gt-next depending on the area. There were a couple of issues
> >> >> that I fixed while applying. There was a conflict with patch 5/19
> >> >> against drm-intel-gt-next so I left that one out.
> >> >
> >> > Thanks Jani.  I'll rebase and see what's left.
> >>
> >> We also took notice and aim to track this more aggressively [1].
> >
> > Thanks.
> >
> > I did clean-up all of the GPU warnings already a couple of years ago,
> > but they seem to have crept back over time.  It would be great if we
> > could put some extra checks in place to prevent them in the future.
>
> We are pretty zealous about warnings in general in i915. We have a bunch
> of extra warnings in our local Makefile and use -Werror in
> development. Inspired by this series, we added kernel-doc check to the
> build, and hope to add kernel-doc -Werror too once we're done.

Sounds good that you're on it.  At least in your part of GPU.

kernel-doc warnings are surfaced by enabling W=1.

> > My aim, albeit ambitious, is to clean-up all of the W=1 warnings in the
> > kernel, then have them promoted to W=0, so they warn more loudly during
> > development, thus keeping them from reappearing.
>
> I wish it was easier to do the equivalent of W=1 on a driver or Makefile
> basis. I like to keep i915 clean, but I don't like to use W=1 because
> there are just so many warnings currently.

Well that's what I hope to improve (again). :)

> The other alternative is fixing and moving extra warnings from W=1 to
> W=0 one by one.

Right, that's where I'd like to end up eventually.

--
Lee Jones [李琼斯]
