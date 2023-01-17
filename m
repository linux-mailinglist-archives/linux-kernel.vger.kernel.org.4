Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9687166E75C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 21:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbjAQUBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 15:01:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbjAQT6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 14:58:16 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312A51E286
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:51:05 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HGSauO017790;
        Tue, 17 Jan 2023 18:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=ifJcNwYb4UZk93UHiR0wdTTd7BBbNmaJNUFcSyWS2xk=;
 b=pNeAeZc0eyzF/0fZPClk1F4wYpCI6xTKVkp+Em4DJ6W3ogo6qJ2oABxlC6gdVITSgMh7
 ++Jku5Di6lsadudt+VKtxNMYFXYfmwDNDIjt/BzDJPTLbHbUyRhPAYO1TRYxEjPefOf6
 YbYJ93l3x/+d7dBAAsE86KnE3E5HCmMGBxdQZotYrAQJId0URi5RFU2b632l1NXso6If
 rSj3pDtJp2vqaGN2aSFUs1yfZImF18GW43hGylvwxmlrdI29zzOeYgoiK/AXmP9tIHC+
 LOWyLPaBIs2/f0IOaF6Tg4pCi/Mc3C5/crjKdqgiFfbaZ8GYxXdNPqtXWf9orR6++xPA 6w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n3k6c5mc5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 18:50:29 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30HIAGgh015251;
        Tue, 17 Jan 2023 18:50:28 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n4rq4qku7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 18:50:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PgpQyn8Hep6ZL29xPX26NRqT0ufbqZIDxIT4l/HoE1kZO2J+X+0iZ0Vwx+GEubwewuX0T8hZ1zfozYIzQf5q+n7LMpdqvq0GZSAUXLqfkak2sW2iB5kvWuwQKif6O3bkFZqsLP4k6LoQKkTfZjMnUoDB/03Z/iIq2RACSSouWCEu+njis+bzENvgi3pKc/Q+/jDA/dkDnwL1Q5sxGW0qdZIcsBftRrosSmkhLNRU4HqVqACIVsV+usSrqXb1SsZ0omGBuFcV0+BKKW5i3ECPuFksWkiTMSkdAuZJ5wjR8fK35Isy6ujQf/bf10rjJ8Fwgsy8kY6T0DQGYff+1oPl0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ifJcNwYb4UZk93UHiR0wdTTd7BBbNmaJNUFcSyWS2xk=;
 b=YeWf6gadaUxqdURre++p2pOpE5Nz7nRxHyh+2npVDEbWNQ+TgjrsVRLc8mxhYTwSRanS96T/liCRo42ybnbm3+8A3hHh/oZDRpuGzuHN7F5FoXrzjS1abdMCxRP+YzuStFW+y9F3QO0sd40G4165sLApE6j43rtw4Z1e+djTB7bPO8exovyQP0O7OVLrSGdK7YzUwbAFm05x7WIetiawKOGkJaaV04IbyYuDzOeY47I/WIKReU8zIebteygPBHeB7v2GXshj2sxXD6SZFuEUbP2/Xz5eUhrbv+zbIbI9PLLxiZrOy4inqHSl8eRCj8afh3m8JAIDfsUNFvNENOgVSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ifJcNwYb4UZk93UHiR0wdTTd7BBbNmaJNUFcSyWS2xk=;
 b=ikQrlfQFRxCgeiehIBP7tsvpUh62L8gv3N4wmi7WuazGNwwiKgO/vYc392uMtdULqnrimgYx310+PNVEmZTpgAdHrwVfLHIilbtDqLJxRwzXdYRztplX44PI8UobA5KJfydSHiQ4UNGav3eRV7DRurJlUU7sO80OR+nOl/AiIVU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY8PR10MB7121.namprd10.prod.outlook.com (2603:10b6:930:73::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Tue, 17 Jan
 2023 18:50:25 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14%8]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 18:50:25 +0000
Date:   Tue, 17 Jan 2023 10:50:21 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Youquan Song <youquan.song@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Feng Tang <feng.tang@intel.com>,
        Fengwei Yin <fengwei.yin@intel.com>
Subject: Re: [linus:master] [hugetlb]  7118fc2906:
 kernel_BUG_at_lib/list_debug.c
Message-ID: <Y8bt7VE1IYGkOU3B@monkey>
References: <202301170941.49728982-oliver.sang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202301170941.49728982-oliver.sang@intel.com>
X-ClientProxiedBy: MW4PR04CA0167.namprd04.prod.outlook.com
 (2603:10b6:303:85::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CY8PR10MB7121:EE_
X-MS-Office365-Filtering-Correlation-Id: 97e1289f-06c0-46cc-9691-08daf8bbb1d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mCt+ctaxmOHu+xt3vRsbZoL+H64v5qeqzm0UwjUPEuFK3pHos+I+9uqTP2bmcrE9ydrDjjCuzZB8dlE92Sn/twoCo0w2gorYjARhgbSMTWRFD9fsqEOc94XBdzNx5lv33oRM5fOD04oUKwL0bP7rFsYQYO5Ym0DDYrQg2KIs5IkBkmTE+a79rln1QGhTWuba8MmXaxjP93UjO8dGj2I2y6pFY1nGQz1CWJBo9wyMvGu6cDh7nnqKr9bVi48qteny3LjwZBsYI5jdDKr97+1Chy1XkC98mdBfhWcDMDOVsKVxU5EyFoAwkifirR6AoJXLfyzpNv1GdppS4SKfAmXakfb4dovNy1eNyuvWbkehLDhb8poIt0SS5Pa9lU1Vxi1iBsqW9Dxzys9UfU7lVzxucnjGSsC8wlPGVj/DF2lrsvFsIJZPHATKmhvT34MAvTDhTR1lZ1HQv8ttNShWmY47HH9/m/bENJnWWKmXEL3+KHtHdfga59LetPxW83JwtCj0u7PPZBa2IFyvEcFc3tL2+HWMKDRAxL9MZBFL5NoFC9E0nXy13iDNu70vwsVVbw77FjHNtVX0GM+sItK0gd0Z72j1nwTTvKy7DO5KjhPw7HsLGM3ZtnatsJRb0gpFIwum
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199015)(86362001)(8676002)(53546011)(4326008)(9686003)(186003)(6916009)(6512007)(66556008)(66946007)(41300700001)(66476007)(26005)(316002)(6666004)(54906003)(6506007)(2906002)(478600001)(6486002)(7416002)(44832011)(38100700002)(5660300002)(83380400001)(8936002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mtkZmAc5lgrvw9qIlEvhPv4TTPiU3XTDpEiacwvvn0RPzDL+7mDhAY1CriZH?=
 =?us-ascii?Q?8SujMFWI68jxoVcUboQ6hNkzD28lcfTq0ZB0gEW8V0+lwX4Uz240aT2xg1/8?=
 =?us-ascii?Q?NwZCp4yrvtcRUZfBHAIFP1ckhdBQwJCXlqdkQOcdKEHjdO+6YfxPCT5hHYgu?=
 =?us-ascii?Q?4notn9hCHQez+/w6FTXaPf3uHAc54b8HxsLiN45nNB9sJi3QkXqzfvfOhLWR?=
 =?us-ascii?Q?aOK7+AaW5GkAaHSsn7+QwH/lnD9u2ANZX6inD4fNR5xQyEWMq1F5oTI8ibUf?=
 =?us-ascii?Q?BLhuoEigzrm+y9Rum9F1KlVpY8olgDXCJtCEkNsvhDZpYPCSxt/VP/61zXmF?=
 =?us-ascii?Q?VNxBeBoP74gDI+U7CiCeunOzLkBIFadJf/p+YnEXgVrV5wIsb3uSdpm2OJul?=
 =?us-ascii?Q?KvUyBYwGgbylCNpnchtzJAiDl5NmR+x3vWMquczBStgS5Uf0YwdIRSepPVlD?=
 =?us-ascii?Q?CnCnL4w0ysSqL0iAjksQsda7fZfpd0r4RktBETa3dQeuKB7d5316XHPUcnMn?=
 =?us-ascii?Q?ndDuAeseC616AR9HmubbY3n8Y3y48urQgxhbeQ3aG3ZdM1t6ySVgrafN/otm?=
 =?us-ascii?Q?mCDylDTB3tJisPAJ2hQYiPBi/fRfuVH6yvgqdmehQ0W26fG705GKqlP6evfW?=
 =?us-ascii?Q?R+M2B0XiDBRY6ZMREVXH9kxrdLu0xjiGJttAP8f0wmIAbZTutn9T+lae1L4u?=
 =?us-ascii?Q?7jZg7EkqvkDPLiIpUR5EwqwUv+w3nsk+WV8oxp8dyc6G0YaUh+i26HAMZ2o7?=
 =?us-ascii?Q?fxnJCQt4+t4m7llg35ogw1k8EJkGl4nf6oEArR0JrGXS0gVvktcswOh5tA3j?=
 =?us-ascii?Q?1GAIwFlxVHdH9RKtfzyBGoWeptbk74ltT7oyvgd8O1wbLqkhVR5g3LRJtq6G?=
 =?us-ascii?Q?1GGT3MsFQjWxrYBdi6AzuiUS9rsg0d3fg4jmz8nfTs4G/kaO+wpiKwEpJQYf?=
 =?us-ascii?Q?XQhy8AIwkFKmEHC+QEOIvhRLX9GQk4NA0Z8Rifu42bxDrVXm2B+1xowakzIV?=
 =?us-ascii?Q?3QiGEfXh0Xxn5JY6QDm5n1IQkDvx+tuIw3ByErqd5o8wI2y/ej8args0Njeb?=
 =?us-ascii?Q?pR3Y8I9tdogKQJ20Lcqy3HDQpMlNaAk//RCCb85dn/F8cmsGheIe2JU0vOVk?=
 =?us-ascii?Q?h0eCsKelHiMNmXep/kVD9sMKLmg7HaFrXJmC5/uXUysX1JPlINGRr/AMh9jT?=
 =?us-ascii?Q?uYC/39r/jsgsWSTbkbzK2Q3RUFbjywHbS/2n0glwaG++i8Z68OrWiVmogA2M?=
 =?us-ascii?Q?Pr8FMlTWSsbjNC+gb4ZhE3WcmvMj2WCKN1ZsYP0NKFlcI9nks4haZvMv31Di?=
 =?us-ascii?Q?Fo3c7P9bARTQ1a557JnKskXi7k1zOYsIdnxsQ4Pu8B2eovgJauxi6DNhHduk?=
 =?us-ascii?Q?41/K10G9BaLrfAXqnjNDTJLkwpKu6A8veTrRNr4575CpJVpXUseTZ6hQQ9h+?=
 =?us-ascii?Q?Pkvcaeov/9LTHfJrs8p4nHof192opradXgRRphbvtm602wEJfvZfeWGxJI85?=
 =?us-ascii?Q?JzAmOko3XeqOsBZ5I107vVSSzpQx/reafq1wxiNkhniRQ2NWO0gGL3HEzvPS?=
 =?us-ascii?Q?YhtIswVYWrQWEUWhl4heuCLPC+5Bl4DmQ6GLn6Y82whNuILA+yclY4UTE1KF?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?4vsiNjxHltcFp9n72qAeQ6m64Z27uFEohmQZclgInDOydg2fR16uoFVrDTOV?=
 =?us-ascii?Q?PenjpAcXBbD86IcEeMnc2482V1f9NSreDnBfkLxVukKZKVNCsIjSh7unJ9WC?=
 =?us-ascii?Q?kuVyJNkefifzgBN0i8pW89fQZNTT8n7GxKtUmfx3ruDpDQ57LMyZN+iTqQM0?=
 =?us-ascii?Q?imNSZIrm/O/qqE7EGN06Xh6YEdHxtday9UBcMa9JAkQq+GfqNaxpDoPfgZzv?=
 =?us-ascii?Q?UnQnzggq0Tck0DAYRb/G7SjAH0l0modteC7OZg3j8bk9TftRp2qv0/KC62Sm?=
 =?us-ascii?Q?k9P0lD3phwjgUU+0TqYDuZE5t28wUWKgaegGZWRK/nviq01u13jTMFbz30Yz?=
 =?us-ascii?Q?vRpsIdjjFTKDy1UyTZw+LM3I49n9OqJmGVq6ZVgGrTvu0c5BS3mTVKcaFjKh?=
 =?us-ascii?Q?XD2NOZTVXFZNk4ANg1hZP9DtUt+E/SGnMrfDpzAxxPhpx1NdkG3LRHlkcLS7?=
 =?us-ascii?Q?MegOBFJq/zXZeb3BucyvGADrY0MtEVUaEYSmrOeBuCspBwcZPkE3VJlm54Hb?=
 =?us-ascii?Q?XIU7mBBFhstuSPn3Ui+oDc6OrZj05h7wo8KLgZ+sqkcmTLas9U8UYNPChQGH?=
 =?us-ascii?Q?6yyIHQXsnv9aUQG+QCqVc89RkG6jYpCVJatl2h2moIhKKOEho/19lHtUmHfu?=
 =?us-ascii?Q?L9CFjCXAasnSD4oLFBTok41GsDHuT435jXe1NxzEHZ7N/Tw9cOIt82SNyCRW?=
 =?us-ascii?Q?losQffjefC2iv18riMtqIv206yE2MF7m0ogs23AYkQX95KATRWXjYr1V6cPn?=
 =?us-ascii?Q?Ct1xRDHNkWGnLKU4Sl66I663GaY6f5SbR7j2eDAxQ4xoFapAT5rZk7V6JAUn?=
 =?us-ascii?Q?zCHiMRX3DMX9fhc/qrrnTgelGPwljSj+Ju0KVRNpbFZ2SwZjB3neHm4CZcaF?=
 =?us-ascii?Q?/6hvKWQ0Trjhl0FPg+ijvIoW6t+ATPh1hbQthWoRGMwtkr3cfHzQIzVZ8LwH?=
 =?us-ascii?Q?NlvPDOLdCFV+StvshFFst5hnU6O967ydqcM5ZqBGngRjBPk7qm9tK5ywIuDl?=
 =?us-ascii?Q?dA15+Q+YAucuZ//SMmkrB0qHhoRFj/wZyRm2mq7VM0IjIH6SBoy6NSzKC17O?=
 =?us-ascii?Q?JEfcmmJmM9a+hoxqkuiBytBIL047ACOXa1oE5LTlpuG/gKsaQHz6nEv/hf92?=
 =?us-ascii?Q?mSj+YZGLnMYbxMKAznBFfk631Y3bfjVKb5OMajrxhLH96lCIS1moTSAXl9qv?=
 =?us-ascii?Q?PQ/6w28AzfTO9SXd?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e1289f-06c0-46cc-9691-08daf8bbb1d3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 18:50:25.4071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bjts9Rz4PcRef0YVYVV10PvGNwCNEIPiiLkhlxM3NvePRSO/VWUYCEoP1UfhVrQySPdvPHxe6gl+1015CTCMkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7121
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_10,2023-01-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170150
X-Proofpoint-GUID: 8co0J2wpdDFmK2f3FqNekn-bE5abF7Hy
X-Proofpoint-ORIG-GUID: 8co0J2wpdDFmK2f3FqNekn-bE5abF7Hy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/17/23 15:10, kernel test robot wrote:
> 
> +Vlastimil Babka, Hyeonggon Yoo, Feng Tang and Fengwei Yin
> 
> Hi, Mike Kravetz,
> 
> we reported
> "[linus:master] [mm, slub] 0af8489b02: kernel_BUG_at_include/linux/mm.h" [1]
> 
> Vlastimil, Hyeonggon, Feng and Fengwei gave us a lot of great guidances based on
> it, and, perticularly, after enabling below config per Vlastimil's suggestion
>   CONFIG_DEBUG_PAGEALLOC
>   CONFIG_DEBUG_PAGEALLOC_ENABLE_DEFAULT
>   CONFIG_SLUB_DEBUG
>   CONFIG_SLUB_DEBUG_ON
> by more tests, we realized the "0af8489b02" is not the real culprit.
> 
> the new bisection was triggered and finally it pointed to this "7118fc2906".
> 
> though reporting for different issues
> ("kernel_BUG_at_include/linux/mm.h" for 0af8489b02 vs.
> "kernel_BUG_at_lib/list_debug.c" for this commit),
> Feng and Fengwei helped further to confirm they are similar.
> They will supply more technical wise analysis later.
> 
> please be noted the issues are not always happening
> (~10% on this commit or 0af8489b02)

Nice work!

From other replies in this thread, it does not appear the actual code change
made by this commit is the root cause.  Rather, the change is triggering some
other bug ... perhaps in the compiler?

I will start looking at this.  However, I suspect others have more skill and
experience in this type of debug.
-- 
Mike Kravetz
