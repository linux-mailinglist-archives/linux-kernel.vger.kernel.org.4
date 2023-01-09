Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D776630D1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 20:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237554AbjAITyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 14:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237228AbjAITx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 14:53:58 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E588FEF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 11:53:53 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309JkfIZ032182;
        Mon, 9 Jan 2023 19:53:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=tsvYzbXixoEa/qGLRKvlwmXD28w2bgNSvMtWbIT4x0w=;
 b=NOsFmPj8NoT9ul60TtvKcGGHpRu3zyKDmwzggWHEZtRZs2KIW48419IANdaDAn4a54iE
 Yp7mJfC2ueFKn/NGsgKUKP9bOm1vh1K9LY6TY5Hs4DXhFW7HFCxewnwIKKM91IT1LqUA
 tQ9q3qG5rwbZtIfXIqqvJDwUVSfoCdn137Oc2+m501n6ocJ9ohWP+vWz7m5xf1Z9YPlc
 pw5CHeM1OVQVrMpGFXey0fMAHARtfQmH7CYn2bdkPC8os7E3N17afpg+oxa+U4br0ucv
 rbZrSZS2VqhKBN5CLI/1hMUyPMK3apYgWW6l7GkrbxXpqMsUt5a1EwOLyawbKIIAo270 eg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mycxbb1ye-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 19:53:11 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 309IRP8b007725;
        Mon, 9 Jan 2023 19:53:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mxy64e8pt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 19:53:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7FD5BHfMWaqtasxSNcIxk1nDvm9l/XKABmu14Q69E889S6ieE7IvDtbF7QYzQonihQXYUH5h6nFDgbOw9RGKTHEHVpz8rKVa87g4P/OySQV4KvozlJCcgGaxNTk0mhAnSHg/Un5OHkMW6uny6Xl7LN0X9/m3mJp0RZB01kxPjXZcmvcZx1vIH/Ity1vKrLe6U86RggllTZoILgZXw+qdvDOJzma0AnziaIRhqvW8+K+j0uLwn2ZzodmuLwSfyhX1U1xgnNr1p5MLsAiUJlu+DwtSGMCrHNM8AXykbVtIybU8G16wG++J6oZQ3dDuLorQk6htUaY0O4LdpVHN+SJhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsvYzbXixoEa/qGLRKvlwmXD28w2bgNSvMtWbIT4x0w=;
 b=OkpQDnZMhFWpcnUg/0kQ47LflfaklDbKLy3INzRlyLjnygxoTTxvkjUFQ8YksWWsnE6vlFVZdqRdGRKfT84boq2UQiS4GDRqfdWegs3he9tBbUt/DqFHg1Y78524RSS/GZ5Qbou59NIN80HWonjM8XpK+RNhtT2Bi7WtyOUXTDfhMQRTbLZWexcOBkILGDvJiyxPXL+uXRY1pKm69fWVw+dy+xuGO7g7TeeDkc74Q9EsefyK6oX6vOLTivkKKxAisNhphNi1A9sBs+/wJ0x8wxIejWrmmQ9EZ6abcKBkN6KxT0rsbtB01W0XU+17DSqhXBrT+l1mmCIFMP/r8I8BgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsvYzbXixoEa/qGLRKvlwmXD28w2bgNSvMtWbIT4x0w=;
 b=0AvVwEG9LS+g4TTJg/hVIxECUMGu6u1nMN5iq0McGwZ0RH4bY99r0lSn4hDMZYNHbRimlXSj9jVCvKiEjkqk+ijLXb+sJmA/1qs4ioQqPtH9v4hfvWjU8FYPsWQwrTEdzkbyO1lkODwXhCIM6KoR4+w7BMuv6f/QI1i4s6dK28U=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH7PR10MB6507.namprd10.prod.outlook.com (2603:10b6:510:202::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Mon, 9 Jan
 2023 19:53:08 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3a1:b634:7903:9d14%8]) with mapi id 15.20.6002.011; Mon, 9 Jan 2023
 19:53:08 +0000
Date:   Mon, 9 Jan 2023 11:53:05 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     James Houghton <jthoughton@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
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
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/46] Based on latest mm-unstable (85b44c25cd1e).
Message-ID: <Y7xwoZq+WqCsyXpw@monkey>
References: <20230105101844.1893104-1-jthoughton@google.com>
 <60f06008-dea5-a08e-edec-fc4aec76dfb5@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60f06008-dea5-a08e-edec-fc4aec76dfb5@redhat.com>
X-ClientProxiedBy: MW4PR03CA0292.namprd03.prod.outlook.com
 (2603:10b6:303:b5::27) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH7PR10MB6507:EE_
X-MS-Office365-Filtering-Correlation-Id: c47aebf7-f24a-4d03-cb38-08daf27b218d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wphboVyXB4OV6ndlg5rt/L/4oyX2P/HeCL5hqRWHmPjFnSY5WYveL6Ztani0MM0FSTfrvnv46eU17/e/FqpzxVX2PZ+5/wrkslcuv78woIUCOtYBsUZxXdbPAE9C+wl7tIK4bXmds3za9WM0FMRfOnZNtDvtaSQlN8Z2geGzLjleDW8q+Wd0X4RLeZQtmz2Adn1pTwxF6ciJwXd/mFMBGm2lsxfh0cZabOCfwgfFTi+syRNtGZFRtA/96xlgrNIpucrIcDMDDxvWdjgmv6sJFOXU3xSVGj9wws1/VpNXdhiLg5OcS0ba+XDMRYPeo54/7l/sQpOLSsOXIqf7tPWC86yiwxGb3ObAzQ4osPOzcvhyk3anl8Tbo8UIBqBlVNl10nN6SpSrbRZUT91DYwKT7hP8j0gco89n/zbSz+nCfO6MBT5a/wrmLLqNpfrRr4XiPkFHZxk0iMxOiWA/t+eko0e3bz4dl74SKI+X9eXqAaXN2A5++RYjESjSqwJmTwiedxCQZLQBgyNhhK5ty5uRats1YL5PK3av9FSVSA35FEZsLMz9DihcKCOlBS0blwxB+daZuhwiph6Zzky+dRLTxy/Pu3cywbD8NwK557FU0XSvd+gYeawV8ihqfjkFUqY3juT6zsigLFEpx6wj7LQPrhIUnEgakxVMvloym41tEASCCXY+JgN7TuB56E3TD+As
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(376002)(366004)(396003)(346002)(39860400002)(451199015)(86362001)(6916009)(2906002)(8676002)(4326008)(8936002)(66556008)(66946007)(66476007)(7416002)(5660300002)(44832011)(38100700002)(83380400001)(6486002)(478600001)(54906003)(316002)(41300700001)(33716001)(53546011)(6512007)(26005)(186003)(9686003)(6506007)(6666004)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hDSKuJ1CtvdJiZfptEAO+jeSkfkwblEfaOmHZQJqAN13vA0Df8nZVImARfjI?=
 =?us-ascii?Q?wSJeEbGya7X1XLXb9CS+qYeZR65koXlbfbawWJ6tRR9XJ7ITrcHjnU2fdYlR?=
 =?us-ascii?Q?JiTD6S5+/4n/k2/f2mT0erReAx47XySq1OooeJSbNIAlU0/NQJkedAkqGprg?=
 =?us-ascii?Q?arHZYKCZHO66o1xXpZbc1ANig0MI2unM3ScX6xL54rkvUmsqfpFj2AqkxRST?=
 =?us-ascii?Q?ou+t4mqYSUfcwBGjbc19vNWXPMWGdmLghKAQ0qBLzHpFlxv1WAw2iZxfR/oE?=
 =?us-ascii?Q?Mpm/x+YTRj/rUCHcrqkxdk1oE9weWBFOFBe3tH4VRSnN5GKUm+qdhNiv040x?=
 =?us-ascii?Q?8rCFjEMPWWvcN9IinILBB5uwkRSGxVQRnakT8jMyniEPeF+RRgXamoxky9FZ?=
 =?us-ascii?Q?LYxx/dVQXS6V1yDCSzcEkNjCZfXa1xJIfSVsocNi6nw5h9tzQFvXrMrUKMxL?=
 =?us-ascii?Q?tM5rElAi1ZzHXvUPvwKmbne7Sst1hk+YCCgLdTSFKw3NjOktdZo6hr8YZjx/?=
 =?us-ascii?Q?VkWaa1Ebbnk5nwlknt0YFydSdp2PrSqkhZAVdodOI3CPP/unue5WXKtkaw7i?=
 =?us-ascii?Q?9ib7jXZu4ZsF2BwmbKKiqxi3O2WsXJdMN0sc73LBvPAlOJPVGpQ8fhaaWieD?=
 =?us-ascii?Q?5IZnT6FbM8Un5EjNJoHEjZqFZo1W6mWS1ndDoQuSc9UHLlIcYIwFEtOoN09F?=
 =?us-ascii?Q?bYhhAu+F8SaHQQodCuigmBMhxSJXxfRKmQUCCLlHv0OjCdIUKW7Cx1I6l1ej?=
 =?us-ascii?Q?7f40dVQdudZxY1fWTaNMu8tTHlGhdi/XNy49p23bqqHWFcOtUSIXEvIGROkK?=
 =?us-ascii?Q?m6TXanYfFXyayZPF9ItU1pRJayvvlTTQLbNwRR/M4PZQeRd/fpZI366agCR3?=
 =?us-ascii?Q?+eElQFg3UGzKbpjf+gTxA5/v7Knn0YJSBDDt7H26q0DVM6+uLGcziF2hv9XS?=
 =?us-ascii?Q?H6qcUN36cTYW5SQCI9UuyKFo+5j28eESfMfHBfT4XOpyL/Y4EA6c3s3jcX/9?=
 =?us-ascii?Q?U4Rrv8eH4KBbFAJaq/ie0GrWTRVFCm7eUhewqWZiVQY9f36g9hi7FrG4moyY?=
 =?us-ascii?Q?xNmoiAZRGD9SdW83fBCB6qwdomOl1v6FHaYuqL5UcMAiE5hVe+Gdszcb/Cy+?=
 =?us-ascii?Q?8od4r0Jvs5qavB7ysDp+fCwMuYitLjuMj9hhh+8h8BjaaSrZczqvJJlPuGsk?=
 =?us-ascii?Q?SDhCeHuAc7XhC1HfyYJS/nHtXXyr1eBA1A2MqqsLFlnNgL2I4DXp6oZUDf0g?=
 =?us-ascii?Q?XktdmQ2JmzUZri1LDSA0wey5LGLiibVuigK0su1GaF4aN53HXfxCp1LJeGbu?=
 =?us-ascii?Q?dIHjaj63W8MzUaBFce2aNrXxg+WHtvrs5jtB4M/y6TTHM2PLC3/woRYcLgor?=
 =?us-ascii?Q?U1a4N52uFr8gq3MTs10j7xAhlOngjea1Iuu/NL9+SlH31ljc19JNf35zXtXx?=
 =?us-ascii?Q?b8aVq6r922h5+4tEvLBo01qCO8lzfd/wJIm4HSr6AdRFWbk930lgg26Vxl/1?=
 =?us-ascii?Q?sT2ak6n5DuhO6fwephWrjYhUcLj+6HhW77zOgQFkbANYw41YPGqAT+wjmhx0?=
 =?us-ascii?Q?hLfR7QLFHN5EGknp8ho8RBZY2w5cYgaz9oAAOQ7g5cFf7ZvG9H7PKzU1/AiT?=
 =?us-ascii?Q?Wg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?wzqMY04YOdNB6acc5iXM+bWWYsBxpNQ+l7O5aPu10OGbZ16atjhnnSW8paSb?=
 =?us-ascii?Q?fJ5dxzZA1FAQmllri7P6zB7NvcOblCDDQTQxiJ8abcFPwPglcFNnzGEQTBvo?=
 =?us-ascii?Q?9t2jFSgBUTdvc4cMuJHEXQXAwMoksQH/7qcKJPTeKSKUc60pPxaUKU92JB2m?=
 =?us-ascii?Q?Tr/N0nYhx+gAD+NpO2ZFm6P2/KWrZvKzZ7rdc1W2yPNpmVeeeQQ9D4FCttbh?=
 =?us-ascii?Q?Oh+wmN18dr1NQrB7b+e19W5hl9s/+cinvimTKoEMFbney1ggTgelH0YBq6K1?=
 =?us-ascii?Q?xpd8mXu9JRqzqL+5qEi6OisEz8UnwLk5KsyCrCXrXGqK9uH/GPeFBVlOsQFW?=
 =?us-ascii?Q?0vKrAXA/IyKsmwQqf82qA4nKaR4LG8f90hWn3REmjoRQu1uGD1dvxoUo2Cc2?=
 =?us-ascii?Q?wS6U/RkTgMsf5WeW8SiouNFv5ruCRiA/5Tza9ezuqPCuQ8zXWxUeuUi0molc?=
 =?us-ascii?Q?k0FV7TUJVuUacwYFJtFPCfQ/ZlZ0myATiX6zcyk4K0ackOsvqqF3H4HDX6qq?=
 =?us-ascii?Q?nwA3rhRj2SkNBBlmZxYkeamurHjLC1felpFvjv4cAGIRRGsnffUqEGX3d7PA?=
 =?us-ascii?Q?tGkWcWkJHHP4kwYaC4f1n9yC7yrQdxWEE/mCLyOtKB6YO+Qd2427sP5AeqaT?=
 =?us-ascii?Q?KKxSFyYJSluYf6maILKCpGojF1uOONsO3Hbz4Y6SzI+KsNnHh47jtYVPSybB?=
 =?us-ascii?Q?6oc5rZbjAbRnzt6G4NAIfi3hDZXV3d2Vsk1YOAm2fx0Dkt2YdUMWETjFRVQu?=
 =?us-ascii?Q?OKbA4jEc43iONX0Rsl7504HgtPtXgooZT3/Rqmu07q1I9+wXTm30AbD6Sqzb?=
 =?us-ascii?Q?RW7ED68C5oCqLpPBr7C06/lrPRrFvDJupJb45Ue0SbdIb/NMucNQtmrDgJBE?=
 =?us-ascii?Q?oPzVIqBgsFmvI3vCFyiqkDUQmadwGoHn9cbCEdO1690gl/co8w7QCaHvskMP?=
 =?us-ascii?Q?09285LJGbX1K5+ivJ6SfqaaIWQL3GXIOpJaI5XZMTdPIdG4zfc1yxvaRNiCt?=
 =?us-ascii?Q?6idxCEUoLh8pOL1f6G5fz3qFL8141fxKGRzuqJl0N44fBeBeuV+3q7Lo5KWx?=
 =?us-ascii?Q?BMlyNeTMh0PZJquQeUfVeao0ArusCq+2Qq/B6omXe0+gvhKr211Xw7Wo3qYS?=
 =?us-ascii?Q?bQw/dorj+QRGW6oZ/ZY86rLTHj66xWWLag=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c47aebf7-f24a-4d03-cb38-08daf27b218d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 19:53:08.6530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1NVBc4K6DOQDEb+nc7QxRJfz1e6rUhkKEt9LMgtdmRNlUSzORvQMOPICUx1BbBa50yINRS7/DO1jBTa6GDTrUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6507
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_14,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0
 mlxlogscore=636 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090140
X-Proofpoint-GUID: bV5Ld4fPRira7EnLx5dxwkJCIyhK1Ay2
X-Proofpoint-ORIG-GUID: bV5Ld4fPRira7EnLx5dxwkJCIyhK1Ay2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/05/23 11:47, David Hildenbrand wrote:
> On 05.01.23 11:17, James Houghton wrote:
> > This series introduces the concept of HugeTLB high-granularity mapping
> > (HGM). This series teaches HugeTLB how to map HugeTLB pages at
> > high-granularity, similar to how THPs can be PTE-mapped.
> > 
> > Support for HGM in this series is for MAP_SHARED VMAs on x86 only. Other
> > architectures and (some) support for MAP_PRIVATE will come later.
> 
> Why even care about the complexity of COW-sharable anon pages? TBH, I'd just
> limit this to MAP_SHARED and call it a day. Sure, we can come up with use
> cases for everything (snapshotting VMs using fork while also support
> optimized postcopy), but I think this would need some real justification for
> the added complexity and possible (likely!) issues.

I believe the primary use case driving this beyond MAP_SHARED would be
poisoning due to memory errors.  Extending HGM seems to be the most
elegant way to start providing better support for this.  
-- 
Mike Kravetz
