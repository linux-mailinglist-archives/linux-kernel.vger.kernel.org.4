Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE3568FBCF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 01:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjBIAEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 19:04:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjBIAEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 19:04:30 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1C1977B;
        Wed,  8 Feb 2023 16:04:29 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 318KwkaT004552;
        Thu, 9 Feb 2023 00:04:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=udQRFDO+VWN//XcVngEhVQqBx590FVnxXLvkb5MuK78=;
 b=LA/hjbfRDLsAuCJUGXlpi9QqT4wuv4JnH3iHkZPdJsPqhGbboL5CqGbzX37AkUapOKP9
 uiO0Wbn4r4QP+nDoz0uzWWB4eUv7uM42tdDvTIm1XTRjomQXuh/JLevCb7tQ1KVu3xf/
 sc1asId+vNrsKjX04imCA2ZA77d3SiMvf3YI/Y5+E6KLNRfOVsb42yWkS/oJtZjQlI7p
 IfP3UsJNQ923ienmrQsgH+Wt+x7Og35pmJ5Wd27G7I5g3+LACJVLl7buBNp5FiPNuYIT
 PYozOTiW9Q6sM1/66HJkQUq1v2FxGBHQcNtJDsjzFGoqXriADyWGN00uQCsCp/1dW19+ dw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhfdchn0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Feb 2023 00:04:22 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 318NOe7L006193;
        Thu, 9 Feb 2023 00:04:21 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdt8f3pg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Feb 2023 00:04:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kkArHz62/hTplQd5xHxYFkeC5NlCTe/Ud2zd4eJgr9hFW1SMTSHXTX6gEPS1Q7helZYL6WSZKFM8A9RQ4gJ4rYr8N/nRmI1/7Vpd8liNyV+KMYr6qd9DoFqN4EgMfEKUyY54/OEz3/7X3U06zuMsocvwCJmIlKT+HOBw+pLMYFwiIvmW3pcYiVcJlP8TS82xqQa+c6Zf1yONd3oRUJtXCsSXJ0DFuh3sl1BRl0UtcVkm3aw1BtbQmQUXsB2VB13NeewqC+7zReRL4rvAneklyk38l6rcWAXHv9dqcyD1pJoKeeM1rMOC1rOMT2f0+q/Ih+d/nRhtTM86IXemP7HQPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udQRFDO+VWN//XcVngEhVQqBx590FVnxXLvkb5MuK78=;
 b=kughOYCy/zHlsgYm1hgMBARBcxirJ3B8YC5Tn4Yvk9Bc2V7sy/1CG1ou8/YjddMfbiY6aoeWjrl/n5JKP8Sc0L5c5WQCyED6q59F6B8REwC5Et0w3c6nIbeUDnW18XKsPdHJfBuy5rpJFFZRcmsyQotkpbJkRPjPRIr9g1agSecq1yO56Q/XpK/O9rvW4v8fSjeYtriwK4AoJD9qxO5mgEUvknOLAUB7wS2TSGqK4LmycyKtiCCqKLL12gXZuE79p9svJAVJeAutVv7FoW/PfqVoJ0mAyIw3j80lvpr/OeNgqkrthSGZtYFSYB1W4r9eXOwVCQGwMm8s6Wmq57rjxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udQRFDO+VWN//XcVngEhVQqBx590FVnxXLvkb5MuK78=;
 b=T2AIsjBQnJi6z0x+kbKKO1rNLtaSY+/2DfudfrvBfMWFfLb1J3Ujq5n0aXxkgk8BAY675f9uuVFJy6xowioNYQ6kn+HrfsN8WkHOCeDeHBvGrWX3c76/9Zblb2XVnMCDZbOPwSBfbxvigc//0XHsyxTXx1GJ5QHEvfc/ezQOvsw=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MW4PR10MB6485.namprd10.prod.outlook.com (2603:10b6:303:221::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.21; Thu, 9 Feb
 2023 00:04:19 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6%4]) with mapi id 15.20.6086.018; Thu, 9 Feb 2023
 00:04:19 +0000
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Don Brace <don.brace@microchip.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        storagedev@microchip.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v3][next] scsi: smartpqi: Replace one-element array with
 flexible-array member
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq17cwryaa6.fsf@ca-mkp.ca.oracle.com>
References: <Y+LJz/r6+UeLqnV3@work>
Date:   Wed, 08 Feb 2023 19:04:16 -0500
In-Reply-To: <Y+LJz/r6+UeLqnV3@work> (Gustavo A. R. Silva's message of "Tue, 7
        Feb 2023 15:59:43 -0600")
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::20) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|MW4PR10MB6485:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d01d048-6c98-46d2-8e78-08db0a313092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WPQnh2ApInC2AFjb7G/gESUkoPysG8TLEMLKJ3OVnYGxH4CWZUFWFmvQed8JC619qwm05NrQv6xAkjEostbhdHCqVqyVA0bKp4hBnfEOLSBIhVOskeFq9azGXyCmWOL6iS0T9QCq55cjImQXOzO4TSCuBhOMyNcJHB4uIJSpGobPqfIj4Qd9GxDqDL3Rr4WEV8TUjGzE2uxP6qj/jxOfsnRkaZief3B2dqOpnhuI31xAxL1i6NolHaqdHYFx23Z0QMNTjEx5OubnJR+9HCeA6X/Fr7fSLJBr1rflZQS+KnnEVZ1QZWJh3n8iqYiXAshKwNs4Vq7bP1aPiv9DuSOzsFqwMl93k1cQMwMLWOu9gJ5/4cs1ZbDSbd2k47YZxu4bB+5Uz1+HwCBrwUR0vtc8Mncn0uxqP6qPjqotn4Vt11QEK2qMIImBCb022XjdI9LS54qrpUpOjfrs3ZgH5fsaldrflmD1ZO0uGFACtzVugXqsRAyZS8Y8oopgqHBynppildwVsvQYWkP7vCIMWa3fw4G55tKkApHJ5fBS4bhk3c7CA+9/I+sML+e04cNsa5URwcAhJ+wmLSfcFYA/qaEjUq74HlnP+ofFCjtUzK6rL9o7y5jX/i2DerUaF7P6HYhCUfibZzDs+LBofXVRd97CfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(39860400002)(396003)(136003)(376002)(451199018)(6666004)(38100700002)(8936002)(36916002)(66476007)(8676002)(66556008)(4326008)(478600001)(41300700001)(66946007)(6486002)(316002)(54906003)(86362001)(6916009)(558084003)(26005)(6512007)(186003)(2906002)(6506007)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XzWQPb801KE52pzB9pYCz6/TEFRGYvhbc2y++WHAv8EjXkXUmEajelb5+daf?=
 =?us-ascii?Q?7DD8suykZH9zc4nUcG7QXyZSBwag6QqkLJFuL6PvvFavYsJDfxtERT8u3aS1?=
 =?us-ascii?Q?a3TVA7dVluTFYqVKeXsfoyboRBT56slw5EFle0vuPbV+uIdtUMCNtI6l1tru?=
 =?us-ascii?Q?w0TMOlW5HjpR9jTcqWyts5sjzbXhxk0ZE8u962c01zHqEFBBULWlsCbuYcMP?=
 =?us-ascii?Q?T70fCaZezfdHzcIVLSxFhm0V6P5yCqCuCHtiU0ZWPtGy7zgAejBSF5e20ncg?=
 =?us-ascii?Q?F2OWowbDPOU+niQAgLIPBTbv90bARntPZY2DIy1rENRWUP+ycrGH4tuRvs5e?=
 =?us-ascii?Q?/2fzh/AtDQZNiGliUr+44w9WRf4w9FBTW95FM78hWlHzv65kQrEKqYcyFhBU?=
 =?us-ascii?Q?wMaNEmGf/CxxhOZhUafv/YDMFpWrTjwz0qd193tH2KHZhqeObV8JDcY+oaZ2?=
 =?us-ascii?Q?6/6aDaImBVSH3I765sxb9INr4eFwsMhPdRTOy6JYTZvoNWmJdEbT9WQKdSO9?=
 =?us-ascii?Q?j2kj1wRD2qlZdelljQ9nxyN6Yi9epqvJmkDjxeo+8kPSWWflwb4DHWfig4+d?=
 =?us-ascii?Q?TWMn+pUfiTCXoz3W15c4JTjCUcu0YkbHy5YbB8iaxYv03dHacZQk0Mf3S3CJ?=
 =?us-ascii?Q?265HXKWcMk+eQWxc2aUCuOo85vKCliFkL5uMEH1Gdrk25Tm6U42GN5+o+jtY?=
 =?us-ascii?Q?l3SKbftrBvcUK9NdMEvVPCScOmJ+uIfUvntWPwKhJgUr23uevjnzpfteUd/L?=
 =?us-ascii?Q?07jFhbsgnKJ7JfQyO9bc5xKqAkrzzriugyqychVlOUor26oce+VqzG8blsWF?=
 =?us-ascii?Q?C6o29QoQekNCptSK8B0+xg3n0YSlIB1KwWl/hC1xAkAkkocUu+IjpoITCr3h?=
 =?us-ascii?Q?COTEVPddtNQyZ+C91pDMY3gPflP8zzAhh2eewfTuvLaLIaCgBZlGo1K2XluF?=
 =?us-ascii?Q?jy/JR2sTuz3f2DyZgm65RPTXbhwjpzfGjN0yKjwpPY/DD2Qzbtcqls4I2zwa?=
 =?us-ascii?Q?qErkIjupMIaEk174XZE0WOaRzZCDmJEMe5gzZwp90Zh13cgegbOX0sq3t/Op?=
 =?us-ascii?Q?RUORldNYLMxCY0D489Vvaqqlo0fOUsP9nsnSA7FUl7a3dm4H2pc8JofTnDFW?=
 =?us-ascii?Q?+ksMFAj8Sc2dwl+u4+JNLvNJzPyDpl8tq23GSt3nVfIbh3r7zQaLHbXehDYx?=
 =?us-ascii?Q?WVLzjduXr1xaVHISJ3puRtTfSEu9Romfppeoy3zlQWbhJcVCltRsCu3u1i1u?=
 =?us-ascii?Q?DRtil6AFp79jLo4ydz1JZTU/uTCxK/3CBIeknX92xSFwRg6X2dikxjRms6mx?=
 =?us-ascii?Q?PpO4hbnLyPcxdGEr9YzS5EUHtWcZWBBWmBEjT/Kev94/7UWU7Fq2J+Ur9tRW?=
 =?us-ascii?Q?y2MC3ARqomKmyW3QG47k7KfwmzkuYKEofDtcaHxfnUzz8drDG/A8hsiTxtHf?=
 =?us-ascii?Q?1EctUcVzqv36iVUdQLMLpbJAoIEDZl7DoveE1xuAg4BVugXfS7AUmkD6NiR+?=
 =?us-ascii?Q?B8Z5fNrJPQ7OGjiXSl4QPqPcCgD48pl+jbDkmdro4/K/23MTpP7SL4Ub0jAs?=
 =?us-ascii?Q?JK1SEEhC11upCe+E/hZjPRf3anwZXT+XMo3Exr6n6LGRbNtXBFye4P4u1qc2?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sD9GIzQjMuSHSZWVwzHAg7utR/t8LVSbkYkvY+fOi7llzr4khWZlL2xvToUMCdr8RHaBQEDxIDZfPdubFjDKwgCGzbz56Sgow3Aqswfg1NWWK33DVCY8UGyN8rQKrfKcjz1mOS+tSSBY2vmJnGYi/6LrOvCgPYOaE39RIjkS6iUzJ1b8FO1X6NuIMa0Bmffx69Vy6GSl+lVCt5UL6nszmIUuT0f8HLRQoC2EcdwW1dHJ0S8car7QmzcAXvsZZfqQavQ2jwh50QSlOFXVv2gl7DD4icS6pdJoR1hoMPTjbB1wpTucnjS4PnugdHQarZljRjpNGfeZ2FTwdkQfCLg3todCysFVrea6dH9hBgTH6LjEs3Rv3GNvDj2gfBwhRKN0kzEb6ynfvW1qm/MEPUXx20wRBFdijnjBUmv8AiK8imMEXmmtj6RtEd8tuEv3GDr2U4+nKp68UhqbYowUwSV88ftyML6DC0tATclsEy7o5Abcf0XvuRxe+M47cAjPllSVdNwzVbCTUQ0Lv8z3kz5JMzWln5aDEkGoHu4T1jt/QiQRFURqzA4JXpRpM8Q6tF4Wuh4KLN+kxw3p5mJ+AyHlSrU6JcGq+EyIeI502ilxgyVIDt5i5gzA20k/6t3OtYBvRsh+9//Xw2YbGA2wq5McbtjQULrfM6TOBjR2a1llQ8sRXL3y4vZTU+0ajWsdt2rujUPOaV8wDPYatqo1kgcl+IIUEDsExEmzOb8CAzwsTYS89RytbG5JKhejk/TDTq8YdwR+65AV8HKcZ3VnXA+Qn3/CyOvlMTfehITEdiDadARH5YjcgCNi9TTViFFFXYIRmUnqYL55Zo6b1mflt1Kk67xLK7ZGsgtfAm/SEg7pMIxhHphDYHFSoVHsCQrfXxk1l9aN2IhdMGjTQkgNWLqlcQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d01d048-6c98-46d2-8e78-08db0a313092
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 00:04:18.9674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O1RpgHKO130Vy7TKHUDTGXpj0PHxRJj8jkU4reSqUgTzxgWGkfn5waq2gE/Uu+M7g0Dx2KSlSB52hnUMMN0qrhO3UJiYpYwt97NE4OpqtEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6485
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-08_10,2023-02-08_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=640 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302080204
X-Proofpoint-GUID: bpXD_2pw00sJkvHVudAHJTfXyPkas-wK
X-Proofpoint-ORIG-GUID: bpXD_2pw00sJkvHVudAHJTfXyPkas-wK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Gustavo,

> One-element arrays are deprecated, and we are replacing them with
> flexible array members instead. So, replace one-element array with
> flexible-array member in struct report_log_lun_list.

Applied to 6.3/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
