Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BC2611AE2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 21:30:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiJ1T35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 15:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiJ1T3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 15:29:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E95D1AAE59
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 12:29:48 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29SIxDiN030026;
        Fri, 28 Oct 2022 19:27:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=1HJtMyoevjdC6xk2WkiB7eKDmwDKJA9J64xo+gqh700=;
 b=tkPdl58LZxcituXHCOaRCfcRWkOG28kZASXuB7XsqrmY+qEtustjpRROYXEp2tJva9Cs
 s4xLTaxxxqWrtZnuccIJIO8zIpWvOQAdGDy637zrvfjGaMogRMCF2vM4P8DV+sPysTcR
 bU/ognsFqU+/NfnI8UNaVyWcAsAW4ztIb9SaVy5PL9YPRP6L3RQgHznuKMPfDedUsFyd
 aDm5b3D2Xog1Sp1QjqMF51XAgN5OhII4k0zZtAeU0O0mnltS4bvZxuKXMeDB2uvFeElL
 yj58lc1g5qa2V6bEDNKQVHdC2l00ueqFSH+dOF+7kgOZ6aa9i4cvzgNdhE70XofB4EZa dQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfagv63em-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 19:27:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29SGLeQ9026558;
        Fri, 28 Oct 2022 19:27:09 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagrdjup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 19:27:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mc+kc0Vi/YuDahEEgkd28U9OPl0n774TsxnuOX2vJ1kFJk4b4rVDNFkou9RbhdhEmwlEUBUE0LRs5L6VCSNHTbDqfq+XDpUuUUVkJcn1ShBI9O0wO/mMzWT6Gfn6aN6nbTOQIx3CjrIYsV5q1jX4fZlYtUAdAvMlGCbowhy5vkkS07faGxnmaD396wMkKZfttysV3QULKuk/jLgVUidy1KOZtw5EMFY+qcC0mhgtJIKHVfSSvvS93fMh8PwrOR3Lk7cV92s+4cfxhh22vEAim+8PoSHev96AGDdwMquV/HDnJe2UKuh5AZE3Mi3zTKrLlqFcQHfTBVvGP08vVacBig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HJtMyoevjdC6xk2WkiB7eKDmwDKJA9J64xo+gqh700=;
 b=KjBotJSgeGZVKKj1pDbFG0ve8ytQ8H5y+hIOKWGLsrnwfnGAeozaBHgQS5WKV50zCNwjQs69PDr0ZXmTkworG4mBp4FdQwNpm4AHdYfV8pIhMCm0U7MIKYscVin1BHtSTmOCRv+VQNk1N0/2kVyPNNVcNLublOCEQ2SyqOHCxpHT//oiV+BFesKDGc1G+s5Wyr8zUNxf6uZvOcfbbZUfNxOhr4dCXVvGX+zwhPf15CrGlk0qRr6uC/X/lXf0TReb5bkTmmR0Tufg+hwhYYsRgLxxIsXdtQPFnJMONN9r3fWgHzT/PtpH96C5GNyF4XmXAhzuOHrNBfCh6RYbjktGrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HJtMyoevjdC6xk2WkiB7eKDmwDKJA9J64xo+gqh700=;
 b=LVz/9gmsm8UmKU5mmLrVib1YrCO66rls/moRlfkwkohSo66Lm0ee5zK8FQnl+9zmauo48RmwQFsitEmST6wQWaMsbkWb3i4ka5PItiZB8L+iratDkMoc2rdmcbdcd1Ezf5W3YgaciMMPn9jRyEFi2J4k3JpqsQPmf0Oo+gHmO3c=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BLAPR10MB4882.namprd10.prod.outlook.com (2603:10b6:208:30d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 19:27:06 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%9]) with mapi id 15.20.5769.014; Fri, 28 Oct 2022
 19:27:06 +0000
Message-ID: <ca43bd5f-8a74-9412-3d4b-52c7d5e54978@oracle.com>
Date:   Fri, 28 Oct 2022 14:26:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Baoquan He <bhe@redhat.com>, david@redhat.com,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        sourabhjain@linux.ibm.com, linux-mm@kvack.org
References: <Y0Dh4ieUUZ4oXa1/@MiWiFi-R3L-srv> <Y0b9apyIs+RpSo1e@zn.tnic>
 <53aed03e-2eed-09b1-9532-fe4e497ea47d@oracle.com> <Y0cmaPTKQuWtwIRh@zn.tnic>
 <Y0d+mFivS+88+Chr@MiWiFi-R3L-srv> <Y1e7Hw0PRDI9NxU9@zn.tnic>
 <Y1lIoTBNvHrKX5K9@MiWiFi-R3L-srv>
 <35c98ca6-10f8-b248-78c5-99fce7e66c65@oracle.com> <Y1uspLb7fLdtnQq+@zn.tnic>
 <d91f8728-6a63-415d-577c-bd76e69ec7f6@oracle.com> <Y1wL+ZrvD5gTZaKN@zn.tnic>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <Y1wL+ZrvD5gTZaKN@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR08CA0052.namprd08.prod.outlook.com
 (2603:10b6:4:60::41) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|BLAPR10MB4882:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d5e99d7-275a-41b9-6df5-08dab91a65f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mnVTofFBwzx5jim0PjKb3R6K/dA9BrOBXFCGrPz9JrXq1uS8axq8M6ji1Cf2mer/JDhXtzN5+bOoqns6AmsPSLVrq/CB8uo/UpR3lNnEz0Ca1zo2dNe4j9HcQRo30SK7yoPQM3Z/TLPBKqLbjhpZ34ByvhGb1XXn+ofbKalRFfiOKHMcfG6R03RG3mhva7x/hB4srEZJjeTz7LEoBiRq74zLBDohKoHvX/9sGceV2YQ+YdrKTDbrdoLD/rXUxO6fe7+ULCPSJD+uKhUXP5LWv54K6juz+RG4/buQcC3QUv89M2vsHRzw/PnO64/Us+x37ZC0MFaPAcZ3W6KHuQgjohM8sMCc0GWL9PEfRve4tNI/pT8Ql37tob7tT2rQBm8O584Rrw3A/dPtau4IHJfXG6A0T+CXUJoLXMlMfENF68ReilgbIdbVSFhzzJw80/QNefwxnLWF1HK5cJ2NKSvdkmfr5FDyj3adY0BJC9/kkL7Z4BLLUcYtIbWmfTlEeWqshYI3OjZRX8LqCeSaTIoOzhMjoh5wTpRLPIHptDVL3pFd2yPPzbD3WZlVtLxUlaRmDmFxGc6ZmRFvdtGYmPp7C4SO38pRBBQcsmf8dQz22gu5e5LqJYsH/nCgjXEMT+kSbvRDj4yWzQU8LcdIB87T4ND7Y6z+rLXEIiVy5pe83b8WzMBb2V92JavAYrHfjYTkQV4Td46DHbSKNUNHEgYZP+6KF/H19MsO+B7ZZTh8KIvslAUzlfgz2FkWr9Bcrg+2AnctfTCcF4u2+XO+8Vbn3g7mn4ajk+MmwzbjNS3zgK8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(136003)(346002)(376002)(451199015)(36756003)(31696002)(86362001)(31686004)(38100700002)(2906002)(83380400001)(478600001)(6506007)(53546011)(6666004)(6512007)(2616005)(186003)(6486002)(54906003)(6916009)(316002)(66946007)(66556008)(66476007)(4326008)(7416002)(5660300002)(41300700001)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXBTSGxBYzhBZnVpWHNRMlQxOTB3MmMxdHdCbzl1VmR0UVJiNGpYVlJRSjB5?=
 =?utf-8?B?b1pKZFB1RFlHZnJkTFRucGdXNXhmbFU1OS9VVjJkUkhjSXRWK1ltTUdsQlhQ?=
 =?utf-8?B?cGlwUzlxMENwODZSbU5qblEyNi93Ym81dytGM1p3b3hudW9lbjZGWlR6ck1r?=
 =?utf-8?B?Y0F6L2gxTWNhaUlsdlI2cDA3QlJqM0x0T3o5bFVIbCsxd1Q1cEhDcmV3TW1K?=
 =?utf-8?B?VHlVbi9qUi9lalQ1d25IMG5vUXBlSjVsSkVWdlNVM0JDSWdkS3JYM0lLVFZx?=
 =?utf-8?B?eWJMZkd1SDFSYUFORm9yNUJHRGpxTkpleUV4MTg3REoxYXZqdDZVYnRCTjlZ?=
 =?utf-8?B?ODlINGh5U05LeVdMWGI3TzJBYVRJRHQ3L0JhM3VIb3R5czNTdmtZU016MXp6?=
 =?utf-8?B?QS9XZGhnZ1VRdEtOR0xKZFBCWnEzVnpuVmcyOEthMGhUQThrUTlkZCtlSlhL?=
 =?utf-8?B?REw4djRab0RUdkFURGFySml1YWlrekVVVTBYZ0xocHdJeGdFaGtRTmFTaDBl?=
 =?utf-8?B?U0kxNFBjQ0FzSU9IeDFMdFZmZGxCNVdsQllnNC9nZ0hTbGVBQk1YcHhFaVVV?=
 =?utf-8?B?dVFQUnNtL20vdW45bmxxUHovVkVOQ2pNbjRpRUt1NVRuVUtUYlBNY1hscXZS?=
 =?utf-8?B?bzJ6V0lDcDljV1htN0pIQWFqL3kycWFCR2ZzZXpOVTV0OTdPMlFSMkk1Yis3?=
 =?utf-8?B?Q25XaCs3RUFtRnZCTzFONzMyRUwxTEloUmNiV3JtYkczb003ejdqcEk3TVlw?=
 =?utf-8?B?dHlQZmNqNklPakRXK29FWEFHRHpvejg5TnowbXhmSXlZRWRxcnoxVHZkMzJZ?=
 =?utf-8?B?NWRKTTMwQkVvRk9QUHp5emZMd2gxcndodElTOW15TUxpTTlCNFJXUGxqWkx4?=
 =?utf-8?B?cnJsWXdkRDUweHpXSnRoWWFMOEFjMWxGZ1duYXN4K0Vwb1puaXZEalQwdTF1?=
 =?utf-8?B?cCsvUDhsZC8vNEI1THBKcFlSZXJSWE8xTUgzVm9nWk5qSVVPTnVhK3pTWmh0?=
 =?utf-8?B?bWEycGZKWk5iSjlGQkxNT2NIZTg4bmUxYkU1UENKenVlNzB3bkM2RmpOK3hO?=
 =?utf-8?B?ZldQOEZuaE4vaC83N205bDY1VkdqTVpXdnJZSDRNbklvL0pSMmdvZnRwejV2?=
 =?utf-8?B?a21vR2JLTWl4alVxUzlRUnM1QzJNQUxYVU5zbTVnaDJIRnZ4VGtXdDU4VWQ0?=
 =?utf-8?B?K1dmMlp6M0lZNlNLNzhjYnk1dVhKSFoxT0tWZnN4NDRtdnRmMldMbjBkWVNH?=
 =?utf-8?B?SU1ub29FNkVEbHU0VFBWWUVuZWZxM292dFBqbWg1dmtCL0lsOWRDWmVZRVpl?=
 =?utf-8?B?RmtsWVFOUkpBWG5neDdWaW4vaWFFdWtUb3d6RzBUSU9FNm9BZ0Q1UHQzcXBR?=
 =?utf-8?B?ZkV2dHBBbHJHT3Rib1BvN1lNVGMxK29UL0tZVFhMNFMzaVRJSGozU1ZMRnY3?=
 =?utf-8?B?b1RNOW9UK3lYaHVHdU55ZU03em5wMkt4Y1lBVC9uc3ZLdnRqb1JvN0VUYitN?=
 =?utf-8?B?Q3R3SzgvOFFkdnUrbzY2aFJBNXNZRmc5Y0h2Z0ZnMnN0SllrRW9YZXNOdVhy?=
 =?utf-8?B?cGVqTklKSTN1QnY5aFlvRUo2THhxNXdNNzJNWGJKRHlXYjlmOHJ3Y1h5eGI1?=
 =?utf-8?B?cnh4amFHMDJvN211Y1BSL1BycmRkZ09PdWEzVGpobEx6ZmxEUi9LS0V4UHdJ?=
 =?utf-8?B?MUthWmhHc0o1MTBVU1BROWs4eTYwcW5TWVRIbWRnY1lSSnJDYmh1Z25qdG5y?=
 =?utf-8?B?Nlc0V3FaQUJYTVNna2NaTHd6NGRxbUtxTmlqRmh1S2Y5aU8rMyt0eVFjeWx3?=
 =?utf-8?B?VzZsdHVLVGcvNkRxQlh1YXFrY0F4ZmhkZitLYjZoazJKUGJOa0xHdEI4MUd5?=
 =?utf-8?B?dTJMOUlUS216YXRxZDBFdHJqOWRZMGVNYmFqQU0wMkVqSHJDdGNKM01KMi9m?=
 =?utf-8?B?cUs1WWhXTi9EN0Q5R1hVWHFyOGV3ZzdzY2t0ekVBMWFlZ1U3RHV3UzdvamNR?=
 =?utf-8?B?WEhiN0xoNEtoU1o1RDB2R3EwKzF0VTBza0lmV05lcnJRUzBwNFpYMUlFWnFQ?=
 =?utf-8?B?VVVJTXhNSUNvRFhwNXArd1V4T0lLcnZrb0VINHhJMXBIVW8weE92enRZMVlN?=
 =?utf-8?B?RG52c2ZpNDNGSjk3dGNWUm1aWnVjNWR1QWYxSGpobGlJajFrY21KTlJIV3lD?=
 =?utf-8?Q?txS3/Yb5jdor+f2oDoeYEkc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d5e99d7-275a-41b9-6df5-08dab91a65f8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 19:27:06.0551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VoddyhoLNk7XLQ0599OPBjjmMyryJv50O26Ay5o0Rv/KQQXioUQsW0e/BQjvC1zY9DZJRxMO+I/rIJpLZlWIW7VKDI45dOkChTWS1NUui3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4882
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_10,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210280122
X-Proofpoint-ORIG-GUID: G6xKHwMQ8GrbDKY3wkVf3NygrQMa6BtM
X-Proofpoint-GUID: G6xKHwMQ8GrbDKY3wkVf3NygrQMa6BtM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/28/22 12:06, Borislav Petkov wrote:
> On Fri, Oct 28, 2022 at 10:29:45AM -0500, Eric DeVolder wrote:
>> So it is with this in mind that I suggest we stay with the statically sized elfcorehdr buffer.
>>
>> If that can be agreed upon, then it is "just a matter" of picking a useful
>> elfcorehdr size. Currently that size is derived from the NR_DEFAULT_CPUS and
>> CRASH_MAX_MEMORY_RANGES. So, there is still the CRASH_MAX_MEMORY_RANGES knob
>> to help a dial in size, should there be some issue with the default
>> value/size.
> 
> Let's see
> 
>          kbuf.memsz =
>                  (CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES) *
>                          sizeof(Elf64_Phdr);
> 
> which, IINM, is
> 
> 	(8192 + 32768) * 56
> 
> which is something like 2M.
> 
> (CONFIG_NR_CPUS_DEFAULT = 8192 - this is because of MAXSMP which gets
> set on distro kernels)
> 
> Now, since userspace kexec tools uses 2048 for max memory ranges, that
> size becomes smaller - around half a Mb. And since y'all wanna be on the
> safe side, you can quadruple it and have
> 
> 	(8192 + 8192) * 56
> 
> which is still under a megabyte. And that's fine, I guess, on a big
> server.

Excellent, I'll set CRASH_MAX_MEMORY_RANGES to 8192! That seems a quite fair trade off of elfcorehdr 
size vs system size (ie 1TiB w/ 128MiB memblock size).

> 
>> Or if there is desire to drop computing the size from NR_DEFAULT_CPUs and
> 
> I think you should leave the dependency on the Kconfig size so that
> smaller machines which are configured this way, don't end up wasting
> unnecessary memory.

Excellent, I'll leave the computation as NR_DEFAULT_CPUS + CRASH_MAX_MEMORY_RANGES.

> 
>> It is my intention to correct the CRASH_MAX_MEMORY_RANGES (if we keep it) as such:
>>
>> config CRASH_MAX_MEMORY_RANGES
>>      depends on CRASH_DUMP && KEXEC_FILE && MEMORY_HOTPLUG
> 
> Yes, but don't leave it to the user to decide what number to choose
> - choose a high enough number, explain why you've chosen this with a
> comment and that's it.

I currently have the Kconfig item as:

config CRASH_MAX_MEMORY_RANGES
     depends on CRASH_DUMP && KEXEC_FILE && MEMORY_HOTPLUG
     int
     default 8192
     help
       For the kexec_file_load path, specify the maximum number of
       memory regions, eg. as represented by the 'System RAM' entries
       in /proc/iomem, that the elfcorehdr buffer/segment can accommodate.
       This value is combined with NR_CPUS and multiplied by Elf64_Phdr
       size to determine the final buffer size.

I'll work to provide information a better explanation as to the 8192 number.

Thank you!
eric

> 
> Thx.
> 
