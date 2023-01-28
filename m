Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035DD67F5D1
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 08:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjA1H4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 02:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjA1Hz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 02:55:58 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F6F4108E
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 23:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674892557; x=1706428557;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QQ+oKMKIO3r/YGYgIlS7IpSJ6lLAzzTTT2x0LwrRzRU=;
  b=MUM64nzeTaFje4r2L/jw74Hy9wGYs/9HQHDYOii0HmEwUWwzl1CxLdQp
   TaO1xOIVIGwqZ1hggJoy0iMBq5+yACJOj/P2I7mv0KjQ8COSwXmbmIXUe
   CrBqc+f2+YNAYJSH6VvmIoOpR3O7q28y6hUdEudviiFKD6t83EqyP1Drb
   lViFVk71i+1Si/H119meUV6DB9aDUao+vGnKMt3hXJsCxcjS5IFGF967z
   tprjcqr///RRJqb765w9ikX0z4tcOYjZqxLVs1h+0D61+pAYVwakVGDrK
   4bAfIvsX2UDAXEoezuCQXLgQW4UX89tTLvC3aDLa2VG7veozafwGVbQYj
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="391826909"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="391826909"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 23:55:57 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="771856631"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="771856631"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.186.212]) ([10.252.186.212])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 23:55:54 -0800
Message-ID: <20e1ba45-adfe-b947-e871-76bc00ff972a@linux.intel.com>
Date:   Sat, 28 Jan 2023 15:55:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, hch@lst.de, jgg@nvidia.com
Subject: Re: [PATCH v2 1/8] iommu: Decouple iommu_present() from bus ops
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org
References: <cover.1674753627.git.robin.murphy@arm.com>
 <bf052fb0301eabe8c2831c6d53b9de2bbe000ac6.1674753627.git.robin.murphy@arm.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <bf052fb0301eabe8c2831c6d53b9de2bbe000ac6.1674753627.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/27 2:26, Robin Murphy wrote:
> Much as I'd like to remove iommu_present(), the final remaining users
> are proving stubbornly difficult to clean up, so kick that can down
> the road and just rework it to preserve the current behaviour without
> depending on bus ops.
> 
> Signed-off-by: Robin Murphy<robin.murphy@arm.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
