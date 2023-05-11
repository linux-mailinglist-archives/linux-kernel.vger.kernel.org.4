Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E12F6FECEF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 09:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237544AbjEKHeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 03:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237532AbjEKHd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 03:33:56 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2061.outbound.protection.outlook.com [40.107.102.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C897A869F;
        Thu, 11 May 2023 00:33:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kQC85FsypQclvlMZL9zsgf/0Mev44oxBW/rnBYWIgKIVYvTyXlMzfzUnkdJbuoMEhmwj/kF3xK0XJ5RPivyoZzDrRYXfuPwwqQRwHtWKSd3pdJIq0jI8WaoI86pMIgCfPAsHPyCU3q8KDY032r6HZcE5R6KbyRt70uiL1corsiOYxemopHRDwM5YpTQBkJDkLxztTQBZQyAvxIa9gs7EC5Ii8gMg16r5qBzg9QG5o1o6Cmr1CXkfiKLVKBS5Jcdmbq3Nr5RW3YYvwDFujASW9ClULlUwusldMm11T0Y00Q0mhY42qAdF7/vMBA49mADhmPCnMtS6XAeRMQum0tu8RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GS2mb3Sq2RblIllbyYHGLHZ0f/Lu1fa37GzLAgtRV4=;
 b=YTsc7Ft3VcLpiax+hv+B+hgxpGfOYXIa9cSaDmMnRK1G2KcPLkqljldzx+CN/lYipMgbhYQCIWBxo8z2K7oHX3AaZiKjyCAtw239GXryJFEQ2VMO6/964sTdnEd9gIothYXMCWKZkUsj4KEG5YeskfDAh1EDk8hXdyZODs+Zi4UgX8OYdzvR1vfQ7U7pHdl5Ogu2HJO/XuBdPfE9OyA1hjZ3JZGr2YV10QgY/tyj9pjD9SfYUD6KRwQhCW/eNMaGL20scAKS5jpUoZFhgazpD4QxdlvgXuw7oGpRjgNhcGz1WPxSbOuvz6LDXijECsiWxpSJVL91IkLca/fFXKNi/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GS2mb3Sq2RblIllbyYHGLHZ0f/Lu1fa37GzLAgtRV4=;
 b=5Md4G9P9NumcZ86oQ0O/NythAyvDjDCnl4RsX/qPIMMouVh3LexOp4Aq0za95ypdCbLFV5mqQWIbCc5zAG+uG0QNNeAcVvDx6qZXCaUptLzsXlHRfTpgajdxZ9ulJTb0Uh5Lno6xcu7g2Hnhzzs7pODoeLetJE5Ln6YJEfZrpjo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by DS0PR12MB8296.namprd12.prod.outlook.com (2603:10b6:8:f7::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.33; Thu, 11 May 2023 07:32:57 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::20b9:d472:1981:cf94]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::20b9:d472:1981:cf94%4]) with mapi id 15.20.6363.032; Thu, 11 May 2023
 07:32:57 +0000
Message-ID: <ede45df2-2282-4331-f5b2-e9b6f49782c9@amd.com>
Date:   Thu, 11 May 2023 09:26:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 0/2] Add rs485 support to uartps driver
Content-Language: en-US
To:     "Guntupalli, Manikanta" <manikanta.guntupalli@amd.com>,
        "m.brock@vanmierlo.com" <m.brock@vanmierlo.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "git (AMD-Xilinx)" <git@amd.com>,
        "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
        "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>,
        "Goud, Srinivas" <srinivas.goud@amd.com>,
        "manion05gk@gmail.com" <manion05gk@gmail.com>
References: <1682512187-8828-1-git-send-email-manikanta.guntupalli@amd.com>
 <6b72c56e79a44fec348de26d14d9dce0@vanmierlo.com>
 <DM4PR12MB61098014775DE9950A0E2E588C779@DM4PR12MB6109.namprd12.prod.outlook.com>
From:   Michal Simek <michal.simek@amd.com>
In-Reply-To: <DM4PR12MB61098014775DE9950A0E2E588C779@DM4PR12MB6109.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0802CA0014.eurprd08.prod.outlook.com
 (2603:10a6:800:aa::24) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|DS0PR12MB8296:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ab8fef-a6e4-4442-d8f2-08db51f1f0ca
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jlGSjRBnuMtLnq55aCZRDuOgntKt12YvwikTRJAymq05wOw6zFEq8f0mD/Ap8Z89EmTYOTPOSU46wLVN8qyB+qEmm5ru6acegQWafIeHzTn/7Q3ToPxtSe255F9lxAYnX3LI0U5lUSC0QiIB9348OT5qGsnKWnj0cm0hmVyOwWEg/LauFMYIWqx8yv1TZeTN1Zpx/hezjnUaZcyaXjCSUCGA7pcmNAE1hqjbii6oKM5S7B2yE13XbZVDzLTvjo2vF9kQUOpTCOsRJ0GgeQ3PXijC0Fujy7KZ4QTC7/NrqUkRO35aEPJQZJ3ODhcaae3udGiXYQhiIbQpyuyso4sLIarPuv7c+hPAyI2FRHReh57hh7g98VTJZzuE9M9EH1oaVikHPjNTtJ+S4a4rvmJrwYS4gfoK05hdTfdDf1Atx0RkqZJZICHvoilk55hm20KYBX8tt01Jnqh0h3AOesBOkaACWcnJTlSRIo5XcIjHTjDZhVNQ5DwXtXyfTRNci6HyPSoDvVQyX3NNGQ6KRxMPpJ8OrzYjRlZItgc2F/LrXgSuyg7jZzSzP76JjdjxcziTiriI8TkY42mf+9QNkgn+38/AQNATySTJ2MFY5ZPULJ8vs0Ugwzp/KgEEjgjMzK5UHVeQwtsXiXs00GeiwIKOMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(366004)(39860400002)(451199021)(2906002)(86362001)(2616005)(83380400001)(186003)(4326008)(66556008)(66946007)(36756003)(66476007)(6506007)(53546011)(6512007)(31696002)(31686004)(26005)(41300700001)(7416002)(5660300002)(6486002)(38100700002)(44832011)(6666004)(54906003)(110136005)(316002)(8936002)(8676002)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YmR6OUI2Ymx4WitpbSs3eXhzU2p3OEl6L0lmdUpFU3VMUXBlS21wdDZiSUNr?=
 =?utf-8?B?cm9zUVlDb3h2c2t1U0R2eXIvaTRLQVVJMXV3S1JpTnpqVkR4V2lVcm0xM3VU?=
 =?utf-8?B?SUJJdFk4TXhDam9vcmp1VXQ1Z21nZHUvRTVmOHJNODV6Zmg4eHNxelBzOFh2?=
 =?utf-8?B?TEZVUEd2NGZIMDdzMU1ibHMvR0pLUlNscm1kUVNjQWJqdkJBMjZRQzJIa01G?=
 =?utf-8?B?T0RXU2RiR0VNb0pJcnJOdzlLRVMvUExEYUoxTlZ2anVtV2ovV0FKaXhzVkxs?=
 =?utf-8?B?b2MwRVk4QjZxY3JZcXI2NStkNHhhVWFnaHJ1a2kwb1RXOE9uY3h4aHVxaTIz?=
 =?utf-8?B?WTR3cGcwQUE3WWhUdy9NRHlWcHVyWHNSeHhWbjB1c3Q3MjFSVmVQTjR6OU14?=
 =?utf-8?B?TmFTdVRlRU5aY0kvNmg3c0txZERLZ05WMm9MWm4yeTh5ejdjdjFWWjkvbldC?=
 =?utf-8?B?Skkwa2ZBaUVXQ00wckNHV3RZbmZUYW0vRkFyanZ2YnFLSEFxclZocUlYd3Jm?=
 =?utf-8?B?TitoSG1HVXdReTdpS3NhREwveXVUZWVlZGFiTnZTWFhsS2dQbnBMUWJXdGZk?=
 =?utf-8?B?eHNWNUltM3Z6c2VNNjUxWitwWTYrVXQyaTYwTEw2QUVJTnVyL2ZPTTQxZ3Vk?=
 =?utf-8?B?ZkVFRndTWUxoT2UveGZnZWUyMUZsM3BYQWg1QTFoTklrdVZXQ2ZCZWV0WmUz?=
 =?utf-8?B?djMvVUhzdE43VWp4OGVvU3B0cy9mY1BkbXZpbjc2b1N6SHYzOUJBMWl3Ykll?=
 =?utf-8?B?VXVTaXEraU5BOFp5ckE5SmpVOHAyeXQ5MmI0ckhzWjBueS8va2I5M3ZXdU55?=
 =?utf-8?B?SHhuQlpCQ1NEbDRuek1iR2V3NlRVZndwUUpRaTEwY3kzV29NWUljWmhKRFFG?=
 =?utf-8?B?YWllM3V1bzRBMDB6WHhtcDQxSDdzNUQ4aGViTXVuNDVKR2R0UTJmOXRZaDc1?=
 =?utf-8?B?aFRKWUowMENVU2FuVFZKK2xETXgzaG00QkJTRWtISm5FRUUrVjZ5Sy8rM1k1?=
 =?utf-8?B?ZlZqZHVXZGp1QXZqU1REVEpvK0ZrYmdZTHFUTVRFS084eXBreGRsbEV3c3NZ?=
 =?utf-8?B?b294WWlSaGdPOGw5WGxrZ2h6c3lEZlVyY3lNOGcwUi9uZytGdWZwc0tVdHlH?=
 =?utf-8?B?L21uZzI0ZTFtYVNGT2xQYXV3WWMxcGEwVnJtZ1pvcDZKNUdPVXFCa2RCZi9m?=
 =?utf-8?B?Z3hnbzQ4Rno2WkJMWmE5dUliaE16N2VGOWZORWVzSGRVdGZCY3h6NDV2VWdj?=
 =?utf-8?B?YTVaWWZNZWJPQmtsTHI3V3MzM1hwVldOb2ZDMElSQkRuOTRxaEVxTzN6RXl1?=
 =?utf-8?B?a1paYjZCK1NJeVdMSUF5ZEQ4Z2tOQnJkSTN6WERCOUdGY0hpK040OVJQbEpJ?=
 =?utf-8?B?aWJiOVZaeWhHWkRuMm1Hd3lyaSsydWtPamFJc0V6a0c1bHdLM2RVcDVidkpN?=
 =?utf-8?B?bEtFbTVObU1iZEQ5RDloWGVhQXErUFoxYWpraEY5WXJ6aitZVCszYzYxYSs2?=
 =?utf-8?B?UExuQklMbVJub05DZ3Z6Y1JhcHVBeTVWUUNXY2FCVUhWTk9VUWdKcTliOTdD?=
 =?utf-8?B?cUZDUzRRYlhLY1FpQ1pmaHlCb3AyZHU4Tzd3aERlNEhNMzMwa0lxei94c1hu?=
 =?utf-8?B?ZUhoQjkwRkFTMzJ1ektXT2lrc00xaTNYVCtlcElBNTVIOXVSOEdxbVB3N0tr?=
 =?utf-8?B?Yk0ySndLbWErb2ZHaG9yamQxdkozR2RkZzR1N0RiMDZGWFEraUJYNTFzTnVL?=
 =?utf-8?B?dCtwSDdUMzBmNDVLZitvN1IvZmcveW5HVlQ2bkZ0YnRqeVhsd1ExV1d5UEp6?=
 =?utf-8?B?aWlmbVlFZnp6MGFuVk9nTkw0ZVY3QmpBS2V5U3UvVjhzRW81cXNlNmZDeXJG?=
 =?utf-8?B?Rjc5TStoaDBNQlpSc1J0YkdJUW1OV3NpL0JMZERPelVkckRFUHpEenZSRWpx?=
 =?utf-8?B?VTJYYysrSHkxSWJIQ2ZKeS9zQWpvQkNidFlIYng1dHFkNU1IWXU3cTExM3o1?=
 =?utf-8?B?ZWlWVzR1R09UYmVDYjFQT3FTTnYxdXBhUTJnSzZiWVdRSWdRMTd4RlVINUQr?=
 =?utf-8?B?eVJJN2d3Z1BTc2Y2dlJYcEJBcFFjSkZuM0g3TS9wSjNhUkNsa0JYM01ZYkty?=
 =?utf-8?Q?+zUxnAecWp1XNk8oEcLEf5IGS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ab8fef-a6e4-4442-d8f2-08db51f1f0ca
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 07:32:57.3534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EPxTwfxC/WLvUAJjDORQfIJ9KqjPtHhqqe43In3UbtmpPf5W1ml6IUSg60kPMWj/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8296
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/10/23 18:26, Guntupalli, Manikanta wrote:
> Hi Maarten,
> 
>> -----Original Message-----
>> From: m.brock@vanmierlo.com <m.brock@vanmierlo.com>
>> Sent: Thursday, May 4, 2023 5:52 PM
>> To: Guntupalli, Manikanta <manikanta.guntupalli@amd.com>
>> Cc: gregkh@linuxfoundation.org; robh+dt@kernel.org;
>> krzysztof.kozlowski+dt@linaro.org; michal.simek@xilinx.com; linux-
>> serial@vger.kernel.org; devicetree@vger.kernel.org; linux-
>> kernel@vger.kernel.org; jirislaby@kernel.org; linux-arm-
>> kernel@lists.infradead.org; Simek, Michal <michal.simek@amd.com>; git
>> (AMD-Xilinx) <git@amd.com>; Pandey, Radhey Shyam
>> <radhey.shyam.pandey@amd.com>; Datta, Shubhrajyoti
>> <shubhrajyoti.datta@amd.com>; Goud, Srinivas <srinivas.goud@amd.com>;
>> manion05gk@gmail.com
>> Subject: Re: [PATCH 0/2] Add rs485 support to uartps driver
>>
>> Manikanta Guntupalli wrote 2023-04-26 14:29:
>>> Add optional gpio property to uartps node to support rs485 Add rs485
>>> support to uartps driver
>>>
>>> Manikanta Guntupalli (2):
>>>    dt-bindings: Add optional gpio property to uartps node to support
>>>      rs485
>>>    tty: serial: uartps: Add rs485 support to uartps driver
>>>
>>>   .../devicetree/bindings/serial/cdns,uart.yaml |  5 +
>>>   drivers/tty/serial/xilinx_uartps.c            | 96 ++++++++++++++++++-
>>>   2 files changed, 100 insertions(+), 1 deletion(-)
>>
>> Why would you want to use a GPIO and not RTS for choosing the direction as
>> is more common in this case?
> In ZynqMp platform Cadence UART Controller RTS signal routed to external through the PL(Programmable Logic) design not through Multiplexed IO.

Just to extend this a little bit. Cadence IP has modem signals but they are not 
available over MIOs only over EMIO via PL logic. But board which this feature 
targets can't have connection to PL pins to be able to use any modem signal for 
this logic.

Thanks,
Michal

