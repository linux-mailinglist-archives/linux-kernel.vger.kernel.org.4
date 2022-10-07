Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858F75F725E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 02:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbiJGAt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 20:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbiJGAty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 20:49:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61341B9E1
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 17:49:52 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296NxWRB025143;
        Fri, 7 Oct 2022 00:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=RMKeDgBbBZW2htlNrxcP4KI6Vitn2n6kW6Pch6KoMI4=;
 b=0ZDI6x8RuGEk8p/spJjcr22nNrNX/3GnLQ05U03/dKWiWS8czceVMFB+SO9AYgKRPcTu
 asTrjUZnbdiyBvs7igHUVmcj+NrJcSHS+q/j5U8EdWoO8cTuBStoAbZWYXB2hG8p+K12
 zd72rpvFFiVuAABhz/tfYUsvgEd40SodblL2zDMbqcBRm4KYm7kSjU39qCGyXgqusg66
 KYvKfBfHMUdeFGN7gTw1fqAq2H2wsWTmGz5yj///IIa+XBYLKZsOg7cuGEVL28pDKG7D
 jPitmAVrIa9MPkfHekH4HVp8droVMqXLGWstQ4hRoKvBqy4wquNUmu2tQka+V2ftU60A HQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxe3tx3gn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Oct 2022 00:49:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 296M2NG2000537;
        Fri, 7 Oct 2022 00:49:48 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc06axcu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Oct 2022 00:49:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwKrJEswOKC8Xy+h5GyNpqyNb0NmqULNvIvgddAAAqV5qqVAnLkKEjbkovKnwZ12pHdRtpumafR5k3n7nCA9V3EN8Iqs0r/aLixQKEp3XtkokC4tp4JgF1yHJocflrsoscm01Pj3fS0mepRFDoApLhRf3Dzj6wNBoDXTuhGAm1iB6vmXC8vtsRxcm47baSO2O/Fn4YFRiyRpWvZMNeClYjGqqB0NNSOPvWzBg6MDXfe5mwx9v/CpdI3aXok6+j1O+iodDXmzJAdYpSAcNA45GVKzCEWi0+TRh6S4TU/s1Ky+Ieov10+GNkWUIJFVDVVUiJKYbNO2dlWYKQp1PnOpQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMKeDgBbBZW2htlNrxcP4KI6Vitn2n6kW6Pch6KoMI4=;
 b=fbQ1VE0ruOPJp5lUZKVBDfQJ4tOWbb8VC5OD3fNfD9MPqPlhoThO8mKQ+epgOvK4p91I4miJg3uaCbTVycVyZjvv2lLvRFGYmUOC9izMdsYbNKj0e7vIvApe9WKgfGk2UQEFTeKJIrqtnrA95GqHqKM/Eo6dV3iHl60VDXkob8+axkeIENy0M21FRjud9opyvO4eFOKIufZN79hRo/K1fWb1pVyBgEj2+aGl4kOsSUEmBVCxdhHVwJY2EAPQ7ojeUatTS85XiPQuzSu15YxSumhhk1jTuHOFJilWikGAXEmkXxwLd3O0+u0VMavv5Zrjtw4YjYkY2dB4SNm7KO4+ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMKeDgBbBZW2htlNrxcP4KI6Vitn2n6kW6Pch6KoMI4=;
 b=hAesx20/2ZtHvn8r8kYhokar4DLALzqaHlMZXNR1X45zhWmffd9rnRqKlXkK7SunrgxbQxhYnj6UwcwBRr57k8777EkUR0HU3fiMeWb4DvwWe4/Qtd0G/mJYqW7owvsJ9wX4oX+6yf6zYlZvVR5ueNXnmohi7hWdtpIeA/7+pr8=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ0PR10MB4414.namprd10.prod.outlook.com (2603:10b6:a03:2d0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Fri, 7 Oct
 2022 00:49:46 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4c38:703a:3910:61d6]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4c38:703a:3910:61d6%4]) with mapi id 15.20.5676.039; Fri, 7 Oct 2022
 00:49:46 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-audit@redhat.com
Cc:     paul@paul-moore.com, eparis@redhat.com, sgrubb@redhat.com,
        linux-kernel@vger.kernel.org, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: [PATCH v2] audit: unify audit_filter_{uring(),inode_name(),syscall()}
Date:   Thu,  6 Oct 2022 17:49:43 -0700
Message-Id: <20221007004943.2910736-1-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220927225944.2254360-4-ankur.a.arora@oracle.com>
References: <20220927225944.2254360-4-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0216.namprd03.prod.outlook.com
 (2603:10b6:303:b9::11) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ0PR10MB4414:EE_
X-MS-Office365-Filtering-Correlation-Id: aca8c84a-532d-470a-4591-08daa7fdd4b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1RXp0AOwB9hZfFcINYs729WgswFbF3Zj50L5Wd0b28Zji0+sc3ivWaLl9PYUH5+GNrbq7EhF4ndvyV1iQ8gAiYFo7VhDphcYe8U0hPu3XxJC2vGu6WsoZACjjPXiEffOcF0s35ef+jyGRdqjf/YXXc6zDcL2nGRX0ukTNRezfYhO23DZjnfjbZdHAn5mEyBtuaCYm3GvqD4dj5ZviHQHihguHhVU15PKM49r8A222dboruOtoSCzkD/HX3+LlmpQZsVC3+ZoweWxULO0xFPfeBJ1kwS4suXZos9VUHouR0BHFDUB+VLJX0RGBPGIXGATpil1aXb8EHiV1vwpjb0uh8lLh/+ywCU4rM9L7lDEqpvITXdyQNgUdFzlPKZd/kMWmpwmIGwN0GblM4/tuMX+qVdYEi/CWFGsQJElW20xtvQfHUBD/1Zw/9sed6DXmS4neWN1G21QPhqSnxsLg77/ggR4lPlL6PX9XWVHOstPRxcTQ1bsZiBFWkwn50X7Guo5a5Py4T41YMjb6mv2eVi0/PUedFGpQESm4w7QK8XlScZaEfRuMxlhUHhRFFvb1mDB60myfl9kAWFhKjVpUppsEPY3RunX78UYoy1bhSDq7nPAa+kczE6aAnczeGtf4KZ+cDTti63BeT09D/WS5+WN4Npt381pf+YIvM27onWNGNPXRg1SLbfuU2E3XxbVbspAdHOZNKnCglk/KM+s1xshpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(366004)(396003)(376002)(39860400002)(451199015)(36756003)(86362001)(186003)(103116003)(83380400001)(38100700002)(1076003)(2616005)(6512007)(26005)(6506007)(107886003)(6666004)(41300700001)(478600001)(2906002)(5660300002)(6916009)(316002)(66476007)(4326008)(6486002)(8676002)(66946007)(66556008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XVStBiwHRXoU9IYKHIwjn8tEvWC2AnLEBJKQzhpQNOHKrZozN2UagdckjBBa?=
 =?us-ascii?Q?ag//zlz8Sy9gc4Z3B39nYTcHrFeKV5FTqNeQDnBqORUuiEBedwArMR8Rr25E?=
 =?us-ascii?Q?U+6y2xLR44DCzHqa1slzlpSJgbCEe2wPfVaEazUw1m1XjB+oZZkXtHS8sCZL?=
 =?us-ascii?Q?26wPWRa4hCf6Y/jst4ARupfwp8D8yBGevyGJNxjTpUt1kip2BhTwv2ewcTCK?=
 =?us-ascii?Q?U2K/Vamg8RN6CBZUMFUZFBf7CKV1/sABUxN1vcSCGJzvixwhL3mbzJifkkCZ?=
 =?us-ascii?Q?UWERou0UpxXcmSu9xwjiXIjeGYrZa624804YRxNTa2u1MQixsk8iX/2oTV0t?=
 =?us-ascii?Q?F1gJaApDVu1ESLsrjJYP7O12tMx5L62QDWqsakoo53h53ssd+uVgGGRKXafC?=
 =?us-ascii?Q?3r8XNeu9IsTuCKfjHHSU+q/xtVoVzcF2M5R7hX4gubco8u3xzo6mHUfuE+uT?=
 =?us-ascii?Q?5SYyANrPedp235GhZ6ec5mFaYy7dLHL1n8TIG0GqXcENKqiwMkD88wRX3iiv?=
 =?us-ascii?Q?KeBIIO6E+gYf39pFiuKAyQ+48FBjQPbqv8BMlTbEsE+qZBGVkgC8IYGkud7g?=
 =?us-ascii?Q?CMfOEZIdkQbG6xPyNEYg1l3k753y7vSobA5jKwnfGMgFDIlSVx5EniaaBPUs?=
 =?us-ascii?Q?Vu4TzQhQaOiaa8eGcmY7HO95VV6TQlrpuFAJmfAmsvjkjqNld95x4CYCAodL?=
 =?us-ascii?Q?rrTf7k6nbftj9ot9W+0lKeWtAycumC3xTcpI4uEGCSqXm1znwhPlc2Z8p/Is?=
 =?us-ascii?Q?dspMFjDpxrEWyQSpogBzZxCiq1v2JnC3XsMo4TBUNPvUnj1wVLl1UAY+1K6P?=
 =?us-ascii?Q?JqUSuMaPvhyjnV66jMZ1a+TbY+7wf76fji4qZkschh5VEM+kEN3aprLwh2T5?=
 =?us-ascii?Q?bRXb/oXA3AvfxLQJln2aqkZpUeozVuLN4Bcf5aleROVC21WvYAzB49A93nWu?=
 =?us-ascii?Q?ZECZ/B5UUH+uI38J5r9sJ5iEsVDA3M8th7qZuuEA7rDHBd8OihZsvct6iVJZ?=
 =?us-ascii?Q?NPI/j4Afy4+aGEPNJV0p/o8fGEJMj8sWteDmmKS1IQQxq106fMJEwkHruU7u?=
 =?us-ascii?Q?FiWZYN/W4u84D5ac/Hlrrq0a/L2SlN1cjmPUbQnaWr4GZmHHngWTK0VpJIzq?=
 =?us-ascii?Q?1CzHVC7NqeGE1sSIPNoy6vKcxXV1ea+Xp/sBfoxy1iPCMo8rw6XiZhDamh1v?=
 =?us-ascii?Q?zRuROB0O5bTZg7qqT0XSbdyxNtPl0EqUtGgN+9n0asS59zXk+MvfFyEdo89D?=
 =?us-ascii?Q?FZXH0w6OcUeMaawge5YxPtpq9d2Wc4zhPQ5D75LzmGYrAS8rhPeCMc9pfPVh?=
 =?us-ascii?Q?ac7Sd7lVdYVOYcRIDAWNkSZwd8a4B5u2OnIXUGDKR53SMXQ4qv6A0pK0dtyT?=
 =?us-ascii?Q?xhlOE0NYg7M9POhTZDapI2SSARTrj9j7Czzdo1Il2XVPK2BAlHs6w71FYdCz?=
 =?us-ascii?Q?HhgQJus5kQG/qY7TI0lm+QQe0oeY0VzPu7tkeHDmEXSL038YrMXf9YCYcsT7?=
 =?us-ascii?Q?F1cq5yrR4RPSSgPv/WppSF+EEkzfPiJv0hNfNoW+MNwWGTFb+g1BqC9Xm0HK?=
 =?us-ascii?Q?G6OtVpWSScNG0WyiK3RO88jj1/pzyLUtDFpiExrrBO1jqMPUHwkDfzJxaj8D?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UXb9d4A7fGDjoXUPaTzjmjXdusIgr+MtGwy+6VmLd2810l+WhDlBa5oedtWkbDAvxGwoXgnACGuMo3PIJBFMRuYY2RQuWALjvhqcsYq5JFK5IjEO3fFGYrxq8F9ISiCgAoihrA7s/E0ihMRiAYw8U44CXyHhXcybdYWk0P1gL0BggFGKb5mPt568N2gHCuLfRoJGJcyX9JJCUseCI6hRpZvGWPcECXgmOJLlW5nigpm5d3MpsDoplSv/pINRYD6PhLIPtpq4vSLZv+EwPqp7T4WoN7H+dQ1Pe10G8UMNYfuoosN62lAXGaKJKDwsz0PL/QeQKxwhEyKbA2TDhGCUaO6CGxW0Lc3X7zEslqQf0kcRlkry46bbOUEvY0kdi7IBDmvG6lcgvBZe0utBrSmaaXoxvn5IVK6lFLo3W2BGX9sHlC/34eOGD4gRIb0pnsdg2SGXXXGjqzLO3rEUCmH6RMRQq75K8LwQuxUaQGdre8ML5cbFzyCiEfui0L5aGqLk+pUmH1ZXUBVwVoB0vas1DQ4w7UYL4HHvGIaokUVQosM/ZhKHR8YR/Z4zxwTjIw+VbfZxSIBTmjRegkVxOzwcqoW6qVkhTK2r5NQWxMr8oB+e0cmZouZVfXyUAyVTO5vJ4YQJQ7q2FOuTkorycruxk5CR81aHqT8R8TCWF8Sm090KDBOXF+ll5w+uRbWsamVISf0Ar1jFxm41WamXYJqglMFxnJfthk7NNvMJQGIATvm7N5Js/ORtOZhbSIxg7ERgN2SQuTPDeqyFhxfXsuKVYqygIBPbCzYNrIbtzRInegfXPexwihBcDP9dd90MF6BTx0ZVapp5qLw9e++Xs5oBgVbwl3EQPiNVuRDeKDHH7uhvXgDWRTrrf6iP+svSeIBmwglRZJAyzmhxH2rSnM29Bg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aca8c84a-532d-470a-4591-08daa7fdd4b2
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 00:49:46.5707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BiL5Nkmb98aDEuPY54pgBFkkpXv3bVJTC9HRsHv4tNvcrqohe8tMtUaLQlYawfmR/gSLUvLlllKwvMolHsgTZpsa8H9qpQBpNgZkmjd5+GI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4414
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_05,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 suspectscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210070003
X-Proofpoint-ORIG-GUID: fw3UxltV4GfzV15JDIsYgINTf6XuTFb4
X-Proofpoint-GUID: fw3UxltV4GfzV15JDIsYgINTf6XuTFb4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

audit_filter_uring(), audit_filter_inode_name() are substantially
similar to audit_filter_syscall(). Move the core logic to
__audit_filter_op() which can be parametrized for all three.

On a Skylakex system, getpid() latency (all results aggregated
across 12 boot cycles):

         Min     Mean    Median   Max      pstdev
         (ns)    (ns)    (ns)     (ns)

 -    196.63   207.86  206.60  230.98      (+- 3.92%)
 +    183.73   196.95  192.31  232.49	   (+- 6.04%)

Performance counter stats for 'bin/getpid' (3 runs) go from:
    cycles               805.58  (  +-  4.11% )
    instructions        1654.11  (  +-   .05% )
    IPC                    2.06  (  +-  3.39% )
    branches             430.02  (  +-   .05% )
    branch-misses          1.55  (  +-  7.09% )
    L1-dcache-loads      440.01  (  +-   .09% )
    L1-dcache-load-misses  9.05  (  +- 74.03% )
to:
    cycles		 765.37  (  +-  6.66% )
    instructions        1677.07  (  +-  0.04% )
    IPC		           2.20  (  +-  5.90% )
    branches	         431.10  (  +-  0.04% )
    branch-misses	   1.60  (  +- 11.25% )
    L1-dcache-loads	 521.04  (  +-  0.05% )
    L1-dcache-load-misses  6.92  (  +- 77.60% )

(Both aggregated over 12 boot cycles.)

The increased L1-dcache-loads are due to some intermediate values now
coming from the stack.

The improvement in cycles is due to a slightly denser loop (the list
parameter in the list_for_each_entry_rcu() exit check now comes from
a register rather than a constant as before.)

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/auditsc.c | 76 +++++++++++++++++++++++++-----------------------
 1 file changed, 39 insertions(+), 37 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 2206cdf1ba2c..4991348e300a 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -807,6 +807,40 @@ static int audit_in_mask(const struct audit_krule *rule, unsigned long val)
 	return rule->mask[word] & bit;
 }
 
+/**
+ * __audit_filter_op - common filter helper for operations (syscall/uring/etc)
+ * @tsk: associated task
+ * @ctx: audit context
+ * @list: audit filter list
+ * @name: audit_name (can be NULL)
+ * @op: current syscall/uring_op
+ *
+ * Run the udit filters specified in @list against @tsk using @ctx,
+ * @name, and @op, as necessary; the caller is responsible for ensuring
+ * that the call is made while the RCU read lock is held. The @name
+ * parameter can be NULL, but all others must be specified.
+ * Returns 1/true if the filter finds a match, 0/false if none are found.
+ */
+static int __audit_filter_op(struct task_struct *tsk,
+			   struct audit_context *ctx,
+			   struct list_head *list,
+			   struct audit_names *name,
+			   unsigned long op)
+{
+	struct audit_entry *e;
+	enum audit_state state;
+
+	list_for_each_entry_rcu(e, list, list) {
+		if (audit_in_mask(&e->rule, op) &&
+		    audit_filter_rules(tsk, &e->rule, ctx, name,
+				       &state, false)) {
+			ctx->current_state = state;
+			return 1;
+		}
+	}
+	return 0;
+}
+
 /**
  * audit_filter_uring - apply filters to an io_uring operation
  * @tsk: associated task
@@ -815,23 +849,12 @@ static int audit_in_mask(const struct audit_krule *rule, unsigned long val)
 static void audit_filter_uring(struct task_struct *tsk,
 			       struct audit_context *ctx)
 {
-	struct audit_entry *e;
-	enum audit_state state;
-
 	if (auditd_test_task(tsk))
 		return;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(e, &audit_filter_list[AUDIT_FILTER_URING_EXIT],
-				list) {
-		if (audit_in_mask(&e->rule, ctx->uring_op) &&
-		    audit_filter_rules(tsk, &e->rule, ctx, NULL, &state,
-				       false)) {
-			rcu_read_unlock();
-			ctx->current_state = state;
-			return;
-		}
-	}
+	__audit_filter_op(tsk, ctx, &audit_filter_list[AUDIT_FILTER_URING_EXIT],
+			NULL, ctx->uring_op);
 	rcu_read_unlock();
 }
 
@@ -843,25 +866,13 @@ static void audit_filter_uring(struct task_struct *tsk,
 static void audit_filter_syscall(struct task_struct *tsk,
 				 struct audit_context *ctx)
 {
-	struct audit_entry *e;
-	enum audit_state state;
-	unsigned long major = ctx->major;
-
 	if (auditd_test_task(tsk))
 		return;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(e, &audit_filter_list[AUDIT_FILTER_EXIT], list) {
-		if (audit_in_mask(&e->rule, major) &&
-		    audit_filter_rules(tsk, &e->rule, ctx, NULL,
-				       &state, false)) {
-			rcu_read_unlock();
-			ctx->current_state = state;
-			return;
-		}
-	}
+	__audit_filter_op(tsk, ctx, &audit_filter_list[AUDIT_FILTER_EXIT],
+			NULL, ctx->major);
 	rcu_read_unlock();
-	return;
 }
 
 /*
@@ -873,17 +884,8 @@ static int audit_filter_inode_name(struct task_struct *tsk,
 				   struct audit_context *ctx) {
 	int h = audit_hash_ino((u32)n->ino);
 	struct list_head *list = &audit_inode_hash[h];
-	struct audit_entry *e;
-	enum audit_state state;
 
-	list_for_each_entry_rcu(e, list, list) {
-		if (audit_in_mask(&e->rule, ctx->major) &&
-		    audit_filter_rules(tsk, &e->rule, ctx, n, &state, false)) {
-			ctx->current_state = state;
-			return 1;
-		}
-	}
-	return 0;
+	return __audit_filter_op(tsk, ctx, list, n, ctx->major);
 }
 
 /* At syscall exit time, this filter is called if any audit_names have been
-- 
2.31.1

