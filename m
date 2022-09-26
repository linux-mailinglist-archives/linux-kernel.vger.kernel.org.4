Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377C55EA943
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235440AbiIZO4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235290AbiIZOzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:55:14 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41FB1054A
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 06:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664198689; x=1695734689;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6vZEOvuaX3fYuRgprKfAm1QGIqBUF0nPgMzjL0S6HQk=;
  b=fClDEblcMRu94F0zskdJc9kMo5E06t3/xqKQzrYjwH335aQBahxP3HWo
   KHb+Vo8cf1MSfmhRrQ+AiwrBkIw2rEye2SWS2MYczUW8RVzb3QeTwtv59
   DBwrLs0LgHjDfp/kAC3KzEctM+Dm5CoShTTDZyBc8862FL0/ERV4TuxOS
   lF4TKdfK/1aMeRPYwQ84WzMXvYd/960GJtHNuhq84VqjHryNTT2rncfIN
   VFUCV+GBdF2QkgZTr3HKW0m3B3RrkbfBCD+CyVQzkh7ykQyBXsEo2iXDO
   uvQdyNl+fvw2A8Ws0op1YGZujo5kOmJIj1I8cDREj4UbeP3wprbB6l7oK
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="301007413"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="301007413"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 06:24:48 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10482"; a="654258495"
X-IronPort-AV: E=Sophos;i="5.93,346,1654585200"; 
   d="scan'208";a="654258495"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.209.229]) ([10.254.209.229])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 06:24:46 -0700
Message-ID: <7d98e18b-a310-d54f-f0b5-0c8a013c0b8b@linux.intel.com>
Date:   Mon, 26 Sep 2022 21:24:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] [PULL REQUEST] Intel IOMMU updates for Linux v6.1
Content-Language: en-US
To:     Joerg Roedel <joro@8bytes.org>
References: <20220923004206.3630441-1-baolu.lu@linux.intel.com>
 <YzGX7ri+CYTpKfeP@8bytes.org>
 <64405aee-0701-5b1f-084a-f0750372a563@linux.intel.com>
 <YzGik3y4J0Fkc9fd@8bytes.org>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <YzGik3y4J0Fkc9fd@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/26 21:01, Joerg Roedel wrote:
> On Mon, Sep 26, 2022 at 08:38:09PM +0800, Baolu Lu wrote:
>> Do you prefer applying de9f8a91eb32 to vt-d branch, or let me send a new
>> v6.0-rc7 based pull request?
> Yes, please send a v6.0-rc7 pull-request. I'd like to carry the conflict
> resolution in the merge commit for next.

Sure. A new pull request has been posted:

https://lore.kernel.org/linux-iommu/20220926131529.4045281-1-baolu.lu@linux.intel.com/

Best regards,
baolu
