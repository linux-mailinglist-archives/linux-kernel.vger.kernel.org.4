Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD595EB128
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 21:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiIZTUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 15:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIZTUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 15:20:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53474BD18
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 12:20:30 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28QHYRQQ005424;
        Mon, 26 Sep 2022 19:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=II/GgYruxBT/jU1W3Em2daD6cc4GIvVMtnhNKyQ/Xp4=;
 b=GYC6IJwgc5Y6LnzG0mcaPyRBZvsPB7P7Hdb/7cE0560DIDtLwttQ+Ed7ZP+Lsohfyift
 NlxU7JzYVoGi5hcO8NfpIaBzx+SvC5TE6s4jjIMe/KoyN+7UN+DS5yj3jba0HB888JZ7
 zpfzNWZxctH46Ov4sx3UcZcxvkqUk29Ko4SaUweEgoUmWUhEsaadSFi2CTY2h9YxsY7a
 UUA4zjt4DiX/xKT+4VR6qTxVp+Rjr8t9q9Sm25Q3IJUeDpT63bVa5Z8ZVQsYgI2HO7vo
 dayMXIbn518omC3jPbmEAmfFasn9Rlhaq0y3NQLbkwze0RmWZtITXL36lK3qyXv0q2cu hA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jst0kmhqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Sep 2022 19:19:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28QHAUTZ019170;
        Mon, 26 Sep 2022 19:19:50 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpvdj4sn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Sep 2022 19:19:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/wCvTeQccRoea+aMBHpGzIlJcCtlCTcUiTFdAaEtulGVt0IGMN9McI07n2rh94gExdnrIu/wMHDMEnwkZ4XJp6BMwzpAQ+pWH4oQG0UtK9MU6/YM+LysNUrZ/TL4rn+k+ZYjInRVum+QGWls10MeuJLfz6OMr38Wervo6my0+xqD2D098CL4NKCeVqtvL3sNMUrNsjYvwm2PXN/PLHjD+R8K1I5mCm8wJsHJUOLOn4tEasgj7YtZW1GQ4Lq8Mjb1wlVunduw3EooRtaMuSCgkP0BoOAe62xknys6QP1Ayed5aNONPE76O4OQ2hR50TcpN85x2btID68+nwervio/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=II/GgYruxBT/jU1W3Em2daD6cc4GIvVMtnhNKyQ/Xp4=;
 b=Qdgwc53v/On2eZdAcAP47G1DHTUL/IlW44w6pCoxT2I1ekxUG/ZryxDgJ6p+rK+zN451lpeO+Xuq3IiR3Nz3NF+qh9zzHCgctX1FBYoYFHUigu6n5xCyRdbRjaU3dzASw2kkmnsDU1VqOMpYbHhjXy7pfmpRd58SYO4R2WtN+1poaNzXzSGbW2mY1TRNfwmTkkysZCGQon1wpQZQtb7b0tVW+VdyRlqvUbSj/xPtZ340ZfjX8fZURuAP6Jbnx/V4rFGf8FyA2iSMXph9sIuv55OxbsmuT2Q/L/Xq2/WqN3sNPYh+T5R2bPbffMHtLrTRgTnviv5gqpDheVJ2qSHxnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=II/GgYruxBT/jU1W3Em2daD6cc4GIvVMtnhNKyQ/Xp4=;
 b=dUTXgbMRqdUcsUkhx7de7LO8HaK0TktpCJhRKUUG5GDjrq0tvnAb/iBnWWrEXFxdO/8cfPFgbBtvfrBmAn7RHPmDdPcdTdn073UiVd82W8jPtrTgo4NOf214kSIR6F3u8qDL2A4KQrdL0ecnim4+imn4xOlDqeg1I9H8JrdsDfY=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS7PR10MB4832.namprd10.prod.outlook.com (2603:10b6:5:3a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Mon, 26 Sep
 2022 19:19:47 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f633:11c5:8ca5:eb40]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f633:11c5:8ca5:eb40%6]) with mapi id 15.20.5654.025; Mon, 26 Sep 2022
 19:19:47 +0000
Message-ID: <52b23884-ef6f-df6e-f700-60fee62410dd@oracle.com>
Date:   Mon, 26 Sep 2022 14:19:38 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
Content-Language: en-US
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20220909210509.6286-1-eric.devolder@oracle.com>
 <20220909210509.6286-8-eric.devolder@oracle.com>
 <Yx7XEcXZ8PwwQW95@nazgul.tnic>
 <cb343eef-46be-2d67-b93a-84c75be86325@oracle.com>
In-Reply-To: <cb343eef-46be-2d67-b93a-84c75be86325@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAP220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::28) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS7PR10MB4832:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dca92e7-52d0-424c-bf77-08da9ff41371
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n89wK7bwmJSGSkW3/1muwO6rHwKSquQ4/SV6YkimlfcONa0QXm68XyBSWOn+e43gbTt5TFSeTgUsxVqZXdLiiUPOQ2fUBchLSWQrOkPyMzBbBRIUXCWJdgxIC40FlRLTbgtOHh8CV9BOCn2HqKFbnEfTCWKDC6gm+jRD1JemL6YT8jL2i36BjfJtmqEyH61yRKv1EvAHSw2iiSLxr1nN6BchSnUdp+H5+6qU4hiYQlBR4cvej3nx9Ro8jvM12m6+C7oPBTRV86NG/xPUGTgLbQ3i1lxHk5WWvzpDB60tyM0nc1vhhqbV3ma35sdUt/p0qzOz+AbNuhI3NmHSJ4J9dp58DUSsopnl0+f/jeqy5Fn4ptrx6qBmCxDFixvzAiGHtamrNj9F50LiJ0sq4VupjpmD08iBT0xu+OUluHwbxEin8Bcv29j1ExOWLcl2F1tglhbQF5Y+GXtG5aL3y0f+DPZzRahJwg3LLfttUtCRGndcpLEzp5hsBihdQdn7ZTzoJB1tPiWklxl2cMHScIhiFlM6MqUWqxiZ+U9tvIsHWEAafUq3R8dlfaYLJ0BccRt/yOr8X3nQ+mWm6g5ZssToIdksvvzFvP/KYItouBk3jCllYvrDdXADAV/mZzsuQyQTEKqif/vFKcZalNbTA2TxrNQSwMLuptbed0kwuzhuY01PgktDWsrMdj9wftkKTgvE3WGYPgoKwkJ6ADr+oFYoT0i+Nuje9SVlj3+P3do0ddD9VGE2vO6/sCnnopkpWnn35SNVA/7RoMKj2IBQTrAp2ZR8v7lZr0k303obqQvSymnddpG2274hfyttKgdWCAyP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(346002)(366004)(376002)(136003)(451199015)(31686004)(2616005)(36756003)(31696002)(2906002)(186003)(86362001)(30864003)(5660300002)(7416002)(8936002)(66476007)(6512007)(66556008)(53546011)(41300700001)(8676002)(4326008)(66946007)(83380400001)(316002)(6506007)(6916009)(107886003)(6666004)(478600001)(38100700002)(6486002)(966005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlhEczMwSFlyczB5OGxiT244NzlQUFA2TVdmWGtuODB2VlhaMVVVNmZSQzVi?=
 =?utf-8?B?blo3Y245N1g1ZDBROW1BVjRicUxSV1MrSXFvVG12dWlRWXhGYjh3Z3phODJZ?=
 =?utf-8?B?SEwwenZZWVZsOUZkV0N2QmFla0ZPS3lGQjZ0dW9pWWRVUHEybEtYaWdzeUw3?=
 =?utf-8?B?UzRnMzUweDBqa015MmZOOHJjNXpLYjZEMlR1V1FUc1dwWWNFejUrQ3JyRWJL?=
 =?utf-8?B?L3lWa0Q4Z0pMQTAxTHA0UG5RZy84M1FTWEgwRkJLUDNMN3NUQjZ5WmpYLzJm?=
 =?utf-8?B?bW5xMFJyVDVxS0JHa1VpRGN6NThjR3M1QnYwVnhFUWpMWFllYjZRNUpvYkZ3?=
 =?utf-8?B?N1NBWW9HblNMbEF6dUY0M0VPZVV6VEF4SUtUZlpISzJXMGxVcTZkQWpaNHlP?=
 =?utf-8?B?UnBrRmtMYzBYSWl0Z2VjL0dRUWRPN2trSGlhd1o2UkM2YlozalkrYVBXTml5?=
 =?utf-8?B?U1YzcTRsbmx0MEpMSUY3MlZDQ0c0MnVDK1NzMlV3azZpaXNpVEFCSWJNVllp?=
 =?utf-8?B?VW5CcGdseXlkNlNsK05Rc3dQcHVnRE5DQ1ZvZ3hFK0JpYThEcHMvWTJSSmJB?=
 =?utf-8?B?OCtHK2JQdkpQRGhHL3ArT3hBQk96cmR5R3pwS2Y2WjVmSnhlNytsQmlhcmxz?=
 =?utf-8?B?Zjh5NWVyYitUcDQ2bDh2V05samxYMTRHQ3RWSDB6REozd3JTZlI3UGh0ZHlh?=
 =?utf-8?B?OXFRa3JBeWhqM3Ftdk1tcUE4WGN1eWJqOVRqTXA0MTJ4M2xCSUtobVV1VXRl?=
 =?utf-8?B?TXkrdHFJQy9LcG9IU3VoY09iNDkrMllHU2hXUXRSK25MSTArMm96YjZZb2Ir?=
 =?utf-8?B?eWxhOTE4c2hzUy8rbWhVeFh0MlpVQzVhNkdQTjF0NnVIbk5RRk1ISlc3d0o2?=
 =?utf-8?B?aTdiUEVOQzREMFkwVjc4eTlzVVUvaWRRcncyc0tpYVNXYVRDdmhkV0VBLzgx?=
 =?utf-8?B?K2tLUDRRUDJOb3E1S2NaeVFwU2M2dlltTTZJTzdKQ3Y0UUtZM2RKSmRWQ3Jo?=
 =?utf-8?B?Y3ZxK3NLWVp2M0pSNC96TEFIWnlIY0tmcDltVnU2WFVWZUVsN2V3M01odStD?=
 =?utf-8?B?UVpnTlFqQ0dBcm9yV2ZpQkRDSjVkUGtIQ0pSOTI1SXNlMnpUS2R6SnUyTnJW?=
 =?utf-8?B?QW1JclNTV3VTN0JLdmZTcFF1UVdGdXVHbTF0VFRBVUdMdDF2M3RDbWtneVhw?=
 =?utf-8?B?RlJhbU91dFlNUm0waUdiMHpaOTFFa3ZwbGlGeVhxRDFPUXk1R1lodEZrN3Bi?=
 =?utf-8?B?UjJza3M2dmlHeWdvbDZOcUtFc3g0RkpJTTd3SDMrY0JSS0ttYy83SWVpT3RP?=
 =?utf-8?B?RU8vRHhmeExTdG5vazJTMGYzRGJNU091aTRQa0pKbERyWEQzanllVkM1VmxN?=
 =?utf-8?B?NzZtbmF2Y21SZFM1aXQveFZkczZTSmZSYVZrSGZsNjFIYXMwSUFYMUl3Unp3?=
 =?utf-8?B?QldhbWdlRjQvZ0I2bUVLcHhpWHR6ak5hQmR5aWllYUQ3eWo4QlhlTjZWM05z?=
 =?utf-8?B?TVlNVkFzWUZnVmhYUkZsYkhrZGw2UDJ6elFTRTVocE1OZ25Vck1ucStWOHht?=
 =?utf-8?B?TFI1alN5S0ZROWRBTlpZN0pWN0MxYVNzUmg3WTBndmovYmFSTlZmS1BRNFdo?=
 =?utf-8?B?K0dxNzd4dHFjNmpybG5ZdHRXaEZhL09JUnFWQ09kVTNjSGlaTWtuZWtHQjJ0?=
 =?utf-8?B?TFBBbWkyMEFkbGtKT0NTZDJoOWZuay93WWdvOTU0a3dkT0pSRUNhN0lpWVpJ?=
 =?utf-8?B?UjBmTzNFL0srTkhocy9iWmxYTkJnMmZpb0JQc3FLNmx1NEVnSWJJUjZCNHZQ?=
 =?utf-8?B?cERmbXZka1hYaWduLzlMRFZHNGNwL2V4NS9jcUU0U3BqTk04KzZVUW5VR3Nu?=
 =?utf-8?B?bTdmcVltUUdtQnlaVWhlbTFzanducDB3dUpDb0NjbXFDeDdkMFRXQW5rYWRv?=
 =?utf-8?B?VTgrbUZPYWQ4aUlMTWptRUo4V0ZEY1FQaFhDVE1LaytPRkdLTkh3QkRoc0k4?=
 =?utf-8?B?cWhUd1FqWitqdTFzbkZuTnhHSjVoYUlOeVFKdFhROWJvNDk5aE85dGdBWlFa?=
 =?utf-8?B?ZGo3UGdUYzBEWm9mNFRmcytMS1ZMbU9WbS9nNXpQRkZ5cW5aSWFvOUxmLzc0?=
 =?utf-8?B?WGRxS3hqaWFCcGlNVUFDa3ZlZldaY3crRDRwVitiRkhtSTdxTWNXZWsvZDc4?=
 =?utf-8?Q?a1YoJhjfldTT+6RU8dBAayI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dca92e7-52d0-424c-bf77-08da9ff41371
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 19:19:47.7154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IK6CuJ85/I23l2GTboY/zpmchjYbdX/fEueaK9kOAUn/UiN93OoMUd2RbrjcIm7PGU8+LJaKZBpYpgLUTrxu4Ydie7SiuwzozhAHh+/FSPM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB4832
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-26_09,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209260120
X-Proofpoint-GUID: rkpt184Ec8__zm9Gr67K2JcMuMBJc0K7
X-Proofpoint-ORIG-GUID: rkpt184Ec8__zm9Gr67K2JcMuMBJc0K7
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Boris,
I've a few questions for you below. With your responses, I am hopeful we can finish this series soon!
Thanks,
eric

On 9/13/22 14:12, Eric DeVolder wrote:
> Boris,
> Thanks for the feedback! Inline responses below.
> eric
> 
> On 9/12/22 01:52, Borislav Petkov wrote:
>> On Fri, Sep 09, 2022 at 05:05:09PM -0400, Eric DeVolder wrote:
>>> For x86_64, when CPU or memory is hot un/plugged, the crash
>>> elfcorehdr, which describes the CPUs and memory in the system,
>>> must also be updated.
>>>
>>> When loading the crash kernel via kexec_load or kexec_file_load,
>>
>> Please end function names with parentheses. Check the whole patch pls.
> Done.
> 
>>
>>> the elfcorehdr is identified at run time in
>>> crash_core:handle_hotplug_event().
>>>
>>> To update the elfcorehdr for x86_64, a new elfcorehdr must be
>>> generated from the available CPUs and memory. The new elfcorehdr
>>> is prepared into a buffer, and then installed over the top of
>>> the existing elfcorehdr.
>>>
>>> In the patch 'kexec: exclude elfcorehdr from the segment digest'
>>> the need to update purgatory due to the change in elfcorehdr was
>>> eliminated.  As a result, no changes to purgatory or boot_params
>>> (as the elfcorehdr= kernel command line parameter pointer
>>> remains unchanged and correct) are needed, just elfcorehdr.
>>>
>>> To accommodate a growing number of resources via hotplug, the
>>> elfcorehdr segment must be sufficiently large enough to accommodate
>>> changes, see the CRASH_MAX_MEMORY_RANGES configure item.
>>>
>>> With this change, crash hotplug for kexec_file_load syscall
>>> is supported.
>>
>> Redundant sentence.
> Removed.
> 
>>
>>> The kexec_load is also supported, but also
>>> requires a corresponding change to userspace kexec-tools.
>>
>> Ditto.
> Removed.
> 
>>
>>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>>> Acked-by: Baoquan He <bhe@redhat.com>
>>> ---
>>>   arch/x86/Kconfig             |  11 ++++
>>>   arch/x86/include/asm/kexec.h |  20 +++++++
>>>   arch/x86/kernel/crash.c      | 102 +++++++++++++++++++++++++++++++++++
>>>   3 files changed, 133 insertions(+)
>>>
>>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>>> index f9920f1341c8..cdfc9b2fdf98 100644
>>> --- a/arch/x86/Kconfig
>>> +++ b/arch/x86/Kconfig
>>> @@ -2056,6 +2056,17 @@ config CRASH_DUMP
>>>         (CONFIG_RELOCATABLE=y).
>>>         For more details see Documentation/admin-guide/kdump/kdump.rst
>>> +config CRASH_MAX_MEMORY_RANGES
>>> +    depends on CRASH_DUMP && KEXEC_FILE && (HOTPLUG_CPU || MEMORY_HOTPLUG)
>>> +    int
>>> +    default 32768
>>> +    help
>>> +      For the kexec_file_load path, specify the maximum number of
>>> +      memory regions, eg. as represented by the 'System RAM' entries
>>> +      in /proc/iomem, that the elfcorehdr buffer/segment can accommodate.
>>> +      This value is combined with NR_CPUS and multiplied by Elf64_Phdr
>>> +      size to determine the final buffer size.
>>
>> If I'm purely a user, I'm left wondering how to determine what to
>> specify. Do you have a guidance text somewhere you can point to from
>> here?
> 
> This topic was discussed previously https://lkml.org/lkml/2022/3/3/372.
> David points out that terminology is tricky here due to differing behaviors.
> And perhaps that is your point in asking for guidance text. It can be
> complicated, but it all comes down to System RAM entries.
> 
> I could perhaps offer an overly simplified example such that for 1GiB block
> size, for example, the CRASH_MAX_MEMORY_RANGES of 32768 would allow for 32TiB
> of memory?
> 
>>
>>> +
>>>   config KEXEC_JUMP
>>>       bool "kexec jump"
>>>       depends on KEXEC && HIBERNATION
>>> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
>>> index a3760ca796aa..432073385b2d 100644
>>> --- a/arch/x86/include/asm/kexec.h
>>> +++ b/arch/x86/include/asm/kexec.h
>>> @@ -212,6 +212,26 @@ typedef void crash_vmclear_fn(void);
>>>   extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
>>>   extern void kdump_nmi_shootdown_cpus(void);
>>> +void *arch_map_crash_pages(unsigned long paddr, unsigned long size);
>>> +#define arch_map_crash_pages arch_map_crash_pages
>>> +
>>> +void arch_unmap_crash_pages(void **ptr);
>>> +#define arch_unmap_crash_pages arch_unmap_crash_pages
>>> +
>>> +void arch_crash_handle_hotplug_event(struct kimage *image,
>>> +        unsigned int hp_action);
>>> +#define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
>>> +
>>> +#ifdef CONFIG_HOTPLUG_CPU
>>> +static inline int crash_hotplug_cpu_support(void) { return 1; }
>>> +#define crash_hotplug_cpu_support crash_hotplug_cpu_support
>>> +#endif
>>> +
>>> +#ifdef CONFIG_MEMORY_HOTPLUG
>>> +static inline int crash_hotplug_memory_support(void) { return 1; }
>>> +#define crash_hotplug_memory_support crash_hotplug_memory_support
>>> +#endif
>>> +
>>>   #endif /* __ASSEMBLY__ */
>>>   #endif /* _ASM_X86_KEXEC_H */
>>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>>> index 9ceb93c176a6..8fc7d678ac72 100644
>>> --- a/arch/x86/kernel/crash.c
>>> +++ b/arch/x86/kernel/crash.c
>>> @@ -25,6 +25,7 @@
>>>   #include <linux/slab.h>
>>>   #include <linux/vmalloc.h>
>>>   #include <linux/memblock.h>
>>> +#include <linux/highmem.h>
>>>   #include <asm/processor.h>
>>>   #include <asm/hardirq.h>
>>> @@ -397,7 +398,18 @@ int crash_load_segments(struct kimage *image)
>>>       image->elf_headers = kbuf.buffer;
>>>       image->elf_headers_sz = kbuf.bufsz;
>>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>>> +    /* Ensure elfcorehdr segment large enough for hotplug changes */
>>> +    kbuf.memsz =
>>> +        (CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES) *
>>> +            sizeof(Elf64_Phdr);
>>
>>
>>     kbuf.memsz  = CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES;
>>     kbuf.memsz *= sizeof(Elf64_Phdr);
>>
>> looks more readable to me.
> Done.
> 
>>
>>
>>> +    /* Mark as usable to crash kernel, else crash kernel fails on boot */
>>> +    image->elf_headers_sz = kbuf.memsz;
>>> +    image->elfcorehdr_index = image->nr_segments;
>>> +    image->elfcorehdr_index_valid = true;
>>> +#else
>>>       kbuf.memsz = kbuf.bufsz;
>>
>> Do that initialization at the top where you declare kbuf and get rid of
>> the #else branch.
> The kbuf.bufsz value is obtained via a call to prepare_elf_headers(); I can not initialize it at its 
> declaration.
> 
>>
>>> +#endif
>>>       kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
>>>       kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
>>>       ret = kexec_add_buffer(&kbuf);
>>> @@ -412,3 +424,93 @@ int crash_load_segments(struct kimage *image)
>>>       return ret;
>>>   }
>>>   #endif /* CONFIG_KEXEC_FILE */
>>> +
>>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>>
>> This ugly ifdeffery is still here. Why don't you have stubs for the
>> !defined() cases in the header so that you can drop those here?
>>
> 
> I'm at a loss as to what to do differently here. You've raised this issue before and I went back and 
> looked at the suggestions then and I don't see how that applies to this situation. How is this 
> situation different than the #ifdef CONFIG_KEXEC_FILE that immediately preceeds it?
> 
> I've included a copy of the current state of this section below for additional markup.
> 
>>> +/*
>>> + * NOTE: The addresses and sizes passed to this routine have
>>> + * already been fully aligned on page boundaries. There is no
>>> + * need for massaging the address or size.
>>> + */
>>> +void *arch_map_crash_pages(unsigned long paddr, unsigned long size)
>>> +{
>>> +    void *ptr = NULL;
>>> +
>>> +    if (size > 0) {
>>> +        struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
>>> +
>>> +        ptr = kmap_local_page(page);
>>> +    }
>>> +
>>> +    return ptr;
>>> +}
>>
>>     if (size > 0)
>>         return kmap_local_page(pfn_to_page(paddr >> PAGE_SHIFT));
>>     else
>>         return NULL;
>>
>> That's it.
> Done.
> 
>>
>>> +
>>> +void arch_unmap_crash_pages(void **ptr)
>>> +{
>>> +    if (ptr) {
>>> +        if (*ptr)
>>> +            kunmap_local(*ptr);
>>> +        *ptr = NULL;
>>> +    }
>>
>> Oh wow, this is just nuts. Why does it have to pass in a pointer to
>> pointer which you have to carefully check twice? And why is it a void
>> **?
> A long time ago this made sense, but it no longer makes sense. I've corrected this.
> 
>>
>> And why are those called arch_ if all I see is the x86 variants? Are
>> there gonna be other arches? And even if, why can't the other arches do
>> kmap_local_page() too?
> Currently there is a concurrent effort for PPC support by Sourabh Jain, and in that effort 
> arch_map_crash_pages() is using __va(paddr).
> 
> I do not know the nuances between kmap_local_page() and __va() to answer the question.
> 
> If kmap_local_page() works for all archs, then I'm happy to drop these arch_ variants
> and use it directly.
> 
>>
>>> +}
>>> +
>>> +/**
>>> + * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
>>> + * @image: the active struct kimage
>>> + * @hp_action: the hot un/plug action being handled
>>> + *
>>> + * To accurately reflect hot un/plug changes, the new elfcorehdr
>>> + * is prepared in a kernel buffer, and then it is written on top
>>> + * of the existing/old elfcorehdr.
>>> + */
>>> +void arch_crash_handle_hotplug_event(struct kimage *image,
>>> +    unsigned int hp_action)
>>
>> Align arguments on the opening brace.
> Done.
> 
>>
>>> +{
>>> +    struct kexec_segment *ksegment;
>>> +    unsigned char *ptr = NULL;
>>> +    unsigned long elfsz = 0;
>>> +    void *elfbuf = NULL;
>>> +    unsigned long mem, memsz;
>>
>> Please sort function local variables declaration in a reverse christmas
>> tree order:
>>
>>     <type A> longest_variable_name;
>>     <type B> shorter_var_name;
>>     <type C> even_shorter;
>>     <type D> i;
>>
> Done.
> 
>>> +
>>> +    /*
>>> +     * Elfcorehdr_index_valid checked in crash_core:handle_hotplug_event()
>>
>> Elfcorehdr_index_valid??
> Comment reworked.
> 
> 
>>
>>> +     */
>>> +    ksegment = &image->segment[image->elfcorehdr_index];
>>> +    mem = ksegment->mem;
>>> +    memsz = ksegment->memsz;
>>> +
>>> +    /*
>>> +     * Create the new elfcorehdr reflecting the changes to CPU and/or
>>> +     * memory resources.
>>> +     */
>>> +    if (prepare_elf_headers(image, &elfbuf, &elfsz)) {
>>> +        pr_err("crash hp: unable to prepare elfcore headers");
>>             ^^^^^^^^
>>
>> this thing is done with pr_fmt(). Grep the tree for examples.
> Done, thanks for pointing that out.
> 
>>
>>> +        goto out;
>>> +    }
>>
>> The three lines above reading ksegment need to be here, where the test
>> is done.
> Done.
> 
>>
>>> +    if (elfsz > memsz) {
>>> +        pr_err("crash hp: update elfcorehdr elfsz %lu > memsz %lu",
>>> +            elfsz, memsz);
>>> +        goto out;
>>> +    }
>>> +
>>> +    /*
>>> +     * At this point, we are all but assured of success.
>>
>> Who is "we"?
>>
> Comment reworked.
> 
> 
> Here is a copy of the current state of this code, for determining how to address the question above.
> 
> #if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
> 
> #undef pr_fmt
> #define pr_fmt(fmt) "crash hp: " fmt
> 
> /*
>   * NOTE: The addresses and sizes passed to this routine have
>   * already been fully aligned on page boundaries. There is no
>   * need for massaging the address or size.
>   */
> void *arch_map_crash_pages(unsigned long paddr, unsigned long size)
> {
>          if (size > 0)
>                  return kmap_local_page(pfn_to_page(paddr >> PAGE_SHIFT));
>          else
>                  return NULL;
> }
> 
> void arch_unmap_crash_pages(void *ptr)
> {
>          if (ptr)
>                  kunmap_local(ptr);
> }
> 
> /**
>   * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
>   * @image: the active struct kimage
>   * @hp_action: the hot un/plug action being handled
>   *
>   * To accurately reflect hot un/plug changes, the new elfcorehdr
>   * is prepared in a kernel buffer, and then it is written on top
>   * of the existing/old elfcorehdr.
>   */
> void arch_crash_handle_hotplug_event(struct kimage *image,
>                                      unsigned int hp_action)
> {
>          unsigned long mem, memsz;
>          unsigned long elfsz = 0;
>          void *elfbuf = NULL;
>          void *ptr;
> 
>          /*
>           * Create the new elfcorehdr reflecting the changes to CPU and/or
>           * memory resources.
>           */
>          if (prepare_elf_headers(image, &elfbuf, &elfsz)) {
>                  pr_err("unable to prepare elfcore headers");
>                  goto out;
>          }
> 
>          /*
>           * Obtain address and size of the elfcorehdr segment, and
>           * check it against the new elfcorehdr buffer.
>           */
>          mem = image->segment[image->elfcorehdr_index].mem;
>          memsz = image->segment[image->elfcorehdr_index].memsz;
>          if (elfsz > memsz) {
>                  pr_err("update elfcorehdr elfsz %lu > memsz %lu",
>                          elfsz, memsz);
>                  goto out;
>          }
> 
>          /*
>           * Copy new elfcorehdr over the old elfcorehdr at destination.
>           */
>          ptr = arch_map_crash_pages(mem, memsz);
>          if (ptr) {
>                  /*
>                   * Temporarily invalidate the crash image while the
>                   * elfcorehdr is updated.
>                   */
>                  xchg(&kexec_crash_image, NULL);
>                  memcpy_flushcache(ptr, elfbuf, elfsz);
>                  xchg(&kexec_crash_image, image);
>          }
>          arch_unmap_crash_pages(ptr);
>          pr_debug("re-loaded elfcorehdr at 0x%lx\n", mem);
> 
> out:
>          if (elfbuf)
>                  vfree(elfbuf);
> }
> #endif
> 
