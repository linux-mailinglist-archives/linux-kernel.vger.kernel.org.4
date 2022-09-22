Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D065E6B7A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 21:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbiIVTHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 15:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbiIVTHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 15:07:44 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B27F6860;
        Thu, 22 Sep 2022 12:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663873664; x=1695409664;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8ZeyjYpqe72ewLlASmK/A6hGNqxbAV4/mf1Wzf7Awtc=;
  b=dNKarn6rl1DpBZxzAuyYnYDIfh38fObmwnmPbctTXNTL/IfhE+C6bZ2J
   GgSiv4jjjWIM0skiE61zAKiTwayj2gJX8fVnqmel2YiK3lubgElRBsu2F
   Xzrcw3MQu3D8HF6qPkZSZc1WBjA3H3RnnbqXCitYVv/7bGt4B6OHTLNJW
   zsvKG+QQ+ajeRTOUILOMBhgMX1AG/3GIEUVnVk9EqY91rfrmOQXRgjBN0
   AvWQ8KOKywmoyaeXllL9wafb08c9Q3B2KR8OJ4+kUermb8x7DDbZlgu+P
   UepgbR0NI6QTgtqTIOjDlsTEP2szY/o3TEtopu03dC3+idC9+oZS6fGhi
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10478"; a="301839263"
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="301839263"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 12:01:57 -0700
X-IronPort-AV: E=Sophos;i="5.93,337,1654585200"; 
   d="scan'208";a="597569877"
Received: from sponnura-mobl1.amr.corp.intel.com (HELO [10.209.58.200]) ([10.209.58.200])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 12:01:57 -0700
Message-ID: <54572271-d5ca-820f-911e-19fd9d80ae2c@intel.com>
Date:   Thu, 22 Sep 2022 12:01:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] ACPI: processor idle: Practically limit "Dummy wait"
 workaround to old Intel systems
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Mario Limonciello <Mario.Limonciello@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        linux-acpi@vger.kernel.org, Linux PM <linux-pm@vger.kernel.org>
References: <20220922184745.3252932-1-dave.hansen@intel.com>
 <78d13a19-2806-c8af-573e-7f2625edfab8@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <78d13a19-2806-c8af-573e-7f2625edfab8@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/22/22 11:53, Rafael J. Wysocki wrote:
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> or do you want me to pick this up?

I'll just stick it in x86/urgent.

It's modifying code in a x86 #ifdef.  I'll call it a small enclave of
sovereign x86 territory in ACPI land, just like an embassy. ;)
