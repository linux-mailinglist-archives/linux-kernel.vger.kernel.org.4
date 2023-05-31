Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0AA717BA4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 11:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234957AbjEaJUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 05:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234937AbjEaJUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 05:20:15 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2107.outbound.protection.outlook.com [40.107.20.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BDFD9;
        Wed, 31 May 2023 02:20:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9y7fLTj+2hQ/+JHA+NH2Z0ugMOQqXmc/iBF15Mi/hm/nFg8NkAAIPCPV8F5pshwnXFhhgAZX2BzFSsML/ZuDsVmUMk+rg/Vs13he+QHhCXkXEDCh/jUxbA11BkiVARr0KQjP2M+rLKG5h9C5OHDi4Kvp1yyBhEJmXkq3fHosCvqHnAZpNfxEcMWJhqKA39tBd4KEUuM+11B+I4LeZ8EwDBVCzNlyIF0rLx3lvSLHC/SHXudt35yanSTva5IRv0YeTGRzbsRlvEmgT1JlaB2GsEUrfcNKDC5UPH8X159v4RQRLo91WL6ok1n9FCUw7rDGAySuNJJURqQZDn7f+EP7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MNtZB9HzzRkByYOuWaHbWgf4gpfWEV4ruNGeVdfdQzY=;
 b=ZYG4h1vvOs0T0bGggfWiZHmhIog4wnjtVyX+eiXc1kfg/yPiIuqq7FwSMwtxs1lJLP+rx9KuwB8kW3kbutfXcM21hqd5jQ4kzgo0OZ5JpdOsrUfXhNVZ+1J5Dv4dFBvTzuYXmj4+LGMcvXIyiGWPLyPB70n7jaz9k9M8I1r4q4XjqvqD4b7RV1/ouyWW+2XVwK4x3UtwdAndzanLqeZ6EV+qSs27lYD/0PZU+6hTQ73iPZhxKkYUFHuL5EHen9uREXUzSJcq9TNYPpOrKU90pwyJvANu8Hb8iWmph75i1ywekuF0vD8RZJ34epj8uFN7859Fu+toMHNVvVm5msiKcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNtZB9HzzRkByYOuWaHbWgf4gpfWEV4ruNGeVdfdQzY=;
 b=WU/AAnlZM95pPgP5vnLjQctBEeDVUbHx+Evwgcz4Kmzzplow7ADViuCoJpkPeIwCVHI3KHEMzJzp1GrFgqNnxE9u/QWozbyCRyIBF73PXgj+Mk+1NtvBwd8BlZY1Ue80InKcuFybrzprKXPFo/x0Rng4wM3GuQsyj8f7Afi0vVM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AS4PR10MB5671.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f2::14)
 by PR3PR10MB3755.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:28::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Wed, 31 May
 2023 09:20:09 +0000
Received: from AS4PR10MB5671.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::efa4:8562:e148:be7b]) by AS4PR10MB5671.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::efa4:8562:e148:be7b%3]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 09:20:08 +0000
Message-ID: <94773413-2bc7-abcb-0b5d-d67088934e7a@kontron.de>
Date:   Wed, 31 May 2023 11:20:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 1/3] dt-bindings: regulator: pca9450: add pca9451a
 support
Content-Language: en-US, de-DE
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Joy Zou <joy.zou@nxp.com>, ping.bai@nxp.com,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230531065724.3671795-1-joy.zou@nxp.com>
 <20230531065724.3671795-2-joy.zou@nxp.com>
 <f343458e-519c-1e5c-e48f-acfed2c00ad7@linaro.org>
 <25e6d735-f191-68a1-84cc-d7e1ae4c3217@kontron.de>
 <0de8cecf-ec36-9300-656b-2c073f60c407@linaro.org>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <0de8cecf-ec36-9300-656b-2c073f60c407@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:22::16) To AS4PR10MB5671.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:4f2::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB5671:EE_|PR3PR10MB3755:EE_
X-MS-Office365-Filtering-Correlation-Id: b7fbf55f-fd8d-4749-faa6-08db61b83a56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a+cIuo2Eie9HHUbvKBB4Nh5Hhf7gIeH6WzpAIrACGhv8PKXKTuKc82OGNYrGi8AxIpYDcooFOcVoN0f7dmacTn/KHuxOYwc6t6UpTC1LG4MSx7LIySZizaVirgU1vbfW8MhdaCOcmNggsxe2P5G5yhIzwnDwLlDBlQDo/MBgKGqG2ctqkhX2ht9tMKzmAGf+wLTqhP4P7C7GbCvx7/R9USItEDqYbQxEfoG6aMgKq+FobYywjlElAxUrGQ8x9uJJ0dUpn0/h4MoprIzuOQKuSBY9gyIlWeZAha9cpaszGPmnO67j8DZZn43YV4K6VY6whckCmD3RlJ9DTEdEh1Nh5J9T7XE/Deu5Ys/yXBD+DjUOYF+LsUrH+KcggUHnIKSmhDT2snYJgiIKW6L6ZyR6rLBOekPLSIYOmyG1FdgamGrQrH5LmzPBG2bg55W+QGcXk+y/mgn9MThFZ+kBo66Y7USaRuN2/JyGzoienkxVq4AZNUnQsR4SjDB2I63n7/XP+joYbDJOolLrRFpmPp5iGsxAiHnFyz9BbPWCGahF7pPq7nqhmqUBAxsF0R0dFprRpo02/lEaqUghnAS0zz6BtDBxCd55ZgsS7SvyNT8fO1Nzi7HR2GhGNqhVZkKN2/f1yPjB82w+maKZGklz2usF+XSfVpAuVFkDk6vWvO+/BUk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB5671.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(366004)(451199021)(316002)(6486002)(41300700001)(31696002)(83380400001)(86362001)(2616005)(6512007)(186003)(53546011)(26005)(6506007)(2906002)(921005)(38100700002)(44832011)(8936002)(8676002)(36756003)(7416002)(5660300002)(4326008)(66476007)(66946007)(66556008)(478600001)(31686004)(110136005)(6666004)(66899021)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDlvQjJaYWxkWTNwTHVySnJVQXByYmNjU2k0bXFTQzhmaGZRQ2ZGZVFOUThG?=
 =?utf-8?B?ZU50QmFsd3BkdGhZV0oweTB0ZUpUUkdIeWNYYW1kVm1nMjMrQlRGMHZNNm8v?=
 =?utf-8?B?b3d3bGY4S29HRGFySVk4ejB6UmtSbUhHOWhwWWRUV1lTaXdYN1RnQVY3UzUz?=
 =?utf-8?B?cGltNlZ6YS9uYkN1RFAvUWRmNlRSbTllMUxuZHh0TkZOdElIVDVEZGlGT3FK?=
 =?utf-8?B?VElFNzZuNTRyUVlyakZHUGJWeWNZS0EreDJCMkRIN3JYNVEyYzJVdHc1azls?=
 =?utf-8?B?TnVicHVnR2EwNlROei94TC9TZk52bVdLVUMrNS9qK0tiTE1QdFJuZkVIMjdX?=
 =?utf-8?B?SGdVUWEzcE82VmNzRzZPRXBUV2lkVUdiK2x3N2x6R1lyYThEYzF2dTZRMFhD?=
 =?utf-8?B?NlVXRkRRaEVwY0hUTy9YWXZuQnVQU09JRVlLV2JOb0hpYkxqbXRqcUNyZEtR?=
 =?utf-8?B?OWZ6Z1FQRVAxR3lyT2k5T2tjejVxRGhIVERWTHV2RitGdDJja1gyOU5VMHZC?=
 =?utf-8?B?RElUWGkyM3Qwbzhld01LQlNhWlBOdnRyTmRCU3FjbUlJNTl4cktLVCtKSHd3?=
 =?utf-8?B?dmJCVzQrN0tURW5SallFTmNKWnVjeGUxdERrR0toRXlsL292dDE0bGQ4Q2VS?=
 =?utf-8?B?RDByUGNWenhSbXhHdUIyT2NzeTcyd1hCSHRjK3Ezc2JpSHdJc2c3NlVOMk5U?=
 =?utf-8?B?d0lyYUc2M0NSdFRJcGdUbnNxVGk3MlQzR2RUb2lVbThHaHlDYjRSQkZQbkhP?=
 =?utf-8?B?eEp0R2FLVkVPaWpBY0daMlUzbTY2VjA2SlM4Q3dCRjBDTjMzeVYrZWVQZmh3?=
 =?utf-8?B?Y1cvcGlBdlNRMGo2TlhrbnFuWHc2Q01Nb2toc1dkRTRMdXBTb3FQQTQ3akpJ?=
 =?utf-8?B?U0l3Q1A1emQvczNQcjQvU3YxU3V3K29Ud0huWUlXZUlqeXZ6VklWVXVjQU9G?=
 =?utf-8?B?dXNKKy9pY2pQWW53cXRCMGxLcjZWT01EWUNDQnZrVHQybUxRTjIyemw2N3p0?=
 =?utf-8?B?Tk9oVWpMQVNIbE9RcHdYTm9ld3Vnc1QvY3NsUnZTaERSdExueU1sR3o3WnZ3?=
 =?utf-8?B?Ri9tbUtQd0JGT082M3BoWmpqL1UrNnlndm1vQWUwR01KdmxWeWsyUSttcUx3?=
 =?utf-8?B?cXZkNG5FdURhNzlBeFNsRkE4OU92UWFldGliaDR4RWw3dStkZGEvT0R4MDF3?=
 =?utf-8?B?Skx6S3NydVRrTXRhamtGdTdwZTlnUHk1Ykpjc0c5NGw4M0VuNjcza0NzYzJD?=
 =?utf-8?B?MjIwb0U4SDl2dldhRWY4NnozKytJK1dzYUt3c2YxUDI0MFJma25paEJ0TnVJ?=
 =?utf-8?B?RWFXTmUrTGZzUXVGYlQ2d25yQUcyckdoRGdsTGtTL1lDU1poZ3VoMy9kanB5?=
 =?utf-8?B?Rng3QTFqT1F2LzVtUTM5Qmo3eGxIeVdpNkNxTlppRFJKQnQvVjVIcVBNYnJm?=
 =?utf-8?B?QWhuOU5HSHN1QU1pVEo3NDM3OFMzSnAvQWpnTjBwSCthT2lxdDZHZUhMbXNR?=
 =?utf-8?B?SW9kSlpiUkJMTjE1K05wVjg5cUJOdlA3bzlML0VzYjV0NDRTY0JNYm1oWjRs?=
 =?utf-8?B?Qlc0WHJRZHo0NktlNTBRNmVNZnBDNVE0aTZCL1JXMElYcVNrdlhOR2ZYemtG?=
 =?utf-8?B?WGg4TVlvbHVvTXdHZFNhTFJMNzdyZnFsdG40WE5kQUVLUGRwb3A4WmtCeEw0?=
 =?utf-8?B?cDk4ZklzOGc0MzlYRk92UmR3eDdLS3VpSVgvT0lOeEFEMWtPQ1lycERkNmNF?=
 =?utf-8?B?TUF2RkpreHprOTRVbWdYSENqZDd4UDdDbDJuRTBidm9taGRPMi9QMVJ1ck40?=
 =?utf-8?B?UXJIdWgvMm9Cc09sYXk2RTRzQWVHTTJ2VkRCcHh0Um83WDlpaFZqZGt6Mncz?=
 =?utf-8?B?SzI0dzRnQkcrZDFlcHU2dllEQjdVZy95dXVHaEdMaHpUUVZsdkRUbll3MjM3?=
 =?utf-8?B?d0dUczdneGsrZkVrL2hhVHlFRHMxRnhsMHlTTnBNRVoyUURCTUJhOEVEVDRl?=
 =?utf-8?B?SnV4dmhHZWtzQ3BhNVJNbWZ5anZMcDBndXNmRk1xMHlrZkFSRTFjRUt2TnNi?=
 =?utf-8?B?ajFoUlBvQWxaZWNuS2IvcjJ3WElxNXZzRnNzY3NOUGZrdFRPZmZpU1NHcVpJ?=
 =?utf-8?B?aHMyQWp5Yjk1clRjN081VTNzemU0MGV6TWd0aDBPc2x5K1J3MzFmZXJKclNq?=
 =?utf-8?B?Q0E9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b7fbf55f-fd8d-4749-faa6-08db61b83a56
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB5671.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 09:20:08.6377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rwexe0yW9UpHTNe9EEhBgBVTsYOpxVeqVej5NioBcWQaXfNYRbkp7qa1MD+lHfdwBmdc+it7iFp+4fM6wHZtO6lrz4pMRlRf2GEvnRNZkII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3755
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.05.23 11:11, Krzysztof Kozlowski wrote:
> On 31/05/2023 09:22, Frieder Schrempf wrote:
>> On 31.05.23 08:56, Krzysztof Kozlowski wrote:
>>> On 31/05/2023 08:57, Joy Zou wrote:
>>>> Update pca9450 bindings.
>>>>
>>>> Signed-off-by: Joy Zou <joy.zou@nxp.com>
>>>> ---
>>>
>>> Subject prefix is: regulator: dt-bindings: pca9450:
>>
>> Is there some way to have this consistent for all subsystems? Most
>> subsystems seem to use:
>>
>>   dt-bindings: [subsystem]:
>>
>> But some use:
>>
>>   [subsystem]: dt-bindings:
>>
>> Casual contributors (like me) will very often get it wrong on the first
>> try. Examining the history is extra effort that could be avoided and
>> often doesn't provide a definite hint as you find both variations in the
>> past.
>>
>> Can we standardize this and make checkpatch validate the subject line?
> 
> I understand your pain. :)
> 
> My expectation is just to have "dt-bindings:" prefix. It can be anywhere
> - first or second, doesn't matter to me.
> 
> Then there is the generic rule that subsystem prefix should be the first
> and here there is a disagreement between some folks. Most maintainers
> either don't care or assume bindings are separate subsystem. Mark (spi,
> ASoC, regulator) and media-folks say it is not separate subsystem (real
> subsystem are spi, regulator etc), thus they want their subsystem name
> as the first prefix. It sounds reasonable. Anyway it does not contradict
> DT bindings maintainers expectation to have somewhere "dt-bindings:" prefix.

Ok, thanks for the explanation. Would be nice if maintainers could agree
on one version then.

> 
> My comment was only to help you and there is no need to resend. I think
> Mark when applying will drop "dt-bindings" prefix if is before
> regulator, though. Life, no big deal.

Im not the patch author, I was just jumping in as I saw your reply and
it already happened a few times to me that I needed more than one try
and used precious maintainer time just to get the subject right. So I
thought there is some potential for improvement.

> 
> Whether checkpatch can do this? Sure, quite likely, one just need some
> Perl-foo to add such rule. :)

Ok, this isn't something for me, but maybe someone around can come up
with an approach.
