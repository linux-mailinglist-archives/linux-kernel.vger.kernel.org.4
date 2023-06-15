Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967FC730C24
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 02:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236837AbjFOAZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 20:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjFOAZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 20:25:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E640E3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 17:25:52 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35EJSLLe011569;
        Thu, 15 Jun 2023 00:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=a1ZJ6ruecuSSOCVGpLL7Plhl6OKdlizHU6N5Lk6XmHU=;
 b=Mw29szS0FGW6mroNOPeU2IHD3px8C/52kkn28vOvqf1mQKdTANOwBz/WMLMipsfK0EK9
 NAjeQVC/t/F1CMJhbxBUKigQzFr0SMoAO4aBaMEVCA+2KUVSMv5U1xo/uGNmp+x6/UPZ
 0xk1LyRAppVZoVAP1E8QTQU6+3aSKPn3S1EforWxvoLyoP4Ym05E8A9kNwBdhSkmEleC
 jhwJ95+76KD0PIUEHOYPvYMbUl1qvVjZRs0jShyFWV5MWKA1EqCYRRMER4tMHY9f6snT
 nxcbwNcVq1lNUJgZgu8I/B3khV0Qm+Kd4upAQk45b2wvnYR41XcgRwLuz2Tb6tBzxh30 Mw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4hquruq7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 00:25:32 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35EM04l3008307;
        Thu, 15 Jun 2023 00:25:31 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fmchshy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jun 2023 00:25:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SK7RGPygpVzlB6OwS8BYYk8Vao4kTQvjNUXcbizu2Cnfr8xyX6QGa7GYerhbiI6gBFdRjpUZkHk5E9eB9ivMYO6FhV2rdaP0AdulgI8OjyEYAWABQ1b9+BWcNI67JN3G+2bKNLZscb9DKy7soiC5xZi4bi8mbu4GkzXWD0mGrkjlre6KfwwMkWqP5Mu5NVzaPK2wJlnl8J6qWuNJBRuNafoU+rzBz/NB775Nqu/k2agN9WPij0urTGpBrjEPa6DLLDhpbUlK01oUeejL9BGL+gg/58w/QB97l3Xlw4mDEQtKSZBk/KyHXcwHeCXjdtH/xrKbMG4ym6n/yq4DnhNCgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1ZJ6ruecuSSOCVGpLL7Plhl6OKdlizHU6N5Lk6XmHU=;
 b=lEgxwq02qZMhblCv0LJ+I+qLWe4LVU4xqjPhjUwYi+sAp3g0xKFywpA6+bQJrsb5uDOD0sY4wM5kLbwMoLom4YPLVfg0QzVrfdrKnXBj347HdoiGFbtvnIAZBO6UZySm3Cgbd03cPc1BcEV1YF3DL0ko3+Uy34HXsUXNi+L4QKvM56l3jX1o5yW2Y9ZlNsXHbbjDKI6RW+Ie3TmmjuF6Hf8Hhv1JytKEx52vEbU1q7m6MMJ9seQCtXSo4mHXOU0zkd7EFDu9UbnFzz99f7HT0W3Hiedobzj1jHdSAO6XFnIbwbegqXXlmHN0TfsrJt/EzFD5NqESUZDnUk0/y6trtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1ZJ6ruecuSSOCVGpLL7Plhl6OKdlizHU6N5Lk6XmHU=;
 b=GNBuVLFe4VqJgol51fXLB67aneT7KvIEsV4W5CKK837Q+B5yuyrdJq/cmX2mRY070g7qFYFts591xsUMlCtn9LnCTGn+dln5twmtWeZMXLmRYl2+uyU6dc0rB2EGpfOn2PSAdkyD1Nv3m+Bf6/nc5bd1m0Gl1gYa3kqJyNN/tr0=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by IA1PR10MB7335.namprd10.prod.outlook.com (2603:10b6:208:3d8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Thu, 15 Jun
 2023 00:25:29 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6477.037; Thu, 15 Jun 2023
 00:25:28 +0000
Date:   Wed, 14 Jun 2023 17:25:25 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        James Houghton <jthoughton@google.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 4/7] mm/hugetlb: Prepare hugetlb_follow_page_mask() for
 FOLL_PIN
Message-ID: <20230615002525.GD38211@monkey>
References: <20230613215346.1022773-1-peterx@redhat.com>
 <20230613215346.1022773-5-peterx@redhat.com>
 <533c32cf-9a18-1590-4d29-f076d6bd58c1@redhat.com>
 <ZInYh3cVUil9R/cf@x1n>
 <ef0f8e0e-cbce-7c7b-1b0e-c9d52ede7e0e@redhat.com>
 <ZIndN9isc4pTp2zK@x1n>
 <38574ed3-ea96-a72e-00dd-4e6204413a86@redhat.com>
 <ZInh//34yuKNuuX8@x1n>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZInh//34yuKNuuX8@x1n>
X-ClientProxiedBy: MW4P221CA0009.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::14) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|IA1PR10MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: f5c9b4c4-0e1c-47e6-2c00-08db6d370592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7yOAtJdwp6itd+0fppuxDnlYReR1uoxuLdHwOXpIIe7n/GpCODcRCqWQ0PGQyhPJOdVkCqbOln932Uzn+fxUepQonL9ogKhMDvaURnVwov1/9ADhWVbk2TyUstBDikVWynk7ODks/kKynbNXIbDnevLtTzt/wkL2KM7QDUhIP9jn/3dhuqwAKxrmbuY6n3/4PpOde+Vs9yP3orUCYRPYA3bqiU5/MLJXaw3vhGohqlol/MpIMa5BJHukCIkz+mrNnapFfCurz86SM5wZvcrasSitRPvkjswm0hci/Gx6gE9/kcrZ5Fr1M2ssIpQKdxRfCARp+Yq+c0Duul3rvtOuiTfpkOXS/lCrmu9GUCBjUqDnwPrXRT30T+lIWvltDnaWS7G6ZWZJWd/Ah0LoePepQ+bcLhiXQjumTrSoI16FQhQSkaOXeGOfedjGrJkwMXkYANxYp4AgZMhbKFO/OkkQNQBs7yHzFHdZ+xznfPk7iit9GlN9fV1G/4M7vNIwGqd+eXEtCCS+BTWsl9CtmwfUOuvhunjccZkjOS5cikTQRkZ3R6Sc/j9muDaJ1FTodgUy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(136003)(39860400002)(376002)(346002)(396003)(451199021)(66476007)(66946007)(66556008)(54906003)(478600001)(8936002)(5660300002)(6916009)(6666004)(4326008)(8676002)(41300700001)(6486002)(316002)(38100700002)(33716001)(9686003)(186003)(26005)(6506007)(1076003)(44832011)(53546011)(6512007)(86362001)(2906002)(4744005)(7416002)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0OoHfee0xjPl0IBs5AtKqmUioI2FoZLPpLpJ8JUlS+MbgfcSCLFMoi6bWr4L?=
 =?us-ascii?Q?gq955FgDNz4HllVdbjNANBfyOMSMr5VqUxApy1g0S1YW8J/Tl8AstukCUBno?=
 =?us-ascii?Q?HMXHRXDYQ5uUhQMF+JARDx9+QGk8RMqlWaqlid+sF7lJDKH2+xPSjzDUWq+P?=
 =?us-ascii?Q?w4iJpjxA9TMWsRDDtshu1gHuxMnTyIyR2Nzu7+74PE2kybti0b93H2sD13Jr?=
 =?us-ascii?Q?cNVwTqWMhAe2mIIQZzYpPKfcAi2cmAGgRqkVnxfbCYwD5c1AnoJlBh2nLT6F?=
 =?us-ascii?Q?0TfJSXkjQI0W9IJ4l+4BdkKCkHeo6v6uABF5jLx2OMuiiEMm1pxbDXaBAdkn?=
 =?us-ascii?Q?u20tGGKpguya4b1Q7bSpZYb/YWO/+Jgo+BqZ4sRNWMOzUB7XxcMyJ5Yeu5b1?=
 =?us-ascii?Q?wpEiBKbABQ3K5YE+BltErNGLzba7L3yVCqlck6StV0oWW+xAtRoCSiFMTbhT?=
 =?us-ascii?Q?c0g+AfVgjMEE8QzgNQhlvejgRnhBQFAXxdizSNL7tN71J3YBH8S9jgvdHeOY?=
 =?us-ascii?Q?VRJelrPJ/GztXXneOAlTOBv5EPyUzgF7hMiEyCst+JdQMGMT8Rj9CItOh86L?=
 =?us-ascii?Q?uoI/SEUYCBwFzgnDvO25cLnTQG8OihoPn/qUEgqo6dxb5NUR8aweHbcCkoQM?=
 =?us-ascii?Q?5w7f0ZOox1t0bNjIQz26MtCLyC9YzLf84CIwrZd2ETlhfM3NQ1TUFQeSGSwB?=
 =?us-ascii?Q?NktupcNaz0BP090z/4HXCQ4TiuIQ+JrgAtRjx/zhywNiTo49m3l2BW5HPx7s?=
 =?us-ascii?Q?pn0GJ+2tL4iAsx0FQGwMSDG2i4gyadBsnxuzWmvNczNkdvIY0+N5yT07oHWg?=
 =?us-ascii?Q?+IBY4HB9Wv32n8AalEW7sUfvzsOg6oxFg6BHfLPz5wA40YrBUsDrVEANe/JL?=
 =?us-ascii?Q?Sv0BYo93MMZviIBC7SaRRIbP/WNM9jHZCQGwKgxiORLUrqsk2SYbDatlT2jh?=
 =?us-ascii?Q?4JPZj3iR1yHhE6ejOIvzH7l8I1G+ZbQqGE+Def20YdCFCKF07Vq2aGxKrUJD?=
 =?us-ascii?Q?k30USe7XgbIGjpOD8ItL+dvL7OS5w7chVzm4wfvXwd/CAZscpurvJcTbacNA?=
 =?us-ascii?Q?KmAf4IOEwO8tlPdLo94MUOck/Cf4Er+AM/xqdJIv/25oGkoB7qqcYty5gOxq?=
 =?us-ascii?Q?ewLktQ3nojhC7+0WA0KyHyGf4vOwpwaVW2MfE7gj8CfAFKsvWm6N9rwSiMka?=
 =?us-ascii?Q?uoiSZP04DSaGBOYSO01UsV5KD0dh1VMnx7wMj0w8iOrzHtL1BE3FIut0qiTU?=
 =?us-ascii?Q?W3kzVi33iRTKVyJzHjVxYOuCWMWi445rEc24wEoyc2W91V+yY97E1Zfsf5M2?=
 =?us-ascii?Q?cCLNf5h5WsJYW8KuNkoxM1DWdmscm6JBrzL/rsETFtPjQ4126XCGKJso2g1h?=
 =?us-ascii?Q?9EHKvy1AyqTWiKjn3NsvdBmfTYe3dx46MrFGTHNExuRL6KKe51LZ/x59Ktis?=
 =?us-ascii?Q?BCR7DblONB7cMGDqIYGFtGueUz/15DKn3nFH1nkXda5zzWpBoezAK6iC9ZIc?=
 =?us-ascii?Q?odLDZGEGo7SpMjKeFVVKHJWzBa4O/QO0pW/3Ek4uzfbAO+1xKk5IFOEuubP2?=
 =?us-ascii?Q?uNH0mTToBz4uQ0ry0jG4PHATK22j0DQ/KNT8aNwrWI200O891XJGJ7QeQ0gU?=
 =?us-ascii?Q?7Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?nBlmP7lPi6He2SR7IwMTyCFKHmm+xfu6tVjTEEjcvGxU5graJC3Kiwjj5ufZ?=
 =?us-ascii?Q?q3oqj3QeWU0hxyevMRi7W8boRpfbSC1NFKGD7nPLYRCfJM5k4t36hF36CED2?=
 =?us-ascii?Q?dJ/A/TQSiZwToyltUxyU8cwW1SuzLnGHN5BGTG2QCNCmpxM+KpRxHBL9qDgB?=
 =?us-ascii?Q?8tgMtnxPDl6n0FXCID4r6ZAeKfqNSqjVMjFkS21Fw968NQewUXSujZ2CkdD9?=
 =?us-ascii?Q?zLTJfZe1ELKqLHy1PzovTFnL+zvAvI+oVgPizg3qe7w7vCc0UV6JB6/g45nh?=
 =?us-ascii?Q?oIgeN9p9/Z15kFxhqELjsualP6h+U81nc/MBFDdaN4LDWRNL3itz79hJnvWk?=
 =?us-ascii?Q?dsPkdXxNSdEHJ/P2W9eYCd/jBHSUuvhIFpGevddkkD53J4cg0AC0cSyFpozz?=
 =?us-ascii?Q?38OEW/zmwdfKQ5WkQNCTOnDQ7Du1lq+QWVlwk78sUFt41xILMEdGumcHXYdR?=
 =?us-ascii?Q?cr9ZUwy2Jx3KgvuXh//4x6Z8IA9B6QVhNRpouIAY4Vd6QCKDXk4zJ6IMHRxU?=
 =?us-ascii?Q?CjXf2alCOKKZX29DPpSpKo8PmPxtQIn+JsF7UKHcyKrm4FuCWOc4MuKIUHie?=
 =?us-ascii?Q?5J4ZgIPtZvu9uGz2lL9mskTqiFcfqV9E2eVo+JNtSHTq1bj5sQVRuI3NZ802?=
 =?us-ascii?Q?dC3hN9Imji6Xo+gxA6yx4bk+7Q0PTGdvIKZvg6nOKj/HM5gmoYfywaMr46Dg?=
 =?us-ascii?Q?IUgGp3qiwYqQuHdKrK9HH1Zhmo+T2FigqlP29XIbD+DxEyJb39LReHY6W0Cf?=
 =?us-ascii?Q?+mjc8vOTiMuAS/aE2nyJKdVn9lkOFI/1l6YsOIG1glnP7uNXy+FPGSn+fMhh?=
 =?us-ascii?Q?2SailDSk17+B7p32LgDznmIp4DkKe//STjpKJ5VdO/GjPp5X8qTCJHD5E+zu?=
 =?us-ascii?Q?odgJJyTHyoDN/hsbAZstL5Ohx5mgfkiYopyEBbY6RrH5sk7MyFnvdR3bzfcg?=
 =?us-ascii?Q?ZkSq50ppgJ731CTQUZtjUHRmahuNlFUJf+0XF3o5SLbiSfBjmj4/JgyLfAV/?=
 =?us-ascii?Q?gj8vTAqDPordQ+84dWdmaeZVnJNGizyv/PGX2Y7E31t8+WHlu3NMde8mW/Q5?=
 =?us-ascii?Q?T1rZcdgd?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c9b4c4-0e1c-47e6-2c00-08db6d370592
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 00:25:28.8217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MtP1RNUGNPWyGoSDwgqELbPDc/59vjYQBSARizP3hn1qYUyCk71B14f8ywTI28hXZCfKyaU/IJ4/WHM/tpwmSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7335
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-14_14,2023-06-14_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=525 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306150001
X-Proofpoint-ORIG-GUID: cpyUIL0mMVlS0bJFBv3kmE99YeJOXbsM
X-Proofpoint-GUID: cpyUIL0mMVlS0bJFBv3kmE99YeJOXbsM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/14/23 11:51, Peter Xu wrote:
> On Wed, Jun 14, 2023 at 05:47:31PM +0200, David Hildenbrand wrote:
> > Right. Then just call patch #2 "Add missing write-permission check" and this
> > patch "Support FOLL_PIN in hugetlb_follow_page_mask()" or sth. like that.
> > 
> > Regarding the backport, I really wonder if patch #2 is required at all,
> > because I didn't sport any applicable FOLL_WRITE users. Maybe there were
> > some? Hm. If it's not applicable, a single "Support FOLL_PIN in
> > hugetlb_follow_page_mask()" patch might be cleanest.
> 
> Yeah, I agree.  The code is definitely needed, not the split of patches if
> no need for a backport.  Let me merge then.
> 

Should have read this before adding my RB to patch 2.  I assumed no
backport.  Agree, than merging the gup_must_unshare here makes more sense.
-- 
Mike Kravetz
