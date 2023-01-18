Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D76672CC4
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjARXpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjARXo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:44:59 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0024DBD3;
        Wed, 18 Jan 2023 15:44:59 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30ILmu0Z008022;
        Wed, 18 Jan 2023 23:44:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=O0fi0jaT1Gel8cl5HonmsY/gvByN/VUMBggxFFlzMgI=;
 b=kib3NlEBPvl+ZJIn+qh+bEqXN42Yst6e58rKCBskt88bnlbMxuvS2FVUGNaqGDs1+0zb
 K2VIy0EnzRIPG3ZaQ4OPv1HgepZ7Nl7jtb3mltbY0SMcEQlgA0/kDRCUs9Q8QcG9MKWF
 Gtt4JFy6Ug4f5LWC6HR1zfcotLaXHTvCfF8bwqf5H/BzP5bmGlOQxAYUvd604zSCqaeE
 0QAP6XDfVZ038de+xHdo5Cts9UPHN2sG5e/gprVYpXVx2e7si51lHp14cByzww/kzOGB
 tbQhCPABkJuDL05T1bjamCTfvpm6728k27bpCeIDT7OvVO1AqumGvuDfj0NFZmAM8OaW RA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3k6c8xy9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 23:44:56 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30INeDEV033460;
        Wed, 18 Jan 2023 23:44:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n6rgcc72h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jan 2023 23:44:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNqpBGZTCna5vbBSbL0NpwfXveWuX0VsWSKcttZbTODc5+qz/6CQ6TfRIqpZ9BpZkRL4x5SuBgc/0o0aMtExhlZbDOxC/D4+r4CApPa1awM781+EtiMDHUJ8RsSu0miFhmEO9qRtJ483pmqH1J5CoGt5v/GIRa5/yUUU8u/nZz5VNmBba0bqAx3gssnDzsfL4Vhahi+pBtvB4S+fdJ+o5DxV4j+KmFv729cuZsdg2CICpRbvx6h0oPh1ugZlGrI/+pbhwCEtViopwqzqQLhDdTHrvRcRFClj5DfCsuWWlDM6l8f9I5MO38DydryYrmA9N+omEy+26cPOfSj/X4Y9PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0fi0jaT1Gel8cl5HonmsY/gvByN/VUMBggxFFlzMgI=;
 b=BQN7uIixBoXw/GceMirp6Z316M4Dq/gt57aX0SvKv27dcy6YtHV0FEbcJVxtHS3d7wPdz/VVnxF9kLGNNONu4lTmm5NbtCvCnZeNJ2TWzETbhoqnlr1TM2+J8LveFJY4AtRc51mV4j1dArayr705ERtuArJ3P5COEJI6XDH8kk4jBRhzKQLR/cRNhRuC9VvIot00F/1Tyksss9xFxClbF+LA2W+XHOPRzTasZlWrlRdsc8WrwKj9uqZWbS64N+HarQztSh9MGJYYymln5B53yvOkdfXCktKPl6ePXyqLRl8D7H72QVgA1R/7dLJJgnV4VgpUfChRejlOUYHvKs7I/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0fi0jaT1Gel8cl5HonmsY/gvByN/VUMBggxFFlzMgI=;
 b=eAX7kSEghQnAfqJDJDAIqE10S/u7XLiCcsWapSQJI5OhlJ6NrSHHJDO/L7CUhekXFy+ULAtg8Xjv8xZ6gl5kTnhB/DNjPRyHd+Tp0D2OFfVmSaBGhGRRn54g0EFKOSNUMXF3e6zIDqQLVqJABHkPa6axI1z7VJo8ICXne+ikjBo=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by BY5PR10MB4212.namprd10.prod.outlook.com (2603:10b6:a03:200::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Wed, 18 Jan
 2023 23:44:53 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6%8]) with mapi id 15.20.6002.013; Wed, 18 Jan 2023
 23:44:53 +0000
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Brian King <brking@us.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] scsi: ipr: Replace kmap() with kmap_local_page()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq13587pfvh.fsf@ca-mkp.ca.oracle.com>
References: <20230103182556.29080-1-fmdefrancesco@gmail.com>
Date:   Wed, 18 Jan 2023 18:44:50 -0500
In-Reply-To: <20230103182556.29080-1-fmdefrancesco@gmail.com> (Fabio M. De
        Francesco's message of "Tue, 3 Jan 2023 19:25:56 +0100")
Content-Type: text/plain
X-ClientProxiedBy: SA1P222CA0009.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::25) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|BY5PR10MB4212:EE_
X-MS-Office365-Filtering-Correlation-Id: c63162eb-6251-47d6-0534-08daf9adfeee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2/8/S7Q1sYZAjUU30On04e6zMRlTNEwpU61sQh1fN7ZNqY2/p9Jk510p66wGJ0iEsOCIFDCTJXvlH1Y2mw5VmsP412FneDxqe5CMMc4IUSHUqpLBmnv2KqYzUYCW5SAWYdz4CE2ZlNNxfAnjrr6LDUy/LiEdNQWBEkrG/wReXVRUWqohJ3SMDFeq3qJMc9fAwmW/oEuEgi6Uki6xrbD31yzKIG5fIfJRb9pcP5l44h2idA8IieZkKlA65wBt/VNHsmlxLQsKVPUPTRKZSP/4nhcNDgwgSeHTMiYif9HwZPjoS4uH65Ekx9wQNhwifhXZrihvF3amSogWzd+gpHZiueTw78Lx3NstrOOp60y/RhCWzP6wXU/0KlGY026VMFoAvOE7EwtK9VUk6H5+NdimukrcpU7PKueAtewJ8ZXQJQh1JMQGD3LQcIBQLAlnUtlJYMR5reASrGXsZXonVTGqb5SnxanaOZqbgZzzemEyN69biClMBMCJzNVWDeaGliIXT/RVHDTQkwiTTz4aKgi6M8I7GMTUxYP4uJ7bhgz7IdTaTcI3PoD1Ng4lzNBiVjPNDc+ga4j5J/hPf/JhPl2Nh/4GROYHKuZRrbVEu5s1dKdvaoj2ivjGCxkf0WEnTavr7QAnCAYoXevVjPGtyTFX5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199015)(5660300002)(8936002)(41300700001)(6916009)(8676002)(4326008)(66556008)(86362001)(558084003)(2906002)(66946007)(66476007)(38100700002)(6486002)(36916002)(6506007)(54906003)(26005)(478600001)(6512007)(186003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s0ZKzwwkHn+HXnpTD/v/jYb3dANgCGmySmZvho1n2nvgA80QfOVIFYm1P5ak?=
 =?us-ascii?Q?LzQZ06L22eWWqPIgnj4j58oNGe/a1/ubeKI8jJhZZPmUbFlECwWqyJ+y2elv?=
 =?us-ascii?Q?G+DfGcVA2j2XWU7KY23kNIGeUQJ8savmE7fGnbvQGN+CCNyqFBrhp1JUr/9U?=
 =?us-ascii?Q?u9xSaYtZxOsV87xsjcknZkEkXBtIMf5YlBqEY9wdCQWrvAmYq9W5OFsHTfja?=
 =?us-ascii?Q?60bgOSI4nkdX+SwfukqR9CeEEKJiZcNqR4nfbBC4ayo6rud4o4qW/MHehS89?=
 =?us-ascii?Q?hTPAeF7Vle4g0YHQsmL71rGNN8M9fLGn+N0FxOvwMl9Ih08NeAlPr11oewk5?=
 =?us-ascii?Q?kT2Rnud3eGEtZnpvY6Eu91/JYuPV33HaU3s2Uo6tdIbAAch60GAG5RMuKAq0?=
 =?us-ascii?Q?4kTb6XNQVS7Ortb8eLDoAn8QT71QoRtx1fipfl4q5RLjy8P1k0d3xo4kleGt?=
 =?us-ascii?Q?uPFH6LRajHhSR9zPDr6g2x2M7NtxG+d+sJXgPCYHIi740UqBhSNo/v75Epas?=
 =?us-ascii?Q?NutC4S2TGVODkwsx+fdmpXkMRHLvsLdXMz1FzcNN4I5VcsHHUcXVHJuMlr1Q?=
 =?us-ascii?Q?v8w2FJRiJpDLEedhDv1HzhvsesTR2EdzmeCV2LiMT9gQRYum/W6uCaLNE3dP?=
 =?us-ascii?Q?8CfozQfUJDEtQoQ8xERCK9jNoJHl1+5IINk6jOr8nojUtYnjPbP4xUoOEa4N?=
 =?us-ascii?Q?yqMgsMilrcDa5B3nmSNPgx1upV5npoVO1oILLQNZK7hWFu2L6uYadR9MwKCx?=
 =?us-ascii?Q?hqIjzkyZRi0UNx0118/OLAWG+xMrN1Xb9Xe4/y3bZY9wi5CjsuzPbkPtH1TD?=
 =?us-ascii?Q?wOdm2eF9+h62T+RXvaCSpiJf9+BVqg0C5gNLY851DrF1rcVe5JgPvPKoT6tm?=
 =?us-ascii?Q?2Ysz+dyaFUjQTnOHX0W4MfpW5LMOL9vdVMkorg51gODxTrCRf1Phb5m5T35l?=
 =?us-ascii?Q?K1RFfxHXGKwuS4g75X6jO6bRBdukRVAQ6n4w3/Ii3QQ1GY3WQHGPVL24ka7t?=
 =?us-ascii?Q?1yqfP8OoNFihQvCPqZ0NsuAuD9qy/TZifuE5GoyAma1waRf9ubkVNyT4Ngqx?=
 =?us-ascii?Q?QZ9qIP+Bu2qsYxPnXzkkOKwcX53untRCkp2fYnEGENng/gYEooNhlULxulmg?=
 =?us-ascii?Q?ghSY7IAczc8i4J80PEDuxcDJ7Ngai4mbTSIVajZCT8cTHvsbwNoSvsf3mLQQ?=
 =?us-ascii?Q?7kE0g2FzysEV15mEF/XquKU5a5SiTnj5Tdrv8buwehfAiy+1Lyk0daT+WpLG?=
 =?us-ascii?Q?RYyWEoTsX55wmPJhZFCHDwMLWtCGlfll/6dXTDZJix6+QNqW2PMM4yELP7RN?=
 =?us-ascii?Q?ExUnTdOo08rNRB/AH0jX7gfNQp1x7gPjl2D/QWZGOrTxZW6IMNB34V98PfVW?=
 =?us-ascii?Q?O9wDcpajM/YKa55q/+osumAlGDG/gSCPu/+1kkdSHV1anYqb1iIiAnRBtrra?=
 =?us-ascii?Q?96mtQwLUBa8BuQihsWeENjjQwyOiCRQt6nU5XyBGuoJE+0HI2/AAWb11C8uH?=
 =?us-ascii?Q?5Yvq1Hf4cVkePs8rGSmrVlJ/fzhLaY88sIX8koEapX1gQ+tD1IDFxbMVdwlk?=
 =?us-ascii?Q?rw+RYD5nV/7x77RpPLhCO9QdkIXMwofGScZOo6YTG+xtT3wx7gniRpcO8FJR?=
 =?us-ascii?Q?UQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: o9gdsFBz/CS4Q2TcaD6YtEEwz8jaXQyjbLi+e8d+EAlDXBYSbGDo899P5tftamCIvruhttcA7c8Gwrkj0FAm5QAvnUGkDmdR+qVcvMPiy3DcE40+rOtMfPg5ZfbWmr1v0geSUIT3opzzKvdChqynjrdhrqxuNr6X8wimEKxmMRBXUk8Jd+cIr2dGh74uV7wf68teUMYwL/5sqx5kS175XwoLd5tjHh3haMfdnKdkxEfertOdT6RJkq9AXfG7eFK4wewxoa/0mdIksbKj6fw37eIm20f2SsX+jDYvJ3Pc5bKjedGpxVFLEdpely3BBvB4hAACbXBAnVXmeLdEaIjFbeuSqAyNiNbsh57sxGmWqurv/S2eZy9OYNGKBYPp5a9zDvBrw0lz2g95cZZzyVdnSaGtsWEZ9PARQBeCcH+6hEirrERcFcHRDGhags1Ey8fdnX9TPIDieVi14ZAHDbFHzbeYw1BChWpF+6W0MPv6xMhTSmJ47J5ufxa51jh68XP6enqms4nUbHnGuTtZRS9mJVc/k1rRI6/uKTXFu8BKmCKffY8kojQ3b87+GmNTIqf7Gf6BatBJHf0QVqofoz4eZpjzcmgep7FzTF7DElR9+W5Ba693LRGHBDUHe5ZZQLUzz4RqMerj7WuB5sr6/BbWihj3Sd0IpLOXKvz05eO3B2hhblT7bJGSrjvfxGTcdVYwkPeYzWP12coE8viQeCGg1FtnAgzXanNg+9GqyeXcYlbEaY37/AuU3uG/jEsHJ6XL20qkUNmsa0ViGDmbiXn1jGqiwJZla6WjWUeQEli90NZCoRXJ+av40znkODCftinUACO7j72yQPeaZ/3KXirKbTRGqLrUGIQK4/eqw0aiQx1PyzBqxhAy4cVGKASL8Vp0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c63162eb-6251-47d6-0534-08daf9adfeee
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2023 23:44:52.9579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ffVOdK9paNLbMJ7jTP6eDn2h4IhpFvzJ/2IV5IJDjbWuBf11ZcAUxpL34YjJ703MYP5hAc4dz4Ymo6gzOEaJcHpCQJM6zvWvaQLev0LwPpQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4212
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-18_05,2023-01-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 mlxlogscore=770
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301180197
X-Proofpoint-GUID: LzBCcdINePjS79gLmqlEr_1xI5bSEDEB
X-Proofpoint-ORIG-GUID: LzBCcdINePjS79gLmqlEr_1xI5bSEDEB
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

> Therefore, replace kmap() with kmap_local_page() in
> ipr_copy_ucode_buffer() and, instead of open-coding local mappings +
> memcpy() + local un-mappings, use the better suited memcpy_to_page()
> helper.

Applied to 6.3/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
