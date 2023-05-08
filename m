Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4986FA026
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 08:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjEHGv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 02:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjEHGvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 02:51:54 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBB6A5DE;
        Sun,  7 May 2023 23:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1683528713;
  x=1715064713;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pleLNiH6dCV30nru7dAZSxMspaaGZSqCE7p62QfPNTo=;
  b=fIG8YCLClfvtGiIc7cGGCT8UlIPDfKjDnAk8eCR1emFkPR/ti+XzQscQ
   TBVKm5OULS6XNX6XBlFqVuqC8lkJGmCL1FuDa5wfDTbR0xa9qhAqMVM0s
   K1BxKK1jtE5GRlxdmKMGiYsRcQW073xqeo6+qNkty3J9HJY6+64Ifyj4O
   +tBFXOjeCXl1xKLhs+J9ss7Uf0GDM+YeP6hy90d0y7Na3L9XlliMhkrei
   zjU1q2dIuL7IO071P/w/+nfC26JYOt4dr0/v8c5TIlFYrN08OtHr2TzOC
   AnFwRSp+AC1dM89CVLcnhnYimZVuBREakuZdrspOJRo+x3IdPFkNJXasE
   A==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vd04EneInPRaOCsL3+PZimPfvfPbM5YVKCfv3JKbvBXRL6OAVlJbBAayA2DsQ5s+aZ+ol0cKTzzP4HE9Fi/i50L7YPKCgfEv6Vu5s9lNhK6Z3TjK98qzu4+AqnGQR/na7Nt17QMxDjH6GNdp0JY9z+gilxDJVVI14sFDPu+0zlVPHxkrX9m2JfTuwy9/J1zybAhnPHqMqYkGYTKvRigTb1wcUv7xXj97uFibVbmlXv32go3CeWVlO0ICrJ0Pi4hRfX/xFNHKT2wxSa+qqV+KePHyTZI25aI0BcTRbmq/y4LnabkojKjpEvGS26rPG4ag1ZZTPilyFH5rHAOsR72Fbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pleLNiH6dCV30nru7dAZSxMspaaGZSqCE7p62QfPNTo=;
 b=bIuoHTzxHzZ/iUPrudNTcGwwB7NXAqEJgDKHB/xmZYAYrt/nefmv5jpItdo90R2c+se2pgBNRDZIDwrvWmdz9xa1rutgXRzSl4RGHR+gF/WqkJBwKaGrDLEhSUPau4FGB8gKKW687MxSgkYj3He3WFv2heGC4mE8QnV7EEwzu84aAPc0W89ndOxF2Ojl1szDXaAjjEb/h6M/pr+yaWmo3Uga9KTV4BhfeshHWg0WrodBFPtK5qxTr3wTyLMA9FHtGnJBTBD84uFblS6LgSU1ojHA1t79iMQHxWaz7SFcWVmbzQEjYT6C438m5EUuj9iV/uhvMWKbBCu2MyCpCtXm5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis365.onmicrosoft.com; s=selector2-axis365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pleLNiH6dCV30nru7dAZSxMspaaGZSqCE7p62QfPNTo=;
 b=x30dY/30npW7MX88fja+V+Xaf9Qex5uwn5vq1zYscVP8h5n7KoJWlocmtxffRnneg+x7Wuq5lPowWdp17xqw9LxyVE430NzaLTzMx7EeH/WjLajnqKJXX90rN7UvhiFkVsBgl6Glng40/t0R+kqvGV4lA2BvdVEFke73ZvYni5w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Message-ID: <ab469af7-22e1-c3cb-6374-26c99f30a900@axis.com>
Date:   Mon, 8 May 2023 08:51:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/2] regulator: Add support for TI TPS6287x regulators
To:     Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <kernel@axis.com>
References: <20230502-tps6287x-driver-v2-0-fb5419d46c49@axis.com>
 <20230502-tps6287x-driver-v2-2-fb5419d46c49@axis.com>
 <ZFOfX+PTsmA35TsC@finisterre.sirena.org.uk>
 <e02589b8-118d-0feb-d32a-bdf39d1b88f6@axis.com>
 <ZFTuAZvnvY2sSXrm@finisterre.sirena.org.uk>
Content-Language: en-US
From:   =?UTF-8?Q?M=c3=a5rten_Lindahl?= <martenli@axis.com>
In-Reply-To: <ZFTuAZvnvY2sSXrm@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MM0P280CA0110.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::26) To AS8PR02MB9529.eurprd02.prod.outlook.com
 (2603:10a6:20b:5a5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB9529:EE_|AM0PR02MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: d8e86b69-d249-4c63-eaa5-08db4f90b252
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MItUDfNN4aTaQOGNGr5qVi+uFF2xGKJhbFqLQao1ZEJgpkP5Ek/K/I6KbcqGccIkpkjQtkszqzbw0MLQ8C6B1i5hWPEGNSBV4r5mii3GKJ5Bem8fUdbnwUD8c8MCLL5zOatdQNbiUXrGyk2VvglO5mJWc+5GiH7VOK8LHpODPTECcAUrfqC7eWiuAGv+00aKlGowJGE4UWIZGao1QtIxgLHL/puAygi2fhnV8YbyThvnRuDAPeh2mXj/Dt0BceDSwLEr8+/4cFGbtEH26iGi6iXlJ2VMLMU+CaM8qXrJolhfGhRnnB0FccTw16IOLL+YEpb0z7mQcgDcdbfTUUDCF4VffMNndctnYjyVL6YrqCD1goo90e1aqOaIf3LoF5KdBXrNlS0Y39rlRwFk/uDdP/R5ud9yoOdLH0TlLM2UcJ+S4yBZnM3YPfeke8piPd5oaK0w5bDoBQSuNfRGSpjNekPcvXSxLz131b/pLZJxeg1+A3BlPVnidvkGczNU31cRVQDtvib4at5mdoTASUrDr40kqAhHMAmr1S1T66t4cbSUUTXpYm+h2y8e6IU/8LJUrWhgBg6IHEgtHgyPc+e8huRm7IkfNwk3Lz6J/TVRYkFyxOXqDdRYkHZlGHDCvsgPiz54IZOJqUe5F44Y7jGw+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR02MB9529.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39850400004)(366004)(451199021)(2906002)(4744005)(54906003)(478600001)(8936002)(8676002)(316002)(41300700001)(4326008)(6916009)(66556008)(66476007)(5660300002)(66946007)(31686004)(6486002)(53546011)(6512007)(26005)(6506007)(107886003)(186003)(2616005)(36756003)(38100700002)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3Y1dFRpaVlaekY0RE5XeHVPL1AwRkplakpUbDUxR3ZGcmZ0WWVDTEtSUnk2?=
 =?utf-8?B?cEpuODljTU8rS3J6SURoS1l3S0RoOUtYaVpQaCtGRGNCUk9icGE2Z0U1Njh4?=
 =?utf-8?B?ek4yYVd4bFFGQkRRTWZ3bVB1R1VhYTUxd2N5YXFPbWJiMURyb2Nvb2svMThC?=
 =?utf-8?B?dFVIRnhtMTlYN1Uxellja3dQOUZhMElwM1lSemVqTnJMY1hDRVFJbXhKNi95?=
 =?utf-8?B?TUF6cWlDQVRHWTE1UGZWVk1IY09SWEVESnkrQnNSQTlKLy9VajFYL0ZjQlNH?=
 =?utf-8?B?VFVPNCs0YXI3Y1FhOE9URE1sUndBUUMxdjA5Z2dMTnRKNVpNTUl6Qi9Fdlhx?=
 =?utf-8?B?YldCOUs1YlZNVjJNZHpkZ2VJUG1yVHBpQXJCbWhBZCtnSlZIK2tYUHJRQlB0?=
 =?utf-8?B?NzZQZktjQXBmQ0VIaUJoeXhqaDlHUm95bE9yOEFIaGNTSjBWNGJidnY3WkJZ?=
 =?utf-8?B?Rk9ndk5rbXNwK1Y4Z0FGK3hIUXJJMUV1SE1ZYjlady94d3FpcmxvL2VrcHV4?=
 =?utf-8?B?OFduWWxNYmllcDhyaGtMZk1NdWVFSEoyS05vOTlMWm5zWWlOcmJKdWh5b2pK?=
 =?utf-8?B?UFBkbnQvTVY5dmhvN2hQTVhhUFB5VmFBVVcxUFR2dDRCN1JsT3QxSWJNOVE0?=
 =?utf-8?B?SjFmWlJSNUkvQWYva3cvSWN1UkJzc1QrU2VpRGcwMUxpVkQxamlaamtLZEYr?=
 =?utf-8?B?OE1Va3NGblA3Q2oycENxMHpOZWlOWkFkeHk1WFVSTWd6UTliRU9YQU5ncEZI?=
 =?utf-8?B?MnVwdStvaHkxL1VvV3pSdUhVYS9NV09pZDQ5eDVybzFjR2YrbUlYejRZSW1m?=
 =?utf-8?B?MndUYjVZR1I0Uk1QYytDY2pTYy9jTzVvZkxEcERTemRrdGllQU1veWUxeUQr?=
 =?utf-8?B?Sk9LT0tCSFpRV1M1SEZvSnF3Tm9IR005aGRJRkNlN3U3WHZqVWpXUHUrMlJD?=
 =?utf-8?B?L1hueDZsK3VRRHFMMSsybkllSFI2NUNScDlQMW9ld0FHMVNIMUhqa3REbS9z?=
 =?utf-8?B?U3FNU2t5aXpyMFo5K25qWWNWd0dkWVFBQlBNTmNRZ3FYMUdGVFFub0VoWHg1?=
 =?utf-8?B?RHVTSXZhSDZxbDdJRXJKT3BSTXAzcFFjWldqVzd4V04yRjBPRzNCNm1Qd0ZT?=
 =?utf-8?B?ZjZKUm5LOXJPQ1BEeFd3bExkY0lQQ2dtSzJENnpzYy9DZHRWQWdXNlZnOVFC?=
 =?utf-8?B?cE5VbFdjWFFWNjFpOU5uSmZYdWwvaVJkN3VreUppTHV5WXkwcXNBNVI4RExv?=
 =?utf-8?B?K0ZyMVQxSkpnV09yeTRic3RDSGdBdEdwWmEyYTFaUjJvSzd6dTY0NEx5bzVu?=
 =?utf-8?B?cmRoT2tPMXhUbUkrRHpHTmV3SWFudytwa1dBazFtMW5uTXpYcVlCREtJSVly?=
 =?utf-8?B?K3dnUGNpQncwSXF4L0JCN2h0blZsUmlrQk10ZFlFSHVSb3JPTkVxa2l1bWRn?=
 =?utf-8?B?OVJDSTlWT1RhMjdUbkNmekc1MlcrMnQybmJQRUhidzhST2VPeWJ1alIyTzc0?=
 =?utf-8?B?UHRtQkhwK1hJRi81NUhqdkFkTXlnSDh3UjBnUzBCM3FrRVdtaURQVEJrbGQz?=
 =?utf-8?B?clM0K2pMeVBINnBiTVE4b2JiMnhSaVZ2WTZQZ1JBNXhDVXl6cXZ2cDNzWmJ6?=
 =?utf-8?B?dXAwMWxseGxuWGxYdVJ3aTc0eXora0JEK3d0TTZkUFp0V3ZSNVJqVk4ySUVS?=
 =?utf-8?B?cGNBeXNTdkk4dTRobUtwU1Z3OUI1dmJXUTM3L3d0WngwYTBNcEF1Y3o0R3Rm?=
 =?utf-8?B?TGRVdVd0VlVYd2ZDRUlIdHo0YS96UlRmRXNZZkVweHhiSlgxdmM4MGUwVzRm?=
 =?utf-8?B?ODJXNUthQkVMcHNBUjdBNGdZeWFRYURsdndJT1ZNaW5qdlhWazkzUDdGWlNE?=
 =?utf-8?B?a0pEeWJjQk1UTFdodXZFaWw4NzJ2WkZ3cGF2cHUyUFZFT0hwNFBuQzJ6RFNB?=
 =?utf-8?B?Rm1hVVB0VnlxdEh0NzlTT3BrWDhPT3huYXN6WHR4SmNROFpzSVo5cXljOEk5?=
 =?utf-8?B?VDV2SUczalVrMkFDRDNwTllIMU1CNWlNZEkvb2dLNDhEK2NjVGc4Y00wRlkr?=
 =?utf-8?B?cTBKd0VVUmhpS3FFNFp3Zm9LMjFiV3luRStsckRFQVQvRS9MektIQzE4VGtm?=
 =?utf-8?Q?mi8M=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e86b69-d249-4c63-eaa5-08db4f90b252
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB9529.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2023 06:51:49.0466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uGYb6oZi6rEy3pcbVmxgXfYIeG6cqmu5ttuKkT3LroW0MV59vnZ2IS3c2r7pkgcQKi9Ym97dWFqJ6v19BqgLnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB5876
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/23 13:52, Mark Brown wrote:
> On Fri, May 05, 2023 at 08:46:06AM +0200, Mårten Lindahl wrote:
>
>> 2. Dynamically set the range when a new voltage is set. This way any
>>     voltage from
>>     0.4V to 3.35V could be set if the DT node has:
>>     regulator-min-microvolt = <400000>;
>>     regulator-max-microvolt = <3350000>;
> You can probably use one of the linear range mappings with a custom
> set/get which munges the range selection and voltage selection into a
> single value.

Hi Mark!

I found the *sel_pickable_regmap helpers which seems to do what I need 
for this.

Thanks!

Kind regards

Mårten

