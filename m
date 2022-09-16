Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7E55BA48A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 04:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiIPCH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 22:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiIPCHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 22:07:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D279091080;
        Thu, 15 Sep 2022 19:07:21 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28G1wwrS013432;
        Fri, 16 Sep 2022 02:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=scCH+h51keDgOLhbGIcaAGqj3bs+A1rdoNJQN/gdVAE=;
 b=sGvV3thvz/YuXYXUh/OlKxfzkSxMm5xDivaU5JMpYFocfr1bLCbpiJE4ohAC7nXmUvma
 C+JEwV2uFtJMUW4fjhv1ez9lPbT6/fTEEGqYMA4apVMkNKaHLL/3RLzwOMpdXeCN+WCr
 stc18szhkbpy5zWPHkgNp0FgCCvDjJOCHB2mQPiN/sBIf3PjptQWqWYLNvCTmwEtFBGL
 DZTVuYokjSfTOORC7prrLziIt5N8KkWnxF3BekzS5DPcH8q6pHkZoAQsMA31pheLvkjT
 STXrYxcenrdEjX0age9JdAuTEyfQaS9PCfRGdMtLTll0Rov8dhDE5bybdEmDaEPhJkuB aQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jm8xb94dj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 02:02:12 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28G0OxxF040138;
        Fri, 16 Sep 2022 02:02:11 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jm8x6ngut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Sep 2022 02:02:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YlCjNpJysfpCf5jMie/Eal7OlCF7P5yPo+R4l+W7ulrM48/eL1FV2Q1AJUWXYQ6sUzr7WOaMQPGuYzjuoVBextWprbVYktLVTa32eIWTkJAiEf1wbPHnGI+9tI+2AuAmG18H70bEB1T5Bmu7eKZVCthfOLir/E+RkZNSO9rowFwjuQAKsGL0y6xDNrKt0Dhliyyo+N4Ra75rRm06kQxPN7NcetfL7l+MVDtAnYm/zZUCMJUNxKLDwWFKvA4xukmOlYbXA+36hkdDNaXlfyjmf9EICmtnRGyj0/n1qgXDF+I0zn4A85pL4Xjo+u7EEe5fV9n7eBHceODoGxF6ONE8HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scCH+h51keDgOLhbGIcaAGqj3bs+A1rdoNJQN/gdVAE=;
 b=HeS+ClqZOM8H+GLC1PZtCJ+DoGObvv5ApIy7YFxsHa/1qlWfXdDRIsw4ZkDpCrlMBjP5PxKfVozDoI+WlWx0R+Lh0/1Yz/2Lc8lo1coZYvumFw2xoX0TMj01F0NVIBDRCstBsf1urNV56qQ/o7AXyrcy3KnIxSNm5zSwFGtZ9OKVevXee4maIkPTwN5lZPZ0UGUD7a0QCZmOmrWrZRc0wFOxbz2GWzF+M3qeR4D8aCviZqMrSQh7fWYdnT1L4Z83DmtJntm4ZlwkJo9rP4fUvQivvrfkHgp6tqHBpL34N2KoXwBjdEvYGmDIRc3eZnrqhhh2HD2p8RKRIpN0H21oUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scCH+h51keDgOLhbGIcaAGqj3bs+A1rdoNJQN/gdVAE=;
 b=rCCNVL81pdGrZCqIcvsvAe44SSJficRBIjX85JU9kR5bDJpiNhSE4aEND65DTQX5pVQOFv6rlacqG+u47WmYtCAlHVeYcUejj9wE1pMOdHC8rHy3Aui1Ark1rhTsxvkiARkkH6DuT0DGwWj15iuErNLw85nFHziGIUy+tElaewA=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM4PR10MB6013.namprd10.prod.outlook.com (2603:10b6:8:ae::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.19; Fri, 16 Sep 2022 02:02:09 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::297f:836:f424:cd75]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::297f:836:f424:cd75%3]) with mapi id 15.20.5632.015; Fri, 16 Sep 2022
 02:02:09 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Hannes Reinecke <hare@suse.com>,
        David Malcolm <dmalcolm@redhat.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] scsi: aic79xx: Use __ro_after_init explicitly
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq17d242i26.fsf@ca-mkp.ca.oracle.com>
References: <20220914115953.3854029-1-keescook@chromium.org>
Date:   Thu, 15 Sep 2022 22:02:06 -0400
In-Reply-To: <20220914115953.3854029-1-keescook@chromium.org> (Kees Cook's
        message of "Wed, 14 Sep 2022 04:59:53 -0700")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::28) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|DM4PR10MB6013:EE_
X-MS-Office365-Filtering-Correlation-Id: de61fb2a-dd4c-4f1d-0ca1-08da978776b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BODlKSsPJM8/7LGufMCT4LbmoXOScbQP4p0PUseRaJF+6/U+LmKXrCNsBxjLKpiFHCbydOlMauZLiaTRc7DgQUsSBeVorGopfCtx3d5kScX1FEd12cJfvED6rFcWyLC0ibTcu7x7Lz454NBDZi1yC/fS2Zr0E/Gc0ROza64qwceFFWwWzOQ9+s9dSFt1muSBVLfl5EZq/dwRmO9pAAq08Dh11IE9bP2zcZfrlC/RVfLBJalvcdSjY5b2VnDGLZThBssCu6d8oljUOge3/tTxVE1YmU4tFWnX8Y5rqtzwxJZ7No1Y5AjY4xKfi14xXs/pJZJX7h6Y7Q56SFKsaDDab36NJfZrSOANevq5B29Egv7auM6PTdTAVUZoeClGMpD18lLs3+PFlokL4MlilOaUxFq2mhxp++vfEac45WMd/3B3Abm06vevBKoOXaY5uJrBvmFC0l34VB62gLPywLXim1rxJ3HP5bpWwr9Koz14Irwya7tJnlFi4qXtAjuFssTlZQhyOWayu6+8/64Yco+T6m0pHe6NFpVomjr/tzOw3LRzqYh25J9Ny3rR690Zy3Zt/rWiEylqItXWt4YohhkkErtC6QHcW8o/4r07fq32nJ22ZQvd3BtxiaohRujJ489b9zoUfFwo+WBW21TH7wV1K2ipFw88IQ5tBnvBMcNyvZj5kcHT9yA0u3qplDJk6lnankdjNzG0SrR9351uN86Hlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(346002)(376002)(39860400002)(366004)(396003)(451199015)(478600001)(2906002)(4744005)(316002)(86362001)(36916002)(66946007)(8676002)(6666004)(8936002)(6506007)(4326008)(6512007)(66556008)(66476007)(6486002)(6916009)(38100700002)(54906003)(26005)(41300700001)(186003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?haOrWD8XIEOC9nn0c4Yoh27ixLLKCJf5GtqH/P033etxdSCc3bA+kD9ik7uC?=
 =?us-ascii?Q?rHQe65xyFBZgYeD6ouGinPnFdfl+F1yjhHAM3quIVVffuuiHHT4q6YuRC7kK?=
 =?us-ascii?Q?lPGfeIsEDrLASWBfGYaUEmy6IulRKczpRhAkbyyCJWQZzls8lDFhHFhidaq5?=
 =?us-ascii?Q?AnuVD7C9GpWT4/ss3od+pm1pWQWmKnWa674jCEpwqscgUERdYkUg58BTfdSQ?=
 =?us-ascii?Q?DtB2hlX6OgRai18xZp7vwsunDjjzZ9MXd1NirEBqkdSqilPzkEiTn0DHI2PY?=
 =?us-ascii?Q?QqNZBdneb3HLFfZRM+mwvy5hZBPflJ782DugMMehP111QH+y2IpOrCMrrjMY?=
 =?us-ascii?Q?XRGdnuBuwgtCD0XKoDjvbcwrGRUGH9g56u5AWYanRTrrWk8wArEdtnc29i/D?=
 =?us-ascii?Q?WSyuifikLmqRNl21acWBT+uikjPfv5afz+nTOAllEkjNHxOvoGw1Abo2HMij?=
 =?us-ascii?Q?cSLttuc5xpDAJtSLvnvsm0XWV4IaP4HAwrJGk6JW9QFpfLvfp3Wu++I7SDrr?=
 =?us-ascii?Q?Uw5Yi/+BbsO/KpSbOoCMeuO0OLJBJREIPuaD6912ZzAC0keGTAgXcupgeQPw?=
 =?us-ascii?Q?z8odIo4cpgzAp6nBW660ctxcrrgG20dfwDZw9Jwzads7O+41Iu+xZI+fsBqg?=
 =?us-ascii?Q?yJb7vn1DsDtiTZ5NzcfVY1SzJU+mBJRcEpI7wpuGcxcIXXUJOdfjeI1fbbiJ?=
 =?us-ascii?Q?Jhbp6A9s+AgCOAKwPx8f61GtdPDrFXRc6FI95MWHh/JdKXjB3S3t+JFT6X3Y?=
 =?us-ascii?Q?pFLwjUw/tSTL/+EgeVXyW3Vd8puRJSinK+0owUo52vwZ/sEbvl2wp111J+QP?=
 =?us-ascii?Q?ojHm4uemmQgvpNryLocXGVlkClE6BYvdSDjK0ShNDqEHvBgK8W9zfsldFG1p?=
 =?us-ascii?Q?pdphAwPW0SraeTKM4FIJ8Qqh9/w60uPh9h3S3criS19uhtnrNIn+Aqsxpzu4?=
 =?us-ascii?Q?Umco2E3A/84gKPWOmIzaO8s5oEEPFGm83tM3zkN6vR4nFtUGN71kKqxrDhyL?=
 =?us-ascii?Q?nPdj2UmX8QJYKF/fcbIOst2GFcTH3FeExrHDUOna3lsRhSDffxRtgHKi8gqT?=
 =?us-ascii?Q?hg/javTngGT+TUMdK0sOPOWevdvCscB9zdee1Sr0/pjf93H+eLPDb3TdhLsk?=
 =?us-ascii?Q?+QKuz73NircBZR7o5Asjh7UEsSqVunKVCf3R7WoxDU90dPNP9zrdMKlzCgH1?=
 =?us-ascii?Q?K10MTHJG+TjipFcr+Xeank+V782tq21+Wfrj99j12xHHo6NQJoB+w1mCK1vG?=
 =?us-ascii?Q?MLDg1ssj1p6DXmoEcRmI6BUSnukkXneMP+5pAezPbpZgw/tM0xn/808mBxv7?=
 =?us-ascii?Q?3QJZZELAK8C1p/ZiND6YZ/8kOy95xeNDMNtxVA8BqhNlWNIDRhN7XWBz5249?=
 =?us-ascii?Q?dIyw06LQwceXNy8POyJuR2+ejGOmKPj5Wp0/8/nZI7vmln6ZY39qUxWe8zKM?=
 =?us-ascii?Q?0mbI4PCKeYCuEVf25e6JbMPSNJ8+q3oCCEzfCHxsWCYjWlELB6vGpA0d5kHq?=
 =?us-ascii?Q?OrrieFiwj2A+Vli9Be6SKDbAYrJP3k4PvcNrKdTBnvDHMxMke9PTemRnpDbG?=
 =?us-ascii?Q?PSs2uacidV0ogasJEF6EKCeuTeQP2JJZ8uk+i42G1bgMrx4aj09SW7fQntBU?=
 =?us-ascii?Q?0w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de61fb2a-dd4c-4f1d-0ca1-08da978776b0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2022 02:02:09.6161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uxhODeOpk/dpd84CmylCwwhzxqS6I0VENdbKDU5w/jsHgmwoyZWZNLGRI/5L1lwIXB9d7rGzMYXnnOYEUkzOIjAukH6vtADC0LF/DVkblh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6013
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-15_10,2022-09-14_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 mlxlogscore=842 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209160013
X-Proofpoint-ORIG-GUID: X7ku0oNU4dLm0IDC3cHtCs0j9vUglGz2
X-Proofpoint-GUID: X7ku0oNU4dLm0IDC3cHtCs0j9vUglGz2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Kees,

> ahd_linux_setup_iocell_info() intentionally writes to the const-marked
> aic79xx_iocell_info array, but is called during __init, so the
> location is actually writable at this point on most
> architectures. Annotate this explicitly with __ro_after_init to avoid
> static analysis confusion.

Applied to 6.1/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
