Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F165FD4F1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 08:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiJMGis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 02:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJMGiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 02:38:46 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0F3127BDA;
        Wed, 12 Oct 2022 23:38:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9bVQApFu/YjgwJT/WRuDsh3FsF9m0gE2NvI3GrlJLZWKy//eTGZXZJLxHE6bQdaUWP8Qk29b3JYRnEch5v20/30YhVWzr74xmRgFyTUPsvZyDfG/VdQy1EKA5DKHERJ2Dv86NY0NJg+GWqmE96OMYXPQztHI3G6WuoMFQthGNG2yKBBMXpygawMJDgpNh2/7vqsu8aeseXdma/hY05559V/wdmzZp59wkySQApM8UjULRlrgdxsrGvNK2PZsajCzgaNdoWHXOlR3fcM5AX8Xhe3A8D1TSC+mND7U8gFU063JPt7bCj+oYtow9pwzJbg3JVLCLia6FedBrQu5DTyZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVvV0L4hidoXv7f8/1s/akz0/1W4jswkoavdEzOiEOI=;
 b=ZeSpLF4n/isQQZnQSeW2sngCpm3krfJtgnyoBy1cioouN510Hqb0JO7NTVkPMMmr7H7aj/jnqmkdt/fbVFEZGSs5URFQm5q1kqH6N7TH2YIZJMTQr0kX1+hJYzArZVCcva+BZLbbmfBypzAJQrKK5gXmNUsaIlO6ltv9TV+7DQr6KGUb/Dr2K8YMzhCnmA9LhdF0Yg8Yr3cbufgLQE7EMARZ7DQxoKqbimGK2ZeXdcg5xk3n8VroRahKJAwp4nqsN6pfMlF1NeeKCOdL8Wd4pD90caJ6gzKBsthU8qVMRIZlaz7TZQZcwSETB8Yu37GdDv2UI+8ku7apvKmuUtA6xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVvV0L4hidoXv7f8/1s/akz0/1W4jswkoavdEzOiEOI=;
 b=Q9LP1yKi2wZK01FjzJxjiN0gsvv7QdOsuj6gixqdEL1gNZZdkxRd829pQAV+aoBeWhnL4WwRJOhsWhsrZoWyvF2/AEQ8Q93NQ/iypI2ltl7ysB2Y1Do83dIsugTyaSGviLfSOxbtCmdPha8AGMh9gw+es6Oc43hb1MoxrosVta0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by LV2PR12MB5896.namprd12.prod.outlook.com (2603:10b6:408:172::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Thu, 13 Oct
 2022 06:38:42 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6579:a8ca:b90b:c3fb]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::6579:a8ca:b90b:c3fb%5]) with mapi id 15.20.5723.026; Thu, 13 Oct 2022
 06:38:42 +0000
Message-ID: <8fc979d4-089a-7293-d580-a2affc74d68d@amd.com>
Date:   Thu, 13 Oct 2022 12:08:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH 1/1] pinctrl: amd: Add dynamic debugging for active GPIOs
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc:     Mark Pearson <mpearson@lenovo.com>,
        Pananchikkal Renjith <Renjith.Pananchikkal@amd.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221012221028.4817-1-mario.limonciello@amd.com>
 <20221012221028.4817-2-mario.limonciello@amd.com>
Content-Language: en-US
From:   Basavaraj Natikar <bnatikar@amd.com>
In-Reply-To: <20221012221028.4817-2-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0131.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::16) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5040:EE_|LV2PR12MB5896:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b0af89e-ef96-49a6-e58d-08daace5920f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GxPvUQgcZrd7I818JhG/t74JS6N5EyzyZojFbfprzcws9zdjk5ZJ9O9Ck0FgevTI8iMEMODiVYD/NnVlsh6YeASSQCn6Hyo6WGXOpd9FmLiRg/qrnXZ+/6QEqXM+2H51TPl2IeaxJ0+33ArpiDxj4GC7sjtHfwPa6VXEYmgxqeTu/4j2vjvGijdqEyzHH1nwoLRTfXwGuFjxdytBv9ymgGeiqHXiZXUb1uEnYDm8zXKZvuYpMnsxblUYwSYS/Qm0Mz9Q8vrK40Vs4BU3ns/mUbPT3Om9FJdnvOeEjVYv1wNOPAhnaUgeI6FK8mZ0PWFiVEiSJVSWXyfhBRsBYIOy2P5y3GNehgDlEBd6mEhZP6nQv+XIT/Agbyf5i6VVj3dUTWTjV6upA04X17qS+gUCwxjo+EBpXxP4GCjhGf4x9JsCMkWpjx5D/RgEvv5rUf7nLlOCViRZXVoFFN0jNvsKAnpLmkYDorGFxhwpkbwpYemyItPrXjmUNODyHfnTm6r2D8Zc7AaF2LuOcYFZN6iv68Fbell1y7hKFaSkTCyD6zlzCUIX+acvJC7X0IUPJ/NGmCHiyMfeVNKTVdB73CPG7I/xi47ZbXsylS+5S5WOIhDLXvriXL4RoE02mmk7y6+gUoA9wj6K8esrc+CVMsd2kDzDj//SfvhbZyHxLLr7mlDbFqZxNL05RriPHGuGvsYFaptMWBCmKdbu5q6V1f7qmrY84DB6DyK/oa4vDax3R/OX9BeL3CcRr2hQKqiYb4/djWtKx14zSvdxEqsuqRHbudKGzgH8Qq2GkueaNyDdC+U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5040.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(366004)(136003)(39860400002)(451199015)(36756003)(6486002)(38100700002)(110136005)(6636002)(8676002)(54906003)(66476007)(8936002)(2906002)(316002)(41300700001)(4326008)(66946007)(2616005)(66556008)(6666004)(83380400001)(53546011)(31696002)(5660300002)(478600001)(6506007)(186003)(26005)(6512007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkVCM3lGWFpJQlB6LzZwZktwdk5XNHBjOGxpZUZ0NjYveTlNV3RhUHNzZFVB?=
 =?utf-8?B?YWkrWUd3R2VtT2RiUDJBbzRMaUdIMWdKU3pELzhtSDZhdFJZbWxZek5qdlpJ?=
 =?utf-8?B?MGlXdGNJVUtuMXRWb0Y4anJaLzF0cEk1V3pzTVRGNlJVK1pqcUl5VnNEcVJU?=
 =?utf-8?B?RjYrOFduRnMwRXJHWFY4U3I5RU82VFVsMm14YjRqNTFWdFVtcUo3QjN4WGI4?=
 =?utf-8?B?cjhjRTZCLzg0MytQVzVzUExnWFIzMUNIZWZMcmhyQnRPa3RvZlpCNHErTHlK?=
 =?utf-8?B?TFZQSG92eHVKTVd0MGhjYkxPd0dudWd0aWRId2lZUE56SGszUEhFT2s5K2VU?=
 =?utf-8?B?VjRhZDQrZGE1TWJGKzA5TDZ3VDMxQTVVTlVnc1NRSnVlQzVVRnhnQ1ZMbW96?=
 =?utf-8?B?M21jMys2KzVFYm9HRWppNjhBbGZIbFJyQ2psR1VNMGVab283dW94eTBNOHpk?=
 =?utf-8?B?UEJicVIxbis3NlIyeXRIUzAxSVdYOEJ5NTdLMjBHZzNRblZqVVlwOElEdGNl?=
 =?utf-8?B?QyswK1FQdG4wMkM4WXhuV0JHS3NiZUZObGRCTHJUU2txRy9OVFF5ZGxqcS94?=
 =?utf-8?B?eURnSHlnV0kvaG5yKzhoZlNoWXVoeG1xVmVDdVdZaEpuU2prOWdxNUFKZkpZ?=
 =?utf-8?B?VDIzc2ZQWVpDT1VWV3VCb0hxVGNFTXBqazMyUWphMklQR3Z0bDdOMmxuVnJR?=
 =?utf-8?B?ZFo0ZVpzdnl1R2Y4cjZuY1FxV2RWNHNWSTkyb25VOGZZYUQ1WW1DV05BNCtm?=
 =?utf-8?B?RmtuWk95dk9BN2hiK1I4Q2hlQmRpRGRSN2IwdmZETDN5RlJYbHB0TEF6YzNJ?=
 =?utf-8?B?eUtuVmJkeEtqbmlnU3d0Z2xKRzArekJpbG1Gc2ZEamtCdW9JYjFnZ01xNlhv?=
 =?utf-8?B?NDJDZStxOW9XVW00a0lPdTZqQVBmM2pYbGVRR2lpS0VXaWpXdWRnSmRpVnNW?=
 =?utf-8?B?S1BPVkZKY0FFN25LRnl3a2haZmJ5dkRURVd1WHFlY1BWVWhaWUFNb2w4OEdE?=
 =?utf-8?B?Si94NWZFVHN6bExKZFJRMU1OMUNUbkx6YlVwVkc4OTFjRFVYdXlvUDJnMFRa?=
 =?utf-8?B?M3duUzBWMzBWN0JNL1RwN3pvd1F4MGhxSTRRWTFubmlXSFdHdndiVU9iUnd3?=
 =?utf-8?B?c2NObEgwTmcrSE1KRHJROC9leGZ4cUcrOG9EMnFsSEVJZHZjMjlrSFBoWWh0?=
 =?utf-8?B?WklTMk04bm1XVy91TXR6QnIydWxmMFIyYjlXRTI0L3pwMXdEdWtkRTlTTDdD?=
 =?utf-8?B?R3RjendPbmhxbmxrR1lmUEtxM3JYdjNEN1dmRFE2REVxSGFCMWQrTTBWMzZi?=
 =?utf-8?B?RysyODZpelNtTEZHTkRWRXF6cWxNTGdPZ0FXVnNrUEFjNk81V2xBTVcwMm90?=
 =?utf-8?B?V1hwYkVtMjBvTTI4YmxOU3dBSk9jZWdDeUpjd1lHUEwrVUhmbUV3bUU2MFdK?=
 =?utf-8?B?d2tIMXV5eWxBejRnV3hqRVUwVStRNW40ZVhCRXlNbk9CaHdsajVhOHBPVWg0?=
 =?utf-8?B?RzJ3M0R3cXhnS2lMWTdLb09nTTdnQ3JhYU11YzZQMXNTVS95eFJoTndLQW4x?=
 =?utf-8?B?bGtQYzBTekNSUGRIR1JPVDV4b0ZGbXgwY3Yzc2M4UERRVVJoay9UVHNpY2lK?=
 =?utf-8?B?ejVzMjBzTlorejJFV0llT0NzU3Z4SEtNQStIOWRKMytDbVFtU2ZRYzZ6dVlj?=
 =?utf-8?B?UzVnei9KQkNVZU52V2NDRW9RcnF0eE5YdnRISUViN2cvU3ZNQk15V3NNU25k?=
 =?utf-8?B?MmN0VnhkV0xONGc5TTdWZFJRVTdGUlpwcTZWaG44K3JSUDFDQkh5NmFrSHh1?=
 =?utf-8?B?TktNbUVGK1pwZVZ4Z2dGalZKREl2T1dUUGRMNFh6YWVrZDhINnRxbklUMXdF?=
 =?utf-8?B?TFhMR2dVV0xGeFMrRGQ3Y3EyNkNtWk5uY1V0Yi9zT0FETmpRa3RXWFhPcmIr?=
 =?utf-8?B?QkQzTFV3Qlc4dFZBOGUybUNOK0lPbGJpeXVBeTkvWGIyT2Y0ZzVhY2E4WlVS?=
 =?utf-8?B?YU9YY05zWUdFb3JQZ0ZjdjZ4TVBYcDEzelpOSlBxUkdxY1dlR1lZWW92ZGFn?=
 =?utf-8?B?c1pLOFQ0SnB3TkQ5ay92Q2QxRXkxSmtjWm9EVkFzb2NpVk83M1FsK1RyenNH?=
 =?utf-8?Q?Wg7/O3uksQuF7OBAZvlkCz2qu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b0af89e-ef96-49a6-e58d-08daace5920f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 06:38:42.7474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XPBceiEI6R42gtpAUePezoi8Nq6UPjLeA8DpZ2j/oVf01bfkQEL8VdyY4n6HGIPmemeOLV0EKEHfrcon/WA9FA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5896
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/13/2022 3:40 AM, Mario Limonciello wrote:
> Some laptops have been reported to wake up from s2idle when plugging
> in the AC adapter or by closing the lid.  This is a surprising
> behavior that is further clarified by commit cb3e7d624c3ff ("PM:
> wakeup: Add extra debugging statement for multiple active IRQs").
>
> With that commit in place the following interaction can be seen
> when the lid is closed:
>
> [   28.946038] PM: suspend-to-idle
> [   28.946083] ACPI: EC: ACPI EC GPE status set
> [   28.946101] ACPI: PM: Rearming ACPI SCI for wakeup
> [   28.950152] Timekeeping suspended for 3.320 seconds
> [   28.950152] PM: Triggering wakeup from IRQ 9
> [   28.950152] ACPI: EC: ACPI EC GPE status set
> [   28.950152] ACPI: EC: ACPI EC GPE dispatched
> [   28.995057] ACPI: EC: ACPI EC work flushed
> [   28.995075] ACPI: PM: Rearming ACPI SCI for wakeup
> [   28.995131] PM: Triggering wakeup from IRQ 9
> [   28.995271] ACPI: EC: ACPI EC GPE status set
> [   28.995291] ACPI: EC: ACPI EC GPE dispatched
> [   29.098556] ACPI: EC: ACPI EC work flushed
> [   29.207020] ACPI: EC: ACPI EC work flushed
> [   29.207037] ACPI: PM: Rearming ACPI SCI for wakeup
> [   29.211095] Timekeeping suspended for 0.739 seconds
> [   29.211095] PM: Triggering wakeup from IRQ 9
> [   29.211079] PM: Triggering wakeup from IRQ 7
> [   29.211095] ACPI: PM: ACPI non-EC GPE wakeup
> [   29.211095] PM: resume from suspend-to-idle
>
> * IRQ9 on this laptop is used for the ACPI SCI.
> * IRQ7 on this laptop is used for the GPIO controller.
>
> What has occurred is when the lid was closed the EC woke up the
> SoC from it's deepest sleep state and the kernel's s2idle loop
> processed all EC events.  When it was finished processing EC events,
> it checked for any other reasons to wake (break the s2idle loop).
>
> The IRQ for the GPIO controller was active so the loop broke, and
> then this IRQ was processed.  This is not a kernel bug but it is
> certainly a surprising behavior, and to better debug it we should
> have a dynamic debugging message that we can enact to catch it.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/pinctrl/pinctrl-amd.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
> index 4691a33bc374f..8378b4115ec0d 100644
> --- a/drivers/pinctrl/pinctrl-amd.c
> +++ b/drivers/pinctrl/pinctrl-amd.c
> @@ -628,13 +628,16 @@ static bool do_amd_gpio_irq_handler(int irq, void *dev_id)
>  		/* Each status bit covers four pins */
>  		for (i = 0; i < 4; i++) {
>  			regval = readl(regs + i);
> -			/* caused wake on resume context for shared IRQ */
> -			if (irq < 0 && (regval & BIT(WAKE_STS_OFF))) {
> +
> +			if (regval & BIT(WAKE_STS_OFF) ||
> +			    regval & BIT(INTERRUPT_STS_OFF))

Above if can be simplified as "if (regval & PIN_IRQ_PENDING)"

with that change,

Acked-by:  Basavaraj Natikar <Basavaraj.Natikar@amd.com>


Thanks,
--
Basavaraj

>  				dev_dbg(&gpio_dev->pdev->dev,
> -					"Waking due to GPIO %d: 0x%x",
> +					"GPIO %d is active: 0x%x",
>  					irqnr + i, regval);
> +
> +			/* caused wake on resume context for shared IRQ */
> +			if (irq < 0 && (regval & BIT(WAKE_STS_OFF)))
>  				return true;
> -			}
>  
>  			if (!(regval & PIN_IRQ_PENDING) ||
>  			    !(regval & BIT(INTERRUPT_MASK_OFF)))

