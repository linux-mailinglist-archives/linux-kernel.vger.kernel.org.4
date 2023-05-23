Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D3E70E742
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 23:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238513AbjEWVVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 17:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEWVVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 17:21:01 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E162E5;
        Tue, 23 May 2023 14:21:00 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-62576fa52b4so990956d6.0;
        Tue, 23 May 2023 14:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684876859; x=1687468859;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AHPM3GBQPi8yO5qwlZK4x/CMaBvpXl5XM+iCpe+XpBs=;
        b=Etoyh42Wp1cO2y8+LEySWfPxZlUOkJ5wlpDrsb1torsW49tqa9/y3wXZTCKO4VsrNU
         5oK1t/Y/1y+aG6NKqrQGLjJr7LlLkCJ/hMHoy4S6ZEWggWRcVfHWt+K0A49CFMrI5ZWN
         FebBTHUeG5DlSbYG6va3d2mZsjb3TbfPxUjYNa0jJYgt81hCDc5sEpFomXv+iu/eqb09
         Xmgyw9QxYMiW1Prs8IAbYgYKnoC1TtErPM1BQD2CKpAFZa7+rP4TINDBvYPOdMWJAcRt
         fvTHXHi4jUhHJ/hYyR75ONyS7ostQvoIV48k+cmlkZF4+6U0uiwCDDq7A/9JN6fI46X1
         w91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684876859; x=1687468859;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AHPM3GBQPi8yO5qwlZK4x/CMaBvpXl5XM+iCpe+XpBs=;
        b=e+rA4eI1FUf2aVidbGPltlhWMxZ8YeUnBNmorOjRQZoqcX+NMMsjrRR26xkbcxzsm5
         /5NZHl9qwC9ViPukJvu1gaNqqQLnQP4FZ8Hkiig2qGfPYnCXyCR/E8J9Fnz6AkS3TUPF
         Z1zTLfjGpp0Hq4L5ZMQBBzcop6QcVHLyvEm3irfwENtGrIHUGRGNES/3Gz2OOTAzeV6b
         GYXpAX46vr6cwixGdFX4HlbUxGJi/uCwas895FLTmCirvrJHOXQFItlbVUhl7y+6lc1b
         V5yP/XHYc8Ult3+fo3GmHzN2Sb8W9vFwn9kJ6/OmWUcNWefp/z/NIEomTIOuCCDAwC7v
         GgAg==
X-Gm-Message-State: AC+VfDzwZ3y49Lq45mhyw5y9OL/DTleBGWeYOk49K8ldBwD5vwLreYGx
        6Ij6NVjIHycXudP+o4V0Cfk=
X-Google-Smtp-Source: ACHHUZ5RAlhMyacvlj2RQpzqpO/xmuUrwyniOctxxCXvfogovAVjGuWB2vbbMGrw1F8CPi1/ltmmdw==
X-Received: by 2002:a05:6214:d4b:b0:5ef:5456:783c with SMTP id 11-20020a0562140d4b00b005ef5456783cmr27017864qvr.40.1684876859017;
        Tue, 23 May 2023 14:20:59 -0700 (PDT)
Received: from [192.168.1.176] (pool-72-94-185-71.phlapa.fios.verizon.net. [72.94.185.71])
        by smtp.gmail.com with ESMTPSA id c18-20020a0cd612000000b006215f334a18sm3041431qvj.28.2023.05.23.14.20.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 14:20:58 -0700 (PDT)
Message-ID: <d4522480-8095-3162-2842-25d5dc0ccfff@gmail.com>
Date:   Tue, 23 May 2023 17:20:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] ACPI: resource: Remove "Zen" specific match and quirks
To:     Mario Limonciello <mario.limonciello@amd.com>, rafael@kernel.org
Cc:     gch981213@gmail.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@leemhuis.info,
        ofenfisch@googlemail.com, wse@tuxedocomputers.com,
        adrian@freund.io, jirislaby@kernel.org,
        Renjith.Pananchikkal@amd.com, anson.tsao@amd.com,
        Richard.Gong@amd.com, evilsnoo@proton.me, ruinairas1992@gmail.com
References: <20230518183920.93472-1-mario.limonciello@amd.com>
Content-Language: en-US
From:   Adam <adam.niederer@gmail.com>
In-Reply-To: <20230518183920.93472-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey, I have tested 6.4-rc3 and this breaks the integrated trackpad on my 
MAINGEAR Vector Pro 2 15" 6900H model (MG-VCP2-15A3070T), but the 
keyboard still works (the trackpad worked and keyboard did not before I 
submitted my ACPI override). I'll send over an acpidump directly as well.

On 5/18/23 14:39, Mario Limonciello wrote:
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
> Cc: wse@tuxedocomputers.com
> Cc: adam.niederer@gmail.com
> Cc: adrian@freund.io
> Cc: jirislaby@kernel.org
> Tested-by: Renjith.Pananchikkal@amd.com
> Tested-by: anson.tsao@amd.com
> Tested-by: Richard.Gong@amd.com
> Tested-by: Chuanhong Guo <gch981213@gmail.com>
> Reported-by: evilsnoo@proton.me
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217394
> Reported-by: ruinairas1992@gmail.com
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217406
> Fixes: 9946e39fe8d0 ("ACPI: resource: skip IRQ override on AMD Zen platforms")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v1->v2:
>   * Rebase on 71a485624c4c ("ACPI: resource: Add IRQ override quirk for LG UltraPC 17U70P")
>   * Pick up tag
> ---
>   drivers/acpi/resource.c | 154 +++++++++++++++++-----------------------
>   1 file changed, 65 insertions(+), 89 deletions(-)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 0800a9d77558..c6ac87e01e1c 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -470,52 +470,6 @@ static const struct dmi_system_id asus_laptop[] = {
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
>   static const struct dmi_system_id lg_laptop[] = {
>   	{
>   		.ident = "LG Electronics 17U70P",
> @@ -527,7 +481,7 @@ static const struct dmi_system_id lg_laptop[] = {
>   	{ }
>   };
>   
> -struct irq_override_cmp {
> +struct irq_override_dmi_cmp {
>   	const struct dmi_system_id *system;
>   	unsigned char irq;
>   	unsigned char triggering;
> @@ -536,50 +490,86 @@ struct irq_override_cmp {
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
>   	{ lg_laptop, 1, ACPI_LEVEL_SENSITIVE, ACPI_ACTIVE_LOW, 0, false },
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
> @@ -592,26 +582,12 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
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
>
> base-commit: c554eee18c9a440bd2dd5a363b0f79325717f0bf
