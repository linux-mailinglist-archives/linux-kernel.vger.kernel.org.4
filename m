Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B935E9D67
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbiIZJWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233529AbiIZJWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:22:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65566474C7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:19:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F69FB802C8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 09:19:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF7BC433D6;
        Mon, 26 Sep 2022 09:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664183961;
        bh=zokIZXIlwzWBqkPaQXmt40NpJQ0hgwAisoGjIS1cLtE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=onOnhZHPmnMEnhxjLoePqwKXpMITuZWqKeQNkgP1CajCp5fPjNwqdZxivdetEQL2C
         MznLDa8bph60pvZS8/aG5JsFrSONfxCREO7wKTPgUaKPAIGSNuMTh6yRZBvfHNpsgA
         Wlm6GCFrOfGjY5Y/RdDrXjxGPjXh3TO+qI228Cuff6LAEN8TPrs5rdXsY5kUCG3C2c
         9z2QkcX422rsJVX4Se3WYQo/e68tVW8naNp4HmilrGj7Zdi8PI/RJMGnYH/7UDFINx
         gxAoT0yumVmNdomiYiS68Gf377Lu5j+271I+lkGzKoEI2KlawYJLrbHP4DkCtPE9sn
         g2DQhxS3nOgXg==
Date:   Mon, 26 Sep 2022 11:19:16 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc:     David Airlie <airlied@linux.ie>, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [Intel-gfx] [PATCH v3 01/37] drm/i915: fix kernel-doc trivial
 warnings on i915/*.[ch] files
Message-ID: <20220926111916.65a9859e@coco.lan>
In-Reply-To: <2aa5f49e-af83-6368-8db5-e9b33dd19f06@intel.com>
References: <cover.1662708705.git.mchehab@kernel.org>
        <752ce443ea141601cf59a1ad8a5130deed2feb4f.1662708705.git.mchehab@kernel.org>
        <2aa5f49e-af83-6368-8db5-e9b33dd19f06@intel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 16 Sep 2022 17:03:27 +0300
Gwan-gyeong Mun <gwan-gyeong.mun@intel.com> escreveu:

> >   /**
> > - * Called when user space has done writes to this buffer
> > + * i915_gem_sw_finish_ioctl - Called when user space has done writes to
> > + *		this buffer  
> As per this link[1], the brief description does not have a limitation to 
> match the indentation when explained over multiple lines, unlike 
> function parameters.
> 
> [1] 
> https://docs.kernel.org/doc-guide/kernel-doc.html#function-documentation
> 
> Therefore if you look at the function brief description over several 
> lines in i915 and drm,
> 
> One of the drm apis, drm_gem_lock_reservations(), is used without 
> indentation in the form below,
> /**
>   * drm_gem_lock_reservations - Sets up the ww context and acquires
>   * the lock on an array of GEM objects.
> 
> In i915_perf.c, indentation is set as follows.
> 
> /**
>   * gen8_append_oa_reports - Copies all buffered OA reports into
>   *			    userspace read() buffer.
> 
> ...
> 
> /**
>   * gen7_append_oa_reports - Copies all buffered OA reports into
>   *			    userspace read() buffer.
> 
> If there is no problem when using the same form as 
> gen8_append_oa_reports when generating kernel-doc, it seems to be 
> indented to match the existing i915 style. However, if there is a 
> problem, I think you need to remove the indented part of the i915 code 
> like the drm apis.
> 
> except i915_gem_sw_finish_ioctl  i915_gem_gtt_pwrite_fast parts, the 
> rest of the parts look good to me.

There's no rule about either indent or not. IMO, it makes easier for
humans to read when indent is used.

Yet, I'd say that, right now, 50% of multi-line comments within the
kernel has indent. So, it is more like a matter of personal developer's
preference at the moment.

> 
> Reviewed-by: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>

Thanks,
Mauro
