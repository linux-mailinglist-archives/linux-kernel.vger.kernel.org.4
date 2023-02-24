Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCCF6A2317
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 21:17:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjBXURH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 15:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjBXURF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 15:17:05 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C05231E7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 12:17:03 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OHhxaZ003391;
        Fri, 24 Feb 2023 20:16:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=z6eDJXkPFShYSdM6FsH4LX7WjjAyhFPnu+j2SrhQlck=;
 b=VluVRL4/Sm3Vt5VJTbEwygTK2KyU3Zp+ew+0ZRgYEeBoe24ZwKd5wXTPrP9lhdJ9C5PT
 8DjISBXIRG2ylLy+MPmJpQpbDNWpkCSaOii8yYGKKc2IheUbeRqzaUQI2elX7Bmp2jB+
 /xXlptHhWypbDV2oGp+Jx50bfAP8ZPOYY6wkZYe/J7Pg0MCaNNgEnxRAv3KwngE+R4pg
 RNEWJwAQsNa9qxowBVyCBzjFNux+IF06kpJod8FkNtW0h3OyPv2jaR+ZCM4yUQm70QVF
 yjX1romwqQq+Ctig80eQBcXJh50ApylvXg2+5jhvlutCnyHnKNbRPN7BpsyYGJ5c1YJ6 SQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntpqcp5vw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 20:16:43 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31OJFPIv030263;
        Fri, 24 Feb 2023 20:16:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn49y6ee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 20:16:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGz41TfrdYK3oLha0Le8nxLt17By5c6FE2oqktxeevAHWtd1KID54T1kZKXhHyfY8Y6FyIs9vCvpawS+Q9srFeB+Uxd0JLLBOEQJ05yp1YwhJIKtW5DKWXSuqwEdGQ9irDyb8/S/4k4Qmwz2Z6YHt7KdQdD8rV91CdBzlPyK/COE4RzOO3G/A27vqsunPhr/V/rjLKs4fBfkqXHAMpLH6o638KT2fxPTYs9OeXoL40FmV2aQSN8QfEP7j8DOCDxHGj7T1uSSzNUVw+Okzta2UYxUwRwjZL49tsCxz6iSGIcbscsAS2sg81uXlxsw4FkL1dYY1/qJ6W+H28MDaV9f5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6eDJXkPFShYSdM6FsH4LX7WjjAyhFPnu+j2SrhQlck=;
 b=G7tZnm9tj8717I2XmHsLkLlTRguYWxhZOrjKhgD9LRvSzK9pgUlyTifIvR6IBy658ovmnmtXx7DitJb2yo6IRdcCDoRxU//1g9Ca2aiQt/cOBT3l1yY4VunJVu4PFlRrdDvzfYb6LGygHh37ntPERnEOcrJT5sOXwlYMVFAMtdVuaNz/zYRiY1HhfbvyYhg5wZc4+FDE4ZLVwEr/iZyRAGL67FC55fp+BpXGYpnShAAN1eYXJ9aNb6krh886SZxWxYn/6gHfg7BJkGa/yvKXdPpXY9F6XPUr3wF2LyQcdqrLMHv5hlQ7rXgj/x3oHiAhA5ep/LgOwjXxamSUihakMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6eDJXkPFShYSdM6FsH4LX7WjjAyhFPnu+j2SrhQlck=;
 b=NZfCOT6sa6y7S/Zr7oEI1TwaahxHBEKDHIa5vLgh/ruxgahfqrxkO986zbflbS4D2oIhZeILuHW9RDCP+DMyDBaC1ORDVcPVrQnMSHunAQa0ZEgpEwq79WjfEshjnMJs/Er3kDJSm0EXgCBI27e0CoOZSVaRsT8hoA0Tcv6Cots=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS7PR10MB4878.namprd10.prod.outlook.com (2603:10b6:5:3a8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.7; Fri, 24 Feb
 2023 20:16:39 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::671e:6486:6996:c38%8]) with mapi id 15.20.6156.011; Fri, 24 Feb 2023
 20:16:39 +0000
Message-ID: <4eeda077-c578-791b-8e48-e418744a7615@oracle.com>
Date:   Fri, 24 Feb 2023 14:16:31 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v18 5/7] kexec: exclude hot remove cpu from elfcorehdr
 notes
Content-Language: en-US
To:     Sourabh Jain <sourabhjain@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20230131224236.122805-1-eric.devolder@oracle.com>
 <20230131224236.122805-6-eric.devolder@oracle.com> <87sffpzkle.ffs@tglx>
 <dd03f47a-0017-6239-04e9-e796dca03c0c@oracle.com> <87h6vw2rwf.ffs@tglx>
 <7580421a-648a-2c4b-3c33-82e7622d9585@oracle.com>
 <d465173e-a31a-c4d6-af51-59d9ff0c2edc@linux.ibm.com>
 <24034f33-739b-e5f5-40c0-8d5abeb1ad89@oracle.com>
 <18c57fd0-2ad0-361a-9a53-ac49c372f021@linux.ibm.com>
 <ee58fcfa-1734-2992-d6b7-83f365a9e16a@oracle.com>
 <fc9f8ba4-967a-6e48-df73-67427c145141@linux.ibm.com>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <fc9f8ba4-967a-6e48-df73-67427c145141@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0350.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::25) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS7PR10MB4878:EE_
X-MS-Office365-Filtering-Correlation-Id: 40fd7fd0-2ee2-4bdd-247c-08db16a409a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c0cu58MoFC6S75d5azW7cUm0Wh5MUUKS5oTrbmNz/nlT2PvcvKwMFaVMwKNNSzUM4nyyd1Mvofv2nBkfDZlCNaTEuI+oeVaeT7Xn1JVxjPj450/dtys6RkrOJwK9DTsyiscfTCvLo/hc/FQ+pIz2Kyxatfde6roJS1/W8vUViBSr79PpHQwxQHsnxw9M2+On7+wsRbqXmMoOf7/DKugXYFCO159qjMOvVmDMQFRQ33DN3wHAylisZpWbl4SeHMTzieN9XL+aJGH5njBEaLnB/yFz2kNe752x9MTT6CYBalx6ZfrVREarMgAKhVzyRO3v/x976UpPMg9qbu4JJGnLbMnaKHyAXRsSw5DS1K0Am8LK4wJqKbDwYK3KPZzZHELRzBZV8sm6CNC68/w10hRIDicEhhPFTY9iM5pIhvCaDztsj5KyvQ36t61hAQU01nIIcj7Lya7uZxqjg0LtgYxDS4QfHdpN+JaJD9DmeHmA0Ki5zUusrK8cIb0v/JSqY7iWGdHeW5Sb40QrLG+ZPOEoMwpoq0Zb18zRpGtYUPfbh/D0OZ6q4GALraUkHfdH6xyQ4QcqZueDPTAvR2ZwSShrrlSPH53F5l4D011zUY7ffNvWZ5vxUicXsIwLieE7wn2ESSaNwoBXSH/SqEbUWqNTYIQxIxE1LNLmIi401f8pXeNdZd29GUkmKvvIu3DXDX2g5IH2FoBxtGojpPQ6J2bpYt/4jlnmNyC4KGQ50cb/ZAE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(39860400002)(346002)(396003)(136003)(84040400005)(451199018)(110136005)(31686004)(2906002)(83380400001)(2616005)(186003)(6666004)(6506007)(6512007)(36756003)(53546011)(7416002)(86362001)(41300700001)(5660300002)(6486002)(31696002)(30864003)(38100700002)(478600001)(107886003)(4326008)(66946007)(8676002)(8936002)(316002)(66476007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFNBMldBenNMMjBsSXdJMDFySXltVTVQSTZGeDIrOUovTWxJMloyNElzQlBJ?=
 =?utf-8?B?dHlkVHpnZXZOa0xmM0lkbUZrcCtHcDl3SUdYZU9xczFmemZVREV2WVVlMXhM?=
 =?utf-8?B?U052a3dKdnZqd3lXdnRZS1ZEd1ZOZEM1eXNUaXU4NCtpSzV1YXJuOGRwaWM3?=
 =?utf-8?B?TzljQWFtRjQzSlIyU3JkSi9ROWsreXJUdmw0VlNvYU1UYmE2Rlp0K2N6Z3FV?=
 =?utf-8?B?dFF0VnByZHZTZ0NZSzM4RHhaeE9ZcmRGQ0hzZ1ZmS0FZRjY2K2tRMHdubjVZ?=
 =?utf-8?B?S3lPUEFMQVhIV2hWMFdXeDZKdWZVcFVRVWRIbGFLMGR2cVZDUEtlSGphUW9O?=
 =?utf-8?B?ZlpwUEpncGI1TElvRjZsYStaQTRPQzFCWUZDOXdaV1kzN09DQ2JhRzJ1MDJt?=
 =?utf-8?B?OHVaYXIyaHBYb1pUbCtTUmhMNVllZG9GU0w4OEZjbmw4N1hRSC9SYURjLzdT?=
 =?utf-8?B?UDU0TzRjMENXclp5UXFSU0o2VWp2eUJsNlhYeTA1WXN0Z1ozcGRkckRMQkc5?=
 =?utf-8?B?MFVTWHpZTkpROW53M3VOQ1llVmwrcHpwOWhPZDVRQWJsL1M3YVducXE2QXBi?=
 =?utf-8?B?Y1BlL0gwNTJURUFHMXdySU9POFQxcU9neFNqWnRWTVFtZDNid2NTQkdDYXQ4?=
 =?utf-8?B?a1dJemlkTFlqWUtNamt6WnhyL2tHNWVqYVF1Zzg3ZkIxNmZVRjRleTZMVklI?=
 =?utf-8?B?TXp5QVdQaGU1UGNMZ09rOTdjcGNHc2U1NlhRUTlVQlRkSjdMVFpQclV3WEtr?=
 =?utf-8?B?N2Y2VXphU1VmcWg2ckFFS01CU1VBWWo4bTVwQ0N6RUx6QUpLVHI2SkV6MkFQ?=
 =?utf-8?B?OW1BV1ZVVUJ1VE5WOHI2VWVPaE5RRnNtSWh0WWZEV1BWV2phQWdIUHR1RUNs?=
 =?utf-8?B?NG5wdTZsREozY29XOVg0Zy80bnE2LzF6SHZQTzZrY0k5SlA4M3NUYy9nWVRW?=
 =?utf-8?B?NEI5OW5Ec01raURONDNDcFRVN3lTdzc4MjVjRm42ZEZGM2MxcmRPS3I2Q3BD?=
 =?utf-8?B?L212R1I4RGx5bVdrMmZtai9TL2RXN2I4ajRsZmlLVWFqMU15RytralgxTjNh?=
 =?utf-8?B?S2FoUnlKVzZIY253bEFCdDl0SEl2OUF1eWgrY2VRM3FEc0JpMHJlMnRpTXp0?=
 =?utf-8?B?OGRRN2JPMVZxRmEvQVorSG14VTVFMU91bWRlSjB1ZG01MUtjNERsakMxbXZ0?=
 =?utf-8?B?NnhIaUpiVS9RQ0dva1UvcjJ5Smt2QTRGanM3QVlQeDZHbEdDbjU2MGFXcWRC?=
 =?utf-8?B?eDJ5S3B6Q1hPWWVRMGtUcER4UmtCdFczZnlweW9XbHFpdStsMnE4QllLQXB3?=
 =?utf-8?B?bnRFWWJCWWhPNVdMNnF5WWwwYzRZUzFEdlMraVZURFh2VVlOQ1Q4SG1iQUdj?=
 =?utf-8?B?cmEyU2g5aWxlanNEYWhLb3FwUG91OFRhSHZDSFZtcHdmNlJ4Y1drd0t3UGhY?=
 =?utf-8?B?TGpKNnBTRWZGTXN3ODE3TTd1MFEvdmEydkowQTVvS0ZQakcxOVQ4TUxscE1X?=
 =?utf-8?B?eElxVVNIN09sWDlqWEVRWHZ3b0ZCODhPWTB2WEUvbTBCTzBaYVhycHlaRzRp?=
 =?utf-8?B?OHhPanV4ZjlFbW9QSVZrMFlvY3VTMWYxWXZWWjlwN1crZGtOUnRvUC9NQzJF?=
 =?utf-8?B?QVZhNjNKVXRzM0EvR0xHSk5ld3JKeUxNZWZjRDhHYnp2R3ZCN0o1alJHT2lU?=
 =?utf-8?B?U2FMNFQyNEFKZ2IvQ2RJSy9MUzEwZW5FWmQ5SC8zTDM2UWdHSTFab0ZhMWVT?=
 =?utf-8?B?V2xWd3VTUlkzWXlNSXFCK2hjYmR1Y3d3cUNBZ3ArWmV6b0Rvb0NJRTBZMXNS?=
 =?utf-8?B?UEhiYTcvSEJTb3cyR3l6cm5UODdBNjBuSk81ZzU5SkpPc3ppT1dUM01SVWFw?=
 =?utf-8?B?RzFQUnN2cUR4MVY0dGtBVWVSMW5VUTBRMWFDYzA0Z3J2TnlzZW94S3Bxa2l1?=
 =?utf-8?B?TjdxeTROVFExTFhMNXVjMS92R3hpdzV3QzF6S1p0VC9neGZsYk9nY0lBc2lv?=
 =?utf-8?B?OVNWbERVYmZ6amlqcEdYdHNJbjRGZ3RWdUlXTWxrVmtycDk5TmlKK1A2OTAv?=
 =?utf-8?B?ZDJTT0tHVThYeE5KVklrTVZhL0F2MDFGbThrZWl0cVVVSjFrbnM0TXVSQXQx?=
 =?utf-8?B?RENvR0t0WmRLSlBlMEw5L29WUk8xb3kxbEoweStpZ2VYV2ErUytrWXl4SWx1?=
 =?utf-8?Q?0Cv3CBYO73lfTpYCW77NuGI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RUJMa1BNTWFMMFpKREU0SUxNMk5FZWRYak55K1RBU0JJOU5zd04raDZUTUVM?=
 =?utf-8?B?SS9ZbkFzbjBGMFR1Ukw4K2piWDFyeFE5bXoySHRQeGV6Z3MyZG05TUloK25h?=
 =?utf-8?B?cHVRR0c2Y2RKc01UUWozZHN5c3Yvc3lLZjRPVFVZK1gwazBreGd0bm13dzln?=
 =?utf-8?B?YkhIVUVJM0xucVlSbWhTdTVIK3E1eDV1S1RrUTYrMyswMGpoQU9aaWxibUFr?=
 =?utf-8?B?VmZsUWRYMkNCRzgvK2FSRm52d1U2TC90WWhYamdxVHluTThzSmpYQ2xyNE00?=
 =?utf-8?B?SXRCVnJyYmtIdjhwd2V4N2ZzYmFkc0ZURVhwSlMvWEV2Um8zY1JBV3Q2cVVZ?=
 =?utf-8?B?RUc1WW05N3pINzdVMml0dVBQYlgxRHNWZTJSV0ZyRWpzTWQ1NDJMWmFleHp4?=
 =?utf-8?B?dTZ6WXZKRnlHeXgwZnd4WG9UR1BWNjlkNm5GWFloV0RSbHE2eSs3WTltY2Vt?=
 =?utf-8?B?VXd6NnRVcXhLVk84bHE1VHB0WWNEWElpNlo2QTFMRlpad0xCSkI1N1ZrZzVU?=
 =?utf-8?B?c2F4VC93bTVFN0xLMkdFaDZ2Y2U1bXhieUZRQ1E1cVFNUUlnRm81Z3NuenFH?=
 =?utf-8?B?UDQyMEZLNm0zWHJJTHFpR1lnSisxRXRoSG9sV0MzVExNWVVCSVhVN002QmtS?=
 =?utf-8?B?LzRqZ0RPUkljcGFoUVM0NUFuSmRyRjdLaEF0NVVmQVpZR2h1U2ZWUVlPRlpx?=
 =?utf-8?B?YlB0SVVXTXNQUDZSSU93T2ROcWdSMTk2L3I3YlY1Qng0OXB4SGNobkJDOWdP?=
 =?utf-8?B?c1JwOFBENGhiOFczREpIQlovRUFMcWpuMFhUQUZLelRmcGhsMnBaa2hXWTkx?=
 =?utf-8?B?VThCOXF6dVg4VkRyTlF6VU95SVVSampsRUJ4R1ovVGxOUjd6QWdWZno0cGtH?=
 =?utf-8?B?eHNWbXpUQ2ZheldranFiUXZTUTU2RFZLd1FLdEtyK3Y3Vm5jRmRKcGRWcTRI?=
 =?utf-8?B?ZElxVlNqUmhCSmx6bmoxYUNvMW11WDV1eUNQVER6MFRLNTROai9KVnZRMnFl?=
 =?utf-8?B?M0dUcHZyUTNOSXIyVjUvcmpkUm8xQ0k4bFBWaUxFaVk2U2N2TU1UNXpnVVpL?=
 =?utf-8?B?OC9LdFVINWYzaXJWbnBhNzZnaDRMSXByVmdkVHpxemUyNXgwZXZGeDRBRjRq?=
 =?utf-8?B?V2s0U2pvcms1UGVsT21rQ0V4bWxkUTNXeUcwbGtzMVl1RkV1Z3VmMHF6aXNa?=
 =?utf-8?B?bDdZYjYyQ1RrZnBsajYwOVdBSmJLRjdJZENpZnZTeFcrbjR3ZEp2dVR6ZzZ1?=
 =?utf-8?B?bzJaaVZiUldacVJJdW1KSzg0L3NqeE5pQ1Q3b1c3eEdTVktrZ0R1ZVVvbCtK?=
 =?utf-8?B?cDJpOFRaMXJuY2lzSGRyY0hMRHBpVHpLekV0U2lrNTNsOUNzYVJqaWVFRTRy?=
 =?utf-8?B?Y3V2QVhHWmZhaXdLR056dG9OWDFoNEg0OUVjN2xsRUtTYU1iZDMreG1Rb01R?=
 =?utf-8?B?MXpidXNQcGwwL1pTSEgrN014a3U4Y01hMURucGtYRzlOK3AvTERpdUdSS21x?=
 =?utf-8?B?OTM1enRmVVNZUlB4cUdVc0gvVVhsaXA2dmVJSmt0bVR2K3l1MnpGUmlwS214?=
 =?utf-8?Q?sihOD3FRb6HCMtWqd5YutdX70=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40fd7fd0-2ee2-4bdd-247c-08db16a409a1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 20:16:39.6466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K7o1L+iRBsz+OC/atK2jCCNLlJFIgncOOt87tx5ztWZe2XBFIkJtlCXBpp2UR62ivtE+/rG/87xOMMXHBYZ+plf5+NUuWvfAW+zxFlZUTHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4878
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_14,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302240161
X-Proofpoint-GUID: omN1fc-7oi7QMkzIQIOXrXDzrGd0GWCW
X-Proofpoint-ORIG-GUID: omN1fc-7oi7QMkzIQIOXrXDzrGd0GWCW
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/24/23 02:34, Sourabh Jain wrote:
> 
> On 24/02/23 02:04, Eric DeVolder wrote:
>>
>>
>> On 2/10/23 00:29, Sourabh Jain wrote:
>>>
>>> On 10/02/23 01:09, Eric DeVolder wrote:
>>>>
>>>>
>>>> On 2/9/23 12:43, Sourabh Jain wrote:
>>>>> Hello Eric,
>>>>>
>>>>> On 09/02/23 23:01, Eric DeVolder wrote:
>>>>>>
>>>>>>
>>>>>> On 2/8/23 07:44, Thomas Gleixner wrote:
>>>>>>> Eric!
>>>>>>>
>>>>>>> On Tue, Feb 07 2023 at 11:23, Eric DeVolder wrote:
>>>>>>>> On 2/1/23 05:33, Thomas Gleixner wrote:
>>>>>>>>
>>>>>>>> So my latest solution is introduce two new CPUHP states, CPUHP_AP_ELFCOREHDR_ONLINE
>>>>>>>> for onlining and CPUHP_BP_ELFCOREHDR_OFFLINE for offlining. I'm open to better names.
>>>>>>>>
>>>>>>>> The CPUHP_AP_ELFCOREHDR_ONLINE needs to be placed after CPUHP_BRINGUP_CPU. My
>>>>>>>> attempts at locating this state failed when inside the STARTING section, so I located
>>>>>>>> this just inside the ONLINE sectoin. The crash hotplug handler is registered on
>>>>>>>> this state as the callback for the .startup method.
>>>>>>>>
>>>>>>>> The CPUHP_BP_ELFCOREHDR_OFFLINE needs to be placed before CPUHP_TEARDOWN_CPU, and I
>>>>>>>> placed it at the end of the PREPARE section. This crash hotplug handler is also
>>>>>>>> registered on this state as the callback for the .teardown method.
>>>>>>>
>>>>>>> TBH, that's still overengineered. Something like this:
>>>>>>>
>>>>>>> bool cpu_is_alive(unsigned int cpu)
>>>>>>> {
>>>>>>>     struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
>>>>>>>
>>>>>>>     return data_race(st->state) <= CPUHP_AP_IDLE_DEAD;
>>>>>>> }
>>>>>>>
>>>>>>> and use this to query the actual state at crash time. That spares all
>>>>>>> those callback heuristics.
>>>>>>>
>>>>>>>> I'm making my way though percpu crash_notes, elfcorehdr, vmcoreinfo,
>>>>>>>> makedumpfile and (the consumer of it all) the userspace crash utility,
>>>>>>>> in order to understand the impact of moving from for_each_present_cpu()
>>>>>>>> to for_each_online_cpu().
>>>>>>>
>>>>>>> Is the packing actually worth the trouble? What's the actual win?
>>>>>>>
>>>>>>> Thanks,
>>>>>>>
>>>>>>>          tglx
>>>>>>>
>>>>>>>
>>>>>>
>>>>>> Thomas,
>>>>>> I've investigated the passing of crash notes through the vmcore. What I've learned is that:
>>>>>>
>>>>>> - linux/fs/proc/vmcore.c (which makedumpfile references to do its job) does
>>>>>>   not care what the contents of cpu PT_NOTES are, but it does coalesce them together.
>>>>>>
>>>>>> - makedumpfile will count the number of cpu PT_NOTES in order to determine its
>>>>>>   nr_cpus variable, which is reported in a header, but otherwise unused (except
>>>>>>   for sadump method).
>>>>>>
>>>>>> - the crash utility, for the purposes of determining the cpus, does not appear to
>>>>>>   reference the elfcorehdr PT_NOTEs. Instead it locates the various
>>>>>>   cpu_[possible|present|online]_mask and computes nr_cpus from that, and also of
>>>>>>   course which are online. In addition, when crash does reference the cpu PT_NOTE,
>>>>>>   to get its prstatus, it does so by using a percpu technique directly in the vmcore
>>>>>>   image memory, not via the ELF structure. Said differently, it appears to me that
>>>>>>   crash utility doesn't rely on the ELF PT_NOTEs for cpus; rather it obtains them
>>>>>>   via kernel cpumasks and the memory within the vmcore.
>>>>>>
>>>>>> With this understanding, I did some testing. Perhaps the most telling test was that I
>>>>>> changed the number of cpu PT_NOTEs emitted in the crash_prepare_elf64_headers() to just 1,
>>>>>> hot plugged some cpus, then also took a few offline sparsely via chcpu, then generated a
>>>>>> vmcore. The crash utility had no problem loading the vmcore, it reported the proper number
>>>>>> of cpus and the number offline (despite only one cpu PT_NOTE), and changing to a different
>>>>>> cpu via 'set -c 30' and the backtrace was completely valid.
>>>>>>
>>>>>> My take away is that crash utility does not rely upon ELF cpu PT_NOTEs, it obtains the
>>>>>> cpu information directly from kernel data structures. Perhaps at one time crash relied
>>>>>> upon the ELF information, but no more. (Perhaps there are other crash dump analyzers
>>>>>> that might rely on the ELF info?)
>>>>>>
>>>>>> So, all this to say that I see no need to change crash_prepare_elf64_headers(). There
>>>>>> is no compelling reason to move away from for_each_present_cpu(), or modify the list for
>>>>>> online/offline.
>>>>>>
>>>>>> Which then leaves the topic of the cpuhp state on which to register. Perhaps reverting
>>>>>> back to the use of CPUHP_BP_PREPARE_DYN is the right answer. There does not appear to
>>>>>> be a compelling need to accurately track whether the cpu went online/offline for the
>>>>>> purposes of creating the elfcorehdr, as ultimately the crash utility pulls that from
>>>>>> kernel data structures, not the elfcorehdr.
>>>>>>
>>>>>> I think this is what Sourabh has known and has been advocating for an optimization
>>>>>> path that allows not regenerating the elfcorehdr on cpu changes (because all the percpu
>>>>>> structs are all laid out). I do think it best to leave that as an arch choice.
>>>>>
>>>>> Since things are clear on how the PT_NOTES are consumed in kdump kernel [fs/proc/vmcore.c],
>>>>> makedumpfile, and crash tool I need your opinion on this:
>>>>>
>>>>> Do we really need to regenerate elfcorehdr for CPU hotplug events?
>>>>> If yes, can you please list the elfcorehdr components that changes due to CPU hotplug.
>>>> Due to the use of for_each_present_cpu(), it is possible for the number of cpu PT_NOTEs
>>>> to fluctuate as cpus are un/plugged. Onlining/offlining of cpus does not impact the
>>>> number of cpu PT_NOTEs (as the cpus are still present).
>>>>
>>>>>
>>>>>  From what I understood, crash notes are prepared for possible CPUs as system boots and
>>>>> could be used to create a PT_NOTE section for each possible CPU while generating the elfcorehdr
>>>>> during the kdump kernel load.
>>>>>
>>>>> Now once the elfcorehdr is loaded with PT_NOTEs for every possible CPU there is no need to
>>>>> regenerate it for CPU hotplug events. Or do we?
>>>>
>>>> For onlining/offlining of cpus, there is no need to regenerate the elfcorehdr. However,
>>>> for actual hot un/plug of cpus, the answer is yes due to for_each_present_cpu(). The
>>>> caveat here of course is that if crash utility is the only coredump analyzer of concern,
>>>> then it doesn't care about these cpu PT_NOTEs and there would be no need to re-generate them.
>>>>
>>>> Also, I'm not sure if ARM cpu hotplug, which is just now coming into mainstream, impacts
>>>> any of this.
>>>>
>>>> Perhaps the one item that might help here is to distinguish between actual hot un/plug of
>>>> cpus, versus onlining/offlining. At the moment, I can not distinguish between a hot plug
>>>> event and an online event (and unplug/offline). If those were distinguishable, then we
>>>> could only regenerate on un/plug events.
>>>>
>>>> Or perhaps moving to for_each_possible_cpu() is the better choice?
>>>
>>> Yes, because once elfcorehdr is built with possible CPUs we don't have to worry about
>>> hot[un]plug case.
>>>
>>> Here is my view on how things should be handled if a core-dump analyzer is dependent on
>>> elfcorehdr PT_NOTEs to find online/offline CPUs.
>>>
>>> A PT_NOTE in elfcorehdr holds the address of the corresponding crash notes (kernel has
>>> one crash note per CPU for every possible CPU). Though the crash notes are allocated
>>> during the boot time they are populated when the system is on the crash path.
>>>
>>> This is how crash notes are populated on PowerPC and I am expecting it would be something
>>> similar on other architectures too.
>>>
>>> The crashing CPU sends IPI to every other online CPU with a callback function that updates the
>>> crash notes of that specific CPU. Once the IPI completes the crashing CPU updates its own crash
>>> note and proceeds further.
>>>
>>> The crash notes of CPUs remain uninitialized if the CPUs were offline or hot unplugged at the time
>>> system crash. The core-dump analyzer should be able to identify [un]/initialized crash notes
>>> and display the information accordingly.
>>>
>>> Thoughts?
>>>
>>> - Sourabh
>>
>> I've been examining what it would mean to move to for_each_possible_cpu() in 
>> crash_prepare_elf64_headers(). I think it means:
>>
>> - Changing for_each_present_cpu() to for_each_possible_cpu() in crash_prepare_elf64_headers().
>> - For kexec_load() syscall path, rewrite the incoming/supplied elfcorehdr immediately on the load 
>> with the elfcorehdr generated by crash_prepare_elf64_headers().
>> - Eliminate/remove the cpuhp machinery for handling crash hotplug events.
> 
> If for_each_present_cpu is replaced with for_each_possible_cpu I still need cpuhp machinery
> to update FDT kexec segment for CPU hot add case.

Ah, ok, that's important! So the cpuhp callbacks are still needed.
> 
> 
>>
>> This would then setup PT_NOTEs for all possible cpus, which should in theory accommodate crash 
>> analyzers that rely on ELF PT_NOTEs for crash_notes.
>>
>> If staying with for_each_present_cpu() is ultimately decided, then I think leaving the cpuhp 
>> machinery in place and each arch could decide how to handle crash cpu hotplug events. The overhead 
>> for doing this is very minimal, and the events are likely very infrequent.
> 
> I agree. Some architectures may need cpuhp machinery to update kexec segment[s] other then 
> elfcorehdr. For example FDT on PowerPC.
> 
> - Sourabh Jain

OK, I was thinking that the desire was to eliminate the cpuhp callbacks. In reality, the desire is 
to change to for_each_possible_cpu(). Given that the kernel creates crash_notes for all possible 
cpus upon kernel boot, there seems to be no reason to not do this?

HOWEVER...

It's not clear to me that this particular change needs to be part of this series. It's inclusion 
would facilitate PPC support, but doesn't "solve" anything in general. In fact it causes kexec_load 
and kexec_file_load to deviate (kexec_load via userspace kexec does the equivalent of 
for_each_present_cpu() where as with this change kexec_file_load would do for_each_possible_cpu(); 
until a hot plug event then both would do for_each_possible_cpu()). And if this change were to 
arrive as part of Sourabh's PPC support, then it does not appear to impact x86 (not sure about other 
arches). And the 'crash' dump analyzer doesn't care either way.

Including this change would enable an optimization path (for x86 at least) that short-circuits cpu 
hotplug changes in the arch crash handler, for example:

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index aca3f1817674..0883f6b11de4 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -473,6 +473,11 @@ void arch_crash_handle_hotplug_event(struct kimage *image)
     unsigned long mem, memsz;
     unsigned long elfsz = 0;

+   if (image->file_mode && (
+       image->hp_action == KEXEC_CRASH_HP_ADD_CPU ||
+       image->hp_action == KEXEC_CRASH_HP_REMOVE_CPU))
+       return;
+
     /*
      * Create the new elfcorehdr reflecting the changes to CPU and/or
      * memory resources.

I'm not sure that is compelling given the infrequent nature of cpu hotplug events.

In my mind I still have a question about kexec_load() path. The userspace kexec can not do the 
equivalent of for_each_possible_cpu(). It can obtain max possible cpus from 
/sys/devices/system/cpu/possible, but for those cpus not present the /sys/devices/system/cpu/cpuXX 
is not available and so the crash_notes entries is not available. My attempts to expose all cpuXX 
lead to odd behavior that was requiring changes in ACPI and arch code that looked untenable.

There seem to be these options available for kexec_load() path:
- immediately rewrite the elfcorehdr upon load via a call to crash_prepare_elf64_headers(). I've 
made this work with the following, as proof of concept:

diff --git a/kernel/kexec.c b/kernel/kexec.c
index cb8e6e6f983c..4eb201270f97 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -163,6 +163,12 @@ static int do_kexec_load(unsigned long entry, unsigned long
     kimage_free(image);
  out_unlock:
     kexec_unlock();
+   if (IS_ENABLED(CONFIG_CRASH_HOTPLUG)) {
+       if ((flags & KEXEC_ON_CRASH) && kexec_crash_image) {
+           crash_handle_hotplug_event(KEXEC_CRASH_HP_NONE, KEXEC_CRASH_HP_INVALID_CPU);
+       }
+   }
     return ret;
  }

- Another option is spend the time to determine whether exposing all cpuXX is a viable solution; I 
have no idea what impacts to userspace would be for possible-but-not-yet-present cpuXX entries would 
be. It might also mean requiring a 'present' entry available within the cpuXX.

- Another option is to simply let the hot plug events rewrite the elfcorehdr on demand. This is what 
I've originally put forth, but not sure how this impacts PPC given for_each_possible_cpu() change.

The concern is that today, both kexec_load and kexec_file_load mirror each other with respect to 
for_each_present_cpu(); that is userspace kexec is able to generate the elfcorehdr the same as would 
kexec_file_load, for cpus. But by changing to for_each_possible_cpu(), the two would deviate.

Thoughts?
eric
