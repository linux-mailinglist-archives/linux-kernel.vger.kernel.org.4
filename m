Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B4D60D50E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 21:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232499AbiJYTzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 15:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbiJYTzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 15:55:37 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60115.outbound.protection.outlook.com [40.107.6.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81B83B94A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 12:55:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btQclWgDDYPr21I0BvwPl16cSNgZL+Y8HoXg27o5NGGwiOxojJjAKI4KozLoYIGE0C/2DPsKvWfnv1BqxxnX6lTzvS67tiU1ONyoQHi6RDDitoqW7I2stq2IEFD3RgzEPsrPnSXfAEfz8tHy7/8Ie6CBQNNGBCTp4HhwUAeHberVtqF7+rIGb2w9K6Yrq7ZNItsagPk8Ipf8W2GjdmgGOxwa75lvLeRSzH2qWWrNQZ1j6pblf7FVxsA3GdzqrOdnXJwHJwKi3bUlGAUR3S8TwSZiKdDDSi5MzT1mFkxRtPrsC8I//qly2ICESSD76cG8JEMct0oihCdMfNMh/KFTpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97/6JQ+vsuKMbVyD99J1LHv3nIKE4iphfJ8iLB6a/EE=;
 b=lR4NNAba3lBWVxBqK6+hnl7azUC1ya41z/WkvqotILZAr/8ZY10fDPaX5hjzi1xT83FnYpPiJk10a5+Kxutg25YoFYvPk7vMSxPSmXY2BO6AE/gWqUwzus7qG/w7qLwhjvMr6KSuoitOhKwz9XPgw0dN2WB1u+1gD2wu9Kg3s5A3eMa8JPGsP9pMHgBjnyNsx44p3+S4l9kGBroegA1fbFlJVPZn1592CyVMj2AiU35UuMc9a23RYbfzas2ohyACs+57sRKLfYWodykhL5caIz7VXvYUtDgitEYCP3b+6MKIjdUz3If7ttgXHCc5wTD9k8uq+fcWa8hiJAVoXM6O4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97/6JQ+vsuKMbVyD99J1LHv3nIKE4iphfJ8iLB6a/EE=;
 b=Z3u8xhj8xztvtVFDXI2v9rtJ+dzAdpAeKZVMVWiCSucPbqECkdD+CRKDX5LWLt5XPTCtOM11y4RFB55PK9+Mt2wfp472pbwwWzamlO7S0jbS4qLnLqnL26DYQpqoQrNYMkkb3yU0ldcsSpiPc0y1jxTrp6xtzU1KHPHc9fy2zqk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34a::22)
 by AS2PR10MB6428.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:547::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Tue, 25 Oct
 2022 19:55:28 +0000
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::732f:4316:a0be:bdbc]) by DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::732f:4316:a0be:bdbc%3]) with mapi id 15.20.5746.023; Tue, 25 Oct 2022
 19:55:28 +0000
Message-ID: <7695dbae-0fc6-d53c-5b9f-b3bd7e7fe8f8@prevas.dk>
Date:   Tue, 25 Oct 2022 21:55:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] lib/string.c: Improve strcasecmp speed by not lowering if
 chars match
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nathan Moinvaziri <nathan@nathanm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@kernel.org>
References: <BYAPR06MB557347406F22FBA1E400A5BFD8319@BYAPR06MB5573.namprd06.prod.outlook.com>
 <CAHp75Vd4Vk0v-T3kfxApGHb-H26KTHgH59DGP3Wm4qBgunDt6A@mail.gmail.com>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <CAHp75Vd4Vk0v-T3kfxApGHb-H26KTHgH59DGP3Wm4qBgunDt6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0027.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::34) To DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:34a::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR10MB5266:EE_|AS2PR10MB6428:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a1141dc-a870-49c7-19fb-08dab6c2dd7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jLWd3ov5LWHsu/e8Cec1TXgNo52kOrdvkDmXUFImfiLAzB1L3io42sUzlfmNi+jYTtaNiWa/kf4G7JGOYSmmDXP0lX+sxVDjxaTOmHw+fipHU+Sui0OueEZwRjZ4j5xvZNkyYtet/B0uT3gmhd1AxCM8QWsZUWzqyW4xlbMXCpsLFj+rC+lHd7VKngpZlnqD7yBULcDe9n28JtnV8AhseFA+n8Oh9ZBP/+5+dOXIFQKlJArEjb2DTMTzfgp2uBCrXzq6HtQeE65zmzJ5QoEe2Dw7/FjB0z0F1Etr9IitR2cf+cTLZt/2vSdUZl1v4sg2V3XMfqoXouCljwFMzlXwEkVzXObLuL1Aj/RF5MgdhVToW2dHy4XsXqwVNfg0Xkx5E8cT7i9p4bW3xFSkcb4kkqi3s7v0dmJllQ5D+cnxke9LBTh2ZSmHfNYHJwVUrH99GeiWmoa7Hexc1V6NsEy0CGs2oiGW4VBGpmRW5Bxehpza3nmR77iAnUWYR0fAefWBLRKuZVZiDrAKRUME+f7mJeVl8kCnmH1zLIcGDlH35yPah/WxfgZf16OXr4AAfowc5RMtSxak+N9txjsPtkY7bXYwLIaslR/eFCLHIZ5y8YvJ8fDYQVYVLwtyOnaWidfpUzugGaqG4DC82XrObG/l3rZJtyuipw7wTwFBUdGlQXFVxLQc3CCeS7/maPqomzb88T5atqdKxABhe9Nppq0VgCeyhBIrwC3G0KyeKn1jMhSCfNun1EFMOqXh4w6DNur9eKNqyyKMJMK/2RxtTUtw5SDz6SeResPhNpQ1dD58zEGCFA1920Ss7cVvTgpaUzgyayc4rF3MMnla8Ji1gAZdQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(39850400004)(346002)(396003)(136003)(451199015)(31686004)(478600001)(6486002)(31696002)(110136005)(6512007)(54906003)(316002)(83380400001)(38350700002)(38100700002)(86362001)(53546011)(66946007)(66556008)(4326008)(8676002)(66476007)(6506007)(52116002)(36756003)(186003)(2616005)(41300700001)(2906002)(26005)(44832011)(5660300002)(8976002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3NOeFp4aUdwd1NlTlNFemFadUVUNFAwK3B4NXV4clBuVnV4LytBeXdUc3Fk?=
 =?utf-8?B?YVRKa0d3YWo2dEJXNTFmbHh2endPQnV5azd6a2dacExGdmQzeUpIV2V3K2E3?=
 =?utf-8?B?WUo0ZjBNWWN1MUN6M1VBT3RuSXF0YkhpWTBBdE9uZUY5N25mU3lnRHpLUXNh?=
 =?utf-8?B?VGdoYVZTMFJKK1VGMW8ralljUVdYS1dnMnd3Q0NwM21OMDJGdU02S1VZQUxI?=
 =?utf-8?B?SWFZV1F6SW9zNCtwcFE0dXRFYWlNaUFrK2RxcXNXcEg5cWpoK2Z2c3Z5YU1s?=
 =?utf-8?B?MjdCUlNxaWYwV3FjNk54bE5rYzdSbVNGVm54L29xeUlXM2pHMEp2SGJPQUdJ?=
 =?utf-8?B?RjhjVDRpLzlxQk5BUERMZzBxR1RjbE9JNzdzakpjYXNUcUFuQWczczU3QVFT?=
 =?utf-8?B?ZE9NeVRQOUhZb3pIc2h5ZlVGT0RoMVdwY1BtWFFOdWJ4bGlMZjJXQzNUNnhk?=
 =?utf-8?B?aGFXRVlKL0t2QWFmTHd4MjhtcDIwVWdHY3VRMG9NUmdPRFJJUUVrMm5ud05W?=
 =?utf-8?B?c2dtUURoeExoS2NIL2F3Y3NXR3hFU1U2WjdNWjc5aWxCNm9WY2oxV1Q5R0Vj?=
 =?utf-8?B?V1diZE9nUVRndHUxcXAyWVdZd2laUm9ucjQ5amd2VVF4cyswTXZwam15bVFQ?=
 =?utf-8?B?RURMazVJZmgxTFI2Y2RlSTRXV0hReUIwR2puNXhTaG55NWgyd3BDVGNQNTJE?=
 =?utf-8?B?RzlXajNuSFMxKzg5enBJMXd3d0d5am1WdXFhSVJRaTdNYm1vM0MzVlg5dXYx?=
 =?utf-8?B?V05VN0tYRG9iZ0dKeTczeGc1UXJYS0hCQWRhbkxvTjNJbnA4TnloWFB1VEUy?=
 =?utf-8?B?TVBwaFdVL1NhcXhObEZBT05JSUd2YjRIKzdyY0FpZlFFN0FxY2NUNnBPeUlm?=
 =?utf-8?B?cmx1TWM2NkFBMzBoV0d6OENhWHYyTWhLWGxoZlpIL3pKL0FDUUxRMWl3Zk1V?=
 =?utf-8?B?WE9Kcjg4cmtPaVdmZkRETGVUWUpzbUd1U3QraW04Y3l1eHQ0V1QrSEtiZUg4?=
 =?utf-8?B?ZmhtMDhkNDJBZTQ2cG5sTWNDdS9NZ3VHcjl3aTdaNlVUbGVrNzZBQjZnZ0hD?=
 =?utf-8?B?dG9MemhsczFZbGVEb0dmWUcweVdCMDZkVWNvNTRCRkk4MEo1T2x2R2tScDNj?=
 =?utf-8?B?dlVEcC9uTCtlVmVXeGJkcGVOM1B1Nm5yZ245N2g3VTdJUEFKcGJadVlOS1VM?=
 =?utf-8?B?V05hd0xwSjRYcnN5TkU5TTBqMlhPYkVxdTZzUXZ5dU9iLzl0TEtUdGxEY29J?=
 =?utf-8?B?dHBjMFlYSGd2d2xybFlBVDNmL2VwajNzZWJUWCtoNWtCN21Vc0hhaGdsczZq?=
 =?utf-8?B?czV3dEY2MS9td08zZGNSVnF6WWkvMlU3VitjUE1QbmRFUDBZVXd3V1V0U2w4?=
 =?utf-8?B?K3R3N0RuTEdFd1d6dVpXKzY4RkRVd3oyaE1haWNRZTJJL2xtU2N5YndaUFBj?=
 =?utf-8?B?UWJ3Y0d5Zy9xMTk5Qi9jR0IvMVpSTFl6VEtzOFZadzE0RUp5Tkd0ZU85WFZ0?=
 =?utf-8?B?Y3VCbFFBenhVa3h5TE9KRHR5eE44SmtFeStBQkRMbklWWjM1b05EMDk3UVhN?=
 =?utf-8?B?akFtR0N5YUFBNUg2UVhXL1J4aHhIa0tKdzNMSGlBRWZ5dUZFZW5CVlFGZzE4?=
 =?utf-8?B?OXViSGNLTndaMDgwL1ZyK1JIZTBHOVFZMGNyaFJEc3hoY1kvczBpVHZ2WVBJ?=
 =?utf-8?B?MU1KRVNRY2ZEaU4xb2VBK3ZkZTNMZHBhTkIwb3RoR0M2aERNc08xTzlsZGQ3?=
 =?utf-8?B?RzU1RUNiVzEyZFZrd1BXeUkvak5mUHhHdXpWejNrVnRPMDdqYldralh0R0pL?=
 =?utf-8?B?SVlLbGszamV4aTRUSjNGT0svRjZHa2ptN295Q0RQM1Q4VFlnU1U0bVc3VGdR?=
 =?utf-8?B?L2ptVjZHRHBEa3ZrTWoxeHlUWWRGd0piM2R2NUpjTXJPcG05YjdXd3cxUUhJ?=
 =?utf-8?B?K2FUby96T29FVVQzUlVqb1J3TS92QXVrSFNMYVFGTnYySnlIN1RySTR1aUZT?=
 =?utf-8?B?Z01BQ0xaTWtTUUZudWx5VklhcU1pNEU1djZ3Y3pKdnN0SlBYVVcxeFpnSEdm?=
 =?utf-8?B?ZEtiNEE4OWFHRGQySzAzMVFvM0JoSUIxMEgyYXhGcVVta2YxWVlJU1dPd3hu?=
 =?utf-8?B?NVBHM1U1TFJzN0FWVzJCd1c1UWJCOExUR21jT0JIK2tJVTZYb283TXlPRTQz?=
 =?utf-8?B?N1E9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1141dc-a870-49c7-19fb-08dab6c2dd7c
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 19:55:28.3873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9CcJv4R9TzBYF7bi6EkeSVrfvUWS8WY645PQsewSEf36terD3i2FmeMuXdIINvUp+S1VA2oU8VRmvIn+LKynPTNWrWiahvtdnhqPEvFFuVc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6428
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,T_SPF_TEMPERROR,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2022 10.00, Andy Shevchenko wrote:
> On Tue, Oct 25, 2022 at 4:46 AM Nathan Moinvaziri <nathan@nathanm.com> wrote:
>>
>> From fcb0159ee74908f92adc34143657d8ca56e9a811 Mon Sep 17 00:00:00 2001
>> From: Nathan Moinvaziri <nathan@nathanm.com>
>> Date: Mon, 24 Oct 2022 16:37:59 -0700
>> Subject: [PATCH] lib/string.c: Improve strcasecmp speed by not lowering if
>>  chars match.
> 
> Why is the above in the commit message?
> 
>> With strings where many characters match exactly each character is needlessly
>> converted to lowercase before comparing. This patch improves the comparison
>> by only converting to lowercase after checking that the characters don't match.
>>
>> The more characters that match exactly the better performance we expect versus
>> the old function.

> You tell us that this is more preformant, but have not provided the
> numbers. Can we see those, please?
> 
> Note, that you basically trash CPU cache lines when characters are not
> equal, and before doing that you have a branching. I'm unsure that
> your way is more performant than the original one.
> 

Are there any code paths in the kernel where strcasecmp performance
matters? strcmp, sure, but strcasecmp or strncasecmp? I don't think so.
If anything, we should nuke the complication in strncasecmp(), and then
make strcasecmp() simply do strncasecmp(a, b, SIZE_MAX).

Rasmus
