Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063EE700635
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 13:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240987AbjELLCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 07:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240164AbjELLCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 07:02:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 15646106CF
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 04:02:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43FCFFEC;
        Fri, 12 May 2023 04:02:45 -0700 (PDT)
Received: from [10.57.73.22] (unknown [10.57.73.22])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B01A3F67D;
        Fri, 12 May 2023 04:01:59 -0700 (PDT)
Message-ID: <9d89ba3d-775f-426f-0956-0d002193bd4d@arm.com>
Date:   Fri, 12 May 2023 12:01:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [RESEND PATCH v1 1/5] mm: vmalloc must set pte via arch code
To:     Zi Yan <ziy@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        SeongJae Park <sj@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, damon@lists.linux.dev
References: <20230511132113.80196-1-ryan.roberts@arm.com>
 <20230511132113.80196-2-ryan.roberts@arm.com>
 <F6BE4C55-EDF2-47DB-A1D3-F4DEA93E89D4@nvidia.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <F6BE4C55-EDF2-47DB-A1D3-F4DEA93E89D4@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/2023 16:00, Zi Yan wrote:
> On 11 May 2023, at 9:21, Ryan Roberts wrote:
> 
>> It is bad practice to directly set pte entries within a pte table.
>> Instead all modifications must go through arch-provided helpers such as
>> set_pte_at() to give the arch code visibility and allow it to validate
>> (and potentially modify) the operation.
>>
>> Fixes: 3e9a9e256b1e ("mm: add a vmap_pfn function")
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>  mm/vmalloc.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
> LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

Thanks for the reviews!

