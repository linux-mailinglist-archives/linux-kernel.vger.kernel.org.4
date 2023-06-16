Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 731D0733239
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 15:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245385AbjFPNcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 09:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjFPNcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 09:32:11 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2058.outbound.protection.outlook.com [40.107.8.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF4F1993;
        Fri, 16 Jun 2023 06:32:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/ghjbNLz2DTXM61G4fA8xbjtGvCl7ynT9mVvWwymM5P+bT2mdu4/Je7ZjDe8JiFRkEY599xczETfkxwU5AYNPsWRIkEQiyv1IB8to93yKDToUFmNqDcLavQ7V46K7MnfBaL84cERT3cVak4Lzx0hD5tLs1CH2HreLBeErvX4v30mgYvzAOpe+LPwLfIC110XpA25hxZC2dCHyNdMk81hMqWc84BnsMP1qBv+zgLTg/stumK7sT8KTgZBswxaVeSNjghnGiVZcxEi4aP+b6Z4gBljUVmDqvt4+POjVzykQ5EVfTMfarJnFmhuvUAeD57nTyOeFumE66qbZvehnzPcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NOQCXQXiXnBl4TV9sBNUJ2fekKMtpCDtdbNmNIODdt0=;
 b=J0BIV60c+iguX2UeuyENk4ASbg3Z+lWlrqeYFXnzWoQzzmzoz24IuHFk4OOrFDbHAlAj3D4wE5/YBE0MYFMYbMY9tUzlbXEiyu6fXqsGngIMcuKbPD6eTMPvwBidp4GXEhheTHGsAwkJMkiyOGLuQfqHn9IRdkWWx9IKtOzdgxtl88ZspEK308UwjwZ360nw05LvYiUaGXFyzgHzE1yU6r+g5oN6uWofDZnmXZ0nUGRGQy4mdaqD9wVLjmemPWy77t4drjbQVuN/URsvH9GoqG03YiVPwo2VCEBBWpSxuwxH3zlxJ+s4Lo1GlaZUOPJpqUZlNRC/DHmS84+53ZKI9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NOQCXQXiXnBl4TV9sBNUJ2fekKMtpCDtdbNmNIODdt0=;
 b=qJenMIASjEca2y7S13YXABXuMdX3vn7XI3NnpcP6Gt08P7KD7fEBDteWu1L/hL9A2x0QRjneywphHtQ1GGqWN8hPPuSJt5mj51gnH2SNfVXyON/6rDioop4cjmY0FhAsUs8gyncGdpVRB+qLjd+sDkAQhl0/urcRxao4MgBSEH4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by AM7PR04MB6840.eurprd04.prod.outlook.com (2603:10a6:20b:10f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 13:32:07 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::5a4:421d:f180:9105]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::5a4:421d:f180:9105%6]) with mapi id 15.20.6500.025; Fri, 16 Jun 2023
 13:32:07 +0000
Message-ID: <5139b72e-cccb-43b3-ba37-35f0011e4a2b@solid-run.com>
Date:   Fri, 16 Jun 2023 16:32:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 2/3] dt-bindings: arm: Add SolidRun LX2162A SoM & Clearfog
 Board
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Shawn Guo <shawnguo@kernel.org>,
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
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Andreas Kemnade <andreas@kemnade.info>
References: <20230616110610.32173-1-josua@solid-run.com>
 <20230616110610.32173-3-josua@solid-run.com>
 <a9098664-ac16-eddb-3e2d-78eb08ac973f@linaro.org>
From:   Josua Mayer <josua@solid-run.com>
In-Reply-To: <a9098664-ac16-eddb-3e2d-78eb08ac973f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::17) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|AM7PR04MB6840:EE_
X-MS-Office365-Filtering-Correlation-Id: acbaa567-7786-4868-7210-08db6e6e1462
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oQva8IGnayGJoEI1EXUpLvGMtcE8ByfE8KcuF6iEBnD2en4QfQjcesbGjtd/2ItLwyFEQbL8Z02PDrTuxsxgqlUAsN0jbVu3OESFAwdFj7yDtn3M2gSaNCOBj6yUdcgoJ7yjFOuuU8APnvr0wNUn0HZAY6aPN/KGIT2a8oVKsUU6qc93UuHap/sj4+6LB/t7Zu4rk3ytvF2OIex/DUhmeVBeh2t4oMCuWi2ZQtcl+Bm7SjmQ5SyDnyI4VdCk/K9LHPuAdVhHbjLM+ZrgrWyPay5Tq+3uKH2XqStKmZxRSIAAdnnpW5lVfN7mEpfEFWkYBEX5+2jIxyptts2SSSaU67GjUVADmSEXiAwW6rnqBPbBVugT/heKQBPA0QO9TinCDvU5PSleoLXlsXRDVEsGpbff9PwpJBXy6FH2YzLO1ozCV58Jz2X+wyFos8Ur3S9SB+zpLLaF4Wg4ZJLudDunv4w5jeZWkG+Gg/8M3SValwlF3EVeY1riI6hlOqkWfnyAt3xN6JvjANIufiakGElPvc7xn9Goqm2k6yEKsiYwGEY6R4NuarJNJ4xbjcgc+nXKiQEKpeBNsWOFTP+h/vql5zywfsXMlpAmmxhQcTwUNaoCpsZa2fa29VUmB6nUN4nPW/40WAtLnSNO4zNkSGGAnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8963.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(396003)(346002)(39830400003)(366004)(451199021)(38100700002)(2616005)(83380400001)(2906002)(36756003)(8936002)(6486002)(8676002)(41300700001)(316002)(6666004)(5660300002)(54906003)(4326008)(66556008)(66476007)(66946007)(31686004)(478600001)(86362001)(53546011)(6506007)(186003)(7416002)(31696002)(6512007)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDgxZFJjUElWM3A4U3BHeUkzVnZheUtmcUJ2Zk55c2VXZnptNW9oRm55M2kz?=
 =?utf-8?B?YjhxWEU1UmR4ajluSWJxYUpTWmlhY2szaHkyUVJoa2FtdGkwQThFT3ZDT09a?=
 =?utf-8?B?MTAvcEx2cm1yM0Y1MmlNSDc2d3dnbEttcGovMG1hSTVUNGVkMWpqRFF6eU0z?=
 =?utf-8?B?U2dIUmtWMDdHS0pnMFJwUXpRQ2JlUDEyTVhWRm02WFdmNnRPMnZVOGFkdUgw?=
 =?utf-8?B?bnZMUDVxeUlDaW9OdjRxWnFYalhKby8yRk9RZElVWXNlM0tNYmpETlhhSFFu?=
 =?utf-8?B?VnIrcFhTeDhmSGREYWxVR0pCVWNEaEZVZ3g2K0o3QmFzTldNaDlVSzhGOThG?=
 =?utf-8?B?cVZsQ0pRU1docUxSV1I1TzQwYWpkaVgvVWhiWjhtNHRwOHhING9BVGtZYS84?=
 =?utf-8?B?ekJRV0NnNVA4RlYybWNxNHk2M2NaRTVaeFBMdFdjME9XdUFjMkJORVZWVmkz?=
 =?utf-8?B?TE53OHJ2ekw1eW5wZmFSTmR6NGtRZWZrSElZNXBFR29OLysvd1FLWjZWKzM3?=
 =?utf-8?B?VXdYT0dVRWZkb1piZTlubkE2Y1RHdHFySk1KZm9lWWRmYlZBdDRiRXlYdUJk?=
 =?utf-8?B?R0dsenN1M0V0Q1VRZFpyZ2FUYWFET3B3Tzk5T0lROEllbGpBK05jSU1hb2pO?=
 =?utf-8?B?RzBRYlZ3WllpZnAzSmhPdXNKSTNsY1FLZm41cVFzakdxODVzaDlmWWxPdG1h?=
 =?utf-8?B?dkU2c3J6ald1STRIUWRyaTRpQUtkZFYwZGUvTjV5U1JUajA3NmgxeWJtRUtz?=
 =?utf-8?B?OXQ5WWd4aERXVWpvM25mRmU1VXRPUndUcXZrNnEvM0g2SnFOVUhPQUNMRlhS?=
 =?utf-8?B?RkhoT3RNVFpxcGRBRGJRL2pQNzdZOUZZSjdHdDlPZEgzQm9EOUVBODlxa3p4?=
 =?utf-8?B?THdObUlyWm0rOSt1aW81YVlKcFJXMy95b212S2pPOU5YSkQzdzU2dWMzVHhh?=
 =?utf-8?B?ckxENElIOCtCZXMxZW1XU1R0cm9mVDNlNjA4b3Bqbzl5TzR3QUxUVm5DcWxV?=
 =?utf-8?B?dEJnOCtRVktXbmVpT3AzdTRCemVMRW9EQnB5NXZaWWR1VURjTCsxb0FZdGJR?=
 =?utf-8?B?U1E3L0JFTlBlazZESkQvN0w2eHNhZkplSFdITEozVFpjc3NjRW5kdjhCL2NY?=
 =?utf-8?B?YnRRZXB4cUNFcVhFQk1hc3kyVTVGQlBGQ3hCWngrc1RUU2FWQXFjajRwOTJy?=
 =?utf-8?B?VUdtRWhUSU84NXRocDFiUElILzRLeU9NVVkxcElFRTRkYndHdkZ6b0VPTHZW?=
 =?utf-8?B?ckZXRzlhTlJ6a05jK0FUdnYxeXN0R3RDZERzYkpPWkFsSnVpbkxzSFZrMEFB?=
 =?utf-8?B?NThpZjBuOHpzYzB0dFRtTXVjKzNJU3J0dmhMeXBHK1VGSkpFS1pMSDRYZTd4?=
 =?utf-8?B?YjgxN3lFL1hIU1ErbjVLV1BwMG9VVlZVVEFQVzlhVEdpSXY5ZkNwMGRyc0o5?=
 =?utf-8?B?Uy9WQmtETVJwUWJpOXl6RjF3VTFobmV3dHRMTUdYZUNNOUJXRjFaT3daWHNF?=
 =?utf-8?B?cGxGMnMrL1grU24xbGYwWjZ0dGNjRXNCdFdSMnRzTHVVV09vbHFCV1l5QU5W?=
 =?utf-8?B?aWIvcmU0SVFOeGEwSlFaODJtd3drQ1k3djdOdzdjRDRBbzNHYnRxWlN5ZUM4?=
 =?utf-8?B?VGtpc29jWG9nQ0oxTWV6NTBvSnBleEJpQ1Y0VWFzZW5YZVNJUktGemY3ZGZQ?=
 =?utf-8?B?dDhqSU85L2JVQmxGdDVCZVEzN1NzS2k2U0k3OEVRQWtxZ1F4UVNGVlAzb3ZX?=
 =?utf-8?B?SkRGT1I0b2NQbngyTGJZZllMRTBHTTVSUDM0b1lrZFU1WXB2TVkyTGZPa0FQ?=
 =?utf-8?B?ZFZodmVpR2pBVVZTelc0OVhhcDJ6aUZYaWFYRUxtTXVZdVlKdTFDUWpoYko0?=
 =?utf-8?B?d2I4NG9YOG85NHJ6MC9xNE9NSEwzcW45enFRVGh3Z0FJVWZWZUVSNm1mWHlh?=
 =?utf-8?B?ai9SRWZCK09iWlhDNks4VEJtbzRqOHo3dXVCSkU0TG5CQXE3cGFSaHAvRjBs?=
 =?utf-8?B?QnE5VGw4SWxpMXRVUWVDVWxtM3ViSWpZNVBnVkg4SXlGRWNNR3hReksyNDFx?=
 =?utf-8?B?VXN3WTJwUlhxWmZWQU51ZE5YM0tOVktNbC9DNk15KzZYTStjbHBBb09FQVRW?=
 =?utf-8?Q?lJ1GjRlNrLPpHp97MOhbRWkPX?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acbaa567-7786-4868-7210-08db6e6e1462
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 13:32:07.2958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O21qSd2Vn6WZyi1iCDpTEidfYEMi5w/iLO4Cvn7N8fZwfGtkrbi8UuaFPtJJSOBb0GFFYcfjj/bFqb43jntJKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6840
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Krzysztof,

Am 16.06.23 um 14:36 schrieb Krzysztof Kozlowski:
> On 16/06/2023 13:06, Josua Mayer wrote:
>> Add DT compatible for SolidRun LX2162A SoM and Clearfog board.
>>
>> Signed-off-by: Josua Mayer <josua@solid-run.com>
>> ---
>>   Documentation/devicetree/bindings/arm/fsl.yaml | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
>> index 15d411084065..438a4ece8157 100644
>> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
>> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
>> @@ -1373,9 +1373,11 @@ properties:
>>         - description: SolidRun LX2160A based Boards
>>           items:
>>             - enum:
>> +              - solidrun,clearfog
>>                 - solidrun,clearfog-cx
>>                 - solidrun,honeycomb
>>             - const: solidrun,lx2160a-cex7
>> +          - const: solidrun,lx2162a-som
>>             - const: fsl,lx2160a
> You change existing entries, breaking boards and changing the meaning,
> without any explanation in commit msg. That's not how it is done. Please
> provide rationale in commit msg.

I'm sorry. Given your comment I think I did not understand how these 
entries are supposed to work.
So perhaps you can provide some guidance based on my explanation?:

- NXP LX2162 is a smaller physical package of the same LX2160 SoC, with 
reduced IOs and some silicon blocks disabled.
- SolidRun LX2162 SoM is essentially a different form factor of LX2160 CEX
- SolidRun LX2162 Clearfog is the reference platform for the SoM. 
Despite it's naming similarity to clearfog-cx, it has a different 
feature set more similar to SolidRun Armada 388 Clearfog Pro

So I believed I could just add to the existing entry "SolidRun LX2160A 
based Boards" also the new LX2162 Board & SoM.
I see now that adding a fourth const messes upthe existing 3-part 
compatible for those already existing boards.

Please can you confirm if it would have been more correct to replace 
"const: solidrun,lx2160a-cex7" with an enum?:
enum:
   - solidrun,lx2160a-cex7
   - solidrun,lx2162a-som

Finally, is it okay to add a "solidrun,clearfog" given my explanation 
above, or should it be more specific "solidrun,lx2162a-clearfog"?

> Best regards,
> Krzysztof
Sincerely
Josua Mayer
