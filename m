Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D3FC728C00
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 01:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbjFHXxJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 19:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjFHXxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 19:53:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45142726
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 16:53:04 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 358IoYwb019786;
        Thu, 8 Jun 2023 23:52:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=fo/De9vQJpbf7WCdp/3BOJVIUsPyIVf7EMZhIQS5Agc=;
 b=m3FfFKyzpFwXhgi4NyspizOlOiEtkxn5R1sbOM8xz2Xee0xFVZ57o+XlGIEs3cnyaIK7
 2tUHbgwG721j1MAO1IOyLo6S8/XWwF0HIqC8c7OfY9HHQvFgfy7sfpDj4m2pR3Dog5iX
 N4TlPQvFAZdeFuZyZmugdTkDnbUlMG/8kL+naXBcXwUmHqavK/z8qiKQ5JHAvhWycpfG
 +zsswOXRiiLtP3qrDWDhTTBIZiqYSo/ED/8BKBEd9TEruPKQR5tCRRZrpFOOYLx6ukhx
 hnl0+HzLayA46Cq59lOiygRTwVmdNDNua3hMJeWezd1fDdWIp9lef+hIX+JGptS8dRon VA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r2a6sne8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 23:52:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 358NUpBB002898;
        Thu, 8 Jun 2023 23:52:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r2a6n9mva-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jun 2023 23:52:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNGsW0vkfb5q2t9uJdp1DGNrqRhV+OQATKRGMc2SrjrrF1oHCwVm+NS2l6qatW/SXv2F8al/XjSpSY9V4a8LWQ9DIX2agpxj/w8lwWWTp2usOPPbQdsf3LPJuQ/RnM2gm8WYWcywxYl2jaUAP58zsr2s3ZrrgTHZqKPPaKp65dplfEPWtM1t8QHT/tx/b9K2YMrW+aNYPdc5L5elb256YsWVUChVK1si6gpgJl6jGyH8UioyOrPE+eSP2AiRqQLytXQMknJvh+iTenuXz76hwg7H5zKYAiQvPPqQefBTiPMr9NkTmQ6qqZzyD2izTYpsmKwVw98wnZuwCypeJM14Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fo/De9vQJpbf7WCdp/3BOJVIUsPyIVf7EMZhIQS5Agc=;
 b=GPtVpJhevYDkv5lirNTqYTA6ztZZvcxesuqSP2x2CtIfKQ0Y9wuTTqzvUbIhhCgzFDzxXjgE98hkC8aVkUJoQwZw7qHzAAZKpphd+cvG5a69l2DBxM+SXPuJBYRXSSjpFoFfKkjXc/uqBASDDyQU/mGGO4ihmTPRmPaFPgF2F6MhAb7ym5OauJskZx2R1TJ1H3zOXLMv+EPZd82FBk4XjBqh7bcdSsd5W0/B1JHpPQG1nt7GuvENuQgr7UJqSaeOELE55B/Jmdxhs1JGoh5CdudcGt55Khcc0Cfn7hc1Yl9T+rzMMk8Uan77TAIsUgwtDyqK8y6MGqomKDYpu+8exA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fo/De9vQJpbf7WCdp/3BOJVIUsPyIVf7EMZhIQS5Agc=;
 b=ztkxjTllvUZnioubeNSqoy6Ilg5DTgpW5V5549yyns6qpwyDDs1TTfdhuwSQsjBk6N7gSEeMsN8p70BjZEJ3LQZWj3th6mOPU37xZdImr5Bc9b57NqlhxikjQn1MHwiWJjB31t4DjXCS9GaCzab2aBCgFopGKvOx1+UyUpjHP4c=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB4180.namprd10.prod.outlook.com (2603:10b6:a03:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.39; Thu, 8 Jun
 2023 23:52:37 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%6]) with mapi id 15.20.6455.030; Thu, 8 Jun 2023
 23:52:37 +0000
Date:   Thu, 8 Jun 2023 16:52:34 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Tarun Sahu <tsahu@linux.ibm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, aneesh.kumar@linux.ibm.com,
        willy@infradead.org, sidhartha.kumar@oracle.com,
        gerald.schaefer@linux.ibm.com, linux-kernel@vger.kernel.org,
        jaypatel@linux.ibm.com
Subject: Re: [PATCH v2] mm/folio: Avoid special handling for order value 0 in
 folio_set_order
Message-ID: <20230608235234.GC88798@monkey>
References: <20230515170809.284680-1-tsahu@linux.ibm.com>
 <20230606155853.GA4150@monkey>
 <873532jmot.fsf@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873532jmot.fsf@linux.ibm.com>
X-ClientProxiedBy: MW4P223CA0013.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::18) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BY5PR10MB4180:EE_
X-MS-Office365-Filtering-Correlation-Id: c721ad60-05c4-4810-7ad7-08db687b6ff1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EzZho/N/J0KojxOEpKkOvZ/gebxGKeZQuPtO0AGJ1Qd+Caq+yUNiI5H9Tw7uq6QC/+YTJXvJAFegrqYzdzvSbxiX+zxyxPBJq461QJskshpVROYwpwx9oUC4yhSLhMpTEbf/Yf2w77kSvpdTIJ8W5Bgn1sWbPkIkAR9/UMbCK0xj0Vl5w+LndxdlOySGLYZ12o7Qjk29KogzjDlykcMvnE534fT1StSX+CF8ZBTqSChB8PZvlg//y8wG76Okgj25ZEir5meLa0B7nhwIkIAWJ+mx9EVXvc3phjbnQDf1VrznCw5OypqJbSYwaftF4to21NU9i1+TbpNK3iDBMCzcTHqOctCXAfu9pWoqogmGMpypQxibx81nqE/olI6FX6m39SvSSwkScbCZMR2Q9yg73CUs8old7wiAjf/boXsSZ/L0umdbNOO4RycXh0pibYiCEAT8So5leObfuGi+JS8M9cVSkU3C50fQmeKrp10dsKubwqRYKXeNNTXhGYfx0onllWb6l3Xqrv+xdk+k97/BYzC+UlH7a4ijuit426R35rydL889JFeUpm89aCidTE1jUZ2iF+1V2CZbJCnS/b2OkiZOowfF3McrPV0/NnadFQA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199021)(66556008)(66946007)(66476007)(478600001)(8676002)(5660300002)(8936002)(6666004)(4326008)(6916009)(41300700001)(316002)(6486002)(38100700002)(53546011)(9686003)(6512007)(26005)(33716001)(6506007)(44832011)(1076003)(186003)(83380400001)(86362001)(2906002)(33656002)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Sw6unB5LS2GCa48cKZvVH8h5pQT3Rit07K6MU09Mbmk9HwY1lI8rvDFcQMbm?=
 =?us-ascii?Q?1BE+4SCkMWa+PG5X76ok62v3Wd+I0N8xaRq7Tgfz9B9rmzWkvYeOEvi/UXUu?=
 =?us-ascii?Q?+QFWek7Igw8sEkk2uj7VQQ+B7htcQoZsjaQXdJBT6h8jeL6cVe8hGnCsCSvp?=
 =?us-ascii?Q?qzIKugjAh5hYNKZ7AA9iHPfRF4E72XuHMyw7EEEs0uIHVYbj/qt+hm1ssFlq?=
 =?us-ascii?Q?IixaHNP87G+MqKHI5cldl+Wk8iMCWdRJuwyrbXn9y9ZmbZftOwgcLNAuBl3a?=
 =?us-ascii?Q?hEPDYD5st++GVNQpVXKkGfSg0rBKWsHYFdehAaRWJcwU81pqzmKJo/X7WrH/?=
 =?us-ascii?Q?ZFs/o/On6/knBT5W4d4Mr/0T0pCn0rPMfAinuR+HmWEUME4n8FzEtBvKIpal?=
 =?us-ascii?Q?SbxQxaBtGISobpKowSjBt2DsvG+QnI/WSwWMr17WIX9UuFg+QQcR4esp4PuD?=
 =?us-ascii?Q?tK0NRbvii56mUYoNC4Vobuo+5vbZCDmwZEU0N4CVvQUr8XwhA2pDbkEMjj24?=
 =?us-ascii?Q?8ywil0Qr2qwhEJODE9JOie0LYDnSj3CJ9BbeX2CTWnTp6bEdatxiGRvVVwTH?=
 =?us-ascii?Q?KOvWimtMmjqMeljs3w+VAaCTXgP/kxBGMXHl18taI8fnSNhtnw7f17it+r+G?=
 =?us-ascii?Q?Ki3dBSmlKqqnNo7joe3l3RLYFq8KKyGAqHxrW5wvih0Y50hOYd60WV0KLN5v?=
 =?us-ascii?Q?UNYN0Fj1EhhkOcFNwf3I2vnKqor5QkeB16epncrBTsZIzZBcjyaIOhVT4Ks9?=
 =?us-ascii?Q?/F6whe0V6LGwo6inNp/jJrSOMKOiWMFE0XW7K53Bm416Mi5Rz+RAotlRWtve?=
 =?us-ascii?Q?i7HaKx2AUdpyZdkS69hRzRR2scpLSbpS6+Gv4vkkHOaDFO3jrUPW4DGjdc68?=
 =?us-ascii?Q?xKUqRjmaZh65aDEvJnxzuF5Auv0dOBrYOntxMN+FDUAfA9NqXAfCpbSGbA9I?=
 =?us-ascii?Q?gml7GMvBXBHnwq1kK0bElvejCBLv5cu23hqsFcKGpB4HHD9Chz+QpCwuqUVL?=
 =?us-ascii?Q?1oAP1SbmWOy0Hx24EsN6HDm5pgNHaiYzTBznLDD5mj06omj5UrqrDH2fYsT3?=
 =?us-ascii?Q?M5iWADAv0/nPeuy+1JMnCfxI5AMv+bbWw6153nC/ZFX91tE6Vf1nzAHqDky+?=
 =?us-ascii?Q?ulkNr7N2IyjmBxCrFgXIoWOxJLT5WPohRDZxOx8h7YPVzcTSMIKMIHo/1o3j?=
 =?us-ascii?Q?EKYLPq/mDHMFNiQRCKuYaXHnoF/ltmF+q+roCHT8yRUv5kQYhxy9tXcfg5Rk?=
 =?us-ascii?Q?RQvJcwi5yauyc65X8Bzhywt8FKjE3Rt+yDNf+8Qb40W+SSC6Ss7WBIQGJlbb?=
 =?us-ascii?Q?GbzGRbWZlvavMKF+0/T7bYaFvuLFuQJUjQiJu2I6HixIl8ervcCrHdmmeCZC?=
 =?us-ascii?Q?S5obfzp+QF4vQSg9U+h8Fh/YLBUXpTAy0uVxnRB0EhWMLO7Dgsn/jbdbbmkM?=
 =?us-ascii?Q?klgPvL8gvvTa2XVLfUq5GdUoPAbOt7+26GKNGPvvBo+daFyQYuk/vfas/viX?=
 =?us-ascii?Q?gZYohGrBRLaJtydE1Hlr6GuXkyPLDvalCosQC0ztLt3QjkbYGXmLqyNCeCGY?=
 =?us-ascii?Q?hjPyNmdVMFQE6Gtl7N4w3BSu6eVE8JvTvDrGLxlb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?SC2jBTlwgdhnacmeeJS9gYN7wkCGW6ZBS88RzU3hyPFll00sCfL/sQ2usiG4?=
 =?us-ascii?Q?VScxQxVneJKlhdkKM8+Kd7YvaAED/jQ1m6SRryZ/UUiM39UcsWllKirlzdiQ?=
 =?us-ascii?Q?jUZroDtDENSg5fY2Gjw5SLZbHlyvfcG8aQ8NsIdQ3ELtHRuv4u7lTKQvj+HO?=
 =?us-ascii?Q?c0Br2dgMDnEcEVNAy/8rARQg2/oAIGFj5M8x33vMcl8PZAx1ECuQnBRHPaEW?=
 =?us-ascii?Q?xGC/khHJloM1WjzL7ICobpKvXUKkSGnCFQq+BYIxBBIk3tTbYWZ5dF9v/HCl?=
 =?us-ascii?Q?KgNMnIfTl1mQYUieBUiMQRlJgl7XO3axI+uzfrWXvjskLoMUr/gTsltaV32l?=
 =?us-ascii?Q?30xekAfThStQDuC0BK8MFtGdrr/VYCNXMs6B5NgTAoQSGBJ85tzEEFnA2b/S?=
 =?us-ascii?Q?g4WjuDlYJaIB9oZ8vGUnq+jJ1a+m2jcAe5TLdsu9wISaMEROCGZ6z5iNhIbJ?=
 =?us-ascii?Q?1QbDCLQfcWTVrMEMLAhBhmzN28JN2IgIQSBQFoINFXAJTwPFbSru2xO/01C5?=
 =?us-ascii?Q?pzT8NLS2Z3pdMHNvx/njesfMTj4BEt2Gwu8bnx1NdmfPd/jxiLK5mVgr0yIy?=
 =?us-ascii?Q?oEr7EZyAfS6Cb3T5o2zxIbsczBq87GrhKwiv6AUv4hpB1mhNUeyv7IomglYq?=
 =?us-ascii?Q?91mPBCfunXVQA2alhHxzq4xghQUTBve15rePULvkUNdqpfAym0mNoUpuTkbx?=
 =?us-ascii?Q?qbUQCG0sOQaxLkuKc+yFIHP7ovjJxmFU1KYEAVowo6ZktXl7JTcVgT6gOt0L?=
 =?us-ascii?Q?YLs8JLS5jvyEv9QX6MVcbLzbAZtiJnkSbsvlMw5+bjOojKc6qjH+leUMtdVE?=
 =?us-ascii?Q?7id24yI0TfpxOYfgMo0o5vImfqNH/P13FZqVbq9bFvGjBrYnOtUirfjxjSKb?=
 =?us-ascii?Q?obZfPI5BNTKVo4XNq1AI1NoGIkEcBrHswFegysMBNEe5Fzk9O86ms4gh2c+r?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c721ad60-05c4-4810-7ad7-08db687b6ff1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 23:52:37.5586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7+MvTkoMew+iPbkDHE5yWRZJIu+j4PRs5W3XhsuZ9KzLe5zbW3/UAvtBZ38vEKmVtNfbiXVa9TGYU+6htOUOiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4180
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_18,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306080205
X-Proofpoint-GUID: Y0YjW_EPnz2xFO8W89KBZFioaR2dK_F2
X-Proofpoint-ORIG-GUID: Y0YjW_EPnz2xFO8W89KBZFioaR2dK_F2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/23 15:33, Tarun Sahu wrote:
> Hi Mike,
> 
> Please find my comments inline.
> 
> Mike Kravetz <mike.kravetz@oracle.com> writes:
> 
> > On 06/06/23 10:32, Tarun Sahu wrote:
> >>                                        
> >> Hi Mike,              
> >>     
> >> Thanks for your inputs.                          
> >> I wanted to know if you find it okay, Can I send it again adding your Reviewed-by?
> >
> > Hi Tarun,
> >
> > Just a few more comments/questions.
> >
> > On 05/15/23 22:38, Tarun Sahu wrote:
> >> folio_set_order(folio, 0) is used in kernel at two places
> >> __destroy_compound_gigantic_folio and __prep_compound_gigantic_folio.
> >> Currently, It is called to clear out the folio->_folio_nr_pages and
> >> folio->_folio_order.
> >> 
> >> For __destroy_compound_gigantic_folio:
> >> In past, folio_set_order(folio, 0) was needed because page->mapping used
> >> to overlap with _folio_nr_pages and _folio_order. So if these fields were
> >> left uncleared during freeing gigantic hugepages, they were causing
> >> "BUG: bad page state" due to non-zero page->mapping. Now, After
> >> Commit a01f43901cfb ("hugetlb: be sure to free demoted CMA pages to
> >> CMA") page->mapping has explicitly been cleared out for tail pages. Also,
> >> _folio_order and _folio_nr_pages no longer overlaps with page->mapping.
> >
> > I believe the same logic/reasoning as above also applies to
> > __prep_compound_gigantic_folio.
> > Why?
> > In __prep_compound_gigantic_folio we only call folio_set_order(folio, 0)
> > in the case of error.  If __prep_compound_gigantic_folio fails, the caller
> > will then call free_gigantic_folio() on the "gigantic page".  However, it is
> > not really a gigantic  at this point in time, and we are simply calling
> > cma_release() or free_contig_range().
> > The end result is that I do not believe the existing call to
> > folio_set_order(folio, 0) in __prep_compound_gigantic_folio is actually
> > required.  ???
> No, there is a difference. IIUC, __destroy_compound_gigantic_folio
> explicitly reset page->mapping for each page of compound page which
> makes sure, even if in future some fields of struct page/folio overlaps
> with page->mapping, it won't cause `BUG: bad page state` error. But If we
> just remove folio_set_order(folio, 0) from __prep_compound_gigantic_folio
> without moving folio_set_order(folio, order), this will cause extra
> maintenance overhead to track if page->_folio_order overlaps with
> page->mapping everytime struct page fields are changed. As in case of
> overlapping page->mapping will be non-zero. IMHO, To avoid it,
> moving the folio_set_order(folio, order) after all error checks are
> done on tail pages. So, _folio_order is either set on success and not
> set in case of error. (which is the original proposal). But for
> folio_set_head, I agree the way you suggested below.
> 
> WDYT?

Right.  It is more 'future proof' to only set folio order on success as
done in your original patch.

> >
> > If my reasoning above is correct, then we could just have one patch to
> > remove the folio_set_order(folio, 0) calls and remove special casing for
> > order 0 in folio_set_order.
> >
> > However, I still believe your restructuring of __prep_compound_gigantic_folio,
> > is of value.  I do not believe there is an issue as questioned by Matthew.  My
> > reasoning has been stated previously.  We could make changes like the following
> > to retain the same order of operations in __prep_compound_gigantic_folio and
> > totally avoid Matthew's question.  Totally untested.
> >
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index ea24718db4af..a54fee663cb1 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -1950,10 +1950,8 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
> >  	int nr_pages = 1 << order;
> >  	struct page *p;
> >  
> > -	__folio_clear_reserved(folio);
> > -	__folio_set_head(folio);
> >  	/* we rely on prep_new_hugetlb_folio to set the destructor */
> > -	folio_set_order(folio, order);
> > +
> >  	for (i = 0; i < nr_pages; i++) {
> >  		p = folio_page(folio, i);
> >  
> > @@ -1969,7 +1967,7 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
> >  		 * on the head page when they need know if put_page() is needed
> >  		 * after get_user_pages().
> >  		 */
> > -		if (i != 0)	/* head page cleared above */
> > +		if (i != 0)	/* head page cleared below */
> >  			__ClearPageReserved(p);
> >  		/*
> >  		 * Subtle and very unlikely
> > @@ -1996,8 +1994,14 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
> >  		} else {
> >  			VM_BUG_ON_PAGE(page_count(p), p);
> >  		}
> > -		if (i != 0)
> > +
> > +		if (i == 0) {
> > +			__folio_clear_reserved(folio);
> > +			__folio_set_head(folio);
> > +			folio_set_order(folio, order);
> With folio_set_head, I agree to this, But does not feel good with
> folio_set_order as per my above reasoning. WDYT?

Agree with your reasoning.  We should just move __folio_set_head and
folio_set_order after the loop as you originally suggested.

> 
> > +		} else {
> >  			set_compound_head(p, &folio->page);
> > +		}
> >  	}
> >  	atomic_set(&folio->_entire_mapcount, -1);
> >  	atomic_set(&folio->_nr_pages_mapped, 0);
> > @@ -2017,7 +2021,6 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
> >  		p = folio_page(folio, j);
> >  		__ClearPageReserved(p);
> >  	}
> > -	folio_set_order(folio, 0);
> >  	__folio_clear_head(folio);
> >  	return false;
> >  }
> >
> >
> >> 
> >> struct page {
> >> ...
> >>    struct address_space * mapping;  /* 24     8 */
> >> ...
> >> }
> >> 
> >> struct folio {
> >> ...
> >>     union {
> >>         struct {
> >>         	long unsigned int _flags_1;      /* 64    8 */
> >>         	long unsigned int _head_1;       /* 72    8 */
> >>         	unsigned char _folio_dtor;       /* 80    1 */
> >>         	unsigned char _folio_order;      /* 81    1 */
> >> 
> >>         	/* XXX 2 bytes hole, try to pack */
> >> 
> >>         	atomic_t   _entire_mapcount;     /* 84    4 */
> >>         	atomic_t   _nr_pages_mapped;     /* 88    4 */
> >>         	atomic_t   _pincount;            /* 92    4 */
> >>         	unsigned int _folio_nr_pages;    /* 96    4 */
> >>         };                                       /* 64   40 */
> >>         struct page __page_1 __attribute__((__aligned__(8))); /* 64   64 */
> >>     }
> >> ...
> >> }
> >
> > I do not think the copy of page/folio definitions adds much value to the
> > commit message.
> Yeah, Will remove it.
> >

I think we are finally on the same page.  I am good with this v2 patch.
Only change is to update commit message to remove the definitions.  
-- 
Mike Kravetz
