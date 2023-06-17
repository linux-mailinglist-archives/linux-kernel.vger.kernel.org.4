Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1B773413E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 15:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbjFQNe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 09:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjFQNeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 09:34:25 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2075.outbound.protection.outlook.com [40.107.22.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5119A1FD5;
        Sat, 17 Jun 2023 06:34:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/xZf/WhgWwwqw30QLEKcfbNAeRzXYmqU13jdUp7SsSxmFe1vm8mwAmvPhCPd3BHV4hIWr7CakuXwYbr5wjjVQgiCxMZs1jg1piFDFRCtKQuE1TIQx7pEdlaW6cPwuXWFuD3pU3Ws/MN0C8Vs3I+pW66NMvlOoinRZqIfK2kVdLNqEepufDwnXq1S6/QjW6K5YWihiXnk8Tp013aLx5o4ZrhFb6/ArmlRL57hVTcYdRVSHQt3aZ5Xh8kUSFC98v+Gl8+VvhL5ZWYCe9EZqso+LGw/iSAxP6UnEPumhQhPHCL2JPp1eMihp1UaFCjv9QrpFDzB7vJUfEV6hnrkoiXmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bx1ZzoLxl74affnA1lxTLQ2pA+Va1K3VlrLiH/AOFqY=;
 b=P6B1sUv5BVbHPU7xs3/aw+HQCF1KEhAyEVXiOXaaWw3slXuw9C+61hiWcHXZ/PS+HMn0Mz7ye0Zh5Enk4P8oQOD+/CMaxuGftdzX95LxolGMt/nLRPS6uBY09jl/veSXrR2LwDg5TTum7/OMMyWc1YvCd3gDTfWtxWnmpHy210LinxpqBBVTLFpugsniRDSMq9m6E8aRGyjyaLw4gv3HBCOL1C8DI6vGf9AWHVhB1IYdXY00WBMcgLg1QWVRV8Yc7qrT5hC9oaOL1IHmTKYciPyHAaIi2SG5xIaDKgabP6EWUWvFZhkuEAqmiMwea7w62b9SbRZexaGE7usmelKTZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bx1ZzoLxl74affnA1lxTLQ2pA+Va1K3VlrLiH/AOFqY=;
 b=TnU4A8G5b59qLKIGUgdzSFG9n8x4qRcs0RPiUcgMUy+AUXBtIP0GLRR4ZWNjsvKsQI12xCuoFk3AmXVZXPXuc0YP5E1HrKJE3mF/47AorFm+iuouPnYbURQDe+vEtviAI8/CnhlhuCsE9dMA1hwknzAXetDFsq9mzKLZtnOLZ48=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by DB9PR04MB8220.eurprd04.prod.outlook.com (2603:10a6:10:242::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.33; Sat, 17 Jun
 2023 13:34:20 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::5a4:421d:f180:9105]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::5a4:421d:f180:9105%6]) with mapi id 15.20.6500.031; Sat, 17 Jun 2023
 13:34:20 +0000
Message-ID: <5d2cb3e3-c957-4b70-f83c-ad9d8653925d@solid-run.com>
Date:   Sat, 17 Jun 2023 16:34:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 2/3] dt-bindings: arm: Add SolidRun LX2162A SoM & Clearfog
 Board
Content-Language: en-US
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Marek Vasut <marex@denx.de>,
        Fabio Estevam <festevam@denx.de>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
References: <20230616110610.32173-1-josua@solid-run.com>
 <20230616110610.32173-3-josua@solid-run.com>
 <a9098664-ac16-eddb-3e2d-78eb08ac973f@linaro.org>
 <5139b72e-cccb-43b3-ba37-35f0011e4a2b@solid-run.com>
 <20230616185728.7f0de1a3@aktux>
From:   Josua Mayer <josua@solid-run.com>
In-Reply-To: <20230616185728.7f0de1a3@aktux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0033.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::20) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|DB9PR04MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f2aed86-77e9-4560-a9df-08db6f378de5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1WSsx8hZhg2VcrqyfkeJjsvCL9r67+viR688a8uFlMY2POXis7fvhHG1QaGjYUJPltGQzuNksWqfEzZIVUiJTVf4uh5l1wwxy/fU/pzOMwrEpDbrgML4XWZrvwsPYP15+G6s0e9gQa/QY40XubySHOH10s3EeeEI8A2xb7lGoISxe/d6rIcaD1zVd0BlJJT6DdLJbWmiw2KiOxoiseYOtYY4Ac+3kTaERYPGkoDpcbIzBxonX6DRGji0ZD7iGD8ZTd1239FecsWMWzsojoEz7PnUMMvkG5yD2Lpiljc1zXlRNP4pi+9vRX/AWBh4D4ArwlIkPjQGAG2e6e3azgQTE7XQ7X5jExDhDfUXjGXqc1GulY0bd2VkupCzxGohPmBlu9jRF3BUGnTE4hvH/2zWElvY2zzOjOs6YJGiZ2NWfvZtusxe7aU9B39Jhtfy3BJpY3t/c+nIUbdJpjS4cL4g+zKXyAKrTERkl8a9cJ+LlDVrz0cMo8cx8TOZfOYuZRnYceueLz4JLlLhulC3JMkcziBAatGQ9ew0xUulO+7d3mvV83hwj+kBVR9CBhvgLlrX9YEnUM/QQmcuvZs3QISyk/J0TVKjbsnqCinQXovvVlL6ozEQ018IVY5mXaop5dgjGMit49qgkI5hgxjuFew2Ow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39830400003)(396003)(366004)(346002)(451199021)(38100700002)(6486002)(53546011)(6506007)(26005)(186003)(2616005)(6512007)(7416002)(5660300002)(8936002)(8676002)(41300700001)(2906002)(4326008)(36756003)(6666004)(478600001)(66556008)(66476007)(6916009)(66946007)(316002)(54906003)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmhyMzlTbk1NUHk3Um52ZTdvc3cvaU1FZVQrQXFhcFRIdDIrS1VHR29vS05s?=
 =?utf-8?B?S1BpaERqS1IwbUY3NVl3YUJnUDlzWVo5THZqVGdCN1dpTjBEQ3cyUUtabEll?=
 =?utf-8?B?TUhsaDE1cXlraC9nc2ZxZFBxbmVDT3lvdEY0VWJPQllCSndzdFlyUHR4T0dl?=
 =?utf-8?B?WURxRWZNdnhUbkF3RXJxYytxeTR3aEx0NHR4RkNBblh5V0VPNVlhZjZJclBn?=
 =?utf-8?B?bkJIc3poRUNrb0s2SzVZT29RUGpNUThNWDNISzhsVDc1a3ZLUkFLSnZ4V3NU?=
 =?utf-8?B?ZW0wbUwxQjY3OGh2UjdoZmorRFlOQWUxL1Jyc2lUMStEYWg2SjIzQWlSYjhh?=
 =?utf-8?B?UG9LVGRsWlo3aXlqQ2JtbFpDZ0xENVYwM3lZbEZVVEszTXBRQXBwaVNSNzFr?=
 =?utf-8?B?T3FQamxNL2M2NEcvMmtYYm5TODQ5Vnc3V0lrc1doenE0VGdHVFlJNEtJZnlE?=
 =?utf-8?B?NGFqaE5kUHNXVlZFeTRNYlNjUUZZVUhSMTg2NVpnOGZBTk5jY3FQbTlrNzUy?=
 =?utf-8?B?dGxCZ29QTXlOSnE2VFNyaEQvYXlWTm9LTDF4c29KZXlHd1R3THZlREp2eHo2?=
 =?utf-8?B?Yit5VkdzcmRwVzJrbmJ3NUdXRDlLakNmRXJJdnFoQTBucTN6ZnU3VlNSY1Bt?=
 =?utf-8?B?N1RiS2ZzdTE4QjZHWm5HK2FqdXZNTW8vU21nL0kxNm42RVV0UC9LbDhxQlhi?=
 =?utf-8?B?cmtDRjdiaXlheFdZUWdKK2xvczNTeHVVSVZha1g4dnQ3dHJVbVJhOUFNejVu?=
 =?utf-8?B?R2xOZUJFMjhyOUVRNEFyRkN6dTRJNFdCdElyNDhubmdGY2hwQTNQZUpMbkp3?=
 =?utf-8?B?TGFZc2Z5WVUwV3NYTmhMNy82OTcvU3B1R1R2L3BocjU1V0hrcTUrTUREWHFi?=
 =?utf-8?B?RHZpS0Fra2ZrTVZ4eW0wWlBqaVNUMmppNVhuczE0VktrUzVjRHhld2J4a2Vp?=
 =?utf-8?B?cTdMZDNIL2xYa1hvL3VMY1dkVlJvcDlWSmFZZjB2VlZSV2drMUV0OTFOaUQr?=
 =?utf-8?B?UlcvZEdUbGVhNlRTY0xTYTZHanltQXpITThJTU5MZm9vZXhRbWNoR3B4ZEs0?=
 =?utf-8?B?SDQ1RHZicU93aytKbmxjdkIvQUZPbHRXakxONFVOUi9ML0UwSEZ0eTArcWR0?=
 =?utf-8?B?cXQvT2N0Z3FXUFREWlJKbzlOYk9YTUZyK2l0VjZTZVkxdHVmNTREaml3WXh0?=
 =?utf-8?B?NkY0ZDgzd1BQUnpxcUpUTFZrR3d0ZWllaXJSeEQrMmE5SUs3WmtvN2dKZjNP?=
 =?utf-8?B?d084MHVjaHNmUW1IUGtqUjNuU1VNUTZVTzY5SjNUTlBBVmFaSE5MdXB6cC9a?=
 =?utf-8?B?SlZFUWFwM05oYm9MUDV6SVhhQ3ZyUmcwamQwcmZaT3lLY3g2NWNaMXFJck9E?=
 =?utf-8?B?NE9aRVhMRmcwSHZLSXV0QmZmMUovRU9SelM3aVRCdkphek12NkNGMjFiMGUy?=
 =?utf-8?B?QU1nT0cvSHlYaXVaVnlvajlCL2s2SWxRQnlHQjVuTEgwdHlNcVY2QUgybUg4?=
 =?utf-8?B?NlFFNFkyYzhiRk16QXRzc1BMQ2o1bHNIL2pobFZhQnd2QUJwb00rN3hsOEVs?=
 =?utf-8?B?M210RFplR0l3YStQRE0vSHhVVk5HZTJCanc3c2RmNHNqLzJiVkJrQTd6ZXFo?=
 =?utf-8?B?ckJPcHpENGNpSm00Mk01M08xN1BQNnFDS1lGaDlkRnRHa2VQaWZQV2drQk1C?=
 =?utf-8?B?aVVZSVZPOHd6eTJhTFhGdjQySzBkcFhwanB4MWlKOGVlNmhldzA0b0VRMmZG?=
 =?utf-8?B?cEl4Rld6Vkhhd2dDMlJWL3VsMy94TEdNQWJwM1cvZlJpVlZId3QwMThwM3Rq?=
 =?utf-8?B?ZFYvVUNrM3RyQ1QwTzMyYy9wZjJpOWF4ZXE5YVVQS1R6Y0R4MGlSZ2NkVGxF?=
 =?utf-8?B?WjBjNmYxT2JKNFljUC9VYmY4MVdxZW5xR0ViV2l2TS9TM3hlRHJmeGdPUGpl?=
 =?utf-8?B?T2JKWThDK2tVakJJZzhuQ1NVUStoSVdvOS9uRXYwZlY0TTNENmhSdXRCSnBR?=
 =?utf-8?B?YmFFOFBkMnR3VWxydjJEQlRLT2dHOUJDdUxpNDNMWitWS0JTakEvbHFkSWVU?=
 =?utf-8?B?RUlZZ3pmK01YK0dtRlpOeFl6Z0gwNzJveGtUNG50VkNTZ0JhelB2aUQ0cjZl?=
 =?utf-8?Q?IfmTj0/B0M880CGhgRG0oP6JJ?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f2aed86-77e9-4560-a9df-08db6f378de5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2023 13:34:19.9223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JkFjDw2QT6L/Tf1utOXd49IHmwtKgQ4P/6JyDfu16PBiXkTGPwV5xvFRJgh5qaEf18f03on8C6In1yGU/PfUCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8220
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

Am 16.06.23 um 19:57 schrieb Andreas Kemnade:
> On Fri, 16 Jun 2023 16:32:01 +0300
> Josua Mayer <josua@solid-run.com> wrote:
>
>> HI Krzysztof,
>>
>> Am 16.06.23 um 14:36 schrieb Krzysztof Kozlowski:
>>> On 16/06/2023 13:06, Josua Mayer wrote:
>>>> Add DT compatible for SolidRun LX2162A SoM and Clearfog board.
>>>>
>>>> Signed-off-by: Josua Mayer <josua@solid-run.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
>>>>    1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
>>>> index 15d411084065..438a4ece8157 100644
>>>> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
>>>> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
>>>> @@ -1373,9 +1373,11 @@ properties:
>>>>          - description: SolidRun LX2160A based Boards
>>>>            items:
>>>>              - enum:
>>>> +              - solidrun,clearfog
>>>>                  - solidrun,clearfog-cx
>>>>                  - solidrun,honeycomb
>>>>              - const: solidrun,lx2160a-cex7
>>>> +          - const: solidrun,lx2162a-som
>>>>              - const: fsl,lx2160a
>>> You change existing entries, breaking boards and changing the meaning,
>>> without any explanation in commit msg. That's not how it is done. Please
>>> provide rationale in commit msg.
>> I'm sorry. Given your comment I think I did not understand how these
>> entries are supposed to work.
>> So perhaps you can provide some guidance based on my explanation?:
>>
> it breaks:
> arm64/boot/dts/freescale/fsl-lx2160a-clearfog-cx.dts
> compatible = "solidrun,clearfog-cx",
>                  "solidrun,lx2160a-cex7", "fsl,lx2160a";
>
> now you would require:
> compatible = "solidrun,clearfog-cx",
>                  "solidrun,lx2160a-cex7", "solidrun,lx2162a-som", "fsl,lx2160a"
I see, thanks!
The more I look at it, the more logical this behaviour seems.
> which is probably not what you want.

Yep. I wanted to keep the 3 components, and allow forking in the middle:

"solidrun,<board>", "solidrun,<module>", "fsl,lx2160a"

This however creates many combinations that are undesirable.
Existing boards using com express don't suddenly become compatible with 
the new SoM.
Therefore I prepared a different approach vor v2 now.

> Regards,
> Andreas
- Josua Mayer
