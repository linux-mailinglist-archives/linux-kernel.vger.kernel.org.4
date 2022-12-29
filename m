Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1546658DA7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 14:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbiL2Nv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 08:51:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbiL2Nv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 08:51:57 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02562BB
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 05:51:55 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id y16so17443701wrm.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 05:51:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zm1bDobgQ6pSygeM5xND4kJhHGlT6DofkyFQfGt783I=;
        b=ebyv8dR6NjEqXCxT6IOlhcLHXUp8IXlMN5UxhjqQjoo2WdZPXKdncfCJXZ7/nJilSf
         iknxXehJ0bmCibu4XomXgfzlgaGShlrLSGtTP8l7R0+SbNjuXVp7YX1AfpZPsX5hR2RH
         GBc6ER0dziccAo57D9bmapVWmX6WWbYH03tv5Rs41ZBFFYzBhCXV4Ft04SlHiy7bTMxX
         CfGHfbeUNTsAPApgDkFcMS1M2PAOt9q2eDvl8aJ/zE1FSzZ/Rt+h95X2xOEZInUd/noh
         HqPdwalRJ9U3QQURPgH8mnMsn02Pf30ith2s1CSeT51aTvHcDvWnpSjh3SXxt26470YC
         tXnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zm1bDobgQ6pSygeM5xND4kJhHGlT6DofkyFQfGt783I=;
        b=E5MWk3oz+xsbuBPuNnL5RYuJRwRWtcCuilhhhbjjJrX7kYPCAJxy2DgXVlRa/Xx3S3
         QbvVxOmCERlO6mxqRm1VSpEaopgq4FcmK789XAAXsDXCc52sQmlW/FKKTe6Mzxq/+6Za
         9OC0THNfsLOBH/zs1IHfdWmpFxIwoLVDOZHQRRjJ1Eet6RgKRD2MweC/BEmvizAPyh66
         SWGdad+FVICXnHSav3ENhvjAuOeZcF9r0q51KuQQ/E990Uduet9wePuIthuhfJu8xVf4
         bu2hYHET8cGjoqV2OxKbC6uI1Ck58jAecWS5LVfczJSu9fivPhgGrJ79AAMU2F6h707v
         aRrw==
X-Gm-Message-State: AFqh2ko3ikoqQc2vMB+iBRLwl/bU2QHPe1b81XlloO+XiFTI4y4ZpRoC
        AzDqVNhzwwCNelSN8sMdcQU=
X-Google-Smtp-Source: AMrXdXtLRvlEt+jd72HMXlQo7iX6ufjl37B1CT3ePpVUkFgVOQvjeCTsYYPmCCcIkJbhUp0GzkFGgw==
X-Received: by 2002:adf:e94a:0:b0:242:154e:5f14 with SMTP id m10-20020adfe94a000000b00242154e5f14mr17800498wrn.17.1672321914423;
        Thu, 29 Dec 2022 05:51:54 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t13-20020adfe44d000000b002365b759b65sm17934596wrm.86.2022.12.29.05.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 05:51:54 -0800 (PST)
Date:   Thu, 29 Dec 2022 16:51:50 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Xiaojian Du <Xiaojian.Du@amd.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Huang Rui <ray.huang@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c:928 gmc_v6_0_hw_init() warn:
 missing error code? 'r'
Message-ID: <202212291937.KPkOnXbQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1b929c02afd37871d5afb9d498426f83432e71c2
commit: 479e3b02b73a2de2b19df2950863149c59d57bfe drm/amdgpu: add vram check function for GMC
config: ia64-randconfig-m041-20221229
compiler: ia64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c:928 gmc_v6_0_hw_init() warn: missing error code? 'r'

vim +/r +928 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c

df70502eef80be Ken Wang     2016-01-19  906  static int gmc_v6_0_hw_init(void *handle)
df70502eef80be Ken Wang     2016-01-19  907  {
df70502eef80be Ken Wang     2016-01-19  908  	int r;
df70502eef80be Ken Wang     2016-01-19  909  	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
df70502eef80be Ken Wang     2016-01-19  910  
df70502eef80be Ken Wang     2016-01-19  911  	gmc_v6_0_mc_program(adev);
df70502eef80be Ken Wang     2016-01-19  912  
df70502eef80be Ken Wang     2016-01-19  913  	if (!(adev->flags & AMD_IS_APU)) {
df70502eef80be Ken Wang     2016-01-19  914  		r = gmc_v6_0_mc_load_microcode(adev);
df70502eef80be Ken Wang     2016-01-19  915  		if (r) {
075719c3cb79f3 Tom St Denis 2016-09-06  916  			dev_err(adev->dev, "Failed to load MC firmware!\n");
df70502eef80be Ken Wang     2016-01-19  917  			return r;
df70502eef80be Ken Wang     2016-01-19  918  		}
df70502eef80be Ken Wang     2016-01-19  919  	}
df70502eef80be Ken Wang     2016-01-19  920  
df70502eef80be Ken Wang     2016-01-19  921  	r = gmc_v6_0_gart_enable(adev);
df70502eef80be Ken Wang     2016-01-19  922  	if (r)
df70502eef80be Ken Wang     2016-01-19  923  		return r;
df70502eef80be Ken Wang     2016-01-19  924  
479e3b02b73a2d Xiaojian Du  2022-01-17  925  	if (amdgpu_emu_mode == 1)
479e3b02b73a2d Xiaojian Du  2022-01-17  926  		return amdgpu_gmc_vram_checking(adev);
479e3b02b73a2d Xiaojian Du  2022-01-17  927  	else
df70502eef80be Ken Wang     2016-01-19 @928  		return r;

"r" is zero.  Just return a literal "return 0;" or "return EINVAL;"

df70502eef80be Ken Wang     2016-01-19  929  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

