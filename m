Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDD26D2234
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 16:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232480AbjCaOR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 10:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbjCaORZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 10:17:25 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C1961B9;
        Fri, 31 Mar 2023 07:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680272243; x=1711808243;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6LPyPGMktGNNzzeF0EgKvNivoqTwJYbCzRum/Ah24es=;
  b=ErBfFaCty8rhQ3XwNM5LuEWRiKXgdGWIJ10CQaxh6/aLcGSkKkVs5U+y
   h3VEfsOp6XgQJ834Kpsw0xup+JY+quQsAibrjSmXK7i/RWWg7XyD2Ase6
   caJjMw9nldceW8gOMEYN9sCqvMjqkerDUEQPbA8DPFyByAw+g7m7JmuQV
   crRH1W+a/s+QSDzR+XpjC+bwT1jaAckRbtJPmkAgFVOBOY0VyYegyDr6O
   uEw4LeIFhPvN+zjwC17k6dGJI1+sPV2G//84076/qeewKMjTOk2tkFe87
   Ht5R2irUfC11hHZ0GwrCsZazKF3YTLQ9hhXE9+UGD7S3OsZ1OcWze5GHe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="343122143"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="343122143"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 07:17:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="859334784"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="859334784"
Received: from meetipat-mobl1.amr.corp.intel.com (HELO [10.251.25.236]) ([10.251.25.236])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 07:17:13 -0700
Message-ID: <369307a5-e6ca-5e5c-f024-49fd174e4f2e@linux.intel.com>
Date:   Fri, 31 Mar 2023 07:17:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 0/2] perf top: Add --branch-history option
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20230330131833.12864-1-adrian.hunter@intel.com>
 <ZCX7m2bsyk0SwAdy@kernel.org>
Content-Language: en-US
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <ZCX7m2bsyk0SwAdy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/30/2023 2:14 PM, Arnaldo Carvalho de Melo wrote:
> Em Thu, Mar 30, 2023 at 04:18:31PM +0300, Adrian Hunter escreveu:
>> Hi
>>
>> Here are small patches related to option --branch-history.
>>
>> Note, currently --branch-history is broken due to patch
>> "perf report: append inlines to non-dwarf callchains" so
>> that needs to be reverted / fixed beforehand.
> Thanks, applied.


How about the revert to fix it too?


-Andi


