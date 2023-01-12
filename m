Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3CB6686E9
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 23:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240488AbjALW1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 17:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240482AbjALW1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 17:27:07 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A661F37519
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 14:24:36 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id 20so9441964pfu.13
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 14:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MIHU3yvE0AEyf97Few65TN6W0VeSVha7m422Ft94+7A=;
        b=CbA4pTm2SHhAMNA1b6IXOEtNp1xFz0u0mzMKo9bqUTONN3HQbnPTKBKrLsogLpNjSa
         0ZNtxD3nvVpAux+j70KuFPBNjUf8wylSfZANYsIlgMlRAIbmw5JG17Tr947Su/sT89cO
         hWADWSOoopeu4L7R3sXZpD7hVv4uFgRkcQ0m8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MIHU3yvE0AEyf97Few65TN6W0VeSVha7m422Ft94+7A=;
        b=rIIBt8QcF88oKgdL0TE0c9qqnkY0YBFYDTKpn4Z5+xPGkMq0NWCd+JiE44dmubO0fe
         wJdpk7zLouWkauoVcFxFjRZeaqcVNelE+CTx9ODRVqSWvWt/ChRLhlPf6WcvvF+hKbsx
         HaBi8ihPPWrIC4hfI+SfZ8tVgHCWcBp0QzmqvZ9kLofKuDwByPWHWo76fme5kQ0eOo+K
         aFZn3/ndiwY3wlDyKl7vU+smkOPC9pVBujedlmoAEdkzIL4F0m0mgeaOF9XcegwbjcJ7
         +B0D5aBmzEcAxiK219CZL30BZBdlVv5v6hEq4m7sH5AGRxy985bzVCK48JbLOmD3lUd5
         H9Dw==
X-Gm-Message-State: AFqh2krxz4T1tImPydEqAatsKAoMTeuKoZ4xfqf3N2BzV2qOsAjaOuef
        6wCxNv2is/2hGPmEqDL8GsO71A==
X-Google-Smtp-Source: AMrXdXuKAy66qRsaguoO7dg6xnQ3vgZ5z1AK7rX4p+jat7ZwYy/A+VHwQzvqc14DEcs75u/ulmALZA==
X-Received: by 2002:a05:6a00:3311:b0:582:6732:ee03 with SMTP id cq17-20020a056a00331100b005826732ee03mr8164704pfb.9.1673562275935;
        Thu, 12 Jan 2023 14:24:35 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q20-20020aa79834000000b0058134d2df41sm11375879pfl.146.2023.01.12.14.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 14:24:35 -0800 (PST)
From:   coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date:   Thu, 12 Jan 2023 14:24:34 -0800
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Lijo Lazar <lijo.lazar@amd.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, "Jiadong.Zhu" <Jiadong.Zhu@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Likun Gao <Likun.Gao@amd.com>, dri-devel@lists.freedesktop.org,
        Tao Zhou <tao.zhou1@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>, yipechai <YiPeng.Chai@amd.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: gfx_v9_0_init_cp_compute_microcode(): Control flow issues
Message-ID: <202301121424.5FA0483AB@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

  Mon Jan 9 17:02:18 2023 -0500
    ec787deb2ddf ("drm/amd: Use `amdgpu_ucode_*` helpers for GFX9")

Coverity reported the following:

*** CID 1530548:  Control flow issues  (DEADCODE)
drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:1374 in gfx_v9_0_init_cp_compute_microcode()
1368     		adev->gfx.mec2_feature_version = adev->gfx.mec_feature_version;
1369     	}
1370
1371     	gfx_v9_0_check_if_need_gfxoff(adev);
1372     	gfx_v9_0_check_fw_write_wait(adev);
1373     	if (err) {
vvv     CID 1530548:  Control flow issues  (DEADCODE)
vvv     Execution cannot reach this statement: "amdgpu_ucode_release(&adev-...".
1374     		amdgpu_ucode_release(&adev->gfx.mec_fw);
1375     		amdgpu_ucode_release(&adev->gfx.mec2_fw);
1376     	}
1377     	return err;
1378     }
1379

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1530548 ("Control flow issues")
Fixes: ec787deb2ddf ("drm/amd: Use `amdgpu_ucode_*` helpers for GFX9")

Thanks for your attention!

-- 
Coverity-bot
