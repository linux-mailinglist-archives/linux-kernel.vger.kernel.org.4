Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59AF603EFA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 11:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbiJSJZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 05:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbiJSJYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 05:24:03 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E18BC468
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 02:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666170651; x=1697706651;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=96p+5dCXwU2m7O55lU9X3Il4Dil7vRTS9IgtZq7J2pY=;
  b=oI+w5r4bMpwnA+uV5uleQHzptopmE47PBVVmRJ5Fot4xMXSbbDm+f3sz
   j9KN7Ys0mO45n5DMJnwGeslsYbOmeaK4t7+Bmp20WXn0gFQpmoezZr5ZM
   yqOD5uSVXeRGZ0T+a3tRRu6jvuFwFQpurQouXFgPGWd4JhBKDa9FPXjz0
   LOTt9/AcXJHOEvLRvBkqzPOgqYh3LyxWo4+ZP9THhUUYDjh4ZGzCwCcVo
   oFXXL1xa1t4DaE/wEiU5/F6gEc9JoVyMYCnPKSQ4xqQXzFbHybTkqIDYn
   2QC410v+vt//1Fn7r1KopbvXFoTUUQqg9AEadG3MzbFtFyEWcWfF7jvNE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="306343342"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="306343342"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:09:49 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="734117114"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="734117114"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.170.146]) ([10.249.170.146])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:09:48 -0700
Subject: Re: [kbuild-all] Re: drivers/firmware/efi/libstub/zboot.c:163:1:
 sparse: sparse: symbol 'efi_zboot_entry' was not declared. Should it be
 static?
To:     Ard Biesheuvel <ardb@kernel.org>, kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202210190351.b33PaxC4-lkp@intel.com>
 <CAMj1kXEUs-CTpM2LJ_9+yH3Gy+N+dm51M7VvNpKNAsRBTDCRaw@mail.gmail.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <def83285-af62-f0c4-dcaa-f9e54aaba768@intel.com>
Date:   Wed, 19 Oct 2022 17:09:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXEUs-CTpM2LJ_9+yH3Gy+N+dm51M7VvNpKNAsRBTDCRaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/2022 3:50 AM, Ard Biesheuvel wrote:
> This is another spurious report of an asmlinkage symbol.

Hi Ard,

Thanks for your reply, we'll add this warning to the ignore list.

Best Regards,
Rong Chen

> 
> On Tue, 18 Oct 2022 at 21:49, kernel test robot <lkp@intel.com> wrote:
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   bb1a1146467ad812bb65440696df0782e2bc63c8
>> commit: a050910972bb25152b42ad2e544652117c5ad915 efi/libstub: implement generic EFI zboot
>> date:   4 weeks ago
>> config: riscv-randconfig-s043-20221018
>> compiler: riscv64-linux-gcc (GCC) 12.1.0
>> reproduce:
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # apt-get install sparse
>>          # sparse version: v0.6.4-39-gce1a6720-dirty
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a050910972bb25152b42ad2e544652117c5ad915
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout a050910972bb25152b42ad2e544652117c5ad915
>>          # save the config file
>>          mkdir build_dir && cp config build_dir/.config
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash drivers/firmware/efi/libstub/ lib/xz/
>>
>> If you fix the issue, kindly add following tag where applicable
>> | Reported-by: kernel test robot <lkp@intel.com>
>>
>> sparse warnings: (new ones prefixed by >>)
>>     WARNING: invalid argument to '-march': '_zihintpause'
>>     drivers/firmware/efi/libstub/zboot.c: note: in included file (through drivers/firmware/efi/libstub/../../../../lib/decompress_unxz.c):
>>>> drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:393:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le32 const [usertype] *p @@     got unsigned int const [usertype] * @@
>>     drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:393:28: sparse:     expected restricted __le32 const [usertype] *p
>>     drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:393:28: sparse:     got unsigned int const [usertype] *
>>     drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:427:48: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le32 const [usertype] *p @@     got unsigned int const [usertype] * @@
>>     drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:427:48: sparse:     expected restricted __le32 const [usertype] *p
>>     drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:427:48: sparse:     got unsigned int const [usertype] *
>>     drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:435:37: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le32 const [usertype] *p @@     got unsigned int const [usertype] * @@
>>     drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:435:37: sparse:     expected restricted __le32 const [usertype] *p
>>     drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:435:37: sparse:     got unsigned int const [usertype] *
>>     drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:459:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le32 const [usertype] *p @@     got unsigned int const [usertype] * @@
>>     drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:459:28: sparse:     expected restricted __le32 const [usertype] *p
>>     drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:459:28: sparse:     got unsigned int const [usertype] *
>>>> drivers/firmware/efi/libstub/zboot.c:163:1: sparse: sparse: symbol 'efi_zboot_entry' was not declared. Should it be static?
>>
>> vim +/efi_zboot_entry +163 drivers/firmware/efi/libstub/zboot.c
>>
>>     161
>>     162  asmlinkage efi_status_t __efiapi
>>   > 163  efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
>>
>> --
>> 0-DAY CI Kernel Test Service
>> https://01.org/lkp
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
> 
