Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8056D67F5E4
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 09:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjA1II4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 03:08:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbjA1IIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 03:08:51 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E40469521
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 00:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674893330; x=1706429330;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OkTqIttwZehfM8GUhzudD/mFz8N4/RQ7nv7RdzmULY0=;
  b=TE9mFZ5TWThs/BtBWmtCYq9NDeBhuQdtc72V9uV0zwJn0oXdKb/iLFgR
   iDbSqisRRV3IAjA1dxHV0zZaY9ZSS3iNFHdRDYVWvXXvbMXfz0WFZwRs0
   dVlXrjrUIWdHenpYifqyzDiQmbP2tuQRkADF/OXpMw2Ubn4ZKVWpml/bb
   28huNDFeXeEI6WVOBw27v1A8zUSNe8qGGweeSl6XufTmzwdcU/Bz0EBmu
   t1XZgWjp/QXPvBLHTtTLdcHs2XcT+t4O6r8GRwN/AIBhpWkbpGDBaT13Y
   58sr0dVrhcyp0lLC92U5QcAQ/HrFeyTGI52NuKDVozQiAXWfhXSbLVhGC
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="391828018"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="391828018"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 00:08:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="806086593"
X-IronPort-AV: E=Sophos;i="5.97,253,1669104000"; 
   d="scan'208";a="806086593"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.252.186.212]) ([10.252.186.212])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2023 00:08:45 -0800
Message-ID: <2c8c0d1d-56d2-4db7-ffb2-5a51eddfa13b@linux.intel.com>
Date:   Sat, 28 Jan 2023 16:08:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, hch@lst.de, jgg@nvidia.com
Subject: Re: [PATCH v2 3/8] iommu: Add lockdep annotations for group list
 iterators
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org
References: <cover.1674753627.git.robin.murphy@arm.com>
 <57cba0cf89556d586e554a9c64cbd28205d67c5c.1674753627.git.robin.murphy@arm.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <57cba0cf89556d586e554a9c64cbd28205d67c5c.1674753627.git.robin.murphy@arm.com>
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
> Before we add any more common helpers for iterating or otherwise
> accessing the group device list, let's start the good habit of
> annotating their locking expectations for robustness.
> 
> Signed-off-by: Robin Murphy<robin.murphy@arm.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
