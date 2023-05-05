Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D1B6F7ACC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 04:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjEECIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 22:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjEECIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 22:08:17 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5304E67
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 19:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683252496; x=1714788496;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mQQCDIZ9Afq+L3IFvslYxX++tsL66MbVRQZOEH3wFKE=;
  b=E4orQoeWmvogs89kRTF+QShrdRgqKikoOIEDMCT4eSeahvt+/q+ddr0f
   Z6zUdDoDkAkc3G7pj4fHGS44ZtRHc+WoTE3870OgI7HaJT3dS8ZiRghWh
   66WevbnvUDNXaRW8siI3Syyix6veQEq9jxgLBfEJ9ROwGJ4lan1hI1+6Q
   H72SxUczCchmXCpVGjJpxYTbG8+/KJQ7Cr1TT4wK8SGczyiFqFHrltcPT
   nnxJpnuPxZRQU7XInMGgH+E5ELraK4lKhvweL3GVLPFybOap4KTcSCeUH
   0wucg7qMMXsAclvCggkJLdYTVjJS2yEq0qVsDP032bLRxUH1Q2De17m4s
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="414637362"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="414637362"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2023 19:08:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10700"; a="762220576"
X-IronPort-AV: E=Sophos;i="5.99,250,1677571200"; 
   d="scan'208";a="762220576"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga008.fm.intel.com with ESMTP; 04 May 2023 19:08:13 -0700
Message-ID: <025d1e25-9f4a-a54b-ac99-b46f032169c0@linux.intel.com>
Date:   Fri, 5 May 2023 10:07:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     baolu.lu@linux.intel.com, will@kernel.org, schnelle@linux.ibm.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iommu: Add a capability for flush queue support
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        jgg@nvidia.com
References: <cover.1683233867.git.robin.murphy@arm.com>
 <f0086a93dbccb92622e1ace775846d81c1c4b174.1683233867.git.robin.murphy@arm.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <f0086a93dbccb92622e1ace775846d81c1c4b174.1683233867.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/23 5:10 AM, Robin Murphy wrote:
> Passing a special type to domain_alloc to indirectly query whether flush
> queues are a worthwhile optimisation with the given driver is a bit
> clunky, and looking increasingly anachronistic. Let's put that into an
> explicit capability instead.
> 
> Signed-off-by: Robin Murphy<robin.murphy@arm.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu
