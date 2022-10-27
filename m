Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1C261018C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 21:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236606AbiJ0TZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 15:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236534AbiJ0TZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 15:25:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E48074CEB
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 12:24:50 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RHmxcw019860;
        Thu, 27 Oct 2022 19:24:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=BkV6uakP1scn33KV/Gu5BiWL6Y23N6fyhftpzmzJPwU=;
 b=Tw41MHpuk6XqZU4M9VKFOmYxNUaWWXq9hWJ+lJVQC0NOkV6z96RTJ/XdSC1Cdz5hpp8m
 mJWCvGT1lsTPyPGXxIt4P9yUTz+AF9m3cgbI1/W1BWlGAa4eGLkZYdFjdBOOp1U1e5xR
 ahHbNb28300rTN3B7JQ/bJOHRnJIYYCAEuP8O5A4zCriMKZdP0Y6RpR9Nrx/KIyCGVSs
 phbTuExWVCsMLoV2qxwVGmZJdHj2JRB9JlVqmNxxl1pMgSspRMFGVHbzsnEIqTkmCF+o
 3a3PMg8p56faDQe8zBsQR/U8w7TYz9cJdZ29tY6z+LYRdY0R1hF/25+n391ZPxC3IJYN KQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfax7tys4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 19:24:20 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29RIWawx017633;
        Thu, 27 Oct 2022 19:24:20 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfaggtj93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 19:24:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DK3JN5hUhPR0bhULEtHsOaIY04ar2baB/QOyarehFAtj+G6LRNlRWSavQVx8pSytZixv1xPs6/nwVO4IjAj/cAKK3mxpd7dJS7ZXLpgRJ4Nvu/btTxAvdZPW2X1VDjsMHkpaH3iSoOLqKyWBa7JAp93sRVbIAixiwlefzQHKneEKsgZufasDzqjMCJqRjiG2ISbZliZlx27Ek2CU2i6FQ+G+EfXQhhdGFE4myFT+2xNiiW1h2JmuGf/6xs2YSqw8cottTRPPsnm7+Bbc1DJKHOfZ0ievhGXxRRPBN2GAO76APp+JcXnQzTnLVgTQJEsWN8MccRBdMU8c5OedTtf9cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BkV6uakP1scn33KV/Gu5BiWL6Y23N6fyhftpzmzJPwU=;
 b=EP6B5gQLaB0Jhe65xUviGmsgP51OCBmxMfzXxK6heSgmQAO544xSG50o5ng2qjXXWtAfa/l5pZ6EjO2tygeBgn0enRAS3FbzeQnq83A5NNHsAM0fqBYSsC/DTYhcWR1iflFaIHrTE+NIi6I8B2C9U3ct3rnNmpwV9lzocRKoLe6sRtJfk1av8xkuYCnFQXT3NeoFtJJm0y3+03X3PKE9n52xEGXVR0zz5pKl2L9cZ6b/B55Dyz5p12Zv/Koc3PCwdOhOzbKWKIdrmRc5tboJDRNjBDyDZD2G2Tth0iE7aPnC95tViZzHtg1bUzBhKWFF4ceUjJD/TVcwptx2lzheaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkV6uakP1scn33KV/Gu5BiWL6Y23N6fyhftpzmzJPwU=;
 b=R1d7+kK9GeYedGZ3XgNc7h9PJtV5bjcjDiFrkct+EeY+YyV7vme0WTm6/tNMuJcLnbWrGvSaFO/fG/UF+NOGjPmkcrLyVRn9JRS6L0ZC4V2ZOrjJ4vXdZrIl18uOIBVwOd296101VqESJNRgs6i4FsZhOMZjQqrmbIDkANy7/O8=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CH0PR10MB4844.namprd10.prod.outlook.com (2603:10b6:610:c0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 19:24:17 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%9]) with mapi id 15.20.5769.014; Thu, 27 Oct 2022
 19:24:17 +0000
Message-ID: <35c98ca6-10f8-b248-78c5-99fce7e66c65@oracle.com>
Date:   Thu, 27 Oct 2022 14:24:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v12 7/7] x86/crash: Add x86 crash hotplug support
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
        david@redhat.com
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        sourabhjain@linux.ibm.com, linux-mm@kvack.org
References: <fd08c13d-a917-4cd6-85ec-267e0fe74c41@oracle.com>
 <Yzceb/y3SSFMuALR@zn.tnic> <d6386653-eb71-188c-8a09-5db46b4e42d4@oracle.com>
 <YzcqE1RVtPcuLlxN@zn.tnic> <Y0Dh4ieUUZ4oXa1/@MiWiFi-R3L-srv>
 <Y0b9apyIs+RpSo1e@zn.tnic> <53aed03e-2eed-09b1-9532-fe4e497ea47d@oracle.com>
 <Y0cmaPTKQuWtwIRh@zn.tnic> <Y0d+mFivS+88+Chr@MiWiFi-R3L-srv>
 <Y1e7Hw0PRDI9NxU9@zn.tnic> <Y1lIoTBNvHrKX5K9@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <Y1lIoTBNvHrKX5K9@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0039.namprd05.prod.outlook.com
 (2603:10b6:a03:74::16) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CH0PR10MB4844:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c7320c7-9194-4ae8-3556-08dab850d6f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lS/IwJHN3Wme7tXwNunCgjtADD8gzhwIV5P/UNK8KPUtwMxNF7umPkSu/7QltFEDuIRrz9rLTg3VcsVGXGWWtuhYVLG3ttmeA/SNC3YidYplPaU+41CW2vlZi7Pw4bvhZbnkXv5d59liU0NUih+RIope1BAA5U+krnpbhRWo+dIPzdackEF4tSJt08GYZ1w2PwPkjl+IdtR7q4N1QaceZJX8TZqsQAVY5c4L1DbytChVvost+bToGr33eSUPc58m+dmN7htTWI3gem8140+QSkrdOeqHeAJkoI2AjEUEaaMERjDWC+hopSEr3fyB0WB3y+Y8tm7rO0zWGVoyBnNW25/zhPcxZaXEnmnTeDn6QfGOMGIOQ97hA7e8Dt1ptIbBDSpOjLSeNb/FFMg6F5bKNObPSS1cPRYM09/a02O30EY8z1pwqAFkN5K6jaQ1JlOCn8PDi5h4BqKA6u/pPA5khSG821WeNIYjWZy0RHLikbHVy5aqNdd3+3yzfNKevJg2R1KFr2ijLWcS3PAlTdu47Gvg0zvqRkl8gi7se6pMCxHZuBFRGOUEk/bQEpviD6lCaABwpD95omV4wXAsOr5r5m4LeEMNEDEqydZS8UUWeQo6xy9AxxfprzWex35QB2Yt94lNNRPUW0xCRa3nnIJxCg85TuDrHl4y2gcGLl4IkT/4goWwujNrk4Sgkd5rKna63asxK7eXxpBt4AzW6JYWUxak1/e/g4kw4ZGPwFaaLiBJmSB13BtuoVRCyhjOwglke/78nCeqqtLQJWmrvw8lie0IvFJy+nu6c+eTp56XXCHM0r8HitgcehbIn9GeXgLFqzGIsHMiW+J5ZEbBg5T3PA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199015)(45080400002)(316002)(66946007)(7416002)(2906002)(53546011)(6512007)(6506007)(6666004)(8676002)(4326008)(41300700001)(6486002)(36756003)(478600001)(66476007)(38100700002)(966005)(31696002)(110136005)(66556008)(54906003)(31686004)(86362001)(5660300002)(8936002)(83380400001)(186003)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWZSMXF1cTAzUXhPUCtDRFJQYVpvL010UytscEE3cm9tUmhqTytNK2V1NFU3?=
 =?utf-8?B?L0hyeVZWMUloU3c5VVV6cWRiZU5VTnFZZ3BlUVk4cXZ5NmxoRUozWmhJYktt?=
 =?utf-8?B?VUdHRFpMamo1eFJNUWxsWThid2dpSVg3R2QxUmFBczQ1WXYxMGdLRmQvU2gx?=
 =?utf-8?B?cTloYWIyR01BekNzeDRGLzllNFBrOHRpanVBSXVycm5uekxULzVOV1Y4R2M0?=
 =?utf-8?B?azdJOGlBeHArQjBBVmR0RzViWFN1RWhHWlZzekNlb1UzeWh1STJLRHl3NVlD?=
 =?utf-8?B?bDh1ZWNwT2RRbjZSK2pkeDJ3TG1ERDJQS3FqK0gxUkQ1aVowTVFpUDFWZkQ0?=
 =?utf-8?B?ZHNDR0tONEJGQVBjbWtKaURpcmVvVVJsU0w4b0NtK3FVRGwxR3ljOG83MXVI?=
 =?utf-8?B?bG9GZ0lFQWR6RmpMVzlHaHJPVnhGZlE2bVF0NXJoRkxQbXVzQmVYVEhIenpt?=
 =?utf-8?B?VmNOSi9WaDlNcGJCVUpMOHlhcDNyM0RJSE80c2h4ZW10L1loTVBiZTFWWVEr?=
 =?utf-8?B?YWN3WUt5cWo4aXNPRkQ1alNkRDBjZmVxci9KZ1ZSUnFTcGRKaE1wck5IQmtx?=
 =?utf-8?B?cFFhWXk3SjNXSzFjV0xPcmxSa2xma1MyY3pxdlU0Y1BpVzdVTXZ2b2VGSVdo?=
 =?utf-8?B?c2JabVdia2dSWHk3Qm9aejZMcW1sME9YemxlUTluNHhBcE8yTDRMQ2o0dDlz?=
 =?utf-8?B?VnM1cktNMDdHUksxNkozRUJIZDkrcmw2cDJvWm5mWGZxYm1FNUlHNGE1Nngw?=
 =?utf-8?B?eHhYWkk1NWFud1EyS1lsQVFRekUrRUhSNWVMNjQvR3N0WCtxUjZldmFpckZt?=
 =?utf-8?B?Rk9MUHI2WURZOG56UklIZklYMkRnY0JIUnk5MlpDd3RoUXlsTHMwaC9PUnZ2?=
 =?utf-8?B?RUZqWVViK1UvOTF4NFJYNmNDaVhQUDJqY0RZRUlMRGh6WmRCVU11L2QzUUVU?=
 =?utf-8?B?TkVhUkhaNWF0cWxtcTFYYnRoVGJkS2Y5dnA0cGxvZnpQQVJ3TGFnSFFNU0Jz?=
 =?utf-8?B?N2ZFL1lDeEpsV2gySTU2NUJHakZMZ3RQSXFQZFJVc2RCRkZ3Unp1M2FGNjNO?=
 =?utf-8?B?Z0lQTi9WNzVmbSs3UXJXS0JORzhmMmI2aTFGVnJVM2ZmdEdxb0VEbWNXOU51?=
 =?utf-8?B?Mm52OXc2b0hzSis4U3dhQm9ldVNwOGx6eXRtK3pTcU4xSU1BUWtDV3Q0UE5x?=
 =?utf-8?B?eEw1eExMNmE5MjhCYnlBOHExL2ZOWVFxbHgrZkJoOURqeHAzMHNnVjRhY29m?=
 =?utf-8?B?K0FhcENRV0cvazR3YkZUbmxhRTNOaXF2VzJQV1FVSUZYK3BSMkVJc2JLSmts?=
 =?utf-8?B?djJPWWd6eFhnNnpQS3E2R2NpTUNyY2t6ZHFTK1FGd3EwRWtpSXRIVzl6RjMz?=
 =?utf-8?B?ZEIzdEdSV0EvTmdud21Wck10YklMSDhlZXBDUm5zM3R4YU5ock45alR0cng1?=
 =?utf-8?B?ZnZRRnZJOGtmV0VaT0NVcEFldThqQ29lWkRiZzdMY0owUzJic0RGRFU1d3NT?=
 =?utf-8?B?YnVLMzVFZncwR3VHMTBMaG5pdTg1aDRmYy9vQkR4MmFsRHdOTUFJOG1ETGdH?=
 =?utf-8?B?akdRN1pIcUVkNzRQZzdicGw0dkFPRHNjclNOYmtwUXVwZ0RnVW5odnN5L3ov?=
 =?utf-8?B?ZnM4OXlIajlGSCtDR2UyOUUyMVZwVjdLRS8rcWVtZTdFNml0SWFZdndqWFJR?=
 =?utf-8?B?MzFueDREbFZONlhEMW1DNW03dmkwQ2tRaUp5OEorcC8vbmN2ZWcwUTFuYk03?=
 =?utf-8?B?b0lad3ROVmR0VlFJNVJPMGxyNVVCR3FjcTJEeEhIWGlNbys1eVd1alFGbStY?=
 =?utf-8?B?OEJaQ2d6dVc3MEMzTWkybk83VVVPSTRUTTMzTDZPRWdKQ0pNMDNIZ1dKaTJm?=
 =?utf-8?B?YllLMlFEL09WRlJvVVhsUERUUWRDMkRrR0IyT3R5NjR0WG1XS3lPVkRLU1Fq?=
 =?utf-8?B?T2F2c2UrdXRqVytQMmczMlBsTWZ6S3l4bDY2UUFkRC9ZNnk4ekkxNk9yR3py?=
 =?utf-8?B?MlhJaVpvTVFNM0dCQitVV2VrVUg5YmNNNEhXKzcvTmxUekVlS052bEhBMi9K?=
 =?utf-8?B?MnRvWEZwRzFiM3ZFUkRYUkJwV1NVTS81VUtramRPTmNiL1RJcWtMb2h3OUZp?=
 =?utf-8?B?U0sycnBXcmVFSGx3Rm45OFVBODhkQTduK21kUGV0ZmE4S1AzcDRLNzR4ZDUw?=
 =?utf-8?Q?HOv2sHRCWEqsz9ELI0Ql4KU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c7320c7-9194-4ae8-3556-08dab850d6f6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 19:24:17.2057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OcpLl1skerAyDebGj7IzsCPTUt2nshcpua4IAIuQMktynxdsjyDy2Jbr+f3fxWmUeFPHVBSCnpM6+HmXMuUxidNvO2duWOwzYggJgyt3s+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4844
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2210270110
X-Proofpoint-GUID: OdAakxnJtcNwxObkgsCF364J8jGXb1ud
X-Proofpoint-ORIG-GUID: OdAakxnJtcNwxObkgsCF364J8jGXb1ud
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/26/22 09:48, Baoquan He wrote:
> On 10/25/22 at 12:31pm, Borislav Petkov wrote:
>> On Thu, Oct 13, 2022 at 10:57:28AM +0800, Baoquan He wrote:
>>> The concern to range number mainly is on Virt guest systems.
>>
>> And why would virt emulate 1K hotpluggable DIMM slots and not emulate a
>> real machine?
> 
> Well, currently, mem hotpug is an important feature on virt system to
> dynamically increase/shrink memory on the system. If only emulating real
> machine, it won't be different than bare metal system.
> 
> IIRC, the ballon driver or virtio-mem feature can add memory board, e.g
> 1G, block size is 128M, 8 blocks added. When shrinking this 1G memory
> later, it will take best effort way to hot remove memory. Means if any
> memory block is occupied, it will be kept there. Finally we could only
> remove every second blocks, 4 blocks altogether. Then the left
> un-removed blocks will produce 4 separate memory regions. Like this, a
> virt guest could have many memory regions in kernel after memory
> being added/removed.
> 
> If I am wrong, Please correct me, David.
> 
>>
>>> On baremetal system, basically only very high end server support
>>> memory hotplug. I ever visited customer's lab and saw one server,
>>> it owns 8 slots, on each slot a box containing about 20 cpus and 2T
>>> memory at most can be plugged in at one time. So people won't make too
>>> many slots for hotplugging since it's too expensive.
>>
>> There you have it - the persuading argument.

So after re-reading the exchanges, many times, I think I realized that I have introduced confusion 
by using "hotplug", and specifically "memory hotplug" and DIMMs in the same breath, and thus that 
perhaps equated hotplug with ACPI DIMMs in these discussions.

Allow me to state that "hotplug" in this patch series refers to CPU and memory hot un/plug, and does 
*not* explicitly refer to any particular underlying technology to generate CPU and/or memory hot 
un/plug events.

For example, I have been using DIMMs as my example because that has been my test vehicle for 
exercising this code; as such I think the discussion cornered itself into real world vs virt 
discussion about DIMMs, with no end in sight. To be plain, this patch series does not intend to 
convey or change anything specific about ACPI DIMMs.

In reality, when I state "hotplug" in these patches, I am talking generically and therefore 
inclusive of any technology that can hot un/plug CPUs or memory. For memory specifically, this 
includes ACPI DIMMs (whether baremetal or QEMU), ballooning, virtio-mem, PPC dlpar (per David), 
Microsoft DynamicMemory, and the upcoming CXL.mem technology. Probably others that I am not aware. 
Any of these technologies can add or remove memory from a bare metal and/or virtual system.

I apologize.

What is important is the number of memory regions (ie. /proc/iomem entries) that can be considered 
to be the maximum. There is no kernel definition of such. The need to identify a maximum number is 
so that the buffer containing the elfcorehdr can be sized and allocated at kdump load time, *once*. 
This elfcorehdr buffer is then modified/updated repeatedly as hot un/plug events occur. It is *not* 
re-allocated on each hot un/plug event; that is what the current solution does, sort of.

>>
>>> I checked user space kexec code, the maximum memory range number is
>>> honored to x86_64 because of a HPE SGI system. After that, nobody
>>> complains about it. Please see below user space kexec-tools commit in
>>> https://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
>>>
>>> The memory ranges may be not all made by different DIMM slots, could be
>>> firmware reservatoin, e.g efi/BIOS diggged out physical memory,
>> 			    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>
>> I don't know what that means.
>>
>> If it is firmware crap, you want to exclude that from kdump anyway.
> 
> Yes, now assume we have a HPE SGI system and it has memory hotplug
> capacity. The system itself has already got memory regions more than
> 1024. Then when we hot add extra memory board, we want to include the
> newly added memory regions into elfcorehdr so that it will be dumped out
> in kdump kernel.
> 
> That's why I earlier suggested 2048 for number of memory regions.
> 
>>
>>> Now CONFIG_NR_CPUS has the maximum number as 8192. And user space
>>> kexec-tools has maximum memory range number as 2048. We can take
>>> the current 8192 + 2048  = 10K as default value conservatively. Or
>>> take 8192 + 2048 * 2 = 12K which has two times of maximum memory range
>>> bumber in kexec-tools. What do you think?
>>
>> I still think that we should stick to reality and support what is
>> possible not what is potentially and theoretically there.
> 
> Yes, agree. We should try to get a number which satisfies needs in
> reality.


> 
> For Kconfig CRASH_MAX_MEMORY_RANGES in this patch, I have three items to
> suggest:
> 
> 1) the name is not good, it doesn't reflect the fact that it's the
> number of program headers of elfcorehdr which includes the cpu note
> numbers and memory region numers.

The total number of program headers is, generally speaking, the number of CPUs and the number of 
memory regions (plug one for VMCOREINFO and maybe a few others). The NR_CPUS_DEFAULT conveys the 
maximum number of CPUs possible, and likewise the CRASH_MAX_MEMORY_RANGES is intended to convey the 
maximum number of memory regions possible.

It is not misnamed, imho; rather, I think due to the confusion I outline above, misunderstood.

> 
> 2) default cpu number, I suggest 512 or 1024. The biggest number I
> ever saw in reality is 384. On virt system, it won't be too big. Below
> is abstracted from arch/x86/Kconfig. A smaller one is also OK, we can
> enlarge it when people really have a super machine and run into the
> problem.
> 
>     config NR_CPUS_DEFAULT
>             int
>             depends on X86_64
>             default 8192 if  MAXSMP
>             default   64 if  SMP
>             default    1 if !SMP

I'm all for making this a sane number, I'm just not sure this patch series is the place to do this?

> 
> 3) For memory regions, I would suggest 2048. Likewise, smaller value is
> also fine, we can enlarge it when a real system run into this.

As David points out, if the memblock size if 128MiB, then 2048 allows for 256GiB, which I believe to 
be too low for a maximum default. I'd at least target 1TiB with 128MiB memblock size, which would 
put the number at 8192.

Should the memblock size be 2GiB, for really big systems, then 8192 entries allow handling 16GiB.

With sizeof(elf64_phdr) of 64 bytes, that means the elfcorehdr buffer/memory segment is essentially 
512KiB.

Be aware, in reality, that if the system was fully populated, it would not actually consume all 8192 
phdrs. Rather /proc/iomem would essentially show a large contiguous address space which would 
require just a single phdr. The reason to consider having the larger number of phdrs is so that if 
the memory becomes fragmented due to hot un/plug events, then you need the phdrs to record the 
sparse mapping. The sadistic case is that every other memblock is offlined/removed, not likely, but 
possible.


> 
> I made a draft here for reference, with my undertanding. Please feel
> free to change it.
> 
> +config CRASH_ELF_CORE_PHDRS_NUM
> +       depends on CRASH_DUMP && KEXEC_FILE && (HOTPLUG_CPU || MEMORY_HOTPLUG)
> +       int
> +       default 3072
> +	help
> +         For the kexec_file_load path, specify the default number of
> +         phdr for the vmcore. E.g the memory regions represented by the
> +         'System RAM' entries in /proc/iomem, the cpu notes of each
> +         present cpu stored in /sys/devices/system/cpu/cpuX/crash_notes.
> 
> Thanks
> 

I'd prefer keeping CRASH_MAX_MEMORY_RANGES as that allow the maximum phdr number value to be 
reflective of CPUs and/or memory; not all systems support both CPU and memory hotplug. For example, 
I have queued up this change to reflect this:

     if (IS_ENABLED(CONFIG_HOTPLUG_CPU) || IS_ENABLED(CONFIG_MEMORY_HOTPLUG)) {
         /* Ensure elfcorehdr segment large enough for hotplug changes */
         unsigned long pnum = 2; /* VMCOREINFO and kernel_map */
         if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
             pnum += CONFIG_NR_CPUS_DEFAULT;
         if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
             pnum += CONFIG_CRASH_MAX_MEMORY_RANGES;
         if (pnum < (unsigned long)PN_XNUM) {
             kbuf.memsz = pnum * sizeof(Elf64_Phdr);
             kbuf.memsz += sizeof(Elf64_Ehdr);
             image->elfcorehdr_index = image->nr_segments;
             image->elfcorehdr_index_valid = true;
             /* Mark as usable to crash kernel, else crash kernel fails on boot *
             image->elf_headers_sz = kbuf.memsz;
         } else {
             pr_err("number of Phdrs %lu exceeds max %lu\n", pnum, (unsigned long
         }
     }

I hope this helps clarify my intentions with this patch series.
Thanks,
eric
