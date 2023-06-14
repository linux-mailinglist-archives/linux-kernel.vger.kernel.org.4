Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA3E730B83
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 01:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbjFNXZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 19:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjFNXZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 19:25:30 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BB2A6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 16:25:29 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EK0AYH018100;
        Wed, 14 Jun 2023 23:25:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=o3dLp4H/ma9CFR4iTerpijcfHbuPVyP2KFhijeR1Oh0=;
 b=SNG6ZPYIildRFFYsdI4ZuYIRMEnk/aq1H6F3nNZR1EJiOfxTIw7OnchN+RkxTqprAiGx
 coTFz2nBO4+IpK3pCSc7oahR7ZqjFftUSooNpsP1LrWBJf7pvbinKlR/xUjfwLpx3F39
 YF34Ga2oscZM3WDADa47+g+srUvUwT9/E+fEo/yjFGe0M6TVQAieLlhLtz4PKqiJzxSO
 sNCfLMgS0AVW6JZrhG08XYY+a09jaXXyhwGHanamp+JvPkVTfOLn/eh13MHta+/JcNSO
 BKgXWreGNY3rrQNLjaiKe5lo8Egn6HKjnpIAMsfBlA70S3KeX5/tx73DtMUemTpr/OBD DA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h7d8s3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jun 2023 23:25:06 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35ELC3NE008940;
        Wed, 14 Jun 2023 23:25:05 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm6fyy1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Jun 2023 23:25:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F46j3Y+vrAkBoUe+uRMpZbMqh2YQJZvEUxsxb2iAU5/T76lofV303kckRv/EVqdfz2IaoWMSruw7rXr/5sdo6ujT3asFklEaEEMl2mkPa8B0YbvwzIZUQx0FxVoLsp66u6B47mSSa6ckqf7CV5J+8h4d/w8FNPMmzIt06qDpCFMlFljbGh8Jp5bBQb0eojdSb9p/f+cYLY3HjKSQMcf4g7IsOr0uiXoWPi2Tyh1o5mhVOzNkvCGj7xKMmJFQySfG1MRAl6s0Ggp48Opm0LDYTEXx/7WihnmzQDjU4vL1DnYaq+d4thwM5WVJrCe78VDBYqB7ppi8I2qiKMBY5iMtLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o3dLp4H/ma9CFR4iTerpijcfHbuPVyP2KFhijeR1Oh0=;
 b=LR+eBmasVwkv5+dfmL9mJGcZKyTusdzkRpPsaNZO93x7fJjo5dvq1slHlgAxx4MeZ7Cu2JW7oFi97enYj8tOFKeUx+7aLIR5xkqjn4wodEHpXNvGscPXPDT7Ds7GYPPrFjLgWcuUEiPcUjeo9mpSyWipGOfJQyaour3Cmn7NGTIthuXZqWFc2Bm5vSEnk6yLFq8JGhKjOnksSQ51b1fCKlLOcEwwuKTM9h34SM5Wl7O/rglw/LaIX8zu08+eAVNyqXHwcBChvZwhNLskFziDM9+yxK/Uk0sCqI88ED2hD/Ddh+Z5ZUx1eKsJln/E6J0dTgj4eA2Y01h+1c9F7NZmzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o3dLp4H/ma9CFR4iTerpijcfHbuPVyP2KFhijeR1Oh0=;
 b=Tc1zd1abAy3aRCRMRa9PudM249ZLlWQs7y1Stgkz9uGdLiSTdpD/HoqTANoMOSkZzVHUTF1+5hUAtD0PBkzmezWWBm910Ln/3Y7SqZHmJUiXl57MsFBaZlIKVYB8/6UUCxm8QlIs1TAqBNy4Yc7B5xLfIOfIkhp2BgbPevUppF0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS7PR10MB5006.namprd10.prod.outlook.com (2603:10b6:5:3a0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Wed, 14 Jun
 2023 23:25:02 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6477.037; Wed, 14 Jun 2023
 23:25:02 +0000
Date:   Wed, 14 Jun 2023 16:24:59 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 1/7] mm/hugetlb: Handle FOLL_DUMP well in
 follow_page_mask()
Message-ID: <20230614232459.GA38211@monkey>
References: <20230613215346.1022773-1-peterx@redhat.com>
 <20230613215346.1022773-2-peterx@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613215346.1022773-2-peterx@redhat.com>
X-ClientProxiedBy: MW4P221CA0017.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::22) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS7PR10MB5006:EE_
X-MS-Office365-Filtering-Correlation-Id: 09d75504-1fd5-4f04-a28d-08db6d2e9448
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xisiNUS83Fow63vdW3r/ktAswGhp7xlpIk8GSsu7R3+/GFhBbFSK1qWg6/toTUICHANaDVu1Vpo11QLiWcj9zHrtDGCuYgfJicGCiSAdIUoxXr0KThyGTYERhARUbPPbiRWHxqoJm1RLzqBu83HVT7Z/yOEJGuGFF5LYEJRryr2jPxWZ/88I0OWI57I/J3fSTZXu2fX4PoxiR/BAWlPPxTsnHXg4MI9FiQGTZA1to2zI/IWh/lGbDewwP0RByFaW1KnH7kQpvzjGrObVeS1Q0Od6hGdLPfPW+4YZAzEDqFL8SMeXaI6IbKLnKTF9X3NqOljpIkYk3WXZcLDNbrInRPEN+g/rWRxaGo0O8ddkC4KndArkV0x+kTKl2IsfuxBkunkTv2T2en717tX7mjsraCoSMLHsv6ToxgDWPEEllpvP/05ssScTHs9gEY1gBl0DbCkEyirew+Zu2ZshSGT1glgU/RfoAse6mJIrbeGKpbT1k8RJg82vrdUiIR8JB0zYvRDYgLu5wHWcef2NSp8sJjq5R3c39qnT3zu3QYJLpE/q6ICxj0amNoHDgnFprZSN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(346002)(39860400002)(396003)(366004)(376002)(451199021)(5660300002)(478600001)(54906003)(8936002)(41300700001)(316002)(8676002)(6486002)(1076003)(6506007)(7416002)(44832011)(186003)(4326008)(6916009)(66946007)(66556008)(66476007)(6666004)(53546011)(6512007)(9686003)(26005)(83380400001)(2906002)(38100700002)(86362001)(33656002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xby/L34fXNKbnJolf53keiFelyznaafnlDFe4o+Er+zt1fePru6O6r4V19k5?=
 =?us-ascii?Q?AC11WoB8/jqMStXLW4CAUN3Q8Pmaqg2oYrE8uaimVEI8LLN+u5WR9AYKLTTC?=
 =?us-ascii?Q?kfh+TsMUA6JWWxfw27hLuJNER8Ge+LqO2p36ztnjDIX5o0ODtzm3NpbmXaW7?=
 =?us-ascii?Q?EkrKNgFS6wcRGSLFRhVeNFvD228JqUvkjW60Rvn30qBiXK4MCaLXgAf4NRXj?=
 =?us-ascii?Q?L3A1jSaeR/gnO0HWvGLAR+wX8X08VOcViTxP9ZqBygvytGbLocKuQAN+2AkS?=
 =?us-ascii?Q?8FXldA/kk2Xh7Z4fM3gNBg7NDDM4qL+0pAaeSukt3a/LooOcrzxBc1tasHSk?=
 =?us-ascii?Q?Y+W2mCNe8PuiAui4MbFPoOxa9G9tSYAsDLmMKGreHVwA/B1CveYhBc5bLBtD?=
 =?us-ascii?Q?1agiebPzO2bPTicwJuOcwptZ6OQay6/d4a7EDVFo9pT0pWvdDMz4yvuKuAwP?=
 =?us-ascii?Q?4kT/AxvhkbS/ROh4pM8oe4p6uIGSdx4ERgzg7xXLfNR5eJhCQkvoYXcS0Cb9?=
 =?us-ascii?Q?Gml6DhOY5vuG94/7ZvuI3Ki02rPTn15IiuFw+HctMLNAiRKnuHdrGhoga54B?=
 =?us-ascii?Q?NgqdwgtgH2qW/K5QrfKHLdKL7VmzB1ESnXNCEaWBDzdPyVbkdvEgohNQmoV/?=
 =?us-ascii?Q?e65yAS+ywaweaolxqZ7UrdWN1AUuyXIXKngGKmL1iSPeGZrR8poTkeSolLtR?=
 =?us-ascii?Q?IHvRAczfmI1j7fvDioevlk3C+7nXIqQtlg+Eiu5DRoON1Z31CcsOPOkAC9Pm?=
 =?us-ascii?Q?UsT6YU2/06VDfdfmKbOIN8AXMlEm+DQbOKCcZ30OBONXoCznmuEcyZ3JSfU0?=
 =?us-ascii?Q?6lLuN1I08OMulUxTwih/E46QubLm8cWqXZfyTBVGTu+H4/2iB/QjoXg0Jolk?=
 =?us-ascii?Q?sxQpL8anLceMJ2WrwtdpbWw20jHQqOilx61z/f2ptUTiwV0K2gwHwt5BFC2L?=
 =?us-ascii?Q?pTf1zG3UteWh/sGktnUs1veJgWj686U+AFS4mDOBbKiPqCsZOz7NTSg7isvp?=
 =?us-ascii?Q?I0X06Xl0OBxmaqJavidQCzXFXgOzz4Rd6eoMvn8p/l+f53ijob+5DqVOae72?=
 =?us-ascii?Q?YFaQajihLGEOi5Mm7iMcE6i6yEEJoqT3lPeYweuJUaQfTc+L8NoRcYrXZ/vy?=
 =?us-ascii?Q?Q5ejTHJJdobj/ZtohyHCi888uewcJm+t9w4z/DcOHVoGaMU5D2R03NEKk1jB?=
 =?us-ascii?Q?zmcQJDM4xjuaCfDLW4uQLq0+Chob9dhazVydwC4Q3do8ShtY9cj6F2BCV/fW?=
 =?us-ascii?Q?4qKHRvZ5Sp0n2cd8nCuc+iiHhiRQxRHI7wFD9GMCxg5CyzksGLYs617+khtH?=
 =?us-ascii?Q?AliJi1k7VC06ScDAsnSkYvAikJSnbK1poAohHta2PM3P8sgTNWaUMj72/FvQ?=
 =?us-ascii?Q?SLOkU5buEJ2VljFl45GrOCwYFhPEmYFE+KJ6i6LR/rIEi0B3rJBdevxIwqNV?=
 =?us-ascii?Q?ADH2UORrHA6codY6+Q/+yqJtzutvQLO/mSTnEzx767imOn2WDLYWqnazhQ3c?=
 =?us-ascii?Q?4q5n4Ie2l6X4Ud/o/NDjy8saSwEg5OyM8FkgMJfq0gUiKRxy2U3RDChKKt1o?=
 =?us-ascii?Q?mWCOpWRFkmNuWVnszuv3lmQtb8XgvDOOGFTGItGb?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?BDgjlKQe+e/MB8rBLO9Ty4KHPkMNe7lLq6hwH1UmM9d3cpdcSRS+f6ekfuNZ?=
 =?us-ascii?Q?8YPq5epCgPycXfQuSgDDhKa5fKUl6ye+ouETGUhC5Sxg5d/K3yYIraqwXpfc?=
 =?us-ascii?Q?QJQ3Xb0gBZ/tvcq9URhrNbRbAaVPX6gOY4niXEcCB9YQa1TLfIAsSY2HFCZo?=
 =?us-ascii?Q?8xQ+UHd1nXnRhYHk1RBHedzmFYcUjX4t5G1cucl8n4RnsMYazluivN/wtTe+?=
 =?us-ascii?Q?B4uMR5Ddg2l6NoH7XFLSTqGu3B5/ko8VFPEkPNs14oTBc3OvifwBdnpy7mbm?=
 =?us-ascii?Q?m955DOGnzLvprwYM4qDWHXNxNc4yccLOUpWI47IDhGvu5R+/+lijAMEyttCt?=
 =?us-ascii?Q?3GBwk9LN6GW8mSpSV+JLQyKlmBV96Viq5CdgljGHu3iZWWAWFlnLEzW2Jxne?=
 =?us-ascii?Q?5O2oZNWaILXSFifYmZThK/95Ot+Mz0c49eobCn2L3QR5cCch2KbR8OMF94cd?=
 =?us-ascii?Q?qHDt4WNXz3FGtbqwMPBq7j30Q918uUcjbnDbz640BYC/dhjxKhKr3ApE4LtP?=
 =?us-ascii?Q?Dpe4t1FsG9B8ka2B/1i8kf8AoamEsusq46M9zasBdplMMIu/GuwcKuUYiMWo?=
 =?us-ascii?Q?TIuBEOj/WrIWgxZCFhYzur95AIHOtF6zG9Sdlt8XTY7XyBF6GqfNFT6yRX0Q?=
 =?us-ascii?Q?aDhp9nRdLL8cefbXK6IJKvqIdGKa8A5/SKEJYmW9FN6JAJSKMJuv58y4BGr0?=
 =?us-ascii?Q?9okqW9h3pYwXol1stRnhFsaRLzuVhJHrJy+DOjPl1WNCeSjm1PJozLTda3Go?=
 =?us-ascii?Q?/CDBHV0JzbFJ6yWBGb3qnP1Sl2x5Rqly3hDQsIdvf7h5m1A0aabkW6rJlvaK?=
 =?us-ascii?Q?DkSo2K5y9Arwmr1w04hgS0YDbets1uRQQM5AUdQC0bCUHEUDKOuAWNQSqHxM?=
 =?us-ascii?Q?s8XWjhRRf11Vjk7WMH2Qvj17hu5lLKaxXH1gqvzbM1OOU1DTovyx6c3EdpIZ?=
 =?us-ascii?Q?6Ce1aP85umoDsgkIroulzFSmNkOazGpiTVSuaHXOtoy/0/mxhFDkup1+33pm?=
 =?us-ascii?Q?vKPjteLFFQIOCqpZK7kDxKaq8w2bMzqVkKf69vOc0T71zCDi+hWx9vKMuK20?=
 =?us-ascii?Q?1uI6Sst8?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d75504-1fd5-4f04-a28d-08db6d2e9448
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2023 23:25:02.7891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZftTQk217IkhtdyoqN7/QFp4b8oDJC1z7tVueQAryfc+xBNtpui4yxyQn5AIlrxqNgu+C0qsWZJY3zirhXTy9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5006
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_14,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=929 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306140205
X-Proofpoint-ORIG-GUID: dnocaYcxfgAsEfnmX7bVqtAmZxBfndVc
X-Proofpoint-GUID: dnocaYcxfgAsEfnmX7bVqtAmZxBfndVc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/13/23 17:53, Peter Xu wrote:
> Firstly, the no_page_table() is meaningless for hugetlb which is a no-op
> there, because a hugetlb page always satisfies:
> 
>   - vma_is_anonymous() == false
>   - vma->vm_ops->fault != NULL
> 
> So we can already safely remove it in hugetlb_follow_page_mask(), alongside
> with the page* variable.
> 
> Meanwhile, what we do in follow_hugetlb_page() actually makes sense for a
> dump: we try to fault in the page only if the page cache is already
> allocated.  Let's do the same here for follow_page_mask() on hugetlb.
> 
> It should so far has zero effect on real dumps, because that still goes
> into follow_hugetlb_page().  But this may start to influence a bit on
> follow_page() users who mimics a "dump page" scenario, but hopefully in a
> good way.  This also paves way for unifying the hugetlb gup-slow.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/gup.c     | 9 ++-------
>  mm/hugetlb.c | 9 +++++++++
>  2 files changed, 11 insertions(+), 7 deletions(-)

Thanks Peter!

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
