Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B52036D9E1C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239797AbjDFRBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238461AbjDFRBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:01:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0186B83FA
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 10:01:08 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336Ehu1W015755;
        Thu, 6 Apr 2023 17:00:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=0T6fW6ybldq7x0G60fT9ux7f8dUOm8wqfmdNp5Op1Ls=;
 b=TgmkkEuYSR/ZH1Rd1vwyngZA4DJ3qw9SXhkaNjLn3lSXUZat9pdHFC4P2LJcQYGdJJ6J
 vTjANsOtWoynts13eSGzSUlwqpbXRRdIQ/lSCs4gMonM1xq56JpNNbLkoyzYHelsJrV0
 uAQse1b75R+dGUgHJT+yVoWqsAEnlqUHB0dBzW3oWnEvoCd8mzrBSAg1BFAl+eR+Z21t
 TvOiiUU3Jj+DqZXljlFIy9Bdb96lPj3lo0WDcP8RPMIxwAidtvXecEXXlbODt16Pt9NP
 /bWcCQDj3iYuw6Vp6bQDWYOlfYfPBwL6xuqjpfD0vXer1f8OM3Sj5BqPqF2S3CBQgCJK zQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppbd43ev5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 17:00:34 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 336FFJrv027547;
        Thu, 6 Apr 2023 17:00:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptut9kp2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Apr 2023 17:00:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOKwJ4BziFBoz1o3zKLdGSP3zy/cp6+HoTLH4Cxc5A8WzkD8ZITYvgLihoQMms8XR9jm6DMoXI6oP2s7CY87qDLuhdO+YdSE+kDzkKcRqH3sVQWx02Sjj+RRrOyw/zmNZBem5JNIFt3fGLctiSv4kXkOdUuE8Fv/E/Rjm5xuUkK2x0Cma3/gh6/k4jakIkIUG9mKPbvFQKUv+l9657UkbO9JZgTr9rKdHqSGWVj0KHGWYmfHgkwKLCQgF7X4m2Lt0m0Ir+WHa9Sr4rXDtCt91OUpuRrfV6/3VsTs/HPzD3VExeT8bcYtaQF10TOKiBA9Dr55NqtxBdrYVJ3d/tmCyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0T6fW6ybldq7x0G60fT9ux7f8dUOm8wqfmdNp5Op1Ls=;
 b=f+ZE3MJCtpObgbAPUwkT0rwiZkfFrOnlHV1asXJtXrvlEaRryzigyVeoAi40KvRxVa4EjyEZsjDpyY22/RCGAxzREa85/+eOwjBb+UJOAlHKu6AO07+mgwnHvheF/tfWF3OSO2NXp4LTYmo1b+QqFzWZMHN84iJf64UHhRacwRawz/DBBOMX74SST2Bp2lTVVIjJmuWWXuAeeFzmBbN7VzP2QB1TRYsfGmfGgsheJzuAZielqaivAk+q6m+9pjF+d12RApQix99KtDPaZd7JEvtHMChym+MsC+tPEVcbuJ5fylLnRFjs6F2mmjpeMAXH3f15MWKL3qenrz+PLee39w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0T6fW6ybldq7x0G60fT9ux7f8dUOm8wqfmdNp5Op1Ls=;
 b=v0u5Vt0grGD9PpR98LoKHzpoqptStCAbToo5WS/yg2JpXlKaJt9OVneHcSXwZm6rtYKJaGVMtv9wL7OsiAOMaNNFlPd6iGCvhNErLJfVTaxUynEhpqihcAc5UjsV5AgbctKO1ElA1/Pdpai3AbsJmGuvljAvbeyTpOreb0gl8r0=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DM4PR10MB5990.namprd10.prod.outlook.com (2603:10b6:8:b2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.31; Thu, 6 Apr
 2023 17:00:30 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::986d:1a90:f60a:53b6]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::986d:1a90:f60a:53b6%8]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 17:00:30 +0000
References: <20230403052233.1880567-1-ankur.a.arora@oracle.com>
 <20230403052233.1880567-10-ankur.a.arora@oracle.com>
 <20230405202704.GF365912@hirez.programming.kicks-ass.net>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, mingo@redhat.com, juri.lelli@redhat.com,
        willy@infradead.org, mgorman@suse.de, rostedt@goodmis.org,
        tglx@linutronix.de, vincent.guittot@linaro.org, jon.grimm@amd.com,
        bharata@amd.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 9/9] x86/clear_huge_page: make clear_contig_region()
 preemptible
In-reply-to: <20230405202704.GF365912@hirez.programming.kicks-ass.net>
Date:   Thu, 06 Apr 2023 10:00:40 -0700
Message-ID: <87355dlzd3.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0219.namprd04.prod.outlook.com
 (2603:10b6:303:87::14) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DM4PR10MB5990:EE_
X-MS-Office365-Filtering-Correlation-Id: 08151f48-b007-446e-e4c9-08db36c06d8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BxV0K6JV0bhwV0/vjI6TOsAqAlLMTl6+UiBazhUllJfxRfjMAdiWQtEP4cZw6i0vKWAuWBkSYniwwJFJ00YfU9SyHipYORvtO+osFVngubHltnirR1oqevBgxhtzwN14e7a8jtKCd4SNaJZ5Qox4/BAYrTSCp4us9lMItay58s+RpfLYPMVqXce/kdYJJ3ZnRHpBs+22zqzNGTvV/KEG6jWtu16N19PUzgzQfTv8bsKCO+h8rxMhgcmG5KVjTqx7y8CBBBLE5ERTLjC6y71X+fVJfjhlGvdxauf8awfNhu+YZbOdc3PBuKRcAuxcBNL0o0N1AVAy0smCQ/3ueLyFngUOq+tebT/zU7/fG183n7nk4P1cWNk2hmIwHsn1XAzPDkx7RjZVUL40If92WVsJoZrRzFzh4iKIUD95zoDwZUdMBGunVS+aXGegl1vmgQR5j6EuKQPBaCMiDxnlKS7PXL10FDqLsP7SX0RaxxryGy/c1t5tsYZF/FnH/MBdAXy7gbXFnlImCTMbT9oCDxt5rHXdU63WcS2j3eCjj7aIiJVB2onQJFUj8x4oLFdd0rB/dScbzK4WggyjC1OtWvlMc0enUb2tQe9tkR9BIZiymjE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(39860400002)(396003)(376002)(451199021)(6916009)(4326008)(66946007)(66556008)(66476007)(8676002)(478600001)(316002)(8936002)(7416002)(41300700001)(38100700002)(5660300002)(186003)(83380400001)(2616005)(6666004)(107886003)(6512007)(6506007)(26005)(6486002)(86362001)(36756003)(2906002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5yg4iGBU6uno+YuL7yjsabL6opovhqMPGpGzjBn/zNPNCGLvO8Wz60MAabsC?=
 =?us-ascii?Q?jFQucM5OXf+IH7Tyuq+SgmVKQPh8tJ9CdHm3epATNwU6bjKK9ZRNYNrI0qkf?=
 =?us-ascii?Q?yV/yCaCUa2qGO/ft5lUvXk3tLjDXaiNq/Nn0ISyl1vRu5UGthek/A0xW7/Ma?=
 =?us-ascii?Q?4jarQm8c5WxG8jp582hpXaxqvwUXrcSZmYsI4iGEsigwnEu0WgU3X8OfRFe4?=
 =?us-ascii?Q?82n4WHHl3/9wxJ1AIR/a0vpaLISPmrJjw/Ivz+AMq/pdswKvvG+ZdConbWeS?=
 =?us-ascii?Q?YkK/JwzKRhT7+yj23gcQGvANsTSqz4YHyGeJ7I9SyoF8RzCLuKuUyvl3nRx7?=
 =?us-ascii?Q?4AngVd0mPWTlsbGSekVt/XnArbNk9XA/k+BuIFvEwJMZRr8frNHvfnmSVN+B?=
 =?us-ascii?Q?QpX72hMfsPjK6A5C0dUMB+uTcqtcnBNvy/SFS2OBfgGiigo1oQjKZpmM2GX1?=
 =?us-ascii?Q?0rC9cFPAXVTMNSt3xofMTjXSJyhECLPfOSDUfxLtpP7iO6uhqMhkFaqBtLOb?=
 =?us-ascii?Q?LknEbjAFY9YSpr8yIEYAWXmwZUYKStA2jjaefCJwv0KEP/7TSpfQIPQ5C2Bh?=
 =?us-ascii?Q?3YAvDJ65ENOoeyyKxZmbi3SnVXxbfhSaVDCX6JhrsbAMVNQmQWWP4bTQFJm3?=
 =?us-ascii?Q?X/WVdscHiEJWzL6GZtkRrN7/Qbgiwm6T82CwGJjy1iepFpzcYfHrQZoOrEd6?=
 =?us-ascii?Q?UvKtzay0GRAi1Xc4Apps3ota9iOUClKsvWjRGo/j99tb2eNi72W8u7gW/xpk?=
 =?us-ascii?Q?nMpVLeeFQxfRg26lbVMiWWOZATUk4hBNmR89iM8sQVgvNT8O4MN+ikofJ5k2?=
 =?us-ascii?Q?/YRxQRzp8U/EQdeiNf5VUoY2kRNjeLQlW4ru8WowjLkDJSKYPtBc9oTgOysk?=
 =?us-ascii?Q?7pUoHY11/XEfBaxeGXae+166xM4pi1QnD02h0ERXrAYqO9ZNZmAffTjCbgiz?=
 =?us-ascii?Q?YUbsT+R5Hs5m2ziHHrfcwYBJfMEdIE1EOFCVTQt0QqywVObCObU4kwm5WGBm?=
 =?us-ascii?Q?DoELGSGPhltaWnRwT4MApgkXKEnQec9tTLarblJy3OPxFmQlBanIw2yS4VeD?=
 =?us-ascii?Q?rvhUsSGbp0Y9HTCxTknRPLBnY41jpApNdicWtmNmEJDWfxRRorCvgQR0j4C2?=
 =?us-ascii?Q?VO7zJllQ4K9ZGTJQudiWr0XeJ93f4NdDapOYnp0FF04Iy2uNsPAyvD+C7jPN?=
 =?us-ascii?Q?gAVf0LDzAPD7DHlogVg1HW+jQoieRH3JVtmEb2JA3xcRBbg7ckE9nDRPIToI?=
 =?us-ascii?Q?ELmqKdcNTEVhbsjnZCXlJYFiDD6jSm3GTKXlw6DuCWsG53ro+ZKudVeAlUr/?=
 =?us-ascii?Q?tZLjSh2uICTEgdM+YxZxIIQ3BSE5vFAIPqkmz3Itc1ZSJ0oeKovtlnrPSf3y?=
 =?us-ascii?Q?kvV/z/auLUudM/ytNxs0D8YYB7L7XKXupEcikgjqOiSWBRyo6D3gwFb3cbY5?=
 =?us-ascii?Q?boDSfwmYUSYAyXFiD6VXSOOKiDQmdKMmax1T3fJpNVU2C5L7KUe9PibSOXjW?=
 =?us-ascii?Q?IB/cXTXpyOlI7tO6E/QnJ/2JjyBZli5srGb8VfB3KunlT7stgHaNd9ae0738?=
 =?us-ascii?Q?SGBIBm5eOZoEHIRmlen/ndDrmSA6sq+U2XHctBRGGG/gMNog0kwk492kjoNP?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?pLtyHQ5Er60GV5mIbToHUuP8KPbtIndGh3+XnMTxcMFC881BsLeBfkdY3skS?=
 =?us-ascii?Q?g/xUAZa+Su1N+5bllhKXj7G1ra1fXEQk08ja/tF3XKlWz1TY0noEVDYVNsVD?=
 =?us-ascii?Q?UAO+wluvfeifA1rH9Bch5z0HSQvW2iOvjB18g3JuUtaNbvevOt/s2e+YFWrP?=
 =?us-ascii?Q?UZgmpCCGsy3AG9MUhhnbzlMKSOGvnueuA7MOa5Vm1Wm9PGQR0yFNZR0DwOc3?=
 =?us-ascii?Q?iOSwTLExeKUArL0hCreMRe0hpg4KLypbJqLB77Q+Bafzoau+eGwU8gj8Epp3?=
 =?us-ascii?Q?8U9JD+jg2j3s2xgu6gPpbA3HfjsJ043vr2/AKVYizkQ0ukXoLHXWguEdMla1?=
 =?us-ascii?Q?Eir2N2/mJPNqAzmDgWz2BChjCaZq8dJq7Ld/K7QKE3r1JGX7gsvipUUmDFfk?=
 =?us-ascii?Q?1VH407xKy0mAJ7O43VxfzWnjF+DUWlJKC1v7u79INsTx5+UyWE83dpkjasTG?=
 =?us-ascii?Q?c0YwdWHKksN6Gm9777OPEFcenv39UtII0cBQuCWST6WI8mDmLf0OGmdWt8Ln?=
 =?us-ascii?Q?6WzJFKILrJCdp/+72nWJvoty/I7S5Q6w52TMfXGCScrvuUyqZ2lE3ZzEkNhq?=
 =?us-ascii?Q?sysOPahalisdaV763A2Mp7ajvuMC3Cr4Ly9FOnkaUXXNblam/7dIQGY5YxCN?=
 =?us-ascii?Q?ZRvTzcy4sU6oRHZXE4SE/ygw5JrkESArJ3zXdCHUyEH61ceWPbJQswdfyI3H?=
 =?us-ascii?Q?BNVpw0YGqKDQQh+Z4NoJ9Li0AvRky3ogRbd3QA6rvsn/rPzdHbzvfP8Vb3WK?=
 =?us-ascii?Q?XzcdRSX8BlIEouaaoPPIvEBNJ4aPW2MvjdsJ3EKxhG3Z3VsbI6Z+H6UKqRBg?=
 =?us-ascii?Q?2Z996cbpfIAZaI7e9DnLqo5ePYixcm8eGkHPD9fs4ldK2rLLe7IQ5JgjE0uo?=
 =?us-ascii?Q?eZ8Hm/RFjwRYL00HUsy1IkMxSqJvoEWRfKDXuPRM5Kw4PyyjhW6aHIi0vDRn?=
 =?us-ascii?Q?ZyJOXgGqtDf4PK5cCX2fKEK3xT+1G5fscK3+F/JD+Yfr6UFOjQH1GjHxeyhf?=
 =?us-ascii?Q?lBWwYnsdHsSQgZb/D98OBy10jNxtvOjRjghgtDStmMVAwdO71105b/feKmHV?=
 =?us-ascii?Q?gbHB6aZjBLeypmFrtQrOGx6WbTXNbwIHIc/bwxSoDUjQMmvx9js8RoMRRW0s?=
 =?us-ascii?Q?Lrdhm4Ds4twvqsjkQKlrMfZboiApbeU6Vb/PWiD02NaRvlJ5Ep5dlFU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08151f48-b007-446e-e4c9-08db36c06d8d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 17:00:30.5486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W+3pngm0sz6h8dy3/l0rZZfGlhzaa5N+hQcXF+sDVBWRSOGro4cyr+WEAZQ8fiBi2Qa12SG1/3l1IRpq1mjCiFu/gjhjcQVYf6qFLn+M+ys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5990
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_10,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304060151
X-Proofpoint-ORIG-GUID: twgPboQ4aVr2XG7lhfaHY2eItuwBZzyB
X-Proofpoint-GUID: twgPboQ4aVr2XG7lhfaHY2eItuwBZzyB
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Peter Zijlstra <peterz@infradead.org> writes:

> On Sun, Apr 02, 2023 at 10:22:33PM -0700, Ankur Arora wrote:
>> clear_contig_region() can be used to clear up to a huge-page (2MB/1GB)
>> chunk Allow preemption in the irqentry_exit path to make sure we don't
>> hold on to the CPU for an arbitrarily long period.
>>
>> Performance: vm-scalability/case-anon-w-seq-hugetlb mmaps an anonymous
>> hugetlb-2mb region, and then writes sequentially to the region, demand
>> faulting pages on the way.
>>
>> This test, with a CONFIG_VOLUNTARY config shows the effects of this
>> change: stime drops (~18% on Icelakex, ~5% on Milan), while the utime
>> goes up (~15% on Icelakex, ~13% on Milan.)
>>
>>   *Icelakex*                  mm/clear_huge_page   x86/clear_huge_page   change
>>   (mem=4GB/task, tasks=128)
>>
>>   stime                           293.02 +- .49%        239.39 +- .83%   -18.30%
>>   utime                           440.11 +- .28%        508.74 +- .60%   +15.59%
>>   wall-clock                        5.96 +- .33%          6.27 +-2.23%   + 5.20%
>>
>>
>>
>>   *Milan*                     mm/clear_huge_page   x86/clear_huge_page   change
>>   (mem=1GB/task, tasks=512)
>>
>>   stime                          490.95 +- 3.55%       466.90 +- 4.79%   - 4.89%
>>   utime                          276.43 +- 2.85%       311.97 +- 5.15%   +12.85%
>>   wall-clock                       3.74 +- 6.41%         3.58 +- 7.82%   - 4.27%
>>
>> The drop in stime is due to REP; STOS being more efficient for bigger
>> extents.  The increase in utime is due to cache effects of that change:
>> mm/clear_huge_page() clears page-at-a-time, while narrowing towards the
>> faulting page; while x86/clear_huge_page only optimizes for cache
>> locality in the local neighbourhood of the faulting address.
>>
>> This effect on utime is visible via the increased L1-dcache-load-misses
>> and LLC-load* and an increased backend boundedness for perf user-stat
>> --all-user on Icelakex. The effect is slight but given the heavy cache
>> pressure generated by the test, shows up in the drop in user IPC:
>>
>>     -  9,455,243,414,829      instructions                     #    2.75  insn per cycle              ( +- 14.14% )  (46.17%)
>>     -  2,367,920,864,112      L1-dcache-loads                  #    1.054 G/sec                       ( +- 14.14% )  (69.24%)
>>     -     42,075,182,813      L1-dcache-load-misses            #    2.96% of all L1-dcache accesses   ( +- 14.14% )  (69.24%)
>>     -         20,365,688      LLC-loads                        #    9.064 K/sec                       ( +- 13.98% )  (69.24%)
>>     -            890,382      LLC-load-misses                  #    7.18% of all LL-cache accesses    ( +- 14.91% )  (69.24%)
>>
>>     +  9,467,796,660,698      instructions                     #    2.37  insn per cycle              ( +- 14.14% )  (46.16%)
>>     +  2,369,973,307,561      L1-dcache-loads                  #    1.027 G/sec                       ( +- 14.14% )  (69.24%)
>>     +     42,155,621,201      L1-dcache-load-misses            #    2.96% of all L1-dcache accesses   ( +- 14.14% )  (69.24%)
>>     +         22,116,300      LLC-loads                        #    9.588 K/sec                       ( +- 14.20% )  (69.24%)
>>     +          1,355,607      LLC-load-misses                  #   10.29% of all LL-cache accesses    ( +- 15.49% )  (69.25%)
>>
>> Given the fact that the stime improves for all loads using this path,
>> while the utime drop is load dependent add this change.
>
> Either I really need sleep, or *NONE* of the above is actually relevant
> to what the patch below actually does!

Yeah, you are right about the relevance.

I wanted to provide two sets of stats: the raw memory BW stats and the
relevant vm-scalability workload. The vm-scalability workload needs a
more reasonable scheduling model than what's present until this patch
and so it seemed to make sense to put here for that reason.
But yeah it doesn't really fit here.

> The above talks about the glories of using large clears, while the patch
> allows reschedules which are about latency.

Yeah, let me find a more reasonable way to present these.

Ankur

>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>  arch/x86/mm/hugetlbpage.c | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/arch/x86/mm/hugetlbpage.c b/arch/x86/mm/hugetlbpage.c
>> index 4294b77c4f18..c8564b0552e5 100644
>> --- a/arch/x86/mm/hugetlbpage.c
>> +++ b/arch/x86/mm/hugetlbpage.c
>> @@ -158,7 +158,17 @@ hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>>  static void clear_contig_region(struct page *page, unsigned long vaddr,
>>  				unsigned int npages)
>>  {
>> +	might_sleep();
>> +
>> +	/*
>> +	 * We might be clearing a large region.
>> +	 * Allow rescheduling.
>> +	 */
>> +	allow_resched();
>>  	clear_user_pages(page_address(page), vaddr, page, npages);
>> +	disallow_resched();
>> +
>> +	cond_resched();
>>  }
>>
>>  void clear_huge_page(struct page *page,
>> --
>> 2.31.1
>>


--
ankur
