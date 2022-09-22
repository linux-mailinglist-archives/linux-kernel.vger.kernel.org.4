Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360BC5E6A62
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 20:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232249AbiIVSHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 14:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiIVSGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 14:06:50 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2118.outbound.protection.outlook.com [40.107.113.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2968A106534;
        Thu, 22 Sep 2022 11:06:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eloB3RLbb6Gtp4+BP1F6SAl+eIDG8fzNSxhGkLaozEmqBB5h+CUecza3M1NVLPgbcIyldY7MuA/tA7XY9Szilua4TFFohJcdoUVn58uIY2RXgX47uRtkmc0qBsUp2CKtpiB4axENiX8I26nOH6VM02Zb82R5JJdJ9PjGnbn8Mb41yqjyhKypG/LZsSn8O8qTW7nOVAectNhmx6ViX58+eHQ8jS5APQoM0GOheR3gUuVuGHpblJ41869Ixyet8QqTuLMDCq+yj7E2aSw7SEg2HQlrCp8/HL41vVxjDceQi8KHoOiAbzrfyqBrWEJc+V2MDuYat3jBgJKF1FIbK4G4nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tx0oQlkdvYSspuYp24NAtPjvyLqMmKr/6eJGPzpA2qA=;
 b=LNxBp8bZPOajXaIBGPsflKuYZDR9vAbbUtQAgWhlClu6fatqZpCz/qbuPlxlYxedw+XhwuTdUtlv6E5hA7q266vJYclKWt6nxz7QoX6262VxmDvxTujjq1JpuGZAcTyQBJpM3YjlgSK0MUxPoPGhKlmvmRc9W+2vDwiRM8Wcf+KnSvyBNdWMDUsRwyay8nb/Ks0ILHdJDZ1dYUno3bz6DpVlB/+llSBxpk8gE2Bvdnu27m7eqigpV0Aol3nznyZ1Eym4wi8Rd6SRwFJfgvKq9JBu2790oFQ6msJrTsyZLtCdzK6pnj5nDzTAOqPGFZYgg1q8E6KnMja/HdZhsVH18A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tx0oQlkdvYSspuYp24NAtPjvyLqMmKr/6eJGPzpA2qA=;
 b=g/kNxaCrx/w6uzR+vPEowgYpTYEp6wcGxwM+LR4rQ6VKCaNW6N451aDpzgmE7wADSf71V5i0U3jLZ15+pyEox9v4sjw2IHBRpPu+IYTbSOg6mAG23raQLKSYAqVkeD4/vB3iFAPfmLlO7b3ayp0mneWuMkhDDj9GWTksWEjZgI8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from OSAPR01MB3892.jpnprd01.prod.outlook.com (2603:1096:604:5b::23)
 by TYAPR01MB5993.jpnprd01.prod.outlook.com (2603:1096:402:36::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.19; Thu, 22 Sep
 2022 18:06:45 +0000
Received: from OSAPR01MB3892.jpnprd01.prod.outlook.com
 ([fe80::700f:4552:de5:c2dc]) by OSAPR01MB3892.jpnprd01.prod.outlook.com
 ([fe80::700f:4552:de5:c2dc%3]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 18:06:44 +0000
Message-ID: <8d71b849-7226-09ec-d099-ae5c172e1a17@renesas.com>
Date:   Thu, 22 Sep 2022 11:06:38 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 1/2] dt-bindings: clock: Add bindings for Renesas ProXO
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, geert+renesas@glider.be
References: <20220914211809.22500-1-alexander.helms.jy@renesas.com>
 <20220914211809.22500-2-alexander.helms.jy@renesas.com>
 <20220915120844.GA996386-robh@kernel.org>
From:   Alex Helms <alexander.helms.jy@renesas.com>
In-Reply-To: <20220915120844.GA996386-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0071.prod.exchangelabs.com (2603:10b6:a03:94::48)
 To OSAPR01MB3892.jpnprd01.prod.outlook.com (2603:1096:604:5b::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSAPR01MB3892:EE_|TYAPR01MB5993:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fbbb632-98bd-4c9b-5cb7-08da9cc5355e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u0e1yKsp5nHGWwTGONWp2d+VFDWf0gcuGERyXb2U0+O/mMGX0zTfJJ/U3h/5TXeaQoXPEr3RwKXx5DZmw/9DVX0akQCYQjk8xiUenj3BXlhlCrpoLQr/5Y/U+JuZ48M+M6cf2GAC1Au9SWqhoYxNrFuhfbfGEMSpfDlQDJ6gdR0hxQJKuTfaaQza0f6KA+7Hzsq2aWB6rPCJI2HszW3oOQoIRQo2rY6S766sLyO+/OEvPsgxWeCA8lnOP8tSqT9BwjZwPKjsZ2grylinePgGMXCzdIycHzoaKQcp696TOxcpWeYQH9XJo8JUwDENIaTYsJhTZjY2Vz9SY8amXjegcg9GH+QMYj6khCmNvdogndSrfIA1gBDCDoeFOAlddE18vpdaSyxfl6HeaR/SVIMONxpHCSmZ14FJQ2dTTgaPbRpFBDQz1QoqyyNxdfvFQms8dtvNYcjMTpL10UivRCGUnH0rlsuGQmYoy9TV7jh+nzlE88PkJ2Cgd1WD8DyyuuQEtlsyFRdS9ktjwrMqEcWXta2G/tjeNqb51Wis1awc68IGCyK1e7JKwN8IAF7umrvKLaJpUv0tn6FHT63ozYfrPLo8PpZZGkPiRETw0O8H208zRbKIy38rH7z7urmw8TwiEz+KFXkkLMkBuRdj8g9xXzt2GtgH8Patf6TDZI2/LVRiAjHpL7ZjTE4UMTONA9UADMllDo3SbXvateRzDwsu/xb06MuieQoB0eulhT4nbeABr1dNIhrCbXD9UG7V9mp9nvyUo8eHvzyPHxPSck5NUa382BvuXarly6So9S1kLwTqAUE+t7wMSZeKL6tKtdg4NNZB7scESf87GXVGSWSpRhCvpfj7tJOiTsSjeXuEE0LkODS/PUbqEiCZjYJN8UvbBsBwpCeAhrZEAr7ha/39Nw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB3892.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199015)(31686004)(31696002)(86362001)(36756003)(38350700002)(38100700002)(41300700001)(316002)(6916009)(66946007)(8676002)(66556008)(66476007)(5660300002)(2906002)(4326008)(83380400001)(478600001)(6486002)(966005)(8936002)(53546011)(52116002)(26005)(45080400002)(6666004)(6506007)(6512007)(186003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEZJams3VzZlSWtmS0NkRG9nYm9iQUNaM1h5YTltZ1NXNXdRbDgzaE9nQ0J3?=
 =?utf-8?B?cjM5NG9vUmZYU0llWWpVZllrRUxaUE0zQjM1WWFJbjRFdkdrT0RxdW5LQjFX?=
 =?utf-8?B?UnpPdG1JaFl5Qlg2eFpsSUpUR0h0bmRENSt4WFlIZGk1S1JkWGdmSTN6NnVp?=
 =?utf-8?B?T1FKWmJ6ZUFSb1hyMDRPeXgzMnphNmI3SlZLWmg2Nnc4V0VuandWUDM4R2tB?=
 =?utf-8?B?LzkyK0d2OXIrR05meEZEL3dVZ3k2bGU0RUpBWWZMOHIwTWROTGJLU1VpSG9p?=
 =?utf-8?B?WDNkWnYwUGVFQkVNRW0rZkx6V3F3NU9vTXQ2V0pRRDBJMXpPekRidTQ4Nmhh?=
 =?utf-8?B?VHFaWU5hbWRuNXlLWThmamp6NHlQN1pOQXJnZUJDRmIxaVhPdzdiWTBlSlox?=
 =?utf-8?B?N3UxSVFERlF4RkVzVzdlZ3hZa1pyNTJucnh5d0krb2RjaWFtK1pxdDlhbzM4?=
 =?utf-8?B?UVJzMFl6bUVFUzl2N1dsRFFHUkxsRTh2R3djMnFDY3hUcnQyTWNwZjVIblZs?=
 =?utf-8?B?clNsenNpSGpiNk9jVjNQZVpYb1BKb3hUMVF2RDJJZXp2dFJEM2U0QnJVRTNs?=
 =?utf-8?B?OHpvU25hM25LYWZBb2RkSHVDNGhVN09idmd5ZzZTS2JTNkxjMWdnNk1WUVVV?=
 =?utf-8?B?NmFpaEFHYXd4Zm9SVUdGV1NsTUxhd083MTdqVE55a0RtZDZSRklFWlpYN0w5?=
 =?utf-8?B?aFFLTjZjSGU4Q3NyWkJDY21pL0JtSmhMZzlDbVdCbGlmbTVUU0FEM2Uyb0pT?=
 =?utf-8?B?TGlTTVhoc1dGc2IvbHlwRWs2cjd2UHVoRStnY25xNkRlTk9vZStJRUVKVHhU?=
 =?utf-8?B?d0pXUEwxNWFEN2dvRHFvbUo5cXJ1UnF6eDFmcWxZVllnWlhrQmFkNkI1cFl4?=
 =?utf-8?B?UExybnhscjZLSmw0WEJLTDZuVHR2TUtzSzJtM1RlOGVoYXhteWZ3N2NYdm4z?=
 =?utf-8?B?WVk2bFFZZ1lOZU1xSU9aUzR4R1pvV2lVNzZHWWI4YUVPK1ZYSUVyZWpyc2Ir?=
 =?utf-8?B?a3kzTldNYXlHeWwxTWdkS2tCN1lxZVRmSjZNajJiTGt6aDVYT0ZOazZpV1Ru?=
 =?utf-8?B?Z2ZlZ0dLVXJCaWc2eXpUWlZCZGNFL2ZsUm1jaVM5RUFpT0k1b3FIazZhaTFG?=
 =?utf-8?B?aHVhRnVoT0VZcmFqNlNrREpQMm90eDZXWGlBTHNleC9lQ3UyZWtpZDY2SFBF?=
 =?utf-8?B?TFBTOFQ3WG5wdW5oZFp5bVpZL2UxUXpRQnZYemNwdzVOeHBKYjZpTG5uU2RW?=
 =?utf-8?B?UjBnZXBadWtyMFY1eU5wWHRYbUxla0loSDFITHBBMXNQdVFqSWJrTmlmVzJJ?=
 =?utf-8?B?V2JndEJmdkpPbFE4Ni9qZFM2SFZFZ1FHZWsrOXZLV0dIV2wwelgrRHRlaFNF?=
 =?utf-8?B?bGxyS2RsbzFuNWFCbVA5bTg0akdNRVNWd3U3Um1vNEU3aUNPb01hSysxZkVZ?=
 =?utf-8?B?bjdyNzdNbVI1YmRFVWI4S3I1aklTZk14VFZHNjdEQmcwSFNmU2FwUDZBbHA0?=
 =?utf-8?B?RU16TmNMekZLekFuRjcrMllvYXh0N3oyandZejFCd2t3d3ByZ0FEeWg5aDZq?=
 =?utf-8?B?VVMwOWdTREt6UmtZdFFmazRlSnEwc2s3T0lrYkhVKzZ2THJjaHFqbngzWFB1?=
 =?utf-8?B?VklmQ1hhY0hacmZpUndhdkpEVUlSWGRRdFJFVkp6b0hsNGIzb2Q5bndvVXJy?=
 =?utf-8?B?MHREL3JnTVRnL3BzWEJjc3d0TnNFNjlFMjZmYk91Ui9TMy9qdW5mTjc5UGhT?=
 =?utf-8?B?Rm1tMTNYQ0NSV3JBd2drWFl5Z2dGSHM4YTdWalZSRkxHTnJJWm9OSExQeUg1?=
 =?utf-8?B?cGZtazRwbnRRVjlrWkxnbFRlREJ3eEJyODNDOWtQUnphZVJ6Q1J3d3JlRVdV?=
 =?utf-8?B?c3VRblRBQ09hMzlEbllqYm8rWG0zcHY2bjRLanZWeGVHY2lCMnNlQytWYzV5?=
 =?utf-8?B?czJBaGs0cmhkbnI1TytDcWtEU2dlTkdldlJHbXJSTElGbEdqYW1xOUxnSFBF?=
 =?utf-8?B?Tmlta0VYTS95Vm9UR05QT01DdllCWFJPSTNhbitKMm1BTGxBQ2RBcGVTYklL?=
 =?utf-8?B?c1ZWNm9iZERpaS8vNWpsVXpiZ1hTODY0U1VzcFBJOWlPQlA2Rk15UnRJY2xr?=
 =?utf-8?B?aS9IT0piNzl1bWtUeGVUelh3a2ttdlFNdkRyT2FlODB1QlBncjBialRwN2pm?=
 =?utf-8?Q?XB+w0aVrOkEov512trh09hE=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fbbb632-98bd-4c9b-5cb7-08da9cc5355e
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB3892.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 18:06:44.6557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mwb7yQmfaHUA/Qul8bfyxyM4p6zSOrK/jwJ6m6EqA8/cclTYzHRYsHbWVAaiVbJdeVUJqLwBx93X2a9ynl55GCBnlfRINs5Ongsj8tBXFmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5993
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/2022 5:08 AM, Rob Herring wrote:
> On Wed, Sep 14, 2022 at 02:18:08PM -0700, Alex Helms wrote:
>> Add dt bindings for the Renesas ProXO oscillator.
>>
>> Signed-off-by: Alex Helms <alexander.helms.jy@renesas.com>
>> ---
>>  .../bindings/clock/renesas,proxo.yaml         | 50 +++++++++++++++++++
>>  MAINTAINERS                                   |  5 ++
>>  2 files changed, 55 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/renesas,proxo.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/clock/renesas,proxo.yaml b/Documentation/devicetree/bindings/clock/renesas,proxo.yaml
>> new file mode 100644
>> index 000000000..2ae131431
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/renesas,proxo.yaml
>> @@ -0,0 +1,50 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: https://jpn01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fclock%2Frenesas%2Cversaclock7.yaml%23&amp;data=05%7C01%7Calexander.helms.jy%40renesas.com%7C34ce960b2542459b61d408da97130b50%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C637988405289843575%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=izvR%2FXbUNVXknaODSnMmcetPnn%2Ff3Jk%2F6RuBdZ7uSa0%3D&amp;reserved=0
>> +$schema: https://jpn01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=05%7C01%7Calexander.helms.jy%40renesas.com%7C34ce960b2542459b61d408da97130b50%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C637988405289843575%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=dQ7nZtgfTE5DrXB1iavJuOhSWmGl4tYI1m6iZpkPAhA%3D&amp;reserved=0
>> +
>> +title: Renesas ProXO Oscillator Device Tree Bindings
>> +
>> +maintainers:
>> +  - Alex Helms <alexander.helms.jy@renesas.com>
>> +
>> +description: |
> 
> Don't need '|' if no formatting to preserve.
> 
>> +  Renesas ProXO is a family of programmable ultra-low phase noise 
>> +  quartz-based oscillators.
> 
> Are they all the same from a s/w standpoint. If not you need specific 
> compatibles for the differences. 

At this time only the XP variant is supported and this is reflected in
the "compatible" string.

> 
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
>> +  renesas,xtal:
>> +    description: Internal crystal frequency, default is 50000000 (50MHz)
>> +    $ref: /schemas/types.yaml#/definitions/uint32
> 
> Use 'clock-frequency'.

I think "crystal-frequency" would make more sense. The parts come
programmed to a factory clock frequency which is different than the
internal crystal frequency.

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
>> +    i2c@0 {
> 
> i2c {
> 
>> +      reg = <0x0 0x100>;
> 
> Drop
> 
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +
>> +      proxo: proxo@55 {
> 
> clock-controller@55
> 
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
