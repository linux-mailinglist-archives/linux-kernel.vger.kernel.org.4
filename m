Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA7D659C8D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 22:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235479AbiL3Vux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 16:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiL3Vuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 16:50:51 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D13F416593;
        Fri, 30 Dec 2022 13:50:50 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BUFxZlA028182;
        Fri, 30 Dec 2022 21:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=2OuqwJ+dgfA4kbsbtcagw0VpgmLpU8hbkySKAY91hHE=;
 b=I96DtrQXTYnfFrSXYRnqJcoZ61q7PTGkAy+WGV7Wf0FUB0/Zm2cvhsHfeVSiHo69WgDR
 Xi1sxg1KVmbijxt6twwVn2Q52Q8vMVUMX5jXWIiL8GMJQfIFgxY2bm19obnU730CfLay
 DIdtihuUteQBw02aXxhcDFCay/+rhGM0729zdKNgX6514LdlayirQcVEX6bSEBRSa33G
 kL1kL/qi3A9PKxmbNBcGRQWx2pwJ93k4bkKpA3NtOZx0AaIMmI5uB4SwJoAX1X6FCS7v
 dknKqxPbkHO464wcggPN4oplMt1RzK+nXIssTrVLiNhNxACfXCWKhVN0JJB7i7sxHGfR eQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mnsyt8hvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Dec 2022 21:50:48 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BUKUTq8020370;
        Fri, 30 Dec 2022 21:50:48 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mnqv87400-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Dec 2022 21:50:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNoh7QLXtWBAyKn2wHQAfPaLJu4SyWMaGdRuGNUnMlcmKPeb3dRv5SOByECsUNZlovstbWAE/lAwmx1wU/jwr/19mlVLV+1tFteuBAEx0KA98LtO9LbPDr0J8MGpd5VnXSRvxxG6KiX0gl/4hJ0daWPjONzR1Gmees23g+jhmLeVG5O0Mu6m4raOyIkM+ut24KqZ1H4+/OuVPHZ7pPJ2VDZmUg8oHOXJljU4IWjZ6j7aKiZifmRf+jBoKL0pclg/L3A2ouIJcJL/Aysn9WzH3M4J3W5esTQntoeGiV5FJNpxXUWLpqKN68/fhIuvzwVNpUKQ3C4dlsThbG1J76colA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2OuqwJ+dgfA4kbsbtcagw0VpgmLpU8hbkySKAY91hHE=;
 b=JoyD0QvsaUKl6v67ScPABhzD69hfCNOH8yP9LeFzaNF3ito/Ihy+B4IGYUhXcKhPVwJFRGYrikV7Ynrg2+KuqD5c4ZVlMT6D2IBwEP/rjS3PlDQl20xQcEYgntYoSip/rxdsjp9UEicYZ+sdigRAtZujFuG0qvNT92ebesDjjRehqGz3pRkghOC0t+hzNWVoNkqaLzww+1vuMroihBOHsVWnsBZQpt6FTBURGXwpG/T4tQfd+wNokdYOR71Jh73VfYwM3+aQPaN4rGsuOVI3CyIwE0Wq3J7aqKCHneqUSUqchZYEAVvxUfNWaln2ezm0q0oTC4pSxgTVAMrFj78hIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OuqwJ+dgfA4kbsbtcagw0VpgmLpU8hbkySKAY91hHE=;
 b=ZOdJ0K9olqFe0DIHIM+FFoeG2Mq7Ym8VKvf6qbfIhvJ4jPleem/xtdXTV59zFYNOZIkqzaAa8bR45Nu5jMvE36SSlCIf5VHiz2FVymNEiACT+jbcixGwIp1uqPtuRCEfSSmJ4N6LSgHdObsrE1p4w/xHtrtgBcG3AcfSn0evKU4=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB6603.namprd10.prod.outlook.com (2603:10b6:510:207::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Fri, 30 Dec
 2022 21:50:45 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::25bc:7f6f:954:ca22]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::25bc:7f6f:954:ca22%2]) with mapi id 15.20.5944.018; Fri, 30 Dec 2022
 21:50:45 +0000
To:     Arthur Simchaev <Arthur.Simchaev@wdc.com>
Cc:     martin.petersen@oracle.com, beanhuo@micron.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/4] ufs: core: Always read the descriptors with max
 length
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1sfgw4l3u.fsf@ca-mkp.ca.oracle.com>
References: <1670763911-8695-1-git-send-email-Arthur.Simchaev@wdc.com>
Date:   Fri, 30 Dec 2022 16:50:43 -0500
In-Reply-To: <1670763911-8695-1-git-send-email-Arthur.Simchaev@wdc.com>
        (Arthur Simchaev's message of "Sun, 11 Dec 2022 15:05:07 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0501CA0069.namprd05.prod.outlook.com
 (2603:10b6:803:41::46) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH7PR10MB6603:EE_
X-MS-Office365-Filtering-Correlation-Id: 939f062f-7809-4323-f430-08daeaafe7a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7OVXFEJxJDFfOy4UGFkJ7YPw4rSmrCjQwgyiIkcp5k9IHcHV/pBqUUZLim0DVHFirVyi666REDMi5AuzWr4PESUTByidkLD4/MtX0Yb82DXZmuXX0Zrp6BZDNuOdv0lk9/WF+bBbKmmKSTAiEZjPTrVZeshmP7FTpeH0DGXgz8hI64Tu9rZW8o/IZwic+4rq20n3ezfQ5YkbGvol5/TevHV5XCQYTYTcZ6vNxO6oCi9PQPCAPOpbvbCqb6K3PqRuIZxiLhYEw1fLEbcyTp+ycO075B8N6WCpMwCUcFTBB0uyHQXCR+2Fw3HZ2hojLV5/LzLF7TS2HcXerRGS7gY6E3vx1pgsOI4ToBx3+WiHkxOubLITasi5i5oFMsJN2tpoOQ+QWdA+QSZ2n2/Q2/vXnOgNgiRdoAO/zPZyMwClkulVOM/Av5144PkwEpAJWE/HH3vuEaE4gCEjEQGdSv2T+TFmwoz/BlaM8eGrD3AhHWBJgFwNIK4JmqOgBf9zKq/K0o/3NLcb/8qJsLOoU8gT/9VI4eZwb6DZSr6zIPAjMMoZ0U5Lrby0sHURuiDVh/2g/p74zBShgFJ52ZVb3VsbRQWGdYaKeQ60+aTotcQigNjjkFamKstd1J000yGSk8U/d+FTJCOOCtxAHo+R6syJ1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(376002)(136003)(39860400002)(366004)(346002)(451199015)(38100700002)(4326008)(316002)(86362001)(66556008)(8676002)(66946007)(41300700001)(6916009)(66476007)(6512007)(2906002)(8936002)(26005)(5660300002)(4744005)(186003)(6486002)(478600001)(36916002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TyhU09naw9ppeZXgaGECBiRHbforqyAZHkn1tKMKsL2xdJEDOa45LxDz2fHA?=
 =?us-ascii?Q?X6/vOlgfe7Fm33zZ9SR62xKf+jPslv7rHLiPjQ/OmNqnEKdfm4VQ7J65OkWk?=
 =?us-ascii?Q?R5Vbsg4ILM1/Qtiw9FkKdPqJYFCG9eXavr9RcK824JWAs5PSU4xrPE7E7VEy?=
 =?us-ascii?Q?AXYac5G9xtB166GN7XU2T/vXzVKR1gtZ8kYJH+WtQwIa8fH+VXrMSCICyLBG?=
 =?us-ascii?Q?c+LvoM8MsEHuj/cLl8YFq+XOGyNQqE4xAGE3hE1BeoF8P3p+iITYLyrq4WMf?=
 =?us-ascii?Q?cMtpDah4zIIQ+BNZguFSYoyuful1Tc1ETdywf0+GiausSToR0CkvknHiAVY2?=
 =?us-ascii?Q?E34NTrbcrSZAj+vbT5Mro8hjA7n9VKdQHJ5OZajhdPB+tcXceBN80jjtCdEd?=
 =?us-ascii?Q?B7gkfH+lgh0yTxRwFpDp71skw2gUnffbN608Hq/O8wltI8Bs0Fb6oW9fA201?=
 =?us-ascii?Q?cLrfVcSIrpBvx00vG24cUDUw9SWilFCCiRelPu0W79mhADBOMuHvI0cUPG5c?=
 =?us-ascii?Q?XNLia2zRxGNQX9tWeh4Uwgc/IcEFfglebN++vDv+pYfB9JI2gOy69cMk6W/5?=
 =?us-ascii?Q?XRg2V6BfSRxxUMstD1NKEAaxKHqwweYkqZ6cd4YXjzAS++jTsh3AxQMGG1nJ?=
 =?us-ascii?Q?8LICKZKhMecLz4ANxs4nywbQ4rTDS5L0riZfaJJvAdMSKnMVcnTZS0egnR0N?=
 =?us-ascii?Q?3E72APun6l3HGEpWIW1i4VnvoYNlZmvH8rIeMZObZOro2/FcSBHvraSozwVq?=
 =?us-ascii?Q?vM17UmooKqFmJb60RhHl7HkVfJDlLRjRUVKjKFXTsa3WcAcOe+LhITP82Oqo?=
 =?us-ascii?Q?oY7rb4NEBleeloVqm3ms7fj2yrl8OLXhJ3jkvB2Hv0jr0VF5p0j3352s9PY8?=
 =?us-ascii?Q?dQ+NUPIeO6+vmFc/bfI7w1jL2HXiD43pWjyceqyZv2sXBszNLcnGx2FVZQIr?=
 =?us-ascii?Q?W6B7WAiLPevyupPlofoJ6bMc6pLz28TOz9fxpH5aQehBCvR8hyC8ko5LhR3/?=
 =?us-ascii?Q?B9m+R1insCSgtwj9+7WPRtFXH0xU3JB5IIFWEqUNWTfn2HbM08BjJPtWXDWb?=
 =?us-ascii?Q?GPFb1NXuEaYEM04QVGLweDPqeB2uZbx7aOjei+yZIwiVZhODW+3v7Adf6w+Y?=
 =?us-ascii?Q?ZGJ/i2tJDxe8YFTl8nymw46A5CPein0Kh4TH1bxQq5xsz/61pdpan+b9ZYI7?=
 =?us-ascii?Q?Zdp5c45sW32FQ1qMRyI3cH32R7DPdQFPTMNN7UKW7ah0M87I/vPDu74kFg5i?=
 =?us-ascii?Q?lMfMc9WIvdx/BY7X8KYe1//T7J7Aqq6FUAAJEeNIgozoELMYf8ecF7wzzXZt?=
 =?us-ascii?Q?ExjPChPHnKtNndO8UoOs0eHe/uZZx6hz5pOwRqZxScFKHhuAHOTRE8BwQyYK?=
 =?us-ascii?Q?JajeREhRmWzewFr8StBT/l83xMT2vmTsvcs/qMft9juHLwkNaLEYzprnyogC?=
 =?us-ascii?Q?RpV/P3N3Xa6JYuRS5fjtQZ6woIvexoShKnttvH+CO34Hukdl5ZJ9t5kl1+14?=
 =?us-ascii?Q?032OGLjNf/INAYKbxQf2EIdN91bs7J3JWTUPZdFLGusFY2yNtDdzpuvLN8km?=
 =?us-ascii?Q?tldHtJZDnj1D0AN9E5UMwyOhvp8fGhvSxhRb2xOemNyn34HCLg5y9At7AVYb?=
 =?us-ascii?Q?Eg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 939f062f-7809-4323-f430-08daeaafe7a5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2022 21:50:45.4633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cAul//8mrWMo57HRpAjLofxnsD7vudRpSoDWCxzZ6YXY0NnRvFHO1pxmEKI2kdQzH8PLym0oU7WXETHiXPM2lD1qihVuvPAxAtk6R9uBJmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6603
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-30_15,2022-12-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 bulkscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212300193
X-Proofpoint-GUID: fouWWYWSFsxdOIYPVY0vHzhZUBNQN9HD
X-Proofpoint-ORIG-GUID: fouWWYWSFsxdOIYPVY0vHzhZUBNQN9HD
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

> Read any descriptor with a maximum size of QUERY_DESC_MAX_SIZE.
> According to the spec the device rerurns the actual size.  Thus can
> improve code readability and save CPU cycles.  While at it, cleanup
> few leftovers around the descriptor size parameter.

Applied to 6.3/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
