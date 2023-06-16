Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B960732557
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 04:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239478AbjFPClm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 22:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjFPCll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 22:41:41 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1062C296F;
        Thu, 15 Jun 2023 19:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686883300; x=1718419300;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2IEe3NTPJuFhMZdWIJvLWj0KlVJtmwWgVB33dSk7gXc=;
  b=bkFy9XwBQqa5SVul2W8TsSmw9pzfMsnjQpXTbMh6F72LDmm5JfRiuhM9
   vjRRLrXxSQszvErLz7tzIbflBm3rkwgi6V7XIYHkTCCd4DjMPc2REuKf7
   5hZzVe5xc2gM9E9FseZC5jsoPx/Q8GBResDPx76GiqhZXYnJIO5izOkeU
   gjIJFH2q3jvQn/yZDA4DkUbgkuqzU06tmTD8RW5bMv9hXaSnFmJsw2LaG
   e1EgNt+YiHcBKfawntxmsrbXrTGY5vAvRnm9h/Yp4KvW8GPQv+hLWKHp8
   lJ+tMdLagdmyVZSXKkaQANK811puLyNDVz3oXPWjXaPoiW4osdasbdmZT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="425029165"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="425029165"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 19:41:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="706909551"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="706909551"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga007.jf.intel.com with ESMTP; 15 Jun 2023 19:41:39 -0700
Received: from [10.209.76.72] (kliang2-mobl1.ccr.corp.intel.com [10.209.76.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id E9780580919;
        Thu, 15 Jun 2023 19:41:37 -0700 (PDT)
Message-ID: <49d5b8f0-7c48-495b-beda-33cbff8e5ef0@linux.intel.com>
Date:   Thu, 15 Jun 2023 22:41:36 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH V3 0/8] New metricgroup output in perf stat default mode
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     mingo@redhat.com, peterz@infradead.org, irogers@google.com,
        namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com
References: <20230615135315.3662428-1-kan.liang@linux.intel.com>
 <ZIu61WSa17DvVtgt@kernel.org>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <ZIu61WSa17DvVtgt@kernel.org>
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



On 2023-06-15 9:28 p.m., Arnaldo Carvalho de Melo wrote:
> Em Thu, Jun 15, 2023 at 06:53:07AM -0700, kan.liang@linux.intel.com escreveu:
>> The patch proposes a new output format which only outputting the value
>> of each metric and the metricgroup name. It can brings a clean and
>> consistent output format among ARCHs and generations.
>>
>> The first patche is a bug fix for the current code.
>>
>> The patches 2-5 introduce the new metricgroup output.
>>
>> The patches 6-8 improve the tests to cover the default mode.
> 
> I cherry picked 1-3 and 6, and pushed to the tmp.perf-tools-next branch
> at both my usual repository at:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tmp.perf-tools-next
> 
> And also at the one we're transitioning to, and that Namhyung Kim has
> write access and will update while I'm in vacation in the next two
> weeks.
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git tmp.perf-tools-next
> 
> Tomorrow I'll do more tests with it and then transition to
> perf-tools-next in both git repositories.
> 
> Please prefer
> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git
> from now on.
> 

Thanks Arnaldo!

Kan

