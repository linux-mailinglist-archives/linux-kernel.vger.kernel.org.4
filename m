Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2CB8706D32
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 17:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjEQPtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 11:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjEQPt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 11:49:29 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9C6C2;
        Wed, 17 May 2023 08:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684338568; x=1715874568;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=3EyLVD0TTPV3FCOCCcWuvj+mI5c+appPtjz6zRCuHA0=;
  b=LOdARhuYCvlBqYE+Kn5f0h5PVcy064VgZV3Jx0nf3paXNbs1jlKjQRX8
   mEYiPcB2dgN7ysOiyQoQioVhKAxbUAtEvPVCabLtgNJtFf7qDXoASLZz+
   am5lx6cD9T8ByZW6Vr9dnvBVtl42TLxuAwywXnfJG/+p5Vf8EX0HNw2DQ
   z07mjnAbuIvbh2QsYwUMccxzKL3f8aROM6t2b18kYJWz0wTvvwkMo5OLJ
   tbm5rwS5J/JNGci97uPLv5Dui5LjnK7Beu5F0V1PPnJKQlcBFAnYIR78C
   p0xP/wADV0iQJsC+I5r4+XmmA8wFycauyienwdOzCXCgjzRPo5swFeQzY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="331411534"
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="331411534"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 08:49:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="876099591"
X-IronPort-AV: E=Sophos;i="5.99,282,1677571200"; 
   d="scan'208";a="876099591"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 17 May 2023 08:49:27 -0700
Received: from [10.212.161.221] (kliang2-mobl1.ccr.corp.intel.com [10.212.161.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id 481D7580AF7;
        Wed, 17 May 2023 08:49:26 -0700 (PDT)
Message-ID: <fdac0774-30d6-c81b-5eb9-54edaa6f6ff1@linux.intel.com>
Date:   Wed, 17 May 2023 11:49:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2 15/15] perf vendor events intel: Add metricgroup
 descriptions for all models
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        John Garry <john.g.garry@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20230517152626.563559-1-irogers@google.com>
 <20230517152626.563559-16-irogers@google.com>
From:   "Liang, Kan" <kan.liang@linux.intel.com>
In-Reply-To: <20230517152626.563559-16-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-05-17 11:26 a.m., Ian Rogers wrote:
> +    "Memory_BW": "Grouping from metrics spreadsheet",
> +    "Memory_Lat": "Grouping from metrics spreadsheet",

Seems there is another place we need to update in the convertor script?


Thanks,
Kan
