Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 615286192AE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 09:23:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiKDIXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 04:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiKDIXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 04:23:06 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA62226AC1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 01:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667550185; x=1699086185;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=7Y+gkhAAp0u7K1e9Tn7vtLtpxEKEw1yXGZ/7gmkDqig=;
  b=gm2kdSbKsCbgwye+Cdd7BeBlpGnHkTYtErAruQxf0TbhzmPb9i6doChj
   SzUd118Oqc5y6K9bkvrAMM5YGWy41dOqRlJ/7YW9zFvVXmK+v2O+1Hprt
   PA9pxOXowqwyI3sAo2HkeTbK/+9AP3XKfHP84YaoMpL2RZ9KDjiwcWsOv
   xGrGMOqmDnwEkd1gBdR0HboBesmjpNSSpmA2zQtcingNQwA/vKt+yc2Ff
   btoGzvj8AGAsTpYFIlnVgEiT7PvDHgbIuIdYuJfksvJwSsO/uq+f4ofn2
   X/KpOWpNi5e8VrkP8MEYXr3v2g8sx6xhoDCs1H2rFZrmq1i2H1vQn+FTn
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="308625393"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="308625393"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 01:23:05 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="880214608"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="880214608"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.254.215.240]) ([10.254.215.240])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 01:23:03 -0700
Subject: Re: FAILED: load BTF from vmlinux: No such file or directory
To:     Mark Brown <broonie@kernel.org>, kernel test robot <lkp@intel.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
References: <202211030542.t5oB7Bw6-lkp@intel.com>
 <Y2Lig+5ak3zKuPa1@sirena.org.uk>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <80c8a969-b88c-fec3-ac32-0a61295decd6@intel.com>
Date:   Fri, 4 Nov 2022 16:23:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <Y2Lig+5ak3zKuPa1@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/3/2022 5:34 AM, Mark Brown wrote:
> On Thu, Nov 03, 2022 at 05:27:38AM +0800, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   8e5423e991e8cd0988d0c4a3f4ac4ca1af7d148a
>> commit: 4e8ff35878685291978b93543d6b9e9290be770a ASoC: codecs: tlv320adc3xxx: Wrap adc3xxx_i2c_remove() in __exit_p()
>> date:   2 weeks ago
>> config: arc-buildonly-randconfig-r004-20221103
>> compiler: arceb-elf-gcc (GCC) 12.1.0
> 
> ...
> 
>> All errors (new ones prefixed by >>):
>>
>>     Complex, interval and imaginary float types are not supported
>>     Encountered error while encoding BTF.
>>>> FAILED: load BTF from vmlinux: No such file or directory
> 
> This looks very much like a false positive, it is difficult to
> understand how a change such as the one identified could trigger such an
> issue.
> 

Hi Mark,

Sorry for the noise, it's a false positive, the commit here fixed a 
error and let the build process continuing which let the bot thought
the new error is from this commit.

Best Regards,
Rong Chen
