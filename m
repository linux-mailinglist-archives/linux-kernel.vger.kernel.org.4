Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349B17492FF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 03:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232546AbjGFBSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 21:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbjGFBSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 21:18:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D314F1703
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 18:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=RNqj58sR6D2iCKUxyhJptVbzfTzgXZ/kvCTP8dmpNJQ=; b=UyUETjxTTWij72ndUBaCJj6d7H
        aLKeV2tVHZ12Ji4JGFUC9YyJAhdQAevae+N33ZkbBrM9ilr2FTc9jTxwj7bctsenXfAmEjfs+66yz
        lsPOBfNo3TF3v/IlaAIsHKo11RWJ+zpnxqCSJ17A1W4iMeGgNy+417rzFvdvpMTiGddddXRSDPZ4U
        56d0BFCPdAyW6MxEIZQ24+z0EUUBBVfJW/2PxJlcL4e+ojKEp4JoRIrVM19fA3ppxyXz6VJeOVBws
        26M/OGmjftFcLEOk3M+ULlY8KsN4awWV/sTtFRPXw3BHC9awXVmnAQu+CSIZbbolk2+oces2u/LBr
        MzLUTXNw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qHDd3-00HY8z-2I;
        Thu, 06 Jul 2023 01:17:53 +0000
Message-ID: <84c4b254-0bfd-b72f-c3c1-69afa45a0874@infradead.org>
Date:   Wed, 5 Jul 2023 18:17:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: ld.lld: error: undefined symbol: firmware_upload_register
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>
References: <202307060742.vdkvv1Z3-lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <202307060742.vdkvv1Z3-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/5/23 16:43, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   73a3fcdaa73200e38e38f7e8a32c9b901c5b95b5
> commit: 9521875bbe0055805557fff0b08fd9a29d02b7bc cxl: add a firmware update mechanism using the sysfs firmware loader
> date:   10 days ago
> config: x86_64-randconfig-x016-20230706 (https://download.01.org/0day-ci/archive/20230706/202307060742.vdkvv1Z3-lkp@intel.com/config)
> compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
> reproduce: (https://download.01.org/0day-ci/archive/20230706/202307060742.vdkvv1Z3-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202307060742.vdkvv1Z3-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
>>> ld.lld: error: undefined symbol: firmware_upload_register
>    >>> referenced by memdev.c:836 (drivers/cxl/core/memdev.c:836)
>    >>>               drivers/cxl/core/memdev.o:(cxl_memdev_setup_fw_upload) in archive vmlinux.a
> --
>>> ld.lld: error: undefined symbol: firmware_upload_unregister
>    >>> referenced by memdev.c:824 (drivers/cxl/core/memdev.c:824)
>    >>>               drivers/cxl/core/memdev.o:(cxl_memdev_setup_fw_upload) in archive vmlinux.a
>    >>> referenced by memdev.c:824 (drivers/cxl/core/memdev.c:824)
>    >>>               drivers/cxl/core/memdev.o:(devm_cxl_remove_fw_upload) in archive vmlinux.a
> 


Fix from Arnd:
https://lore.kernel.org/all/20230703112928.332321-1-arnd@kernel.org/

-- 
~Randy
