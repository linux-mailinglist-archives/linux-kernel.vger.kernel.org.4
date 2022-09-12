Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F275B5E80
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 18:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiILQsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 12:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiILQsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 12:48:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AE52D1EB
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 09:48:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92315B80DC6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 16:48:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80A17C433C1;
        Mon, 12 Sep 2022 16:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663001284;
        bh=h9EV557k36C+3muOY8zImqhUu/m9mCgOybmjNo1zImw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qafsqtfi0zCHhQ1KmtYTb6RXDokkQim0CcYRyPNsl8R/AgdAqgZU5UJYZXoQwd8Gd
         N4H3+JgSVeMTCVm1eV8vNYAJ4GOiOxtwzYbfTLA4wZuM5EeQ1peMKp3dcQ6bV7qKOK
         WQGMU2lWPJGZQi6ubjHbttiJgAbJtD4hti7OuO6jdH0cS75BnFIvTm/iwrKjMJa76w
         AX+sZzOQAt408jIYnrQAytacgTiN6Cvenco+ZMmZCLTZpNsYoueFpvSOZFkYAv7Ms6
         12mxS+Q2ifc/xDP/7XgtT2FVHhafsuALzwAKzk76XReznQJWWbjyFbUzaZPvndGCIt
         qdjxuB/utB45Q==
Date:   Mon, 12 Sep 2022 18:47:56 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Matt Roper <matthew.d.roper@intel.com>
Cc:     Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Alan Previn <alan.previn.teres.alexis@intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Daniel Vetter <daniel@ffwll.ch>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        David Airlie <airlied@linux.ie>,
        Imre Deak <imre.deak@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        John Harrison <John.C.Harrison@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        "Matthew Brost" <matthew.brost@intel.com>,
        Stanislav Lisovskiy <stanislav.lisovskiy@intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
        <dri-devel@lists.freedesktop.org>,
        <intel-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 19/37] drm/i915: stop using kernel-doc markups for
 something else
Message-ID: <20220912184756.61492ad1@coco.lan>
In-Reply-To: <Yx9LxciaH/y8fnRD@mdroper-desk1.amr.corp.intel.com>
References: <cover.1662708705.git.mchehab@kernel.org>
        <6405f00c4ba03987abf7635f4c62d86b40a0e521.1662708705.git.mchehab@kernel.org>
        <Yx9LxciaH/y8fnRD@mdroper-desk1.amr.corp.intel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matt,

Em Mon, 12 Sep 2022 08:09:57 -0700
Matt Roper <matthew.d.roper@intel.com> escreveu:

> > --- a/drivers/gpu/drm/i915/gt/intel_context_types.h
> > +++ b/drivers/gpu/drm/i915/gt/intel_context_types.h  
> 
> Several of the comments in this file do appear to be kerneldoc (in fact
> kerneldoc that was specifically requested during code review at
> https://patchwork.freedesktop.org/patch/448456/#comment_804252) and this
> file is included from Documentation/gpu/i915.rst, so I think some of
> these changes might be moving in the wrong direction.  Should we instead
> focus on fixing up the comments that aren't quite formatted properly?

Those *appear* to be kernel-doc markups, but they aren't, because
the structs themselves are not properly marked. See, for instance
struct intel_context.

scripts/kerneldoc will *only* consider what's there as a proper
comment if you add:

	/**
	 * struct intel_context - describes an i915 context
	 * <add a proper description for it>
	 */
	struct intel_context {
		union {
			/** @ref: a kernel object reference */
	                struct kref ref; /* no kref_get_unless_zero()! */
			/** @rcu: a rcu header */
	                struct rcu_head rcu;
	        };
		...
	}

Describing all fields inside the struct. Just placing
	/** something */
on some random places in the middle doesn't make it a kernel-doc.

If you actually run kernel-doc in Werror mode:

	./scripts/kernel-doc -Werror -sphinx-version 2.4.4 drivers/gpu/drm/i915/gt/intel_context_types.h | echo "ERROR!"
	ERROR!
	drivers/gpu/drm/i915/gt/intel_context_types.h:1: warning: no structured comments found
	1 warnings as Errors

you'll see that this is currently broken.

Thanks,
Mauro
