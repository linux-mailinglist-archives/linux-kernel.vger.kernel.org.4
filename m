Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CBBB662B29
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233816AbjAIQ1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjAIQ1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:27:35 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCD15F66
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 08:27:33 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309FofSI031984;
        Mon, 9 Jan 2023 16:26:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=x4JbvgO6n3l33M2FHE/3/geQLvO0G2iiojrrufpToX4=;
 b=XnPISx/cMc4pz2rjNC2ZNyYGge4MbsB+6dMIdIhWZ0r+R4493M7fhQDsZ+fZdBD57mTL
 E+fTZeZekyvSJPq00N9ywx79j890n9QJGm3uzOn3yymwlz/qyHN+aS4PKy0NzG5QSDAk
 ViyeZcF1DIkib+G4xPe8B7pV9puqdqJlASzv+boiNG2N2JS+AQln8JdCDu7HPhroA1a2
 auV91AvvA0yRaFFNoXj6Dau6TA8vQwvySI/y1vv7UtgTz/CIs3WYFHrjl7I4Lffdc+Ql
 cRRjxZ9TOp6kxqh397KqHQS55TjQPfJTqNuV+wfKyeox3x6jfod9fbz9iluPACKK/pGU sw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mxyh3k20r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 16:26:12 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 309FWrXm033032;
        Mon, 9 Jan 2023 16:26:11 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mxy646rft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 09 Jan 2023 16:26:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N2bllyM+6dlHPPZAvZ8g8Kb5Ocw7lVcSU1vlYCzkJCieWudERtZgmVkjomR6kK0/xIV4h2SsrstVZQc8lUlhsE0B+I8S5UVcRBmjDVKECm/ZjwjRqifM1UZuk3PdwGf5jLoWVms/d+vdtn9WxnxBMMT5xKoj9+JGWoUdLwEWsR5ixY0lQqb1LYm0w3WP2rILuvg7TuMRXIcmXro4tMzwINhOAyhISipmFJPH3Ido3OiBAi0pCqLs5wnqtn36FVOYwm153fjO4cZXOndvotBvCFCyuIJRejbtr6d7oBJJzsTTJiAn3HKDezCTVX35eGfyZJzoDO/UrGXPwaJpn5d73Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4JbvgO6n3l33M2FHE/3/geQLvO0G2iiojrrufpToX4=;
 b=Nc+nL6/i5i6xnGE0iGPJTnU9P1O/vif9pAJ3muQu/zxKbzCQRCvZDlEJy3CoxhJ63z9A1MHkVb2cgPnIjlRDBkT4j/x/JREZBI2Oj2ovxYDixOjybQaT+MCOUd3IUE9GJRRJCKZ+kFB8R4qTShv03EqDXSkBZoT247d9oiOdN8U1htjXrvoTSk3uAgPm2TKjAwqkXrTwEeqM+9Kc+4cRqR5NS3Mk0ScPw6cRouP9J06ImLMYOiZA85sdPVdhXolO25PZdlQmyv284yvNOK5tbRutrOTASED9vxGsXCANmbku0q2LtiAoXpa6BOFSVdW7R5yBgMpDVVpbhLEuXtNCKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4JbvgO6n3l33M2FHE/3/geQLvO0G2iiojrrufpToX4=;
 b=BMxOyUwZKKcLpq+w8whpbNK7pr+rcS1krrzgbvX0SGrXN8lsy9gcMuWoep72C24mjowJIdoSfLgfiArvqLOWqbbCUEw5z1gk96CsyA4qBwiFrqNJMhj2QJdCyhe0ojf6PQMAwOwyQ/ejpbHPbBMN8P0CZjACsaoKZPYTHMKPFWE=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by BN0PR10MB5032.namprd10.prod.outlook.com (2603:10b6:408:122::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.11; Mon, 9 Jan
 2023 16:26:08 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::93ca:e22f:aa6d:94d9%2]) with mapi id 15.20.6002.009; Mon, 9 Jan 2023
 16:26:08 +0000
Message-ID: <4a0bb956-c878-4516-11a0-b233cbc2b3de@oracle.com>
Date:   Mon, 9 Jan 2023 10:26:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH mm-unstable 6/8] mm/hugetlb: convert
 alloc_migrate_huge_page to folios
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, songmuchun@bytedance.com,
        willy@infradead.org, tsahu@linux.ibm.com, jhubbard@nvidia.com
References: <20230103191340.116536-1-sidhartha.kumar@oracle.com>
 <20230103191340.116536-7-sidhartha.kumar@oracle.com>
 <Y7jCzW6oqlHpxusA@monkey>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <Y7jCzW6oqlHpxusA@monkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0018.namprd14.prod.outlook.com
 (2603:10b6:610:60::28) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|BN0PR10MB5032:EE_
X-MS-Office365-Filtering-Correlation-Id: 95c4754a-1c23-463a-b25d-08daf25e36a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vz+j9H+kh28H809g3Ntu8EuJR4/LrR66gKfrCOts3JurQiGN3rN/jyK/vcF9IhDA6Jc5mYq6rEfv64t2HRgTibAnNI8JnxgPPUhQYf7sF/6ruz3CJkvZMuqH80ZaOH+4xoyhbfTdZPKA1LvPZ/IK5EhAo8m3QDGLrBXSL+o8M6lL6gqOsowQcH4K4ecr36mc7U8DfBhxY1qfz2nT9s6/KP9H9SB7QaP5z6qnx+ZM88pSx+2nv97FCMXlOT59gdALo2Rg7LAUC6RD/THGMyvx32jZgt8E7nGsXyNjApr0osC/kuiJ4Z44w0OT3vtfOZlZmlltlKExBUAatMLwS8dx3o6bA+ZBu3V8ZwOldH/M0WjJRnnUDNtM5YWGU39Fucdjr5OtQ9IGNJpoyCJJt2QfX2TL5XTzDMgPt0LD6zVTk2LYE0dTn+YJPY6CgsAZN4Hb5fYOS0TxZ3hndAOPiQOMI4SEjHsfKCPDDjQOQ7Mh6y/f8IRsegFZ9dTwYT9TgcrKUk6cdVoMTEQ/O200YV4PX+uzHk64PIRFZ0yjdJT9LNDNrAH6nBTmYFSVAeBMxcKOAxcrj+vw3p6P088HvbHGoysC7RzYpf7buqXSn/9bHy6btz6O03RarPeWTOOkCsnrqtitYaNh68cQL4Y2VFfvE1ONBmEpO7XPHzxl+a5Hw4Zog3bf/k+4NANULAtC9TOn20+7qNT5NGE3qGEm0jCEWz+WFmPKIDnryt7/saBnY+WoBQqqmH3jUf0Rrdx9+qaHOTF9FfIyHtLsXk5Vcb/4jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(396003)(136003)(346002)(39860400002)(451199015)(36756003)(31686004)(86362001)(6862004)(2906002)(66946007)(4326008)(8936002)(66556008)(66476007)(8676002)(5660300002)(31696002)(83380400001)(38100700002)(44832011)(316002)(966005)(6486002)(6636002)(478600001)(37006003)(41300700001)(53546011)(2616005)(6506007)(26005)(186003)(6512007)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXFTSktXd0lFcUs2cjYrWndsRDBEcm9hektiTmd1WVA5WkxheTZoM0JWSGgw?=
 =?utf-8?B?ZytDczdQUG94dzM4UEdrNTFLSWFCcTNaSzNyNTU0Qy9NZmtrb1Q3RWltOGRR?=
 =?utf-8?B?a05kM0hrVDBPRm52Y1pMZC92NzBHbWVYc1ZyeWtpeFhZYXp6MmJpL2N5Ulpx?=
 =?utf-8?B?a3dHRy96d3VvOG52dG5FVWdOOWUzNjNDZGVEeTd6R1p3dlgwNy8vbzdmVGRL?=
 =?utf-8?B?WVU2OGtrdWRzdGFoT0VWSlVYUitNUWQ1UkVianBLU2loOVZvM1NNaVEyNkFX?=
 =?utf-8?B?MG1aS1J6cXk2b0NTVHkwWStyRXkvaDVrS2ppem8vWjFmREVyWlhLd0htb0FZ?=
 =?utf-8?B?MWh0TEJVQ0RjclhvZldmT1NvdDRUZ3dadi9ESVB2NjlNWDJLMmJtc0s0L3B5?=
 =?utf-8?B?UGc0MHVoSVhJaDlEazZBdGJzNWFieXBhMG1MVjFDWHMrSGIvWlR1OE9DZWlj?=
 =?utf-8?B?UkN5MWdScGZZOVZHVmZ6NXRBUXN2Mi9EaFJvRXprSlVWbXNPWVdCalFaVGtV?=
 =?utf-8?B?bEc5MFd1U3ZpR0d1WE50OFE5Vm5xS3d1QmV6OE1RKzVtTzYxdldXU1BoOTFK?=
 =?utf-8?B?dHNadEwyczJIVmdFRTMvdy9hUlR3K3F3MGYwbXViRVZJUWVrRTZSYjNhM3Yz?=
 =?utf-8?B?V1prYU1hR245a1NzWGIzU0ROZzRNenFST2xYTzhDSGhhSm8wUzNVS0c4dGpq?=
 =?utf-8?B?WjhVdm9rZSsvV2J6TEtDVDJscW5VUmJ0c0hFQWJOYVR5dzIrbnJKT2tJMm8w?=
 =?utf-8?B?R1NHYnVqcjI1SXZoZWZESU9JRURHTG9RR2tzYzdSYVJyeTFiemRWUlFNRFp4?=
 =?utf-8?B?Rk84UEtObDZoR0liaENSZ3JmM25lazFTbkYzQ3grWnJaRmdCazN0ZFFPN3pJ?=
 =?utf-8?B?YjlEMG5OK3RPcGFKQkVTNjcrN1ZmZ1kwMndTR3lUM2pGY2JuMHh4QlpVU0x3?=
 =?utf-8?B?SThVS1h4MG5XWlRnSXVoNHgyU0NXa1JrdDlkODBuR0FOcWcyeXdtMDFOdnoz?=
 =?utf-8?B?cnJXS1E3enZmb0wvNmpOQ3h0dzF0c1hIMHdkYVpCUC9Tb0NBRmw1dm5MQnls?=
 =?utf-8?B?aHFVL2NxODVIa25DanZGTU5oUjZJbE1vdWNhRGlsYThlaGl2ZS9jZUx4YzV2?=
 =?utf-8?B?RkROYU9HODRPbm5CTjJtNkh1TFNBeEl5T1BrcFBCNWZhNWdjSE5xMndKU2lz?=
 =?utf-8?B?bmdseUVGZk5MSVg4SVlvSEFuNWhjdkM2WG1sY0Jnb2RVZ0paelMzOU5Da1VJ?=
 =?utf-8?B?UWpiNnFVZ2NzRmlMMzFvU0dURDRiQTNRSTlxQ3JBb2JzSmtDSFJNL3p0NE02?=
 =?utf-8?B?NkZORlIwMFZ5aGhqMERWSjJlSVRuQjZVTTRsZndmWWdSL0ZCNjgxNlN6eGpL?=
 =?utf-8?B?cXozRElYSWdIbktsRTdoT2ZqR0QxU2Y4QnI1Wm1sdEJCNnFKOXMrbjZPYXFh?=
 =?utf-8?B?bnZRUzBWd3Z4U2JpT3l4bHFpcmdWOWdvcFpMT1RkSWVoaVh3Mm5CMXhPOG9Z?=
 =?utf-8?B?NkVESmpVWHJHN2s4OURtN2VJbS91MnZHcWkzWmZoQkZWUmlQSFRCR3h2MUZP?=
 =?utf-8?B?REZUVXVEM2VoNzBuZnFsOStjSDFSaWxveGhHQ25Ha3FIY2pERit3T0FoeTd0?=
 =?utf-8?B?alM4bjUveVZaRy81Vk5POGt6SlNTNkxka1VkT3FMMVU4VG9aSEtQMk1sdndy?=
 =?utf-8?B?eG9VUXBGbGJiT3daRUcwcENrWjVzTkVBemxGRGpBQVU0VEpjakVNSlRCTTFD?=
 =?utf-8?B?bkt0cFk0RmxJK0dpaUJYQ0RkLzUvRDQ2LzlTOURCRGhGWElwY3BOYlpUOGlu?=
 =?utf-8?B?a1FLUFlPS0c4Sml1L29HNmNNaTVDbFdyUEt1OC9laTVwQlFzY1JVYlp3MENM?=
 =?utf-8?B?Rm1weGx0UEl1dkZFcWFoMW5XeTJ3b05tcHUzT2hSdnNUcHFjYlMxTHBDa1FL?=
 =?utf-8?B?c25JbUZqZ2VCbHJHaXp1OEIwZHVlUXczcHZZTUNBYXRrTVBPRUNPbHRkSURI?=
 =?utf-8?B?REVvY2hnMlcwakt4RWxkZ2ZNcnhjR1c3WTZpcit5UGozSmtyWnpINklNb3Z6?=
 =?utf-8?B?bjlQT3F4VDVCUGFuTEI3STZCYmR0ZDFSeEU3OFJXNmczdUozUi9uOEdJL1hR?=
 =?utf-8?B?TnlRc1JxUU1rL0I4TFl0eW1UQVZVeWlYTVE2OGZyTW9pWHRvTEU5b1ZIYVNI?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YlBDcDBWalRQWStRdXM1dEwyTUlWRzJVdjhxOHU3bURiQ3BjSVFkTmQvZW12?=
 =?utf-8?B?SUNwWEl0ZWtqSDZwM0xtT3I1NkZhQmwwMTltQVpjN05DekprYWMrSUJWM0kz?=
 =?utf-8?B?UGZtdzA2djdrN0hIMTdyOTRQUGRBVjNmNC8rUEtraU1MK0k3QVUrRHhyMThr?=
 =?utf-8?B?VVZKRnoya29wc0JSbk9qREtCR2RyY216SUJudStHQlV4ZTZJQ2w3b2ptMmM0?=
 =?utf-8?B?cEdoQXZpekkyblAzUGlPcTJaQlR6TnhwRWdZbGl4UjhuRjE2SUhiZ1A3QnA2?=
 =?utf-8?B?cDI3Q2JMVEQ1Qm1qRzFWeVFEaHJSTEpIcXpCaE13K3poRjN5NUhSdStBeGMr?=
 =?utf-8?B?QkZJbkY5NGRLU0NnNE5EYkZxd2FQdFBwTW4zN3hmWmROeEVwalJXdERvcGZG?=
 =?utf-8?B?ZTNaN2J2NHZHbVRaeENxaUNQeVcwS01VNU9iMkI5WjhUV1JZSEhnUUhiYmth?=
 =?utf-8?B?TmxZd05laEltdXh4M1d3RG9vSFBpQm1oL0lqWWJwd2t4ZVhKdnBGYjZCSXFt?=
 =?utf-8?B?ZXpTdnB1aGxiYkRwbUcwZ3RKcks3ajZjaC9TdHJOSnBCbUM5UkZJQlMvcW9D?=
 =?utf-8?B?U0tJZ2h4Vk55ZkJRUngwNDgxTmtyMjFWVUpBVUUxSVpsK3hNR3JwR2cwM05C?=
 =?utf-8?B?aU9XWThRNGxWUVplSzRYV0xqSFRWZnk5WXc2cGZkVFRiZ09mcm5GVFdPSlVz?=
 =?utf-8?B?OGJkNURMWWU0Ry95dE8zRDhhVGREeGtHdmwzdnhQb1JsejNVU1VDZkhqRjFs?=
 =?utf-8?B?OXVOZnJCb0N5OGtNM3FqTkZLOXFSQzNQY09pM2hiS1JKSWFHYVdJck5rYXpL?=
 =?utf-8?B?YnUwT2xKWmJHajVhMnFuNC92dVVXeGpDRkdtSVp4TzlBWExNcXlPRGVYcm1i?=
 =?utf-8?B?SzVrQU1ibTE3R3R4N0VGeHNpZzJBWEdaK0Npbm1BSktweE9XeXZaQWt4T2I1?=
 =?utf-8?B?dDh2Y2ZWWXFYUkNubEdXRm01UUhkb1VpaEp2K1l3N1JFUGREUVk5WlZYYkNL?=
 =?utf-8?B?VDRkTmhyZVFHN011S3ZXQksyREt2ZlRYUk11WWhnQ2FOTjJaaTkrUGd3UTB2?=
 =?utf-8?B?TDFIM3Q5R1l4OG56d0N3ZkY2bFp5c1g5SEVHY0Q1YURyM09kMllVM0dlTUNE?=
 =?utf-8?B?eDV1WDJWT2E0Wmk3c1hTdTE0UGtzdUU0OGtnWEtrejNQdkhyeThZOVRSbDlT?=
 =?utf-8?B?OWVIUDZDWU5OUVZoTnlkaWpuSVIvU2xVU2ovZThsc3pVaVE3djRMTlZ4a25o?=
 =?utf-8?B?NitzbjRqN0xEWFMwbEcwV1lVbTVBRnQrVjc1dEcwN1VtZmZYSHNMMHB4T3Vn?=
 =?utf-8?Q?GnnLJp2oh95a8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c4754a-1c23-463a-b25d-08daf25e36a9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 16:26:08.6940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k4cUq5blsHT8lA2+id5Yjx2F2g826UhrZDHnAJnsTVjAwvVufntkq9AdilPJt7Mww/rHN+vAmhkVIy3+gbfH1pqofsnanEXJ0VYQ2juM948=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5032
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_10,2023-01-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301090118
X-Proofpoint-GUID: TIqrU2V9GmPsWQtIlLUOvDO19XZG93cI
X-Proofpoint-ORIG-GUID: TIqrU2V9GmPsWQtIlLUOvDO19XZG93cI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/23 6:54 PM, Mike Kravetz wrote:
> On 01/03/23 13:13, Sidhartha Kumar wrote:
>> Change alloc_huge_page_nodemask() to alloc_hugetlb_folio_nodemask() and
>> alloc_migrate_huge_page() to alloc_migrate_hugetlb_folio(). Both functions
>> now return a folio rather than a page.
> 
>>   /* mempolicy aware migration callback */
>> @@ -2357,16 +2357,16 @@ struct page *alloc_huge_page_vma(struct hstate *h, struct vm_area_struct *vma,
>>   {
>>   	struct mempolicy *mpol;
>>   	nodemask_t *nodemask;
>> -	struct page *page;
>> +	struct folio *folio;
>>   	gfp_t gfp_mask;
>>   	int node;
>>   
>>   	gfp_mask = htlb_alloc_mask(h);
>>   	node = huge_node(vma, address, gfp_mask, &mpol, &nodemask);
>> -	page = alloc_huge_page_nodemask(h, node, nodemask, gfp_mask);
>> +	folio = alloc_hugetlb_folio_nodemask(h, node, nodemask, gfp_mask);
>>   	mpol_cond_put(mpol);
>>   
>> -	return page;
>> +	return &folio->page;
> 
> Is it possible that folio could be NULL here and cause addressing exception?
> 
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 6932b3d5a9dd..fab706b78be1 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1622,6 +1622,7 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
>>   	struct migration_target_control *mtc;
>>   	gfp_t gfp_mask;
>>   	unsigned int order = 0;
>> +	struct folio *hugetlb_folio = NULL;
>>   	struct folio *new_folio = NULL;
>>   	int nid;
>>   	int zidx;
>> @@ -1636,7 +1637,9 @@ struct page *alloc_migration_target(struct page *page, unsigned long private)
>>   		struct hstate *h = folio_hstate(folio);
>>   
>>   		gfp_mask = htlb_modify_alloc_mask(h, gfp_mask);
>> -		return alloc_huge_page_nodemask(h, nid, mtc->nmask, gfp_mask);
>> +		hugetlb_folio = alloc_hugetlb_folio_nodemask(h, nid,
>> +						mtc->nmask, gfp_mask);
>> +		return &hugetlb_folio->page;
> 
> and, here as well?

Hi Mike,

It is possible that the folio could be null but I believe these 
instances would not cause an addressing exception because as described 
in [1], &folio->page is safe even if the folio is NULL as the page 
offset is at 0.


[1] https://lore.kernel.org/lkml/Y7h4jsv6jl0XSIsk@casper.infradead.org/T/
