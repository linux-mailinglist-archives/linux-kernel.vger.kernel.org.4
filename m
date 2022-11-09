Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743546224F9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 08:57:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiKIH5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 02:57:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiKIH5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 02:57:22 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11DBC1C12D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 23:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667980642; x=1699516642;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=b11OAt7034UMeGrgRP/0loZ9GIxLTwxteVa4x5MZM5k=;
  b=MP3GGGJyDmDLc5qqrbu/MRQibJVn/UvjCU4gY9jpwnTTEwU++rU/aCab
   XoHUgEzTarXQvPu4qAQHMnsyDx1Ztk5jXOuxypJUQQ8g2V2iYMnUMZGvp
   0mAASSSn8ib2nSX8KrpnDslx0bIfrt8BVbJAlwEwVnJD3t5Ha+sEmICca
   zy7m6ecPDMSwV17bY+665OEXHh6fmEuZm8fo5AyWHTHLcoPog0wVxh/Fz
   3kRk1OqX9EIr5D+tu4qv1ggu4XSKR0247MQiDn4QrKrROOoy7OTvk+jxw
   +QjG1/0ofueuZiKMHJJhRmpwhzRthypEUjz7ymPmEPZthm7/TaVyXOF7k
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="310912955"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="310912955"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 23:57:21 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="639110158"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="639110158"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.254.214.171]) ([10.254.214.171])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 23:57:19 -0800
Subject: Re: drivers/remoteproc/st_remoteproc.c:114:20: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
To:     Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Russell King <rmk+kernel@armlinux.org.uk>
References: <202211091154.quYhgunB-lkp@intel.com>
 <5f51b4bd-3bc2-487b-aacd-9d0a1129c615@app.fastmail.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <1e65634e-9184-d93f-6477-bbe96193a5e3@intel.com>
Date:   Wed, 9 Nov 2022 15:57:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <5f51b4bd-3bc2-487b-aacd-9d0a1129c615@app.fastmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/9/2022 3:33 PM, Arnd Bergmann wrote:
> On Wed, Nov 9, 2022, at 04:54, kernel test robot wrote:
>> tree:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>> master
>> head:   f141df371335645ce29a87d9683a3f79fba7fd67
>> commit: d803336abdbc1bfacdb32b2cf9f4fdbee072b8ee ARM: mm: kill unused
>> runtime hook arch_iounmap()
> 
> Thanks for the report, but I think it might be better to stop
> reporting address space violations from this patch, because it
> only started showing existing known issues with a slightly
> different error message, or flagging issues on arm32 that
> were previously shown on other architectures.

Hi Arnd,

Thanks for your advice, we'll add the commit to ignore list.

Best Regards,
Rong Chen

> 
>> sparse warnings: (new ones prefixed by >>)
>>     drivers/remoteproc/st_remoteproc.c:98:12: sparse: sparse: incorrect
>> type in assignment (different address spaces) @@     expected void *va
>> @@     got void [noderef] __iomem * @@
>>     drivers/remoteproc/st_remoteproc.c:98:12: sparse:     expected void
>> *va
>>     drivers/remoteproc/st_remoteproc.c:98:12: sparse:     got void
>> [noderef] __iomem *
>>>> drivers/remoteproc/st_remoteproc.c:114:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got void *va @@
> 
>        Arnd
> 
