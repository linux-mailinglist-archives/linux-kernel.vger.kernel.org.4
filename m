Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3AF70F089
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239960AbjEXIVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbjEXIVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:21:40 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2120.outbound.protection.outlook.com [40.107.14.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88671AE;
        Wed, 24 May 2023 01:21:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8qCDPzNBfGsBO7464Ejf1XbZNEeLNlyMmT0YNOsKmyxhmExdklnEvEz2Z8hrT0pXzWZ6+yFsG/eQ6PcqsXxtCvz/zyVkF/wIIxN96soluQGkKI69vHC/gLwsS2H5p25QeMtzLNFxL+7E5FbeMa8wJRKFqbmsOjK1bcV4M2sZhkW5EwCDWJPCmbLJc/2xBqUZF7lxmRJ1AlP0aveSShR4dANN53EZvCz3sZEg4Zy/3dlwBRV0ZXkoou8h2SN2p7XbTjj7TjfZQBM2kIC4kMISTwadd/cu8FLlxbxaZX8q1NS9CVfOSSa5OQAZy86uroRw16ybrCAR5znF9wxhS7eiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDk6Ml4Z9C5K3gfjMKVtt1JcEwaaKZVOnVskGKaxZZ4=;
 b=QtANNrILqnaZMDdCnqQQlY7D0SWrLIr1xE6736G7bcYPEw4hwbR5C/jkwHCawf/34B7yQyVuThSXBPoU+cSias2h2btmQShp4XHwyJMfkhQ7W7cDE6hMrl8EQAB+h6xoeGNfqWPeyvDXb33p6Cw4kU0FJUolQzatwOuUUzUNB4MiAVRaL6exGT3CN8uAbgPxaJTC/rb6wxDZ3w1Nsy1fVOAAo2bRAdib3dQBXOvHYtBznNYH/TymDtAnt+i5Zu4Mi2XsrPKNuZpV34Of8GlXfaYENgBgTiQPzqFPaM4v2VOXy0JaKxD3SBS0gMQOwDAjza4kixZCNtDsw7b5TEuAFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gDk6Ml4Z9C5K3gfjMKVtt1JcEwaaKZVOnVskGKaxZZ4=;
 b=TTOdN2gbmCNa+tPaPqWur4dn7xwvkukKxkwTdhis5Ii19kcdJsPdiHGh3yIghR0cIJF1wXV8rPcAD3+hE7MLO/2MvdmP4MUfv3tNZr00XlHMOSuy6b+OW/PQDDVBGi4jlBTeMqf4McNqLIydsCbK++5ENbzpdg3zPrgFl7RDpks=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by DB9PR02MB6876.eurprd02.prod.outlook.com (2603:10a6:10:21a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 08:21:16 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::681f:7dcc:3f6c:3b36]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::681f:7dcc:3f6c:3b36%5]) with mapi id 15.20.6433.015; Wed, 24 May 2023
 08:21:16 +0000
Message-ID: <d6a7e322-8e60-d4b9-b83f-d364cc3ca133@axentia.se>
Date:   Wed, 24 May 2023 10:21:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] dt-bindings: ti-serdes-mux: Add defines for J784S4 SoC
Content-Language: sv-SE
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srk@ti.com
References: <20230310111630.743023-1-s-vadapalli@ti.com>
 <dec4dc37-7e4f-6fae-b288-e1433ba640e3@ti.com>
From:   Peter Rosin <peda@axentia.se>
In-Reply-To: <dec4dc37-7e4f-6fae-b288-e1433ba640e3@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0079.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::12) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB4436:EE_|DB9PR02MB6876:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cceb1ee-200a-41ed-afbd-08db5c2fd7c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ePRxAYdThMESWKQvdiC54QWKioEN5t+/xpnuK6nUai2RKryiQnDETEmwfwOqVOpozLhaP0wj+TQTRRTLFu/jIxNCXppXto8pqpJ72VE8AKEHIpGaa7DxDfinFWh5lVrXU+e++EoYAyRSQxax0LfVh5B5P//vNpITI3NDayTRR4yo8j8Nc7dFHmdDRcsU00TWIVR6ixDqBvX/il41sQW2Hp+/gN8M4M3JiwSypw0njcBb26XeDDzkAPICOPdW6s7+ltbweN6+sXRf1UKOCiW2iAXyNMCKKzWJ+/7Qs5sEcC+gjXKDhPpQdQCUPtTprZ6h8rZY93BIYX6rwWjSgpHkeVIhEC5T+yHzVEbp/N1RMGMJs38nYM+pxBGgQCAOx9XmuU50dGSWS6aY7UTMw7NnSOv0ON1y1grjLK39tOtYQgTU6JxhTdjxWgALU4UEwMTJ3tkiA5wOzwjT4dB1oyKmiahm9lDge/JbSUyVPMxGbSKinmCrKcrX0KsR26Y/njLSaiuY2OalcbcVyIIzfjLio36bT/usXFsCxEpeDC+q5Q9T4DZp1/bImolXImVP3pog2aweNS3GE8nLSXnuPNYByGWz1x0wMa8ts4qTmUNc4WaITGgmqVQQxpt8IH1smGJWR2UDgLtI9rB9RyDQMAJOzg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39840400004)(346002)(136003)(376002)(366004)(451199021)(5660300002)(8676002)(8936002)(186003)(2906002)(86362001)(36756003)(2616005)(38100700002)(31696002)(26005)(6512007)(53546011)(6506007)(316002)(66556008)(66476007)(66946007)(4326008)(6916009)(31686004)(478600001)(6486002)(41300700001)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkNpZ2VVeFo3Q0lJRUxJbWI2NHpGR1lJYXBJKzFRNXRSdDA1OGJHSjAvQjBL?=
 =?utf-8?B?NnRKYmRvTW9IQnY2b0o0aEp4WURyWGRoSHh4UlhvSnZyNkw5bHN4SWEyNzZ0?=
 =?utf-8?B?SVM3eEFCWUcwakQxZkVkMWE0TTgwb1dYNVA2Y0ZzQzZURzNFWXR2Mm8zU1Uy?=
 =?utf-8?B?cDRDL203SWtJc1lQUUhZS2VweDN3aW1Sb0xrNUp2Q09tZmdJMW9Md1FPd0dG?=
 =?utf-8?B?eGxFMHJVVHVnR0NQOGx0dVZ0c2YwcFpFS1R0dHhzNjYzQktvc3FUVWxscTFK?=
 =?utf-8?B?d2R3cGRSUWwrWU1kOUJlYVhaYkExVDVDYXVBVlE3cnZVTmpmQ2EzU2lKWU5l?=
 =?utf-8?B?UERiRlFzV0VpVXV4VC9vTTVCRmltZ2Zab1VDR2NBUDgvcW9vRlpTMWN1UWJM?=
 =?utf-8?B?SDRhTWQyVE01dU93ZXQrSFpYYlo5VWxPbGRxVmZqbjNuQ2pJbkJZUjdMTHN2?=
 =?utf-8?B?VUlZR1ROdWNnaGtJcU9CUG93U25TWW5HRFpMeFRBNVFwZFljUXRROTd3aExr?=
 =?utf-8?B?WU5GYXpRRmxrNFJaUnRmYWlOOU5ZTm1OeUtwQ2hlYlVHTlJvbnZoY3NENjRM?=
 =?utf-8?B?TVRqVE5uZEN4aXJwc1BUZlkxRUFxRmY2Z2o0MVdydDI2ankxMnJONW8rVEZz?=
 =?utf-8?B?bDR1YWp3OU82Zmpwci9XWk1tYWUzZ2kxT0VUOG1FbkhhSWJ2bitQSXJVdXRI?=
 =?utf-8?B?cG1CRERjeklyajdmd3BxaCtnODJ2c0RBbENmdlk3ZllzNTkxTmVsUmpPUGlK?=
 =?utf-8?B?enRXeFY4NXRrWWtXL3lrZHhRK1VZT3VYR2YxV2JWTzQ3OHhpQTk1WWxXM2pV?=
 =?utf-8?B?ODZPNm4xRkZJV25JZWVIVWZTbWZJS0l2WEUrbXJyYno1VkxqbGpkRmdJbmgv?=
 =?utf-8?B?dFNxRm15bXlrdzh2cXA3bS9mYW5TaFJKVnJ1UUtsMUJtOVRiRVNvRHhJOWd1?=
 =?utf-8?B?YWFwaXFJUXVwOHcyUG1JdGFZOE1HSVhlamI4dldaeHVWcnVjSi9HbkVHb2c0?=
 =?utf-8?B?S1lpdVcrOFZjSVc5OTg1R0VaWlJWR09Vd2pTcDhWTE41cjgzM2V2OGQ1NlMv?=
 =?utf-8?B?NDZkZkl3WVpZUVNVY3AwM2VHN2s3dXExQ3F5RDViNmFGdkdIbVNEWnE1U2w2?=
 =?utf-8?B?Unh4bnFDMTR3bGpUTEdsYzdtdXpVVGpkdGFEUXJBdmQzck9qdFE1UXh2bXVW?=
 =?utf-8?B?RG9Gclh0Y3ROMTExVEJrcUNaVlJISStjamJPQlg4dHhwNng1azVjdllJZ2c1?=
 =?utf-8?B?RWRkTzBRWWVjN05OcEdRb201T0EvRG5sVmo4QlBMUnlVcnBrekQyQlE0a0Ry?=
 =?utf-8?B?YnY5WHIyTlRZNXdkdSt4V1JMUGtjUTdPZ0tQcjh0MTZMck9hVXo5R0IrL1lB?=
 =?utf-8?B?Ylo3bkNMaHpCMFBvOXNSSmp2UWVPOVVLRE5YNlF5YTIramZtbXAwMUZRNEtI?=
 =?utf-8?B?bFIwVGVtYmF5Yms1K3RQSVFhQzZaOFBqUzZvZ3JNSFZjT1M5MWRKK2hTdzhx?=
 =?utf-8?B?MzRWUGRyQjM1Tmc3NHN3R1pONHJXUE1xczFpTjR5SHJLQi9zbWlDZ0VpVlI4?=
 =?utf-8?B?SHIvOS85NjYxZUVwMWpzQ3lNVThRSGFkMmx0aGV4dHRTOUt4ZVZwNE5ESWQv?=
 =?utf-8?B?V0JMQndmVVZXOU16aEQzR2ltWFNheFVmU1NwT0lZT1liT2I0dkV6dVc5bjJ4?=
 =?utf-8?B?dFJuQ3cwSkNobytjcC9sNnRYcGZjQ2VZRVAzOVJ6VUlFZVBNSE03ZThsTldN?=
 =?utf-8?B?S2hwcklmWUdQQzVXZU1xNzEvZjNpbGdHclQzN2ViUWZFVW04eS9jcGhWZGFm?=
 =?utf-8?B?MWtpRk9EQm0wV1JVS3pMYjJhR3pqUjlJbEF0NjZQSnFyMkpzQjZ3cG0yVVpH?=
 =?utf-8?B?TVhURzhMYU1wd3R2UjhsZmJSOVlYdUVuTTA1MTBhR1B6M3pRbk9VbU9IQlVZ?=
 =?utf-8?B?dkxIT0dIa0Z4K3c5MDU3TjRHc2lHUlFUbjYyQktsVWM0aVQ4UUdxZlhpTStV?=
 =?utf-8?B?VW56N2lpbmRkdUV6R1gzWG5URDM3cEZDU05IRDgrNEVVS3F3eWVHZndGaVh2?=
 =?utf-8?B?U01Pa2wvQnp3KzMzQ2lidXU3c1VLVUVqZmc1SDQrellrNGNkaWxXdlF5YkV5?=
 =?utf-8?Q?O6SL9PfczLsR1JNDdZDOPyF+P?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cceb1ee-200a-41ed-afbd-08db5c2fd7c8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 08:21:15.8560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bOiXo0fWN17BoA6TTlR1mePIOQMgS+szZGQa/HpR8IGrba6ZrIt1bv5F84fDH8Tu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6876
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

2023-05-16 at 06:40, Siddharth Vadapalli wrote:
> Peter,
> 
> Can this patch please be merged in case of no issues? It applies cleanly on
> linux-next tagged next-20230516.

Sorry for being slow, but this is now finally on its way to linux-next.

Cheers,
Peter

> On 10/03/23 16:46, Siddharth Vadapalli wrote:
>> From: Matt Ranostay <mranostay@ti.com>
>>
>> There are 4 lanes in the single instance of J784S4 SERDES. Each SERDES
>> lane mux can select up to 4 different IPs. Define all the possible
>> functions.
>>
>> Signed-off-by: Matt Ranostay <mranostay@ti.com>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>> ---
>>
>> Changes from v1:
>> 1. Collect Acked-by tag from Krzysztof Kozlowski.
>> 2. Rebase on to linux-next tagged: next-20230310.
>>
>> v1:
>> https://lore.kernel.org/r/20221015055024.191855-1-mranostay@ti.com/
>>
>>  include/dt-bindings/mux/ti-serdes.h | 62 +++++++++++++++++++++++++++++
>>  1 file changed, 62 insertions(+)
>>
>> diff --git a/include/dt-bindings/mux/ti-serdes.h b/include/dt-bindings/mux/ti-serdes.h
>> index d3116c52ab72..669ca2d6abce 100644
>> --- a/include/dt-bindings/mux/ti-serdes.h
>> +++ b/include/dt-bindings/mux/ti-serdes.h
>> @@ -117,4 +117,66 @@
>>  #define J721S2_SERDES0_LANE3_USB		0x2
>>  #define J721S2_SERDES0_LANE3_IP4_UNUSED		0x3
>>  
>> +/* J784S4 */
>> +
>> +#define J784S4_SERDES0_LANE0_IP1_UNUSED		0x0
>> +#define J784S4_SERDES0_LANE0_PCIE1_LANE0	0x1

...
