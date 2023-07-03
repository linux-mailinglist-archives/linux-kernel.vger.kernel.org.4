Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031E674618F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 19:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjGCRw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 13:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGCRwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 13:52:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B135FC2
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 10:52:21 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 363G8E5O026238;
        Mon, 3 Jul 2023 17:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=28yXbymEz3ANKb2ikl9to739c0KzjJQ3hnl6I4urb7k=;
 b=o6QZNOWZlK4fsAiUHM99/qlpjjfUNWFidwwTGkUKITHFJ0eP9VGe6Tb/gFkNBc6knDF3
 lhvDcb6ZOObn8F7dk7Q6IDKIGRuZjFcSWd9zLkbvnJUc+/mA1Xl+t3LbcSyO9Q8Jr4iq
 beuMT//KprwybII7tmwnCuD76WGSYvlDmeJY51y7CWVnuxAdr5YmLS1uEL7A3lUAmpuo
 ZzHlsbzFU4NOIT7elSw7JbesFNxzq4IvNCwJTzogYrWb+6SiPfBq7qOwxMTz+dLkOiuD
 6U2X2Mji1hAVqEyfZR1tKn2e3kQeNSCrFAGgY0GqK6X7lby5tkusliod5CMJoUhvcW1/ 8Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjajdb7ma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 17:52:06 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 363HY3B4004200;
        Mon, 3 Jul 2023 17:52:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak3v2uc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 17:52:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zg+ZPCLiM0B217EJNgtAvpOVtTxAqRq+5ZX90KTBw5ZmLuTFB4+Jau7pXbTLRQMFHm9h2BpnFGDvf8iOI4lH2qUZu1sRiwzzereG5g4xxigNPr7m6DTc/4OChzUlsvz1WO1JTtYsNkTNztCKXLE1sbBN6A4dlGAEOJmSuRrMATvakGErXCTnDhhhdGYyp4yWsxAmdzlKohxZK0EsWnJqT7kPfvVyulgjfv4IUVhd0IuWc9WiXyS/+uqWiXUZVI5Pz2DfV1OjmFjDcLGQqUERfy3xYzfuFwY/NGXX9bBVx2c3s6qwxRdburn/zf7ZH6Ho1ngtstreSWyFSapL++/uFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=28yXbymEz3ANKb2ikl9to739c0KzjJQ3hnl6I4urb7k=;
 b=jzG5h95DKLqBuT3UFMQiX3CCZB0e3uXPRRa9/680J2M0L4wZiHr6iwcD7TRtlUlsMwh4tqZ5ipJG+bW8I7L8Bn6Xg3SssqR8MyVsd3sbvvqWEbTJWJCMLMfP+FnWzxn4K1CloHr07zZJ9YzXZbaXaZ8vxbl8tIoMt/M345z4ZyWW4WraglzJMxNLV/7F3pgp1+7v3q9Brs1LSNIJSXEOhfzBsv7r7cgm/6vFvGmjNqKWQ0X9ucAjxMjVygh75esSE+zvmMQ5rHssUHKt5wgkklcRGThs1EdvQ/1LVq3QSSxVR1yFHddgQctjU3+vGptOCwNoxtfC+sNUC50w8ytCVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=28yXbymEz3ANKb2ikl9to739c0KzjJQ3hnl6I4urb7k=;
 b=Hl9ICGe0g32ozp3bgND+VvyeiZkv4jKEx9DcjMvQWcvv/kx0moYoIbNhcnrTa3QrmtCh+UpPliJZY3wQ/Y7ruX/PbE9SHeik63+MLEoNHzXL6uZPLV3CpJclgHDbYHtAwJDdiDL2WLgRvFd6g3Empt1eesVQEhORLI9QCqKiWV4=
Received: from BLAPR10MB5009.namprd10.prod.outlook.com (2603:10b6:208:321::10)
 by CO1PR10MB4785.namprd10.prod.outlook.com (2603:10b6:303:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 17:52:03 +0000
Received: from BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::2bb9:5d2e:a65b:e731]) by BLAPR10MB5009.namprd10.prod.outlook.com
 ([fe80::2bb9:5d2e:a65b:e731%7]) with mapi id 15.20.6544.026; Mon, 3 Jul 2023
 17:52:03 +0000
Message-ID: <573ce7fa-d64f-7351-b64d-01692fc87512@oracle.com>
Date:   Mon, 3 Jul 2023 13:51:57 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] x86/xen: fix secondary processor fpu initialization
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xenproject.org
References: <20230703130032.22916-1-jgross@suse.com>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
In-Reply-To: <20230703130032.22916-1-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0056.namprd17.prod.outlook.com
 (2603:10b6:a03:167::33) To BLAPR10MB5009.namprd10.prod.outlook.com
 (2603:10b6:208:321::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5009:EE_|CO1PR10MB4785:EE_
X-MS-Office365-Filtering-Correlation-Id: 7702ce34-46f3-4e5a-22a8-08db7bee352d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m11cW2g0hc0kCBB5yhI5xbY1nkPLFA9qxCfam4damnt/1sm581Z7lesRwEDLp7qUgFcIhrONmLgQUfyHIR0FvVwPJP82Y+M7Pifw/UgwCLIWn+1UhR4EQY3Bl9jWtmwyNV8dQHIXA92BV+baAzn/VJab+/4UudIy81ILkdp1nDNL1I0YEP3b0R/S4sF5UBx0dWtrQazLYFNmSDXjLB9Jd7I0Dl48quTpCeYRni5PlcULJR94nLitViHBax04QLH6hT6+8Q/7DgJAJ0VCwKfHuUICBtYJWC+LlqP+89cSRHVhP9u1pMZFFEpmw/Sy615FthK64jtsJRxG3mxWNVFRQ+3QDwM8VrU4bB96gpa4Zn7YOup6gT0x1FS1V2W9J8Rgiybb0wvH/ylbeyWNmLrkzn42Xs/Ybr9b8eAHSoZQ8gprsF792Q+vqHvyJunb8BeBi2sTrHEhzaNi/O1BSvUXF7Wrssq4yPMT3C2xmmDsHQjxtCIWy3VhltR7lwN+ISOvuNt5u9850SlQDXfrn0M+WGtmgcyqjn1hRpITR+c46b4s8w9+sR3ZG38ykR5EJXg0p+6sVJ6UsJMK+FtFIHUBrdJkZjM1Ug2CxoRyZErGic7cMCxJ4NFhFO50hfmaI+M+QtdFGMO6SbdPSHyCAPZEsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5009.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199021)(4744005)(2906002)(41300700001)(5660300002)(8676002)(8936002)(44832011)(36756003)(86362001)(31696002)(186003)(2616005)(31686004)(478600001)(26005)(6512007)(6506007)(6666004)(53546011)(6486002)(316002)(4326008)(66556008)(66946007)(38100700002)(54906003)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXN6VzF5bVVwcVhpYktoZ042bEpkWWhvNlFCOStuWnNJRmZ2QUJsVUVnMExu?=
 =?utf-8?B?dmRJRFdldy9KY0VzTncybmtkMTdocFgwSkJlOU1ON2dJb0txZzNwVWRYSG9h?=
 =?utf-8?B?MXBkaVFuTWtOd0ZjeVo4L1lnd0xPWmFhMk5xRVFGek5yYXpCVHYySGhwS3Y1?=
 =?utf-8?B?dEtzL0VDSlhpVzRtY21TZjF3SWxuK2FUM1hFS2ZKVkd0MTZLZ3RwY3FmT1pB?=
 =?utf-8?B?L2RxMGJYTEtJQlU2c2N4T0xvK0d5UUFDK2huMlhaVnQ2R2Rtb0ZWd081UEFw?=
 =?utf-8?B?aUN2WllNaG81dUdLVkNRb2tHY2g5NVkrekNIOThOSTJkNmdKUmhuNGF5TTZ3?=
 =?utf-8?B?aThMWU1hYjBWajV1aWRGWDQrdmxIcVJOZ0pueDVReU1JWHlsaXRsNzhOVm9T?=
 =?utf-8?B?S080RVYwZHNJWjZtMEVBelNRTmNHbDc0SFpKdnpTa3RXWTFIOFVBdHVLMktD?=
 =?utf-8?B?Q1p3NnVSeUJmV1lrM2F4VGZVeDZYL3A4YmpzWFZtRXhURk9Sb1V6THRiUXg4?=
 =?utf-8?B?ZG9mQ1ljVFRvU1FXalRBbndTOGpPUGhQOVQ0WE43OUl4cE1zWWY4aHdVdXpW?=
 =?utf-8?B?YmY2dzdLRzZ2eUd6WjNESnNoQ3poOXdCVkVNdGMvaTlvUkJVaUlITHI0OHF2?=
 =?utf-8?B?UlFCKzFhRnNUazgyb2g3bnpJRGVScUxMVkE3dVpCWkdsalU1dzc0ZnlOMjVV?=
 =?utf-8?B?RU5hZEp6N1c3bmM1MEJMZElCTEFYcHY4ZkxaSFdndUVuWkRVbG9YaEtIREgw?=
 =?utf-8?B?dDRVN25EWFdNVnlCMmUrZm5zdzZ3OWdSY0h4c1VHTXNEYkJFTUFwNFovbkRP?=
 =?utf-8?B?ek0zRmZtQS8xajJaeTRMV0JEMXhvdktONVlyb2Z3SkxZb0p1ZEVLQ0FxOTdq?=
 =?utf-8?B?a20wcnF0L0syUlhBZ3Q4b2ZUZWRYamFhTzZYb2p3LzQ1Ym8xWTU0MFAxKzJt?=
 =?utf-8?B?bG1veWgzcGxKTGhSUmZ2NGNmTmtGaHpkbVFvQWlpL0h1V21HK0FEMDdESTVi?=
 =?utf-8?B?eVZ1NDhXYzdHOU11Y1BtOGdwTHFrM2lsdUkrM3VIcXpwbGc5ZW1EZmptUTIr?=
 =?utf-8?B?cEF6aThzK3lRYlc2cEZCNjc2MmY5TTQyUkN2K2pBQk9qZ25RcVc1Z0VPeng2?=
 =?utf-8?B?a0dkZDhIalVHNHR0MmNiOTFWR1dFUktXNkcyWUl1NjlIU1lzUS84TzZ3OGFP?=
 =?utf-8?B?UGt4b25KOE81cGhTNTlhVXhHR1lEL2srUDdBRWMzb01oNHU1YU1LLzBrbDV5?=
 =?utf-8?B?enNIM1JVeXVmc0p4Y2szamM0ck9vazI2RTMrNHVDbEt3T09OY3dKNVRJYUg5?=
 =?utf-8?B?N0NzNVpIR0sxRzV6WWxxY2FmQWZkQTVobENaN01uL2pNZk92K2ZoQ2JsU2pS?=
 =?utf-8?B?U3kvVGdwdmZ4Q3hnREtKWStpRHl0aTdtcGhPcnl4Uy82Q3d5ZVRJTEpSS04w?=
 =?utf-8?B?UHNFR29nLzc2MUFPVmRmM0RxaW5WWmE3Q0tBSVF5RFlBMFlnRFVJQnZiczFF?=
 =?utf-8?B?dW5iSU1GWUQ1c1VoYTFUR3c2M3llYThyN2N3VjdoZThjV2JnU0Fia2VORW9P?=
 =?utf-8?B?RHhld1N2SzRjOWMzd0FTZ0Q0NGoweTRoKzRuWWRhTy9YbUlOcEU2OS9oWTIw?=
 =?utf-8?B?YWRrMTE0VjF2NUhubkJIYy9mU1lxMXJTUGhzWk5lc0U5S0U5M0ZUUmppZFRE?=
 =?utf-8?B?OHFOQWFxNXBYZ01ONU9OTC9rUlZpUjlKZHZKTzZkYkxhU2JXYVZlL2lOMjNo?=
 =?utf-8?B?TzB1SVdLZ1F6d0N6d1pqeW51cktReElKdkdLZEg2UklyNnVoUHNnVnZGVG03?=
 =?utf-8?B?dVNjK1NmM2dQeWx1U3BXdFViT0EyRmUrbmNPS2tGSGhxR2pHU2l3RGYvY1E2?=
 =?utf-8?B?bFkyRUVZMmFKSzA1UGUxQU9WM2NQQUgwVFpyN0RFVnJ2OVJFQTVCU0k3ZFNm?=
 =?utf-8?B?d2RmeHRjUERMYUZ2RFlqWHdVb3Q4aDhXL1JzS2JvUll6KzhHZjErSUxZZXF2?=
 =?utf-8?B?bkNaZjI1dFh4N3hVcTd4a3BJYitITms3V1ZpbnVFVGlBbnZqYlM3MDU1THhW?=
 =?utf-8?B?eVNvTTNvbVJyNHk1UWVOTmpqZE8zOVh1c0dDenhyLzVCbzZCYWRaT2dNMk9i?=
 =?utf-8?B?VklOZlRkV2lXTGYrZlg4VkM1Z0V0QzlORzZDUFJzbGI2K1lCek5rbGtFOFFw?=
 =?utf-8?B?OVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?OXpIdkFmNnpPTm9XeFc4VTNrb0EzVTdFSjd0eHh3TzJ2WHQwOE1SaytJUG04?=
 =?utf-8?B?NVFDNG1vYmtWeWRpODhyazI1UndUWmJqSHN1TnFIK2szRnR0QWJ1WTZ6VGJQ?=
 =?utf-8?B?NnlsQkdGc2xJb0Y2NENFdE9iUTMxWXlMMFU2VGFlQ0R0SWVhWWZQc0RTd1Jn?=
 =?utf-8?B?UU51a05haTFjcDhrb0Z2TmprVk9VbDFyRllQZTRGbW5KQUpoZjFBUE9MUWNv?=
 =?utf-8?B?MHhxbnpDbHBtdWdtSGpNN2M1QVZocDdXd01LYkV3MGJPK29XbHhxRWhoV3lo?=
 =?utf-8?B?eEYraC80MzZuT0M4L2d6TTVCbXkxQ295SXY5anNzeWdObXArVGxDSmFMWGZk?=
 =?utf-8?B?VE42cmQrb045US9uelM1c2RYaXdWbTVTRktJa2RBK29kcXc5L1ZxSkI5OTQr?=
 =?utf-8?B?dllIcFdOSnJ1TUdYNzZ5UVBsVmpubXFFendRWnZaRjdRdmxmZDFiQmVHZzRN?=
 =?utf-8?B?M1BBYldCRE05K1JZRmRvS3oyeXIzM1VlbFhVc2xYRFFKQnlkU3JNdU5NQlpu?=
 =?utf-8?B?OE5VVzRzZXFKWlNXendVdyt1OUFBQ0xvZ1E2dmU5Nm9rQnhIREZrV1BMbXZL?=
 =?utf-8?B?ZWRDcndSUWN2M1IrbmJOaGlyODA1N0lLUTViM2dsR1BOZVl5ODc4dmt3QzVS?=
 =?utf-8?B?bTdjNEVPY01RUm1Mb01ENUV3SktSRmI1cWhCNWZyQWw0WU1hQWQ4VGVCV1dk?=
 =?utf-8?B?VkxhQnJhZ1RtWWREeHZQdGJ4bHA1THF0NmFVS2xOOWE3dEdPd2pUODFydll0?=
 =?utf-8?B?bE1weEl5T01xVHJPS3hCV1BJSEFUQ3F3OStkTHV5dnpubmQwajhWNUhMakUr?=
 =?utf-8?B?ZmkwQ1pZVUpTZHVzdWhFOENaM29ZRG9rcXNncjJ4YUwwVk9GUEVzRXFCblJB?=
 =?utf-8?B?N2lseXBOejVGRUJvZiswZEduZ1ovV1ZpcEM4ZTl0WlZWZjhWLzFiM29LUm4y?=
 =?utf-8?B?cms1ZW90ei9nMHRXZWVtZWdCOCt4akVuZnBaQ2Fwa0F0NHJZdTRIYUZjQjRs?=
 =?utf-8?B?ZEw3bzROWTQwM2FnZ0ZGejhYOGU4YlRGbm1BZC9xWkNaRkJGTmw3TU51OFpu?=
 =?utf-8?B?K2VaSFVMc2gyakN0YWRzb2dSK2ltZkZDdWtNZUlCOW1sSTJsOEQ3VjJ5N3pt?=
 =?utf-8?B?aXpDUDAycm1XUW05aEd6aWhLUWttRHhRR3VuaTVNQ2d0bFpaVkc5SlBQQmI3?=
 =?utf-8?B?QXdSbkFJWTNVTTNOYnhYc1F2aS93N21Rb0lNb0xTaDFRaFJ5TjRhd3pjOEpH?=
 =?utf-8?B?YUdkVVdzdnhLaDlGdjFoREFNU25NRjJJUHplUmhGVEdDU1ltcUFiTGRob3J5?=
 =?utf-8?B?aU9NdzdablRzRXFpVGFZbU8vcDhnNlFKekErRlpqU3Q2ZVJORUVXNTU3cnpI?=
 =?utf-8?B?ckYzZ0J6eC9SYWc9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7702ce34-46f3-4e5a-22a8-08db7bee352d
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5009.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 17:52:03.0184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fYaZgw6LY/VcF9JsLQb8fhp+fjwPHJhG0KPihy5ChJWHzZenyHBC5SSTfCxlK8CpbpWYy0rNmmhSbeig9UDQkm11FZfSrMlRYs8UXjXcYII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4785
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_13,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307030161
X-Proofpoint-ORIG-GUID: vFqCnZoahiG2G0JeDYtrxbPHv_hRygQU
X-Proofpoint-GUID: vFqCnZoahiG2G0JeDYtrxbPHv_hRygQU
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/3/23 9:00 AM, Juergen Gross wrote:
> Moving the call of fpu__init_cpu() from cpu_init() to start_secondary()
> broke Xen PV guests, as those don't call start_secondary() for APs.
> 
> Fix that by adding the call of fpu__init_cpu() to cpu_bringup(), which
> is the Xen PV replacement of start_secondary().
> 
> Fixes: b81fac906a8f ("x86/fpu: Move FPU initialization into arch_cpu_finalize_init()")
> Signed-off-by: Juergen Gross <jgross@suse.com>


Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

