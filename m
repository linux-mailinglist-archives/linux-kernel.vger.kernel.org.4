Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89005F7558
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 10:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiJGIdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 04:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJGIdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 04:33:36 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30C7B97A2;
        Fri,  7 Oct 2022 01:33:35 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id lx7so3915933pjb.0;
        Fri, 07 Oct 2022 01:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t8AvHLBrW0u0+zP3kVvWPEDq2LuXtLquFKvkRq6GRpw=;
        b=eLxeatpmAbGEj7/LFEmAhqjqPVqkAxEmu04khoe3lpOsW3/2Vvltp0pSfrLjIiok03
         M/NpPJ6EveheUFtlMmg50n/GEwcgcYu0M5U0fbiFuYfPXuKFYwVcFYoC60heRUOgafBT
         xCDEPt735WiC5fjIN0yss8U7P3bWnZmiMS3yvZgcHxjUgSp/0OfqRmYNJdo8eIeByi07
         pUOL9J5IoOyFOyOC/BSYr3K8HBgpQGx+CyQ3o75zoSDMPqYRupg344TmQ4oIStaHhXR9
         dZUnNkRzg3ALL6ZbTbTaXZKgqb4s3c1HMhJIapC0h8sPWkdTsQq4uWYuxmdULXzwk7Y1
         LYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t8AvHLBrW0u0+zP3kVvWPEDq2LuXtLquFKvkRq6GRpw=;
        b=1DIn5r/26VJhVSYS/9hEej5OQcG91kshZsQLj6fbX9c56dk/uZvn4ZTVQoe+0RflKd
         omjNRsNg5TkSzeCyGR9xW4F8yTkVuH9Cj/voHeNnJOgcimPi/Qg3FhYSYQ6QUyjW+Q97
         zAzWTdINUVZw2Sq008HIJ3OiDGscmAkwG2TaiMu6tH2OUfsy5hfBlRib8GnoydEOsCbm
         lrX95S67pRxff40Ch/LWYuIC1tDajTMR9Zx5b2DSnRQHfH4CrPMrFseKZ9Ji1wayCTmA
         hf6h/WKN9wNIs7kjUwiHzzxUEdHEhbFW+oCpjzyJYazSOgWJZfMBw0Aa6Nnb8it0HYGh
         v4/Q==
X-Gm-Message-State: ACrzQf3qcn9MAfDNKOKiVLoHvAYdbZADF8H1No6Sm066MPMt67SosXMa
        lJbzAhy3t3FZYfUmDc0KkXQ=
X-Google-Smtp-Source: AMsMyM7MRyd/TxAVuMQJkKWcGMTHmVr7iW4cf58HSCHSQlkDJdVxaoELplBF0CW9NNcCrKJCXnXpCA==
X-Received: by 2002:a17:90b:3b4b:b0:203:3265:d314 with SMTP id ot11-20020a17090b3b4b00b002033265d314mr15177200pjb.196.1665131615035;
        Fri, 07 Oct 2022 01:33:35 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-21.three.co.id. [180.214.232.21])
        by smtp.gmail.com with ESMTPSA id c4-20020a170902d48400b0017f637b3e87sm945231plg.279.2022.10.07.01.33.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 01:33:34 -0700 (PDT)
Message-ID: <eb7e7927-84b4-a952-e8c7-dec518bfcda9@gmail.com>
Date:   Fri, 7 Oct 2022 15:33:25 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v5 00/12] x86/resctrl: Support for AMD QoS new features
Content-Language: en-US
To:     Babu Moger <babu.moger@amd.com>, corbet@lwn.net,
        reinette.chatre@intel.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de
Cc:     fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com
References: <166431016617.373387.1968875281081252467.stgit@bmoger-ubuntu>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <166431016617.373387.1968875281081252467.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/22 03:25, Babu Moger wrote:
> New AMD processors can now support following QoS features.
> 
> 1. Slow Memory Bandwidth Allocation (SMBA)
>    With this feature, the QOS enforcement policies can be applied
>    to the external slow memory connected to the host. QOS enforcement
>    is accomplished by assigning a Class Of Service (COS) to a processor
>    and specifying allocations or limits for that COS for each resource
>    to be allocated.
> 
>    Currently, CXL.memory is the only supported "slow" memory device. With
>    the support of SMBA feature the hardware enables bandwidth allocation
>    on the slow memory devices.
> 
> 2. Bandwidth Monitoring Event Configuration (BMEC)
>    The bandwidth monitoring events mbm_total_event and mbm_local_event 
>    are set to count all the total and local reads/writes respectively.
>    With the introduction of slow memory, the two counters are not enough
>    to count all the different types are memory events. With the feature
>    BMEC, the users have the option to configure mbm_total_event and
>    mbm_local_event to count the specific type of events.
> 
>    Following are the bitmaps of events supported.
>    Bits    Description
>      6       Dirty Victims from the QOS domain to all types of memory
>      5       Reads to slow memory in the non-local NUMA domain
>      4       Reads to slow memory in the local NUMA domain
>      3       Non-temporal writes to non-local NUMA domain
>      2       Non-temporal writes to local NUMA domain
>      1       Reads to memory in the non-local NUMA domain
>      0       Reads to memory in the local NUMA domain
> 
> This series adds support for these features.
> 
> Feature description is available in the specification, "AMD64 Technology Platform Quality
> of Service Extensions, Revision: 1.03 Publication # 56375 Revision: 1.03 Issue Date: February 2022".
> 
> Link: https://www.amd.com/en/support/tech-docs/amd64-technology-platform-quality-service-extensions
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> 
> ---
> v5:
>   Summary of changes.
>   1. Split the series into two. The first two patches are bug fixes. So, sent them separate.
>   2. The config files mbm_total_config and mbm_local_config are now under
>      /sys/fs/resctrl/info/L3_MON/. Removed these config files from mon groups.
>   3. Ran "checkpatch --strict --codespell" on all the patches. Looks good with few known exceptions.
>   4. Few minor text changes in resctrl.rst file. 
> 
> v4:
>   https://lore.kernel.org/lkml/166257348081.1043018.11227924488792315932.stgit@bmoger-ubuntu/
>   Got numerios of comments from Reinette Chatre. Addressed most of them. 
>   Summary of changes.
>   1. Removed mon_configurable under /sys/fs/resctrl/info/L3_MON/.  
>   2. Updated mon_features texts if the BMEC is supported.
>   3. Added more explanation about the slow memory support.
>   4. Replaced smp_call_function_many with on_each_cpu_mask call.
>   5. Removed arch_has_empty_bitmaps
>   6. Few other text changes.
>   7. Removed Reviewed-by if the patch is modified.
>   8. Rebased the patches to latest tip.
> 
> v3:
>   https://lore.kernel.org/lkml/166117559756.6695.16047463526634290701.stgit@bmoger-ubuntu/ 
>   a. Rebased the patches to latest tip. Resolved some conflicts.
>      https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
>   b. Taken care of feedback from Bagas Sanjaya.
>   c. Added Reviewed by from Mingo.
>   Note: I am still looking for comments from Reinette or Fenghua.
> 
> v2:
>   https://lore.kernel.org/lkml/165938717220.724959.10931629283087443782.stgit@bmoger-ubuntu/
>   a. Rebased the patches to latest stable tree (v5.18.15). Resolved some conflicts.
>   b. Added the patch to fix CBM issue on AMD. This was originally discussed
>      https://lore.kernel.org/lkml/20220517001234.3137157-1-eranian@google.com/
> 
> v1:
>   https://lore.kernel.org/lkml/165757543252.416408.13547339307237713464.stgit@bmoger-ubuntu/
> 
> Babu Moger (12):
>       x86/cpufeatures: Add Slow Memory Bandwidth Allocation feature flag
>       x86/resctrl: Add a new resource type RDT_RESOURCE_SMBA
>       x86/cpufeatures: Add Bandwidth Monitoring Event Configuration feature flag
>       x86/resctrl: Include new features in command line options
>       x86/resctrl: Detect and configure Slow Memory Bandwidth allocation
>       x86/resctrl: Introduce data structure to support monitor configuration
>       x86/resctrl: Add sysfs interface to read mbm_total_bytes event configuration
>       x86/resctrl: Add sysfs interface to read mbm_local_bytes event configuration
>       x86/resctrl: Add sysfs interface to write mbm_total_bytes event configuration
>       x86/resctrl: Add sysfs interface to write mbm_local_bytes event configuration
>       x86/resctrl: Replace smp_call_function_many() with on_each_cpu_mask()
>       Documentation/x86: Update resctrl_ui.rst for new features
> 
> 
>  .../admin-guide/kernel-parameters.txt         |   2 +-
>  Documentation/x86/resctrl.rst                 | 130 +++++++-
>  arch/x86/include/asm/cpufeatures.h            |   2 +
>  arch/x86/kernel/cpu/cpuid-deps.c              |   1 +
>  arch/x86/kernel/cpu/resctrl/core.c            |  51 ++-
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c     |   2 +-
>  arch/x86/kernel/cpu/resctrl/internal.h        |  33 +-
>  arch/x86/kernel/cpu/resctrl/monitor.c         |   9 +-
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c        | 298 ++++++++++++++++--
>  arch/x86/kernel/cpu/scattered.c               |   2 +
>  10 files changed, 496 insertions(+), 34 deletions(-)
> 

Hi Babu, sorry for having to do public reply to this v5 cover letter
due to accidentally delete the preview documentation patch for your
upcoming v6.

Thanks for privately sending me the preview patch. Seeing it at a glance,
LGTM. Please send the full v6 series for us to review.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
