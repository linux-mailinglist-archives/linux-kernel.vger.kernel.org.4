Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6733F5F7689
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 11:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiJGJxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 05:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiJGJxQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 05:53:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AAFC4A485A;
        Fri,  7 Oct 2022 02:53:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16FC51063;
        Fri,  7 Oct 2022 02:53:20 -0700 (PDT)
Received: from [10.1.30.24] (FVFF763DQ05P.cambridge.arm.com [10.1.30.24])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 844B63F792;
        Fri,  7 Oct 2022 02:53:11 -0700 (PDT)
Message-ID: <3a78df5d-7d81-1b2f-1e77-fe667e49e488@arm.com>
Date:   Fri, 7 Oct 2022 10:53:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH v5 1/2] perf: arm_cspmu: Add support for ARM CoreSight PMU
 driver
To:     Besar Wicaksono <bwicaksono@nvidia.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "thanu.rangarajan@arm.com" <thanu.rangarajan@arm.com>,
        "Michael.Williams@arm.com" <Michael.Williams@arm.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vikram Sethi <vsethi@nvidia.com>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>
References: <20220928201830.45637-1-bwicaksono@nvidia.com>
 <20220928201830.45637-2-bwicaksono@nvidia.com>
 <f67bf3b6-c8ba-4134-5772-ce750f4bb4dd@arm.com>
 <SJ0PR12MB5676FE048F8105D01C83D0EBA0579@SJ0PR12MB5676.namprd12.prod.outlook.com>
 <SJ0PR12MB5676BCFE7E8AC56729C1D9D2A05C9@SJ0PR12MB5676.namprd12.prod.outlook.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <SJ0PR12MB5676BCFE7E8AC56729C1D9D2A05C9@SJ0PR12MB5676.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Besar

>> I was expecting the vendor specific impl to be aware and make its own
>> copy if it needs to make modifications to the array. But I can return a copy
>> to be on the safe side. We can revisit again if it is unnecessary.
>>
>> I will send the updated patch shortly.
> 
> Here is the link to the latest patch:
> https://lore.kernel.org/linux-arm-kernel/20220930023443.9463-2-bwicaksono@nvidia.com/

I have seen the patch, and happy with those changes and my tags. So, no
further actions is required. I assume Will can pick up the series after
the merge window.

Suzuki
