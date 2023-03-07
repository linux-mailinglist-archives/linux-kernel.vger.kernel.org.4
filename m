Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBBE6AF817
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 22:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjCGVzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 16:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjCGVyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 16:54:52 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8497094A6C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 13:54:50 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 327JwhUL005079;
        Tue, 7 Mar 2023 21:54:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2022-7-12;
 bh=oHN5ZGPjd5OxPr3pBbLZFg7jXDTHdFmODa73G6Xu3XY=;
 b=DYsXgk8cQTk6e7TKvFLH8JSaXlIAFrnQTeysG0Lc6GiVW4343lY7mCktHC/1te/ukSjY
 /1k6Ls2HNBLSC3D+5VR0G2vmdJFPdvlkDCG185xX+EIZegis5QN7nxb31O5IPx4PSIKS
 VfppiezGr0m1lG83Q49j4sZhk3Fp6PolnOTV8Qh6+jxo+gO58b+Oxs/Qaco6VEbo3iAF
 rBwSW7lByx7aLzA5Hhwd68iS+E8hExJuQmZ/l3IGSEO5cBqNw8aTjhbzl2iLHP3JqfQZ
 ZNFx2zd8ic6pbaKL/aJ5huH3DUQUIreijNeePdW9aS3oyRVy3SX2k2f0+jcF7SB0RxD7 1Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p4168prjq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 21:54:27 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 327L48Pf023477;
        Tue, 7 Mar 2023 21:54:26 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p4u06v5u0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 21:54:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DaMtRha9o+Qib8PaeqOZGn/f62RagyabXLLjKNJs0QlmnD+400Zg8flrjpQ7jxA4wlD9qYfgM2EvlWGTwOkSMFqpvtV1D68poAQ9H1x6uWpD4j7KUFIbXli8hV0x/rnEKqkQbk957eq/h7aXpdaMMlqmHpC2FqWilAC32ohmBZxHU6n9wfgOlzpKrkJ9Z7K8kzaw8xwHR0htW6lWv7dviofth1H27Y7SWbh7wK3BkDKAku9Qm471yR4CP2igAn0asjPhdfxRfc1SLF9gDGZh6He8AyN6O4/GTrfrtOkXqfCtnR/1KmqbumVi2RDTDfWQZdYttjNrEGNUucyoYAA1fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHN5ZGPjd5OxPr3pBbLZFg7jXDTHdFmODa73G6Xu3XY=;
 b=chsEhLJickw8tZo8Lg3JU63E5oEvbHovvywFhD8mOMr9wWBgTJiHCPh+pHwMxt1QQKFPfyEG0Pgl/tlJWhJAHWB01E/LwBhZKxoTqC1ykHK8UAK31gpApYqtjB/Zk1tNlCKYbcgW81ywxGVbPUZpPEBUSVpMOFQMekqg3rgdD3mWjxMoG+//qSv3cyCbrcCqoNDw1oVyX6jQasG5uo3R2k+WBTRpKLM+mZKPcfPiil/qxz6VTyxS3BuSu9ec5Qh8b4HpveAsNk3r8W/UXJ7q2bCbluhukqE9vgdZ9rKmUFt6c+FcRffTPdBhMEW8i+5o+FLe96Ar1OwSWxmVI9E+Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHN5ZGPjd5OxPr3pBbLZFg7jXDTHdFmODa73G6Xu3XY=;
 b=utNQ90hQt5qo7ahtm2qyZOlFVoy6YMXM2Mj/dEMqgjHbGVnZtHlWm1mQHwwgXvRgf6IToqbi/HczUH+nJOUpBPsxBm82c6tk8Etq4lDNMyM1yz4Om2lzjeIAsxNQtwWe7up5/vZiOCLA9zFBE6loddmBYitwcSJU/HxEhWG8mwc=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CY5PR10MB6189.namprd10.prod.outlook.com (2603:10b6:930:33::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 21:54:24 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::3db5:6e11:9aca:708a%8]) with mapi id 15.20.6156.029; Tue, 7 Mar 2023
 21:54:24 +0000
Date:   Tue, 7 Mar 2023 13:54:20 -0800
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     James Houghton <jthoughton@google.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: rmap: make hugetlb pages participate in
 _nr_pages_mapped
Message-ID: <20230307215420.GA59222@monkey>
References: <20230306230004.1387007-1-jthoughton@google.com>
 <20230306230004.1387007-2-jthoughton@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306230004.1387007-2-jthoughton@google.com>
X-ClientProxiedBy: MW4PR04CA0054.namprd04.prod.outlook.com
 (2603:10b6:303:6a::29) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|CY5PR10MB6189:EE_
X-MS-Office365-Filtering-Correlation-Id: cd26c784-08ad-43f2-0a34-08db1f568398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O2ZN1Jjs95w5YFRFXNavqAqQ/eESZ+OjdrW/qQ55gH2+x++avVc9748/wmcIDVYNnYhE4VS5X2UJrwzWgJZ5FvvBxyboFgjWdD3zuLmn0ecVvld6ak9XNqydWHJ7QmWvE2DJOivw9zwWNDvaKbjatkL4OmNmdY2En0pcFsThggSTVqzadmkKPI/+t7R/UxkqXLewRq4hBOsjYlTkU96MVIo7SiEW4597rxUxlNUvu7PiNbetFBypBYPygBMEuwUT6Tav0ux+mPjj1Q/2SeF4++6QMfqPwmjH21aqwXoXO+2q4ErntPmnmFEGHwrRBcc+5rGydPAxUMaDRkVp+GtA0KkxN2W/sJNyReiFWJND5zk3pPjwB8i6041YnOq+sAM9M+6EYOM5l231ZMRqElQELfdKDxF555KebAGM6Bqdf+4hELxb85oXDBHw660BTVr6wkwOxMuQf+PEju0fKS0+isFKBtBJK+OiWTqbikwlQx1yX4031l8be9guDQU1MlSlmQArs0Ws4b6lIwWdXo9p50+1Rtc2Jfs1FLuo+e7DLZyzTfe8FAVi6DSAkm1RXuZoDNk0cJcfXDDCYxiPsEsF1QqmxKrWTp0ZnLnLpmdgtYDwa9YGcoiD5GBZdHLjZdkKlvwchZKJd4f9xUsaPEnPOw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(7916004)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199018)(6666004)(5660300002)(478600001)(7416002)(86362001)(186003)(9686003)(26005)(1076003)(6512007)(6506007)(2906002)(33656002)(53546011)(6486002)(44832011)(83380400001)(66476007)(66946007)(33716001)(66556008)(6916009)(4326008)(38100700002)(8676002)(8936002)(316002)(41300700001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dnOHhhEpBpjrpcn0nV8K0P+T/bDLxIEYAh1AGZG9aUuf/pqAylrzcQHe41h3?=
 =?us-ascii?Q?afNVuiPI9iQsaowz8Mmsk7iMkKJ6dSqHI0KZdnxnk9PrZdYWJhMZVb4FpeWG?=
 =?us-ascii?Q?VYItmCxVsuCiykE2+P8h1gC3xUyMyvVRl48g6dckKqQp/5IWyDgG5XHOOcWy?=
 =?us-ascii?Q?z15Uo3bNEOxnStv4jYktxWoomE8/hfhyg3aLeyjTWHxNCvxigxdwygIfzIGK?=
 =?us-ascii?Q?OsowNHwLuQ63irGkmI+kjyRXeiwnJ+MxrtQeeLx26b5FjQ1znRXewfJiMFe6?=
 =?us-ascii?Q?lspWkAGsxtQkGH8gV7NwPoYz/Xtka7bFpUNC0Dvwmm2ZNZa3XHZPzK2xdGIM?=
 =?us-ascii?Q?uvyglPMjxFOSUi64+Uj1TsVwkkz0gxPxXGEmFK6kZQ0oyJ3HqXdTGE989rVE?=
 =?us-ascii?Q?95u1arU3A60y2IHFuDSC2/deXrFxh3I1SxVz3YPB5Jm9R6z7Yafco3XCnj+I?=
 =?us-ascii?Q?yYGvzS9a1yZpFHpsVZh+HlwfMQN5dLcn2vMHG/OJN2TFAJRjnEHpRI7T3ByP?=
 =?us-ascii?Q?47e8V7ayWVPbJzMMjIQxis8xqUPfavF18h0T1tZtbR+8qiLDhlUK0Qben4hL?=
 =?us-ascii?Q?pTzo5ew1vok6Ycp+k+Kdv9rGMt6P6jUM3Ml/vEh3EyobrkyU1maQIkm0cmdH?=
 =?us-ascii?Q?puDQsTFwgR730ccQPBXnP9KkCfwLLQoqv46nkP8dst7ygUiqDihXhr89h91T?=
 =?us-ascii?Q?g4GrQ2jDkdjyDqS+0ZuKhiOxAmP3LXSgGphKOCBtvGYirKbtxxPMK3KD6fwF?=
 =?us-ascii?Q?Kw46JAuR+vwEEJ7P8aBM0osbjBD59vcJV3KcCZLgAzaWjlASKB1SOJnkQQbY?=
 =?us-ascii?Q?g6WWFbFJsbHLVoxZ+rrcKmj1IxhEj4Hj/ivYUz6rMG9ZhkmxkF8HS/xiePre?=
 =?us-ascii?Q?osRx8l1teif3WVL9LY2kAu7IsaAkgiUecDoc7i4u13TTWPGNPmtAh5aRTpyJ?=
 =?us-ascii?Q?7pE6XDAh1zTXSoSjSbC3OlhraFoQbR38VybarChe9HjQ5cTUadb2nQYvAhHu?=
 =?us-ascii?Q?+lfAVe9O0SAqNfNAwlNA+2N0/4hiO/djppLry2gx+dtiI072TdruBwJ3ljR5?=
 =?us-ascii?Q?TL/hJMUDq29WOa88WOKI2M4LRzDY/YJbESAg94EBnrdxqRy3CwI5pIoxggBj?=
 =?us-ascii?Q?N/0aKkzFG1axB1e+dXyVI3ET/ZWnMSNJ2rW0k3p8wkFREVpEy/wOgywsZXCV?=
 =?us-ascii?Q?QcKX2bEzQFmpA1tzlScG3OFviRFesqmoJdVX5cpbe9Nz3xImCpIQiVUVlgSz?=
 =?us-ascii?Q?4Qn7nOUZNp5Mbcn2p3jIpeMAg22snTgnxiDyHIwkxD495Kltk2VVfE+u7s/p?=
 =?us-ascii?Q?YjsXwxI+Ax2IJYryEKVHcLlZ6QPyEJnjQtngeiwd6kIH4eqIlzAiyUqgya/r?=
 =?us-ascii?Q?iR59Vi7whHMgsnNvjSBxM9okVNar2yYBMaJ4AoO3+rjEkzb0LaF7of34JyVl?=
 =?us-ascii?Q?A1F3o4mr0GQdgXQvoRz1OI4dvJNyV0tOwPNxr2IJ0/XgdBqMOafPjxgJ1jJ4?=
 =?us-ascii?Q?mHoD+RTZMpTGkku/R/Lwz5cO4sQWllAIm02ibykSUJaD8fHuNQnckupAmdLQ?=
 =?us-ascii?Q?eorruv5+1emyRmTnEY0SFnwWipRXwcn5C6qoNlTjXCMu4E0mbunPg0gyRLtJ?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?SGdFtf89+b9/5eRS5o3gqbjLDVbq+t6MrLKu6cL8YxuNjWNd+zdilChwLpBK?=
 =?us-ascii?Q?6RYM2BsEALiBQ8fUDs6L4cwy+3yPNnG4kUJIhiJhgd1owKBz0tMQ58lUa4k9?=
 =?us-ascii?Q?nscsQX0GXAIEodPpQm7rI445E1ridJfgcQvpOUPjIq7o5ULVAhk0GMo3Fa8u?=
 =?us-ascii?Q?++2ECV16agjPtcjJHLgSvqCiJIqVJgSp8OV2i2IIGBsWCrVWBHnrDmd8Ll6u?=
 =?us-ascii?Q?nl5AvXB+2Ij2DULHY1SVRuvtB8cXxzy4KSpf+ic+n7ZNRN6VXRnKeA2TSV3V?=
 =?us-ascii?Q?tBP1uehcwdagDBXUlBjc2KbKX+uSSeYkDXx7924fP31iJKl0fkTYDpl+k6FK?=
 =?us-ascii?Q?0LePtNUjyVAyZw3pxWrzMqv8Ttukf+Lpp4C0z4NBjUzScTSKFZ+lzVC6IyHs?=
 =?us-ascii?Q?3nyX7oHg5Azfh0/I5HLUTS5AhA3BYyjZhlyxhjP6QVaZTEVlgjTDcAiaVEE9?=
 =?us-ascii?Q?A++CvFYLHTygc5sVA2I0CyctZiEbLRejDGik4hr7sXRN8xCjReaRiacuzOYe?=
 =?us-ascii?Q?BAgcfXBRZv0kcuGLCv8TyrZNvVPQszjiCunkmN/RTH2B6s3ZRk8x/9cad37Z?=
 =?us-ascii?Q?C6dciBi6XGstwFIpy4nQ3U4EVoTQiPgWim0zVzPt/uJCJB36EkJZPq667eTf?=
 =?us-ascii?Q?VTs3/6s4mtNHk/xwhR/15RCHhfhOtrCsn8Ru8O/mGCGMN17Wo6n3Jn/8pTQc?=
 =?us-ascii?Q?N71u/UXBfqHJaHWUVAGBv4NEagtDyCyc6YChNCM348ivGKc+i7HbZE6wBLzU?=
 =?us-ascii?Q?IDfSRY+tSfmUQ1lr8KbiTToH51+wN6XNvuNSbZ9lTPAxzLmtuwFB3Woq7vUw?=
 =?us-ascii?Q?AaaariYKDTglMfj16/cFaEF7an47L4PDfCPoocBuTR0ThCljmtFeFzUW/kIl?=
 =?us-ascii?Q?wka2EnNbPyo34ceD4CtkvGUTsYHM75f67H4sZWfsPRzvdYUQMwRs6pUg7G9e?=
 =?us-ascii?Q?EL2Bx/CX1BmZIgz183cXmqCVe+VnFbGo9IJqvFwN1uXQA1FM4Ql9vePc8YOr?=
 =?us-ascii?Q?xMOteh9kGQ9U3YEZUwPuqGTZRg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd26c784-08ad-43f2-0a34-08db1f568398
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 21:54:23.9734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JFzS6t4bvuQfNMSk4729+D8bdU8hEnJ2Q2UhWOT+xGAr1QdJ4uLxJua9z99eADVz8nbIgDTpuOOArKYN0GLqOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6189
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_16,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070195
X-Proofpoint-GUID: u15DooNKCdUQr0cDgIowFBF7j2PPBgJa
X-Proofpoint-ORIG-GUID: u15DooNKCdUQr0cDgIowFBF7j2PPBgJa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/23 23:00, James Houghton wrote:
> For compound mappings (compound=true), _nr_pages_mapped will now be
> incremented by COMPOUND_MAPPED when the first compound mapping is
> created.

This sentence makes it sound like incrementing by COMPOUND_MAPPED for
compound pages is introduced by this patch.  Rather, it is just for
hugetlb (now always) compound mappings.   Perhaps change that to read:
For hugetlb mappings ...

> For small mappings, _nr_pages_mapped is incremented by 1 when the
> particular small page is mapped for the first time. This is incompatible
> with HPageVmemmapOptimize()ed folios, as most of the tail page structs
> will be mapped read-only.
> 
> Currently HugeTLB always passes compound=true, but in the future,
> HugeTLB pages may be mapped with small mappings.
> 
> To implement this change:
>  1. Replace most of HugeTLB's calls to page_dup_file_rmap() with
>     page_add_file_rmap(). The call in copy_hugetlb_page_range() is kept.
>  2. Update page_add_file_rmap() and page_remove_rmap() to support
>     HugeTLB folios.
>  3. Update hugepage_add_anon_rmap() and hugepage_add_new_anon_rmap() to
>     also increment _nr_pages_mapped properly.
> 
> With these changes, folio_large_is_mapped() no longer needs to check
> _entire_mapcount.
> 
> HugeTLB doesn't use LRU or mlock, so page_add_file_rmap() and
> page_remove_rmap() excludes those pieces. It is also important that
> the folio_test_pmd_mappable() check is removed (or changed), as it's
> possible to have a HugeTLB page whose order is not >= HPAGE_PMD_ORDER,
> like arm64's CONT_PTE_SIZE HugeTLB pages.
> 
> This patch limits HugeTLB pages to 16G in size. That limit can be
> increased if COMPOUND_MAPPED is raised.
> 
> Signed-off-by: James Houghton <jthoughton@google.com>
> 

Thanks!

This is a step in the direction of having hugetlb use the same mapcount
scheme as elsewhere.  As you mention, with this in place future mapcount
changes should mostly 'just work' for hugetlb.

Because of this,
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>

I have a few nits below, and I'm sure others will chime in later.

> diff --git a/mm/rmap.c b/mm/rmap.c
> index ba901c416785..4a975429b91a 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1316,19 +1316,21 @@ void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
>  	int nr = 0, nr_pmdmapped = 0;
>  	bool first;
>  
> -	VM_BUG_ON_PAGE(compound && !PageTransHuge(page), page);
> +	VM_BUG_ON_PAGE(compound && !PageTransHuge(page)
> +				&& !folio_test_hugetlb(folio), page);
>  
>  	/* Is page being mapped by PTE? Is this its first map to be added? */
>  	if (likely(!compound)) {
> +		if (unlikely(folio_test_hugetlb(folio)))
> +			VM_BUG_ON_PAGE(HPageVmemmapOptimized(&folio->page),
> +				       page);
>  		first = atomic_inc_and_test(&page->_mapcount);
>  		nr = first;
>  		if (first && folio_test_large(folio)) {
>  			nr = atomic_inc_return_relaxed(mapped);
>  			nr = (nr < COMPOUND_MAPPED);
>  		}
> -	} else if (folio_test_pmd_mappable(folio)) {
> -		/* That test is redundant: it's for safety or to optimize out */

I 'think' removing this check is OK.  It would seem that the caller
knows if the folio is mappable.  If we want a similar test, we might be
able to use something like:

	arch_hugetlb_valid_size(folio_size(folio))

> -
> +	} else {
>  		first = atomic_inc_and_test(&folio->_entire_mapcount);
>  		if (first) {
>  			nr = atomic_add_return_relaxed(COMPOUND_MAPPED, mapped);
> @@ -1345,6 +1347,9 @@ void page_add_file_rmap(struct page *page, struct vm_area_struct *vma,
>  		}
>  	}
>  
> +	if (folio_test_hugetlb(folio))
> +		return;

IMO, a comment saying hugetlb is special and does not participate in lru
would be appropriate here.

> +
>  	if (nr_pmdmapped)
>  		__lruvec_stat_mod_folio(folio, folio_test_swapbacked(folio) ?
>  			NR_SHMEM_PMDMAPPED : NR_FILE_PMDMAPPED, nr_pmdmapped);
> @@ -1373,24 +1378,18 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
>  
>  	VM_BUG_ON_PAGE(compound && !PageHead(page), page);
>  
> -	/* Hugetlb pages are not counted in NR_*MAPPED */
> -	if (unlikely(folio_test_hugetlb(folio))) {
> -		/* hugetlb pages are always mapped with pmds */
> -		atomic_dec(&folio->_entire_mapcount);
> -		return;
> -	}
> -
>  	/* Is page being unmapped by PTE? Is this its last map to be removed? */
>  	if (likely(!compound)) {
> +		if (unlikely(folio_test_hugetlb(folio)))
> +			VM_BUG_ON_PAGE(HPageVmemmapOptimized(&folio->page),
> +				       page);
>  		last = atomic_add_negative(-1, &page->_mapcount);
>  		nr = last;
>  		if (last && folio_test_large(folio)) {
>  			nr = atomic_dec_return_relaxed(mapped);
>  			nr = (nr < COMPOUND_MAPPED);
>  		}
> -	} else if (folio_test_pmd_mappable(folio)) {
> -		/* That test is redundant: it's for safety or to optimize out */
> -
> +	} else {
>  		last = atomic_add_negative(-1, &folio->_entire_mapcount);
>  		if (last) {
>  			nr = atomic_sub_return_relaxed(COMPOUND_MAPPED, mapped);
> @@ -1407,6 +1406,9 @@ void page_remove_rmap(struct page *page, struct vm_area_struct *vma,
>  		}
>  	}
>  
> +	if (folio_test_hugetlb(folio))
> +		return;

Same as above in page_add_file_rmap.

> +
>  	if (nr_pmdmapped) {
>  		if (folio_test_anon(folio))
>  			idx = NR_ANON_THPS;
> @@ -2541,9 +2543,11 @@ void hugepage_add_anon_rmap(struct page *page, struct vm_area_struct *vma,
>  	first = atomic_inc_and_test(&folio->_entire_mapcount);
>  	VM_BUG_ON_PAGE(!first && (flags & RMAP_EXCLUSIVE), page);
>  	VM_BUG_ON_PAGE(!first && PageAnonExclusive(page), page);
> -	if (first)
> +	if (first) {
> +		atomic_add(COMPOUND_MAPPED, &folio->_nr_pages_mapped);
>  		__page_set_anon_rmap(folio, page, vma, address,
>  				     !!(flags & RMAP_EXCLUSIVE));
> +	}
>  }
>  
>  void hugepage_add_new_anon_rmap(struct folio *folio,
> @@ -2552,6 +2556,7 @@ void hugepage_add_new_anon_rmap(struct folio *folio,
>  	BUG_ON(address < vma->vm_start || address >= vma->vm_end);
>  	/* increment count (starts at -1) */
>  	atomic_set(&folio->_entire_mapcount, 0);
> +	atomic_set(&folio->_nr_pages_mapped, COMPOUND_MAPPED);
>  	folio_clear_hugetlb_restore_reserve(folio);
>  	__page_set_anon_rmap(folio, &folio->page, vma, address, 1);
>  }

Should we look at perhaps modifying page_add_anon_rmap and
folio_add_new_anon_rmap as well?
-- 
Mike Kravetz
