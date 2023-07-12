Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39079750C72
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 17:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233676AbjGLP2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 11:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbjGLP22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 11:28:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CFE1BE2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 08:28:20 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CEiDXL013191;
        Wed, 12 Jul 2023 15:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=Tfi6QX7MoMch6N3yxNPU00IZ6qEmsdAICiEiy2yElzE=;
 b=38bqnF5dNEuJA7XyZOXxbjDTfKUlaZ9FGWL2lCh9zeUCUp4eApRSV9/lli69cw2q1XhB
 a9bsl5AZ5QCTVt7KtboJ425zob1tqxIO6REesE/UCNZK2Cb/VzjV8b4TalI0wXHsQX4u
 lb9RIRDbt44PnxzSJTr94qTQ8ddCjX9Noz0LiIO9LjTrVCj6KHRv5RUok4LKzNttZ4aY
 79b3rENTJIh5nPF+UlRAY6sBPexQIpZ3MNBTxgu/l5t4qQpe9xWjdZeykOwnrZQWiym/
 EXJW9wHyJwq3AjE0Je749qG4e4oroHUe1uG6tkvnpv8pzAwpxWI7KmS2ktNDJ5VtR1w0 gQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rr8xup0te-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 15:27:43 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36CEqLt8008596;
        Wed, 12 Jul 2023 15:27:43 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx8d19vw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 15:27:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyT93RomLOZktLfQ37dfIUNGrrGOjdHEiMlBlvLcT9Vw9wS32jlys+UkSEnZ231FWhnfXHY+oullgxoaXexZyD9r5JOlqD+nd+ZBglUsrN4Uz3MZ2Tfb7O46nrefkr/zLrwn9nYJ5nMjWxcn+ZQiqS7i61soJ+spbKuvg6evJ1+6IjF676HEEhvYdhH2L/DKG+2pL2us3WK/wxzpyK2LifXm1efBD8f9Pj0/hO4HXE9ZWttpLDxkoOtH8pj4cuARXb2j4Lgq5lOuwXV5bcixCVNjxUg87VL1q/4sU1QELQ6qn+a4ilaJ0uoWVJAtlE3A6GKXtyeeIoz91CZPf1IRdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tfi6QX7MoMch6N3yxNPU00IZ6qEmsdAICiEiy2yElzE=;
 b=j72nFLAEwljikqm+KejyRt7b2GyoDLhXzaYDrXogY8uFhgzcl4Dr4jGRelNrgtAfXbapmCLNYP3D3/vOTU8TvC90iLxkeReP+oOuju0VWbKMUJfUpFeKajztHAdhDtlSp1NGhJ+L5nxu8+r1ZRldAO8+pTAgRQBz9lndZO6TWZklo2kxCVqRkt6LA6Cql8t6gP5T+AN1Ne9aP+07YadBrTD4RpdbcKPhMHGqe1mZ4/m19s381ud7oqEZ5U4UlBwwcyflUZqJxUeA1dj808qYeD4xWkG+Odv9UsksKaXK3BOWMFIOdmCk2MJRH+/3Yhq83BjcFicFD3cNexROXe0cbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tfi6QX7MoMch6N3yxNPU00IZ6qEmsdAICiEiy2yElzE=;
 b=RHPXHV+LWY0Cue0yEk+fGm5aYWBI2vOaX3cSjDT+t2UAr4b+wzXZrxxFieucr1ydjSAM+oNxzL7CJOmCYk8bjsBCNdGpLLLnG85X1oSpkMGXwFRnR+Ayb+mphy5zOAcNbMWkZWMKaDnyYeLb1421KNFM6s1z3ettXgq5oiDkxDc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4772.namprd10.prod.outlook.com (2603:10b6:303:94::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Wed, 12 Jul
 2023 15:27:41 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c370:eff7:9ddc:f188%4]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 15:27:41 +0000
Date:   Wed, 12 Jul 2023 11:27:38 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     maple-tree@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: Maple Tree Work
Message-ID: <20230712152738.ld7rn5zmmhtc6wkg@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        maple-tree@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20230707163815.ns4kdz7iut5octjv@revolver>
 <463899aa-6cbd-f08e-0aca-077b0e4e4475@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <463899aa-6cbd-f08e-0aca-077b0e4e4475@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0013.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d4::18) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CO1PR10MB4772:EE_
X-MS-Office365-Filtering-Correlation-Id: f479a93e-8b40-4d9f-87a9-08db82ec8805
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7KxFl9YTlMJr+nkktIOueuiU+EvW0kTWT8Vxy638Q/gBVIz8SwnSZf0uzkEFkwi2C+RWiKYvuicdd+iZP4iSDiIF8w091+4L0BIYqH68zA3bJ0JQ0J/Rzei1GDYPZ+C76kPcqCyWrO9SpkCO0xOByl4nHEr4wEbh6APBlBBny26ygXrs6Pc7h5/sh+rFIYC6We/TRDcfzHJf0OHYRcPA56FXv6zHc9B5OBzdt9tyS+0W7e+unShEZdOKVDGkezCR+kbLnjfHIozMfo3hxIHAMr+TGJ02UiMv0TPxWUeUscX4kuR/4ldD3fpqtzQLrPcejsTO7R49XynpXQwZLHyO/gQ007xj2ZEMYw67/TZWWhQX5qCdGUkre6edq1pEodAPJl73JViKf7e+D53vugxfRv4bQ7an8CcHKzgWZ16up1e7qyhBesdGNVN2VglqXUb5Cple0csoX2AJ8ceG+RjUuhd8jI2gItULN0EuMKy8XYYbHrVHDiyfHjcsPnfpJ6ctBnP5wzVmDgoouddLSpH++TdFpJ0su5LIQlSD0/UYHd6W4fc0Ugw8rw1kO/91nDgzhjXSvuMA50riKq2bbVKYVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(396003)(136003)(346002)(366004)(39860400002)(451199021)(7116003)(8676002)(41300700001)(8936002)(5660300002)(26005)(3480700007)(316002)(4326008)(6916009)(66556008)(1076003)(186003)(6506007)(66946007)(83380400001)(66476007)(478600001)(86362001)(2906002)(6666004)(6486002)(966005)(9686003)(6512007)(33716001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0VoK2daZlBVV3RwUFNSWmpScXpvbmk0N1pGd25LMXpQNU9aSHJZaldwcTB3?=
 =?utf-8?B?ZzJSV2pJeTdnS2JaWlFRN3ZwVjBYV1RrT05pVUdUY1FwUHd2WGNxaVJYNDdu?=
 =?utf-8?B?MDNSWld1UllsVTBqRktyUHhLZEN1SmNUbnlMdXZOeHlHQVFERE05QnlqVG9N?=
 =?utf-8?B?WEdkc282blM3emE3MFJISlQzaHAwYnVDMTNHNVBuMkFuMVNHdXFHYThSZEc0?=
 =?utf-8?B?NTdTWUhmWUdLTDNWQVpabmlFZkl0RUNYcHZTYWJFUVV3UTM2RmVFSEduVXVh?=
 =?utf-8?B?YlZld2ZvME1DcFNuQS82UjhaSkc3dmM4MDZmOWl6blBLQTdLOU1hZFp3dlpv?=
 =?utf-8?B?MFBEaXp0SVY4cndhektrZXVmcmtiQ01LY01XZHI1aTN1bHRGai9IMGI0QW50?=
 =?utf-8?B?MWlzY0VVWTNOa2pxajNsQkhvOGU2cWZRMEVYYng0VnByNUNBeEZtMDlLQmla?=
 =?utf-8?B?ZWhITi9vRlREM2xoTndISHBsZTBYNFJteGUyNWsrWmRvbG15UlQrOTR4amdE?=
 =?utf-8?B?UHVxM0xDWUhPWXdxL3R5REFGc3NhUzJmV0s3aExSNzVZUDkrTysyMHRVSHp4?=
 =?utf-8?B?dWxWazhsTjlQVzZJRzJ0T0RXVDh1aEtLa0RkSFVqbnZlUmkzNTQrWHVOdzds?=
 =?utf-8?B?dG50cFc2UVkzTzY3eFlMS3N2RVlrUmxiVUtNY3hxaGtmencrVXJYMW9JbE9x?=
 =?utf-8?B?SzBldW5mTEhvc0dLSGloZWVrdXRaNnJxdkllZ082VzBya2g1T0J2c01jRTBr?=
 =?utf-8?B?VSsyUlB6ck1pUUpIeTB5SnNMQTVMVnJRYWFnVGU1TFkxeGJ4SHB6RGxJUVQv?=
 =?utf-8?B?MmhUdFFkOFEwK0xNUHJDc2FBMjMxYW9LL0NydWhDcWtxQXo3NGhrdjh1eERY?=
 =?utf-8?B?eUkrWWFsMzd1YitPQUxGTTluc0pHbTc0TzFlS1BxM3c2TFhFRW9oRGJTWDlO?=
 =?utf-8?B?enk3SGMvaDJKaWV0RzNQOXBhbFRsb3Q4YlhQNmovcm84MVR3T0JVbHNzNWd2?=
 =?utf-8?B?TWxPd3EvemJyaS9vSlVoTzI3dmtLdWI2bW1sRDdpb1R3cWlSWmRaUm9HR0Ez?=
 =?utf-8?B?cHVaMThyeEYzLzlqVDZiVy9XNEg2MUhKUHpKdkRObDd3WEFucHBIZDEzUEkx?=
 =?utf-8?B?UWZoQVNNY2pxZ21Pem1ObFllenNuWGg2NlBMMlc1RmhKd3p6aVZqRWQxbVVR?=
 =?utf-8?B?TVYrejVXaEF4OU1VK3p5Z1R3R3hRbU5FQXJhVTBCN3drOGpnMGFiZHVxNHpo?=
 =?utf-8?B?dWhJam1QcGhHM1NxTEtIaFJlSmJmWDg1L1NDUkE1SnVkNFF3bGdaWm0wTHE5?=
 =?utf-8?B?NFlJRWRJMlhLVVZyRGZRRXJ2VUFhNGhrcWhmc0hZUVlrZG0xcUFQN2RPVzZD?=
 =?utf-8?B?M2FMRFRHd2JRTlc1TWJwZ2FyREJUVCtYcSt0Um50KzFOTUNvdnJKUE1SQysz?=
 =?utf-8?B?bFU1VWV1cFoyalVwTittMHhyV0pvdktWOGYvM0NBRnF6SVFTaS9OV09UYzVl?=
 =?utf-8?B?T0NKc1hscnlTekcxdDh6ejlTSGtBZGFEekJHU0RBSkJQV3E2V0VUVXlBa0Jr?=
 =?utf-8?B?NU1OZlh0b2NMM1FJbnBJeVd3TkRDbVBWaUFYUXlodDhiVFRDc0hpRU01MnJR?=
 =?utf-8?B?MHNlaHlybklDNG9MWUc0aU5NV1R0YXVEaWJNOHJNR3RpTDdZQjFMMlBhYXpx?=
 =?utf-8?B?eEV1U2wzanQ1NFd0NXAxVzZUcThFdnVZR3J2OGNsMGZybkVhSUNPZFEvSmow?=
 =?utf-8?B?THJNTldJd1hlV1Rvb0tPcmwzVFRJSXV1ODF1STdBWVNYbWFoVlZVM1hSUTZH?=
 =?utf-8?B?ZUxCNzVLcEtROEV3TERndzB4SnZzd0l2VGV1bE1MbW41K01xRURjTlBEcTU3?=
 =?utf-8?B?RGFKUEJUU2k2WTUrNFlPUURFaFJJS2pMa3llRFdOZk5NUkY3eGtLQmZRYlgz?=
 =?utf-8?B?cUhVME5TdHprSlpxb3MxbnVVdkJ0SGZLL08ySUNvbHdTZXJuL0FFeUJ1UHdp?=
 =?utf-8?B?bWQ5bndxZjJZdWxFdTlpTHVacnhuRUxkZU9RbURnalNPNVJiWnZUK1dSZWJV?=
 =?utf-8?B?TE5ieHViLzdEZjQ4Y0NjWFV3VjlsRFNzWTdiL1JYaHFoc25RdXdtS3lDWUtz?=
 =?utf-8?B?dEV1YklPN3hOTjNRN3ZSZWQrVjNPK1hzYmp3WEZzNHgwVjI4bEZKUlo0dEt1?=
 =?utf-8?B?dWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +tBHN/vhk0pTvEB6CNXOnZKlnlw+xTkaL6w4jIpIwPTswOpDFgI3NUYmVnfWDy4Yumem7GUNx9eloIDWzN05vv+Yr5n4nS5c+ePV148KWSxA41qdXpMkp9YMzxRzQOfA7CDBf8WGMJzYAEG+dcMxpwxeMkHypTVK12vR2LjUAeBD3LmW4WCFvrSQrPU8mrtELTdQZbRSq5sxhcLC3tDUFj5Ylyj9cgGHSFJZl6uFNRu7CHRKP0xvBacW7hD77+RRNg4SPWHJtV1Rmiqi7FQrNpSnOU3I9C3FgnMg43klQxWrYSEbts8mxD7xPwJFjIRz1S6F1IzEAxn/Ul5MHPNSogS2PIre7Psbn+n7tfZHPZv6ptef2FxhMqSE9pXP1oXkNrEngh6L1af1od88Twlsb4rhwp6LHhSMb87oc63AX1DBmkvlRFX4QbjfoJqT3AYZHWpoNboK0JefZoCrgUxt0aJ0vcBgC/xu+L+Tgp48ZXDjqESP4+UjdZO5BHwoSIP/cA1SUV0FBZF/eu9DuE4Y2BW+FKuE+pbwoF+Jpa3+iWhujZQYSF/FaET7u+cBxbSrIPJI353Pl40ntWx/Kd7If/c7zKEAA+lKzqHMfRh6PLXwhh7AQFa9EOWSXBBGSR2wsl+nZt9g9JCGdomBVrqWqthrY59NkkQUScwbmMEIUeR78okAktNjQA1/7o5T6cDQ+8A5ieb128s9Cn2HD0PFf5H9veuiMKhRGeK7kEvtihJksDFC2c3IT/SpIIjkMaClfQVsuwqGp+GI59oUaPDtOU/3xsnAkYqI+CfmsewFhaPvzd31hRXkayHabeOac2Yf8aF/RucbWlLqJ4OBO4O10UyBwO0nIxSDODt8/usFhvbjdg7oKMvmaOlSsluXMEMy
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f479a93e-8b40-4d9f-87a9-08db82ec8805
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 15:27:41.1233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QZED9dEY+xpEKeyTGqRYPnDMQtxSvx5XdIajdlJt6Ix591kYDNIOkGJjQr+/qqTvgJxcoSAuvtUEVB1KlN+EIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4772
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_11,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307120139
X-Proofpoint-GUID: 3i0JQyazf0gmxpl2pEaX0vQ7rmhUgzaW
X-Proofpoint-ORIG-GUID: 3i0JQyazf0gmxpl2pEaX0vQ7rmhUgzaW
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dropping Danilo from the Cc..

I was asked to add linux-mm to the list, so I did that as well.

If anyone else is interested in seeing the full list, it's on lkml [1] and
the maple-tree list [2].

Thank you Peng for looking at the list and taking time to think about
the items.

* Peng Zhang <zhangpeng.00@bytedance.com> [230712 07:49]:
>=20
>=20
> =E5=9C=A8 2023/7/8 00:38, Liam R. Howlett =E5=86=99=E9=81=93:
> >   - Fork & Dup tree + Delete DONT_COPY
> >   	This is to optimize dup_mmap() in kernel/fork.c, but other
> > 	users may want faster duplications of a tree.
> > 	This should be faster than building a tree in bulk mode.  The
> > 	idea is to just copy each node and replace the pointers in,
> > 	probably, a BFS order.  Once the leaves are reached, the VMAs
> > 	will be replaced by the copies made in fork, unless DONT_COPY is
> > 	set, in which case the VMA will be deleted from the copied tree.
> > 	DONT_COPY is not common and since the tree isn't visible, all
> > 	nodes should be available for reuse (no RCU worries).
> If DONT_COPY is set, this method will be complicated, because the gaps
> adjacent to it need to be merged, and the gaps of all ancestor nodes need=
 to
> be updated.

My understanding is that this is a rare event; there aren't many VMAs
marked this way.  The store operation already does all the necessary
work for deleting an entry. The gap tracking is also updated, and that
would only happen if the new gap is larger.  Are you concerned about the
performance/runtime of handling the DONT_COPY in this way?

>=20
> I have another idea to build a tree, if inserted in order, we only
> insert at the leaf node. All leaf nodes are connected using a linked
> list. In the end we get a linked list with only leaf nodes. Then we
> construct non-leaf nodes layer by layer from bottom to top. I think
> this is also faster than bulk mode. Another advantage of this method
> is that we are applicable to more scenarios, do not need the original
> tree, only need to know the ranges inserted in order. I don't know
> how fast this method is, so we can discuss it.

What is the advantage of a linked list over just building the tree as
you go?  Considering the non-leaf nodes are just a list of nodes
already, and you will have to do the same work of setting pivots,
allocating nodes, and filling them after you have the linked list.

What work do you avoid that would make a linked list faster than bulk
insert or a tree copy/replace VMAs?  I was thinking that we could avoid
a lot of the work involved with splitting/pushing and the parent
construction by using memcpy of each node, replace each slot (and
parent) with a new memcpy of the mirrored tree, then have a minimum
amount of modifications to delete the DONT_COPY during the VMA
replacement.  BFS copy would ensure we wouldn't modify the source tree
during VMA replacement and deletion (DONT_COPY).  So the rebalancing (in
bulk insert), pivot calculations, metadata, and gaps are (mostly) saved
by using memcpy.

From what I understand from your linked list idea, we would need to
construct the child node by examining each entry and know that a certain
entry is a DONT_COPY (ie: VMA logic would be needed in the maple tree
code or a callback?). We really can't have VMA logic in the maple tree
code, so we could do some sort of loop through the VMAs to add the entry
to the list if desired.

Once we have a linked list, we still need to figure out each pivot for
the parent (I guess we won't use the last slot so there is a pivot to
check?), and each max gap in each child to construct the upper layers
of the tree.  Is this correct?

I guess we would still need to adjust the last node to ensure sufficient
entries as well, so as we add items we may need to rebalance the last
leaf with the second-last leaf.

The bulk store currently adjusts the split to favour splitting
left, could you get the same result by strictly filling the nodes?  This
would have to have special handling to rebalance the last one - which we
have a pretty good idea of when it's going to happen as we have a count
(and the DONT_COPY is rare).

Are you thinking you could compact the tree at the same time to gain
efficiency?

What would you consider a sufficient packed tree?  It's best to keep
some space around for expansion/contraction.  This works out since, I
think, we would need to keep that last slot free so we have a pivot to
check in your linked list plan. Initial development with strict
split/join rules resulted in a 'jittering' of nodes as the number of
entries in a node shifted just above/below the threshold so we relaxed
the merging of nodes to avoid such a scenario.

Let me know if you would like me to put your name beside the Fork & Dup
Tree item in the list of work.

[1] https://lore.kernel.org/lkml/20230707163815.ns4kdz7iut5octjv@revolver/
[2] https://lists.infradead.org/mailman/listinfo/maple-tree

Thanks,
Liam

