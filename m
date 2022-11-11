Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7537562641A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 23:01:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbiKKWBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 17:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbiKKWBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 17:01:05 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321EA8B44C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 13:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=beLHtOxF6kCxGUTEGseHfS+O7VRs82p3voVTAU84sF8=; b=msZ2/Yz8u4rU76Y8q6ZG9RDy/u
        7eIwj4NAo98Ht1vduN9HBVABDWJRrPOOHpIJC0OLhPaqdrxmITHHcZqZqFYPGpbEw/KtQngTLuv43
        oY+KU7edg+2JE+J2t3XnT4x7ehP0QhtwVUvT1v/zRe4IZ+3u62nvHsB2x1fRs+gb9qOXu/qYGZtCG
        //Axo3CoxrQScDAY2vDv7GEgwjms8lvMREr+GB7vzsDD9Hp4VKvirZWVnf4CiY0G/t7F0zlulTkaB
        ViNiYfKOkAUtaUutotnmTx9bDFK+fbCVLtgYQsNjT1VKx3eAkbbvFmoZHF66M/n67f6nRPOPQO+O0
        dkSHsabw==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1otc3p-001OrX-1l; Fri, 11 Nov 2022 21:59:41 +0000
Message-ID: <d81630d5-756c-4067-fc1b-47e5f56cad33@infradead.org>
Date:   Fri, 11 Nov 2022 13:59:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: Re: ld.lld: error: undefined symbol: firmware_upload_register
To:     kernel test robot <lkp@intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Xu Yilun <yilun.xu@intel.com>
References: <202211092004.GI7IL067-lkp@intel.com>
Content-Language: en-US
In-Reply-To: <202211092004.GI7IL067-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 11/9/22 04:30, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   f141df371335645ce29a87d9683a3f79fba7fd67
> commit: 5cd339b370e29b04b85fbb83f40496991465318e fpga: m10bmc-sec: add max10 secure update functions
> date:   5 months ago
> config: mips-buildonly-randconfig-r004-20221109
> compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 463da45892e2d2a262277b91b96f5f8c05dc25d0)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install mips cross compiling tool for clang build
>         # apt-get install binutils-mips-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5cd339b370e29b04b85fbb83f40496991465318e
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 5cd339b370e29b04b85fbb83f40496991465318e
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> ld.lld: error: undefined symbol: firmware_upload_register
>    >>> referenced by intel-m10-bmc-sec-update.c
>    >>>               fpga/intel-m10-bmc-sec-update.o:(m10bmc_sec_probe) in archive drivers/built-in.a
> --
>>> ld.lld: error: undefined symbol: firmware_upload_unregister
>    >>> referenced by intel-m10-bmc-sec-update.c
>    >>>               fpga/intel-m10-bmc-sec-update.o:(m10bmc_sec_remove) in archive drivers/built-in.a


This happens when (bool) CONFIG_FW_UPLOAD=y and CONFIG_FW_LOADER=m.
Ah, it's the old "bool depending on a tristate" problem.

There may be some Makefile fix for this - I don't know.

Or the Kconfig fix works AFAICT (below). Change FW_UPLOAD to a tristate
and modify 2 header files for exports/inlines.

Luis -- how was FW_LOADER=m and FW_UPLOAD=y supposed to work?

Thanks.
-- 
---
 drivers/base/firmware_loader/Kconfig |    2 +-
 drivers/base/firmware_loader/sysfs.h |    2 +-
 include/linux/firmware.h             |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff -- a/drivers/base/firmware_loader/Kconfig b/drivers/base/firmware_loader/Kconfig
--- a/drivers/base/firmware_loader/Kconfig
+++ b/drivers/base/firmware_loader/Kconfig
@@ -204,7 +204,7 @@ config FW_CACHE
 	  If unsure, say Y.
 
 config FW_UPLOAD
-	bool "Enable users to initiate firmware updates using sysfs"
+	tristate "Enable users to initiate firmware updates using sysfs"
 	select FW_LOADER_SYSFS
 	select FW_LOADER_PAGED_BUF
 	help
diff -- a/drivers/base/firmware_loader/sysfs.h b/drivers/base/firmware_loader/sysfs.h
--- a/drivers/base/firmware_loader/sysfs.h
+++ b/drivers/base/firmware_loader/sysfs.h
@@ -99,7 +99,7 @@ struct fw_sysfs *
 fw_create_instance(struct firmware *firmware, const char *fw_name,
 		   struct device *device, u32 opt_flags);
 
-#ifdef CONFIG_FW_UPLOAD
+#if IS_ENABLED(CONFIG_FW_UPLOAD)
 extern struct device_attribute dev_attr_status;
 extern struct device_attribute dev_attr_error;
 extern struct device_attribute dev_attr_cancel;
diff -- a/include/linux/firmware.h b/include/linux/firmware.h
--- a/include/linux/firmware.h
+++ b/include/linux/firmware.h
@@ -170,7 +170,7 @@ static inline int request_partial_firmwa
 
 #endif
 
-#ifdef CONFIG_FW_UPLOAD
+#if IS_ENABLED(CONFIG_FW_UPLOAD)
 
 struct fw_upload *
 firmware_upload_register(struct module *module, struct device *parent,


