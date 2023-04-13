Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831BF6E05D6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 06:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjDMERa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 00:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjDMEQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 00:16:27 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAA09774
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 21:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681359207; x=1712895207;
  h=message-id:date:mime-version:cc:subject:from:to:
   references:in-reply-to:content-transfer-encoding;
  bh=Qx1roPB9NVHKquwWhlDSEPgRlas4fd/F7m3pwsubR+4=;
  b=Jlu2e5yRI9DmgAhKQ0K7GhhybiS15W1oXcvPsviz/Chs3ab+sDgJKLS3
   B+6/5cvaRVJ1Z1njuhsZ35yQ60Afy2OQ8GVfvvd9BuQIBrvUSfdt7a441
   6u08ljjE9wD8jQT9Z//o//QP9w9O6R8vemPQdpIvm6uOE+4D2wLSMzUH/
   U1h9UqEjUD1BVq/yRSiW/5bjlTXESGFjwTrGses/8AhzJxnRkRHbbU9oS
   eTzv9og+vnnYIMNg+ayQyyihKeCM1Z22V3X+Wz93mZT3gIUSLt7pwiWW0
   tnh101j8CWcg2lojI7eAKK9Nvj7xuUbfRwt+ddCtm7yEf3p6IJ25M85zq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="345872340"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="345872340"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 21:12:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="753808034"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="753808034"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by fmsmga008.fm.intel.com with ESMTP; 12 Apr 2023 21:12:15 -0700
Message-ID: <aab4ab9b-1e5b-6ad8-385e-46f0240a23cf@linux.intel.com>
Date:   Thu, 13 Apr 2023 12:12:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Cc:     Vinod Koul <vkoul@kernel.org>, Tina Zhang <tina.zhang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/17] [PULL REQUEST] Intel IOMMU updates for Linux v6.4
Content-Language: en-US
From:   Baolu Lu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
References: <20230411064815.31456-1-baolu.lu@linux.intel.com>
In-Reply-To: <20230411064815.31456-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/23 2:47 PM, Lu Baolu wrote:
> Hi Joerg,
> 
> This includes patches queued for v6.4. They are:
> 
>   - Allow the VT-d driver to support non-PRI IOPF
>   - Remove PASID supervisor request support
>   - Various small and misc cleanups
> 
> This series also includes an idxd patch to avoid driver regression after
> changes in the IOMMU driver. It has been reviewed by the driver's
> maintainers. Please feel free to let me know if it's inappropriate to
> route it through the iommu tree.
> 
> The whole series is based on v6.3-rc6 and also available at:
> https://github.com/LuBaolu/intel-iommu/commits/vtd-update-for-v6.4
> 
> Please pull them for x86/vt-d branch.

Hi Joerg,

I just sent a v2 for this pull request. I addressed David's comments
there.

https://lore.kernel.org/linux-iommu/20230413040645.46157-1-baolu.lu@linux.intel.com/

Best regards,
baolu
