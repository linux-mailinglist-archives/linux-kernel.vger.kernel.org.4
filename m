Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AEE05BDAC6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 05:16:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiITDQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 23:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiITDQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 23:16:33 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E324DDEE9;
        Mon, 19 Sep 2022 20:16:31 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28K1nMln011945;
        Tue, 20 Sep 2022 03:16:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=+ZXLZKKpnhJI/Cua1PqrrkWMRQAGu7qCFJCL/i4BP4o=;
 b=uSm0VADcgzaYlWF80Nk0MiMBtF42jQTQVWIi4IhWWXQjyGJSrgtR8rI0TecTQua2dQSV
 /UvWAzUujLGTUII9Q31Bb1LyHL7gB//HXfGlucmrmYyVzQkNQfHktiygRoxIugdXbdHY
 mqTFEAfL/1kI5RkHgRNVXrGA2WOLbqShcyL1UpBM24g7UsPm4Q+kNIJ/NOiSq/0Fq4Wx
 D/pLXg1AF+XN2N3LblH4nnxHJoZ7TaCA/GSkrBAW99UOQ/EPbNBog/rM2HSh3GORPY2f
 yiFqsSJkRcRob+FJdl/k6oeMwMFibNDg30Jpx/plTq3moM5eDJ09u2cu1xl2H3Ri8//h Gg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn68m5ht0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Sep 2022 03:16:29 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28K2UB47019073;
        Tue, 20 Sep 2022 03:16:28 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jp3d1sk83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Sep 2022 03:16:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aaXSRmv3o5Fg/U5upD2jXj0Ib+RRyW9S2IFZU4BwkxdkeL2RoA7UcyZRDOAzwZttMgUr8qGEzoPzQYs43imyuyeT+PWsCZlP/edtaKNi4LgAFc9TPkSsoCmgBA+uaERhSFJoATGxWZnYmg/wBzpmHQtecWiLuxl4+ODkIKu6ZGx6/4o66xN7S6EOf09pXO2RkmZMSS3853VDkLkmKwG/3Ij0GFmDHjHGGuODyCvqZqpVClVb5CIKxwT1y4pI5VdeVlkUW6LK+TTXe8gF8gIT+TWq6Le5p0hpiQzC9izgt41JBO2VOXL/vUZbs4aBYP8abetBF8yOq4Aq7GkNNF+4Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZXLZKKpnhJI/Cua1PqrrkWMRQAGu7qCFJCL/i4BP4o=;
 b=hegYjy/zi10XdgNjI4huCVcKIv0x+oq/rDHvUddYuy7msJXVvhi0wW//UBJIqcB3pinpGzJlokWV/xpt0bZvkBqbiucn43FoYDL0YyVSaM5fMS8K7J6Ogn7HK5vHp4UdHuBVauCkTYvDVEgQDGy4knhASF0cHukZSjRycoe6SD3d1pUTk7GV8wx1+Ri9hN8eizxx6Guy9blUHhx2pna8lous3OUu6RmxNemUOC5gwUd99WXtxLC1s4KunvlbcQqRia1wNmPdLIxxUHaBratInxGDiTuwJhGNR5lD8yE0BsiOsnNJsJh/Cm3mUNJA+GZ29QLyCWWCfOqPMvThU6r9Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZXLZKKpnhJI/Cua1PqrrkWMRQAGu7qCFJCL/i4BP4o=;
 b=vXOZQ26sHoMVEnYMYpwov1aFUTeDQ5j1lGUJDku3SSUnvoAYgpWBGxzy1op9L4JUGfUPB+q3t86NJVF3hqDDXjQfJexI4Yuln50U4ugyfBWJGfg8bzqTIA00levN2pIBxQ90zmmLVmCUd/s5vnr6SBgGKwuw2thCReLlS9hT0ZE=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY5PR10MB5964.namprd10.prod.outlook.com (2603:10b6:930:2b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.18; Tue, 20 Sep
 2022 03:16:27 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::297f:836:f424:cd75]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::297f:836:f424:cd75%3]) with mapi id 15.20.5632.021; Tue, 20 Sep 2022
 03:16:27 +0000
To:     Arthur Simchaev <Arthur.Simchaev@wdc.com>
Cc:     "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        Avi Shchislowski <Avi.Shchislowski@wdc.com>,
        Daniil Lunev <dlunev@chromium.org>
Subject: Re: [PATCH] scsi: ufs-bsg: Remove ufs_bsg_get_query_desc_size function
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq17d1yohxd.fsf@ca-mkp.ca.oracle.com>
References: <1655727966-31584-1-git-send-email-Arthur.Simchaev@wdc.com>
        <YvBK/8yeohLhu2Za@google.com>
        <BY5PR04MB6327431615BFFFD735EB2502ED6B9@BY5PR04MB6327.namprd04.prod.outlook.com>
        <CAONX=-cXDcekWznHf6h1WwtJfELyFxSPAZ4bnA5t3xOrmUQZ5Q@mail.gmail.com>
        <BY5PR04MB6327C911666B7A5AE0E92A96ED459@BY5PR04MB6327.namprd04.prod.outlook.com>
        <BY5PR04MB6327FA0C19A60F8318FC79AFED4D9@BY5PR04MB6327.namprd04.prod.outlook.com>
Date:   Mon, 19 Sep 2022 23:16:25 -0400
In-Reply-To: <BY5PR04MB6327FA0C19A60F8318FC79AFED4D9@BY5PR04MB6327.namprd04.prod.outlook.com>
        (Arthur Simchaev's message of "Mon, 19 Sep 2022 08:33:51 +0000")
Content-Type: text/plain
X-ClientProxiedBy: SN6PR08CA0031.namprd08.prod.outlook.com
 (2603:10b6:805:66::44) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CY5PR10MB5964:EE_
X-MS-Office365-Filtering-Correlation-Id: af18cbd9-0f9d-4e3f-af47-08da9ab68173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n8dmeWtGfsPC7LQrGdTFyZYHGFkQk0ckUb5KSBgCGYNT/81PzsheOMriYfmlMI2XqrN8bcR3qGqNqTdWKviHYpnb/GZL5obAG03Ne4kU1LmYEQn2CMZ15nS50WAlsECYpTcoiG+K6B/bonK1Y5wBrTKADF/TkOffEeY6q6eLBgJPvY0ty9UmkO58rhf/mTcdL0jezphbiJ+9KSRsbQbm+Cs1ooJ6E53QQWrPBdFXnIuKijO77GyylowNSkmEsrCBnyMMzClBTXNUBTUgfUByg+GaHmOU47Ns/Gh6xOpRtJHI36D2JfRP0+bkBOxzs7RgxLAmOUhWG8zmjOX1mojHVpNo0EEkR2FefpH1ZITS+3xR6iIER/rWBF+huP5aM4SScW3WazejvUp7aQUabLRXpLOvcuulYh5uLTayIeuxUd1jZ6AwhTJcylMAK7o8vfEgFx8BjAzSqnN9NwyX0PLCCvmzGhLfBiDrHhlonxbcS5o72ZtNNTZ8MGM4COpreBh5WEJqznhk9hyb4hii4IJXtKfzD5271X2wojAMSe4m/bbnYDYT1cF3T+i3IUOBmfdh2LXfJ45E2gtel4IOaXO8lhDncz28blZ+LGtnecJywb6JgTVqXeo4d88PyB97bZtsES/7LWIkaB+MnEzZKt680XJfvP0s4C2nfPesyFnx3eu/SpdRb8f+KrznpLE685Z2gTxnf4iAIy0rRFbZN3NvWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(39860400002)(376002)(346002)(396003)(366004)(451199015)(6512007)(36916002)(26005)(41300700001)(38100700002)(66556008)(66946007)(4326008)(66476007)(5660300002)(8676002)(478600001)(6486002)(6506007)(2906002)(54906003)(316002)(558084003)(186003)(86362001)(83380400001)(6916009)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2Ow6nELjzgVuhxDbhGyxNzvlWN1UW9gPOepnuUGuTLGJ9e7pLIv2TEXRQcsI?=
 =?us-ascii?Q?BwqDdN6uClpSUYFTxERP4YSpAoM0SpM4uuEk6wgDwt5zDcGaHRFdZiycUPSq?=
 =?us-ascii?Q?y2ar+Y0z1hpZUue3oDrBl/8XAAuCj7cCuAJt2Zp6znhtNxFym3M+8LUvejs7?=
 =?us-ascii?Q?ydZvUF78Enee316oclTy0Y2qL1tNfpx39/pxvnazp0f4br/WXragrRTn7BNP?=
 =?us-ascii?Q?GJrdGnfci2LUJ7sTAOB6cEItQHNRq+MO+a5H+NNqN2SR76XgEgW0Y/wrY01w?=
 =?us-ascii?Q?HbtAjEBbap+EJXOgkR9NCkXzJPJv1qlr9tVHO6J+64Wj8fKeEdf3Cpzooq/E?=
 =?us-ascii?Q?GHWoQss8U+LV9vLkzr7iCCDBrySMerzCcA5RYTgtQlunOEJSjy1xmGoJ1YZO?=
 =?us-ascii?Q?/btQIeDkFuRduyMjWO9tPOCLe7X0fu9aTILf9JrdQ3B/NApk0jRg+bRpToff?=
 =?us-ascii?Q?QHqcHMA/hQL+Zn3OJT/1RVRCi9LnuRcBbzwoWvRO82/4q9WIBODO4xskvw1u?=
 =?us-ascii?Q?huqx/rQxTz/AEXE7nRgBiMnzrYXvfjI26slCQO85RFPcIcPeyo1xAtq5qO8h?=
 =?us-ascii?Q?CfmeBj6fWIfHcukkHtdo0Mm36Rgllrx5Q589hRuZS6i6SBGp/ufiphf5lO8y?=
 =?us-ascii?Q?bpXoLpEk5BOxY6CWlkdFsfoAvURgJlVgdFMhsAqjWvleSnLHSk0fjeXva20A?=
 =?us-ascii?Q?YREEk6bKNqkabLhkVIo/Q9z8iw/3Lk9fGJVNquy2pfdHrjdD8kcZIysJ28cu?=
 =?us-ascii?Q?h0gEkA8nA1tP2TALU9It2a6trakRh2CHkJlueQMqV5KY6+apjzo4KGbr9leY?=
 =?us-ascii?Q?fzypBR3hYR283YTWvL7W3vu/jSefcyxkJXodxIe0AJNR98MwUJBC9NSijKJI?=
 =?us-ascii?Q?onj9GesnXFiHDMEzb9wlj07EVrLvwnXUdJvtyzGs9zbWGqEb5/qZcYwHwBrK?=
 =?us-ascii?Q?5PM++FLfaBr9JZptRrDBVw+f6kaI/7aSwkpPE/oqvSN/v3sM5rLvY2JWnFiC?=
 =?us-ascii?Q?7DLnH3WhoNiUrh6Tf8oGy2bSsvmzvIyLCP5puYEMcscMX6dndDVqkC/8HsDd?=
 =?us-ascii?Q?g6YWTH5ZVL04/nWHBNUBO0NApChcnARvVHJgbBACi3pWLq/daw7M0yyHG4+u?=
 =?us-ascii?Q?N6P9L7Jl6pL1R/ScXuh3EJTdunb2t4VuoUP0MuLJfpIkuSwFv8CCYuEZqna1?=
 =?us-ascii?Q?vJYfMz7ncwhi7gglsMVFFArqYqH1TPSlDEBIe0SR8JwfhHJ5cJ7cDseMG/1U?=
 =?us-ascii?Q?V2c5O4TsdK4ZX9xs7iwaWTQ3xkO9aEF0NIONwQ4fTR/mIorZXIVHTcI75FpM?=
 =?us-ascii?Q?J1UVv9fxw4RRTXKsfHsqvbfY8F/FQwyeinv8aYdTMRXcwgHNgnjWwddiBaHE?=
 =?us-ascii?Q?M4+ivmZ+/VjBWZ4i7U2EsZr2+W+lqV4cwmpchvaHJLEiL8VALcCuZovvC6n/?=
 =?us-ascii?Q?ygK/ZcM9VHhcQlWLxxwKH/lyuqfYHB4eoB1pt9GuAwJ6H+j8liGfGjTGkY4k?=
 =?us-ascii?Q?CLBQ1trM/d5Aj4npuAodbAaKEySPXOXRI8lmqiZoFv222Fm5jqrjftOUs34+?=
 =?us-ascii?Q?iwcfz2BmLzjNFivlYmhzSlnVX/w3dJoVQHRT9cwGl2f25vSQR/Hr+g2lDPUc?=
 =?us-ascii?Q?9Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af18cbd9-0f9d-4e3f-af47-08da9ab68173
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 03:16:27.4645
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lLvsujM/ydZB++7sPiSbRdrRfFmboMKGqtWCAfEGh913NUJ8dxAvr+mtTGnOSxeZZDVLesE+ohw9JgozxyxTXuXA2vXJJVH2s/PbZVvmdw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5964
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_05,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 mlxlogscore=864 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209200018
X-Proofpoint-ORIG-GUID: -YcJCITJaMx4Jk9pSLaUZwNmuVu_9PbN
X-Proofpoint-GUID: -YcJCITJaMx4Jk9pSLaUZwNmuVu_9PbN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arthur,

> Martin - a kind reminder.

I have been waiting for some of the other UFS contributors to chime in.

-- 
Martin K. Petersen	Oracle Linux Engineering
