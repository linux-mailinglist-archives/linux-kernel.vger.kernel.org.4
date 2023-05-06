Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE3EE6F94CA
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 00:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjEFWpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 18:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEFWph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 18:45:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3C6900F;
        Sat,  6 May 2023 15:45:37 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 346MQ6UU018160;
        Sat, 6 May 2023 22:45:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=uB4IeuIoDAQqkGE4qd/g6Iuu+1Yl0t+usZOjpiIY+38=;
 b=j+dE8XzJ/X8KGsySt1fvoCjOOfVsFOgri8uzCSzhshk3cVF78I1mMC0VpaT7qYSOAHgj
 A9I6A/akWSGoRooK9ve94wE1Ly+18rt1phDtUgZQcRvFOwnuchAzC9XWwr8irIRLINPP
 c5O5/X/UqypXTZbf95A7ovLs198nnFELkHYGBxrfQGDGC4j1SJA8XFNFYLeEqnx4sDTc
 uchyp0Jap1YPc9/0F7bSfTmUdPnBOEpppxifFCV68o0RjSu3K8KbR98Ae+/o0LS5aSeB
 q7v7+hWyG5/1Wtg5N86pERFAcjdFibUakRNDKtWZABmGb4T+RCk4Zwk43uPk7+brCll4 HQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qddg210bk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 06 May 2023 22:45:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 346KmbsR023937;
        Sat, 6 May 2023 22:45:27 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qddb3bbdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 06 May 2023 22:45:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exerIpeweruYBqwX+aqbv+fdkRqwtBLG2J3hanLAAJm3gdlQgFRdK3xcjaHn+IXX0R/Yz4IsgkM59FgIYsmeWn3AYAq24ZnyWAARlLOHo/AxftdpnLN6RpHcdXdtFbTRbiL465A1xTh18dRbPIXbeIWox2QjjXelKK1/7kXS8wfJcM3W/85kKsR8b6HjD/nNbagMEnfnSDzHzmQUuPiV9Uzsm0SMkzcFf8PwEht84Adv/jReyXlK8W8SXL7I7td5cf7BcEXLCYB7Qw0wNS0tXN73Sr11N9xLhvLlW+iLjniQrksLiGukhcgJo/oPsV3ZzTKzGTt36d+J7aER7v3Mww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uB4IeuIoDAQqkGE4qd/g6Iuu+1Yl0t+usZOjpiIY+38=;
 b=mM2uo0YXV2YJiu0T3yx+w/HH7xoMtlbUVMT+rluQg3E44Hz+tjDJQkDGmQQ83Iw3A40Pd7NybfYCnUNCWjTF98zmcR+4w620WsOXFfeAbeg/a9TmdJ8FiOdTsDJel1UCbrRfQ8hSSI4Ji+8vjFdceNJ1EPyTDOpKougJlqVAptbUXU5SGBSLGyy1WFUFvgmafQZPP/n/gATogX/leAPymLFodsVtYKyhY87mhTsV4GyxA7wGPifOx0ccv9NOnbjia2vIzu3GaJoGmO8GYkv56zhuo8NeKktmki5WIIl1GICyKIkihaSzsaGsF2qc+/cdLdyB/TX7d/f/aSg/rBFXWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uB4IeuIoDAQqkGE4qd/g6Iuu+1Yl0t+usZOjpiIY+38=;
 b=KW37xkMatFNsjyDUk0ZyGNrJvI/hLwqB4lWmwZW5VH3S6MNNZhf1GJgbQa2KYnZsWwqpXjMR+Wksl9D+DR7MgTwBotRgg3sfoVE7pQ0eAuzFgv06LR6ubhM1sbOwOq2Zi9pA64vI3LzEIm0RMBeqciKghtfCaIGLPRghaUJ9Z5g=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM4PR10MB7526.namprd10.prod.outlook.com (2603:10b6:8:17f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Sat, 6 May
 2023 22:45:24 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%7]) with mapi id 15.20.6363.030; Sat, 6 May 2023
 22:45:24 +0000
To:     Jinhong Zhu <jinhongzhu@hust.edu.cn>
Cc:     Saurav Kashyap <skashyap@marvell.com>,
        Javed Hasan <jhasan@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Manish Rangankar <manish.rangankar@cavium.com>,
        Arun Easi <arun.easi@cavium.com>,
        Nilesh Javali <nilesh.javali@cavium.com>,
        Dan Carpenter <error27@gmail.com>,
        Saurav Kashyap <saurav.kashyap@cavium.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scsi: qedf: Fix NULL dereference in error handling
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1fs892i6h.fsf@ca-mkp.ca.oracle.com>
References: <20230502140022.2852-1-jinhongzhu@hust.edu.cn>
Date:   Sat, 06 May 2023 18:45:18 -0400
In-Reply-To: <20230502140022.2852-1-jinhongzhu@hust.edu.cn> (Jinhong Zhu's
        message of "Tue, 2 May 2023 22:00:21 +0800")
Content-Type: text/plain
X-ClientProxiedBy: LO6P265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::7) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DM4PR10MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: 90539f17-81ee-45d1-ad7e-08db4e8394b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fD4weUGNJoYKrBQnwUAdJ3AbSp/t4Dav6WdvUIz9N4viE2+mfFRKvzWUDKax07HiaGV9zFiTj331kBiEvtRmcPJkGGD5Nh+sZvdiQbYfYGQhHF4pvBvi+Dbnb5jGFNBFso+wvSkwC11Kjz8eIV9BLiEdEd/Uzf86z44OKcnG2eNFfwCvApICKDIE2ODDXQgm/NytNSIABx4+4GyVzBQKFLumS5EOt2/ITf+B/6xuZBS6s9WvwPXy8g5rteLy6HC9Ij4rxtoNxcs+SQcxuZMOZo6sSlWf+Yy7c6kgZiMprqxMWelUZSW+MEfzvFujulWF9XHUpu9fwyy/pKg/hGOUmGryAoqNp2zTJfLl/Q1NzeppSAeKvaXPVHCPjDNh1hW9ev7e3h1XmZ+qLdRKXKiVGS7WpNl5tcdpT0ZzxV1kds208M8xsG7uZWWjzyHLY9HJdd/Q70542nfZncvB1SWqztjtq4MB/t6XsctdEzXWJcxysKIShpsLvXMQs2sKStE7IFR7sTZi5y6tSDQ8VSEfaSKTt5IhyNyoB5VBJMcA54ju6JukjUBMta5xHlO3F5Lu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(346002)(376002)(39860400002)(451199021)(41300700001)(4744005)(2906002)(186003)(478600001)(26005)(6666004)(316002)(6512007)(6506007)(54906003)(86362001)(8936002)(8676002)(7416002)(5660300002)(4326008)(38100700002)(6916009)(6486002)(66476007)(66556008)(36916002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mEeFWunrjuakmG6b/MZdvbJ1DukbyvgNOU3UYulWvnQ+QKy4CMNmAeMabDnH?=
 =?us-ascii?Q?ILQ/bAEGwPBusB5H86PrES101+BC0cnlxVdTMovlAnOQ7e5dEgISkq74cGMv?=
 =?us-ascii?Q?g2D6vfHqxuQ9ZcSqh72dbfGRki/WYf9BLnzRhgPOlkq/vNHfBpVSzcozCj2b?=
 =?us-ascii?Q?7ZIkKXlKGtSaMxB+k+O0DUHFeo2EGbzBzhhK5ZmJzG/wxR/IUtGyw2YyQXpk?=
 =?us-ascii?Q?4hOTK0xjoq3Vg0kaKKtNirbSEAoGCvAnEnEQGlVs76QjsniWTJA+R6jLOcSn?=
 =?us-ascii?Q?GTMzjpVvA4nyoa+MaA6ruSIAEPrScKJVse45kJiNNWI2uR02LPWSsduWgSZn?=
 =?us-ascii?Q?9aqyODGSYNN5jcBHuRbHcslF/tuoorD79iQpDziFg4Tit0ubzMDRwUup8jkD?=
 =?us-ascii?Q?eXrsEBojDt1u9f3z3GvCikHwAL83fU9WGnjo1M21dyTbwooplf8eQW/Wrx/G?=
 =?us-ascii?Q?OMi6afws6xrxl/p8hHCbmF9sCadKWXrGy8oW5ZKsqLLD7f/NlxAWDAV++DEL?=
 =?us-ascii?Q?wMtebK05VziGmRrq8PEJAt1PQRlHeG3u7jd1PsWdMEJJ+Ns7QbGxFi2Yeb1j?=
 =?us-ascii?Q?HHSc8A8nMQaZZoJ8idAHJrCl5beyfesuB7rBbnZ5iuZxKQoKGFHRSpDd++WY?=
 =?us-ascii?Q?MhseviYZ1vBEdiUDA6L7iHOmg0wCUOrKU7gwwMFLlcyGgHEfuKNkzC5IY8uz?=
 =?us-ascii?Q?5Zy+G5z4MATH1XURx/CZuDyTSEHTgyhZh9m9E3/m0p6tO77iKm0Ao/SiHK6Y?=
 =?us-ascii?Q?dfSJ/f6ttIMWZzA1BKWOVhjIorQAGV8IENDbQZNJ+cRWKe8EdQS0sMpsMdWo?=
 =?us-ascii?Q?2xNZBSelhlnQPUDhCSWal7cR/9Am79qd5wXU64Q2uB8WCQ1rxcjjG7DP6Fwx?=
 =?us-ascii?Q?VPurritnFA50VuQz8Axb8Cv+5h3wehM6C0RZ68vODu6mpxNUJCiKKi3sm+46?=
 =?us-ascii?Q?0pde4lRfdiUEGrjnak6eikTHfaZ/Kz0VyUxfxoX34qWbKfsnYc2mz4s2NvN5?=
 =?us-ascii?Q?T8x3EfuiZlvp4KsmVcgbCtLsqP8RtJbs5BcHPDrlCSVG3JDYAtc69uuVz+Ta?=
 =?us-ascii?Q?9EbQ48E94OU19lFTR+QOgFbN1doRsJXxFzH8otDjyHRSF1atEl6cK70z91u1?=
 =?us-ascii?Q?sBlPDiG8CjP0lkWiKknvgO6WJpKl1NTNz6T1j6C+XQn7WRnkWE0LA83ygWbn?=
 =?us-ascii?Q?v3Tw6OgKBQNVcKEH4fPxW6c336TUYJwnbY+0+JC7kc5HBcn2jjubDPP6Sg3u?=
 =?us-ascii?Q?ZzX+msgj9BFG9yxgq3oCixKV64s6+6pfB5D9zvGvr6BDGpJPfD9jx74Eq6h5?=
 =?us-ascii?Q?b6PZ566rFXSEXEBgl9+/D1Qz1wEB0tlcje4delL0vKpHXPoS1ZVErWdytapf?=
 =?us-ascii?Q?mZRLzC9ainyn9elHuRnQ5yhBeMHRToiwoCb4gbA4kSs8qAPrgjST+sv/21zG?=
 =?us-ascii?Q?shLHYGsfiYc1hxw/kbKvw2LzG1b1sYPoinFIspTW3ckF2RoxpvvGPKDnvKJY?=
 =?us-ascii?Q?oJrvzcn1CQa8OXsYkM1lD2sqKy4v0Crh0Z8S2TzEzOYt4Z7ZaSBFBlzKgaGp?=
 =?us-ascii?Q?TyZa1CFqf2X4c5xW/c/r0S6o0aaTxzGBAAhRQdn45ukDhWUv1Sioy1SPPkWr?=
 =?us-ascii?Q?Ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RApZig3FZdop853dYxZCYT5Ndxg6Eteo/IWJ+9IExzG3ceVMta8ulOeaTx0PNVdGkKdVa2UKPRgCxj0RuKFiNDq/b4hZOXVOvA6g5mPrV0+xqLEBNpsxeoIo/PVkhmqzVz+OjAqnvUJzU/j+0C/4WtsBkK5mfT6yuU0mr6uPOvrIiXyepwuBF/ESfcncWp1DLjSxSilrqlntDL9DHOR/dgz0k+um6QggaWP/0awnTZqJnfmuGC+vnTvgCyb88B784PDk2jWgwR9uBW+Bflkr5uVaZ9hty48tQGdIxGABgCFCzrNuGEE6iaaB/gGt01IDu876N205+NQvJhkCmAEcWDUuUYpoIdpKEc9eo7SqTiERWJJ/MgMFKTwKrAl3QnHO70SHQUr10p70s7rbgvVT68k9fh+xR4tbvUrEMkk4KeAIKL//xiPA968yNJIeUpbWFiN6ajZGIg0/TGg90ZQ1HHA4WGrQKlqnf0iu2nyOcYyW3TOprvqciJ1h4Q2SNz5UsSAZvCuXSbrCiDLhSqpDd6+RfZkAOWHNFKySjCS9aWPhACfQ4TVwHT4aP9ivH8iYQx+b2BEU6bZNaPWaByTZq1MKCz3AozSO8DO9xH17jXNNkSCpkvjGL4HOoqejXo0CijlMzT2LwJstQtMyhf80a/2rofDBSWRh9MDNQJXtLoa+B7eYxyfYGJz0F/ciImMxddJzwfSqOA6lM++buO4gBqcofPICb/EAAfIgjqQzdgO5KpFiNzvWFThbKDKnOdSpns98p+HxGILZhuKY+MJdpjImGkWiskHxzfrMscJFnn5d3CNs87JQWF1Hg7A4+RdcZ3+6sCoMk5A0VIezumePovVw+yz/XsqEUbsgkpJWfzjNdG9N9tytbpowafjEaTMkVMfkrZB4SII7fvcLQdqMEYjUDZ0b/GF3G1dlz7TE+bk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90539f17-81ee-45d1-ad7e-08db4e8394b8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2023 22:45:24.6651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dXSK/w3YQfnic/rk8JUd2PVVy7dj4QARJLScS18xMIZBi1bJFSDWoifN4FuZ1heHjVR6mbOY4gO3F1kL3med+4QkVduBH3LXK7anqyShvDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB7526
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-06_14,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=782 adultscore=0
 phishscore=0 suspectscore=0 mlxscore=0 spamscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305060177
X-Proofpoint-ORIG-GUID: 12fl8hkkZ1zRMOJccKoqLa7plAG2b6mq
X-Proofpoint-GUID: 12fl8hkkZ1zRMOJccKoqLa7plAG2b6mq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jinhong,

> Smatch reported:
>
> drivers/scsi/qedf/qedf_main.c:3056 qedf_alloc_global_queues()
> warn: missing unwind goto?
>
> At this point in the function, nothing has been allocated so we can
> return directly. In particular the "qedf->global_queues" have not been
> allocated so calling qedf_free_global_queues() will lead to a NULL
> dereference when we check if (!gl[i]) and "gl" is NULL.

Applied to 6.5/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
