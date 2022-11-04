Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B876661A142
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 20:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiKDTlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 15:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKDTlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 15:41:03 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BED09B11
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 12:41:02 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id b21so5802262plc.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 12:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xTleQU4VJfAukQnxKaDYAnGqK2WphhJc8fFwPIDZB8o=;
        b=msmwpF6Ois8LGAEpwDgc+v1z3O9zPF/gToUCKqHVslP3hhHCt/dUr3MBgaajqYY8+r
         v8IHIH33Nb8tZyr5wzF1Z1u4/02bw3vX6jbPl/qjsYR+o3kurpTnt8kUpMPNspaplUPj
         EIS1wt0Z83toaM+v3HO8zDdOzYakLB7A3sIXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xTleQU4VJfAukQnxKaDYAnGqK2WphhJc8fFwPIDZB8o=;
        b=HBpdgEy++9WEKMKRLtaz8TOZA0sueh6XV0SkihIyUO35cmkpAbyMKtA+nTMjwYjYkJ
         T9Kt33z1o9hi2XBt6nNmj8tdxKaJtYYyMx/Fesf8GyBaAg2est2vJN5Mnct1KieVyRJ4
         m593R57OpJYP9qrTyf7r04FzzDK/mVVzwlUmnnaXEO48kl1CEMkUqsKey2ANmZT6w0AF
         Sk7UlLgJFo2Xn1SwDSNVd0GTT4cZqbdTZUlm7vOCzwWct4XoWNi+pCpftEuD1D+dCfxX
         YoxSOIMZLnZ3T98GLoIV4iR3GerKMGg4hQXh7ZoZED5l9cT0MIoyB7f8SYy/PPr5d5w5
         4A2w==
X-Gm-Message-State: ACrzQf2HKmzwcCn+NlxIv/Nzjhgw8yLAmu9gFzrgwEnZBCffJlyhG2Sk
        KeYyCtGZVRDNpcTfuDT6lr7HvA==
X-Google-Smtp-Source: AMsMyM5lPZwJMkVoNQNtETbRNTdHQI/XbapUB0H45rWGJXujIBislKOpf8ovzPpaS4yP5yAJByf1Sw==
X-Received: by 2002:a17:902:aa44:b0:186:7a6b:7bbd with SMTP id c4-20020a170902aa4400b001867a6b7bbdmr37459295plr.78.1667590862227;
        Fri, 04 Nov 2022 12:41:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ik12-20020a170902ab0c00b00187197c499asm128906plb.164.2022.11.04.12.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 12:41:01 -0700 (PDT)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Fri, 4 Nov 2022 12:41:01 -0700
To:     Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@gmail.com>,
        amd-gfx@lists.freedesktop.org, Oded Gabbay <oded.gabbay@gmail.com>,
        Jay Cornwall <Jay.Cornwall@amd.com>, Ben Goz <ben.goz@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Kent Russell <kent.russell@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>, Amber Lin <Amber.Lin@amd.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: kfd_parse_subtype_cache(): Memory - corruptions
Message-ID: <202211041239.2B98F280@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This is an experimental semi-automated report about issues detected by
Coverity from a scan of next-20221104 as part of the linux-next scan project:
https://scan.coverity.com/projects/linux-next-weekly-scan

You're getting this email because you were associated with the identified
lines of code (noted below) that were touched by commits:

  Fri Dec 8 23:08:59 2017 -0500
    3a87177eb141 ("drm/amdkfd: Add topology support for dGPUs")

Coverity reported the following:

*** CID 1527133:  Memory - corruptions  (OVERRUN)
drivers/gpu/drm/amd/amdkfd/kfd_crat.c:1113 in kfd_parse_subtype_cache()
1107     			props->cache_size = cache->cache_size;
1108     			props->cacheline_size = cache->cache_line_size;
1109     			props->cachelines_per_tag = cache->lines_per_tag;
1110     			props->cache_assoc = cache->associativity;
1111     			props->cache_latency = cache->cache_latency;
1112
vvv     CID 1527133:  Memory - corruptions  (OVERRUN)
vvv     Overrunning array "cache->sibling_map" of 32 bytes by passing it to a function which accesses it at byte offset 63 using argument "64UL". [Note: The source code implementation of the function has been overridden by a builtin model.]
1113     			memcpy(props->sibling_map, cache->sibling_map,
1114     					sizeof(props->sibling_map));
1115
1116     			/* set the sibling_map_size as 32 for CRAT from ACPI */
1117     			props->sibling_map_size = CRAT_SIBLINGMAP_SIZE;
1118

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1527133 ("Memory - corruptions")
Fixes: 3a87177eb141 ("drm/amdkfd: Add topology support for dGPUs")

I'm not sure why this suddenly appeared after 5 years, but the read
over-run looks legit:

struct crat_subtype_cache {
        ...
        uint8_t         sibling_map[CRAT_SIBLINGMAP_SIZE];

#define CRAT_SIBLINGMAP_SIZE    32


struct kfd_cache_properties {
        ...
        uint8_t                 sibling_map[CACHE_SIBLINGMAP_SIZE];

#define CACHE_SIBLINGMAP_SIZE 64

Thanks for your attention!

-- 
Coverity-bot
