Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CDF63EFF3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 12:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiLALxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 06:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiLALxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 06:53:14 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB46155AA0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 03:53:12 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EBF1D6E;
        Thu,  1 Dec 2022 03:53:19 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DC77B3F73D;
        Thu,  1 Dec 2022 03:53:10 -0800 (PST)
Date:   Thu, 1 Dec 2022 11:53:08 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Walbran <qwandor@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 02/12] firmware: arm_ffa: Move comment before the field
 it is documenting
Message-ID: <20221201115308.gciyfttnhvz2wcuz@bogus>
References: <20221116170335.2341003-1-qperret@google.com>
 <20221116170335.2341003-3-qperret@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116170335.2341003-3-qperret@google.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

On Wed, Nov 16, 2022 at 05:03:25PM +0000, Quentin Perret wrote:
> From: Will Deacon <will@kernel.org>
> 
> This is consistent with the other comments in the struct.
>
Not sure how that happened :). Anyways,

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

I am yet to look at the other patches and I would like to have a setup
to test it as well. So I will look at the other patches and test it later.
The reason for reviewing the first 2 patches moving the code out of the
driver is to check if they can be merged for v6.2 itself.

I may start pushing FF-A v1.1 changes for v6.3 and trying to avoid conflicts
or cross tree dependencies. I know it is quite late for v6.2 but these changes
are trivial and good to get it in for v6.2 if possible.

Will, thoughts ? If you agree, please take it via arm64 for v6.2. I don't
have any FF-A changes for v6.2 ATM, so there should be not conflicts.

--
Regards,
Sudeep
