Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33BD660B20
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 01:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236266AbjAGA4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 19:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjAGAz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 19:55:59 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F737271BB
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 16:55:58 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30702Cot027163;
        Sat, 7 Jan 2023 00:54:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=gAsz0+cBVDR9pvlJDuQqVlj+Vdiv0HaQ/P715jlRUYs=;
 b=RFUq3+5TcUv13tPBNWhGTDmge+AnMMvfQyppUsxDSnr1QdvonVZ1AU6WREv/io01jMGK
 MyO9JslIFsuNHL7f+uY6bt5SPDFwOJSsT4gffHhEyfW1wJoxEuoPcJNwqlkRuNUMoObA
 FyfCEUcKEhU45XdK2AKAhmJirh2xkqt+FDMGIxFZk9x5Rx5FxXKS6lGrf/gF/JBc+KtY
 W4LmKNENu200mPYRmo/Gej57XbYyD6AYUsxGWKyB0I/5xLWpVaVLpt+MH0lWJa5ocGM6
 dl1MPuMqO9KiVbNOIvJjcxIH2QSBp0UNIdbEEmLXy2lh9ZhmfJW14osIFfZug9DTXO3Z nA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mtc0ave42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Jan 2023 00:54:50 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 306N6q14031183;
        Sat, 7 Jan 2023 00:54:43 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mwdf2ewrc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Jan 2023 00:54:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MIyje8pZf6zy2Xkv5s3L/LJQam4qiIkcEpoJLzsmxooUGCEO3innanq/FGZ58SJS1eXl/dta0fQ5PKSdVuCKSbXoBHQ8aYUTyLKKOUpPWMaMcj3cGE7yMO0Me5sWbRLm+wQS/VSHwYiuKaSyTB1GjaswfDhG0N0QL5pVCL4z0eCon377d1IWIVZcLmLi4U39ivwghkpDrND/baXptoMBpL3rHuYFOLky5bIndWzfFD1YeUcFbCgrg1zKFVyfqBGST2ooJffRR2cpHzuEjWAHAWM9xQ0/z4IS8pH0bwlxKb2u0pKcZ7sVxwr98KHtnXYZdFE1IKHqEdkPpMgG+ptaAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAsz0+cBVDR9pvlJDuQqVlj+Vdiv0HaQ/P715jlRUYs=;
 b=dhRfJ2FtCoqDezCGirjLwxF82sxz1TRggmv+PCqR3rKm8R5epc4H0Jv0eKBDDyn/D3PUVBwZh1K9f9a4804aat9mDILG85gqDWJeXcL6g/qv7zZM/SvJAKA2JWfW5sJ52UxGnaXxFijRBhugn3BdKXjFvGCqGmUHL8T4hj+Sdr9JkQCWffHTdpBqism3JzceH4pvLHiaH1QsREy1Ris1R2/PCglnEwIzjXlGc3UuM4aXtQVamOhlvN4Hyu/D4xNalCMPBrDKC7xCh63Nwg83rpGYMXLEaEInUFYx471+cT46ZW+2XkG2wsrYE4LIRHoZgA2sjKGYC5h0vrDala7tRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gAsz0+cBVDR9pvlJDuQqVlj+Vdiv0HaQ/P715jlRUYs=;
 b=HjjtBxirxl5D9UaSxD8EZSev9WO2a/YsUs9MKOlHTNJGf5eQX8kjfhmyKbt56wxmPnlXOhfJDluamps0qA3L67QvslIwrN6yn+2jFoGEqV1sib9+rvsupB3JaIsyOd9vkIhOwUs18+w4KHWtVivhNXIhRsduTp5h8oaq2JLYAMI=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH2PR10MB4326.namprd10.prod.outlook.com (2603:10b6:610:78::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Sat, 7 Jan
 2023 00:54:40 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14%8]) with mapi id 15.20.5944.019; Sat, 7 Jan 2023
 00:54:40 +0000
Date:   Fri, 6 Jan 2023 16:54:37 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, tsahu@linux.ibm.com, jhubbard@nvidia.com
Subject: Re: [PATCH mm-unstable 6/8] mm/hugetlb: convert
 alloc_migrate_huge_page to folios
Message-ID: <Y7jCzW6oqlHpxusA@monkey>
References: <20230103191340.116536-1-sidhartha.kumar@oracle.com>
 <20230103191340.116536-7-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103191340.116536-7-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4PR04CA0135.namprd04.prod.outlook.com
 (2603:10b6:303:84::20) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CH2PR10MB4326:EE_
X-MS-Office365-Filtering-Correlation-Id: 3764239d-7a80-43a7-5b27-08daf049c1ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WkKdFreOvPdcrm9SSIb+jXe0ula8BWQCNqv85Hd4zdz4CGWzlHTkhw0ho8BX0o2qI70G8sQjwzES446AdIZMuxu9PGd5j0jKxPkzJ6/WMQkfq/ivexS3axzd1MFUx3kXAlGDt2DEYLByRVh1vjhEMSB14GF99MFsCEfmHDsdmzt1Ol059FiBz+ucR0m1+uX3PHLBAzjA0NcftJKE6WTLfb6pYE03mMO5p35GsDiYHTb17t0YHC6R3MWrnfYhnS40qS4W8kfHurBOL9EGlITyuguJY1dC1i8y/yZuZ8lLh0S2wmwGrTfXEhgf2jtYXiTv+blc7/ksiaVc1QWKRuWZU8PBr0VdN9Eou8NXWW+NXYFqZ4r6lAP/rf7SRSHx5tG2RZYMd8oiWgv9ZQQWtwf/tlw1QLxmp8Ymzx4np7sdBX7DydljiKxO/yUTflblwEgdE4kQkw8JWsgr4spJFfaJhOT90Jb1VpB1qTq/P2nUMykUd2lW/34ETHgOq+3sSLAo23baDoFfh6AN4AzUmtNH55CU/WjSwvU5kMSHmZddUr9pRJ2Db14U2j5ibUfNY7SeCzoWwplEYFkzJ9o0HPsn1uuwebF6dNzvJu0McF8MTYIBlbF5Q3G8qRui1VrFbRx99/JD29AHx+ix3IvxhlYQRFvPBFk3qXKgg+a+3PSxyxR6b//tPUykey1KoUmZheWo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199015)(44832011)(83380400001)(8936002)(5660300002)(6862004)(2906002)(41300700001)(33716001)(86362001)(26005)(6666004)(316002)(186003)(6512007)(9686003)(6636002)(478600001)(6486002)(6506007)(53546011)(38100700002)(66476007)(8676002)(66946007)(4326008)(66556008)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Rx/DL+t85wgDsLUXiyMsuQMrwKHf0w6bTrY+ckcx3WgFjwBwVZ9MqLOECRNM?=
 =?us-ascii?Q?qpjMITN0F7OxiGSvNkgQxsS89c+OREKt6sJricWEjcIuTrTqLm6ugk6UtO5O?=
 =?us-ascii?Q?f/tjUCaKrnqMPDUqnu0/xsyHzy0HUuWDI4iEIEKjhWq5RWCLwwPsGABNSLPi?=
 =?us-ascii?Q?OfHzDNRp8EsUCncjIz/tFGJS9NXxIuHGif0BmtFgsZBmjAvtfx9c/cu0zBi3?=
 =?us-ascii?Q?Nd4hpiwsxseeCD7LUrONT4gVyGffRFA0HYaBUsqsYYzgiJQQl/J3rSW5sL1M?=
 =?us-ascii?Q?DJPjXT0yVxPvpZuUQj/DSF/07IJnb2fdNq4GI/MnzPHPRmpMf1zLME/XRmbC?=
 =?us-ascii?Q?497SLQKCdqz9ghOinlMvaIUuqpYOQMODU4GbFc/1ef21Mecg+1PduxlV8DKA?=
 =?us-ascii?Q?ECt1ymuVmJRj5MDRCkJfV5ZK4bdXEI86V5/ip5MvMfoq9Sdh9trQjJBGdKd2?=
 =?us-ascii?Q?fHXNEGqWzFzwVOx8oT8GOZUFnJ5F3v822JuTy4iatgnIPgetSNHBuBh/kfBm?=
 =?us-ascii?Q?pCjMHyI1PgF334NYbvwLWifdiM3Kc6STCesYPKzDS0KZIYKsuXVFJCgcxBol?=
 =?us-ascii?Q?FKaOiBuBUT+W2n8ByctOzm+NraVadsbzRBX1nHxkKjZiRzS9546c7pQWgCym?=
 =?us-ascii?Q?awa76kVr32aCW49MXc9XxNQqqG2YpwLQUYm6wgvsx4aMzTZMf5P0/c26WdIM?=
 =?us-ascii?Q?reCiNZiCv7vbsf8rEJcqN1oTQOgeAYQm1BKaUwcqf2w5c1uTnYwbqzy638sy?=
 =?us-ascii?Q?KSIIT/W117DfYbXx59BvxSzwNs6etQIk06AJmI9/kj8mRWSQk4gUfyWUETUE?=
 =?us-ascii?Q?DLO4JfOPL9NBJL3RFFCOXsuwuTVvHufgdAlULO81DZTDTXhxFzD5CaNWgAxB?=
 =?us-ascii?Q?iKU2lccZrcLG3WeTuH7zHRG2lbDq8KHYj7r9vsqsy6KquBOov3KpiOZYQo/V?=
 =?us-ascii?Q?TkWcTYGX/CJfaNOR+wbF0ytmBIskgQtG0vTgY6SGkTj2wqWcdw7dDEeoY1o7?=
 =?us-ascii?Q?nN2tuK6hy3pGkdR2vAy7NgYHjrwzeRDXo+R+Q7JbIebKcVO58pSKjypDY3N2?=
 =?us-ascii?Q?8KC//vtmWg7qJ+fnLlw7Kt7iJC7poMW61oRX0rj1gexw1ofvmltU3CqO0otm?=
 =?us-ascii?Q?nzYeIHlQPkasGAUk6RlpH5W7MBT5deSeWTTb1GQqlccI1bcH24n0IaZzT4Y2?=
 =?us-ascii?Q?JECde5BikshAq4+uFw8/Tf26/q6MBrqZpyDHpmRL658G1rDQ+0jKZdnoIVnQ?=
 =?us-ascii?Q?RUFMZm4m71Vn8I59O8nwulj6Zi4p01OfHhw2mgx4DOicTordct1XgMm4Xg0n?=
 =?us-ascii?Q?5Rc3894PSFbkV71hTWpC0p3d/T2S1en8qQ+9pKk32ks+qyWdPgIZBz5EWGoc?=
 =?us-ascii?Q?yA6ePoEigAzT3w4umOyAWYwMLwkCSN5cTbg+iHgdoADFUqL6PMymqlM7D6Wf?=
 =?us-ascii?Q?EL4TA2xBNm0Eir1MYceCYDsYWbhnuQ82XRdEC1rcFFaDwufxIuytWc82D9Fu?=
 =?us-ascii?Q?zGVnNuqY+F+SZ4SY8BbC6D7MUYfOlSMXVykn3yjimMiKkKRhd6lepE8uX0bt?=
 =?us-ascii?Q?wi+ERIGX7nAZ600y/hueqBWkc35K4sTuRI2Ocj1bFB3HOUfJMXPLxLq45slz?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?vL4JO6MFuEfpaeAYnQo8PzXsqSRLvyP1bZi7xtZsCHvohnCJY2WIQGVFIGX1?=
 =?us-ascii?Q?Lfk+gRZfjioYtbmbtgQytHAoLbB5Zoz6oKYVyk8rkrt3BvTm4jaGpiHm9+uv?=
 =?us-ascii?Q?TYRb1W+F2hOYozM5En2kiSpI7zJQy4YJK7uGozS3Xe/pOZAQltbFVEfnExN4?=
 =?us-ascii?Q?dIkaHpsCDL+R+AB2Kj44dzlprhKASiSmC1qseYKbQJ7b1XEK9XffQaa39QfP?=
 =?us-ascii?Q?vw2vswX6Ij2oo0w88OpXuylFzMiECHQjjWwLOMv04sof4CSU8bMcoxp7Z/jh?=
 =?us-ascii?Q?jHpO7vNhTljYcY+4iS9gV4kD9ITSGoIva8GlAx8Sy3+O2cM/TRebbMrq+2cz?=
 =?us-ascii?Q?69g4PmvhWj2rpez3BE803Wsf7G31/Ti6eVShfrFzh0NIqoPD89G6lKCRl+XA?=
 =?us-ascii?Q?N1RBnBYpCYIDtdJK5311pkiCqZY2At+JxT4eVSl7bz/YZkc4r9gIDelO3Sfo?=
 =?us-ascii?Q?9SDq8pxCy0vuWtRFdWr6MBlJlooAjDpxC7aeMvUsfgm9/MExNhIYqRDLtfXG?=
 =?us-ascii?Q?ximHvCKet7CBVTdxEgri0FCq5ulSwcEsX4jXyRveUdZyyygiO04vUA2dr1KV?=
 =?us-ascii?Q?+WfXHLNU3LOVW/Yp8T1/GfHWaopAPsfrdmo2kON7CEBxWFrAaKWI7gxu6U2a?=
 =?us-ascii?Q?+BU1VGeobGfji1h7XN3k9USS4jSG1JI/b5Y/AXk+ji8wZkaD1vRVOzKXa7uN?=
 =?us-ascii?Q?LWcRoCo0ZX3dV0qsrogl5AHokF4Gc8c1EOwyfdnhp1FuqoxOXkQmBZFXBDuA?=
 =?us-ascii?Q?LYBGEQAboAHcdkMqJ7/my4ZUV8Vf//cSw4kpo0ZLepBpuuiMw+Cu4wvwMKMv?=
 =?us-ascii?Q?iu6Wk/iYTEWmuWtgGiUSgZ8OcUpx8cFqVxgp1QSX4yvsuvFnBqGDnJcAgtlz?=
 =?us-ascii?Q?IgRqetrwzW8LIwYp4wFihsPzGY1cd8sung/aLpRyI0IAhFIxv3+699aDrRcO?=
 =?us-ascii?Q?gC3elpKH8zT7SMph3J72Sch4FaGiLyvQA+78W5Z2SxU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3764239d-7a80-43a7-5b27-08daf049c1ac
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2023 00:54:40.7358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rYs1smlc5ZsNBK2tdCE01oswIyJiRLmeWWNlWnAvPV7RJ5CQYJpWTJIHEBewgUM3NpBeyJyuHCStABUNeJqQrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4326
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-06_14,2023-01-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=944 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301070006
X-Proofpoint-GUID: Su5UU6H7WDGMKwtJHBPSnoVnmz8zn8R3
X-Proofpoint-ORIG-GUID: Su5UU6H7WDGMKwtJHBPSnoVnmz8zn8R3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/23 13:13, Sidhartha Kumar wrote:
> Change alloc_huge_page_nodemask() to alloc_hugetlb_folio_nodemask() and
> alloc_migrate_huge_page() to alloc_migrate_hugetlb_folio(). Both functions
> now return a folio rather than a page.

>  /* mempolicy aware migration callback */
> @@ -2357,16 +2357,16 @@ struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
>  {
>  	struct mempolicy *mpol;
>  	nodemask_t *nodemask;
> -	struct page *page;
> +	struct folio *folio;
>  	gfp_t gfp_mask;
>  	int node;
>  
>  	gfp_mask = htlb_alloc_mask(h);
>  	node = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
> -	page = alloc_huge_page_nodemask(h, node, nodemask, gfp_mask);
> +	folio = alloc_hugetlb_folio_nodemask(h, node, nodemask, gfp_mask);
>  	mpol_cond_put(mpol);
>  
> -	return page;
> +	return &folio->page;

Is it possible that folio could be NULL here and cause addressing exception?

> diff --git a/mm/migrate.c b/mm/migrate.c
> index 6932b3d5a9dd..fab706b78be1 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1622,6 +1622,7 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
>  	struct migration_target_control *mtc;
>  	gfp_t gfp_mask;
>  	unsigned int order = 0;
> +	struct folio *hugetlb_folio = NULL;
>  	struct folio *new_folio = NULL;
>  	int nid;
>  	int zidx;
> @@ -1636,7 +1637,9 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
>  		struct hstate *h = folio_hstate(folio);
>  
>  		gfp_mask = htlb_modify_alloc_mask(h, gfp_mask);
> -		return alloc_huge_page_nodemask(h, nid, mtc->nmask, gfp_mask);
> +		hugetlb_folio = alloc_hugetlb_folio_nodemask(h, nid,
> +						mtc->nmask, gfp_mask);
> +		return &hugetlb_folio->page;

and, here as well?
-- 
Mike Kravetz

>  	}
>  
>  	if (folio_test_large(folio)) {
> -- 
> 2.39.0
> 
