Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0EAA625659
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbiKKJNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbiKKJN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:13:29 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD63AC12;
        Fri, 11 Nov 2022 01:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668158007; x=1699694007;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=IVJlEJxcaLZjgj4B1SoJxrWJYgVgR68jgWpjx2f8kP0=;
  b=NlG1g9cn7mh4brWCgNfFZUyUSFPK1vYJPt/oH6vUDlLx+Xwzy4ymxdaf
   VBCC47YUfLEtH8Gp+Q2e+u1f+UlrALuvPloyd8PVFK7QSxfYsBQ7wFp5n
   FY/Q8rrHAZgGnhYgu5kmnSETfWTZPh1cjSsT4BsFevjVU+knAN9wwzW/H
   QVrt/7JcHilTAqFNJlKfvYJrC2uutgHowEt3FXfeSWeugwp9k0hR248Mw
   YGjcf0nipbMfAx5ws2nVgfQ09pGTyc+dLyjzU/XIc7ANkCcSscdMVot2r
   57cP4Vypkn5EzL8/gU3IXK92+qUTBF51doxpcf5wKCdQndOBa+YJHyyk9
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="312709452"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="312709452"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 01:13:24 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="706488000"
X-IronPort-AV: E=Sophos;i="5.96,156,1665471600"; 
   d="scan'208";a="706488000"
Received: from ldunne-mobl.ger.corp.intel.com (HELO localhost) ([10.252.15.227])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2022 01:13:19 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     coverity-bot <keescook@chromium.org>, Lyude Paul <lyude@redhat.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, Ilia Mirkin <imirkin@alum.mit.edu>,
        Daniel Vetter <daniel@ffwll.ch>,
        Karol Herbst <kherbst@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@gmail.com>,
        "Nathan E. Egge" <unlord@xiph.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        Dave Airlie <airlied@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: Coverity: nouveau_dp_irq(): Null pointer dereferences
In-Reply-To: <202211100850.7A8DD75@keescook>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <202211100850.7A8DD75@keescook>
Date:   Fri, 11 Nov 2022 11:13:17 +0200
Message-ID: <87iljl6ehe.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Nov 2022, coverity-bot <keescook@chromium.org> wrote:
> Hello!
>
> This is an experimental semi-automated report about issues detected by
> Coverity from a scan of next-20221110 as part of the linux-next scan project:
> https://scan.coverity.com/projects/linux-next-weekly-scan
>
> You're getting this email because you were associated with the identified
> lines of code (noted below) that were touched by commits:
>
>   Mon Aug 31 19:10:08 2020 -0400
>     a0922278f83e ("drm/nouveau/kms/nv50-: Refactor and cleanup DP HPD handling")

Hi Kees, this looks like a good idea, but maybe double check the Cc list
generation? I was Cc'd on four mails today that I thought were
irrelevant to me.

Thanks,
Jani.

>
> Coverity reported the following:
>
> *** CID 1527266:  Null pointer dereferences  (REVERSE_INULL)
> drivers/gpu/drm/nouveau/nouveau_dp.c:237 in nouveau_dp_irq()
> 231     	struct nouveau_encoder *outp = find_encoder(connector, DCB_OUTPUT_DP);
> 232     	struct nouveau_drm *drm = nouveau_drm(outp->base.base.dev);
> 233     	struct nv50_mstm *mstm;
> 234     	u64 hpd = 0;
> 235     	int ret;
> 236
> vvv     CID 1527266:  Null pointer dereferences  (REVERSE_INULL)
> vvv     Null-checking "outp" suggests that it may be null, but it has already been dereferenced on all paths leading to the check.
> 237     	if (!outp)
> 238     		return;
> 239
> 240     	mstm = outp->dp.mstm;
> 241     	NV_DEBUG(drm, "service %s\n", connector->name);
> 242
>
> If this is a false positive, please let us know so we can mark it as
> such, or teach the Coverity rules to be smarter. If not, please make
> sure fixes get into linux-next. :) For patches fixing this, please
> include these lines (but double-check the "Fixes" first):
>
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1527266 ("Null pointer dereferences")
> Fixes: a0922278f83e ("drm/nouveau/kms/nv50-: Refactor and cleanup DP HPD handling")
>
> Thanks for your attention!

-- 
Jani Nikula, Intel Open Source Graphics Center
