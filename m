Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5022E6DA7F8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 05:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239196AbjDGD1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 23:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjDGD1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 23:27:44 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2113.outbound.protection.outlook.com [40.107.255.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF4393F4;
        Thu,  6 Apr 2023 20:26:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BCZ2DiaGPW3nzmlRW15R6pr26Jsq2UIeRG2YuoARp42avLIl9rlyhuALdno8GKt5Y33E661U1i2z7YrjWSLIuEstQ8Ux3y/DxZCfCLA6nIQaWddZKrzd3jl+Wco/VHGr6/5mABooHDYlODKni1ONfpRid73IlwHmBLLCzcd85uJkpfbD7s5ASTfKqBWgoyqcH6ikcvrYQbxhVQSxNcSfa5qbG1HZIP9p2LtBfpJnucZ0fln7DR7tiKj6piNvK+KvXMrcU5eQqRSc1JGk38PX7XxzljUp5Pcjd+iOAak4FO6s+A0x+5uavNNX0ExnA8frkXDyXTikxmVnSDPfMmMR/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2ehDwo83iYR3pSsuVU9FeoMW3DX8e6frBY8K27pOjQ=;
 b=Z+AERj1qkY8xwuQAw45klAeo2Ve/s6ci6DXUddhe4dHUTTxGA+wBKYJVs/uqoC1BiEK1SA3GTH4QaNgfXFlCfpEoT4q347ckiUOuxL/NFGhIGolFr79E57BAgXLXYDT7Rd+AP6hHb9rp9lwWnLq9+iIBSjZb6WX0drIRIta+ecKwyXF6F/Z7z3Pt+4R2C5qoNWEu9fsdAjAIvkp0sXMymTICQ9vB/3Ns+F+4zEWH89+b2FedsCoq/cdlZIxRNme0EVG79Q+QiwyRRXh+0F+Nv+ooA0WkQLKjBSFb5MzaSYm1qWtDbB4RPfJxlUKfPF/KYCz7rPBlk/vhVvnDuHQAYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SEZPR03MB7033.apcprd03.prod.outlook.com (2603:1096:101:e2::14)
 by TYZPR03MB6792.apcprd03.prod.outlook.com (2603:1096:400:202::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Fri, 7 Apr
 2023 03:26:54 +0000
Received: from SEZPR03MB7033.apcprd03.prod.outlook.com
 ([fe80::9d77:7adc:25da:b086]) by SEZPR03MB7033.apcprd03.prod.outlook.com
 ([fe80::9d77:7adc:25da:b086%3]) with mapi id 15.20.6254.035; Fri, 7 Apr 2023
 03:26:53 +0000
Message-ID: <d48aaa51-6a55-c103-c2b4-ec924326a10c@amlogic.com>
Date:   Fri, 7 Apr 2023 11:26:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH] dt-bindings: arm: amlogic: add C3 bindings
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20230406081627.4083103-1-kelvin.zhang@amlogic.com>
 <284f1538-dfe3-8d54-d20f-b47365283e74@linaro.org>
From:   Kelvin Zhang <kelvin.zhang@amlogic.com>
In-Reply-To: <284f1538-dfe3-8d54-d20f-b47365283e74@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0040.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::9)
 To SEZPR03MB7033.apcprd03.prod.outlook.com (2603:1096:101:e2::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR03MB7033:EE_|TYZPR03MB6792:EE_
X-MS-Office365-Filtering-Correlation-Id: 962d7f16-759f-449c-5bd0-08db3717eec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HLSzr7YhVR6qwwj5oHQB21zIOSyt6AdR7sOtCnprGUXxVGutYWN8gKB7rdXCAhERsM4KiHSIaAn5ZuyOsISHxKPSx1rQEvSbetkCRb0m00ihLNIhBIZkXAnyymGC7HWaa8mXWbHoMHxSNQXtv+yPAZkVUXDvzGBDU4cJ5RGYwngk4jpXTzQjeorGJucZKelT5jSFGMO6rlAn0xCoNisV4Bq9dXKqPQB0w5kPZZjICjVdx88CKimgGmJZBrqo34i9B/2juZqPVUTymncrxtx7Jm+zKACzuDExyozk101luSIZcjaLoPy5Yw2TjLLbvQAtE7DUkYYiLMnV46VLMLT7wPeoWaKyY0kSgDBlfb8dwRg6k8BJmQ+pledVlA7tbH3VZOCG4GQtViE+7LOVEWX1L0o+bHBdqk13zQmfFEmll4qknRj6ex7oT4cgt2aKQZECVFzUzn2n4KYThXrEaOsABWm3Ua9JNRFYaZC88x0/ywu4tZt2dhQJTe1UXF8OrP6thrsAcT8cAy7N4pPGFkSiBYNrGebwWDHBfsks2Dofg904RjQl/wMASc8cYRLVxFMIO7OXnukplbRr8ololDBKlJAgU5svOIk9uOJJ+hVpM4kiu7sjQEVv+2osIBqQm7XcumDJtT/jmy5hwFR4R40+Rg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7033.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(346002)(136003)(39850400004)(396003)(451199021)(31686004)(8676002)(316002)(66476007)(54906003)(966005)(66946007)(66556008)(6486002)(36756003)(44832011)(4326008)(6506007)(26005)(83380400001)(2616005)(186003)(6512007)(38100700002)(41300700001)(478600001)(6666004)(5660300002)(53546011)(86362001)(31696002)(2906002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFduMWVaSk9wc2JmYkl2MmtJQm1VYjdvbElaN09PZTZ3cW5TRGV3SnpQUGYy?=
 =?utf-8?B?c09qWHB2MmRFNG9oUHNSRVUzL1dWM3hqMm1jK2paM3Q1Z0FuVE96YngrUkxn?=
 =?utf-8?B?VTc4UFAwUFN4WWpKU0x3RjNjcWNWNHJuYmVDWGswY0x2ZndRQVM1Nm5mSTRt?=
 =?utf-8?B?cTFmaGkzS2NVeDBVWlcyV3VBN3BUd2hxK0FGUVI2UHUzRVdzS2RWYXF2ZFh4?=
 =?utf-8?B?OHByQ0ozbEdvdlFnK3BKTDlyN0ZpQ1FldFNoaENsWVIvNmlrQUtHejlyT0pu?=
 =?utf-8?B?cktjdi9CNi9CNFdlRjBqUkV2YzN5YTdyTzgwWklwcU96TnlUNDRCTnhLclRO?=
 =?utf-8?B?NXprbkJGMkhwSEtHNnQwZTd5c0NENm40ZzhpSS9ST3R1aUEveU5xMjhXWSsr?=
 =?utf-8?B?TVg2Y2k5VS9EV3RtS0poTi9XWUpvWlh3dVNnQWlTSnBLUUprWGRZem5sUUJP?=
 =?utf-8?B?WW5TMENnNnA3eG9GREh5dEdSR0xNbEs5RTBBQ3oyTmVUU1JUV1dnWnZ5ZEhE?=
 =?utf-8?B?c1lqb0ZaQ25pWXpaTGM1L1JKeGw3QzNVbHk2YzIxMGt3dVBZV2FVQmtCWjVR?=
 =?utf-8?B?aEwzVmJCYTNINTVLVVBmajJ0dHhkQjZPbVRQdzd3NjZsWGM4eitiVzA4VXBt?=
 =?utf-8?B?M3BJa0l4c04zTnFxNWhtZHNoN2JkRUxsL0h3WHFwMkMwck9qd2JXY25jSTV4?=
 =?utf-8?B?Um51b3lkVDBKcUVYLzVOcS9iNlZQSTIxNnBVUkI0RkJBMGxoTjdlVTdWZGVw?=
 =?utf-8?B?YlluTSs0bHVTT0dnbncrVHMreEtSRjJIQjhBVlcya0JBcENGK01tM0hNZk1q?=
 =?utf-8?B?b3kyeXR6MTJGeFZMcWtVdHlHTEQ5NlJrZ0xGVWNSVTc3U08za0w2VWNnMTJS?=
 =?utf-8?B?R0RjQzZRS0ZsMnNWeWhEcm8rcHkvcHAzZ2JGblhSMDBrNHpZTlIrbkZnMjNQ?=
 =?utf-8?B?Yk5rbE5HUG1MZUdJQ0J0ZW1RWWV1Q2ZlOVRxZVJSRzB0c29DSXVQQmFsWnl2?=
 =?utf-8?B?NmNQRXBwUXRPb09Id1dURjIyZGtzSzl1WjgxZ2FQN2dIWndsckdaRHpqeThq?=
 =?utf-8?B?VFBFUTQxcGtkSER6T3ZtREYxM0JrNmpZaU92VmVERk5nSUVFeUxPeHhCNkpS?=
 =?utf-8?B?VW9jMXFITEJKSDJIdy84eXM5MVF5eXlLMEFOY1UzazU1SEdVd3VFWjViWG13?=
 =?utf-8?B?ZGNISFRYUDN0Z1NqQ0tzYWJkZWk3T0dXWUE0Qk1nOE5LejFSZFlRQ3JxWTFF?=
 =?utf-8?B?OWlUclJNQTloYmQ4UzRxazRxU2IxYXBTazBxNXVmcnVlUUZaMXJYRDhKbFhr?=
 =?utf-8?B?UlFwdnJNKzlWZlhaM0FaUjV0VFpUeFIyNHdLY20vMm4wcUFIR3BLZFFhYk1V?=
 =?utf-8?B?VVlOYm56bi8xWmtwSytEQVBiY2RtVVNyTGVEV0R6WHkxNDdMRWp2L3c2QnM4?=
 =?utf-8?B?TExWN1VsT2FBWUUzTlNRVGV5VUdmV3dhZXNuNkdSWFlhQzV5Y3B1YkI5bWd3?=
 =?utf-8?B?UWdxcHBDMFVHWGtWbUF5UWdDZnhKSmRWcndUTXUrZlRkWTgyeFljaEt4UHdG?=
 =?utf-8?B?eVhWdDdiRkhIMDJDVm96SmVhWFNJcGhxd1lBN3N4ZDFuS3lUVC9uSnhqbVY1?=
 =?utf-8?B?SlpDQ21VNFowbUxuUVI0aEtFcnJoSDR4RzNiRDRHUzNsaFQ1b2JvazdnMVAx?=
 =?utf-8?B?a3pKNHphdFNLUmk2eHU5K3NDaUJiQ01zZFpMU0doWjU4ZjdiRWU1d0VGZERN?=
 =?utf-8?B?Ni9USERBM280OW9KWDlkZVpPZnUrTUxrYzk5bGFoY09WR1Avbjh2dGlFNSto?=
 =?utf-8?B?dE1MdFJCa2IrSkNPOVM0SVAzRlVhSTJNYi92Z3RRSHVIRmIreERHYkJLYXVI?=
 =?utf-8?B?aGtuY3diRTlJUHdVUzBLcnR3Rys3TFpGUzBENUZ0OXNhN2pHV001MUtXRmE1?=
 =?utf-8?B?cWlrOGNRRUFucW9hUlFSdnA4NjNUcTRzNFFXUWRrMVd4dlVWeEJIMWlZNGpV?=
 =?utf-8?B?WXRzelROVkJ1ZDgrZWlKeXJXNDdodXhNY1R3ODZmWUxzZ09HQVBkbGNGOXlN?=
 =?utf-8?B?MDhaZy9yQzVuK2NpaUF4VFpEN2ZwTlM5VjFxNjVLZTR0UDQ2V3pBa21BMDd0?=
 =?utf-8?B?NzRkazZoSExkZHE5WWMrOXU0MTIzZEMwM09JcmZROUQvN0QwZ2JLdVpOWHpz?=
 =?utf-8?B?OGc9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 962d7f16-759f-449c-5bd0-08db3717eec4
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7033.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2023 03:26:53.5689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H5dEQvGigJFSL2TkRJYblYIUBfzXBD1l9mAO5hTbhfR/zafkczvMY9gtjrcK7ChNfSvzoUYxxJIm97+lxRHcToYeG6zA9yL/WMBu1U6T9V8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6792
X-Spam-Status: No, score=-2.2 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/7 02:11, Krzysztof Kozlowski wrote:
> [ EXTERNAL EMAIL ]
>
> On 06/04/2023 10:16, Kelvin Zhang wrote:
>> Document the new C3 SoC/board device tree bindings.
>>
>> C3 is an advanced edge AI processor designed for smart IP camera
>> applications, which does not belong to Meson series.
>>
>> Therefore, modify the title field accordingly.
>>
>> Signed-off-by: Kelvin Zhang <kelvin.zhang@amlogic.com>
>> ---
>>   Documentation/devicetree/bindings/arm/amlogic.yaml | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
>> index 274ee0890312..ade730f35519 100644
>> --- a/Documentation/devicetree/bindings/arm/amlogic.yaml
>> +++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
>> @@ -4,7 +4,7 @@
>>   $id: http://devicetree.org/schemas/arm/amlogic.yaml#
>>   $schema: http://devicetree.org/meta-schemas/core.yaml#
>>   
>> -title: Amlogic MesonX
>> +title: Amlogic SoC based Platforms
>>   
>>   maintainers:
>>     - Kevin Hilman <khilman@baylibre.com>
>> @@ -211,6 +211,13 @@ properties:
>>                 - amlogic,aq222
>>             - const: amlogic,s4
>>   
>> +      - description: Boards with the Amlogic C3 C302X/C308L SoC
>> +        items:
>> +          - enum:
>> +              - amlogic,aw409
>> +              - amlogic,aw419
>> +          - const: amlogic,c3
> Try to keep some order, e.g. between a and s.
Sure. Thanks!
>
> Best regards,
> Krzysztof
>
