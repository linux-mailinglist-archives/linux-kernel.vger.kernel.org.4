Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CB5743F48
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 17:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbjF3P5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 11:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjF3P5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:57:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2163ABF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:57:10 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35UEmrRk020055;
        Fri, 30 Jun 2023 15:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=/4LKS0h/e0wLVsm5wIpnFLcFY8ZpfxuFPJB9DE/e9sQ=;
 b=SKGersZ9jLHaqCYbmI9OYBObDDROELZyj7n5iWRwoL9wAeDvikt7NB4BGbyppPinR5ZE
 cKNv/jyxhyNzht/uOO2c+P+h13QJ3E6/HFhBcaHiZM5+OIwJJTp0UGU4pz2e+5H1Wjsr
 WGK1yij6FULOpfZoD+TVEx3oT3gZu8+599OiBu9s7zhLPQVJsdtiUDndDF2HN3y2AfH9
 hgdGDaeq+e5LZUV6LSNgBikgN72QliItfJpX3KEPRiu/fYy3mhTXNIT6/wG296IFnZ0q
 znYbUBFf/NPw/QNa3TY64d22xZpkMphTzV6STqSHp2RsJguAZjSLF4IJjj4o224yS+ad 6w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdrhd1edq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jun 2023 15:56:17 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35UEjmIh029615;
        Fri, 30 Jun 2023 15:56:17 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx90x99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jun 2023 15:56:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kf8JKpU1qJ0BX9EMIFxn84GXfNGjJwl12/sGmhi7R0GqgYdQPkjSklPd1iwoOchWXtOffNqHFC35TYmMGHc0QL8LKztTmRbrRU5NeGH+SA9Z9aXkCD124timdvGD5s3Cy85SUdaBehT9NJDSmWK7cqHnADJmIdTGlB67zo/984yELOHJqyC1wGRaTYAZ9Fz+XgKWTfOElK7zalRux4RvQkmQpICC/3+pPEkNxviIHEUudOgivarnwIlKKFoc9F5jzUOIVX7X8cSwEpajEN3HOF7k95pECnFRLWeUvtWq/gh0ttVJjAOzMatHMd6Y03hNOoLMW4JEBH0ccGg1yjVO1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/4LKS0h/e0wLVsm5wIpnFLcFY8ZpfxuFPJB9DE/e9sQ=;
 b=fIRyjg3ZTHHP/c9bdz+ULB6WVfdYQtqjRGULEpPz550mUrXm5s/Q/RYsBtIRjEBEJAaC0+nREAC2ByC+PPWI+d1KQPpnLrZsw6XGififXNPZv3NJ93D+tPU74nUoIVEwyGE1xrLvByg24zTDVy2HFNaGQVjJsiI50ajgcIwzq1HtT7FGeL+nCdrKB873hvngzzCMQl/UKyscF8vULPWsO/CAIdeZTUW2kGJ3AeooWMRo5B1CPIWchffDn06Gj6RDs6BpozsfIpyDSGeUD3H9Z1qVDffNjObsTyiO2c0ZFOdi2TIwuXYikyJnkM1ODdi5UXPVsdf9/YcI+nYCU/WCfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/4LKS0h/e0wLVsm5wIpnFLcFY8ZpfxuFPJB9DE/e9sQ=;
 b=HeqXYv5t7Ou230JACL6pvSB8JMD9tSxxdjZKFCzasIIOFI2zFP25DRkKpQjyca3HBNLv+MzJ+PuxF9tD4CVhkGhe+Pc0FIVmr3inZ5gclCfXhZwwk/qtVb+iP80XGQpXcEfNK9WbPaZO12b17FxaNep/gzpWx1gEsCHuipKxo1c=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by SJ2PR10MB7653.namprd10.prod.outlook.com (2603:10b6:a03:542::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 30 Jun
 2023 15:56:13 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5%5]) with mapi id 15.20.6544.019; Fri, 30 Jun 2023
 15:56:12 +0000
Message-ID: <4cda8a4a-e9f6-9d8b-2246-0b3f2ef7900c@oracle.com>
Date:   Fri, 30 Jun 2023 11:56:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] mm: remove page_rmapping()
To:     Peng Zhang <zhangpeng362@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     willy@infradead.org, akpm@linux-foundation.org,
        wangkefeng.wang@huawei.com, sunnanyong@huawei.com
References: <20230630121310.165700-1-zhangpeng362@huawei.com>
 <20230630121310.165700-2-zhangpeng362@huawei.com>
Content-Language: en-US
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20230630121310.165700-2-zhangpeng362@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR12CA0019.namprd12.prod.outlook.com
 (2603:10b6:408:60::32) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|SJ2PR10MB7653:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a3d3f7c-35af-4ada-20ca-08db79828739
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cHhVb1aXH2P6173qcMKz6hptgzIrD/HUXROvPKSQq5RJrTYtjbmzjmVe6IjWHkhh1Y6xuVUc6U/KuUV53U4CaUx/KBBiL2QMylGeabsa0kYimABbbg3d7+Cfo/WvEa/bBuYbsQw+rJdPxPI5VMs/7J4T+rJqDbytdR3zQJThUeyvwS87ptKBsVVjM3EKU2JtgAUl8C+CTd1lpfEgdNF07gVQa550JW3Ib9APFx57t684oiHojh5MLFhCGXeetCr65q3myoNiNdOfkvcfpoZ/eNO1oLB4ucTb1zXkckfgARvObGKQ2rXTM5YoJAXHL7lWvP78gB7/YnZGcdZngEYhikI0QnT26J5nFJhEXdvbV2DYyGV5hcAdLIysGCTvjPdR+eF4Dh+7mv73jKasWGcAtcvMlV7fxR3GXVrZoqJc8ASMVD/GX5+Ig7eKLlGCwghvq7/cO2/jw44C5BONJvtbsYG6e+TE5zDtxUOKBBeI2l8SaBExCLORaHEpePRrHtdPOzgoNKYPDBzgjSo4QcwkuyRxwWRpIhcieYxVflBZ2/1+bpbd1e5WKZla23yDmzDfRc5G4PMoDiTiOZH2tjcA9RhnVB3NW273Q7w8eRoaRJsg4GmNDPczJOn73qSPNNY5YJpatf7s+Mss0/Y2eppD9w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(396003)(39860400002)(376002)(366004)(451199021)(31686004)(66946007)(316002)(44832011)(66556008)(66476007)(4326008)(478600001)(8936002)(36756003)(8676002)(5660300002)(6666004)(31696002)(86362001)(2906002)(41300700001)(6486002)(53546011)(186003)(6512007)(6506007)(83380400001)(38100700002)(26005)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bElMazIvY2ltdGYrVXZvZ21UYm5wQUl4bVRnWVNoTmpRMTh6ZzFzYUpCY2ZU?=
 =?utf-8?B?TzZvZ1lrNmszOTlMVDFFWmh2OXVsdkd4WDlUeTEwMDlFMUFuM0dqSnRhZU1n?=
 =?utf-8?B?akhhYW52VTloa2g4SnNJNlNPZHpmWmltY0RpMkNWRXBYTUNlb0ZsOUNLQVRi?=
 =?utf-8?B?K2JiRDZDd0FCQVdmVjUzL2RxL2hKelVNM0VBRHJMTENmblZEck9UcjN3V1J6?=
 =?utf-8?B?dGdxaytKSjZOTVZRSkNPQmxVM2hJdUpubGJ0OTFYUVcvMWhEQTA0MWI1UFE0?=
 =?utf-8?B?WEJYRmNpaEFTcUNHVkNCSWpaTUxrV1BMSEpDbmpHNG93YlpSRU5ST3poNFYz?=
 =?utf-8?B?cjRpWTlUZFdtbTdNMDlESDdsUUpLeWU3UTJiN2Y5SXBGelJDeE9ScGRwa2E3?=
 =?utf-8?B?YU1oM3cva1VPUzZKZDFMR0VuV2R6MDNtZ1c4cnVsUS9jbkh6aWtnbXlGdXQz?=
 =?utf-8?B?dkNtVlFaSFZNbm0yd3M0Yk9zQStFcWV2Uyt0QjdrVnFSL3V4em9FZ2hLZ2t4?=
 =?utf-8?B?WWlqOW1uM0V0b3orbW55WjNhMmVpWHYyVGpicmZrOGMwRlhkN2hDcXFsZUti?=
 =?utf-8?B?b1BEbzRFNVNXRW5DMXk3TlBXY1Z4bHlId3FxMGFyUzlxZGttajUzZDFReWdN?=
 =?utf-8?B?Z2NnNVdrYkk5eHR2YVBjOXhyN2VHakZ4Q1R1bWNsQWdDTWllQkplQ3VRbXZR?=
 =?utf-8?B?RkNxTG9PTVFWWENwbWtGSmM5OUhZSVI4a21YLytzem9SNTBIaUlDN05RQ21i?=
 =?utf-8?B?Y0JicG5maGx0aE1qbkVHVlJjUGV6cEc1cCs1Vi9SdnVoY1VGZU94dDk2a0J6?=
 =?utf-8?B?ajVUSUFlZlpKelpFdWszK1U1bzJ2QXlzS21IWmxwUjFoRUp3L1l2d2JWU0FD?=
 =?utf-8?B?OUNGL1F1alhDNnA0bnY2aVlNbkh6amJZSnBObkdRNWI1ZHFHS1BHaXVLNUll?=
 =?utf-8?B?VUM5dHZOSitJN1dWY2Z0NUh5alVDQW93eEpTZ1hDM2liQU45OGZKRlo1allU?=
 =?utf-8?B?Nzk5QXpBczJuSmFEOU5wYTRCcjllRVVkck16UXZNaXlsWW9qV2VEV1hxL2pQ?=
 =?utf-8?B?bUN2R0x6U045Z0NlU2RoRTQ5SkNpRmxzNDRoQ2lxTDJhTWZ3UTRnckdrbEVm?=
 =?utf-8?B?TUhFUnFPSjZwOVBIZDlSVWduSkVmV2c0bGtaa3hUbTlZcU1hcm5JYlpFK2xC?=
 =?utf-8?B?TkVGS2RVbW1XUG5jN00xanI4TEJkQXFZL244L0NMSFZmS211MXV6ZkZ1bjdB?=
 =?utf-8?B?aHVxbUR6UE0rZndZay9aeDdwcHhnK2xpdDlFaHlwMEV0a2xuLzBqRlNWRkVL?=
 =?utf-8?B?Z2VsYlBZNDZmbnRxMHBEa3NpaVVyMlpuMXRCNWs4ZHhSZnFOeUJLUUVObEk1?=
 =?utf-8?B?UnlDS2hMVE1yUGsrcjRLY0RXOUdDTnd5QmdockFGSytMTGRZN095SDVtcHk5?=
 =?utf-8?B?b1FoaHU3K1hVQ2hIRjUzS0VOUk5RMDJBOThRNFkwZkxubnp5bWZYSEp0VFUy?=
 =?utf-8?B?ZHlYVW80R01wc25JQzZ6TysvVDVmWnJaU0Y5WXdrMUFHZzVvMEU1MmhleFRn?=
 =?utf-8?B?UlA2Qm9Pem94R1pFOXBqdURBYzVKZFcydlo3YThZOVFBbWNwOEljL3V3RS9G?=
 =?utf-8?B?RnlQUjdjY3c5NVF2d2FzS2drb21CQUp3dHRnKzVRbW1pcjNlclNMTWtlYUxo?=
 =?utf-8?B?ZWY4M1ZwNEVWNXErb3UyWmJyS3ZIK1J3VzhyL3pCYnJsZEcwM2c4VkdVc29m?=
 =?utf-8?B?ZjQ5NWlHMVZUd1ltanpPU0UxbFBhWThvQVlBSmJlMmJ5WEQxTHhsenQ1RWJO?=
 =?utf-8?B?NmxyNEY0TGNFTTJ1dzlDdzdDc3JVSGErbUw2dXFXckhOeTlRbWZWOWNRSDN2?=
 =?utf-8?B?bzh6UktES2V3UmJyN2wxWFphZ2hMeWJJTWtQcUFkZHVXZWdxZkdLenluWlN1?=
 =?utf-8?B?M2JHdkpuYk1laUZ4Q0x5SVJlVjdlVWUyaTR3TFk1NkhDY25XUW5sY0hBVDlh?=
 =?utf-8?B?R2Jna2FQd3BSWWVaOCt3WXVuaGJDNDBCa2dLcHJkQTZLOGxHN2tvb2xoTTFm?=
 =?utf-8?B?YnBxWUpkaXpqaFl5d0Y3dTJ6S2ptbFpBRi9UTkR3RHJjVjhvN3h4eVBZYklo?=
 =?utf-8?B?U0NWVENJYmwrdHBOekVoYXlpUXFHWDgrMTdqNWV2SENOMUVVbTFhbEs2cWtu?=
 =?utf-8?B?MHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: P0vvWrGqoPwBfDOY0xTSIblAw3pgVm7yZStUkUbWoHqdpT6YD6TnHESnybpcANbecq+ndTIsAyBYLA5aEZLBrglh6DGQE0YS/zzXAvyIjd7gjCC4H45qFeoj1rizJ6bJqVla3eA/ZX4TA8L8nDb+64UI4pRzQEXutFsAUec2EPiJBDMRj5al68q0/hOblyGjwK3LWVgC6NVFhCSLyn3M137L2JAymngCTAllcCXnkbYjIHVNQO9Y9gjphI5YwTLXHwWgRuh+Fcn811eYnwdiZVfX7M91nAcc6BEOqAhfCVZ4LKEdpG6qA5Ca1HQ6rMFSSFRl9UZgujVWn9iHQ8JWltyrpqECIw4bhHZ+T6T7FsS55J/kaBrfTgT3jknYw3s9Pb9PBQ6/JPgkqdhvfmVZkbd1L4AQnUVkuRzzCFxBOPZVqMnTxxt5FbuAD1aJZbLvBP289miWSiFht4Bg2+za4NSN1sR6lald1+fHSZPMw3pAGXO3dbQ+hcz0I5ehSafBswgWI4zKJEYWLbbFZ2inf5QADlPCloIy60TZTvoKGG9+RZfttFZWWuXP8rU3VhC081R9sT+42O1BDw7nbd8KEV2vO9nN1Y9pOd3cTjiaf+dtxshOKaZ46ROIWPk0LowAV1YpMKtjZPyP/EqHzT1Hv58a42UXw+2Yo27L1FOtTuY/S7S3KDGk1LQhLK2jI+ikUox5o3d6t02Aj3UyIaeP2SC4VJg+2vcIPTb/xZYt2yXDl6uF8/E0Gy3i4jka9zbZaLeAVBZEPDFMdGlosQJJxhEbrADL24NyY9yZi4O+h/DrV+wGk8LnEwFW3oalwLeDyv+PjAzNii8HDfsQbQJmcVryYbQQpsxDi3laDNTHkx8L/+JRpWO0lyuNhlpK86QWBo46FFYUaEjpcj0K4zSZyvhyHBGX5RjoLrAjbgfeCjc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a3d3f7c-35af-4ada-20ca-08db79828739
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 15:56:12.6583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tXQ03bE4wdf+oUv2ZGQ0+feejiEAIXUL93HhspUb5FH1JtDE8EB94Fr56AvTHRIMQYlKSsDxYkhkP1ZzCqxKWl89BHTQTz7ulCmy2sSeRU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7653
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_08,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300136
X-Proofpoint-GUID: sNNJlNegysbuvrzbVSI-oZ_X-PtRltwL
X-Proofpoint-ORIG-GUID: sNNJlNegysbuvrzbVSI-oZ_X-PtRltwL
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/23 5:13 AM, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> After converting the last user to folio_raw_mapping(), we can safely
> remove the function.
> 
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> ---
>   include/linux/mm.h | 1 -
>   mm/memory.c        | 2 +-
>   mm/util.c          | 6 ------
>   3 files changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 9ecb8b9c07f6..8c7eba7370b2 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2129,7 +2129,6 @@ static inline void *folio_address(const struct folio *folio)
>   	return page_address(&folio->page);
>   }
>   
> -extern void *page_rmapping(struct page *page);
>   extern pgoff_t __page_file_index(struct page *page);
>   
>   /*
> diff --git a/mm/memory.c b/mm/memory.c
> index 21fab2727209..6921df44a99f 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2979,7 +2979,7 @@ static vm_fault_t fault_dirty_shared_page(struct vm_fault *vmf)
>   	 * pinned by vma->vm_file's reference.  We rely on unlock_page()'s
>   	 * release semantics to prevent the compiler from undoing this copying.
>   	 */
> -	mapping = page_rmapping(page);
> +	mapping = folio_raw_mapping(page_folio(page));
>   	unlock_page(page);
>   
>   	if (!page_mkwrite)
> diff --git a/mm/util.c b/mm/util.c
> index dd12b9531ac4..5e9305189c3f 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -734,12 +734,6 @@ void *vcalloc(size_t n, size_t size)
>   }
>   EXPORT_SYMBOL(vcalloc);
>   
> -/* Neutral page->mapping pointer to address_space or anon_vma or other */
> -void *page_rmapping(struct page *page)
> -{
> -	return folio_raw_mapping(page_folio(page));
> -}
> -
>   struct anon_vma *folio_anon_vma(struct folio *folio)
>   {
>   	unsigned long mapping = (unsigned long)folio->mapping;
Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
