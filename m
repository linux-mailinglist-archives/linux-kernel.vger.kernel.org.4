Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2E3709C6A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjESQ2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjESQ22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:28:28 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D0E8F
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:28:27 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-307d58b3efbso2315736f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684513705; x=1687105705;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2GJdeGWAzoXld9QLuODG0U2sKMNphJdDP2fBZjGvqmI=;
        b=DplTAsJh4Gbxe0zkwj+3EHsAdFZh18sUNl88kJ/NEb/DXR1dsnjoftCCqi4z/9mevv
         IWtqtGkjzz9Y1ReQBpZ0qPvPvoXejShcfCD5yqPcpXTsQdzyhoqUOJ3FoOg70LNskOAp
         VeDhpEeG1QzDzLefMxy9CqzXAHOYRvKRgI3VzUO3Hi+lwG+vKpKX2+odV+QEPgWOcj1F
         hSx7eiEyhOTsDio6UdFKqV7AnoQeB9W1jL7b62VrNdaKuwpxew64qxx94pnmjUhR/+37
         788dcnsOKcVDwjdPqoY5KxB2xYTdXf9geOSsbG65pmh9rQ76vORaVbiq5rbiaLsAxO2O
         P+lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684513705; x=1687105705;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2GJdeGWAzoXld9QLuODG0U2sKMNphJdDP2fBZjGvqmI=;
        b=QfNGGQ5xPUAJPvNjmiy/2QVQ13F+QTnOFHY48Fg+NGFGKD85JD39qzwaNyBuMX5jbt
         KXAq6ITtUovZT0PFd3zv1nRaqE6pUF3lH5ck16w7QLbrucI+lVnkOMpOHQUQcuk4gfqP
         GyJAVu9Be6/ZvtdsrncCKams8vXDMwrtJyOc4PYdMddSXqs+G4Fdd7oculumQ/a+4A10
         wqDlxzyP3WOEk9eagUB+WZmo76tivX/jCiePMAJYA/ns/HJMbY4NPrksHvq4cMNdZLCy
         9dgDiTmRbCMoBctgTvjnm1EYvl/WAH3N4iM2bj5au9/OmhWr30ikfHCEXnh1Mf+DGung
         qrzw==
X-Gm-Message-State: AC+VfDw7+ePAXSnSL/U7Wy933LVd0laRKPplklC5AVF5spul+Tvw1jKN
        Zp5jubd6tvVgDl8rhoOmepNZpA==
X-Google-Smtp-Source: ACHHUZ4+noNRFYc/gXg2MiArTOT/3T/uxKicgvezGE4QIW4v1m8aywHdparsRxmCv8wrI2tZshVofA==
X-Received: by 2002:a5d:4301:0:b0:306:147e:5553 with SMTP id h1-20020a5d4301000000b00306147e5553mr1867234wrq.23.1684513705606;
        Fri, 19 May 2023 09:28:25 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id c2-20020a5d63c2000000b0030497b3224bsm5678580wrw.64.2023.05.19.09.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 09:28:24 -0700 (PDT)
Date:   Fri, 19 May 2023 19:28:04 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c:1371 dpu_plane_reset()
 warn: variable dereferenced before check 'plane' (see line 1369)
Message-ID: <f286d777-8866-4207-83f8-2f1c81efdb23@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2d1bcbc6cd703e64caf8df314e3669b4786e008a
commit: 7f38ec140d9c1f257eb55d45d224a7203998d3cc drm/msm/dpu: move pipe_hw to dpu_plane_state
config: ia64-randconfig-m041-20230514
compiler: ia64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202305192230.fkMk4qjF-lkp@intel.com/

New smatch warnings:
drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c:1371 dpu_plane_reset() warn: variable dereferenced before check 'plane' (see line 1369)

Old smatch warnings:
drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c:618 _dpu_plane_get_csc() warn: variable dereferenced before check 'pdpu' (see line 615)

vim +/plane +1371 drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c

25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1365  static void dpu_plane_reset(struct drm_plane *plane)
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1366  {
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1367  	struct dpu_plane *pdpu;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1368  	struct dpu_plane_state *pstate;
7f38ec140d9c1f Dmitry Baryshkov  2023-03-16 @1369  	struct dpu_kms *dpu_kms = _dpu_plane_get_kms(plane);
                                                                                                     ^^^^^
Dereference inside the function.

25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1370  
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27 @1371  	if (!plane) {
                                                            ^^^^^^
Checked too late.

25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1372  		DPU_ERROR("invalid plane\n");
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1373  		return;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1374  	}
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1375  
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1376  	pdpu = to_dpu_plane(plane);
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1377  	DPU_DEBUG_PLANE(pdpu, "\n");
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1378  
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1379  	/* remove previous state, if present */
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1380  	if (plane->state) {
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1381  		dpu_plane_destroy_state(plane, plane->state);
c9ef97b694b9bf Bernard Zhao      2021-05-09  1382  		plane->state = NULL;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1383  	}
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1384  
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1385  	pstate = kzalloc(sizeof(*pstate), GFP_KERNEL);
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1386  	if (!pstate) {
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1387  		DPU_ERROR_PLANE(pdpu, "failed to allocate state\n");
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1388  		return;
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1389  	}
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1390  
7f38ec140d9c1f Dmitry Baryshkov  2023-03-16  1391  	/*
7f38ec140d9c1f Dmitry Baryshkov  2023-03-16  1392  	 * Set the SSPP here until we have proper virtualized DPU planes.
7f38ec140d9c1f Dmitry Baryshkov  2023-03-16  1393  	 * This is the place where the state is allocated, so fill it fully.
7f38ec140d9c1f Dmitry Baryshkov  2023-03-16  1394  	 */
7f38ec140d9c1f Dmitry Baryshkov  2023-03-16  1395  	pstate->hw_sspp = dpu_rm_get_sspp(&dpu_kms->rm, pdpu->pipe);
7f38ec140d9c1f Dmitry Baryshkov  2023-03-16  1396  
f964cfb7bcffc8 Dmitry Baryshkov  2021-06-28  1397  	__drm_atomic_helper_plane_reset(plane, &pstate->base);
25fdd5933e4c0f Jeykumar Sankaran 2018-06-27  1398  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

