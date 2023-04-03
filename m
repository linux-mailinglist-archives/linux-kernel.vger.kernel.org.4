Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB0A6D4D6B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjDCQVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbjDCQVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:21:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C581722
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 09:21:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35B8C62119
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 16:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF45C433EF;
        Mon,  3 Apr 2023 16:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680538864;
        bh=i2Oz7DQi/g/2tldSSt8VII9IwwJ5AoZtoEq5C3Lbu2I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SP0ZkypPTMOPAXytpcdYAnDwP2eVA88IYdfUg/PFKBO2W0Iz7DnJ1Qz5+/RgjlcDs
         ED4jglqlQJsdicClebvoHuvKpFwN986kP1G8WrcoGznB3jk1np4w1mJsUAp5aeSIj+
         iRQOl58ZqboCOoh6cw4P+WNT3LuD7NvOsouLXow8JMMbPa67jz6njID3KzUMUHh5q6
         EIvAynoRbMR5L/NndRWEd6u6CcyXOsbQPMhJPK8bl5ZvK4NDvjeKHupgrEhCMnBovE
         jePKl7FwsUdmkx1zT8mbiRr7t3wIn6W5M9lL3dg5fuoz2iwdnxeU03gVD29RiBGKCF
         Qwzw2I7IS0JOg==
Date:   Mon, 3 Apr 2023 17:20:59 +0100
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
Message-ID: <20230403162059.GC8371@google.com>
References: <20230331092607.700644-1-lee@kernel.org>
 <20230331092607.700644-2-lee@kernel.org>
 <87jzyt0yil.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jzyt0yil.fsf@intel.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 03 Apr 2023, Jani Nikula wrote:

> On Fri, 31 Mar 2023, Lee Jones <lee@kernel.org> wrote:
> > Fixes the following W=1 kernel build warning(s):
> >
> >  drivers/gpu/drm/i915/i915_scatterlist.c:62: warning: Function parameter or member 'size' not described in 'i915_refct_sgt_init'
> >
> > Cc: Jani Nikula <jani.nikula@linux.intel.com>
> > Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
> > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: intel-gfx@lists.freedesktop.org
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Lee Jones <lee@kernel.org>
>
> Thanks for the patches!
>
> Applied all but one of the drm/i915 patches to drm-intel-next or
> drm-intel-gt-next depending on the area. There were a couple of issues
> that I fixed while applying. There was a conflict with patch 5/19
> against drm-intel-gt-next so I left that one out.

Thanks Jani.  I'll rebase and see what's left.

--
Lee Jones [李琼斯]
