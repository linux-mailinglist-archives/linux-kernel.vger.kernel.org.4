Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFC46E37B5
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 13:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjDPLXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 07:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjDPLXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 07:23:21 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2081.outbound.protection.outlook.com [40.92.52.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4DC2D4D;
        Sun, 16 Apr 2023 04:23:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVL5vAQ8CRdkPYa+0n3xJoZbn48STyP/2e1MwViMuyMa1wu9ep2UL/sux7rY2sgV8wp8EhfrHlBqH75DJFoK8sKpfN2tECQzi3QlJNLW3mL/9UCqEXHiDa2cZypnnIoLdqvdu1q+eV/4i3ApeP42xGfBApby5vdZR8JZmu7K9UAO6SasnLG1OHq2W/TDV9xlRJZSmm7isvN9uHwOHUEX/FHg2JF0l4upTASmO/sRU6xUMX8NO7XeyYMQdp3idvvJqASSoFRDXhKacljCnwjnqay02qQGuYhxMOJloDGrTHxs4Rh1K+x+52apN0W02xU7l95Pjr68bph6WnSu326A8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGGJ0kDYbj3dgQYbyW5iiQrj0QGA3/aQ9gLo6IP1kec=;
 b=W8TaseCiPmnjlSjSC6aZxiwqtV1rAhA2NCFl7ydWHm6QISOVSflEyaXLzAxBJSzWBSGm9+A/2g7ktLmXM+Eh7wtFnzHmD+iMSmdsgtY88yPx/M4jgZTTbT7K3SKccp6iz8DvpoekTSZDXVRfzcPDEIRsd77aYTj8uWpnZEqEdb9mTbh+x0vCA65Cp3Umu0TgJNsbO47/Y6dE6EPHtuxAgf5ObItT7CKbMP0sWtkgmoZ8COr9oDD83k6BGzieQzdU8r0Xp9F+NlpkQuo57HzY/vfYduq2jXmxfgwbnvJ56AGHbwhg0Dc7m64eKp8920UjGCu7FEnI5WORuEGbgg7Gfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGGJ0kDYbj3dgQYbyW5iiQrj0QGA3/aQ9gLo6IP1kec=;
 b=PVKST2Zvwu/q2hOGsKWwxWZ+cke/ZRFny/vCslRecPwqZg9457pDkt7PMjXshBwf4QsXgHvxq5s+cLQtJUtOo6G8CnUct0KlRvaA1z2gEXs/j/LDrBzLp+/HKM9UkaA8faSktVjBkP6279tD4oVMlBgKY/HnbHlRPF7lelXLQiXRI/wxGaAcNbkL3zGzAtAr7pkAzJb57P/juNgjXHhgJMVoU/eNScvzLUCjqh98E9zYl/1P0fcR6tcAnIiZ7SEREEpbkaCf6Ln1GvMhzB7iyNng4Lq+U95hTea99PK0yIyOZyIbW+ZKyt9X9HwGtbwjjpPE2Ohw0HUmODdmEATdTg==
Received: from TYZPR04MB6321.apcprd04.prod.outlook.com (2603:1096:400:28a::14)
 by TYZPR04MB6103.apcprd04.prod.outlook.com (2603:1096:400:25a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Sun, 16 Apr
 2023 11:23:14 +0000
Received: from TYZPR04MB6321.apcprd04.prod.outlook.com
 ([fe80::4705:d219:7cf0:46f4]) by TYZPR04MB6321.apcprd04.prod.outlook.com
 ([fe80::4705:d219:7cf0:46f4%3]) with mapi id 15.20.6298.028; Sun, 16 Apr 2023
 11:23:14 +0000
Message-ID: <TYZPR04MB63219AB5419192530CD99C58969F9@TYZPR04MB6321.apcprd04.prod.outlook.com>
Date:   Sun, 16 Apr 2023 19:23:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC v4 4/4] dt-binding: mmc: histb-dw-mshc: Add
 Hi3798MV200 compatible string
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     tianshuliang <tianshuliang@hisilicon.com>,
        Jiancheng Xue <xuejiancheng@hisilicon.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        David Yang <mmyangfl@gmail.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230415-mmc-hi3798mv200-v4-0-44096e187f53@outlook.com>
 <20230415-mmc-hi3798mv200-v4-4-44096e187f53@outlook.com>
 <7cdf170f-1045-db73-df87-fd9da693da28@linaro.org>
From:   Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <7cdf170f-1045-db73-df87-fd9da693da28@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [zfjRa/9FudgfPc0cXhBHNmQLu0jumY6gWGfcUSBrU385F9Xy0aWtKD183cB9TnsR]
X-ClientProxiedBy: SJ0PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::6) To TYZPR04MB6321.apcprd04.prod.outlook.com
 (2603:1096:400:28a::14)
X-Microsoft-Original-Message-ID: <9796d087-d522-ffc7-198d-6b2c7c7fb1ef@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR04MB6321:EE_|TYZPR04MB6103:EE_
X-MS-Office365-Filtering-Correlation-Id: 72088f5b-0337-4684-eb3e-08db3e6cf838
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SZLheEtg1a5iNb215ZoAl8Pz6xIUeNYAp/8uisC+DGx0wzlP/frhT8COcE1m8e5+ijweYZlG9u6okM5z7sr5i5G1Ufo8ZO9Eqdu+qIbINx7IZLTiryNk9z17+6kpzzBbdsUYdAiu5hBk4VajwJefxO3vGMo5SehdhM7s2Rc16mgmQqiUsnOhRySe9h33f8/Ek9kbFW2o4SuQKWjCBml6ZDNZnImaCzU5eOFJBqDeNhZoFEwuo+y+V9Qf922uwaFnwA+/E56SjUcmNsboYHcIyFakU+RumWFydtfXAjDwY7cPDVstfOF7UnSlypfjGA9VwTqqORt2YLxzoD8TQijs1BKefn7c4Au7BHjt0ouOMM16pzOfiUAHNqBmq2BvTMdQLmjFTYS2xgcRwdxq0TRIbOPtrASPEZ95OMCj8PfAWwchRZfvY2FwpSlc4ZfFsSipXTqSvjn99bb75SBgMimJe6jnBfimgToVyP/BBS5LywGueCJFPeK375KHF5nAHMDKhIWD+maFVLdsTCn4S/Ko3qS3UQSPuM25MCes7n+oTcsPnZfhCKYXT/Xn9u6UshWjy3KVLA03S9xD3F7WBQwjj3F0zV3JFrcYenhqjY19zJOqUq/h+IvEcaVoZSFMPnUn
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0hvOXYzYTI5cytGMW0rQjRzUnZDckZzeXB0Qko2ek4xaVlEeXJyeGE4Nisw?=
 =?utf-8?B?T0FFU2dWbEJDa3RnbHRFaTlEaGFPQkZneGFkTnp0YnpCcytDYllBTGdBL2hj?=
 =?utf-8?B?MXlNSTRUV0hxOWxoSllkeHdPUXdzd1B0TGxZS053VlpDczRGSGhkYWtobG56?=
 =?utf-8?B?WjQranRmeXhrRlNPa0pZVTFOU1BYazlhMUpPZ2U4S1Rpd2ZOeU56QmdFUENK?=
 =?utf-8?B?V1lBK0RESlp0RmhmUnRMRC92OVNvYXk1bCtzaVBzOXlqMThzcVpEdzJlNEcx?=
 =?utf-8?B?dkYreWpjWWRQd0Y0MVJNaTUwTXZCdzdrVkMzL2Nsc1NaL1pKRktQbXJucTlv?=
 =?utf-8?B?Y2lteFBNMGV6K2FDUmJOSDYzdkdzdkpNSmZrVkJzLzZJeHd3TE0yYTRPSE5i?=
 =?utf-8?B?Y0JPQk04S3REQXN0Tk1qVGE4dzQrNFg1QmJManBkZVR1SjM5WHYyb3lvV3hG?=
 =?utf-8?B?KzJwaFNIeHlnQmtGNEYrN3ExODBPOVRzQVlHbldtS0xtV1ZVaTJseGJMUDZ3?=
 =?utf-8?B?TGRwM2xocERtUFQrbGdxbUJqVVBqZFQ3bVErbVJaOWpwSTNHZnlCR080NEtK?=
 =?utf-8?B?d0k2YTZ1OThkemRXNjU1cEtkL0NhOC9PYUxYd2NPR1ZuOGRYa3puUHVreXJp?=
 =?utf-8?B?V3YvVWQ4VE0rMXltS1ZWTFF4QmZ5T3VlSnNseXh4dEh3bmFkZDVQY0tRN1F3?=
 =?utf-8?B?di9SNjkyM09UWW1WNnhGRUxNc0dEcTh2WC9mWU1EMkZBQ0lyS1RMRDJyUGNI?=
 =?utf-8?B?NGg3Z1VrWUF1dCtDUWxuemhwUmdtUHAxTlpZTVdOQlc3YWJXandPTlc0MGF3?=
 =?utf-8?B?ZEVONkxQRnBldmk5OXhGd0ZwY2JBM1ppV2RGUHQ4NlgzcmhzbVlONFFLY0pE?=
 =?utf-8?B?b3RoRUlWbFNIc3QrUG5ma3Z4UEc1eG5pemZobzlWSGNFOHBkV1hMY0g0Q0FC?=
 =?utf-8?B?RGtJdzhxVXFUOEJQTkhiRWd0dy94MDUrV1RDR1JubVh0VUdHWnRmRkhtOFE2?=
 =?utf-8?B?VldNUHFyM2NSQTJVUFo0eGV4UEhJVC9FdnpNYmhzUlhsbUdhVWYvU3pOSmI2?=
 =?utf-8?B?Zm1uSjlZcXdHMkswVjQ3eTF3VXpOUUZwZkdCbDMyZWVOVVM2VktteTFxOHJC?=
 =?utf-8?B?enVmYnFCZDNRSTZsb2tpUjFJL3FBK2hzRmZIQzdrdzBIVXgwYy83bThwekZR?=
 =?utf-8?B?ZHNHc3VlNStVeFpLbzNvYVhmbGU5NmVlOGhsMjE0c0tNQ2ZKTjhLSFZHSEJs?=
 =?utf-8?B?ak5BN212QzBMY1FwWWRvbTdGM01ibnpETjlCcGYwWktNMUpKUWhGbk16eFpI?=
 =?utf-8?B?YjE3OFo4NW1vRUM1enlLYmE5bUpMRlltWkFlOVZTMlNOZTNuMC9yOWljaVhu?=
 =?utf-8?B?ZlNJejc3cUEvZHJHT3NDaU5XWVVJQnB0aHVsZWErOHc0SE5XZXdFTFM5dXgv?=
 =?utf-8?B?Nk1ZR3JVUjNHVEdEaUxmcWdENHpUMWdvWVpBb0Q0ZmNjOEtxYm5VUEMzZ1VW?=
 =?utf-8?B?RE10ei9ma2YvbjlZQ0NiVFRQQXZ1QXcrWGdrRldvZTF0Y0V0b1J0ZXhIQkcz?=
 =?utf-8?B?cVN5WFRSem9xQ1ZnakdCQzZNSEZ5ZGdRQWVUOU9FY05nZkQ3cXZ6QmZ6MVh5?=
 =?utf-8?B?N0tnRnJwczdISU1PSEo5WEJUT0pIQ21GY2JCYXRKTW44dngrTHFPZzFJQmNa?=
 =?utf-8?B?T243eUVHaTBWZjNTY1hJSmdKdWo5RDR2aVA3Z2pNNWtDWnJaRjIxQlB6K0Fy?=
 =?utf-8?Q?DpM+AT7PWzYlqwH7Uk=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72088f5b-0337-4684-eb3e-08db3e6cf838
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB6321.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2023 11:23:14.7302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB6103
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/16/2023 7:16 PM, Krzysztof Kozlowski wrote:
> On 16/04/2023 11:19, Yang Xiwen via B4 Relay wrote:
>> From: Yang Xiwen <forbidden405@outlook.com>
>>
>> Add Hi3798MV200 compatible string and an extra clock for it.
>>
>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>> ---
>>  .../bindings/mmc/hisilicon,histb-dw-mshc.yaml      | 26 +++++++++++++++++++++-
>>  1 file changed, 25 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/hisilicon,histb-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/hisilicon,histb-dw-mshc.yaml
>> index 301b6ad39c5af..2f8335fd2c965 100644
>> --- a/Documentation/devicetree/bindings/mmc/hisilicon,histb-dw-mshc.yaml
>> +++ b/Documentation/devicetree/bindings/mmc/hisilicon,histb-dw-mshc.yaml
>> @@ -19,6 +19,7 @@ properties:
>>    compatible:
>>      enum:
>>        - hisilicon,hi3798cv200-dw-mshc
>> +      - hisilicon,hi3798mv200-dw-mshc
>>  
>>    reg:
>>      maxItems: 1
>> @@ -27,14 +28,16 @@ properties:
>>      maxItems: 1
>>  
>>    clocks:
>> -    maxItems: 4
> 
> You miss now minItems. Are you sure you tested your bindings? This
> should fail.
> 
> Anyway, wait with sending new versions of patches to give other people
> chance to review. It's already second patchset today.
> 
> Best regards,
> Krzysztof
> 
Sorry for that. I'll fix that in v5 and send the new patchset a few days
later, waiting for others to review the driver.
-- 
Best regards,
Yang Xiwen

