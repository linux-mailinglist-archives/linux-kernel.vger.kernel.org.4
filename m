Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640D2667D49
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbjALSCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239995AbjALSBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:01:52 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7D81A83C
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 09:24:01 -0800 (PST)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30CGxUBv006522;
        Thu, 12 Jan 2023 17:23:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=vcIEcRIQJ7BaGR38cuXiafChIusJFeGwR/gMujabnGU=;
 b=ffUnrpRE7c0He9V03rX5bDpPpBuOdtRZ467gYTB6fgbskLXER3J7u/UCfG0/sIIIuwbI
 uA+g5g38wAASnjHzvuz05gaDIqqIaQ5k0Xfltq1SjWXmu9k3rdN7FalU6AwBrKq+TPeJ
 qWmkIYJMP1k10meXWfgTQ47IQP+QWDHvZ26qy3K2qfV1Hjt+tm+Lkuq8b7X9yPgqQRoZ
 waBuNctHCbYlsxk0mNZG96DaxnD5VXojT2Dwrfog+GGTO2JLoz1XQa4hj6wCbSFjEAwQ
 qK4Q6vkiJEBn9xPy/DD3XnC1g1BHhl8p//yaVdlHDFksu2cxqHjHnPGdCr5hqs8GpcWV Yw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n22x02bjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 17:23:26 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30CFlMhR034199;
        Thu, 12 Jan 2023 17:23:26 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4grjhs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jan 2023 17:23:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcgJcsd9PpAis35unY8JqmV9IUBmitl7xrSCeXjcST90k/R3pungrSVKNVMl/gIitZXzVpsY/NsGXaJWohnxLZ0yFG+Kh/+K+QQTq76s0ljrn2WI6mj/xnGnALAdqJ8BxVNTsSKMQ37iz/h1W3CSGju36RjZOFIxJUWxVg0mOKp4VKsxaj98ulD4GrrlWRKO6JKsZtWjhlY5lcCfYrg8fj+turVw7XCr0buh9DYExYDPKoW39X6GdiBYxKT8OYJrcBDcvyC6VaOHu7/znDQr6ptXcbcxMmt8QUQIO2AdM3qFQooDQcLYdFy6cydEf1ahrKQ1hiJdT6oqa3mezefogA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcIEcRIQJ7BaGR38cuXiafChIusJFeGwR/gMujabnGU=;
 b=T627gUn7B/Ifua58PcntFWkwrx5kCbP/o98YyCQzKSRn5Vlf8P6X1rLqRT3nvlLPEo5i99zZFAYLymMiedK1XBni3MlizaSqAWBKMPG9MUJLon19agPRKZd0kT4odtX29zvohu2sfgvoJcTPLJoh6gZKJP4b8HeWsVf6tPxvhXLcp7z1bmy908sc2WZqTFDZc5InfH9/IduXduU9S5V1YkME4qIY67PGXeZpm7wDGkOlJXtRo4Fy9MXYMa1Gb2azRPrKtQO0XmZdDNAaNCDFOGFlQJ5CTsmx+l+MDpW2FG0l2edlY38TI7xx2+sozOz5hQ/fwNBzAS9hTuIucpZKPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcIEcRIQJ7BaGR38cuXiafChIusJFeGwR/gMujabnGU=;
 b=tyZGqRdVabESkQGxzKEEA2n8YJu323igtLvv0Fk/HzmnyxKGB+GFrukF1riCFwv+18qvzYuAIrlweVjBQp6WY+Yd8GOuTnq1ojoOvrZEfxZATLWofCMcGINBq25rrizhxp47QdC4VyQPn3c3EwGUAHneii3dxka41tTpjL9mxpM=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by PH0PR10MB4741.namprd10.prod.outlook.com (2603:10b6:510:3d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Thu, 12 Jan
 2023 17:23:23 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::e301:fde6:85e5:b45a%5]) with mapi id 15.20.6002.012; Thu, 12 Jan 2023
 17:23:23 +0000
Message-ID: <b3f3a4e5-35e7-2cb4-f754-f425da094f28@oracle.com>
Date:   Thu, 12 Jan 2023 11:23:18 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v15 1/7] crash: move crash_prepare_elf64_headers()
Content-Language: en-US
To:     Sourabh Jain <sourabhjain@linux.ibm.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20221209153656.3284-1-eric.devolder@oracle.com>
 <20221209153656.3284-2-eric.devolder@oracle.com>
 <09567e13-c5ed-d1b9-027c-9340fce6a0a8@linux.ibm.com>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <09567e13-c5ed-d1b9-027c-9340fce6a0a8@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0180.namprd03.prod.outlook.com
 (2603:10b6:a03:338::35) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|PH0PR10MB4741:EE_
X-MS-Office365-Filtering-Correlation-Id: cd931f00-b151-4950-2e92-08daf4c1b54d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oy0e97TtdWHyeye7mU7jukcJZUzQEYKvCA04luACz3RbvkJlHMczPZZBGvLICo2Tp3LRocPX7Y4pfYZ1X6KGs0UsnlBmkzGhhaskCZsAKvxKWjOt6kcFymoX7HWvhXLuD6VMI9COR+9M0cFRaMf9XbwDqfEi6kYLr00/HADxQjz9oXDnq5VRJyhcfdEK7l5u3B66DD0l6JSNuiRWxG3PoKTKaVHaN48K5cIn0/nUx+bkvzkKjKieDLaw84DfDulXPDAIqbImtn0m+jHZSqNoQgfehmaNGGacDo7ijIsHIeJIP0C7OZi8kMSbvKIYj/dePQ+sto5NYT+HrLIu2jPXiIlFzQ8v+4X/IH8gh2w0pUwihiqI/2ibdkRohEOYlqotVAAb/TpzuRGPOVt66ce4AqdC3g4qBO2pbW5/DF5HPnHi3ecq4rxhIsxPOHE1ry6tQ9Z+fXG+g2miaiYdJI19UOeFqac8cb0HFqD+KcmLQnfwQmSjeaSHMXv8OX5I3WlfwOCG9UeusD3WVj1HxUXHV20/02yIql3KbqHrxrYIb3mLUeC1KwCx9/AMSKNS5lofH/SlcQISi4jjCAwz9nOXkP/7bTO/PGzoGgbvQtZ1teMgs1rW8gX0lDykpqhnsISnuyWiJKXdEW3UNPooof8izTqAKGnslpDfFi2WG+49LMQfdjwb7FcmhnxgEn0wbMS1fKeuBtfqjW0vQy3TO1Awxy05FFl7VSc6g5L6DmPFYHU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(376002)(136003)(346002)(366004)(451199015)(31686004)(2906002)(4326008)(5660300002)(6486002)(36756003)(86362001)(31696002)(8936002)(7416002)(41300700001)(66476007)(66556008)(8676002)(66946007)(38100700002)(316002)(53546011)(6506007)(83380400001)(2616005)(6512007)(6666004)(107886003)(478600001)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0JxbCtiUER1ekFQQTlnRmhWUEtYWHJDUGt3OGQ5WE9xdHJjK0o0VTZxVEF2?=
 =?utf-8?B?QzkwcU4veFp1MEtnQk5pVTJoKytwS0xwSTJBYUorbkgxNkJYWXN3dEs5ZDhV?=
 =?utf-8?B?Z3hSaEVnWGlNbmZuZkkrRlJmdUFyY1hpWDFYVDdtUURTb2x0bHY3ZWYwVWVS?=
 =?utf-8?B?NUtCWUd6WWNvV0VOeVROQWJzUHRLQ0dCS2ZDZk45aFd2SHZrRWhNbk50VjJp?=
 =?utf-8?B?M2lVL2h2STVzVDI1d2hvVGJmOVg2ZXcyZzMrZDNwZ2NaN2lnTUJ2NkN4M3VL?=
 =?utf-8?B?bjdqbUllOGN5b0REY012ZHpUK1ZkamRTcDR4MWttTXNBVDhqK2NKN3drV3Fy?=
 =?utf-8?B?RWlvdlZ2MmpabndnV0dUQ1RNdkplWlBZdS9sT0JTa0Z4Q2pDRm9VSjhGaDEy?=
 =?utf-8?B?eU1JQ25zcGpYS3BJVE1oTnhuY283U3Q2bUpJcnVMRkNWR3VwQnNqWGlzeUpq?=
 =?utf-8?B?Z1lVZXlxU0tMaEJFMGRPU3JhdlB4L0ppZnBJZ2d2bnUxbjNBUU92VmNhZ3NC?=
 =?utf-8?B?M3FyQTFQWGtNWGk2bmhpMzUvREpEYlR2bGJjc1BLd29Id2ttbDhyRmcvc0Zw?=
 =?utf-8?B?SGJ3UFlJRTFGcmpaTzZOdG5YUVNZTDQvdERqKys0bEd6ci9YNkxOUDJBZCtv?=
 =?utf-8?B?cHcyeWt5WmxWSUZZS2NNRnJWVm5aVldkMEJiMUx2NnI5U3lpQm1BSHhUWGlP?=
 =?utf-8?B?RHJkeGJQNDNwTzN5T2h0blVGYmdqMHAwQ1h2bHNUQkZnb2R1Tmxqbm41ZWor?=
 =?utf-8?B?QTlzenAwclJ2RS9xMnRCclpCMnE1eElCNUFrVExlRW1HaDh3RWhJa3dPZThQ?=
 =?utf-8?B?elc3R3NKeGZJeWVkVVZ2Q2w4Q2FJVjJKcU9hcG00bitpSExWS2NYVkhLK29X?=
 =?utf-8?B?M0hxRUJ5cG5LTG5xWFdNalJVN1lRWStkUnNETFJuVWtCM2hqRHRjeHNqejlk?=
 =?utf-8?B?MzNIcDR3U3cxSGV4b1N2dlR5amN4SlV0bC95OXdkTzdqN3RmNkVzRjY4cktK?=
 =?utf-8?B?UG95QnNxTjNBZStmS0RGK05ZL01jQUtxN0ZpdUdEWXlTUFJGY21VenpVYlNp?=
 =?utf-8?B?V1VoN0xKREtUV0lFYUF3ZVhRM3JBSXdFdlhidUthUldkYW9BYkJwR3NOTmlZ?=
 =?utf-8?B?OGJNWWJUcTRjWlFqb0RQcjBYbGhDRE9NditYQUtCbUR0QTBsZ2Q4eXZBOGhY?=
 =?utf-8?B?eEhSWmFpWjlTNStzZ2RnVEo1bUpLcmdlbTFtMG9hSWNhbytZVzNkVTJFQldT?=
 =?utf-8?B?RTdHbGNGcWtHUmh1NzhrdWJkdS9QTlVyWWJsZDFucm9lNEM2L1Fia01qdXRv?=
 =?utf-8?B?ZzBQQlIrcUFwM3NIbjNLKzhKT2Zub0dKTjEzSlNvblo4U0c1VFpIN0J2WFlH?=
 =?utf-8?B?Y05lS3Y4cHBaSlJaK0pRRG41UldkeXJsc21wVHJqVjN1enpEeUt5M1diSFpT?=
 =?utf-8?B?L3ZoelZLRDRpbGs1REhLVDdaNXZsUndsT3pMV1RiNWFOSTlUVnU0dmdsVEFJ?=
 =?utf-8?B?YnlwL1lNWUdDQTlsdlJaaTY4dXZ0cWdyWC9US2w4elpKRU9WZ29qSVlaK1pj?=
 =?utf-8?B?V3hBSTNhTnFUZlA5RGxBRXpIM2VsK0JibjVvSTZ2cjdkS0h5Z2paR09sWlJX?=
 =?utf-8?B?SytIZkFic0RPSlJSZUxTendLWm5TSzhITVorenlxdk15SHgxakNKWm5hRlE1?=
 =?utf-8?B?ck1pOUlwa0ZjaWJEWnhJMWwyVUFFMlY5MmhEamkrbkRjZ2cyRExVVW9hS3dy?=
 =?utf-8?B?L1dnbnhZVTVzMHNvampOL25KMXpyWlRQRk0rZENpWmdNdlNCVXJQTy8xd00w?=
 =?utf-8?B?eElGSXNxQTZOc1orQUlDZ3ZGTURZanQ0NjVEZW9RNU1OYlNkelk3czJKdDk0?=
 =?utf-8?B?enA4Q0ZFOWRYcWtZWitmaHdMOE5sNzRublNER2QveExOdUNZR3ArcjBVOXRQ?=
 =?utf-8?B?WGluZ2JsQitQK2xtTHhOZ2I0VVkzRUhYQlA0THZ5cnJqZEFRN0ovakFkUGRM?=
 =?utf-8?B?cFh5MitOdXZONzQ3Rk1Cemo5OE5GeW1VM0twa1lWOHhzcGxmcmxwY0ZNTGlG?=
 =?utf-8?B?dStobHVuUTl3aGVqWSt0ZzVjTmVkZEVGd3k1V25oL21GVWUramJyZDFtaTZw?=
 =?utf-8?B?TkxVUGhrYzVudHE0VTUrajJ5L3FrbmxuQmtubFdad2hRaFlKR3JCWU1yTWNn?=
 =?utf-8?Q?D+wu3TUi4G6Tz59t6sKVFaU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?R1hxL2EvVGxrQWJDei9oZ1JqWCtVUEJ5WEs3bkxHUm5FOVBOM0dXUWJ0Rjdu?=
 =?utf-8?B?OHlDVkFIaGQ3eXNuemdoeVIrRkZlRTl4cTVWclVxU3loRXVpVElQRzdTTk9X?=
 =?utf-8?B?cGxpbWU1bk4zMWltZHc3VWNlSG9NTkFtbW9sRUJMOHF4WG1WY1pROWJFZFB4?=
 =?utf-8?B?My9kZDlDdVV2YlFRZk5XRXd0ais5UkNHRThMZm9xVk5TdjRMeXQ3c3RSSWF3?=
 =?utf-8?B?NWxtWlJvalF6aFRIRFU0MlZDcjFkOFVDc01taVlKRWlmdE40ZXlHb3djS0hD?=
 =?utf-8?B?Z2Z3VFE3SzRxZUJaMWlxVTlxQ2ljQS9Hc2xiZElhYmdRSWU5ajk0RHBqTjd5?=
 =?utf-8?B?V3ozNkNNcGhieDhlQ1dMTUJkQmVuNStDV3JZb3ZlM2c4bE5TRW9UY0NWWUdR?=
 =?utf-8?B?WTFoMFc1T1QzMFNvRyttUWc1QTg4MzhVN1NDZWZ2WStDRUhRc28wcXRCaUpZ?=
 =?utf-8?B?dG5SOW4xeE1HM24vYTdubzh0WlhkTnVaK0VDNk9FUVZYN1Z2WithRlVrdHYv?=
 =?utf-8?B?TVhBSFA0cEpIYWpIVHQ2RG9KUTIrbjFYaWpWNTltdmF1dnc5M0R3TXNxTEE4?=
 =?utf-8?B?U09PSDJTVnpNWEFnTG5ITENXOWl5YWlSakMvOVVoT241UW1CSEhwQWRLSkEx?=
 =?utf-8?B?SGZITFdLVmc5dUlUYlNNTGtjN0Z3aU80RTJZbWFRbFlCY2NCZFJIZXNuVGwx?=
 =?utf-8?B?NFN1bUt4emd0MVBJMnhyTUUwNGR1cWNDTkhlZjR6dmFUb1FIcE9qa2tpekVK?=
 =?utf-8?B?dlhuWWl6dG1CN2s1QTVwa3dWTzliWkdsVG9GdGxJb3Q0ak5NbjlMYTh2VzhD?=
 =?utf-8?B?cE5GYUdMalNjN0VsbkRFZmQxMll1NUFWUGxSakRoRXhMUmtsdFZza3VpYlVs?=
 =?utf-8?B?cllob0Ryc2Ryb1F1SW5RTjRmL2F0cEdzZ2MyM2lSTCswR3lkTXZCKytSSGZq?=
 =?utf-8?B?bDhUZXRJN21nakY1cnVTQlovbFE0UmFjdzJPdnZWR0l6TDF4dEpqZ3FsalBL?=
 =?utf-8?B?RmkyRlJrNHIydzczQmY4OTBLY1B0ckRPNEF1VE9aNkpiamtZSnZnWVU2R2pi?=
 =?utf-8?B?azc0Qm5icUczWjRNSDhZUUNaN1VxS0s4eURFYmRrbTl4Zm1YSlJscHFpOUFs?=
 =?utf-8?B?QmdCbG5xNDJVaHk1dFlVMU13RjZiVEljS3o5T3N3SWxZWlZpZk9JRkJheEFY?=
 =?utf-8?B?VEM4bEt6ZnRXWVpVRVljaVdVWENRL251b25GYlRWV2YwdFJiYjdBTGpRRlVH?=
 =?utf-8?B?MmZ6ZWwyQTNva2VaNkI1R0MxQ0hXdDEzVlc0ZWJTVzdWUW1kelNxcE5xbExL?=
 =?utf-8?B?UFlTVGFwL2kxZFJiVy9oZEJVNVE4MEswS3hzN1cxUks0VWd3ZkpsNDBZR0xr?=
 =?utf-8?B?enBIMXd6VldMUFphNUtXM2RGeUpPbTBzaThRcDhjY21Wc3ArUzROWVJsSHdI?=
 =?utf-8?B?MjdLS0JNaGRVTVQ0ZUE0TzA1eVBvdXNtendjN1E0eDVRd3dUbklINWdsRUlm?=
 =?utf-8?B?VFZwbGR6dmtidVAxNlNsTmZtOWpCeStESXFKSDZhM0crcTh3U010VVhmbm9Q?=
 =?utf-8?Q?cNUupbqGtWKLoJzuulXU7igF0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd931f00-b151-4950-2e92-08daf4c1b54d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2023 17:23:23.6445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: epYOvlu29za8OyFLSDRebYVOtVS9222mfyR0CBg/eXAUceeFDHB/8CGH8nUAhgvflKvJ3bJxJkExQhX6FTJstoLaOMreCbiq3smMfyDGiTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4741
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_08,2023-01-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301120126
X-Proofpoint-ORIG-GUID: K00GkrcJuxRvu5tsPR_eN84w5NWozRbG
X-Proofpoint-GUID: K00GkrcJuxRvu5tsPR_eN84w5NWozRbG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/8/23 23:05, Sourabh Jain wrote:
> 
> On 09/12/22 21:06, Eric DeVolder wrote:
>> At the outcome of this patch set, the crash_prepare_elf64_headers()
>> is utilized on both the kexec_file_load() and kexec_load() paths. As
>> such, need to move this function out of kexec_file.c and into a
>> common location crash_core.c.
>>
>> No functionality change.
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> Acked-by: Baoquan He <bhe@redhat.com>
>> ---
>>   kernel/crash_core.c | 100 ++++++++++++++++++++++++++++++++++++++++++++
>>   kernel/kexec_file.c |  99 -------------------------------------------
>>   2 files changed, 100 insertions(+), 99 deletions(-)
>>
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index a0eb4d5cf557..46c160d14045 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -10,6 +10,7 @@
>>   #include <linux/utsname.h>
>>   #include <linux/vmalloc.h>
>>   #include <linux/sizes.h>
>> +#include <linux/kexec.h>
>>   #include <asm/page.h>
>>   #include <asm/sections.h>
>> @@ -314,6 +315,105 @@ static int __init parse_crashkernel_dummy(char *arg)
>>   }
>>   early_param("crashkernel", parse_crashkernel_dummy);
>> +int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
>> +              void **addr, unsigned long *sz)
>> +{
>> +    Elf64_Ehdr *ehdr;
>> +    Elf64_Phdr *phdr;
>> +    unsigned long nr_cpus = num_possible_cpus(), nr_phdr, elf_sz;
>> +    unsigned char *buf;
>> +    unsigned int cpu, i;
>> +    unsigned long long notes_addr;
>> +    unsigned long mstart, mend;
>> +
>> +    /* extra phdr for vmcoreinfo ELF note */
>> +    nr_phdr = nr_cpus + 1;
>> +    nr_phdr += mem->nr_ranges;
>> +
>> +    /*
>> +     * kexec-tools creates an extra PT_LOAD phdr for kernel text mapping
>> +     * area (for example, ffffffff80000000 - ffffffffa0000000 on x86_64).
>> +     * I think this is required by tools like gdb. So same physical
>> +     * memory will be mapped in two ELF headers. One will contain kernel
>> +     * text virtual addresses and other will have __va(physical) addresses.
>> +     */
>> +
>> +    nr_phdr++;
>> +    elf_sz = sizeof(Elf64_Ehdr) + nr_phdr * sizeof(Elf64_Phdr);
>> +    elf_sz = ALIGN(elf_sz, ELF_CORE_HEADER_ALIGN);
> Seems like above function is out of CONFIG_KEXEC_FILE but some of the
> structure/attributes like crash_mem and ELF_CORE_HEADER_ALIGN are
> still defined under CONFIG_KEXEC_FILE (look for include/linux/kexec.h).
> 
> This leads to kernel build issue when CONFIG_KEXEC_FILE is disabled.
> 
> Thanks,
> Sourabh Jain

After looking into this for a bit, to allow hotplug without kexec_file would require quite a bit of 
code movement. Why? Because hotplug is basically built on top of (part of) the infrastructure that 
was needed for kexec_file.

I'd be inclined to suggest that KEXEC_FILE be a required dependency for CRASH_HOTPLUG, ie:

  config CRASH_HOTPLUG
         bool "Update the crash elfcorehdr on system configuration changes"
         default n
-       depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG)
+       depends on CRASH_DUMP && KEXEC_FILE && (HOTPLUG_CPU || MEMORY_HOTPLUG)


If that isn't feasible, then it would appear quite a bit of surgery is needed to properly separate 
out the items hotplug needs from kexec_file.

Thoughts?
eric
