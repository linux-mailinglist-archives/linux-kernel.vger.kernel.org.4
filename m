Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0604968A783
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 02:18:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbjBDBSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 20:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjBDBR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 20:17:56 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456B474C19;
        Fri,  3 Feb 2023 17:17:55 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 313NOQvM014820;
        Sat, 4 Feb 2023 01:17:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=hMBBNmdtVWkLfOABVVNIhFBNDXzhy6kAxK5dLFS6wKo=;
 b=TcnTSWY6FkT1YHB+BvIyuircMjRserdH4w+S1I5zIlsKFDZbmSW6/U6pbCDJ2vcZVL6d
 ULFDq9UmqFnYz0DreYgfPZjvqcEQsjaqvLXJxN3bw8D6r4DpMm4VOjhBpr4OuJVe/mC4
 K3Btz3zEdK31RSs9QqR5vW3+kms4DpKts8Qgg/X2rjPwRjJ5kEyZmpP17PSuHML0FQNo
 Q0mT5bQKfdpdjm+luf+dmLOw+bVnr6oktX/xWGVTWI8OO8ZumlZJiz9mPVPq5SE+lD6F
 oBxUBirb0Br5TEJZewFiA1MXr7jn5NMAFxAIwu8R+U+4ylOG56r8wmrPrAmm3aNEgMHd ww== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfpywpwdj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 04 Feb 2023 01:17:32 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3140kHKD027904;
        Sat, 4 Feb 2023 01:17:31 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nct5bav97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 04 Feb 2023 01:17:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+0eHTzeuPsuH9yW2sN0dpo4JEYsSbfqRV8rXTylvqJ0yf4Gn81YEcOY0eq7i1tBa8eWbgGqR9N+A3YMw7rOPQM5Xu8fSPXnrJRrb4F5VL9gveVRyLXeeXKDXUMUN7DYFT857eLg/nPssH7T0+uN3ZvRXZnRuGgVsLGuZfxYRPpIpLW3PZNOrd3aCE/M7WOJBWXVEEixM5dhY96ewlDtZcfWUsuffoe7UB9+t7QspidaQVnlNhNC8J8q6xSlzCuCQ+W03KrduWlY2Kdn+VtNcAGSXJXlXifkePRZesmdRUj7SPvkpiyN/i1gyLZUtp8ZBvucpQ0/7sboq10mKIvZBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMBBNmdtVWkLfOABVVNIhFBNDXzhy6kAxK5dLFS6wKo=;
 b=G71ngPpVC1NbD32tgcw9sCA+rojBbs/MPSxvf8eLzWC4Qzn5KPpU+3drfDwRy2Kj17tk0zznwcVuHm5ProjSLq3H3EBiOgAn8Thrm5RBKUDEZ7Wk7kxcjBZQRUgP5xQDmnv8qh4Ys010Hk3+WmVK7FJQQB0NTjq83V3LO74m80pRRB3/6xSzLpHbz9jP0A/4beI9MFDxi6B8VwlNPMcdsLH5vIrk+aiR8/XC9auN5X8Dov+S7DCe1cxcQLgHX46+cYizaGjfJYMphcZuMJZbwLKM1e8Nq3ZEziJeQpEp78viBMJjse2frfVYYNW3aUWvXytQs144ZqeLnkI3BE1J+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMBBNmdtVWkLfOABVVNIhFBNDXzhy6kAxK5dLFS6wKo=;
 b=dsNdGas3sxkLFaO1Rb7HfMLGiOy9QrcCw5HybOYUp9DB4dma46ym4gMQGfSeKGZqMgk8yQvNXQ2ECWfR5PrX5rXUPgldWgkEugmtNSZ9e38a8XJ7nByYu0LnQuHnuN17DBU8CQmbEmVHa/ggP2qrqjOiIGmY5i8IQ/a1LeszZTs=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ0PR10MB5860.namprd10.prod.outlook.com (2603:10b6:a03:3ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.7; Sat, 4 Feb
 2023 01:17:29 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6%4]) with mapi id 15.20.6086.007; Sat, 4 Feb 2023
 01:17:29 +0000
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Can Guo <quic_cang@quicinc.com>, Arnd Bergmann <arnd@arndb.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] scsi: ufs: qcom: fix platform_msi_domain_free_irqs()
 reference
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1357m5iw9.fsf@ca-mkp.ca.oracle.com>
References: <20230126211831.2274211-1-arnd@kernel.org>
Date:   Fri, 03 Feb 2023 20:17:26 -0500
In-Reply-To: <20230126211831.2274211-1-arnd@kernel.org> (Arnd Bergmann's
        message of "Thu, 26 Jan 2023 22:17:31 +0100")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR07CA0121.namprd07.prod.outlook.com
 (2603:10b6:5:330::33) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SJ0PR10MB5860:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b45886b-aa31-4b61-c1f4-08db064d9533
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CeStnbKsKDukw/uZKCTFlwumtI5qhQntSI47OtN7yKSEtsPpiZvt23E4R3voihk3Kty3AohUIFmeU6V0YZ4llbqOYsbmLkS5gi/mwh1ZqNETjbXDYWq32rLtBYWinawdmaPkW3vgPWCLmqEM9aC9KuUdPyqjHm8QFw7st+1EV2xE/rz1yOKcBmhdJXDXErPibvglyDW7RAAieHOrpu4wQVhJtRdVTISJZZJpqXmNzdSsYDVULAAGHqEe/bwV5wYZarfrYRaimgXi2e0fjlf0vO8tbDFhmFYnvXmlrQ/e61jjTNnzv11PBNEHk1G3D1600NfmOVGXQ2M8mTGXdddu9xc71kPjdm2644NZslsvW6TRl+bXo85fPowVKTVghGJrPsQJfNPcqVjA+YOGXmDTn+QgZhdgmb0u318BEd2mIPjmZKDURk4QEm/VSXEr3eNpMwNcSHOehrj4NqdJZd2QD40kFZxL9os+vQa07FieZVAm+LXT7ON4b9oUo/Fuvi1Rwcrr1+nIzCQGKOdV/Ov5sP5LZcmy7WpUd4WCIl34F/kZCkED0Rzlf1RpmxaQuLQ9YAJeNtquUveHwmBzeFJ/G/5/Mz4frGanIJKjr51Hx6Wjzsa1DjJ+/Ki+/gnfEpHTsG5LkIGJH6ohh3avwLIQDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199018)(83380400001)(36916002)(558084003)(86362001)(38100700002)(26005)(41300700001)(186003)(6512007)(478600001)(6506007)(6486002)(316002)(6666004)(54906003)(66946007)(4326008)(66476007)(66556008)(6916009)(5660300002)(8676002)(7416002)(2906002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XtzXxBMPjRLBoRaLFnHEv142UgFlQDxZ72WUk9PwqJmCCafnATV/WXsVZ+WQ?=
 =?us-ascii?Q?Z35jEzgd+QfcKcvJ637CcEOxoP8EzALNnm063t5I83s0+HtW/Yy9SSGWu+zs?=
 =?us-ascii?Q?JYc0EKcWL7a+r4HF4YHdEznLbEyWpySUPUIuTbEWNWZcuKTHIpeNlrEiYtJ1?=
 =?us-ascii?Q?cSf5FSA+vk79AlfFxAiUKAtMA/A+fa3OW3SjhWZs7Zy2VsAzEA/D8mg43YYX?=
 =?us-ascii?Q?BJ/iCeAqo7gKWJYFnl3OHmRzPIqT6uleqrDeiO/iTmSx+OiBbF8KSjzKxZO1?=
 =?us-ascii?Q?n/mw8VdbesK9qfNWHqLdAvWUaERJfcuLydDgoVp1yHQB9aQlW0qdU3lc/XME?=
 =?us-ascii?Q?fDkT5K1UHCAXefET5OtmdvEPjR8oh/uxNYg/V1hdDm0fHRdpfbCQmwrDukU8?=
 =?us-ascii?Q?UsL/VZ58nKrYoX7Gv7r87aldp9jsmD4Yl2GYdKtgp1QuPDY8gvsMPVtnmuI3?=
 =?us-ascii?Q?Gt4anDFUSPpWsb1/RBN50tpqZG8oH6j5tQO0/zAvdRREAZH174KEE5znsNHh?=
 =?us-ascii?Q?ocvIw67Htvk0pqcpYY2M6McPqRV1B2L7KeXk5N3aFlmDICrl/IqAdvRwRFCn?=
 =?us-ascii?Q?OdHP77M2XUYEk6i1dZbloCeBQbqAue2eWOtCXAq2ACwnfzHhUcBjHmpdBCmE?=
 =?us-ascii?Q?GfMmeYDgpZDSjgkyp+0kb4xCw6zpVQ1Tzk14+7znHoFM63GDL9Zg8+mRwgQM?=
 =?us-ascii?Q?44Z75pbDKuaX4BTaLyv2XsQBAge3OASfw9C7IcxWgioPMlTbt1lkuWRfRAkx?=
 =?us-ascii?Q?16ZRt3ZGsvCsBzGRDdRG7QM1/QOPFutpLEQIjiyAjuL/YuaJnbvfnBOddfN0?=
 =?us-ascii?Q?8t6YOeRnQHLmLlCy9U/b2zPn86fB35UJJ0vsTQDGLTPeIAQjHa3Lisn5X3Kp?=
 =?us-ascii?Q?tTTSHe2KokmsCA/sj97WWl+5uDAXVObd3IaFKIhG/CWYUiBBbvU7mkWBel9k?=
 =?us-ascii?Q?a00nRaR0cJOq+JohVkVU/tnBF6JH5ugmP2B2IGFuQp91QMmLArxVhSrBtZ7b?=
 =?us-ascii?Q?Fnymj7O9QUpzgmZ2qJe0iwLAFHEFgYS1oQzjMNOtxmSux+rjMQvUjURIv2E6?=
 =?us-ascii?Q?M6lB9rmHCNnOXlfuC4nOetimAHDv7f/jWhR0iE8pOqdhdv3fxX0R9hr89t2Z?=
 =?us-ascii?Q?sMPV02e+KO71ot5WaGMFaYg9/tVOcpXSNjjj3UpFNOUcLMcnqJjf8vMGnxDB?=
 =?us-ascii?Q?yjwXBVZq5lQk6/u16UAgplGZ4hlJw4bvQLcnOkQ8PcuUrMKE+Zbln6LN8Rzx?=
 =?us-ascii?Q?OJA0V+Foeuzo7/N3dG7msN7SQh2u+W3fmJnEvorHsUQW04KLPUHijXNJG7E+?=
 =?us-ascii?Q?VREpGm1alpQ6mDRwigj4oDDOc8qsyZgr1KTQRIfCwRjOyqtMjUIrSeySenG7?=
 =?us-ascii?Q?Ks7DclxZcv07uvLk1Y9fT83qLDFwhxf5X/a0xIGrEQZVCLFKpiu33CPVkDDn?=
 =?us-ascii?Q?E/39bAsTF9xBunItwlRANAi/UrKsu/E9wKuOCg4dnKuG1xLZfHnGXx3uof1U?=
 =?us-ascii?Q?yHimToaCxFtl6jSN4wNV1ThVyUkFCcH4W5EM3ofW6ORt+H4fikb1rF+oJPFr?=
 =?us-ascii?Q?jmhkog1rtNY2X7qIbLzCGAp3jab9a0zy5AudCqfjXUrrcCx61srm7omia1Ue?=
 =?us-ascii?Q?Dg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?+KHyBERx/tmSSi6i+gTz/8vosfWfZyO/+/T/X+bf8BOIEW/0WhPBzzRwcO7N?=
 =?us-ascii?Q?WwQIcDntdn+9ERGpmt6NK4obfPg3HcyYrd4luzpkvAgMFPuGaygqc8xr4xSU?=
 =?us-ascii?Q?vkkfi7kAybu/zapr/aWe1BfZTqZs3WNGRZntadNmFRJy4ZQ0MBUXBqwEm4ow?=
 =?us-ascii?Q?aYHsMixB8C/C1IZRYp9MhIRykGygSTnTewQt4zz3VxhTTEQMcg1WYhRTHLOb?=
 =?us-ascii?Q?X+QEGHAKZxHZAoZrN0VxliG+rwU2Ry0WSsPr+QM3PMYxNBOsFCDK2Iu9VKJr?=
 =?us-ascii?Q?RgIM6sRqkwkqaco9mr8wJY9B1qT1yZI1fiSxRXCkmUJcpoOUVxuSB+tqXAEv?=
 =?us-ascii?Q?e/nGKf9I+dm5IbnFsMmTHHr2C+qEcbk92AjVL7JkQ09nCiqa8QzzSB+mLMyh?=
 =?us-ascii?Q?mUNxVq37SVDxJtSG6OrD0YikWEEh7waY7lXlwu1IbdcrVy7tYCXUORqeeNqS?=
 =?us-ascii?Q?trcSjc3ix5HzA+dwHEMTCC98wdxFAB5PSpmlRExjcBiV5QnFTQbWIYj2n8yJ?=
 =?us-ascii?Q?uR6shfQpANCLMc3w7mRM5Z6z0SrT4uj+++d7gRO2C91ayWlfGaA3cFmQYzBp?=
 =?us-ascii?Q?dHmPKivsUK9K6PZW0Gm6UBTyVQoHPSqu4Wl19kmwTmtzsV/HIUAcKrUeLA3Y?=
 =?us-ascii?Q?1QEZaQC/8AkJup5LBkV+6tyXkVNQHKNjRINQeAo4Za5O7Gq7jMQloBxAdJS5?=
 =?us-ascii?Q?E8dEfrx1mrtEw27tTmogxTv+CeK2ULvalGar5SOL/C1PgEILSi6jbcrFD/oV?=
 =?us-ascii?Q?wUg2N+yvZ7MFbpMqagdqD5KB9ptoC/X+OpcEJ4jkHykQMcN8guCzDhJPtQBw?=
 =?us-ascii?Q?t2IYndFogga52Xo+ZnzOt/ym2LEr8h1/aDDEXY0BgiKKp/BE3cIjE6GMBIdU?=
 =?us-ascii?Q?OUmMWSH+tn/nqjQvT10Y+g1CKtvk/rDH/7Vav78HM2yU/JivdL/yOdLAMEUR?=
 =?us-ascii?Q?djb9zvkPLKjmewvIsNGtlftuuWH3NLT39R9KgnaRIpA0PJL6EmHap1aBVEEK?=
 =?us-ascii?Q?pQGqZoCBI2SB/ZEa/P+sqEZrMux+U8m/xrf01ege7xfAXPQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b45886b-aa31-4b61-c1f4-08db064d9533
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2023 01:17:29.0221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UT1cu1A8aaux2GovWfzEeYyPbn348QzCP/1UP0UiXtTS6wlCIUkals37oRmKyVTLGQys8DKqtyyKoZVrMCyy1m1y0UpbUIs4FFCPgl7zkqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5860
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_21,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=786 adultscore=0
 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302040010
X-Proofpoint-GUID: 77wmgQiz_6vbuIgLJm8629oYr457h4AX
X-Proofpoint-ORIG-GUID: 77wmgQiz_6vbuIgLJm8629oYr457h4AX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd,

> The newly added MSI support is mostly hidden inside of an #ifdef,
> except for one line that now causes a build failure when MSI is
> disabled:

Applied to 6.3/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
