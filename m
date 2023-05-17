Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D697D705C90
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 03:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjEQBmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 21:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjEQBmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 21:42:13 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EAEA2D73;
        Tue, 16 May 2023 18:42:11 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34GJx3EO021329;
        Wed, 17 May 2023 01:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2023-03-30;
 bh=WIvendoBg1kZVZHpdCRTUUmDBfpXnofqOaQvC4VKhR0=;
 b=tOd5/xFWzIYUn3xBCBhExRDVGc8JdEBnEijO2GXrvMGOR8S3qEDnnMddRlSJTlOfcI6q
 FjyAH/mRHDFYFDymd0u/dQEeBYdVLvY2f8wyorEJ0L/ohU6tmx09mzByauTeTzEB2HED
 QDp8Nem2TyEeLObyNC/SqOL9V29IvSPlutMwjM5RHjV5BbP6u8JimRW0GB9Y38+MBDVL
 O8c/ijovEfoWXsr19yO2VszQNdf8pzmqWMpoaLwgxijqXYZo2EOjZnYrIQ5u+RLG7JuX
 VvIMiV+771oAe1V1uhX4VrqNUKK931rB+k9if7ZUWd6ZRqicDthpJrYwqFn94GRmoPf6 8g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj0ye4eya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 01:42:08 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34GN8kkO025047;
        Wed, 17 May 2023 01:42:07 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj104tave-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 01:42:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGtizHos4tZaUdTMfwLiSRs6Zs0Kz8Uann0JtwWNKdhi8OS3S+ZwZfkalZZ/g4axQRZZGqGW1d2JXxAE4MxLhXQwcLVNmPBZvmvZOvqM19WN8nlSZ2zZ1Aovqr4/PvK5F/KkWzPbkm9aK8zD/0Kpn8kidWbHwaCs24+bnEJfD1MqVUHOb/equaHZjcXg6V5jyd2N1MLRcxgC3qiWKvALSYp0Qm8CkndGcvaXgdLa8OUhRkUHc9bsSVyVNEmJO3+CPsS/v0YWhDK39Elro0MmZCsi8inwD/sMM6xQ9f2GozmauDqiZCDfXCLorW4nk7nSFkb7VoPNk8W5e5ntaxEnug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIvendoBg1kZVZHpdCRTUUmDBfpXnofqOaQvC4VKhR0=;
 b=eaPBqUNfTtGaE2vzrH/CDvxcFvw1RdEKY+T14GfEbgd5y0uWaLBY7QsZgVI64E2FWSabFXIg5iIpk6w8n7eJQ+nQCj+isLfgGNK+K+iYIsonHH/6nrMjTV7CdLDzZQ8KxR2kVg/pv+BG3jJztXDCOLo6nmgCthYji//oEYQCdtq6GUdLwM3pnyQ1uvvqIjcQ/5Q5iwfm/EbOOLnfYD7PxqQWnmmtp5JcOUeqgA/WIeL0Q85RtgTr4Nt/9EO/A7SMnU+9hBQdq0lhz9V2GNavfeK26DpRS62KhUwO+GZtTIr40oZMUy4nOESePJ3NclSlMg/NQR5HFqh2W9m4Q0WbrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WIvendoBg1kZVZHpdCRTUUmDBfpXnofqOaQvC4VKhR0=;
 b=Lz3RaKGKkWYCzszAyCsx27gewMh2mmuI0P6yXDoaihqCdzURwpIMC8RXtjm4px5AKASvhhUtg55mFmCPd2YfbveaFtXMmPwbrQ1GOOIQobj4+WaZY/pAbCnQVweBItFqqaSx7V8k47WkJT9DMrv+YG26TOSlC9KvUwNi/FyoWPE=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CH3PR10MB6857.namprd10.prod.outlook.com (2603:10b6:610:14a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 01:42:05 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::9a52:4c2f:9ec1:5f16%7]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 01:42:04 +0000
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        linux-hardening@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: qla2xxx: Replace all non-returning strlcpy with
 strscpy
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1cz2zu42r.fsf@ca-mkp.ca.oracle.com>
References: <20230516025404.2843867-1-azeemshaikh38@gmail.com>
Date:   Tue, 16 May 2023 21:41:58 -0400
In-Reply-To: <20230516025404.2843867-1-azeemshaikh38@gmail.com> (Azeem
        Shaikh's message of "Tue, 16 May 2023 02:54:04 +0000")
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::27) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CH3PR10MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: 99c27512-53e6-4602-4adb-08db5677eb09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XkEv8fF41iTTzOm77nkoPxDsfMyBQ4I7ewYuaMNdQ+6BLWxfL9XFlnVv/E1iPLsoqfjhKaUhvAry9QjsMyOxMcC3IuCMt8f3idZZeJvyOlsRr2nOyUytCnf8tvy6sWJ5aD1YPV6BGIA6O0TXGUAmiIcQFdyvbFnszRJF8xfFZ15AePTmlEoIPKZaBYn54bYB3AXuBdGAwBWAC/dgt1n92s1h2fbYambjc59+3ivK3NGRUtjRePQ/gRzD8qq9KNjrYY0VY6RiWFfKlJcQ7uQNmzRyczPEBeQ6QJyni8xlQvKxRhjHJgFblcDpe7qGab25hTuk1CZdCUy/dy4pvOU3m6YkJX4yWvAiBNMXmL9Cd3aHx8WcPnFHa0TazLZfbR6pPgn9dumD8ahNKOD+e1qyubPFF7/V6kINvNtrYlUP6IJ3BamS6RxPC/q56ku9JgpDBrsjlDmFS+OG80ISbhJQ9gFpRJK21dFAtg9m3kqvPz42K9Tz1qvWzqpDOqz1LOohmxRdELMkc2lbI1TidOaTR9x9Doj02FsIZtIBVqm+mP755IlUqZwQJ3DZqJwl1DUlPW23juV6nslLtuvC71qDxi3m20EX2wM1RGnr0RCuxys=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199021)(36916002)(107886003)(6486002)(83380400001)(6512007)(6506007)(38100700002)(26005)(86362001)(54906003)(4744005)(2906002)(41300700001)(8676002)(5660300002)(8936002)(316002)(4326008)(6916009)(66476007)(66946007)(186003)(66556008)(478600001)(6666004)(156123004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jMVESxCkcVDApb5cM+uQkgB1hMv1DbAPlbVhA5Qfy/NUlJarIiRN8E6hZueX?=
 =?us-ascii?Q?kuNEho7LlD2nHoaYx3zOhvNadXtKiMGcxQTe380WLHIg/WDG1mx/ZrZ7Bkja?=
 =?us-ascii?Q?AK8DLJKOx8PsHoft33lqgpr5W/Cn0fNs3CWwFLaF8LYz6BcxQNvgxqjGdxar?=
 =?us-ascii?Q?CKF1K8dn1gkhCTCjRN4LLobTlFMdR8nLwfW25bM18L8VA/14dnZyDuqbU4OM?=
 =?us-ascii?Q?9IltHUyFuRwa3cDFEGz2mGFRl6xIgJYOsE7uE/Q1281hcP5OGNNj23jFJTRK?=
 =?us-ascii?Q?8PvnkwgMQw04Qs5zY4nJV1IfLOpuxM+AZ9ZICmSc/ViXUjYkDvI1d5xh2sQM?=
 =?us-ascii?Q?vFzo4Aj9WnEoMzVn0MaOEnkuNjXBFuqT++XhDwt/GPx1BuMsEUft1NUNsb6i?=
 =?us-ascii?Q?xc6FJmX9wDmof/9mxJ8LcHEui7K5fQQskPTNmsOBrUsbskuCGp0kxYITkRIU?=
 =?us-ascii?Q?kPTfrnwENuomz/bZC3JQ7WdAQe0baYbM1G8kFl7tT8L8ouZoo57e7PihThaS?=
 =?us-ascii?Q?umxOVOZYoA9/9bSoPVl2oCqig5HpJOwNk8/nIudiFMFcLrDtue0ZoosYw9cb?=
 =?us-ascii?Q?ymydU8KcvnDQg6Tq3NFXS7zF1RL8kDLzZHacAa0tKaLU228U4CArD/f+qGKl?=
 =?us-ascii?Q?xNPJZPeJSPfNxHALknsb6SJFePW9UxOW1eun96ithpEV/hqlmSLsjkE/HyPl?=
 =?us-ascii?Q?1h4TeZOgfAZld/G/rby1L0717Apym8QQPOVLnHZG5sW+6j2lRxEROcvv1lWA?=
 =?us-ascii?Q?UR7mRejNaFJwXeWwOnSs7CEy7k0hyLHji3xFNbsi8EMXJwkFzWlocGTAHMTZ?=
 =?us-ascii?Q?sYOiTT9sc7UsfQrX4EiSOKP+K0X4ZWL5g/oHpSTMcwNoYkqD2RRwJZ0TiYmV?=
 =?us-ascii?Q?d3jquviqmgpiPdZRo+tuKRbg00nEk+G+sP1olD7ELHv0XWzJd+B7aA5aDIu6?=
 =?us-ascii?Q?8o/AACVWKBZAi7vHMDJsXulmEmhywQwLe6l9x+3izgB7I2zvz9yB8tiWLjvZ?=
 =?us-ascii?Q?rO3E5hBfRq3JXNJ4VFR4zYX+cqh61C8nJTyQvtc3MYzvoSdvpwmLElmw28z6?=
 =?us-ascii?Q?SEMO4+pnsq27izbF+QvUy/SMowk4m5yHB5ShQcopV0bLJ8OkEgzIpQDuvWFT?=
 =?us-ascii?Q?jT8XeaoH2Hks7pyFM7e9HoKF0PQJ+Yk96wSMs3rj5K//PF7sa0bbwAOjg6Ih?=
 =?us-ascii?Q?FRLQBLQbHydwbfptxeqVAzAMJX2mvsAg2lvQBnnfAdkGZdO4AXjPqhdc84+F?=
 =?us-ascii?Q?F0ktyonXx1ODzJTyQ9wRTNsKKczmpg2DXP3lFkaxujb48u6jlHtE0oF0oS5l?=
 =?us-ascii?Q?qqnfJ1pP7//7mHt889Ns1lOwEb0yjFGNLKRYZsUAOCcle3QZNwcWXNqWCg36?=
 =?us-ascii?Q?LXoLPc39g4xKh0TIfotSVIk52C+AQu5HUwuLVVTwIUiAwUO+pTS5PkpHmjsv?=
 =?us-ascii?Q?Y+q2FJ03a/vmhDLR8ipvrIaC9/DN2xVRGMasb5fdXsYMKJu7AFHWSdPo63ZA?=
 =?us-ascii?Q?xz2+N0Nc4TPb90c1RJaWnnKm90gpeZCuEXo6+LYIFeEEuLYeQMFefM4dTozQ?=
 =?us-ascii?Q?jhWu//WI5Ya46uVionewuPKqVYfLIxzp3Mdml/dwr/NbVj1dWElHRNo7sVts?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UItP6ZLYMduRTZ9/DWftvbCx4mbL4mqPJ7aSNF4AHmPA5NqOJpX1WMRC/4JjZ5L7Rbv5PfZsc80P4GrUMoE3jA2v4orsiEnVzffQaQTM6a1QrEnCc4CzidGIS25RrpI8pTfvDx0ngskflBnTM2/lopXJTloD7ARsWUTrHlbTx4tf+zYnAX/iaqyx8//8ajvK2HekGtyY1gfC+VvL2+vh28dQBkhHrGUpSptzQw2cWeDASe8qDqwt+QNhdasoHGn1ypT2PZcosJFVYVCv+Tfz69PBLwTiNpOSxy/IqGoOQrvh4YyhlL/gcg9jbwmUm0qfTbn5PM7nN+Er7fg/KOcYRZwYc8Y6Q8DCv93+6X7dDdXvjFbG2qBTp4y+Qw3jiB0bRZwiQbTaKGRgrkOY657yjSaGAkuIQew5KPuBMKAIwpwYA78SdfCBm8Ou8bjHCHqY0kIzhQ7GgipLv9zmqH6G8Fxk7h1FVyTXbiurEVj10BLzDGfI2EFuFbhuFsYYFSguiVvp8dnO+ZYxNzabKUJe4AThw29e0hvkchLFhClURETK8FHms1y0reT7pM6P4fcwQqT5KfaFP73+5lcQG5m6gns8UYSKTHSQDiqm9mmr/88byeoUNspVeDvYvz0WM3LosdpV7P1YI/0oXKFlY4vsvvFk4LlmAuRAiGH54PxGwE10r4UB4ubycilC53CYNvFtLY0Ozb1IfT4Ya0qEiI4evxGpOJ+FRBi2+7KAMfTj1Gt2l7Ph/UNDFMyJAw4T99QbAY6f1DoWF2G+Abq7zWUu3/MMANE19QEAvQgIaOhOgXHus5im9rw6wzR7RSPpJFWK4FMmDaoLkwTQPSxqVxDuXyebEJuUWtvqW4vG1sJeBWA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99c27512-53e6-4602-4adb-08db5677eb09
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 01:42:04.8651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2/tZT1Y8TkjeZyVLn3VEblo3ZMb0tdIbTAhByPZnRXPPAMbx1pbb4tjFnHLJ3cJXnliUsNwmwy2aUlKlKguXefzkpmdMvBzTXGTWdvxSYX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6857
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-16_14,2023-05-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=941 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305170012
X-Proofpoint-ORIG-GUID: PCRKfxpZzrR0P5QyCMHJ3vxK5pkotKPS
X-Proofpoint-GUID: PCRKfxpZzrR0P5QyCMHJ3vxK5pkotKPS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Azeem,

> strlcpy() reads the entire source buffer first. This read may exceed
> the destination size limit. This is both inefficient and can lead to
> linear read overflows if a source string is not NUL-terminated [1]. In
> an effort to remove strlcpy() completely [2], replace strlcpy() here
> with strscpy(). No return values were used, so direct replacement is
> safe.

Applied to 6.5/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
