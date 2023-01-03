Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9C965BB8C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 09:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236894AbjACIB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 03:01:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236945AbjACIBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 03:01:17 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358CEDF4C
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 00:01:15 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id i17-20020a05600c355100b003d99434b1cfso12282755wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 00:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGe2dNB2O4DsKtHDiJtdu6ZDVemkFhiQQFAUL63hwnc=;
        b=YgAGjs3aYWKp0FP4eoXSs3SrEkWUWSTVhLGesQBqLAKt2i2ZxYBIIeadHgt9Nibdo7
         vGqtInYcEt6n2L7465PGlNGk/nMk18HMVm2LxrWDyj8yom5v4G5nr6J1BAKmKjwCD0cy
         SQr5TWtHEvm4/qApb5VkdUYIOu1UYvDPyzSq8sldsd2h3XUfLXvOxsrLzqq5iU6+dkFy
         97H452KhgAoQoDPhbUer4vpmjz4fC4nvjaZfj6X/16AupX5BLzxZuyjo2EBoVmSepLTz
         NHASVhzir0UMQCHjwRDGSi/MGiKxV8tXk6eR12ohQ3qhx0F8xAGjwQmUtFawrYbA9zSD
         eZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGe2dNB2O4DsKtHDiJtdu6ZDVemkFhiQQFAUL63hwnc=;
        b=fH9rgB0PqX8jJrVMJWWdAtwyuts/E5gDvxCqGQ8kV5Vo1H9jNwXyi1fwr/u5cQwF4O
         GJfVwuMV1fnQPlo1kV4mAm2QVEGP1HFxMBu51bQJ68+BYqEFA/oWXfUsSPiy4Bdji0+8
         Av8JuGkm76+YNln1bIQ/VlEaL1cWKB/PF6ySWu6j7eW9WliOFP00HPAa2pdd6K9891tO
         aq6w3S+KQe35xFB3guWKneEsoCF8RMf0zeMMJCygeZvMkmsQUGhRb774biOFuyxV3AXU
         ZmVrWGtcaOS+AsBQUReHqEKliwv6v7Hxl9qM2QWD9ze3My/NH9fP1rJF7mJs5a68UWl4
         HP/A==
X-Gm-Message-State: AFqh2kqMy3uvRu0UDRkyj5SAhEdwYU/37S+JgCg3Z8EAbh35S0GJ2/lc
        OwuWwPS3VSiYhVhPA5KkP6Q=
X-Google-Smtp-Source: AMrXdXvFtbAoAaFKpX+Rat5ImAisAP6yESMRxvuUT+kssNxjABlldmaOx3Bo/YLhHUt1xAt1Ys1BUw==
X-Received: by 2002:a05:600c:54cb:b0:3cf:d0be:1231 with SMTP id iw11-20020a05600c54cb00b003cfd0be1231mr37428713wmb.13.1672732873668;
        Tue, 03 Jan 2023 00:01:13 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id m28-20020a05600c3b1c00b003d1e3b1624dsm49940467wms.2.2023.01.03.00.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 00:01:13 -0800 (PST)
Date:   Tue, 3 Jan 2023 11:01:04 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Luben Tuikov <luben.tuikov@amd.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:473
 amdgpu_bo_validate_size() error: we previously assumed 'man' could be null
 (see line 458)
Message-ID: <202212300020.CFmsapaG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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
commit: 7554886daa31eacc8e7fac9e15bbce67d10b8f1f drm/amdgpu: Fix size validation for non-exclusive domains (v4)
config: ia64-randconfig-m041-20221229
compiler: ia64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

smatch warnings:
drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:473 amdgpu_bo_validate_size() error: we previously assumed 'man' could be null (see line 458)

vim +/man +473 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c

79c631239a83ae Andrey Grodzovsky 2017-11-10  444  static bool amdgpu_bo_validate_size(struct amdgpu_device *adev,
79c631239a83ae Andrey Grodzovsky 2017-11-10  445  					  unsigned long size, u32 domain)
79c631239a83ae Andrey Grodzovsky 2017-11-10  446  {
9de59bc201496f Dave Airlie       2020-08-04  447  	struct ttm_resource_manager *man = NULL;
79c631239a83ae Andrey Grodzovsky 2017-11-10  448  
79c631239a83ae Andrey Grodzovsky 2017-11-10  449  	/*
79c631239a83ae Andrey Grodzovsky 2017-11-10  450  	 * If GTT is part of requested domains the check must succeed to
7554886daa31ea Luben Tuikov      2022-12-10  451  	 * allow fall back to GTT.
79c631239a83ae Andrey Grodzovsky 2017-11-10  452  	 */
79c631239a83ae Andrey Grodzovsky 2017-11-10  453  	if (domain & AMDGPU_GEM_DOMAIN_GTT) {
6c28aed6e5b7fa Dave Airlie       2020-08-04  454  		man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
79c631239a83ae Andrey Grodzovsky 2017-11-10  455  
7554886daa31ea Luben Tuikov      2022-12-10  456  		if (man && size < man->size)
79c631239a83ae Andrey Grodzovsky 2017-11-10  457  			return true;
7554886daa31ea Luben Tuikov      2022-12-10 @458  		else if (!man)
7554886daa31ea Luben Tuikov      2022-12-10  459  			WARN_ON_ONCE("GTT domain requested but GTT mem manager uninitialized");

WARN()

79c631239a83ae Andrey Grodzovsky 2017-11-10  460  		goto fail;
7554886daa31ea Luben Tuikov      2022-12-10  461  	} else if (domain & AMDGPU_GEM_DOMAIN_VRAM) {
6c28aed6e5b7fa Dave Airlie       2020-08-04  462  		man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
79c631239a83ae Andrey Grodzovsky 2017-11-10  463  
7554886daa31ea Luben Tuikov      2022-12-10  464  		if (man && size < man->size)
79c631239a83ae Andrey Grodzovsky 2017-11-10  465  			return true;
79c631239a83ae Andrey Grodzovsky 2017-11-10  466  		goto fail;
79c631239a83ae Andrey Grodzovsky 2017-11-10  467  	}
79c631239a83ae Andrey Grodzovsky 2017-11-10  468  
79c631239a83ae Andrey Grodzovsky 2017-11-10  469  	/* TODO add more domains checks, such as AMDGPU_GEM_DOMAIN_CPU */
79c631239a83ae Andrey Grodzovsky 2017-11-10  470  	return true;
79c631239a83ae Andrey Grodzovsky 2017-11-10  471  
79c631239a83ae Andrey Grodzovsky 2017-11-10  472  fail:
299c776cebb01c Michel Dänzer     2017-11-15 @473  	DRM_DEBUG("BO size %lu > total memory in domain: %llu\n", size,
4499c90e902f39 Christian König   2022-03-11  474  		  man->size);

Followed by crash.

79c631239a83ae Andrey Grodzovsky 2017-11-10  475  	return false;
79c631239a83ae Andrey Grodzovsky 2017-11-10  476  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

