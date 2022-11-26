Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C8863929C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 01:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiKZATy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 19:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiKZATu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 19:19:50 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBD9528AD;
        Fri, 25 Nov 2022 16:19:47 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2APN3daP001619;
        Sat, 26 Nov 2022 00:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=/uRhS2flf0Oh/DBySW4ZXMo2YnvnIZ1P7u0hcftXcOo=;
 b=qJmdhbMZ+ovuWfu6nPM1OsOHZxVkX0BoaQ6b/cJu9HiU9/uLHc6I8jtsM4NPiWUxGt0T
 1FDm9LZFjG2FakY3MlIpr8EflW0hQHSj77jX/C1QluQnPh0NGil1Hle2KRyWlDNZ87qS
 Rfkexr7OkMh0+u/iWgWIIZ0/nsPfPhzDOisPjaM3b70vhSGjbKFN+F+Z4Nt7AYueUPZW
 ylE2oZw5qfmLLieetZ5C1yB08DykNoXtKCrCa0JF0e97DOUoCuAL04B7/1rQKqQdm1DX
 MyihUcQS0xdzT6gSS3RNk0/wItFyideBcehagKC3R+xVqiyjVa8T8itNBK8xLS097pXI LQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m1p5fng9r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Nov 2022 00:19:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2APKeiP2027671;
        Sat, 26 Nov 2022 00:19:39 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m233yhbrq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 26 Nov 2022 00:19:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CZQ+VZZKyroKxOeIx5qCey+l6oLzYI06cfd3p27j4gGXi6GtEQuk9ItjHV2+vzYN31m8LH3J8RGb5R6g2Qhx/t2MowKvhXwdItjtAm9g22u9SCheo6+ovv6B+ny88QJJKlrv+8ttNuNR1bESv3U0bPORcFnJPNlWEY815SxPCH2YJidkKZeCrKxKBn2qh16JTcp6qvuDRLclJoDtP+3t7tHX7Pd1tnBoBN81FLUS6aqNnQZcAK4LWP3/4LmpMPxDXoXSpnMFsRqe2uadlymYxs/fHdaOVbs/imyqrltDkxz9kk6tE4bxbBhG9mEMpnIWVEe/Ded+ZDr9xRTSWOfDnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/uRhS2flf0Oh/DBySW4ZXMo2YnvnIZ1P7u0hcftXcOo=;
 b=Z63GsgBTtYSl+zWccQhkt9XjC6xdv64ibpdBh1UT+38nJasKbp6NOb0pJ7vCX9CJg90RtBFeXd1oCpxOSNG34d5KaQePoXRg8lm46dqB7FfdE0tIhJcvfCg+ePwuuIdd/GYRSsrJiY7lu1Pc7POjrTsXwiJJ25b1cqAGa9kh2nA8nOLHJb1rvl86/0GftoXPTj7Ty8QJ80BwsrLYxwWmwRZ+DpXHymmO0uKQLKuodmzm3wdCcaV/kMixO8ju5BazHX6enOZB3gQ8daP0GxfLMCGlnaGD8mGuLUQkk2hb1KWv8DLx/cXLDU9ufcIbPbv5T+PcFGTlGXQv5H/lkAnZcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uRhS2flf0Oh/DBySW4ZXMo2YnvnIZ1P7u0hcftXcOo=;
 b=D6bF9SKCFqXlK0tIpp6bRKionBjUteR+xliiJzetuWeybT1Rw3bx9BqsF1uILKfX4d158S8QSNPY0c8v5coR6pyEFcyVFhFc06q32ZgYkCte/gsf8zr4r/fJYOtx0NaCNDjUySLmRmFHMUGwyhBlWFEYciv37NxM420fehTnVxY=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA1PR10MB6391.namprd10.prod.outlook.com (2603:10b6:806:257::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.20; Sat, 26 Nov
 2022 00:19:36 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b32e:78d8:ef63:470a]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b32e:78d8:ef63:470a%9]) with mapi id 15.20.5857.020; Sat, 26 Nov 2022
 00:19:36 +0000
To:     Chanwoo Lee <cw9316.lee@samsung.com>
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com, beanhuo@micron.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: ufs: core: Fix unnecessary operation for early
 return
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1v8n2r2ie.fsf@ca-mkp.ca.oracle.com>
References: <CGME20221111062328epcas1p2c2d1f52fed1068579a1dad7fb4e60f52@epcas1p2.samsung.com>
        <20221111062301.7423-1-cw9316.lee@samsung.com>
Date:   Fri, 25 Nov 2022 19:19:29 -0500
In-Reply-To: <20221111062301.7423-1-cw9316.lee@samsung.com> (Chanwoo Lee's
        message of "Fri, 11 Nov 2022 15:23:01 +0900")
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0195.namprd13.prod.outlook.com
 (2603:10b6:208:2be::20) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SA1PR10MB6391:EE_
X-MS-Office365-Filtering-Correlation-Id: 463731b2-7842-4bde-5801-08dacf43e643
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D67F87QrDzdfPkrArXdQ0d16lVWfK1SPBxo7n29ZgGIWDKQcU1ZLoQYVIONzZ3TZAVuasVSvE6W2z5chwfKfeX5HsmvulHyQD1A06htmIXXzYNhYwaE2p2o0Iun5DVHyHnqRDrpC6xrix34m3l/usxvaUzca2RHLepff7trFgvsaSymhiYtrSx2gD/TjY615NgLbeBYTl5oeShE2scmpbd+CqJ0rTmjHw8SZy2oV7SdBy5sOC98dPM8Xj4FFPJC+lcoytH04nLx3oKnCTkzAZZL980XA25rcKn4NE2TJ3P9yC5bAuN+wiBwz9xCmdpGXNMYKhqf+9quKN3hlmEL8QqkywonHhLwC122VNLDMmOQBFoJY9JUXxBWQPq//ZrDsb7voVT6whMPm4C0SYKxTm+wDsGi9tzGSsPl8uM6gt/jvOUaH8lJ20qltxaibNIIgEMtwYtOVeBa1EsmXixK3fQmoXbyHG0ieqFwuPzMTlAJ9zG2TFdQ2OA7IHWVtNx4lxbrP9U2lFg5N4KVTxR7XgmLItB5f1/N01SsMqJNmZHI8snZqDTjimRlWdyJM2VsWIRQ2rb6ppOnQjLnPenqAZlgDPea6F73wFyO61Wyb4P7dtYQ1eDo4ZAnJS5WtdvZ3qMJdr9sYpYpr01cDtyn4VA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(136003)(39860400002)(346002)(396003)(366004)(451199015)(8676002)(4326008)(66476007)(66946007)(66556008)(36916002)(38100700002)(41300700001)(6486002)(86362001)(558084003)(6506007)(316002)(6916009)(26005)(6512007)(6666004)(2906002)(186003)(5660300002)(8936002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fm4fiLO//8HvN+4CRhoeFDst6xtva7sX/loMbMD97oQgQcHrpVQiuyW9h5aY?=
 =?us-ascii?Q?PebiOpR2yM3HO5/s74Id5xMzhTxPMIp90BSCFiqJOi5oOCQINw7hgk5Bah7d?=
 =?us-ascii?Q?BXDqtJ9zCAbokL5QBajmKWq0cDhIwPpd0+c7hy4gQ22YL7J2ukvuwgQF5KvL?=
 =?us-ascii?Q?RusE1gQyde3uaX7o65wxhQwhnLoot8DZlgckc3VN6YDIEgkndA5B9/JEmWW+?=
 =?us-ascii?Q?vLtPuJ+jYd5hikJI/XsQL5ndyRlQw9EG90Y2NfaS2QgINlOVSmk6CNaEk5Bf?=
 =?us-ascii?Q?i67jMnm486p57PfaGC78ZfrywPN0wfWmELggGbKHTEcFrM30xJKWlXL/+Tnf?=
 =?us-ascii?Q?yjG3QK/Y66wtyyix7E6DcSLKUAbsx/wtalIl8fch4tWFxSq3KM+EmwC64F9B?=
 =?us-ascii?Q?esDY/u3dZDf8nEatQa2eeMcYPoi97jxDwVSVAbUWPpkAOzMu7itM68r6N+bM?=
 =?us-ascii?Q?awxXtPJjSclIW7IQ5IpyUQJiLM+xMYSiQQZO5IiZAbfu0orFTPgW62oEssv7?=
 =?us-ascii?Q?Kgwkn4Hki0RnMmwqsaiFpe70PrikgonGnsLC+HjXsTHoeO+gM9Cj6Lx/uiw2?=
 =?us-ascii?Q?UNmGloo3pAEHUL8sspKg4yIXw21tEafTudI47ZZHZLaJK6p9O7/UmSGPbXno?=
 =?us-ascii?Q?iUPOiKdd5E3Qcco2J1t+ucmkqGr6XbpwxuownPe2yv0mP+f3c4gsOg+sT2na?=
 =?us-ascii?Q?RWA7HFNGVwZ9KmXBG39rNNFyc5O4Jer4Blu7loTd9N7CT4/vvTXIQT7Vl7ZB?=
 =?us-ascii?Q?EXazcENSidMJbBH8uOu0VsiX/e9DlBYVrzizlFsPv4ewWNhZUUTjmtdMXGDE?=
 =?us-ascii?Q?UGU5CpzvMoHk67LgLIo8jgcZSZBkcIGDkJIrXpOhO09guN+y7ktx8cBRJOER?=
 =?us-ascii?Q?Ex5ab7XFERcBLeS2d6Y1SQRxf4LAoVPMNDuxAExBMo9ckvnvVufeTIm27iUg?=
 =?us-ascii?Q?scAUW1hYmrQlZjLoLUctQA2jtYEzm13wxY/lXoMtsWt/CGy4JGmxkv0ggx/0?=
 =?us-ascii?Q?Fr/OqLVgxXNlOqci4gskQxahOY18QyVr8vr1FzA3ZtUmb75jYuWg9Vmh9oXe?=
 =?us-ascii?Q?uO3SbxCBu9/74gc2B5as2LHDNj/BU0pm6HvbkR0CPydQrjOp3preIsC/z5Ii?=
 =?us-ascii?Q?8BZ7pS6p7tThYXDpZoPlzxo51RIJ6+W7itwRX1ZTpiFPOQf6b5CF5SzIFSKf?=
 =?us-ascii?Q?4LqzIZPElSB7P4EcMNnU3aPzPZFIPHWn1bhAQtL8yc5cRkIDhDKV2SG9bGh2?=
 =?us-ascii?Q?xHjvqbbj/vfQs3BkrePEghrc8aHyixeJsJdU74ozfVCuIHt/j/UmDq10BXZ4?=
 =?us-ascii?Q?WW59SEKFBMNdLt/F3h2AUuYRf3t6fO/zreLZ9S/1tIROR8NOmWVBkmvRC5TN?=
 =?us-ascii?Q?uO5+UyGdSE/I/zuEIhJp9SLNBtSD8gnVy3EtfazJcczL5YmcYGmWKadKs7Li?=
 =?us-ascii?Q?1ZnCnzNPgSAXZ8t469MDBKv7A0E8o11StLkRl3WDfjLUtRPPYo3/2QSvZgu1?=
 =?us-ascii?Q?iNEjEed0+lHWXB32RyIArnaoUq26UP/lWkR/9pZiOuCpSdddhExz8kCsxbsx?=
 =?us-ascii?Q?/npakeXepV+qPH4NT2HrdeKI5s/fFfZK7rAhPFvbvFwWlU6LuQ6noBb4heus?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ITK8KsTxW8MhIavaNkEqsxPpQU8mX1fj/hNzVdcbaBaRg7ajdxvSPA36i63l?=
 =?us-ascii?Q?60hsU/ekHCiD9KysPVZFOAIlDezlvV3iuCpmdM/F6aSifMWrsR2ngNWjqZMN?=
 =?us-ascii?Q?/pb92ulB/PZ1RAcbZQTRDwhDFoUlYiNYla7hG3jBFQyVilCt7CNUSV/qMaZ9?=
 =?us-ascii?Q?TM0fo8vzX7dvQC3Gv8JFsb7YKHZZz6G6ikmxp9kOm3kfBR4yVQfCKEG4fegc?=
 =?us-ascii?Q?hkjh8ShAgdl6ZsVABXo6WLxUsd3x+n4L3loCXdoSii0E1Yg+yxk+Y1vo3L/b?=
 =?us-ascii?Q?ve7Tz8blEXRhJzvDpsrDd71r2b7dvjdyOyUgsxyxzbpWCBbFwsJWBX30xRJa?=
 =?us-ascii?Q?5i3p/G5iusMa5d4bKnK3+q7dKiiWLei/AaI+Z64oNCX9fMC2jgbJ8xXZI1I0?=
 =?us-ascii?Q?b4hXwZoQhrqkytFsR8yLya+5OwkGzNvyO7ZOX93AOcoyuZ/AkpqU13BQe5HQ?=
 =?us-ascii?Q?t7vHtfZou0xsKwOcnAynkjSbNx2ipgFeunnOCcrIdDLIuPcpqaznGqkDWD8i?=
 =?us-ascii?Q?3+a5EbQw9G1Ub+KElxAWEpDGUNQFISM2mi0jP0RcX43YAf8HrkPL6a2acMpU?=
 =?us-ascii?Q?ERXANmz1Lz24TrurVJdClhGpIczrc2W6TWBqIN16VwllqcX1z1/sMjUDzsK2?=
 =?us-ascii?Q?v4pNx25jMw+wAM9GMtdTBuh2g0C2r3v7jGTo25T/weWdJnCYbQFKo61f3mfv?=
 =?us-ascii?Q?JupHzqr7fOOt7JIlSRZQzRw9bR1L17l2r+g4WkX0PAkHmofTCFttixrYiFp+?=
 =?us-ascii?Q?s/EM+vlkeMTELTL6IpbSLH61/hi4Sn4SI4z1/805BmTiqnK7h/iDGa0LK66T?=
 =?us-ascii?Q?SMU8SDZ4CvfA9M+aSsdbE2mMjvMY0zqc+hqZq/mrSIj+95JjuT/aG6XoQZR3?=
 =?us-ascii?Q?64c84QyppTwZlL7XldZyxiM9NiDcPmEf9YanudG/vNikqN+/o3ACFI6Q90rI?=
 =?us-ascii?Q?/Grr4eXe1DuoUyEtl9VV58vsJ8PFFk9Opt/+TW0kFPg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 463731b2-7842-4bde-5801-08dacf43e643
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2022 00:19:36.0841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rczYhfn5KQL1w+58bkginFTAUqh9AYqvPXay56sdk3wFlknJFn+i1zOrrvvQ3/FZnbevtxfTM07Hpoo1souu3IKSvKAknuBE5q1I2frZXWE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6391
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-25_12,2022-11-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=867 spamscore=0
 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211260000
X-Proofpoint-ORIG-GUID: K-6VDi33kT1zfeSV_dk3-AJlVbq7EwXc
X-Proofpoint-GUID: K-6VDi33kT1zfeSV_dk3-AJlVbq7EwXc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Chanwoo,

> For early return, bitmap_len operation is not required.  Modified to
> reduce unnecessary operations.

Applied to 6.2/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
