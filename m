Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACD6672CBB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjARXm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjARXm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:42:26 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2CB4CE4C;
        Wed, 18 Jan 2023 15:42:25 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30ILmt5A003547;
        Wed, 18 Jan 2023 23:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=8pjDRMPD+eIWDhgzFxp97ANXrWUisoly/hXr7YW0L5A=;
 b=Zhu+WWjSl/VGFUrNFpqCNjYDg31dRvPCWnQCCmL3TAg3UKS++aG97oUyQuXWxGsQBcX0
 5JOq6vpdISvvXQshALltAVrcWuznZ6DAPVu+9aZEgd0K8cMH/3I9Ave7rsAPUa/qFfS+
 CYuDmsd3WGuQ4whQ7/GespPbbOauKS4O3KTsn2OBj9pcLhY+4Hdds/CLx9fLAB4Mkiq8
 48KCifSX+SCSVELSpMTNWc0MnF8b8OuhayhiokmwtFa6lmvN8Env/ttFOUFEMD8wviIE
 mPMWW9H8LOmB2ZQW0g/hzyu/p+X5L2Xv8qDs8w2PI5PcDubygFTt3T6nQNVSZAMjMY6z kA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3k01115r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 23:42:22 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30IMNuNg030715;
        Wed, 18 Jan 2023 23:42:21 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n6quawy62-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 23:42:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKZwk91pN2O3HSIXxc59ovFkT2zoq8WkcdW6JhV1NvUH3mqwz11H9K3Cdgi4EZVkut5MZ+wTrCOox45amMP367EjnN3DJLfnWDdsaS2aMF5Sn4XLh3Emqju+qh8v6wKZfBnWfr1AiAiY4EodW1JedO7gXl7LX/aBla1SHY4qdD0Pk/YUw8XsaK5Xb8rvsg04L9I2OhyXwwMf3lCk5FTUUOtWsHFGDi0JY7thnIw5oeAzjY6C+1edqxUnHXd54sG+ZNGIOphQty5ArgrKqXFXGhObNqnRwuee4ipFWBytWh+PZtjYe6HGMVNhsYW8Ru5iPxtFQDezfjKyozGkon1l4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8pjDRMPD+eIWDhgzFxp97ANXrWUisoly/hXr7YW0L5A=;
 b=lU9mOE4uMZR7su/dkw6RtAbYia8M4WNvH13DEJ35848oYqfNlB6NyWOljtorP0ReMIUrLmQENz+BCmBcTRTMVcYlo6Aeu2F2qwlx+vUvX3eZaxCE461xS9QvLsz6mnE99ylsAPsKw2ZAMuF1VoyvLbZP8BuvuoCyfRxrvlhYXRwNTEqa9DkqbVY5LR8QPSh7zvpjW5q1RlNJi8fI6JK996s+s3NUfxYuYuuW0q5JAMmZHMjjNvEpnO56OEzr1By9NPSPUWLeyqwrSNDktuyk2fplflqcB/CJcFU8WNAuQ4K0ZgJCudzsbZ6NDpJId/m2AY5Y4FuZPvdg0Pz3vo+8BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pjDRMPD+eIWDhgzFxp97ANXrWUisoly/hXr7YW0L5A=;
 b=NJLkYUDyUoKUwbUarbIEmDbBlo0rUlbBfSAMkn2r72zaiQLXxxZgzCA9YIgViLlH7uOb5Rfr4AvEAFTzTO6BSltbn0aNHDVWlO2LjIXIupfESbmo4rVpaun6Xlq2n80GHvV13MzIekw8Kq4MK6KCCHZ984o88VLVMS7IlgaOdmk=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA1PR10MB5821.namprd10.prod.outlook.com (2603:10b6:806:232::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.9; Wed, 18 Jan
 2023 23:42:20 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6%8]) with mapi id 15.20.6002.013; Wed, 18 Jan 2023
 23:42:19 +0000
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] scsi: ips: Replace kmap_atomic() with kmap_local_page()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq18rhzpfzw.fsf@ca-mkp.ca.oracle.com>
References: <20230103173131.21259-1-fmdefrancesco@gmail.com>
Date:   Wed, 18 Jan 2023 18:42:15 -0500
In-Reply-To: <20230103173131.21259-1-fmdefrancesco@gmail.com> (Fabio M. De
        Francesco's message of "Tue, 3 Jan 2023 18:31:31 +0100")
Content-Type: text/plain
X-ClientProxiedBy: DS7PR06CA0024.namprd06.prod.outlook.com (2603:10b6:8:2a::8)
 To PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SA1PR10MB5821:EE_
X-MS-Office365-Filtering-Correlation-Id: 062dace2-01ee-425f-6682-08daf9ada3a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 71qDQCNShGZJD1eoWv3mfGDXU2Kyhu11BCL0cKmTY9wgzsAKFkvkfA/dC3vBX8oCc1bPleQTk2mGFtuh+qICOm2R51Br5CoP/9be7mDgSDYa2AF6s2gyYApM/SD3/qPrVsEGaj13yoZZ4KzAIxAagE6TRU/r0A1wsoJd/XA9v/1LdRa3dmV/GxRadA7LZim00UdFdYdEEDvzUCqaY2pIqxxn+pAKHry/zO2Mk/oIouipLfx8kUssNn23/dW00l6Pn2cdcALD2SQ1gFx4m3HZkMI1H+VkdAr8pbQos6ZkmdcsJ7iNTD7GoCR/dexzByT6a2uZ8GGztmLF3ivBbmfBbEt3F/h+5F6Zf37NuWxKxsJsy6d9cezrT55JOuYyqPRwEl0D8WgDYZSmwA+uZpGAs4lr+bSX6lCxPz2Ll6hZBjotZ7s4kzarAjAFrDRvVy5RugvxccfNAVldIx2Kqy+ca+EJ73v2jrnuUIP8bRFBfvYhjiByHW9Y/fQvLdr2Jpstus0dCOElvtPC2QQaXxnnT/1UYuUo7/J2TCFPdpA5JFVQW1SPhQcwI9MbCyK5EPiUU52yOf5GLypFXmcIUaJIIZnOM5LNzeabGKPqSWz6MJ+pZbAWuayWDRdH0bQED7Ucjx3SQlwcTVycjbVkbKFcWQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(366004)(346002)(376002)(39860400002)(451199015)(6916009)(558084003)(86362001)(6512007)(38100700002)(6486002)(8936002)(5660300002)(41300700001)(316002)(66476007)(4326008)(66556008)(8676002)(66946007)(2906002)(478600001)(186003)(36916002)(54906003)(26005)(6506007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tpumKHuh1EXwoD2Q3DpAJF23JFXj5fGfhN50XjTctno3Ak0SLs/H5fNxskl9?=
 =?us-ascii?Q?fMrQKRotiMvhQ73h4tJ5qsRkkmn2E+tWhAh87SHLbur+8rjdrXDIvGGIMY7V?=
 =?us-ascii?Q?w19TDwXwYik+XBNMP0PxACvCu0K60qeOwqvQthHIPUEAJ2dmcN0kmmODqOeS?=
 =?us-ascii?Q?rCvA54EDqQj87SNvXLRmsDNSDNKq1fIi7ObWadtnB/4wW61sv20LE7W/ivUH?=
 =?us-ascii?Q?nIa/OiSmxsXsxXGSaxdQLCXMG6VdPMYApToo6cDN9sCAXpBo8wmpsrCLv5Hc?=
 =?us-ascii?Q?aY6CKnTY+CtFplEPVZKxzmMVy+GVaOBtKNBxCFnWPi24DiY3LRJVQaPoBThZ?=
 =?us-ascii?Q?jM28//BMCcmbYnJ33ed3ZFKi4ZqWKijbd4T2ySLbNDN7oOggLIssI8Sijreq?=
 =?us-ascii?Q?2deDoAWUl5XzKtIENRw4W2dGvUL724CDOXka3sSHofaD9TYNdy+568vNHblK?=
 =?us-ascii?Q?pZzXfbTJ9Z0jQoCCGE0YS2I947lMvrnU95/+W4pB8lb/uzCq+DF6otn7URF6?=
 =?us-ascii?Q?y0VclIB2KISeF1iUtS5VI6JFcvu8DJUWWurvWajSZSm3EqxEM0BmovI5V534?=
 =?us-ascii?Q?vJSCH/V7f2drln9w39JqTyU8iuydPBofJP1fkn8+pN5c/H/OW+M2egnqkIgp?=
 =?us-ascii?Q?5+beeSi7B7oSoz7vowOFRqMskAcS6ZGJFH9hu0jeGr1HQqe2MT6Uba5dle7/?=
 =?us-ascii?Q?8bGvjRSc3k8Vd8MvIWSqrvJo76aoMlyHpJmABTvyRzGgXTI2VemygO47Qf5K?=
 =?us-ascii?Q?S1X4edsaTojAk3R8xa5zntWdWSWoGpJN67NXIzJvNg3nTcGMHjQ8mZaReiAA?=
 =?us-ascii?Q?xLKIQfndbenJ6hU2Tx5fP6Nd8kIUVUKz7msRCgg5yh4xgciEOPWgrTEpt1+d?=
 =?us-ascii?Q?D08himhAcp4LkSNwSD25enTsZC0F9raNJArlrYZ/GHr/RVi/vqrnpMo7BPlc?=
 =?us-ascii?Q?rAXmGPVLH9J8RBBQJWyYygn34OPrc/NPsGo0pzk/zNzg1nKjqRoJO79OJQ2a?=
 =?us-ascii?Q?BgZrBibZX8qDQnzYeeuap+eIH/OjXvvietkwi6F1gixGNKMmohBCaxSg3+ez?=
 =?us-ascii?Q?nTIpFVqI4MC9IaoXXLwi9792AzprC2urJMdSMjr6i9J/NtcLbTD7k0GP5+4D?=
 =?us-ascii?Q?HTJfzqVRzoQOAUbYd/65XkIqQrbSx2OFHH6aj7F3I6RpFAjNXM+U1OHZ7oL+?=
 =?us-ascii?Q?IskbqI48TUal+ISxSeIHoE17UdhPmE+TB1is0GEukV5OdMEzBsmo4ZJKRU02?=
 =?us-ascii?Q?XrIYg4iwwICcOyZEIfbvpgioEMlNQ+4+t6G/hM6eOyvghI32k7TH7F9LXVxy?=
 =?us-ascii?Q?LUKNaKh+w9iornQpHqsvNGImL788EYoZdx4dTtWbtctZ5uYzgxoBD2ZweBcg?=
 =?us-ascii?Q?Qk5D+LAdYVIxyBFYcNV56T7szZkEd+fS2rsYtCZNQuisc/FwnqmkGMz+CpPR?=
 =?us-ascii?Q?xrx9wI+HcSyKSGgiCywcvbfTDrWobuqCp9Dvww2sx2il7fU571MVST3TQZEF?=
 =?us-ascii?Q?PH433DRlKnqj9t36Loq9jqTTBVMO3OciXuas/nBAFhb2Ki5nWvcDuEn+swxK?=
 =?us-ascii?Q?mWMWEu4y5q7EtY8J8OidCirCWjybKqmImzply9PySTqHWw5TAjhppAOi0fmv?=
 =?us-ascii?Q?UA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ohz9pXRvIDgQ/h2kYKInIRm4qGjUK4qtzI9auTiy2mHsCtZO7313TxOU0L535V4j34L3ngHchCh7d0ZwbKkeW+1bsOj7alqQ7k97JnZKoewBLhXoSVzbz4uV/1uRAaacVAEBBMNlse+Ic/as6LkYlPrg/igAhxg+sP1OIFIE3ibQA3dDmn41HjkHVNqfnbbm2G6rXI3wok7jdfLjMc6xRONuZLJjaDai2AR+pRDjkx01VtbNLmx5a94+EufcG/swx89DwF1dUNB5N7svP3b9EssiOYWEQr7qfgBZMp/g9QxcwdgzO3E6de5mAUCnl5l4VJalm6H2OkDkHVTQrya4jfiH1Z9oOMadNpnsNENLmu4rRjZx5qAHwJIJ2EsPsI+rMbXtKQbteT77w4pSneEs2NYMujR61COwsdE5ZBpKZoc0tVTgDuiCdDECIu7vkFEJdHT6LWFo+JLGL4RFWIYSdPzgm/Uk8uZiwl59RuZTDbr2BVB+XLwrFIdbn4WO2zaJ3LufROXfUKhSjcWgc60OJzkSQcLd2MJYz+Dd0wbdOKxL8ahj0nWxk/xO2h1pgV+939jXZYzpgOe2IMjcGQPxOMbqnxDjIkIOdcr/eXHNMLDJVEgypEOyL8a+AuKfzq4PXNJHrqCV1pSvyhZOLuL6EAwRqWCsweLjjGUX7r2kCVB28mzsG0urW0sQz0CoqanloaCjahwQhagQMDAMSrq0KSpiq+1DTZZGHMXeEzVZAj6PEW0cjp3vmu789ZG2Uf85NMVYftZM2FekUGbmgwgggPRQzNoHPcnxXygigU/9aQLZIMUJHYFuFFVCo66xptoAsxNNsWFFGFpoqYGqeEGr3FGlbsEn7IGDsYW3KNgpQPpZ43c1mgKocAPRRSrCoiH5DBxwQaW0asED7Y8xbkoJxw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 062dace2-01ee-425f-6682-08daf9ada3a3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 23:42:19.8458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XtmiQtocljRbTi2YK6em0aeWKkWzwuZaKN6DuXaMpa5UzRTNZ0kEYlkXEz8jBONDe0EB06Oo6wbaci7TYmV/74NU93be+pC1Ui0HGOHAJo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5821
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 mlxlogscore=740 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301180196
X-Proofpoint-GUID: 9xghnK0O7CfCCZWSVHtoDxbdPZczBWzx
X-Proofpoint-ORIG-GUID: 9xghnK0O7CfCCZWSVHtoDxbdPZczBWzx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fabio,

> Therefore, a mere replacement of the old API with the new one is all
> it is required (i.e., there is no need to explicitly add any calls to
> pagefault_disable() and/or preempt_disable()).

Applied to 6.3/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
