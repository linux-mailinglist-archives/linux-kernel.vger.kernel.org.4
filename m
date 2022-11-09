Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B4D6224E9
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 08:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiKIHxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 02:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiKIHxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 02:53:46 -0500
Received: from out199-5.us.a.mail.aliyun.com (out199-5.us.a.mail.aliyun.com [47.90.199.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D47641F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 23:53:43 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VUMxDA2_1667980416;
Received: from 30.97.48.51(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VUMxDA2_1667980416)
          by smtp.aliyun-inc.com;
          Wed, 09 Nov 2022 15:53:38 +0800
Message-ID: <79f89559-f213-c022-990b-1c6a5068fc5a@linux.alibaba.com>
Date:   Wed, 9 Nov 2022 15:53:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH -V2 2/2] migrate: convert migrate_pages() to use folios
To:     Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>
References: <20221109012348.93849-1-ying.huang@intel.com>
 <20221109012348.93849-3-ying.huang@intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20221109012348.93849-3-ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/9/2022 9:23 AM, Huang Ying wrote:
> Quite straightforward, the page functions are converted to
> corresponding folio functions.  Same for comments.
> 
> THP specific code are converted to be large folio.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Matthew Wilcox <willy@infradead.org>

Tested for normal page, THP, and hugetlb migration, and works well on my 
platform.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Baolin Wang <baolin.wang@linux.alibaba.com>
