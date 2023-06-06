Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71587724D2A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 21:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239039AbjFFThU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 15:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbjFFThR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:37:17 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CE9139;
        Tue,  6 Jun 2023 12:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686080236; x=1717616236;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YUqOBbQQG/p0HWE+ud/uO5RdIVIWD2N44iMPZl/2qW8=;
  b=LdOfFJrJfYIJ/V5YX0iwhgMjLdYpKDZTjcjGBFbOHmkpcFiKxvznN+up
   OWa9B+9DjfpmNwZkWZQRf4OpwLC1wFg3BVgfKuGZY3BCSv4u25IKy1aqk
   2zuaJUqizx3yIgvwX/jNxR2p+URnEpJ51duLJ9zlXYNCb/GJM/y17YNOk
   9vyeeCVnDLTVq+gWoaYkXyY2bHb73g+oxtYvGenJvNGEhLT0kV69DFuIk
   31OWhNqb4BpSkWtCE7VUL09YPXASeNTBVLrafREUdJrfj/MFIW+4gEntI
   ImQp+v0/jUk2QpKhe5n5W/FTqoW5skrElL2yT0yNzQVZiPwev42sNq39E
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="422620795"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="422620795"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 12:37:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="821790565"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="821790565"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.56.224])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 12:37:09 -0700
Message-ID: <9a3776f9-9c9e-b23f-9f18-91b4b5b8364d@intel.com>
Date:   Tue, 6 Jun 2023 22:37:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.2
Subject: Re: [PATCH V3 0/1] perf tools: Allow config terms with breakpoints
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20230525082902.25332-1-adrian.hunter@intel.com>
 <afe1c05a-2b77-c3d8-aacf-b4c7bebb8bf8@intel.com>
 <ZH933yJMYTr0cC+N@kernel.org> <ZH+Havh+xRIfwa4n@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <ZH+Havh+xRIfwa4n@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/06/23 22:22, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jun 06, 2023 at 03:15:59PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Tue, Jun 06, 2023 at 08:00:33AM +0300, Adrian Hunter escreveu:
>>> On 25/05/23 11:29, Adrian Hunter wrote:
>>>> Hi
>>>>
>>>> Here is a patch (V3) to the event parser for breakpoint events.
>>>> I am not that familiar with flex / bison, but it seemed to
>>>> need trailing context to stop the mem event colon and slash
>>>> delimiters from getting mixed up with delimiters for config
>>>> terms or event modifiers.  Please look closely at that.
>>>>
>>>>
>>>> Changes in V3:
>>>>
>>>>       Add Ian's Reviewed-by
>>>>       Re-base
>>>
>>> Still applies.  Any more comments?
>>
>> Tried it now, twice, once after removing the O= build dir:
>>
>>   CC      /tmp/build/perf-tools-next/tests/event-times.o
>>   CC      /tmp/build/perf-tools-next/tests/expr.o
>>   BISON   /tmp/build/perf-tools-next/util/parse-events-bison.c
>> util/parse-events.y:508.24-34: warning: unused value: $3 [-Wother]
>>   508 | PE_PREFIX_MEM PE_VALUE PE_BP_SLASH PE_VALUE PE_BP_COLON PE_MODIFIER_BP opt_event_config
>>       |                        ^~~~~~~~~~~
>> util/parse-events.y:508.45-55: warning: unused value: $5 [-Wother]
>>   508 | PE_PREFIX_MEM PE_VALUE PE_BP_SLASH PE_VALUE PE_BP_COLON PE_MODIFIER_BP opt_event_config
>>       |                                             ^~~~~~~~~~~
>> util/parse-events.y:526.24-34: warning: unused value: $3 [-Wother]
>>   526 | PE_PREFIX_MEM PE_VALUE PE_BP_SLASH PE_VALUE opt_event_config
>>       |                        ^~~~~~~~~~~
>> util/parse-events.y:543.24-34: warning: unused value: $3 [-Wother]
>>   543 | PE_PREFIX_MEM PE_VALUE PE_BP_COLON PE_MODIFIER_BP opt_event_config
>>       |                        ^~~~~~~~~~~
>>   CC      /tmp/build/perf-tools-next/tests/backward-ring-buffer.o
> 
> But it doesn't _break_ the build, just warns thiis when generating the
> .c file, the next build it notices it is already generated, no warnings.

The build script I was using has a flaw.  It doesn't show warnings
unless the build fails, assuming warnings are errors.  But these
are not.

The first hack that came to mind, and seems to work, is:

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index bbfb8110947c..dd36be3832b6 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -510,6 +510,8 @@ PE_PREFIX_MEM PE_VALUE PE_BP_SLASH PE_VALUE PE_BP_COLON PE_MODIFIER_BP opt_event
 	struct list_head *list;
 	int err;
 
+	$3 = $3;
+	$5 = $5;
 	list = alloc_list();
 	ABORT_ON(!list);
 	err = parse_events_add_breakpoint(_parse_state, list,
@@ -528,6 +530,7 @@ PE_PREFIX_MEM PE_VALUE PE_BP_SLASH PE_VALUE opt_event_config
 	struct list_head *list;
 	int err;
 
+	$3 = $3;
 	list = alloc_list();
 	ABORT_ON(!list);
 	err = parse_events_add_breakpoint(_parse_state, list,
@@ -545,6 +548,7 @@ PE_PREFIX_MEM PE_VALUE PE_BP_COLON PE_MODIFIER_BP opt_event_config
 	struct list_head *list;
 	int err;
 
+	$3 = $3;
 	list = alloc_list();
 	ABORT_ON(!list);
 	err = parse_events_add_breakpoint(_parse_state, list,


> 
> - Arnaldo
>  
>>
>> ⬢[acme@toolbox perf-tools-next]$ cat /etc/redhat-release
>> Fedora release 36 (Thirty Six)
>>
>> ⬢[acme@toolbox perf-tools-next]$ rpm -q bison
>> bison-3.8.2-2.fc36.x86_64
>> ⬢[acme@toolbox perf-tools-next]$ rpm -q flex
>> flex-2.6.4-10.fc36.x86_64
>> ⬢[acme@toolbox perf-tools-next]$
>>
>>
>> - Arnaldo
>>  
>>>>
>>>> Changes in V2:
>>>>
>>>>       Add comments to tools/perf/util/parse-events.l
>>>>       Add a test for 2 mem events back to back with config terms
>>>>
>>>>
>>>> Adrian Hunter (1):
>>>>       perf tools: Allow config terms with breakpoints
>>>>
>>>>  tools/perf/tests/parse-events.c | 157 ++++++++++++++++++++++++++++++++++++++++
>>>>  tools/perf/util/parse-events.c  |  23 +++++-
>>>>  tools/perf/util/parse-events.h  |   6 +-
>>>>  tools/perf/util/parse-events.l  |  23 +++++-
>>>>  tools/perf/util/parse-events.y  |  42 ++++++-----
>>>>  5 files changed, 224 insertions(+), 27 deletions(-)
>>>>
>>>>
>>>> Regards
>>>> Adrian
>>>
>>
>> -- 
>>
>> - Arnaldo
> 

