Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD086175F7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 06:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiKCFFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 01:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiKCFFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 01:05:06 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC0C1836E;
        Wed,  2 Nov 2022 22:05:05 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id o4so1005303wrq.6;
        Wed, 02 Nov 2022 22:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=rom:in-reply-to:content-disposition:mime-version:message-id:subject
         :cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1rISLR4fCir9Qo3kG4MmHWQffnyg0E3C9I6ZPdYWK9w=;
        b=jDFOlwvSc4VgW9Cn1fok4tf84n1Zoc1XNswknecjG6szmDrX3himVRKGQEfehicZos
         pQswasGK5TpH0KnL2YXgOY6LW8G4/0aguckorCvgXw7fC/xgLPkIPMpKBaXRywtqmYaf
         ScnHmYHTaKI482GETt69Q/+q3/z78rhE6YU1Lqegc3WY5dGdraf33XB3SWWlSlFqMAD7
         SRKQ79u4Do/7siHdUvgb3MdLxp8KDb//4ByCNctMhrCSUWuySN1T99ShB8ZiehdDGxr4
         DDlPKBmm/x5tkl4eJyuff2eEJfSa0WYEqk22ZsZifBa2HL9SXBFQaf66MG5rAvkDJJwO
         fbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=rom:in-reply-to:content-disposition:mime-version:message-id:subject
         :cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1rISLR4fCir9Qo3kG4MmHWQffnyg0E3C9I6ZPdYWK9w=;
        b=coayfJWF5Sqfhr+4VopkTgh74HFkWdYc/mWbXa705vQbnlhP9SPLlkfBX56mSTbRFF
         g06rWLTEbGb+qQ5Kbdc3bkDhF2T+BgokXGGS5Y/jygxxy8JKGjz/xppvgjy9h1m7Hj8S
         L7F51cnfCz59micuZONcbkEajjAQiLmZTrtoZVeURUPSGfY0kmTIsUQm11z3HxaWsUC+
         TlGtSfQsszPnb0M3eZSiU6v4VaVQSqkZ0XClEzimSgkiPNkC0PijCw+7vdN+ckoYFWWJ
         VzAhO1bjmByZw0ZQR0AABXQ5CHPxpVFgkGaCC7HCh9kUcHaI8jwMD4CsLKiDFu8P2Hnc
         f1Iw==
X-Gm-Message-State: ACrzQf2UH32ckr9xfGiTAY5/v874XrBflGpkGD0G0RY2n5NY38XVlViV
        S8Xisz/h5bJwgjkAbEQgvwE=
X-Google-Smtp-Source: AMsMyM4UOOQbvay5N+xws8xCof0zFaHNmgxxOtRxaaz48CAHz2TdkWIxy2j2dvWMA4IKUS202c40Mg==
X-Received: by 2002:adf:d226:0:b0:235:d9ae:1de9 with SMTP id k6-20020adfd226000000b00235d9ae1de9mr17736970wrh.599.1667451904103;
        Wed, 02 Nov 2022 22:05:04 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id e12-20020adfe38c000000b0023655e51c14sm14241193wrm.32.2022.11.02.22.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 22:05:03 -0700 (PDT)
From:   error27@gmail.com
Date:   Thu, 3 Nov 2022 08:04:59 +0300
To:     oe-kbuild@lists.linux.dev, Yihang Li <liyihang9@huawei.com>,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev, bvanassche@acm.org,
        john.garry@huawei.com, chenxiang66@hisilicon.com,
        daejun7.park@samsung.com, damien.lemoal@opensource.wdc.com,
        yanaijie@huawei.com, duoming@zju.edu.cn,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        prime.zeng@hisilicon.com, yangxingui@huawei.com,
        linuxarm@huawei.com, liyihang9@huawei.com
Subject: Re: [PATCH] scsi: libsas: Check and update the link rate during
 discovery
Message-ID: <202211030845.FLT5UqWU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102100555.3537275-1-liyihang9@huawei.com>
rom:    Dan Carpenter <error27@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yihang,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yihang-Li/scsi-libsas-Check-and-update-the-link-rate-during-discovery/20221102-180734
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
patch link:    https://lore.kernel.org/r/20221102100555.3537275-1-liyihang9%40huawei.com
patch subject: [PATCH] scsi: libsas: Check and update the link rate during discovery
config: m68k-randconfig-m041-20221102
compiler: m68k-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>

New smatch warnings:
drivers/scsi/libsas/sas_expander.c:1962 sas_ex_update_linkrate() warn: iterator used outside loop: 'child'

Old smatch warnings:
drivers/scsi/libsas/sas_expander.c:253 sas_set_ex_phy() error: potential null dereference 'phy->phy'.  (sas_phy_alloc returns null)
drivers/scsi/libsas/sas_expander.c:253 sas_set_ex_phy() error: we previously assumed 'phy->phy' could be null (see line 189)
drivers/scsi/libsas/sas_expander.c:1974 sas_ex_update_linkrate() warn: iterator used outside loop: 'child'

vim +/child +1962 drivers/scsi/libsas/sas_expander.c

39d64046e3dfc7 Yihang Li       2022-11-02  1947  static void sas_ex_update_linkrate(struct domain_device *parent)
39d64046e3dfc7 Yihang Li       2022-11-02  1948  {
39d64046e3dfc7 Yihang Li       2022-11-02  1949  	struct expander_device *ex = &parent->ex_dev;
39d64046e3dfc7 Yihang Li       2022-11-02  1950  	int i = 0, end = ex->num_phys;
39d64046e3dfc7 Yihang Li       2022-11-02  1951  
39d64046e3dfc7 Yihang Li       2022-11-02  1952  	for ( ; i < end; i++) {
39d64046e3dfc7 Yihang Li       2022-11-02  1953  		struct ex_phy *ex_phy = &ex->ex_phy[i];
39d64046e3dfc7 Yihang Li       2022-11-02  1954  		struct domain_device *child;
39d64046e3dfc7 Yihang Li       2022-11-02  1955  
39d64046e3dfc7 Yihang Li       2022-11-02  1956  		list_for_each_entry(child, &parent->ex_dev.children, siblings)
                                                                                    ^^^^^
Imagine this loop exits without finding the correct child.

39d64046e3dfc7 Yihang Li       2022-11-02  1957  			if (SAS_ADDR(child->sas_addr) ==
39d64046e3dfc7 Yihang Li       2022-11-02  1958  			    SAS_ADDR(ex_phy->attached_sas_addr))
39d64046e3dfc7 Yihang Li       2022-11-02  1959  				break;
39d64046e3dfc7 Yihang Li       2022-11-02  1960  
39d64046e3dfc7 Yihang Li       2022-11-02  1961  		if (dev_is_sata(child)) {
                                                                                ^^^^^
That means "child" is not a valid pointer.  Not sure why the warning is
only triggered on the line below instead of here.

39d64046e3dfc7 Yihang Li       2022-11-02 @1962  			if (child->linkrate > parent->min_linkrate) {
39d64046e3dfc7 Yihang Li       2022-11-02  1963  				struct sas_phy_linkrates rates = {
39d64046e3dfc7 Yihang Li       2022-11-02  1964  					.maximum_linkrate = parent->min_linkrate,
39d64046e3dfc7 Yihang Li       2022-11-02  1965  					.minimum_linkrate = parent->min_linkrate,
39d64046e3dfc7 Yihang Li       2022-11-02  1966  				};
39d64046e3dfc7 Yihang Li       2022-11-02  1967  
39d64046e3dfc7 Yihang Li       2022-11-02  1968  				sas_smp_phy_control(parent, i,
39d64046e3dfc7 Yihang Li       2022-11-02  1969  						    PHY_FUNC_LINK_RESET, &rates);
39d64046e3dfc7 Yihang Li       2022-11-02  1970  				ex_phy->phy_change_count = -1;
39d64046e3dfc7 Yihang Li       2022-11-02  1971  			}
39d64046e3dfc7 Yihang Li       2022-11-02  1972  		}
39d64046e3dfc7 Yihang Li       2022-11-02  1973  
39d64046e3dfc7 Yihang Li       2022-11-02  1974  		if (dev_is_expander(child->dev_type)) {
39d64046e3dfc7 Yihang Li       2022-11-02  1975  			child->min_linkrate = min(parent->min_linkrate,
39d64046e3dfc7 Yihang Li       2022-11-02  1976  						  ex_phy->linkrate);
39d64046e3dfc7 Yihang Li       2022-11-02  1977  			child->max_linkrate = max(parent->max_linkrate,
39d64046e3dfc7 Yihang Li       2022-11-02  1978  						  ex_phy->linkrate);
39d64046e3dfc7 Yihang Li       2022-11-02  1979  			child->linkrate = min(ex_phy->linkrate,
39d64046e3dfc7 Yihang Li       2022-11-02  1980  					      child->max_linkrate);
39d64046e3dfc7 Yihang Li       2022-11-02  1981  			ex_phy->phy_change_count = -1;
39d64046e3dfc7 Yihang Li       2022-11-02  1982  		}
39d64046e3dfc7 Yihang Li       2022-11-02  1983  	}
39d64046e3dfc7 Yihang Li       2022-11-02  1984  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
