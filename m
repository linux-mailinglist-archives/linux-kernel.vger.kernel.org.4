Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5856B93B8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 13:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjCNM0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 08:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbjCNMZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 08:25:49 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1BCBA54D6;
        Tue, 14 Mar 2023 05:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678796586; x=1710332586;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RuyzWY5XFbFQK+dZMnLdmca3l4H11rbmQtGEfO/KEF0=;
  b=Uc9e3vacsGoNSj7yVTFPDhcKvuKAnd50tYmg/DtF6Y8H5+IRQmnSdcbP
   dRs4B8nKpB+PO+hUBbJUq1bjM7XyLxZwix4oZYIuZgZkPYacjtU1qY5yR
   n8H/ULLvXR0IV8+V9E25hiS+nj4RqiS6Gl+Mu2ZlIdhWFfwd9BWVaufCZ
   R87BCapVHoGYPiTRwSzHg5w+nNHxt/sxhsTDpKeSRFnHhJ913gAnHZnWR
   yUe+I/5EW2rF8rk8r5JUNdZTX6ijndSQ4Q1sK3/gTfJ4Ly73aXs8Jta40
   5R+zOGYgqXKA89lnGwxc1aylgGKa1jc5td3eJRN4pMbm7mi1ym6ZEGjmW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="402273918"
X-IronPort-AV: E=Sophos;i="5.98,259,1673942400"; 
   d="scan'208";a="402273918"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 05:21:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="802836234"
X-IronPort-AV: E=Sophos;i="5.98,259,1673942400"; 
   d="scan'208";a="802836234"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.221.17])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2023 05:21:29 -0700
Message-ID: <86250a33-940f-4dce-fa6f-4331be7d806b@intel.com>
Date:   Tue, 14 Mar 2023 14:21:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v1 00/13] Perf tool build improvements
Content-Language: en-US
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Quentin Monnet <quentin@isovalent.com>,
        Andres Freund <andres@anarazel.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Leo Yan <leo.yan@linaro.org>,
        =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev, Stephane Eranian <eranian@google.com>
References: <20230311065753.3012826-1-irogers@google.com>
 <ZBBkWDFdBDC9Spt9@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <ZBBkWDFdBDC9Spt9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/23 14:11, Arnaldo Carvalho de Melo wrote:
> Em Fri, Mar 10, 2023 at 10:57:40PM -0800, Ian Rogers escreveu:
>> Make the default build options a more preferred set, such as making
>> BPF skeletons default and failing the build if jevents or libtracevent
>> dependencies fail. The binutil dependencies are opt-in given license
>> restrictions. abi::__cxa_demangle demangling support is added so that
>> libiberty, from binutils, isn't necessary for C++ demangling.
>>
>> Some build/test dependencies are fixed and the code cleaned up.
> 
> I'll continue fixing more stuff, like adding NO_LIBTRACEEVENT=1 to
> things like amazonlinux devel, that still doesn't package libtraceevent,

FYI I'm currently testing a patch to allow python scripting without
also requiring libtraceevent

