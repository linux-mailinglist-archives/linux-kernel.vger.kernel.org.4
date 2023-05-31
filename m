Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDF2718E09
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjEaWGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjEaWGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:06:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB1B11D;
        Wed, 31 May 2023 15:06:29 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VJgeGE027610;
        Wed, 31 May 2023 22:06:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=WIvendoBg1kZVZHpdCRTUUmDBfpXnofqOaQvC4VKhR0=;
 b=ZGvXjvPQqBltkqD9kiX/wsDOa8RviMU44D46uFBlrmjdA2mAWK3sKUe3V4SOwbOh+zaj
 ikqvjynjEosaaSDuTnfz/Awf9rYQv1DKY3WxkHJOmIW2Q58+cWgk0+jKbqEr/Gc/PESu
 PQcTNNvUs2yPfVC6INUTFfxJRq5sxxWzXe3pNB2vaLsr+z6wOPOnF5qozNXe+POIqBIR
 3eEF9x3RMxTvwheTMmSV8CB8oN5oz5kRdQAdqpoboR3HN27lrmuiFG/O590IjIVuo4ta
 1gqdglPR+TyO3bTUaAH/hSB2j+dSJv0B7MHmJvd+NwHmfAgxG3p844xPXjBOiCaGORYn MQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhwwf30p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 22:06:25 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34VKg6VP019709;
        Wed, 31 May 2023 22:06:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a6hegb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 22:06:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfVfaeB/V4ciV2SGWiRhpj/Pu7kaKFk32FN09UBLu+6O6lA4ywQVb/exiUQqI+0oGoQFGBrrTHhFIXiBEIxaUK2AeouHhLPot46rFbX3UIYMlwJ06meuyXS8pZ4cLngeOcnJIkAO3l3Qo2jCDpiDByxiQl///AWwNDRrta0kL1GmbyuvrF63n3+sZJ3WapM4qn2gd1lb6dSoK8J7Znd20bVBNgVaBcyndgDuWivtE6Okl0AgJig2IYUQXDH88HJbJkvFF9efl2k/cZCL5i23zG09EHTQQpFRmRIfq/LT2iqk/Nd8NqnKOo33/kuOfkENQoxVURTqLxxuAf7Qo4nz4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIvendoBg1kZVZHpdCRTUUmDBfpXnofqOaQvC4VKhR0=;
 b=eqdUv7KQwm1b5sN39DE8tkLDZzbEHTLtcB2hzn57klejOitm7CelbE7eB3cv1MgjZXd+Q+s2rE8bGcoJhljM2S7yon6owprTXFwt8m5tDcJ/p9Kbo5TGL0slgFtONSRG0/zbanI3N+cOtsuQuQ/xGIMfVWp5yp+LPUpGniyLlhVWqaHi+ImVKr10GFxT85Epw4K40vrC+DkqHRbLDHPbQRgwxBI6UW74ofYpRUgWFIxI9ABm0WgLaf/LRN1wf1ay7whbjyvrKsVwiUf5r2EXAaUD7T70Sz5J/ZiNRpcvvTCGNObb5EH+BTnnccEV4kJF2MSf77tg03tth5RJiuKR+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIvendoBg1kZVZHpdCRTUUmDBfpXnofqOaQvC4VKhR0=;
 b=KkswC7AmUp03tMZsjeULdvNAcpBc4+6H/yx6gAHQJtaF0ZU22pL1ZQGeulQ5STkOt81iE0gzskGLLXis9igd+jZWglNfF+OK0+buHgEQkETeFTHO+clxCR8c3mRbWrMnuO7RzdfXjdeo08PmMoNJOtRVNqNHfHDUvfHP6rNqZ1U=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM4PR10MB6694.namprd10.prod.outlook.com (2603:10b6:8:112::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Wed, 31 May
 2023 22:06:22 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%7]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 22:06:22 +0000
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Don Brace <don.brace@microchip.com>,
        linux-hardening@vger.kernel.org, storagedev@microchip.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: smartpqi: Replace all non-returning strlcpy with
 strscpy
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ilc8cg18.fsf@ca-mkp.ca.oracle.com>
References: <20230530162321.984035-1-azeemshaikh38@gmail.com>
Date:   Wed, 31 May 2023 18:06:20 -0400
In-Reply-To: <20230530162321.984035-1-azeemshaikh38@gmail.com> (Azeem Shaikh's
        message of "Tue, 30 May 2023 16:23:21 +0000")
Content-Type: text/plain
X-ClientProxiedBy: SA0PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:806:130::32) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DM4PR10MB6694:EE_
X-MS-Office365-Filtering-Correlation-Id: 3970fbc2-12f5-4319-f8c3-08db622344ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xbebE02stTYweKNW3vpb+RoGfIiNLI0yDAKd9FYK4JHTSJSviA+75VcCzDw78Vh1FZcpomOUo770DaU+WT4Ichv21y1BjH5OKhmkZswVyG0j0PZmJnfBSSu/IpYqcC5yjLbz35SL2xFMWCax+CQbpsLC3BSEAfMT5U6fwXhtdtbdvNdILHzRAwe81kWb+l4CvslIWLRY8nj7oBs6aiAasbb7jfsRiotwGJ3Iz5hyYqiWLJ3x8oUXk/GyowHd1BIDF3FNnWXoCqAYvIStfGr2AwisF1CMdbExOOlZsi0iRJKrzj8e1RHnfw8tn4TivTBXrgxZSbvgNc7Q7Vy0f5DhVehnKO6CveHcLUi73H7MTjoktrNCpzqrtxU5Y1DM8fbpVXdsZlAavZzUT68RRpzH8AwVv5hJACbAFXlCtI0CxiSpHOBr4GDrJkeRCIdf5N0vkhq4d0JCCNAxOAOyYs5YWlnozKywBPATllBp24FvLARvqA1EgVTacs74FNQks4S7auvrsn4NHobI2Wci6MDyjO1eQ1GYKBX5BfYcssZkZii4yOFZLUwYG3j8P1DpWKdZm5Xf3hR/ixP3WtzlDOmzona9DAHfv72ETviEy/Bx5D0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199021)(2906002)(4744005)(86362001)(66476007)(66946007)(6916009)(41300700001)(4326008)(66556008)(83380400001)(186003)(6506007)(6512007)(26005)(8936002)(8676002)(5660300002)(38100700002)(107886003)(6486002)(478600001)(316002)(36916002)(54906003)(156123004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nWTRPMLaXK/+N3ZwNFq4NIsdVkB0X7ff/jpsacXyQLIAVqxvZVWIU+JepKJU?=
 =?us-ascii?Q?4H8sBfUuK9RosorW6BC8+Qby3i/PKQUSnvRIQnoAH2bdBt09U2vYW5an1Isp?=
 =?us-ascii?Q?815XlS4ygdAHPww9hoyMRyl9/xiLHeBJVbKUIiYhcjzpK0JfP2RFNUuRyljW?=
 =?us-ascii?Q?A460joyHOw/SlCiRlwsZ9RfUnpoPN5iZiKbe6NNEu+6Q2bZk/I2fF8mr47Fv?=
 =?us-ascii?Q?QHN1V+oPYRxDM7u9NOz3j/FbAxb8H396TkxlzNOU6VvmXyTCwCxDWsgPViU9?=
 =?us-ascii?Q?bWiJyjM3x4j2bWWdSw6tmYn4P9+lx2e+iVZC5WCx4quRyKvrfbl8zKeitVEm?=
 =?us-ascii?Q?FGRGAgFPgvGw7bKttDat3VgJH5VpbPwO9p7vQg9oKTf4UcmgF0QvW/usm1Tx?=
 =?us-ascii?Q?wHTPSQ7z229M/dl3Z2BP3VT6l4sQKw3RiDVRJD3OQxDVSRsHuNYOeel3qZsm?=
 =?us-ascii?Q?9X8AItyF3Bh4Hf2L0OX3U31ORzw1vdq9jvVZX3iKyxSSfmnsYI0BAVjUFczZ?=
 =?us-ascii?Q?J2n683gOJUP3lJGn2EqjILW02bopt27kVkJ28MNPkAI6HoZBpmk3Ym5Ribbp?=
 =?us-ascii?Q?dNqBNIFg3lyFSipCBzFtfLzHuzX62Jz9GVkstRCjEyUSz/hcPyGd5n4Wr8DM?=
 =?us-ascii?Q?5QxQ/GdO/eRqnB3l4IQcVQ2L48/768Y9Fb9jZAIWpsZ9JlUrwfYahjGLGwdH?=
 =?us-ascii?Q?dyW7qJmxL54vBDpSHNijZ3ahEbPR/hf8CInbfi//vY2PxCnl+alhjz90qpo1?=
 =?us-ascii?Q?ek+0CHnd7UpDfm/BgFe+uLe9Cfi87c1hVrx2mwm9uPlSZR26zN3TufV2gBfB?=
 =?us-ascii?Q?+KKorVKwUohua8YSA+RdMFVKq4HiyvBXjYNAutIgi9g/i9vPQ6KtupppdqoR?=
 =?us-ascii?Q?QArk1s8bpkUuJDDwXmZhoGmdQxLT6+uslwt3ZqtXvfQmKQtPs5Osbj55nk2z?=
 =?us-ascii?Q?rtymLAd+WL6M8LCpcGtxo0Et1Yrk/Vj4TBF/TviZW9T6VsOpm31nrxJLnIO0?=
 =?us-ascii?Q?0/az/7FIfD5V6yFY7OeG+lsN8LRH3/eDt+Y+pkKsv2yjv4PavP2iRv6BXtZy?=
 =?us-ascii?Q?zvOuCtOB6BUqP17JZEwGYh/JhkpYTcmp2WNLqLWED/JJkGRudyiWB6Z4FQpg?=
 =?us-ascii?Q?ZFzPpmLN7+I8jSTmFhrW6O+ebSWXzGT3VfXx7SpEFnERpU33p4fm170ea+7A?=
 =?us-ascii?Q?KpWPLB17o1PI7zUUqGjkYRyFKKP9Ivd74ezU/VstgQjylvcTVU8Pwse4wmJu?=
 =?us-ascii?Q?QFEQ7Nai3Vz3bXWNBSAhmqqdsGFBc0+fCOL4IhPL+SBEDgl3D6gySkVz1Jn+?=
 =?us-ascii?Q?6qhy//T1UdfPCYLClt42NlG6r0BFMTMxIpZxs0gezfhvH+ORUcL933aeWi+r?=
 =?us-ascii?Q?14G+8yQLcP8ARGO/e3xpkE4wCu1kZ7L5xSDt63sQQZr5AIc+duokKXyvWO2B?=
 =?us-ascii?Q?fR9HDn7DyHMtYmAYSVTW5/CX8ULi7pOLWDSkxm09NWiIjMkFIddxU2GsiqrA?=
 =?us-ascii?Q?2odQHS8EmsutoXp9mWipvFRmaYa+Z9eewAkRx7Dm7mPU/J/F8tbLLaZXgac6?=
 =?us-ascii?Q?KEBNX2FWixR9el08Cbf9YC/eY2GxIp5P0ufs4+UmCZAZBOJ3vhxYjqD2jm0w?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UedM4TlrjwJFx1Llis/rK1XSTP+XTypz+qL3V2GuAVmHWjt19rOLKr9zbh2QPo997TPmPnJ7tNrZoEeyd7G1+NLuZLitD+2Q2D9oYh7+eNGS8zFfm/fS0qYuPX9VJAUPR1dt5mFHfEUvbss+gBH7X4Uc2y3gkxwgiIPSGCYZhSp8Bo/Zm6dTgEc7UDAC6rTPEnuFjDl6ARSF8oAAtKlJ3poBIjiwZ28PWtLacjQy3xC3TGJqs5n/9TAXm8wv2Dc32UM6MrfqeyiPOHHSG8ehYyAfF1Da/Y5rR/UOagtwmM9sJUzNrUeSU4GELDesXiAeysptOjlA+eE865X9Fc5E2mUj3EpLobNjW1al01t9+Lgit9o1aFP+DuEuelrWACJ6jdD/J+yhasK3hp+fx8UbQJijXtLnzUz9biSiZhRa5C1ywlZajQjz/PbNuvnWd6aW9S3VZCNLd/NZmK2YGWgAQKBeQEgI65At5Lu9usdPx/wS470xOwqg120XWav9/y4KCNSi1M4txgQEu26A6FebYVoFcA0KcK5bMwXsnmxzvD7tZeoTH4ABcc1uZAEsHUF2F38XHcowHZuIbRHf39eH93k0tOKifvie8DOZVdxA3Zn19vkTNjfzyIhRAl+495zxNJlmi5KIMJX8yi6DN7x7V8tDe1HckR66KJ4ZhsTOBbs2adbLpRMYHWXMfO981IMh/w1FyU99O+zf4oW2kpFOSO5k0q2D8fZqQ3tqBWvo2xsGcN6son2taPTWppQB73fYfgnSiKGMC0r87kvDP2p4/s6eRW9/RzR0pRG+O75ad7IG08RzCegwTawLcq1a05rjmmq83/e5Tx4gTsv8wB5cx5jloIIDC76i4mailsqUw94=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3970fbc2-12f5-4319-f8c3-08db622344ec
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 22:06:22.4333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LKthQx/4dlvvX3lVuAzhzmkNhSKxYijW01IQMpOqsb4F9wwlN4ifTUdt858b8pOKbhxvHrS0xxKXSbKFWyQrOy7jH0UmoT25NT+NdrOlzMs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6694
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_16,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0 mlxlogscore=927
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305310186
X-Proofpoint-ORIG-GUID: VR6y-Qtr_RoWdQEo6tNvs7Fg7AJWpxyP
X-Proofpoint-GUID: VR6y-Qtr_RoWdQEo6tNvs7Fg7AJWpxyP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Azeem,

> strlcpy() reads the entire source buffer first. This read may exceed
> the destination size limit. This is both inefficient and can lead to
> linear read overflows if a source string is not NUL-terminated [1]. In
> an effort to remove strlcpy() completely [2], replace strlcpy() here
> with strscpy(). No return values were used, so direct replacement is
> safe.

Applied to 6.5/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
