Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0399A6451AD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 03:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiLGCCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 21:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiLGCCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 21:02:47 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5421EE028
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 18:02:45 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B6LKUo7001067;
        Wed, 7 Dec 2022 02:02:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=l6Xp3JK1emONBSaSiiJVRYxFq2QIy+pNPMF7Epghoos=;
 b=jFn6LmUvQtmKeTbLSyPv6UOb+bPLBcYRRUyzp2d5E4W3N3jtGXE1Z4CLTYHWG7/e8z/T
 N05kgbCcYuWjFwprh/Uw136+RrrpUVADJ92w4onOx9KaLhExrCrXtvObiMv8/Fu/3Zwp
 nFFdYr9bCKgFnOj2KfVEFA1ZFsVHa4ZYz9ZsTJsVxiLFVTuIyJ7to5hfBWvCVd2YClIM
 ISiIsRUr4cpFAAr7OCaknFsZoG3z0u+TdVra1/HMcozq5lGVTPos85igUFhh5reM92HL
 0/cFDgR6Cf+SMK7PEEAkRDPMjEcboArDK905v4LGEMd27YPtuurD24Yl4wOZ3/KlcOra kQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7ya49g3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 02:02:27 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B6NmjSi032141;
        Wed, 7 Dec 2022 02:02:25 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3maa7vjp5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 02:02:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7htRocpyK8rVXxlD8BUccjPoysVTjnZsf4v6dICVTzvdx2v1iRdNPZ725yINzCXSgSjpzQ9wDtgGtK4r0T5AIih4we2zmWnZ1V4XHRc7F5D0qWWJHdfyStr1fYjLJmj3klBZBCmMKBazAOqJdgeZxsCmDXVv28p+OviWoiFig/2PPifE8XPdcmDtxoO/Po7aZL5XpUdnjjSQbKYT2jEnhcovnm1+CQAQJTg6qWbMoywVr8wl0iGDbizJrI+x4EWzvHGgFYukvg7k2Xg3LhB/NOeoBenPiUhaBTmHxylyieTq/c2IyAmUutcpzyTbh5rm2EzNK77JYAfp0M6YHN6GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6Xp3JK1emONBSaSiiJVRYxFq2QIy+pNPMF7Epghoos=;
 b=Z5X5V/XmrhPNBMYuzoTDe+9xMrgZhND8OHxXjZQCUMASbyEGYjzuFsQdixlnbt09FSx6Awpafr6oOGVVhn8Ux9ffgVO3nV3OvJxRc0ppgSq5GFGVGxODVD/fb5x8aEbdNbPzQEpaoGyPVxzNrdLDdKcmKDX7Gi7m3zT4cpSrTeDiHy7OTgKiR4f8cZM4Uv2rsG5TnBRl9fZ9u3ms1KmOXhTKY9PFoC7wfsHlrfw42HKacU06UYHybJp15t56KiVEZ3/jpn+LnRUjmZo0gK2fDXqc6QDReoSycalF0SQ7OxwBXqfyix8UnJFnKAXpq5iMc95H54TY+zf4A4PA3sqDvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6Xp3JK1emONBSaSiiJVRYxFq2QIy+pNPMF7Epghoos=;
 b=gv/26N5+zozTBrKTHxGlg1/8YtG6/sjnkeZ+EN3niZtAv9HTlbjv4hL+jY4o4zxoYd2Jx78Oz6oLuYEuLa+aY1/rxRzbBeW98JT8z0Mu13O4bqkCXdtfbwyryLt6R1mmogUt//SQJnR/hPwKcR4X4cVmeaMYRuQ9dK5MGh3m1SI=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by IA1PR10MB6805.namprd10.prod.outlook.com (2603:10b6:208:42b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 02:02:23 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::8d67:8c42:d124:3721%4]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 02:02:23 +0000
Date:   Tue, 6 Dec 2022 18:02:19 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, almasrymina@google.com, linmiaohe@huawei.com,
        hughd@google.com, tsahu@linux.ibm.com, jhubbard@nvidia.com,
        david@redhat.com
Subject: Re: [PATCH mm-unstable v5 05/10] mm/hugetlb: convert
 update_and_free_page() to folios
Message-ID: <Y4/0K/OtyvjE1zT6@monkey>
References: <20221129225039.82257-1-sidhartha.kumar@oracle.com>
 <20221129225039.82257-6-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129225039.82257-6-sidhartha.kumar@oracle.com>
X-ClientProxiedBy: MW4PR03CA0256.namprd03.prod.outlook.com
 (2603:10b6:303:b4::21) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|IA1PR10MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: 00201220-9e89-4d0a-6cd2-08dad7f71478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wKqSSR6WFr3hed0njewsm0OUlizHPPSmp7H+WpHWOekcBmGplkXg22z/uLN5o7xocDPmmMLFCrXU3UjCjp11COl2RPYs7mAQHSxcyNRoBCmAwtXqeOK6XpV5NpwgfYEF/9P3iYxOuIb/uSZUCoshNi2f+w1x0j9dDumxranCX5MaRUsoKSiHtVz+tY/i7Ha1rTnZoTR+G4aHmcBExAVwxrBcKNCRxyXxiVn0g2i3tqb+eHaxXk/RSjmV8MMMXMQa0/Tf93hZlYkv7A4nZdQyZdnfIMF7ODsS7CQvF8vr/j3HF6xlULruKMAmTbeMfwxFd7CV41KuRX4uOgTiYwamg1m4qCEN72gSx53iPbszbNoFbUNCKyhh9IbYDpdnb30MTgJz5sPlQq2h8zMptQ3UT+yu66mn/OUd9IGYyY91VLhMc6xGb39M9VObsXPnGyqHK5CVLa9ph+2Dz4yvCXqApUQLJhsqW/mo88X15sgESVM2UuIi0fSBYiJj/+/NYEhVYy9O0LrOxVLibhhDisds/zauZzhb6ylVhtisf/+TikVCpWV4vZugvLX8iCPltUlRSHpm6QaND+Cln8kyg26PRaBWP1utyoXPcw/CYH2ReiVPMAdu2igoWUrfnQnDmFA2gx7RTsERcfPmUcEKADfOeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199015)(33716001)(86362001)(38100700002)(6862004)(8936002)(5660300002)(44832011)(7416002)(41300700001)(66946007)(66476007)(66556008)(8676002)(4326008)(15650500001)(2906002)(9686003)(26005)(6512007)(186003)(6666004)(6506007)(53546011)(83380400001)(6636002)(316002)(478600001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K3F+4TWts5c8taX+b037Uxa8GE9ytuG5r5khnF2DjC6Q6hgfDs4Z5rNonigB?=
 =?us-ascii?Q?ZQZZxuCYbb06aoKX7EdajYR1LOldo3IJOZYQVTchBxQgj4HKNDk9dRzIvdAQ?=
 =?us-ascii?Q?gpsCNSJundxT1GfQ7r2k45p8ldZkZuYlYyHNBZjVjYelBoiIgAEHFMdFrMbb?=
 =?us-ascii?Q?I4Nh0K4e6n/QMdhXwk0JZd2DhajP3/bbfap0PIosOVs4OJv2ByeMcIoNJ9zM?=
 =?us-ascii?Q?eCJ6bbCqK9FE0EXBqiXtBqlmGcQ/TpkMF32T34o/ZebqEIKxeK++0Gh04I4E?=
 =?us-ascii?Q?7N8YkrmA8LAhxlUKF+1SBZ8M1gIXZEYHVna5NQgGTxaZYpmEJUvmQOZMCLAP?=
 =?us-ascii?Q?3R3cCnXxw+NjXLbhShyGMg5qzPDARGHVw2Gpj6nTl6DSWCwgkJi5OHXcdZ9J?=
 =?us-ascii?Q?M64++aQPPflDJqGBBD4cLl6xRoRxGc1xn2wpk0ZDWP0M01dJ4sjcMWAhUJXY?=
 =?us-ascii?Q?gph6/JKzjCcfTbdEiD/2eueyK3MEmS7xfyp+FRh1xoHLHaayMLxqmkqlMTdN?=
 =?us-ascii?Q?Ucm4s0yxf9Q2hky/e/T0XvDSf5swkloI4LMoanC1LWsdoVK9ir1RibVByq6M?=
 =?us-ascii?Q?u/03Mgf4kOtonBERXf0Ky8gjNBNPFDsB985eZsBBnFgCiIvx3LswRQwuPH0+?=
 =?us-ascii?Q?i6sFn45cCfa/y47B/MJ0fKuIRYfDCj90ajqO6UYjCLbZjifN6AOdbYznuWsx?=
 =?us-ascii?Q?iOZZhy6gQTubPbkV+/XlG6JeMsymkEq9KlhpvB4JOZZAqpqLiHE1IMjQk5z7?=
 =?us-ascii?Q?1nb26IyNdfqIza6e6wP7YmFcLX6E9itfOBq2sCFXc/CPjmRyuzM4/ziPwQ+U?=
 =?us-ascii?Q?a4By2jnlouukRarpew8uHsML/03cOnIySWXJ5+nqAaRTpLiSWp52R1Wghat0?=
 =?us-ascii?Q?NO4ezJwHCP6ZKf0l6oL9mgLKa2CyKEiqoqkwNngo5HFAOp0ZAAxJeU3bnu9p?=
 =?us-ascii?Q?5QywqpEUbfMkCSmTmzU2yUEZ7Co1fW94yCW4a60LXj9ncm/kl168wek7Q2LF?=
 =?us-ascii?Q?7iDX4BgrL8gjYlJcsfp4z2F6sluEzOZMHGqxn0QrTOr4XpZs+6gq9QEmH4DG?=
 =?us-ascii?Q?/noVsPw01fhdnO9H+efFO788P2HArc95+7bH6sbOGCLHiARK2axDUsdLlUSw?=
 =?us-ascii?Q?07BWhqN4wqyXKzzwYlOz+KZqbAOLsg2inMgHpkoZZ9aKZdYtIih63dKb7p8q?=
 =?us-ascii?Q?j7nzuEtJCpWk6DVkQ1WgdKLCBxaOujz4aU5XDlkl5Rdv7P8xbRSriXDBeMEs?=
 =?us-ascii?Q?gdPg9UfV4ik/35AhN0mjMPj00ZxfMbaNjF7PjtuS/JiWGjIDFP1QvuTDLOm7?=
 =?us-ascii?Q?Cuqq5TKELowTpsLkXpAaqmdHgfeN9xiA/zfI7lTbqM5Mm7AntmTop+KiEHqb?=
 =?us-ascii?Q?GqFN7xzts0UWfHpj4mYwqcVKWJR+yS4x4pW3HNaLAiILmqsxnfCTy4Pbd/yP?=
 =?us-ascii?Q?5CJwDHYZc8RM+/Ve5u46bWPNWO1AXLuFK2FfvC8hQF+SSgHHYR/dzJWs+5TB?=
 =?us-ascii?Q?uZlLnFIcl0DUM6VLQaEdvtmOMYr2jkIZmL0k5Zh4s9+jeidwAvdWhAOmy7u9?=
 =?us-ascii?Q?FwN3JZVbRNkK7RXMDqSYigW+tz5ds/Pw+AfPh1AxrdPw9bH7NRd44sErb84c?=
 =?us-ascii?Q?uA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?y/6LkzWvURZM4IEqaSa1xhaaEilejrcAKfUyE4uEQMRh09pZ2qs6avLT9/zR?=
 =?us-ascii?Q?I6WPJwKPhmsf6Qso8ejmsRJlfm2Q4zg0cs31ThSnTz5VnXI/ZI3IpzXUsRFl?=
 =?us-ascii?Q?+XjANNBNS3YAF33E9b3VRHmmvybGmQ1g5xmEl+VJPgYL/ZeCenywNqIcwQim?=
 =?us-ascii?Q?Vw5/ALhBvk+3UdCCTFRe2zxzGXZBmiapwHPVcMRW3U91rJ8BAOrx/vpMdE4C?=
 =?us-ascii?Q?Z0k/+qWa6sOucjtz88Qoi7j8SyVFHbPkZ5KvhRb91y6X8+uSJXTPcbaomu3u?=
 =?us-ascii?Q?XqG3AfDww/aXra7FO4p2ZYIGwPfexKSOj2GKgS8QhXpdGUekyJTxClJvNLA8?=
 =?us-ascii?Q?kGpqudkGfbMYbuNKSPx59HQ3UJKkS094OK7nhbREoPPfW6JIJZTZ7DxudWJO?=
 =?us-ascii?Q?mbKPdIiQ7Q53sAIJAC4UCVqV0MBWL9Pc4iKSqKYfDzY2r5dZC0jG/xiJanKa?=
 =?us-ascii?Q?AapXjhyd3yQBudqZkhluzV2sgnD1G0Ijpr8GGo060I+E0aX3Iyp4zET66TDS?=
 =?us-ascii?Q?kh2osscz4h6VgXc4LEj0Ph4Lh0FFlO/YbI9y5rtpMyeE6IxSLRVBoN11QZ2o?=
 =?us-ascii?Q?qrqcTyhytiLZEDfvBfMY+cGQ14+lD+d/xiI+E8Qd/yfKcOEaLWb0JkaQzoTq?=
 =?us-ascii?Q?3WxAye3zR4VDOv8jeQbS5nZfP89ao9cG0meJk243IFhtrPc63WSyIEhfPKts?=
 =?us-ascii?Q?k9rvYif1aiH/CO/7TpaEsjd2AbDG0ZZ+7LXOmY/qyrBa8+DH760lanj1k1QA?=
 =?us-ascii?Q?xKcmcMKzsbWN3r7DolpBgfnT96Y0uKxQmjW/PQczH9eSLc5b3JCyWqVehldN?=
 =?us-ascii?Q?jc/LP0h1p5/ox8O05KU7ss0zniNLqOu1BH3T0l4SqjQsus0jrbqwgv+SdoX1?=
 =?us-ascii?Q?1f2cfHjlIEYK8JoRr1EqGOad3ik3gcn96Pfs8wqU4unUHoVJY8aeSdwc+ln0?=
 =?us-ascii?Q?X+EBOwdukxTpIKzYT/AT7OyGJEe1LUUomfypCF6WgCfzDAylQYrMObm5X1kq?=
 =?us-ascii?Q?f4e9efMNL+wJEqNa0yhpGBLVnmdVbbXPWm3LdkFz5yrR+Agt5Tb6PZuQVQIp?=
 =?us-ascii?Q?6rqF7++/Uigm5Akn3CN2u9YE99J47f6JAZQ/MSCrkBgjCZrE8zE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00201220-9e89-4d0a-6cd2-08dad7f71478
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 02:02:22.8707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zXHAWOtR4L7x4bfzVDp9qw5FeO292IS98EZCvx/JKGnhEVRhFUZAZQmvEANv1aRFQ3NembodnELzFym+zQuEpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-06_12,2022-12-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212070009
X-Proofpoint-GUID: dU1wsSwFn7pIReg8bBKJzrwwtIu5tuUw
X-Proofpoint-ORIG-GUID: dU1wsSwFn7pIReg8bBKJzrwwtIu5tuUw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/22 14:50, Sidhartha Kumar wrote:
> Make more progress on converting the free_huge_page() destructor to
> operate on folios by converting update_and_free_page() to folios.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  mm/hugetlb.c | 30 ++++++++++++++++--------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 90ba01a76f87..83777d1ccbf3 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
<snip>

Minor nit, not worth fixing now.  But, we should cleanup sometime.  Comments
below still refer to pages when we are operating on folios.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz

> @@ -2818,7 +2820,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
>  		 * Pages have been replaced, we can safely free the old one.
>  		 */
>  		spin_unlock_irq(&hugetlb_lock);
> -		update_and_free_page(h, old_page, false);
> +		update_and_free_hugetlb_folio(h, old_folio, false);
>  	}
>  
>  	return ret;
> @@ -2827,7 +2829,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
>  	spin_unlock_irq(&hugetlb_lock);
>  	/* Page has a zero ref count, but needs a ref to be freed */
>  	folio_ref_unfreeze(new_folio, 1);
> -	update_and_free_page(h, new_page, false);
> +	update_and_free_hugetlb_folio(h, new_folio, false);
>  
>  	return ret;
>  }
> -- 
> 2.38.1
> 
