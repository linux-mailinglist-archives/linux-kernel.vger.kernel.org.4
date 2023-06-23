Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A53273C238
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 23:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjFWVNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 17:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjFWVN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 17:13:29 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2103.outbound.protection.outlook.com [40.107.22.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7542189;
        Fri, 23 Jun 2023 14:13:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BsZ3pAMtDlZM1X4vvxziwS8KKof6/rFy7GvE/pNI6gl2O8CFjBYb5ZdRubheefMVRy0x9zoS+gp8lHb+52yrJXA1ySYdtcmK//Qloh3a6JnyNzxiCC6jOZM7um/I7T+FShJw4x5nvLhR0Ge5kl3eGbATr432GLCPDQOmIgStm3lb4MsB7vEO+wDaGhm7XeoEHUYGu+OlLRbBwO7mFUd5ipg/cLoxRDGRVPmkkRdsgyBpHJFJVhiphikv8JlOs6ksY2ELUhir009D/v+gAe+4gX6obQ9e7HU39YSLUbp+tUfItA76+jal2X3FOYz7NqAX/TS3MyvVwGkb5O5cklXxvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tv82/JG2yYj1NUniIrwiSwP7xS6yGsoUSaEkMcQUtuU=;
 b=MCZ9Bl/cBWqduWV1Lvoa7H6O5UmNJa0/B0UpSENSGddFd1WCSACqRp+tIMVuAWttTTu9nQVKNSj+f/GZ8rhu1McPvVXzNTl6Vgb56bZB4THsTB5fvXDtIvLwAlS1s1HX9bXr+v/Dgm+cJNXiXnFkNP1Z/uoK7PsN09z8S+aDdWI32TZLPrm6w+/XoigKvLoM5YBDPhjk57lHKGX7+QKlgRm80vqlDfpu1SA+WeoVgTWisdcAJjeChUjDRvRkDx435PBu8htuFX06XxtS3m+/OP3Vh4XRLcsmRbr83MR8c+eTI1w+nQlrHh5wt/yFYAKu9pgeeiaQFPa+W9ko3y2EjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=victronenergy.com; dmarc=pass action=none
 header.from=victronenergy.com; dkim=pass header.d=victronenergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=victronenergy.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tv82/JG2yYj1NUniIrwiSwP7xS6yGsoUSaEkMcQUtuU=;
 b=cJEkM8aT8aEEsJajSu/JL8vOwYY+roVL+dLeiVAbOmpiUKXrN84MqRnDhTHlb4M3H3EagwYSBlk0OVFJCJvmgPmjP3VT1DkdFp+S9WeV4kFEzwMpPiXtAFV3GswDKFW4+60L5TvyMSfrjmCGvE+yhndymbj+G6hikSAwsiLHtwU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=victronenergy.com;
Received: from DB9PR07MB8679.eurprd07.prod.outlook.com (2603:10a6:10:30e::14)
 by DB9PR07MB9365.eurprd07.prod.outlook.com (2603:10a6:10:456::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 23 Jun
 2023 21:13:24 +0000
Received: from DB9PR07MB8679.eurprd07.prod.outlook.com
 ([fe80::8013:d5b9:e8ef:36c1]) by DB9PR07MB8679.eurprd07.prod.outlook.com
 ([fe80::8013:d5b9:e8ef:36c1%3]) with mapi id 15.20.6521.026; Fri, 23 Jun 2023
 21:13:24 +0000
Message-ID: <de546232-0638-318a-535f-169184933a20@victronenergy.com>
Date:   Fri, 23 Jun 2023 23:13:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] net: cpsw: fix obtaining mac address for am3517
Content-Language: en-US
To:     Simon Horman <simon.horman@corigine.com>,
        =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc:     Tony Lindgren <tony@atomide.com>, netdev@vger.kernel.org,
        Mugunthan V N <mugunthanvnm@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "open list:TI ETHERNET SWITCH DRIVER (CPSW)" 
        <linux-omap@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1477668756-2651-1-git-send-email-jhofstee@victronenergy.com>
 <20161028155213.2t3nwwe3lqaynaer@atomide.com>
 <d8ad5cab-5183-cddf-fa9a-4e7b9b8c9377@victronenergy.com>
 <20161028181914.mskebckucukzhxhz@atomide.com> <yw1x7cru445g.fsf@mansr.com>
 <ZJX9FBBvOTv10IO4@corigine.com>
From:   Jeroen Hofstee <jhofstee@victronenergy.com>
In-Reply-To: <ZJX9FBBvOTv10IO4@corigine.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4P251CA0008.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d2::16) To DB9PR07MB8679.eurprd07.prod.outlook.com
 (2603:10a6:10:30e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR07MB8679:EE_|DB9PR07MB9365:EE_
X-MS-Office365-Filtering-Correlation-Id: a999b888-0a41-4fc7-e89c-08db742eae2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sq6rd2Hs2zc+hijuZKh2McTl2hIs7nKsb9/MtD8Zt16SGm7fGFHlsGneVaS/3b28RP6OxvLrSOITf/zZTkOdQU5xzOWOawE4Sv1rM7PVtVC6MRaaRkr2PxC6MBzAiBWWkDxy8iYrIxt4oXRxh9OrpAwNkOtDUzvBgoRSI+VmsNI3cTitBreDEkFaMR13D3q7y1+jMtOy1RdMOS33SX7JVJUpFl/+Bpul5Bsi0F3PMDTr5/Zr3QXm3rOq8PHbSC92rpDgdw3+5WVNdKUTPfLGH9krGROWSZAavHGwdKQDA0EORyguawUYGU/tXgvGRHGIvESQuZqJY8QMEeuEbGxITGOPHDOl9JWdkJeHhDBR+lT+pVL+AdJVOKDst2EHdI5VcY/utR9ZxJ6wvQbKVVbEjCOgsc3JzUoRgFCsHJBPpigtkZUTQS+lHV9JWskPLJtwPqqj3BmUxdqSbtQOkRuoAKkDZjj4IzJNR9MmW86SiEpBQ2beG2Y6+0VTRKB7wiZOCvwGYfUChactOYUb4VeA8kapX40exHO5K8DWQPIYe0CcVuPkQTrTR5iSKyr9rbAAdbd5v9NHr/9LwRyO31XgQ4qbPaEWX6t2NMxTuvo4r52adf0czjoIZLTq+2vTo+bPGhGwhOHNW5vNTjkDLlfu/QKtNhs3UmUG0G1mLdVE3sos8z7IPwAIru+dlqWkk224Go5Hl566uRYZv9kHNrdRsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR07MB8679.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39850400004)(136003)(396003)(346002)(451199021)(31686004)(53546011)(6512007)(186003)(6486002)(478600001)(110136005)(54906003)(2616005)(86362001)(31696002)(66476007)(66946007)(4326008)(66556008)(6506007)(41300700001)(66574015)(316002)(38100700002)(5660300002)(2906002)(8936002)(8676002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEcydldZZDZhZUo1KzVKUithcjExVzNPeDlUWWowa2pOQkV3MldvbFlFTXhV?=
 =?utf-8?B?SWd6YzZVaXh6b3ZZU2tEbW02UEh5OXI4cmhGbmZkWHE2eFhZN2Z0WXpNTndF?=
 =?utf-8?B?YXZPRHBMdkhZRG1uTk52NnQ5azUrMHhSdjF6c3BSTy9jQ205ZUxTV2prNGJw?=
 =?utf-8?B?RmlINGZnNk9nMUI3cExaUTNhejczUjJOK1NXR2V1Y0hkR0UzbVI5Qm5ZNkJH?=
 =?utf-8?B?MmM0ZTBUNEloRUtPYlpvWVVlNkVkVWZjelk1NTdjSnM3dXV0Y1dMaWVyTm9q?=
 =?utf-8?B?cXk2TzdKVWtWLzIwQWZZckJaZ1ozUUNxYmo4THJodUNlbTdXWHBIR2JicTZo?=
 =?utf-8?B?RGxpZVJUaFhsaWNoZDJLVWdJSUhqNU5ZcExOS0ZuUFVoOHJ6ZmVMMXRHT0NT?=
 =?utf-8?B?UkpJQms1U2QrZzN2MGhTU2FzSlM4MHNvRkhZNHVFTGZhaWFFK3NCNUI1U3hC?=
 =?utf-8?B?MFdFRjZDWFlHdFNCRDlUK2lBYWNNU2FSUVVrelBxR2FPcmkxVWt2bVJWdy8y?=
 =?utf-8?B?NmxXT2lXQWIrdmh5MGlxNFoyUjlFK1JMWURaYjcrUmVId1RmTWMzOSs3c3Fk?=
 =?utf-8?B?Y3BQeVJDZW9PcXFNYWpibjVvTmMvNVdNaklnNXdMdjB1UEhTa0hMS1JXczVo?=
 =?utf-8?B?c3c3R1dlS2E1Snd6UVE4dW9hSFh2cVgwMGtJZXRXYWlMZEJCbUFWWDBaYXV3?=
 =?utf-8?B?MlpRaUdSbmJDa3dURXV6aGxrR0hmeHdaT0ZiVjN5N05ac1kxNm54b3Y4UTVt?=
 =?utf-8?B?RWxQNXMrMGdhR3IwS2ZzVVRydVJPUWRlRHFUdG1wTWw0Q3pkUzBRaUxLbFNk?=
 =?utf-8?B?RENHK3hVYnBnL2k2UGhGeTZSUFJnTld4K0dBckNnOXFpVnRQTXdnZ291ckI3?=
 =?utf-8?B?OVZ5Q0tCanJXZUlDMmFhRUNhdmlpdms3Q3o3cXFFK3UyRVl1cHJ5K3RyRVl1?=
 =?utf-8?B?K09rd2hDUmt0RFZJbGRjUHJnRXZBdTBVZFVFcEtYVWt5ZCsxQ2UxL1ZaUS96?=
 =?utf-8?B?NndEMFIySTR4QlNNRTU4Sm00RmFNS2gxeTFXWG5oK2xtOVY4WXVSTVFvb2s0?=
 =?utf-8?B?Y1E0Yk91REUybkFDWk9IK2c4NXVDWjNNaWZmYmk4RkRRMnIwWm1SR2JYampj?=
 =?utf-8?B?Ri9ac1Z3RFRpdTBjYm1WRW8rcnFsVTE0aFFURExUdDhBclY0Y1pZZktsRmJC?=
 =?utf-8?B?dUJwQzFZcENQS1N0L1NPcG14c0Vza0tvSi9URGJwbTBZa0lMeGxtQ1M5K282?=
 =?utf-8?B?dG80c2hGMUZlcSsxcXZ2QjFsVUJVVit5Q2o5enJVQkRzVEMwSlVvbUZuaUh2?=
 =?utf-8?B?TEovQVM2RTduR3JCeFZUUlkrdFc4b0RRcEVsWUJ6czFVZk1RaEdsNnJTdk5U?=
 =?utf-8?B?UEZyTGl3K2Nqb2JUQ254Y0ZDTG1IY0hBM0FhZCtneXcvcGNUMzJNeGlVSFRp?=
 =?utf-8?B?Zk9yZXVDanBiSVVVTzdjV295d011VUJZdnBpRTdwYVRPWm1vSDZPdVZydlpW?=
 =?utf-8?B?Q08rMFcyNVljV2FRYWNPUGt1a1ZVbFZCYXBVcVQ1M1B2QmJNdFVieTRkNXVD?=
 =?utf-8?B?QU1zdmp4V1cvb3J3OGtWL2dPUytVTUhNemtsOTB2c085ZCszZEVRZmJ1cUIy?=
 =?utf-8?B?SFBjdkFLTWpMdUdaQnVQa1dNR3hsWnRxZ1h5N2RlN21HbE1uazJMUkF5YnRD?=
 =?utf-8?B?SFNmWjhwbklveGc2b1lGSllRdW96SG1VUytGMlRxcWJnN01SZmxwbExlZzZh?=
 =?utf-8?B?NUlva1Q4eGtLYUwybmo1YXdyZnZGOFVwSUlZcWdFbVJwWk5yaXlXWENOeVFK?=
 =?utf-8?B?aU1OL1ovRW02L1pWdFRsaU1BZWFwa3dQYTlvNGtycU9YcG41QjlBR3M2ajRU?=
 =?utf-8?B?cklkcHNEekd6MmZvVW9NWFp5WVhubkNOYTVaaUJ3WEdSOTFkTnRQYm5BZ1Yr?=
 =?utf-8?B?bGhqc3FZZTBBODdJcVVxR1dsaDBoQU5JTTh2MXJZODBWenUySHhWUmE2bzZi?=
 =?utf-8?B?ZzBVRk1KYnhGWm5sMC80V2hqVndwTXRQYmV0eTdBakV5VkxRRE85aGZValpO?=
 =?utf-8?B?STdPc1d2SE9Ta3Q4eElBSW5IMUE0NFF2Y1BuWGVsSm1nazIzeEZaUVcrY3Mw?=
 =?utf-8?B?Y2owNXhrdEdjNHZnTU9VS2Y0TjFtTEIyZnpEN0p3U1JtOU5jemh2dFdkQ09V?=
 =?utf-8?B?OW1KeHlCTnU4S29qbWtwSk1FT2djQ1hrdG1jeTk2YUNXcXdHczJQdjBCLzJq?=
 =?utf-8?B?ZVN0VTg1cUt0SXhKRzRQZWNOZWd3PT0=?=
X-OriginatorOrg: victronenergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a999b888-0a41-4fc7-e89c-08db742eae2a
X-MS-Exchange-CrossTenant-AuthSource: DB9PR07MB8679.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 21:13:24.4108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 60b95f08-3558-4e94-b0f8-d690c498e225
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: afz5icBFQbGlqReWReiVrAI1rM2CNpltMgwW+cBAp08VAp2WXUoP4n/yVlLrxdyAnBjyW9E+QY1ifJPbb4rvruIvtJbbsV9Nv7bIvlM9NqY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9365
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23-06-2023 22:14, Simon Horman wrote:
> On Fri, Jun 23, 2023 at 03:58:03PM +0100, Måns Rullgård wrote:
>> Tony Lindgren <tony@atomide.com> writes:
>>
>>> * Jeroen Hofstee <jhofstee@victronenergy.com> [161028 11:19]:
>>>> Hello Tony,
>>>>
>>>> On 28-10-16 17:52, Tony Lindgren wrote:
>>>>> * Jeroen Hofstee <jhofstee@victronenergy.com> [161028 08:33]:
>>>>>> Commit b6745f6e4e63 ("drivers: net: cpsw: davinci_emac: move reading mac
>>>>>> id to common file") did not only move the code for an am3517, it also
>>>>>> added the slave parameter, resulting in an invalid (all zero) mac address
>>>>>> being returned for an am3517, since it only has a single emac and the slave
>>>>>> parameter is pointing to the second. So simply always read the first and
>>>>>> valid mac-address for a ti,am3517-emac.
>>>>> And others davinci_emac.c users can have more than one. So is the
>>>>> reason the slave parameter points to the second instance because
>>>>> of the location in the hardware?
>>>> Sort of, the slave parameter gets determined by the fact if there is one
>>>> or two register range(s) associated with the davinci_emac. In davinci_emac.c
>>>>
>>>>      res_ctrl = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>>>>      ...
>>>>      rc = davinci_emac_try_get_mac(pdev, res_ctrl ? 0 : 1,
>>>>                            priv->mac_addr);
>>>>
>>>> So it there are two ranges, the slave param becomes 0. It there is only one,
>>>> it
>>>> will be 1. Since the am3517 only has a single regs entry it ends up with
>>>> slave 1,
>>>> while there is only a single davinci_emac.
>>> OK thanks for clarifying it:
>>>
>>> Acked-by: Tony Lindgren <tony@atomide.com>
>> Is there some reason this patch was never picked up, or was it simply
>> forgotten?
> I feel like I am missing something here.

That is a weird response, you feel like something is missing, while
it is a recognized bug, acknowledged by the maintainer at that time
and apparently still not fixed and Måns simply asked it there is a
reason for that.

This is not a really helpful response,

Jeroen

