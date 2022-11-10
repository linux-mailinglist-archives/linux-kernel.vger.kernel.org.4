Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE513624775
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbiKJQtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbiKJQtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:49:01 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B269FEF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 08:48:19 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so2030966pjl.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 08:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LDJ5GbeH4x/1yjxtjF2BP9FcVDh9qhDYbgp39xw30DM=;
        b=Fe2LrkP4LSaAmzpNbzUlL4Sz8W/ckj87PLB0s4ExV2y1hr/SBDx2aHXMGIHH4Q1HZp
         SlVXRYyU/kLp+VT2nJhpvSEpLp5Gw306usHXiFoSvkdLXpFh1XiL/tfTwivIahCI7ZWT
         lxhf3NYj8/XNq2LoDLiXIqTqCb4OIr0rR5gOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LDJ5GbeH4x/1yjxtjF2BP9FcVDh9qhDYbgp39xw30DM=;
        b=fRkPr53ppjwYMYJ4fbTo1f1cV4kcdrD2b8HNbIVULYGhXpzI8+HWKWPE3l3N73uHhS
         6Y7bxEOiZDsD8eLokqvLASOJdpx8TesbiQPvwWwCn9cOxsFHl7z/rZzrTeKDh1Lv90v6
         EZmkgsGPZIKgSx2NUR1Q93zegM03Bv1akMq1IAlAk5Wftt6PpPS+8AJtOe4i71MiS5FW
         UCqjvHXJprWIlZAoi3yLQNYQ+DlOGGfl1nApNeBfB9B52EnBDGBMRWx0AZIf0yAAVuMq
         2Vu3S2YI8cUrX8/WjoTMCt5kUHSt05DI8iioL70V801tSj+r1MeEvM9BnRzKkpb3zycw
         /mYw==
X-Gm-Message-State: ACrzQf3HRgAA/GveZko3qFNaa73N6G1nkGO28Y/DURkpeRvaqU8FmufC
        Hn74hrXlG69kqiLvPGJJvEQV8A==
X-Google-Smtp-Source: AMsMyM5L7JASpAto4IfQ834QGHOPC/E4fFSGlP1B6IiNOx5M0h4LxXrBlQ6jL1GcB0G62qrRYLVm/w==
X-Received: by 2002:a17:902:d503:b0:187:19c4:f9db with SMTP id b3-20020a170902d50300b0018719c4f9dbmr58312424plg.82.1668098898782;
        Thu, 10 Nov 2022 08:48:18 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id om15-20020a17090b3a8f00b00213c7cf21c0sm50871pjb.5.2022.11.10.08.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:48:18 -0800 (PST)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Thu, 10 Nov 2022 08:48:17 -0800
To:     Ben Skeggs <bskeggs@redhat.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        Lyude Paul <lyude@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        Jani Nikula <jani.nikula@intel.com>,
        Dave Airlie <airlied@redhat.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: nv50_sor_atomic_enable(): Memory - corruptions
Message-ID: <202211100848.FFBA2432@keescook>
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

  Wed Nov 9 08:22:02 2022 +1000
    813443721331 ("drm/nouveau/disp: move DP link config into acquire")

Coverity reported the following:

*** CID 1527269:  Memory - corruptions  (OVERRUN)
drivers/gpu/drm/nouveau/dispnv50/disp.c:1619 in nv50_sor_atomic_enable()
1613     				lvds_8bpc = true;
1614     		}
1615
1616     		nvif_outp_acquire_lvds(&nv_encoder->outp, lvds_dual, lvds_8bpc);
1617     		break;
1618     	case DCB_OUTPUT_DP:
vvv     CID 1527269:  Memory - corruptions  (OVERRUN)
vvv     Overrunning array "(*nv_encoder).dp.dpcd" of 15 bytes by passing it to a function which accesses it at byte offset 15.
1619     		nvif_outp_acquire_dp(&nv_encoder->outp, nv_encoder->dp.dpcd, 0, 0, hda, false);
1620     		depth = nv50_dp_bpc_to_depth(asyh->or.bpc);
1621
1622     		if (nv_encoder->outp.or.link & 1)
1623     			proto = NV887D_SOR_SET_CONTROL_PROTOCOL_DP_A;
1624     		else

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527269 ("Memory - corruptions")
Fixes: 813443721331 ("drm/nouveau/disp: move DP link config into acquire")

Thanks for your attention!

-- 
Coverity-bot
