Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0F572744B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 03:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbjFHB2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 21:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjFHB2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 21:28:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA8A269F;
        Wed,  7 Jun 2023 18:28:36 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 357LbFlb005557;
        Thu, 8 Jun 2023 01:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=2x39+Dx3ppHdCs7ROW7vsgiF+76LvpZiWy5EzL1TJf0=;
 b=rtBto9sl/uZdhqetK/quyA4v/QzPzn0+QFuxuivTa8+ulNc53j2b7EW8gTeKyxa4BlVz
 7dhuD5RYegbBXH1fgfnhR6uLNdKqWQKEHjBKW9WZfiIn3Io3QjzQkH/HAYs7rmYfY9DS
 BFZzHta+ShB/Okpu++z7cC+/lGn8yl09bF6T8FvMrso43Hh/7qPD9NeN51PjpFRTIbfI
 oIG+rEkDHxgDTTbzVDOBlsIEyYuKxBcEUzDzEw3yX9+9M9nTxXlqRpZHXPLhV6vwi2wb
 6srK4eZ+34iRrMNwejZXtR2DnJ6cU8pBbiO0NuFraxyY45wK70kmZaov1pupP5gf0jJS bA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6sk74d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 01:28:31 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 357NTkfY002971;
        Thu, 8 Jun 2023 01:28:29 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6m04u8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 01:28:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3Tt7ie9yRtXCI19Hc1pGPnlCEELcbOmc84024pbCgocAPQaWPO89cOcxFRaaChWMad688NzhagDrmDWEN3MBp0LXyRIrxwYuHWwGkG3+Sa0l1rJ89YreZ7x4GQtkFgGtK6XVh9IETIZ8KxoNqbOLP0in9OBNfmCbHfiKugHvuODXHu1Zgh6tWcHLDC75HS39PZBFF4GpqhAaTFkxKwgUXV5Udx6cV1w3u7DjyMNK+uMwAbT+YfE50Hsy4Zt2U/2juFuK+3/gET6xDIeLN8YRArTtzKOxz/sUQECx7wo6Sj74eH0rBCn0o0EnWSW4qVRXjR7+2ENEte5KeXyXxjxmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2x39+Dx3ppHdCs7ROW7vsgiF+76LvpZiWy5EzL1TJf0=;
 b=WuFmPEZxjE8W7kkRuEQtBCMZnjcWVnU91wDnpzeZhfp4svHElX2eL3ktC2NvlJstFVSLk/e1VL0FNRxL/CWeGk45a/VxLBWsvxO6m8GcOO7qHZv3kJxPFFOI4IxxiHXQoIZbOkckb84buHgnr0TK/aK7M6sTixS8Ds3vyc2iRyOx8mSxzs9R1parPW5G4LK8Pjwq6di+/8LpLjfILDZWtrXHy2HL0wp4xNSkvRDCDw9TJwcAssp28RElId4dbSXo1/SHsbnCTUctGEBNcP3rQp9fwmIR/jKR7H5eGd1hrrelh5MSWvkh/htxXXu9zkDTTaXJ4hAfOQkGHqZnYdAT7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2x39+Dx3ppHdCs7ROW7vsgiF+76LvpZiWy5EzL1TJf0=;
 b=L0BBwh83D+g5kGZZJ5aWLE669TjmqJB11Z3ENZu/iSIjWT3s/n2Ke7syX+cp2WJNasQY2kdZKx7FKwFoXC5pnirIqcl73K1XojatZwuvkjGF5M4EG8z/tnQFFY0yeo+voJIcxB6Ab3IpT0FSF+pVvSo6wrHQm9KLEAjQhXwKfuA=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SN7PR10MB6364.namprd10.prod.outlook.com (2603:10b6:806:26c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Thu, 8 Jun
 2023 01:28:20 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::b77c:5f48:7b34:39c0%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 01:28:20 +0000
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Nilesh Javali <njavali@marvell.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        GR-QLogic-Storage-Upstream@marvell.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [RESEND][PATCH][next] Replace one-element array with
 DECLARE_FLEX_ARRAY() helper
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1pm663fq1.fsf@ca-mkp.ca.oracle.com>
References: <ZH+/rZ1R1cBjIxjS@work>
Date:   Wed, 07 Jun 2023 21:28:18 -0400
In-Reply-To: <ZH+/rZ1R1cBjIxjS@work> (Gustavo A. R. Silva's message of "Tue, 6
        Jun 2023 17:22:21 -0600")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR13CA0070.namprd13.prod.outlook.com
 (2603:10b6:5:134::47) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SN7PR10MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: c2d41935-d01c-4779-1810-08db67bfa4cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NgSktvItL4e0vs4oFLB/+lclYQX061isf40pGk3Pi1DOG81b9FGDp6cG3lQDHENFDErdFgqe1R7DQmiOAA8kHFbv5UVxHlS5pWEOp9K6zuH7BTh6mTJF3vvyofQqucBpm7gUwevEqG6UlNB8ObIbjsCixr5598av9uMtP1R5XZWyhUrVTrT1nACjcH60KeX4NWYLlW+ZCQozBP4s0WUZJLxLzGz8cBzPRw7zwhNB3My1RCJxTIvDJt2fxGc5UCVV3uc2pYOeYpjEzEeB6OcCX/y0RvADZ5M5BmoUNgZDgRDE3vCErIi+RxqO7xZP39Vda/hXeaCX7wWDSVXrHLi9ewy3U9sYZVgR33iYxr3ZGSu04eKKu2roM5fugDzfD4GMNoJI0lu3HS6bm0FTikxBuPQRSO+vl3wMXhitiTYWEHqhOBGNKujHp4ygVCzjjy076UymlJJIiBKu6dR4tYlGldMgAUDTBuIcuXJU6fVfojJzyLJA6m8YFLg45mFJEGVyEI/Jzf7jq1Bw5O/WVV9fb3DgbGSBIe85lBNt1DmbFfFGkvwe02qDC3GnXIpOzQyb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(346002)(376002)(39860400002)(451199021)(8676002)(8936002)(54906003)(478600001)(41300700001)(5660300002)(316002)(6486002)(36916002)(26005)(6916009)(186003)(4326008)(66476007)(66556008)(66946007)(6512007)(6506007)(83380400001)(2906002)(4744005)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BLY80zoitEP0AzSoN4Pfjx/QTFgqf5xVOQJ+DUSi0nV75/IClQPohTWEOeV6?=
 =?us-ascii?Q?RQFg22CIvuIyYk2AgvWLNQzNlrVvk9vc+t85qEXGukCque0E5kLjcqISemMw?=
 =?us-ascii?Q?S/E3+wydNu+YPdeKGoWpfs6nU99pQvNVMenof6Tn0/GuNqMCkgiJb4Dut6T5?=
 =?us-ascii?Q?QKNWuIdvhkbcKDjeEnrs6wI3fkuVoLJG0k4h1q0SCpDXsT80zP3cx/c37FPe?=
 =?us-ascii?Q?+YPF0YgJNxScKIlQBFjfEm2gTR5yUyxPZrHjPkF73U0X4YCLGGVsvzuisVG/?=
 =?us-ascii?Q?uXYoujowwL7KzduWpxDL3tCHZFtq9UWVZJnule7toHQZKNbzPtJNQKcqQ2tz?=
 =?us-ascii?Q?mKMFMTMjTWhn5ul3zZFZ+lmdwiEX1J3TKUUcgERjADiYMn0+bRXlxE9tbdwy?=
 =?us-ascii?Q?5Y+tjNDIpm3kgGYX9xsET/2WDEqubJx/aR38R2pcbt1KU/RTUXbcr0E7Q2Ax?=
 =?us-ascii?Q?1UGiQyhNTKBl1R+m7hOYZoM812HwdSCNob7uocWAncG3hZ9uybV3/XbGd5Ha?=
 =?us-ascii?Q?9U5TpMxLEN82Efzv3DnrQoQg8VKT3Y/+IqtuN/3oGXB0huA/ymoucHx8WB/t?=
 =?us-ascii?Q?tJRmRSa4iEs+dhwiMiP9QdCQbxw7KXm/3IpUrH3WPxF8j4EMVo+gUi2JhiRp?=
 =?us-ascii?Q?R1D+gTq+CkbCwOumupprnAbUoMP8lCltWWUJcTebXx+IbK2p+5NasEbvSmGb?=
 =?us-ascii?Q?PxqOfr/CDWJG5csvrP1kDFFb8XD4KlpKGOmE5OZvhGu9QNLH+ZnrOuzjI4xu?=
 =?us-ascii?Q?G9UH9tJjn4O333BLdufcLUR13tRG7+qgxXzYtVXzMndYNchaiijZ136tVGj+?=
 =?us-ascii?Q?uXsJYP1Z3nxRyrsefHULy2A73MSVQFNdtGpQgFxNM1xpS8bQ1ARbhopRkVwF?=
 =?us-ascii?Q?0FSRbDz6Xc46OR89dSqfQGr2QbXTMnGONsWouOhVAvnowo6z292L9lgen2+G?=
 =?us-ascii?Q?Tn+wUDQyp4JlLEaVwcRBA1mnONQescCT/FUqYGDgHSD61I03nipuE3wlyeWM?=
 =?us-ascii?Q?5OikXZ55S01IvFMuL+lIchMmVDrTZ0yAz8D4TrZsNWorHmisVeGcZ7eqiwEr?=
 =?us-ascii?Q?I7LU+KVN48RporAJMn4SzqnmxLLQdpp/EW+Y3j2zBroWQ03YMoOnacbfaXSF?=
 =?us-ascii?Q?mAmS4ewdcWOF/PQn+Y/at7nfJOMmxrbBp0f52/SjEE++Glp4kzEMPtibTrlX?=
 =?us-ascii?Q?hBqZe2vyOI2Wy7md7SsRq1PuuMM7mjvO4DIsTEk0IMkIILdFLXARQyQIzJ9M?=
 =?us-ascii?Q?dDoa4474UISaBfpXMl9Sq4LquCFV5fNxLX+t7Hbq2gQL/hjbAZy9yZh2wA64?=
 =?us-ascii?Q?3f7RGNix8dPv305EJk6gTC99vkYGbBL624NwPTiklM29/6YudfRlRbDmH5iZ?=
 =?us-ascii?Q?++1y84VAQSC9YT9jIXMd1/CUln83oOQYBq6g1krIQHXUVRF0yJFQeOK5VIEx?=
 =?us-ascii?Q?Vl+le3s/ypax8SQSo9mcQ3uFM0OHKsDzJoC0fpT5RRyZJxtIT2ILAoNB6lVY?=
 =?us-ascii?Q?fj9Vq64vmwXFeCxUHHc/Zh0gRyTKUR26EoHWglpyuhIdyIsqEOGDVN/Tbz7z?=
 =?us-ascii?Q?RjOqzllvpohnLKPftNqUUZkXaoqyKDNdGT4jqXVpxOq7rumFJ6jC1riVEQ5u?=
 =?us-ascii?Q?NA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: i7Pvo6dnECLRYF4KrIU+SvBeuMbJedlbM9TcOfGQhqFde1xirZ3te82sIaR1FLkY6rnQ9PxnmKjfJUMo+TTA1EUjxNTF8MxreLXI8HYCZ+0d0EI5sGkva6rfLOqcs2yQurq0Utng9DqVDeA6rUx1tEyYbgTsnxohHe5IBKMG24ltlqgKdEFf7ZDu5/sgU6IEho7V7XOgCwWc9pVFcgzjWxxutF9T0ERRSel8CdyozsHA/q0Xm1kUWRpyqw3OAuRXNeK+DjR3T2F8bv0RTjERW7JvJRdyh34lZ8QmL4qsCWezGDtVzinc7OAzee5mybRUJWDk1gnweIqf/ssLKjiUDtHJHx7iE7E5v35KxGMNU1TaZPrbpzo2azEoKwXUpUAEBlHu0W/7gQ6JpdvXgf1eeIIvDC96n3Ojoe1pFf64ThF7FiXm7Zh7b6YwTPAVN6Narsua82iLGnqKB8TmZz1u+T/T6ili9ErPuj6PWXrTvoOw4NC/1k0XJqI1992zxphO0OTdS6zxttuBSmDt20Gb1H8Jgt82Ug5/zLApv6XdodxSGA+sNp6AXLNXMUS/8aPgDXtN11XiD1+a/Gwp+Ff1qz/EtUZcv3uQ4f9yh6ktXT8UynD5FGiI0WpOCK2FrIN6ysvBeFNN8ScXIKSa81N06nHmEM/KbdaGI2T2q2/uDc7EJRYomz9FJDWfE37BAxYqq+nz3xaa787pBTlbsXAFzNJcSs4ihj9oSLERBzazL9aGMTVISqCiusr6FyP+unqoOtAv9yPEi9/GC3LhtS36ceKUegyO/BtJgbLTm+X7bApmwkvytFAvxZXsrSOaJVNi+iJNRePLCti8mg7te/6HuN0iuq7i5xbUP9b5QRw9yeI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d41935-d01c-4779-1810-08db67bfa4cc
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 01:28:20.5270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bjfpth3i7JihBVa7mSZD5f3eH4Fi+Edwh29LRqCvtyv8m3mRElJ3t2z/opDgn5Am/blgFA63qp44yeFOzFncG0KuDDhLrfkUzco1upv3j0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6364
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-07_13,2023-06-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=998 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306080009
X-Proofpoint-GUID: oiqjUnVbCktUUR7sS2Ix8EHB3De2VE6g
X-Proofpoint-ORIG-GUID: oiqjUnVbCktUUR7sS2Ix8EHB3De2VE6g
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Gustavo,

> One-element arrays as fake flex arrays are deprecated and we are
> moving towards adopting C99 flexible-array members, instead. So,
> replace one-element array declaration in struct ct_sns_gpnft_rsp,
> which is ultimately being used inside a union:

Applied to 6.5/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
