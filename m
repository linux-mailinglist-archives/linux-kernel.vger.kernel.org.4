Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701B07169BB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232385AbjE3Qff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjE3Qfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:35:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4E3E1BB
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 09:35:12 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6048716F2;
        Tue, 30 May 2023 09:35:31 -0700 (PDT)
Received: from [10.1.34.168] (e126864.cambridge.arm.com [10.1.34.168])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D83E93F663;
        Tue, 30 May 2023 09:34:42 -0700 (PDT)
Message-ID: <b38910d2-a675-88d9-985c-adf527c08045@arm.com>
Date:   Tue, 30 May 2023 17:34:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 06/11] KVM: arm64: hide MOPS from guests
Content-Language: en-US
To:     Colton Lewis <coltonlewis@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Luis Machado <luis.machado@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-kernel@vger.kernel.org
References: <gsntcz2ob4c6.fsf@coltonlewis-kvm.c.googlers.com>
From:   Kristina Martsenko <kristina.martsenko@arm.com>
In-Reply-To: <gsntcz2ob4c6.fsf@coltonlewis-kvm.c.googlers.com>
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

On 25/05/2023 20:26, Colton Lewis wrote:
>> As FEAT_MOPS is not supported in guests yet, hide it from the ID
>> registers for guests.
> 
>> The MOPS instructions are UNDEFINED in guests as HCRX_EL2.MSCEn is not
>> set in HCRX_GUEST_FLAGS, and will take an exception to EL1 if executed.
> 
> For my benefit, could you please explain why no support for guests yet?
> Why not set HCRX_EL2.MSCEn in this series?

There's probably a few more things that need doing for guest support, such as 
setting the HCRX_EL2.MCE2 bit and handling the mops exception in KVM. I'm
currently having a look at guest support.

Thanks,
Kristina
