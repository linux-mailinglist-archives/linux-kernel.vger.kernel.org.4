Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79455662EE6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 19:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237297AbjAISZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 13:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237355AbjAISXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 13:23:55 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76471167D4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 10:22:48 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309IGRK0007420;
        Mon, 9 Jan 2023 18:22:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=+R+umG/rlwbZVcbVVfP1wAWLh9deKUDDDPt/KleT/3I=;
 b=oe2eaTgsGx9EIe7bmUFITG2WXmCDsz6eP7hxwYZT5dldYFC9U/3bchTvgQ6/wxerHpxN
 +ddLB9o8KG3aqAjgiRrViAjgifhxSbtiieHuF/TW5wxpxpmhidrYzoSdcXhntTirG6P9
 tTSsmrja0MV/WBW51zTy99sey4WsCThC2ePxrLn/FwK+8SaVp103pkcLXnbhHf4Qvx8w
 CSqLhyjd4lCbnOTrG5/W6iB4AQTLe7OM4BvZCAlwiAd4b3lGCkNBnSNuOdeDVHpE2uLK
 Z2T5xab3mfzsW37FPnuQmOkEceZBTJ0khtr+hmrfThhpWTbMbSbQfRvHheLCvyiqbkFc pA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mxyh3kchv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 18:22:02 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 309HoaKN004568;
        Mon, 9 Jan 2023 18:22:02 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2046.outbound.protection.outlook.com [104.47.56.46])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mxy6acg5y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 18:22:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9MGupkK1LRmwvY4vcfCoUnzPAFKvd9MIw132MWanTdUPqZArlOrMia2inOXZbrsgK3RW9NDbSAqeIg4qy8mSpJkdFOF8D3i6vM9Bag4xAfAirnNAYrsL8Z+7FrPcc6uzmOgUTm/H4l+p4a5KCARmo6DiVzvRKUjw9NMQgZsQNUxCIm7rC4OtgHDF9J+VhsZn8S8i7fgey4hZ62STEReVzF12GRAwbDYgOuXuU7BUWj4edTMH3ZdLi1vW/z+IiP57HdfH90WlwxjnDera4KO1z9WNHzCm0w+k+UczX0RSxb10n4830nK2T+4AZ/qtMWJ42gASx5qrgJR0vf+m1n6Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+R+umG/rlwbZVcbVVfP1wAWLh9deKUDDDPt/KleT/3I=;
 b=BFtM6LHoNAfQMjB2ihsDRrI/lbiwZvOkh/IIEm3NJ2On0nKsZmgiGLzNDbvrOEEJXZTDRhTHJ+4q2EAuBAAgrRipYPIGqd4YCw1MT4chs/Mc421lbQEilfqeLbRb4kMCpnA+J8+NcXRfoBd9mDRkLNgZN4dm1P8/3qSyZhPENRVIRstBgGqrSzzj8AOFFWLmpf5xTQqQ/XmGpu713uhDWtFDywc2xOoEEc+LRiUpTKnbM5SbIvKuRnE2Q4RYpeXUe24RNVxVXGQxQSXyl02U6HWAG94cLEKZ6tGQr9praF0GevklZqNrOLBdQ1McFVERc7bMRGFH7O4IiPaOp8m1EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+R+umG/rlwbZVcbVVfP1wAWLh9deKUDDDPt/KleT/3I=;
 b=NxdyNdcCrGO8Uaz3VBlYP64aDxRgf41Hf1/w0+nCBLJxpJDsU6BQ0JWI0JAGuQ9Bl6y5EqOpTyA9PvmFRKWXV6prTReMB5OU9E7OYY07uTHD+2L2b+c56yclpUzgIrGkkxADtOnja8/hj+bafPNnATQERl6Qc4pezhSC1bEXtbo=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by MW5PR10MB5739.namprd10.prod.outlook.com (2603:10b6:303:19c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.8; Mon, 9 Jan
 2023 18:21:59 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14%8]) with mapi id 15.20.6002.011; Mon, 9 Jan 2023
 18:21:59 +0000
Date:   Mon, 9 Jan 2023 10:21:56 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, tsahu@linux.ibm.com, jhubbard@nvidia.com
Subject: Re: [PATCH mm-unstable 6/8] mm/hugetlb: convert
 alloc_migrate_huge_page to folios
Message-ID: <Y7xbRE8xOsRU3DKN@monkey>
References: <20230103191340.116536-1-sidhartha.kumar@oracle.com>
 <20230103191340.116536-7-sidhartha.kumar@oracle.com>
 <Y7jCzW6oqlHpxusA@monkey>
 <4a0bb956-c878-4516-11a0-b233cbc2b3de@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a0bb956-c878-4516-11a0-b233cbc2b3de@oracle.com>
X-ClientProxiedBy: MW4PR04CA0108.namprd04.prod.outlook.com
 (2603:10b6:303:83::23) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|MW5PR10MB5739:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f5509a2-83aa-412b-93b8-08daf26e65bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oVWrhOKqGYqJf33UWmO5hfGyE5LXYJs6iArc0OddKNG6ulQku4iZ0U0T1KVFVAxX2dmRGmTYA9dMs4gaAie9Hp6opcsBunj5AIHJTZQFGuj2sYxtibxCN/XZ5/jhckVidlQy0IOZaT1x1mCLHxN2oCJEx/GKR95DV06zH4Kgpg1awZDUUkd1pUvdNVUzAWxzAlDx5JX8QdNv4AkPGGq+jxNkXYzLK7bs2+6j7G5bEozZWacEtPAqdcCVme91DaxbzaBrgqBnU1cENuh7qTRfrr/ilLwBMzrH3+YHqMIwmv+8PD26O81Fcg4Iq/sXEckIB4f8aGwTcg/L5/GI3k06PgHIwVwRK99c/U8VwD/gHWlBOyDNr1rJX2BdYsWFDUHT4VXhE1vgXCqT7OP7bx4C0dEIhfbqz0kOjhXQyyLyniaxAHGbF88I49ahF0109WTRzUMOz/l6BJXdnUm8nJGD3K0vOja8We/WeeGFMWUZ1vzNPA8dHwBV5PK3XBFpV4jfdpMbo91O7m+U8eR/RJLd6TvhHRi3BRjzesB5D/l7toj6OLevaRv3fjbA4+BAKzvqEXGNzcMsS8R0zznd3SbWvZz57IdKKcx6XXBF5bwM5KAa+/QooqwQ82QvqWLkpw0S0TC8vm0wKbFMYL3C+EPYBAr3BwN6Ob/m/D0075WNWWndyblH2+OgR13Ko9mMpuoRDbJin07aob32JmpVHVdc0Aje8X7QJxVi7Bxv1aiAL1o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(39860400002)(376002)(366004)(136003)(396003)(451199015)(38100700002)(44832011)(6486002)(966005)(53546011)(6506007)(478600001)(316002)(6666004)(33716001)(4326008)(66556008)(66946007)(86362001)(8676002)(41300700001)(5660300002)(66476007)(8936002)(6862004)(6636002)(83380400001)(9686003)(2906002)(26005)(186003)(6512007)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4CCc4xGUKpSBNIuxd8En+lqIzTTYj/AqCK4A49A+Sr2gwGFL9Q7fA7v/CDEk?=
 =?us-ascii?Q?KXW7OIcGy4H77w1gxvRLWKyUqOokPoe+WR4KKs5ngd3q6sw3Ah/p6fKTkzyL?=
 =?us-ascii?Q?zOyw6cdRGr9eEpqlZSYCH594XJZ0SrDMdmm9RZy9hjz0QnvtEpCuES9NV+wC?=
 =?us-ascii?Q?kd1vHLS9SVdii1v0+o9ZA0yhKK0QKG9vjCf3TNGP+5sOmxezUtCAauP1BVXq?=
 =?us-ascii?Q?rebhMBYSJFbCHiCxLzVOlqdmRckiRZntLH7uLl+IxVm/Fq6nINJFCdBSsnpo?=
 =?us-ascii?Q?BlLd50JBT4Hfv9wmQAxmcXieVeNi78L6P9lYQY8UNI1iN5k/vBbmwW09Xn5O?=
 =?us-ascii?Q?2SxYqRECPXKSDsVAp4HIGNCdSQuF2qiQ7ox0oHhHA5cmycfTVmxPqjb+jAgR?=
 =?us-ascii?Q?/v4IYy2+cALZgjMV34CX9d1TmDBph/h3Lv8O9U2lryytjyR34Lws/oXu9vsc?=
 =?us-ascii?Q?6KKkXIwBBKw/5oIWXMNlcTwGkizeZgYP0LUMezJeS/AcR/ZwBx9JJL6VTTds?=
 =?us-ascii?Q?MYMQLSZJ+TxzUnq0Y6dgbacQ0R0MMVUh5GdIg6qswr9vrIh29PguXKmHI3e5?=
 =?us-ascii?Q?IcHEejxv4ROFrFG9QAl3CAVmGPdhYhaPOkgUuADlHdhmD373M4daUTWRdmuH?=
 =?us-ascii?Q?KYBOzbaJ9TFInNL1KWugESMeBmTzyrxr5orWEdKbOPEoXF35OFGG4lbsXvQU?=
 =?us-ascii?Q?N8iVof0JlqahVqEyfylXPM8Y9C8OznFIWfv1ontJVx0nl25wLahaFKMz3lsh?=
 =?us-ascii?Q?dLVDe3p4vfGjq8d7J3N/bpdKmX1TqC5GqtYOnW3bHjKoVaVPYqYg+SAoYHOB?=
 =?us-ascii?Q?4icmp1CktitaM21/t5G6UwhAjaIfbf+rmTVBVs/6M3F+ZeMX5s98qy6Z3N+G?=
 =?us-ascii?Q?NifxTOKMOpGvWKxc0Mnsf7s2DGzouwSdRydjZAdTqop67Vje2nnQ6GT2SYZS?=
 =?us-ascii?Q?HClkMDNlaKM9wq+rczZgc6vIBFwSHTQU6WPm41edpRNeb9kNjDl+tOfOcdM/?=
 =?us-ascii?Q?XbyJGvRq2jEBIUpwBTLbd+qFtJH445rm8/uGfYwxWwFcPRkdxtnY2bzwCV+1?=
 =?us-ascii?Q?gq/2LswBjO8PIZBItcmizIpE2qOPIXaxBo3gLQvXEWaBp5WVmNzVTbmHZgbD?=
 =?us-ascii?Q?nLM/qmMwQ/TkdmfOu+97my33Ki1jDYwWZgx7EC1cBJGzONPKp20gd+X1d65a?=
 =?us-ascii?Q?vnT3mUyk28UsLcIZSdplPnPyEGzz0+cdZaE16qaUa9tPmbDD4MtqKmrMfX+0?=
 =?us-ascii?Q?Xj5xKbZCc6Z/vhikTudCy/36qBFZm81tdsiP48jRcfHkzUyAEo5BpvC64GmT?=
 =?us-ascii?Q?XfVKwu2iA+karI4AAORn5KjyjnsN5iz60mDy4Z6th7uh+rmZCZ5MAwZ+ROOF?=
 =?us-ascii?Q?LuyHE4xzDePYPIq/Q6/6hXVEaWygZ8nDmKwwjBwDDefHJ6uE9ygHcY+uY+vC?=
 =?us-ascii?Q?I0sgzsB8U/CNHK0bwHLPjqBg6H/Sq3w3GKhLDWY1gAR+GP6aEiaawiTB/6on?=
 =?us-ascii?Q?kej9lgmt+uKyzywyLWU7bFBLBfYCA+fnnBNtlwD4vOhScbypg2iHa2dNKPN4?=
 =?us-ascii?Q?sdw5ku6wluGIGVh+BqnpwLmzrbk1MKgCdHa8qpMK1JG0BZ978lxtHBUMBWbI?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?iJEIanKNPqrpJuPFc5Z/es0UchwLzGC6O6YigMB6pS4R8qij5DaAc0Mzghv+?=
 =?us-ascii?Q?ICyn8xmZHwtaHb3fOkxgweKEJ/Zi8eKopfPy4aO0uKULkvpmt2G9VHZ2uBC2?=
 =?us-ascii?Q?zXrgpcwHxyBy6z75ZiOaOxMfPHV+oDhQSgzdGs4lWa4jScWlZCMQR/IF0Jeh?=
 =?us-ascii?Q?qO6HURiuNlnvjqLpOkNCSkWjgKO+X2AssY6sFku9+CJHaW3aKtfo4HnCNFlk?=
 =?us-ascii?Q?mvRmTAWMhB6JLbn9Yq6+n8J3LZ1ioyfzZdQo+1ptxzWwyTy8Q9tcigLQrhQc?=
 =?us-ascii?Q?lQbqnMbscBGC+VpFuxtAXm1WpV1xX5OQBOn9sfoP0+qMZM6UHn0Ll7KbDOCZ?=
 =?us-ascii?Q?OuRpMQovkR1BXzmSYCUsqqQcVw82Wr+yLY7WS4zT//rIuL+WyJDyTmYCstuW?=
 =?us-ascii?Q?52Vk4u5joobPQYOwhylfrCGOmYeDO9wR64udAoRikmtFyWcynfIFb75Fva3T?=
 =?us-ascii?Q?KlYKZJYwiBmTv9xY1YDBTaMCBGBB8wYPmWCU3Ow66+QnRZM79D6/grKsIll2?=
 =?us-ascii?Q?0CbUZfmLfUrKTFtedhVEuyVb4cALbIbFrJTRNe1b+q+Yt9SrBKOwv/4eh+zB?=
 =?us-ascii?Q?MCspBR1CqykIrhWLnSSvljpJxaEAVQD9dMrxII5hKrTGLn2nvGh1ghrxQFKy?=
 =?us-ascii?Q?e8jTvUIOYtRXa8dAnRdIoFgbaTLyPCiNEAtvM7+RMjeBaJlpVv0A9/b8JMpk?=
 =?us-ascii?Q?CpL7wPoBIdEyai11c+Ha06nMbNLpVO6nD8mI4bXlJkkq0qdvghfvzOUoM8eE?=
 =?us-ascii?Q?rVg8/Welc8+lcQ2N2dVIiV+ArTTh+Jy5h7oI2xQQFL4z7HnjihD6qD+ESus/?=
 =?us-ascii?Q?If1aTgY3eDcs88xClbNvu7Xa0O2XyXN+7F4eEsMQhveNKl8kM99IWh6aAPNV?=
 =?us-ascii?Q?22uHwsYUlnc5y+O11DNdYYR7Bw0iAOra5nr34K27NbXQ3KOnIMcxoqcinoam?=
 =?us-ascii?Q?c8289K6jim1yAE7URjxTYPyygfKO8IMSDQIGS8LLwiI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f5509a2-83aa-412b-93b8-08daf26e65bf
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 18:21:59.5443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wEeOybrpHwA3gQfeAdPmkMkYwqMDDwiy2PQBBf6YyU/Tz/c7yzmi8kTjRiMXmzy5vaKJLSFzW/Awu6Whgrjp+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5739
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_12,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090131
X-Proofpoint-GUID: KcmTfwlCwssdFO3Rp-ezMen8nqmCmSmJ
X-Proofpoint-ORIG-GUID: KcmTfwlCwssdFO3Rp-ezMen8nqmCmSmJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/23 10:26, Sidhartha Kumar wrote:
> On 1/6/23 6:54 PM, Mike Kravetz wrote:
> > On 01/03/23 13:13, Sidhartha Kumar wrote:
> > > Change alloc_huge_page_nodemask() to alloc_hugetlb_folio_nodemask() and
> > > alloc_migrate_huge_page() to alloc_migrate_hugetlb_folio(). Both functions
> > > now return a folio rather than a page.
> > 
> > >   /* mempolicy aware migration callback */
> > > @@ -2357,16 +2357,16 @@ struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
> > >   {
> > >   	struct mempolicy *mpol;
> > >   	nodemask_t *nodemask;
> > > -	struct page *page;
> > > +	struct folio *folio;
> > >   	gfp_t gfp_mask;
> > >   	int node;
> > >   	gfp_mask = htlb_alloc_mask(h);
> > >   	node = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
> > > -	page = alloc_huge_page_nodemask(h, node, nodemask, gfp_mask);
> > > +	folio = alloc_hugetlb_folio_nodemask(h, node, nodemask, gfp_mask);
> > >   	mpol_cond_put(mpol);
> > > -	return page;
> > > +	return &folio->page;
> > 
> > Is it possible that folio could be NULL here and cause addressing exception?
> > 
> > > diff --git a/mm/migrate.c b/mm/migrate.c
> > > index 6932b3d5a9dd..fab706b78be1 100644
> > > --- a/mm/migrate.c
> > > +++ b/mm/migrate.c
> > > @@ -1622,6 +1622,7 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
> > >   	struct migration_target_control *mtc;
> > >   	gfp_t gfp_mask;
> > >   	unsigned int order = 0;
> > > +	struct folio *hugetlb_folio = NULL;
> > >   	struct folio *new_folio = NULL;
> > >   	int nid;
> > >   	int zidx;
> > > @@ -1636,7 +1637,9 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
> > >   		struct hstate *h = folio_hstate(folio);
> > >   		gfp_mask = htlb_modify_alloc_mask(h, gfp_mask);
> > > -		return alloc_huge_page_nodemask(h, nid, mtc->nmask, gfp_mask);
> > > +		hugetlb_folio = alloc_hugetlb_folio_nodemask(h, nid,
> > > +						mtc->nmask, gfp_mask);
> > > +		return &hugetlb_folio->page;
> > 
> > and, here as well?
> 
> Hi Mike,
> 
> It is possible that the folio could be null but I believe these instances
> would not cause an addressing exception because as described in [1],
> &folio->page is safe even if the folio is NULL as the page offset is at 0.
> 
> 
> [1] https://lore.kernel.org/lkml/Y7h4jsv6jl0XSIsk@casper.infradead.org/T/

Thanks!
I did not follow that thread and did not look closely as to whether
&folio->page was safe with folio == NULL.

I must say that it is going to take me some time to not pause and think
when coming upon &folio->page.  Perhaps that is good.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
