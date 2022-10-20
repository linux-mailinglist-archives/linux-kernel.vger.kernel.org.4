Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906F6605484
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 02:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiJTAeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 20:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiJTAeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 20:34:02 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D1B1B2B9F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 17:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666226041; x=1697762041;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=87qpzl5VuBgixsuakBVkMxYZabfA2HU7mgCTHOJupqk=;
  b=jY1mdYOO/CBu/h2vYY57Cd6hId40w8/AZJssBaAPl8IlmhhKjaeXZlwf
   vOXZDpkVwm7Y3CPqcUD067NvVxu0ffzaO5lGcfSaDRreiaCzFGbVXzfU9
   SWI+h9jBXFU5iNyNDKdfPr1HTMX/6DoWlqr24r46acS9Udw3dfaE0WwhV
   ECpkMteLF2wTpYNrTrPEPj1ZEwN6DSK3vYq9r8mlWyBZhC0R6RV5mf9wx
   Rh6yPBxDeTWHntlUUQwkyAvAnNEBDGoqDDNatcUR/SKkP+X9iP4AE+azu
   0bDEI0TWnkiwN+1CD9j73yiei6SsbmimYkVi/vZ1rjZxH74BqSEt6+PpR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="286962885"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="286962885"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 17:34:00 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="772044405"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="772044405"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.173.192]) ([10.249.173.192])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 17:33:59 -0700
Subject: Re: [kbuild-all] Re: drivers/firmware/efi/libstub/zboot.c:163:1:
 sparse: sparse: symbol 'efi_zboot_entry' was not declared. Should it be
 static?
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
References: <202210190351.b33PaxC4-lkp@intel.com>
 <CAMj1kXEUs-CTpM2LJ_9+yH3Gy+N+dm51M7VvNpKNAsRBTDCRaw@mail.gmail.com>
 <def83285-af62-f0c4-dcaa-f9e54aaba768@intel.com>
 <CAMj1kXFG243S0awWUHD4xWidG8nsRamVBk9CC8QYz2hbkgBWxQ@mail.gmail.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <cfc54875-d9c0-b641-b275-ad728b1ad3af@intel.com>
Date:   Thu, 20 Oct 2022 08:33:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXFG243S0awWUHD4xWidG8nsRamVBk9CC8QYz2hbkgBWxQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/19/2022 5:11 PM, Ard Biesheuvel wrote:
> On Wed, 19 Oct 2022 at 11:10, Chen, Rong A <rong.a.chen@intel.com> wrote:
>>
>>
>>
>> On 10/19/2022 3:50 AM, Ard Biesheuvel wrote:
>>> This is another spurious report of an asmlinkage symbol.
>>
>> Hi Ard,
>>
>> Thanks for your reply, we'll add this warning to the ignore list.
>>
> 
> Thank you Rong.
> 
> Wouldn't it be easier to detect the asmlinkage and never warn on it?

Hi Ard,

We'll try to search asmlinkage from code if the sparse warning occurred.

Best Regards,
Rong Chen

> Maybe this should be sparse's job instead ...
> 
> 
>>
>>>
>>> On Tue, 18 Oct 2022 at 21:49, kernel test robot <lkp@intel.com> wrote:
>>>>
>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>>> head:   bb1a1146467ad812bb65440696df0782e2bc63c8
>>>> commit: a050910972bb25152b42ad2e544652117c5ad915 efi/libstub: implement generic EFI zboot
>>>> date:   4 weeks ago
>>>> config: riscv-randconfig-s043-20221018
>>>> compiler: riscv64-linux-gcc (GCC) 12.1.0
>>>> reproduce:
>>>>           wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>>           chmod +x ~/bin/make.cross
>>>>           # apt-get install sparse
>>>>           # sparse version: v0.6.4-39-gce1a6720-dirty
>>>>           # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a050910972bb25152b42ad2e544652117c5ad915
>>>>           git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>>           git fetch --no-tags linus master
>>>>           git checkout a050910972bb25152b42ad2e544652117c5ad915
>>>>           # save the config file
>>>>           mkdir build_dir && cp config build_dir/.config
>>>>           COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=riscv SHELL=/bin/bash drivers/firmware/efi/libstub/ lib/xz/
>>>>
>>>> If you fix the issue, kindly add following tag where applicable
>>>> | Reported-by: kernel test robot <lkp@intel.com>
>>>>
>>>> sparse warnings: (new ones prefixed by >>)
>>>>      WARNING: invalid argument to '-march': '_zihintpause'
>>>>      drivers/firmware/efi/libstub/zboot.c: note: in included file (through drivers/firmware/efi/libstub/../../../../lib/decompress_unxz.c):
>>>>>> drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:393:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le32 const [usertype] *p @@     got unsigned int const [usertype] * @@
>>>>      drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:393:28: sparse:     expected restricted __le32 const [usertype] *p
>>>>      drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:393:28: sparse:     got unsigned int const [usertype] *
>>>>      drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:427:48: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le32 const [usertype] *p @@     got unsigned int const [usertype] * @@
>>>>      drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:427:48: sparse:     expected restricted __le32 const [usertype] *p
>>>>      drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:427:48: sparse:     got unsigned int const [usertype] *
>>>>      drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:435:37: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le32 const [usertype] *p @@     got unsigned int const [usertype] * @@
>>>>      drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:435:37: sparse:     expected restricted __le32 const [usertype] *p
>>>>      drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:435:37: sparse:     got unsigned int const [usertype] *
>>>>      drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:459:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected restricted __le32 const [usertype] *p @@     got unsigned int const [usertype] * @@
>>>>      drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:459:28: sparse:     expected restricted __le32 const [usertype] *p
>>>>      drivers/firmware/efi/libstub/../../../../lib/xz/xz_dec_stream.c:459:28: sparse:     got unsigned int const [usertype] *
>>>>>> drivers/firmware/efi/libstub/zboot.c:163:1: sparse: sparse: symbol 'efi_zboot_entry' was not declared. Should it be static?
>>>>
>>>> vim +/efi_zboot_entry +163 drivers/firmware/efi/libstub/zboot.c
>>>>
>>>>      161
>>>>      162  asmlinkage efi_status_t __efiapi
>>>>    > 163  efi_zboot_entry(efi_handle_t handle, efi_system_table_t *systab)
>>>>
>>>> --
>>>> 0-DAY CI Kernel Test Service
>>>> https://01.org/lkp
>>> _______________________________________________
>>> kbuild-all mailing list -- kbuild-all@lists.01.org
>>> To unsubscribe send an email to kbuild-all-leave@lists.01.org
>>>
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
> 
