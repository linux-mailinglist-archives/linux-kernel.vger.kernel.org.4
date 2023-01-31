Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48016825EB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 08:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjAaHxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 02:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbjAaHxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 02:53:31 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60FFA28D04
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 23:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675151605; x=1706687605;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JG+wb8bqGbnOoAJrhM94NIsc3fCfzpe0Naap9WNrSdA=;
  b=a3PpqgyvMq9G17Ubn2KjixXgzmHYGX0lLxO+esRvDqvx3ujmW0hRjxSj
   w1COvtaCGr4N+gJICCOinKKehdDNvtn3lJBTI+7tZnCtlwieilk/FkaQm
   YrD9rtH+HRXXjkwassHQ73qIi0QqtvE9Jb0Sb9Q1/Lsob6I6vwkIazOU2
   44TrCbRMVEpYcxbJise+5vyAh0bwkWLSSLULC2h6aZDepEuUXY59XAdjY
   d7bD/r3D5kxMvJroPN74TrbyeH3hU1tHel/q23WYUZNDDBStaxCkTx/tb
   ei8Mqk2WrSQpf+7sqil/oQ8XTHsZAIcNUT8IKKmhwYgm7DHV73ClKTL0k
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="307434054"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="307434054"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 23:53:25 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="666392693"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="666392693"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.172.41]) ([10.249.172.41])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 23:53:23 -0800
Message-ID: <a9a4552e-a401-3ef3-1a29-f4b8f169afa0@linux.intel.com>
Date:   Tue, 31 Jan 2023 15:53:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Set No Execute Enable bit in PASID table
 entry
Content-Language: en-US
To:     iommu@lists.linux.dev
References: <20230126095438.354205-1-baolu.lu@linux.intel.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230126095438.354205-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/26 17:54, Lu Baolu wrote:
> Setup No Execute Enable bit (Bit 133) of a scalable mode PASID
> entry. It is required when XD bit of the first level page table
> entry is about to be set.
> 
> Fixes: ddf09b6d43ec ("iommu/vt-d: Setup pasid entries for iova over first level")
> Signed-off-by: Ashok Raj<ashok.raj@intel.com>
> Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>

Patch queued for v6.3.

https://lore.kernel.org/linux-iommu/20230131073740.378984-1-baolu.lu@linux.intel.com/

Best regards,
baolu
