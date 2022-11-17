Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6567062E3E3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:13:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239454AbiKQSNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240446AbiKQSNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:13:24 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464E786A49;
        Thu, 17 Nov 2022 10:12:56 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHGD4Ux011625;
        Thu, 17 Nov 2022 18:12:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=wEx4ul3TTmRBZm82nPOyTciNck4NP8ZHEl4FWMSJrfc=;
 b=Ug9Kb6icWnlP6RAJPXpgMgVD30LzjmAHrExkoXdEk/Ej7zDBIvqhMSJ9V3XBx3kDpoiV
 jr848mP67BAwdf/xKTZREiOy2TWwZhjSB+7rCBjjxZxXPNrJi4168+b12I+ZBpoOPhy1
 TovtUWO7afF0IHS7j6fqALtCLCyGlP1i4bUYr2rWUEVGlRup1S+dWRF9e/IVo5qiH6G4
 tPD+e6U/M5K5FZ77SdeQy3bmc6eCLnLbWSSHKPBpxQcW+Sr2bDEl1AMkT2/YJUk7TNvI
 fl9ukrARJBeW/M2sDj8uHmKoJ5ppzSqOGZjAnNTRcDi8bqf9rwD7eD3bxzSi2E5jjzhe Qg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kv3he1hsp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 18:12:51 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AHHGJjY028842;
        Thu, 17 Nov 2022 18:12:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kuk209sb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 18:12:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAfyuq+P46BlAd3yKZ4rDNfr7n6jTQP0RUkNw6D9UbyY3+R+KRhiK8aMjJJv1PDB049l8+ve0jBoRiAevgnFgoNK4nr855W2MaEMvg+EOA7Vf0HQYcEtBqOZTN3YoWmCZPI92ipukdQNZEyM1aUL0cYbxwOKKpdRYnbX0+QIIX9n6uHDbaBZ/sVBNcimUFTAszhreT5vpwtVVOYT52NHdsBhE6hr1nXWYELCBbeRl20YlCyg3GJ3JZO2MFqIM5JiExBC5Pg/PLReEHdg44XcMKmzyGDS84lrj5CB11BY0e7MmQOmxAO8FM1qd3VAzyTSW4Y8lVWLEzMhdh5tHxPaPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEx4ul3TTmRBZm82nPOyTciNck4NP8ZHEl4FWMSJrfc=;
 b=A+fx1kryzpZmfqS9t9I6t7zEwE3v36OkC1asbrxIyYww3/7dGZ9d8UpJIKCRDzKMano3a+ob3bxm8h9pho7yE5lEPQ4WSuEWvzQtvx/1bubX4HI+oTDYIB7qkkUPzgG9FJdVoct9MjsaWz4kWhKSBc+7qRO8OpTwAQYBRbAmsCE9/a1UB9VpaJP1PB+ttrR4h/uQMF6tEEUFv+HyT060riBunTlngxqs4g88hKVb8v/vv6Dt3G3ux98l1Y6MeqhTv/ofK+45jBLvuev/nWOm1UabcN8YOidowxX6Br7w3txtwrULjV4OrgdhTUz/KRjopNh8ENA6pkujveo+Ur/uYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEx4ul3TTmRBZm82nPOyTciNck4NP8ZHEl4FWMSJrfc=;
 b=DY03hExyte1mTuGq5He/6KlbaUMY9XdgRQMG9xhRozjEMFjmt2v9Kje715MmFThtgzXet5na6BCZpNC+NucedOsY+xlDNAtHr4t03j5f2/JtTb5Kt4q7kz+CuKMxEI2vh7I69Ni9DGEoc+TT+BQKYnxMS1Or4hhBamUbugo4CQM=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH0PR10MB5052.namprd10.prod.outlook.com (2603:10b6:610:de::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.20; Thu, 17 Nov
 2022 18:12:48 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b32e:78d8:ef63:470a]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b32e:78d8:ef63:470a%9]) with mapi id 15.20.5813.020; Thu, 17 Nov 2022
 18:12:48 +0000
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc:     error27@gmail.com, harshit.m.mogalapalli@gmail.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: scsi_debug: Fix a warning in resp_write_scat()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq14juxxxew.fsf@ca-mkp.ca.oracle.com>
References: <20221111100526.1790533-1-harshit.m.mogalapalli@oracle.com>
Date:   Thu, 17 Nov 2022 13:12:46 -0500
In-Reply-To: <20221111100526.1790533-1-harshit.m.mogalapalli@oracle.com>
        (Harshit Mogalapalli's message of "Fri, 11 Nov 2022 02:05:25 -0800")
Content-Type: text/plain
X-ClientProxiedBy: SN7P222CA0015.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::29) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH0PR10MB5052:EE_
X-MS-Office365-Filtering-Correlation-Id: 40486226-b2d3-47c9-bbbc-08dac8c75525
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NzpPbDEdCnrl0yZ+JaieQFy3ZmROSj+JxNnHutIFaWIhWn7M/0/VzS1kVCduoyQszFEtxyUXCgKNnI8y8Us9kEyhZb03QS3LI9VAuRiKQ2XZowxKqYnCscxd3eAqvzcRoNbZlG52DbqWhv7j/NAs2JVae4pFyLLBAsEjMLWuBGoBKpcAIq3nt/HdIz1B/djna5wT6JsaMrMvTIpMMjgeOOPK/Xt/9gyZ/eVLLOxgwMu4shd75uTe15LqVjqYXlRvwVXX4V2JP1YWvuAGYUciq6s9SmaCMJ8SO0jtWbQ9RYRHZ5Z4pYHGumRFKXlPQovrhhcIvEgz3+t5SLA2mxHpJiP2QSWnH/CFEtEYxh6k0X9z0mjYlg6Uy8HHYc548Me1V+hkUUCcHGnUDcy6sX5ktk6O6ahbr5ZyswaCSC6pJncTuVaKA/nGaMAYm4tr1BRB6i2GGd0Dd43veMLlCNz0VTgf76hPrvMEtN0fUGL3LZ68Y9fUKKwHpStuN7t0Q+bOqB7Q/RKIrj5PhN24idQ49hP9QdYT0LwKxhnoCOKgtcJvMlYr3f4WyUWfn0iTYQCkzarKiJDHgKAcSyTCVlXZKm2Yhx8q2dVWo+UXHkqxbAgcFvPWc3WwnP5ovxjDkf8aQ+XvAc7aVsdTjLWn2oxmNQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199015)(186003)(5660300002)(6506007)(54906003)(316002)(6636002)(41300700001)(6862004)(26005)(6512007)(66476007)(4326008)(8936002)(66556008)(8676002)(66946007)(38100700002)(2906002)(83380400001)(558084003)(86362001)(36916002)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SOrMWCimWCs9bTOKl3XHdTHdVf3NCHqXH+cAHjH31brFNJhVSUJlz0iIvuP/?=
 =?us-ascii?Q?3Omqcem2mLQe4XYQDnEPsaIDRSDDjTi9Iub0XGIONWLewqFCxDT5LEERzVjE?=
 =?us-ascii?Q?9X6zHyBX87NXzPhc8KVhWPCoiWE4LKhmXp8xl7Ue/sQj2K7NW8ZgPyabg5Wt?=
 =?us-ascii?Q?XdSeRZW3kxos9B+AH1Qvd4eWIWE84WtZ8SotMl01ELKYMED7it9rs6WygGes?=
 =?us-ascii?Q?DuH6OFNPwE9qHFTNeVdEpsrXRMm1VdUqQSG6h3l3TrnLNFM3GtHmjRoIIIjP?=
 =?us-ascii?Q?085m3FZxvgbP3IjIQPrQtkQyQ/iGE2Vu4B/8mKwQAJHIAO2TfTTOC8Ni0csQ?=
 =?us-ascii?Q?2qAHk5zs+b3SxYw+7v6yrtq51kpEPzBmiGpwEWsbX/A6clD1B0//2c5ieZ02?=
 =?us-ascii?Q?sZY6sfLe0fBLqRwAY8xdzy/+f8Oatxzgkw0Uzmiv0P29woEcnXNyccAXialz?=
 =?us-ascii?Q?QmJz1XeSN0nG0poWfYk6gXpRICQ5ElARwNLp8pRL02HHVE8/ILJjrXz16Emv?=
 =?us-ascii?Q?Do8XtM6r/VO18YsTFs+BoHZ03XDrqI7j5CyoyPfGo4+3urkShgjfDkkS6nxR?=
 =?us-ascii?Q?4hYA4pseDj1R1k9+Xmit6f1lBw4/X3s+4/DTRH3h/CkZ/isKA8xeMgHxew5q?=
 =?us-ascii?Q?9i/qtJ5H6A3TR6NamXbrLHD9XUd9YUUX5eMCwTupy2yYG28bKF1mOTie/un3?=
 =?us-ascii?Q?6WKx/lYlVphO08nOSIx7ioWEIGdxuNdOBUh7lK2a0Td8xAnikicvduVry/1f?=
 =?us-ascii?Q?FmGI9SHRScbMyWOJ3uEfoOpnvYnKo2FzB8yl0oqBThE2brMc5quBbn7dJhsy?=
 =?us-ascii?Q?TSHrW9hAFr62ANPhqshDDv5pq35Eqili8jpv54/Ogt+ZEGDiwqvSS1g/jKGX?=
 =?us-ascii?Q?NpMiJwUwI0+nU5D2HqdeUVkqXq2eN3hTyas47yRh9s1V8pUckPF0AkvPHMFN?=
 =?us-ascii?Q?gjcMvY+1mBEPy41bFYBcmp9CugEBQYYpCXiDYtrJJom6XirzHXSDZRpKv5zd?=
 =?us-ascii?Q?9FyyTx5Rw8iRZ73SJVLBiFp6SBTPtelxXywGnTEtO8Iw86LukV6DnWuTHciJ?=
 =?us-ascii?Q?Zgiz0ADHK5kgZDsryaOuKNDbHSwc5WHCnfe3w9l77zE8dNY0EDXDW+NBEYsu?=
 =?us-ascii?Q?jW+pSx82vqYRxXPk/eH2NcyLszZrdak16F7NYah40kNQmdJwIzS1Gy5xkvJs?=
 =?us-ascii?Q?dt2Mwr1P3nbjx6bSOHg5XoOJkXw+noEIjqjflkqwo52tR5BJqd+ob46Pv++/?=
 =?us-ascii?Q?r7QOrnnYNDn4PpoZkA9SjwQQZobl4D3T8i4f6Y348q/cgNZQC8rz8BdGK10y?=
 =?us-ascii?Q?5Pw0o0R5kPY5JgJcPzhKaAE2RGnGJK6Ey6NSqo92xd2Q2ieN11PnSkL5bFTN?=
 =?us-ascii?Q?AUnmGaOVYaHRJdL4/dBhrVCRvSTVh4UdGIm2Y/WD0vUOG1ppDRiTn5NNmWV+?=
 =?us-ascii?Q?U/8FKO6GdVTVy1kHJeBiYtStCkbHCKMjLarbTwVToQFXuF83XXSxolq1HaLK?=
 =?us-ascii?Q?48QN4RCv1GMbRcDdxcnTD2JRxM31zqk6ohHN3X+NPdEOlJKnN+cnoFANBoIu?=
 =?us-ascii?Q?VM3GbuZTM4D2gVLRLYY6SJ/uFa909AkFG4AjdIKbOSEx8TBDpUnxfsaaw/h2?=
 =?us-ascii?Q?Wg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?63joivZ1ovpiTYWPMiV63duyp464Qay2LVqLJ5EGtzrphTIesJ9Jt9ExHHV1?=
 =?us-ascii?Q?XuSm1fQPdl2q6rHgxaQdFlCnhjclUizZ58j3UlTkbIQCyiAtPvWeb6i0RcRA?=
 =?us-ascii?Q?PUz0jq9+9hk0mqJuv6bY1zwOb1Sls8G+71Wr2Op1+dOtC/R++FTywXlmIX0z?=
 =?us-ascii?Q?B+kqjiLqZvS7ceLUn11WYPHj4cgZPjhEZhvLtmPBfYnC52KjZAiUJLYcnEei?=
 =?us-ascii?Q?M9qbagGM+XIlq58M2EMl/c9XGur3XR1kcUdfjhMSneG7b67ICGSzG9/uInl1?=
 =?us-ascii?Q?vs7dlc4fCkp+HpROJ3i5naJ+H8vfOgvLNZpf52wZN8TfYP0UQ/B2iORDSfy8?=
 =?us-ascii?Q?qWUZmwBgiOGO1sLIjCyglir9zga4dDeXEcoCYP7mRNtpm/ZqHK9pFMU++9RV?=
 =?us-ascii?Q?M/Zioj91IpqbGDD06swZU64SuwHaX+UzIikgBKevizZNc85I9iH4asjpTGmS?=
 =?us-ascii?Q?40XAHYovdDRioUzyO5QJrRxeX5GGYdPown769FShUHmhXDOkmCgDr4WGEYch?=
 =?us-ascii?Q?Sw3FSKzmjaaVP9s2N8Ou6o2jobr2N5WAPbr5UpCb4vIdCyavtPEbQxcz2/Rf?=
 =?us-ascii?Q?UY6kd7CfmSfxfYuLlK2nYbusyqgZ5BjMBNckaJLXmnT9cYdE3Pyn9LFCv4ab?=
 =?us-ascii?Q?/oRtfXafJ9JABsm84RLlFVHd7HdI9M2FAFdFNhgxSrg7eQFoR02FF/rwmqTi?=
 =?us-ascii?Q?3x/IzzjE+/tgv1A9VMjIShHUUZSpZzVuE/FAvOyqyPxir7/H9v4b6A23ygvv?=
 =?us-ascii?Q?KI9lIlwKu1CTqB6lni5lGFfMgPUFjAFf9oWm7R0xmt/+4697gHDJ1goxni/4?=
 =?us-ascii?Q?FcAAheQKfOdoPseEVV64A9lGdj5j0rH4H8CsB+CCsZkYYGutHDMwg3X6xF99?=
 =?us-ascii?Q?0osewZSjVNSlX1e5TYBuYjaeVHa0CEfYhtfPcdeHb9mWCDlHveT+HlKQhyWY?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40486226-b2d3-47c9-bbbc-08dac8c75525
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 18:12:48.5021
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CgtfXOYDnuWMei2oSpcm6zvgHh89Is6ZzpgYc/Y9699ZFKJSossHTQr7aMXArqNBZaNuK6xZVt2jLTVcVMAgLldypCudRvICy0p+orfGiLk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5052
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxlogscore=861 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211170131
X-Proofpoint-ORIG-GUID: 2RaL_rDprBBOOeLLP08mTgK_qlJhxR9Z
X-Proofpoint-GUID: 2RaL_rDprBBOOeLLP08mTgK_qlJhxR9Z
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Harshit,

> As 'lbdof_blen' is coming from user, if the size in kzalloc() is >=
> MAX_ORDER then we hit a warning.

Applied to 6.2/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
