Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F5A5B4174
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 23:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbiIIV3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 17:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbiIIV27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 17:28:59 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A6A123EE0
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 14:28:56 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 289KYMGE020425;
        Fri, 9 Sep 2022 21:28:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=MG2y93cT8o7AjPyuFHH9G9qe+M4tmzPaR6CY9ntGDY0=;
 b=bkZRGLn0pmyiJdHpXs1ELeIwDorFL4UCQHmFfNcATvO9jFQpmrUUCP/SBPw+Ru4QR4zO
 jA/HNLg170Hb4b5ctfhWJBexyUG2deHDNEtzIHHy2zOMv6ZYMuBhMhpTDa0sSgv+rSLU
 0FUGV11ZUOok1ONrkiaRBoo5X+H/dQdjbgZXCWYgDJO/VQZh86L+VB8drEddeKZa0niA
 eeWAAiZcVTfBhUjKPfORAvWnqsQXJ5Gzr2o4iCJy2IlWnsePBhpKW/vCPhqy/A/fHN95
 SH86j2WZnGY7cr97UcpWlbUUdq1jRQs+J723kgYdO5yqI/GHTdRweYJOulE7Bz7EEyQq Iw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbyfu0fa3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Sep 2022 21:28:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 289J0vQv024565;
        Fri, 9 Sep 2022 21:28:20 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jf7va0sbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Sep 2022 21:28:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKJLzDMosmQJiwu0RCgmT26y4VOCT8nrnPQge9HfWut9yXy1Q9jJjXi1v/QcvTeUMXpfhQW2XkmHovtDPLlEEnLcbCeECwfIQ0nNI/Hg6o7OEOxjmwyBybcf7F8q9HnP6B8XmkBXBd82mw2ayqA0O2qidOxYymedRaJT29m7LoCh58w3MZvhbU9g+vY1zcylSrKsY/VmN1ccTXcghCsirPTpty36nXNcdOxpZJvbq/BHmqRVbuwwZAU4XZkESXoEPTQsY4eKvww2i2+FrVUQw99sRx8Z2PI3MVOyZiayaHeeHsa3zk2CyuKbbaWnIInLC3tc4EllyHNRkM2xDX1uqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MG2y93cT8o7AjPyuFHH9G9qe+M4tmzPaR6CY9ntGDY0=;
 b=diOZHcw5fekYkcr8V+At/YOc2n8jWnbroyTKpNpzYu/TJDd9mibRbTJ57ufvBtVbIT8EBWxKnCOg8FuMxNJmgSe8DaS3Fnahn8BTmDZ1IvQavNIebDa0xiXKaXxpS0NdM4zFDLavU9LkZtyPo4o+Rvi+b0UkylNyVbeRHGfo0oOG+8p14w8Q2f0uzS2cv4Mzgdy6dMD7+q6F5z34NMpvOefUUqLLfQNPDUd/WJxTIfqpgffxp/8pRi6PA3phvt2LVt9UIKqktRyjhlrjTusUw2VhvpqoIa6pkWthyRzj5HvXD81jIT3Qjt8ax68ANhNLeYkRUVNwTAO9jaMOBBWhEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MG2y93cT8o7AjPyuFHH9G9qe+M4tmzPaR6CY9ntGDY0=;
 b=LrqlvVq69zo7NPlN6vcNAH7fN8YPeG8Fwz4T1zZeE8FeywTOh8pn9FuPBfk/AdLbrlPkFt1fBydJ/ojM3fbrxbxuDQ+ZZjI+TOqF3mtK7jh8mWBUG56dFQ4I1szWLGZ+1kCBzvwaRKziLl4wCVL4ggGvRJbNRHzOqTuIxtLOopo=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DS7PR10MB5149.namprd10.prod.outlook.com (2603:10b6:5:3a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Fri, 9 Sep
 2022 21:28:18 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::18a0:409b:1256:1bcb]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::18a0:409b:1256:1bcb%4]) with mapi id 15.20.5612.020; Fri, 9 Sep 2022
 21:28:18 +0000
Message-ID: <d7dd336e-10ef-1674-05fe-45a755bca8d6@oracle.com>
Date:   Fri, 9 Sep 2022 16:28:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Subject: Re: [PATCH v11 3/7] crash: add generic infrastructure for crash
 hotplug support
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, vgoyal@redhat.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20220826173704.1895-1-eric.devolder@oracle.com>
 <20220826173704.1895-4-eric.devolder@oracle.com>
 <Yw7U5jYKcwZ+cMpu@MiWiFi-R3L-srv>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <Yw7U5jYKcwZ+cMpu@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0220.namprd13.prod.outlook.com
 (2603:10b6:208:2bf::15) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DS7PR10MB5149:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a96841b-fda9-4037-2c5a-08da92aa362b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ns1BIc+a18YNhOh2lLun8Y/fwKO3+dabwqH5sDxo2rVPsPoRZHnkivmHzFBWcjgMW7zwZHg1FCw8O1V05P40Bl2cjHSImdu5zTfkY75I05jFdlRKmoo1rWRagYrzUGIv88dvUH+VqL/n1doRFVRK7RyQQ3eBzvD8FjOeNuZnNU2ZjXPpNwhsc9jA+zmChDZ3ndZj9MbrLWLPj2k8fIFl6uEls57dtWGeRWWBEGOji7zau9rhVrLceQ0/+d2cBDgI/XCRA/rJxl20p2iOM1vNE+i3Lt03Z+/dnCaqTkoMvovScRW7EflxegBKF+MFf5dDqy0WwFLPkiPQbd00aFejtJVatWuROoWrE0zUTh0mvGONKl4iyB70N82iDgR0T+kJeZsFevpLxWNHEWc2ZV3sB/LKeHKCR5hLe5LdMup9bP/TF/n0/MkobgtKeVoyZBTYzcAIjJnOujlJm1MbvgnrBtc92g6nhQaMY8b40aYe6zkQDmVAUE9OQjt9SnVlSaslTlwN54HdpuQH+wUswDy2M5XWRbQA58aAjJA06kmFKAi4VeyqAewPKawtvAumOh61cVh4Jr0v3WD/X0AcxyBA0Jo4bHxK2zs7bOR+COJso5H8yIbrNpKpBM61U9G9uCq+aFYNNQ6TOOeOFtfoGxyPOgjH+wyDhUEqKup2J61BgJD1LQtJa6MxFJFVMPgFV6DA9cwP+DjeFEUaB4laxK+p42KXeO20ZU6hln5hPIwfIygN5m8vkPsMeU3eLW63DzOrvzLkpbRWKaz10mGKJWcKxQMesh70Tx4IVUxUxClLAsFK6o3pV+Tfk5lK1IsYjJX2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(366004)(396003)(346002)(376002)(31686004)(86362001)(316002)(6916009)(186003)(2616005)(2906002)(38100700002)(31696002)(7416002)(8676002)(8936002)(66946007)(66556008)(66476007)(6512007)(5660300002)(4326008)(6666004)(6506007)(53546011)(36756003)(41300700001)(107886003)(6486002)(83380400001)(478600001)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjJrSHIrNWh0U1RqSEloZURrR2k2MWVFS2JjN3Z6cWo0Sytvd3FhQ3M1WXVu?=
 =?utf-8?B?a0xCTUh2V2ZNVXZFME9sQmlEbmJ2RDdScGh0ZllZcEFYM2U2VldVNkxtNVlE?=
 =?utf-8?B?MUpxZzdjZ2svTWpDTHdZM3pmNlFlUFhOREIxcWlhSzluT3l5Znl3UUlJanMx?=
 =?utf-8?B?d0RMN211UXR3SXE2cnIzRk9HRHl5VDd2QkYwZHFnVUVCTEFoTVdSL21KZXN3?=
 =?utf-8?B?Q2s3RlBtUDBBbVY3bVFCRy9XcDV2T2xPdlRmd1ZOSDg2a2I3YlZxSE1tNzQ2?=
 =?utf-8?B?K2paTDdJQnBTU1M4RU5RKy9BbmxNMFQ2em9UeUN6NEhKMnBMM3NSSUo3WWQw?=
 =?utf-8?B?WVo5cjVhNEx5aVFMUEFPSXZQT2tCTStIbEJMMkZmSEVwVmh3QmhaRUlpZ3Y4?=
 =?utf-8?B?UW50KzNEb1pSY3dpSG1MOUdqVm9sRG9Xckw3OHl2T0RweXFtZTc1enNJSDJj?=
 =?utf-8?B?SGQ1cUNscU1FQ2pEbVp4Qy81VVdydmMvOCthK0JXZW9SclBYVW00c0JwcFdM?=
 =?utf-8?B?K1BweEM5U2FYa3hWWXc5SnQ5S1JsdFVFRE8zNmpYRVg0VjdiQnhxeXdLZW9k?=
 =?utf-8?B?Zi9CWWozK2dWdjBVSHBMOFMvckcvYlZYVmlURWhhUks1dkJNZm1FOWpZM1lW?=
 =?utf-8?B?amxwUHpZYnNyUWU1ZlpIcVNpd1p6SHJzazVnRkl5R0JlTlhDNW1YOTRmclRn?=
 =?utf-8?B?R000S0xpUXYyUU9NSVdIeWhsWUh1bU9GdElPTk11QkRiQjZHZEZQQU9xZFB6?=
 =?utf-8?B?MmtUNmFxQWlkQ3dqOWdiMnA4UnVPbHVCY1J3Q1o1SnQ5dmdhcmpvWGhFVWE0?=
 =?utf-8?B?cEpZak1rMU9rOGk5V3RRanNpaVUvR1NFMDdLQk1OeVljanp2T09hdWFtUlBH?=
 =?utf-8?B?Q1FuWVRSKzhydmppQkZFdHlFcmhwbXFqdzliei9zL0ZsT0NQMDM5THVINWI4?=
 =?utf-8?B?bktYclVBQS8rVmtoak5Bd2EyNWpqcnlrVUZJS2FzQnVLTnBBOTU3V1RFOGht?=
 =?utf-8?B?MU5MNDZ4cnFSV2MwWjE5a2dTS1Z3Yk5XaU5LWlVoRDBuVmhaalpOT3VTTXNU?=
 =?utf-8?B?VExHR2hVVWYvSlYwTXpVQnZVUkJabGdSQmlON3RZd3JZSVN5dFJHZFB0cktu?=
 =?utf-8?B?empwYkl0Z25CNmZXa2luR0k5NVR5Um5QQVF0UHRrZjhONDFsbFoyWllEWHhN?=
 =?utf-8?B?a3NDbVhrVmdHVkRPNU5WSFhMNnRubTBpTGdKRGFRa1N1M0UxZTFKM0NibHds?=
 =?utf-8?B?UTQrWUNvZzd5VFpJSnhpZlhJcGlwVGpHejhqbzNJcXBwejMwekF3Wlo5TnRW?=
 =?utf-8?B?SnZBbkxsVzN6ZExDZUlld0d4NTBqaDlDalFqb0xnYVJkY05tdXB6MW02Ymkx?=
 =?utf-8?B?SFRmVERxVVV2cDFVYlVHSi9LcThoVkcvTklEMko0bWgwOTB4QnlnV1Z0bzR6?=
 =?utf-8?B?eUNUNFQwWGQ1UEdNaXRsd29ONVc4VHRUNnBFdjJxR0ZMWUFmSHF1WldEK2Zv?=
 =?utf-8?B?ejM1OTBUYktJZTZmQm0waHhpMlk4RE5XWUpaVEE5U0xubE0zQ05UOGlEaU14?=
 =?utf-8?B?OHhHU0ZVVmpHVDRmN3pIWDFRbUZFT3EwNzBPcm91ZnRHdlJEcWtnejNMZjk0?=
 =?utf-8?B?V2ZkRVZRZFgrT2Q1OHRIaDEzWVpDSmt6SlNpMmhjQW1ib3RsWHVHU0ZkN0dJ?=
 =?utf-8?B?WFZ4VmhQQ2RsZVE0TkgxODRBd2ZnZ0Fyc3BPeWJDWC96QjVUdWU5cnhSeWFE?=
 =?utf-8?B?QngwNG5ORkpkT2lldVRiME1NUXgzbUdBU0hMRzUrbnE1TmE0QXFRbzFCNURn?=
 =?utf-8?B?eTh4OWEveVpxazhmL0hOUzNURjEvVjNTdkRIdHJPb3ZUZVlzOHc1R0JBRnJh?=
 =?utf-8?B?OU9ETmxvWWlHU0g3dDdwQUlPRjFmTXo0WTNFWHFLUm5nWFhqVVM3U2UrdGFw?=
 =?utf-8?B?aUNTMkJyRytiOVBGSWpNWFk3YU9BYlQ1WWo3RHN3VDJka3NGdVB2bFJ6N01I?=
 =?utf-8?B?cDFSL3pQWlpBdWcxblZML2FkWGhFN3dmR01xQlAwREw3dkdLZC9ILzAzMnhR?=
 =?utf-8?B?WnhlZENEd0hNajl1WWNDUmFORFZaWE82aG4wd1QzcWJHeThxTVk3eUk5RDR4?=
 =?utf-8?B?TTlDWmJ5QURCaHVrM1lHL3k1QlJNQnk3MGMxWkFmQS9kd3FxRVQ2WHVEbFFX?=
 =?utf-8?Q?LauZLceWvmUNHI0dAsLlkb8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a96841b-fda9-4037-2c5a-08da92aa362b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 21:28:18.0209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1YB/M9tH+i54+yQMo4ol43HcTbTPdj2EsCE5845vmxbtXvvgQPBE6VolYWbTu2rmiV0lkj6cVvn8gxdGhDJ2eHyq8fyAZm/yc7RFNk+/70s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5149
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-09_10,2022-09-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209090075
X-Proofpoint-ORIG-GUID: 9Bs27g0MX6vDIHOwS6m29URK9mX4tjDE
X-Proofpoint-GUID: 9Bs27g0MX6vDIHOwS6m29URK9mX4tjDE
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/30/22 22:26, Baoquan He wrote:
> On 08/26/22 at 01:37pm, Eric DeVolder wrote:
>> CPU and memory change notifications are received in order to
>> regenerate the elfcorehdr.
>>
>> To support cpu hotplug, a callback is registered to capture the
>> CPUHP_AP_ONLINE_DYN online and offline events via
>> cpuhp_setup_state_nocalls().
>>
>> To support memory hotplug, a notifier is registered to capture the
>> MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().
>>
>> The cpu callback and memory notifiers call handle_hotplug_event()
>> which performs needed tasks and then dispatches the event to the
>> architecture specific arch_crash_handle_hotplug_event(). During the
>> process, the kexec_mutex is held.
>>
>> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
>> ---
>>   include/linux/crash_core.h |   8 +++
>>   include/linux/kexec.h      |  26 +++++++
>>   kernel/crash_core.c        | 134 +++++++++++++++++++++++++++++++++++++
>>   3 files changed, 168 insertions(+)
>>
>> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
>> index de62a722431e..3b99e69b011f 100644
>> --- a/include/linux/crash_core.h
>> +++ b/include/linux/crash_core.h
>> @@ -84,4 +84,12 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
>>   int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
>>   		unsigned long long *crash_size, unsigned long long *crash_base);
>>   
>> +#define KEXEC_CRASH_HP_REMOVE_CPU		0
>> +#define KEXEC_CRASH_HP_ADD_CPU			1
>> +#define KEXEC_CRASH_HP_REMOVE_MEMORY	2
>                                          ~~
>                                          Nitpick, These arenot aligned,
>> +#define KEXEC_CRASH_HP_ADD_MEMORY		3
>> +#define KEXEC_CRASH_HP_INVALID_CPU		-1U
>> +
>> +struct kimage;
>> +
>>   #endif /* LINUX_CRASH_CORE_H */
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index 4eefa631e0ae..9597b41136ec 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -374,6 +374,13 @@ struct kimage {
>>   	struct purgatory_info purgatory_info;
>>   #endif
>>   
>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>> +	bool hotplug_event;
>> +	unsigned int offlinecpu;
>> +	bool elfcorehdr_index_valid;
>> +	int elfcorehdr_index;
>> +#endif
>> +
>>   #ifdef CONFIG_IMA_KEXEC
>>   	/* Virtual address of IMA measurement buffer for kexec syscall */
>>   	void *ima_buffer;
>> @@ -503,6 +510,25 @@ static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, g
>>   static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) { }
>>   #endif
>>   
>> +#ifndef arch_map_crash_pages
>> +static inline void *arch_map_crash_pages(unsigned long paddr,
>> +		unsigned long size)
>> +{
>> +	return NULL;
>> +}
>> +#endif
>> +
>> +#ifndef arch_unmap_crash_pages
>> +static inline void arch_unmap_crash_pages(void **ptr) { }
>> +#endif
>> +
>> +#ifndef arch_crash_handle_hotplug_event
>> +static inline void arch_crash_handle_hotplug_event(struct kimage *image,
>> +		unsigned int hp_action)
>> +{
>> +}
>> +#endif
>> +
>>   #else /* !CONFIG_KEXEC_CORE */
>>   struct pt_regs;
>>   struct task_struct;
>> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
>> index 0f8aa659cca4..455150205ded 100644
>> --- a/kernel/crash_core.c
>> +++ b/kernel/crash_core.c
>> @@ -11,6 +11,8 @@
>>   #include <linux/vmalloc.h>
>>   #include <linux/sizes.h>
>>   #include <linux/kexec.h>
>> +#include <linux/memory.h>
>> +#include <linux/cpuhotplug.h>
>>   
>>   #include <asm/page.h>
>>   #include <asm/sections.h>
>> @@ -18,6 +20,7 @@
>>   #include <crypto/sha1.h>
>>   
>>   #include "kallsyms_internal.h"
>> +#include "kexec_internal.h"
>>   
>>   /* vmcoreinfo stuff */
>>   unsigned char *vmcoreinfo_data;
>> @@ -611,3 +614,134 @@ static int __init crash_save_vmcoreinfo_init(void)
>>   }
>>   
>>   subsys_initcall(crash_save_vmcoreinfo_init);
>> +
>> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
>> +/*
>> + * To accurately reflect hot un/plug changes, the elfcorehdr (which
>> + * is passed to the crash kernel via the elfcorehdr= parameter)
>> + * must be updated with the new list of CPUs and memories.
>> + *
>> + * In order to make changes to elfcorehdr, two conditions are needed:
>> + * First, the segment containing the elfcorehdr must be large enough
>> + * to permit a growing number of resources. The elfcorehdr memory is
>> + * typically based on CONFIG_NR_CPUS and CONFIG_CRASH_MAX_MEMORY_RANGES.
>> + * Second, purgatory must explicitly exclude the elfcorehdr from the
>> + * list of segments it checks (since the elfcorehdr changes and thus
>> + * would require an update to purgatory itself to update the digest).
>> + */
>> +static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
>> +{
>> +	/* Obtain lock while changing crash information */
>> +	mutex_lock(&kexec_mutex);
>> +
>> +	/* Check kdump is loaded */
>> +	if (kexec_crash_image) {
>> +		struct kimage *image = kexec_crash_image;
>> +
>> +		if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
>> +			hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
>> +			pr_debug("crash hp: hp_action %u, cpu %u\n", hp_action, cpu);
>> +		else
>> +			pr_debug("crash hp: hp_action %u", hp_action);
>                                                         ^~ "\n" missed
>> +		/*
>> +		 * When the struct kimage is alloced, it is wiped to zero, so
>                                               ~~~~ alloced is confusing, s/alloced/allocated/
>                                              We can accept alloc being used, alloced is a little weird.
>> +		 * the elfcorehdr_index_valid defaults to false. Find the
>> +		 * segment containing the elfcorehdr, if not already found.
>> +		 * This works for both the kexec_load and kexec_file_load paths.
>> +		 */
>> +		if (!image->elfcorehdr_index_valid) {
>> +			unsigned char *ptr;
>> +			unsigned long mem, memsz;
>> +			unsigned int n;
>> +
>> +			for (n = 0; n < image->nr_segments; n++) {
>> +				mem = image->segment[n].mem;
>> +				memsz = image->segment[n].memsz;
>> +				ptr = arch_map_crash_pages(mem, memsz);
> OK, I see. You want to avoid the over 80 chars line, so introducing
> two local variables. We may be able to tolerate that in this case. No
> strong opinion, let's see if other people have concern about it.
> 
> Other than these nitpicks, this patch looks good to me.
> Acked-by: Baoquan He <bhe@redhat.com>

Baoquan, I've had no other feedback; I've corrected the items you've pointed out in this and the 
others. I've posted v12. Note that all patches in v12 now have an Acked-by!
Thanks,
eric

> 
>> +				if (ptr) {
>> +					/* The segment containing elfcorehdr */
>> +					if (memcmp(ptr, ELFMAG, SELFMAG) == 0) {
>> +						image->elfcorehdr_index = (int)n;
>> +						image->elfcorehdr_index_valid = true;
>> +					}
>> +				}
>> +				arch_unmap_crash_pages((void **)&ptr);
>> +			}
>> +		}
>> +
>> +		if (!image->elfcorehdr_index_valid) {
>> +			pr_err("crash hp: unable to locate elfcorehdr segment");
>> +			goto out;
>> +		}
>> +
>> +		/* Needed in order for the segments to be updated */
>> +		arch_kexec_unprotect_crashkres();
>> +
>> +		/* Flag to differentiate between normal load and hotplug */
>> +		image->hotplug_event = true;
>> +
>> +		/* Now invoke arch-specific update handler */
>> +		arch_crash_handle_hotplug_event(image, hp_action);
>> +
>> +		/* No longer handling a hotplug event */
>> +		image->hotplug_event = false;
>> +
>> +		/* Change back to read-only */
>> +		arch_kexec_protect_crashkres();
>> +	}
>> +
>> +out:
>> +	/* Release lock now that update complete */
>> +	mutex_unlock(&kexec_mutex);
>> +}
>> +
>> +static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
>> +{
>> +	switch (val) {
>> +	case MEM_ONLINE:
>> +		handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY, 0);
>> +		break;
>> +
>> +	case MEM_OFFLINE:
>> +		handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY, 0);
>> +		break;
>> +	}
>> +	return NOTIFY_OK;
>> +}
>> +
>> +static struct notifier_block crash_memhp_nb = {
>> +	.notifier_call = crash_memhp_notifier,
>> +	.priority = 0
>> +};
>> +
>> +static int crash_cpuhp_online(unsigned int cpu)
>> +{
>> +	handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu);
>> +	return 0;
>> +}
>> +
>> +static int crash_cpuhp_offline(unsigned int cpu)
>> +{
>> +	handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
>> +	return 0;
>> +}
>> +
>> +static int __init crash_hotplug_init(void)
>> +{
>> +	int result = 0;
>> +
>> +	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
>> +		register_memory_notifier(&crash_memhp_nb);
>> +
>> +	if (IS_ENABLED(CONFIG_HOTPLUG_CPU))
>> +		result = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
>> +						   "crash/cpuhp",
>> +						   crash_cpuhp_online,
>> +						   crash_cpuhp_offline);
>> +
>> +	return result;
>> +}
>> +
>> +subsys_initcall(crash_hotplug_init);
>> +#endif
>> -- 
>> 2.31.1
>>
> 
