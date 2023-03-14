Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D696B9744
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 15:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbjCNOIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 10:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjCNOIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 10:08:40 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB25410417
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 07:08:36 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id o12so62535254edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 07:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678802915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2fh50q0+/HEalk1h1oQC2pXaNeew6AKaitkp7RgML7Q=;
        b=J1G5R1YnRKN2hzDDJInJdLGi2sJjFHgYNB/uDk3DMY1eqELgKvyT78qq1VUN3anRAY
         7bQSxtcGc/J2RWnxz9XLdnE6L2mMC+St1n4XEuYo5fqdTxQqDTgiG32m1SHSOkSyf2Fx
         N2tQmCPw42aVW6+WXa6j4dzCYdEFvXA/s0bwrCWY/vbjBJzILEPQU4YckdkJ1kc7zVpo
         FOrPmSS5JHhOD0ddM3fuhoJHzS3RdXzs89cFbifyy/8R/Ah3f/Sf9HO99/WwuM0dSMPh
         ucVk8oMa4kZ2wxA+wDl00F0MiojdNoiQlAa4SfM1Hg9a//XOuUbXMSIyGxdJCDCho1ZA
         Ts2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678802915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2fh50q0+/HEalk1h1oQC2pXaNeew6AKaitkp7RgML7Q=;
        b=OyM+gyYAw8hNo5CZ1hlQIFFe7UXfzhPlknlTSmHJnfDHG6i6fL50sxEKaDCew4RCGe
         Q3RkOufVGYUWK3cNM0VM1hRCsCZ5NXXkzb9zNl+KhyAGljptmjOFUdUt9Zx67zlmkyLN
         wps7NCAUt5/nbOToPOPjijMrPxR5nbkhSuBSUMpR8eJC5WpJ7FQJf0xhQ340m0nd2x7b
         J7Ew9wkLEFmy5fUWhfRgRaTvfGjh41JZpf0/FioeXLULKVCscSFAEA9UHTnEW4FBiVrE
         QUK2WZ9OaISlB+qpol4FRoCTCROvBLb0KRNsg+3HiUd6rZpKiV1IHbgWkhyKNKokGvf6
         hM+g==
X-Gm-Message-State: AO0yUKUGxxZ7xwFuGa3eSkYvbacqVHIm10px1dCp+9vfuvyl3hUdxU5m
        1KIoQClXP8PIrBNq9bMUG43EmTTYVf6QYgUX
X-Google-Smtp-Source: AK7set86cuDzNUeHz96tiWnCTlYRXr331XXgSySDYske0mghcxOZyatZQSOnYpKOjpb3zG7dWQVokw==
X-Received: by 2002:a05:6402:516a:b0:4fc:c7c8:e78d with SMTP id d10-20020a056402516a00b004fcc7c8e78dmr6730921ede.31.1678802914820;
        Tue, 14 Mar 2023 07:08:34 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.111.116])
        by smtp.gmail.com with ESMTPSA id kk1-20020a170907766100b0092b8c1f41ebsm1198352ejc.24.2023.03.14.07.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 07:08:34 -0700 (PDT)
Date:   Tue, 14 Mar 2023 19:08:31 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     outreachy@lists.linux.dev
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: axis-fifo: initialize timeouts in probe only
Message-ID: <ZBB/30ZBW9EU1QfK@khadija-virtual-machine>
References: <ZA9mThZ7NyRrQAMX@khadija-virtual-machine>
 <202303141159.6wN9HNP9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202303141159.6wN9HNP9-lkp@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 11:45:51AM +0800, kernel test robot wrote:
> Hi Khadija,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on staging/staging-testing]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Khadija-Kamran/staging-axis-fifo-initialize-timeouts-in-probe-only/20230314-020827
> patch link:    https://lore.kernel.org/r/ZA9mThZ7NyRrQAMX%40khadija-virtual-machine
> patch subject: [PATCH] staging: axis-fifo: initialize timeouts in probe only
> config: arm64-randconfig-r012-20230313 (https://download.01.org/0day-ci/archive/20230314/202303141159.6wN9HNP9-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # https://github.com/intel-lab-lkp/linux/commit/9d186f6c9f9bf467b48da3e28b0e9aa31fc3faf3
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Khadija-Kamran/staging-axis-fifo-initialize-timeouts-in-probe-only/20230314-020827
>         git checkout 9d186f6c9f9bf467b48da3e28b0e9aa31fc3faf3
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/staging/axis-fifo/
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303141159.6wN9HNP9-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
> >> drivers/staging/axis-fifo/axis-fifo.c:817:18: warning: implicit conversion from 'long' to 'int' changes value from 9223372036854775807 to -1 [-Wconstant-conversion]
>                    read_timeout = MAX_SCHEDULE_TIMEOUT;
>                                 ~ ^~~~~~~~~~~~~~~~~~~~
>    include/linux/sched.h:296:31: note: expanded from macro 'MAX_SCHEDULE_TIMEOUT'
>    #define MAX_SCHEDULE_TIMEOUT            LONG_MAX
>                                            ^~~~~~~~
>    include/vdso/limits.h:11:19: note: expanded from macro 'LONG_MAX'
>    #define LONG_MAX        ((long)(~0UL >> 1))
>                             ^~~~~~~~~~~~~~~~~
>    drivers/staging/axis-fifo/axis-fifo.c:822:19: warning: implicit conversion from 'long' to 'int' changes value from 9223372036854775807 to -1 [-Wconstant-conversion]
>                    write_timeout = MAX_SCHEDULE_TIMEOUT;
>                                  ~ ^~~~~~~~~~~~~~~~~~~~
>    include/linux/sched.h:296:31: note: expanded from macro 'MAX_SCHEDULE_TIMEOUT'
>    #define MAX_SCHEDULE_TIMEOUT            LONG_MAX
>                                            ^~~~~~~~
>    include/vdso/limits.h:11:19: note: expanded from macro 'LONG_MAX'
>    #define LONG_MAX        ((long)(~0UL >> 1))
>                             ^~~~~~~~~~~~~~~~~
>    2 warnings generated.
>

Hi everyone!
Kindly let me know if I should look into these warnings.
Thank you!

Regards,
Khadija


> 
> vim +817 drivers/staging/axis-fifo/axis-fifo.c
> 
>    805	
>    806	static int axis_fifo_probe(struct platform_device *pdev)
>    807	{
>    808		struct resource *r_mem; /* IO mem resources */
>    809		struct device *dev = &pdev->dev; /* OS device (from device tree) */
>    810		struct axis_fifo *fifo = NULL;
>    811		char *device_name;
>    812		int rc = 0; /* error return value */
>    813	
>    814		if (read_timeout >= 0)
>    815			read_timeout = msecs_to_jiffies(read_timeout);
>    816		else
>  > 817			read_timeout = MAX_SCHEDULE_TIMEOUT;
>    818	
>    819		if (write_timeout >= 0)
>    820			write_timeout = msecs_to_jiffies(write_timeout);
>    821		else
>    822			write_timeout = MAX_SCHEDULE_TIMEOUT;
>    823	
>    824		/* ----------------------------
>    825		 *     init wrapper device
>    826		 * ----------------------------
>    827		 */
>    828	
>    829		device_name = devm_kzalloc(dev, 32, GFP_KERNEL);
>    830		if (!device_name)
>    831			return -ENOMEM;
>    832	
>    833		/* allocate device wrapper memory */
>    834		fifo = devm_kzalloc(dev, sizeof(*fifo), GFP_KERNEL);
>    835		if (!fifo)
>    836			return -ENOMEM;
>    837	
>    838		dev_set_drvdata(dev, fifo);
>    839		fifo->dt_device = dev;
>    840	
>    841		init_waitqueue_head(&fifo->read_queue);
>    842		init_waitqueue_head(&fifo->write_queue);
>    843	
>    844		mutex_init(&fifo->read_lock);
>    845		mutex_init(&fifo->write_lock);
>    846	
>    847		/* ----------------------------
>    848		 *   init device memory space
>    849		 * ----------------------------
>    850		 */
>    851	
>    852		/* get iospace for the device */
>    853		r_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>    854		if (!r_mem) {
>    855			dev_err(fifo->dt_device, "invalid address\n");
>    856			rc = -ENODEV;
>    857			goto err_initial;
>    858		}
>    859	
>    860		/* request physical memory */
>    861		fifo->base_addr = devm_ioremap_resource(fifo->dt_device, r_mem);
>    862		if (IS_ERR(fifo->base_addr)) {
>    863			rc = PTR_ERR(fifo->base_addr);
>    864			goto err_initial;
>    865		}
>    866	
>    867		dev_dbg(fifo->dt_device, "remapped memory to 0x%p\n", fifo->base_addr);
>    868	
>    869		/* create unique device name */
>    870		snprintf(device_name, 32, "%s_%pa", DRIVER_NAME, &r_mem->start);
>    871		dev_dbg(fifo->dt_device, "device name [%s]\n", device_name);
>    872	
>    873		/* ----------------------------
>    874		 *          init IP
>    875		 * ----------------------------
>    876		 */
>    877	
>    878		rc = axis_fifo_parse_dt(fifo);
>    879		if (rc)
>    880			goto err_initial;
>    881	
>    882		reset_ip_core(fifo);
>    883	
>    884		/* ----------------------------
>    885		 *    init device interrupts
>    886		 * ----------------------------
>    887		 */
>    888	
>    889		/* get IRQ resource */
>    890		rc = platform_get_irq(pdev, 0);
>    891		if (rc < 0)
>    892			goto err_initial;
>    893	
>    894		/* request IRQ */
>    895		fifo->irq = rc;
>    896		rc = devm_request_irq(fifo->dt_device, fifo->irq, &axis_fifo_irq, 0,
>    897				      DRIVER_NAME, fifo);
>    898		if (rc) {
>    899			dev_err(fifo->dt_device, "couldn't allocate interrupt %i\n",
>    900				fifo->irq);
>    901			goto err_initial;
>    902		}
>    903	
>    904		/* ----------------------------
>    905		 *      init char device
>    906		 * ----------------------------
>    907		 */
>    908	
>    909		/* create character device */
>    910		fifo->miscdev.fops = &fops;
>    911		fifo->miscdev.minor = MISC_DYNAMIC_MINOR;
>    912		fifo->miscdev.name = device_name;
>    913		fifo->miscdev.groups = axis_fifo_attrs_groups;
>    914		fifo->miscdev.parent = dev;
>    915		rc = misc_register(&fifo->miscdev);
>    916		if (rc < 0)
>    917			goto err_initial;
>    918	
>    919		dev_info(fifo->dt_device, "axis-fifo created at %pa mapped to 0x%pa, irq=%i\n",
>    920			 &r_mem->start, &fifo->base_addr, fifo->irq);
>    921	
>    922		return 0;
>    923	
>    924	err_initial:
>    925		dev_set_drvdata(dev, NULL);
>    926		return rc;
>    927	}
>    928	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests
