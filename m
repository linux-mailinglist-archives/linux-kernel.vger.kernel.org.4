Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B646269F5EF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 14:54:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjBVNyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 08:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBVNyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 08:54:00 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139A01B56B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 05:53:59 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id o4-20020a05600c4fc400b003e1f5f2a29cso6419685wmq.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 05:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p9RB48KEAWbHAtCefbOrjQ1m5aljxgCXAYZywn/lFIM=;
        b=PLzHbO3h35jRkYwW/EHAj6BMoqKxrRxiKjxgsIMU5mA11YKLrUby39FipTzQ4DS+3H
         N5GVR8SnZiVGDOoTVloKjz50DVUWDkk4bmbyUo40YkMeltzeES1avuhX/UYHX3x5wB1J
         bcYcnFNuGGWg8znml5BY8FUDUO05elTRjAH1DbS33xWGfAO9xfo8aW0zpBJelO1gx/CO
         N17+WRcCjrRRE5oNBhETja0IhWgk+6frsPHfUbAaYVHAvQ1XKfFvbTfNAyuYWintAPYy
         c+fFDOYCx9RSGGHpT2ebOgrJ30/88nJBetJQ27fT8tfi1V7bsw0OphCYY2Rw3fAuCA0+
         or2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p9RB48KEAWbHAtCefbOrjQ1m5aljxgCXAYZywn/lFIM=;
        b=R9xef2WrKPh/mzxvhAFQNhdoJFYc+UeGwTnrM1iehYY0z1FyRVsp2xG/ZQAM+lMbFz
         MmApexQepMk1v4Z+SbwOFIUA1tOF5wGG4G7D33fGaF/pzHuYAgpiKF8/CXI3gd3olkRF
         1aPthbHZcWqTkKzpVa8VH9zrMD81/iGEmkFYQqHn1kZxu2HG0YdrqXilJ7WZCJSP+6Tr
         le21aFZDDT2Hr0x+dMAbFaQtG6mGqqiXJr0FmAzwkXIWzj+4r6M/0kFuj08bGz/dik/9
         z7wPpQ/pjholYak+k/EL54VA4yrEoBnHyOABquX2HYcGnbH4IoyYSWStxLiXVTZh/NM5
         +R7g==
X-Gm-Message-State: AO0yUKW1NZb2Mh43VnqqWZlGSoiII2xm2yRwUQfeJuiYU89q0xjFEQF9
        zW4gvUAQop7nNyv3/LC1E68=
X-Google-Smtp-Source: AK7set9ccwdpRMP992urQgI3oh4x7bVKRvDfDvwGPDIhpMjVMdHkHgjKnsb8bsjTR2L2/tevLzN9KQ==
X-Received: by 2002:a05:600c:2ed3:b0:3e0:b1:c118 with SMTP id q19-20020a05600c2ed300b003e000b1c118mr6780291wmn.5.1677074037530;
        Wed, 22 Feb 2023 05:53:57 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id v9-20020a05600c444900b003e21f01c426sm7853653wmn.9.2023.02.22.05.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 05:53:56 -0800 (PST)
Date:   Wed, 22 Feb 2023 16:53:53 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev, Besar Wicaksono <bwicaksono@nvidia.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: drivers/perf/arm_cspmu/arm_cspmu.c:1075
 arm_cspmu_find_cpu_container() warn: variable dereferenced before check
 'cpu_dev' (see line 1073)
Message-ID: <202302191227.kc0V8fM7-lkp@intel.com>
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
head:   925cf0457d7e62ce08878ffb789189ac08ca8677
commit: e37dfd65731dc4f001fa7dfa7f705e6840017d5a perf: arm_cspmu: Add support for ARM CoreSight PMU driver
config: arm64-randconfig-m031-20230219 (https://download.01.org/0day-ci/archive/20230219/202302191227.kc0V8fM7-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202302191227.kc0V8fM7-lkp@intel.com/

smatch warnings:
drivers/perf/arm_cspmu/arm_cspmu.c:1075 arm_cspmu_find_cpu_container() warn: variable dereferenced before check 'cpu_dev' (see line 1073)

vim +/cpu_dev +1075 drivers/perf/arm_cspmu/arm_cspmu.c

e37dfd65731dc4 Besar Wicaksono 2022-11-11  1069  static inline int arm_cspmu_find_cpu_container(int cpu, u32 container_uid)
e37dfd65731dc4 Besar Wicaksono 2022-11-11  1070  {
e37dfd65731dc4 Besar Wicaksono 2022-11-11  1071  	u32 acpi_uid;
e37dfd65731dc4 Besar Wicaksono 2022-11-11  1072  	struct device *cpu_dev = get_cpu_device(cpu);
e37dfd65731dc4 Besar Wicaksono 2022-11-11 @1073  	struct acpi_device *acpi_dev = ACPI_COMPANION(cpu_dev);
                                                                                                      ^^^^^^^
Dereference

e37dfd65731dc4 Besar Wicaksono 2022-11-11  1074  
e37dfd65731dc4 Besar Wicaksono 2022-11-11 @1075  	if (!cpu_dev)
                                                             ^^^^^^^
Checked too late.

e37dfd65731dc4 Besar Wicaksono 2022-11-11  1076  		return -ENODEV;
e37dfd65731dc4 Besar Wicaksono 2022-11-11  1077  
e37dfd65731dc4 Besar Wicaksono 2022-11-11  1078  	while (acpi_dev) {
e37dfd65731dc4 Besar Wicaksono 2022-11-11  1079  		if (!strcmp(acpi_device_hid(acpi_dev),
e37dfd65731dc4 Besar Wicaksono 2022-11-11  1080  			    ACPI_PROCESSOR_CONTAINER_HID) &&
e37dfd65731dc4 Besar Wicaksono 2022-11-11  1081  		    !kstrtouint(acpi_device_uid(acpi_dev), 0, &acpi_uid) &&
e37dfd65731dc4 Besar Wicaksono 2022-11-11  1082  		    acpi_uid == container_uid)
e37dfd65731dc4 Besar Wicaksono 2022-11-11  1083  			return 0;
e37dfd65731dc4 Besar Wicaksono 2022-11-11  1084  
e37dfd65731dc4 Besar Wicaksono 2022-11-11  1085  		acpi_dev = acpi_dev_parent(acpi_dev);
e37dfd65731dc4 Besar Wicaksono 2022-11-11  1086  	}
e37dfd65731dc4 Besar Wicaksono 2022-11-11  1087  
e37dfd65731dc4 Besar Wicaksono 2022-11-11  1088  	return -ENODEV;
e37dfd65731dc4 Besar Wicaksono 2022-11-11  1089  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

