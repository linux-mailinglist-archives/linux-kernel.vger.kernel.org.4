Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D8F61072D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 03:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234184AbiJ1BVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 21:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234664AbiJ1BVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 21:21:15 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57E5A5724
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 18:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666920074; x=1698456074;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Ke8xqmu74MBNu09uQSSx4fHz0nPg3J+30BU054HdydQ=;
  b=XttGRhTzk6zBMLhb6/iZ874my3GQ3n4As45v5tYJiRzZq7kHDF/vhahh
   TkadUO+PI1QI82NMprhdLK+Ji2IOkMvwhPdQCvGdDwxNTt2FkP42Fo+RX
   per694AT59Fra3BF+vHF3kSTvzwPeN2wZ1g8wzxICqo47z/WeIh+/W/n+
   mfm7HprPgP1Yy2Pg9WuGML/CIM/cgrJz+4PNIJP2xG1wp18aex/lzcxDs
   kNiN5L0C805mcsHG3SO4poYBX45fqbN79C4JfO+TsVYxCHQmY+aO4mugV
   ntJqsxtHv6M5E+Ht+sV0HyLTFTvRRo/IrM+lJHBB738IYybPHgvIO4ReQ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="372596215"
X-IronPort-AV: E=Sophos;i="5.95,219,1661842800"; 
   d="scan'208";a="372596215"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 18:21:14 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="775201002"
X-IronPort-AV: E=Sophos;i="5.95,219,1661842800"; 
   d="scan'208";a="775201002"
Received: from xlv2-mobl2.ccr.corp.intel.com (HELO [10.254.209.8]) ([10.254.209.8])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 18:21:12 -0700
Subject: Re: [tip:perf/core] BUILD SUCCESS
 dc39beffcfc19a8dd2a09c5818dcd1a4e9099033
To:     Peter Zijlstra <peterz@infradead.org>,
        kernel test robot <lkp@intel.com>
Cc:     x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org
References: <635aef44.eRNqJ814AXKXgqPJ%lkp@intel.com>
 <Y1r/15SeteYfbFbA@hirez.programming.kicks-ass.net>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <add681c0-b051-5426-357e-03eddc53f6b6@intel.com>
Date:   Fri, 28 Oct 2022 09:21:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <Y1r/15SeteYfbFbA@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/28/2022 6:01 AM, Peter Zijlstra wrote:
> On Fri, Oct 28, 2022 at 04:51:16AM +0800, kernel test robot wrote:
>> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
>> branch HEAD: dc39beffcfc19a8dd2a09c5818dcd1a4e9099033  perf: Optimize perf_tp_event()
> 
> The robot is still broken:
> 
>    202210272227.jWuKg5y6-lkp@intel.com
> 

Hi Peter,

Sorry about that, we'll fix it asap.

Best Regards,
Rong Chen
