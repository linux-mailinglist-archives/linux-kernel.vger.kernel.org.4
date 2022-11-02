Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2379616D3D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbiKBS5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbiKBS5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:57:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193AFCD6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 11:57:47 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2HT6WN013641;
        Wed, 2 Nov 2022 18:57:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=trzihmBIGAIOZaXvSx1PqAymaVPgz3hZer3chlDb0B0=;
 b=1/ohXfvzqtQsRb0o16v2qFldWOGiIeElhYK/i6s73wL1FUWiRh28faI+lO4zlZyIAeCO
 605f1DEFHirjU4zPZYMaR9h+rM+npe5Bpaj22jlZuPA7fLg1EqxFwhMBjxvsEbruhMi8
 fGBQqoT98LxzHYioacRFUypd/NbaYwuQh+b3INvKXmZui+hJoabXieD7ObxLutUMwwUh
 uHz6G/5SfNUkt6+YS3ETr8dlgBsJXDEwjAGr21L8efjANWVcc3Gir7+2ap3T4h8Ye1Oy
 MQu7whr6kP3M6Oxn8gSd8ylaNmwjBpvP8+DhP0stmOvxnng6SWTNaeKP3r6SQsB3tl7G fw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgtkda85v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Nov 2022 18:57:25 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A2IH7tU012172;
        Wed, 2 Nov 2022 18:57:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3kgtmc5xej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Nov 2022 18:57:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DF3POUH/MV8jnb4fMaF0eyJ+xY7bk9FfwYOPBLQKp9jWtUQJ7RWITYhCUzlTsz/Ow6LtH0wr7oo5L++cfj3vg490BUpDpC5h4w/XrV0CTI/dKSe9gHtps0Ir5Tux3d+7QTi7gdEqFul/KimtBxgiOMrSZdYqLG9LdMFTncoDNDajsHQEmfZkakRSkGWJJHk7FVyIj7kmsHbrk73VuujWGXiqIAVGLw0makkMCliRKXtMQjKcikslxeNIME9/AKJyXgNo+jBvzZKvv7cDfo8uuUp+k3Ffl/qGvTjXJ8yMzG9OCqQdsqMeFElTrD+53h/T/fU79plGho/Cp1BoHe15Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trzihmBIGAIOZaXvSx1PqAymaVPgz3hZer3chlDb0B0=;
 b=oaQdqKROT1RjhZTcHdoQt2iYpnfutN0UwC5wG4VaGJ6ZU8ycUnQVjnhEXGidBeedVSdUZWwiJ5lLKJnGO0As2iK4qJztuYS/qQGLgrT2MUh5Q6n4S1NXH5ZnZY0zhEQGVOA82pzwjlv+CA7HiJUisyfE3Eim1OglZm0V4MR+GGb2TR39vi+5gGiz8V8TPsnJ+jYNY+fA4w/Ko89fHu7bifUUdYS+/MISZ/hPcYCCHHinOgymFF+i+uui5i+SNUkzAwkOJ5DvseJawhAEXJZXRd3vnVzeKKuIY/ALPPyriuKWHcWEVzTjfrjYWO481ival3qA1BTkQSPTiaect1KDQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trzihmBIGAIOZaXvSx1PqAymaVPgz3hZer3chlDb0B0=;
 b=k3xMdXQuFDktttC1QwdsaJjUsViqN+3SfJQQVjFyyDigXeE7tf7qjHCvkb41fgyDr/h5/82EzLDtNW9BiAv8azvZgN+zi9OKYxCT1yxJdKCsyBtMr86q7XWE4M6wva7vZVWx04eNLNDegRGxR34UJTF/8WGS2bFyvuoUswAkQ6c=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS0PR10MB6704.namprd10.prod.outlook.com (2603:10b6:8:13a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Wed, 2 Nov
 2022 18:57:22 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::f7b2:af85:fe37:31a7%8]) with mapi id 15.20.5791.020; Wed, 2 Nov 2022
 18:57:22 +0000
Message-ID: <a01a43bf-0d2c-cb7c-bbe1-352b77c07fce@oracle.com>
Date:   Wed, 2 Nov 2022 13:57:14 -0500
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
 <c08bb557-846c-0f82-391a-3eeda7e6ea67@oracle.com> <Y2K7u+KfkdBxJ01h@zn.tnic>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <Y2K7u+KfkdBxJ01h@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0023.namprd11.prod.outlook.com
 (2603:10b6:806:d3::28) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS0PR10MB6704:EE_
X-MS-Office365-Filtering-Correlation-Id: bd581ee0-8694-48f5-f420-08dabd0412bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jmezV1Zvz1SEh4eSX+Os6S4jYF4j4AVAFl9O28xiSq/vuF1/EwCVw+GzYyNzgE67+JmfFqSxfwtpzFdiu8WeUg9pFA6MDf+LeBhIFIBYz+AlluvYd2OvmYfYqKeIb1qFNXk5xy/TmNpGc+4K6ccnuEWkvVZPzTyMQyXvCkRwNMpcvYzsJ3RYz7xK9yis1nVvheOROrHo9lGNWua1HEwjGPCFdgko4EOKmhQFRqTe7UUCALubqd7ekIg0Cz5N8a6uBZALKjRZYa8MnP8MfOerBWoWUPjGVV0hhGOTd489vmaenJkuN8cy7nnfK7qajTqz4UFWIvPeTxgA17gDGMnMQ6xCpod64XmoJ4Sg1Q+CPT2rjA3AtDjC2UVcoiF0KquKP+Dr3coup96ijVTTF/JuOmM2zX+BwGubtGAh5Q3wq+hzsHWKAXqPaojLjCG1F/McqwwvgkqrrxIoD5+ziwmEg0kgA1AerxFDmSQ0DJjEUvcHOG1d2bZjXPWfBMZJugAdLwmBNTsCUvgvQ3vpWfwnMz477XCY3q5jHRZQoiVRuZYDXmu2ytV70ncCn3IZN1ZYSvVdqdA8TkMRbA+Wx6rBJve/wl8jwYWcuD4oRE0Uju5x+rWaYZp6K2+hUzX4lviPoGDlEpVMBaN46z93kvyifr9JV5boONiOiwblheisRStWSeu6McKyvAf6Nv78n5qgheuvxg3y2FicTTOmdOBy/G9L17JzQDLbkK7BkkE7kekFLrdo1NRQ9GrfE17+MeVfUtMzP1jpQxuBbk13GVilOanmf/+xNm1MKvvg69m9EEo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199015)(2906002)(31686004)(4326008)(6506007)(53546011)(41300700001)(8676002)(6512007)(36756003)(31696002)(86362001)(7416002)(38100700002)(66946007)(478600001)(8936002)(2616005)(6666004)(316002)(186003)(107886003)(66556008)(5660300002)(66476007)(6916009)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d21OTFplbFZTWk1rRUQxdTk4WENHa0JEUDVwaUZwVFpCRU9BL0RXdnFEN1Va?=
 =?utf-8?B?cVZTSkZYQzZyTi93TEJPbkVhSm85Mnl5TjJxWlNTQWlvTitPeVN1SU13UlVa?=
 =?utf-8?B?QVljUGJUVWFmRFc4RWhWRXdhcU5HMTRxNTM1SldmcVlJM09ReUFsQytaV2xi?=
 =?utf-8?B?QUo5ZTJYdVZhS1FDYjV1d1dGZ0h1UnVwbnQyaGFiaGxlRmticnpaempYQ2tT?=
 =?utf-8?B?Vmx2dkJza2w0ZXpzeDQzWldyOEg5TkpxeHJnQitNbXRpU1FTbklxREY2YlpJ?=
 =?utf-8?B?dkpTV3B0OUNMTTJDUU9xUzVOV0N4WldGMTBlTGZraHNQZUU5VTBkaE90Zkdi?=
 =?utf-8?B?b0VaMFlzd1E5dE50TkdTVDB0NVlrTmR0endMS3d6V1lGOUJaMkFyYlVudVZ3?=
 =?utf-8?B?WXkvZ0tHeW1oUFhaNnZWTWV3OXFsMmVhVUFMdk1DRS84T0dZRDlUZ1VVZ1ds?=
 =?utf-8?B?aThQWkpLa3JrdjlCTW5WNkVkTkFkTFNodGIrTnRjOVJyUFJ1NEJ5cmtHVFJD?=
 =?utf-8?B?SENYbElCYXBRbUkraUdCNUlrL1phM1lnYmhjMHpDQkdvV0NuQnFKMHYvM2Vq?=
 =?utf-8?B?OWhFdFZRaFJOK084S1RWVC9yK2JOSyt2SGlMSG9wQVVhallaeFBwdmVSTUdl?=
 =?utf-8?B?WXBMS3R1aEYyVnNJRGxEYlBGU29XZGRnWU9EOG9QQStNbFV2dDRSc0dYK2dv?=
 =?utf-8?B?cmpnNkw0c3VSSVZLbldlOVVXU2NtdHdIR1ZQdzhZVHZndjNvamY0MFc1REsx?=
 =?utf-8?B?WllyRWVjRWtQYzFuYVBWVVpBS3V0ZTRMbXQrZ1dSbSsvd2djWERXVzAwZUVv?=
 =?utf-8?B?aFpEYjJnSDZsTkZROFBZOXJId1hwUkE3aW5JSzBreEMzOUlNSzltOWJlUVRu?=
 =?utf-8?B?Q2tOQzFHd0RNaGdNYjhHMVAxQ2xvM0pXQXdwTHdCcmRJYkpBdWdrWVpnVWpi?=
 =?utf-8?B?WEZzTzJaa0NnWERURmQwVzNQNHRjczRmelFFUk50MG9rS0ZsclYvdHVEYkZr?=
 =?utf-8?B?YjFhZmVWOG9GQytjU1l0Z0ZVVWhNSzJkSGVhQzM4V21MalNIMHlMSmtXN29i?=
 =?utf-8?B?RUdHc3AvTEJ4d0hJamZUSXNaWHR5NDJ6MnNyWThCeU96MGJjeDhKWVVFZ2Z6?=
 =?utf-8?B?VWpaeDVFSk1kSHE0WEl1UmtYOExLMUx1M0dobWZQWERtb1JIRDQ1STdiRzNW?=
 =?utf-8?B?VWdUeVJqUlNTOE5MSmxaclhnR3ZnZGJSak1HZDI0VlE3Rkp6UDNCd0Z6akM4?=
 =?utf-8?B?VlRZd3lqMzhiTVhwckFnZ0lOaVhaZ1lTY1kxdkdJYnZFVWUwTENYQzBYVXJH?=
 =?utf-8?B?NWVUWjlDbU1pRUFjUDJocjBGVkVadFUzRVBtbDJaR2NWQitOeFY5TmZqM2Zo?=
 =?utf-8?B?UmM1ckpVb3VEWFF2YkxpMFZHaXY0V0ZFREZaaUd0dFZtWWZlaDRkRkVBby8z?=
 =?utf-8?B?Zm5MeTdwY0wxeGhTQU52R3kreVE0UFRZREhnbUlJUmRweVpsbWw0VzIwQ0lB?=
 =?utf-8?B?R08rSVRIc01tMEozR3lVVXM1dDZTKzBtYzVlVmtIenc0REJ0L3gyU2k2UWxk?=
 =?utf-8?B?Ui9PdE1rTGUwekUwMHkwWFZBazZzUVhIMWt6blFQcEIzQkRGQ2szNHl3ZDNZ?=
 =?utf-8?B?YTNhcWkzTVgvVVZoZU4xN01DUFJ5SExCSndLV3dzVGxmbHk0SW1xSUlTdlJT?=
 =?utf-8?B?RGxncVU4YmY1WkRvLzFLUlJWcmIzaW43REVCYVpXK3BaWFFDeE96WjZ2NmpH?=
 =?utf-8?B?enQyL1V0YkhTRngxZFozUzgxT01XY3JXc1FYdTYxclZsVDA0a1RRUlNiYzRh?=
 =?utf-8?B?b1l4WUZlZFE3cktGaE9iMkEwZGp5Sk5YbWRJNG9uNVJaNDFadjZGNVlObVFB?=
 =?utf-8?B?UlFYTVNBbGkrZ3ZoN0ZmMDZ4Y0FURDcrUERrMUVFRWUvRWNhMmwrNWltU2Jw?=
 =?utf-8?B?NjJqMmpSM1FGbUR2aXZMM05HRXc5bzgxemNwL3FZc0Zkc1IzOTV6WmQ5UCs0?=
 =?utf-8?B?MW5NY1V1b1RQYWc2NHhTSlJzeHJrb1Q4Szc5L2dnaFRnYWZSaDJEUXhQdXhT?=
 =?utf-8?B?SE5Yd05xblFmTGlMNVVuVnpSeEVNd0lNZ05FS1llZ3RBQnFBWGpLRmhCeDVu?=
 =?utf-8?B?cmJ2Y1R0MVdZa2JTSzdPMUtpdi9RUlZBaTVXUUJ2YjdpUHorN1g1THNleElR?=
 =?utf-8?Q?biSpL05fdlyYuhcAJcnXDsg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd581ee0-8694-48f5-f420-08dabd0412bc
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 18:57:22.0425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Z1Y6D7k9iJ7XqV5i0eEMQj1SkZE6M8u1B9zBqedx9MNDF1gC/aNRKiChdgWQQvEfQt8fT5EOjF/oyGjYwbIg2zvzeZkVG5aFZh+CFvSbjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6704
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_14,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0 mlxlogscore=750
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211020123
X-Proofpoint-ORIG-GUID: _SfYb6bgy1Q9tT87pyezrZN_AO8HhEKv
X-Proofpoint-GUID: _SfYb6bgy1Q9tT87pyezrZN_AO8HhEKv
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/2/22 13:49, Borislav Petkov wrote:
> On Wed, Nov 02, 2022 at 11:54:08AM -0500, Eric DeVolder wrote:
>> Technically the answer is no; cpu hotplug events are independent of memory
>> hotplug events, but both are written into the elfcorehdr, so in reality
>> yes... The elfcorehdr contains a single list of Phdrs describing CPUs and
>> crash memory ranges; the entire list is re-written on a hotplug change.
> 
> Then technically also yes. Otherwise your crash information will contain
> wrong CPU numbers.
> 
> How has that not been a problem until now...?
> 
> I.e., offline a bunch of CPUs and then cause a crash dump.
> 
> Hmm.
> 

There is a solution for updating the elfcorehdr today, for when say a bunch of CPUs are offlined. It 
is done via userspace udev rules to do a unload-then-reload of the entire crash kernel system 
(kernel, initrd, purgatory, boot_params, and of course elfcorehdr). This performs extremely poorly 
in highly dynamic hotplug situations (such as when adding alot of memory to a vm), and thus the 
attempt at this solution.

But I sense I missing your point?

Thanks!
eric
