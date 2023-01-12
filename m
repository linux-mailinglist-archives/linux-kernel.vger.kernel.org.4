Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D796686F1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 23:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239485AbjALW2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 17:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240584AbjALW2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 17:28:18 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996AE3B91C
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 14:25:22 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso25158788pjt.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 14:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bj8YNZYj773EODRUgqHFXApSaiD9KuR4jPUiwE8KcAo=;
        b=oL0l6AyEgEXf+sREiti4ml1oEbzpS6BUwIZVV1G63ij1HTMvCtqAu0LaknGOkfMsGH
         p/UviPcDu2CY4MdRx/VKTKArEYyiHa0vD6NvNJSk92L/L25OeCB3PrdqYpgwro0SHwhv
         +AJvCee9Q7DU6/iL9PyTpgzmxCgdJmDiuD5uA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bj8YNZYj773EODRUgqHFXApSaiD9KuR4jPUiwE8KcAo=;
        b=PdGb0YpijonCtl+8YFLaUdv0F+Y5uVfo+SwW/LkamTdZ4XlFRl3grXudbr86Ov00k/
         qtUEONLWhgo52EjICBnvNLYsuyAjVcPklEXz7aw3gs+P0VaOT3P9dfa+WQ6Gxls9g3JH
         kFVQ71rhtDI5BoEmPTDkS0S689Z6sgNA2MAkrak4fZjKMwKxz2dBhgcG4yFfA6xc9OBH
         ozn+oDYBY00RMEilpTVRmCHneO4is8DBjcukB3qG9nyRzjaXQNyD8M98NxozIhGU9B/S
         kZs+yk6k2OHVdqSH6XLe1/xVv7F8v2TxB7jTMFbwZrlM2WjMOfe6RlFbYjUVH4ojePie
         WWiA==
X-Gm-Message-State: AFqh2kr5L+MK95UBnp/+lp0aDsGYlA+SHwX3uguB8/kr4TbprdJKsNNX
        TMwtQOMXA8dmMxKy2umv4Sabgg==
X-Google-Smtp-Source: AMrXdXtfGsX9cI/jSo6TyoHbQX+mIPNPV0+cKVX+LPemtsSZtxnLciLhyi8qD5itmK1Hq/uY8ur9Ug==
X-Received: by 2002:a17:902:978f:b0:189:6f76:9b61 with SMTP id q15-20020a170902978f00b001896f769b61mr15951500plp.39.1673562322119;
        Thu, 12 Jan 2023 14:25:22 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d8-20020a170903230800b00189ac5a2340sm12710681plh.124.2023.01.12.14.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 14:25:21 -0800 (PST)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Thu, 12 Jan 2023 14:25:21 -0800
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Leo Li <sunpeng.li@amd.com>, Roman Li <roman.li@amd.com>,
        Fangzhi Zuo <Jerry.Zuo@amd.com>,
        hersen wu <hersenxs.wu@amd.com>,
        dri-devel@lists.freedesktop.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: dm_dmub_sw_init(): Incorrect expression
Message-ID: <202301121425.FB249B61B4@keescook>
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
Coverity from a scan of next-20230111 as part of the linux-next scan project:
https://scan.coverity.com/projects/linux-next-weekly-scan

You're getting this email because you were associated with the identified
lines of code (noted below) that were touched by commits:

  Tue Jan 10 14:32:57 2023 -0500
    a7ab345149b8 ("drm/amd/display: Load DMUB microcode during early_init")

Coverity reported the following:

*** CID 1530544:  Incorrect expression  (IDENTICAL_BRANCHES)
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c:1951 in dm_dmub_sw_init()
1945
1946     	switch (adev->ip_versions[DCE_HWIP][0]) {
1947     	case IP_VERSION(2, 1, 0):
1948     		dmub_asic = DMUB_ASIC_DCN21;
1949     		break;
1950     	case IP_VERSION(3, 0, 0):
vvv     CID 1530544:  Incorrect expression  (IDENTICAL_BRANCHES)
vvv     The same code is executed regardless of whether "adev->ip_versions[GC_HWIP][0] == 656128U" is true, because the 'then' and 'else' branches are identical. Should one of the branches be modified, or the entire 'if' statement replaced?
1951     		if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 3, 0))
1952     			dmub_asic = DMUB_ASIC_DCN30;
1953     		else
1954     			dmub_asic = DMUB_ASIC_DCN30;
1955     		break;
1956     	case IP_VERSION(3, 0, 1):

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1530544 ("Incorrect expression")
Fixes: a7ab345149b8 ("drm/amd/display: Load DMUB microcode during early_init")

Thanks for your attention!

-- 
Coverity-bot
