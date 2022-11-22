Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E87463415A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 17:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbiKVQW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 11:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbiKVQWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:22:55 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2057.outbound.protection.outlook.com [40.107.249.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EF218B06;
        Tue, 22 Nov 2022 08:22:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcIiEx8a2JwFAnPPFgth4nD/IXZF0/CHUQ4gPJFJFz6b2wURRxGGcIi7nXjyOfaZG5akE6156y/ztp37uBRZb5KGeVZcseRzyqKmKomqXe3wnAFLCXddNjwGtP2y/0jrsWXS05MJs3ARrroolRvUAhYXmbPrK1HHkWBmEaT81SphI8Xns4Czr28Ipxvkfy4FLzfG2bl240LwwQ/gwVR8VmMNfu0gKB8YxTnCQC5juvF/ME5Vp3UeXv0RfcgB359KPQyXXZKybnUd2KqsHJrjrKdbrMR8Iq2Ecrktux57OF68rNNqU0sQ35g4IUfSGvjc5XgqTy/J4kMmJYr/3LinZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xn9kW3EbpxTGnSIL2SkV7ne2N9yYGaY2IazEngKVsc=;
 b=og5fd2MGswq7wcefPBuW2wrNW9CVCYrD8yaTqT+reYzPZwEAByOxw6+0rmpOY1jan+Bh7aAJOslIGF7wcwyngh7r60DqSSNTKvVvwb7UUpDulwefTTaNafczn60bGiExINusDg3NTVAGo48vBGt78GihmcGTDkNi4ugdxrqks27DUA5yAPovNgRM7ZkyJJEcT4G/MRC1mA0XDILgE66tjbde7AzZP3entB1xPuElxmAbAOgFkmGiffOfu8ioC5DdZx2Cxv8Z9kOZI0vYV5oafM8M+MUrW8xl7pP0LIIQKBUoZD8o77RtIF/ljFlsXQIVs1LxNMYOI/GEuH+VYTkqBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xn9kW3EbpxTGnSIL2SkV7ne2N9yYGaY2IazEngKVsc=;
 b=JrcJUWh5wqHTWzK7qlBIBFS5uK0OSWpj2pm9tayB8DfZDQjDvPQ/F+ZkRSFK7gxqRXUW5kyYjWYa0rZZBZfUnetR8jXSFVoXAb8FKBuQlj5b22f7CuwRqyv7ePriuhEbTtVUE6pshC39OSpJ4s53F8r9DTIg6fFdxkgnbuxRfco3Ds4P3SaevqmVtSD+Q0MPK7sTBRA2H16rkk9MmQo38my8XmWTfYic8puv3QvVHMDwN+TuR5qE+3Rs6iKj5ngYByWY5c2lW7+Nxlm/FHnJj0cVruMqS/Go15h0F9G0Ie9ENMNvsB2KIrNj/60z/PKD1lSf6l6IjUqUyru9lml6+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by VI1PR04MB7182.eurprd04.prod.outlook.com (2603:10a6:800:121::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Tue, 22 Nov
 2022 16:22:50 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::9584:94ee:73c6:bed4]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::9584:94ee:73c6:bed4%5]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 16:22:49 +0000
Message-ID: <84af9a9e-5d82-7420-e72c-4d984135f2d6@theobroma-systems.com>
Date:   Tue, 22 Nov 2022 17:22:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH RFC v2 5/7] arm64: dts: imx: fix touchscreen reset GPIO
 polarity
Content-Language: en-US
To:     Robin Murphy <robin.murphy@arm.com>,
        David Jander <david@protonic.nl>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Quentin Schulz <foss+kernel@0leil.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Samuel Holland <samuel@sholland.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org
References: <20221103-upstream-goodix-reset-v2-0-2c38fb03a300@theobroma-systems.com>
 <20221103-upstream-goodix-reset-v2-5-2c38fb03a300@theobroma-systems.com>
 <CAOMZO5BzWsHAy7KjZe+KEiXVq-Mfpggqjk0vswuzx7nkups3gA@mail.gmail.com>
 <20221122081851.6cb762d8@erd992>
 <907b9321-14dc-dc99-80fc-e1a20ee33a1e@theobroma-systems.com>
 <916a6953-d9b4-c257-c08b-f5277ead71af@arm.com>
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <916a6953-d9b4-c257-c08b-f5277ead71af@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::13) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|VI1PR04MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eb923b4-2cb6-4f45-03aa-08dacca5cb31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qZxJyOp0v4NF/p8r7kDBOSOUdEBkce5p+kGSiO+hwWfuT0hte8g4nEUTu8ntmi/qi7M0Erir+BPEqUhANiRAAnfGx5bK3ClF8aZlGHDTP00/lndecOCO/reWncaYHsIh4hFAJVU7SgrgVnHBrfTG9MgrIX1THp1BIvezNGgETgqgUv8n6UHQd+tI/66Ncxz3zVjFjliKSCIob6e1MCvBO2Np0p9s4zKrDG1Jx9jlj5VH9JCVZWyhZWe2vE962jaNKYtXPrgJ/FwNUCNvez1FR3F/jmjKjyeQVWHNZkWyFCwdT8k+n1TWhKlyoDuSggnJLJlnGGGLgwpIt4nLsTMl+dX2fApqt36rD2L/l2hlh5LGbiXgm+FzT4rSqdU68Z9uocP2C8ySxwuWmzNicOwfTsIaYIhesIO/OfktF5WURfINHv4S1F8DwE1gmi4f3Tmp6SosB6xDBfINS7V9ITqKdzIqJSKal0R9A8qNNEZoI00wrzM6VTMxF2U6tJ+FHrwccOxXhJfgTgABpJNiEmdUEBgmE8GG7skEuo+HLBJWLU3AzIQRiZMJhcucXMniILfE5h0qUQWV2CbsOgqptkSdBPACwfuWyUFGKTnngpCsijGvdPAFD3CQcI2cRpiSjLYU20KylRnxRiKfJZpTckcNYB/Wrq2H/hCWhmo4y6zv8RISpAc/shr+YpmtjFTo2K1qszlVEUnb33uWZ/pIFMdi742gcyxCrqtXIK2RE2VFCiJZ9eY7dXfpBMSE1WaEjiEI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(136003)(376002)(366004)(39840400004)(451199015)(31686004)(6486002)(86362001)(54906003)(53546011)(110136005)(26005)(6506007)(6666004)(478600001)(36756003)(31696002)(6512007)(38100700002)(2616005)(186003)(83380400001)(2906002)(966005)(41300700001)(316002)(8936002)(5660300002)(4001150100001)(7416002)(44832011)(66556008)(66476007)(4326008)(8676002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkQzOHpwdTdKSU5qUG1PdmtRS2hDNjhBS1RLbGZkZnhZYnVsVVd6M3pmUUFQ?=
 =?utf-8?B?a3FaL0xqbFJ3VHFOdTQwdThPNlJmK2l6VW5yaVNzSTRXWXE0Z1NweHo2clov?=
 =?utf-8?B?d3ZHQUw3N0owSDNpSi9aMTMzV2RXUWV6Qzdqcmp5cnRoeHZHS0JDZnlJZFFQ?=
 =?utf-8?B?cU42WnVud0FhcVZWZDVtcmVKRm5mckR3TUpVRlRGV2hJYlVqaDhyVEtsNEFS?=
 =?utf-8?B?Q2YxeXpMbVprN0NLMkZ6RnNVQk1CUFFCVjIzZ3pDMWU3TjV1SWh2MHlwWEFr?=
 =?utf-8?B?MzhmTnc3UmRpdi9UOTFYbDBRd0UxeE44eTUxZEw3d1BYay9nUnM3VEVVVWNE?=
 =?utf-8?B?YnU5V2xybTNhQmpaV1VJckRpSmZ3bW1OWGZ1ZWFGbWlrMDFOVnhpZ3I4aGli?=
 =?utf-8?B?U1lLSkV1RERneXYvVDQ4eTd5MFJsazk0aDRPZkY4RnkzTW1vdE5QNkNkNDVu?=
 =?utf-8?B?aG5hVTlWdW1GcW5vZVFLakRYYUZGdG40aTlEV0I4UnFiVzdhMjdVQTFDR1o1?=
 =?utf-8?B?TWsrTlhFdkZnS3EyeW12SE4xYksyZEp2OTlSckljVGxEbDA4YUhPNmpQSit1?=
 =?utf-8?B?UVN6V21PRUp5Z0dHNXAzS0RoNWpwVWZXWlNQeVZNbjJiZGVCNlpUK2ZhRnpU?=
 =?utf-8?B?eWpzcTdzUnJtQmlQR0QyRmNvaU05VG9SRFkxRHc3cnFtR2FxM0xwTktqdjhP?=
 =?utf-8?B?dXJoWUNkWnhibFB4bHRpMnNSQTRJYjQ2UUhxU2MrNmJmamlHR0pTZm5lSFJw?=
 =?utf-8?B?VU5Rclh6d2VNNGUrUGs0UVQyRlJ6bjlMUUlFVXBoVTJhTWpkMFdHa0c3Qmtv?=
 =?utf-8?B?MGRscXlpSDlxUG5sSG9JeStIckhTWGwwT2tCdHVNZ2JEaHR0RzMxbGgrSFhD?=
 =?utf-8?B?aDI0VXA0WGlBV2g4cjYzVmR4cEtIQytpcUNVTkxoVHpkdVM0TkNlT3NtWm0r?=
 =?utf-8?B?d2RoRGJDN3ZTYlErUDZQTXB0RCtjKzlWTU5KNGxaNlZkRjdueTh0R1c5UGU5?=
 =?utf-8?B?Sk1ScE0zT2ViWHo4NGRoV1RqSDdGbFc3OG9RT3QvbWp1cVJZSUhFcittdUtB?=
 =?utf-8?B?SWJaVWdzQXUzUmNsdUszSXVmbTE3K0d0Ty9ocUM4N1JIckdUSlkwL0lzcVVq?=
 =?utf-8?B?U2hxbVhmcEp1Uk1zZjZLN093MVlGMEhOa1UvZjR0R3dpUDg0QjQ2VWRVOEJz?=
 =?utf-8?B?K2RqN0pFbFA4Z1V1NlhmZnl1eE1MMDkrc2tUeWRObndsK3BRSVRDT0tqL0FO?=
 =?utf-8?B?UndaODhSMG1tUmZDWGlUcGNXaUtsQVI4NnZhbThmYk5VYVdzT2ZiUjlNMDRs?=
 =?utf-8?B?dVRSakJIMDROTUkzaHFqbG1mRjRHYWFZdm9YN1ZVbk9OQWVPRFAxbnE2aElo?=
 =?utf-8?B?cW5kc1U0ajdtYlR1UmxWTDNETmpvTDdpVTZXVVRLK2NVQjZaSUhlZ1VDdklR?=
 =?utf-8?B?bCtwNWJyYmV6RzVwYTZnNVBORzNORWovdzB6VS9McDBRMlhOWC9ocnZTd1ZU?=
 =?utf-8?B?RUl4WGJKQ2Jlc29TN0xaTHUwM3ZubU9lODBhQVdpb0N6cU5IQnN6REg3Q3Bv?=
 =?utf-8?B?cmVsSm13R2JyaFJ5UTdRRGhNMk9qUUh5M09TK05lT1hZM2hDVkMrcFN5ZnJm?=
 =?utf-8?B?aHpKMXFrSHRBWTVjOTlpV295UEZhdWJXem5NTDNCWGJyWElZVS9oT1BxNThj?=
 =?utf-8?B?U0lGbGlsYkQwUGdBQ0QyQlk4K0lYcTl2VkZuMjc5SER1ejZSWHpqM1VUUTAz?=
 =?utf-8?B?dENoZ2hhVWYrbG04UU0rM2s4d0NPQTdXazJudmc4aWVGeVRITGswaFJBZWcw?=
 =?utf-8?B?dTMrSXFWb2IxTzNwOGdaSVFWM0dWT0dCNUNmL0xFN1NRaTJJa2EzeEdIa1Vp?=
 =?utf-8?B?RXlXdXNwaG50cEQ3NWJ3Q3MvRHJQWk9lSXZyL05mUGdZTVl3b0ZZQi9xb0s1?=
 =?utf-8?B?S2U4WUZwZEhycUMzRXREM3dsdVJDbzBaejhGdGRiUitWTERHb3NDMitpT3cz?=
 =?utf-8?B?VU9uL0I2Zk5RZ2xBaE9KbzE0L2FFV3praFU0ZUZia0dsUXJXSDF5cE00Vmxu?=
 =?utf-8?B?Y3VIaDNhQ0EzNHVNZUN6dFJrOFVMVitpelpyME5QRHZybGxpOWtVM3ZvRWk3?=
 =?utf-8?B?R1N2Q3kxNUdMc3dZYk96ekRKczB3OGZrTHVWY3lZS21ZQmFyQUQxd1dqWXBL?=
 =?utf-8?Q?69ZDs0ZeqQEG3K0/xapM/8M=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb923b4-2cb6-4f45-03aa-08dacca5cb31
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 16:22:49.8095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I24sxmFUzR5uPUe5aNFCLJC3zBRdhBjQWX6Mwdx2wXh1QLbnQbM35w3FeGIkmUeSMSfjp31+KkXrlSJUYPmq95LLpVlsGqKfq/XR4q8LfB6Dxbjn8eCM2qJtfm7wWhq8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7182
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robin,

On 11/22/22 13:46, Robin Murphy wrote:
> On 2022-11-22 09:58, Quentin Schulz wrote:
>> Hi David,
>>
>> Thanks Fabio for the Cc.
>>
>> On 11/22/22 08:18, David Jander wrote:
>>> On Mon, 21 Nov 2022 15:18:32 -0300
>>> Fabio Estevam <festevam@gmail.com> wrote:
>>>
>>>> [Adding Angus and David]
>>>
>>> Thanks. This was apparently necessary ;-)
>>>
>>>> On Mon, Nov 21, 2022 at 3:12 PM Quentin Schulz 
>>>> <foss+kernel@0leil.net> wrote:
>>>>>
>>>>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>>>>
>>>>> The reset line is active low for the Goodix touchscreen controller so
>>>>> let's fix the polarity in the Device Tree node.
>>>>>
>>>>> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>>>> ---
>>>>>   arch/arm64/boot/dts/freescale/imx8mm-prt8mm.dts         | 2 +-
>>>>>   arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 2 +-
>>>>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-prt8mm.dts 
>>>>> b/arch/arm64/boot/dts/freescale/imx8mm-prt8mm.dts
>>>>> index 9fbbbb556c0b3..df7e5ae9698e1 100644
>>>>> --- a/arch/arm64/boot/dts/freescale/imx8mm-prt8mm.dts
>>>>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-prt8mm.dts
>>>>> @@ -107,7 +107,7 @@ touchscreeen@5d {
>>>>>                  interrupt-parent = <&gpio1>;
>>>>>                  interrupts = <8 IRQ_TYPE_NONE>;
>>>>>                  irq-gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
>>>>> -               reset-gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
>>>>> +               reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
>>>
>>> NACK!
>>>
>>> The PRT8MM has an inverter in the reset line. The reason for that is 
>>> that the
>>> reset line needs to be inactive when the driving side is unpowered.
>>> The DT was correct, this change will break it.
>>>
>>
>> The DT was correct. The implementation in the driver is changed (the 
>> polarity is swapped) in this patch series, therefore the DT isn't 
>> correct anymore, hence this patch.
> 
> I'm not sure it's quite that simple... FWIW I'm using an add-on LCD 
> module with a GT9271[1] (and I won't be the only one - Raspberry Pi and 
> other SBC users using DT overlays or custom-built DTBs are a whole other 
> can of worms here), where GPIO_ACTIVE_LOW is correctly specified per the 
> schematics, thus "wrong" for the current driver behaviour, yet it *is* 
> working OK as-is. I guess that's because /RSTB ends up driven low for 
> long enough between the current "deassertion" by 
> gpiod_direction_output(1) and gpiod_direction_input() allowing the 
> external pull-up to take it high again.
> 

Correct, that seems like it is the case for "current-wrong" GPIO level, 
provided you have a pull-up on the RESET line (as recommended in the 
datasheet).

c.f. 
https://github.com/hadess/gt9xx/blob/master/specifications/GT9271%20Datasheet.pdf

with the current driver, what I assume we should get is:
             ___________________
INT _______|                   |___________

     ____________           __________________
RST             |_________|

    ^
    L__ pull-up on RST so high by default
         ^
         L___ gpiod_direction_output(0) (deassert GPIO active-low, so high)
            ^
            L____ goodix_irq_direction_output
                 ^
                 L___ gpiod_direction_output(1) (assert GPIO active-low, 
so low)
                           ^
                           L____ gpiod_direction_input() (floating, 
pull-up on RST so high)

This works because of the pull-up on RST and that what matters is that 
the INT lane is configured 100µs before a rising edge on RST line (for 
at least 5ms). However, the init sequence is not properly followed and 
might get broken in the future since it is not something that we 
explicitly support.

With the proposed patch:
             ___________________
INT _______|                   |___________

     ____         __________________
RST     |_______|

    ^
    L__ pull-up on RST so high by default
         ^
         L___ gpiod_direction_output(1) (assert GPIO active-low, so low)
            ^
            L____ goodix_irq_direction_output
                 ^
                 L___ gpiod_direction_output(1) (deassert GPIO 
active-low, so high)
                           ^
                           L____ gpiod_direction_input() (floating, 
pull-up on RST so high)

This should work too and does not rely on some side effects/timings and 
should be future-proof.

As for OOT DTB/DTBO, nothing I can do unfortunately, that is correct.

The fact that we have both "interpretations" of the RESET GPIO level in 
Linux is worrying, albeit with OOT DTBs. A driver or subsystem rework 
might break boards in which case people should update their DTB as 
suggested here or we'll decide to support both interpretations, which 
ain't great either.

Cheers,
Quentin
