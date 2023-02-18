Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2CF69BDED
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 00:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjBRXUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 18:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBRXUf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 18:20:35 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A646126D6
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 15:20:34 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id BA9ED5C00E5;
        Sat, 18 Feb 2023 18:20:31 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 18 Feb 2023 18:20:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1676762431; x=
        1676848831; bh=tjtgdd+H5NnT69NzUOb8A7efXFAPqfaIKfbXt/lcGPE=; b=Y
        Rrod/xhp4OoYLBbuCCFWk3t3IOargZWAZ/ij0HLCSgPjKOkmQTxI+pfCKYyurQhN
        O6VN+jSwAq+UL1tij5OiXeW+kwFMblWXheuw0b3Ma3PoLLfaeN9YOEVilXUrAnfJ
        1PpUtNgWTg3H20MmRfe7WDTPhQhpTVMH1ERF3dBVvrG6IQNl8dD41wC83Jtn/AgC
        8K8LJRQjkktyyjShYQnqIlT/l7ZFyyvZCT/7lC/OCjhZHdnptUCcIAOHYLTFX2aB
        vKNpV4RjsJil86b/weY/pUUaanL8O9UqZ/eSP9Z89V1px88mSJFnY3QuT6+9Gutz
        nql4euIA0AW/U58c3qBsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1676762431; x=
        1676848831; bh=tjtgdd+H5NnT69NzUOb8A7efXFAPqfaIKfbXt/lcGPE=; b=V
        uPX8jLqqAiJqFf2BrTrx3H1dQNmFG1a4CIiqBsHp1AFoWib/ik5Od8dVYoAP4ri8
        lPsTQDT6BxraxwWLa00mHdIxLwp91ScKjOI37PAR03tZI6p3naPfckjw2Y4HKvHq
        gTROygTxdgxk5Vp80ARl+99xlO/FxHXCR3ntw5CnRX4rKslyg9uV0ieJcUgWMYeD
        mb8uIPSrMp62tKtSUZC+6AEC6H9+Preqnasiy4SpF+bV9lmEAnrnSAx1I5O80awS
        oxTk+9z1UDnn3lWKuIQWlNUZMJa3cqBYrqfhWYkUkKgBgmZmJDdC5wRn2Ql/V9L3
        8+tF1OiLP36TjzjixDmHA==
X-ME-Sender: <xms:Pl3xY-9itOHN6oZiK113Wf1jGEIU222-TOnSCpjAE4dBrB-gSxAioA>
    <xme:Pl3xY-v1-uikDKQWyKTZJ8rmH9UwAQlr4Aqr4TqlUNRmVisr31zRMqTuiH6ddEDhb
    iVwKUCLq-YFPaCy-A>
X-ME-Received: <xmr:Pl3xY0Av0CFDwPx485PrvEJclTWkAYlFOiyBmLUmpfkuf7-aOgWRO1EN3wBetAhgfdMdTHCVFJBWuFjz2vBIWE4PVW3TwFNaO836urvZ25hbVG_4I1QBgUwFPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejvddgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfvfevfhfhufgjtgfgsehtkeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeeikefgheduvdfhheelkedvffelueehgeejtdeuieduieejhedv
    vddtfeevleeihfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhl
    rghnugdrohhrgh
X-ME-Proxy: <xmx:Pl3xY2cK-8Nky_EsS8dIInZ8tIUE_bqp-fsy_eUa19FKNW0UxmvRZA>
    <xmx:Pl3xYzO8cyJ5VLJSe4GcIRoe6G3DP9t42MvjMWtqTAKmMxnviSVmag>
    <xmx:Pl3xYwmQR-C_HMa12UxSRSI8FgzstEne8viOfsC3wT8nb3RwcysH4A>
    <xmx:P13xY8tyxLq8alLpvpHX7WkYsTPUyF9yipiOPj_m1JA5Y2UGThyPpA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Feb 2023 18:20:29 -0500 (EST)
Message-ID: <8bba0d3c-bf10-97df-80a5-ad98d5a417c8@sholland.org>
Date:   Sat, 18 Feb 2023 17:20:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Palmer Dabbelt <palmer@dabbelt.com>, rafael.j.wysocki@intel.com
Cc:     dmitry.osipenko@collabora.com, aou@eecs.berkeley.edu,
        apatel@ventanamicro.com, Atish Patra <atishp@rivosinc.com>,
        geert@linux-m68k.org, heiko@sntech.de, kai.heng.feng@canonical.com,
        mcgrof@kernel.org, paulmck@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>, pmladek@suse.com,
        yuehaibing@huawei.com, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, tangmeng@uniontech.com
References: <mhng-fbf5d10c-239d-4e47-bf52-3e1255cbe5e0@palmer-ri-x1c9>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH 1/3] kernel/reboot: Use the static sys-off handler for any
 priority
In-Reply-To: <mhng-fbf5d10c-239d-4e47-bf52-3e1255cbe5e0@palmer-ri-x1c9>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/23 18:17, Palmer Dabbelt wrote:
> On Wed, 28 Dec 2022 08:19:13 PST (-0800), samuel@sholland.org wrote:
>> commit 587b9bfe0668 ("kernel/reboot: Use static handler for
>> register_platform_power_off()") addded a statically-allocated handler
>> so register_sys_off_handler() could be called before the slab allocator
>> is available.
>>
>> That behavior was limited to the SYS_OFF_PRIO_PLATFORM priority.
>> However, it is also required for handlers such as PSCI on ARM and SBI on
>> RISC-V, which should be registered at SYS_OFF_PRIO_FIRMWARE. Currently,
>> this call stack crashes:
>>
>>   start_kernel()
>>     setup_arch()
>>       psci_dt_init()
>>         psci_0_2_init()
>>           register_sys_off_handler()
>>             kmem_cache_alloc()
>>
>> Generalize the code to use the statically-allocated handler for the
>> first registration, regardless of priority. Check .sys_off_cb for
>> conflicts instead of .cb_data; some callbacks (e.g. firmware drivers)
>> do not need any per-instance data, so .cb_data could be NULL.
>>
>> Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>
>>  kernel/reboot.c | 10 ++++------
>>  1 file changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/kernel/reboot.c b/kernel/reboot.c
>> index 3bba88c7ffc6..38c18d4f0a36 100644
>> --- a/kernel/reboot.c
>> +++ b/kernel/reboot.c
>> @@ -327,7 +327,7 @@ static int sys_off_notify(struct notifier_block *nb,
>>      return handler->sys_off_cb(&data);
>>  }
>>
>> -static struct sys_off_handler platform_sys_off_handler;
>> +static struct sys_off_handler early_sys_off_handler;
>>
>>  static struct sys_off_handler *alloc_sys_off_handler(int priority)
>>  {
>> @@ -338,10 +338,8 @@ static struct sys_off_handler
>> *alloc_sys_off_handler(int priority)
>>       * Platforms like m68k can't allocate sys_off handler dynamically
>>       * at the early boot time because memory allocator isn't
>> available yet.
>>       */
>> -    if (priority == SYS_OFF_PRIO_PLATFORM) {
>> -        handler = &platform_sys_off_handler;
>> -        if (handler->cb_data)
>> -            return ERR_PTR(-EBUSY);
>> +    if (!early_sys_off_handler.sys_off_cb) {
>> +        handler = &early_sys_off_handler;
>>      } else {
>>          if (system_state > SYSTEM_RUNNING)
>>              flags = GFP_ATOMIC;
>> @@ -358,7 +356,7 @@ static struct sys_off_handler
>> *alloc_sys_off_handler(int priority)
>>
>>  static void free_sys_off_handler(struct sys_off_handler *handler)
>>  {
>> -    if (handler == &platform_sys_off_handler)
>> +    if (handler == &early_sys_off_handler)
>>          memset(handler, 0, sizeof(*handler));
>>      else
>>          kfree(handler);
> 
> Sorry for being slow here, I'd been assuming someone would Ack this but
> it looks like maybe there's nobody in the maintainers file for
> kernel/reboot.c?  I'm fine taking this via the RISC-V tree if that's OK
> with people, but the cover letter suggests the patch is necessary for
> multiple patch sets.

See also Dmitry's reply[0] to the PSCI thread. (Maybe I should have sent
both conversions as one series?)

I am happy with the patches going through any tree. The kernel/reboot.c
patch is exactly the same between the two series, so it should not hurt
if it gets merged twice. Though if you take this series through the
RISC-V tree, maybe you want to create a tag for it?

I am not sure exactly what needs to be done here; I am happy to do
anything that would assist getting both series merged for v6.3, to avoid
a regression with axp20x[1].

Regards,
Samuel

[0]:
https://lore.kernel.org/lkml/0a180849-ba1b-2a82-ab06-ed1b8155d5ca@collabora.com/
[1]:
https://lore.kernel.org/lkml/e38d29f5-cd3c-4a2b-b355-2bcfad00a24b@sholland.org/
