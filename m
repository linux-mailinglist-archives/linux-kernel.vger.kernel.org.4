Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA6763F61F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 18:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbiLAR0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 12:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiLAR0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 12:26:15 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546FA27170
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 09:26:13 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id t17so2468158pjo.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 09:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=02CF0TJYI4L7g3srrazD4xH+/OuBD9klT/4Hk2gtU0U=;
        b=txApKc3gtDcQMm+FVBYm+D0Mo1n4TL0Vapxd3lQf0wekHKp4QFL/juRdq0ivkrC709
         rVw0C5ACxYCPAbySn7V5JKA+NV3okQWkwPGbENM2SJwgdMTeyObxCCwgwUOOx0BC7oWz
         +h7qGkFumy1Mw737V/jWWIQ0z6+NFFhlD5owjCq/feMugXvEoCHJax5uCjFKdA88ptVQ
         C2bNboHdjpx/p+BBKcMcghLfjGguL5CJ+usVgzk6pHX7s0eXXjYbXywS0/ciUiAkhj6B
         w4jY4IdmFe2vSaYLG2oj5UHN9K1ZzirLTvOs3K1gjqpLYDePd8bzLoi1/rndXhowE6SL
         zdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=02CF0TJYI4L7g3srrazD4xH+/OuBD9klT/4Hk2gtU0U=;
        b=3DjTelRXUK6J7G8BdLYy2kuY++gH9i8BvGALW9MKwhMyZhWnJBQn13Vc1lBwdVqi2+
         qEGHAH16db5u4TDz2BA4sWzsw55q7EkB1+ZO+SlaF4Mp08heo6X8UgTieel+ymOZ18Hl
         T2M1+P8NDr26ZSZylHh7pZigxDvibsWvv7yGbG88Kalgs0/AamscPdqAyiM0SMaY9dbs
         lfEHnluny8h2+iuDPv3Dr2eh6MuuqThSHiCF8MQ2z1qp40LBc967o5clXthRJLFQfpGP
         cVWVbQmQmMgyNZggwhb6bf9iXqiRh/DSJhsx1ihZ0DVu9wTbjYkAQkWg2QiGzPEEUEgQ
         gDLA==
X-Gm-Message-State: ANoB5pmPYGZu3+afUI1F2ZtPIh8BHh6zux6JLO/r+3/U9gl8wZElQQJY
        8RBChyJqeBCODezoc6e24QjUFA==
X-Google-Smtp-Source: AA0mqf4SMFdu/n4a1aFlo3szQD2bjOfheoqlSHE9xuODUTMXDUAclzarx3ixXW8iNFKhgeVWojv9Lg==
X-Received: by 2002:a17:902:d650:b0:189:f86:ecb with SMTP id y16-20020a170902d65000b001890f860ecbmr58839022plh.45.1669915572825;
        Thu, 01 Dec 2022 09:26:12 -0800 (PST)
Received: from ?IPV6:2400:4050:c360:8200:8ae8:3c4:c0da:7419? ([2400:4050:c360:8200:8ae8:3c4:c0da:7419])
        by smtp.gmail.com with ESMTPSA id n11-20020a170902e54b00b00178aaf6247bsm3965798plf.21.2022.12.01.09.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 09:26:12 -0800 (PST)
Message-ID: <50499ee9-33fe-4f5d-9d0a-76ceef038333@daynix.com>
Date:   Fri, 2 Dec 2022 02:26:08 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 0/3] KVM: arm64: Handle CCSIDR associativity mismatches
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>
References: <20221201104914.28944-1-akihiko.odaki@daynix.com>
 <867czbmlh1.wl-maz@kernel.org>
Content-Language: en-US
From:   Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <867czbmlh1.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/01 20:06, Marc Zyngier wrote:
> On Thu, 01 Dec 2022 10:49:11 +0000,
> Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> 
> Thanks for looking into this.
> 
>> M2 MacBook Air has mismatched CCSIDR associativity bits, which makes the
>> bits a KVM vCPU sees inconsistent when migrating.
> 
> Can you describe the actual discrepancy? Is that an issue between the
> two core types? In which case, nothing says that these two cluster
> should have the same cache topology.

Yes, the processor has big.LITTLE configuration.

On the processor, the valid CSSELR values are 0 (L1D), 1 (L1I), 3 (L2D). 
For each CSSELR values, each cluster has:
- 0x700FE03A, 0x203FE01A, 0x70FFE07B
- 0x701FE03A, 0x203FE02A, 0x73FFE07B

> 
>> It also makes QEMU fail restoring the vCPU registers because QEMU saves
>> and restores all of the registers including CCSIDRs, and if the vCPU
>> migrated among physical CPUs between saving and restoring, it tries to
>> restore CCSIDR values that mismatch with the current physical CPU, which
>> causes EFAULT.
> 
> Well, QEMU will have plenty of other problems, starting with MIDRs,
> which always reflect the physical one. In general, KVM isn't well
> geared for VMs spanning multiple CPU types. It is improving, but there
> is a long way to go.

On M2 MacBook Air, I have seen no other difference in standard ID 
registers and CCSIDRs are exceptions. Perhaps Apple designed this way so 
that macOS's Hypervisor can freely migrate vCPU, but I can't assure that 
without more analysis. This is still enough to migrate vCPU running 
Linux at least.

> 
>> Trap CCSIDRs if there are CCSIDR value msimatches, and override the
>> associativity bits when handling the trap.
> 
> TBH, I'd rather we stop reporting this stuff altogether.
> 
> There is nothing a correctly written arm64 guest should do with any of
> this (this is only useful for set/way CMOs, which non-secure SW should
> never issue). It would be a lot better to expose a virtual topology
> (one set, one way, one level). It would also save us from the CCSIDRX
> silliness.
> 
> The only complexity would be to still accept different topologies from
> userspace so that we can restore a VM saved before this virtual
> topology.

Another (minor) concern is that trapping relevant registers may cost too 
much. Currently KVM traps CSSELR and CCSIDR accesses with HCR_TID2, but 
HCR_TID2 also affects CTR_EL0. Although I'm not sure if the register is 
referred frequently, Arm introduced FEAT_EVT to trap CSSELR and CSSIDR 
but not CTR_EL0 so there may be some case where trapping CTR_EL0 is not 
tolerated. Perhaps Arm worried that a userspace application may read 
CTR_EL0 frequently.

If you think the concern on VM restoration you mentioned and the 
trapping overhead is tolerable, I'll write a new, much smaller patch 
accordingly.

Regards,
Akihiko Odaki

> 
> Do you mind having a look at this?
> 
> Thanks,
> 
> 	M.
> 
