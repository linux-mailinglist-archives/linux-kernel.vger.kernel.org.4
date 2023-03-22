Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24AEA6C49B5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 12:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjCVLw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 07:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjCVLwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 07:52:54 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29ECD10ABE;
        Wed, 22 Mar 2023 04:52:53 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y4so71810287edo.2;
        Wed, 22 Mar 2023 04:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679485971;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ho4jVBmPA9BFJ1NRBlIYYugOjZKS7BAlkcBVP60WOFY=;
        b=E3Oh+auU0oU56o4Ag9yCvnQ/NujkTP0f/ZvGt/y7CLtux5D3nolsuSjsF/3blUbsfJ
         eV8kejmE8d95Y+1LNWWto+mgd7RcuFW/gnnl2oipW2ky6GwDEwTAITvLoQwIRCVr1XuF
         TrpxFzJ2iuDLJPEaATm4qvd+ofG2nx3KYegE/6EmnVs7SxIQfhSr9y3C6/uOqZnWhMhX
         zuY2iDo1tXjCg3gilbwxs6aj5nBIuOAqJjZx5sgfi0aP0HhadSDasNAGTyOLjgAGY7+J
         0bl338AYEXDfQgAsGdE0oJ0mikj3pCgQEMIfVKT3kQSNSKFQ1RGdrCXR6Ac1hTNiqRHu
         ulzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679485971;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ho4jVBmPA9BFJ1NRBlIYYugOjZKS7BAlkcBVP60WOFY=;
        b=TVJlhoe251fqTinz498wFrlgzDkAxEM/dzHD98j/CT+EsSYH6/hXyMJJCr7UJ7q5lu
         BCu7qJFUBLUAQrCTwvkR0vU0+OnvVhNMTdmfDIBRwAWhhB1rK7xXDDsJQCokpEuokpjZ
         G69wP/UFJQqkd3zRtjmSZRJA/yGtOonWzm7qUfDHnRHNRj7/Mh0Jf8W1GJuRtrAFZUyC
         9f+d93sbZKluKkehyPT/VyTMZ7JF7bUE1Rg8fCX025CReAzl4lJ1Ty8cBs8tOhSM6u0U
         kidttPLjCLL+khCPQ8lI3Qq6hjY6lgz4mZUv5F83AicTY3+lHC08oDv2pYWMnjfTVOA7
         mIZA==
X-Gm-Message-State: AO0yUKWjM+rO9vqAelC7DBpDGcRbQVF4ZaznRk3BTmHA9toeQN2w7Fe0
        ysfMYp/BHecTd0dsgITARqo=
X-Google-Smtp-Source: AK7set8jk6V8+fNpBSGtiZGLG7GpUDRiZlz/urB9685AOQ4i8HnPZa4QlvotQ+Sk+/vEAa04Pr3snQ==
X-Received: by 2002:a17:906:eb8b:b0:884:930:b017 with SMTP id mh11-20020a170906eb8b00b008840930b017mr7424514ejb.60.1679485971523;
        Wed, 22 Mar 2023 04:52:51 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id d8-20020a170906c20800b0093a2160168esm1984974ejz.35.2023.03.22.04.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 04:52:51 -0700 (PDT)
Date:   Wed, 22 Mar 2023 14:52:45 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Tanmay Shah <tanmay.shah@amd.com>,
        andersson@kernel.org, mathieu.poirier@linaro.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tanmay Shah <tanmay.shah@amd.com>,
        Tarak Reddy <tarak.reddy@amd.com>
Subject: Re: [PATCH v2 2/2] remoteproc: enhance rproc_put() for clusters
Message-ID: <82ff071d-cd00-47f8-bc72-4d78bfed731d@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322040933.924813-3-tanmay.shah@amd.com>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tanmay,

url:    https://github.com/intel-lab-lkp/linux/commits/Tanmay-Shah/remoteproc-Make-rproc_get_by_phandle-work-for-clusters/20230322-121102
base:   e19967994d342a5986d950a1bfddf19d7e1191b7
patch link:    https://lore.kernel.org/r/20230322040933.924813-3-tanmay.shah%40amd.com
patch subject: [PATCH v2 2/2] remoteproc: enhance rproc_put() for clusters
config: powerpc-randconfig-m041-20230322 (https://download.01.org/0day-ci/archive/20230322/202303221916.LgKkr8Gk-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202303221916.LgKkr8Gk-lkp@intel.com/

smatch warnings:
drivers/remoteproc/remoteproc_core.c:2565 rproc_put() warn: variable dereferenced before check 'rproc->dev.parent' (see line 2562)
drivers/remoteproc/remoteproc_core.c:2566 rproc_put() warn: variable dereferenced before check 'rproc->dev.parent->driver' (see line 2562)

vim +2565 drivers/remoteproc/remoteproc_core.c

160e7c840fe858 Ohad Ben-Cohen  2012-07-04  2560  void rproc_put(struct rproc *rproc)
400e64df6b237e Ohad Ben-Cohen  2011-10-20  2561  {
fbb6aacb078285 Bjorn Andersson 2016-10-02 @2562  	module_put(rproc->dev.parent->driver->owner);
                                                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^
Unchecked dereferences.

573d22d13a6970 Tanmay Shah     2023-03-21  2563  	struct platform_device *cluster_pdev;
573d22d13a6970 Tanmay Shah     2023-03-21  2564  
573d22d13a6970 Tanmay Shah     2023-03-21 @2565  	if (rproc->dev.parent) {
                                                            ^^^^^^^^^^^^^^^^^
Checked too late.

573d22d13a6970 Tanmay Shah     2023-03-21 @2566  		if (rproc->dev.parent->driver) {
                                                                    ^^^^^^^^^^^^^^^^^^^^^^^^^

573d22d13a6970 Tanmay Shah     2023-03-21  2567  			module_put(rproc->dev.parent->driver->owner);
573d22d13a6970 Tanmay Shah     2023-03-21  2568  		} else {
573d22d13a6970 Tanmay Shah     2023-03-21  2569  			cluster_pdev = of_find_device_by_node(rproc->dev.parent->of_node->parent);
573d22d13a6970 Tanmay Shah     2023-03-21  2570  			if (cluster_pdev) {
573d22d13a6970 Tanmay Shah     2023-03-21  2571  				module_put(cluster_pdev->dev.driver->owner);
573d22d13a6970 Tanmay Shah     2023-03-21  2572  				put_device(&cluster_pdev->dev);
573d22d13a6970 Tanmay Shah     2023-03-21  2573  			}
573d22d13a6970 Tanmay Shah     2023-03-21  2574  		}
573d22d13a6970 Tanmay Shah     2023-03-21  2575  	}
b5ab5e24e960b9 Ohad Ben-Cohen  2012-05-30  2576  	put_device(&rproc->dev);
400e64df6b237e Ohad Ben-Cohen  2011-10-20  2577  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

