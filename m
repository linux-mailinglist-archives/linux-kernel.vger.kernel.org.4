Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8606E6D6D19
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 21:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235605AbjDDT1V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 15:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234792AbjDDT1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 15:27:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F149310E5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 12:27:17 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 334Dx6Bg002554;
        Tue, 4 Apr 2023 19:26:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=57p/uIrV/Y0uYNPN5kT5//IkfX4/Mxn9g4HOGyf/6bI=;
 b=CUuJuuSwQelAnPGhZXr1yFcslFKKb/IA3shQrbWEZGwUPI6CvPrp+gG+Qvytf52HFfD4
 Klvs7x6o1g087AEnpoCpwgh9vwS9iv8rZt2Vs5y5wwTQQjfb4ZcDPJ4ZONA2e+i+4KHU
 ynSwH61DQT+DTDQOTRufKI/Tuoci+5HuPMIGk57LYvG110rFYRYpLabdUKoSy3sccLu5
 5anKAznGCVL/2aBKhsmxIgYgahNGXM8CXpRquwNrN/3WdZrLdD9UoU5thbm28y1F+tWH
 HudgP6nefB6fVvYNZ24KkUekrxrQ3V21pGW89ZlRJyvatB7vv5zW30sH22TQL9qJ/JRy rA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppb1dppum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Apr 2023 19:26:39 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 334IX9h3037784;
        Tue, 4 Apr 2023 19:26:38 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptjsm1u0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Apr 2023 19:26:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYUUHi+06IUTg3xUmclVNY9iuiEi1wWli9xD9FQ6ArxC6nrxAKaeE1hiQzXO7Y6yGvNJ2iChaYQ2SlZaqwTUpCjzgU3BaokyHLxs6ujtkXmTPmUygglryLxhTsZO9/FAWFiLyR3QekCvy64oG1U6PHovXY9urXJd5FKapQ/RWpgQ3kyWNWEjQI+fIfODrSx+npl6PrY4vZZVfvpeSSjL2S2kCz0ZGebwCwiRJbv+58ApEmzE2WasCNhWx0ovwaf9L4mNIyXQYjeyBzGH12Ngk4+SpPZplYETmxDvyQsVwv2q1dZ7n09N43bGULlJIwFbVutM1iqurXdsyz4Ks3L4Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57p/uIrV/Y0uYNPN5kT5//IkfX4/Mxn9g4HOGyf/6bI=;
 b=GnAZXDk4Vn/lGcjVbE8hWf+0gwxICzmJ7ggbW6FE0q/QTCSSxCVqtkbtuhKIxxFlBCxF2QdvC8NhBGQja61wX592LuUmuKR9sjknA0QV5I83J2hd2gTbpCALiVYN86uLoUyTuN4CC6sOCz64rIQQ8HuaQ8OOVWtPgVY8IopwkkxI1vU53peheqSbwLMW1DaPInoWTxWl6MOu0wHHyPEijPUGsvnITzhqULpPI4JXfBV7b/qb6MT4bNVwVouarOw96dDavtaPv5jsZ5ybdBQzCOVLSqtmChiIH7XyFALB96hyXsO5IGdqjbaYtUBeXx+Jav2Vx33/nbcYjCMxlJRlVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57p/uIrV/Y0uYNPN5kT5//IkfX4/Mxn9g4HOGyf/6bI=;
 b=tiUvm+HQLY3hOlWmumlItFNajJOQ7U7lcq61EbpAxQnNfnifDcZvulNWrLty0QD/2zHqDuSJU9RqDSW/ZW2cwNAGKfda+Aka0ocLk2nQDAGl9YL4Y/v0RttIoa/VUol0VOtl8MJkwkuptNgafyW6Ve/bJmoJ5E7rQPH00Ofgx3A=
Received: from PH7PR10MB5698.namprd10.prod.outlook.com (2603:10b6:510:126::18)
 by BN0PR10MB5317.namprd10.prod.outlook.com (2603:10b6:408:127::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 19:26:35 +0000
Received: from PH7PR10MB5698.namprd10.prod.outlook.com
 ([fe80::8e48:ddd8:992d:582b]) by PH7PR10MB5698.namprd10.prod.outlook.com
 ([fe80::8e48:ddd8:992d:582b%3]) with mapi id 15.20.6254.035; Tue, 4 Apr 2023
 19:26:35 +0000
Date:   Tue, 4 Apr 2023 15:26:29 -0400
From:   Daniel Jordan <daniel.m.jordan@oracle.com>
To:     Ma Xing <maxing.lan@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, yuanzhu@bytedance.com
Subject: Re: [PATCH] sched/cputime: Make cputime_adjust() more accurate
Message-ID: <20230404192629.tcyy2k5ikmzgnfhr@parnassus.localdomain>
References: <20230328024827.12187-1-maxing.lan@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328024827.12187-1-maxing.lan@bytedance.com>
X-ClientProxiedBy: MN2PR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:208:d4::35) To PH7PR10MB5698.namprd10.prod.outlook.com
 (2603:10b6:510:126::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB5698:EE_|BN0PR10MB5317:EE_
X-MS-Office365-Filtering-Correlation-Id: be2b2e91-8a7a-4d15-a447-08db3542808f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z+A+kSG0+WijDK+s6VRMLsZKC/N6OSdAcvKgu+vpI7sS5hdOduFwb11q1afNPQ+qhuQmldWBjN10fGeyShA6GeUC39uqc2/TxnUiuxPxxyZpPqSGC++uFKS1x679Hc6Y9tjTOTKfT9P4tkGi9VrIPT/dWNsKD2v05LKPRkwbzgf+zHFmDjj0esYKYPZ/zhElH79IkaoXPsz44e5QFu9L2RNWG1jjNferF1mBNdGZol+cuJPeIS5ViEZa/hqWLmYyo7Tg+vVrNLWoF44IT+kA0cFlyYuJH1XLhYdJ1PSG0O6P6erVg02NU23y+z2Ky8lOQjz/FipJbinS7As9444CLUWwpHjrD2VKsxZWGiv+3w5EgcxSdBENlmsDvmDpwF007kZ+j7iwPIEBbN2XJkK/OFAQydTwxpJX4dIbudl0GpvjXqZcVu2QUQvd3Wm90lOPEondmmDIl5zfftdzpkbBBwXnI4DnaBBU7ilrpPJDj0WySsBcRMkOIb19gzEhytWzuiSFMI+MorbwmtWrT/Bmz6ORPGZ0HkhkXmK/H6Ez8BU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB5698.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199021)(6666004)(6486002)(966005)(83380400001)(86362001)(38100700002)(6512007)(9686003)(26005)(6506007)(1076003)(186003)(316002)(5660300002)(2906002)(7416002)(8936002)(41300700001)(66946007)(6916009)(30864003)(4326008)(66476007)(66556008)(8676002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yZZCrzwC0iYTlpPttAr62IDU9Z5ctFNMVp2yZI2YohwdRhux97f6VLDW3ZI6?=
 =?us-ascii?Q?kkB5aCNWLEaeg/td5xJyAuBCL2bxbh4GFLetOYjemzOjKrpcMIhRx/6wz10b?=
 =?us-ascii?Q?I5putweqix8Xqf55jacd375osoh6wBo2ysmiIhKgtFEgsHA5TNLE2MOY+aY2?=
 =?us-ascii?Q?qMU+JOQXM4a+GPjOTU06CdPg9/39Fd7j/6nptVRexAYNL+pHH5Hdyhprdo16?=
 =?us-ascii?Q?rL143djU5v62xoY09KplmTr+MoNoND5BhSZzfAUfpts1bf+qNh769p6lePGd?=
 =?us-ascii?Q?dfMegtErs1ifXCDZqHrhYPYsVHh2jIqACtAmCfz9yKVxJSZyav67fbYDbelp?=
 =?us-ascii?Q?rT+yuE2xB4eN8WqC0FsYqUpqAlmdWtRBz9wKIRRkzj2eftJ67+2tVhltmxn7?=
 =?us-ascii?Q?1ManRAHBAP6PsS6TaAYXdOYbYKibjHvfRAh2sRR/Wt3ygpWQkz5llJx0TPHd?=
 =?us-ascii?Q?1OjhGKkE9RV1JAEi9kR5W7fm/3l0DVgvrypO6vd/l2UWSJFYKSB/Y6NNPhxY?=
 =?us-ascii?Q?K5ASBaeXBh77NXThxaYjN2imPPtRDRXM2TtKe/GjxB3y17aQAQ+gJ9XK3oRX?=
 =?us-ascii?Q?fau4m4RKInt+abQgISQ3CdiElOohNfvSianGO6znc+AHOI5tr5XvUEvyP+jH?=
 =?us-ascii?Q?W/TuB20sC3qv05CrsKlWVbvSnRUjfQAWrfoOyZV2eUZXXgrAWV1jZHHJDVFf?=
 =?us-ascii?Q?V8BTvec1/ZGAzu+O9bkgq7qjCtmyTz9noyp/i+zuJ5aMS7X796RBlkMs3/jL?=
 =?us-ascii?Q?q9owrwfslEFx2d1nL5slKZqchasOWXfEEAYX00fmE1PGRq8VcsP0xoVW1n+m?=
 =?us-ascii?Q?62rkXRq4vdBXob5fhCqu+bTfmvtat2DA4Yxhx2/6PqzSfp2jkk1DMJ7d7qcz?=
 =?us-ascii?Q?2W/38jX4G8GohYE6VIN2jA48+wsk85xEablmbS+tUehLEgGAgfJuJKgIFtn7?=
 =?us-ascii?Q?kUrPwRXSQpC8E5VANC79mbZbvon7Tzc1MvM05fFfWNJ5VdGy5yUy2rFw0HMD?=
 =?us-ascii?Q?xY5C+Q5XPQUnQGD0vW9JK3r1VT1S0mr7zQ30a/aphgkv/qZfE5+dw4nAohqp?=
 =?us-ascii?Q?wjLg7ba41rq0eTftqOY6vzMNGgDMwHbbwb9E90YaVN5RDs57N/QuGhJLW+5G?=
 =?us-ascii?Q?G5KpzBJpWmsZzcxEiqMpvu8CHinIG2yBK0zDuhSY+NML9MmEj07RioZa9ELe?=
 =?us-ascii?Q?lJfzIECaDoGmly87p7i1OnnRugoLGGrvZVAkryQajU0rH7OplyVOr0ELBDL4?=
 =?us-ascii?Q?XAR9ugOmIpLsXGQj2pSCFt64tqw2xFmFDKD7guQkEIR+JeUF9ouR027c4yzc?=
 =?us-ascii?Q?rm4ANk7e1/ZxViMqKjIJ8VxF55opZLM1SCFfnfTky9A5QyueO/nf131UxQnd?=
 =?us-ascii?Q?7usP2HTP70b4yoyDJCcm+qB6q9ySiRJ6cY+D6Fq3QnBlyLypwNFBpEOoWwdh?=
 =?us-ascii?Q?q64OvnqhONEg3/WGRnzYOyeZqTuJ7acf+WWDXyzav2/sSrYzxWT/VmveqLP0?=
 =?us-ascii?Q?JBrFdo87jfXcHAsRqFBvbdQ/0zInphexf2iqfoOXF28omDqIlWml+tIXZ9/q?=
 =?us-ascii?Q?Jv0GML+NYqt7lBEI/GlaheXrZxlu29DDThXkV+ipIusrDyc7BDqOUgGiaAMe?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?UuW+Raxsjho4BQZ7+MU51JvFPlqAAWCLhMsi4RQti6PUfwkQoahwg2O+3GNa?=
 =?us-ascii?Q?EpPIhmJ7pURrFE8+rQsGi9QACh6WagcxMnA46jkeQ3+S93WZWHqkMTN6e76O?=
 =?us-ascii?Q?XJ8+GNqYY8yuY0tAKP1FlYayh0MfYnU45FD694R8zQsxajkUxDrpGGZS/uTZ?=
 =?us-ascii?Q?D5JFfsT1fkCeDTzYw0usIyZ5bnUYGPJzSkeTG11hNKnyNKYs6W7+jBz0LNx8?=
 =?us-ascii?Q?I5ba4y7OM1xJ0w16aCd+a9fEVnbgm9on/j/LFxTBdd6nlT+tNWOmsEwGGwRH?=
 =?us-ascii?Q?mElNXM+euiRBtXpc/8rANL8ar/+TE+Qqk79HR+355QVPy723BmXw5L4wsBLz?=
 =?us-ascii?Q?uzkRWBdIO3o/s9eSx1ed+y1/Mv8ee50Otk18DR/YpOTlhBUKS2t/q259D/V5?=
 =?us-ascii?Q?wGy78sRLqC03D50g3kFJtZsrHVn7hEeilD94u6b1iiaWg+JNXBbib3f7I/Tz?=
 =?us-ascii?Q?bJEKTpzo48v6Vc94M4IMCiZJDkl5QztI0bFVctNgDX28xrSoE0ad9bVsLcvy?=
 =?us-ascii?Q?GL39+BtV0MtxZYGlLRBWx6xmwECTC9rj0Cx0fDCF79Yu3aRTIVUVIwrhaR9A?=
 =?us-ascii?Q?pE5HdsS5KUVM7Hf/EwW6oTR9OEBYWvY5XglW1kTpdXpLcbLlBtG9Am4ZIXdI?=
 =?us-ascii?Q?GUfp9nRiX1KtmQ8ceTbDCiuxSDnw2/WbQYVbZwN9+xOzx7q2k+yljxNyf/PO?=
 =?us-ascii?Q?/P0dHxJ9dR3mA/rSuAqrfdM6Le+osnODehh+MbHavKV9yaSzIczEWEUibKyp?=
 =?us-ascii?Q?tRQBmjlFmbwZ5jQ/qp8QlAnbo9i+h6yr+mLGCT5Y5GtA9OcNXdz+bGh/+09L?=
 =?us-ascii?Q?CV3y8d3Ic0bTLWKsGhQQNb9D4YsPYH8dAv9nA7ORs+KmeuCr4cC23XDxRZ7T?=
 =?us-ascii?Q?HzIBL2ERUUBjbEoSfrJcRs0q+/nwYxxyCFRVKjnGmnsORe9Mfv4qPfMzzXIG?=
 =?us-ascii?Q?bD00XeYG2ovASdcKlMe/0zFnonwgvr7h4vcZozyaCLrambm98sQr8Ird8FsO?=
 =?us-ascii?Q?6IBO?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be2b2e91-8a7a-4d15-a447-08db3542808f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR10MB5698.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 19:26:35.3630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +wp61DqDIm1Ff75pjuTE1qxVkPZ77RyWhHOlkBwCWu4BmSwDXCKiVAfomw+b7kEEulNnRHZwz0CU6izfruSuwQioScjxnUda/DkJbpPaPUI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5317
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-04_10,2023-04-04_05,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=479 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304040176
X-Proofpoint-GUID: hTI-bhaOumEhQyZxVYJu-ZImbCLsAzU1
X-Proofpoint-ORIG-GUID: hTI-bhaOumEhQyZxVYJu-ZImbCLsAzU1
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

(fixed Valentin's email, leaving whole reply text)

On Tue, Mar 28, 2023 at 10:48:27AM +0800, Ma Xing wrote:
> In the current algorithm of cputime_adjust(), the accumulated stime and
> utime are used to divide the accumulated rtime. When the value is very
> large, it is easy for the stime or utime not to be updated. It can cause
> sys or user utilization to be zero for long time.
> 
> A better and intuitive way is to save the last stime and utime, and
> divide the rtime increment proportionally according to the tick
> increment.
> 
> I wrote the test-case: refer to
> https://lore.kernel.org/lkml/20190718131834.GA22211@redhat.com/
> 
> 	int main(int argc, char ** argv) {
> 		struct task_cputime c;
> 		struct prev_cputime p;
> 		u64 st, pst, cst;
> 		u64 ut, put, cut;
> 		u64 x, y;
> 		int i = -1; // one step not printed
> 
> 		if (argc != 2) {
> 			printf("usage: %s <start_in_seconds>\n", argv[0]);
> 			return 1;
> 		}
> 		x = strtoull(argv[1], NULL, 0) * SEC;
> 		printf("start=%lld\n", x);
> 
> 		p.stime = p.stick = x;
> 		p.utime = p.utick = x;
> 
> 		c.stime = p.stime;
> 		c.utime = p.utime;
> 		c.sum_exec_runtime = p.stime + p.utime;
> 
> 		while (i++ < NSTEPS) {
> 			y = STEP;
> 			c.stime += 4*y;
> 			c.utime += y;
> 			c.sum_exec_runtime += y;
> 			pst = nsec_to_clock_t(p.stime);
> 			put = nsec_to_clock_t(p.utime);
> 			cputime_adjust( & c, & p, & ut, & st);
> 			cst = nsec_to_clock_t(st);
> 			cut = nsec_to_clock_t(ut);
> 			if (i)
> 				printf("ut(diff)/st(diff): %20lld (%4lld)  %20lld (%4lld)\n",
> 						cut, cut - put, cst, cst - pst);
> 		}
> 		printf("\n\n");
> 
> 		while (i++ < 2*NSTEPS) {
> 			y = STEP;
> 			c.stime += y;
> 			c.utime += 4*y;
> 			c.sum_exec_runtime += y;
> 			pst = nsec_to_clock_t(p.stime);
> 			put = nsec_to_clock_t(p.utime);
> 			cputime_adjust( & c, & p, & ut, & st);
> 			cst = nsec_to_clock_t(st);
> 			cut = nsec_to_clock_t(ut);
> 			if (i)
> 				printf("ut(diff)/st(diff): %20lld (%4lld)  %20lld (%4lld)\n",
> 						cut, cut - put, cst, cst - pst);
> 		}
> 	}
> 
> For example, the new patch works well when cfs based rtime disagrees
> with tick based stime/utime, the root reason is it converges fast:
> 
> 	# ./a.out 300000
> 	start=300000000000000
> 	ut(diff)/st(diff):            300000400 ( 200)             300001600 ( 800)
> 	ut(diff)/st(diff):            300000600 ( 200)             300002400 ( 800)
> 	ut(diff)/st(diff):            300000800 ( 200)             300003200 ( 800)
> 	ut(diff)/st(diff):            300001000 ( 200)             300004000 ( 800)
> 	ut(diff)/st(diff):            300001200 ( 200)             300004800 ( 800)
> 	ut(diff)/st(diff):            300001400 ( 200)             300005600 ( 800)
> 	ut(diff)/st(diff):            300001600 ( 200)             300006400 ( 800)
> 	ut(diff)/st(diff):            300001800 ( 200)             300007200 ( 800)
> 	ut(diff)/st(diff):            300002000 ( 200)             300008000 ( 800)
> 	ut(diff)/st(diff):            300002200 ( 200)             300008800 ( 800)
> 	ut(diff)/st(diff):            300002400 ( 200)             300009600 ( 800)
> 	ut(diff)/st(diff):            300002600 ( 200)             300010400 ( 800)
> 	ut(diff)/st(diff):            300002800 ( 200)             300011200 ( 800)
> 	ut(diff)/st(diff):            300003000 ( 200)             300012000 ( 800)
> 	ut(diff)/st(diff):            300003200 ( 200)             300012800 ( 800)
> 	ut(diff)/st(diff):            300003400 ( 200)             300013600 ( 800)
> 	ut(diff)/st(diff):            300003600 ( 200)             300014400 ( 800)
> 	ut(diff)/st(diff):            300003800 ( 200)             300015200 ( 800)
> 	ut(diff)/st(diff):            300004000 ( 200)             300016000 ( 800)
> 	ut(diff)/st(diff):            300004200 ( 200)             300016800 ( 800)
> 
> 	ut(diff)/st(diff):            300005000 ( 800)             300017000 ( 200)
> 	ut(diff)/st(diff):            300005800 ( 800)             300017200 ( 200)
> 	ut(diff)/st(diff):            300006600 ( 800)             300017400 ( 200)
> 	ut(diff)/st(diff):            300007400 ( 800)             300017600 ( 200)
> 	ut(diff)/st(diff):            300008200 ( 800)             300017800 ( 200)
> 	ut(diff)/st(diff):            300009000 ( 800)             300018000 ( 200)
> 	ut(diff)/st(diff):            300009800 ( 800)             300018200 ( 200)
> 	ut(diff)/st(diff):            300010600 ( 800)             300018400 ( 200)
> 	ut(diff)/st(diff):            300011400 ( 800)             300018600 ( 200)
> 	ut(diff)/st(diff):            300012200 ( 800)             300018800 ( 200)
> 	ut(diff)/st(diff):            300013000 ( 800)             300019000 ( 200)
> 	ut(diff)/st(diff):            300013800 ( 800)             300019200 ( 200)
> 	ut(diff)/st(diff):            300014600 ( 800)             300019400 ( 200)
> 	ut(diff)/st(diff):            300015400 ( 800)             300019600 ( 200)
> 	ut(diff)/st(diff):            300016200 ( 800)             300019800 ( 200)
> 	ut(diff)/st(diff):            300017000 ( 800)             300020000 ( 200)
> 	ut(diff)/st(diff):            300017800 ( 800)             300020200 ( 200)
> 	ut(diff)/st(diff):            300018600 ( 800)             300020400 ( 200)
> 	ut(diff)/st(diff):            300019400 ( 800)             300020600 ( 200)
> 
> while the old cputime_adjust has the following problem, when sum_exec_runtime is 300000 secs.
> 
> 	# ./a.out 300000
> 	start=300000000000000
> 	ut(diff)/st(diff):            300000000 (   0)             300002000 (1000)
> 	ut(diff)/st(diff):            300000000 (   0)             300003000 (1000)
> 	ut(diff)/st(diff):            300000000 (   0)             300004000 (1000)
> 	ut(diff)/st(diff):            300000000 (   0)             300005000 (1000)
> 	ut(diff)/st(diff):            300000000 (   0)             300006000 (1000)
> 	ut(diff)/st(diff):            300000000 (   0)             300007000 (1000)
> 	ut(diff)/st(diff):            300000000 (   0)             300008000 (1000)
> 	ut(diff)/st(diff):            300000000 (   0)             300009000 (1000)
> 	ut(diff)/st(diff):            300000000 (   0)             300010000 (1000)
> 	ut(diff)/st(diff):            300000000 (   0)             300011000 (1000)
> 	ut(diff)/st(diff):            300000000 (   0)             300012000 (1000)
> 	ut(diff)/st(diff):            300000000 (   0)             300013000 (1000)
> 	ut(diff)/st(diff):            300000000 (   0)             300014000 (1000)
> 	ut(diff)/st(diff):            300000000 (   0)             300015000 (1000)
> 	ut(diff)/st(diff):            300000000 (   0)             300016000 (1000)
> 	ut(diff)/st(diff):            300000000 (   0)             300017000 (1000)
> 	ut(diff)/st(diff):            300000000 (   0)             300018000 (1000)
> 	ut(diff)/st(diff):            300000000 (   0)             300019000 (1000)
> 	ut(diff)/st(diff):            300000000 (   0)             300020000 (1000)
> 	ut(diff)/st(diff):            300000000 (   0)             300021000 (1000)
> 
> 	ut(diff)/st(diff):            300000000 (   0)             300022000 (1000)
> 	ut(diff)/st(diff):            300000000 (   0)             300023000 (1000)
> 	ut(diff)/st(diff):            300000000 (   0)             300024000 (1000)
> 	ut(diff)/st(diff):            300000000 (   0)             300025000 (1000)
> 	ut(diff)/st(diff):            300000000 (   0)             300026000 (1000)
> 	ut(diff)/st(diff):            300000000 (   0)             300027000 (1000)
> 	ut(diff)/st(diff):            300000000 (   0)             300028000 (1000)
> 	ut(diff)/st(diff):            300000000 (   0)             300029000 (1000)
> 	ut(diff)/st(diff):            300000000 (   0)             300030000 (1000)
> 	ut(diff)/st(diff):            300000000 (   0)             300031000 (1000)
> 	ut(diff)/st(diff):            300001000 (1000)             300031000 (   0)
> 	ut(diff)/st(diff):            300002000 (1000)             300031000 (   0)
> 	ut(diff)/st(diff):            300003000 (1000)             300031000 (   0)
> 	ut(diff)/st(diff):            300004000 (1000)             300031000 (   0)
> 	ut(diff)/st(diff):            300005000 (1000)             300031000 (   0)
> 	ut(diff)/st(diff):            300006000 (1000)             300031000 (   0)
> 	ut(diff)/st(diff):            300007000 (1000)             300031000 (   0)
> 	ut(diff)/st(diff):            300008000 (1000)             300031000 (   0)
> 	ut(diff)/st(diff):            300009000 (1000)             300031000 (   0)
> 
> In addition, this patch has been running stably for 2 months and no problems have been found.
> 
> Signed-off-by: Ma Xing <maxing.lan@bytedance.com>
> ---
>  include/linux/sched.h         |  2 ++
>  include/linux/sched/cputime.h |  1 +
>  kernel/sched/cputime.c        | 38 +++++++++++++++++++++++++----------
>  3 files changed, 30 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 6d654eb4cabd..e1bac4ee48ba 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -326,6 +326,8 @@ struct prev_cputime {
>  #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
>  	u64				utime;
>  	u64				stime;
> +	u64				utick;
> +	u64				stick;

The new fields don't enlarge task_struct in my builds because of later
alignment, but struct cgroup and signal_struct do get a bit bigger.
It's the only downside I can see, the change looks like a win overall.

It improves utime/stime accuracy even when rtime isn't that large, when
there's a change in the rates that utime and stime grow relative to each
other.

>  	raw_spinlock_t			lock;
>  #endif
>  };
> diff --git a/include/linux/sched/cputime.h b/include/linux/sched/cputime.h
> index 5f8fd5b24a2e..855503bbd067 100644
> --- a/include/linux/sched/cputime.h
> +++ b/include/linux/sched/cputime.h
> @@ -173,6 +173,7 @@ static inline void prev_cputime_init(struct prev_cputime *prev)
>  {
>  #ifndef CONFIG_VIRT_CPU_ACCOUNTING_NATIVE
>  	prev->utime = prev->stime = 0;
> +	prev->utick = prev->stick = 0;
>  	raw_spin_lock_init(&prev->lock);
>  #endif
>  }
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index af7952f12e6c..ee8084957578 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -559,6 +559,7 @@ void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
>  		    u64 *ut, u64 *st)
>  {
>  	u64 rtime, stime, utime;
> +	s64 delta_rtime, delta_stime, delta_utime;
>  	unsigned long flags;
>  
>  	/* Serialize concurrent callers such that we can honour our guarantees */
> @@ -579,22 +580,36 @@ void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
>  	stime = curr->stime;
>  	utime = curr->utime;
>  
> +
> +	delta_rtime = rtime - prev->stime - prev->utime;
> +	delta_stime = stime - prev->stick;
> +	delta_utime = utime - prev->utick;
> +
> +	prev->stick = stime;
> +	prev->utick = utime;
> +
>  	/*
>  	 * If either stime or utime are 0, assume all runtime is userspace.
>  	 * Once a task gets some ticks, the monotonicity code at 'update:'
>  	 * will ensure things converge to the observed ratio.
>  	 */
>  	if (stime == 0) {
> -		utime = rtime;
> +		delta_utime = delta_rtime;
>  		goto update;
>  	}
>  
>  	if (utime == 0) {
> -		stime = rtime;
> +		delta_stime = delta_rtime;
>  		goto update;
>  	}
>  
> -	stime = mul_u64_u64_div_u64(stime, rtime, stime + utime);
> +	if (delta_stime <= 0)
> +		goto update;
> +
> +	if (delta_utime <= 0)
> +		goto update;

Where do task_struct::stime and utime decrease?  If the < in <= is just
defensive, there could be WARN_ON_ONCEs earlier on to catch bugs, and
then couldn't the s64's become u64's, the above four checks be
reduced to

        if (delta_stime == 0) {
                delta_utime = delta_rtime;
        	goto update;
        }
        
        if (delta_utime == 0) {
                delta_stime = delta_rtime;
        	goto update;
        }

and the monotonicity code below go away since the nonnegative deltas
ensure that on their own?:

        delta_stime = mul_u64_u64_div_u64(delta_stime, delta_rtime, delta_stime + delta_utime);
        delta_utime = delta_rtime - delta_stime;

update:

        prev->stime += delta_stime;
	...and so on...

> +
> +	delta_stime = mul_u64_u64_div_u64(delta_stime, delta_rtime, delta_stime + delta_utime);
>  
>  update:
>  	/*
> @@ -606,21 +621,22 @@ void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
>  	 *            = (rtime_i+1 - rtime_i) + utime_i
>  	 *            >= utime_i
>  	 */
> -	if (stime < prev->stime)
> -		stime = prev->stime;
> -	utime = rtime - stime;
> +	if (delta_stime <= 0)
> +		delta_stime = 0;
> +	delta_utime = delta_rtime - delta_stime;
> +
>  
>  	/*
>  	 * Make sure utime doesn't go backwards; this still preserves
>  	 * monotonicity for stime, analogous argument to above.
>  	 */
> -	if (utime < prev->utime) {
> -		utime = prev->utime;
> -		stime = rtime - utime;
> +	if (delta_utime <= 0) {
> +		delta_utime = 0;
> +		delta_stime = delta_rtime;
>  	}
>  
> -	prev->stime = stime;
> -	prev->utime = utime;
> +	prev->stime += delta_stime;
> +	prev->utime += delta_utime;
>  out:
>  	*ut = prev->utime;
>  	*st = prev->stime;
> -- 
> 2.20.1
> 
