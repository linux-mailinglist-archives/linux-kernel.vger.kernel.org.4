Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7509F7325C7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 05:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241838AbjFPDSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 23:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242415AbjFPDRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 23:17:49 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556501FE8;
        Thu, 15 Jun 2023 20:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686885457; x=1718421457;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=U669CxqKeYrlEExe4cllzHlyM9/w82AvKRW4naxbKxk=;
  b=CebfMNlhaykDwxrND2bk4tQL9wqalb0uBhRR3JWcqFVcZYVkWBEp6FGj
   Hj+vdJ03dqUBP0H/SFs5fwN/pEEpdahl8yzfaRqL9nWhZ6GAS3MBRW8DC
   uUhVE3IRfMT+XN3efGkkzCIPEDySz1o9YGi1AgKZMsEnQXyIZJaiFqX7f
   o46vW74OuA9PHJ2Q5656VyjhxkPC/HiMlUjmJZsVFBmMhRnMfzXRGa4yL
   C2Y1P3AaMKNEN47WGr6xt66u2f2OoEpwlFFhrfpx1PhGkTkiMluNS48yt
   JmANfP8yrwgOrVctMeCsWtQKr9v1UER8aU9Ow1R1OwwLvutufxF+Ht0n2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="425034458"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="425034458"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 20:17:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="706922092"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="706922092"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 15 Jun 2023 20:17:36 -0700
Received: from [10.209.76.72] (kliang2-mobl1.ccr.corp.intel.com [10.209.76.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 84369580919;
        Thu, 15 Jun 2023 20:17:34 -0700 (PDT)
Message-ID: <c86fa926-ffef-9b43-a689-cb423324672e@linux.intel.com>
Date:   Thu, 15 Jun 2023 23:17:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 4/8] perf vendor events arm64: Add default tags into
 topdown L1 metrics
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>, acme@kernel.org,
        mingo@redhat.com, peterz@infradead.org, irogers@google.com,
        namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com,
        Jing Zhang <renyu.zj@linux.alibaba.com>
References: <20230607162700.3234712-1-kan.liang@linux.intel.com>
 <20230607162700.3234712-5-kan.liang@linux.intel.com>
 <adc68c05-3631-be63-3069-09bebf4956ef@oracle.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <adc68c05-3631-be63-3069-09bebf4956ef@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-06-14 10:30 a.m., John Garry wrote:
> On 07/06/2023 17:26, kan.liang@linux.intel.com wrote:
>> From: Kan Liang<kan.liang@linux.intel.com>
>>
>> Add the default tags for ARM as well.
>>
>> Signed-off-by: Kan Liang<kan.liang@linux.intel.com>
>> Cc: Jing Zhang<renyu.zj@linux.alibaba.com>
>> Cc: John Garry<john.g.garry@oracle.com>
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> 
> But does pmu-events/arch/arm64/hisilicon/hip08/metrics.json need to be
> fixed up as well?

The patch has been added in V4. Please take a look.

https://lore.kernel.org/lkml/20230616031420.3751973-6-kan.liang@linux.intel.com/

Thanks,
Kan
