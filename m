Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C319273778B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 00:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjFTWj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 18:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjFTWj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 18:39:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C3A193
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 15:39:54 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35KLXi6p004945;
        Tue, 20 Jun 2023 22:39:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=tDbowRWL9h9jT7ty7K/V6K8JoViH+9VuzUjCnYlf9QE=;
 b=W4GtC832F2MKlx/jSDhsTO3kYltuS5aPrlUFhD3aeVMzinFC7CBt6Dy/kEXz5YPo0Omn
 3XJi553fExGBmtLNYL+7IDgHW64VeyN48rWrQZo3ScCFigMAAxkTTDZINzyZzMcLlmcJ
 4RhvQfSWohrhRo3xQ2V8M5RgP2bIUuYhNlIdkeFuBOgqKYX8bTxqrYuTpOQgx0SBHQbi
 JjeqivNPBJsE6/0FVL0ngCycpD5suPiTYMh0z8ZZK3u96x9XUI7mVKFgSk7KNAy7l6yW
 47Q+z5mRC2VaDKu2Aj9/RGEVdLO16k24LKGExihQk+B8et8qZz3dgRqstvKALDbVljvA qw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93m3p291-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jun 2023 22:39:16 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35KLIuox038616;
        Tue, 20 Jun 2023 22:39:15 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r939586up-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jun 2023 22:39:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7aW8rib0wYJn294M7wH83qCo7aUiDKh4L1lguGE1bxJ4l7UVxmCRcjq+3Fg/ehDDzqv78qRd+wmf/yJDroZDFj/iVJIOHKi+IpfF/AgxCr6KlFkALK38UFBzLwihab48QEpT7oflnMIEpCPx5IgYb9GLjiVEG/vfZ4rJQor27ilFSm51AZzvILXGQOOKlBZ3ehTx/UkhBamotFhkB9cJO9zo7/FmqQvs6op1f2nW933AQjieSF8EP31PUGTxiZufYEqjHnEgsV2pTUkp/tzmPjffkslC4RmpMW8haZn5UFk4fGgC/4Sc18JMLbXY4+jnlKKlBE+Y2nWcAtQfN7bpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDbowRWL9h9jT7ty7K/V6K8JoViH+9VuzUjCnYlf9QE=;
 b=md7EWKr1Vn8NG6WTyXP7v7EFD4vnoqpcYhZNsOm96ae47DmQR31dfrRCpP2DOt7J8OLeNxCvp5Z+N78ofWbv4Je0AW4fhSjAWVKs4GtZE0DbLGlk/qtcO1VPfhiotrczEe3JgFYO3rMtVkFa0F3mVAe1y+BROySz2BMBjzc+/ZZtMdZtcHknA5+W7t+5OZ17aGh7yyS/pD1b5CFCIMCDZqZ+ktdVyqP11zmDjuZljBuKchjkL/Pl5do469JleEHn4ueeJMrdJfiRUk6xSVRlKnsBYlVtl1maXYlPg2wDcgLFNwpyROqIih06Fa2OPRDWjz0sbDGDFq1KjvecS3IyvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDbowRWL9h9jT7ty7K/V6K8JoViH+9VuzUjCnYlf9QE=;
 b=Jaaure3v6ZcfV0Tfx+OXUkpaqjfHoHjNlm2PWT3mKjiIk+6ZQ1uemCQat4BTRPZiQXqVkXQA7cRrq+lI6PqgkFuWaV1y+z705/h1p+wxJJAieWe4T5Ql3PDg6pnfq+BUERT1BdC/h5ES3wJWtaEssHnTLsb/8inMsJVS3aD10gc=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by IA1PR10MB5947.namprd10.prod.outlook.com (2603:10b6:208:3d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Tue, 20 Jun
 2023 22:39:12 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6521.020; Tue, 20 Jun 2023
 22:39:12 +0000
Date:   Tue, 20 Jun 2023 15:39:09 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     Jiaqi Yan <jiaqiyan@google.com>,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "shy828301@gmail.com" <shy828301@gmail.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "duenwen@google.com" <duenwen@google.com>,
        "axelrasmussen@google.com" <axelrasmussen@google.com>,
        "jthoughton@google.com" <jthoughton@google.com>
Subject: Re: [PATCH v1 1/3] mm/hwpoison: find subpage in hugetlb HWPOISON list
Message-ID: <20230620223909.GB3567@monkey>
References: <20230523024305.GA920098@hori.linux.bs1.fc.nec.co.jp>
 <CACw3F53C0f_Ph0etD+BgkAz4P8pX3YArjFgSPaLh_d6rUqMUCw@mail.gmail.com>
 <CACw3F52k=fhYpLpvDoVPcmKnOALLkPsGk08PdS_H0+miSYvhEQ@mail.gmail.com>
 <20230612041901.GA3083591@ik1-406-35019.vs.sakura.ne.jp>
 <CACw3F51o1ZFSYZa+XLnk4Wwjy2w_q=Kn+aOQs0=qpfG-ZYDFKg@mail.gmail.com>
 <20230616233447.GB7371@monkey>
 <CACw3F52iG5bqQbvZ9QkkRkVfy+NbSOu9hnkVOt5khukNNG73OQ@mail.gmail.com>
 <20230617225927.GA3540@monkey>
 <20230619082330.GA1612447@ik1-406-35019.vs.sakura.ne.jp>
 <20230620180533.GA3567@monkey>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620180533.GA3567@monkey>
X-ClientProxiedBy: MW4PR03CA0154.namprd03.prod.outlook.com
 (2603:10b6:303:8d::9) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|IA1PR10MB5947:EE_
X-MS-Office365-Filtering-Correlation-Id: ee6f5338-7b1d-4c84-14b3-08db71df2b73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JmfzV+FIoa8sT0XyBJHfwoQNUsNgPD6LEnoeJaQ4bxuD5vVQvf8MiOeCqoZe8wrkZ1s/Q/AbglxpeVowdTLN3TA7DJ8pQ4QwRo0Q6mK+mRd0OesF8tPQFrAKXozPhkR/Bws1RDbjE8/NqeSkyz7/i2aBgAfp08pTr3yIpptQ2RnbijWAjRqJideDXlAvl9ZL7lZwCvLmhscoDKABW/IEjFbNwvyPfOhNkTkXZlRQ7E3sLiyEmMJi3Ac90cTvoZ7Q3fFzU7oUkzcZJXnA2hlfElNR9niHsV3HYYqIKWjFYhwxt9+nPDqFxzvfv/ZIhlnjjCFsPy4fLSACaXNShWMWJhMB3rim7UBaAvp5jrChTKiX8zh+/E1IbNQBXAdSAidSndp4NpZxK3XmzAswip3D+Sm1Hjcum8GB0T2FhtBiJ9OlmMUsbuaJTLZVU4W5OFiDGRBUUTok0oVgf+TwV+W23uYCO3aUwtuq006Z9P34C8NIizsjESzyuNeMERc7VINIR0x1r8u5qCJEV923LJDdiSxrXW3VtslbPsGJudRgl5g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199021)(5660300002)(44832011)(7416002)(2906002)(33716001)(8676002)(8936002)(83380400001)(86362001)(33656002)(38100700002)(6666004)(6916009)(4326008)(6486002)(966005)(66946007)(478600001)(66476007)(66556008)(54906003)(186003)(9686003)(6512007)(26005)(41300700001)(316002)(1076003)(53546011)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FQ1iBrIXky5IJpIFpZoXoYpn9ZRKbw6TjQwhMUw5jfDZUVuXd1k8KL6Aj6w9?=
 =?us-ascii?Q?t3qkZSkZOCCYpb05oCeLkxBMwEaauLYWX/6l9UnnkyHgJvbuKM/8UEkv9Ept?=
 =?us-ascii?Q?EpMjc1HhRJ0SYHU71EG/lDGe1S3pqHLhjoGiFBPbsWd/eVL/5hr4zyz6kVBL?=
 =?us-ascii?Q?mBDG0amBR6WDUquD/nKC3XcSOy4Omk2aJMJShqq/vUeWK13HyBBBmVMQqgtt?=
 =?us-ascii?Q?pD1eQGO3QoOMTR3/MVNFFE08EVRRTh+WeXUgTtEJSvwLGUllH45eAJkV2Ca0?=
 =?us-ascii?Q?JAdkWFwHDmq2HhHaxtH93Nk74TZZwvaRoqGsRCHt7vkF/QuvvTBYbclgmye2?=
 =?us-ascii?Q?kYtGE+p0rXE9DGBeG6/WN7IVYu4+Gpbchv40WjClapWxoDQ1tjEjlVrW3+GN?=
 =?us-ascii?Q?2nq9QzFTJL0JIEafBQzTj+iTCOtECH2mFPdKZNjCAWVYF/wpFH2gOrfSWfA9?=
 =?us-ascii?Q?k+9bJZiR/IQ6E0/0PQ4/clXJIBEiq4V68C20m01rDv63Q9iHeLDVpJROzoUo?=
 =?us-ascii?Q?gOFoWHVMMddWcRVXMSLvb9yAFBwV4PR3MNqWyKXDt8FHKGOLAqXymoGhM33j?=
 =?us-ascii?Q?r+StKAoK15xeL+ljJT4rR8ZNj32aXaGLtLQcnW3qMugUkPL5q2IASxSrUclk?=
 =?us-ascii?Q?cDv+wOkhGOyJwWFnsuYvBHoawUNfq6++RDyHx3Kk1Mv4TKRTFVBmODpbDDZz?=
 =?us-ascii?Q?YbraNSrfLNtblJWMUyzw0kERuclZxpQm0mChOcv1N99fZvXqBtC+mrNWdQIE?=
 =?us-ascii?Q?Xc5ww6C0X7YVWlgpJOiXlaq3wOihF5JNKUAEuUEkaCZzYl/eZbs9US0eJjOF?=
 =?us-ascii?Q?R5dZF6H1IxcB3rWUMZeTA2wgkmM1i+X4Pw7MDzKRMnXnCg5hUBi7abQjDod5?=
 =?us-ascii?Q?JCGNJ590nRJp9o74BCrDMzYOv+SpJOK38og9eqLmKI/f/crn3mSiaWUpGX1G?=
 =?us-ascii?Q?PFT4YKLQmrsZKd4wKbUmjW/E1PoTTt/YtoU94lijTw4LxVff7BEDB8KvWcqA?=
 =?us-ascii?Q?IZb85cwo9spR+GFjNL4EC7fQhiIVBN6u0mlSVfs3sTaXyB9BVbwrCTzqMHXd?=
 =?us-ascii?Q?aeZYd276rckGvqbzsWERCltsKlDf7o0EtIQV37E4RTTCbLbVlrsJZxRhFWqS?=
 =?us-ascii?Q?gYfuwz4EeL775obRtf9UbQ9cvA+ZvGWwbE2FvZPypv6QGKkhMYDBXCX5z9iA?=
 =?us-ascii?Q?fit/I0X9p7hscU+9aqjd6SWlrUHPL5B70+8f4cF7pEptFOmUKfDiXJ6hif9W?=
 =?us-ascii?Q?aQYiZEsbYXxroVm4CdrrKAlc9kPFOXuPF6+hYzcAraFC+F3LP97AyEEUgaQ3?=
 =?us-ascii?Q?tjAxdihNk29kfHCQ+XfAPdVY9V9b4oRKozkFhfK6GFRa6vTEO1X9NAiNVWlL?=
 =?us-ascii?Q?5gPqXeoGeV/b0HtJltw+d/PE197M+dUOwQgmHfSBkBOb4oArSlhV1Co/Vkii?=
 =?us-ascii?Q?Ck5F2opyixI5ZKrrLGYcmnq/0HPDdqLfio0kHSwYfZiyya1bWRQqDq5MqdCK?=
 =?us-ascii?Q?fwzmu7x4Y2hs9zKovBnqg4xVH/oLudmPaWyn40AOl65dL4SyaC1S2Fj4GoNs?=
 =?us-ascii?Q?OYDwETvJ8mQvcTHviQcJNVW4sX7v2JcryIwB2UIe?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?7q4S5gh2XyKGt7e+gPAKq5AuQNoQxt0Ls7Ak2RzxFhboMa7/wCoABkPBLOL8?=
 =?us-ascii?Q?wmvVwXTM1w2UYzJRK6PLY+4mZu3eMzXQntLYmCw+Yr2R4dbqRn/KqcKn+6Kb?=
 =?us-ascii?Q?hvGzSwMYprxCiP7HVU97AR7Aqhs7NqkCRfbntkoWefVlITNa8685DNmDyd1V?=
 =?us-ascii?Q?PcWinLxdrY72KDgTrqz/Fe6F7VuTLPiLN5UMF+KQ7Ln9kUzBdv6qkcK8dT5u?=
 =?us-ascii?Q?iSu3N0M/X8ttr/khQcbqupZUOUdgmVDhlXb3vPczRpoq6UtDtZonajxindNc?=
 =?us-ascii?Q?ODFvGz6ozZc4Vcc++bYOeruNCBSSGyn8Tnp8cEIGIby4w3+Hj5DacRGDOmST?=
 =?us-ascii?Q?JC8K7qaAt212DsB82QRc71PWi2tZvA7lwjFAgBqwlfvd74gUBF5fpaFwMzlY?=
 =?us-ascii?Q?7v/K4BGogxqRRMZBD5abIbgQ9OSrKdkL4AnqaUlr1MyKBuydSUmeSHqKGmQX?=
 =?us-ascii?Q?maH5rVkSEuqbe6+Qt4b+NiT5dJeZ3ekKE8XW/yczXv6MGZ7L2N3MwdUlfLxy?=
 =?us-ascii?Q?aM83CzrLWY4DUZazPGytrVEfPY5dn0mjSDaz2MD6MuRmsZdrTCXVOGh8OSue?=
 =?us-ascii?Q?NHrAllXzv4lhSsekR6A6tE/MOrQaR1yJy9XkMzG7wuVRoXAYzhmtrIJEaztT?=
 =?us-ascii?Q?CTGSs8QLdtXwQq/RgunH0VdTYekUy1h8HYMM8vT/0COIt7fQp6EfGu9rpxxM?=
 =?us-ascii?Q?8A3+OgKLXhhJiR3hyXKdeNg/ipYtP5oqWIbbVe4HCcn/vHRxSdjyipltyaMq?=
 =?us-ascii?Q?17iksaNDMcU/geDDHM/zlALSo8H8Dpr2s5dxXh6vdXTr5GnB5v906qwP0x28?=
 =?us-ascii?Q?QUVCVy+8xeXf6D6omNcBK0qApDSUW6fHCndDgSWJIiquQ4MNiKgAY/HKxrDW?=
 =?us-ascii?Q?e8Wtjax/7tMmvcRR3867iUrseG3f4HjgoXV2WPmB/qWOiUZO75uAcBu5ExUH?=
 =?us-ascii?Q?EEsull3Lw9q87KBPDeXszAqRvQWf1zpcKw3UITQ9bDtTY+p6+ks9s87/b3LD?=
 =?us-ascii?Q?X+cTVsbwQxFa7pSHiQZDGe+uPw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee6f5338-7b1d-4c84-14b3-08db71df2b73
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 22:39:12.5822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3aZhqLSLMS5z7ODzjXM32rEF3qow+BbAxWUSDJY8nlxYdOUr2fda7A4X1LinNRFAUYg2m8btMtVrGjOpignmYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5947
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_16,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306200205
X-Proofpoint-GUID: BwXHYi2rPBXwcpPDP1CwVoZuVzPmwcXK
X-Proofpoint-ORIG-GUID: BwXHYi2rPBXwcpPDP1CwVoZuVzPmwcXK
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/20/23 11:05, Mike Kravetz wrote:
> On 06/19/23 17:23, Naoya Horiguchi wrote:
> > 
> > Considering this issue as one specific to memory error handling, checking
> > HPG_vmemmap_optimized in __get_huge_page_for_hwpoison() might be helpful to
> > detect the race.  Then, an idea like the below diff (not tested) can make
> > try_memory_failure_hugetlb() retry (with retaking hugetlb_lock) to wait
> > for complete the allocation of vmemmap pages.
> > 
> > @@ -1938,8 +1938,11 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
> >         int ret = 2;    /* fallback to normal page handling */
> >         bool count_increased = false;
> > 
> > -       if (!folio_test_hugetlb(folio))
> > +       if (!folio_test_hugetlb(folio)) {
> > +               if (folio_test_hugetlb_vmemmap_optimized(folio))
> > +                       ret = -EBUSY;
> 
> The hugetlb specific page flags (HPG_vmemmap_optimized here) reside in
> the folio->private field.
> 
> In the case where the folio is a non-hugetlb folio, the folio->private field
> could be any arbitrary value.  As such, the test for vmemmap_optimized may
> return a false positive.  We could end up retrying for an arbitrarily
> long time.
> 
> I am looking at how to restructure the code which removes and frees
> hugetlb pages so that folio_test_hugetlb() would remain true until
> vmemmap pages are allocated.  The easiest way to do this would introduce
> another hugetlb lock/unlock cycle in the page freeing path.  This would
> undo some of the speedups in the series:
> https://lore.kernel.org/all/20210409205254.242291-4-mike.kravetz@oracle.com/T/#m34321fbcbdf8bb35dfe083b05d445e90ecc1efab
> 

Perhaps something like this?  Minimal testing.

From e709fb4da0b6249973f9bf0540c9da0e4c585fe2 Mon Sep 17 00:00:00 2001
From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Tue, 20 Jun 2023 14:48:39 -0700
Subject: [PATCH] hugetlb: Do not clear hugetlb dtor until allocating vmemmap

Freeing a hugetlb page and releasing base pages back to the underlying
allocator such as buddy or cma is performed in two steps:
- remove_hugetlb_folio() is called to remove the folio from hugetlb
  lists, get a ref on the page and remove hugetlb destructor.  This
  all must be done under the hugetlb lock.  After this call, the page
  can be treated as a normal compound page or a collection of base
  size pages.
- update_and_free_hugetlb_folio() is called to allocate vmemmap if
  needed and the free routine of the underlying allocator is called
  on the resulting page.  We can not hold the hugetlb lock here.

One issue with this scheme is that a memory error could occur between
these two steps.  In this case, the memory error handling code treats
the old hugetlb page as a normal compound page or collection of base
pages.  It will then try to SetPageHWPoison(page) on the page with an
error.  If the page with error is a tail page without vmemmap, a write
error will occur when trying to set the flag.

Address this issue by modifying remove_hugetlb_folio() and
update_and_free_hugetlb_folio() such that the hugetlb destructor is not
cleared until after allocating vmemmap.  Since clearing the destructor
required holding the hugetlb lock, the clearing is done in
remove_hugetlb_folio() if the vmemmap is present.  This saves a
lock/unlock cycle.  Otherwise, destructor is cleared in
update_and_free_hugetlb_folio() after allocating vmemmap.

Note that this will leave hugetlb pages in a state where they are marked
free (by hugetlb specific page flag) and have a ref count.  This is not
a normal state.  The only code that would notice is the memory error
code, and it is set up to retry in such a case.

A subsequent patch will create a routine to do bulk processing of
vmemmap allocation.  This will eliminate a lock/unlock cycle for each
hugetlb page in the case where we are freeing a bunch of pages.

Fixes: ???
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 75 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 51 insertions(+), 24 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d76574425da3..f7f64470aee0 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1579,9 +1579,37 @@ static inline void destroy_compound_gigantic_folio(struct folio *folio,
 						unsigned int order) { }
 #endif
 
+static inline void __clear_hugetlb_destructor(struct hstate *h,
+						struct folio *folio)
+{
+	lockdep_assert_held(&hugetlb_lock);
+
+	/*
+	 * Very subtle
+	 *
+	 * For non-gigantic pages set the destructor to the normal compound
+	 * page dtor.  This is needed in case someone takes an additional
+	 * temporary ref to the page, and freeing is delayed until they drop
+	 * their reference.
+	 *
+	 * For gigantic pages set the destructor to the null dtor.  This
+	 * destructor will never be called.  Before freeing the gigantic
+	 * page destroy_compound_gigantic_folio will turn the folio into a
+	 * simple group of pages.  After this the destructor does not
+	 * apply.
+	 *
+	 */
+	if (hstate_is_gigantic(h))
+		folio_set_compound_dtor(folio, NULL_COMPOUND_DTOR);
+	else
+		folio_set_compound_dtor(folio, COMPOUND_PAGE_DTOR);
+}
+
 /*
- * Remove hugetlb folio from lists, and update dtor so that the folio appears
- * as just a compound page.
+ * Remove hugetlb folio from lists.
+ * If vmemmap exists for the folio, update dtor so that the folio appears
+ * as just a compound page.  Otherwise, wait until after allocating vmemmap
+ * to update dtor.
  *
  * A reference is held on the folio, except in the case of demote.
  *
@@ -1612,31 +1640,19 @@ static void __remove_hugetlb_folio(struct hstate *h, struct folio *folio,
 	}
 
 	/*
-	 * Very subtle
-	 *
-	 * For non-gigantic pages set the destructor to the normal compound
-	 * page dtor.  This is needed in case someone takes an additional
-	 * temporary ref to the page, and freeing is delayed until they drop
-	 * their reference.
-	 *
-	 * For gigantic pages set the destructor to the null dtor.  This
-	 * destructor will never be called.  Before freeing the gigantic
-	 * page destroy_compound_gigantic_folio will turn the folio into a
-	 * simple group of pages.  After this the destructor does not
-	 * apply.
-	 *
-	 * This handles the case where more than one ref is held when and
-	 * after update_and_free_hugetlb_folio is called.
-	 *
-	 * In the case of demote we do not ref count the page as it will soon
-	 * be turned into a page of smaller size.
+	 * We can only clear the hugetlb destructor after allocating vmemmap
+	 * pages.  Otherwise, someone (memory error handling) may try to write
+	 * to tail struct pages.
+	 */
+	if (!folio_test_hugetlb_vmemmap_optimized(folio))
+		__clear_hugetlb_destructor(h, folio);
+
+	 /*
+	  * In the case of demote we do not ref count the page as it will soon
+	  * be turned into a page of smaller size.
 	 */
 	if (!demote)
 		folio_ref_unfreeze(folio, 1);
-	if (hstate_is_gigantic(h))
-		folio_set_compound_dtor(folio, NULL_COMPOUND_DTOR);
-	else
-		folio_set_compound_dtor(folio, COMPOUND_PAGE_DTOR);
 
 	h->nr_huge_pages--;
 	h->nr_huge_pages_node[nid]--;
@@ -1705,6 +1721,7 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 {
 	int i;
 	struct page *subpage;
+	bool clear_dtor = folio_test_hugetlb_vmemmap_optimized(folio);
 
 	if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
 		return;
@@ -1735,6 +1752,16 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 	if (unlikely(folio_test_hwpoison(folio)))
 		folio_clear_hugetlb_hwpoison(folio);
 
+	/*
+	 * If vmemmap pages were allocated above, then we need to clear the
+	 * hugetlb destructor under the hugetlb lock.
+	 */
+	if (clear_dtor) {
+		spin_lock_irq(&hugetlb_lock);
+		__clear_hugetlb_destructor(h, folio);
+		spin_unlock_irq(&hugetlb_lock);
+	}
+
 	for (i = 0; i < pages_per_huge_page(h); i++) {
 		subpage = folio_page(folio, i);
 		subpage->flags &= ~(1 << PG_locked | 1 << PG_error |
-- 
2.41.0

