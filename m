Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5308F5FF29F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 18:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbiJNQxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 12:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbiJNQxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 12:53:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881571D4DEC
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 09:53:28 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29EGOFbP007182;
        Fri, 14 Oct 2022 16:53:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=FokC5M/7TmYXgf06jkQTCYaQsfk8lKtYu83Jl7ty9f8=;
 b=rElNRbk67113yQbID1DpLcEifaPq9s2ajIQf3S2TKiL5cZ6wkEt87KP+NBYGbfVvf7M/
 1X6aPk6ujsqZBiq4w3fPfyCjUVSiEBRrKS1NXEvMdsRHy0E61ufO1QZRi/n39Q54wufZ
 7jU5bt7CqIP2qrudyEiy5ZJReNpt4nnpp0vs0ZlBceafENIgUJXmS4fEc1h4g/k9ePg0
 F7npvoJpK5Y4jQ4H8DnM0uokFcP2D+pc67X2KzjbE+80KJx6naEsKS1HoYQvBEdG2Q3U
 c0fU0FYewQKgg8QCm4fJefmtTgdzyjaYtNmiM+IeJIT9tCRkyvdQi/cHtrUuCp/m+xMu 3g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k795k0hf3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 16:53:24 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29EFAriX003798;
        Fri, 14 Oct 2022 16:53:23 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yndx1ec-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Oct 2022 16:53:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SatcyG7dfRI7XDYsYKQAhozyf59SlsbaVnSGxinv6SOAfMFw8q5ksKhhZcBIlPGmD/tnvObK+V1QyxtUZaWDVL+yI70Fy5BTG8SOWlxXZc5mA0p8GubPz8lhqfNFQ2lETCJuPlvhAjWTcFxbHC62V2u26bdEbj2VTEI9BPD481fHB3TDYU5QIAXvFUlwmIdZ6qLeznE1blo8HP4C1EIsjDyworglzhxk/C6UHM4t03aGbDPjFxTh747LyZrQaMTeOajLoPYIyVPIAHwdqk+LPpMIH8CpQtyhOim7hDUunWHlQ1DUGRvrWdurQvi2oAgv5JxoHKAT3Iwfo3DoFqIx4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FokC5M/7TmYXgf06jkQTCYaQsfk8lKtYu83Jl7ty9f8=;
 b=YXGao9+wmQHEIJdcgqO39IjwkXC1dVRirt8l6pL4koYbwRmBPKatBhi3UTlOf5WFWcbw/zfhSZHg1PGjgbu3dyBweAi+8ZbvjrCqcd2elPTKKXZw0WQHKIAYyNJ6MBE/4XB6oXbumpqCZmW0UY7gPxR/hEzAULOLL8tyzgjWtYvgfP67Q9PVvJYZNY7VhtcenUn2jVOUqV2JhqwJryALPwTlePuXKygR1Fcnr4lMevm8z6GJpI6twO+N0BCEcQ1D3uZUEOokjv2tdN0Y7ldRtTKJuuWQzCbAIebjiPlskL0Ga2yj8r/jAk3vKGyshMb9ZtKCy1H/KJfQcsKQBQI8iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FokC5M/7TmYXgf06jkQTCYaQsfk8lKtYu83Jl7ty9f8=;
 b=FHxou0Wnp33//4/GuZfkBQKE2MatzRtBknJV5RBCemCc+WhepLBehac9HupjxHyay8lGLb7bsec1ncKIZCwrdn8on5a1HjdI4vzZVMuJPgAkiVverJBneORDQAEKX14A+4Kmy70lPdsPdFYshmt9ZINhCFm3QGz0daT1K8oRASQ=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BLAPR10MB5028.namprd10.prod.outlook.com (2603:10b6:208:307::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.21; Fri, 14 Oct
 2022 16:53:21 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::9d50:fa6c:853:c12]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::9d50:fa6c:853:c12%9]) with mapi id 15.20.5723.029; Fri, 14 Oct 2022
 16:53:21 +0000
References: <20220927225944.2254360-4-ankur.a.arora@oracle.com>
 <20221007004943.2910736-1-ankur.a.arora@oracle.com>
 <CAHC9VhSnWZ1ovEeajasBPQA0-_AgNW21K2Ycpc3wvSHw5uQZ9Q@mail.gmail.com>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>, linux-audit@redhat.com,
        eparis@redhat.com, sgrubb@redhat.com, linux-kernel@vger.kernel.org,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v2] audit: unify
 audit_filter_{uring(),inode_name(),syscall()}
In-reply-to: <CAHC9VhSnWZ1ovEeajasBPQA0-_AgNW21K2Ycpc3wvSHw5uQZ9Q@mail.gmail.com>
Date:   Fri, 14 Oct 2022 09:53:19 -0700
Message-ID: <87zgdyz6rk.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0315.namprd04.prod.outlook.com
 (2603:10b6:303:82::20) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BLAPR10MB5028:EE_
X-MS-Office365-Filtering-Correlation-Id: d2d30ad3-557b-46f5-a7f9-08daae0499bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ENCZyJJtiEnkUxgL9kyK4iDxW4STn8UbbHt76T98Rpy53BA0E8I8bsUgjNamnGNpJAIAs/utYfipkjyZWAhqLJtv7vkMKRzyrMGjeeVjf2sSjTcgR/yQDpaqQ05r2ebwlMwASfpCsYKNk7v/ogXWEZrGdDWUEa9mvA5OmYDloYqRK0gYsg7RZbZY145KIa8yKBBYuuBFllG9qPJt58G0P0dZk06My4ISHSTGGmzEptl3+XZCbaBqKanXor9v51/ys/51WgCheNq0UY9QewIlIBI5Rq1+qDtMPKnzhmlp5bEOVcU+H9iDpaTCQlsmS16qi5HXgdduR166RRI63oWIV6ih0HO4MOUNdWvtTjOCECME/1opg7au5sDqGmOjpg7pqyw4wSxVGdB6qPJfJuATnnfv8lH+61iLOD4FQgeGxvH3OLPulNgJoXO5KSl+4hUw9jYBi6kO7kuDDHeBU+6W181kTnYySRNa8yETz6lrU1Zv/gEF/MFHom5EkKXcpw7Wm3g+iEnTOMF1Z34i+f3HS2W+tm+EOt6Ak+Vs0qwNfnDX5b4l97FfL4GRyY3RsLAAI3kZm/WrnnfSdhJxhO71enTgZxyXgrix/P+5WAeZW9K31EY6quElkMtSRRqHKDC6SeW2Ilf9TF+z3mmb6O0zFYAJKUsC65A/HUi/abP89Xc3GJtSvfdyM0xSVNjQevEY6wfH0bcKaRQnjVDchsFvPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(39860400002)(396003)(346002)(366004)(451199015)(186003)(83380400001)(2616005)(38100700002)(5660300002)(41300700001)(2906002)(8676002)(8936002)(66946007)(26005)(6486002)(107886003)(6916009)(6512007)(53546011)(316002)(4326008)(66556008)(6506007)(478600001)(66476007)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YlXOp4e5WS6MuWYLs4WwO+fDnEVRyUAq+Roqygs3SwPtB/gsBGKTaB8mtFUZ?=
 =?us-ascii?Q?QJZFvPKK9fWzsM7BNeZAYTtjMMkwyNQQq4SFghPupxB9mO70l2aCEaOq/X17?=
 =?us-ascii?Q?SdbrMgFh2mjUCNeTgUk7bTL2YQkpgpPEwNt3FcJSdcrz81YV/uMqHqch83r6?=
 =?us-ascii?Q?fYHhXkxnZgGhU61zhIkV65zNeiSRFuvewF+mUYyGwQzRKh+3bqrISmKrnK3h?=
 =?us-ascii?Q?8paiI6PvJJqqceXyFlm2yAqW1J+wQl9b3YH8ugfOi1vSa9V+GMJ6t6qYXfE8?=
 =?us-ascii?Q?MMis8JXs5xVHGm2DMlhR0RW57CYrw38l4AlWRheG0Jt0XvWab8Mz7VIjPcpO?=
 =?us-ascii?Q?5WQ0gzaa66wDK0m9YVq+M+Eewj/u61CWP57N1HP2/RHv4iVn17FnsUB4V/ef?=
 =?us-ascii?Q?yzj+speg568JChM1Y+8rmGiZZPJGKLSW3MXcRE/USUGUushncaBab0YtBbks?=
 =?us-ascii?Q?BnPoxYJX/VXjSul2DR9UQkcgBGzNRl94ex5F3ZqHFLVaKB2f3xocygMFpi9E?=
 =?us-ascii?Q?r5W/u2Aq5KA20WBO7RXOOYr4qYkN/n8Ndnk2Q4vo0YoiKsVd2XuhMIavE9Z5?=
 =?us-ascii?Q?eDIIAwtomRj7+rYsKgGf/4VukPZnFf1nbIVzxmE57QnpEgWaTYJ2Qy+2ZKs/?=
 =?us-ascii?Q?xALBkiwQdTy8CyZxFB5pa8I9BX4NZbvprrUK+xW53AZCQlgP/tvGZ1QstlfE?=
 =?us-ascii?Q?fn7VeD7iCVZZiv3JwQ0tA9BqHRKOnpLS6xilnQhpXJn9xFjrmPHA86VnZjSp?=
 =?us-ascii?Q?j/FQ3dShAels8WZEPRkQ7mgTHp1QKOPwKFej0yxmfVzLRufs1pD/ntRPwhCm?=
 =?us-ascii?Q?2tlXy3XxJq4u6UmgKiKUpRxQpuJ6m6WBjwN0fy1/fQNToNmRY4SMMYsBPK6K?=
 =?us-ascii?Q?/501OrfBv538Ph539UXb+gFJV8haIOAI//cryOzFYJegR6O/gzQpM+c+KgRT?=
 =?us-ascii?Q?FbKzbG20Y+OWpFm2NIFqfCd3k0UbhNLD9MfNhNQToxvXifwMWPGvBGa1jOOX?=
 =?us-ascii?Q?YoxhHbJyXwABN3CJRTcPf6AB9WYa/V4eVwXDBwyWjgl5p9ktJmdgO2UM6VGB?=
 =?us-ascii?Q?437w09Gq9wiX8D/ts1M2OosLd2WW6JnLc1SzOsBaXat5mOiizQ/u1gti9x8n?=
 =?us-ascii?Q?i5mShrF89XRbgLhxTgtmTZNLpaxQkaj3fEZfHT9t9zYe2axrG84jtIWEJrjM?=
 =?us-ascii?Q?yQmJMnJtQyHISOOMrKWScGBJPWiNs8kf+So5BW77k7ELjYVSkVmjcpb99oHd?=
 =?us-ascii?Q?vhMbzPM4MUvKakGikmsxhtggxT9SQkPGqIau50rke2FScYTAHTqv5COtDOhT?=
 =?us-ascii?Q?JMPae5MpfC5MYPbuca5zTJkpJCn6zpHsOxoMXJ2GsE5/A+X8vEN8OKGwgKXb?=
 =?us-ascii?Q?eZosUPbgTBd7Lqr6qjCqWjzCVs+G8+LM8knRHfdE5yNk7/Auou9RNnuz+OAf?=
 =?us-ascii?Q?kEv7BsLFw52fhIx5lAKK99QDzPpRJ+Nf8OQJwer5CN1e3SjVsWGllzYrfsxw?=
 =?us-ascii?Q?KBjEvdx0//nWhBCF9FKtP1DfNSiXe1yb4I9qXFtBDMg5JUp/SdIC+WTXmPKk?=
 =?us-ascii?Q?v0hY4Z1hF+vemZh0im1YIiB1xAqUkfWgayjJ7YuE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d30ad3-557b-46f5-a7f9-08daae0499bc
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 16:53:21.0613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SUct462jRWlTnziVWVYB8bijRZopQv49On4WoCc7RCUndBxNrfs07poFraHnAfHTJnECalHp3grXAOqNANRwRFr59lD12cyqWFBHftcl+QY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5028
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_09,2022-10-14_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210140094
X-Proofpoint-GUID: eGntNJunOAWwJxSBATVpJWlO9l7M391e
X-Proofpoint-ORIG-GUID: eGntNJunOAWwJxSBATVpJWlO9l7M391e
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Paul Moore <paul@paul-moore.com> writes:

> On Thu, Oct 6, 2022 at 8:49 PM Ankur Arora <ankur.a.arora@oracle.com> wrote:
>>
>> audit_filter_uring(), audit_filter_inode_name() are substantially
>> similar to audit_filter_syscall(). Move the core logic to
>> __audit_filter_op() which can be parametrized for all three.
>>
>> On a Skylakex system, getpid() latency (all results aggregated
>> across 12 boot cycles):
>>
>>          Min     Mean    Median   Max      pstdev
>>          (ns)    (ns)    (ns)     (ns)
>>
>>  -    196.63   207.86  206.60  230.98      (+- 3.92%)
>>  +    183.73   196.95  192.31  232.49      (+- 6.04%)
>>
>> Performance counter stats for 'bin/getpid' (3 runs) go from:
>>     cycles               805.58  (  +-  4.11% )
>>     instructions        1654.11  (  +-   .05% )
>>     IPC                    2.06  (  +-  3.39% )
>>     branches             430.02  (  +-   .05% )
>>     branch-misses          1.55  (  +-  7.09% )
>>     L1-dcache-loads      440.01  (  +-   .09% )
>>     L1-dcache-load-misses  9.05  (  +- 74.03% )
>> to:
>>     cycles               765.37  (  +-  6.66% )
>>     instructions        1677.07  (  +-  0.04% )
>>     IPC                    2.20  (  +-  5.90% )
>>     branches             431.10  (  +-  0.04% )
>>     branch-misses          1.60  (  +- 11.25% )
>>     L1-dcache-loads      521.04  (  +-  0.05% )
>>     L1-dcache-load-misses  6.92  (  +- 77.60% )
>>
>> (Both aggregated over 12 boot cycles.)
>>
>> The increased L1-dcache-loads are due to some intermediate values now
>> coming from the stack.
>>
>> The improvement in cycles is due to a slightly denser loop (the list
>> parameter in the list_for_each_entry_rcu() exit check now comes from
>> a register rather than a constant as before.)
>>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>  kernel/auditsc.c | 76 +++++++++++++++++++++++++-----------------------
>>  1 file changed, 39 insertions(+), 37 deletions(-)
>
> Thanks, this looks good to me.  I'll queue this up for when the merge
> window closes.

Great. Thanks Paul.

--
ankur
