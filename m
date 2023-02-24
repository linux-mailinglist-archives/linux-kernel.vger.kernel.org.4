Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFE46A24DF
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 00:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjBXXJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 18:09:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjBXXJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 18:09:22 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5F11630B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 15:09:21 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OMxEJe012721;
        Fri, 24 Feb 2023 23:08:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=6fZeklH2Yd4Gg4UePtbRu1IvA6yOhYydySx53/kT3N0=;
 b=ymzYBf7mhKFtsR8Ev0D7Nb7N3p9f3tdZ2SeZeU2fBmtOPSZY9GdRiQ+Iy99p1SjlXCF1
 GqPnXhaOX+zLE4gAy7n62FeNMCbpnmu48RSKtueqHiGMqkcvon0SYF6TKcBSCRP7lemF
 OBImSvJbri36hbsCv9nfzypYE75EVMZglosLtzrSFsDtkNkaJyQlsu/8QhVVkrorjYVe
 XrVwSIS6aRldUNK3vqYdK8ETYkdc3Mz7zKtjcZW/6hmvGSFNQZJfWfdxzCDOq/jP9o7z
 W/xIRct2RnEp+3KZbpWQJ9FcHO9jyHKX7iFUHj1nBimIkCc+pyuOtBqFRgK8HrZTIByc IQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntn90xbbj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 23:08:35 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31OMpsnx031603;
        Fri, 24 Feb 2023 23:08:34 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn4a87k5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 23:08:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdjf3NqWotxn52H/2duOqcPM4esLZwhGseB70+H1Mex5Zup1i2rDFYJyQ2AfC6pZPsflnXty6qOu3v5qkFrOUskE6vIZzYbwVILqKfFVirNk2dzu+e+M4RtxbvW5ZN+Etrd4xpnlorTvmMEiJkvJv0de2gCVibeTF7JOphrYTf9JWNE5epo4DHjLpVnt5QSpX7bkTDR34J10JquUyJBqC49Xg810gq0jFmQUQkfRxYxIO01CAAFR5lfzv60aNJ7rI5fpRAP0kbZBQVCObuLMNUoigzLBHxZRt0C4S2O6YgeBczYt8Oxt4dG168fsv/g1QMJDC0aiPS9YZQOhqU+tEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6fZeklH2Yd4Gg4UePtbRu1IvA6yOhYydySx53/kT3N0=;
 b=LVZ9BCfQXtAJ2Rju0YmEQP7+OrDj3vd3MuzfiA+9rXaoQZklWDdgumTcjbuynrgdVV9w1Ab0vwFgPUMqdovM9Vo4evOlfY0OwtBmpMBc/wxR86r2SSAYps94z8e7+KT1xxu6/+CFLCutYQ4byBEMTRXXR2stdASaCwGTlu/NZlmJf06kYldc3xX8GOUMkclR6v92//xKJp3M0cr6yTCejKax40zCWvteMQfdqD65iAE6/ASzhap0oN9EQF7fsMkDipbKSH2kT3LCuo1/k/iF03+OtNFVKB3x7QRrffWiJahd+v156NZni0PURj73oOnPtw0FI9ybRwl3PzREIojJcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6fZeklH2Yd4Gg4UePtbRu1IvA6yOhYydySx53/kT3N0=;
 b=RSFcriVgom+ben4Tx3LquFKIpSGfEEztCcTcQnIYC6fGy+JRPBAc1l24Nrr5g8cB/SEVzQ4Re5eSrlsUNCfUgskJxRx5eiGIkzB4I7KryKP+ZC07KYIl46dUDDiVKyhCbFIejCdMFKqlHHYSlBOuspbLA5FNJo5t880518QYnAY=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by DM6PR10MB4124.namprd10.prod.outlook.com (2603:10b6:5:218::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.11; Fri, 24 Feb
 2023 23:08:23 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a%8]) with mapi id 15.20.6156.007; Fri, 24 Feb 2023
 23:08:22 +0000
Date:   Fri, 24 Feb 2023 15:08:19 -0800
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
Subject: Re: [PATCH v2 08/46] hugetlb: add HugeTLB HGM enablement helpers
Message-ID: <Y/lDY+TSwS0TTv4P@monkey>
References: <20230218002819.1486479-1-jthoughton@google.com>
 <20230218002819.1486479-9-jthoughton@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230218002819.1486479-9-jthoughton@google.com>
X-ClientProxiedBy: MW2PR16CA0056.namprd16.prod.outlook.com
 (2603:10b6:907:1::33) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|DM6PR10MB4124:EE_
X-MS-Office365-Filtering-Correlation-Id: cb5f9706-cc94-4e8c-c57d-08db16bc0672
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4hi1MgA5mUIBMcZsVPc9/WNPnfU52xsJ7y60Yyj7HFEcKR1lXghzXJmZxjMsbgmHEV6fVp+uYu1sRenyj46YNmRQWbqWM2YGOami+pkcdhrWT9kOTWQAsVU9aE7gFKd20KpShk+kK7xurGRFhx7/Kg37+8qJHMpFntK3Mqv7u1A6iytEuIBnzdb+nu+Wr3fvV56E8Bzr/IsjBjWwGBdMG6pyimzFW7LGu2N5Zu9m5SQyl4UxlNC5EnOKwTYAOPhB/PjS2Lf0VTvsA0IMfgUI+A33UB+HvCzJ6cgBdsvV9O67siGtEHObB+KjxWYGBTY8UCiPw67P48MSM/Pel4JZF/kLo6SdN/AQDbGm1rTYJ0nCfMpMVL/ZOeYwhZmPMFs/BwyLJ1QOel3lAGzpeU2kzLf0eoeXU+Vd64vtgeIxU0cuVYdTXyitfoUYrOchnFUvGkdTf4Q5oHExOjxLTL+zRDiu0cCZwAEa4CEXmpCcqo1JxDBBeDYkgkHxA8QSYp5TP47GT3VV07WJWR9nlaChGYnrOp6Wr1xwR64G2LGWFRRvv/uwcZyNT0uSVutLmDK76FUOL3u5eNODxF9d40E9T3o+OR2kHKFefn93hPr21/6U3jGhDP4v8QuEJAJJFL3eNqB7Kg46gP3VGhrTqi1PKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(136003)(396003)(39860400002)(376002)(346002)(366004)(451199018)(8936002)(7416002)(5660300002)(44832011)(2906002)(66476007)(66556008)(66946007)(4326008)(6916009)(8676002)(54906003)(316002)(6486002)(478600001)(6666004)(6512007)(9686003)(6506007)(53546011)(26005)(186003)(33716001)(41300700001)(86362001)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RbEPid7LAsJHJyLHF6qfyftL9YMmDFWOq4+45GfA8snBBCl8UQdUzuxJaeDR?=
 =?us-ascii?Q?kiygmyC6G9vnYY1OsGSawUocKPHBCfJo7yUVUhl0snGSS4kJU286e5ldO+A9?=
 =?us-ascii?Q?Z3yQRBQywUjAVuunff26Hyp7XWPT5j5rtv4Jruq3DOW5lwr8FaV4Wd6Z79h8?=
 =?us-ascii?Q?wYF5uVd1JJ67MTuiuYnnBOg2A9JGFC4ZxA6DFiDeD5fyen4DHfbQPYGRFoEX?=
 =?us-ascii?Q?rw5ncXuDnqpDQOILtBbADL7RnRI3zZBZeBvoV+xw6h/T5dTEqvwVjhYAMdvB?=
 =?us-ascii?Q?MjBIg//K8LMekPAUmkRFiPYsG4sUtk+2CbWDPHVM5urZz6ERUulDMppGQ/TV?=
 =?us-ascii?Q?EUbwc/HG8V2dd891Dt+WfW0F+09eO1+gGzfmcHZ/JBCwFtGyH/3FMNfEjyFY?=
 =?us-ascii?Q?SlEP2/5EP+hfoGTnzT+sbJlSgIXP5EHEqViP02EuQRLWWf8zc36185U14oRP?=
 =?us-ascii?Q?mpICYPRK8E8zdretFylrOq6xpIJxe44d4EZaCu5hUINyUD+YPhUnWcHSFXPc?=
 =?us-ascii?Q?blJQAiCwVtghFQeMvTziL4nCJ1ZwbNlqU4J9HmoMTOlefw972F5vEvnziTLM?=
 =?us-ascii?Q?4RMUapWqRYsUzzSvtJF9LuymOMGG+FH7IedRrUg653SYDgAWgS9z8wcXsCcv?=
 =?us-ascii?Q?rbOHq+uEQbah+MjaJakRL1wWgpje+Vf3/3PLgsKUe7gSg3ANSnHIrsybhe76?=
 =?us-ascii?Q?wORbsWtJSlP62qS6C18dcByEp1uNpx0DLhCvWkMwjjCYsDJZV4RPDX0mjxHd?=
 =?us-ascii?Q?v8jDPgIRD21nQ+XgwttpR4EDQROCM2/MHpQMBEOPzKsq3Uf/IKCulGD1sfbl?=
 =?us-ascii?Q?ZxLkAnHqRJp1cZiWZ+7y+3b9o3BXqj0TGq8P0FTO5rQK+FffgvhRAqtWGyxv?=
 =?us-ascii?Q?YAIktXHJk7MC8GSNQggKYWcshnxAFBRtnuTvfU+eZYir/B8bigl/vxJFY7Xp?=
 =?us-ascii?Q?Yl7D8Mqo63iBvMYtEM+i22HntUvnxBTq1aiQk6X+e/ARuNWRUO3TjFKuJi3H?=
 =?us-ascii?Q?6X8yGareck9QttBhoCRIeZipdKd8pPw+GnYmkeWzjbJ8wiuOMO9wrjwVHzU4?=
 =?us-ascii?Q?kbKoGSWniEBJWRHfnHO0asZe6PuqE259I/Q01xOSsztgcoe/aW7SFO7+8fwi?=
 =?us-ascii?Q?TKhjHZv+mdCncuhBXsV+RWcJf+S5lNYVAE2LhO41dgs3xHHaZ3C4vp/ZNVed?=
 =?us-ascii?Q?GQJENT3rTN4sBXHn47oYRQrO99sAQKN+m115/NiHCQT7PmEXm3qAtWFDnOxZ?=
 =?us-ascii?Q?FPrWDrqMVF18OBp0mtg8DPXf5jr7nz+sBfUK29Kfd0/E272ShTEUonARSefS?=
 =?us-ascii?Q?keRL+3fiePBvUOrG6pmEKsa+MArnwM4Ots28xnsE6BCAwR/BZf7gpaAheV8l?=
 =?us-ascii?Q?OguXbEti3nI2t2nyG+xFz1FfyrhDbBh6h8jicvnck2bCSTdHqeeDd7oDMfiu?=
 =?us-ascii?Q?trZf52NtPt94YbrfaMSo6483MxWWMr4mziNO7fZ3EPG+nwjH2bXK6WYSLgGX?=
 =?us-ascii?Q?Z9LVHX31y+U2lQjGR3ftYrMavq5gwezVkC0vmKNfbEfgPpL7Wmh0XMzpG9Ub?=
 =?us-ascii?Q?9pw2Y8oNJI0XNYFYK4HpahHNtSWUyBMrXyYMjP9oKS1O/hILN6qe9iNaKXx8?=
 =?us-ascii?Q?Zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?nJaodaX8mAeKZvrwR1lcQSZtcORAH/UTn+w9stvw1FgHOPly0mVafh1GXCYP?=
 =?us-ascii?Q?+r8OpOIJPaGoJDMYhqNwOdNC6jSJWVl650ohGRd/rKnlRHuBcjBVRuezI+IT?=
 =?us-ascii?Q?/GevDkA++iOWLkrOz/hrwJnGoHcVHvqktVVflc/dRb1U6XCvuWEK/8mP0U0z?=
 =?us-ascii?Q?Lr5rc4fihafzn/BgM2PuzPDa53actKRnjwSRQ3TtrOyqJgWoZ/yJ8+4ASwXw?=
 =?us-ascii?Q?0Ju5GekEoxewf4ERTmOzXTJZ2YGLSc7HXnJuFd1g/Z7JnKVBn+fA8doPUXRH?=
 =?us-ascii?Q?31YZGo0+P50s8G094M9bjNmnAy5MQVYUgGl19BiwWrA94N27RT5Azk8czM9h?=
 =?us-ascii?Q?MySX7YyU8uNnPRmB+WFC9zxtFztKb+sDKSm3LT/c1VaaeCBPU+SYN+URX7v0?=
 =?us-ascii?Q?q86oDMVo5vihEBLwzE2hrIGSfERqmIFjM+1eAk5Ie/uW2inCB6gr+gnH20SF?=
 =?us-ascii?Q?0khJmBpOgClmlmxKBYv47RX+qkbCrT8E7/AYUoyklcErWZVsHQKw9C+tUsp2?=
 =?us-ascii?Q?NXAJEK7oGOp2XY5v68eso0T4pvGNvl/c9q0Q9d2TKPx3cF3r4WbzUfOG8dqC?=
 =?us-ascii?Q?HWeRCTP5/HJsAPfzm5R17lAqHjBCgzZlCuAo9Fykmk0ouE94RdWyAh7jpKgw?=
 =?us-ascii?Q?1iP9Xs59Hgt/rX/C4i8tNYrNmKip13AU8/k7wiISzYCARfUWvXpw0wkGpRZi?=
 =?us-ascii?Q?+XHEu49UpjpoTEeyuot0WqIU1XxmQgnSeevf6TTwQ0y0ZbYpXvXcOdE499um?=
 =?us-ascii?Q?l12M+aUSsiZlM9HI8/wer+jntsqpHjGsKtlg3OmCGhdr5IqYv+Xeqhvnbbea?=
 =?us-ascii?Q?aFUrT4aJbqexxzz4ofcgs1ytjPPO+CnHUUpcHvOmVTxvNWFHQpVS1t0jccgU?=
 =?us-ascii?Q?CJLAwiRUlbhmFO8+fy78g38spiG+4bUNmIo4izT3atGrtXi27/MoSq7br62v?=
 =?us-ascii?Q?p4AdI42F4Dv8vH+GJal3PZKGa4y6EMA16lKpisXuQdiwShltvfHp7mC4pGkU?=
 =?us-ascii?Q?0q2SkNwxPAW3fCgMiAG5uq9+RRW32He6mhXaskfwkrR8CpTb1PwcP/9aHlK2?=
 =?us-ascii?Q?8IUSyibOYTBAnjspsup7jXaNwAmcH+T9hyX3rDB592YDWwisDKX2J/C9I31n?=
 =?us-ascii?Q?QWTjq+EUr+RlGSp7CfkRr+tXH8E3+/9rKQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb5f9706-cc94-4e8c-c57d-08db16bc0672
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 23:08:22.7622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2QKdpPXUKCpDfg3vuPLdCGSnDBM/XlwhF15iwRBTiXtcSslQvWw0a2YLmWe8mc8icQtr+pch5OfLTlRlbaaw5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4124
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_16,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=671 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302240187
X-Proofpoint-ORIG-GUID: BvPZlnt6-y8SbwmKxZPszTakSwpbuNz6
X-Proofpoint-GUID: BvPZlnt6-y8SbwmKxZPszTakSwpbuNz6
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
> hugetlb_hgm_eligible indicates that a VMA is eligible to have HGM
> explicitly enabled via MADV_SPLIT, and hugetlb_hgm_enabled indicates
> that HGM has been enabled.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 7c977d234aba..efd2635a87f5 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -1211,6 +1211,20 @@ static inline void hugetlb_unregister_node(struct node *node)
>  }
>  #endif	/* CONFIG_HUGETLB_PAGE */
>  
> +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> +bool hugetlb_hgm_enabled(struct vm_area_struct *vma);
> +bool hugetlb_hgm_eligible(struct vm_area_struct *vma);
> +#else
> +static inline bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
> +{
> +	return false;
> +}
> +static inline bool hugetlb_hgm_eligible(struct vm_area_struct *vma)
> +{
> +	return false;
> +}
> +#endif
> +
>  static inline spinlock_t *huge_pte_lock(struct hstate *h,
>  					struct mm_struct *mm, pte_t *pte)
>  {
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 6c008c9de80e..0576dcc98044 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -7004,6 +7004,10 @@ static bool pmd_sharing_possible(struct vm_area_struct *vma)
>  #ifdef CONFIG_USERFAULTFD
>  	if (uffd_disable_huge_pmd_share(vma))
>  		return false;
> +#endif
> +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> +	if (hugetlb_hgm_enabled(vma))
> +		return false;
>  #endif
>  	/*
>  	 * Only shared VMAs can share PMDs.
> @@ -7267,6 +7271,18 @@ __weak unsigned long hugetlb_mask_last_page(struct hstate *h)
>  
>  #endif /* CONFIG_ARCH_WANT_GENERAL_HUGETLB */
>  
> +#ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
> +bool hugetlb_hgm_eligible(struct vm_area_struct *vma)
> +{
> +	/* All shared VMAs may have HGM. */
> +	return vma && (vma->vm_flags & VM_MAYSHARE);

I think the only user is madvise_split().  We should probably check here
or more likely at the beginning of madvise_split for VM_HUGETLB_HGM already
set.  No sense in invoking the overhead of hugetlb_unshare_all_pmds if
not needed.
-- 
Mike Kravetz

> +}
> +bool hugetlb_hgm_enabled(struct vm_area_struct *vma)
> +{
> +	return vma && (vma->vm_flags & VM_HUGETLB_HGM);
> +}
> +#endif /* CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING */
> +
>  /*
>   * These functions are overwritable if your architecture needs its own
>   * behavior.
> -- 
> 2.39.2.637.g21b0678d19-goog
> 
