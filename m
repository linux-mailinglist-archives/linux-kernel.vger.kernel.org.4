Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80837325B4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 05:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbjFPDMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 23:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbjFPDMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 23:12:34 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176CC211C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 20:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686885153; x=1718421153;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SIlRmpyQygKYv0i3uwyThwyRnkqCbhHybrnKDoUIcE8=;
  b=Zn/KopGRylMtqM9awFZIki/QrwJjED6LALjBjoRkoEHMynA++ZJs2Out
   9qGu3/jA0SdCIAw1L8YWfi7rrIYVhIRLpIKFFbkz0N5L7pgiMiyE4OB9o
   cILOi7qrygyZdexNW3VO8HISejAGPseyI7HX8VNoFr4q2Fa+xrHS/HPrO
   7RpuFEDmfO1JlzhKmu547p1E+uy24OC33i/HiYCASeGlaMqqjTo54EvId
   MUgqicMuysbQ8IgwcYfH1yrrwtzALHy/Hz4JGBJ/ThIrNhEOhJ+jEmvIl
   qP/cPYmitaW+s8WEmfPqPWrskb22lQ79zdf+z4GlkLTmt/a/TYbGAQUOB
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="359106657"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="359106657"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 20:12:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="663017410"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="663017410"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by orsmga003.jf.intel.com with ESMTP; 15 Jun 2023 20:12:30 -0700
Message-ID: <cf14aaa8-ed88-b1a9-1097-042b8d703a8e@linux.intel.com>
Date:   Fri, 16 Jun 2023 11:11:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/vt-d: Fix to flush cache of PASID directory table
Content-Language: en-US
To:     Yanfei Xu <yanfei.xu@intel.com>, dwmw2@infradead.org,
        joro@8bytes.org, will@kernel.org, robin.murphy@arm.com
References: <20230615071613.690639-1-yanfei.xu@intel.com>
 <3f60b35a-683c-5e18-c9d5-964df9331f0f@linux.intel.com>
 <5044217c-9380-f50a-2809-0e3dc80f7bd2@intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <5044217c-9380-f50a-2809-0e3dc80f7bd2@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/16/23 11:06 AM, Yanfei Xu wrote:
>>>
>>> Fixes: 194b3348bdbb ("iommu/vt-d: Fix PASID directory pointer 
>>> coherency")
>>
>> Do you need a Cc stable?
> 
> Yes, will add Cc: <stable@vger.kernel.org>

I was not asking you to Cc stable, just reminded you to consider whether
your change fixes any real problem and that problem could also happen
with stable kernels.

Best regards,
baolu
