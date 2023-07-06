Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0E674935F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 03:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbjGFB6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 21:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbjGFB6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 21:58:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BD71BE1;
        Wed,  5 Jul 2023 18:57:56 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3661esuJ022055;
        Thu, 6 Jul 2023 01:57:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=i2GBJW7YnhJAfSq5S1FEiS/hHRHybZekvWvojK27UAs=;
 b=SIbQDmPaTPzi+A13j6eC1coaO+AITRd+uJn1/k+ZJLbtyRAWbYbxfvPkvfO7SD/R2uTY
 /9zGxsYdTjtoPtVn8khyjog+aS942bKHbuePZnggTWFtnw3lZfcWtR3/j1qXvH5P8vgr
 0Txr0b5TAaah1O3SY0ThehUh5ddk43hTHg5/zFM2pOk85HFR0M4iKhc0gvKVcFE+/YVo
 nhPP9i00BeeMAffgZPiNPF+h94rumAoHQ3XFN8+cTbSQWXUr7MlIIK4Tt2h+7cUdBiVo
 XQVMeuj3lxomSoKiQBvcKnC6m+2kUxpn8s91TXiRuk3g83CkE3u+UVAM9lnkiyGlmm7Z 9A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rnm5980ga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jul 2023 01:57:51 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 365NRCn4001782;
        Thu, 6 Jul 2023 01:44:32 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjakcbrrk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jul 2023 01:44:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0lsCN4Dtxb8x1Q0TnSBofIXp3FZsDxNcmRz8rmhBTaVFgoSncy9G3HjkgWDmcWMoWuoEG4v/ODNXNBQZ1UBPP5q3TxIf1uAxozIjAzsfcWH7/+SLdHUhga2zYP4M61Cj1MQkuzdl7wr0c+R4dgu68Fs/+MNYZ6zazLZh8tHmplU46/OHyJ7FnslinvS1aAMt/ErtWDHZpPn2zxJAJb3BX3mna/JuizW9oy/LXxa5Yt17ejv3lMmQ+hSyNLp15f5c9qWpgBBmp5H2iOBQDBsqC42sU834O/Lkf2A0oxcdSkg5XGumprnI55q4ESjZft8FXV8y3lmcYphOoMUFTS86g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2GBJW7YnhJAfSq5S1FEiS/hHRHybZekvWvojK27UAs=;
 b=GtN2s5PeLkiIDy4D8ZtSPYDtJbam3bY/pCGLmcWG75pX+0q6s3mRkMa3gBJK8d2MVna5vWiXjWljmPLP/iTWUwSOSQ8sVkJhZnL5+zm2ivAlcW7JLWtGYhl64W5EjB9UwisyarjllYnOZbEj8kGAGcNmkZr1jv5GdLH45qor6OzfkLxqWdsNB3CodAQvpT84dbf0PMjMJV/pVPdjLiRJzi+fE0ZThcRe9zXPrBcq/xLY7JBscTP3HV4m5b6R9G6hEw6uAVIhbu53d4daTuWebS706CxQgA4j5Dy3etxdztGrSlypk1LdtuYdh5uD8C0zqvKr9HorxomnDJgOa7lOMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2GBJW7YnhJAfSq5S1FEiS/hHRHybZekvWvojK27UAs=;
 b=t8+HfMmmbzAoOQYKa+EQYKJ+VzbqwwJJ2/QTMdAQd86XD/wi40sHER6rojawNUyNtBixHdKXRUSIG1aqte5F1IXNw1keGPgb4XTyPQh9ceVyfoIyvVXDymZbcRD6adPcvxLBc66lmIfNwiFxZWYjOLm9rgZcJEZAKjOnsKo9uTA=
Received: from CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24)
 by IA1PR10MB7143.namprd10.prod.outlook.com (2603:10b6:208:3f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Thu, 6 Jul
 2023 01:44:29 +0000
Received: from CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::9f29:328c:1592:d5bb]) by CO1PR10MB4754.namprd10.prod.outlook.com
 ([fe80::9f29:328c:1592:d5bb%7]) with mapi id 15.20.6544.024; Thu, 6 Jul 2023
 01:44:28 +0000
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Arthur Simchaev <arthur.simchaev@wdc.com>,
        martin.petersen@oracle.com, avri.altman@wdc.com,
        Avi.Shchislowski@wdc.com, beanhuo@micron.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND v2] ufs: core: Add support for qTimestamp attribute
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq13521lspb.fsf@ca-mkp.ca.oracle.com>
References: <20230626103320.8737-1-arthur.simchaev@wdc.com>
        <5f172788-f16b-7bb1-6338-24453995f221@acm.org>
Date:   Wed, 05 Jul 2023 21:44:26 -0400
In-Reply-To: <5f172788-f16b-7bb1-6338-24453995f221@acm.org> (Bart Van Assche's
        message of "Wed, 5 Jul 2023 14:13:03 -0700")
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0025.namprd13.prod.outlook.com
 (2603:10b6:806:21::30) To CO1PR10MB4754.namprd10.prod.outlook.com
 (2603:10b6:303:91::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4754:EE_|IA1PR10MB7143:EE_
X-MS-Office365-Filtering-Correlation-Id: 51d1e411-3b8f-46dc-3c79-08db7dc2897d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jJPyxzDjPhLESR3JD3mWv/vkxZug9twNkkLDL1YmppqWBBeAoO3E/4EKhUlJ9DHyNG8wH9Aa+bB7KoqG19O4lhS7ulnqGwxaKOUIU4B8XfsMJqVM+TkSiQLqZax6K/hZ1UYdGBb2GBvcYkZMbJxAVQL8+bMOPvfA9L+taTBdqp5mzn+7jZ1x0XuxTgmb1WI4mGnzMunMZmtGFTwDNjNTUagyjW85TDqkJOL4y17eMJ+8QsFTZitRO078XesDBAgjlKBXtsQUctSZ8GqqVh8OvKYSOXNIEjGlBMOKCyTx4td1V1T2FpK0fAcKF/Lb4C7pjVhr3gmHtEucTaW6M4d0alEpnGXisTu2yCgujVeL4TdFgeEr0i+jv1B97Ea7rKfM/lmgMUGXbu/7YiOX4oWS/4lRdug0dOvp/m235A97ClzvfqnaQEUFdYobaEVh/GQ/zLbWcDtRm62zzw+v1P70DHgYOY3T02PXnuSoUWj4ZoeqcU/Y9RP84Pb0tAwKHzcAre/PaYXcXIt6JHHZT/rkcmRMEdU9FTmcptwoW2aG2zLIuKUCLNMn8uEgAC27U8ne
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4754.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199021)(6506007)(6512007)(6916009)(316002)(66556008)(38100700002)(66946007)(66476007)(4326008)(83380400001)(186003)(478600001)(26005)(4744005)(2906002)(8676002)(5660300002)(6486002)(86362001)(41300700001)(8936002)(36916002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iEFcD9GvE2oz67Pd2621LwOTgZYo6FdmhRbI/PHRx/bwEPRejJr5qLCJAv/C?=
 =?us-ascii?Q?GRTZbNurXzToaSLKAGDs7aQX5HRRJyJhCxQHZ6H8ATjI1/I9ksRe02QY38lR?=
 =?us-ascii?Q?Z/fEme7Y3rGhuMMLsXHnoajTrGC1Gk+v6z8cw00hXyV/VFX9urThwtqHlBR2?=
 =?us-ascii?Q?Ka6hQXcGhwkU0cCmht5Xe7XuXLxW5tWfkbreHVLkwU+yNS1V5y9K9sT+1BXL?=
 =?us-ascii?Q?oyX8pOscAO518tFrkYQz/xTZhYVrIH3zw9cxJhbttQGY80pqPHI57nYhLR4b?=
 =?us-ascii?Q?u9q6BnD1fR4UNgtLS9B3dA1OZ6kl+MTvZZRZRQ2iTpwZD51Anm46sHqSXz4T?=
 =?us-ascii?Q?6YCCrQkyDRMqPcZEefQzhsJzX5Otv3pxuCS/R4fvFByVz7NFVSbNBwPnDImU?=
 =?us-ascii?Q?q+QmIhk40ji16hlVKT8BZncwoOz7cCNYE95C0NrGHhnV7TqKknm6hwMzXoTP?=
 =?us-ascii?Q?XyFNHHPB8sFzADBwiMllOhIm8t7y9cvBHSXDQMNjpf1jN/gc5mAErZ+tZ3Yy?=
 =?us-ascii?Q?4+itKQGn5TQOGSJbzuC5WeHibZMe7piTdoxQNeq1iILtdv5FpT2eiiM70Pud?=
 =?us-ascii?Q?JzqjANvjOm0kHVO5jtWjwRlHWOwZTd33iGKHRLlbBACcUGua4wi2J3kmBpdM?=
 =?us-ascii?Q?6VckrUGQx+wp0xrBUsDtWdbPYqec/NJKw8NdCYawl6usVp+tOitzYyAVcihJ?=
 =?us-ascii?Q?Wbp645HfgtJhh74A80MlmoUcJdVoiF1t3rSvodVgaRbkKE928X76OmfUrhYO?=
 =?us-ascii?Q?GC3nMLTTytDnaBqgT9QuOn06TmuZOuiky4ROclxmIzn6DqSm6K8hrCL8wzLL?=
 =?us-ascii?Q?GlqKtpfHEIEa3Venk5OFiuR++TwjxSDzxoUYWjH+jMfqmlQb6wyXHUaR+4AJ?=
 =?us-ascii?Q?UtkJAJ85GuO5YwHWblWVeUMLNBHLjVIZ5jlee2frgRllWTy8cO52Q1Lg7hEW?=
 =?us-ascii?Q?c69C2uOLoH/QYmePgjyMEk6o8oL68SMQG2dbm91DTnu4oXL/D9K/TGg0NQcW?=
 =?us-ascii?Q?rTI5SGAz+xxSonyV3cttgw5kojQ1mUZHPxYG+KQqiCm3lcA1FP9rL84C85kC?=
 =?us-ascii?Q?Xa2XxT0XwCZyRizmItVdOPe3vsQwlVrQl2aBukykuinAxj6EfhiYg5OfefGK?=
 =?us-ascii?Q?kPARtq8boqFHEH47VX+y1W+pY8oT6llZSqRBxQ54J7D2xH8TIPPMCss8P3km?=
 =?us-ascii?Q?vqo0lknTGQNdwKQktH4dDrG/VrjtFgmuSVWyx6IYn71Bzg8V67UnRhGW2hGC?=
 =?us-ascii?Q?kse1P77StP0HMQ6UnZ6cq+lbOEhTEHxZ5gTHC4WHACX/zPoWlwyoc3BCsCCv?=
 =?us-ascii?Q?SlQnMKo7zUK01zC2Jr30DBNd2HYkIbiBgisEp6DqgK36wXnMVrTrl1vjYPXp?=
 =?us-ascii?Q?SJy8FlZ4l8E0af+dxlTDbjzra9ZHrxcMWiLUnUYMQOgahTVwJ5qUtn4x2BuD?=
 =?us-ascii?Q?Kysd+4gfcYqhC0+9xJbbM4+kO7pe74FmqTdQNg3iHRWuZe4he/qaZ4dvr5y4?=
 =?us-ascii?Q?iRIGfV+iAUvGueDk0D0ekSwFCltq9WJ1U270ehizIyZ17MEyqCYo5hTo+AGq?=
 =?us-ascii?Q?FI9e7/T/eD7rTK0eRwmVILAE2GbkLRNK7CNRRFNL0Cu3473tZYpb+x0JHnN0?=
 =?us-ascii?Q?yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bsbG18I24wXR3GiZk8Bt8YuC3iUUW+ko8CrRNnVi0AlmnxCX/Pp4U7aCedWD8Y4L9GvXVfDKVCH70wzvcKs/HNY6f5LPRlFEPBHgS3Vu8IY1mkF/IMXA93D14o8ajT9pwpOKUpXLM+as3l/F/H60imBX6dB+Tt5beW7EK+XzdsRDqf7skaiykdjADf6nkg8WmkbMfhthaJ5mTSkGqggNcAXAhDYDiDPbYwMD/dCizbm0MzXcp41iSopR+PJKvhYRTJZVN+Wz7/VMRDxroLxTtaEbm302cmYJ615qaW48l0gHHmeBo20eHAjPGCGnS/zqFUfXLcqo+oZMtlsmA57Dm4dyohuDANJc91QGENY2f/VWCFQxeeaXo+pO4KuNa9pLBARUFsRUoAcgT69Xcc0dO2dr+EZEuFWq03pwoKmO3Je3Cfp45uv9vlohRnTXJz1kYuGbBt21+y1U6A2gzbrBTLgzUjNKrXL7DG/YnEQgZoi28959GsbWHv8YDYUDM9i4fhfhvRJiADJvnAXXO9rh4bVEOgm6kXvgoRNqxQsFssy0bfCUmRPKX7fgVHUAJuDZYuiBhFvvI4b5mHJW1LYaMCV1xSxibbJi2VAf9gEBHN6GsujZlSjRc/4MCilIVb3cYZdklLuLlms1OdEQ/DYoPTAXoZWhMdyJsjhNXwdoA+aWKMoE2Y22xyS7U707fIi6qP1Fm35cfchrJ7TnLFQWlKE7XA6fUA5HyhfOByxUThzLX5JfllJ7zwrrpMelpUIuNsQnHdeoaHkRlC7uVBwUhCmyZZhf9JoVbFNLfycDKR0uvKMVOr+IZq6fiHeG7/yQGDBSz91CsQMk05LGIgjwYg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51d1e411-3b8f-46dc-3c79-08db7dc2897d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4754.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2023 01:44:28.7945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lr63LIkt48GvOjJJO+6St5vFjRh8U809qE33fhVoHZMwmA99F6m/Fvs+vRzjlhkGEPwX6U74X7kvwZSMQOC7XpmBc6fuIhAtcbDrLc4cj7M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7143
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_11,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060013
X-Proofpoint-ORIG-GUID: AtYgfm5aHIhmuCE9GTS6qQ85oUddgxFo
X-Proofpoint-GUID: AtYgfm5aHIhmuCE9GTS6qQ85oUddgxFo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Bart,

>> The new qTimestamp attribute was added to UFS 4.0 spec, in order to
>> synchronize timestamp between device logs and the host.The spec recommend
>> to send this attribute upon device power-on Reset/HW reset or when
>> switching to Active state (using SSU command). Due to this attribute,
>> the attribute's max value was extended to 8 bytes. As a result,
>> the new definition of struct utp_upiu_query_v4_0 was added.
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>

Applied to 6.5/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
