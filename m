Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96B75E9BF2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 10:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233924AbiIZI0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 04:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbiIZI0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 04:26:01 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B26126AE9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 01:26:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A13B4CE1095
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 08:25:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A8BC43470;
        Mon, 26 Sep 2022 08:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664180756;
        bh=App1ZjPH8nkKBwK8Hhjqf0mfR2s8++nd8clCs0X/edI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qxxJdB5QU2RfOjTWBoZ63EhYxEYw326xMhU+YxYSrEkbdhAv/Avr6uKiT9iZZs7nE
         F8ELI+H8nVVHB4YoHTa0Qa1dZAr1OPF8G+N/muNxMgn+lM4hVHoBiQag49PIq421xM
         abc5j6+D30N/JqptqcFV2wxTuQNS6k30R2nT1yHNpSNYU9YHfOfbkKP55bdCFwp/Xd
         xf8UiT5zat7955XASia1noCEGiRUs+NM4URexoifb6q+K66tAiUDvY/tzxCH65e7qX
         sngqrF6PnbGHE6dBoQFSuzbFyyOwLr04q4jKufTEL6cEI4ghWOO0CWoujPIV9RP+g6
         ueqFLwtuzlPMQ==
Date:   Mon, 26 Sep 2022 10:25:51 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Matt Roper <matthew.d.roper@intel.com>
Cc:     David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Alan Previn <alan.previn.teres.alexis@intel.com>,
        intel-gfx@lists.freedesktop.org,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [Intel-gfx] [PATCH v3 19/37] drm/i915: stop using kernel-doc
 markups for something else
Message-ID: <20220926102551.55278f31@coco.lan>
In-Reply-To: <Yx9qCCmxnSM06CgH@mdroper-desk1.amr.corp.intel.com>
References: <cover.1662708705.git.mchehab@kernel.org>
        <6405f00c4ba03987abf7635f4c62d86b40a0e521.1662708705.git.mchehab@kernel.org>
        <Yx9LxciaH/y8fnRD@mdroper-desk1.amr.corp.intel.com>
        <20220912184756.61492ad1@coco.lan>
        <Yx9qCCmxnSM06CgH@mdroper-desk1.amr.corp.intel.com>
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

Em Mon, 12 Sep 2022 10:19:04 -0700
Matt Roper <matthew.d.roper@intel.com> escreveu:

> > Those *appear* to be kernel-doc markups, but they aren't, because
> > the structs themselves are not properly marked. See, for instance
> > struct intel_context.
> > 
> > scripts/kerneldoc will *only* consider what's there as a proper
> > comment if you add:
> > 
> > 	/**
> > 	 * struct intel_context - describes an i915 context
> > 	 * <add a proper description for it>
> > 	 */
> > 	struct intel_context {
> > 		union {
> > 			/** @ref: a kernel object reference */
> > 	                struct kref ref; /* no kref_get_unless_zero()! */
> > 			/** @rcu: a rcu header */
> > 	                struct rcu_head rcu;
> > 	        };
> > 		...
> > 	}
> > 
> > Describing all fields inside the struct. Just placing
> > 	/** something */
> > on some random places in the middle doesn't make it a kernel-doc.  
> 
> Right, what we have today is incomplete/incorrect.  But I think we
> should be fixing that by adding the missing documentation on the
> structure, rather than giving up and removing the kerneldoc.  The end
> goal should be to have proper generated documentation, not just silence
> the warnings while leaving the actual output incomplete.

The end goal is to have *real* kernel-doc markups, not fake ones.
We're aiming towards there, where the first step is to get rid of the
ones that just pretend to be kernel-doc without really being validated
in order to check if they produce a valid content.

See, what we have so far are just comments. Some examples from this
patch:

	/** Powers down the TV out block, and DAC0-3 */
	 #define CH7017_TV_POWER_DOWN_EN		(1 << 5)

Currently, kernel-doc doesn't have any markup for not-function defines.

What we do to document this at kernel-doc is to either:

1. convert to an enum;
2. embed it inside some struct (or function) definition.

Other examples: this is not a Kernel-doc markup:

	/** @file
	  * driver for the Chrontel 7xxx DVI chip over DVO.
	  */

Neither this:

	/**
 	 * active: Active tracker for the rq activity (inc. external) on this
 	 * intel_context object.
 	 */
 
In summary, what happens is that those "/**" tags removed on this patch are
just pretending to be Kernel-doc, but they aren't anything. See, when a newbie
starts programming in C code, without having a compiler, lots of syntax
issues will happen. When they try to compile their code, hundreds or errors
and warnings happen. That's basically what it is happening here.

See, the very basic syntax thing is missing: just like a C file requires
that all codes to be inside functions, a kernel-doc field description 
requires a kernel-doc markup for the struct/function/enum/union that
contains it.

-

Now, I fully agree that the end goal is to have proper kernel-doc markups.

Adding those require a lot of archaeological work, looking at the git
commits which introduced the changes. Patch 34/37, for instance, does
that for struct drm_i915_gem_object:

	https://lists.freedesktop.org/archives/intel-gfx/2022-September/305736.html

See, besides adding a real Kernel-doc markup for the struct:

	+/**
	+ * struct drm_i915_gem_object - describes an i915 GEM object
	+ */
	 struct drm_i915_gem_object {

It had to fix several sintax and semantic mistakes:

Typos:

	/**
-	 * @shared_resv_from: The object shares the resv from this vm.
+	 * @shares_resv_from: The object shares the resv from this vm.
 	 */

Invalid kernel-doc markups:

	 	/**
	-	 * @mem_flags - Mutable placement-related flags
	+	 * @mem_flags: Mutable placement-related flags

Kernel markups that miss that they're on an embedded struct inside
the main one (thus those are also invalid kernel-doc markups):

                /**
-                * @shrink_pin: Prevents the pages from being made visible to
+                * @mm.shrink_pin: Prevents the pages from being made visible to


Etc.

Thanks,
Mauro
