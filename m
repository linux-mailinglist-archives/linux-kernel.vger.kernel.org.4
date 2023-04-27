Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3E2E6F0991
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 18:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243673AbjD0QNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 12:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244000AbjD0QNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 12:13:25 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E108035BB;
        Thu, 27 Apr 2023 09:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682612003; x=1714148003;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kXohL0idJGL9sYGzpSSWqJpOGZfaiROA243ZyCIvb9M=;
  b=SkZ94A16l4s0azcEsIDGEZOcTBxn2KPHyiq1I0PEXdrNv7v3T9yaro3+
   yaxUlXlcpxdN+/kGZRBxZM0cBTmkpPathJJ5c0z3lV4ft6wL/eTgZwHaN
   X6Igsmu+55it8ev+Ryrz9tRvtXj6ZWARBtcf4NjVThVGOQzXgr5Snb5Ah
   /8m9JOOvSYJ4qtryl7h+oJyOm4W+BKdJZ/wOltInNa0v7h+3QifkIynR6
   8oV/XptDMzotFX+X3H0pLU16mKc+Uk+7L1fFNOZVf7GB2l+1MujYwCyBa
   9wqujVwE6Hi+4ZU7RXwNqNGlzeZSIQ0YNxbnWWundUTuZugypxcke1l4e
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="327100375"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="327100375"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 09:08:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10693"; a="688490765"
X-IronPort-AV: E=Sophos;i="5.99,230,1677571200"; 
   d="scan'208";a="688490765"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.60.162])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2023 09:08:22 -0700
Message-ID: <f743969e-7dda-5686-59f8-844016ebe31e@intel.com>
Date:   Thu, 27 Apr 2023 19:08:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.1
Subject: Re: [PATCH 1/1] perf tools: Allow config terms with breakpoints
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20230427122656.42473-1-adrian.hunter@intel.com>
 <20230427122656.42473-2-adrian.hunter@intel.com>
 <CAP-5=fU0Sicx0AUWh8nc4g6_eDpr+0w6PmVJ191o6405POhcCg@mail.gmail.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <CAP-5=fU0Sicx0AUWh8nc4g6_eDpr+0w6PmVJ191o6405POhcCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/23 18:26, Ian Rogers wrote:
> On Thu, Apr 27, 2023 at 5:27 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>>
>> Add config terms to the parsing of breakpoint events. Extend "Test event
>> parsing" to also cover using a confg term.
>>
>> This makes breakpoint events consistent with other events which already
>> support config terms.
>>
>> Example:
>>
>>   $ cat dr_test.c
>>   #include <unistd.h>
>>   #include <stdio.h>
>>
>>   void func0(void)
>>   {
>>   }
>>
>>   int main()
>>   {
>>           printf("func0 %p\n", &func0);
>>           while (1) {
>>                   func0();
>>                   usleep(100000);
>>           }
>>           return 0;
>>   }
>>   $ gcc -g -O0 -o dr_test dr_test.c
>>   $ ./dr_test &
>>   [2] 19646
>>   func0 0x55feb98dd169
>>   $ perf record -e mem:0x55feb98dd169:x/name=breakpoint/ -p 19646 -- sleep 0.5
>>   [ perf record: Woken up 1 times to write data ]
>>   [ perf record: Captured and wrote 0.017 MB perf.data (5 samples) ]
>>   $ perf script
>>       dr_test 19646  5632.956628:          1 breakpoint:      55feb98dd169 func0+0x0 (/home/ahunter/git/work/dr_test)
>>       dr_test 19646  5633.056866:          1 breakpoint:      55feb98dd169 func0+0x0 (/home/ahunter/git/work/dr_test)
>>       dr_test 19646  5633.157084:          1 breakpoint:      55feb98dd169 func0+0x0 (/home/ahunter/git/work/dr_test)
>>       dr_test 19646  5633.257309:          1 breakpoint:      55feb98dd169 func0+0x0 (/home/ahunter/git/work/dr_test)
>>       dr_test 19646  5633.357532:          1 breakpoint:      55feb98dd169 func0+0x0 (/home/ahunter/git/work/dr_test)
>>   $ sudo perf test "Test event parsing"
>>     6: Parse event definition strings                                  :
>>     6.1: Test event parsing                                            : Ok
>>   $ sudo perf test -v "Test event parsing" |& grep mem
>>   running test 8 'mem:0'
>>   running test 9 'mem:0:x'
>>   running test 10 'mem:0:r'
>>   running test 11 'mem:0:w'
>>   running test 19 'mem:0:u'
>>   running test 20 'mem:0:x:k'
>>   running test 21 'mem:0:r:hp'
>>   running test 22 'mem:0:w:up'
>>   running test 26 'mem:0:rw'
>>   running test 27 'mem:0:rw:kp'
>>   running test 42 'mem:0/1'
>>   running test 43 'mem:0/2:w'
>>   running test 44 'mem:0/4:rw:u'
>>   running test 58 'mem:0/name=breakpoint/'
>>   running test 59 'mem:0:x/name=breakpoint/'
>>   running test 60 'mem:0:r/name=breakpoint/'
>>   running test 61 'mem:0:w/name=breakpoint/'
>>   running test 62 'mem:0/name=breakpoint/u'
>>   running test 63 'mem:0:x/name=breakpoint/k'
>>   running test 64 'mem:0:r/name=breakpoint/hp'
>>   running test 65 'mem:0:w/name=breakpoint/up'
>>   running test 66 'mem:0:rw/name=breakpoint/'
>>   running test 67 'mem:0:rw/name=breakpoint/kp'
>>   running test 68 'mem:0/1/name=breakpoint/'
>>   running test 69 'mem:0/2:w/name=breakpoint/'
>>   running test 70 'mem:0/4:rw/name=breakpoint/u'
>>
>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>> ---
>>  tools/perf/tests/parse-events.c | 135 ++++++++++++++++++++++++++++++++
>>  tools/perf/util/parse-events.c  |  23 +++++-
>>  tools/perf/util/parse-events.h  |   6 +-
>>  tools/perf/util/parse-events.l  |   7 +-
>>  tools/perf/util/parse-events.y  |  42 +++++-----
>>  5 files changed, 187 insertions(+), 26 deletions(-)
>>
>> diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
>> index 8068cfd89b84..f424ad77da60 100644
>> --- a/tools/perf/tests/parse-events.c
>> +++ b/tools/perf/tests/parse-events.c
>> @@ -439,6 +439,76 @@ static int test__checkevent_breakpoint_rw_modifier(struct evlist *evlist)
>>         return test__checkevent_breakpoint_rw(evlist);
>>  }
>>
>> +static int test__checkevent_breakpoint_modifier_name(struct evlist *evlist)
>> +{
>> +       struct evsel *evsel = evlist__first(evlist);
>> +
>> +       TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
>> +       TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
>> +       TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
>> +       TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>> +       TEST_ASSERT_VAL("wrong name",
>> +                       !strcmp(evsel__name(evsel), "breakpoint"));
>> +
>> +       return test__checkevent_breakpoint(evlist);
>> +}
>> +
>> +static int test__checkevent_breakpoint_x_modifier_name(struct evlist *evlist)
>> +{
>> +       struct evsel *evsel = evlist__first(evlist);
>> +
>> +       TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
>> +       TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
>> +       TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
>> +       TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
>> +       TEST_ASSERT_VAL("wrong name",
>> +                       !strcmp(evsel__name(evsel), "breakpoint"));
>> +
>> +       return test__checkevent_breakpoint_x(evlist);
>> +}
>> +
>> +static int test__checkevent_breakpoint_r_modifier_name(struct evlist *evlist)
>> +{
>> +       struct evsel *evsel = evlist__first(evlist);
>> +
>> +       TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
>> +       TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
>> +       TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
>> +       TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
>> +       TEST_ASSERT_VAL("wrong name",
>> +                       !strcmp(evsel__name(evsel), "breakpoint"));
>> +
>> +       return test__checkevent_breakpoint_r(evlist);
>> +}
>> +
>> +static int test__checkevent_breakpoint_w_modifier_name(struct evlist *evlist)
>> +{
>> +       struct evsel *evsel = evlist__first(evlist);
>> +
>> +       TEST_ASSERT_VAL("wrong exclude_user", !evsel->core.attr.exclude_user);
>> +       TEST_ASSERT_VAL("wrong exclude_kernel", evsel->core.attr.exclude_kernel);
>> +       TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
>> +       TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
>> +       TEST_ASSERT_VAL("wrong name",
>> +                       !strcmp(evsel__name(evsel), "breakpoint"));
>> +
>> +       return test__checkevent_breakpoint_w(evlist);
>> +}
>> +
>> +static int test__checkevent_breakpoint_rw_modifier_name(struct evlist *evlist)
>> +{
>> +       struct evsel *evsel = evlist__first(evlist);
>> +
>> +       TEST_ASSERT_VAL("wrong exclude_user", evsel->core.attr.exclude_user);
>> +       TEST_ASSERT_VAL("wrong exclude_kernel", !evsel->core.attr.exclude_kernel);
>> +       TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
>> +       TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
>> +       TEST_ASSERT_VAL("wrong name",
>> +                       !strcmp(evsel__name(evsel), "breakpoint"));
>> +
>> +       return test__checkevent_breakpoint_rw(evlist);
>> +}
>> +
>>  static int test__checkevent_pmu(struct evlist *evlist)
>>  {
>>
>> @@ -1973,6 +2043,71 @@ static const struct evlist_test test__events[] = {
>>                 .check = test__exclusive_group,
>>                 /* 7 */
>>         },
>> +       {
>> +               .name  = "mem:0/name=breakpoint/",
>> +               .check = test__checkevent_breakpoint,
>> +               /* 8 */
>> +       },
>> +       {
>> +               .name  = "mem:0:x/name=breakpoint/",
>> +               .check = test__checkevent_breakpoint_x,
>> +               /* 9 */
>> +       },
>> +       {
>> +               .name  = "mem:0:r/name=breakpoint/",
>> +               .check = test__checkevent_breakpoint_r,
>> +               /* 0 */
>> +       },
>> +       {
>> +               .name  = "mem:0:w/name=breakpoint/",
>> +               .check = test__checkevent_breakpoint_w,
>> +               /* 1 */
>> +       },
>> +       {
>> +               .name  = "mem:0/name=breakpoint/u",
>> +               .check = test__checkevent_breakpoint_modifier_name,
>> +               /* 2 */
>> +       },
>> +       {
>> +               .name  = "mem:0:x/name=breakpoint/k",
>> +               .check = test__checkevent_breakpoint_x_modifier_name,
>> +               /* 3 */
>> +       },
>> +       {
>> +               .name  = "mem:0:r/name=breakpoint/hp",
>> +               .check = test__checkevent_breakpoint_r_modifier_name,
>> +               /* 4 */
>> +       },
>> +       {
>> +               .name  = "mem:0:w/name=breakpoint/up",
>> +               .check = test__checkevent_breakpoint_w_modifier_name,
>> +               /* 5 */
>> +       },
>> +       {
>> +               .name  = "mem:0:rw/name=breakpoint/",
>> +               .check = test__checkevent_breakpoint_rw,
>> +               /* 6 */
>> +       },
>> +       {
>> +               .name  = "mem:0:rw/name=breakpoint/kp",
>> +               .check = test__checkevent_breakpoint_rw_modifier_name,
>> +               /* 7 */
>> +       },
>> +       {
>> +               .name  = "mem:0/1/name=breakpoint/",
>> +               .check = test__checkevent_breakpoint_len,
>> +               /* 8 */
>> +       },
>> +       {
>> +               .name  = "mem:0/2:w/name=breakpoint/",
>> +               .check = test__checkevent_breakpoint_len_w,
>> +               /* 9 */
>> +       },
>> +       {
>> +               .name  = "mem:0/4:rw/name=breakpoint/u",
>> +               .check = test__checkevent_breakpoint_len_rw_modifier,
>> +               /* 0 */
>> +       },
>>  };
>>
>>  static const struct evlist_test test__events_pmu[] = {
>> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
>> index d71019dcd614..4f4901753f25 100644
>> --- a/tools/perf/util/parse-events.c
>> +++ b/tools/perf/util/parse-events.c
>> @@ -896,10 +896,14 @@ do {                                      \
>>         return 0;
>>  }
>>
>> -int parse_events_add_breakpoint(struct list_head *list, int *idx,
>> -                               u64 addr, char *type, u64 len)
>> +int parse_events_add_breakpoint(struct parse_events_state *parse_state,
>> +                               struct list_head *list,
>> +                               u64 addr, char *type, u64 len,
>> +                               struct list_head *head_config __maybe_unused)
>>  {
>>         struct perf_event_attr attr;
>> +       LIST_HEAD(config_terms);
>> +       const char *name;
>>
>>         memset(&attr, 0, sizeof(attr));
>>         attr.bp_addr = addr;
>> @@ -920,8 +924,19 @@ int parse_events_add_breakpoint(struct list_head *list, int *idx,
>>         attr.type = PERF_TYPE_BREAKPOINT;
>>         attr.sample_period = 1;
>>
>> -       return add_event(list, idx, &attr, /*name=*/NULL, /*mertic_id=*/NULL,
>> -                        /*config_terms=*/NULL);
>> +       if (head_config) {
>> +               if (config_attr(&attr, head_config, parse_state->error,
>> +                               config_term_common))
>> +                       return -EINVAL;
>> +
>> +               if (get_config_terms(head_config, &config_terms))
>> +                       return -ENOMEM;
>> +       }
>> +
>> +       name = get_config_name(head_config);
>> +
>> +       return add_event(list, &parse_state->idx, &attr, name, /*mertic_id=*/NULL,
>> +                        &config_terms);
>>  }
>>
>>  static int check_type_val(struct parse_events_term *term,
>> diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
>> index 86ad4438a2aa..6cb2076f1577 100644
>> --- a/tools/perf/util/parse-events.h
>> +++ b/tools/perf/util/parse-events.h
>> @@ -179,8 +179,10 @@ int parse_events_add_cache(struct list_head *list, int *idx,
>>                            struct parse_events_error *error,
>>                            struct list_head *head_config,
>>                            struct parse_events_state *parse_state);
>> -int parse_events_add_breakpoint(struct list_head *list, int *idx,
>> -                               u64 addr, char *type, u64 len);
>> +int parse_events_add_breakpoint(struct parse_events_state *parse_state,
>> +                               struct list_head *list,
>> +                               u64 addr, char *type, u64 len,
>> +                               struct list_head *head_config);
>>  int parse_events_add_pmu(struct parse_events_state *parse_state,
>>                          struct list_head *list, char *name,
>>                          struct list_head *head_config,
>> diff --git a/tools/perf/util/parse-events.l b/tools/perf/util/parse-events.l
>> index 51fe0a9fb3de..0d05594e7890 100644
>> --- a/tools/perf/util/parse-events.l
>> +++ b/tools/perf/util/parse-events.l
>> @@ -218,6 +218,8 @@ drv_cfg_term        [a-zA-Z0-9_\.]+(=[a-zA-Z0-9_*?\.:]+)?
>>  /* If you add a modifier you need to update check_modifier() */
>>  modifier_event [ukhpPGHSDIWeb]+
>>  modifier_bp    [rwx]{1,3}
>> +digit          [0-9]
>> +non_digit      [^0-9]
>>
>>  %%
>>
>> @@ -315,8 +317,9 @@ r0x{num_raw_hex}    { return raw(yyscanner); }
>>
>>  <mem>{
>>  {modifier_bp}          { return str(yyscanner, PE_MODIFIER_BP); }
>> -:                      { return ':'; }
>> -"/"                    { return '/'; }
>> +":"/{modifier_bp}      { return str(yyscanner, PE_BP_COLON); }
>> +"/"/{digit}            { return str(yyscanner, PE_BP_SLASH); }
>> +"/"/{non_digit}                { BEGIN(config); return '/'; }
> 
> Hi Adrian, at this point the lexer is going to match "/" and the
> non-digits, consuming the non-digits. So if you have input after the /
> then won't you have a parsing issue?

Thanks for looking at this.  The trailing context should not be
consumed.  From the flex manual:

‘r/s’
    an ‘r’ but only if it is followed by an ‘s’. The text matched by ‘s’ is included when determining whether this rule is the longest match, but is then returned to the input before the action is executed. So the action only sees the text matched by ‘r’. This type of pattern is called trailing context. (There are some combinations of ‘r/s’ that flex cannot match correctly. See Limitations, regarding dangerous trailing context.) 

>                                      Tweaking your example this could
> be:
> 
> $ perf record -e
> mem:0x55feb98dd169:x/name=breakpoint/,mem:0x55feb98dd169:x/name=breakpoint/
> -p 19646 -- sleep 0.5

I tried that and it seems to work ok.  Presumably the "/" of "/,"
gets scanned as part of <config> instead of <mem>

> 
> This will match "/,mem:" and return the token '/' which will then
> cause an issue as the second 0x55feb98dd169 will then need to be
> unput.. actually non_digit doesn't have a plus or star, so you'll
> match the comma which I think still causes issues.
> 
> Hope this helps,
> Ian
> 
>>  {num_dec}              { return value(yyscanner, 10); }
>>  {num_hex}              { return value(yyscanner, 16); }
>>         /*
>> diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
>> index 4488443e506e..cfdb99537d07 100644
>> --- a/tools/perf/util/parse-events.y
>> +++ b/tools/perf/util/parse-events.y
>> @@ -57,7 +57,7 @@ static void free_list_evsel(struct list_head* list_evsel)
>>  %token PE_EVENT_NAME
>>  %token PE_NAME
>>  %token PE_BPF_OBJECT PE_BPF_SOURCE
>> -%token PE_MODIFIER_EVENT PE_MODIFIER_BP
>> +%token PE_MODIFIER_EVENT PE_MODIFIER_BP PE_BP_COLON PE_BP_SLASH
>>  %token PE_NAME_CACHE_TYPE PE_NAME_CACHE_OP_RESULT
>>  %token PE_PREFIX_MEM PE_PREFIX_RAW PE_PREFIX_GROUP
>>  %token PE_ERROR
>> @@ -78,6 +78,8 @@ static void free_list_evsel(struct list_head* list_evsel)
>>  %type <str> PE_NAME_CACHE_OP_RESULT
>>  %type <str> PE_MODIFIER_EVENT
>>  %type <str> PE_MODIFIER_BP
>> +%type <str> PE_BP_COLON
>> +%type <str> PE_BP_SLASH
>>  %type <str> PE_EVENT_NAME
>>  %type <str> PE_PMU_EVENT_PRE PE_PMU_EVENT_SUF PE_PMU_EVENT_SUF2 PE_KERNEL_PMU_EVENT PE_PMU_EVENT_FAKE
>>  %type <str> PE_DRV_CFG_TERM
>> @@ -267,7 +269,7 @@ event_def
>>  event_def: event_pmu |
>>            event_legacy_symbol |
>>            event_legacy_cache sep_dc |
>> -          event_legacy_mem |
>> +          event_legacy_mem sep_dc |
>>            event_legacy_tracepoint sep_dc |
>>            event_legacy_numeric sep_dc |
>>            event_legacy_raw sep_dc |
>> @@ -540,16 +542,16 @@ PE_NAME_CACHE_TYPE opt_event_config
>>  }
>>
>>  event_legacy_mem:
>> -PE_PREFIX_MEM PE_VALUE '/' PE_VALUE ':' PE_MODIFIER_BP sep_dc
>> +PE_PREFIX_MEM PE_VALUE PE_BP_SLASH PE_VALUE PE_BP_COLON PE_MODIFIER_BP opt_event_config
>>  {
>> -       struct parse_events_state *parse_state = _parse_state;
>>         struct list_head *list;
>>         int err;
>>
>>         list = alloc_list();
>>         ABORT_ON(!list);
>> -       err = parse_events_add_breakpoint(list, &parse_state->idx,
>> -                                         $2, $6, $4);
>> +       err = parse_events_add_breakpoint(_parse_state, list,
>> +                                         $2, $6, $4, $7);
>> +       parse_events_terms__delete($7);
>>         free($6);
>>         if (err) {
>>                 free(list);
>> @@ -558,31 +560,33 @@ PE_PREFIX_MEM PE_VALUE '/' PE_VALUE ':' PE_MODIFIER_BP sep_dc
>>         $$ = list;
>>  }
>>  |
>> -PE_PREFIX_MEM PE_VALUE '/' PE_VALUE sep_dc
>> +PE_PREFIX_MEM PE_VALUE PE_BP_SLASH PE_VALUE opt_event_config
>>  {
>> -       struct parse_events_state *parse_state = _parse_state;
>>         struct list_head *list;
>> +       int err;
>>
>>         list = alloc_list();
>>         ABORT_ON(!list);
>> -       if (parse_events_add_breakpoint(list, &parse_state->idx,
>> -                                       $2, NULL, $4)) {
>> +       err = parse_events_add_breakpoint(_parse_state, list,
>> +                                         $2, NULL, $4, $5);
>> +       parse_events_terms__delete($5);
>> +       if (err) {
>>                 free(list);
>>                 YYABORT;
>>         }
>>         $$ = list;
>>  }
>>  |
>> -PE_PREFIX_MEM PE_VALUE ':' PE_MODIFIER_BP sep_dc
>> +PE_PREFIX_MEM PE_VALUE PE_BP_COLON PE_MODIFIER_BP opt_event_config
>>  {
>> -       struct parse_events_state *parse_state = _parse_state;
>>         struct list_head *list;
>>         int err;
>>
>>         list = alloc_list();
>>         ABORT_ON(!list);
>> -       err = parse_events_add_breakpoint(list, &parse_state->idx,
>> -                                         $2, $4, 0);
>> +       err = parse_events_add_breakpoint(_parse_state, list,
>> +                                         $2, $4, 0, $5);
>> +       parse_events_terms__delete($5);
>>         free($4);
>>         if (err) {
>>                 free(list);
>> @@ -591,15 +595,17 @@ PE_PREFIX_MEM PE_VALUE ':' PE_MODIFIER_BP sep_dc
>>         $$ = list;
>>  }
>>  |
>> -PE_PREFIX_MEM PE_VALUE sep_dc
>> +PE_PREFIX_MEM PE_VALUE opt_event_config
>>  {
>> -       struct parse_events_state *parse_state = _parse_state;
>>         struct list_head *list;
>> +       int err;
>>
>>         list = alloc_list();
>>         ABORT_ON(!list);
>> -       if (parse_events_add_breakpoint(list, &parse_state->idx,
>> -                                       $2, NULL, 0)) {
>> +       err = parse_events_add_breakpoint(_parse_state, list,
>> +                                         $2, NULL, 0, $3);
>> +       parse_events_terms__delete($3);
>> +       if (err) {
>>                 free(list);
>>                 YYABORT;
>>         }
>> --
>> 2.34.1
>>

