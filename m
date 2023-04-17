Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACF96E3CEF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 02:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjDQAXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 20:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjDQAXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 20:23:36 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA8E210C;
        Sun, 16 Apr 2023 17:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681691016; x=1713227016;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lzQbXWRU7YivvtCUE1XwPbL80+u+WR0OsIWR1+rgxS8=;
  b=PcQ7xuElVku4UAgFT8UK0WUlEXOdbGxB3gqJ8pnzz6osZGGtEHjGNuxG
   LhsXhF3swmEk0Fle/UDx+ZrTbnd7gdsjzszxJ8auid/Jb78CFs2jC8q+B
   f8mQ0au4lSj7avwyjwmGZfzoJy8LeWGuRwCJ88JVAHbu506IJbgh1VK1o
   68tB//YsgxL397eBzT729vkRxSyZHlgIbmYFn29k1UUdhQtnOKBgs5KJd
   3gNGKjWkwHNFiMM7I4uxFMVm2VxrRWL9E3Xi0uNzWx/zmb6WWhO/ckjjL
   2KMt0agEiYDWdLRaw/CH/8j9juOQV/9xBgtu3x8J5YxGwuwMgOOWBXIhL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="409986235"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="409986235"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 17:23:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="667930798"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="667930798"
Received: from rfaria-mobl.amr.corp.intel.com (HELO [10.209.22.12]) ([10.209.22.12])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2023 17:23:34 -0700
Message-ID: <7b068fc1-2d88-27c3-b561-0a6c36c589da@intel.com>
Date:   Sun, 16 Apr 2023 17:23:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2.1 2/2] x86/Documentation: Add documentation about
 cluster
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, corbet@lwn.net,
        jgross@suse.com, andrew.cooper3@citrix.com, peterz@infradead.org,
        Jason@zx2c4.com, thomas.lendacky@amd.com, puwen@hygon.cn,
        x86@kernel.org, linux-doc@vger.kernel.org, oleksandr@natalenko.name
References: <20230413172918.1500-3-kprateek.nayak@amd.com>
 <20230414031743.875-1-kprateek.nayak@amd.com>
 <cf4fdb30-6f2e-ca3e-fbc0-b48f6949508d@gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <cf4fdb30-6f2e-ca3e-fbc0-b48f6949508d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/23 19:24, Bagas Sanjaya wrote:
> On 4/14/23 10:17, K Prateek Nayak wrote:
>> +  - cluster_id:
>> +
>> +    A per-CPU variable containing:
>> +
>> +      - Upper bits extracted from the APIC ID.  CPUs which have the same value
>> +        in these bits share an L2 and have the same cluster_id.
>> +
>> +        CPUs for which cluster information is unavailable will show 65535
>> +        (BAD_APICID) as the cluster_id.
> "... return cluster_id of 65535 (BAD_APICID)."

Bagas, this is talking about a per-cpu variable.  Variables don't
"return" things, functions do.

I also have a request: I'd really appreciate if you could avoid
reviewing x86-related documentation.  The review comments that I've seen
coming from you have not helped x86 documentation.  They've hurt the
patches more than they have helped.

