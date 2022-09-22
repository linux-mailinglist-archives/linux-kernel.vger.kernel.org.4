Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1809F5E644E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:54:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbiIVNyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbiIVNyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:54:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F496EFA7C;
        Thu, 22 Sep 2022 06:54:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44DDBB836FF;
        Thu, 22 Sep 2022 13:54:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0455AC433C1;
        Thu, 22 Sep 2022 13:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663854857;
        bh=qjCgIG05FIbRmb5odbQu1R2eP7+xAOawGVW9WX9y/eY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rbU1dQGlJvMOAaJ9PAl/j2BwHeX5E0GNYdsz0QA8uXZycp8yoMQeoWq8Gnrbil2/X
         2P2qn2l/0BkLo7KBoZ1nWEj4RVqcx2BXcujkER/p6ByK3Wx5fz6iVgkM7uQzNFo/UB
         CLghROV8iMWgDHmwfvEPPbA0nIdVABLL64HxC9nYtnZmOA+mAqve8TMPTZJfHw2GFt
         ZE5Flj6Q882Iw8e9U26ThD/OwePQuxGXE4kHy7YnH7y0OY2r5wZXif/yGL4hsIj7Aa
         Snp647pNnh2niz+1F7LVdwFQKW+9WTWwbCi4xichBqTdmslHIosXnuL3QW6HdjG+0v
         0ir1vGoxqmKBg==
Date:   Thu, 22 Sep 2022 14:54:10 +0100
From:   Will Deacon <will@kernel.org>
To:     Besar Wicaksono <bwicaksono@nvidia.com>
Cc:     "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
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
Subject: Re: [PATCH v4 0/2] perf: ARM CoreSight PMU support
Message-ID: <20220922135409.GE12095@willie-the-truck>
References: <20220814182351.8861-1-bwicaksono@nvidia.com>
 <SJ0PR12MB5676C20F2083A73FBA973292A0709@SJ0PR12MB5676.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR12MB5676C20F2083A73FBA973292A0709@SJ0PR12MB5676.namprd12.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 05:24:05PM +0000, Besar Wicaksono wrote:
> Hi Reviewers,
> 
> Could we get some comments for this patchset ?
> Or an estimate when this could get your review is greatly appreciated.

I'd like Suzuki's ack before I merge this, although it mostly looks alright
to me from a quick look.

Will
