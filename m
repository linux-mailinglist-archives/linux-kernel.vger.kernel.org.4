Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C946668F890
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 21:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjBHUGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 15:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjBHUGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 15:06:49 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93BEF44A5;
        Wed,  8 Feb 2023 12:06:47 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C0D471477;
        Wed,  8 Feb 2023 12:07:29 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.30.155])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 397CB3F703;
        Wed,  8 Feb 2023 12:06:45 -0800 (PST)
Date:   Wed, 8 Feb 2023 20:06:42 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Will Deacon <will@kernel.org>, kernel test robot <lkp@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH V8 5/6] arm64/perf: Add branch stack support in ARMV8 PMU
Message-ID: <Y+QA0tRk2VVJ4gwu@FVFF77S0Q05N.cambridge.arm.com>
References: <20230123125956.1350336-6-anshuman.khandual@arm.com>
 <202301310047.b5iv9hM8-lkp@intel.com>
 <20230203113153.GA5927@willie-the-truck>
 <143549b7-6f16-209f-b1be-c8202fd55d05@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <143549b7-6f16-209f-b1be-c8202fd55d05@arm.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 09:46:25AM +0530, Anshuman Khandual wrote:
> On 2/3/23 17:01, Will Deacon wrote:
> > On Tue, Jan 31, 2023 at 12:28:17AM +0800, kernel test robot wrote:

[...]

> > This looks like it should be fixed. I'd also like to see Mark's ack on the
> 
> This build warning is triggered when CONFIG_PERF_EVENTS is not enabled, when
> all the fallback stubs in there try to use has_branch_stack() which does not
> get defined. The following change, fixes the problem.

I expect that you'll post a v9 with that folded in, and I've just made some
comments on v7 which I expect will require some changes, so I'm going to wait
for v9 for further review to keep this manageable.

Thanks,
Mark.
