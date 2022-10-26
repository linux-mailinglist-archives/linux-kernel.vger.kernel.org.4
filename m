Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26BF60DCFC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 10:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiJZIXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 04:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233159AbiJZIXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 04:23:44 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34696C458C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 01:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666772624; x=1698308624;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=idCJqZoO1jKQHHxI2CG4bg0AEYuj2yQ23It3QVMRFUU=;
  b=GOlXkPsjeZIINZQDD/DCE8Yp7QJ9ZOb8ZJSwXO41qgKVLvhH5ChJnH+b
   Fqlza46TsTlVRuvP6yiqtefoLaWX21Lxhea/f/Oep/n5nwdOkaj8qZjZ5
   kIYnNfzAoUna3/VCj+7uUo5WMuuW3ySOrPp+j0QqoG/1Qs967MMDfCLNe
   CDvdUmgIXTIvksEneoFY2nnRfFqdj1oFL2QfJtjC0s1mvDlrkQoGuwfNU
   ZmFHW+rrnnnCcYweRp/3/AYWDrQJ4l4Tb/O2mfyMucpvHigxWvwGKkZw7
   Fm6/KVNjkQkPcyJhbu4kpmVdtE+qTNhNlCFi8FW4y/FYMJb6AR1f5KzxO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="372101907"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="372101907"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 01:23:43 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="665210000"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="665210000"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.254.209.199]) ([10.254.209.199])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 01:23:42 -0700
Subject: Re: [kbuild-all] Re: drivers/net/ethernet/renesas/rswitch.c:355:71:
 warning: left shift count >= width of type
To:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202210222356.2lAehSmv-lkp@intel.com>
 <caa1e514-1fa3-229c-3772-91357240d6f4@infradead.org>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <b6061fb6-51f9-6358-7318-561984fde181@intel.com>
Date:   Wed, 26 Oct 2022 16:23:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <caa1e514-1fa3-229c-3772-91357240d6f4@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/26/2022 1:49 PM, Randy Dunlap wrote:
> Hi k.t.r.,
> 
> On 10/22/22 08:23, kernel test robot wrote:
>> tree:   https://github.com/intel-lab-lkp/linux/commits/Yoshihiro-Shimoda/net-phy-marvell10g-Add-host-speed-setting-by-an-ethernet-driver/20221020-091402
>> head:   54882d9015d6bc070075b3ab4eab5cf4d75cf56e
>> commit: 77bfe15a20a8c80e2150e86970e1157acfca24f8 net: ethernet: renesas: Add Ethernet Switch driver
>> date:   3 days ago
>> config: parisc64-allyesconfig
> 
> The attached .config file does not contain "CONFIG_64BIT".
> How did you generate it?

Hi Randy,

Thanks for your reply, the config name is wrong,
it should be parisc-allyesconfig (we use `make ARCH=parisc allyesconfig` 
to generate).

> 
> (more below)
> 
> 
>> compiler: hppa-linux-gcc (GCC) 12.1.0
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://github.com/intel-lab-lkp/linux/commit/77bfe15a20a8c80e2150e86970e1157acfca24f8
>>          git remote add linux-review https://github.com/intel-lab-lkp/linux
>>          git fetch --no-tags linux-review Yoshihiro-Shimoda/net-phy-marvell10g-Add-host-speed-setting-by-an-ethernet-driver/20221020-091402
>>          git checkout 77bfe15a20a8c80e2150e86970e1157acfca24f8
>>          # save the config file
>>          mkdir build_dir && cp config build_dir/.config
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/media/platform/chips-media/ drivers/net/ethernet/renesas/ drivers/staging/vt6655/
> 
> For 64BIT parisc builds, it would be better to use
> 	ARCH=parisc64
> 
> See 805ce8614958: parisc: Allow CONFIG_64BIT with ARCH=parisc
> and 3dcfb729b5f4: parisc: Make CONFIG_64BIT available for ARCH=parisc64 only
> 
> To use only ARCH=parisc, you must ensure that both PA8X00=y and 64BIT=y in the .config file.

We'll take a look to use ARCH=parsic64 instead of ARCH=parsic.

Best Regards,
Rong Chen

> 
> 
>> If you fix the issue, kindly add following tag where applicable
>> | Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>     drivers/net/ethernet/renesas/rswitch.c: In function 'rswitch_ext_desc_get_dptr':
>>>> drivers/net/ethernet/renesas/rswitch.c:355:71: warning: left shift count >= width of type [-Wshift-count-overflow]
>>       355 |         return __le32_to_cpu(desc->dptrl) | (dma_addr_t)(desc->dptrh) << 32;
>>           |                                                                       ^~
>>     drivers/net/ethernet/renesas/rswitch.c: In function 'rswitch_ext_ts_desc_get_dptr':
>>     drivers/net/ethernet/renesas/rswitch.c:367:71: warning: left shift count >= width of type [-Wshift-count-overflow]
>>       367 |         return __le32_to_cpu(desc->dptrl) | (dma_addr_t)(desc->dptrh) << 32;
>>           |                                                                       ^~
>>
>>
>> vim +355 drivers/net/ethernet/renesas/rswitch.c
>>
>>     352	
>>     353	static dma_addr_t rswitch_ext_desc_get_dptr(struct rswitch_ext_desc *desc)
>>     354	{
>>   > 355		return __le32_to_cpu(desc->dptrl) | (dma_addr_t)(desc->dptrh) << 32;
>>     356	}
>>     357	
>>
> 
