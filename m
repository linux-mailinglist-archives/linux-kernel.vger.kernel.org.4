Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2518F6F94C6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 00:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjEFWaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 18:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEFWaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 18:30:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30E2217FE7;
        Sat,  6 May 2023 15:30:22 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 346MU4Xf000354;
        Sat, 6 May 2023 22:30:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=7LvLp6sUNy6AuHI9YBR4UXZy5viBG06ZcWWDUntaDEw=;
 b=KLl5i7xAbhgiLoNZqhjENQ9r7a7Q8qQZaAJZThVpaoRDi5Zc0KxvEl8uKOHV15gcbopB
 lnHsOAw/bDvn+gfwBY/KAY6OepV77vObK6b3JwjkL6XqzdyBRlQDUB4X09Jgd9tTw53H
 DLUj7nw2H1mLHJZLPPq4XhRK2tCtkSj/XrDZ5TVhKFblJBo9jQVf9EunxwCkziX2C+YP
 JPvF8sOP0+jgVJDNJ2aQQG8EqSi/wuQ6ECuqtqGqPc9m4KgOKcYQE36eQ2fx1FcOD4MN
 IZzzVSwEMTMAlMtViKEChKg6O6m4mtufvWkpPYyfG/o37LSM8PkUEs1MMWQ4X0vNAyZ5 eg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qddae0ykt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 06 May 2023 22:30:03 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 346K2aDB037164;
        Sat, 6 May 2023 22:30:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qddb9kksw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 06 May 2023 22:30:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nx8imnRz8VJ3VVfHjglEnwflTAT6CilfJCbKFES2A1KH9H6/FL18VX1LBQ16Sz003cskidGshRZuON9wvDQ1bVIS9zAEZJ1qBXTbq2E7jx+VhLQw2sxRbE+gN3myp/wHsgtP+7aGauYNtc9PPGD9CULR5oMHiSxILhxKxZaVljKGa+F5w/Wwn/jsA28EnXvv9ip2pTakE9HId+FX5aqU8VqwytujMJEQTopVl4djl3WKh3JklhhHy+q7vTr69ee/D15tOecN84FJcbHWC1RoFP6+Tky72bP/zGPkej+c2cG10nt7gmv/+6nnuw+8pNDg0u+zmZ+1e/h1Jo1+9RhyOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LvLp6sUNy6AuHI9YBR4UXZy5viBG06ZcWWDUntaDEw=;
 b=BNifO3wrctfJa1b7NaqvFcXJqujQVyyp6Pkf9H+zm99wRvXD7g55SSuG0j1+2PqEj5NJ3y+NctXCdOOoQkf9RA/QsxtW8tyt+tUMXkO2dSPB0p69U/h1lS9eg7LEb24TzVEJq3UZuV6xm7HieMhuXBKmE/O6YcxPb4qu8juqUkgOoPF4w7AgWPYjHuWbr/pL2VXADizZzAhuauH1EpBHPLpH5jc+aMch7uYu5PP69SU9wwk3En3jLEH6ndlULGNLu73Y40jMITC2MDSlwPBWSQJY0icixN0tVEfCxy+t6xIW8HIPea439bYBF76TruPKdt57UfYxHskDG6CNHHZlUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LvLp6sUNy6AuHI9YBR4UXZy5viBG06ZcWWDUntaDEw=;
 b=yZCyWHlK+y2ruhViAc5c50r5KlebJzRpCicH9beG6sjbxHEuwOtwEumrAQXAa3wrdHUVACJwN30TrtSdidW0gIPInVMdlqU8ffCX0tGaCeyGJtr+k4aybFrHcpbg9X7I6A4IlsvVZLc3lqJ4hxhvZreOrNhpOTHMHcIxh+8MK1k=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY8PR10MB6779.namprd10.prod.outlook.com (2603:10b6:930:9a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.29; Sat, 6 May
 2023 22:29:59 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%7]) with mapi id 15.20.6363.030; Sat, 6 May 2023
 22:29:59 +0000
To:     Keoseong Park <keosung.park@samsung.com>
Cc:     ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "mani@kernel.org" <mani@kernel.org>,
        "quic_asutoshd@quicinc.com" <quic_asutoshd@quicinc.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: ufs: core: Change the module parameter macro of
 use_mcq_mode
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1wn1l2iw6.fsf@ca-mkp.ca.oracle.com>
References: <CGME20230427094420epcms2p1043333a3e0c0cf58e66164e0b83b3b02@epcms2p1>
        <20230427094420epcms2p1043333a3e0c0cf58e66164e0b83b3b02@epcms2p1>
Date:   Sat, 06 May 2023 18:29:52 -0400
In-Reply-To: <20230427094420epcms2p1043333a3e0c0cf58e66164e0b83b3b02@epcms2p1>
        (Keoseong Park's message of "Thu, 27 Apr 2023 18:44:20 +0900")
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0094.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::34) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CY8PR10MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: 53dff50d-8089-4efa-db31-08db4e816cd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xjV/tkXMjvDPl5v4fiBTQ9ddENsIavMFWHL7iSVx/UUvkSHzIWc+JL5hhhPoFvPIZUWwEzkvP1J9qmQxp3r73uR9Dl70haJ4DhqwHHYG2reCDSggxNt5QbhE2Rj5U+SYiuNjqCV29vzTfRknvzd1ZEwld7SRQ63txnw0jZwojUtZilM6rvgZoed037mtHuZk5IAYU3W3EnGFYnEHFi6/Sgwk3Mq0CzZSOV00vFqQDVx88mqQNe7L5PG2zPM8hPJD58qNitT+X1cTWK1bB+QDtrfaU8qQqenxwBkAcDHfrH4GH6gBlfdGv2b7TrtRPmEQv1ml4j15nntRD5S4UZhf7ZGkMQv46U6dOLNMGDU1tiTNrq5tkQjIgiPinl03Vz97rNUT6+CRPd2gCQSiyA0doVUcFXSR+Xw9DKQnyBLl/5Ulqn7WOlXLjtgGSSvY+YnZcDYsEFgsFXNsu/Y0do5tOixsYBDOL2g7y/kSoTOV4hpKkr4iPpHVCuoEHMRU/jhAEjLFOXmj6BI3KG31uCeah0e0WhvF+8lLSgzbzU/BqUlID/uW9UkgX6JlbOoCcDkP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(346002)(376002)(39860400002)(451199021)(5660300002)(8936002)(7416002)(41300700001)(8676002)(2906002)(54906003)(6916009)(66556008)(66476007)(4326008)(66946007)(478600001)(316002)(36916002)(6486002)(6666004)(6512007)(26005)(6506007)(186003)(558084003)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aDceOIMx25Hnzfv+qGc4sCNymJ72rwQuxvbP9eowedGWpX/toQwXvFSjVzI1?=
 =?us-ascii?Q?Rv9/9cHXOBNfyHz8xxyDHh8VVdliGeYKW2jbkPM/RNlkx1Dx0PIw3vQ+IzZl?=
 =?us-ascii?Q?4kVHPpOHTP9iGef8Eh51za6cgAqwlXUeVSjgQfmZN0ZQyyfQ/pGwQq/ZnTA2?=
 =?us-ascii?Q?DYCIN30bS3+RMzTrZennQG76t4PDBI+dJJoqrpHm+Dk2SZMYTXY3bjKNg8Lt?=
 =?us-ascii?Q?GrUPxFP1ChTWNzMzXzW7zyxMYds71KCA0vSSdcgh7JuJKQLkGRM+TK76I0cP?=
 =?us-ascii?Q?nnksY0tSfHhWJqkQ/M4b9TZnRb6lVUIkDeY8O/VsPkEJiZlZKIa2Etwbdn2t?=
 =?us-ascii?Q?gegiSAtpuhbx79aN4AX9D+ymty8fGgpv++QzT4kZaytyaqv51YZgeU94OPwZ?=
 =?us-ascii?Q?lGOLPhta/RZoJcwEi5tlQmwt7P9PmCbfFJP4jmppbvZOFCbWxdsYu/rcvbaI?=
 =?us-ascii?Q?djOL/10VJhXUYNMCVE/C/FQVF4D8ztFIh5HCCNUFin42gUIJeiDu6T/3nw0W?=
 =?us-ascii?Q?yeOfDlzeTEwh7WPsBVAJyPcZokF6jhleG7jjiM/pphrfWL5g/iQyrB6+vw8n?=
 =?us-ascii?Q?IGEcaFxdHMHyJAHmAvf5ZQU5y9J457gsoeTy4+b3qY/14KYVTjeUzR7jEqmQ?=
 =?us-ascii?Q?bRpeP2AS9N24AGyX1vYZoteBcxJ2Y254SqkZzOR5NcsCcoh68YyzLid6OqVz?=
 =?us-ascii?Q?3UbAn0NgTLOPyHFcvNsELN95lxgZSyf1C2AeV/kRVQZ1EjUgLfOaGJBJfLJA?=
 =?us-ascii?Q?JQhCf51qiSxtMtX5Eol6hitb4+jkvIl4aHydOs960asAkziu7/YP74hewS2D?=
 =?us-ascii?Q?jolxZTTt2QQaVOi8LpN+Yr5coTsY2yDmWV39U9cs4HNLcYhu+U4CywxuUzyX?=
 =?us-ascii?Q?LQdp6CIzMUfjVgowNdK3jJPKHgX9DTu3bIwt1wksTfGnGZ6a8/x2+kIlro5g?=
 =?us-ascii?Q?3e2DR25S3kHNoBGeZernrGbulOoBklsRCluXrhsSlc6yGadFABBC2sPsnnO5?=
 =?us-ascii?Q?8ZxOUDKncyCfOOqZ5Wd9awwBGWK/aaU2TD3RgtT7SCK/2k4o0yd8oxU70Vrd?=
 =?us-ascii?Q?Mc/L3PaM0OfjFLvTBZm0Yiwg9F5OUjPfuwbPkab1VOuuk7PxcYwVMpzNbFLZ?=
 =?us-ascii?Q?YT7dw/j/ulAoUNrHSNqog80GHh7nR0K5J3yoIaR0PlXeJrwnkBrYN3BjdG61?=
 =?us-ascii?Q?n5XW5ziBdVEHCEwMPBl4XJWRVI5bDAI8iqNgiUxRgljsEeMZp7tWOGzWExUo?=
 =?us-ascii?Q?lqc0DmkG46oXC9vb9x2dk+vVSIRNqkjtun49xLepvIuFBUqVe1RtkEDWFjk6?=
 =?us-ascii?Q?WmR3InuRW997aBaqjDAEYoVMfk7hUxFCWxWxU3luWvxebPc05AcX0SDgOgMa?=
 =?us-ascii?Q?RWhEJYfx0wFTU4O7+5mCz2iSJSRGvrmEr3hmrCq+I/PqmJ9XwCu+c0bqwrkZ?=
 =?us-ascii?Q?m/ar48CQO3ZhqVb93+DgNwNMQNkz2nbly4eZ6BUNvAamqeuhbTxPAq/s6Rsp?=
 =?us-ascii?Q?Q8nY08287mrWwGYXpe7NdG9B7owgx9pkyC++cn95WTIKJX7z3lNdhnR8GdJc?=
 =?us-ascii?Q?guDbAGSk//UAgtxS3p0ObdIxxQgjCzPUuOWpe4nubO5vPOyAXUWZX2rkv5On?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?O9+3PHhRDaUQixZs63Cbs3aGzWQ0FJ9anWamzjwYMDIuWJHESDDhFwdNJxLJ?=
 =?us-ascii?Q?9D+mWtmJ0GnsGU8Dstk+qGgY5OW+cKwGj9GZGPhTIqjKqbPRvB4qsrXe8Rrb?=
 =?us-ascii?Q?UyfMaM44/Xc10omyU1WBMDRvfDjwpDux+25w57m6FIJ8a8tE8B/SCx2Liwbk?=
 =?us-ascii?Q?G2h72Rslz13zPgCs4X50oHGgtXu/8lHUQsKhVVy6zd8D7WJx29RG+xzYMIv/?=
 =?us-ascii?Q?fiq888NyrCVzzMLNA3TkK+W4bPIakDGeW8zGRS7VY/bQVCWjpQ8tpG5NC3Y0?=
 =?us-ascii?Q?Q56DYsn70chy/fhEWnIfM/uK5Por/e/pqCRWtMEVM4U80p1Ehf8v31V6gy9n?=
 =?us-ascii?Q?fs2beqc8astPKrcUHORk6QG+20VHmk6uGj+vpXzBcAL/qYzD+jXeXbgZOo57?=
 =?us-ascii?Q?uI0oRRAYapo/jOQfDmw2j1f0aFQOoYsJLyjK+Si5YoryDfmII1QMrRsRw/G4?=
 =?us-ascii?Q?wTnH8N7RSnKm5KfmxiSTqC3MP89XHC+vvkcI55LuDeSzN9rKwDfw7zw5jytm?=
 =?us-ascii?Q?Dh2fw69GcT56WaA0GNVDyOH00KmjqfKUEBQDCO1HOO44T05hJRXL7uuv4ZkF?=
 =?us-ascii?Q?xo2pQQrQphrgumZoq33wUJAVgEk3cxn16aAHaL4UceDrAgRqr/QkvbYFf9VK?=
 =?us-ascii?Q?1LhhgdzoBjDq69cLPI2N3Youm69XmdFI3Wif86xMx6VKM4/SXjIFEtPuHf0n?=
 =?us-ascii?Q?UY4y042kzE1/Q5X5ni6zdGf/WnnCITV3lerDwzTNcfgFyIt277NM71BpnhCW?=
 =?us-ascii?Q?3zivvZqUKvSQN4JhF2ZtMq+q7c0gPdFXcUhtxU+KOZ12QyEJNH2Lt5MHxHwP?=
 =?us-ascii?Q?TguthEp8A4n0/vbBONbz9xYayq4b3HQDJy/Q8kH/wh7K/XUmpJgUns2GSAry?=
 =?us-ascii?Q?URtmt97RgaQ1feXPa9+q9qz7Ge+IX2b6Qvl6ybJqWcVhroWoqYToxx+Ympxr?=
 =?us-ascii?Q?Td5YcuVDjKfWyfFymAvnq9WV3g+YVsVDFAh2FBBFCc6EzQuzaHe8CXwJlAI6?=
 =?us-ascii?Q?6GZy?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53dff50d-8089-4efa-db31-08db4e816cd7
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2023 22:29:58.8970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uZlD5EwbbOAlKDum94AjWqHy/5ApJEZCov+o6ab8/GYdSbKqiZ5o843xveT6du5oWBHF+SJvO7PqxNhByRIRRe+Bu2RKXne/QCwqDtQw4Rk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6779
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-06_14,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=895 mlxscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305060176
X-Proofpoint-GUID: NH9kCPY-LX-uwCW5-O5TsyKqf1KRW4xC
X-Proofpoint-ORIG-GUID: NH9kCPY-LX-uwCW5-O5TsyKqf1KRW4xC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Keoseong,

> mcq_mode_ops uses only param_{set,get}_bool(). Therefore, convert
> module_param_cb() to module_param() and remove the mcq_mode_ops.

Applied to 6.5/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
