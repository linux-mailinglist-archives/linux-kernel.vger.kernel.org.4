Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE37654BCD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 04:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbiLWDpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 22:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiLWDpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 22:45:30 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2501571C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 19:45:29 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id 124so2559498pfy.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 19:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vsZV1SWEC0jRGxNbS9/PiSpEKdBflkdhSZ4r3iCyIh8=;
        b=EHF3TPDrtFqgLh092/56kxJKKEYKXdNUlsncO7bJQwmdSHvHiT2i8JykKLzCDrpCHR
         g9NDnGKnVaqJsq9EzNLUsGLmOP6MwMA5cGXdkZGB01x6NKMH9nztdF9iUZqOc6hRuKg8
         j6DKi9P4C017IGEPueqGhXUNA7jiUJf7CwJTerBuziuN3nROE3qNaxVsa3r/Mw9rmT1r
         Wf9MT95JIA2i4U7XSmNR976Sehc6h4psZHXOTum5pIn2QN33H5bXkyGld4eFdsbFWp3o
         FisKsnhzQqwkkeKYSx0mnGwRF4ZvCQVCOShYih0ImchanszxftRbqa5vriUkv2HE8U+b
         aZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsZV1SWEC0jRGxNbS9/PiSpEKdBflkdhSZ4r3iCyIh8=;
        b=tGGeLDBw7uJ/7IYlmQWSzs2iAiD6ZgjwBofeacQPJUrNlVbFRJs2ZiXf/iEF16tL13
         00a35a4jvhQb7NQmWX08FAJgDQ3Mi5SRk4qs1Q28nJDdjWC37mk1BY0t3J4203Kta3w/
         n8Jm3e+k/60NlEAy4magKSgmojN8Zn+LqLcoDN8QXDUuf5iXCNZ0+LtkTViMyZsa1HN/
         EP45CMTqxuZFRUMz34L/mZv0LSaKxZpjBRQ6L9OkhWuIF3KF0zs0s/aMAumQp81pegyW
         OCVzmQ3et+cYjrbIKbKICW/KPoeBIkDYhnx+VeBzVUq8Q5c852jYTO8jW5FpORYf0c0/
         pHcQ==
X-Gm-Message-State: AFqh2krxIFCQJ3NZASy//gBIEg1W1oI3+Vm4meDrkuyIShSHc6qBZUKa
        /FAvz565RxuvBpuTE6F4QgRogQ==
X-Google-Smtp-Source: AMrXdXvOgCAnjPqUGzH80BTvCIHawo7HZAx27GsECjHuiNcQq1GGCTB6jaNENckKNdLTMFzQww7whw==
X-Received: by 2002:aa7:94a1:0:b0:56c:962:fe7e with SMTP id a1-20020aa794a1000000b0056c0962fe7emr7427572pfl.32.1671767128796;
        Thu, 22 Dec 2022 19:45:28 -0800 (PST)
Received: from leoy-yangtze.lan (n058152048149.netvigator.com. [58.152.48.149])
        by smtp.gmail.com with ESMTPSA id z1-20020a626501000000b00573eb4a9a66sm1442111pfb.2.2022.12.22.19.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 19:45:28 -0800 (PST)
Date:   Fri, 23 Dec 2022 11:45:21 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-perf-users@vger.kernel.org, tanmay@marvell.com,
        sgoutham@marvell.com, gcherian@marvell.com, lcherian@marvell.com,
        bbhushan2@marvell.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] perf: Use perf_pmu__open_file() and
 perf_pmu__scan_file()
Message-ID: <Y6UkUQ9dcQQwvRpz@leoy-yangtze.lan>
References: <20221222160328.3639989-1-james.clark@arm.com>
 <20221222160328.3639989-3-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222160328.3639989-3-james.clark@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 04:03:22PM +0000, James Clark wrote:
> Remove some code that duplicates existing methods. This requires that
> some consts are removed because one of the existing helper methods takes
> a struct perf_pmu instead of a name which has a non const name field.
> But except for the tests, the strings were already non const.
> 
> No functional changes.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/tests/evsel-roundtrip-name.c |  3 +-
>  tools/perf/tests/parse-events.c         |  3 +-
>  tools/perf/util/cputopo.c               |  9 +-----
>  tools/perf/util/pmu-hybrid.c            | 27 +++-------------
>  tools/perf/util/pmu-hybrid.h            |  2 +-
>  tools/perf/util/pmu.c                   | 42 +++++++------------------
>  tools/perf/util/pmu.h                   |  3 +-
>  7 files changed, 24 insertions(+), 65 deletions(-)
> 
> diff --git a/tools/perf/tests/evsel-roundtrip-name.c b/tools/perf/tests/evsel-roundtrip-name.c
> index e94fed901992..9bccf177f481 100644
> --- a/tools/perf/tests/evsel-roundtrip-name.c
> +++ b/tools/perf/tests/evsel-roundtrip-name.c
> @@ -103,8 +103,9 @@ static int test__perf_evsel__roundtrip_name_test(struct test_suite *test __maybe
>  						 int subtest __maybe_unused)
>  {
>  	int err = 0, ret = 0;
> +	char cpu_atom[] = "cpu_atom";
>  
> -	if (perf_pmu__has_hybrid() && perf_pmu__hybrid_mounted("cpu_atom"))
> +	if (perf_pmu__has_hybrid() && perf_pmu__hybrid_mounted(cpu_atom))

After change the parameter 'name' to non const type in function
perf_pmu__hybrid_mounted(), at here we still can pass string "cpu_atom"
without warning, right?  If so, we don't need to define a local
variable 'cpu_atom'.

[...]

> -bool perf_pmu__hybrid_mounted(const char *name)
> +bool perf_pmu__hybrid_mounted(char *name)
>  {
> -	char path[PATH_MAX];
> -	const char *sysfs;
> -	FILE *file;
> -	int n, cpu;
> +	int cpu;
> +	struct perf_pmu pmu = {.name = name};
>  
>  	if (strncmp(name, "cpu_", 4))
>  		return false;
>  
> -	sysfs = sysfs__mountpoint();
> -	if (!sysfs)
> -		return false;
> -
> -	snprintf(path, PATH_MAX, CPUS_TEMPLATE_CPU, sysfs, name);
> -	if (!file_available(path))
> -		return false;
> -
> -	file = fopen(path, "r");
> -	if (!file)
> -		return false;
> -
> -	n = fscanf(file, "%u", &cpu);
> -	fclose(file);
> -	if (n <= 0)
> -		return false;
> -
> -	return true;
> +	return perf_pmu__scan_file(&pmu, "cpus", "%u", &cpu) > 0;

It's not necessarily to change the parameter 'name' to non const type,
we can handle this case in two different ways.

The first option is to refine the code with using the function
perf_pmu__pathname_scnprintf() which is introduced in patch 01, thus
we can keep using fopen() and fscanf() to read out value from 'cpus'
entry.

Another option is to define a local array 'pmu_name[PATH_MAX]' and
then copy the input string to this array, something like:

bool perf_pmu__hybrid_mounted(const char *name)
{
  char pmu_name[PATH_MAX];
  struct perf_pmu pmu;
  int cpu;

  strncpy(pmu_name, name, sizeof(pmu_name));
  pmu.name = pmu_name;

  return perf_pmu__scan_file(&pmu, "cpus", "%u", &cpu) > 0;
}

We even can consider to dynamically allocate buffer and copy string from
'name' to the allocated buffer.

>  }
>  
>  struct perf_pmu *perf_pmu__find_hybrid_pmu(const char *name)
> diff --git a/tools/perf/util/pmu-hybrid.h b/tools/perf/util/pmu-hybrid.h
> index 2b186c26a43e..11db6ef4a376 100644
> --- a/tools/perf/util/pmu-hybrid.h
> +++ b/tools/perf/util/pmu-hybrid.h
> @@ -13,7 +13,7 @@ extern struct list_head perf_pmu__hybrid_pmus;
>  #define perf_pmu__for_each_hybrid_pmu(pmu)	\
>  	list_for_each_entry(pmu, &perf_pmu__hybrid_pmus, hybrid_list)
>  
> -bool perf_pmu__hybrid_mounted(const char *name);
> +bool perf_pmu__hybrid_mounted(char *name);
>  
>  struct perf_pmu *perf_pmu__find_hybrid_pmu(const char *name);
>  bool perf_pmu__is_hybrid(const char *name);
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 827c1a6bb99a..faaeec1e15aa 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -570,45 +570,29 @@ static void pmu_read_sysfs(void)
>  	closedir(dir);
>  }
>  
> -static struct perf_cpu_map *__pmu_cpumask(const char *path)
> -{
> -	FILE *file;
> -	struct perf_cpu_map *cpus;
> -
> -	file = fopen(path, "r");
> -	if (!file)
> -		return NULL;
> -
> -	cpus = perf_cpu_map__read(file);
> -	fclose(file);
> -	return cpus;
> -}
> -
>  /*
>   * Uncore PMUs have a "cpumask" file under sysfs. CPU PMUs (e.g. on arm/arm64)
>   * may have a "cpus" file.
>   */
>  #define SYS_TEMPLATE_ID	"./bus/event_source/devices/%s/identifier"
> -#define CPUS_TEMPLATE_UNCORE	"%s/bus/event_source/devices/%s/cpumask"
>  
> -static struct perf_cpu_map *pmu_cpumask(const char *name)
> +static struct perf_cpu_map *pmu_cpumask(char *name)
>  {
> -	char path[PATH_MAX];
>  	struct perf_cpu_map *cpus;
> -	const char *sysfs = sysfs__mountpoint();
>  	const char *templates[] = {
> -		CPUS_TEMPLATE_UNCORE,
> -		CPUS_TEMPLATE_CPU,
> +		"cpumask",
> +		"cpus",
>  		NULL
>  	};
>  	const char **template;
> -
> -	if (!sysfs)
> -		return NULL;
> +	struct perf_pmu pmu = {.name = name};

Here we also can define a local array and copy string from 'name' to
the local array.  This can allow us to provide a friendly function and
caller doesn't need to explictly pass non const string.

Thanks,
Leo

> +	FILE *file;
>  
>  	for (template = templates; *template; template++) {
> -		snprintf(path, PATH_MAX, *template, sysfs, name);
> -		cpus = __pmu_cpumask(path);
> +		file = perf_pmu__open_file(&pmu, *template);
> +		if (!file)
> +			continue;
> +		cpus = perf_cpu_map__read(file);
>  		if (cpus)
>  			return cpus;
>  	}
> @@ -616,16 +600,14 @@ static struct perf_cpu_map *pmu_cpumask(const char *name)
>  	return NULL;
>  }
>  
> -static bool pmu_is_uncore(const char *name)
> +static bool pmu_is_uncore(char *name)
>  {
>  	char path[PATH_MAX];
> -	const char *sysfs;
>  
>  	if (perf_pmu__hybrid_mounted(name))
>  		return false;
>  
> -	sysfs = sysfs__mountpoint();
> -	snprintf(path, PATH_MAX, CPUS_TEMPLATE_UNCORE, sysfs, name);
> +	perf_pmu__pathname_scnprintf(path, PATH_MAX, name, "cpumask");
>  	return file_available(path);
>  }
>  
> @@ -1736,7 +1718,7 @@ bool pmu_have_event(const char *pname, const char *name)
>  	return false;
>  }
>  
> -static FILE *perf_pmu__open_file(struct perf_pmu *pmu, const char *name)
> +FILE *perf_pmu__open_file(struct perf_pmu *pmu, const char *name)
>  {
>  	char path[PATH_MAX];
>  
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 2f2bb0286e2a..8f39e2d17fb1 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -2,6 +2,7 @@
>  #ifndef __PMU_H
>  #define __PMU_H
>  
> +#include <bits/types/FILE.h>
>  #include <linux/bitmap.h>
>  #include <linux/compiler.h>
>  #include <linux/perf_event.h>
> @@ -22,7 +23,6 @@ enum {
>  };
>  
>  #define PERF_PMU_FORMAT_BITS 64
> -#define CPUS_TEMPLATE_CPU	"%s/bus/event_source/devices/%s/cpus"
>  #define MAX_PMU_NAME_LEN 128
>  
>  struct perf_event_attr;
> @@ -261,5 +261,6 @@ char *pmu_find_alias_name(const char *name);
>  int perf_pmu__event_source_devices_scnprintf(char *pathname, size_t size);
>  int perf_pmu__pathname_scnprintf(char *buf, size_t size,
>  				 const char *pmu_name, const char *filename);
> +FILE *perf_pmu__open_file(struct perf_pmu *pmu, const char *name);
>  
>  #endif /* __PMU_H */
> -- 
> 2.25.1
> 
