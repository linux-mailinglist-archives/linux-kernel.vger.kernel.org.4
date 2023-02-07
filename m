Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7845868CD74
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 04:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjBGDcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 22:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjBGDcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 22:32:00 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554A8977A;
        Mon,  6 Feb 2023 19:31:59 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id BDC1F5C00E1;
        Mon,  6 Feb 2023 22:31:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 06 Feb 2023 22:31:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1675740718; x=
        1675827118; bh=YZgLRUSiyOAejTTanFPROC5JmkrhAOFOeQDpMqNffU4=; b=i
        p8JFwYWjbAOkoBTgWGvYCSPqT6xnWDKDnGl4XMU2JAQPmqb1dETjpnE8GUk53pN3
        lGI8ZgNhRXOf2w9QrXpyoIqt9cCA5ThthpM8XE8/cKWe3TC7A+i4iqFdDjzqJ0G5
        kNNKk97hoQlFUb64Ntq0fNTrj2Csc60TVAjsVe5qIm7JiN6nEViK9GyS8aHh4jl5
        56M3dBoCALuIP6XqKiZJ8qqT7lAgrFRRclOeNKbNQjd7PpXm4Hd5McPqL7UfNRnM
        CmhaQZDCmpKitht4OyZkKznv8fW0VnyvTzz27NRbOBOC3pnHTz0bWy3jUKG0sB23
        RAvk4KEwNaYNxcDqgxT1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1675740718; x=
        1675827118; bh=YZgLRUSiyOAejTTanFPROC5JmkrhAOFOeQDpMqNffU4=; b=k
        SzdjIh8gZhtDaHZ92zaTxdcmoQIRaghPhAbQgbuT5zVxEHtyG53wTEktOgSjITJo
        jVLNzgKCz+uZcqclg3BeumhSZ9eRW8lBLzf4rEvXXaIGrKyXRRpSO8r1q+V65Ybe
        6s14A4T8HpqlJ8CAaCH7HAtERgjZt8bTYxU24N8HUU9ImqyYOomWoKtTl8vGh4bX
        doSbK/v5IuNdqPfTVx+hZDi7gnFmhS/EGDPdWAXz/ABIgGL3rc5LBH9JcDTYuQIT
        bIX5gOBj4uwojFruiLbazGHK9GfKkXA90CfvgakZsiraMLxXDyzWuk4+bfYr1E3c
        sDc+SIwna5QR7+7uKGVsQ==
X-ME-Sender: <xms:LcbhY-_4_ci_Wox3WeINMVK_fIbrpDXPpJB6mkSGmawOF4FtPQUBBg>
    <xme:LcbhY-vTE8j6wJTLN79_S-6YNpo0B55-ffIab1qXWa5IDhr4X1xAVOdrscBp3XJEO
    6R840UoKckJnNMbfQ>
X-ME-Received: <xmr:LcbhY0C12h4eSjxV_Wm-3U2tcOPtO6gisSHRVvgUcMAMDqunvOEUzHxbpVH-cME0kZ-8JdHhV93nbF2eT5Xet11A7HajkqUg2Qf3w6apGwWhUhUG5Hnw7vTIEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudegjedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfvfevfhfhufgjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeehtedtfeegueduledvffeljeehjeeuleduudeivdekffegteeu
    vedvledvteefjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhl
    rghnugdrohhrgh
X-ME-Proxy: <xmx:LcbhY2cY2n2eEqSi67ml7E0TtNZI2u40qR6JrRwvDk4x_jPPZy6vAA>
    <xmx:LcbhYzOyAJVWKKKqvx4lWRhIN1yZ4D5wH94FCOs58SlhBKaN-wPlIQ>
    <xmx:LcbhYwlOUBPC91CnkJhC-kuwUhBcsbl9uLBfXzC8_Iu45XqxIe5xTA>
    <xmx:LsbhYxu7uIAKiJhH6xfKRs58t8mQM6ixp2qHxmiTr_1D_b1_EUMPdQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Feb 2023 22:31:55 -0500 (EST)
Message-ID: <e38d29f5-cd3c-4a2b-b355-2bcfad00a24b@sholland.org>
Date:   Mon, 6 Feb 2023 21:32:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        YueHaibing <yuehaibing@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tangmeng <tangmeng@uniontech.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Lee Jones <lee@kernel.org>
References: <20230101181715.42199-1-samuel@sholland.org>
 <0a180849-ba1b-2a82-ab06-ed1b8155d5ca@collabora.com>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 0/2] firmware/psci: Switch to the sys-off handler API
In-Reply-To: <0a180849-ba1b-2a82-ab06-ed1b8155d5ca@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/23 06:53, Dmitry Osipenko wrote:
> On 1/1/23 21:17, Samuel Holland wrote:
>> I want to convert the axp20x PMIC poweroff handler to use the sys-off
>> API, so it can be used as a fallback for the SBI poweroff handler on
>> RISC-V. But the PSCI poweroff handler still uses pm_power_off, so done
>> alone, this conversion would cause the axp20x callback to be called
>> first, before the PSCI poweroff handler.
>>
>> In order to prevent this change in behavior, the PSCI poweroff handler
>> needs to be converted to the sys-off API first, at a higher priority.
>>
>> This series performs the conversion, after accounting for the fact that
>> the PSCI poweroff handler is registered quite early during boot.
>>
>> The first patch is a dependency for both this series and the SBI
>> series[1], so I would like to get at least patch 1 merged soon.
>>
>> [1]: https://lore.kernel.org/lkml/20221228161915.13194-1-samuel@sholland.org/
>>
>> Changes in v2:
>>  - Update commit messages
>>
>> Samuel Holland (2):
>>   kernel/reboot: Use the static sys-off handler for any priority
>>   firmware/psci: Switch to the sys-off handler API
>>
>>  drivers/firmware/psci/psci.c |  9 ++++++---
>>  kernel/reboot.c              | 10 ++++------
>>  2 files changed, 10 insertions(+), 9 deletions(-)
>>
> 
> Hello Rafael,
> 
> Do you think you will be able to pick up this series for 6.3? I'm going
> to continue removing the pm_power_off from kernel, the new power-off API
> feels stable now to me. I think the Samuel's improvement for the early
> boot memory allocation will be good to have to avoid similar problem for
> other drivers.
> 
> Ideally, the PSCI patch should get an ack, though the code change is
> about the PM stuff, so perhaps will be fine to take it via PM tree if FW
> maintainers will show no interest in the nearest time.

Additionally, a patch which depends on this[1] series has already been
merged[2], so if this series does not make 6.3, that change would need
to be reverted.

Regards,
Samuel

[1]:
https://lore.kernel.org/lkml/20221228162752.14204-1-samuel@sholland.org/
[2]: https://git.kernel.org/next/linux-next/c/a4755a1374ba

