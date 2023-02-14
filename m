Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AFFD696297
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 12:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjBNLlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 06:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjBNLlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 06:41:12 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2079.outbound.protection.outlook.com [40.107.6.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25EEF2331E;
        Tue, 14 Feb 2023 03:41:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OlWEoiN8HSqjiKZJBk/WJ13PgqHG9mDD8S4/WAbdNw8DWXL7DL7Eb0BuuCl08+ECXSmq1G194zKYI4elsOvpRx+QHDsQDvJn2QtYV/8VcohfVtSK3HhYuo5IrIK8YxxnSTISE5xaF7jL6oYXjLYFXZ2EdMa+UndSI/azbouW0AOT4waX5AOllhOFDRInqPHiFCraGGhNQXGgcqZEO07MwAxX5+cFeBqW80Cky1voJ1wKyDJakguzJ1woYefzIHRqGEPOOj5JXQBvs/R8M5MrIYodei16V7pN8wKE+j2OWirxmROkFaU9r+YRjGFrYfIqDQYP2vTQzesAWNAlbencWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O6ypz0MG2PlnSQO2TZD+vzxDpfUmJ3FyUH+GSiHlxvQ=;
 b=DOfR0eKiJhir4MfdE9YpVsHuWAU+0eS0BMJPBUkIdlMRsQpQPWulStK8d97xH2nwEMZaFt0ccHdOnyK/oS0qF8CWbs2ZHDZizcrViLZjwtao7rXYly3HJxeydwMNMtoAVA5gSJ3i8B1whcgUOVBDeFPMi5eNOSr1CYtXY/ImOnPqvQOPsvCCam9DldznadzMTTZPf3/63KF6BQZbv7koCRfSGJvsuREhqCDadLqIpgtlOSUWIQBOwKrsnyw/X+Q7h9zjkwKIvWzuBr9j+EN4fSi43gDzrtBzNgeL0uboyGZXEtRv1fNYUcWyGgpK3pKwPHPF6X52iep7gb/IuT480A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O6ypz0MG2PlnSQO2TZD+vzxDpfUmJ3FyUH+GSiHlxvQ=;
 b=PWu+LM6gGskHYaV72Fy7Oha9szRkfuFv2XQQYVrV+Fa0F4hIspa8ESvKF+vDKQBDvs4gosfOdlu4nzgbqa56l9DUTrZIp1PHG3gISgsjai7+Rg2iKjJ8qe0h/M4VfGOMWXHoQ2PE1pL55MM9b5HDuI+cB0KQghOV1DAHYWm5wjc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AM7PR08MB5336.eurprd08.prod.outlook.com (2603:10a6:20b:105::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 11:41:05 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::93ad:a231:e2ea:d1b1]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::93ad:a231:e2ea:d1b1%5]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 11:41:03 +0000
Message-ID: <1145ccf7-ffe0-533e-45ef-5576a54e4531@wolfvision.net>
Date:   Tue, 14 Feb 2023 12:41:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] dt-bindings: rtc: nxp,pcf8563: add
 quartz-load-femtofarads for pcf85263 and pcf85363
Content-Language: de-DE, en-GB
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>
References: <20230213095018.2255225-1-javier.carrasco@wolfvision.net>
 <12dc51e4-622e-4a26-8bde-2795d77ce36e.e0c24246-04d4-485f-8d5f-1cc8fbefd095.f8cc75cd-465e-4339-8415-7d994963b841@emailsignatures365.codetwo.com>
 <20230213095018.2255225-3-javier.carrasco@wolfvision.net>
 <Y+pur70KB7wWRCCi@mail.local>
From:   Javier Carrasco Cruz <javier.carrasco@wolfvision.net>
In-Reply-To: <Y+pur70KB7wWRCCi@mail.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0043.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::32) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AM7PR08MB5336:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e406016-bd17-4f0c-689c-08db0e8059e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rVU553rcYXYoH2Tt0kJejcKL4r9Z1xu/yt5IeqinAfPrnHmWQhMIK33xNeCBjZIRcwhSRp3I1j5hzNrYBt6ubPgLxQDxx8X+4kTonFj94f9RML/1cvVmeYgjLJtECraixztwVvG1ImycWkwY9dPEMqTbe9fGkJC1mCn/dHiiAldfMipKIQh5jt1KzAu95A6aQ1uuyAZYwd1Cerg8UoMVRVefmWS+cjrxm6UMeqqvTp+NUlCTEjdX6kG4bBsxfzvzB3l73hH2HNS25NOwg4lEAUFbmXyzNItuqwEyMkhfUSYIE6YBXSywjgnhP/7e2fq4fViHUetWrTnPZogRK/Yf2zL/xCmRuW33/dULSYnmUkhKgRhYfXT0dPOaxqmt3QMBryPJlSou7Dqshl3/t7s39spMyuz7z5agnm/p3Ue6ifvKQ9XfBUumxj038SveJc/cfA0w39bmEEQHVbYZobfdXB12h8i8n4j83+q2quS0S1qXG2ERolJZcPMX7Mm1YNm1+sbr5uWhFZMho9qq/8SA342dcXbofOQ4bG9oLGkICwr4+u8FfBe4HhRsr1EJNZDTtV/4Jv445XjQpNdl5BxnVRL8J8voPtEqqdfUGTqoqW/apbFdRPyznTtmSsRtYGsHPgqf830wi0JUCKx6y3Mb9ynQNWKpd8lkWT3MQuqmhp9asFd8uMNbIuWMf6DlcchpWTPY7Iap70+JQB6t0oi6gZYbG6f5WmObsA7KRTCY564=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(39840400004)(396003)(136003)(366004)(451199018)(31696002)(86362001)(36756003)(38100700002)(6916009)(8936002)(41300700001)(316002)(66476007)(66556008)(5660300002)(66946007)(4326008)(8676002)(2906002)(2616005)(54906003)(83380400001)(6486002)(6512007)(478600001)(6506007)(186003)(26005)(107886003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWdwSmdEQjZReUplOVIyRFhqc2lUN0ozV3ZobVVPQktwODR1azlQeEpSTCtY?=
 =?utf-8?B?Y2QxUWlVWFVCUi9ZU3VwdWtEYmxweGFqZERaVUJtNXZ1Y00wWXdLWnQ5SHlN?=
 =?utf-8?B?QTdYUGRkQ3NYS2ptc3k0ck1Ub1hiQkQxYnc2RFhwM0ljUElUWFVtVGlDUHkz?=
 =?utf-8?B?Nmd2THFpeVFEQ1BuT2czY25RSHdENFk5dWRta3lGNWEzeFRERUk3NUpocm1k?=
 =?utf-8?B?aGptYlF2cG95Q0QxMk1kbTMzMTNLR2FKTkhjdlFCTFZIMG1YcXpzODA5RHVN?=
 =?utf-8?B?Z2pGY0o0VHhlTFJEbVNzV0hsSmV6M3lLT0EyaWxTS09McG9hWHUvUXZHNkZD?=
 =?utf-8?B?RWFtNkpjZmY0M25HMDVVU1dkUmIzaTdQL29ORkhaK1VKNjI3ZytPdm5oRk9Q?=
 =?utf-8?B?eFpHSFI0WnloT045YUdzamZxdDBORTIvUGNYOTFKRXdUSlcvSVVsb05GZG15?=
 =?utf-8?B?OGxPMitRNUZFM0w5OWFlZlJTcUcvekk4QXhINXJ0Y2YwSmoxbDg1c05EbTFV?=
 =?utf-8?B?UjdFV05GRWdENEVlRlpDdnFRd2hNYlRCL1dDMzdvemJZSisvakVBR1EyMlhL?=
 =?utf-8?B?R3RDYWdES01QbHdEYWg0OXQ5TzlVUmtvVG44YkNIb2RWRzhYMjFLNjN3Tk9x?=
 =?utf-8?B?bHpNUGxZSzZsYmdESXhjVWxDOUNEd05GaGtoc2tpZFM3YzBtOXVlc0NoVUpI?=
 =?utf-8?B?L2lKOTM2L0ZsUjJicmJUMzg1RW5uNUFRcXhGYUx0MUFwQ2JIaVNvdCtwbE1k?=
 =?utf-8?B?MGhZWnlZZ0hCa3BOT1g3T3BCY0IycEZIZzZPenZzRGpvZWZGRDJJaXhvT3NF?=
 =?utf-8?B?R1VFRHl1dTVNOGVyV0RyRGJVNkJtbnZwdGRxaENOamswVnU1b1o3MEFCSGNM?=
 =?utf-8?B?RUkvTWhzbFFPVHFOQUt2RUgxMFROaGtLL0tia1pEeHBNWVp3K2lHM0hTZmxQ?=
 =?utf-8?B?TjI1ellIYlBtbmJNSHhZaEJtS3B2cXk3NHYwWW94em5nZUpsVlZaTjk0Z3lu?=
 =?utf-8?B?UVlIV0xyQWN5Wm4vc0xBaSs2a0JSYVlNMnY2Y0FLYnF5a2ZDbnNOOWliejMw?=
 =?utf-8?B?bUs3MHdHRXgrY2ltRUcxM0VnWDQ2a0swaDg0ZEVkSkRieXE2QkZhY1pESnpT?=
 =?utf-8?B?ZUk4bVN6Yml0UmlCTWszV1d1SzBpT2dVcVdPQWFkcVpac2dYV2JLemtzWnA1?=
 =?utf-8?B?Y0d0dlMwek5KQ3pFOFIrdExmMU1ab1NhbG5ka3hDR1c5dGl4eGZoRDl4eGsy?=
 =?utf-8?B?Z0dBUVM1anA4bmFkNDZ1VmVFUnRzNTJZRlJlbENyNE9XdzdIYVErOCtxUGlj?=
 =?utf-8?B?MWU5V2Q0YnZ1ZG9USDVNVHRRTnZxa2ZZU2ZseTFkM2ErMzhaOGJheE11RUU3?=
 =?utf-8?B?SkpoVWp2Mm1GeFlsUGdDaktaVUxRelNEbGtxajZCWnJ2UWNVSTdkTDRaSHd5?=
 =?utf-8?B?MTJSN2M5MUtMSGZ6eTFMMnBaMUZ1UG9vM1Fmd1NQTzVGdGJHZXJsY0VzNk0v?=
 =?utf-8?B?dUlocTZKWFFGb1RvWFJpMFRseWdNbE04cnFvbDMvZUJ6TzhTc25ydnp1R2Nr?=
 =?utf-8?B?aWFhdUxrcE5VRFo5a25jRHhxT0NXMjFBa05qamRhL3I0cXZETXd3ZXFQMDhK?=
 =?utf-8?B?L0FORWMvQUhBNXRLUi93YzU1Z0FOUmJrREs3c08xVEFBUHozT3FnOVFvaUFV?=
 =?utf-8?B?SzF0Y09QSVVHS29JZHo4UlRhRU5pcWVVMlovUjdLRDE4bGlFZW0rMGc1SC9t?=
 =?utf-8?B?M0lkRVZXeC9xYXp4Nys0bDBZcGsxNTVEWVpnSEFqck9hL0lLSDhTdUpIek0z?=
 =?utf-8?B?UXltbGJYUVQrVUxhN1V5Zk9vWm1JNVpqS1ZLbWtSb2g3clRnS2FKVEZlV1ox?=
 =?utf-8?B?VDdhaHZ1aUlZRFlsMkxWZjFPT1pWY0JJMk5uNkZQc01NUHpYSkFUelBPOVNP?=
 =?utf-8?B?VVk5N3ZhajJIL0lXYjh1elBROFFHN3NuTE00VWxVYXRNMFNiM2FPaXc4Ujlz?=
 =?utf-8?B?SkVEUkdCdFVoQ05ndHplaDBIRkNhR3ljb2ZoSEdqYjlBSEozSGhZM1pwemp2?=
 =?utf-8?B?Mkh2S2VPSEdoYWw3SXV6NEZLS0xKM3I3KzIwZFJGTitaZFRyZkVpbmgwZW1F?=
 =?utf-8?B?Mnk5c3dNYnF2c2FWVk9ZckdkZGxvUmlBMUR5QmJsd2krK1IxdzA4S3FhK2kv?=
 =?utf-8?Q?GRZjmaFzGMH/I/uxlnTwYR4=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e406016-bd17-4f0c-689c-08db0e8059e7
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 11:41:03.2341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKG278yhuAF1aYo0+LAjcE9D+WCnctl3uInKXUm3vFtuZpuFdXGyS2uD36kCmsDGVegO9nFUrJZIcV9FJTnQfnzYmW9bbdxLS9fNwzllWYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5336
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Sorry for the previous mail in html format with annoying signatures.

> Hello,
> 
> Krzysztof's confusion is because you are changing the binding for
> nxp,pcf8563 while adding support for the nxp,pcf85263/nxp,pcf85363

If that is ok I would propose a new bindings file nxp,pcf85363 for 
pcf85263 and pcf85363 in the next version.

Best regards,

Javier Carrasco

> 
> On 13/02/2023 10:50:18+0100, Javier Carrasco wrote:
>> These RTCs are handled by the pcf85363 device driver, which now supports
>> the quartz-load-femtofarads property.
>>
>> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
>> ---
>>   .../devicetree/bindings/rtc/nxp,pcf8563.yaml  | 20 ++++++++++++++++---
>>   1 file changed, 17 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/rtc/nxp,pcf8563.yaml b/Documentation/devicetree/bindings/rtc/nxp,pcf8563.yaml
>> index a98b72752349..aac7f7565ba7 100644
>> --- a/Documentation/devicetree/bindings/rtc/nxp,pcf8563.yaml
>> +++ b/Documentation/devicetree/bindings/rtc/nxp,pcf8563.yaml
>> @@ -9,9 +9,6 @@ title: Philips PCF8563/Epson RTC8564 Real Time Clock
>>   maintainers:
>>     - Alexandre Belloni <alexandre.belloni@bootlin.com>
>>   
>> -allOf:
>> -  - $ref: rtc.yaml#
>> -
>>   properties:
>>     compatible:
>>       enum:
>> @@ -37,6 +34,23 @@ properties:
>>     start-year: true
>>     wakeup-source: true
>>   
>> +allOf:
>> +  - $ref: rtc.yaml#
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - nxp,pcf85263
>> +              - nxp,pcf85363
>> +    then:
>> +      properties:
>> +        quartz-load-femtofarads:
>> +          description:
>> +            The capacitive load of the quartz(x-tal).
>> +          enum: [6000, 7000, 12500]
>> +          default: 7000
>> +
>>   required:
>>     - compatible
>>     - reg
>> -- 
>> 2.37.2
>>
>>
>> Javier Carrasco
>> Research and Development
>>
>> Wolfvision GmbH
>> Oberes Ried 14 | 6833 Klaus | Austria
>> Tel: +43 5523 52250 <tel:+43552352250> | Mail: javier.carrasco@wolfvision.net <mailto:javier.carrasco@wolfvision.net>
>>
>> Website: wolfvision.com <www.wolfvision.com>
>> Firmenbuch / Commercial Register: FN283521v Feldkirch/Austria
>>
> 

