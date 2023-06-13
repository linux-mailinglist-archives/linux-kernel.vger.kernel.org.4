Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDAD72D8ED
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 07:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239896AbjFMFD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 01:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjFMFDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 01:03:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A53368E
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 22:03:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 351521FB;
        Mon, 12 Jun 2023 22:04:35 -0700 (PDT)
Received: from [10.162.42.9] (unknown [10.162.42.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41E823F587;
        Mon, 12 Jun 2023 22:03:47 -0700 (PDT)
Message-ID: <77d4d867-cfa1-bdef-dddd-0f28493a4e6e@arm.com>
Date:   Tue, 13 Jun 2023 10:33:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V3] arm64: Disable EL2 traps for BRBE instructions
 executed in EL1
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20230516083015.569248-1-anshuman.khandual@arm.com>
 <20230605140038.GB21212@willie-the-truck>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20230605140038.GB21212@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/5/23 19:30, Will Deacon wrote:
> On Tue, May 16, 2023 at 02:00:15PM +0530, Anshuman Khandual wrote:
>> This disables EL2 traps for BRBE instructions executed in EL1. This would
>> enable BRBE to be configured and used successfully in the guest kernel.
>> While here, this updates Documentation/arm64/booting.rst as well.
> 
> Is it safe to give the guest access to BRBE if the hypervisor doesn't
> switch the state? I'm assuming the architecture defaults to "trap" for a
> reason and disabling the trap alone isn't sufficient.

Hmm, understood.

> 
> If it _is_ safe, please can you explain that in the commit message? If not,
> then this should be at the end of the series adding hypervisor support.

Sure, will add the patch when adding hypervisor support for BRBE.
