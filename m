Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D5A6624793
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbiKJQuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbiKJQuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:50:13 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587D51400C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 08:50:06 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so2036876pjl.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 08:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZVqd+PvgZXEgpR5oiDP8I3WYALDkF1kwCNnCVwq1mpo=;
        b=KOrM7nTAXpp3ofHwJJRvDPycbrxwy/BUtfmO83XndSZ41PtDxOacBE0DrQFpxytI1Q
         JJCh2k1V7GgfY+6JXBzLBO19fnq0I4c2Jxvx68eO/LtakOsggQNrDZKf2M8qFcI91F9P
         1JIEUsrASBrRow9EergEBIaIRb3VyJeJht5a0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVqd+PvgZXEgpR5oiDP8I3WYALDkF1kwCNnCVwq1mpo=;
        b=bccL0XSihygV8JOvNVhulZZKlyRr7U7+Y3TH3RKPh2E9llofv/Had5M6236uFaUPQD
         AAc9RLYJzqcP5Y+fYvPJJy+F1zGZzMxz4iBRPEBeXCv4efOWc47ceSjr8WlY493/Jo+m
         O6cMGT6F9dFvsaU+7TskPXnYmnQLUVcYOchrI6nrwrFrUgPY0FrLKSbz6eBIw0Zsmnl5
         0yxhV/AZ53OPfcVo7pT4qsQ3bRpTH9IjWcH/kt1YtESCyErzLTpnamDmMzOxsUFSANd/
         ySF4aYaXSg9TP1xKwSRZ5VMmVd19wvA95tOfy0qUjHExdhDkexs/dRNi7AwbiFjlyT9E
         ixpA==
X-Gm-Message-State: ACrzQf3NKcBGIulhxW7gY/G6wsWrRktGGtKGSgxInM3RT9JgaI6YzUiB
        NIMjWNPSUYYRO7/4i2RRoPrXJA==
X-Google-Smtp-Source: AMsMyM68qD69p1bOkhPUXlhFPk3ZndMHRyb1mJfNywAclXB2dk8dtu5d1uueCVKTxNOxV0ehqJ3EmA==
X-Received: by 2002:a17:90b:4d91:b0:213:f1b:dab5 with SMTP id oj17-20020a17090b4d9100b002130f1bdab5mr65253209pjb.95.1668099005884;
        Thu, 10 Nov 2022 08:50:05 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y23-20020a17090264d700b0017f92246e4dsm11375728pli.181.2022.11.10.08.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:50:05 -0800 (PST)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Thu, 10 Nov 2022 08:50:04 -0800
To:     Lyude Paul <lyude@redhat.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, Ilia Mirkin <imirkin@alum.mit.edu>,
        Daniel Vetter <daniel@ffwll.ch>,
        Karol Herbst <kherbst@redhat.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@gmail.com>,
        "Nathan E. Egge" <unlord@xiph.org>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        Jani Nikula <jani.nikula@intel.com>,
        Dave Airlie <airlied@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: nouveau_dp_irq(): Null pointer dereferences
Message-ID: <202211100850.7A8DD75@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This is an experimental semi-automated report about issues detected by
Coverity from a scan of next-20221110 as part of the linux-next scan project:
https://scan.coverity.com/projects/linux-next-weekly-scan

You're getting this email because you were associated with the identified
lines of code (noted below) that were touched by commits:

  Mon Aug 31 19:10:08 2020 -0400
    a0922278f83e ("drm/nouveau/kms/nv50-: Refactor and cleanup DP HPD handling")

Coverity reported the following:

*** CID 1527266:  Null pointer dereferences  (REVERSE_INULL)
drivers/gpu/drm/nouveau/nouveau_dp.c:237 in nouveau_dp_irq()
231     	struct nouveau_encoder *outp = find_encoder(connector, DCB_OUTPUT_DP);
232     	struct nouveau_drm *drm = nouveau_drm(outp->base.base.dev);
233     	struct nv50_mstm *mstm;
234     	u64 hpd = 0;
235     	int ret;
236
vvv     CID 1527266:  Null pointer dereferences  (REVERSE_INULL)
vvv     Null-checking "outp" suggests that it may be null, but it has already been dereferenced on all paths leading to the check.
237     	if (!outp)
238     		return;
239
240     	mstm = outp->dp.mstm;
241     	NV_DEBUG(drm, "service %s\n", connector->name);
242

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527266 ("Null pointer dereferences")
Fixes: a0922278f83e ("drm/nouveau/kms/nv50-: Refactor and cleanup DP HPD handling")

Thanks for your attention!

-- 
Coverity-bot
