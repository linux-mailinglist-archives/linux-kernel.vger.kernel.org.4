Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517A861A02F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 19:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbiKDSmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 14:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiKDSmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 14:42:01 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C261326C0
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 11:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667587320; x=1699123320;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=v/o8zarpAlq27GAzWPdFSA3sk+v/d/vyRl49BFPdGBw=;
  b=GjvvjPl7AAxITl3RshUNguMPit5B9064/QUjKITApvS6VkPIU4iS6UJU
   lAHb4BZ4Rr6Lx0L6fzwLoHuphL34+8QneteZZpPz2PnnIB0mHca2weENO
   zEdIxHc+C2WvoszNsBXfFCQfgCt9oOm9yRrH6qX9LxCjO9XxUlwJBnQEq
   t4rmVMxLE4GC9UKe+tGpz0GTPvs/E7OtNRpuqSFOYf1YEtjy/qwuAkRWe
   ZqPUTVvKnAdQOKI6pyBfAv0wfbSERcM+fG+hNfDCjH4pStoaLhuLkcGqi
   zPHRcUD3Wbe1tKhErsp0Pal7S2z7ufSCSzbg/GRA+mgJM9CyfAmtxUzpi
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="311162464"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="311162464"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 11:42:00 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="635188429"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="635188429"
Received: from anantsin-mobl2.amr.corp.intel.com (HELO [10.209.97.57]) ([10.209.97.57])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 11:42:00 -0700
Message-ID: <1897905e-6e37-a13b-acc7-2ab458aadfe0@intel.com>
Date:   Fri, 4 Nov 2022 11:42:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] x86/cpu: Add several Intel server CPU mode numbers
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev
References: <20221103203310.5058-1-tony.luck@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221103203310.5058-1-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/22 13:33, Tony Luck wrote:
> These servers are all on the public versions of the roadmap. The model
> numbers for Grand Ridge, Granite Rapids, and Sierra Forest were included
> in the September 2022 edition of the Instruction Set Extensions document.
...
>  #define INTEL_FAM6_SAPPHIRERAPIDS_X	0x8F	/* Golden Cove */
>  
> +#define INTEL_FAM6_EMERALDRAPIDS_X	0xCF

Were the core names (like Golden Cove) left out intentionally?  Not a
big deal either way, but it's sometimes nice to see for things like the
hybrid parts what it might be "related" to.

Either way:

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
