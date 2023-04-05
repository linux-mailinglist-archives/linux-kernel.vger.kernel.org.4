Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669C16D7DFB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237738AbjDENph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237141AbjDENpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:45:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC7F4699
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 06:45:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B95A63D27
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 13:45:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8CBC4339B;
        Wed,  5 Apr 2023 13:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680702331;
        bh=WN1tlGM8hTcM1BpGhKqRwIyZF6fShF08Oe9D81Xx/vc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=izlUdtyNSs7BmULosGTvf3IbcJWV5GkWoWLeKvC1PyK7FPDFqvm0MG4Vaj3/GbDk6
         bSV0oS/B9fpp9Y8EY9BUs8mJSFf/Ejlapf7fzlaCY3jHtS1NprP09Q4iLlA7u7mB8p
         MYNnQx7sZ+ZAPQrfsTpqmzQ1pSLzq2tus9zABIDLdKGeVVUEd799AcLAj39+FX6YyO
         OLzz0rtaIGIezt/JzO184a7DBbUMxNl+71XvcKy/j79TKl9IhIMYyHWMnkKZH9jPG0
         cyZTSESg9dkLqQeW4el8pgHlLWE1Rcp253LeaDAWVKgmH701FN/ZFl2+S+9Jyy896e
         kV4TabC+is44w==
Date:   Wed, 5 Apr 2023 14:45:26 +0100
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
Message-ID: <20230405134526.GE8371@google.com>
References: <20230331092607.700644-1-lee@kernel.org>
 <20230331092607.700644-2-lee@kernel.org>
 <87jzyt0yil.fsf@intel.com>
 <20230403162059.GC8371@google.com>
 <878rf80ynz.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878rf80ynz.fsf@intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Apr 2023, Jani Nikula wrote:

> On Mon, 03 Apr 2023, Lee Jones <lee@kernel.org> wrote:
> > On Mon, 03 Apr 2023, Jani Nikula wrote:
> >
> >> On Fri, 31 Mar 2023, Lee Jones <lee@kernel.org> wrote:
> >> > Fixes the following W=1 kernel build warning(s):
> >> >
> >> >  drivers/gpu/drm/i915/i915_scatterlist.c:62: warning: Function parameter or member 'size' not described in 'i915_refct_sgt_init'
> >> >
> >> > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> >> > Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> >> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> >> > Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
> >> > Cc: David Airlie <airlied@gmail.com>
> >> > Cc: Daniel Vetter <daniel@ffwll.ch>
> >> > Cc: intel-gfx@lists.freedesktop.org
> >> > Cc: dri-devel@lists.freedesktop.org
> >> > Signed-off-by: Lee Jones <lee@kernel.org>
> >>
> >> Thanks for the patches!
> >>
> >> Applied all but one of the drm/i915 patches to drm-intel-next or
> >> drm-intel-gt-next depending on the area. There were a couple of issues
> >> that I fixed while applying. There was a conflict with patch 5/19
> >> against drm-intel-gt-next so I left that one out.
> >
> > Thanks Jani.  I'll rebase and see what's left.
>
> We also took notice and aim to track this more aggressively [1].

Thanks.

I did clean-up all of the GPU warnings already a couple of years ago,
but they seem to have crept back over time.  It would be great if we
could put some extra checks in place to prevent them in the future.

My aim, albeit ambitious, is to clean-up all of the W=1 warnings in the
kernel, then have them promoted to W=0, so they warn more loudly during
development, thus keeping them from reappearing.

--
Lee Jones [李琼斯]
