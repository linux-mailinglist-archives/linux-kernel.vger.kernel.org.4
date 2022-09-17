Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3075BB7EB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 12:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiIQKzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 06:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiIQKzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 06:55:10 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC793F1DD
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 03:55:09 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id bq9so39848475wrb.4
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 03:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=qgeFEKmlCeElYtmQhO2NHIF7009WxIJXwGvauIaMgRY=;
        b=jTwbtV+yyd/9MW4yeNhB8fqWF5IfLZXmGqFokfSHdqBzJOpR3tqFM/OzSvmTo85V0s
         oCBbiWbFULuvLd3Hij1urxgaUx5L/BzoUcvud2cNV1gg0IeW62AdIanOsm/pSOaGr3m1
         ZiQoj6MVGNibMNxlPoj3EZViF4QqbCgVXjG/v2oxzwBQ9R23+JcOBaLSaaGFSEbO6Ke5
         KFD1B2PQ92gql3dyP/p43UVBHPDGATa2SaxRt5E+Aw7VVGX26DntFEJhvSL27j/eSAqq
         rjGs4QnRboK5UugvL1SVRVoxcrijYvlgq335VmTBp5CUWOIOh8iZ9r4/+5QjtyM6CNFg
         K70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=qgeFEKmlCeElYtmQhO2NHIF7009WxIJXwGvauIaMgRY=;
        b=UnLEj/PlFoznwRwSeUXh8FbtOrmtt+QwU59V3RXDMbYiWIOD4XbmFnRN/lh3cl0gW2
         BpM4/XloFGHRomhC98vqKIFcu1eLGmoZuRQKQszQu6YYHDnKw96s5iKAfE/woYZVxqYB
         FTy1dcLQOGSj4xi+EUW2qGQyaxCd49EnixLUAjNeA+7sgm7rWvNZR1C8neIZCQxe/wCG
         bAYfKazWS6xRgQZMM8bx8rq4AeuJogh2bu3hDzLqo0/aI9+PwBzPyo5xlBMnpSj3kGZn
         pZsxj4C7P95DqcEiR69IiIgDENFc13WVWT8YtZWG/4VJosRSlDdnnMHGfSF0UdmEmnG/
         BwZg==
X-Gm-Message-State: ACrzQf1QNI/hokBbkxjtfb65xzK5c9QjIAo2+HghB0DI5zRw+ZS41GTv
        xkTVGU4G+ogUKl8JwplNjKQ4X7rIPJw=
X-Google-Smtp-Source: AMsMyM7hhfKCI4x+UY64D+f0D7/k+FZrG5LGnSK6gzywitR/qTjOUZeB+KzC9ZGxKfbbACcwikNkXA==
X-Received: by 2002:adf:d4c9:0:b0:228:de3a:220f with SMTP id w9-20020adfd4c9000000b00228de3a220fmr5599938wrk.597.1663412107392;
        Sat, 17 Sep 2022 03:55:07 -0700 (PDT)
Received: from debian (host-78-150-37-98.as13285.net. [78.150.37.98])
        by smtp.gmail.com with ESMTPSA id f17-20020a05600c4e9100b003a5bd5ea215sm6026813wmq.37.2022.09.17.03.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Sep 2022 03:55:07 -0700 (PDT)
Date:   Sat, 17 Sep 2022 11:55:05 +0100
From:   "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
To:     Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: mainline build failure (new) for x86_64 allmodconfig with clang
Message-ID: <YyWniVAqJclcbSqN@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

The latest mainline kernel branch fails to build for x86_64 allmodconfig
with clang. The errors are:

drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/display_mode_vba_314.c:4020:6: error: stack frame size (2184) exceeds limit (2048) in 'dml314_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
     ^
1 error generated.


Note: This is a new error seen on top on a335366bad13 ("Merge tag 'gpio-fixes-for-v6.0-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux").
Previous reported clang build error is now fixed, thanks to Nathan.

And, it appears Nathan has already sent a fix for this:
https://github.com/intel-lab-lkp/linux/commit/4ecc45d7585ae2e05d622879ad97e13a7d8c595b
https://github.com/intel-lab-lkp/linux/commit/819976a950b497d7f10cd9a198a94c26a9005b30


--
Regards
Sudip

