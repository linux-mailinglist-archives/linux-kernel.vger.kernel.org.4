Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2190870FBA8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 18:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbjEXQYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 12:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEXQYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 12:24:19 -0400
Received: from debian-mailserver.fidu.org (mail.tuxedocomputers.com [157.90.84.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF578E9;
        Wed, 24 May 2023 09:24:16 -0700 (PDT)
Received: from [192.168.178.25] (business-24-134-105-141.pool2.vodafone-ip.de [24.134.105.141])
        (Authenticated sender: wse@tuxedocomputers.com)
        by debian-mailserver.fidu.org (Postfix) with ESMTPSA id 7469C2FC00CF;
        Wed, 24 May 2023 18:24:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
        s=default; t=1684945455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mfFxQs/lolLgBVLKGn3/oeJ4OPiYGO891nJGc0ctP/A=;
        b=HuzBR2CnEyIMo9ETSYoPY/aE8FF9oqeAnjPow3uhuU1niinAbqIWplGobSlRVno96VicQ4
        WDBNTA43IZY3nJO1e3nCZtBtHqeZdjnBKxocEKQkD6dsqfT2lsV/tS9kZ32cGQ3Mp1G+/y
        vZ5OgdwP8WT2fhTjq9iuTyNl/9gMa4M=
Authentication-Results: debian-mailserver.fidu.org;
        auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <1921a791-10ad-90c4-5656-71bca1dfded5@tuxedocomputers.com>
Date:   Wed, 24 May 2023 18:24:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] ACPI: resource: Remove "Zen" specific match and quirks
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "rafael@kernel.org" <rafael@kernel.org>
Cc:     "gch981213@gmail.com" <gch981213@gmail.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "regressions@leemhuis.info" <regressions@leemhuis.info>,
        "ofenfisch@googlemail.com" <ofenfisch@googlemail.com>,
        "adam.niederer@gmail.com" <adam.niederer@gmail.com>,
        "adrian@freund.io" <adrian@freund.io>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "Pananchikkal, Renjith" <Renjith.Pananchikkal@amd.com>,
        "Tsao, Anson" <anson.tsao@amd.com>,
        "Gong, Richard" <Richard.Gong@amd.com>,
        "evilsnoo@proton.me" <evilsnoo@proton.me>,
        "ruinairas1992@gmail.com" <ruinairas1992@gmail.com>
References: <20230518183920.93472-1-mario.limonciello@amd.com>
 <ca1f3eeb-76b5-d80f-e12f-94890922fdd6@tuxedocomputers.com>
 <DS7PR12MB6095B4D8F7882719E5224861E2409@DS7PR12MB6095.namprd12.prod.outlook.com>
Content-Language: en-US
From:   Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <DS7PR12MB6095B4D8F7882719E5224861E2409@DS7PR12MB6095.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 23.05.23 um 19:56 schrieb Limonciello, Mario:
> [AMD Official Use Only - General]
>
>> -----Original Message-----
>> From: Werner Sembach <wse@tuxedocomputers.com>
>> Sent: Tuesday, May 23, 2023 12:53 PM
>> To: Limonciello, Mario <Mario.Limonciello@amd.com>; rafael@kernel.org
>> Cc: gch981213@gmail.com; linux-acpi@vger.kernel.org; linux-
>> kernel@vger.kernel.org; regressions@leemhuis.info;
>> ofenfisch@googlemail.com; adam.niederer@gmail.com; adrian@freund.io;
>> jirislaby@kernel.org; Pananchikkal, Renjith <Renjith.Pananchikkal@amd.com>;
>> Tsao, Anson <anson.tsao@amd.com>; Gong, Richard
>> <Richard.Gong@amd.com>; evilsnoo@proton.me; ruinairas1992@gmail.com
>> Subject: Re: [PATCH v2] ACPI: resource: Remove "Zen" specific match and
>> quirks
>>
>> Hi,
>>
>> Am 18.05.23 um 20:39 schrieb Mario Limonciello:
>>> commit 9946e39fe8d0 ("ACPI: resource: skip IRQ override on
>>> AMD Zen platforms") attempted to overhaul the override logic so it
>>> didn't apply on X86 AMD Zen systems.  This was intentional so that
>>> systems would prefer DSDT values instead of default MADT value for
>>> IRQ 1 on Ryzen 6000 systems which use ActiveLow for IRQ1.
>>>
>>> This turned out to be a bad assumption because several vendors seem
>>> to add Interrupt Source Override but don't fix the DSDT. A pile of
>>> quirks was collecting that proved this wasn't sustaintable.
>>>
>>> Adjust the logic so that only IRQ1 is overridden in Ryzen 6000 case.
>>>
>>> This effectively reverts the following commits:
>>> commit 17bb7046e7ce ("ACPI: resource: Do IRQ override on all TongFang
>>> GMxRGxx")
>>> commit f3cb9b740869 ("ACPI: resource: do IRQ override on Lenovo
>> 14ALC7")
>>> commit bfcdf58380b1 ("ACPI: resource: do IRQ override on LENOVO
>> IdeaPad")
>>> commit 7592b79ba4a9 ("ACPI: resource: do IRQ override on XMG Core 15")
>> The TongFang GMxRGxx/XMG CORE 15 (M22)/TUXEDO Stellaris 15 Gen4 AMD
>> breaks again with this patch (applied to 6.4-rc3). Am I missing an additional
>> patch that is required?
> You're not missing anything extra, but let's gather some detail about your system
> and figure out why.
>
> What CPU is in it?
AMD Ryzen 9 6900HX
> Also would you mind sending me an acpidump?  You can send directly to me off-list
> if you want.

Doing that to not load the list with big attachments.

But for reference: here it was discussed too: 
https://bugzilla.kernel.org/show_bug.cgi?id=216698

Note that TF did eventually provide a fixed BIOS, but most likely not all 
vendors ship that BIOS and/or all users are aware that this fix exists. So I 
purposefully used the older unfixed BIOS to test the kernel.

>
>>> Cc: ofenfisch@googlemail.com
>>> Cc: wse@tuxedocomputers.com
>>> Cc: adam.niederer@gmail.com
>>> Cc: adrian@freund.io
>>> Cc: jirislaby@kernel.org
>>> Tested-by: Renjith.Pananchikkal@amd.com
>>> Tested-by: anson.tsao@amd.com
>>> Tested-by: Richard.Gong@amd.com
>>> Tested-by: Chuanhong Guo <gch981213@gmail.com>
>>> Reported-by: evilsnoo@proton.me
>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217394
>>> Reported-by: ruinairas1992@gmail.com
>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217406
>>> Fixes: 9946e39fe8d0 ("ACPI: resource: skip IRQ override on AMD Zen
>> platforms")
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>> v1->v2:
>>>    * Rebase on 71a485624c4c ("ACPI: resource: Add IRQ override quirk for LG
>> UltraPC 17U70P")
>>>    * Pick up tag
>>> ---
>>>    drivers/acpi/resource.c | 154 +++++++++++++++++-----------------------
>>>    1 file changed, 65 insertions(+), 89 deletions(-)
>>>
>>> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
>>> index 0800a9d77558..c6ac87e01e1c 100644
>>> --- a/drivers/acpi/resource.c
>>> +++ b/drivers/acpi/resource.c
>>> @@ -470,52 +470,6 @@ static const struct dmi_system_id asus_laptop[] = {
>>>      { }
>>>    };
>>>
>>> -static const struct dmi_system_id lenovo_laptop[] = {
>>> -   {
>>> -           .ident = "LENOVO IdeaPad Flex 5 14ALC7",
>>> -           .matches = {
>>> -                   DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>>> -                   DMI_MATCH(DMI_PRODUCT_NAME, "82R9"),
>>> -           },
>>> -   },
>>> -   {
>>> -           .ident = "LENOVO IdeaPad Flex 5 16ALC7",
>>> -           .matches = {
>>> -                   DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>>> -                   DMI_MATCH(DMI_PRODUCT_NAME, "82RA"),
>>> -           },
>>> -   },
>>> -   { }
>>> -};
>>> -
>>> -static const struct dmi_system_id tongfang_gm_rg[] = {
>>> -   {
>>> -           .ident = "TongFang GMxRGxx/XMG CORE 15 (M22)/TUXEDO
>> Stellaris 15 Gen4 AMD",
>>> -           .matches = {
>>> -                   DMI_MATCH(DMI_BOARD_NAME, "GMxRGxx"),
>>> -           },
>>> -   },
>>> -   { }
>>> -};
>>> -
>>> -static const struct dmi_system_id maingear_laptop[] = {
>>> -   {
>>> -           .ident = "MAINGEAR Vector Pro 2 15",
>>> -           .matches = {
>>> -                   DMI_MATCH(DMI_SYS_VENDOR, "Micro Electronics
>> Inc"),
>>> -                   DMI_MATCH(DMI_PRODUCT_NAME, "MG-VCP2-
>> 15A3070T"),
>>> -           }
>>> -   },
>>> -   {
>>> -           .ident = "MAINGEAR Vector Pro 2 17",
>>> -           .matches = {
>>> -                   DMI_MATCH(DMI_SYS_VENDOR, "Micro Electronics
>> Inc"),
>>> -                   DMI_MATCH(DMI_PRODUCT_NAME, "MG-VCP2-
>> 17A3070T"),
>>> -           },
>>> -   },
>>> -   { }
>>> -};
>>> -
>>>    static const struct dmi_system_id lg_laptop[] = {
>>>      {
>>>              .ident = "LG Electronics 17U70P",
>>> @@ -527,7 +481,7 @@ static const struct dmi_system_id lg_laptop[] = {
>>>      { }
>>>    };
>>>
>>> -struct irq_override_cmp {
>>> +struct irq_override_dmi_cmp {
>>>      const struct dmi_system_id *system;
>>>      unsigned char irq;
>>>      unsigned char triggering;
>>> @@ -536,50 +490,86 @@ struct irq_override_cmp {
>>>      bool override;
>>>    };
>>>
>>> -static const struct irq_override_cmp override_table[] = {
>>> +struct irq_override_acpi_cmp {
>>> +   const char *id;
>>> +   unsigned char irq;
>>> +   unsigned char triggering;
>>> +   unsigned char polarity;
>>> +};
>>> +
>>> +static const struct irq_override_dmi_cmp dmi_override_table[] = {
>>>      { medion_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0,
>> false },
>>>      { asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false
>> },
>>> -   { lenovo_laptop, 6, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0,
>> true },
>>> -   { lenovo_laptop, 10, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0,
>> true },
>>> -   { tongfang_gm_rg, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1,
>> true },
>>> -   { maingear_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1,
>> true },
>>>      { lg_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
>>>    };
>>>
>>> -static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
>>> -                             u8 shareable)
>>> +/*
>>> + * Ryzen 6000 requires ActiveLow for keyboard, but a number of machines
>>> + * seem to get it wrong in DSDT or don't have an Interrupt Source
>>> + * Override.
>>> + */
>>> +static const struct irq_override_acpi_cmp acpi_override_table[] = {
>>> +   { "AMDI0007", 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW },
>>> +};
>>> +
>>> +static void acpi_dev_irq_override(u32 gsi, u8 *triggering, u8 *polarity,
>>> +                             u8 *shareable)
>>>    {
>>> -   int i;
>>> +   int i, p, t;
>>> +   int check_override = true;
>>>
>>> -   for (i = 0; i < ARRAY_SIZE(override_table); i++) {
>>> -           const struct irq_override_cmp *entry = &override_table[i];
>>> +   for (i = 0; i < ARRAY_SIZE(dmi_override_table); i++) {
>>> +           const struct irq_override_dmi_cmp *entry =
>> &dmi_override_table[i];
>>>              if (dmi_check_system(entry->system) &&
>>>                  entry->irq == gsi &&
>>> -               entry->triggering == triggering &&
>>> -               entry->polarity == polarity &&
>>> -               entry->shareable == shareable)
>>> -                   return entry->override;
>>> +               entry->triggering == *triggering &&
>>> +               entry->polarity == *polarity &&
>>> +               entry->shareable == *shareable)
>>> +                   check_override = entry->override;
>>>      }
>>>
>>> -#ifdef CONFIG_X86
>>> -   /*
>>> -    * IRQ override isn't needed on modern AMD Zen systems and
>>> -    * this override breaks active low IRQs on AMD Ryzen 6000 and
>>> -    * newer systems. Skip it.
>>> -    */
>>> -   if (boot_cpu_has(X86_FEATURE_ZEN))
>>> -           return false;
>>> -#endif
>>> +   if (!check_override)
>>> +           return;
>>>
>>> -   return true;
>>> +   if (!acpi_get_override_irq(gsi, &t, &p)) {
>>> +           u8 trig = t ? ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
>>> +           u8 pol = p ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
>>> +
>>> +           if (*triggering != trig || *polarity != pol) {
>>> +                   pr_warn("ACPI: IRQ %d override to %s%s, %s%s\n",
>> gsi,
>>> +                           t ? "level" : "edge",
>>> +                           trig == *triggering ? "" : "(!)",
>>> +                           p ? "low" : "high",
>>> +                           pol == *polarity ? "" : "(!)");
>>> +                   *triggering = trig;
>>> +                   *polarity = pol;
>>> +           }
>>> +   }
>>> +
>>> +   for (i = 0; i < ARRAY_SIZE(acpi_override_table); i++) {
>>> +           const struct irq_override_acpi_cmp *entry =
>> &acpi_override_table[i];
>>> +
>>> +           if (acpi_dev_found(entry->id) && gsi == entry->irq &&
>>> +              (*polarity != entry->polarity || *triggering != entry-
>>> triggering)) {
>>> +                   pr_warn("ACPI: IRQ %d override to %s%s, %s%s due
>> to %s\n",
>>> +                           gsi,
>>> +                           entry->triggering ? "level" : "edge",
>>> +                           entry->triggering == *triggering ? "" : "(!)",
>>> +                           entry->polarity ? "low" : "high",
>>> +                           entry->polarity == *polarity ? "" : "(!)",
>>> +                           entry->id);
>>> +                   *polarity = entry->polarity;
>>> +                   *triggering = entry->triggering;
>>> +           }
>>> +   }
>>>    }
>>>
>>>    static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
>>>                                   u8 triggering, u8 polarity, u8 shareable,
>>>                                   u8 wake_capable, bool check_override)
>>>    {
>>> -   int irq, p, t;
>>> +   int irq;
>>>
>>>      if (!valid_IRQ(gsi)) {
>>>              irqresource_disabled(res, gsi);
>>> @@ -592,26 +582,12 @@ static void acpi_dev_get_irqresource(struct
>> resource *res, u32 gsi,
>>>       * 2. BIOS uses IO-APIC mode Interrupt Source Override
>>>       *
>>>       * We do this only if we are dealing with IRQ() or IRQNoFlags()
>>> -    * resource (the legacy ISA resources). With modern ACPI 5 devices
>>> +    * resource (the legacy ISA resources). With ACPI devices
>>>       * using extended IRQ descriptors we take the IRQ configuration
>>>       * from _CRS directly.
>>>       */
>>> -   if (check_override &&
>>> -       acpi_dev_irq_override(gsi, triggering, polarity, shareable) &&
>>> -       !acpi_get_override_irq(gsi, &t, &p)) {
>>> -           u8 trig = t ? ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
>>> -           u8 pol = p ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
>>> -
>>> -           if (triggering != trig || polarity != pol) {
>>> -                   pr_warn("ACPI: IRQ %d override to %s%s, %s%s\n",
>> gsi,
>>> -                           t ? "level" : "edge",
>>> -                           trig == triggering ? "" : "(!)",
>>> -                           p ? "low" : "high",
>>> -                           pol == polarity ? "" : "(!)");
>>> -                   triggering = trig;
>>> -                   polarity = pol;
>>> -           }
>>> -   }
>>> +   if (check_override)
>>> +           acpi_dev_irq_override(gsi, &triggering, &polarity, &shareable);
>>>
>>>      res->flags = acpi_dev_irq_flags(triggering, polarity, shareable,
>> wake_capable);
>>>      irq = acpi_register_gsi(NULL, gsi, triggering, polarity);
>>>
>>> base-commit: c554eee18c9a440bd2dd5a363b0f79325717f0bf
