Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA4166515F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 02:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjAKBy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 20:54:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbjAKByW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 20:54:22 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20867101E6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 17:54:21 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30B1cD8V008025;
        Wed, 11 Jan 2023 01:54:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=qVIr3rcoL21uZvDWS2Zdt1M1NU1XLkKaqw4TBTe5/BA=;
 b=07LXn6WcGKbFNIN6NaL5HH9sE2WdlwQG9h2zpWyn7oetZGQJCjd32gSiZjfiY/nTg9Ei
 DK+/i1GnjzoaZoK7RP3FUJNjHBYXIlJZdM6a47bcOifV8TNQtWG7NsQy87Zgx1U4g8iD
 rHoZZB0BpYeSz+roRLjrTODpz1XqLKAvhyj03qfwHoIWUvKrRcHzBxTLvqR5WW9yc2gn
 dyrR9QASSae3DuDRYEyWMGzBMfTOlOmHRSuAf8sMP//zA4lXggh5mmLVKDraU/MgMxfX
 6h3Ym7zWEmadBIMJdMYQxa0Dvm4lrdFU3bvzTJI0yaznzP5QCIVPohHttqke2zXNyUzs 3A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n173bhtsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jan 2023 01:54:01 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30B14Tk5009146;
        Wed, 11 Jan 2023 01:54:00 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4nhc32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jan 2023 01:54:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xvipt3IHiE5D7f8EXz/oByAG1fMeT+TfgKBzmj30N2sZ27JZYg0SR1FHAJgv9kQmBsD9swNFSu9Z8A9NSaXDgCREqsGNGDRjDoFydiQEnIYm4xY4WCuE5MqPjtqnZC1DiirZEuS1+jIf88s0ketoN2gXT571DAoNZxmw+tEs9/r8JnRKNHvzWByXjxZuInuXfqkpv4B2KuTV6qknWAby1eFZL+A8vDk89kud8qeNcGsNZ9Y/n+s4QXdDsXgRXIcvE4Deu8yHKldrrwDOv00bysf7T5s79L0QDZqqTGay4nSwgABXH6rY22VHyr5+XmnKJoESSpe6aacf2XEjC2a+Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVIr3rcoL21uZvDWS2Zdt1M1NU1XLkKaqw4TBTe5/BA=;
 b=W/O4nI9HkwmjYqqC+Moi1GvFkCv8uN+N42fLh/zL4B6KcAk1oY8IreycRzwie/jmitF8Q2G6PxXE40mOneIJrVCOQeOfEqV7vapkj7nXI/igeZvk8p6dRWYFLhDqEN6OTXCPyt5+X53sY6xnFwmqDW6yDOTOsiIMHtCsP9g6/mFvRE3n1rvV+iyIHSVeQW4XAf2QbsVTYr03pLX0+E4I9EuMXUh558+2Gk5FRGwguEkxVbRb+/dCdVSI3lr3MC4lGY75sDAfpByNc4UyGRYQS2/33vgdIB6VQJivtt00xk6wyAjSCZ56+JdvOJxPvf3lPJaYpdeMJ/KgnqTrgJj8Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVIr3rcoL21uZvDWS2Zdt1M1NU1XLkKaqw4TBTe5/BA=;
 b=tOz6mHsDO6F888fBd3WBk4Rl/3MxCbCcMDqXVEtg/McYpQ0HueOoO6ll9OlrsL1ie1sLSpaZQVF4ClW1ga987150b/ENcgt82cOBJaOb/Ae5l9xC0QF6CRTqIpDqOyF/ViYVGlPblcnUng8nEwN4lpE4s6RJFYkyOnSjagSoLtw=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CO1PR10MB4561.namprd10.prod.outlook.com (2603:10b6:303:9d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Wed, 11 Jan
 2023 01:53:57 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14%8]) with mapi id 15.20.6002.012; Wed, 11 Jan 2023
 01:53:57 +0000
Date:   Tue, 10 Jan 2023 17:53:53 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        Bharata B Rao <bharata@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        haoxin <xhao@linux.alibaba.com>
Subject: Re: [PATCH -v2 0/9] migrate_pages(): batch TLB flushing
Message-ID: <Y74WsWCFGh2wFGji@monkey>
References: <20230110075327.590514-1-ying.huang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110075327.590514-1-ying.huang@intel.com>
X-ClientProxiedBy: MW4PR03CA0230.namprd03.prod.outlook.com
 (2603:10b6:303:b9::25) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CO1PR10MB4561:EE_
X-MS-Office365-Filtering-Correlation-Id: fdfda900-77f6-4dfd-ec96-08daf376b373
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1DxZrNkuQ1A70pA3mED7Jh6MJTf8EkSdn9PyB2NUarBmtKGJ59EklxeniWmvEg85XB9/eT65kMWERjHq1Tq7iIG6eCidPTUvo0fa2Rcen2fd3O5PA+zR6Kg9K+1Ae3D6VXEiKsCGQPp7SUW2Fpn6ayp3fnjUHbK1tqSATNsuKhtuVwcb+Q6d4efR3+La4/dhM+t8TZHlV5vssfM8BBbd/94wFLZPno5Nqh4M47P/8tPDkmTS13uRFUJkXaAIyC7xXiXQIblHcorzwHrgRMTt2UL3VBhJiEAJBbQuXwBaRio0oNIk2J+1Ux5r2438ZdipJkOtljqTwAVlJn0JP1CQNAqXqxOb95RlNL1KaBQnAjsc1Z9T8o49PuxeoleH/Yyx7suygXpS81YEmkSkujjjjYdNZJASznCa99sdMeJUed+/iMob/6pzSl9Ra3RfV82c5rGfhVvXRNHPQ2wtPv/i4fiKFsCk18OC0SoMOVwOJxro1RPZTV9Q3MFUaXs0hU3zNsuQ1sqTSjfQMbHjPlj9d1iYqL5MoX5FzlzI3FGboK2nrg2ZFvN5XR+IU+eOT3orXdGDqtvxK7hk3Iv4oEra0/uXvEuafB5QR3iJjkjnibfsYUXNaS+iZmqNsnIaaWcumTr/HScQu98I4zLwX+VDBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(396003)(346002)(376002)(39860400002)(366004)(451199015)(6486002)(478600001)(2906002)(86362001)(38100700002)(83380400001)(6666004)(6512007)(9686003)(26005)(33716001)(6506007)(186003)(45080400002)(6916009)(66476007)(4326008)(7416002)(5660300002)(30864003)(66946007)(8676002)(66556008)(41300700001)(8936002)(316002)(54906003)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dwxb9efcozLbKYWsYLlP9L5G9hFvJD6vo4mgf2JCFEU6xw7KXGeOXBZjMIqL?=
 =?us-ascii?Q?f3z8AP7ED/NPzRKvEHV3a0c4LijrcQ4urG8/OVHnaETUpeZPGTYJI1q9ZLMz?=
 =?us-ascii?Q?HVtDag+8u/RCWyuSwN4IhFYL7gHMTyRXWkiYgw8hFQih7puu7dq9gpBGFjRw?=
 =?us-ascii?Q?CfFZqAm/msMXLipqF8henxuYtPq61JkUQfgJ5nujCyNLAa1l6w/7QE2lUyaj?=
 =?us-ascii?Q?QqeIOH8KycxpttNtEWy2ivkKyLbHjXpxTIiRm4K3h+dLK2Twa5JeoPsN9ELc?=
 =?us-ascii?Q?6F0W8ttuaRPsnkOZy2HeS9WVxoRcp6+B6ueugkIR9+R59XsXmJcq34O+Tq0z?=
 =?us-ascii?Q?MdDbqonKLd6dakVedjAlfYs+by0iUHrUIOc0oZD0UhuPp6rCQEpkU4FfyuZ2?=
 =?us-ascii?Q?m42iICEJrnuTyDVKNY5JNE+B0/m3OxMw+7kkrjv3M4VNgolMt/2gpDYHTjV4?=
 =?us-ascii?Q?W3hVUTs9m6j2NiyFEnxWxfnUiC/dqVTiN9yx/648Gqtip6ey50e5/SjG5LeD?=
 =?us-ascii?Q?cjHmdn3RY0KURGREn6//75FAVeKQMCJSyW+vEKytuI+Wm3zxogjn0vgoBFjI?=
 =?us-ascii?Q?s3audNXeFtLFq6iEoLcIGSbce9AkGD7dQcgrgbOfvjfOkbM1UhhfE8Y8mSPc?=
 =?us-ascii?Q?L71HeuWZJjUG6LtD5fEUkXGgiYZ0qmTN+ZE09H4M1DYchlmZIEs1jhU4Zr0E?=
 =?us-ascii?Q?vLYQbwiRjnulJKxltqmbppLCCK9S47iDOTPNsiWgjuTZuf8cYuULjbKUz6g2?=
 =?us-ascii?Q?hraN4yyPZOnNztkgCuxLSeCexZGsVeVFQpQklTCCvCIHMeLfaZ1R3lFAsqdC?=
 =?us-ascii?Q?kGEu993rhXoVN/99PsJc3KCUl5z4r8fbXI3lbhDt+UHmSsDVKf1u6QP1Nbd7?=
 =?us-ascii?Q?4AUMx2CY0UYHh/wm7oQBmG2wecdxufaKI93HERvWXjtuTc/2RAJt63CzMNZb?=
 =?us-ascii?Q?xak7k940ZH7XxyUnBdyOmYX/9mDZueCetJ/Xi9ShcUrOv5aH7G+lgdIFJSzf?=
 =?us-ascii?Q?3ZXdHhe+SM+V7p3I63ZGtltO472B1iOTWHNqTz7Jl610ghOPszXrnc1Uku7s?=
 =?us-ascii?Q?kBMY/LtERu/pJ85Bas7P+31kWPUrIvm3D01RLWLvL0Yi64s5IgrauAjqklwd?=
 =?us-ascii?Q?mRaykDOSMXQfs3D1i/QwbK7qnS2bLsC+X2+w+ltFIXuJ6AEFr2Ckhdis6Rn5?=
 =?us-ascii?Q?pUPBeUpCo4iEbwpNaouZYCX1mTWRyQzPoZHtGfI9+kgGnCqvyOJHEChAPKih?=
 =?us-ascii?Q?7CQS1PhBMqLxQz1o/KGTCWhcFbtIm8ErnUwEq5SQcYktBsGZZsFmuv15f9ir?=
 =?us-ascii?Q?SKZ9MuECesVKjuUcUUn3hR73qXg7TT1Hv9LeCB1oXlOe0/rVUdfQxSxCF/UZ?=
 =?us-ascii?Q?/74qLdsvZ+2zoR4jn7BsZdMd+wsbHxRFqEu5YkK1hGTRU3UAzmN9ogBn4zcl?=
 =?us-ascii?Q?T8MWXFPNYz9BfKdmuCNU0pGF6vYijbdb39fu0yFBDREXamY/ec79Uc5enBl3?=
 =?us-ascii?Q?f/2qoCaxCv9Qq7oWTP5npYWg/rhdmM/9ddMKh20qNZFvyZCKr7dg/xClbiCt?=
 =?us-ascii?Q?/CMSKlemy6ATPE/mAotxRsPWyoe1vmMRdtHm8MTQs6IwTyaiaigJa34/i5e5?=
 =?us-ascii?Q?Vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?mrqzlI9xP9C0CGV4gyzqwgYPx3+E4VC9vi3XoiAyPDod0UNm+pyB9rnJK4b2?=
 =?us-ascii?Q?3aQX0gg9R+64ZSSk14rtM5Q+0qZTXHNfKZ5tZcn7mwoaOGpej8L8v7QViD8r?=
 =?us-ascii?Q?pTdJ9AaXCQWnvi9pQsDBZLsP8QsZbkmfKkZT5v3tKYS0awZGBWBndOWoBirv?=
 =?us-ascii?Q?pr6AgdsaO/67pmUWRIsFwzkTgGYF8Km9oqFtVJCkfShmqlORXEYGVenakpTJ?=
 =?us-ascii?Q?MnMJsUv1kIlgAMLURFJQ1UyBmE26Oc4k/f6rYRl+LFmM/I0ne6wJpxKW3mtw?=
 =?us-ascii?Q?123gJUAV3a6lHjRrmP9hiIPDoGUkDEf7zwVZcCvlg9rpwcjz2UDGHSxJSlEY?=
 =?us-ascii?Q?hTBrr/O1Q8s7l3Fb0JWn9+kqpI6PBEhPKFLRjbxxK9vzu+UzHqNZzSCgakGg?=
 =?us-ascii?Q?EQLg0+bgaZl9tRI0S++yEj+KRRbFT384NHpNZxBwUwnD7+tYJd1m2duVs4Q0?=
 =?us-ascii?Q?qlS6aos626KlSCO8Euf69i+mCCXCUq1ej5UAzyFR+kPEBWcwT8NmydQ/Yg4P?=
 =?us-ascii?Q?7N5EvgFcjAY0u+6pYsT8o5xKkrnJTQQd4GRWDdk34FTGoC6DUOrgCMwzPizB?=
 =?us-ascii?Q?gASTVzI3Lar8buRkMib/c0r59naIjtFI+XM0aWnGKD90mEt0g0YX8bywzM+E?=
 =?us-ascii?Q?mOKf60P+HPthawdCdAOKrFBoPITnD7lwvuArwBbky5ZbqGj/7qZ7zf3j6GVp?=
 =?us-ascii?Q?H/+xGqzsmobyzjYSOcxXq4mg1R5rGPaU8ADuUujb9fZoDg5Red5WIXmUsYdj?=
 =?us-ascii?Q?WpXvpSInImElOlMr6ls6ILzLL+iQS3zLeePQIfmal5a+T4le6fRtnq4+WUlT?=
 =?us-ascii?Q?DttTy8exDmJsk+nyjPYPB8BHZGWV/T0Zq7Fe7IY3BHKWR+65ddt/GTj+It+1?=
 =?us-ascii?Q?RKCj90vatMSQ0792pIgJb+nE8HPO1K90NePOs7bE9GIJNiZ7MrQEV45IPh+2?=
 =?us-ascii?Q?kSxYgKHPZ/ZmzF4b35029amUN1ypn55yQ8zohRfcBMsqDlWjSAvTOGQ9IbUb?=
 =?us-ascii?Q?RiHsIW3Y4ib1fgId0Uht7MJE/Rff9fQhKBHXPZRsdki3xDw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdfda900-77f6-4dfd-ec96-08daf376b373
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 01:53:57.1724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: akmNT8KT/Gk0stCLqyaK+Jpv0VzXCBEQqgqmD30hPxPIBdNu6IoByZ5YSNSsRwjtbs6jhOkMd4Qo0jyd1wzzrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4561
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_10,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=775 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301110011
X-Proofpoint-GUID: FsQ6UBZyTNe85AqQahRquRT5NsrlEekL
X-Proofpoint-ORIG-GUID: FsQ6UBZyTNe85AqQahRquRT5NsrlEekL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just saw the following easily reproducible issue on next-20230110.  Have not
verified it is related to/caused by this series, but it looks suspicious.

Reproduce by,

# echo <very large number> > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages

This will 'attempt' to allocate hugetlb pages until it fails.

-- 
Mike Kravetz

[   46.084610] page:ffffea0005d69f40 refcount:2 mapcount:1 mapping:0000000000000000 index:0xffffea0005c37bc0 pfn:0x175a7d
[   46.086777] flags: 0x200000000002000(private|node=0|zone=2)
[   46.088025] raw: 0200000000002000 dead000000000100 dead000000000122 ffffffff81e28c42
[   46.089413] page:ffffea0005e6ffc0 refcount:2 mapcount:145 mapping:0000000000000000 index:0xffffea0005fe09c0 pfn:0x179bff
[   46.089762] raw: ffffea0005c37bc0 ffff88817d0bf0c0 0000000200000000 0000000000000000
[   46.091287] flags: 0x200000000000000(node=0|zone=2)
[   46.091291] raw: 0200000000000000 dead000000000100 dead000000000122 ffffffff81e28c42
[   46.091293] raw: ffffea0005fe09c0 ffff88817d0bf2e8 0000000200000090 0000000000000000
[   46.091294] page dumped because: VM_WARN_ON_ONCE_FOLIO(!memcg && !mem_cgroup_disabled())
[   46.092652] page dumped because: VM_WARN_ON_ONCE_FOLIO(!memcg && !mem_cgroup_disabled())
[   46.092671] ------------[ cut here ]------------
[   46.094438] ------------[ cut here ]------------
[   46.095638] WARNING: CPU: 0 PID: 836 at include/linux/memcontrol.h:756 folio_lruvec_lock_irqsave+0xde/0x120
[   46.096882] WARNING: CPU: 1 PID: 41 at include/linux/memcontrol.h:756 folio_lruvec_lock_irqsave+0xde/0x120
[   46.098193] Modules linked in:
[   46.099364] Modules linked in: rfkill ip6table_filter ip6_tables sunrpc snd_hda_codec_generic snd_hda_intel snd_intel_dspcfg snd_hda_codec joydev 9p snd_hwdep netfs
[   46.100184]  rfkill
[   46.100843]  snd_hda_core
[   46.102560]  ip6table_filter
[   46.103937]  snd_seq snd_seq_device snd_pcm virtio_balloon 9pnet_virtio snd_timer snd 9pnet soundcore virtio_console virtio_net net_failover
[   46.104497]  ip6_tables
[   46.106522]  failover virtio_blk crct10dif_pclmul
[   46.106921]  sunrpc
[   46.107340]  crc32_pclmul
[   46.107873]  snd_hda_codec_generic
[   46.109582]  crc32c_intel ghash_clmulni_intel serio_raw
[   46.110016]  snd_hda_intel
[   46.110698]  virtio_pci
[   46.111067]  snd_intel_dspcfg
[   46.111483]  virtio
[   46.112101]  snd_hda_codec
[   46.112963]  virtio_pci_legacy_dev virtio_pci_modern_dev virtio_ring fuse
[   46.112970] CPU: 1 PID: 41 Comm: kcompactd0 Not tainted 6.2.0-rc3-next-20230110+ #39
[   46.113399]  joydev
[   46.113756] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.1-2.fc37 04/01/2014
[   46.114248]  9p snd_hwdep
[   46.114676] RIP: 0010:folio_lruvec_lock_irqsave+0xde/0x120
[   46.115052]  netfs snd_hda_core snd_seq
[   46.115972] Code: 83 66 90 80 3d 1f 76 31 01 00 0f 85 74 ff ff ff 48 c7 c6 e8 2f 21 82 48 89 df 48 89 04 24 e8 29 6b f7 ff c6 05 ff 75 31 01 01 <0f> 0b 48 8b 04 24 e9 4f ff ff ff 48 c7 c6 e8 2d 21 82 e8 0b 6b f7
[   46.117079]  snd_seq_device snd_pcm virtio_balloon 9pnet_virtio snd_timer snd 9pnet soundcore virtio_console
[   46.117375] RSP: 0018:ffffc9000121fa58 EFLAGS: 00010246
[   46.118633]  virtio_net net_failover failover
[   46.119056] 
[   46.119845]  virtio_blk
[   46.120351] RAX: 000000000000004c RBX: ffffea0005e6ffc0 RCX: 0000000000000000
[   46.122782]  crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel
[   46.124257] RDX: 0000000000000000 RSI: ffffffff8223be4a RDI: 00000000ffffffff
[   46.125032]  serio_raw virtio_pci virtio virtio_pci_legacy_dev virtio_pci_modern_dev
[   46.125686] RBP: 0000000000000000 R08: 3030303030327830 R09: 3030303030303030
[   46.125891]  virtio_ring
[   46.126250] R10: 00000000203a7367 R11: 0000000067616c66 R12: ffffc9000121fa80
[   46.127107]  fuse
[   46.128096] R13: ffffffff812709d0 R14: 0000000000000000 R15: ffffea0005a98e80
[   46.128097] FS:  0000000000000000(0000) GS:ffff888277d00000(0000) knlGS:0000000000000000
[   46.128099] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   46.128100] CR2: 0000557bd8d9ab54 CR3: 000000017f58c006 CR4: 0000000000370ee0
[   46.128104] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   46.129137] 
[   46.129139] CPU: 0 PID: 836 Comm: bash Not tainted 6.2.0-rc3-next-20230110+ #39
[   46.130216] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   46.130218] Call Trace:
[   46.130219]  <TASK>
[   46.130221]  folio_batch_move_lru+0x91/0x180
[   46.131261] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.1-2.fc37 04/01/2014
[   46.131263] RIP: 0010:folio_lruvec_lock_irqsave+0xde/0x120
[   46.131647]  folio_add_lru+0x83/0x100
[   46.132546] Code: 83 66 90 80 3d 1f 76 31 01 00 0f 85 74 ff ff ff 48 c7 c6 e8 2f 21 82 48 89 df 48 89 04 24 e8 29 6b f7 ff c6 05 ff 75 31 01 01 <0f> 0b 48 8b 04 24 e9 4f ff ff ff 48 c7 c6 e8 2d 21 82 e8 0b 6b f7
[   46.132825]  migrate_pages_batch+0x4fb/0x1210
[   46.133889] RSP: 0018:ffffc90003a2f658 EFLAGS: 00010246
[   46.135033]  ? __pfx_compaction_free+0x10/0x10
[   46.135864] 
[   46.136891]  ? __pfx_compaction_alloc+0x10/0x10
[   46.136895]  ? __pfx_remove_migration_pte+0x10/0x10
[   46.137933] RAX: 000000000000004c RBX: ffffea0005d69f40 RCX: 0000000000000000
[   46.138143]  migrate_pages+0xa35/0xaf0
[   46.139206] RDX: 0000000000000000 RSI: ffffffff8223be4a RDI: 00000000ffffffff
[   46.140186]  ? __mod_node_page_state+0x72/0xc0
[   46.140497] RBP: 0000000000000000 R08: ffffffff824636a0 R09: 0000000082d9d55e
[   46.140823]  ? __pfx_compaction_alloc+0x10/0x10
[   46.141527] R10: ffffffffffffffff R11: ffffffffffffffff R12: ffffc90003a2f680
[   46.142707]  ? __pfx_compaction_free+0x10/0x10
[   46.142714]  compact_zone+0x9d4/0xdf0
[   46.143533] R13: ffffffff812709d0 R14: 0000000000000000 R15: ffffea0005a96c80
[   46.143535] FS:  00007f2148bff740(0000) GS:ffff888277c00000(0000) knlGS:0000000000000000
[   46.143537] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   46.143539] CR2: 0000563a927d7c20 CR3: 000000017f58c004 CR4: 0000000000370ef0
[   46.144211]  kcompactd_do_work+0x1d2/0x2c0
[   46.147103] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   46.147105] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   46.147107] Call Trace:
[   46.147109]  <TASK>
[   46.147111]  folio_batch_move_lru+0x91/0x180
[   46.147833]  kcompactd+0x220/0x3e0
[   46.148533]  folio_add_lru+0x83/0x100
[   46.149164]  ? __pfx_autoremove_wake_function+0x10/0x10
[   46.149413]  migrate_pages_batch+0x4fb/0x1210
[   46.150058]  ? __pfx_kcompactd+0x10/0x10
[   46.150814]  ? __pfx_compaction_free+0x10/0x10
[   46.151669]  kthread+0xe6/0x110
[   46.152277]  ? __pfx_compaction_alloc+0x10/0x10
[   46.152281]  ? __pfx_remove_migration_pte+0x10/0x10
[   46.153276]  ? __pfx_kthread+0x10/0x10
[   46.153280]  ret_from_fork+0x29/0x50
[   46.154056]  migrate_pages+0xa35/0xaf0
[   46.154059]  ? __mod_node_page_state+0x72/0xc0
[   46.155067]  </TASK>
[   46.155768]  ? __pfx_compaction_alloc+0x10/0x10
[   46.156656] ---[ end trace 0000000000000000 ]---
[   46.157310]  ? __pfx_compaction_free+0x10/0x10
[   46.157316]  compact_zone+0x9d4/0xdf0
[   46.209601]  compact_zone_order+0xc0/0x130
[   46.210469]  try_to_compact_pages+0xf0/0x2f0
[   46.211439]  __alloc_pages_direct_compact+0x78/0x380
[   46.212525]  __alloc_pages_slowpath.constprop.0+0x3e4/0xe10
[   46.213725]  ? vmemmap_remap_range+0x578/0x590
[   46.215659]  ? free_unref_page+0x186/0x1e0
[   46.216502]  ? prepare_alloc_pages.constprop.0+0x197/0x1b0
[   46.217583]  __alloc_pages+0x218/0x240
[   46.218409]  alloc_buddy_hugetlb_folio.isra.0+0x66/0x140
[   46.219456]  alloc_fresh_hugetlb_folio+0x1cd/0x260
[   46.220410]  alloc_pool_huge_page+0x77/0xb0
[   46.221265]  set_max_huge_pages+0x16c/0x3a0
[   46.222124]  ? kernfs_fop_write_iter+0x160/0x1f0
[   46.223039]  __nr_hugepages_store_common+0x4e/0xb0
[   46.223941]  ? _kstrtoull+0x3b/0x90
[   46.224679]  nr_hugepages_store+0x77/0x80
[   46.225538]  kernfs_fop_write_iter+0x108/0x1f0
[   46.226439]  vfs_write+0x203/0x3d0
[   46.227181]  ksys_write+0x63/0xe0
[   46.227896]  do_syscall_64+0x37/0x90
[   46.228648]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   46.229656] RIP: 0033:0x7f2148cf3e87
[   46.230444] Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[   46.233509] RSP: 002b:00007fff92367e58 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   46.234869] RAX: ffffffffffffffda RBX: 000000000000000d RCX: 00007f2148cf3e87
[   46.236042] RDX: 000000000000000d RSI: 0000557bd8d9ab50 RDI: 0000000000000001
[   46.237408] RBP: 0000557bd8d9ab50 R08: 000000000000000a R09: 00007f2148d8b0c0
[   46.238801] R10: 00007f2148d8afc0 R11: 0000000000000246 R12: 000000000000000d
[   46.240217] R13: 00007f2148dc7520 R14: 000000000000000d R15: 00007f2148dc7720
[   46.241738]  </TASK>
[   46.242289] ---[ end trace 0000000000000000 ]---
[   46.301978] page:ffffea0005be0400 refcount:2 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0x16f810
[   46.304043] flags: 0x200000000002000(private|node=0|zone=2)
[   46.305321] raw: 0200000000002000 ffffea0005f3d2c8 ffffea0005fe0648 ffffffff81e28c42
[   46.318282] raw: 0000000000000000 ffff88817a78f738 0000000200000000 0000000000000000
[   46.319978] page dumped because: VM_WARN_ON_ONCE_FOLIO(!memcg && !mem_cgroup_disabled())
[   46.321820] ------------[ cut here ]------------
[   46.322924] WARNING: CPU: 0 PID: 836 at include/linux/memcontrol.h:756 isolate_migratepages_block+0x139b/0x1590
[   46.325280] Modules linked in: rfkill ip6table_filter ip6_tables sunrpc snd_hda_codec_generic snd_hda_intel snd_intel_dspcfg snd_hda_codec joydev 9p snd_hwdep netfs snd_hda_core snd_seq snd_seq_device snd_pcm virtio_balloon 9pnet_virtio snd_timer snd 9pnet soundcore virtio_console virtio_net net_failover failover virtio_blk crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel serio_raw virtio_pci virtio virtio_pci_legacy_dev virtio_pci_modern_dev virtio_ring fuse
[   46.334006] CPU: 0 PID: 836 Comm: bash Tainted: G        W          6.2.0-rc3-next-20230110+ #39
[   46.335723] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.1-2.fc37 04/01/2014
[   46.338314] RIP: 0010:isolate_migratepages_block+0x139b/0x1590
[   46.339469] Code: 01 00 0f 85 3e f3 ff ff 48 c7 c6 e8 2f 21 82 48 89 44 24 58 44 88 54 24 60 48 89 7c 24 38 e8 ac 50 00 00 c6 05 55 5b 3a 01 01 <0f> 0b 48 8b 44 24 58 44 0f b6 54 24 60 48 8b 7c 24 38 e9 05 f3 ff
[   46.342950] RSP: 0018:ffffc90003a2f868 EFLAGS: 00010046
[   46.343994] RAX: 000000000000004c RBX: 0000000000000000 RCX: 0000000000000000
[   46.345374] RDX: 0000000000000000 RSI: ffffffff8223be4a RDI: 00000000ffffffff
[   46.346749] RBP: 000000000016f810 R08: 00000000ffffdfff R09: 00000000ffffdfff
[   46.348100] R10: ffffffff82463700 R11: ffffffff82463700 R12: ffffc90003a2f9f0
[   46.349424] R13: ffffea0005be0400 R14: 0000000005be0400 R15: ffff88817e3ca000
[   46.350812] FS:  00007f2148bff740(0000) GS:ffff888277c00000(0000) knlGS:0000000000000000
[   46.352314] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   46.353405] CR2: 0000563a927d7c20 CR3: 000000017f58c004 CR4: 0000000000370ef0
[   46.354731] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   46.356093] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   46.357512] Call Trace:
[   46.358080]  <TASK>
[   46.358570]  compact_zone+0x39b/0xdf0
[   46.359329]  compact_zone_order+0xc0/0x130
[   46.360152]  try_to_compact_pages+0xf0/0x2f0
[   46.360956]  __alloc_pages_direct_compact+0x78/0x380
[   46.362015]  __alloc_pages_slowpath.constprop.0+0x3e4/0xe10
[   46.363157]  ? vmemmap_remap_range+0x578/0x590
[   46.364195]  ? free_unref_page+0x186/0x1e0
[   46.365082]  ? prepare_alloc_pages.constprop.0+0x197/0x1b0
[   46.366299]  __alloc_pages+0x218/0x240
[   46.367853]  alloc_buddy_hugetlb_folio.isra.0+0x66/0x140
[   46.368946]  alloc_fresh_hugetlb_folio+0x1cd/0x260
[   46.369983]  alloc_pool_huge_page+0x77/0xb0
[   46.370864]  set_max_huge_pages+0x16c/0x3a0
[   46.371753]  ? kernfs_fop_write_iter+0x160/0x1f0
[   46.372678]  __nr_hugepages_store_common+0x4e/0xb0
[   46.373615]  ? _kstrtoull+0x3b/0x90
[   46.374367]  nr_hugepages_store+0x77/0x80
[   46.375117]  kernfs_fop_write_iter+0x108/0x1f0
[   46.375887]  vfs_write+0x203/0x3d0
[   46.376516]  ksys_write+0x63/0xe0
[   46.377125]  do_syscall_64+0x37/0x90
[   46.377909]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   46.378857] RIP: 0033:0x7f2148cf3e87
[   46.379598] Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[   46.382943] RSP: 002b:00007fff92367e58 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   46.384279] RAX: ffffffffffffffda RBX: 000000000000000d RCX: 00007f2148cf3e87
[   46.385480] RDX: 000000000000000d RSI: 0000557bd8d9ab50 RDI: 0000000000000001
[   46.386680] RBP: 0000557bd8d9ab50 R08: 000000000000000a R09: 00007f2148d8b0c0
[   46.387902] R10: 00007f2148d8afc0 R11: 0000000000000246 R12: 000000000000000d
[   46.389203] R13: 00007f2148dc7520 R14: 000000000000000d R15: 00007f2148dc7720
[   46.390510]  </TASK>
[   46.391045] ---[ end trace 0000000000000000 ]---
[   46.392105] page:ffffea0005be0400 refcount:2 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0x16f810
[   46.394529] flags: 0x200000000002001(locked|private|node=0|zone=2)
[   46.396138] raw: 0200000000002001 ffffea0005be03c8 ffffc90003a2f768 ffffffff81e28c42
[   46.399758] raw: 0000000000000000 ffff88817a78f738 0000000200000000 0000000000000000
[   46.402249] page dumped because: VM_BUG_ON_FOLIO(!folio_test_isolated(src))
[   46.404308] ------------[ cut here ]------------
[   46.405764] kernel BUG at mm/migrate.c:986!
[   46.407171] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[   46.409174] CPU: 0 PID: 836 Comm: bash Tainted: G        W          6.2.0-rc3-next-20230110+ #39
[   46.411797] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.1-2.fc37 04/01/2014
[   46.413956] RIP: 0010:move_to_new_folio+0x1e4/0x1f0
[   46.415451] Code: 63 02 fb 31 c0 e9 ce fe ff ff 48 c7 c6 e0 cd 21 82 48 89 df e8 fd 26 f9 ff 0f 0b 48 c7 c6 e0 cd 21 82 48 89 df e8 ec 26 f9 ff <0f> 0b 0f 0b 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90
[   46.421496] RSP: 0018:ffffc90003a2f6b0 EFLAGS: 00010246
[   46.422751] RAX: 000000000000003f RBX: ffffea0005be0400 RCX: 0000000000000000
[   46.424844] RDX: 0000000000000000 RSI: ffffffff8223be4a RDI: 00000000ffffffff
[   46.426904] RBP: ffffea0005e300c0 R08: 00000000ffffdfff R09: 00000000ffffdfff
[   46.430491] R10: ffffffff82463700 R11: ffffffff82463700 R12: 0000000000000000
[   46.432562] R13: 0000000000000001 R14: ffffea0005be0400 R15: ffffea0005be03c0
[   46.434219] FS:  00007f2148bff740(0000) GS:ffff888277c00000(0000) knlGS:0000000000000000
[   46.436075] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   46.438219] CR2: 0000563a927d7c20 CR3: 000000017f58c004 CR4: 0000000000370ef0
[   46.440031] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   46.441560] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   46.443031] Call Trace:
[   46.443586]  <TASK>
[   46.444095]  migrate_pages_batch+0x4b9/0x1210
[   46.445028]  ? __pfx_compaction_free+0x10/0x10
[   46.445962]  ? __pfx_compaction_alloc+0x10/0x10
[   46.446937]  ? __pfx_remove_migration_pte+0x10/0x10
[   46.448008]  migrate_pages+0xa35/0xaf0
[   46.448870]  ? __mod_node_page_state+0x72/0xc0
[   46.449852]  ? __pfx_compaction_alloc+0x10/0x10
[   46.450873]  ? __pfx_compaction_free+0x10/0x10
[   46.451941]  compact_zone+0x9d4/0xdf0
[   46.452786]  compact_zone_order+0xc0/0x130
[   46.453722]  try_to_compact_pages+0xf0/0x2f0
[   46.454715]  __alloc_pages_direct_compact+0x78/0x380
[   46.456032]  __alloc_pages_slowpath.constprop.0+0x3e4/0xe10
[   46.457468]  ? vmemmap_remap_range+0x578/0x590
[   46.459525]  ? free_unref_page+0x186/0x1e0
[   46.460472]  ? prepare_alloc_pages.constprop.0+0x197/0x1b0
[   46.461667]  __alloc_pages+0x218/0x240
[   46.462556]  alloc_buddy_hugetlb_folio.isra.0+0x66/0x140
[   46.463725]  alloc_fresh_hugetlb_folio+0x1cd/0x260
[   46.464706]  alloc_pool_huge_page+0x77/0xb0
[   46.465446]  set_max_huge_pages+0x16c/0x3a0
[   46.466234]  ? kernfs_fop_write_iter+0x160/0x1f0
[   46.467161]  __nr_hugepages_store_common+0x4e/0xb0
[   46.468060]  ? _kstrtoull+0x3b/0x90
[   46.468805]  nr_hugepages_store+0x77/0x80
[   46.469622]  kernfs_fop_write_iter+0x108/0x1f0
[   46.470500]  vfs_write+0x203/0x3d0
[   46.471219]  ksys_write+0x63/0xe0
[   46.471889]  do_syscall_64+0x37/0x90
[   46.472643]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[   46.473606] RIP: 0033:0x7f2148cf3e87
[   46.474323] Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[   46.477667] RSP: 002b:00007fff92367e58 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[   46.479164] RAX: ffffffffffffffda RBX: 000000000000000d RCX: 00007f2148cf3e87
[   46.480477] RDX: 000000000000000d RSI: 0000557bd8d9ab50 RDI: 0000000000000001
[   46.481783] RBP: 0000557bd8d9ab50 R08: 000000000000000a R09: 00007f2148d8b0c0
[   46.483086] R10: 00007f2148d8afc0 R11: 0000000000000246 R12: 000000000000000d
[   46.484529] R13: 00007f2148dc7520 R14: 000000000000000d R15: 00007f2148dc7720
[   46.486022]  </TASK>
[   46.486563] Modules linked in: rfkill ip6table_filter ip6_tables sunrpc snd_hda_codec_generic snd_hda_intel snd_intel_dspcfg snd_hda_codec joydev 9p snd_hwdep netfs snd_hda_core snd_seq snd_seq_device snd_pcm virtio_balloon 9pnet_virtio snd_timer snd 9pnet soundcore virtio_console virtio_net net_failover failover virtio_blk crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel serio_raw virtio_pci virtio virtio_pci_legacy_dev virtio_pci_modern_dev virtio_ring fuse
[   46.495734] ---[ end trace 0000000000000000 ]---
[   46.496819] RIP: 0010:move_to_new_folio+0x1e4/0x1f0
[   46.498074] Code: 63 02 fb 31 c0 e9 ce fe ff ff 48 c7 c6 e0 cd 21 82 48 89 df e8 fd 26 f9 ff 0f 0b 48 c7 c6 e0 cd 21 82 48 89 df e8 ec 26 f9 ff <0f> 0b 0f 0b 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90
[   46.501891] RSP: 0018:ffffc90003a2f6b0 EFLAGS: 00010246
[   46.503055] RAX: 000000000000003f RBX: ffffea0005be0400 RCX: 0000000000000000
[   46.504548] RDX: 0000000000000000 RSI: ffffffff8223be4a RDI: 00000000ffffffff
[   46.506072] RBP: ffffea0005e300c0 R08: 00000000ffffdfff R09: 00000000ffffdfff
[   46.507643] R10: ffffffff82463700 R11: ffffffff82463700 R12: 0000000000000000
[   46.509193] R13: 0000000000000001 R14: ffffea0005be0400 R15: ffffea0005be03c0
[   46.510724] FS:  00007f2148bff740(0000) GS:ffff888277c00000(0000) knlGS:0000000000000000
[   46.512569] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   46.513878] CR2: 0000563a927d7c20 CR3: 000000017f58c004 CR4: 0000000000370ef0
[   46.515469] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   46.517088] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

