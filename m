Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5817B654B2B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 03:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbiLWCjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 21:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiLWCjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 21:39:10 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CFC1928A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 18:39:09 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id n4so3756788plp.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 18:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sL/rbJ8T1w26m0FDbphKBsY/xLpZ7Is14/l1AhjpfWc=;
        b=GP4OqcFip45zWA5hMx+m/uHfYvoszOC/e0G9Afz7+pw8JfrW7dRXtdbpKFdWmTa0yo
         bAsQz0J3mK5cV7AGXhTy2PKR5QUfBNe6GPSKHS4fitM/rnnXZMfz014OQRt/3eH6Ozjf
         u7GfORsmGpj/4xZair4W9nqzec7nkwEr5wF06n6GeYgTBoAYK3/uq+1JljzZgFSOslBC
         eyl7KAhdOE7vMzdwZ6d5iSYyx3ggQUqHE8xETBed3ljsTig0OD3WbKl0fsDT0FJbzEh6
         2hlywjaXVFPjiyf4eNgYlVYHWM+oxZbPXT0oMAU1di8D7jdEmhg0MSTc3CXvccKp1T1t
         L+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sL/rbJ8T1w26m0FDbphKBsY/xLpZ7Is14/l1AhjpfWc=;
        b=C+6+gD7cCR4SFYNpUqYOzzOCW0clvBT3LdJbbDABX8eC/gHyL8BZ5hpQCybYZ8hEfr
         y1XzBsB9NuDFf5jvc46HJnjEf83y4fZcXuiLOQLtRHDgA1JyRYfyjtSu/Q/E21SpXrEj
         XEqJz7edswLb2Y/t3ooUpXyNgoa+KgNS2lmUhRI4OOQLDkO5AvDyXTbdEPg0vm/I/gTB
         pGDXUquju+tJxmpB+F6DgWMWUVe0ye/chMs6xhsmluP2ZQsMq82NWY753oaNimF12syV
         E2V+AJtIzgI2ZRc11ju4a5HC67/ooAK0Qa6RXQ0VL8BxT7a7uzY0uSkbBSevtJ4EvUmk
         8ANg==
X-Gm-Message-State: AFqh2kqsaITU0TuSy+QRyYujKWlQzL95S7RDDyP0Ad+/mCRzyg4+QClZ
        R0O4kYdLGj2Xw63a5/oxYJ/7qA==
X-Google-Smtp-Source: AMrXdXutPD8Vk2CuRuy93tFMO37dNdGfW8AA3U88qflfNLQVq2l918cyzsVi6BWzt+jYQtr7whPWcQ==
X-Received: by 2002:a17:90a:c281:b0:225:c190:3b9 with SMTP id f1-20020a17090ac28100b00225c19003b9mr1246940pjt.23.1671763148930;
        Thu, 22 Dec 2022 18:39:08 -0800 (PST)
Received: from leoy-yangtze.lan (n058152048149.netvigator.com. [58.152.48.149])
        by smtp.gmail.com with ESMTPSA id a8-20020a17090a688800b002135e8074b1sm3746834pjd.55.2022.12.22.18.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 18:39:08 -0800 (PST)
Date:   Fri, 23 Dec 2022 10:39:01 +0800
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
Subject: Re: [PATCH v2 1/7] perf: Remove duplication around
 EVENT_SOURCE_DEVICE_PATH
Message-ID: <Y6UUxUEmO1ucwBzV@leoy-yangtze.lan>
References: <20221222160328.3639989-1-james.clark@arm.com>
 <20221222160328.3639989-2-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221222160328.3639989-2-james.clark@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 04:03:21PM +0000, James Clark wrote:
> The pattern for accessing EVENT_SOURCE_DEVICE_PATH is duplicated in a
> few places, so add two utility functions to cover it. Also just use
> perf_pmu__scan_file() instead of pmu_type() which already does the same
> thing.
> 
> No functional changes.

After I read the article: https://lwn.net/Articles/69419/, good to see
this patch uses scnprintf() to replace snprintf().

> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/arch/arm/util/auxtrace.c |   5 +-
>  tools/perf/arch/x86/util/pmu.c      |  12 +--
>  tools/perf/util/pmu.c               | 110 +++++++++++-----------------
>  tools/perf/util/pmu.h               |   5 +-
>  4 files changed, 49 insertions(+), 83 deletions(-)
> 
> diff --git a/tools/perf/arch/arm/util/auxtrace.c b/tools/perf/arch/arm/util/auxtrace.c
> index deeb163999ce..3cb4a6a16112 100644
> --- a/tools/perf/arch/arm/util/auxtrace.c
> +++ b/tools/perf/arch/arm/util/auxtrace.c
> @@ -55,17 +55,16 @@ static struct perf_pmu **find_all_arm_spe_pmus(int *nr_spes, int *err)
>  
>  static struct perf_pmu **find_all_hisi_ptt_pmus(int *nr_ptts, int *err)
>  {
> -	const char *sysfs = sysfs__mountpoint();
>  	struct perf_pmu **hisi_ptt_pmus = NULL;
>  	struct dirent *dent;
>  	char path[PATH_MAX];
>  	DIR *dir = NULL;
>  	int idx = 0;
>  
> -	snprintf(path, PATH_MAX, "%s" EVENT_SOURCE_DEVICE_PATH, sysfs);
> +	perf_pmu__event_source_devices_scnprintf(path, PATH_MAX);

Nitpick: since 'path' is an array, a good practice is to use
'sizeof(path)' rather than 'PATH_MAX' for passing the length.

>  	dir = opendir(path);
>  	if (!dir) {
> -		pr_err("can't read directory '%s'\n", EVENT_SOURCE_DEVICE_PATH);
> +		pr_err("can't read directory '%s'\n", path);
>  		*err = -EINVAL;
>  		return NULL;
>  	}
> diff --git a/tools/perf/arch/x86/util/pmu.c b/tools/perf/arch/x86/util/pmu.c
> index 74d69db1ea99..e3456d4b9063 100644
> --- a/tools/perf/arch/x86/util/pmu.c
> +++ b/tools/perf/arch/x86/util/pmu.c
> @@ -15,8 +15,6 @@
>  #include "../../../util/pmu.h"
>  #include "../../../util/fncache.h"
>  
> -#define TEMPLATE_ALIAS	"%s/bus/event_source/devices/%s/alias"
> -
>  struct pmu_alias {
>  	char *name;
>  	char *alias;
> @@ -72,18 +70,14 @@ static int setup_pmu_alias_list(void)
>  	char path[PATH_MAX];
>  	DIR *dir;
>  	struct dirent *dent;
> -	const char *sysfs = sysfs__mountpoint();
>  	struct pmu_alias *pmu_alias;
>  	char buf[MAX_PMU_NAME_LEN];
>  	FILE *file;
>  	int ret = -ENOMEM;
>  
> -	if (!sysfs)
> +	if (!perf_pmu__event_source_devices_scnprintf(path, PATH_MAX))
>  		return -1;
>  
> -	snprintf(path, PATH_MAX,
> -		 "%s" EVENT_SOURCE_DEVICE_PATH, sysfs);
> -
>  	dir = opendir(path);
>  	if (!dir)
>  		return -errno;
> @@ -93,9 +87,7 @@ static int setup_pmu_alias_list(void)
>  		    !strcmp(dent->d_name, ".."))
>  			continue;
>  
> -		snprintf(path, PATH_MAX,
> -			 TEMPLATE_ALIAS, sysfs, dent->d_name);
> -
> +		perf_pmu__pathname_scnprintf(path, PATH_MAX, dent->d_name, "alias");
>  		if (!file_available(path))
>  			continue;
>  
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index 2bdeb89352e7..827c1a6bb99a 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -107,14 +107,10 @@ int perf_pmu__format_parse(char *dir, struct list_head *head)
>  static int pmu_format(const char *name, struct list_head *format)
>  {
>  	char path[PATH_MAX];
> -	const char *sysfs = sysfs__mountpoint();
>  
> -	if (!sysfs)
> +	if (!perf_pmu__pathname_scnprintf(path, PATH_MAX, name, "format"))
>  		return -1;
>  
> -	snprintf(path, PATH_MAX,
> -		 "%s" EVENT_SOURCE_DEVICE_PATH "%s/format", sysfs, name);
> -
>  	if (!file_available(path))
>  		return 0;
>  
> @@ -513,14 +509,10 @@ static int pmu_aliases_parse(char *dir, struct list_head *head)
>  static int pmu_aliases(const char *name, struct list_head *head)
>  {
>  	char path[PATH_MAX];
> -	const char *sysfs = sysfs__mountpoint();
>  
> -	if (!sysfs)
> +	if (!perf_pmu__pathname_scnprintf(path, PATH_MAX, name, "events"))
>  		return -1;
>  
> -	snprintf(path, PATH_MAX,
> -		 "%s/bus/event_source/devices/%s/events", sysfs, name);
> -
>  	if (!file_available(path))
>  		return 0;
>  
> @@ -554,52 +546,16 @@ static int pmu_alias_terms(struct perf_pmu_alias *alias,
>  	return 0;
>  }
>  
> -/*
> - * Reading/parsing the default pmu type value, which should be
> - * located at:
> - * /sys/bus/event_source/devices/<dev>/type as sysfs attribute.
> - */
> -static int pmu_type(const char *name, __u32 *type)
> -{
> -	char path[PATH_MAX];
> -	FILE *file;
> -	int ret = 0;
> -	const char *sysfs = sysfs__mountpoint();
> -
> -	if (!sysfs)
> -		return -1;
> -
> -	snprintf(path, PATH_MAX,
> -		 "%s" EVENT_SOURCE_DEVICE_PATH "%s/type", sysfs, name);
> -
> -	if (access(path, R_OK) < 0)
> -		return -1;
> -
> -	file = fopen(path, "r");
> -	if (!file)
> -		return -EINVAL;
> -
> -	if (1 != fscanf(file, "%u", type))
> -		ret = -1;
> -
> -	fclose(file);
> -	return ret;
> -}
> -
>  /* Add all pmus in sysfs to pmu list: */
>  static void pmu_read_sysfs(void)
>  {
>  	char path[PATH_MAX];
>  	DIR *dir;
>  	struct dirent *dent;
> -	const char *sysfs = sysfs__mountpoint();
>  
> -	if (!sysfs)
> +	if (!perf_pmu__event_source_devices_scnprintf(path, PATH_MAX))
>  		return;
>  
> -	snprintf(path, PATH_MAX,
> -		 "%s" EVENT_SOURCE_DEVICE_PATH, sysfs);
> -
>  	dir = opendir(path);
>  	if (!dir)
>  		return;
> @@ -696,14 +652,9 @@ static char *pmu_id(const char *name)
>  static int is_arm_pmu_core(const char *name)
>  {
>  	char path[PATH_MAX];
> -	const char *sysfs = sysfs__mountpoint();
>  
> -	if (!sysfs)
> +	if (!perf_pmu__pathname_scnprintf(path, PATH_MAX, name, "cpus"))
>  		return 0;
> -
> -	/* Look for cpu sysfs (specific to arm) */
> -	scnprintf(path, PATH_MAX, "%s/bus/event_source/devices/%s/cpus",
> -				sysfs, name);
>  	return file_available(path);
>  }
>  
> @@ -969,11 +920,8 @@ static struct perf_pmu *pmu_lookup(const char *lookup_name)
>  		return NULL;
>  
>  	/*
> -	 * Check the type first to avoid unnecessary work.
> +	 * Check the aliases first to avoid unnecessary work.
>  	 */
> -	if (pmu_type(name, &type))
> -		return NULL;
> -
>  	if (pmu_aliases(name, &aliases))
>  		return NULL;
>  
> @@ -983,9 +931,14 @@ static struct perf_pmu *pmu_lookup(const char *lookup_name)
>  
>  	pmu->cpus = pmu_cpumask(name);
>  	pmu->name = strdup(name);
> +
>  	if (!pmu->name)
>  		goto err;
>  
> +	/* Read type, and ensure that 1 value (type) is successfully assigned */

Maybe I don't understand well, seems to me a better comment is:

/* Read type, and ensure that type value is successfully assigned (return 1) */


The rest looks good to me.  With addressing above two comments:

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> +	if (perf_pmu__scan_file(pmu, "type", "%u", &type) != 1)
> +		goto err;
> +
>  	alias_name = pmu_find_alias_name(name);
>  	if (alias_name) {
>  		pmu->alias_name = strdup(alias_name);
> @@ -1786,16 +1739,11 @@ bool pmu_have_event(const char *pname, const char *name)
>  static FILE *perf_pmu__open_file(struct perf_pmu *pmu, const char *name)
>  {
>  	char path[PATH_MAX];
> -	const char *sysfs;
>  
> -	sysfs = sysfs__mountpoint();
> -	if (!sysfs)
> +	if (!perf_pmu__pathname_scnprintf(path, PATH_MAX, pmu->name, name) ||
> +	    !file_available(path))
>  		return NULL;
>  
> -	snprintf(path, PATH_MAX,
> -		 "%s" EVENT_SOURCE_DEVICE_PATH "%s/%s", sysfs, pmu->name, name);
> -	if (!file_available(path))
> -		return NULL;
>  	return fopen(path, "r");
>  }
>  
> @@ -1849,7 +1797,6 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
>  {
>  	struct stat st;
>  	char caps_path[PATH_MAX];
> -	const char *sysfs = sysfs__mountpoint();
>  	DIR *caps_dir;
>  	struct dirent *evt_ent;
>  
> @@ -1858,12 +1805,9 @@ int perf_pmu__caps_parse(struct perf_pmu *pmu)
>  
>  	pmu->nr_caps = 0;
>  
> -	if (!sysfs)
> +	if (!perf_pmu__pathname_scnprintf(caps_path, PATH_MAX, pmu->name, "caps"))
>  		return -1;
>  
> -	snprintf(caps_path, PATH_MAX,
> -		 "%s" EVENT_SOURCE_DEVICE_PATH "%s/caps", sysfs, pmu->name);
> -
>  	if (stat(caps_path, &st) < 0) {
>  		pmu->caps_initialized = true;
>  		return 0;	/* no error if caps does not exist */
> @@ -1993,3 +1937,31 @@ int perf_pmu__cpus_match(struct perf_pmu *pmu, struct perf_cpu_map *cpus,
>  	*ucpus_ptr = unmatched_cpus;
>  	return 0;
>  }
> +
> +int perf_pmu__event_source_devices_scnprintf(char *pathname, size_t size)
> +{
> +	const char *sysfs = sysfs__mountpoint();
> +
> +	if (!sysfs)
> +		return 0;
> +	return scnprintf(pathname, size, "%s/bus/event_source/devices/", sysfs);
> +}
> +
> +/*
> + * Fill 'buf' with the path to a file or folder in 'pmu_name' in
> + * sysfs. For example if pmu_name = "cs_etm" and 'filename' = "format"
> + * then pathname will be filled with
> + * "/sys/bus/event_source/devices/cs_etm/format"
> + *
> + * Return 0 if the sysfs mountpoint couldn't be found or if no
> + * characters were written.
> + */
> +int perf_pmu__pathname_scnprintf(char *buf, size_t size,
> +				 const char *pmu_name, const char *filename)
> +{
> +	char base_path[PATH_MAX];
> +
> +	if (!perf_pmu__event_source_devices_scnprintf(base_path, PATH_MAX))
> +		return 0;
> +	return scnprintf(buf, size, "%s%s/%s", base_path, pmu_name, filename);
> +}
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 69ca0004f94f..2f2bb0286e2a 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -22,7 +22,6 @@ enum {
>  };
>  
>  #define PERF_PMU_FORMAT_BITS 64
> -#define EVENT_SOURCE_DEVICE_PATH "/bus/event_source/devices/"
>  #define CPUS_TEMPLATE_CPU	"%s/bus/event_source/devices/%s/cpus"
>  #define MAX_PMU_NAME_LEN 128
>  
> @@ -259,4 +258,8 @@ int perf_pmu__cpus_match(struct perf_pmu *pmu, struct perf_cpu_map *cpus,
>  
>  char *pmu_find_real_name(const char *name);
>  char *pmu_find_alias_name(const char *name);
> +int perf_pmu__event_source_devices_scnprintf(char *pathname, size_t size);
> +int perf_pmu__pathname_scnprintf(char *buf, size_t size,
> +				 const char *pmu_name, const char *filename);
> +
>  #endif /* __PMU_H */
> -- 
> 2.25.1
> 
