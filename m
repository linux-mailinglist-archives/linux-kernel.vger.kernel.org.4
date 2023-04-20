Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626AA6E8CF4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 10:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234481AbjDTIjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 04:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbjDTIjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 04:39:45 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7974680;
        Thu, 20 Apr 2023 01:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681979974; x=1713515974;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Zvq8F51VWHWQu2DVzypL2OCP2ACTnHPhDRs5TdUm6G0=;
  b=k47vIaDnR4XEIwk7hls3bfxEqx/J1C1FdhZWpE5x+khTv8C2ZLSqale4
   JWovysoVj19g5fx02sR/kxjMyrsXlYR3iS0LK4/zA+yoSGrcQHKE57qri
   mwevJaSKZ1CHMWlmJrT1Wd+OVfKjIh5rB11TSC8D+jykyGWulpiF2ttt8
   GyqZF7vsPnCFbd+lrk1fIBaTKYoLbGEUnXazJ3xNj1mFdEsEgSPk8docv
   tLRXKjAyVWfE9L8JXIdBmRjFWZc5m6ohN1ft4DjW1g0lzqEmEoaguNSKs
   vlxWu/vtPrcklAsAMbaF7ht0NEkJ4hym1kuqtPnSEfxdiPJv2EmgyxV5Z
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="326003757"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="326003757"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 01:39:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="642068168"
X-IronPort-AV: E=Sophos;i="5.99,212,1677571200"; 
   d="scan'208";a="642068168"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.33.27])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 01:39:30 -0700
Message-ID: <ff8bc134-853d-a9d9-901b-2c20beed8d05@intel.com>
Date:   Thu, 20 Apr 2023 11:39:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v5 2/3] perf: add helper map__fprintf_dsoname_dsoff
Content-Language: en-US
To:     Changbin Du <changbin.du@huawei.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hui Wang <hw.huiwang@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
References: <20230418031825.1262579-1-changbin.du@huawei.com>
 <20230418031825.1262579-3-changbin.du@huawei.com>
 <3001bde2-b010-3c00-17de-1c78ef4b589b@intel.com>
 <20230420025511.fkd7upvuoxfz2xih@M910t>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230420025511.fkd7upvuoxfz2xih@M910t>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/23 05:55, Changbin Du wrote:
> On Wed, Apr 19, 2023 at 09:58:10PM +0300, Adrian Hunter wrote:
>> On 18/04/23 06:18, Changbin Du wrote:
>>> This adds a helper function map__fprintf_dsoname_dsoff() to print dsoname
>>> with optional dso offset.
>>>
>>> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
>>> Signed-off-by: Changbin Du <changbin.du@huawei.com>
>>> ---
>>>  tools/perf/util/map.c | 13 +++++++++++++
>>>  tools/perf/util/map.h |  1 +
>>>  2 files changed, 14 insertions(+)
>>>
>>> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
>>> index d81b6ca18ee9..7da96b41100f 100644
>>> --- a/tools/perf/util/map.c
>>> +++ b/tools/perf/util/map.c
>>> @@ -445,6 +445,19 @@ size_t map__fprintf_dsoname(struct map *map, FILE *fp)
>>>  	return fprintf(fp, "%s", dsoname);
>>>  }
>>>  
>>> +size_t map__fprintf_dsoname_dsoff(struct map *map, bool print_off, u64 addr, FILE *fp)
>>> +{
>>> +	int printed = 0;
>>> +
>>> +	printed += fprintf(fp, " (");
>>> +	printed += map__fprintf_dsoname(map, fp);
>>> +	if (print_off && map && map__dso(map) && !map__dso(map)->kernel)
>>
>> That will also block vmlinux offsets not just [kernel.kallsyms]
>> Is that what was intended?
>>
> Not only vmlinux, modules are also blocked. We'd better print offset for
> vmlinux and modules.
> 
> $ sudo perf script -k vmlinux -F +dsoff
>        perf-exec 2531039 4120893.685967:          1 cycles:  ffffffff99094ec4 [unknown] (vmlinux)
>        perf-exec 2531039 4120893.685970:          1 cycles:  ffffffff99094ec4 [unknown] (vmlinux)
>        perf-exec 2531039 4120893.685972:          9 cycles:  ffffffff99094ec4 [unknown] (vmlinux)
>        perf-exec 2531039 4120893.685973:        194 cycles:  ffffffff99094ec6 [unknown] (vmlinux)
>        perf-exec 2531039 4120893.685974:       4605 cycles:  ffffffff99094ec4 [unknown] (vmlinux)
>        perf-exec 2531039 4120893.685976:     108083 cycles:  ffffffff9928e8d0 [unknown] (vmlinux)
>               ls 2531039 4120893.686003:    2197682 cycles:  ffffffff993c92bc [unknown] (vmlinux)
>               ls 2531039 4120893.686554:    4497190 cycles:  ffffffffc159692b strcasestr+0x7b (/lib/modules/5.15.0-60-generic/extra/isac_ipc.ko)
>               ls 2531039 4120893.687700:    4189758 cycles:  ffffffffc18a5d66 delete_net_reject_cache+0x76 (/lib/modules/5.15.0-60-generic/extra/isac_networkfilter.ko)
>               ls 2531039 4120893.688786:    3780376 cycles:  ffffffffc18a67de delete_net_process_info+0x5e (/lib/modules/5.15.0-60-generic/extra/isac_networkfilter.ko)
>               ls 2531039 4120893.689716:    3416607 cycles:  ffffffffc18a67de delete_net_process_info+0x5e (/lib/modules/5.15.0-60-generic/extra/isac_networkfilter.ko)
> 
> But I found addr returned by map__dso_map_ip() for 'vmlinux' is not a 'dso
> offset'.
> 
> $ sudo perf script -k vmlinux -F +dsoff
>        perf-exec 2531039 4120893.685967:          1 cycles:  ffffffff99094ec4 [unknown] (vmlinux+0xffffffff99094ec4)
>        perf-exec 2531039 4120893.685970:          1 cycles:  ffffffff99094ec4 [unknown] (vmlinux+0xffffffff99094ec4)
>        perf-exec 2531039 4120893.685972:          9 cycles:  ffffffff99094ec4 [unknown] (vmlinux+0xffffffff99094ec4)
>        perf-exec 2531039 4120893.685973:        194 cycles:  ffffffff99094ec6 [unknown] (vmlinux+0xffffffff99094ec6)
> 
> Do you have better idea?
> 

What do you get if you try below diff on top of
your patches:

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index c7bf1ac14e90..df0d21141185 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -576,8 +576,11 @@ static void set_print_ip_opts(struct perf_event_attr *attr)
 	if (PRINT_FIELD(DSO))
 		output[type].print_ip_opts |= EVSEL__PRINT_DSO;
 
-	if (PRINT_FIELD(DSOFF))
+	if (PRINT_FIELD(DSOFF)) {
 		output[type].print_ip_opts |= EVSEL__PRINT_DSOFF;
+		/* DSO offset is relative to dso->longname */
+		symbol_conf.show_kernel_path = true;
+	}
 
 	if (PRINT_FIELD(SYMOFFSET))
 		output[type].print_ip_opts |= EVSEL__PRINT_SYMOFFSET;
diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index a86614599269..19ebfd3468cc 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -67,6 +67,42 @@ char dso__symtab_origin(const struct dso *dso)
 	return origin[dso->symtab_type];
 }
 
+bool dso__is_file(const struct dso *dso)
+{
+	switch (dso->binary_type) {
+	case DSO_BINARY_TYPE__KALLSYMS:
+	case DSO_BINARY_TYPE__GUEST_KALLSYMS:
+		return false;
+	case DSO_BINARY_TYPE__VMLINUX:
+	case DSO_BINARY_TYPE__GUEST_VMLINUX:
+		return true;
+	case DSO_BINARY_TYPE__JAVA_JIT:
+		return false;
+	case DSO_BINARY_TYPE__DEBUGLINK:
+	case DSO_BINARY_TYPE__BUILD_ID_CACHE:
+	case DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO:
+	case DSO_BINARY_TYPE__FEDORA_DEBUGINFO:
+	case DSO_BINARY_TYPE__UBUNTU_DEBUGINFO:
+	case DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO:
+	case DSO_BINARY_TYPE__BUILDID_DEBUGINFO:
+	case DSO_BINARY_TYPE__SYSTEM_PATH_DSO:
+	case DSO_BINARY_TYPE__GUEST_KMODULE:
+	case DSO_BINARY_TYPE__GUEST_KMODULE_COMP:
+	case DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE:
+	case DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP:
+	case DSO_BINARY_TYPE__KCORE:
+	case DSO_BINARY_TYPE__GUEST_KCORE:
+	case DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO:
+		return true;
+	case DSO_BINARY_TYPE__BPF_PROG_INFO:
+	case DSO_BINARY_TYPE__BPF_IMAGE:
+	case DSO_BINARY_TYPE__OOL:
+	case DSO_BINARY_TYPE__NOT_FOUND:
+	default:
+		return false;
+	}
+}
+
 int dso__read_binary_type_filename(const struct dso *dso,
 				   enum dso_binary_type type,
 				   char *root_dir, char *filename, size_t size)
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 0b7c7633b9f6..fb33f5224fb6 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -396,6 +396,8 @@ static inline bool dso__is_kallsyms(struct dso *dso)
 	return dso->kernel && dso->long_name[0] != '/';
 }
 
+bool dso__is_file(const struct dso *dso);
+
 void dso__free_a2l(struct dso *dso);
 
 enum dso_type dso__type(struct dso *dso, struct machine *machine);
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 7da96b41100f..9b79f88d371c 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -447,11 +447,12 @@ size_t map__fprintf_dsoname(struct map *map, FILE *fp)
 
 size_t map__fprintf_dsoname_dsoff(struct map *map, bool print_off, u64 addr, FILE *fp)
 {
+	const struct dso *dso = map ? map__dso(map) : NULL;
 	int printed = 0;
 
 	printed += fprintf(fp, " (");
 	printed += map__fprintf_dsoname(map, fp);
-	if (print_off && map && map__dso(map) && !map__dso(map)->kernel)
+	if (print_off && dso && dso__is_file(dso))
 		printed += fprintf(fp, "+0x%" PRIx64, addr);
 	printed += fprintf(fp, ")");
 

