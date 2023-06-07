Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C87B572535E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 07:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbjFGFdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 01:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbjFGFdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 01:33:15 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CC119AA;
        Tue,  6 Jun 2023 22:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686115994; x=1717651994;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=WKqGJ0Cr8W1DLMfOa7ITnpvqsLwc+JD5KKUCEXVA6mc=;
  b=lUHlv87GSYq+MjTjhm+H1nBMzt5fbTvDNS4GZwDS7ISz0rx4T/X4mrLi
   jywpi+U/wWF8MhbeZ/TYsNP6g4ZVsEHBG2wIanD31QMl1BUXvFmWZop6v
   OzZiaoAQ2jGnYD56wlrPts5CmvE74NFtR14D2RjJ7P8cOplH+L0irfMWs
   MP/D2Js9ywcNPagMSjN8BOe2jmwtH1zHKIKaIQmSnXxH8YqlnfvsOJjWC
   NZP2qsaGbaPdCnNFBDvDGDq6bzU0w8vuSG+U2E8WM7Wiwb7UbTxu7PEmT
   E9wW+8w2RH9oyRun5jtTl17x+oJ02epXLUzHtP1AZRJxqf84zYtm4L0dv
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="337251616"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="337251616"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 22:33:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="853693801"
X-IronPort-AV: E=Sophos;i="6.00,223,1681196400"; 
   d="scan'208";a="853693801"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.47.234])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 22:33:12 -0700
Message-ID: <f7228dc9-fe18-a8e3-7d3f-52922e0e1113@intel.com>
Date:   Wed, 7 Jun 2023 08:33:07 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH V3 0/1] perf tools: Allow config terms with breakpoints
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
References: <20230525082902.25332-1-adrian.hunter@intel.com>
 <afe1c05a-2b77-c3d8-aacf-b4c7bebb8bf8@intel.com>
 <ZH933yJMYTr0cC+N@kernel.org> <ZH+Havh+xRIfwa4n@kernel.org>
 <9a3776f9-9c9e-b23f-9f18-91b4b5b8364d@intel.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <9a3776f9-9c9e-b23f-9f18-91b4b5b8364d@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/06/23 22:37, Adrian Hunter wrote:
> On 6/06/23 22:22, Arnaldo Carvalho de Melo wrote:
>> Em Tue, Jun 06, 2023 at 03:15:59PM -0300, Arnaldo Carvalho de Melo escreveu:
>>> Em Tue, Jun 06, 2023 at 08:00:33AM +0300, Adrian Hunter escreveu:
>>>> On 25/05/23 11:29, Adrian Hunter wrote:
>>>>> Hi
>>>>>
>>>>> Here is a patch (V3) to the event parser for breakpoint events.
>>>>> I am not that familiar with flex / bison, but it seemed to
>>>>> need trailing context to stop the mem event colon and slash
>>>>> delimiters from getting mixed up with delimiters for config
>>>>> terms or event modifiers.  Please look closely at that.
>>>>>
>>>>>
>>>>> Changes in V3:
>>>>>
>>>>>       Add Ian's Reviewed-by
>>>>>       Re-base
>>>>
>>>> Still applies.  Any more comments?
>>>
>>> Tried it now, twice, once after removing the O= build dir:
>>>
>>>   CC      /tmp/build/perf-tools-next/tests/event-times.o
>>>   CC      /tmp/build/perf-tools-next/tests/expr.o
>>>   BISON   /tmp/build/perf-tools-next/util/parse-events-bison.c
>>> util/parse-events.y:508.24-34: warning: unused value: $3 [-Wother]
>>>   508 | PE_PREFIX_MEM PE_VALUE PE_BP_SLASH PE_VALUE PE_BP_COLON PE_MODIFIER_BP opt_event_config
>>>       |                        ^~~~~~~~~~~
>>> util/parse-events.y:508.45-55: warning: unused value: $5 [-Wother]
>>>   508 | PE_PREFIX_MEM PE_VALUE PE_BP_SLASH PE_VALUE PE_BP_COLON PE_MODIFIER_BP opt_event_config
>>>       |                                             ^~~~~~~~~~~
>>> util/parse-events.y:526.24-34: warning: unused value: $3 [-Wother]
>>>   526 | PE_PREFIX_MEM PE_VALUE PE_BP_SLASH PE_VALUE opt_event_config
>>>       |                        ^~~~~~~~~~~
>>> util/parse-events.y:543.24-34: warning: unused value: $3 [-Wother]
>>>   543 | PE_PREFIX_MEM PE_VALUE PE_BP_COLON PE_MODIFIER_BP opt_event_config
>>>       |                        ^~~~~~~~~~~
>>>   CC      /tmp/build/perf-tools-next/tests/backward-ring-buffer.o
>>
>> But it doesn't _break_ the build, just warns thiis when generating the
>> .c file, the next build it notices it is already generated, no warnings.
> 
> The build script I was using has a flaw.  It doesn't show warnings
> unless the build fails, assuming warnings are errors.  But these
> are not.
> 
> The first hack that came to mind, and seems to work, is:
> 
> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> index bbfb8110947c..dd36be3832b6 100644
> --- a/tools/perf/util/parse-events.y
> +++ b/tools/perf/util/parse-events.y
> @@ -510,6 +510,8 @@ PE_PREFIX_MEM PE_VALUE PE_BP_SLASH PE_VALUE PE_BP_COLON PE_MODIFIER_BP opt_event
>  	struct list_head *list;
>  	int err;
>  
> +	$3 = $3;
> +	$5 = $5;
>  	list = alloc_list();
>  	ABORT_ON(!list);
>  	err = parse_events_add_breakpoint(_parse_state, list,
> @@ -528,6 +530,7 @@ PE_PREFIX_MEM PE_VALUE PE_BP_SLASH PE_VALUE opt_event_config
>  	struct list_head *list;
>  	int err;
>  
> +	$3 = $3;
>  	list = alloc_list();
>  	ABORT_ON(!list);
>  	err = parse_events_add_breakpoint(_parse_state, list,
> @@ -545,6 +548,7 @@ PE_PREFIX_MEM PE_VALUE PE_BP_COLON PE_MODIFIER_BP opt_event_config
>  	struct list_head *list;
>  	int err;
>  
> +	$3 = $3;
>  	list = alloc_list();
>  	ABORT_ON(!list);
>  	err = parse_events_add_breakpoint(_parse_state, list,
> 
> 

Maybe this is cleaner:


From: Adrian Hunter <adrian.hunter@intel.com>
Date: Wed, 7 Jun 2023 08:12:29 +0300
Subject: [PATCH] perf tools: Suppress bison unused value warnings

Patch "perf tools: Allow config terms with breakpoints" introduced
parse tokens for colons and slashes within breakpoint parsing to
prevent mix up with colons and slashes related to config terms.

The token values are not needed but introduce bison "unused value"
warnings.

Suppress those warnings.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/parse-events.h | 4 ++++
 tools/perf/util/parse-events.y | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index b0eb95f93e9c..5fdc1f33f57e 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -228,6 +228,10 @@ void parse_events_error__handle(struct parse_events_error *err, int idx,
 void parse_events_error__print(struct parse_events_error *err,
 			       const char *event);
 
+static inline void parse_events_unused_value(const void *x __maybe_unused)
+{
+}
+
 #ifdef HAVE_LIBELF_SUPPORT
 /*
  * If the probe point starts with '%',
diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index bbfb8110947c..0c3d086cc22a 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -510,6 +510,9 @@ PE_PREFIX_MEM PE_VALUE PE_BP_SLASH PE_VALUE PE_BP_COLON PE_MODIFIER_BP opt_event
 	struct list_head *list;
 	int err;
 
+	parse_events_unused_value(&$3);
+	parse_events_unused_value(&$5);
+
 	list = alloc_list();
 	ABORT_ON(!list);
 	err = parse_events_add_breakpoint(_parse_state, list,
@@ -528,6 +531,8 @@ PE_PREFIX_MEM PE_VALUE PE_BP_SLASH PE_VALUE opt_event_config
 	struct list_head *list;
 	int err;
 
+	parse_events_unused_value(&$3);
+
 	list = alloc_list();
 	ABORT_ON(!list);
 	err = parse_events_add_breakpoint(_parse_state, list,
@@ -545,6 +550,8 @@ PE_PREFIX_MEM PE_VALUE PE_BP_COLON PE_MODIFIER_BP opt_event_config
 	struct list_head *list;
 	int err;
 
+	parse_events_unused_value(&$3);
+
 	list = alloc_list();
 	ABORT_ON(!list);
 	err = parse_events_add_breakpoint(_parse_state, list,
-- 
2.34.1


