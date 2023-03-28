Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3222D6CC738
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjC1P5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjC1P47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:56:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5E3187;
        Tue, 28 Mar 2023 08:56:56 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32SFoL0P026386;
        Tue, 28 Mar 2023 15:56:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Czr+mdDmb05DUa5xAb8gho8TFbkHIZ5ymIQylzcMiuE=;
 b=gM7mb77p8tPmJ3+xsXA7eqUQ7g/8Xn3HjYho6cscak7gpMxFSXHlY2K1NXFgXcOL6E0F
 bS1YOGzkWLE4HoEuYDlcUqCaFUeAsJiGuhrm9puEzmwawXY81kKY1AqgS3ExYUYLzItE
 AeLaU9lBUgtrl3DC88OJQqbkdR8rRAX/iyjUb8rwpFWBtLsygwO4SDyerkyVFYfJMyeO
 fu/TDS9Nt8U4qJWxqP8YlWcadSnxf+ZrYRJ0Ri3/HdxvunCfjvWs1ev6jtUCViy80ZuZ
 3jz6VwwE86LuQ0yqVhlSSe/ycir/SpXRUx/mOvVS+d2JFqInBoupe9IU+WSCvRnt7RgF iA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pm37q00r3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Mar 2023 15:56:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32SFBwDE026773;
        Tue, 28 Mar 2023 15:56:38 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3phqdd4hq4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Mar 2023 15:56:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZxTzUBlMW8PNYPRQONllHjC822RnOZ4kl25N8JtTQcI1z81v80TcjfMo5aKmJ33jWkrd6dAWFslHXPtzID8P+kUWU95i6AUvFLwkuQ38kbwhHUE1ArB37Ml/1W1be4LqxgSJwjq3Fx7ZJFMiCEsUeyAVJhSA5ioIbIspL2Z/9cI2LLAviuXRC976K/vlFqUaXYYCmtwyWNtFGN7QDNOANm01Kl4C7/kzT0km+bXaSvRqfBLDX9MVgIEYrYiCk5d+1f1gijTgBs9d6AIXCTayWM8vFB19U6RdjfyadvzutTt1+mKGF7avG/OrFOzuHAhTYD2Axy13Wv8yDDF4GCBf1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Czr+mdDmb05DUa5xAb8gho8TFbkHIZ5ymIQylzcMiuE=;
 b=TbHBpREcUkR7386TB9SxwffSPZBIKWYpvpktNSsOdO6IvapUMG0tEo74kE9bUENnmfBbbP9FOdXkGnVFSfanf2GknKtznMhf+CG4diPRE2a1E6hn69DPr32cKfSw/fbWGSO8YuribZRtZH7S6OsokzQxAlDO6SQ9eBoEGQu+yiRfeMvfxejHlCEVhJg9fHoFbCx86qeQI395AxJR90l32LssqR7L2k+vHRbC166c0W0li8mvOwz+gP2wOt86eb8lkbxmnuDviBGuguQ+qc/3gCrDsyhs8o53uND1f/RpLFhuFfidbDmvFV+FDTe/XqgL0RPacTeqhhFGnTZfI5ewuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Czr+mdDmb05DUa5xAb8gho8TFbkHIZ5ymIQylzcMiuE=;
 b=youWD+SQTSZiQrIRbTdQfueeyCKZZDqXwn15+qgvwfG7iTRL1bkVE7p0mg7P1mTHWEQ/t26Dpd35WC4wQjdLtopQ4ySXDcG+FHOU4h2vD/cUNs7QdyafWN4AuV16hz3p/QrRxf/ALW2nbqBJ7JXh4ifzuj/y4Cgwozm5bkLeu4U=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 SJ0PR10MB4605.namprd10.prod.outlook.com (2603:10b6:a03:2d9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Tue, 28 Mar
 2023 15:56:36 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::dcf6:889b:21f3:7425]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::dcf6:889b:21f3:7425%6]) with mapi id 15.20.6222.033; Tue, 28 Mar 2023
 15:56:35 +0000
Message-ID: <b16d9ae7-625d-c5b1-d7bb-42bac8445125@oracle.com>
Date:   Tue, 28 Mar 2023 10:56:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 3/3] scsi: blocking IO when host is set blocked
Content-Language: en-US
To:     Ye Bin <yebin@huaweicloud.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Ye Bin <yebin10@huawei.com>
References: <20230328143442.2684167-1-yebin@huaweicloud.com>
 <20230328143442.2684167-4-yebin@huaweicloud.com>
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20230328143442.2684167-4-yebin@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:610:52::34) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR10MB1466:EE_|SJ0PR10MB4605:EE_
X-MS-Office365-Filtering-Correlation-Id: 707d40e4-2247-427a-a24c-08db2fa5021b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JmajUqAWPvj2yZxV1yzNp2jgWTCwrWyi5qm68kI28DTl0CfS/2txhOyssoWueueU8NUN/InxJbq0jmfHoVycq2iJOuD5e8lWGgpGrBWmGLvVeMvIWx7OCQHAPd2OjkOF6U+/g7vMkMPStVtAf3B/TBRTMQjKmX1LkUVX500guvNiQyGHOsLHYQ7nAYT+Pq8odj6NjdVTE5vo8HpR9DOAPs1+PYkF64xnJK/tKKdLr1Gkj3nOItX24OSotrjtLMKPlagr3JjtsdXESEaTNVz14sZXE1jJz5jRINMAn238e8sZClOeVem46DumkHhMUQG8jCJ97Ks0cxqNwo6FhDPcV9eqhicaMWEOdh2GAFBKGGgu8j3z0xXq+LGT7taz6RsH6t9D6HpTzliqSMpJnFx24++863AWuaaZuojvRZXU5oTqvTxXBzPw4u4T4gVN8rgfgARkLnAp3/x9yoC5bU67fsymzopwQdBKp1G9xYQCFwTjYYSf34Lsg++DlWBi32W9Nvv8BbmFiVde2aN2pooGrdgnajCa3CF7AA+Quh9P/1qeC0HOAh3rT9KkqE4IIWJ5GXI8tadvOQPkKsuFx2R5oLybBNfBHCPLWLXQCqC8U3IMVttNVjnCPXcp7W4E2W7SI3qB+pyigZAVtZ5qCXAGaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(39860400002)(376002)(346002)(396003)(451199021)(316002)(6512007)(86362001)(5660300002)(31696002)(2616005)(8936002)(41300700001)(36756003)(66556008)(8676002)(66946007)(4326008)(66476007)(186003)(26005)(53546011)(38100700002)(478600001)(83380400001)(15650500001)(2906002)(31686004)(6486002)(6506007)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkNGVzVWTmJlSkp4K0lsd1JldXdEeFFReVJoRUJvMERMQTRveExiOU9scXZW?=
 =?utf-8?B?aGJFM1FQa3dpYndscDdUU3UwaWszWXRXSmlLd0JLL240MkZMa200U0NpUzdW?=
 =?utf-8?B?ZCtRZWJiV3k2NHVPNmFoQ0F5ckJLbmI0QVMxeTZlbWIxalM4amZSNzc0R1FW?=
 =?utf-8?B?c0ZJMlQwT0lHQm9HL3R2ZnNTRHdzenNIeGhpRlpmMklQWUJSN1VZRDE5YzZV?=
 =?utf-8?B?T0E2SDlNZ1BwbzdHNzVibnJKa29aa1F2ZDAyaWw4aFgvMUlzWkFJRndSeUVl?=
 =?utf-8?B?RkJxYXR6REdQZjdZLzRIZWlqVTlyNlpxUzlEbmQyZDhZUi9uSzhjY0FLSHJX?=
 =?utf-8?B?ZFJ2S2tvQjBrNUtCM0RKUFRFaHh3dVNMSVZUR01CaENuT2xQSEpMSTBvSlMv?=
 =?utf-8?B?YUN0dmJhYU9Vc2dwbDVaS2xmdnExVG5RN0hoM2ErRzR4TTVkVVdSZ1VrdDdK?=
 =?utf-8?B?WnhvL1JKMENEdDBoYnR6L1FmR0cyWjRHSmxuVHI4N2hmV0hJYXZNK1h3eDZK?=
 =?utf-8?B?NnJzSlJUN0RnQTdUYnJFdDhkVHUxR0hxd0hBMGc0VDB0dk9HdTg5ZFFSekQ2?=
 =?utf-8?B?Uis5RkFENUN6Z295ZlljdUw3Lzd0bWJaV1N3Mm9tdUJVSzVvcUpYeDQ0QVIr?=
 =?utf-8?B?YnZ3SEQ2R0lLK3BuZVJkbjl0T3A2ZjBEd29Tb1FqNnkvYmVwUUN4YkErekZH?=
 =?utf-8?B?SGtwQzVWNEMwZ0duNmp4QWFNeW5wVnpiWDZFT29ZaDZxeHhVQXNNeW8zVS9G?=
 =?utf-8?B?OUlVN0ZqZ3AxOTlPaVFuWmZ4c0FkRHV6QXdtc2V5dXR3a01nQTV6Z3RkK1U2?=
 =?utf-8?B?eDcweXByNzlqaUY2NUlMN1hxNS9XNkR3bVNMeVFjQzFtRHZmeEVNSlFkbUtv?=
 =?utf-8?B?RzNMWEZCNXVGeWJBZ1YycUxjM3cwWWE4Ty9IdndLVkdpdGdSS3hYTjAyb29L?=
 =?utf-8?B?Zk5mdSs3OVhpeFlFTE5pOUFCWWRaUjRLaDJGTnk3ZEhUSDc0elFWelNkR1hN?=
 =?utf-8?B?TVhoYkNGbkJqeUVaYkt5ZS8vSVN3N25xTzlhSEppc0JaTUZFMmJacW1rOGF6?=
 =?utf-8?B?QThZMUxxRm5HL0lpSm1qQ2hFMjRKQ01ybzgwaUM4WEdlV3hPWExrMjFWZVcw?=
 =?utf-8?B?NWNIcVBoTDBhZW1NaUtJVW5KK1RMajV5UktwTDRiY09EcDExK0QxeDZtMENY?=
 =?utf-8?B?djNoeTFMazJTMzZQWTM0SmJtdnVFZ0FBUU05Rzd3V0dFMm90Nlh5YStxZ3J2?=
 =?utf-8?B?dXJHNlVMV0pYSnprclVpdk03LzF0UmNJckJPWXp5djZ6Uk5JZEpvL1VNUnli?=
 =?utf-8?B?QWRxc1ozQjcvZkdrZUJzaS8zV2RXUi90T3RMblV1TjRRbVhDTXY1UmlieGhF?=
 =?utf-8?B?d29rb1MyamZZcVprVzQrdktVZ3FteVgxS0ZiS0tnNnlHcnVDbDJZNFI0cnVp?=
 =?utf-8?B?a3I5ZnlzcFJSQ05yMS9raERtOHBZajVsNXZjL2JieXFMYWNSb0kzMXhtS3hh?=
 =?utf-8?B?THVNWm14YTVZMGxRYmNHNUZ5RHBpcWsvdzRyRHpMYXRjSHJ3R09NcnJMRDR3?=
 =?utf-8?B?UTdjQmFQYlRIVStiWjZFNHpyL05WSEFDeEVwSmdNV1dnWHBrZVhlWWlEeFZp?=
 =?utf-8?B?TUFaS3JXQVVWMUNseUwxK2QzSU9nNjVldjBsdzRXL1dxQjJ2Rmxkd3IrMWpK?=
 =?utf-8?B?cGorTVAyNmlkOVJyT0lsVHo5Z0IzamRsU1ozL2J6UnFHNk4vc3M2YU0vcGRP?=
 =?utf-8?B?Rkp6T3FYUVowNEZtZkNKdG13NnJwbFN6Y2V0MW91S0hlWVcxWkgydXZqd2d6?=
 =?utf-8?B?M1p0M2c4eWZyTnVHVlBuS1F5YnNjZE9NNDNXQTVCYkMvVWkxNGdBSkx2Z1Bl?=
 =?utf-8?B?MGhOQmJBcHlacm1aMFFXUnhKYTVjei9xcm1oRDgybURQbHBrL25sb2RwMm9o?=
 =?utf-8?B?Ui9TMXZrTTE0Q3JoZDJlc1JhKytrakFycFN3WVJKRXVSUXAyZW01WnZiZ0RI?=
 =?utf-8?B?amc5QVZPN2ROVllBNS94RE1nNW1KMUhDMXN2eVVYa3BBOHc2UjFxQmdiZUk4?=
 =?utf-8?B?SWQySENEeEZsMjJjblFvYmlRWEpLb3RKRDU4UjFzczEvZjQzY2FYTG83YzRx?=
 =?utf-8?B?SXdHbTBReE5GNjhFUkxKb1diMXdkUVplWUJrQ0pFTTNrQ2Z5TnpVU0tYQ0RC?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: wKY7gEXHFIHgjLYen+jIIsTBtjj88My8QtMUaC/5XlCiepiM+cpUNQhAAJ0hEThbM7iE7kQgDLbzVnhx2KF9thBDZGdmCyVKAIBwXjQzfhd3Lmd+gGvBKq3lEQ/+2lGhCyJRye5uqTqPWEAyTKAIoe03TmG8HsujY3p+XMM/oMC5M+iRarLoD6sQnDXyJERfPHvQGPTdw4fYx5WL8xHGfoPVBE/r9kQGcZE2c+gI6B3fbbFPp6T5ui1GSrCfCEwpJbCgO1ounPyR9y/MwbKGY06UTXeR5mZTzfCehrdrboa/ACBdJDPgsFOCSfIXxT6RImdPuVBZeLPJTTgGjb/9x5ZWvfkTjEs2hs9vQyuevyin0gK3PdprRPnZR3/3v9KgYXUY84goYDBvdP4C6y5ixknNPFfcl3/xgFtbjMyGG9DH/ajVCEsuGVH5hgrjhBaBHIefDJ3KuStxvySEmkallioIZ9S1/iWz9VH6cMLgwULgO1wZDxzlBCXffaWlNt+JVfHsK69gvDi9OXFk6dV+z2zrDDnkYDCrc+e+bk23Uxl3XFZx0YY/X/K0GTS1fVB9FtRw15hvw8m1p5Wvg4p4TzMSGmSD5xdD0F2SoM1cGnKpCdlqaLeBGV7KAp0HtrQjiXmitATO6Z2NzvjgjGhjJQyshQqIZ2eCkbsfQ9PS3W3hdG2zzDdJMD/5BjtSKT+wkNTA6xPU5i1xKr7dAICJZhxqinP3vxtjn9WrTlWP8yxu4tfgbhS5ctTPvfx5+5Zk1FYsMN0nF1xHFJ/caCtU81jVz9G9esIeFzEgFBMzeDwI/aMCzdtbvh4i2vGCvvPujm1fdxNNiuTXV1pJf4zfdkxkdASDMc0gXRGETgRONVJuVbD//Us984yiJwKLp6wf
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 707d40e4-2247-427a-a24c-08db2fa5021b
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:56:35.6470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KBvGJ6PwBBC/WMC+sDyGiwZw+3sT8LGBs/Ww7c/L+BOshVru6gV1e/Je76CqOatuGijZ3Hc6lyfrG7QuwmfwiFp+HNhbLbkTgaviKhauOVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4605
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303280124
X-Proofpoint-ORIG-GUID: FdwdfkYiGLmDS2_UPTUMjrgeo-IWKSWa
X-Proofpoint-GUID: FdwdfkYiGLmDS2_UPTUMjrgeo-IWKSWa
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/23 9:34 AM, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> As previous patch introduce 'blocked' sysfs api to set 'host_blockio'.
> If 'host_blockio' is true will blocking IO.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  drivers/scsi/scsi_lib.c  | 2 ++
>  include/scsi/scsi_host.h | 5 +++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
> index b7c569a42aa4..20d618300a46 100644
> --- a/drivers/scsi/scsi_lib.c
> +++ b/drivers/scsi/scsi_lib.c
> @@ -1724,6 +1724,8 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	}
>  
>  	ret = BLK_STS_RESOURCE;
> +	if (unlikely(scsi_host_blocked(shost)))
> +		goto out_put_budget;

You can just put this check in scsi_host_queue_ready with the
host_self_blocked check.

