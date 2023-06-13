Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A36472EFFE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232747AbjFMXad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjFMXab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:30:31 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F9C1713
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 16:30:29 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35DGhrXx000312;
        Tue, 13 Jun 2023 23:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=bgbuj4RXTPcC86Hx8ySHx7RLLgH7R7VK3uIJ+quaEko=;
 b=HROqEVSmITMXYF8bG/KS1hMNlx9JxAD8E2dqWZsNgK/NlaxeQ9BovdpD0E6rKhE1g3RM
 1EUPfo78TiHiCqEuLqo0dbiE2sfh+8BN66Q0RYKO0pf7dR6LTCI/oEXphZTaHnxXvk7S
 qwg+QnQLYcB0UqNlKvsz/TZ5Kp2lb1l1OuYHvdIDR5GLApsNYcMHouJdze0MAjdTm+OQ
 kCaQgJ+iq6dFqnMKRlO1ajG+Kc/5cxVqkU6OGhzislyz2NFlsSSex3ancDkYDOHi0QWB
 NXDHRfr1of0KYWahG7qivpXXLV38Zc+xcaNPvzgRa3EzgwuUUW+Bj395uiyj+Fqy1OoD Vw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4gstxaen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2023 23:29:47 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35DMAiQ2017798;
        Tue, 13 Jun 2023 23:29:46 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm4jauq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jun 2023 23:29:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHXSHwu+yWjMcORIGPcSVsUi4cvn5Iqd5HDFKJTJDq7kyqgVt+SpQb4oTP7GD8dcVkpBppCYXs4xF1tnz5dV9h/dptgKS3QQkI/+cJyANZTvND2ZhfrWOG/KVO+kJMeWsIb7TRT3sdE8q8d6HT4V40XGZdbb4kX3Q3w6EVH0hiROl/hKRJllWJTDLuqIFvVOPqEE5r+Qty4YE8hCuN/Ky+a4ij2fTD/6N403/cVB2O6TP+JAIK+pi14QHPU8aZW+r9EoAGpShBmN9qFcPHY9PlFe0Qw2anFskTHBo+iQi3xMPJd+VqPLVqOFNkCONi2eBKmS9bozTgoCXTWl7zN/dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgbuj4RXTPcC86Hx8ySHx7RLLgH7R7VK3uIJ+quaEko=;
 b=gTfErQThmadUpytHy7ulJVV+Xe3AQgxgZPlm35z+X7lBPT79ZMZf7Eg2Hah1ZZl21GJhmGuY1nkajAeH/MBpH26dtH4a7E9bPf3iD5EaE9TVGAijYyz+Xh+hCIcYxXTuiOOkmDlj4AonJYaY6Drynf6+cD6aFhVrd5UyIoRP+xxH74qL3i+LsOO2N+NMUFAtoZWIm4JFDz8WGp1B8R416vah9k0RVZB+d+d4UCXQ02JWDk4yWB8fnAkDJY8C+9eJozCFDCfUjRYIT0JjuJZ1nPKoob4kzB0YnWAeMectthyGkM5S5TMd80ggeoX9Z3sa0KR87g1wOlhf8y1f6zwbxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgbuj4RXTPcC86Hx8ySHx7RLLgH7R7VK3uIJ+quaEko=;
 b=X2JovWwbcVUxgwrh0zsgBZ3d4x3r+ZkvFnqmOmP7GWzA/jsQcht1ZNdkILcesGqnVamboKIBmDZCCCbN0sy6K40KBOsvz1MmMM+OKD1uze0aoRA6J7UjEXHehMTOMFR1rKs5FX4aI9pGtA68BAlbOTxBnNefcRXGA2pPLZ9PGDA=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY8PR10MB6705.namprd10.prod.outlook.com (2603:10b6:930:91::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 13 Jun
 2023 23:29:44 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6477.028; Tue, 13 Jun 2023
 23:29:43 +0000
Date:   Tue, 13 Jun 2023 16:29:40 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        almasrymina@google.com, linmiaohe@huawei.com,
        minhquangbui99@gmail.com, aneesh.kumar@linux.ibm.com
Subject: Re: [PATCH v2 5/9] mm/hugetlb: convert isolate_or_dissolve_huge_page
 to folios
Message-ID: <20230613232940.GA3898@monkey>
References: <20221101223059.460937-1-sidhartha.kumar@oracle.com>
 <20221101223059.460937-6-sidhartha.kumar@oracle.com>
 <ZIdYzZGSUzYumrCT@casper.infradead.org>
 <20230612233451.GF3704@monkey>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612233451.GF3704@monkey>
X-ClientProxiedBy: MW4PR04CA0283.namprd04.prod.outlook.com
 (2603:10b6:303:89::18) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CY8PR10MB6705:EE_
X-MS-Office365-Filtering-Correlation-Id: 356a1ce8-6d72-4e1c-27ea-08db6c661121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yYjM0i+9CFOV53VpHVpWoTV+48Rkv+rDFBVaBn9tcqTep/sGud9JhZ9lnyrwAuwxF8dxyRcA0Za3QQUKFuhwcB/oVYVNo2jT2KLFniOEntWBIoz4+GDzuec/hYbHeJy9/fQ1aYCZpS21S5LCz2dcg2scbNTbQPNeBGuxRTjBDsxRwGt3qbSZA4olNM+d4oSQiTWJesjDT9gD7aZx/OSv4pdZKS9vq0cTSV4ksy7k/Xg/tvhloll/Eh5eWmhpIaSgj25z2I6N8vyIHnjgAIpf5y/OHwe2fOUAWYZOzADQ1Z7ALDDb3l6H1imkrracRHes9K5tBSeEhzFgght93WyonZNtyFYBEtYvemz5+etTNz1ZHCvcLhxJNEypP8ItXaZ3D+O+fP9ay3IFq5uMIYw219gUw8aZGp+/WR5e9x1nuMD/f5QM5XBxpi17BzrK2XYpgYuKaOiCqGx2aCjr/mHP2oc80BleLk9evUaxB1qHazc7xRG9oOb67tPoDIxdG6W/YaxwMj/+fdHv5lgbzrFexJlq3/+5UNKh/5eNnm0yPHx488Mlc/wEnGHp6E49WyC7RONJBsOITPsFecb7+yi2VM3a0pNnfIP7eMUJIv3WP7A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(376002)(39860400002)(396003)(366004)(346002)(451199021)(66556008)(8936002)(8676002)(4326008)(6916009)(66946007)(66476007)(6486002)(41300700001)(316002)(86362001)(478600001)(33656002)(5660300002)(44832011)(83380400001)(2906002)(186003)(33716001)(53546011)(38100700002)(9686003)(26005)(6506007)(6512007)(1076003)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0dO80m7jBiJ/N+12CdBsPdSC2SIwWJGoU9DVOpJRR8ccjJ/3m/05UMFBBQ28?=
 =?us-ascii?Q?GbErynfvzNWY3xMJykgWUpiJ4dDaTLHG10A0wmX4XTBNeDu7gTbsXNoWiOuL?=
 =?us-ascii?Q?AFLruvj3XiU2lazbhdsyZp7SIHkA+7WEaS5NfDbmDDFSNuFO6TzrWhGu0JWg?=
 =?us-ascii?Q?IeViDSCYak+yXhP5qAYT21u2iy4w/fcBJjncORqWn5hVsLdvWIwLEUu/Cu1+?=
 =?us-ascii?Q?bdGc4EPQ1H66BDzHhqoAf9rA72/rvJw82WdY+9a4V5kKjHh5Yb0RMcv2WN+c?=
 =?us-ascii?Q?0kGqJNnTf93y3ebTv8uRveaChBc9JOPApPR9NImZb74oD4NTTk1aKaSL6O8S?=
 =?us-ascii?Q?zI0uUmh/m7xutoNlTgKyV87L/o8i8zt366tZCrY4V4fMyVd+suSgVvHOqiZf?=
 =?us-ascii?Q?M+dJGKsVqCctMv15vpLl3S9yiiKRsVkxFErqfyfuiMblYlj/L9hseGo28YHA?=
 =?us-ascii?Q?iNgtUvzHWg/hqArlsMgM2xgmIdwmpQvFqEcNPTlSZWbPEXFtmC2H+pmQ0zQx?=
 =?us-ascii?Q?LEmRITzWR7+5oIKGt9xFJiJkw6Zl1/lBeVb8msoPBlptjmv3B8SfrKgGkGjS?=
 =?us-ascii?Q?dkz3tfuRsKQqIwxVuE0Dn/G6L5gQeggahyMAIAQfB1HRvzmr+6/Nbi+n6bHt?=
 =?us-ascii?Q?4JCgsJtt7s06rsEwFWl3w82k/cxvSBar+SGXC6ILyKzUHOCGWG+NRah0uGJk?=
 =?us-ascii?Q?/GP7QSRd+gnDRZDklVXKkm+53p4k8Sj9Qh0ZyvlO6XyH5gL25zZUIMHRnu9O?=
 =?us-ascii?Q?5X5wm5CCSiK5/KW+Ue/+O4komHeIIveYHdytlXJhpotr9PBvl0BwNrT66+Er?=
 =?us-ascii?Q?99mGTt81qrxaoBEi/HQcbtbD1EUPNuWTVR/39KGAyg5vMBI3qTL+Hv+9ikxm?=
 =?us-ascii?Q?bSR1k4FPCnEcodHSVnetB3fCHDpNri9WDOdt7GOjqLCG3rj5Rs+8ohyuE+v9?=
 =?us-ascii?Q?ZGYosq30PJPwloBp+j0p63b/oADTQL1JkZRnfjUmSxj+QD9uCYNvHCAdb7uO?=
 =?us-ascii?Q?5NQWsUOXrN7hRrjGxH48A+0cSq0ylfagxaa7U2VgDO/lQfJ/XT+eIJ3Z147D?=
 =?us-ascii?Q?1GCdwsMMejiuvzRAWJIyTSD3d2NPALWkdqtH09VK5aunCO8w47vxuooNgZGc?=
 =?us-ascii?Q?agQhlqhH+MdzACpktEWIcUge2clV1spI8EDaJoLqX2cfk4XbO4L89/iWu3Ey?=
 =?us-ascii?Q?5PKk51FGq7tvswGKZi75FREOk4FZQo5GMtjmEKsMr70C/1SHIvYhX8/ozEsd?=
 =?us-ascii?Q?HhCM3cCLG/FZPGMHfrOlPSVeZm4TPuSs+wmaMIfLXwO061X7tYhntUf56BYa?=
 =?us-ascii?Q?OOauyP4jjQjq3EtJGjHGcDdDhjRIXtmxE9vtizQzHqEKGptXh3LjASVYXWkm?=
 =?us-ascii?Q?8zju2ChfdkVwmKTMLxsMOUyb/kioEQKe6UhItYjQTrnskyk0DgrMf2+GsYpv?=
 =?us-ascii?Q?PsJDQ3qb6ouw4QdOPgS1mxTTzlYM2e/06H2iALRHWz/953Ua0kRouwjM9R7F?=
 =?us-ascii?Q?beIl4omBj/I5CD/fAiVISK6MsuW16NUtT4dCVB09IJAL0Mhm6VotLKN6qrof?=
 =?us-ascii?Q?TAl311x0jcEl/3HOq5u0Xzb8O8cz+J/xzj7Tvn8X?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?YK9H7ekC1J3jk49y6bC9y9uxYh6e2PBykHFhquEd4mMgCtgaMyYVQw6DTCKk?=
 =?us-ascii?Q?YOechOhHEdmhIsj3AZmNgTGMHL/Xd6JkOPO/Qw9hNVMREcVFK6iDBCYqkxY5?=
 =?us-ascii?Q?zZgPCwDTVPLExNeE1vNaVadz1cUNkmI4XgS+QnP9N4l0EY5NSTaSSPtlKLNz?=
 =?us-ascii?Q?9UJzAEyFkDGDMGu9ArISo0o3THCCvUj3oTrUzifuRrmoUXptY0bgOvdIVQHh?=
 =?us-ascii?Q?rJ7U03LA+sNIu9Wb7TBrwPWbXaKdDT5mAUCLQ5NKxXH8VgB3vu3Sr4jseXOX?=
 =?us-ascii?Q?nnCo+xfzFIwBfFEzzbWxkLtuTgyEQYEZWHjIQjb+hmj2UCLHU9NKwl35Vzm2?=
 =?us-ascii?Q?4dFl8yXh5tWwJbGQVUAD/rwU3Zfd6SRKxrn0spOVf6duB+S2AQh5ncDAU7uM?=
 =?us-ascii?Q?Lj9MHyzsBTdPTh0SdDzBNKU26+sYPKIeSxU3SOR5JykqQDQe5ew6i3zosYrq?=
 =?us-ascii?Q?+suO8h1o4dXtFgAICcmJpz1VOtLOHtfLlc9a/jka+Ta5I3IFcdOuCU0cP3kb?=
 =?us-ascii?Q?3JrPf28Bh4uwuzaqUVREdmNL/vTITzv6v/Ay8dSSP6QE3YSIQPyAsMnDXxeD?=
 =?us-ascii?Q?JI9JuUIPxdQve1+n5elBNzCQkdMQ3y9AhgzCZ9fBh/Yv4UPguprhJUGOJz8u?=
 =?us-ascii?Q?QVkSdmiwxhLebvl/yeSvR1qnQ176OJ49esWEw0RRFl4IC7dmNIXNTUT3DLZK?=
 =?us-ascii?Q?5+yWbqu1JJ0twnQJSqQse9WWp2O3AZ2Hy61ca93D6jJ76LtAp2/9UA+wFKdU?=
 =?us-ascii?Q?jKRsTsL4XmcD5rN0pNcMv32kUoKjkuBzW7jC8Vf0nk9vqHjFD64/rQc8Yv4R?=
 =?us-ascii?Q?qKjIwVn1OBeFVFMz82aS57SGGGl46WyRkl3fsHL4U+LazCy6ikdMwocDChVi?=
 =?us-ascii?Q?5a6PnI/9vTGjRMh5sJnjXZjjW0OdpqRtJLqyAfupW5D4d9n0fumwDJX+boo1?=
 =?us-ascii?Q?AAkVS21hFkynMC9xrg0I8o8FpvvksT0MOB9r4J21DEyU0wCDrw1SR2VW5iHI?=
 =?us-ascii?Q?1/1Jd5TqzpbJrD9Pdm7VfMKPE/w2L9JC4trdNXwJKtMfiVA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 356a1ce8-6d72-4e1c-27ea-08db6c661121
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 23:29:43.7913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W8sY91xbHG9WwW8/bCXPobGDUTF2ILjWPYYpuoE3I31EwzlD2TzBS5ZElOoyCFi0TsZHXR6hM7xhAs4QCI9q/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6705
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_23,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=850 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306130207
X-Proofpoint-GUID: cBIvN9jC7d1xWWeFzypIN0oMYBPQdzHR
X-Proofpoint-ORIG-GUID: cBIvN9jC7d1xWWeFzypIN0oMYBPQdzHR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/23 16:34, Mike Kravetz wrote:
> On 06/12/23 18:41, Matthew Wilcox wrote:
> > On Tue, Nov 01, 2022 at 03:30:55PM -0700, Sidhartha Kumar wrote:
> > > +++ b/mm/hugetlb.c
> > > @@ -2815,7 +2815,7 @@ static int alloc_and_dissolve_huge_page(struct hstate *h, struct page *old_page,
> > >  int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
> > >  {
> > >  	struct hstate *h;
> > > -	struct page *head;
> > > +	struct folio *folio = page_folio(page);
> > 
> > Is this safe?  I was reviewing a different patch today, and I spotted
> > this.  With THP, we can relatively easily hit this case:
> > 
> > struct page points to a page with pfn 0x40305, in a folio of order 2.
> > We call page_folio() on it and the resulting pointer is for the folio
> > with pfn 0x40304.
> > If we don't have our own refcount (or some other protection ...) against
> > freeing, the folio can now be freed and reallocated.  Say it's now part
> > of an order-3 folio.
> > Our 'folio' pointer is now actually a pointer to a tail page, and we
> > have various assertions that a folio pointer doesn't point to a tail
> > page, so they trigger.
> > 
> > It seems to me that this ...
> > 
> >         /*
> >          * The page might have been dissolved from under our feet, so make sure
> >          * to carefully check the state under the lock.
> >          * Return success when racing as if we dissolved the page ourselves.
> >          */
> >         spin_lock_irq(&hugetlb_lock);
> >         if (folio_test_hugetlb(folio)) {
> >                 h = folio_hstate(folio);
> >         } else {
> >                 spin_unlock_irq(&hugetlb_lock);
> >                 return 0;
> >         }
> > 
> > implies that we don't have our own reference on the folio, so we might
> > find a situation where the folio pointer we have is no longer a folio
> > pointer.
> 
> Your analysis is correct.
> 
> This is not safe because we hold no locks or references.  The folio
> pointer obtained via page_folio(page) may not be valid when calling
> folio_test_hugetlb(folio) and later.
> 
> My bad for the Reviewed-by: :(
> 

I was looking at this more closely and need a bit of clarification.  As
mentioned, your analysis is correct.  However, it appears that there is
other code doing:

folio = page_folio(page);
...
if (folio_test_hugetlb(folio))

without holding a folio ref or some type of lock.  split_huge_pages_all()
is one such example.

So, either this code has the same issue or there are folio routines that
can be called without holding a ref/lock.  The kerneldoc for
folio_test_hugetlb says "Caller should have a reference on the folio to
prevent it from being turned into a tail page.".  However, is that mostly
to make sure the returned value is consistent/valid?  Can it really lead
to an assert if folio pointer is changed to point to something else?

> > Maybe the page_folio() call should be moved inside the hugetlb_lock
> > protection?  Is that enough?  I don't know enough about how hugetlb
> > pages are split, freed & allocated to know what's going on.

Upon further thought, I think we should move the page_folio() inside the
lock just to be more correct.

> > 
> > But then we _drop_ the lock, and keep referring to ...
> > 
> > > @@ -2841,10 +2840,10 @@ int isolate_or_dissolve_huge_page(struct page *page, struct list_head *list)
> > >  	if (hstate_is_gigantic(h))
> > >  		return -ENOMEM;
> > >  
> > > -	if (page_count(head) && !isolate_hugetlb(head, list))
> > > +	if (folio_ref_count(folio) && !isolate_hugetlb(&folio->page, list))
> > >  		ret = 0;
> > > -	else if (!page_count(head))
> > > -		ret = alloc_and_dissolve_huge_page(h, head, list);
> > > +	else if (!folio_ref_count(folio))
> > > +		ret = alloc_and_dissolve_huge_page(h, &folio->page, list);
> 
> The above was OK when using struct page instead of folio.  The 'racy'
> part was getting the ref count on the head page.  It was OK because this
> was only a check to see if we should TRY to isolate or dissolve.  The
> code to actually isolate or dissolve would take the appropriate locks.

page_count() is doing 'folio_ref_count(page_folio(page));' and there I suspect
there are many places doing page_count without taking a page ref or locking.
So, it seems like this would also be safe?

> I'm afraid the code is now making even more use of a potentially invalid
> folio.  Here is how the above now looks in v6.3:
> 
> 	spin_unlock_irq(&hugetlb_lock);
> 
> 	/*
> 	 * Fence off gigantic pages as there is a cyclic dependency between
> 	 * alloc_contig_range and them. Return -ENOMEM as this has the effect
> 	 * of bailing out right away without further retrying.
> 	 */
> 	if (hstate_is_gigantic(h))
> 		return -ENOMEM;
> 
> 	if (folio_ref_count(folio) && isolate_hugetlb(folio, list))
> 		ret = 0;
> 	else if (!folio_ref_count(folio))
> 		ret = alloc_and_dissolve_hugetlb_folio(h, folio, list);
> 
> Looks like that potentially invalid folio is being passed to other
> routines.  Previous code would take lock and revalidate that struct page
> was still a hugetlb page.  We can not do the same with a folio.

Perhaps I spoke too soon.  Yes, we pass a potentially invalid folio
pointer to isolate_hugetlb() and alloc_and_dissolve_hugetlb_folio().
However, it seems the validation they perform should be sufficient.

bool isolate_hugetlb(struct folio *folio, struct list_head *list)
{
	bool ret = true;

	spin_lock_irq(&hugetlb_lock);
	if (!folio_test_hugetlb(folio) ||
	    !folio_test_hugetlb_migratable(folio) ||
	    !folio_try_get(folio)) {
		ret = false;
		goto unlock;


static int alloc_and_dissolve_hugetlb_folio(struct hstate *h,
			struct folio *old_folio, struct list_head *list)
{
	...
retry:
	spin_lock_irq(&hugetlb_lock);
	if (!folio_test_hugetlb(old_folio)) {
		...
	} else if (folio_ref_count(old_folio)) {
		...
	} else if (!folio_test_hugetlb_freed(old_folio)) {
		...
		goto retry;
	} else {
		/*
		 * Ok, old_folio is still a genuine free hugepage.

Upon further consideration, I do not see an issue with the existing
code.  If there are issues with calling folio_test_hugetlb() or
folio_ref_count() on a potentially invalid folio pointer, then we do
have issues here.  However, such an issue would be more widespread as
there is more code doing the same. 
-- 
Mike Kravetz
