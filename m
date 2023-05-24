Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF70870F7E1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 15:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbjEXNlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 09:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235338AbjEXNlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 09:41:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCCF19D;
        Wed, 24 May 2023 06:40:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C984A63554;
        Wed, 24 May 2023 13:40:34 +0000 (UTC)
Received: from rdvivi-mobl4 (unknown [192.55.54.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 65486C433D2;
        Wed, 24 May 2023 13:40:31 +0000 (UTC)
Date:   Wed, 24 May 2023 09:40:28 -0400
From:   Rodrigo Vivi <rodrigo.vivi@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Azeem Shaikh <azeemshaikh38@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        linux-hardening@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        John Harrison <John.C.Harrison@intel.com>,
        Matthew Brost <matthew.brost@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
        Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/i915: Replace all non-returning strlcpy with strscpy
Message-ID: <ZG4TzMhh+wwXrCYb@rdvivi-mobl4>
References: <20230522155228.2336755-1-azeemshaikh38@gmail.com>
 <202305221316.2817AA4FC@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202305221316.2817AA4FC@keescook>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 01:16:03PM -0700, Kees Cook wrote:
> On Mon, May 22, 2023 at 03:52:28PM +0000, Azeem Shaikh wrote:
> > strlcpy() reads the entire source buffer first.
> > This read may exceed the destination size limit.
> > This is both inefficient and can lead to linear read
> > overflows if a source string is not NUL-terminated [1].
> > In an effort to remove strlcpy() completely [2], replace
> > strlcpy() here with strscpy().
> > No return values were used, so direct replacement is safe.
> > 
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> > [2] https://github.com/KSPP/linux/issues/89
> > 
> > Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

pushed to drm-intel-next. Thanks for the patch and review.

> 
> -- 
> Kees Cook
