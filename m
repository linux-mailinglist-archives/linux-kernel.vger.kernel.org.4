Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340A4634B5A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 00:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbiKVXsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 18:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbiKVXsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 18:48:39 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090B48C496
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 15:48:37 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AMLg2Vw008328;
        Tue, 22 Nov 2022 23:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=XYxALwEhQJfpP78jAnaCbCeE9A2c+8Betd1EdA7V0YA=;
 b=jXymTrjjGW4QcK1Vfr6QTffSgVqR6s3cchxZ48fQky+TGNDSo1sSEiCC4Ug7NlYWusz3
 SVToTspTwR/jxFKfiVPuykbyPU9kazM8SZjmSuryeaIqXIYUc2r90bPp+DDJM7dAYsv3
 QKDvTRdFLlIU7xpl92Z4M3++5ezPuwgG9LL5wKmi27hh4aao7JoGYeK7QrU0uXU4xNoM
 V98dXJ9U3WbzRqjCQZMw/vKxDXuU+iu+e0eqOt2D5zJRdVHzV6j/FRf9R/fwApbN5Hfu
 UcgIfy+41KfN8yfA3yWpIgfic3txYHdVSYk6n4oT5DMJOgEFcOUlYvn2pC+VhWydLcID sw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m169509c4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Nov 2022 23:48:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AMM1uNY028919;
        Tue, 22 Nov 2022 23:48:26 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kxnkbx54d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Nov 2022 23:48:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evxynh74avPnC6PkmydL9mGKIq5d3In33++AR3aaLHUCRikprYxlqgvy6EtWfDax6dQ4uQo3rcf3/JV5TzDc0g2sROXSnuFrAYl6dz4ncTQM7udF/6/LIYjqivM98GMbogy6t7JqA3rPi4b/XXcoA13HhXp94t3xtk2HvC3wnqKcAIM2YEhvAGKhjSxXQ0slF1HpG1zubaA50DLV66JLb3So9cN7EbrCBOcGAVQ2+g89V0U+SJVbIMlUM29KOmOLxSEQvmtXi0T7Shqk2AJABI8PiFETRedoUMr+JgbZ/CGB9Lo+jkS+iGiptlmiV4aoUC57fmCEGjnYGnCbmY8EqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYxALwEhQJfpP78jAnaCbCeE9A2c+8Betd1EdA7V0YA=;
 b=NAV7ze74BRU4W6CvKl344bZYtWVTtSqpqblZHIJF/bMYvaqGot1jlX3reVR1LFTxP1F0SOHTSK4GfY7M3OijlXhSvPiohCdFuIMaSmdcWLyaiXW2BtCmMxBa9/V65GM1hqeeisidpPPKWk80atsKc1sKdM6WUDzx9hsIzhvXItVzroyiwUqkVe8xwKATAmkgAT/rbndp7AQc5lfeVqukbWJeTp9O0ynjX53GqJmL43zISaUg/D8a+O+8ayZt5Ofs52nwS7v6NPL2pwCyLCN0SDOU0SE9NMZSGYUP/a5Wr5Nypp2T5Rlh+xbOjqfsqdfmA/maETaxzW48+XhQGqt8pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYxALwEhQJfpP78jAnaCbCeE9A2c+8Betd1EdA7V0YA=;
 b=xUgZUUiAYmlVQ7UPY3WF7TufZQTJiAZzmeH270mYV+5OdzdMi3hApkZHoaiVlQBn3e+4F/Z3rJm/Jl8w0r9Xs/KfKVoc1kRNMAH5G4UdLz0DzcZ52qDnipSDGF3ZdxjLOTIl9G7UFWJfv8Ik89+FwCgL8GDAk9GD2LQfTmjI/cs=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH7PR10MB6507.namprd10.prod.outlook.com (2603:10b6:510:202::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Tue, 22 Nov
 2022 23:48:24 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 23:48:24 +0000
Date:   Tue, 22 Nov 2022 15:48:21 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        syzbot+f0b97304ef90f0d0b1dc@syzkaller.appspotmail.com
Subject: Re: [PATCH v1] mm/gup: disallow FOLL_FORCE|FOLL_WRITE on hugetlb
 mappings
Message-ID: <Y31fxXk/Ou3Zr6kS@monkey>
References: <20221031152524.173644-1-david@redhat.com>
 <Y1/0e12ZJT6+N0kI@nvidia.com>
 <Y2BIbyxT0Bh6bCUr@monkey>
 <e2e59601-ced3-a62e-48e8-69fd24b1297e@redhat.com>
 <20221121133320.a4e1c70af6ca72f29795fd5f@linux-foundation.org>
 <4b926dc7-b8ec-e363-b9d8-35c0f2c897f6@redhat.com>
 <Y30Js24EqCncvqO/@monkey>
 <Y30N/YCg9MOVnhLk@nvidia.com>
 <20221122150355.41805b9013855cf0433b6612@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122150355.41805b9013855cf0433b6612@linux-foundation.org>
X-ClientProxiedBy: MW4PR04CA0270.namprd04.prod.outlook.com
 (2603:10b6:303:88::35) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH7PR10MB6507:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c6d998a-d3a5-41fd-a137-08dacce40b49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0uvC1eySfCMcKpYDjywbP0MI+duj38V4o1BcOHcBUsSTZBL11GsehqRMx9uX/wPHzZR+e16TkhurhWu2AxdTGCIdvM5N2BgZklGdEBywGY4Usd8/bseQrCCUQjPISvg3HM1DWhGAa1uQmCpR5av2Du+pdOPmnwObmbLjUlOlLgVOPIf6uXmOKc6r/A/yzs6qldT6UcTG2N/rPRCQHpB0z4xf6qS0F4jsoNtx+FMpflipo3ORk2t9Unyzf1cKuc+oNdr+B/flScAoYP0a/Lvs2KsH8rLdu+1V4ydwftRE7WgfS8ZSjuVCVxONzarwn6vvU6GEEVUm4y7APNXoL6FYc8rU7sYyLxFMToBTmlTfKxRHVQZfXJojcChPAulZ2YLXmJut6XyGVHik8zH/wehqBTAV8UZsJPHyEv/fZP09WGPL2u7EciPHuoWaZtg06+ETkfBGq9rk50V6sij17Or6nQO3+aNa9lCC4A0L4bkmBJWhqOb7sumpfxc4JWpSVEIX4V+BquokuFiyAXl2D1Y/6l/FNAJvVos7N6rnlyyyyxb0Kp4+jX1rPtk3w2AUnJHZ9BXocqWLTariZcWBgnbZopMgt+cVbYCZZOYKnTTM32bo/ie9q8/CxlAAfO/h7aS67Q2lzY2ZXwGWyv/ZbytrrfjHeBZch4VbdnQgOBew516f//uQZNtaXiozC1vW5ydn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199015)(86362001)(66946007)(66556008)(41300700001)(186003)(66476007)(8676002)(4326008)(5660300002)(8936002)(44832011)(478600001)(6486002)(26005)(6666004)(316002)(6512007)(9686003)(6916009)(54906003)(6506007)(53546011)(33716001)(38100700002)(83380400001)(2906002)(66899015)(83133001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BbKSPXrSU8cfibAQeP2fSL8E6U4SmG1cg+9h4FNUJTVGbDEgATVDvfZX17w2?=
 =?us-ascii?Q?YT4g2spgeAuKuQNe+Oo5T/+vniIk4Da/wPKnbuUHcn3gmcOQwLrUIhmMEqKE?=
 =?us-ascii?Q?RLqiJQFNCFbmyPco2sEKNmOV1/HnI1V2npJO+cIbGLprfLRaZi+Vg2/Sw8+L?=
 =?us-ascii?Q?Z0SeOp9Li269H5LWD8cWBP/OhciQt3m+pfk8EXKkBGezIM8huq7t1Zi4tOYe?=
 =?us-ascii?Q?GqMyVFkuDPdN2nCAL/C+G6P2PSED6q5IFtkzHLhCpZy0v4QqVoc2ljCKdewC?=
 =?us-ascii?Q?RqdieDMUfB3xoV2+h7WXkN3ObMzGlUWsz/yeQiLQf8jMDJ8zGNd0BAZOHC2m?=
 =?us-ascii?Q?6moqSFy01ZqcWc1HQT6fDedfH40Fu4DlBPzPsb3kFeANnonIL7QoHiBbc5/X?=
 =?us-ascii?Q?5nRIoos9pbRIX8xjliPM+3WbgGuSksp+46yM7Fco3gt6YeJWZa1jdp9wXb6A?=
 =?us-ascii?Q?HD4iuCry4UVMTqn2JYauz+/4ythJNjb4Izwwwd+ZHfVGsl4oxuH+wiBSQ8Sl?=
 =?us-ascii?Q?jW0XQ0XE+VPBgCBMZO+vSZlWOljLD8kSnNPCJ45uXqAyaPZzsp+/bNzgSYtm?=
 =?us-ascii?Q?Qm6IwzoPq7dproOm8dmyqYblvrEeFiPhjkxQbJ3FSWft3Bw1vmalYGTnHHL3?=
 =?us-ascii?Q?R/jjWCB9QSEgb3OKydypQK0FdxksEzvUQ43H7SkC/wmjUl60uXgQNYrTWVta?=
 =?us-ascii?Q?7sRS3DJ5g7g0z5tAV+xfsBch2gwn5/AH+HJqzkfT6pMujgKPrtAph/oEdUet?=
 =?us-ascii?Q?Afu8TaPCsSD17eAReWn1hIpQZlRrzH2OZXlUwxboymXmEXvWPNna5PceuvoX?=
 =?us-ascii?Q?K/qoV0wsxULaifg/pUlk0sNNFBTe4YP7/PCUFOzzqY3AhQBYjRAd5FpM6dkg?=
 =?us-ascii?Q?j3M6Grm527a2RUAlKyfzMUTBOX7VCpJJ5ZC/EEK0cVmVat8O+IC6e/bDx6Co?=
 =?us-ascii?Q?U3YSeIbL+/+YXmORAsswPUVRDkq7MjnCMTwyvwN//QhEPQiqiY2BhgxxBTxd?=
 =?us-ascii?Q?/gndMuyAi04AaXT0OIwa9uGDcOXPMPib0GdM2WQKip2YaJ9fhJ1rcsALgwdl?=
 =?us-ascii?Q?s0S9K7kpwiqZTNgNYRXo85UXrnisavAgh0AWEUoKW6BJsSuLhYfpxXd8NBjI?=
 =?us-ascii?Q?3zh0I59xBKmO4HjSN7bRw9KtCVYBKd6A/GOYw0A0CdfG7uFKacJFNTxmBk4s?=
 =?us-ascii?Q?v0sfTbPpFvhgrxG9Q3Uw3cyFH1s6KE55G9N9ElsMDZQAR1+IIkoaZQ7mimVU?=
 =?us-ascii?Q?mAgcGyLkbtMaojxLcoeE6MRk7mR+Npoal4hWFRySf1uY/NKOqwHidRaqoV12?=
 =?us-ascii?Q?88uD2lKRpZsVK5g6fcLIidItPzrlkbjqIVmcsiQV47+wUfC4JdU3cdPbTrNO?=
 =?us-ascii?Q?QTF6CFyaFuhVTd9XIqAWx8M3LtyiQo12rUUHQOgvDWRXzOqFh3rkiFr64fNL?=
 =?us-ascii?Q?C7gO8dumhp4eu/kaaB2Sd6vuPccbl4cIABPfXHe9YBRPNKZnP/0W9YwZJgga?=
 =?us-ascii?Q?jl+cFN430DtP/FwsHkJUfFErA2oUD0Mgl5wQcKR8xN7CgiookScJeYCcjVO5?=
 =?us-ascii?Q?Q3Tn87B/0fkrLOEyRIXJCsaWKrE8JDODxUOzfntL+3HBGluBW2wEm93l7C9/?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?I4f+VmzVNy4nsdvJon6khgQ27I69kdN1cXygmKW6dklrKSuZ1XOy3rNjaQ5q?=
 =?us-ascii?Q?qa1sVd18ejeObQH8ZJY6wkYed9j/i22zRUgfaASAnVmaFPW179JcpKW601lN?=
 =?us-ascii?Q?r4CPRdHMki5PzjuEJ4bSgCBoMzzOEyALt6EwA+dzhuw8NwKTc84N134Fn002?=
 =?us-ascii?Q?BLyvY5uUl8H1QnButWXxywqzhHJGqIvthO/5ix7KJbFefUpcLmn0vV20tfRP?=
 =?us-ascii?Q?MAr+KBItCHuHUnSnSA8VFIgd90SoEKpuEYuGoRibuOl3TSnViZmaQrFsVQ01?=
 =?us-ascii?Q?CXrCymGOco0xtQL/xXi4z3rzVZw7ENkoOh0nzycjdG149E+BhfqBgiiIvpIn?=
 =?us-ascii?Q?ZXmR2K3U5bVpWa0dzaItS2ZqMHD5ezb5TBqVEX2o4kWBGKVSrYzeubL2vAAm?=
 =?us-ascii?Q?15zgrR7fpc5xuJQRyk08sXwohb8ILtmEWgC87mWw4XmJM0mMkDvUvd8iO4u6?=
 =?us-ascii?Q?QSon4lt/otNKbbGUjhWWcA7M2ujtJjyt7MCsUD72cGnefebM68GOfT0Q4dUS?=
 =?us-ascii?Q?thXUkxVwNgkLhmOICS9Qnanojdkz2b8pNjY9rbJAB+usB71fanV/TgIFp8W5?=
 =?us-ascii?Q?SMSiq3SSdcFzCp0dVDK2qNu6X5ip8G6H5qRtqaqUJ9hchmKCkNnUBWhzOouD?=
 =?us-ascii?Q?7W8KCKhXuczzLFXmZnXlohiF0yHlSvETKSX3+p23xR+b9f0SpvmB+G6yKLb/?=
 =?us-ascii?Q?7vWOvonEFu15WH54C0HRelu5sKxj7/1+NNCqLwKz1Xc4Gv+SZUBZdnS+kfK+?=
 =?us-ascii?Q?jktGxBiwHVO8q2nZKAKOK8ePFiBIvmnfjpQj50jhQzVVeYRA5akwvz4LEL8/?=
 =?us-ascii?Q?Z3wcXzLKJxxhO0j99SJUaa9H9lwg8I/yx1HG5uuuLeFuXoP+lzIxqg0cev1Q?=
 =?us-ascii?Q?hM8qFajp6erjEBfzh4nPBSn1qh4ldVvX6rJOY1MeAHH7PG73bVejwiIBhCoX?=
 =?us-ascii?Q?FlfcIw7nrP66SQzDVidXMA+znk0ECGC+a0Qm57HYiBOTGsXNdnHnI5srHgUP?=
 =?us-ascii?Q?c3BLnKJNvQ649f5KlDK/apTzUw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6d998a-d3a5-41fd-a137-08dacce40b49
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 23:48:24.5017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pN9D/uUF+93aHupeCv6i6OTLhA+uawhBa5DnFulkwQPcUE+1ngXuAmvpM/sviQ6ocmcvS/64u6jd7GpKBTrtgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_13,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=652 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211220180
X-Proofpoint-GUID: q7610WRcTK_Z9oRbb7-M5gY8QBHmqgfX
X-Proofpoint-ORIG-GUID: q7610WRcTK_Z9oRbb7-M5gY8QBHmqgfX
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/22 15:03, Andrew Morton wrote:
> On Tue, 22 Nov 2022 13:59:25 -0400 Jason Gunthorpe <jgg@nvidia.com> wrote:
> 
> > > > 
> > > >     While that's certainly valid, it's not the common use case with
> > > >     hugetlb pages.
> > > 
> > > FWIW, I did check with our product teams and they do not knowingly make use
> > > of private mappings without write.  Of course, that is only a small and
> > > limited sample size.
> > 
> > Yeah, if it is only this case I'm comfortable as well
> > 
> 
> So.... I am to slap a cc:stable on this patch and we're all good?

I think we will also need a Fixes tag.  There are two options for this:
1) In this patch David rightly points out
   "I assume this has been broken at least since 2014, when mm/gup.c came to
    life. I failed to come up with a suitable Fixes tag quickly."
   So, we could go with some old gup commit.
2) One of the benefits of this patch is silencing the warning introduced
   by 1d8d14641fd9 ("mm/hugetlb: support write-faults in shared mappings").
   So, we could use this for the tag.  It is also more in line with David's
   suggestion to "backport it into 6.0/6.1 to fix the warning".

My suggestion would be to use 1d8d14641fd9 for the fixes tag.  However,
David may have a better suggestion/idea.
-- 
Mike Kravetz
