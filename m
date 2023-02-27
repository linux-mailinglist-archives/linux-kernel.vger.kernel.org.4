Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8056A4AA8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 20:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjB0TRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 14:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjB0TRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 14:17:49 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9246D25296
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 11:17:47 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31RIho9W016327;
        Mon, 27 Feb 2023 19:17:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=XVFDYg5CX7aX+nptpdmvI8wEhO1D5Nym3Xf8lPSL2Vw=;
 b=b9s3ysJ0XEPltMqefxso1C5yx8xj1Wio/bXxMOhqaH4NxnawZCTUUzlMtZ8mzYxKUkS+
 T/zkTpC0Aq8DX8JrS8kJMzhqA4/WFALxNpeDdWAXcdzVYAtrWKjyyWq4jUAFaB/cWmM0
 5CpvOCeoziV2WPS1GxegupWuydE8QY38jq+A+kVOOmZEmBaR4FcTN42f65plBQAW9ElB
 9uLZJicBCBeED/0XiYJHq3BxHydFPCX6RQ5Fky3x4GcC7NeMv3WKlphUwgjK+ovyco3a
 91WSMoskNOO951Ux5K7qoHK4MwglQ75QqtEZXapKX5E9mViqGUGPgXtRIzAPh2H46MML 0w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nyba24h3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Feb 2023 19:17:00 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31RJ56Qg013778;
        Mon, 27 Feb 2023 19:16:59 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ny8s5qm1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Feb 2023 19:16:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJwA7IQA/5DZAgqH0MndOZOdEOVFmWssCIZ/HAZ748k0W6C0Tqk5D3i6vvZmxHo2DNSrMhxbeZqr+q9wr7OyIYCGLKjmE7H/HZLC8l3m8RZ5sKKQbvHeG2RoFc4nX573XNaOA1xmFwiuOu8HJZSXULgJjeGUA1R0IBP0p8jXalLlVkNMxNcfIVDFHursplc5aSNTwEPDQQnGETyABTkMeJCIqbTnbySSSn8C7PlVgpZ2jq+apmpJcKTF1BZwSJX/DzQPpd6iXkx69jITGexxnVhwBpJhkhe66VgN/yYPHYnPbFS0Ed1458zlHn8iCiaYbHr9frEalwyWHBIhB6ju1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XVFDYg5CX7aX+nptpdmvI8wEhO1D5Nym3Xf8lPSL2Vw=;
 b=BeBmW2ciuAxscKg1xWThsvKYeBJAWwPXiQUMm7tL7D/V6HDdUiHjijjzVbOFvz6PhvzG+cU4IBo4cW6Z3Rp32PD/738QvdYDHVWxI+FXVPAsuL2LHNK3rRR1z6dHizgmxWBStERAN/27wRcAFISiD2F72UcHSBcy/tSEAq+EN+3/Ewa3sld0l3ig/tzLykJSWU3jUMfWQ7o9SAeQDpYlmxg39rmYKzk/SuSY8ifGpZ81AH1gahQW8AMChDL2Vy1tPkmLVsPRFa2Vj2Bz9P7UgTrvSNa8oHmINOBAEHmYVkHS+bC/4ZR0A2NO9adMy1nprgXeVk7wYKwZdVxYQtV/Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XVFDYg5CX7aX+nptpdmvI8wEhO1D5Nym3Xf8lPSL2Vw=;
 b=KANzNt/sUwJdiPBbBuoojyZOgwZzb4NcKk2ksZnYEi/ArLpYHNI4igx6MJzrUC5rNeSiYxfQJK5lFuU9OBcS9Bx9sB+hnxzxMTeFHBtg+SAay76CIPsK9uMlETL9YionG1IvPubecxV+ABR1ZdrUTK7pZ6vQdK0rp4kbuT2+Ils=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DS7PR10MB4942.namprd10.prod.outlook.com (2603:10b6:5:3ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.16; Mon, 27 Feb
 2023 19:16:57 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a%7]) with mapi id 15.20.6156.016; Mon, 27 Feb 2023
 19:16:56 +0000
Date:   Mon, 27 Feb 2023 11:16:53 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Frank van der Linden <fvdl@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/46] hugetlb: add hugetlb_alloc_pmd and
 hugetlb_alloc_pte
Message-ID: <Y/0BpWmWNGOxNqXx@monkey>
References: <20230218002819.1486479-1-jthoughton@google.com>
 <20230218002819.1486479-13-jthoughton@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230218002819.1486479-13-jthoughton@google.com>
X-ClientProxiedBy: MW4PR03CA0269.namprd03.prod.outlook.com
 (2603:10b6:303:b4::34) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DS7PR10MB4942:EE_
X-MS-Office365-Filtering-Correlation-Id: fc5f7c60-bb7c-43dd-a42b-08db18f7312a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NGBYu2Jz3mojYPvEF+oi/Mrj9FSq8sK0GgZvHofx7Ut9VXIM849OKJLeodL07dwYT21StPJg375oDsd7aSb1iZeYnqjeb3j2Ptdy3zYhURK7ADxLG2THN7GfW75IfoCqy1W90+uyP6g3OxQFSERxIjrCmngsT45/GaPS07R8sW+dpymuFIdw0hpoH+ZZeH35tT/G0Z+zqzzuRzHsKgml+ZUQvgrQQcJqu08Ve1szD0F737E4N7T+hCwNZ1oV8kJ/Uu9VA2ldUYE4s15tRDJbSHQNYi1Noq+3CuCvnxoEsfFia97nrK3Z4XvEWhyYch3XTIoJEGkC6wNcmsuz8hEARDMVZKYBBprLlP0oUo1W7SC7OCriuyEHCoSw4AAgZYVGLpWbacMOJNQPHp+fbPVtpvGIqSghS4XC3+K9pUjsGwWINdQKLWCwqGJDbdeBDDVq5GUSbWXv5JqX5T08R+VQf5VHgts/dzne+9s1Qtm0VxKpfNEAvs+WzjFOrTCE/G5seloA4wcqHowRYXBa/5Ez62JJx99Gy2NiZ5UCT29HbF2d0w3zJWr30D7kSAtZxsOdvhamYSm0gl8L5PfwrX5i2sxbaO5JEl9Ii7OBVv1unZIldtEn47h51K+rdhAIVDmj3e/PC2DsxOmu7bnyEhAvaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(346002)(376002)(366004)(396003)(136003)(39860400002)(451199018)(316002)(54906003)(86362001)(38100700002)(6666004)(83380400001)(6506007)(53546011)(9686003)(26005)(33716001)(6512007)(186003)(7416002)(2906002)(8936002)(6486002)(5660300002)(478600001)(4326008)(41300700001)(44832011)(6916009)(8676002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SudzqF4d4XO/cybuyL9i6dBz8k0IyUcciA7pyuxUVLVx88irv634Mv6Pl1tm?=
 =?us-ascii?Q?2jErCnGdWgwxnAqFVSOKo95TL6+d3hgWD3HeHvPrYV9skn/s44mYZJ44YASn?=
 =?us-ascii?Q?hwqhGPc/CXpLHPxe50kRinMKNt5hxiB38GrV+b+JPWHv6MtG1U+zbSRKJ8Mn?=
 =?us-ascii?Q?aNxvK/lwLkao4AxeVK36wb7nUdaX/h8n8u84JG/nt/vdGIfsQMd2UeVyi3zk?=
 =?us-ascii?Q?9XVZzQkYRHnOuXyW2LATQAqdbs3Wr8X2ELCK0gKDIUwu8kfYDejdUtbnHvi8?=
 =?us-ascii?Q?DrH7F1bByWsECO/5HQiTLNabXGPAxWCKk3779wFjGlOoNFZZaYUDEbI5S2oy?=
 =?us-ascii?Q?xbP/DvBIbBZnqGZyjS5/c6N0I9Hx1vaL0knOyWV2YWBypCXQeuqzehGF67hf?=
 =?us-ascii?Q?3HDQhyRJmupZom8PYoTl9sqLR8UU6IXPBTs0MJHYLtrhLOvh0wwplm+woK1q?=
 =?us-ascii?Q?DvAmiGMf1ElV+1uzxGNcQCev1mc6IX2pvrLvQqadT/kQac3hWWLFfCqks5Sj?=
 =?us-ascii?Q?i6fnavP/TbU446l1SmxoHEbzoGwkotVHj/tZf4Au9VP0qkFHAsQAjZfkh6sP?=
 =?us-ascii?Q?TXcu7jh+v+W216ZfDb1qx4J87ElGEgzpy+4P97wQFGxD1hqzOpm2Oxw/yz9y?=
 =?us-ascii?Q?qhGahvjuin3hjoxJ3y3bOkbp88s5P0+TD62YoH5i+If+3qXGZf4kXLeD9F4s?=
 =?us-ascii?Q?w9r5Yhn/jmxG+x3fK2Y9uwvi6anaipSe4d/wXX3BiRrDGBT3dYISEsR2HdCf?=
 =?us-ascii?Q?McTQVTYfHhLoaMl496c9Un7Zp3uOiUJT1xxiFz9OWIlpQPNK1LIgNPd9NmmE?=
 =?us-ascii?Q?LgWYOSzm8npWAhYVNoQekr4OW8wNuJQZE9SeKo5gOz55ogYY8sL8Om3KCMc6?=
 =?us-ascii?Q?gJUgGZQQZx/ee1jK4QFJHucZhMkBhE3MNnIaEOd1v8ybGH/t6Nnyuof7wCR1?=
 =?us-ascii?Q?A+vF9wJcCFKiFXmd+aiEIrtOGAY6+qCd0LWy1ZoLlbtEKPhJLryVESoL19M3?=
 =?us-ascii?Q?54ynXlTxcj68jyo8mTyXmspjp0R4Hz5pU4QFC/eSG9jc0iRm6rQG49b8WUHS?=
 =?us-ascii?Q?Ot9YqMDOPoI269q+JAC3KEjfZ8U3m+bkDBrBAOMJXRpRWMrQGXzKnWVDEhuW?=
 =?us-ascii?Q?yg3oAd79MRomieu3gwOKlvlsbPMi02BCgMz2YglEa1m7SCuYlu1Abwgljlrd?=
 =?us-ascii?Q?Z6kXJAq4xhMX68HZ2K/MGI8By9ZS9IcfOYkZnRziuHoyAA9aSDH+m1zR+zXy?=
 =?us-ascii?Q?VjXIesWZpjZyDRtbWIpK5Czn/UKyik6fvYuPFUOGwgd7cxcKcpgq6YzcAjNR?=
 =?us-ascii?Q?/ypDbiXlEthpdj+uA55nVgY6Qo1H/skXrS8/fRnHWWqtCM/YkmoRfA1MxiPg?=
 =?us-ascii?Q?AvZQ8ZvpV1KSLTGmoYEN9Ma8NyiXvkIfm1v+lMxHEKMqs6JQOm1yktFBa0Nz?=
 =?us-ascii?Q?NVF2ayewhipkG6IQtsQtp0FuTuvKADUWA/I3X0K5qeaeBfC4MH0usO6QfrNS?=
 =?us-ascii?Q?YDwXSt8OSTQSqIWBQGNZNuAzy6hvOb9TQh9xpUJa0y5PkoD1elWSuyHyaloh?=
 =?us-ascii?Q?b2cVw96xNdLqdC6H1iqlxuEzuy0696Q++cm4tipCI5IImyFgkxJY/bjJbC4C?=
 =?us-ascii?Q?oQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?PoLyRLziW3nxD3QtZcIsbYLVMRbKl8hCPaLG6gNk6gp4rsD70HC3gibwpUXq?=
 =?us-ascii?Q?rxI/4/QI3gzYDpFvil4BGSAqII/Ig8XUzQZBrqyPWErCE9bU/t6XJOPcMuZc?=
 =?us-ascii?Q?Hip6GeexPLzzPV23YhISEO4jpu654+5cEVGQZfblUfzXUKbBbYc/SH9dioqm?=
 =?us-ascii?Q?g4qJB28zFfOIU4BJ3mErJe9yMFIWZN7cNItRjVnJkBFOgbGhS+GbDhwJKu+x?=
 =?us-ascii?Q?v+Zqai0p2alsbd5awW29WYEHhlN9qK9VznEMyjzUJvtTl49yeM/9qDEqtpIj?=
 =?us-ascii?Q?2mKM5L7F5i+UaW5YZs7yrI6747caXEZdjmpcONDe2NLzxgZdOHeYMOfy+4K4?=
 =?us-ascii?Q?fOT5cQNezi42e+i0ahWVOtYNHSgw4Q6k0ifef3f1mij2RAOACc+Q4sRkNz3K?=
 =?us-ascii?Q?eLyNeDetLP9ZM0JjjP04O0e8a6WuEzFZcq+cxGklG20FiGtH21Ka+Hyg+Y9L?=
 =?us-ascii?Q?ubs+4bPEHVdBEX4nu6pUfkPR5k5PVdS0udrLJC4uhEdfu0/agV4H1zj3ZoGO?=
 =?us-ascii?Q?mAKe1LQ+7nqKmBhh1VNn5oHZpxlhb4zKX8FEHUTyW6QQeeh3Z1uOSDKKmPom?=
 =?us-ascii?Q?PEZdPUJ2d+PtPXZmei+TKcUklGg+DmktH9DM0588PQy9TuwIBnK0kUBiOiJB?=
 =?us-ascii?Q?MkeMN1Xvx8o7krx6ivXQwyZs3AwRMWrQe3S07HCBZEmDrEud1A+RH+bEhdPt?=
 =?us-ascii?Q?+ChTJXz2r8BOOR9UJakKcBxjCEuPt7VQS3aJ/nbjQNapLK+ila8Sh+nWla4e?=
 =?us-ascii?Q?PtNtCekQKGg8zxXx+tlZUzXGmWU29rY582FYPN+PnauOhoTLLuEwfmT3WKjM?=
 =?us-ascii?Q?B7zvFr6OHzEj//NkozcLZsidcjv9YEUyUHX/nqz6fdadd/10wAHTe2nF2VBi?=
 =?us-ascii?Q?nK8vYplkGW2ukAZu29uTnwzq3BUAVrvlzqPbHEHniXlC3c18Lt9A5CZ7YSOA?=
 =?us-ascii?Q?+fP/LbJe51TwcjIUu9LKt59zY927URZHrxq8wo3hzxXChk1v9Tg9LJUTEgoZ?=
 =?us-ascii?Q?Ct2P8TsWUVfiyXmedqhqzcPC1/F8OX+AiGT2ysin1yW+XtswmvVDQvUC5ASB?=
 =?us-ascii?Q?mbRi2VRO/ksAchSUV93A+LWuBMj1R7dQqp65zJ1avd2/ODJq1hP/GFv1tTIu?=
 =?us-ascii?Q?Tt05A+dWltdkpCiNLkH2uUMZ8PhcfvTwsQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc5f7c60-bb7c-43dd-a42b-08db18f7312a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2023 19:16:56.7985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bh0eQk8M29bF6n9toElc7gYmyqxji6Cg5K3nPyhepmZycrjAq3iS68kppJw4+7MDjKSul1qzXPp5h55XcPmwYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4942
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-27_16,2023-02-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302270152
X-Proofpoint-GUID: 35rDfUJrOPP1b_7ilaQFZ82wohHFHCnR
X-Proofpoint-ORIG-GUID: 35rDfUJrOPP1b_7ilaQFZ82wohHFHCnR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/18/23 00:27, James Houghton wrote:
> These functions are used to allocate new PTEs below the hstate PTE. This
> will be used by hugetlb_walk_step, which implements stepping forwards in
> a HugeTLB high-granularity page table walk.
> 
> The reasons that we don't use the standard pmd_alloc/pte_alloc*
> functions are:
>  1) This prevents us from accidentally overwriting swap entries or
>     attempting to use swap entries as present non-leaf PTEs (see
>     pmd_alloc(); we assume that !pte_none means pte_present and
>     non-leaf).
>  2) Locking hugetlb PTEs can different than regular PTEs. (Although, as
>     implemented right now, locking is the same.)
>  3) We can maintain compatibility with CONFIG_HIGHPTE. That is, HugeTLB
>     HGM won't use HIGHPTE, but the kernel can still be built with it,
>     and other mm code will use it.
> 
> When GENERAL_HUGETLB supports P4D-based hugepages, we will need to
> implement hugetlb_pud_alloc to implement hugetlb_walk_step.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index eeacadf3272b..9d839519c875 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -72,6 +72,11 @@ unsigned long hugetlb_pte_mask(const struct hugetlb_pte *hpte)
>  
>  bool hugetlb_pte_present_leaf(const struct hugetlb_pte *hpte, pte_t pte);
>  
> +pmd_t *hugetlb_alloc_pmd(struct mm_struct *mm, struct hugetlb_pte *hpte,
> +		unsigned long addr);
> +pte_t *hugetlb_alloc_pte(struct mm_struct *mm, struct hugetlb_pte *hpte,
> +		unsigned long addr);
> +
>  struct hugepage_subpool {
>  	spinlock_t lock;
>  	long count;
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 6c74adff43b6..bb424cdf79e4 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -483,6 +483,120 @@ static bool has_same_uncharge_info(struct file_region *rg,
>  #endif
>  }
>  
> +/*
> + * hugetlb_alloc_pmd -- Allocate or find a PMD beneath a PUD-level hpte.
> + *
> + * This is meant to be used to implement hugetlb_walk_step when one must go to
> + * step down to a PMD. Different architectures may implement hugetlb_walk_step
> + * differently, but hugetlb_alloc_pmd and hugetlb_alloc_pte are architecture-
> + * independent.
> + *
> + * Returns:
> + *	On success: the pointer to the PMD. This should be placed into a
> + *		    hugetlb_pte. @hpte is not changed.
> + *	ERR_PTR(-EINVAL): hpte is not PUD-level
> + *	ERR_PTR(-EEXIST): there is a non-leaf and non-empty PUD in @hpte

I often get this confused, should this really be 'non-leaf'?  Because, ...

> + *	ERR_PTR(-ENOMEM): could not allocate the new PMD
> + */
> +pmd_t *hugetlb_alloc_pmd(struct mm_struct *mm, struct hugetlb_pte *hpte,
> +		unsigned long addr)
> +{
> +	spinlock_t *ptl = hugetlb_pte_lockptr(hpte);
> +	pmd_t *new;
> +	pud_t *pudp;
> +	pud_t pud;
> +
> +	if (hpte->level != HUGETLB_LEVEL_PUD)
> +		return ERR_PTR(-EINVAL);
> +
> +	pudp = (pud_t *)hpte->ptep;
> +retry:
> +	pud = READ_ONCE(*pudp);
> +	if (likely(pud_present(pud)))
> +		return unlikely(pud_leaf(pud))
> +			? ERR_PTR(-EEXIST)
> +			: pmd_offset(pudp, addr);

... it seems we return -EEXIST in the pud_leaf case.
-- 
Mike Kravetz

> +	else if (!pud_none(pud))
> +		/*
> +		 * Not present and not none means that a swap entry lives here,
> +		 * and we can't get rid of it.
> +		 */
> +		return ERR_PTR(-EEXIST);
> +
> +	new = pmd_alloc_one(mm, addr);
> +	if (!new)
> +		return ERR_PTR(-ENOMEM);
> +
> +	spin_lock(ptl);
> +	if (!pud_same(pud, *pudp)) {
> +		spin_unlock(ptl);
> +		pmd_free(mm, new);
> +		goto retry;
> +	}
> +
> +	mm_inc_nr_pmds(mm);
> +	smp_wmb(); /* See comment in pmd_install() */
> +	pud_populate(mm, pudp, new);
> +	spin_unlock(ptl);
> +	return pmd_offset(pudp, addr);
> +}
> +
> +/*
> + * hugetlb_alloc_pte -- Allocate a PTE beneath a pmd_none PMD-level hpte.
> + *
> + * See the comment above hugetlb_alloc_pmd.
> + */
> +pte_t *hugetlb_alloc_pte(struct mm_struct *mm, struct hugetlb_pte *hpte,
> +		unsigned long addr)
> +{
> +	spinlock_t *ptl = hugetlb_pte_lockptr(hpte);
> +	pgtable_t new;
> +	pmd_t *pmdp;
> +	pmd_t pmd;
> +
> +	if (hpte->level != HUGETLB_LEVEL_PMD)
> +		return ERR_PTR(-EINVAL);
> +
> +	pmdp = (pmd_t *)hpte->ptep;
> +retry:
> +	pmd = READ_ONCE(*pmdp);
> +	if (likely(pmd_present(pmd)))
> +		return unlikely(pmd_leaf(pmd))
> +			? ERR_PTR(-EEXIST)
> +			: pte_offset_kernel(pmdp, addr);
> +	else if (!pmd_none(pmd))
> +		/*
> +		 * Not present and not none means that a swap entry lives here,
> +		 * and we can't get rid of it.
> +		 */
> +		return ERR_PTR(-EEXIST);
> +
> +	/*
> +	 * With CONFIG_HIGHPTE, calling `pte_alloc_one` directly may result
> +	 * in page tables being allocated in high memory, needing a kmap to
> +	 * access. Instead, we call __pte_alloc_one directly with
> +	 * GFP_PGTABLE_USER to prevent these PTEs being allocated in high
> +	 * memory.
> +	 */
> +	new = __pte_alloc_one(mm, GFP_PGTABLE_USER);
> +	if (!new)
> +		return ERR_PTR(-ENOMEM);
> +
> +	spin_lock(ptl);
> +	if (!pmd_same(pmd, *pmdp)) {
> +		spin_unlock(ptl);
> +		pgtable_pte_page_dtor(new);
> +		__free_page(new);
> +		goto retry;
> +	}
> +
> +	mm_inc_nr_ptes(mm);
> +	smp_wmb(); /* See comment in pmd_install() */
> +	pmd_populate(mm, pmdp, new);
> +	spin_unlock(ptl);
> +	return pte_offset_kernel(pmdp, addr);
> +}
> +
>  static void coalesce_file_region(struct resv_map *resv, struct file_region *rg)
>  {
>  	struct file_region *nrg, *prg;
> -- 
> 2.39.2.637.g21b0678d19-goog
> 
