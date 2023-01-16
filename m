Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24A966B6CB
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 06:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231685AbjAPFPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 00:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjAPFPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 00:15:09 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2105972A2;
        Sun, 15 Jan 2023 21:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673846109; x=1705382109;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4YWxotzkHgTG5wQlXN7X65qn9NuDDjyO017wRvnH0sw=;
  b=O+hbJNsSGuKmFNd6b4upzOPDrcJjN0Nln9Ao6T/az/8ryoRZUnRCONCd
   G7axwq47hOUNOWLegeG6goY6A29Gv1BqdzM5NrqSAB0noUv3Khsph3d5v
   BDyPnDSoEFFE4igOJ7fX+hO7hc6z0BvBi3dGonENjpyFqcQPxWg4+/si7
   xGxlMh6VTDGdoJhvcMGcqWvwpe2Ilke9NJS5axdJNGJUrFBASzZZO+Zl8
   8gxni8J03Fbqej+gRziTeWG5QkL4Xh6c3oEqcUF3rI37TuW1RUU/eiVHM
   saU2UIXe6CuqfZYtd9ZlbpGDOY2B1dMc2ECU5LWlZ/vfBgwaI0oroAFDv
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="323089330"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="323089330"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2023 21:15:08 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10591"; a="636428515"
X-IronPort-AV: E=Sophos;i="5.97,220,1669104000"; 
   d="scan'208";a="636428515"
Received: from ttulbure-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.252.53.56])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2023 21:15:05 -0800
Message-ID: <ae03d3af-02de-0d36-4680-c4ad934da77d@intel.com>
Date:   Mon, 16 Jan 2023 07:15:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH v2] tools:perf:scripts:python:intel-pt-events del
 unusedvar
To:     Alexander Pantyukhin <apantykhin@gmail.com>
Cc:     mingo@redhat.com, namhyung@kernel.org, jolsa@kernel.org,
        acme@kernel.org, akpm@linux-foundation.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230114130533.2877-1-apantykhin@gmail.com>
Content-Language: en-US
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20230114130533.2877-1-apantykhin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/01/23 15:05, Alexander Pantyukhin wrote:
> The event_attr is never used later, the var is ok be deleted.
> Additional code simplification is to substitute string slice comparison
> with "substring" function. This case no need to know the length specific
> words.
> 
> Signed-off-by: Alexander Pantyukhin <apantykhin@gmail.com>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  tools/perf/scripts/python/intel-pt-events.py | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/scripts/python/intel-pt-events.py b/tools/perf/scripts/python/intel-pt-events.py
> index 08862a2582f4..dfd566369ca4 100644
> --- a/tools/perf/scripts/python/intel-pt-events.py
> +++ b/tools/perf/scripts/python/intel-pt-events.py
> @@ -340,7 +340,6 @@ def print_srccode(comm, param_dict, sample, symbol, dso, with_insn):
>  	print(start_str, src_str)
>  
>  def do_process_event(param_dict):
> -	event_attr = param_dict["attr"]
>  	sample	   = param_dict["sample"]
>  	raw_buf	   = param_dict["raw_buf"]
>  	comm	   = param_dict["comm"]
> @@ -349,6 +348,7 @@ def do_process_event(param_dict):
>  	# callchain  = param_dict["callchain"]
>  	# brstack    = param_dict["brstack"]
>  	# brstacksym = param_dict["brstacksym"]
> +	# event_attr = param_dict["attr"]
>  
>  	# Symbol and dso info are not always resolved
>  	dso    = get_optional(param_dict, "dso")
> @@ -359,13 +359,13 @@ def do_process_event(param_dict):
>  		print(glb_switch_str[cpu])
>  		del glb_switch_str[cpu]
>  
> -	if name[0:12] == "instructions":
> +	if name.startswith("instructions"):
>  		if glb_src:
>  			print_srccode(comm, param_dict, sample, symbol, dso, True)
>  		else:
>  			print_instructions_start(comm, sample)
>  			print_common_ip(param_dict, sample, symbol, dso)
> -	elif name[0:8] == "branches":
> +	elif name.startswith("branches"):
>  		if glb_src:
>  			print_srccode(comm, param_dict, sample, symbol, dso, False)
>  		else:

