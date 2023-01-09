Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052BE662C81
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbjAIRTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbjAIRTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:19:18 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE770265D;
        Mon,  9 Jan 2023 09:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673284757; x=1704820757;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=W9lQMx8p1cYgBKIitly2zFxbVUfvSpaA8p9FP2KB+GA=;
  b=V7wSzFlqMRCOgoONxEDyNlLjjAqh+Kjd50PFjx41IB0nRVj5LzKuSMlr
   /2EEBPPIwWX19gnAWH/mGahlli02tUUkfkC+dm/iHMdbpIKRexVc7WyMK
   fnWWZ8woCLZcUaSA46lqSDMHYr6Q1SpWk8jgtLb1dAA9u8lARwiDMzeZQ
   qKUtJsnPT25tOxdMpScTJKjB39yTHCU5reeOz+7nVVvdCj0F+WBlAvgNH
   bcptxTnaqDckBhsrKP67OsrFN+XvgpeWdno3CSiRguybaJXVkHGyrVjXp
   83+6d8W5/2nil3DGmMhLpFGB+w1yVL1at81ZZRpJ508HMBDhpg+iRGR1k
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="409174934"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="409174934"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 09:19:15 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="780756701"
X-IronPort-AV: E=Sophos;i="5.96,311,1665471600"; 
   d="scan'208";a="780756701"
Received: from swapnadi-mobl2.amr.corp.intel.com (HELO [10.209.29.117]) ([10.209.29.117])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 09:19:11 -0800
Message-ID: <ceec97e2-2acd-6f15-5675-6b2b143b972f@intel.com>
Date:   Mon, 9 Jan 2023 09:19:09 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] x86/retbleed: add "stuff" mode admin documentation
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
References: <20230109160808.30740-1-rdunlap@infradead.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230109160808.30740-1-rdunlap@infradead.org>
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

On 1/9/23 08:08, Randy Dunlap wrote:
> +			stuff        - Enables "stuffing" mode mitigation,
> +				       which uses return thunking and call depth
> +				       tracking.  Only in effect if
> +				       CONFIG_CALL_DEPTH_TRACKING is set and
> +				       Spectre V2 mitigation mode is
> +				       "retpoline".
> +				       IBRS is fully secure mitigation but is
> +				       more costly (slower) than stuffing.

The "fully secure" thing makes me cringe a bit.

I'd suggest saying:

	IBRS is a stronger mitigation
	but is more costly than stuffing
	(slower).


