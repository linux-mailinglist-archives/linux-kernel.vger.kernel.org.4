Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33EC6169CD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 17:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbiKBQyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 12:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiKBQyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 12:54:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9390163FB
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 09:54:48 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2GPJO5005287;
        Wed, 2 Nov 2022 16:54:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=pNUe8qEyVMOJ2KPkq2SLN6aRyup5Bx2Bn3DpcRkL6rE=;
 b=HLO0qNGjyRCzBXZO0ThcmkVa1XXzhTYbb3/jd+9t+QbDX6twH50BG2jPMt9LGWzgwiVy
 VQ1N+R8u4WiMs3VvLQx76jF5lldDugu70RhZTSxb0bxN3VNicWoA43g88tVQQax1XzEg
 yNjS3Ey1c14hfc0J8bjgjBA+jlckoL9NBxx6RheFs+iv0IjPvjmx3FUpL2z5BZo+lejM
 OGSleI6QB9vijVAIpcTdP+XjJWWSG1Pi3O1J0uvBTh2MheBFc2ySxpjwjrI7AP272lzx
 bOCgY4g0+8P99dILlnf0Na5Udj1FKQgIWoUAxmmfAxPFVJbSoeJH1sSz+y4kRl2pZkVo pQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgv2aj8kk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Nov 2022 16:54:20 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2Fx9mE001327;
        Wed, 2 Nov 2022 16:54:19 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtm5rbk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Nov 2022 16:54:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOC3yE7Lqt6hREzVtVvJj0GGNUtGaipEiKQKqzjDzVzD2N/5VjH91Ju8m5SOykKOIRFNDs693zhp3jYNQZJ2uqJx0MQ+CufTbSNrMF52+oLR+URTBWQTWWnONBC0vGFn4pCoyTMqNVfVMrWDlZLOKXYlT6msb7MYSTqBhHyLNCpz93+t6ULcL4NjCwSEGPT25WDQx8dGkGBSx8zbA+3I+3CJqgu9PT5x/ljHPgMeg65nREmNV/DkRbGr4VxANRhNWlzt6P/UH/+69Zbc8jBgMcitF5qmmLsI4EBjpeSK5Denanfc2UTx1x0c3PYQFp4CvCPsuMo0JChKcF3ARHNThQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNUe8qEyVMOJ2KPkq2SLN6aRyup5Bx2Bn3DpcRkL6rE=;
 b=WzM+22jF+n7GB80Lb4U3EqZBtcO43e2Epap3a+6QMBxdGaPESTbzCODN3jnONnTP/vAjOQL2Yh2/HgPbfbRS1DmRRFIAbMWECSlxhyDcrJw78kDhGoLepX8K5bXcBjRy6XMjLI+TeyfHvZJXIvXKeE1z5GZQ5pYiU/2rvu7BqU1iD+c7J/sgUMVrk15Q51yME5FfNvmvQfHEOeKhe2urwWa5et/wZl4oGEvuQRURa+QPZi4CbdwOKRNGenOuuzxMpVrP/sAz7CHFyhfkzpC/rWoMWaDBVdgzR5CuI/VDarwefz2IZjHF9lfneuRSjgfSDfwsgFBYMoZi964LhJDi7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNUe8qEyVMOJ2KPkq2SLN6aRyup5Bx2Bn3DpcRkL6rE=;
 b=s6a9t0zSONopvsuOztQjphOtcmq7ir7roSUJ1f22EFgloL8ICoN5t2nnod45v/sAXMO5kDSGsW6F0f3HLVTC+o0J4EQtTpgxxjvMokg4DV1B2cU1yPtauSPt/a8VBvq5U7O7NewZ0DrM8apcwXsjwLMknZIYmb3hQcKIHa9txnk=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BY5PR10MB4259.namprd10.prod.outlook.com (2603:10b6:a03:212::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 16:54:17 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%8]) with mapi id 15.20.5791.020; Wed, 2 Nov 2022
 16:54:17 +0000
Message-ID: <c08bb557-846c-0f82-391a-3eeda7e6ea67@oracle.com>
Date:   Wed, 2 Nov 2022 11:54:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v13 7/7] x86/crash: add x86 crash hotplug support
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20221031193604.28779-1-eric.devolder@oracle.com>
 <20221031193604.28779-8-eric.devolder@oracle.com> <Y2A4TqyOaPYBu4Hk@zn.tnic>
 <1c11a429-b5a9-fb55-fbef-b49e760e2d1e@oracle.com> <Y2I3zQ9ZU+C9Kgf7@zn.tnic>
 <06ef6e4b-1f42-d50f-1328-4f82fb34dd4d@oracle.com> <Y2KYls/Ji5E+4kPP@zn.tnic>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <Y2KYls/Ji5E+4kPP@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR18CA0010.namprd18.prod.outlook.com
 (2603:10b6:208:23c::15) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|BY5PR10MB4259:EE_
X-MS-Office365-Filtering-Correlation-Id: 491a89ba-b314-4ad3-67ff-08dabcf2e0db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9uRnANd8scHSsTHp1+zqz/pnbHfrSESwEe2YvPxaqhhKi9ENoWJNQeASwcg+EpcvOmzxJ4KFnhkPGkHh+GbEJwhVZqVI76Jq0fJAHQzSFJ68TzLLcMXG5SRi7uIsoqvoZ/eXsun8M6t+v4xzqNE/qG18CBT4PJhY7/kpb6t0g2lj6x4YYyoh/+AKwG5hRS8W5YqTjEvEn456wOAxNUfJSLbcXwIPtWaYmcPusNugfsNaIoL0eqi0L9DMKRnVZtmLDFEQx3B1UlpZqi8AT/aIoAYE1WBTVizVdno++Q5IahjV9vbVgfo+spRa+LbvF96Hby1z72dTnG+n2wTDFUXsmmXbattq3H4/AOi3y/uPc5Mv8po7/wIng2kI5kzNOT6lBrYYi2u1tA4DyFdBG2VM9jqJ6edWtWQpOJb9TQQeXws+ir4NR4WAmYctQb4edwBZFpT8yDCrGKwW4UapveHEJYRj8ahXShnSFQWWT+JdOlhq69BKrma79UH6TJ20lp9f0CQkqnhr4ILMWjrVFlPSDEgxxyyZwFeaBzTxrHnpYuqx9pwdiiPLFTC4iQ4e+YDLZuBaRK9XvfH9dYnVC8VbGP3OS+l7iHdnbfO1JtcWnEpduuHYL76zeESWsmfzqt8Ax1B0hOWlSiL4QKvqdaD/fLta0rSSYXdT8voGCix7zXwaZSSuJwILiOCCTfWRqHxqD4QRL5RbkfSRUmlYh+B0xCb8n6w5utKuvBa4+45yO7N4tYYspUfGTYfdogA5Q7heOMuf/D8dUSvimtV42Lom06ut9Gnao0c6KGsE50I3ml4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(376002)(396003)(136003)(39860400002)(451199015)(4744005)(7416002)(186003)(5660300002)(2906002)(2616005)(8936002)(6512007)(41300700001)(38100700002)(36756003)(83380400001)(31696002)(86362001)(6916009)(316002)(107886003)(31686004)(53546011)(6506007)(66476007)(6666004)(478600001)(66556008)(8676002)(6486002)(4326008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHRWOE92anZabUhRTVV0cnhWSklhbGwwY3ZHMFlDSnFZdTd3NTNZblFTUEZo?=
 =?utf-8?B?SXhqWkFJelNwTHFaVytxWDVsY1lyUW16S3czRzIyTWd4MXVJRUc1ZXpjV0Vr?=
 =?utf-8?B?bzlab0Q5ajVNS3JKS1pqK3J6YmwzV3hhd00yUFpXWmVYKy9SamNNOFVKYXJh?=
 =?utf-8?B?TjY0alpXemowRUlzcXdCNE5VVDlzNHNVUjFLZml3TG9uRUhIaHpYbmRwbGwx?=
 =?utf-8?B?ZjVoamhqbUxiNFpoYlBDN0w3NDVUYzV6Wnk2Y1lZZEJnS2Nab2pGNmtObXFi?=
 =?utf-8?B?MWFJUXdSaHZ1bkN1Vzk0QktvempHTk5lOWsrQS8zS1U4K2ZDdHR0b3BhdHVJ?=
 =?utf-8?B?c2xpakl4RkJCckg1azNBWkMrQndPbk8rRnJVMVVVS2Z5YWZOSGdaZ2JQckl5?=
 =?utf-8?B?RVlPK2tZSDF0NjdEWkJQTFV0cUs3dlNPOUxNTDBKY0tnL3FXZXRha3czNnpx?=
 =?utf-8?B?SjJVV2pVZDE0cGM1QWdNVnhnTmtVSkVqWjYva25YY0lnMmFkeUZ3ZTZEanF5?=
 =?utf-8?B?ZjdiMkJOZjBCejljUHJSWXdGWVZjT05FWVRHclRySmdRazN1MENnaDUxaU12?=
 =?utf-8?B?TndSYjNUakJlb3ZPbHRqN0NFellxajAyOG5wUmJSV3hvK3FWendWZVFJT1NS?=
 =?utf-8?B?bDR5bjJUcXBncGg1eHFXODN2WTFMdlQ0TUlVczRZUnpSbm84enZXUk1tYUxn?=
 =?utf-8?B?cVhUKzBETkorZ213alVobUgwOHFvUXh2QlIvbXRWQTJOc3NpVmV5VXpDckpO?=
 =?utf-8?B?M3lhaER2d2JNR0ZWelZMQVVSZDRzQ3BzTVV1Z0tMTVFraW9ENEpuaStDMzcy?=
 =?utf-8?B?SGR3T1ducmppaFBJNlZZR2ppczN1UG1PL2ROdWZVMzVjUFBmTkNySkJpV29q?=
 =?utf-8?B?cHMxMGg4N2pwc0RwTFhOZm9YT1hPcjE5bEExYXQwRmFYTElsRGVsNmh3bndS?=
 =?utf-8?B?Smk4cDN1VXZtVDBYcFBaOHB1RDNOdzZxNjdWcnJFSDQ5T0xhYmpUbXdNZXFo?=
 =?utf-8?B?ajBaSDZtNytVRnRFYzIzNndDMXBGWk1RZ0JZejVIRmNlb1hKT0NLODBNZkNz?=
 =?utf-8?B?RzdNTjZOUm1zZFRWRElKOGxzVG8rbXFMZ0x0ZUhGNWM3WkxFMDFqQXNIREFU?=
 =?utf-8?B?R0czbEZLUXd2SldIYWhJVUR4TDV6RGxzWTJkN1NsTGdWeXIxcnRCWWgrOW1l?=
 =?utf-8?B?TGF1VkFpaTY1Q1JNVmhna2pRQ0twZ3UzRVpGZGlaalhXU3A4K2pwdVdHQzFP?=
 =?utf-8?B?TVdBSXNvUGwrTXVqRUNwZCtxZElaUkVySWJWYXB4TTI2bENqM0U1eEJOZkhO?=
 =?utf-8?B?TVhYOE5kWFh3NllkWXhDaFFqZThTZ0psNS85dGlRa2NKSG5VTFhBUGdBaTA3?=
 =?utf-8?B?OUR5ejl5RDNoNnp2L29XdVI5VUZqYVgzT0daSzN3MDFPRzNsMGlQa0tRZnhm?=
 =?utf-8?B?Ni80aXJmOGRRZlJKS2ZlQ0dtRUJqMjFXUHdsZXhuR0wweU5GMjVGZmFLajln?=
 =?utf-8?B?cUkrWTd2cFN1UEpPR2FOdVFXeW9WcCtCSlVhZTF4WFNOcUhMcmNzdTdjcTAz?=
 =?utf-8?B?QmJqZzJwU0ZCZTdBUTFaOFRxWmNHVkVLdFJRUnk3ZjlVRE5UUENRL1pDbE54?=
 =?utf-8?B?OXIvcDhsZmdrS2pRODcwemc2L0o2TVpsTEpUNC9odVUxTnJTdjV4TXBhdDdX?=
 =?utf-8?B?QzZyb1FObW1VT3ZFaDJnV3hMU0dxU0RSdUF2VUR2ZGZiREZwWDJETkVrZHFz?=
 =?utf-8?B?WU0zZjhObHUxcU9odHgwaFJWd2ZkUDlsQ0lJbmNvcjJvT01pZUNOTDZ6a0Y4?=
 =?utf-8?B?eHlwcnArV051cG1xNmkzN3ZhWmxyWnlMMUk2cklIR1lLTFNDNTdVL0VQOUsy?=
 =?utf-8?B?TGdUa1RqSHlUWkgrTGNmVHVOTWVjQWR4dWc3dTA4S2F3aHVCdkk2bC9ydjlZ?=
 =?utf-8?B?NDlLRGREbTNaekxDRzV2RHF1Sm1EeWhldENWcG5ubGdITE0yUGcwZVdldkNv?=
 =?utf-8?B?ODVvRWNrZFMxQ3JCdHlzOHpiSW1tdWpGZWtHYWtqR2thUjRrZGJCcVpMTW1w?=
 =?utf-8?B?K2lXYmIvRitYRFBEQlNRMHVXK3RpYUlSMmx4d1B5cXlQeFlac054YVBTbVdu?=
 =?utf-8?B?S1VuS21JcDRaOE83d01NRTVROEl6US9meE5TVHJGb3cwbEZ5eHNoUFhwOW80?=
 =?utf-8?Q?lR++SeMtr3vzOXsMcjid6/A=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 491a89ba-b314-4ad3-67ff-08dabcf2e0db
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 16:54:16.9116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +J+dpCarJkn0ch27W0s5abqZBJOy6os63/oo+DO3bl2eIrRFnrLj8UfUbjj0AZv8hfBXR/9f0sfQiEmEImAdwjZ+ikfIbvY6f81r4n4c8wY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4259
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_13,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=975 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211020110
X-Proofpoint-ORIG-GUID: s-1ay1feopNPcVwqIH9siVO0O6ssSIrF
X-Proofpoint-GUID: s-1ay1feopNPcVwqIH9siVO0O6ssSIrF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/2/22 11:19, Borislav Petkov wrote:
> On Wed, Nov 02, 2022 at 09:55:06AM -0500, Eric DeVolder wrote:
>>> "But on a plain simple laptop or workstation which has CPU hotplug,
>>> would it make sense for the crash ranges to get updated too when CPUs
>>> are offlined?
>>
>> Yes, it does.
> 
> Why?
> 

Technically the answer is no; cpu hotplug events are independent of memory hotplug events, but both 
are written into the elfcorehdr, so in reality yes... The elfcorehdr contains a single list of Phdrs 
describing CPUs and crash memory ranges; the entire list is re-written on a hotplug change.

Eric

