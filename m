Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C85662B5A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbjAIQhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjAIQh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:37:28 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C261580D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 08:37:27 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309FotWi032055;
        Mon, 9 Jan 2023 16:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=rrPMm4kRbHh9BhNP/kZJEn2rSlgGEGQwfWz6LCIiNs4=;
 b=rQ1csUN8nQ6hDZAOlO2ZHpl8WN3rjk3DUn4UhgqCMLahytea/5yp1lFC/4w1Y92/4Lwh
 Q1R80ipn6IMp+ZZG21ZmcyE4m1ormfk7pAr2T7MF+iIxPnbcEBU3JEvqme1CkxGKL837
 ksNeGh9X5axj5RsjueF/l6txKSpPqHQYsJ1Y+6Zg9Iwa83QqXvqYseI3tEQd3h0Y0oEC
 Qw2IH6GpzDC5xC5HC0IqvNTxmzoV91fNse9h1wd8UBtYHrg+bz4Ja8owcbZm0SmM2eHb
 ibXpAX5nOAKGDtgA9eBGmoJn/hZgxKzqTiHC+k9pS2+BYpHZiGCL2CmFTQWHCXa1+AYM sQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mxyh3k37s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 16:36:50 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 309FX6tH002352;
        Mon, 9 Jan 2023 16:36:50 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mxy6480q4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 16:36:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RT6StfN5vdgVsJlD8GaafjrCDxn1AN19LYD+QUZA7PSTSgCwjagfgY6ob9pNZtOnh7WbKQLoSyPAWo62EHU1n3zHV4yBdvTGhYarEPHOtJXucrag2zT1dnSdHr+9dt3Pc5Ng2YiclEWUGzbfSvj3cuTzRUthYAX9KoQBrCQk5/EKz2MgJ/4CCUYToA3lvO8eHipBlWTKh9sNzIBNCeUAkoGch85Aci0Ru/Fjp87W/oFM6jpo1tNLJ2GTmDc9lYY7Dt9e2LjwTQD3muEyOX/VnuD/BSJxA4Z5yaGkN8IMpBVEZu67rjw/t6eL5gJSNNdAqqqOaBysIyHqpmAI6gKXPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrPMm4kRbHh9BhNP/kZJEn2rSlgGEGQwfWz6LCIiNs4=;
 b=Qnp5cRObB8j+W25AJaq0YxIyrrHa1IhzRf/78IpOk0fmSTUKW6UqsH9UdK0NC4+BfT0KCSCWNkZFgz3C+NvX9frgIGDm2cuTyLqsAmniiwVGhtvH4IjsogUX5eoL83zyAgLTQy1V3ew4mLpfkhTeZkIEKXUyRvIyYR04bVhJbfwjgpHSPyxTx0iowlLU9/NAwSpcB05azY46k7OE/SHS2kIYzkQCoB17BGIXRckO02NA5svCbYXzsJcHBisqhW+BMsHWrb6xlsQWEa2v0AFuE0du9/h9grx7byiQ9HmRkQG54+mjuO//hayyHJmRwaXbSv819cN5SfFgD1bUxxGKEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrPMm4kRbHh9BhNP/kZJEn2rSlgGEGQwfWz6LCIiNs4=;
 b=rwsE400K2GBpz+kO0x0F2bQN+u2ypji/iX2A59/JK7dvLhiikrKX0szP9S1HqLHBHjHNpgWkhwKO143+CJCeoWHbvRzAoDDJDjkVWM6YYbMHHXp5pmaF127xsXoLd/RYPdUkVWXT70x/jb9OUo4jIILnVTRjnHIuEe69KuwzmQk=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by IA1PR10MB6122.namprd10.prod.outlook.com (2603:10b6:208:3aa::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Mon, 9 Jan
 2023 16:36:46 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.009; Mon, 9 Jan 2023
 16:36:46 +0000
Message-ID: <0b711878-71b0-4a4b-4f0b-af157d6cac42@oracle.com>
Date:   Mon, 9 Jan 2023 10:36:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH mm-unstable 8/8] mm/hugetlb: convert demote_free_huge_page
 to folios
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        tsahu@linux.ibm.com, jhubbard@nvidia.com
References: <20230103191340.116536-1-sidhartha.kumar@oracle.com>
 <20230103191340.116536-9-sidhartha.kumar@oracle.com>
 <Y7jGyH9Atv3sPjcZ@monkey> <Y7jLVJ9kvBFCUhNd@casper.infradead.org>
 <Y7ncSXYzCmjzmS87@monkey>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <Y7ncSXYzCmjzmS87@monkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:610:b1::26) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|IA1PR10MB6122:EE_
X-MS-Office365-Filtering-Correlation-Id: a628666e-e80d-4d63-3745-08daf25fb2ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MdmOiGbiVHsW+VwQiBXFJqA2TotD0W8o0Ubo6EQnpE3+ZGVpT0n0567ofSmugJJGorRcaCKrpTDWlMXC9lo8bi0AGOAcF+XLufd4CQhtaLr8H+qXVTVOPYj8ugfnynTXWG6kkbO+TMrhldj37dJFbmTMeWdwUCfgJ1ayOQah1CuF6BP8l7FykWT+fienc89cYyc+Ws9F5KnQ9Z9jSkTpUexOTDIbx/4vKDaYGJLku85rlqAZqDG8s7MawK4LfA/kxwnJrYFsML8v2bNboeYNj+kTWoKaAqsKH5M2ejzJHJLWvxw+XfJAO2InI1ytL+NB1/KJZpVqEwlu0G/PKvCoXhtEhgB0wOr52HEyzFdKmdcXu88bkzTRjHVrXL8f4v01Sw+NBA0qoTqVGwZZ/yYyTp3LcFqB6lVSf1cw7eYVupXngZ7KasBOgqZmsvu4OyzHLCk1RzNIrfN+njBMjg7dkOclYlOz06OlhEMup11jGX/6haoa88JQe6Fu3d/e5XmyqCnsy/iHx07UgCpVmFe3K6gWPozKpFLZs7+RXzOHuCNH+08zsCYCMw+Xcg5c55VB8Un0oSyXCsdBHNuOWaSya98Azz0Cg2hYyLkj+jL04Ihlz/hLPimhHZ5fTLJBhCqW0qHLhNO1yds9p5qoQr6HEiuL8LY9lpK+bjTSvNSGxFtecRd6SRThui380EIzqWpi+lj7Eg3oDOiSg+wtPA9B0Wm58KWqFOqH5Qn0D6UGUI3PwmNbRu2e3xvXiM06/oo3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(136003)(376002)(39860400002)(346002)(451199015)(31696002)(86362001)(478600001)(83380400001)(38100700002)(44832011)(41300700001)(8936002)(5660300002)(6486002)(66476007)(2616005)(6512007)(66946007)(6506007)(8676002)(316002)(66556008)(4326008)(186003)(26005)(110136005)(53546011)(31686004)(2906002)(36756003)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDFRYjdGOU41amQ1M2VmbktvTTR4SktHV1J3L0wvdGdnK2R1aFo3MC9HWEF4?=
 =?utf-8?B?ai93OTduL0ZZQ21YVHBQU1QzaU16aUhvWjg2NUF1dnZ5c3ErU1FwMXJ3dU83?=
 =?utf-8?B?RldFZ1ZtODdzVDRuSno3ZFJlOTNzK2lJRzhsUGloenMwUlRISXVnQXg1c0I2?=
 =?utf-8?B?TCtBV1Rpdm1zK2NmdllYRG1ybXJOOTlJSHRVZGFCaDEveEY3QW1ZbDEvNDZv?=
 =?utf-8?B?MW0xb09DVUR5Tkd1UmhOUkoxT0EzZjk0blNxUFN2WFBVTE5od2paM200T0dk?=
 =?utf-8?B?QmRCaktHbWFqRHoxcmxUdjBtNjlBWTNJWGVabFlWRldkeFJMSE9ldmNFcWR0?=
 =?utf-8?B?N3QyNmlQdjEzc2ptUE5xNVcybDJIbXA0Tyt5YjVhUFdGOTlUeUlwY2djR25Z?=
 =?utf-8?B?cndJbGl1RnZ6Wng5SkRkUURiRDJLKy9taW05aXhJOTZ5RnVvTnBuRXZTaFJY?=
 =?utf-8?B?ZlBGWEZQbnJWbWtKdlVzOVhHY3JWaG9aVUszdzA5eG0xQ3JkT1JOSCs1WUJG?=
 =?utf-8?B?bkJ6YXRQOCtveWRJUjVzY0xaRnR6TkNMQWpESTlWTEdlQ2ZoN2hvTnZiY1Ny?=
 =?utf-8?B?R0xOR1owKzNFWXBwajdmcCtaL0h2MmIwNTdSbThJZ3lGOEZMWGNqNGNMcjZV?=
 =?utf-8?B?OHlYbzJ2dEdSMFB0NXdocnhUNnQ0SWhPV0FlSWpWS1BkdTJPdzgyUTNIN2Fw?=
 =?utf-8?B?YjlVcmxKZlpLRUZEOEVOZm14YTlNTlF6YnN6ZjE2TWZaYWdybzlPYXlDbDhZ?=
 =?utf-8?B?aHg2eG1OUS9lckJ2TEdIU1hydC9HOFVxN3U5MnVBaW5XTEpua0RtWmJQaFlV?=
 =?utf-8?B?ZDRhRjhQVjZ0cVpvUzNMMHhKYUtlakpBQklBWjYzWkxDOHRXYWR1cUlXVDZL?=
 =?utf-8?B?NThyM3B3S2phc2lMdnhyQzBETEZmZnpmajQzbkJXcGVNNStHQi90YlRkVHN4?=
 =?utf-8?B?SXFQaFBrbUY4dkJINmdEM3NJWHlCZS9SdWV2Y1l1eEkyem5oYnpQWGJ2MVJ3?=
 =?utf-8?B?dHdoTlNpM1hvY0VkNzlVQkVQVkZvN3l1UjRuNDdtQTZJai92TUNEY0JJbmNM?=
 =?utf-8?B?N2FkSTFqa1lYQmRMbWJEa1o5dW5TYVR0Ylphb0h3VDJzMmdTWlo1MXRDcDZu?=
 =?utf-8?B?WlJ2WFZpVmpGVW5rNjNjSG1ZSWNXUVJGdDlZTlNreHh5VlkxNkdzTm11UFF5?=
 =?utf-8?B?Sm1nWHpIaGNOQW9PL0lqazMwTThoRFFXWGdkVW1pWmNUaU9QSUlNckRsMW1D?=
 =?utf-8?B?UjhFUzJXRUJ2djVsLytoMERHbTBsVkhDckgvamlkalFzd3dROUo3TzRCWkFR?=
 =?utf-8?B?YVI0cmdJUTB1UjE0MURlQW1SeHphdVRUbU4vN3dzQkpZbHZ4UFlmTVlKKzgr?=
 =?utf-8?B?RHFxQ1ZORmp2QnRNV2dTOHVvRUtpS0lvbmQzdE5Ib2NtZ2JISzFWVktUOHVL?=
 =?utf-8?B?QzA3eUpGa1pVMlV3SGM5cVZaM3phbHdNSXFQK291emRsQlJCN1pObCtUMUxU?=
 =?utf-8?B?M2htdFJtSVRicStBZmtJM1hWUWVWaTFrZVlsZjNKVzZlaWs1UEkxaElhaXNZ?=
 =?utf-8?B?VXBRaUpiU1ljbnB0aCttc21oSG50eVlCT0tKd1ZwMmVQNlBNYlVHbWdaeHJy?=
 =?utf-8?B?c3VMOEhFN2xGelo4Y1VBMWhOZnYwYzJidXU2UnE5LzZZMzlldzJJZDdZK2V5?=
 =?utf-8?B?cjRaSEdTRHhPcVRKcTBXeWJ1R29kVm1QRGpFclNiZitZanlHaGtzNnNLdVhF?=
 =?utf-8?B?clJOUEJDM3JVSDJGb1hKbTd4Tmg4bUtqcUhGcFZYY1B1RzZHbjMyeEtDV1BN?=
 =?utf-8?B?UVdVNWdkNVd1ancxVlZ6NlEwa0RnK1RrbUI3SUttdUxKVXErbGhHT2VVUXlI?=
 =?utf-8?B?OFduUHUrZ0xYdkl4T0IxZnUzMlRWMjBHMjFaRzZEejlxL1A3YXhGbXcwemZj?=
 =?utf-8?B?L3BmUG5EZVA5WVVuZTlLRnIrN1BRUnd0eDB5RzlXVVlDYjhVcVRSK3B4WEtl?=
 =?utf-8?B?c0tGS2NjV2FIZi93TzUrNmZ6SlBmdnI1b1J6cSt5Z0VycTRTY0ZTeWZDMkxV?=
 =?utf-8?B?aklza0RTY3AzMXIxa0cvckdSaWQrUjdRSHBlU2dUU0RvSTZaeGdVZDRMblEy?=
 =?utf-8?B?TlBCdWpuSVdRQm5LTHduV0M5VGNEdTYxdTBRYmhReXQ3NE1uMWMwZDd3UmZK?=
 =?utf-8?B?N1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?UmlORWpmUUZVc3h1Y1paaHZhWW9hZG50QVkvUndrdFQyVGlUenp0c3NIL1RY?=
 =?utf-8?B?cVNtMjNDVEJmTjZLNlplbHVGZmZYVnlFWk50MDNBVkZhQzdsSzV1UFE5WkZJ?=
 =?utf-8?B?WS9qbTBNTW44OS9iWVJuZnd1ZFV0aDlIWEE4dG5aOVZiTCs3TDZ4VmhidmlD?=
 =?utf-8?B?a2pXOGhOcUVkZllRc0lQanZmY1BTNFBXZHJEZDZodjBRdTRSQXZ2a2JVTUk1?=
 =?utf-8?B?RFoyRDA2bWw4bm12b25uYlBjRmlvYjlRMVlIWWMraTQwVEVnOHErMHRiUytT?=
 =?utf-8?B?RTd4Znl1TjI2cktMeWRKL0FDTnJtNmowRE1JdFZJTDJCOXFtaGIyS3dpc3Bw?=
 =?utf-8?B?MHM2TFpDRitBL2NzRUNPcFl6Y3Yyc0VXbzViSkV0U0dNNUhFYzhjWFNtOG8x?=
 =?utf-8?B?Yk55QW0zR29ROFU1MXFQMm5UNjlYNjVHanNwZUVUSEIzT2hOQ0lDVS9YWVlh?=
 =?utf-8?B?OHZqWjhsbzc2MWdvRG9UeStTSGszbG5hdUN3Tmc5bk9lOTY3U2Z2dEZPMmpx?=
 =?utf-8?B?RHBSckY3clBNQ3YxejJGUytxZnJ5WmU5dDlsSTNjNTVuYlhIN2Q1RnQ4MWNu?=
 =?utf-8?B?UHYxczRaa3lCNFExK0tXZ3M2azZXS2xlL2Q4Z252RlNaVkk1YnkvRVpSb1Iw?=
 =?utf-8?B?dXBtK0crYUNOUzdLQzFXN3ZKS0pDdTJtemVsTnVNT29UTzF3OE1JYU1vQys1?=
 =?utf-8?B?VkVzQmJTYy9RdW5GdzBBcnk4bldwUGtZVFE5V09rTEpZVThZU0tLOTZPb2o1?=
 =?utf-8?B?dWRIdnIxV2hpSGl2ZDIxQjBzSGM5K1FMMmd5T0REUlJwSVR1SWplcEpybXIx?=
 =?utf-8?B?TTNIaVV6Qm9qckNVdGppbitqZ29ldjVnS1NLZGRRbjNCbkhPQ2tCRW5ENHBo?=
 =?utf-8?B?TEtRcllFSVdjYWdrV3YwVmNxSjJFbHU5c0VHV0hCUnRuTHFVRGtoY2JIRHkw?=
 =?utf-8?B?RStpeEtxVzJveS9SeUp2a01ZRWJBYU8xNW1HUW1sU3BPNjlydC9odkdQbE5q?=
 =?utf-8?B?UmRxRkZ1YTNoRUZKRTdRM1JnMUNLT1ExNVIwcmI1a0VQb3dBeDBFSmhBMXZZ?=
 =?utf-8?B?ZFdUbnZhNzZkRkgvY1ZiVmJoMkM0T29FcUt3dDJkMDViSWlwTlY3bEdiTjJ1?=
 =?utf-8?B?bVc4NGFKYUMyWHRyWlcyenRodUptMnQzdi8yL2tQWlRRN3gwZU9FU0ZocTVl?=
 =?utf-8?B?N0IzZzR1V1NlRVI4ZWUvYlpnc0RkSDZjN2lwOFpsUlBCb2RKMUYySG9iVWU5?=
 =?utf-8?B?K0lndkRqTlNyUFdFT0xtd2RYckQxQnVkY3hsZlZYN09zNkVXMkh2OEVzTDdX?=
 =?utf-8?Q?bNCVrdGHYjVbo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a628666e-e80d-4d63-3745-08daf25fb2ad
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 16:36:46.4387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jMmGXYFI7AGAoajYmr/lLmY8JtmlultG0uTDeR/TlFoFiAvPyhHhI77HOMirS2ennVcp7sS2yTkhm99s8WaGsafK1ijAwf7YKRAZk+J//Jk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6122
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_10,2023-01-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090119
X-Proofpoint-GUID: RS0Nr8LZ_q5GIsHEbKl_Wca0Ny04ONQW
X-Proofpoint-ORIG-GUID: RS0Nr8LZ_q5GIsHEbKl_Wca0Ny04ONQW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/7/23 2:55 PM, Mike Kravetz wrote:
> On 01/07/23 01:31, Matthew Wilcox wrote:
>> On Fri, Jan 06, 2023 at 05:11:36PM -0800, Mike Kravetz wrote:
>>> On 01/03/23 13:13, Sidhartha Kumar wrote:
>>>> @@ -3477,15 +3477,15 @@ static int demote_free_huge_page(struct hstate *h, struct page *page)
>>>>   	mutex_lock(&target_hstate->resize_lock);
>>>>   	for (i = 0; i < pages_per_huge_page(h);
>>>>   				i += pages_per_huge_page(target_hstate)) {
>>>> -		subpage = nth_page(page, i);
>>>> -		folio = page_folio(subpage);
>>>> +		subpage = folio_page(folio, i);
>>>> +		subfolio = page_folio(subpage);
>>>
>>> No problems with the code, but I am not in love with the name subfolio.
>>> I know it is patterned after 'subpage'.  For better or worse, the term
>>> subpage is used throughout the kernel.  This would be the first usage of
>>> the term 'subfolio'.
>>>
>>> Matthew do you have any comments on the naming?  It is local to hugetlb,
>>> but I would hate to see use of the term subfolio based on its introduction
>>> here.
>>
>> I'm really not a fan of it either.  I intended to dive into this patch
>> and understand the function it's modifying, in the hopes of suggesting
>> a better name and/or method.
> 
> At a high level, this routine is splitting a very large folio (1G for
> example) into multiple large folios of a smaller size (512 2M folios for
> example).  The loop is iterating through the very large folio at
> increments of the smaller large folio.  subfolio (previously subpage) is
> used to point to the smaller large folio within the loop.
> 
If folio does not need to be part of the variable name, how about 
something like 'demote_target'? The prep call inside the loop would then 
look like:

prep_new_hugetlb_folio(target_hstate, demote_target, nid);

so it is still clear that demote_target is a folio. A more concise 
version could also be 'demote_dst' but that seems more ambiguous than 
target.

Thanks,
Sidhartha Kumar
