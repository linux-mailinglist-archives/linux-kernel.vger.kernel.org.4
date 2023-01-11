Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1856D666622
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 23:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236035AbjAKWWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 17:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235873AbjAKWW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 17:22:28 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1F5431A5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 14:22:26 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30BM5XJ0005223;
        Wed, 11 Jan 2023 22:22:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=BIUyMNgUy9z/g5r3Fm2tT7efyNydPGCFHMszmD23XnA=;
 b=BmkutUUGpdbQBLYZRGmRZvizVf1f7vI0aa3dryLHw34a19VIAuoFMs5OhnLIKgZ8KWC1
 /MJavjZElGSR2c0A1NAD0ifJbsZfv5K1lrUI7VeqgtM/7rOWOd+z9r6AApaNTlzWa4D6
 9ClsVXPD7d70g2ek36UqVadp2uf5Zxx1uEDLKiIjyjeh17xtw5CZVoNibjnrEiiNsTBK
 qSCKaOP6hMiS7ZfGznJPU+GodwoYznfu2vJAYvDJ+SD3ZAoNYo1PEkeOBjjoOs87dJYl
 5/HJTIJL/eRPPbeu73GI3M5VMeAcDydYddYUlYZjZxuiK0NANmm2++hCokgbf516QCT9 tg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n25k7g0ye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jan 2023 22:22:06 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30BKbJEH022857;
        Wed, 11 Jan 2023 22:22:05 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4ed5y9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jan 2023 22:22:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvWccjyGDApOZxlZBlyWyPLYbdQo73pSPqnURrAHHEqiz6jFONbK608wBsjwpb2bMRVoesayZbJf7J5Wbn4EplqY6GcuZeRHLwHBLoJ41/zvAhLnu2IiPSjuSkzhbRzRbadJlvtaNJEZlvaZ9koG/drDAHkCaTALHZM6HVMqmHm1nnwAGDeGnSI1KsQ4BfuMtuauP1wTjKa/pdLt6lhykeGu7Tilu7fdMmxLan8+4RbfiL+i2YFKZ4k0BDwLlCVPcNVQSi0K872srcgm+LP/SSYZEQYU74wWgiV8C9ZXhYCap/vGkAvYbkONWYS2KDEDk4xJlSpHCRZTAINMLyIXcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BIUyMNgUy9z/g5r3Fm2tT7efyNydPGCFHMszmD23XnA=;
 b=idGXsEUh+fskaIx85XkxGHmuKi/uECYdc4z5lp5LhhRNaALEwbSjmycvv72p4DHbyrGKQEK/7HTevwdqJlLhcc270Oa9RXw9hP3++/c+nkDVjtA0KT0FZA/FqBGUVM2YK9GWbvNIgXOFAH5W4Gb5mAaNAdtZrAnW4AW2s9CgxsDmSSXcORkuZUwE5psDgq5DdoOWxaL2KPcJFEOMXPl0vRUrJ38wxXT4gHIO4l/urTq8r8/x7Ynlc6aqHxGHPWnfVwRynkoq2y+rUs8w5L5F0g+vSNOVclifBKGLy6Bh9LK2An5VDYfxOR2a2ogEzw9wIrf5/izItoggAYJ5hfhShg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BIUyMNgUy9z/g5r3Fm2tT7efyNydPGCFHMszmD23XnA=;
 b=YA/RuDHAEYkFY4ievnaJq17LXYgJ7FO/KLLtkelakAjE8UTTMlge6f4g5aKcPOH7Cf5D+RTw+ETJywIUcMIc6a5Q5/w3YDMxlEjXqLC9hG9Zljr84isG+b+rdTRcCJcMKyjuHIRI1Us/IGTiEbO1RvWGtI5uLmLHDgdWdfaC/0c=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY8PR10MB6756.namprd10.prod.outlook.com (2603:10b6:930:97::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Wed, 11 Jan
 2023 22:22:02 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14%8]) with mapi id 15.20.6002.012; Wed, 11 Jan 2023
 22:22:02 +0000
Date:   Wed, 11 Jan 2023 14:21:59 -0800
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
Message-ID: <Y782h7t10uRVW0RC@monkey>
References: <20230110075327.590514-1-ying.huang@intel.com>
 <Y74WsWCFGh2wFGji@monkey>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y74WsWCFGh2wFGji@monkey>
X-ClientProxiedBy: MW4PR04CA0090.namprd04.prod.outlook.com
 (2603:10b6:303:6b::35) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CY8PR10MB6756:EE_
X-MS-Office365-Filtering-Correlation-Id: 621f75e1-fdb6-4cc7-332c-08daf4224350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: isVQrZkMXJvVso2H7tNbhR1VoLI4zIT8UV7OC13sHI1XvYHZh/myfaYGimRmMmfHLWArZA08r27IRwL4pPJ6YkEuANixC8QeiZA0ci/+3rZ7W5MABTGILEostVeWZAicHYnFybJSJyniQfaey9nprNCt7ffHQXDJ8UL3bISPfQFPPF88DgWypglR2YyaUqNc9a7YM/j1ADC6SfcCG4HYSO0s2EPAAj7IK3Ri/LnMzOgVTpkXBprs/PA3KM8hZM1EiQSCurIuTTJVDCaXPlJLx5J/y/G2XT2f+4sfkVuvtUTjte7055fPVh7/i3+i7wwMqrQ7+yWOUijJfApGKsN8FZ5kyEoptpP4wIAV6x7Ipj0vdY0yd4r0TaCE65oHpK4ZimnjEdVlYK2tHzdF1V+xirV45qkgimxgB1AH/p2/Z+xHjNmkyzctT+0N5Tjaq8ZREeO1gUf8TUYw0+yMok3jVgUeDlB4LKlyBP/PH6t2xw2bugmphDS4qeGnccx355PedyRofEjGqerSuaQp89Op7nsP2eqs1bXsOyE9QBF6BUvCZXEVRmiDnozmr6xn/qFTq13Jqiar+ROK7vu566HUp4l/P4HQurAsBRitPzZqrVbLaoYuhR5ut50UBUkQzOwIdlaOsPrSbvVoB9jLIlPfTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(396003)(376002)(39860400002)(346002)(366004)(451199015)(86362001)(44832011)(8936002)(7416002)(5660300002)(6486002)(30864003)(66946007)(83380400001)(53546011)(6506007)(478600001)(26005)(33716001)(9686003)(6666004)(186003)(6512007)(8676002)(66476007)(41300700001)(4326008)(6916009)(316002)(66556008)(38100700002)(45080400002)(54906003)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?upfsSoPetpW+7dlEQKymklm2aX7ABEo5ZyPpc7Iurgak7MFgxPOCS4OjgHwn?=
 =?us-ascii?Q?9UPhlwFzkUZKDNCRghnylm3+6jNYrPbgRDBY37GMEVSGwC5J6QOrT3dBOU1e?=
 =?us-ascii?Q?crJ0QJd5lIFGsdd9T3XB6DgXBYoDcBJ36bONrkXEOajbYzXSMEmojbfkwETA?=
 =?us-ascii?Q?JK15cXAQFoV0kJDID+vxEptMlErvO22duJWn33drMTpv4XKMNGpZLzTq+ASX?=
 =?us-ascii?Q?Z0U4mAwBOx/LjvbjgTtAFArT5GjDwL1xdVfo6kUaljRjdeEk+GVIKfWLkGH/?=
 =?us-ascii?Q?kvVhpq1sdadwtEqmxGKxYCUVSqBXpbc2IP99jQVkhZJJKNlNVkrztdxudmfX?=
 =?us-ascii?Q?iqi7UGbCKPW9J9M4ljMhH9mt8o6S4hA/G8dejqHC3I82jIX6jE12SyQBQQCR?=
 =?us-ascii?Q?e3Rx3WZDdcEL684kJ7EPel6SPDElwxw7n9qa3x3PTFZ6e2q6P6BXnrhuCik+?=
 =?us-ascii?Q?I7wGx5VvByZseNBUjHyYDOKNJtSsuXZ1qk9A7hJmUdbIhT/jdW1Om2txgXXM?=
 =?us-ascii?Q?+sFLr538kcevUsyQL/fA4LDwg01/bDFPNmelRyzuXgEZ4/ywNBNi98s6U3Ue?=
 =?us-ascii?Q?+hyp8FSKKLrkqtVX3OTfp3kb6S9c2C08AWgc2QmZ9rie0N02h549CjVE48YJ?=
 =?us-ascii?Q?SlRhKNsSC9M5pm/h5JUtCBwoizmYp7XG03SvhhHDpPcJ0ZkfzVbLcfOkVIbh?=
 =?us-ascii?Q?mKPlJhDtjcMZFwP75iwJ4/js2lU8WyLIDc+q+hi6YhehA6rvcZRTFb5IWMx9?=
 =?us-ascii?Q?jLwp5avEvbUGysU3DUZ8m2I2KlCwrjAXELgFPDfQD1n4MgaZZMor8cs8bLGw?=
 =?us-ascii?Q?3xyxV9clCVopwjLcop7GwSkj5+D5dWtJcSaFhaQ8CirWNANobqJIkHuwozWB?=
 =?us-ascii?Q?b1UTjDUi+Lt5EtTBL0LJtHTGUxE+Fzrbz1VhgjsKRHh2qs1V1Ex4Dx6btLLo?=
 =?us-ascii?Q?SQR6DeFt6ghRDKKgqF2lGGQfiTRtNn7NcNvyVF1JjIUsbbMAKSbN1ys6qMOV?=
 =?us-ascii?Q?E5z0aLlGJNjiKf9s3llxn8Z4v3dEFOF1jiIvZFbayQhbS487R8V0fZ/8AsYR?=
 =?us-ascii?Q?JIMLUKu3yO/oZPJlxGskN/qdzRKCMyOiVz3ZIyT6UU9h3QrNzTZKQAKgwhDG?=
 =?us-ascii?Q?KbdbI5lWp1LuV3C0WbZu4EU/1tLWwNh8rq49TfC2XnZlqDa/orHIU/GePKG6?=
 =?us-ascii?Q?hj+aK4z38fcPbrF/uNtrUG2KHXSRqGxYv+RUnVG/bBt/K9dT3OQC0BAYye8D?=
 =?us-ascii?Q?nPjxKjTNHUhrWtTFU40ieuie89KVnJyrBmzUvGR8wBc+84gk1tEsRIcxa4ht?=
 =?us-ascii?Q?AmimEvrglz9vmEc7M6stIJxkh42hwQKl6BGHLzc5T81Ef/Cut0l/ZB5PrFW1?=
 =?us-ascii?Q?8v1FLQuW9oVsdmdWQwUJzZ63DUlBWmcyQK2f58J2xALbDi7x86irbhMVbOFF?=
 =?us-ascii?Q?p0SHHXbQ1ffb1KYsdrGxqAGRA45xnoueBTQHnG08GyvrDjgwmPMqTSGDFEDj?=
 =?us-ascii?Q?oKG4TwixlrT1QE3wIqQFHETrMk/tTCYHh+wcvnbt5oXKlxFiZTKQk+Q27dD/?=
 =?us-ascii?Q?ds9b9dESO3m74ZftHAl3nP9BoRWty089iHQdD9GlCu/6/b7Qt6XfLMSOJosr?=
 =?us-ascii?Q?mA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?xDxN76VjLnIf6ZiMXXyVnLTPKUeg3tVlpgVx2Qnpm+OaoOVdeOB52w0esAs0?=
 =?us-ascii?Q?UKtkjkFKjQuTAp4li49NN4Na1VywmqRKFEQy2JvXH4GgskpZU9+NL0mcv/uz?=
 =?us-ascii?Q?+Lfgo1F8KVBEEIF//+/FSqORaiOPcwEJFJRPVwe0c0KR5ZTnjKTOAfvbfn6U?=
 =?us-ascii?Q?eMJjO24+FnHjEsbLdZpT8/MtW/PnhTRWMgL+OvdlhghJHeZJd4IQnWvp06qm?=
 =?us-ascii?Q?Tydn7qSDCVai5wKdmgJ5FqYaPobKy/qJVaYfSYyJE/lA7oeWo5GIg6zpvzay?=
 =?us-ascii?Q?mRKSDZjVKNWTEWF8u6XN8TYMsfxunJthE9kL9xdQYkkzRUxBaB6mIE0uJ8g1?=
 =?us-ascii?Q?uL490zeOSm25yBoSI7af7wZh7pSfGX1pwfkK+esTtERyL1jkI/s5CCqTRAtv?=
 =?us-ascii?Q?GKMlJEbye52RSOC6YiH/p/kE39i/bmFIdSbGnESbO/Zd0BrQ2y2SJpyVqqBd?=
 =?us-ascii?Q?EHgyR3EnjvGtSoOZb7XBwsjzqgd2fPDh1cBhXutsLfiDTO67HlZG00sLPZ1/?=
 =?us-ascii?Q?WdmOBFNdTgGpbkk8TezMgCRvYKNyP7bvudzmwsStVk4dztpqQ/YmU0zzZ7Id?=
 =?us-ascii?Q?rYtl8oBKBPV+7ocKPr2fQo5CDyQlJ2BwRfh54ypSMOr6cz3EgRq/QPVIIk1E?=
 =?us-ascii?Q?mYghanRozBVra58xP+vfNZrFe8vHYYMttiXow8sYus9VZ4CIxRblWqYP2jqy?=
 =?us-ascii?Q?s11waSTZH7MLS9lpa4ejQSM9K5WxYXnjLOe9VBZHNr13P+g0sL9GQTNzvkTM?=
 =?us-ascii?Q?YRbaf3E4XedpZmDUBISKiLCaC9Fb9tzB40iIxqP3XDdAaihd/HPuuC2X5Hh2?=
 =?us-ascii?Q?GeCr9Q0Fk/Gvxi4tN3Lmvt0h8hx7GyDaf/B+aLzoADu6SVLvFdvLs4eZjCJA?=
 =?us-ascii?Q?9WT191a7QbBmWGFX4RRa62Wgy7J5+yaeMzolI79JrleJ1eFLuH/A9G7MbVZE?=
 =?us-ascii?Q?yPIm+PlJQwkZCqDYZS7WhkmBb6UDMXtThOYJym2vL+ahUt29QzCs6tEe9LM5?=
 =?us-ascii?Q?PyLn9qABmKmUmLnliWP5hX4W5QC3llfTL6/P/RyO24CPakd0AqoJ75GesfOK?=
 =?us-ascii?Q?Ck29sEDg?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 621f75e1-fdb6-4cc7-332c-08daf4224350
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2023 22:22:02.3641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9tN6FlpYZYhMTn9QpWUMAZbKISu//yRmbZoaJrq7yAOX/UuCP6zekTyqIaBjNZ+sCtrW/5Vpvn9EzGq1pk4Tbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6756
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-11_10,2023-01-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=829
 malwarescore=0 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301110163
X-Proofpoint-GUID: e6oyI6q4W4f2vzbV8eN9kU5l6meUwNU1
X-Proofpoint-ORIG-GUID: e6oyI6q4W4f2vzbV8eN9kU5l6meUwNU1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/10/23 17:53, Mike Kravetz wrote:
> Just saw the following easily reproducible issue on next-20230110.  Have not
> verified it is related to/caused by this series, but it looks suspicious.

Verified this is caused by the series,

734cbddcfe72 migrate_pages: organize stats with struct migrate_pages_stats
to
323b933ba062 migrate_pages: batch flushing TLB

in linux-next.
-- 
Mike Kravetz

> 
> Reproduce by,
> 
> # echo <very large number> > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
> 
> This will 'attempt' to allocate hugetlb pages until it fails.
> 
> -- 
> Mike Kravetz
> 
> [   46.084610] page:ffffea0005d69f40 refcount:2 mapcount:1 mapping:0000000000000000 index:0xffffea0005c37bc0 pfn:0x175a7d
> [   46.086777] flags: 0x200000000002000(private|node=0|zone=2)
> [   46.088025] raw: 0200000000002000 dead000000000100 dead000000000122 ffffffff81e28c42
> [   46.089413] page:ffffea0005e6ffc0 refcount:2 mapcount:145 mapping:0000000000000000 index:0xffffea0005fe09c0 pfn:0x179bff
> [   46.089762] raw: ffffea0005c37bc0 ffff88817d0bf0c0 0000000200000000 0000000000000000
> [   46.091287] flags: 0x200000000000000(node=0|zone=2)
> [   46.091291] raw: 0200000000000000 dead000000000100 dead000000000122 ffffffff81e28c42
> [   46.091293] raw: ffffea0005fe09c0 ffff88817d0bf2e8 0000000200000090 0000000000000000
> [   46.091294] page dumped because: VM_WARN_ON_ONCE_FOLIO(!memcg && !mem_cgroup_disabled())
> [   46.092652] page dumped because: VM_WARN_ON_ONCE_FOLIO(!memcg && !mem_cgroup_disabled())
> [   46.092671] ------------[ cut here ]------------
> [   46.094438] ------------[ cut here ]------------
> [   46.095638] WARNING: CPU: 0 PID: 836 at include/linux/memcontrol.h:756 folio_lruvec_lock_irqsave+0xde/0x120
> [   46.096882] WARNING: CPU: 1 PID: 41 at include/linux/memcontrol.h:756 folio_lruvec_lock_irqsave+0xde/0x120
> [   46.098193] Modules linked in:
> [   46.099364] Modules linked in: rfkill ip6table_filter ip6_tables sunrpc snd_hda_codec_generic snd_hda_intel snd_intel_dspcfg snd_hda_codec joydev 9p snd_hwdep netfs
> [   46.100184]  rfkill
> [   46.100843]  snd_hda_core
> [   46.102560]  ip6table_filter
> [   46.103937]  snd_seq snd_seq_device snd_pcm virtio_balloon 9pnet_virtio snd_timer snd 9pnet soundcore virtio_console virtio_net net_failover
> [   46.104497]  ip6_tables
> [   46.106522]  failover virtio_blk crct10dif_pclmul
> [   46.106921]  sunrpc
> [   46.107340]  crc32_pclmul
> [   46.107873]  snd_hda_codec_generic
> [   46.109582]  crc32c_intel ghash_clmulni_intel serio_raw
> [   46.110016]  snd_hda_intel
> [   46.110698]  virtio_pci
> [   46.111067]  snd_intel_dspcfg
> [   46.111483]  virtio
> [   46.112101]  snd_hda_codec
> [   46.112963]  virtio_pci_legacy_dev virtio_pci_modern_dev virtio_ring fuse
> [   46.112970] CPU: 1 PID: 41 Comm: kcompactd0 Not tainted 6.2.0-rc3-next-20230110+ #39
> [   46.113399]  joydev
> [   46.113756] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.1-2.fc37 04/01/2014
> [   46.114248]  9p snd_hwdep
> [   46.114676] RIP: 0010:folio_lruvec_lock_irqsave+0xde/0x120
> [   46.115052]  netfs snd_hda_core snd_seq
> [   46.115972] Code: 83 66 90 80 3d 1f 76 31 01 00 0f 85 74 ff ff ff 48 c7 c6 e8 2f 21 82 48 89 df 48 89 04 24 e8 29 6b f7 ff c6 05 ff 75 31 01 01 <0f> 0b 48 8b 04 24 e9 4f ff ff ff 48 c7 c6 e8 2d 21 82 e8 0b 6b f7
> [   46.117079]  snd_seq_device snd_pcm virtio_balloon 9pnet_virtio snd_timer snd 9pnet soundcore virtio_console
> [   46.117375] RSP: 0018:ffffc9000121fa58 EFLAGS: 00010246
> [   46.118633]  virtio_net net_failover failover
> [   46.119056] 
> [   46.119845]  virtio_blk
> [   46.120351] RAX: 000000000000004c RBX: ffffea0005e6ffc0 RCX: 0000000000000000
> [   46.122782]  crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel
> [   46.124257] RDX: 0000000000000000 RSI: ffffffff8223be4a RDI: 00000000ffffffff
> [   46.125032]  serio_raw virtio_pci virtio virtio_pci_legacy_dev virtio_pci_modern_dev
> [   46.125686] RBP: 0000000000000000 R08: 3030303030327830 R09: 3030303030303030
> [   46.125891]  virtio_ring
> [   46.126250] R10: 00000000203a7367 R11: 0000000067616c66 R12: ffffc9000121fa80
> [   46.127107]  fuse
> [   46.128096] R13: ffffffff812709d0 R14: 0000000000000000 R15: ffffea0005a98e80
> [   46.128097] FS:  0000000000000000(0000) GS:ffff888277d00000(0000) knlGS:0000000000000000
> [   46.128099] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   46.128100] CR2: 0000557bd8d9ab54 CR3: 000000017f58c006 CR4: 0000000000370ee0
> [   46.128104] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   46.129137] 
> [   46.129139] CPU: 0 PID: 836 Comm: bash Not tainted 6.2.0-rc3-next-20230110+ #39
> [   46.130216] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   46.130218] Call Trace:
> [   46.130219]  <TASK>
> [   46.130221]  folio_batch_move_lru+0x91/0x180
> [   46.131261] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.1-2.fc37 04/01/2014
> [   46.131263] RIP: 0010:folio_lruvec_lock_irqsave+0xde/0x120
> [   46.131647]  folio_add_lru+0x83/0x100
> [   46.132546] Code: 83 66 90 80 3d 1f 76 31 01 00 0f 85 74 ff ff ff 48 c7 c6 e8 2f 21 82 48 89 df 48 89 04 24 e8 29 6b f7 ff c6 05 ff 75 31 01 01 <0f> 0b 48 8b 04 24 e9 4f ff ff ff 48 c7 c6 e8 2d 21 82 e8 0b 6b f7
> [   46.132825]  migrate_pages_batch+0x4fb/0x1210
> [   46.133889] RSP: 0018:ffffc90003a2f658 EFLAGS: 00010246
> [   46.135033]  ? __pfx_compaction_free+0x10/0x10
> [   46.135864] 
> [   46.136891]  ? __pfx_compaction_alloc+0x10/0x10
> [   46.136895]  ? __pfx_remove_migration_pte+0x10/0x10
> [   46.137933] RAX: 000000000000004c RBX: ffffea0005d69f40 RCX: 0000000000000000
> [   46.138143]  migrate_pages+0xa35/0xaf0
> [   46.139206] RDX: 0000000000000000 RSI: ffffffff8223be4a RDI: 00000000ffffffff
> [   46.140186]  ? __mod_node_page_state+0x72/0xc0
> [   46.140497] RBP: 0000000000000000 R08: ffffffff824636a0 R09: 0000000082d9d55e
> [   46.140823]  ? __pfx_compaction_alloc+0x10/0x10
> [   46.141527] R10: ffffffffffffffff R11: ffffffffffffffff R12: ffffc90003a2f680
> [   46.142707]  ? __pfx_compaction_free+0x10/0x10
> [   46.142714]  compact_zone+0x9d4/0xdf0
> [   46.143533] R13: ffffffff812709d0 R14: 0000000000000000 R15: ffffea0005a96c80
> [   46.143535] FS:  00007f2148bff740(0000) GS:ffff888277c00000(0000) knlGS:0000000000000000
> [   46.143537] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   46.143539] CR2: 0000563a927d7c20 CR3: 000000017f58c004 CR4: 0000000000370ef0
> [   46.144211]  kcompactd_do_work+0x1d2/0x2c0
> [   46.147103] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   46.147105] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   46.147107] Call Trace:
> [   46.147109]  <TASK>
> [   46.147111]  folio_batch_move_lru+0x91/0x180
> [   46.147833]  kcompactd+0x220/0x3e0
> [   46.148533]  folio_add_lru+0x83/0x100
> [   46.149164]  ? __pfx_autoremove_wake_function+0x10/0x10
> [   46.149413]  migrate_pages_batch+0x4fb/0x1210
> [   46.150058]  ? __pfx_kcompactd+0x10/0x10
> [   46.150814]  ? __pfx_compaction_free+0x10/0x10
> [   46.151669]  kthread+0xe6/0x110
> [   46.152277]  ? __pfx_compaction_alloc+0x10/0x10
> [   46.152281]  ? __pfx_remove_migration_pte+0x10/0x10
> [   46.153276]  ? __pfx_kthread+0x10/0x10
> [   46.153280]  ret_from_fork+0x29/0x50
> [   46.154056]  migrate_pages+0xa35/0xaf0
> [   46.154059]  ? __mod_node_page_state+0x72/0xc0
> [   46.155067]  </TASK>
> [   46.155768]  ? __pfx_compaction_alloc+0x10/0x10
> [   46.156656] ---[ end trace 0000000000000000 ]---
> [   46.157310]  ? __pfx_compaction_free+0x10/0x10
> [   46.157316]  compact_zone+0x9d4/0xdf0
> [   46.209601]  compact_zone_order+0xc0/0x130
> [   46.210469]  try_to_compact_pages+0xf0/0x2f0
> [   46.211439]  __alloc_pages_direct_compact+0x78/0x380
> [   46.212525]  __alloc_pages_slowpath.constprop.0+0x3e4/0xe10
> [   46.213725]  ? vmemmap_remap_range+0x578/0x590
> [   46.215659]  ? free_unref_page+0x186/0x1e0
> [   46.216502]  ? prepare_alloc_pages.constprop.0+0x197/0x1b0
> [   46.217583]  __alloc_pages+0x218/0x240
> [   46.218409]  alloc_buddy_hugetlb_folio.isra.0+0x66/0x140
> [   46.219456]  alloc_fresh_hugetlb_folio+0x1cd/0x260
> [   46.220410]  alloc_pool_huge_page+0x77/0xb0
> [   46.221265]  set_max_huge_pages+0x16c/0x3a0
> [   46.222124]  ? kernfs_fop_write_iter+0x160/0x1f0
> [   46.223039]  __nr_hugepages_store_common+0x4e/0xb0
> [   46.223941]  ? _kstrtoull+0x3b/0x90
> [   46.224679]  nr_hugepages_store+0x77/0x80
> [   46.225538]  kernfs_fop_write_iter+0x108/0x1f0
> [   46.226439]  vfs_write+0x203/0x3d0
> [   46.227181]  ksys_write+0x63/0xe0
> [   46.227896]  do_syscall_64+0x37/0x90
> [   46.228648]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [   46.229656] RIP: 0033:0x7f2148cf3e87
> [   46.230444] Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
> [   46.233509] RSP: 002b:00007fff92367e58 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [   46.234869] RAX: ffffffffffffffda RBX: 000000000000000d RCX: 00007f2148cf3e87
> [   46.236042] RDX: 000000000000000d RSI: 0000557bd8d9ab50 RDI: 0000000000000001
> [   46.237408] RBP: 0000557bd8d9ab50 R08: 000000000000000a R09: 00007f2148d8b0c0
> [   46.238801] R10: 00007f2148d8afc0 R11: 0000000000000246 R12: 000000000000000d
> [   46.240217] R13: 00007f2148dc7520 R14: 000000000000000d R15: 00007f2148dc7720
> [   46.241738]  </TASK>
> [   46.242289] ---[ end trace 0000000000000000 ]---
> [   46.301978] page:ffffea0005be0400 refcount:2 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0x16f810
> [   46.304043] flags: 0x200000000002000(private|node=0|zone=2)
> [   46.305321] raw: 0200000000002000 ffffea0005f3d2c8 ffffea0005fe0648 ffffffff81e28c42
> [   46.318282] raw: 0000000000000000 ffff88817a78f738 0000000200000000 0000000000000000
> [   46.319978] page dumped because: VM_WARN_ON_ONCE_FOLIO(!memcg && !mem_cgroup_disabled())
> [   46.321820] ------------[ cut here ]------------
> [   46.322924] WARNING: CPU: 0 PID: 836 at include/linux/memcontrol.h:756 isolate_migratepages_block+0x139b/0x1590
> [   46.325280] Modules linked in: rfkill ip6table_filter ip6_tables sunrpc snd_hda_codec_generic snd_hda_intel snd_intel_dspcfg snd_hda_codec joydev 9p snd_hwdep netfs snd_hda_core snd_seq snd_seq_device snd_pcm virtio_balloon 9pnet_virtio snd_timer snd 9pnet soundcore virtio_console virtio_net net_failover failover virtio_blk crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel serio_raw virtio_pci virtio virtio_pci_legacy_dev virtio_pci_modern_dev virtio_ring fuse
> [   46.334006] CPU: 0 PID: 836 Comm: bash Tainted: G        W          6.2.0-rc3-next-20230110+ #39
> [   46.335723] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.1-2.fc37 04/01/2014
> [   46.338314] RIP: 0010:isolate_migratepages_block+0x139b/0x1590
> [   46.339469] Code: 01 00 0f 85 3e f3 ff ff 48 c7 c6 e8 2f 21 82 48 89 44 24 58 44 88 54 24 60 48 89 7c 24 38 e8 ac 50 00 00 c6 05 55 5b 3a 01 01 <0f> 0b 48 8b 44 24 58 44 0f b6 54 24 60 48 8b 7c 24 38 e9 05 f3 ff
> [   46.342950] RSP: 0018:ffffc90003a2f868 EFLAGS: 00010046
> [   46.343994] RAX: 000000000000004c RBX: 0000000000000000 RCX: 0000000000000000
> [   46.345374] RDX: 0000000000000000 RSI: ffffffff8223be4a RDI: 00000000ffffffff
> [   46.346749] RBP: 000000000016f810 R08: 00000000ffffdfff R09: 00000000ffffdfff
> [   46.348100] R10: ffffffff82463700 R11: ffffffff82463700 R12: ffffc90003a2f9f0
> [   46.349424] R13: ffffea0005be0400 R14: 0000000005be0400 R15: ffff88817e3ca000
> [   46.350812] FS:  00007f2148bff740(0000) GS:ffff888277c00000(0000) knlGS:0000000000000000
> [   46.352314] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   46.353405] CR2: 0000563a927d7c20 CR3: 000000017f58c004 CR4: 0000000000370ef0
> [   46.354731] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   46.356093] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   46.357512] Call Trace:
> [   46.358080]  <TASK>
> [   46.358570]  compact_zone+0x39b/0xdf0
> [   46.359329]  compact_zone_order+0xc0/0x130
> [   46.360152]  try_to_compact_pages+0xf0/0x2f0
> [   46.360956]  __alloc_pages_direct_compact+0x78/0x380
> [   46.362015]  __alloc_pages_slowpath.constprop.0+0x3e4/0xe10
> [   46.363157]  ? vmemmap_remap_range+0x578/0x590
> [   46.364195]  ? free_unref_page+0x186/0x1e0
> [   46.365082]  ? prepare_alloc_pages.constprop.0+0x197/0x1b0
> [   46.366299]  __alloc_pages+0x218/0x240
> [   46.367853]  alloc_buddy_hugetlb_folio.isra.0+0x66/0x140
> [   46.368946]  alloc_fresh_hugetlb_folio+0x1cd/0x260
> [   46.369983]  alloc_pool_huge_page+0x77/0xb0
> [   46.370864]  set_max_huge_pages+0x16c/0x3a0
> [   46.371753]  ? kernfs_fop_write_iter+0x160/0x1f0
> [   46.372678]  __nr_hugepages_store_common+0x4e/0xb0
> [   46.373615]  ? _kstrtoull+0x3b/0x90
> [   46.374367]  nr_hugepages_store+0x77/0x80
> [   46.375117]  kernfs_fop_write_iter+0x108/0x1f0
> [   46.375887]  vfs_write+0x203/0x3d0
> [   46.376516]  ksys_write+0x63/0xe0
> [   46.377125]  do_syscall_64+0x37/0x90
> [   46.377909]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [   46.378857] RIP: 0033:0x7f2148cf3e87
> [   46.379598] Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
> [   46.382943] RSP: 002b:00007fff92367e58 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [   46.384279] RAX: ffffffffffffffda RBX: 000000000000000d RCX: 00007f2148cf3e87
> [   46.385480] RDX: 000000000000000d RSI: 0000557bd8d9ab50 RDI: 0000000000000001
> [   46.386680] RBP: 0000557bd8d9ab50 R08: 000000000000000a R09: 00007f2148d8b0c0
> [   46.387902] R10: 00007f2148d8afc0 R11: 0000000000000246 R12: 000000000000000d
> [   46.389203] R13: 00007f2148dc7520 R14: 000000000000000d R15: 00007f2148dc7720
> [   46.390510]  </TASK>
> [   46.391045] ---[ end trace 0000000000000000 ]---
> [   46.392105] page:ffffea0005be0400 refcount:2 mapcount:1 mapping:0000000000000000 index:0x0 pfn:0x16f810
> [   46.394529] flags: 0x200000000002001(locked|private|node=0|zone=2)
> [   46.396138] raw: 0200000000002001 ffffea0005be03c8 ffffc90003a2f768 ffffffff81e28c42
> [   46.399758] raw: 0000000000000000 ffff88817a78f738 0000000200000000 0000000000000000
> [   46.402249] page dumped because: VM_BUG_ON_FOLIO(!folio_test_isolated(src))
> [   46.404308] ------------[ cut here ]------------
> [   46.405764] kernel BUG at mm/migrate.c:986!
> [   46.407171] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> [   46.409174] CPU: 0 PID: 836 Comm: bash Tainted: G        W          6.2.0-rc3-next-20230110+ #39
> [   46.411797] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.1-2.fc37 04/01/2014
> [   46.413956] RIP: 0010:move_to_new_folio+0x1e4/0x1f0
> [   46.415451] Code: 63 02 fb 31 c0 e9 ce fe ff ff 48 c7 c6 e0 cd 21 82 48 89 df e8 fd 26 f9 ff 0f 0b 48 c7 c6 e0 cd 21 82 48 89 df e8 ec 26 f9 ff <0f> 0b 0f 0b 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90
> [   46.421496] RSP: 0018:ffffc90003a2f6b0 EFLAGS: 00010246
> [   46.422751] RAX: 000000000000003f RBX: ffffea0005be0400 RCX: 0000000000000000
> [   46.424844] RDX: 0000000000000000 RSI: ffffffff8223be4a RDI: 00000000ffffffff
> [   46.426904] RBP: ffffea0005e300c0 R08: 00000000ffffdfff R09: 00000000ffffdfff
> [   46.430491] R10: ffffffff82463700 R11: ffffffff82463700 R12: 0000000000000000
> [   46.432562] R13: 0000000000000001 R14: ffffea0005be0400 R15: ffffea0005be03c0
> [   46.434219] FS:  00007f2148bff740(0000) GS:ffff888277c00000(0000) knlGS:0000000000000000
> [   46.436075] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   46.438219] CR2: 0000563a927d7c20 CR3: 000000017f58c004 CR4: 0000000000370ef0
> [   46.440031] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   46.441560] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   46.443031] Call Trace:
> [   46.443586]  <TASK>
> [   46.444095]  migrate_pages_batch+0x4b9/0x1210
> [   46.445028]  ? __pfx_compaction_free+0x10/0x10
> [   46.445962]  ? __pfx_compaction_alloc+0x10/0x10
> [   46.446937]  ? __pfx_remove_migration_pte+0x10/0x10
> [   46.448008]  migrate_pages+0xa35/0xaf0
> [   46.448870]  ? __mod_node_page_state+0x72/0xc0
> [   46.449852]  ? __pfx_compaction_alloc+0x10/0x10
> [   46.450873]  ? __pfx_compaction_free+0x10/0x10
> [   46.451941]  compact_zone+0x9d4/0xdf0
> [   46.452786]  compact_zone_order+0xc0/0x130
> [   46.453722]  try_to_compact_pages+0xf0/0x2f0
> [   46.454715]  __alloc_pages_direct_compact+0x78/0x380
> [   46.456032]  __alloc_pages_slowpath.constprop.0+0x3e4/0xe10
> [   46.457468]  ? vmemmap_remap_range+0x578/0x590
> [   46.459525]  ? free_unref_page+0x186/0x1e0
> [   46.460472]  ? prepare_alloc_pages.constprop.0+0x197/0x1b0
> [   46.461667]  __alloc_pages+0x218/0x240
> [   46.462556]  alloc_buddy_hugetlb_folio.isra.0+0x66/0x140
> [   46.463725]  alloc_fresh_hugetlb_folio+0x1cd/0x260
> [   46.464706]  alloc_pool_huge_page+0x77/0xb0
> [   46.465446]  set_max_huge_pages+0x16c/0x3a0
> [   46.466234]  ? kernfs_fop_write_iter+0x160/0x1f0
> [   46.467161]  __nr_hugepages_store_common+0x4e/0xb0
> [   46.468060]  ? _kstrtoull+0x3b/0x90
> [   46.468805]  nr_hugepages_store+0x77/0x80
> [   46.469622]  kernfs_fop_write_iter+0x108/0x1f0
> [   46.470500]  vfs_write+0x203/0x3d0
> [   46.471219]  ksys_write+0x63/0xe0
> [   46.471889]  do_syscall_64+0x37/0x90
> [   46.472643]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
> [   46.473606] RIP: 0033:0x7f2148cf3e87
> [   46.474323] Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
> [   46.477667] RSP: 002b:00007fff92367e58 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [   46.479164] RAX: ffffffffffffffda RBX: 000000000000000d RCX: 00007f2148cf3e87
> [   46.480477] RDX: 000000000000000d RSI: 0000557bd8d9ab50 RDI: 0000000000000001
> [   46.481783] RBP: 0000557bd8d9ab50 R08: 000000000000000a R09: 00007f2148d8b0c0
> [   46.483086] R10: 00007f2148d8afc0 R11: 0000000000000246 R12: 000000000000000d
> [   46.484529] R13: 00007f2148dc7520 R14: 000000000000000d R15: 00007f2148dc7720
> [   46.486022]  </TASK>
> [   46.486563] Modules linked in: rfkill ip6table_filter ip6_tables sunrpc snd_hda_codec_generic snd_hda_intel snd_intel_dspcfg snd_hda_codec joydev 9p snd_hwdep netfs snd_hda_core snd_seq snd_seq_device snd_pcm virtio_balloon 9pnet_virtio snd_timer snd 9pnet soundcore virtio_console virtio_net net_failover failover virtio_blk crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel serio_raw virtio_pci virtio virtio_pci_legacy_dev virtio_pci_modern_dev virtio_ring fuse
> [   46.495734] ---[ end trace 0000000000000000 ]---
> [   46.496819] RIP: 0010:move_to_new_folio+0x1e4/0x1f0
> [   46.498074] Code: 63 02 fb 31 c0 e9 ce fe ff ff 48 c7 c6 e0 cd 21 82 48 89 df e8 fd 26 f9 ff 0f 0b 48 c7 c6 e0 cd 21 82 48 89 df e8 ec 26 f9 ff <0f> 0b 0f 0b 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90
> [   46.501891] RSP: 0018:ffffc90003a2f6b0 EFLAGS: 00010246
> [   46.503055] RAX: 000000000000003f RBX: ffffea0005be0400 RCX: 0000000000000000
> [   46.504548] RDX: 0000000000000000 RSI: ffffffff8223be4a RDI: 00000000ffffffff
> [   46.506072] RBP: ffffea0005e300c0 R08: 00000000ffffdfff R09: 00000000ffffdfff
> [   46.507643] R10: ffffffff82463700 R11: ffffffff82463700 R12: 0000000000000000
> [   46.509193] R13: 0000000000000001 R14: ffffea0005be0400 R15: ffffea0005be03c0
> [   46.510724] FS:  00007f2148bff740(0000) GS:ffff888277c00000(0000) knlGS:0000000000000000
> [   46.512569] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   46.513878] CR2: 0000563a927d7c20 CR3: 000000017f58c004 CR4: 0000000000370ef0
> [   46.515469] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   46.517088] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> 
