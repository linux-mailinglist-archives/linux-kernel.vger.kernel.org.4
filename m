Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9CC6D3B97
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 03:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjDCBsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 21:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDCBsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 21:48:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F4A5FD4;
        Sun,  2 Apr 2023 18:48:04 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 332AxpgE029290;
        Mon, 3 Apr 2023 01:47:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=Qv7zjfmlbPfWjYnlOqsbN401wtWRMAoEfSE0sLTX3a4=;
 b=EZdPBYoahFWU5nxZ637RlkqTa/YIUBTjhpnb6JlrdFmwpvLK6I1PNNAZrLVHIgZv4Wqo
 TwiqiW2WaKGVCnC9LnbkNzU1loQKqEFlJXoAAt7a82hkb5vel6DwEo3j2RIWPt3UoGXm
 I+LcrVVWNjCQ6x4FMJxGQVu2t5DbEG/GJFQQdGS3fvbDmtE8qDvbzv2EYcW44iXWpE41
 PuuuIjD/ylVfM/pE9c50Ttx5bQsG2GGdQhVgnUu+SulnHVjxAr/EkBz8DILAWA4FzJNY
 w2hwqFnUYY+hdK8J36P61dYywOGrHsuipCmFH8mNIYtGOik8BEdIQ2TqlZAp0BVuiTZK sg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppbhbt172-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 01:47:52 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3330ulTb027613;
        Mon, 3 Apr 2023 01:47:51 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ppt23w8px-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Apr 2023 01:47:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZQIcDvjQ6gzduN26orrnsp1RO7l2VHwRuNDqNIsDWdIS4lsxCEZg8cJ5qpmK5Z4PMBuy7h9oBjr7DCkCKzof2W2B0NwZa7Bwfup78MRcQGVr/Q4gYTFHPh9ebNCzW2FhEGCr0HzlpV4zYZrWRwDVv8ffEacchmWiXzW5EHFitsx4h/hw3pajbwA3Htlm+vlPxGcUSmKJK6ZxNMdqNDfo8nv/4nHjKbFCEd7Md2xfNM+lpRMn5ILiSorKGERwaVNMqXUQqRA+BVEqz0nf3gtoIKNqHftuR3yKHBlSVdrR2WOiZ61N9EfTn20NymEm0B4yun99+kWnXznkeq308fijRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qv7zjfmlbPfWjYnlOqsbN401wtWRMAoEfSE0sLTX3a4=;
 b=LWCtiemCFZG2Xnv70x8ZTqAQXcy1oq1mS5f5qlzuBSNHZUSHHxMy/OTKVJ+FHLkAJA0QU2ePYlSlH0mSc7DWHOsj77Mrja/SsRi+ZUpOfRweR73Yy2hYo0ea2o68Hp4K2Lz7jmiXq3YpvMql6/fYZH39qdG5im0Ou/AtYcUIxRYeB6OwcrWZt2atIoynYzJz2EkkcHyYClIDPcxREUNzJqlix/OBc0wUtQzfvWuSon74K1L0DC1IKrgpxL+nDmXzwUjSPDepk+m3dAno3k4T1fPDPo6z9HW2mFFqqDcwAwo0I7dnTlvtL1CIPyghM/HPrwCgcz2xf8wCAyBgKo0d3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qv7zjfmlbPfWjYnlOqsbN401wtWRMAoEfSE0sLTX3a4=;
 b=WZGlFSt5LJXuyRjobjoYwltwPTe2BNINRwhkZ8lVjVgIK1ayt6QzMU4ZiYxxuwiwRc95rAjSZt+tchIJEIhAMF5IUeqwXWsBvV/3wFMYreCG3rY3r0DSYSGVpJeqTR2StWlDjj2SU+1XlHxX9XzDSBdDCP0UwdUguA1r8JOBvKA=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH0PR10MB7533.namprd10.prod.outlook.com (2603:10b6:610:183::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.30; Mon, 3 Apr
 2023 01:47:48 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6c5c:93c2:3d1:5e98]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::6c5c:93c2:3d1:5e98%6]) with mapi id 15.20.6254.030; Mon, 3 Apr 2023
 01:47:48 +0000
To:     Tom Rix <trix@redhat.com>
Cc:     kartilak@cisco.com, sebaddel@cisco.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, nathan@kernel.org,
        ndesaulniers@google.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] scsi: snic: remove unused xfer_len variable
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1h6txwxc3.fsf@ca-mkp.ca.oracle.com>
References: <20230328001647.1778448-1-trix@redhat.com>
Date:   Sun, 02 Apr 2023 21:47:46 -0400
In-Reply-To: <20230328001647.1778448-1-trix@redhat.com> (Tom Rix's message of
        "Mon, 27 Mar 2023 20:16:47 -0400")
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0076.namprd11.prod.outlook.com
 (2603:10b6:806:d2::21) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH0PR10MB7533:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d525c27-3bfb-4dcc-65b4-08db33e56dd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /pbccXuWF7LFm4fVcBHE9ZIAACf3aOyhFh2+rO5U4HP3goxTGC1thCbBidTrMUqaM7vXY/uLvYzRMH7LgxJTC5ppql4JyeOdtH+r9qKThf60MTtRnwVZ0YQBPquYxjACOPHuetpw/RKx3T2WwOMfqTuFsTWtM2dtIAFoEftid0VslEvorD0RGOXTGNiYwoViC+eGRYMFsq+slfyGOH9zOnnE6VsH2k6FCVMfjK5+1LFvEwXXNjUhtfp2cW4eo6UQpZlte/PPDPcoll4Znop574d5VF2Lt5+5cYcY8UcbQO7tp4cM5wg6QdwB+8oDxO/PXUGK03oagFBcTcOjxwhOEsMHel7dgwkNFia2w6z0Zi5oaWBB3hGV1bj6O7Vth4zwi7oj86IszW6ytd5he3hUxuCHmfj2U3Rd4YGrvNFm6m22AqXRJoN8tt7blzhMpMbuAlfMmo8KgLc6Dd2Mg0WXW1A9XR3OB87kYaCvadruAbg9PRy3KFHpMYqATSqoZub6qvQTxLSD58EO1hSuws5PQD1+hN4gKxNO7qkRaydLtOmbmkiE7fOla+91962h236w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199021)(558084003)(478600001)(2906002)(186003)(6512007)(6506007)(36916002)(6486002)(26005)(6916009)(8936002)(38100700002)(86362001)(316002)(5660300002)(41300700001)(4326008)(66476007)(66556008)(66946007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mS/GWMajdZ+Kba/gWjAYQ+Qxi9MP/+rhxBq4vAjT18pPBQlQ4LLRNYuU5H+o?=
 =?us-ascii?Q?N8UHtGxTp8BdhVNz43RIyQ6N8jT72u8XHzhnyuWUpbgsWhHFA491REnMR1xy?=
 =?us-ascii?Q?5fygAOxBsOlDIPurKXLjunPXB1pM1k+hyCWTyjAhK7eKLaHck84URBVLy98X?=
 =?us-ascii?Q?OI6qIlE0FSWcw/WZVkgtjylZyR5wKNpPL5/mEZFZ5NwaWe49QynKRaJ7kneX?=
 =?us-ascii?Q?+LxGqBHtx1qmiB3kXEtN83Kem2El6ucPZBf6GIgAl/M93kwCfRsbIAg2iWVz?=
 =?us-ascii?Q?oUz/teLOcBhMf4h2/Vd30yTL2Wcdjt/oz3TIcNFILUqSszgH/whr9zStpVIC?=
 =?us-ascii?Q?NNT0ZLMBxLkW6g9nnpnFeVg3Gvolhiiyl2C9djSW7Rm4lgbisbmpUEdMfZlu?=
 =?us-ascii?Q?bX0/K39v/ANhmIRMnNka5xBG9qelocYfz11M0m9p46OtxRlcbqQz35JBX5Cv?=
 =?us-ascii?Q?Q0Y1f4CTiuDvhPXgFx1d/y/22tM6OwpRJf64LaiIfqi18TudqEA7OTX0W028?=
 =?us-ascii?Q?NNtJVwH5Hli3dx0wjNX9OQ3PJ6U0nvHoLZPR0f/qMG0mBW/BtRzuA+vImSSa?=
 =?us-ascii?Q?nAs39K36UdTmlu5SayqSU1daD0Jow/mUiTyyZMiEMCuddZH81NNH3VQlpoON?=
 =?us-ascii?Q?m6NMYQELtckwn8yxQpFShtHIAU/vISYgS7X8/eKVMMrZKxi0wYt/sKzqBx85?=
 =?us-ascii?Q?qN7Uo6b9+S4928UAor4z+tfSBI737Ss845hWy/0cpbvkzTLMGs3W6H73svyK?=
 =?us-ascii?Q?X335EoKxtVUlIr+tJPOaDtOP2/MqPmq11UjzWaZWmUthYHs7WmtVFroJAOZW?=
 =?us-ascii?Q?hGfoZ5QaRhtf7DUh0blnY8NZzyVbTBtc9SmH23n2Z23loIW8PRAQVYrsV6mQ?=
 =?us-ascii?Q?zCl9tQjAwmQ4iRFyjnmAS0mW/TWM/f+U8BfXed3suHfI8t8m9FAtDJ4AFMH0?=
 =?us-ascii?Q?Fy6PzM2By3cKNVJFkQ2Hs5SG/xkqQJecOZ7iWIeCo0vQFX75jU59tJpPUzqZ?=
 =?us-ascii?Q?b9hsIWh39HRUAXTnGWQ46AQkITG3M3CVU0tOQ5rFvZWlQAiXiSqttwu0mBoz?=
 =?us-ascii?Q?h06fG11DM68ursUMbd7upKz2GXkyRtfv457phfR17Hs33MijnrZ2boZ0ufqd?=
 =?us-ascii?Q?uCnwphTr1outYt88Mdn46WtBYRkwXb7O71niUhBXftvzAZ0kE0LPqkGaeCEb?=
 =?us-ascii?Q?IRahNxBCycdiWUPFgxmze3GhXevdnisWQuCfqrRy3iA7SpzSgl47+ykeDe5Z?=
 =?us-ascii?Q?T7YofPNmSUDWHsrb3JK6a7bChuSJjLIabx0SsO4LB1o2EfDykDaD6zUt5uKr?=
 =?us-ascii?Q?+ckUb0e4avfRzgEDQaA++aPfrP+TLLVVJCtFqIRrDyLm6dqCPmrD5XFopbHn?=
 =?us-ascii?Q?pY4VcRwlXiGaxZkwoKcr/JrFTPmf2UDEa4PMy3ywuyvHDbz9fmSeNtlSCWTc?=
 =?us-ascii?Q?r6eXJnys8tO7Ig0rDElOdgG/imIVc00zP5xvmw7h0mld0cGKIjn9umvWT2dS?=
 =?us-ascii?Q?L8yU+GuYHc9FFM7YJDzdAkifBlN6NMTuQyluMuLvJrbRyvDdNU8kVzw4EsGz?=
 =?us-ascii?Q?/Az5l0OEIdG2R2xt2HYsZzW7TwZKc0HeuCf0c39aTKHBgpppI2kQNcSi1dKn?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ieFfQQ51RyW7LchMie8q9zDTuFbJdlKSnTeFLHaTahLvau3DhHxvYgCPdQPe?=
 =?us-ascii?Q?KJQomUxD3CKO2GFQLSCQkaE+gpxRljSbzQ2MXqRa03aQOufohlxY2Q4zN5DV?=
 =?us-ascii?Q?mOx+DzzKy2v4/oiZIBdi9mTzpXo4+hD/e4j1vjqQgAbxZGoX1e/kew+oun1W?=
 =?us-ascii?Q?Nfqi0j1NMEi+Wv9whIsMD8ybKwughOfYXFl6XZYTUxwSwIv4eKJpJzAAMKPX?=
 =?us-ascii?Q?kyXQ+Bv4kU2zZjTh/k6NAnaX7rORYTw6oolht8CBcoHkUwY06y2WV7vDx3if?=
 =?us-ascii?Q?bEEM/eWmxH8x4rXjpWufydIr1s9T6PBo6vMmeUubhqbDnG6nx0dg3B9L312A?=
 =?us-ascii?Q?QS9njUN4r4JwKLhwUn5UZQoyxLs5s5O300hpEiBJFeAw/cO7IgW5H53wBrXx?=
 =?us-ascii?Q?LpPr7kG3Keji/nz5hmzXJScTWoNqZHciJY4hsnhPmejyV6UuW3ev6j7cNWrV?=
 =?us-ascii?Q?eYQbzMkdDVf7nB222V0leplJK89B/Emy2A2/cS9vQu3rHB8Ik7mrl5LytJWA?=
 =?us-ascii?Q?JChbze8UXGNIOGm5YL/R3tMnLqdBjljSWBodpnrLru8OUEpsG+xg2fRcNbae?=
 =?us-ascii?Q?64NTgoGVLNpgw6KRMWNH8d5JdlZX3HjlzBHBnNi2rckW5piUQd+isVmnVVnq?=
 =?us-ascii?Q?W9HiqzQM/4c2EVFm9DZrWAZI+8rOb0oBsg2s2SPZ+fn13dtB7aoOFPyF6xBn?=
 =?us-ascii?Q?VMgKiIfZ4XfuA8Xl7uW6mZA16nqfZQsMk9LL757ahIxBCG0b+957rxRZqPAL?=
 =?us-ascii?Q?8OkK2is1RzjgAoIN7zZPlO0tiLkqPNQk227jzbr7cpwTlfUxWKpRvyiW/lQX?=
 =?us-ascii?Q?VwZ+sPfwkvvWZDwSaMKB4hvFRBBdpIdEpchC1IiWUbUsllRiyOni3URHRjXl?=
 =?us-ascii?Q?tkfpMoq8BbM8jMH+nx3+TaRak6GPSd6lYU6GtmT5MxVv5eGhgLAIjeolaaiJ?=
 =?us-ascii?Q?kRg07SvDyQls6/0A7hbedw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d525c27-3bfb-4dcc-65b4-08db33e56dd3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2023 01:47:48.7591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HHaxWz3fwMKXZvz/s1N3MySWhFQTcwBOh+gOZIWbqIARBzNFmQY/cc3DyEkQhJ/k9IJ20n1LFHrLtZVdK9zfUmh8MTORvv68qn739lzsRD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7533
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-31_07,2023-03-31_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxlogscore=753 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304030010
X-Proofpoint-GUID: X3afEC7VBepfoEGSh81ZCYadQf-wQI7p
X-Proofpoint-ORIG-GUID: X3afEC7VBepfoEGSh81ZCYadQf-wQI7p
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Tom,

> clang with W=1 reports
> drivers/scsi/snic/snic_scsi.c:490:6: error: variable
>   'xfer_len' set but not used [-Werror,-Wunused-but-set-variable]
>         u64 xfer_len = 0;
>             ^
> This variable is not used so remove it.

Applied to 6.4/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
