Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089115FCC45
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 22:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiJLUoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 16:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiJLUns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 16:43:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDA0108DC9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 13:43:25 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CKTsAI011906;
        Wed, 12 Oct 2022 20:42:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : from : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=zbILeCKMsnlY7K2j3T15uhudN34AZP/7dGq/9sBo1Og=;
 b=ulWXNACdABlabgf6SNTUt50E1Lrjla7dUeZ8FApwVUWfTKqVQZPcOGcOFG8CFZ6IX8uX
 NeZYc6DkZJj8Cyk+R8jN27xN6TmtYchmZmgGInQHumEUl1rmA/Vq869rbqjQZMn24n+I
 50OAiJKuDYDOMcROxg7kwoYrKDyeqCZSwnL6bzXuUH0kGXrqOcTfhiCKdmXQ66X8KgDx
 ZLAB0twPFWwxbRGuZavO8rSnjiJfiHCuaSHN/aNFxDfuN2BBl6qES92wq15Ip2UuIhLL
 hM227xrlThkz0st4pOwv9EwB99BTDSArVk7bnF1fgu0Jlkef5zBlAxOB7InUpVCSN/sR EQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k31rtka5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Oct 2022 20:42:56 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29CJ4AEM002988;
        Wed, 12 Oct 2022 20:42:55 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k2yn4yp7w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Oct 2022 20:42:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iym0EL05a4nel/8s90EJUdvHMXJJ9mSgZj00/TLq18WLEVDUpkyM40lDVLVXPLRZnw+LgBPmPtwlSPkCcQfkTktt1mORk0f5jeErO5vXaf50lZ2ABmqzh28uIglqt4NsX9Na00MtLO61RXOSgwNkQsd/q7I9IozuH2tEvmvldiArFUAD9bbgyS507/HY6YBGsjAfeHnKEV7Sh36bUvuRvYV++h7bbIiTsHpNLPxil0/+5vv4qdrx+bI9EyiBY1GnqyCZ+DV39NkJm9itDYH7hR5f4gj2X4Ag8m8zJNSwDCYZ/CSS6sGCZT7Tl5eYdyCreAYEXGIubi7G+aNX4J8iKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbILeCKMsnlY7K2j3T15uhudN34AZP/7dGq/9sBo1Og=;
 b=B+uvebRPdbWZpyDO1fxO0nUOA/XRhSXdGCwvOUnLtD34/iXYfVBjuQvsduozkRraQoiQopXmsHcxQLPzAUf0w+sx6y7ENTxvuaeqG0CvxZvduJBL/Bc2R1QzpyPspf561TkfCvbu0tNu2B9DFatr94GV89JqPjWFrib6/V5kCKOR0k7hl5UpFUISEulVBOSXuURVpR68hVJ9Wp7DhuKyKXAA+63ffw28q9/yPuVim8iqFLYm60/MJsVyTaofEUCYU/4Mvw4xc3U72Xeo7edzAFnfLkDoVrIqgCZetIoIgGiGXQXU8KIyGNYARGY6wB+6fmjirkIJuO/bN8q5H7eheg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbILeCKMsnlY7K2j3T15uhudN34AZP/7dGq/9sBo1Og=;
 b=KLIt1y4yeOnr3r8NKxcffe38rlTMMNfQRZmS4BdEvgDET6mAX9sfBnKRho6DJLSoCwD9AvB6CXRowPEVGrtBO5slVc7MCM8LPTJM8SIiWBOaXmr2cWw3BF70fgZG6zulDOhZE/Uz7Z7GYlOG1JReOFB7XpIIaGH7jX8J6YTjevQ=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CO1PR10MB4548.namprd10.prod.outlook.com (2603:10b6:303:97::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Wed, 12 Oct
 2022 20:42:52 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%7]) with mapi id 15.20.5709.021; Wed, 12 Oct 2022
 20:42:52 +0000
Message-ID: <d8a00112-4280-f947-fff5-c8bd916c0d85@oracle.com>
Date:   Wed, 12 Oct 2022 15:42:48 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
Content-Language: en-US
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     Borislav Petkov <bp@alien8.de>, Baoquan He <bhe@redhat.com>
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        sourabhjain@linux.ibm.com, linux-mm@kvack.org
References: <20220909210509.6286-1-eric.devolder@oracle.com>
 <20220909210509.6286-8-eric.devolder@oracle.com>
 <Yx7XEcXZ8PwwQW95@nazgul.tnic>
 <cb343eef-46be-2d67-b93a-84c75be86325@oracle.com> <YzRxPAoN+XmOfJzV@zn.tnic>
 <fd08c13d-a917-4cd6-85ec-267e0fe74c41@oracle.com> <Yzceb/y3SSFMuALR@zn.tnic>
 <d6386653-eb71-188c-8a09-5db46b4e42d4@oracle.com> <YzcqE1RVtPcuLlxN@zn.tnic>
 <Y0Dh4ieUUZ4oXa1/@MiWiFi-R3L-srv> <Y0b9apyIs+RpSo1e@zn.tnic>
 <53aed03e-2eed-09b1-9532-fe4e497ea47d@oracle.com>
In-Reply-To: <53aed03e-2eed-09b1-9532-fe4e497ea47d@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0282.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::17) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CO1PR10MB4548:EE_
X-MS-Office365-Filtering-Correlation-Id: 8303e734-77cc-4826-d5ec-08daac925553
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zXBmkQKOfcTV8F2k2Ehf13ESbTHk2P61FNjwAK2a5hUuT4gxrTOCBrob+MG5osCd62kQ+3OcbeKUXprbNDP3USgz9S6jHxfVV2nwklcAUIGYdS61W6qZ2/fWERi+vKMZwa0cJbcfEsCZu2+rLCrrJ7y4C3M0D72WrmDq7JQ0W852mAKF9/RX5Nkx0znQcJSMCKxe8VfMmo8RvJnDvuuwvp1lQFLwn9Ti0y6P5x1YtaeFvc4HeqxzPq6BGHtCR2RqZdhLDruC0YbDGsMRW0Buup1lWdVKKR1TKLMh6U7Bj06DdhP2+2G+C15VwZPX2dY0mF8mzSSeOBK5gCM0PR5v+x2yUqyJaN1GSIs3o/jbr4+c201I1N/RG/Yxh4IfOq8xyoCT2nllVd0cxCwgHwLmHgpWAj7vS4bxsvdKSQwnEyLKo30lmLW303Jmn+QxCdKJQ/3E1KfGzF2f3HlZBw77SuddW02aObJSn1C/yeH5xb1NZSkBeLAsT2cDzIfFS44V6niXkXbjcvsYr5ZpkwRn8x2SWoBEe9cb1bCRqvVg7z6TjJ+YjZCXP2KPhSoVnQLtJ/eT51VcARGUC55DxcCBeRSETE7aorenXyQE4m5QC0s6ZPKLH4Pxa0z6y6IJ/XYNFPMpFkCQdtzx1+xNXv6wjSXqyJt3BdFpNP2NaKmSe/nWKQkw7zBABWRIfwh1VWVsYaxqMUo+gVbdPLpZtmMZBNaaCpcOtaT6wLrywQNXI9NCaAdjLZgWzYHLgPMlNpWeouvbR+ulAizt/7E9fZdq5ohZMBKK3rnlFGnUheQpJII=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(396003)(376002)(346002)(136003)(451199015)(6506007)(53546011)(31686004)(38100700002)(66556008)(4326008)(316002)(8676002)(66946007)(31696002)(66476007)(86362001)(36756003)(186003)(83380400001)(6486002)(6666004)(2616005)(478600001)(2906002)(54906003)(5660300002)(41300700001)(6512007)(7416002)(8936002)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUF6RlJBTnF0OWc2SGhzb29ubHlmQlQySVdwNkNjOTRhdFdGb05qczBVQVdr?=
 =?utf-8?B?dS9ENUxOYldHekROTEdoR090TDZpVEJyMXBiRk9TZzBPaHJFZXVBSXZZZ1lw?=
 =?utf-8?B?Y1lyak1SYTJvQXROdlhUV0cwM1E1amtTMDg3MVY0Qk50TGFNWHROSE9JV1NO?=
 =?utf-8?B?aVZLSnpZenNvS3RUNDd5WGFJQjBnWjM4bHpJU1RmMmFkeitnQ1ZGVzVRVFdu?=
 =?utf-8?B?TUUvU3Eya2ZiTDJ0Rzd6bjdlNWtablhyQzZ6WVhJRDJMRlc0Wll2Qi9hUDhC?=
 =?utf-8?B?ejF6RUQ1TGllb013QnoyTkFac1dyaktCWWdCVkpkYnpXbmxXT0lGOFdNSzhq?=
 =?utf-8?B?dng3Z2k5TE5UcHZYSUtzeVZ6MUI0MmgyRXRkZmNJMDY4aittVTVFMTVabGN1?=
 =?utf-8?B?MDNONW9DaGFuY21rWXFIQitZNkx6dkRPd09UWEZSc1ZmSlhscTU1UldqNllF?=
 =?utf-8?B?ai93R2hTTTcxZXZJTE40NFZqVzZvMFNRZDNGSHpRczRIMkNZamVJc3ZEeGFJ?=
 =?utf-8?B?NjdieDJ0UUMwM25VV1V0TEJhSUpYZ3RjNTh6QnNvWmRMbTFGeGFJdWVqRmRu?=
 =?utf-8?B?Slk0aGd4TDMvUnJMQ1NJOWpzUTZNRTlBcmxXOHhtTlE2MTNIbFBGeXNTZUFM?=
 =?utf-8?B?cm1TbnIwZ0MvU0MvNE1CWHlKdGF4UTR2VDhnVWIvbXNXSGlQTzZScjZiYklJ?=
 =?utf-8?B?alRuV0gwcm1Fb0RKZzRpUTJCTHN2VTdid003K242VFJraE9rT2R1OTJQM1ZD?=
 =?utf-8?B?Y3Mxb1JidHVhMk1lTVRWZ3MzaWVFVG1mR29pREFMbk95ZTlXOWZabEt5a0tM?=
 =?utf-8?B?ZER5b2phb0xTWVdLd0tLWm10NFdTOUtkMDRIT1gyNExLZXlMTXNPUHNFZ3lZ?=
 =?utf-8?B?dmMrLys3cm9DT1ExNms0b3JMMlc0MmlMaEEyWGxtWXNwUGMxaklXQTd0SlBD?=
 =?utf-8?B?ZTF2cER0djBXM3lISEpsTTlXQU9Rc2QvU3NNa09hVXdCbkJaSDZwN0lFUmVI?=
 =?utf-8?B?cnJpVjh4MDJzdGxHRllDei85czFuRytBVi9KUVg0MTh1ZDNDWWFmeWlqcVRq?=
 =?utf-8?B?RWtYNGlRakhHVjVXQ1pHTEtyQnZqNmhYQUljUlgxZ1p6MUlaQWZSMDVpSUFx?=
 =?utf-8?B?bVk1ditkRjV2dnZKa01lVFhwYVVMMUl0WnNpUE91U1lvTzJxaktWczhwY0Uw?=
 =?utf-8?B?MzlsdXNBV01Uc2VJN1paM1Z1aG44M2lrWjgvRHpxTm8yVzcxM0pQQW9lLy9q?=
 =?utf-8?B?TGhnMzRHQ004TldDR2VrRmtvTUlNYmxIdXkrS2E2WFdBMGd2bDlxRFBTM01n?=
 =?utf-8?B?YW1kdHFSMHNLME51RTRsclFoVW9ERkNMekQvV2l6dk9Ub1hFaGVMdGUwQ0xr?=
 =?utf-8?B?b0dROEpNcVdqMklZVlRWb3NPVXFCUzQ4UGFTNUhVcEZkYTVuMm5MOVlVeGEv?=
 =?utf-8?B?SjJnWVZyL1lkMS9aVG5jVitjWlRiazh3Zk9EelYyUFZqRU9rMitPVk9QTW4y?=
 =?utf-8?B?Y0xUVHVuMmhGTU1TWFpPeVJzNlJlVHZUa1p6VWs5Tlc3Qi9Xd1JUM293ZWZD?=
 =?utf-8?B?RkVMcW1kckN4WnpBd1VPcnREbkFiYms0ekVybDd3eWV0ejVwMGZlWDRwMmZO?=
 =?utf-8?B?T1kraE8wRG8rRnp2NWQrVkRrSXhTVm8rMHpZdmtkMDk4WW11VWJtUmlOVm5k?=
 =?utf-8?B?eE1RQ1FSR2JRUWhqcFZnek81UisvOXhxaXo3VW9zTE16NzA2bEF0K0pZVVJS?=
 =?utf-8?B?YjRneCtVTmhhMU1EalhGdnJYY1Rab0g0eEswS0pGSHd3eThIeU9xS05ES09I?=
 =?utf-8?B?emJiUnV5VGtNSnU3UFg4R1ZHcHFHQzVlb3pzTy91YVBWZmJHcmF3SVM3MkVQ?=
 =?utf-8?B?SzM5NUlNaE4xVGpzNG9uR3BYQlBOU3lsUEhndjJNS0lQTmpPRjhweFY4bW45?=
 =?utf-8?B?YXhwZ1Y5MlRNZXRjZ3hSZlFEbGFycXNaSGh2bWJsckpuY1c0dDc0MXcxWW9Z?=
 =?utf-8?B?ZVh5SS8vYjgvSUUxOWlUS2kzUVVXUnBwQWNhdlZ1Ri9wYTE4QkI5cU1mL3ND?=
 =?utf-8?B?V1dTTWVoR3RtVkVmWDI0RThSNTY2U2N1WC9JUWFDVHpEdUt4ejFld2hjWnpy?=
 =?utf-8?B?RjFHbHpwWHIrRlRQRjBFNlBrOWhIVXVjbEJaOVUrOWdrSHhsVWNuREMvOTFM?=
 =?utf-8?Q?Uojql0eQe2Dw0WKSZqZ7Tgk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8303e734-77cc-4826-d5ec-08daac925553
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2022 20:42:52.4981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aA9167Rk9PFHoAMP5jqWkAph74DTlGJP9i/skUUNhL83y0tPSk5AFIfgEvOgc3uHG73CmVN7GGDsr4qCyVclNJRgq3nO2kmNob86gv7Qi8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4548
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_10,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210120132
X-Proofpoint-GUID: a2biQz_GpRH_tR1uT5BOmOmig1W2qUKF
X-Proofpoint-ORIG-GUID: a2biQz_GpRH_tR1uT5BOmOmig1W2qUKF
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/22 15:19, Eric DeVolder wrote:
> 
> 
> On 10/12/22 12:46, Borislav Petkov wrote:
>> On Sat, Oct 08, 2022 at 10:35:14AM +0800, Baoquan He wrote:
>>> Memory hptlug is not limited by a certin or a max number of memory
>>> regions, but limited by how large of the linear mapping range which
>>> physical can be mapped into.
>>
>> Memory hotplug is not limited by some abstract range but by the *actual*
>> possibility of how many DIMM slots on any motherboard can hotplug
>> memory. Certainly not 32K.
>>
>> So you can choose a sane default which covers *all* actual systems out
>> there.
> 
> 
> We run here QEMU with the ability for 1024 DIMM slots. A DIMM can be any
> reasonable power of 2 size, and then that DIMM is further divided into memblocks,
> typically 128MiB.
> 
> So, for example, 1TiB requires 1024 DIMMs of 1GiB each with 128MiB memblocks, that results
> in 8K possible memory regions. So just going to 4TiB reaches 32K memory regions.
> 
> This I can attest for virtualized DIMMs, not sure about other memory hotplug technologies
> like virtio-mem or DynamicMemory. But it seems reasonable that those technologies could
> also easily reach into these number ranges.
> 
> Eric

Oh, to be fair, if the above were fully populated, it would essentially coalescence
into a single reported region via crash_prepare_elf64_headers(). But in the sadistic
case, where every other memblock was offlined, that would result in the need to
report half of the memory regions via the elfcorehdr.

$0.02.
eric

> 
>>
>>> For the Kconfig CRASH_MAX_MEMORY_RANGES Eric added, it's meaningful to
>>> me to set a fixed value which is enough in reality.
>>
>> Yes, exactly.
>>
>>> For extreme testing with special purpose, it could be broken easily,
>>> people need decide by self whether the CONFIG_CRASH_MAX_MEMORY_RANGES
>>> is enlarged or not.
>>
>> I don't want for people to decide on one more thing where they have to
>> go and read a bunch of specs just to know what is a good value. So we
>> should set a sane, *practical* upper limit and simply go with it.
>>
>> Everything else is testing stuff and if you test the kernel, then you
>> can change limits and values and so on as you want to.
>>
>> Thx.
>>
