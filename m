Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 693A769FB11
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 19:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjBVSgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 13:36:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjBVSgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 13:36:49 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5602F3E630
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 10:36:48 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB853FEC;
        Wed, 22 Feb 2023 10:37:30 -0800 (PST)
Received: from [10.57.15.137] (unknown [10.57.15.137])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC2C33F587;
        Wed, 22 Feb 2023 10:36:44 -0800 (PST)
Message-ID: <d61573bb-07be-5abe-4ca5-8649ac79e430@arm.com>
Date:   Wed, 22 Feb 2023 18:36:19 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 03/10] KVM: arm64: switch HCRX_EL2 between host and guest
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-kernel@vger.kernel.org
References: <20230216160012.272345-1-kristina.martsenko@arm.com>
 <20230216160012.272345-4-kristina.martsenko@arm.com>
 <Y+5Xy/Hqu4FKLTUE@sirena.org.uk>
From:   Kristina Martsenko <kristina.martsenko@arm.com>
In-Reply-To: <Y+5Xy/Hqu4FKLTUE@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2023 16:20, Mark Brown wrote:
> On Thu, Feb 16, 2023 at 04:00:05PM +0000, Kristina Martsenko wrote:
> 
>> After this change, SMPME is no longer set for guests, which should have
>> no effect as SME is currently disabled for guests.
> 
> SMPME is mainly set for the benefit of any future guests, it is
> used to turn off SME priorities for guests.  While it's true that
> we don't have any guests support yet it's there as safety to
> ensure we don't forget to enable it later on or something
> otherwise goes wrong.  We don't need priority mapping on the host
> since we don't have any priority mapping support at all, and it's
> difficult to see a reason why we would want to remap our own
> priorities in the host.

That makes sense. I'll fix this in v2 so that priority mapping is enabled for
guests and disabled for the host.

Thanks,
Kristina
