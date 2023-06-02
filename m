Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C27C71F6F4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 02:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjFBABY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 20:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbjFBABU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 20:01:20 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF29112C;
        Thu,  1 Jun 2023 17:01:18 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-75b01944dd6so17238985a.1;
        Thu, 01 Jun 2023 17:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685664078; x=1688256078;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UCg8WzwXak17NTUJxpDTh99QdG7Lc6KzqCJOD2KYiTA=;
        b=mVnyUIjngL9CJuUS5Oq12mXGDGONPm6FcjRZiywI/dZZsWlioXrx9SFfIzvBG9Hvgy
         pTmvf5lVUlpQPFOASlePXDxVSOlR+b+ONKm2E7FxS99nk4/AEHK0/WNql1DzusWXiyCb
         vGUVaXDJPxM2EvYTV0DrWvCLDmLFi6TrBlEeoY+tUNObdjMjHLEocTtDADZXj0LGFLLs
         Qu+gn+Q2q8LICPTlNsTx0dC+kbUwb5CTPNCJ7f3PJx7UxiMNXTjlrESdUTs5uSAHGvzH
         7hGZdzytrS55qHkNhOpw8WSWuE8/1VfOHS8usrVTybtgcdjrcuiRsbW8La2KDsm6NI2R
         0wow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685664078; x=1688256078;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UCg8WzwXak17NTUJxpDTh99QdG7Lc6KzqCJOD2KYiTA=;
        b=G7WQuW5i4lnqEpDRTsf1taNhboYL+Tk/1gfyGNj4ndVf+pMg7OHVnqKjsevlzvNqli
         W6sjGafhVlDg8OZKyQ4wPDurwDLxnWzaiwnMpGiNsiRn3gQsh8wdVQv2my0VB29mSXZi
         C3Q5hNmnnFlupDh2pln9PvNlorl1ru9XFyoiVq+cYV+S+MhhTzb1HbRHpN4BeDzEIQfg
         HQUo33F1A0oAQnMxahLH9VOjPpJ3qzTwKt4FR2tAvZYxgsuEA0YZTN/yvS8c6E9NvDwM
         Djzw95tzgRCiNSYvC9ujqHykiB5RanfC2/fdKkHUlGFaZu4ilu4bfYN09ZE9OtEHlD+t
         W7Wg==
X-Gm-Message-State: AC+VfDyf8JvLhoIVfXK0FRkEe1DenONUCbaBnqQXPhY8FntmtqKd0ANB
        gPZCz9kecf8Ay8a04KTzq7I=
X-Google-Smtp-Source: ACHHUZ4Hvfb6JsqkWlR9ZbmLdULxFDLb0tHiNU/Xkd2eAOZNtG9TNNRR9kw66ZzxP4ORIEcic8d7Tg==
X-Received: by 2002:a05:620a:17ab:b0:75b:23a1:829f with SMTP id ay43-20020a05620a17ab00b0075b23a1829fmr8311812qkb.0.1685664077619;
        Thu, 01 Jun 2023 17:01:17 -0700 (PDT)
Received: from [192.168.75.211] ([173.23.87.62])
        by smtp.gmail.com with ESMTPSA id y184-20020a0dd6c1000000b00565e57e6662sm4792656ywd.55.2023.06.01.17.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 17:01:17 -0700 (PDT)
Message-ID: <b97242cf-33cf-66b8-4816-ba1f90df41a4@gmail.com>
Date:   Thu, 1 Jun 2023 19:01:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] ACPI: resource: Remove "Zen" specific match and quirks
Content-Language: en-US
To:     Mario Limonciello <mario.limonciello@amd.com>, rafael@kernel.org
Cc:     gch981213@gmail.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@leemhuis.info,
        ofenfisch@googlemail.com, wse@tuxedocomputers.com,
        adam.niederer@gmail.com, adrian@freund.io, jirislaby@kernel.org,
        Renjith.Pananchikkal@amd.com, anson.tsao@amd.com,
        Richard.Gong@amd.com, evilsnoo@proton.me
References: <20230515213822.1277-1-mario.limonciello@amd.com>
From:   Matthew Anderson <ruinairas1992@gmail.com>
In-Reply-To: <20230515213822.1277-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I tested Patch v3 and it still works on the Aya Neo Air Plus.

Tested-by: Matthew Anderson<ruinairas1992@gmail.com>

On 5/15/23 4:38 PM, Mario Limonciello wrote:
> commit 9946e39fe8d0 ("ACPI: resource: skip IRQ override on
> AMD Zen platforms") attempted to overhaul the override logic so it
> didn't apply on X86 AMD Zen systems.  This was intentional so that
> systems would prefer DSDT values instead of default MADT value for
> IRQ 1 on Ryzen 6000 systems which use ActiveLow for IRQ1.
>
> This turned out to be a bad assumption because several vendors seem
> to add Interrupt Source Override but don't fix the DSDT. A pile of
> quirks was collecting that proved this wasn't sustaintable.
>
> Adjust the logic so that only IRQ1 is overridden in Ryzen 6000 case.
>
> This effectively reverts the following commits:
> commit 17bb7046e7ce ("ACPI: resource: Do IRQ override on all TongFang
> GMxRGxx")
> commit f3cb9b740869 ("ACPI: resource: do IRQ override on Lenovo 14ALC7")
> commit bfcdf58380b1 ("ACPI: resource: do IRQ override on LENOVO IdeaPad")
> commit 7592b79ba4a9 ("ACPI: resource: do IRQ override on XMG Core 15")
>
> Cc: ofenfisch@googlemail.com
> Cc: gch981213@gmail.com
> Cc: wse@tuxedocomputers.com
> Cc: adam.niederer@gmail.com
> Cc: adrian@freund.io
> Cc: jirislaby@kernel.org
> Tested-by: Renjith.Pananchikkal@amd.com
> Tested-by: anson.tsao@amd.com
> Tested-by: Richard.Gong@amd.com
> Reported-by: evilsnoo@proton.me
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217394
> Reported-by: ruinairas1992@gmail.com
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217406
> Fixes: 9946e39fe8d0 ("ACPI: resource: skip IRQ override on AMD Zen platforms")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/acpi/resource.c | 154 +++++++++++++++++-----------------------
>   1 file changed, 65 insertions(+), 89 deletions(-)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index e8492b3a393a..828adb4be721 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -470,53 +470,7 @@ static const struct dmi_system_id asus_laptop[] = {
>   	{ }
>   };
>   
> -static const struct dmi_system_id lenovo_laptop[] = {
> -	{
> -		.ident = "LENOVO IdeaPad Flex 5 14ALC7",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "82R9"),
> -		},
> -	},
> -	{
> -		.ident = "LENOVO IdeaPad Flex 5 16ALC7",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "82RA"),
> -		},
> -	},
> -	{ }
> -};
> -
> -static const struct dmi_system_id tongfang_gm_rg[] = {
> -	{
> -		.ident = "TongFang GMxRGxx/XMG CORE 15 (M22)/TUXEDO Stellaris 15 Gen4 AMD",
> -		.matches = {
> -			DMI_MATCH(DMI_BOARD_NAME, "GMxRGxx"),
> -		},
> -	},
> -	{ }
> -};
> -
> -static const struct dmi_system_id maingear_laptop[] = {
> -	{
> -		.ident = "MAINGEAR Vector Pro 2 15",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Micro Electronics Inc"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "MG-VCP2-15A3070T"),
> -		}
> -	},
> -	{
> -		.ident = "MAINGEAR Vector Pro 2 17",
> -		.matches = {
> -			DMI_MATCH(DMI_SYS_VENDOR, "Micro Electronics Inc"),
> -			DMI_MATCH(DMI_PRODUCT_NAME, "MG-VCP2-17A3070T"),
> -		},
> -	},
> -	{ }
> -};
> -
> -struct irq_override_cmp {
> +struct irq_override_dmi_cmp {
>   	const struct dmi_system_id *system;
>   	unsigned char irq;
>   	unsigned char triggering;
> @@ -525,49 +479,85 @@ struct irq_override_cmp {
>   	bool override;
>   };
>   
> -static const struct irq_override_cmp override_table[] = {
> +struct irq_override_acpi_cmp {
> +	const char *id;
> +	unsigned char irq;
> +	unsigned char triggering;
> +	unsigned char polarity;
> +};
> +
> +static const struct irq_override_dmi_cmp dmi_override_table[] = {
>   	{ medion_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
>   	{ asus_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
> -	{ lenovo_laptop, 6, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
> -	{ lenovo_laptop, 10, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, true },
> -	{ tongfang_gm_rg, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
> -	{ maingear_laptop, 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW, 1, true },
>   };
>   
> -static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
> -				  u8 shareable)
> +/*
> + * Ryzen 6000 requires ActiveLow for keyboard, but a number of machines
> + * seem to get it wrong in DSDT or don't have an Interrupt Source
> + * Override.
> + */
> +static const struct irq_override_acpi_cmp acpi_override_table[] = {
> +	{ "AMDI0007", 1, ACPI_EDGE_SENSITIVE, ACPI_ACTIVE_LOW },
> +};
> +
> +static void acpi_dev_irq_override(u32 gsi, u8 *triggering, u8 *polarity,
> +				  u8 *shareable)
>   {
> -	int i;
> +	int i, p, t;
> +	int check_override = true;
>   
> -	for (i = 0; i < ARRAY_SIZE(override_table); i++) {
> -		const struct irq_override_cmp *entry = &override_table[i];
> +	for (i = 0; i < ARRAY_SIZE(dmi_override_table); i++) {
> +		const struct irq_override_dmi_cmp *entry = &dmi_override_table[i];
>   
>   		if (dmi_check_system(entry->system) &&
>   		    entry->irq == gsi &&
> -		    entry->triggering == triggering &&
> -		    entry->polarity == polarity &&
> -		    entry->shareable == shareable)
> -			return entry->override;
> +		    entry->triggering == *triggering &&
> +		    entry->polarity == *polarity &&
> +		    entry->shareable == *shareable)
> +			check_override = entry->override;
>   	}
>   
> -#ifdef CONFIG_X86
> -	/*
> -	 * IRQ override isn't needed on modern AMD Zen systems and
> -	 * this override breaks active low IRQs on AMD Ryzen 6000 and
> -	 * newer systems. Skip it.
> -	 */
> -	if (boot_cpu_has(X86_FEATURE_ZEN))
> -		return false;
> -#endif
> +	if (!check_override)
> +		return;
>   
> -	return true;
> +	if (!acpi_get_override_irq(gsi, &t, &p)) {
> +		u8 trig = t ? ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
> +		u8 pol = p ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
> +
> +		if (*triggering != trig || *polarity != pol) {
> +			pr_warn("ACPI: IRQ %d override to %s%s, %s%s\n", gsi,
> +				t ? "level" : "edge",
> +				trig == *triggering ? "" : "(!)",
> +				p ? "low" : "high",
> +				pol == *polarity ? "" : "(!)");
> +			*triggering = trig;
> +			*polarity = pol;
> +		}
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(acpi_override_table); i++) {
> +		const struct irq_override_acpi_cmp *entry = &acpi_override_table[i];
> +
> +		if (acpi_dev_found(entry->id) && gsi == entry->irq &&
> +		   (*polarity != entry->polarity || *triggering != entry->triggering)) {
> +			pr_warn("ACPI: IRQ %d override to %s%s, %s%s due to %s\n",
> +				gsi,
> +				entry->triggering ? "level" : "edge",
> +				entry->triggering == *triggering ? "" : "(!)",
> +				entry->polarity ? "low" : "high",
> +				entry->polarity == *polarity ? "" : "(!)",
> +				entry->id);
> +			*polarity = entry->polarity;
> +			*triggering = entry->triggering;
> +		}
> +	}
>   }
>   
>   static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
>   				     u8 triggering, u8 polarity, u8 shareable,
>   				     u8 wake_capable, bool check_override)
>   {
> -	int irq, p, t;
> +	int irq;
>   
>   	if (!valid_IRQ(gsi)) {
>   		irqresource_disabled(res, gsi);
> @@ -580,26 +570,12 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
>   	 * 2. BIOS uses IO-APIC mode Interrupt Source Override
>   	 *
>   	 * We do this only if we are dealing with IRQ() or IRQNoFlags()
> -	 * resource (the legacy ISA resources). With modern ACPI 5 devices
> +	 * resource (the legacy ISA resources). With ACPI devices
>   	 * using extended IRQ descriptors we take the IRQ configuration
>   	 * from _CRS directly.
>   	 */
> -	if (check_override &&
> -	    acpi_dev_irq_override(gsi, triggering, polarity, shareable) &&
> -	    !acpi_get_override_irq(gsi, &t, &p)) {
> -		u8 trig = t ? ACPI_LEVEL_SENSITIVE : ACPI_EDGE_SENSITIVE;
> -		u8 pol = p ? ACPI_ACTIVE_LOW : ACPI_ACTIVE_HIGH;
> -
> -		if (triggering != trig || polarity != pol) {
> -			pr_warn("ACPI: IRQ %d override to %s%s, %s%s\n", gsi,
> -				t ? "level" : "edge",
> -				trig == triggering ? "" : "(!)",
> -				p ? "low" : "high",
> -				pol == polarity ? "" : "(!)");
> -			triggering = trig;
> -			polarity = pol;
> -		}
> -	}
> +	if (check_override)
> +		acpi_dev_irq_override(gsi, &triggering, &polarity, &shareable);
>   
>   	res->flags = acpi_dev_irq_flags(triggering, polarity, shareable, wake_capable);
>   	irq = acpi_register_gsi(NULL, gsi, triggering, polarity);
