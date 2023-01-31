Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0793D6825E0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 08:51:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjAaHvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 02:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjAaHvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 02:51:36 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F3C65A3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 23:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675151495; x=1706687495;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kyUTQkrz9mWJxP+tOYE6CbK4sQ6wiEtAftpUXLRxRs0=;
  b=Xz47mGKZ4eqpa+sYMexQzOB4z4KlHIAaq2z2Hj9JRqLY3hrKqSnksG4n
   wfRg2m7Pjx+8mMcwWNOfoPEPiWaMDpg3COsljtPOpGa5YG03+lIB2sSTM
   YsAJdNm19DhDr5oQUMQLclDGBBCPGwkoxuWh/4NVlK0c+XZz8nOw0irqU
   DNOHGxKwmGAie0URqzKa+9PRPTNNPsrro+NSG2PqZJnL/wqO/L0aMCTvK
   J4DQgNUEJAwDHKwBssDl9UqAJdtwcWgCr6qhc+c3e/I3wCSNc2ramtHSZ
   JnZmoYxRbNkfYAKRhJy51XxZYQvCW0WdJtDHldeqy9vsnG37zhe8GaWvo
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="308120198"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="308120198"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 23:51:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="909813199"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="909813199"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.172.41]) ([10.249.172.41])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 23:51:32 -0800
Message-ID: <a766837f-2c24-68bc-d0c1-74e64f8aa97d@linux.intel.com>
Date:   Tue, 31 Jan 2023 15:51:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc:     baolu.lu@linux.intel.com, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] iommu/vt-d: SVM implementation cleanup
To:     iommu@lists.linux.dev
References: <20230109014955.147068-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <20230109014955.147068-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/9 9:49, Lu Baolu wrote:
> This is a cleanup series after the merge of commit be51b1d6bbff
> ("iommu/sva: Refactoring iommu_sva_bind/unbind_device()"). It removes
> the unused/duplicate data and code.
> 
> Lu Baolu (4):
>    iommu/vt-d: Remove include/linux/intel-svm.h
>    iommu/vt-d: Remove unused fields in svm structures
>    iommu/vt-d: Remove users from intel_svm_dev
>    iommu/vt-d: Remove sva from intel_svm_dev

Patches queued for v6.3.

https://lore.kernel.org/linux-iommu/20230131073740.378984-1-baolu.lu@linux.intel.com/

Best regards,
baolu
