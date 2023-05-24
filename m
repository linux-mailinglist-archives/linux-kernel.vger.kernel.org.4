Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1380970F79F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 15:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbjEXNaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 09:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234399AbjEXNaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 09:30:15 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2100.outbound.protection.outlook.com [40.107.22.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0513BE9
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 06:30:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TR8o5lu2pnfHLphq8sQ3ZZsIH38krZDAhg3Ov2D8+qupDhcbqKXihLcVP+YMIJC9Op9fDGfRdJAkQ/rUqSnb1lT/Z/1UNd8yNilnaLDqKWUEKxHfeGthkZvrqW/VPVMMYOw09e9fHrrIKYoFSMYt+LUOk0ShGyK5nzvAxFdSiEFIYKYy5djOCwEn3b5Oog3XuPNnN2qPb7gAR7Bwa/EqgTRmlIkbQjsiwm1bdoNDiseOwxZE52YJb1HCsPYL9icxmzNNd/lKobtAi2zjNPAgHyfHgvOxuLp3vwCtsMoM9cLwR3hy2sgEdBPG4Kje7ToJizWSgjx1Uv8J1V/AigCfMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9eepb3a57ozjJU6nNmtgst05xl3a1+RNKW946hLsXE=;
 b=YSuU650CAzB9psDWn8MxLSMwKamEvUtndBqlvekiZBGwBHRQnHb6RR8uquGd/v1yoHu+fPMHPz2sqk8wiEdOBwkpMIZMpTFnamN3Fa6WtV+llrlOu5H+vlzCkPpqgrL5C82CrNc4YXs/1jFw0wM3ThcOIYpdoYw29he5oQsxaWgL2msy6gi+amFk5IFqveC+rpVWju9fZqvn7sXr6ZxTE25PDRo3HPt+Vq4OQRzb1c5ktWsWa/tbazIWT4vcDbLcEyMk7W7jJDt0U3rDvWxBJfwrR9MYBdA8l4n0R2y3a7fNnqKMCvApvffPoUDH5DZ3AcSOaKpCkVzu9cNaAosprA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9eepb3a57ozjJU6nNmtgst05xl3a1+RNKW946hLsXE=;
 b=SsRUxyNsjLAK7T6akUU5eegSatx8+MDPBNtEGN5+pIaRfw0gxCcZaQXflj4uAT5u1wkNb5AGtm+aLii20vifFK/ZsEu0dcXCTiiODN2f3PbN0e0AODNPDKJXhUmB0geR+edKLwWCP4lihcNjc6ez9VwwgcPwNxexwoqw/kUELLI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by AS2PR10MB6688.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Wed, 24 May
 2023 13:30:04 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8edd:b6b0:d2dd:ee12]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8edd:b6b0:d2dd:ee12%7]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 13:30:04 +0000
Message-ID: <33d57180-aa13-4178-86e1-c4cf6ef29a6e@prevas.dk>
Date:   Wed, 24 May 2023 15:30:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH V3] soc: imx: support i.MX93 soc device
Content-Language: en-US, da
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
References: <20230515063730.2042715-1-peng.fan@oss.nxp.com>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20230515063730.2042715-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0023.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::24) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|AS2PR10MB6688:EE_
X-MS-Office365-Filtering-Correlation-Id: 99902de6-c3ae-4cfd-7f7c-08db5c5afbe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P5TiXLizDVoozqMxRFEwvkkQ8lOr+IxlTu/XzTmvxZBAROLef01NxIPEEGOg1Qb6msTrNmswQTMaRvNTDbPGi0sJesPG34M1Ol6JU1KjvJOb/KG8VJXaRMD2e8WXJV4Z4nJlAkFAnsrr5cHjT+TqhMp//xVndoLmpqe4RQzWJXm8mLD8/RiUxaWhRL0IBUMMdVttLHABC+B4zfvSRrWORH+zmd0jTNWEltZ1W3POCPfDDIKzX+7YA/Z/4Jgg/88ICUYHehOCOYFu5WoQPkdH40mQLIkr/7Od0AYFg+VQPJP3a2b4Cl9kz2MmgfuoYRReARzdt8pd6mwpEwcKX808zxuqUyVLOTiYlvkqoA9IPCQBcf5CKZk7BlMM9f9Z6QUHSuvQuDp9slbgqKqNKZlgSIkQzTnn6qiGp8KSjZRmdkrZIwPaqV7YdTNICbbOjBID71VZT73EDIE+CRl51l+tnk6sRo+QrU/NgQGbuRIhO5L4ypDvvA9/Ols9TdeBfybdd/VDlgjZo1+x1qhJoNRcMjvu0ejVd7oXKovenMicCoSnSe68H0LRPNlpdOnLB1mOv4ffr+dfbLUUm0Xrhw9qLrSR+3HRh2jkkFoc2T15mAT7g0LJSA9i3z+j3R05fgJAkBpddj8yXszWUeJlxmRzn9GVpButpwNu/1BJc87P6D7KWAJQxz6bOURR/VMLfzji
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(366004)(39850400004)(396003)(451199021)(8676002)(8936002)(8976002)(86362001)(31696002)(5660300002)(2906002)(6512007)(6506007)(26005)(36756003)(83380400001)(2616005)(186003)(44832011)(38100700002)(66946007)(31686004)(66476007)(4326008)(66556008)(6666004)(316002)(38350700002)(478600001)(6486002)(52116002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzRkWWRxU01zQ0Fvc3hDb0gzc09nbTNndWppMjQra1dJUXhTck5HeXRqUlcv?=
 =?utf-8?B?S1ZKbTNLeVl5b3B3c2w3czJ1am9TdnpRVFNJNEVwMEVzdUVGdHNTWnkvalRo?=
 =?utf-8?B?aFM2a3M0aS9la1BOUU1jWmFLcEJxNXI2RDBwMndaSXhZN1hrUTZDU1ZvUUYw?=
 =?utf-8?B?RnJLaG1ZU3BHQktneXEza3hhRGNpVHc1MkcxVDRaN0RTYVJVS04rM2JuaDJO?=
 =?utf-8?B?dGJYYTNydkE5Um1iWEtqcC9NMnJ4WUFiWndtZ0c4S3l3cndFVlI1TVNUamFs?=
 =?utf-8?B?RCtYanN1N1dPZWlzZ01nSDZhdXZWUlFGOHFBUlFJZ01aOW8zTktYVzYrd21Q?=
 =?utf-8?B?RUZydGtUNHgxRmYyeXo1RFp1QmRsM1ErSHdYdHRXZE5pRWF3TUFmejRwS3VT?=
 =?utf-8?B?V0NVVUFHZ3R4TGRqclNSaGoyZmFubWYzWi9GUEVFWEVwZ3ZLVDhQUjBCUjBK?=
 =?utf-8?B?MVhRS1ViMzJzeis2TFVKSmxwcUlZd3g1OUJ6YjA2bk9XdDdtVW5lZVh6NjNW?=
 =?utf-8?B?Rk5SaG5GdVhGRzJDa0VOOTRueWlOV1MxMEo2cWJZc2xVUkMzcFYwYUcxTmxn?=
 =?utf-8?B?dzdmVFlaVmRWM0pQMzNCTjg1c1ZOODBuZjdYSWt3MEp1cGlNUVh3VUw2QXVL?=
 =?utf-8?B?NEdGREZVZGFZcEZ2VU8rbWJFcmpkcWdBRHFzN01LTTIxOWV4VW41RVhPdXNV?=
 =?utf-8?B?dUFPaE9zVnNsdGJQTkJrZ2NHTjZBc1JyeUpuRllkWDBydEoyNUxMeTV2MU9l?=
 =?utf-8?B?RWFDSTA2bGtMNXFDb1FYMVZsZDR4VHRYaWFXVkQySUN2MC90K3JkMkN4Rm9R?=
 =?utf-8?B?T3dhb3E2UW5Xc2xmUSttTjJuOGphdEU0b3lEUzZ0aERTUHdVNnkvZXkzZGZ4?=
 =?utf-8?B?WXVaTGVaa1hzSXdWSEE0SlhxV0NodHN4SGV1a1NMbUttMGtudXRUUDZYV1p2?=
 =?utf-8?B?ZGk3ZWUvdEhaUjg1MUhqT3dXclVWNUoyVWZPQ1Z6UVlnWWx6OFNwTk13d25T?=
 =?utf-8?B?aEhRcy9xdGtIU3FJa2VIZUxQZTBEMUFFUGk1cVpsYzhPb21aS041MmlnRWNu?=
 =?utf-8?B?emRMV0M1SzQ0eVdSR1JhTzdmQnpWYjBON3ZrekJtT2NXQWZhOHpJYTltME9O?=
 =?utf-8?B?YlpMYm9RMHVyWjNkT1k2N2NLMnNrSTh6RHVBM0pwYjVWVGE3ZXU2WkpvdVRC?=
 =?utf-8?B?N2l2c1RWM3ZqQW9YbmJLa1VzN0p0dzI1QWNUSVB4d1NBL2VXU1pySGZmeVpa?=
 =?utf-8?B?V3RWSnRxY1NiUU4zSVgxcWc4WG9sUEIvZ240bUlPU1plb3hKQWhyK2MxNlVQ?=
 =?utf-8?B?RkJ4ODd6dy9hb0t3aWRyclRBUXEzdDZSSG1qQVVqRS9jdElLUWs0RkpiOTlL?=
 =?utf-8?B?eWtQVlBqbXd5UVFXNm5ST3pCV3Jsang0a3dXTlQyaklCbFUyMGFlRXllajhY?=
 =?utf-8?B?c2N3NE5xejBDSmh1L2IwWTl3bG5WUE55R1hWK1FWcWNYZ0JzWUxXeXYwSWdU?=
 =?utf-8?B?a0dmRzM0Y2MyZGNVOUxrQVJLaHdPYUVyV0x2ZUMxa3ZOTkdVVEZkSERUTTdl?=
 =?utf-8?B?NE1ieUlzTGhOdWloOWFmU3ZXMGM0T1Zlamw4YmJyQTZZYS9JM2sveWFkT3hi?=
 =?utf-8?B?Yi9jdVFxSEoySGM2WEVhRFNMendzaUE0TVJBd2s4L29ybWI4RzYyUVpBVzFV?=
 =?utf-8?B?bFBwOXloTXBvREUxL2o4enFDbjJoenF2RUV6Q3JMU2gzK1VpN3ZId0kzQXpz?=
 =?utf-8?B?bGFRblVmaHVoM0NhWUdUYy9vMzdTbFB1YVVITllNcER2bE82NjV6bU1VSTh2?=
 =?utf-8?B?NDcxcXU3MW85dk5VMElDQzZuNzRCVVpzOXRWSUpiWXNFT2x3U3VXZXJyalRu?=
 =?utf-8?B?MjlrSXdEdE5pMkxJQkJZUDB5Y24vVzdxYWI0ZVUxOGVQYjNnWlpsQ04wWXFH?=
 =?utf-8?B?OFpDbnRwM1pEaE1Yd3VRRy9UZGw3R1VKYkU3YjNxU2JlYlBjOFR3L3VBOVky?=
 =?utf-8?B?bi9Qa0xQQXFxdFV0TjhDbUk4eFZMY2dXcE9qSUtML1BDRmlsSXA5V2REYmw1?=
 =?utf-8?B?UjQ5UzM5ekUyaVA3SDAzWkFRUHhJNzhPc0k2alFOdlFzUml5Lzl1aVdSWGoy?=
 =?utf-8?B?U29EdkxISXZMU01TMGVySTc0QnVWcFhzZEQyQk1Odzc4SXcyRXM2K0Rud3Jm?=
 =?utf-8?B?R3c9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 99902de6-c3ae-4cfd-7f7c-08db5c5afbe7
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 13:30:04.7878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kcvBLroBvFdC4jSH28oBi2aohmUwZgn6K81YZOD3cMo0pNxXsIC9Ys5XEFJop8BvGbmD5QfrA28vB5CaRLVcy+6HuXiiEjRhcigGSgxu0wo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6688
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2023 08.37, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX93 Device Unique ID(UID) is in eFuse that could be read through
> OCOTP Fuse Shadow Block. i.MX93 UID is 128 bits long, so introduce
> soc_uid_high to indicate the higher 64bits.

So apparently, the imx8mp also has 128 bits, at least according to the
reference manual, which mentions a "UNIQUE_ID[127:64]" at offset 0xe00 -
0xe10 (i.e. bank 40, words 0 and 1).

However, no further mention of these upper bits can be found anywhere in
the RM, or in linux or u-boot, mainline or downstream NXP. Furthermore,
quick experiments on both an imx8mp-evk and a custom imx8mp board
reveals that those words are not locked down (they do seem to have some
contents from the factory, but I can still set more bits in them).

Could someone from NXP please explain what exactly bank 40, words 0 and
1, on imx8mp are for? What do their initial value mean, why are they not
locked down, and why does the RM indicate that they should be part of a
unique_id?

Also, assuming that the RM is just wrong (wouldn't be the first time;
the description of the lower 64 bits is also wonky in its own special
way), an obvious follow-up question is: Are the currently exposed
(lower) 64 bits unique among all imx8mp SOCs, i.e. does those 64 bits by
themselves actually work as a uid?

Rasmus

