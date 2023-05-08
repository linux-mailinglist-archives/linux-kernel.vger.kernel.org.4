Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8D46FB495
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 18:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjEHQEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 12:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234057AbjEHQCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 12:02:54 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67155588;
        Mon,  8 May 2023 09:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683561773; x=1715097773;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FJSlVdhkFps4m9yW9DtGq15XX4xhvkxEhOkkJuq8yPo=;
  b=WX/O/03qmAkYvTQT/gZnVB+Il1Q8Z2CuqiprTc0ddIianv+dAJ7aY1OL
   g/Cln1/z/M/VqSdZWxh2vMZrGtPdEiGQZgtjNTIEMU/lx1dy95CKUaiIk
   cz57Db8H4OSHNguR4vOB4sFWVNB1i1RbwB2LGFwEpIekUo36hNfSb1cgT
   5dWL2XGX+QbP7XxplSjpS/XCzCqLvdrFdhtOruy+3HMuvkwNVZ/Koiamf
   I6VWa7NOAL47WntgCcg5kZidAHNaOMUtNUXOplUh06am0WA+vIzTifcJ7
   QnPu9nMvuo/xGEuknI8VXdtGzjEDTZq1do2OmPOdIAONxIQsOH/TsFg0d
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="334127066"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="334127066"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 09:01:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="822729832"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="822729832"
Received: from pscharto-mobl2.amr.corp.intel.com (HELO [10.212.92.102]) ([10.212.92.102])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 09:01:55 -0700
Message-ID: <fa975430-1ca1-fc89-dfa3-f28b2228b6a2@intel.com>
Date:   Mon, 8 May 2023 09:01:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v3 0/2] Fixing check patch styling issues
Content-Language: en-US
To:     Raghu Halharvi <raghuhack78@gmail.com>, linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com
Cc:     linux-kernel@vger.kernel.org
References: <20230508082531.136281-1-raghuhack78@gmail.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230508082531.136281-1-raghuhack78@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/8/23 1:25 AM, Raghu Halharvi wrote:
> v3 changes:
> - Update the cover letter and commit message with full author
>    name(Fabio/Alison)
> - Correct the "typo error" in commit message(Fabio)

Hi Raghu,
Please make sure you pick up all the review tags given by reviewers in 
the previous round and also add them to the respective patches.

Using the b4 tool can do that for you.
https://people.kernel.org/monsieuricon/introducing-b4-and-patch-attestation


> 
> v2 changes:
> Thanks Alison, Ira for your comments, modified the v1 patches as
> suggested.
> Dropped the patch containing tab changes in port.c
> 
> v1 cover letter:
> The following patches are cleanup or fixing the styling issues found
> using checkpatch
> 
> In cxl/core/mbox.c, in case of null check failure, returning errno or
> -ENOMEM in this case is good enough, removing the redundant dev_err
> message.
> 
> In cxl/core/region.c, the else is not required after the return
> statement, cleaned it up.
> 
> Verified the build and sanity by booting the guest VM using the freshly
> built components.
> 
> Raghu Halharvi (2):
>    cxl/mbox: Remove redundant dev_err() after failed mem alloc
>    cxl/region: Remove else after return statement
> 
>   drivers/cxl/core/mbox.c   | 4 +---
>   drivers/cxl/core/region.c | 8 ++++----
>   2 files changed, 5 insertions(+), 7 deletions(-)
> 
