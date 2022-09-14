Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA555B8F0B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 20:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiINStX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 14:49:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiINStV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 14:49:21 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E647C304;
        Wed, 14 Sep 2022 11:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663181360; x=1694717360;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wKdkMK97QvN1TsEP3F9ViaVJj7ucJDq4Hjzmntz6m2c=;
  b=Fh3UtvoxU1spmzbIPrSWppRmZpmkUFZ+B90LH5RNlU588MW+WGKnG7Lr
   8fLeg3tjw5+VQDuV+5aETlRQEyuScdrS3DEUVOY/5X/TbCtrWPhbDiVMj
   3KJ2Cg9m1fIrmQFXMhhp9ag9jg5PicocMWSP7S+Zj136IxarKHCSRWoUi
   gjHK3lGuQsB8Aln4MsaxYcnxKvfT5c+bBLyHUm7R/9+Blzb39WaexLHsi
   z2GN5OkwlNwmhBtPJliYx1+Ts1RCv4cDLdCyLQOnqikjydlBj4UT1Ic9J
   8TdhPgvmaKepd4VpgPbW4U/FJ210ZeIa1QpIGDziy1zLWG7/6p6LzWGAg
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="299873381"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="299873381"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 11:49:19 -0700
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="720687930"
Received: from msmurdoc-mobl1.amr.corp.intel.com (HELO spandruv-desk1.amr.corp.intel.com) ([10.209.88.211])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 11:49:19 -0700
Message-ID: <6768bf65227ac1da28255e192464bfe15b0403d4.camel@linux.intel.com>
Subject: Re: [PATCH] tools/power/x86/intel-speed-select: Remove duplicate
 macro
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Risheng1128 <hi4u29ck02@gmail.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 14 Sep 2022 11:49:18 -0700
In-Reply-To: <20220610172714.27772-1-hi4u29ck02@gmail.com>
References: <20220610172714.27772-1-hi4u29ck02@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-06-11 at 01:27 +0800, Risheng1128 wrote:
> There are some macros such as `GENMASK` and `GENMASK_ULL` are
> redefined in
> `include/linux/bits.h`. Simultaneously, the `GENMASK` in
> `include/linux/bits.h` is more secure and prevents the following
> situation.
> 1. [net: stmmac: Fix misuses of GENMASK
> macro](https://reurl.cc/loMWvl)
> 2. [clocksource/drivers/npcm: Fix misuse of GENMASK macro](
> https://reurl.cc/b2yr96)
> 
> Therefore, I think these macro could be removed.
> 
Sorry missed this one.

> Signed-off-by: Risheng1128 <hi4u29ck02@gmail.com>
Please follow
https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html
Developer’s Certificate of Origin 1.1

It says

"using your real name (sorry, no pseudonyms or anonymous
contributions.)"

Thanks,
Srinivas




> ---
>  tools/power/x86/intel-speed-select/Makefile | 1 +
>  tools/power/x86/intel-speed-select/isst.h   | 7 +------
>  2 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/power/x86/intel-speed-select/Makefile
> b/tools/power/x86/intel-speed-select/Makefile
> index 7221f2f55e8b..760d49d61955 100644
> --- a/tools/power/x86/intel-speed-select/Makefile
> +++ b/tools/power/x86/intel-speed-select/Makefile
> @@ -14,6 +14,7 @@ endif
>  # (this improves performance and avoids hard-to-debug behaviour);
>  MAKEFLAGS += -r
>  override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include -
> I/usr/include/libnl3
> +override CFLAGS += -I../../../include
>  override LDFLAGS += -lnl-genl-3 -lnl-3
>  
>  ALL_TARGETS := intel-speed-select
> diff --git a/tools/power/x86/intel-speed-select/isst.h
> b/tools/power/x86/intel-speed-select/isst.h
> index 0796d8c6a882..44de990d182e 100644
> --- a/tools/power/x86/intel-speed-select/isst.h
> +++ b/tools/power/x86/intel-speed-select/isst.h
> @@ -27,12 +27,7 @@
>  
>  #include <stdarg.h>
>  #include <sys/ioctl.h>
> -
> -#define BIT(x) (1 << (x))
> -#define BIT_ULL(nr) (1ULL << (nr))
> -#define GENMASK(h, l) (((~0UL) << (l)) & (~0UL >> (sizeof(long) * 8
> - 1 - (h))))
> -#define GENMASK_ULL(h,
> l)                                                      \
> -       (((~0ULL) << (l)) & (~0ULL >> (sizeof(long long) * 8 - 1 -
> (h))))
> +#include <linux/bits.h>
>  
>  #define CONFIG_TDP                             0x7f
>  #define CONFIG_TDP_GET_LEVELS_INFO             0x00

