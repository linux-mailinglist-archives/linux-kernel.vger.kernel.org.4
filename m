Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238505EEA04
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 01:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbiI1XOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 19:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiI1XOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 19:14:30 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2107.outbound.protection.outlook.com [40.107.113.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF15883F5;
        Wed, 28 Sep 2022 16:14:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVE5DYHko5NU2iUDrr6fyENM/iSgYArczVQJPZw6tF8YJ+stOmSU8aZeeyUL+++3xNnLx7CYAOXsK66ouReshkn75VvCKMxMrzM3NT+8T11gGNP81tUqCyjPISdMxuA7kNAcr6mNchYh8yNAgiS3Crzbdwuwx2EJXAjs/MYsJvop/aHEFrlZaSgNskntCLYk5qaU+pGyVhmkBLjhw01yr4HNmt+MEyUTDDW8CaKFwxCpRf/Epnf/kqrkSGC6SSBvurXnCIl+6MG7ZTPJUJEGrUNcWQvCHOJFK6z0h5ToT3Ieh7lDMEHYZJZ853q6fxqc2o90xLVCwNPfeutXWkec+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ginGMCzSQ0jkTBb4J8s4EoQxrPLsrUJduHsngEvDxg=;
 b=HCNRTGOStgJkjfDd0GkVoznn3BQ93WvhLRPxI3NrqZQ5FEbVlH7fEKca2ZVWYwhh1Wj8VapAFsYdbHzhpI1PIKqbpINJKWPMsSaIFcWcXbTXGw9afET+wj8UBgH9ArlhO1B+5qfOSYSIW2/zrcKdftLZuUDN6NbIuQ8YF+UHfO6DF+w+yEt7F8DT4hZp6yGi1YhQoxzAhKQcTOVpLS3qfXbMQYEG4YZOSm+LgWFv0VHiQOTdOIu+DnOjhnAS1XBd2FQxCM52rZqH2+wrdPTXVrh9oaJ3dj59uWUvU+sNIOKFeDlB66ahVLz5GbtrM+hhjEMcLZcy1HhDWLu1R3me8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ginGMCzSQ0jkTBb4J8s4EoQxrPLsrUJduHsngEvDxg=;
 b=R/4CDTOXqm2PnTQsfUKAXm5DQZHrZJFsasVUx/6dcgrvyPZ7BZHulSaX/TNfuv0VXRna1mF4nrkbCdbq/xJAESv2fa1q65VSQ+Yokib6q3/clUUVUJCSyQKt6eJDT69SeyLWXBv8yRPFxcz9COw80oRGuB6Rz9FzesuOZ/bXoag=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OSAPR01MB3892.jpnprd01.prod.outlook.com (2603:1096:604:5b::23)
 by TYCPR01MB10380.jpnprd01.prod.outlook.com (2603:1096:400:240::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 23:14:27 +0000
Received: from OSAPR01MB3892.jpnprd01.prod.outlook.com
 ([fe80::87b3:6d49:458e:8db1]) by OSAPR01MB3892.jpnprd01.prod.outlook.com
 ([fe80::87b3:6d49:458e:8db1%2]) with mapi id 15.20.5676.019; Wed, 28 Sep 2022
 23:14:25 +0000
Message-ID: <85faab48-13d0-1e6b-302b-b74d4d7acb95@renesas.com>
Date:   Wed, 28 Sep 2022 16:14:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: Add bindings for Renesas ProXO
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, geert+renesas@glider.be
References: <20220923205251.1387-1-alexander.helms.jy@renesas.com>
 <20220923205251.1387-2-alexander.helms.jy@renesas.com>
 <20220926230438.GA3128861-robh@kernel.org>
Content-Language: en-US
From:   Alex Helms <alexander.helms.jy@renesas.com>
In-Reply-To: <20220926230438.GA3128861-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::24) To OSAPR01MB3892.jpnprd01.prod.outlook.com
 (2603:1096:604:5b::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSAPR01MB3892:EE_|TYCPR01MB10380:EE_
X-MS-Office365-Filtering-Correlation-Id: 78e2c611-07ee-4788-ebb7-08daa1a72f64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W7tMMVyO0RQBVno/CHOjyDmWi3Hq/JZUnYb0Yly6G15WMbfPfsNl/1bi36fSZfh67bDdDE9ZLn99w1s2o/dUl3YBJFtvHeRTYeidjQsXov9p71YKOsiEyBmuSLFBUnQR2ykbuUTB8ihOg9+PpJFCR7VFuMaAINi/rxIuswH/1Ff25V+oFEWHTBmrkYvxI8akcISJfTKArus/JSqVOZmzbF3iqoJO7oi7p4GbEstTNiU5LC9ydEqLEAb/svPmWpa7VwTe/hQWPUGvaJ2hzx5ND1KUDnzhmnRmK619EL+jmFXRKlpKz3x2oS8USrduUqekpKkfIjQrvPedKvCRDGxX+BN/I3B7iKolYezK8I4sR0PjxFyE92rQ4rYGpB0kYCFOqXcmnRHEOP4Qp7UONqUBeG/anmxt7PV/uWXYYSDZ3ZadVYRgRslxyJ8Xw0UIz9EzkFCMPpgC+LpHZEzgZ7ZaEcrj9S34Jws00ivUuMDyz0HmlwUPsUtZJTQYldYhzDCBw13eZPBOVBSbHGFPX+dq3jfoMAGZ8fn4EIoxccCvhYcLpDIHsjb65wg6byGZaiIIziZD5BBSMb92VkDcFGDdY4FRS1oMorC7c0UADiywDI+pCPNK5JddstRKqr0NMeipSGhLkuojPpU2pSbeDZHin22a7CHdBGcHKrAvv2x+n1nyWc7P/JmV+frSt9i1QhoKWqbU3itZu2urX/X0fcF6AZwB+Nv3cmdYpXLQB6HaZemfuJAgmEqfhrJ4dyouTz2y5qlxTc/b6aaM/lkxX/jjtzw68B8ugyHFgioU8upipYJVw1G8EIUJST1s+l+goSd1Xa5rBQcgcBdn6uA0J7GFRAW4Ebchwg029iVQ2L24IV3qWB1AB05pw1ly0F3+vpsG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB3892.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(451199015)(45080400002)(2906002)(6512007)(316002)(478600001)(6486002)(186003)(2616005)(6916009)(41300700001)(6666004)(966005)(36756003)(26005)(38350700002)(38100700002)(6506007)(52116002)(86362001)(31696002)(5660300002)(53546011)(8676002)(66556008)(66476007)(83380400001)(66946007)(8936002)(31686004)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGY1QVI5S1A3OGVzS2FQNTJUalJxTlYxbnRsVVI1UUNMWlRmVGtzajJBc3p4?=
 =?utf-8?B?VmpjbGV1UWJjdHFCbjNUV0pxUkR5bUtZWmMreUZvS0x2aEZpOGRXZkgvWk1U?=
 =?utf-8?B?anpOWlg2VExiTmROcTJ3RTlRdng5ZVQ0YjVoT1VoVTBsTzE1d3JDNytjaisw?=
 =?utf-8?B?UzZLMFVnem9ZNDNmTzBTcE5xS2gyY1RmV1E4NVZWOW1lNmNWc2YycGtRYTJ1?=
 =?utf-8?B?SzduVVdZdklYbTRXUDNqcDZxTUZtUXFTVXdwY3VVTU5YdlRLSHZLaG9LQ2ZD?=
 =?utf-8?B?N3BiZmkvUW0rK0QwbG4za3gyRGt5L2FEYlBoeXNCMk9kcVM5a01uQ3poNWZ5?=
 =?utf-8?B?ekVNdTMyc05ZaUFUSng3b1hmWk1ManhjNzVsVCtVMnB0UWJrbmNKVDUwVlps?=
 =?utf-8?B?NmVRRE1JRlk4S2NYTWVGNldaWHNHMU5GVDd0Mk9SWWJCNmc4cHNLb3A3THhG?=
 =?utf-8?B?NzVhaVFFTVM4Zmp3RmJnTWM5WGRWVlRZVldaYXk5T3VCcGE4WVhMRnIxbGps?=
 =?utf-8?B?WmJXVDgyNERBWlJOcmVwTkkrK3lwZC9oK1UxdG91dDcyVW1oeEVBb0ltd0hE?=
 =?utf-8?B?bzBSTElIcGp5d2ZqOVdxTHRYa0Q2c2lRbTRnM0V1bHViRUhkNG5UY1hxVEc5?=
 =?utf-8?B?UFcyMTA4b2c1bEsraWpiNUVid2Z2UUpqakRSMXZkM1R4TGxyeVBkSGJGSXI1?=
 =?utf-8?B?NGN5Yjk0cGxDUUlVT2R1S3RycTR0YjZFOGdiR3IrMFFxWThGODN4cmpac29h?=
 =?utf-8?B?aTBKZWs5Q0NjLzBDOGhUMEtMaExoZXFETXJwdXV1ZEwxa1laY3JjR1BoVitp?=
 =?utf-8?B?QnBHb1hkVDlBeVQxc2ZlRGRJOG1OKzNUV0FVM3JkVzBWdlVYckhxZUNOeXho?=
 =?utf-8?B?c01Mc2krdjREYmJEeVBYUkxMRGFPNnp2ODhRS1BpVzArdnMrcndiOFJFbkZU?=
 =?utf-8?B?d0F3K2FnWW5jT2NvdXZ4TFptcHpzOWZxanBKY29YZVcweEphWU0yZG9nSkJK?=
 =?utf-8?B?VVdHTiswYTFLMzlWSzYzNjRMdHd2UEJ2Z1R4OUxsaFY2Uk50TFp3YnlKWk1Q?=
 =?utf-8?B?dDcxMnkwMm15Rjdsbkt1dlh1VGFRcEc0QzBHTG1HWkNmQWREeEFqV091MmtV?=
 =?utf-8?B?ZWlCNFQ5RjRsNlpkd2lRRzZmNHlsQWI4elQ5SzgvaW9DUkluVjVDV0c4cTRu?=
 =?utf-8?B?bUQydGtXZVgwQStvZmZwSDFORkI4UFNJRnFVMnd4ZU03UG9vaEEyVThwK2dG?=
 =?utf-8?B?Sy9oR0FNc21XS0UxNWt0RkJrbFdoU3dFNm1VdWRlV1Q5ZkRKNS95NmhQb014?=
 =?utf-8?B?TGIyaUZSRVBwanorR2puY0xzb3puVXNXak1pWGMwOTNwRmNsTDlMRjMwbnZo?=
 =?utf-8?B?dTk0TStrRU54UmRSeVhGOFl1b3g1WjBMaGNmbjNZbHh3aTVaYWdlKzYrdjB5?=
 =?utf-8?B?YjZqUUQ3dVE3MG5oSno5dmI2ZUtHNENaMEZINHpjZkJ1bGVsaUE0dlhNVmd5?=
 =?utf-8?B?M29CQVdBbmNveTlvNjNqZlA0N25tSm9McUtDanJtUk5OdkYzMnNLVlVKK1dQ?=
 =?utf-8?B?TjBNUTBORG9IRFlhaSsxZ0xDVjkxWGg1NzdES3ZaODlQeHZVQmZ3emFyMzNu?=
 =?utf-8?B?cXJGVW5ILzRMUHhFbDZKeThiNVArRmlmb2lIc3lFRXpTSnp2d09YcnBDYTh2?=
 =?utf-8?B?Rk9UZEpXVndqSHV6Qm8vbG4vekdCNEIwUStGZ3E4NytTZUc1a3FXVlJONnR3?=
 =?utf-8?B?TWpSMCtjWFdIeGFhNUJOMisrcm5VUjR3MHhKSCtTNjE3Y3JVOTQzNG55YWZn?=
 =?utf-8?B?R2FMUDhSYU5mTUZkTk9ZblZPS0plZVZZQ09zZW9sVWZyblM5Y2tXSGxzV2J0?=
 =?utf-8?B?TWUxbW1ZcDBUdHhURHNOb0RzMS9YK3RrMmdNTVhZcmhLZEUwa2M2eGNLU1pj?=
 =?utf-8?B?ckRoUnJDZkpHU1NvUVEvd01WYjYyYU9JVUg2Z2JmeXdIRnVObnh2ZVYySVN1?=
 =?utf-8?B?M3VmZFhxeUptNFdvTWNSYyt1QVRjcWd4RFN6WmtUVjN2WDBSU2RQT3R6RStW?=
 =?utf-8?B?MmVYTmdzcG15c1NpZXh2TGdMVndOYTBKU0dOV015WitNcUw3QWV3Uk85TGVV?=
 =?utf-8?B?THBFeWlKZk8vZ3NidWlkdjJHQzhGRWxtVnVEZHhVSkRDN0ZiYTkwNTc1dk54?=
 =?utf-8?Q?aopIuDF+mQSxRseWe7Dc1xc=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e2c611-07ee-4788-ebb7-08daa1a72f64
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB3892.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 23:14:25.6224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h3o6x1mgQ9jJgFhHzwxPIMPYgHfXzvg9V+DHdWbbUFj4hPD5G9wlyHsSN6Lz0ZFdCEYhNPyafwAG8nwXDVjFIhtSGAGqycV45tOBfgS6FO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10380
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/2022 4:04 PM, Rob Herring wrote:
> On Fri, Sep 23, 2022 at 01:52:50PM -0700, Alex Helms wrote:
>> Add dt bindings for the Renesas ProXO oscillator.
>>
>> Signed-off-by: Alex Helms <alexander.helms.jy@renesas.com>
>> ---
>>  .../bindings/clock/renesas,proxo.yaml         | 49 +++++++++++++++++++
>>  MAINTAINERS                                   |  5 ++
>>  2 files changed, 54 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/renesas,proxo.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/clock/renesas,proxo.yaml b/Documentation/devicetree/bindings/clock/renesas,proxo.yaml
>> new file mode 100644
>> index 000000000..79d62f399
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/renesas,proxo.yaml
>> @@ -0,0 +1,49 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: https://jpn01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fclock%2Frenesas%2Cproxo.yaml%23&amp;data=05%7C01%7Calexander.helms.jy%40renesas.com%7C6b2973fc747e49d4353308daa0137e97%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C637998302827553694%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=Xk7KWuuUfUfA0xv4oUSEOzvhEMpE5YWKad9YVXsJbXg%3D&amp;reserved=0
>> +$schema: https://jpn01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=05%7C01%7Calexander.helms.jy%40renesas.com%7C6b2973fc747e49d4353308daa0137e97%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C637998302827553694%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=%2F1uyeDB3%2F9iLv1soU8V2NtEaaeoFkpwI%2FG7cSaZCKbo%3D&amp;reserved=0
>> +
>> +title: Renesas ProXO Oscillator Device Tree Bindings
>> +
>> +maintainers:
>> +  - Alex Helms <alexander.helms.jy@renesas.com>
>> +
>> +description:
>> +  Renesas ProXO is a family of programmable ultra-low phase noise
>> +  quartz-based oscillators.
>> +
>> +properties:
>> +  '#clock-cells':
>> +    const: 0
>> +
>> +  compatible:
>> +    enum:
>> +      - renesas,proxo-xp
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  renesas,crystal-frequency:
>> +    description: Internal crystal frequency, default is 50000000 (50MHz)
>> +    $ref: /schemas/types.yaml#/definitions/uint32
> 
> 'clock-frequency' doesn't work here?

If 'clock-frequency' is commonly used to describe and internal crystal
frequency then I can change it but in my opinion 'crystal-frequency-hz'
is a better name for this parameter as it isn't really a clock, just the
internal crystal that is inside the package.

> 
> Anything else needs '-hz' suffix.

I will add the suffix in the next patch.

> 
>> +
>> +required:
>> +  - '#clock-cells'
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    i2c {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      proxo: clock-controller@55 {
>> +        compatible = "renesas,proxo-xp";
>> +        reg = <0x55>;
>> +        #clock-cells = <0>;
>> +      };
>> +    };
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 350102355..d52a8a5d2 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -16080,6 +16080,11 @@ S:	Supported
>>  F:	Documentation/devicetree/bindings/iio/adc/renesas,rzg2l-adc.yaml
>>  F:	drivers/iio/adc/rzg2l_adc.c
>>  
>> +RENESAS PROXO CLOCK DRIVER
>> +M:	Alex Helms <alexander.helms.jy@renesas.com>
>> +S:	Maintained
>> +F:	Documentation/devicetree/bindings/clock/renesas,proxo.yaml
>> +
>>  RESET CONTROLLER FRAMEWORK
>>  M:	Philipp Zabel <p.zabel@pengutronix.de>
>>  S:	Maintained
>> -- 
>> 2.30.2
>>
>>
