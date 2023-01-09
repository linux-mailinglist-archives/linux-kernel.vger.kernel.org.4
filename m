Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB418663220
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237756AbjAIVAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237754AbjAIU7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:59:42 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65439027B
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 12:55:43 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309KjIjF000782;
        Mon, 9 Jan 2023 20:54:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=dVbmwSGltLxbzOCV4iRJ6+iOVHVtB0omcfRlhJV0clk=;
 b=efDsDtxF5rLIVo6vUenXFAqT7mIl6SXHQ2zasblSDeAkNWtY6xyiiZFkNZQ+DAPSFqEB
 uxt36tpyIzTE6GcfphZ2wxefIL29w2tiXCV9pIlQIlh3z4hVm5s8CQ0EfHMOQvKbLP0A
 WGx7DjqV3YwIYabicJnbX53L07arZo+FQivTsYZHsFIS+BcPX+sbLkuI3zsyFZLF0oO7
 tZFJXukTNGBT+MlKGmIpYMATmL7SzQdi04e9WCbvv8fnJIC1WX51JoVarbhVLPJa7EcQ
 Wyd864qR7xPtl2AVLgz2SfuvyXuSez4551E7ML0a7yBkEGt3sAH8ku+/OIHzbPar2F4M rw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mxyh3krfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 20:54:00 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 309KWlSQ004434;
        Mon, 9 Jan 2023 20:53:59 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3mxy6ahs58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 20:53:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgmbWfzlzzE8BBibIYRarHPPynwkWC3tQVJzSjwBk1zZ/Ho7l+puYbAPp57agfw3uKVhc9H708GPA1jAg+j+h7/uTGrPK8a/CDb5oB94z3ellYqP6BEPtBa1EeDedm9klxfsrfbOtmW7SlfxvEaaISEZ1dLJNV253vC8X+dinLs5iew+gJpzUEJfBcFWrB96cwONE2FuFjaNfa6MOLy3Tc/0LT7ryVM9jCsojdVRe2Y0Xujw2dOk6+D4XVZS/4Dd3IZKZXdwZIS6ipcGrhbQI7vrtntLeZdDNefE6V/LeWpbEi3QfbZZwUi7fnNHbPVrZfOpiXg804Apiz0JddP7QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVbmwSGltLxbzOCV4iRJ6+iOVHVtB0omcfRlhJV0clk=;
 b=iMc9IRG1wKwrLo08d8EPqIJ6ZH5IyqixTs/tyENh223uaWvB8y7yeIFC8SHl6URmDE4GUFpd57hlHg3AmYoJchatNY4MmgQeFe0HjB3Zv+zkAqSjYwUxKe+XaTdG/qzv+3fyy+Zk/M9h44PmGxC0SQHHgI7MbSlbiG6G+JEXq4Q57NIKEhAOlFlXcyNOnlenFNWDn290Fb8R7N5++OpcjVw0MKKwIVcvhT1GY6sUY8EvfnSkfZt1dF/qZJhEhOibDWdTI51dIosbkWGgTpulX85KiEIRqxfgX28uMkHPiOXkpvD6q15ZiC+0qVJSY0CFFagbSwrTyJiQEzjxtc8WfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVbmwSGltLxbzOCV4iRJ6+iOVHVtB0omcfRlhJV0clk=;
 b=k+frdn2aZyr0vipuo2UQ1wwUVyY6BSRpvNiUQeGgDuc0bbIrKHYl7yORfuw/hJYEoe4UEvJh0uPaAR9jYZzrpRSfW305Z6jJiBJsi5Ka8R0kToznzrcvAooxryo40xXNQ9jIdSh8Gq1JqosFNfcX7+oe8VwuTeuKw/88mRvkae4=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by CY8PR10MB6827.namprd10.prod.outlook.com (2603:10b6:930:9e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.9; Mon, 9 Jan
 2023 20:53:56 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.009; Mon, 9 Jan 2023
 20:53:56 +0000
Message-ID: <2c593f0b-5a29-2743-9d1d-313cf8bf6d85@oracle.com>
Date:   Mon, 9 Jan 2023 14:53:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH mm-unstable 8/8] mm/hugetlb: convert demote_free_huge_page
 to folios
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        songmuchun@bytedance.com, tsahu@linux.ibm.com
References: <20230103191340.116536-1-sidhartha.kumar@oracle.com>
 <20230103191340.116536-9-sidhartha.kumar@oracle.com>
 <Y7jGyH9Atv3sPjcZ@monkey> <Y7jLVJ9kvBFCUhNd@casper.infradead.org>
 <Y7ncSXYzCmjzmS87@monkey> <0b711878-71b0-4a4b-4f0b-af157d6cac42@oracle.com>
 <Y7xbsnYSM687X8pF@monkey> <153c451a-029f-ef03-7a57-7ff0394ac3d8@nvidia.com>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <153c451a-029f-ef03-7a57-7ff0394ac3d8@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0180.namprd03.prod.outlook.com
 (2603:10b6:a03:338::35) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|CY8PR10MB6827:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f474e88-f151-442a-4df2-08daf2839fab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o05ONQ0DuB15B/F2/qWC3IQ3BJt0mB5OIlPcO3bUmucL4iiPdAZ3Kqh42rEr1zxwNx9rm3SnvBX6JNquZnFsFEBFmZgWJVB456le8u/2EZmStjhXza6GRBatV0Uf0h+nwdfGpMBKvghxy6Ls8E5pjTeiKCfhmPG0QmDaPpsrldhWAlCc6M/L1u3LwTK/0pxeV0c+eYS47gU5I+SddFxa/04i62gIb6k9vQCdcVMrs/vP23nZ/kcBoo99yEMKOGkTft5MzLsFcnxciZCoqWozEsZlgQOP6fcD92ByIpHUmXpqiuw5GZLB2/7OOO2o2oQ1jVTmba7hcmO+xHK6nXJz49u0Jmi7QjKfmNmAUlv/bXlJtZshS+DRFi0SXbf/mxkFtJEUqoLAVCSqSjSm32u6OsFaY7FzHk4ZPBx1kOF6OIWPisLnCM1uS7sTKlJPdx5kQEA259laKXY/MeF8SBnbXXoJTjFgfMaSqloNBIMY7oJ1iYycHxnCMM3lwZBiIfoFsStFuedV7uWJyfNMjH2R9UWHRrYsMjyizeUTUrLnHB3iUoh2Rkv8GKaIsFdvFzpGQ0be5fIZDIs+w3lS9J3sdKoNe6l6uT0iW5ofynYbT6CO/fDPOYPKgzo7Skd0zSWqaMqRfqbBC8lcPkBxxtiC95EqYQoTcRLnHetvsfO/PS5ifWUcFye3/fXMpUzCG78vxb4/F7fzQRZ+DfPsikkvS3PJeCjzQ4MBLqxAN63o1XCuN0dJDy220WVDIN6uJt03
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(376002)(346002)(39860400002)(136003)(396003)(451199015)(2906002)(83380400001)(44832011)(110136005)(2616005)(66476007)(66556008)(5660300002)(66946007)(6666004)(53546011)(186003)(6636002)(36756003)(8936002)(6506007)(6512007)(478600001)(38100700002)(8676002)(41300700001)(6486002)(31686004)(86362001)(4326008)(316002)(31696002)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rnd3QjZOalFVak1wSG90a00rWUM5aGFLcGRvdDd6bHZVeUtFQzA1eFcwUUJJ?=
 =?utf-8?B?aUMrWVBjcVpyYlhBQmorZ1pBNkdtQ1d1c2U3UE0vRTR1K3puU3VQYzdwcG82?=
 =?utf-8?B?U0hHdytSWWxZNEpEOFg1QWM1dkcyMFhOOWw4YWZoZEdCZkI3K1hWSDVxLzlE?=
 =?utf-8?B?Yi8rRW1ScnBHL3JIQUZ4cnJxMDhpN1lNc1cxZllIejEyNTBUT0dYVU9jRFp6?=
 =?utf-8?B?NnVsb0M0UHVVMkYvRVFWQ2VGelo2QWpzUmJWSXJFOVErYVMxUmh2SDdnTHlp?=
 =?utf-8?B?dUdqeVpENEZmeXAyeHIxcFZTTnJKdkpJbjVsTGQxU1VYSW1YeStob2xxayts?=
 =?utf-8?B?enlyQ0R6VHFaMjI4UXY3UkYxdU9pNVhwbGYxTUh3U0NtWWNzSk9nZkdkRVZE?=
 =?utf-8?B?U0EyallwTmRpZzY3eU90Z0ZSbXBBVGxkQVluc05zZ0FqSGd1R1Y3RDlhclBG?=
 =?utf-8?B?bkV6QU04aU9BUzI4bnN5OVRsTEo3SjZLdUNITFczWFl4aE0rOTBFMlhRWEJl?=
 =?utf-8?B?YVpFVSt0MGhidHpvbXQwU0lhQjhISXVCVzUwTWRKd2N4OTdyMkhRWEFieUFr?=
 =?utf-8?B?OVV3TUxQR1ZtNEcveWJDa3NvNHlzMEI2OFVMY3pOMnZHZnZaOWptNTIzN3BO?=
 =?utf-8?B?QXEyd05UYXZaaHhJams4VkxEZjlzQS82bnAyVEpCb20xaGFLSmhXS3lrdnRh?=
 =?utf-8?B?Z1MwY2JsYWdNby9jQ2RqR2FvQndMZ2M2WkpGUWRIc3BVeE1iSXNZejNFUTht?=
 =?utf-8?B?RjlveDU3L3p1L3ZVc0Q1OFZ4UnhWNjFrVGZDYU5aTWJIcUZvNXJIZFJVbnBY?=
 =?utf-8?B?TjZIak40M3RJSklXbXBQaHZNUHcrU0hZcHVobUNwRG8vWmVVT3ZzRmwxUmtq?=
 =?utf-8?B?WkYvRFZLNjRybFplWDBObGtKM1lWY3BXV0V0dWxjc3FEL1NyT0F1OVRNaWg1?=
 =?utf-8?B?VDI4b2d4NGZINTk3V0R0SjRURVRva28wcm9pdXRyakNNbmo4WDFGMTBSUnVC?=
 =?utf-8?B?VmtKUFBVK25XR3hiUmVvZ05aS2lpSmZzZnJWSnUzWHlEU1oybC9MZGZXd2Rn?=
 =?utf-8?B?Unk0cnVMMytuK1BXbUp1R21WeTVRK1FDL2NuUlVmeHo1OXNsZUNSUkMvOVJo?=
 =?utf-8?B?cm1DRmpZVXhXeTVMeTgrYmc3MmpTbjJOalc3eHNiaWNVcEZ4eUhxUkNZc0o5?=
 =?utf-8?B?eEdDbk9oblRXckEvd3MwUCtGWEZNZmhIdXN5UXRjS1phYzJ0Uk9tSGNOZksz?=
 =?utf-8?B?QnZFbE9DWUhqQm4waEE2UkZ1S1RrNlEvbklBd0ViWHd0Z0dqTGRneUJhSmpx?=
 =?utf-8?B?ZzZpOUNnQVJUNk5MalNJV2ZOSHZBcVRkTnViTDR5RmR6ZktTRnVrSy9rVVhY?=
 =?utf-8?B?S2MxeDN6L0ZCc0hMcDRHcFJwN0JEQStKYTVpNUNiNlN5VkJJRTNuYmYvZXdN?=
 =?utf-8?B?SzFCdzZ3LzR5enVwZWNEeW50Z1YwdGZpbDRpZ3VmMkYzeTRhYjZCYnJjRnA3?=
 =?utf-8?B?TXpmUHhiTlJBcGt1NVlMM2twNXk5MEhtWEpwcG56VnQ1TGk2UW9GQ2VZM2Yx?=
 =?utf-8?B?UVV6MUluUXJqcld4RWQzdlFleFk1RlpySktMRWxEMlMveVpTRGV3Z1BJWWk1?=
 =?utf-8?B?UzhseGdyM0xRbFRrK3ZoSFN2Q3BPazdWTmRxcFZnc1ZxbDUvUk5mNFNRSlN3?=
 =?utf-8?B?em90OHpDMzBnOTJpREdqazQ4TXZOOWM5VW9SQUozd29sclZLbDV2VEZGZlZl?=
 =?utf-8?B?VVUydEEwZUZvZEVyYzZpSVJsZFlidlZLendyYVgvcUNwTGxtUEFTcEZIc1Ur?=
 =?utf-8?B?bmhQRDh5STROZTlWWDR3SHp5R0VLdFMyalI3UDgrZ09MeWVPRGJpbjJGbkU3?=
 =?utf-8?B?cXg2SVhDdzdlbUFlS3dsUndUMWZSUklHU05VVmxtWTg2V2xSVVBOR0tCZHE3?=
 =?utf-8?B?eDB5VnZQMFdPbWJOaDRJcURHTjR2QjRNU2NUbzB0RUE0aXllMFB1Mnpxbzdp?=
 =?utf-8?B?ckVqcGZRZ0JBUlRkRWNwYlRGQUJQdHZYMzI4RHhRL0ZobWdJT2pWa2lwdklR?=
 =?utf-8?B?K3YvQ1lZNkhRdHZoMGNvWVRRbmRuRW13ZzEvZGZyZmhhanBwQkJBTllzZ1Ew?=
 =?utf-8?B?bWptOXhHTHc1QVdvMUN4VzZ3Tk8xVW1ueDZKMDFwbzh5dXNIUWFVM2xPTkN1?=
 =?utf-8?Q?DDulJNSB49EFQUh+WkIZ/QM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Zmd6dlpEa1RqQkFvV1dyQmlZdlRSUzRnNFp6Vzk0QkJQaHJhb05WVFRzT1dK?=
 =?utf-8?B?U2ZkSVBLVDBsL3IyZ3laY2JMbHl1dXJlMHBMOFowd1p0SHlyc1c3SW5XcnZw?=
 =?utf-8?B?aWtrd0tTWGZFTE9UcFdPbkR6Vmx4TTBKN0doQkNaOXg1a1BWcjVEUDdWS3Ir?=
 =?utf-8?B?TjhCY0txckx5ZE1scHJxeVpwMWRNcU1MQ1BLSTQ4enA2MHNLRS9odmZhUnpE?=
 =?utf-8?B?K0dzWlJvcnZRWDJyR3BEYnV5ZUxwdkN0ZDRRbWsxM1NTL1d0a2ZKSnZsZUh2?=
 =?utf-8?B?T1lPaDZRMDZMQmhZdHZFeGdDM3dhZjFNZFMwNVA2SEdPNG51THExYzN5MjVV?=
 =?utf-8?B?QkhkV1R1MTB5MWFjMjcyVFZYaUk3cktMUkF3d1liR2pRTlNocjBrZ0g2dHht?=
 =?utf-8?B?Zlhpd3htRWQ1SkcrZWxjQkpFYWJRVERaV2F4YmtBWGI5RGZHdWtQM3pHeGlX?=
 =?utf-8?B?dDhWeThhUlZwMUhES3huU0pDZlFBS3BaOThrSjVsMzZLdGkzKzFmTFB0cFNu?=
 =?utf-8?B?ZWRUSTRDdGdTUDNVb1hxNjlwbXJROVliUnhxSXBTc2IyQXBTcFZCWjhmbjJv?=
 =?utf-8?B?NzFiRVJ6N1FqTXZIOVREN010NlEwempaNzRzNnpUNm5KNDF5YjRXc1lhc1lu?=
 =?utf-8?B?b2RGenliUFRTdytWWkVaaUtoNjNFdWU5TXk3M20xVFQ4Y3FNTWZRQkQ4TnRM?=
 =?utf-8?B?R3UzOXJvYXJlTnowMDJyTVB6SUkrNnpBVVE0aUFJdEtTbS9LY3JCZmJvc3F1?=
 =?utf-8?B?WWRyeHBobW9GT2owSk1hYjVCNG5ncE5PQnFLM1RBWUpOeHhWS244cCtPSWh4?=
 =?utf-8?B?Y0JtT3BYVElpNitoVkkrQ0Z2UTVnU09vWlk1ZVpjeEVYTm9tME9aZ3hOdXU4?=
 =?utf-8?B?dHNLZHZ5NDM0cDRMdmN1NlArMlRzQUgzSE9oRzV0c3hEejZ4ejZtTTNXejRt?=
 =?utf-8?B?a2JCVDNLSFNiRGRGdm9FbTFHM1ZjanUweEcwOUpWdlRHSXpESmo2ZE4rSmJi?=
 =?utf-8?B?LzFMbWljc3VnTWlrcDg1REtLZHZCaTJKQ2lTVTR2cjBEYnp3b3FNODlRV3R1?=
 =?utf-8?B?YWpidFRtZXY1aCs1dXAxejI4YnBKNllGWnE2VVAyQ21PUXVJclI2eEZncExa?=
 =?utf-8?B?cjNLZGhZM2J5UXM3RnlYTEZJNElrNSsyRkQ0M21RR2k3cjczUThiLzFsMWcv?=
 =?utf-8?B?UGJnM1BweGZITnZBajZRL2I1L1lueEtiSmF2c0VWNEl6NWlzcDUxUzNtRC9Z?=
 =?utf-8?B?NWZrdXpEUUtIT2o4MWtqODJrd1U2S1gzekhhT1dvOUdYMk5wejF0OTFWeU93?=
 =?utf-8?Q?BG0IcXJJ8iejw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f474e88-f151-442a-4df2-08daf2839fab
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 20:53:56.2912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kB+bddIpZh4/hmgW0H6GIRkSrr/XQXg1nzSpcmT6YawyGtlRGVUNyJlZnubLn8as2UUnQbGVDjYGxB+cSG812Sq82qSUz7uDMk7lFM/ywHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6827
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_14,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090146
X-Proofpoint-GUID: lY2zSGelYhnWd827atECh95A3eQEnxxu
X-Proofpoint-ORIG-GUID: lY2zSGelYhnWd827atECh95A3eQEnxxu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/23 2:01 PM, John Hubbard wrote:
> On 1/9/23 10:23, Mike Kravetz wrote:
>>>>>> No problems with the code, but I am not in love with the name 
>>>>>> subfolio.
>>>>>> I know it is patterned after 'subpage'.  For better or worse, the 
>>>>>> term
>>>>>> subpage is used throughout the kernel.  This would be the first 
>>>>>> usage of
>>>>>> the term 'subfolio'.
>>>>>>
>>>>>> Matthew do you have any comments on the naming?  It is local to 
>>>>>> hugetlb,
>>>>>> but I would hate to see use of the term subfolio based on its 
>>>>>> introduction
>>>>>> here.
>>>>>
>>>>> I'm really not a fan of it either.  I intended to dive into this patch
>>>>> and understand the function it's modifying, in the hopes of suggesting
>>>>> a better name and/or method.
>>>>
>>>> At a high level, this routine is splitting a very large folio (1G for
>>>> example) into multiple large folios of a smaller size (512 2M folios 
>>>> for
>>>> example).  The loop is iterating through the very large folio at
>>>> increments of the smaller large folio.  subfolio (previously 
>>>> subpage) is
>>>> used to point to the smaller large folio within the loop.
>>>>
>>> If folio does not need to be part of the variable name, how about 
>>> something
>>> like 'demote_target'? The prep call inside the loop would then look 
>>> like:
>>>
>>> prep_new_hugetlb_folio(target_hstate, demote_target, nid);
>>>
>>> so it is still clear that demote_target is a folio. A more concise 
>>> version
>>> could also be 'demote_dst' but that seems more ambiguous than target.
>>
>> I am OK with that naming.  Primary concern was the introduction of the
>> term subfolio.
> 
> How about one of these:
> 
>      smaller_folio
>      inner_folio
> 
> Those are more self-explanatory, while still avoiding "subfolio".
> 
I would be fine with inner_folio.

Thanks,
Sidhartha Kumar

> thanks,

