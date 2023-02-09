Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECE8690F4B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 18:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjBIRcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 12:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBIRcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 12:32:22 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95484216
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 09:32:21 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 319Gi3sG014368;
        Thu, 9 Feb 2023 17:31:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Nu3D0/MvZb4fMSrABq1BJHbh3phHko1WdWJPq7sSolM=;
 b=FUQNfmuMOGYfVTqHyiOeGOmp0Lpzs66NVBn2c9Rzoah1ukCjpAoYgOAzHVYLHMlesIhW
 YjIqvmn41y+lMkncJLlZLejKftLw5X5sFmIYigYS2fGRE34SqOkimmW0w2OI1yfx1cVM
 ZeREYkQ1efiCBO8VYYiiTO4lwfLooh+RQPau1Yp5s1wDJEPCDG8VcwCr/LjVfeEmXfNk
 rHqz+FkyGu2Bty+7ZrE07ZhWAfytZNnhgtWFlzaNemT6KfPIom0exEEaXSSRgpRn3Zzr
 yR7vzZi3L8ZUW6uHyRIw1kgQ4anTB1IwzKHePglQI/Z6/XaNkPLj0pCrPQxY6I29ycAf 2Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhdsduana-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Feb 2023 17:31:52 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 319GnouC015165;
        Thu, 9 Feb 2023 17:31:52 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3njrbdndbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Feb 2023 17:31:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRZu7BfQ89R+nyywznlH+fL64JsRGaNu2tzrRPS+kOOr56+n6LiFYaPeGgGpByfrRbwEGgYGea2KkYuoT7AKDLkWSD5Z6F7bpSnifNA9MQ63v+Vcp0KkyajxB+6PEJO/BG6kp5zTZy0cgVaWhx3OVWAHRzM+oGB2XPKF+3sjiJ8AZnZN7GEjxMsGxvb8/su9PuzWlC9lHsW6bVi0M3x2hSUE+EoCEQemD0/wq6zRumkLGkEK1qFDrsW8u5y79FlHvrFKtsjlSxpPt5Senr56+r4rVXHSSXMQ6EQbzmmWKc/JrQHJlpZBSaOpXiSYlVkaQbgVNOsHr6Y6lpKWvaEq4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nu3D0/MvZb4fMSrABq1BJHbh3phHko1WdWJPq7sSolM=;
 b=LzYuI+NKi+yrYW9lO2RQ4LF9TR+sPoOV8q+qSkg8X/R8semUwvzsAsU+Zq8OibqzJpbi4/MpV8VmO512gowJeFVbRjsVNYJg3sqgRoYgEqsIIxmkrM0Z0bn1ZzNVtY/vezNaMS45CiG6RPHIo6+8t4mspWaWoBgt4saFnYEh+95xf/qji6B8lWam9F3eRAPGHPQ/8pM2uZ2Yimb8MwzLEICRTr9zcoTRtF8chggOpHZPjb8mGke+8pgVnEmzCCISkoKTok9zWdYY8csNNV+Xl0cbe9rrTsuktro+fSFnTE+KSSF4B+R0NV2lZuagNIGf69gnJZ9In/BIjrW08h+NCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nu3D0/MvZb4fMSrABq1BJHbh3phHko1WdWJPq7sSolM=;
 b=qkPCLgi1fbwLnFRTqRdtGQxtk+O7Q3gmRFPdpFTzOwZHQm0H3Dy/uJwOJk0w3kOsxBV5+emumfAIQSEZPeZWMoaRmPzb0WQ7aqs5t2TzZhjYcI08Coc0nP3RX03Kqx6zATcvdJOOGpyoykQ2VZdFjvK7YKWEREKIEnZceYiS/f8=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MN6PR10MB7444.namprd10.prod.outlook.com (2603:10b6:208:472::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 17:31:48 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::2101:3ed8:9765:370f]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::2101:3ed8:9765:370f%4]) with mapi id 15.20.6086.019; Thu, 9 Feb 2023
 17:31:48 +0000
Message-ID: <7580421a-648a-2c4b-3c33-82e7622d9585@oracle.com>
Date:   Thu, 9 Feb 2023 11:31:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v18 5/7] kexec: exclude hot remove cpu from elfcorehdr
 notes
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20230131224236.122805-1-eric.devolder@oracle.com>
 <20230131224236.122805-6-eric.devolder@oracle.com> <87sffpzkle.ffs@tglx>
 <dd03f47a-0017-6239-04e9-e796dca03c0c@oracle.com> <87h6vw2rwf.ffs@tglx>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <87h6vw2rwf.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR12CA0032.namprd12.prod.outlook.com
 (2603:10b6:408:60::45) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|MN6PR10MB7444:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ff0bdb3-1c2f-479d-d2fe-08db0ac38552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H7hypN2m+RnF131Uf8NVX9qSVvsknoZ6kQsI0kftSPXn18T686Fkxp0fRd651Izp+aU3C7ph1HqCT39C/v2VU8SvelD96jvfI/fm94eMit+kEwbl4/juiJgG03Gpgzhz5ZklHz3a/l09Ql6ZQL6fm19M18DGmWyHPqGFwSa7Xb8QWWfCv2N2fLuX3ccrvi5Jueo3VPQoDsbfvZ63IaKS+Zx+SemLaCDqYvd5x6VGO5fHdRH1aw0a2QlwSY1gT6p97p5BJtYXmLxUJMLddnlTNtUL8xxsLY1YPI+PQm/gyjC0hOXb3Tycv8G1YdAYnEHFYxYF5PyItU4rTKaFuMKoQOhqeZ6ew4fPuJHUnMrTns19J2801yylnvEYmSbUNJIPZ+w/MsYSEGny/L8UpD96hhUbfOZY+xNR4Gwp/cjsbzEzB2YmswkPQ4HnLk7YBu+cj/kO9vT8BaeQGO0TdHeDUqY6yKOObxJk38OiAqkthSu01RCQN1jyJhln7M94QOhp6ks1r2u/clCSBHZM/2xlqyKTnC4dHYhv6wxAXdzHA/pjyBUMT/hTBEpIT8vXcAlzkB9rICe64aBlm/sUegrvvg+6WabPVM0uihvR7w9hY+fC1SuY/IgDwNt1BD+mT8cL0aZ1N9y7Z1xa29AMbDuoBLPTGLxP9SwpB2u5j0XsbnfIDVYTjrV7R8iAwazAbl7sGJfHAjtJTePUcP4xUXXHwoapaJOidCQ4hQNCOnV2UaI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(39860400002)(376002)(346002)(136003)(451199018)(5660300002)(38100700002)(31686004)(7416002)(186003)(8936002)(53546011)(6506007)(2906002)(6512007)(41300700001)(107886003)(6666004)(4326008)(8676002)(66476007)(66946007)(66556008)(2616005)(83380400001)(316002)(31696002)(86362001)(478600001)(6486002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTM5eVFua2Z0MU1qcFdiOUtBUm5NTklIV2V5bjVFSEdDczQyREdQdlA3aDF1?=
 =?utf-8?B?cXdsc3gyc0VzZEcxWWV1bGNSN00xTENBeWx0SlVPak9vVFB3N0U2cWNjV2NB?=
 =?utf-8?B?RnlVYkgwTnk4d0RtVW9OWWtGTHoyZlZ3STd2SUptRkpsb2NkRjRXUlM4S1lo?=
 =?utf-8?B?SkVmLzM2STN2MGppLy9pNVA3Z1VtbDJxOEd5aVJRdHNUVEJvcE91SlZyZUtk?=
 =?utf-8?B?NHRsdHYrdE01RUwzODJjWkd5WTVjK1BlckhaeHVjdFMvWGdEV3FmMi9rRE9x?=
 =?utf-8?B?d3FGTDQrT2VRVmFsZUtRM2VLQVVURUsvZmRja0s2UWNnYk5tODlmTEoyeWNm?=
 =?utf-8?B?QWRVRnZ5RGtGTXk0QTYzaVNWc1V1YzJ2Y3dEL0l1M0Fldm92Q3Y1MmY0ck1D?=
 =?utf-8?B?OHdOM1NTSy9iNC94RlJZRFhFcUtpOWVGOWJsbE1WamJBVEZkTFJZV210Tk5k?=
 =?utf-8?B?QlZ5VnY0RlF1QkZYc0VmUmtVa1J2TjBSNi9PcWQwekg3ZnZIRVEwYVZ6TTU4?=
 =?utf-8?B?Vkdkc0xRWEVHekRnVlIyb21ZZXY5Nmk3YVR3TC9kdjJJbnNXR2Q3VTIrRHdl?=
 =?utf-8?B?bFI5NHBqR0RsOTVXYXIveDlTeWhaZWN6TWpRSVYyNTJKZlRDMDdGMGhqQnJw?=
 =?utf-8?B?TzJYK08zczFYamp5MjdxMXdmNXU1cXlBQzU1aWRETGpGQ0k4bVM2eE5rWHFm?=
 =?utf-8?B?dG14bnoyb2xLWXhMRlZvR2RzNUcxdGErNGF5S21PMk1OY2l1eTNQZ3VhSFFz?=
 =?utf-8?B?UUdrWDlQN0VYMUZScnozamNiaGtMaVYvN0pwd3FDbTdyTU5KNGNWYmMwN0Nk?=
 =?utf-8?B?am0yNkpLTVYwUG4xUHhjTktROVJMc2Jvb2s1L1dWa0hSaVR0b3F2UG9tVk1a?=
 =?utf-8?B?T3pvcVBtMGtMMkgvMlJMNzBOTVgvKytnNlRlWUcxUjFhUEZ6Wk5rYmVQVko3?=
 =?utf-8?B?QUdHalpnNzEzcUFQclZPWFgwN3dtRFFObnpuSDZTRzZPMEw4ZExpT3JTUjV2?=
 =?utf-8?B?WTFuNGZLdW5hY2hvbzRQYVdURWVmS25ybTFIV1JrQmc1VXBHTmRsRU1OR1dG?=
 =?utf-8?B?VHRjNmhsWXVnUEN1SVVXbnJ3R0lzOFFPRWlqNFhqcWRVaGpLR2h5TFZRTW45?=
 =?utf-8?B?VC92dms3cnBHMVNlWS9PTGVyTStNN2RibUJieU5WcUl5U2pKamU5Q0d1S2Q2?=
 =?utf-8?B?Ukg0Ty9jMEt1TlZtYi9yVEgxOW42L0NuenFqeWsvMkcvRXpRemJUVkZ3SUdJ?=
 =?utf-8?B?T2tvdFpSUjZvUXVzUVYyQkhkRXRZVitXa2NzaTJBWmxIVEpjSFdKNmpVbUhi?=
 =?utf-8?B?TFJ2K0VrS1NiSVM1QzRkbXhkb3pzcWFSYU5hZjhKaVZLcS9kOW5JM0NLeGR4?=
 =?utf-8?B?WEZjTk9vU0hoM1Y0bzdpVE9mZUVhbHU1TDgzSit5QmxzY1JZb3YrWVFwR2Z6?=
 =?utf-8?B?dXF2bXR4bFVwUHphQmlGR0tQU1JDOUVoSDE0cHZGUUIvRFF1Um5aa3hQa1hS?=
 =?utf-8?B?eFh2MDB6aGRXYUFwbENrcXV2TDgvMjIzbGNTb2d3bHVqSTdpZmlUYnNrT2VX?=
 =?utf-8?B?OWVCQ3lLd09YT3FUMVBBUUF3eEQ5ZWJXa2RmN3B1TnNQWDhMMXBMZitsaE1h?=
 =?utf-8?B?eUZKU3RCNE4vYjVTelE2bnE5UVNpeVd0U0cyK2RTVkd2WkxvQkhDWnpsbS95?=
 =?utf-8?B?bFQ0Z0xXVzAzeGxpa2tHVVpLNjVpNHpPS204K2ZGaFRPNklxb2ZDMzRrbVJW?=
 =?utf-8?B?Q1dWWTlJM0oxbGJ6WUJJU1RwTHp0WlREcjkxMWtRRHVKaGR0SDh6eThpS0I4?=
 =?utf-8?B?bVFqeW5WTWxLNHNUQXl3MUc3Ung5SC9na2NsTytsaGxmVSt2TGNkdk12MFR0?=
 =?utf-8?B?R2RkS1U5dUMxaFZKREZHSVdEeCtGd21VZWdTY2o2SDFMN1piRHNWQXBmM1BU?=
 =?utf-8?B?a1JoUzRmNXI1SDBZc3pkYjYyQjEzUjJQUm5RTVlEMEVXWHpaaUJ1Tityczl0?=
 =?utf-8?B?dTlaR1FxL2hJRmdqSnNtOXpBSkNpQ2FJZTZUNHZtR2JXWXlleXZzbTJXcTdG?=
 =?utf-8?B?T3JCU3NMRVpYbUE2dGMxa3ZONnB4WWZNenQvUlFGSUN6SkZLZm1yaSs1elho?=
 =?utf-8?B?ZWpsRHlmVVYvMm9lQ056OElMUDlTS1loaHBpeklMeEZXc1ZYYWdnNS9yZ2RX?=
 =?utf-8?Q?xITQw0i3fO10zrgU9IyHm0o=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RTE1Vk9OVWV4VGE1ZmhmOS83VXJ6d05nNFZQd3FPSCtNS2k0TjhjeE50YTFx?=
 =?utf-8?B?RjBVUi96STg5SHdrOFh4bnVncHZxYmdKdVJtd2diT2N3MGJ6WitmNzk3blQx?=
 =?utf-8?B?NnROUDFxbWFxdmM2dnQ1bUM5c2UxaTRFTSszQUpOMTNkQ0xxSDNnN0htSmZ4?=
 =?utf-8?B?UEJRaWVnT3A5bnhLS29LV2VpR2JnZEdzVE1pS1hEY05PMEZnZFJWa05kZnRz?=
 =?utf-8?B?S1gyK0xHTlNKSXJrOG84Y1ZTWFpnejhxdERuaFJtSDdpU01Qcnd0c2NRUkxS?=
 =?utf-8?B?NTdKZVZXdEV1SEszUWNPaHdLU3hQZkVKOUNYMk1sQkJPNE9NWTR4Smg5SDR2?=
 =?utf-8?B?Z3BYeWJOSyswMUJ4azB2azNkT0pZVEl1YjdrVnlBekhQTEc1eTZYMWtFWGxK?=
 =?utf-8?B?aWhRVnhNZFp2L09qWkpoaVBGNVRmOHZOcE80ZXhtdDREOGFBN0pOL2pqWFZq?=
 =?utf-8?B?ek5jL3lWRDJnQnI5aXprNVJGcE9OYzc1YnJKR0RzaUI3aENtRVE3cm8yaEEw?=
 =?utf-8?B?NzN6K3VpcUFHNytJRVFFZ2hiYStmWVdGY25yN2tQZkZmeFNaZHZ0M2puZnB0?=
 =?utf-8?B?ZEFLUm1LOWkvM2xNcGpET0lZWmt6dU1Ualp5ZGFQZlN0bHhZcUR1dWhHdlRZ?=
 =?utf-8?B?VFhRbjAvc1RJU0ZNWnVuN1BIOFpSUHBmVDVsOWRlK1hSaWliWlVjbndtRGtI?=
 =?utf-8?B?MlFhYW9HWDVJZ000NFhHSllQRTgwa3VQMys2SThIMnFvVlh6QjJJWG9XLzNQ?=
 =?utf-8?B?dzBRMGhLVlV1YUpkaFdaWUYybVNhWkhRT25PYWVoUkRPMGQ4TWRjcEMxR09L?=
 =?utf-8?B?MURuVVN0YWxzUGswUEZLaXpwNG9PTTdoNjBuMGViOXVDenZaTlN1aHpMVEhG?=
 =?utf-8?B?YUphNys5d2ZkNGVXM29EVDV3bFcxd09mZzRhTTRnajB5QXM5d0NPVDErdkNM?=
 =?utf-8?B?SUxhZC9yNXhFKzMxMUtNcWQ2Vk5Haldzb0lkOHhDS1lHNElyL3ZZdW80WTdN?=
 =?utf-8?B?MXlnVVBGaWNvWWEyOEhnUVNXQmtoUWRudzNVREJQTDVqSG4zWm9na0hNd2lB?=
 =?utf-8?B?STJmSUNtYlFDYllMNlY1cFRPQlMvWVUxdTN6dkpTQmtNWGV0MW96QmRCRGRs?=
 =?utf-8?B?WnhveTVCOFp4cGJpTWR3N2dRTi95K09GazNvaXcyN0s5V09GN3VlNnlxZG5Z?=
 =?utf-8?B?akRkYldzWFhyN2NTR0piOXZRVXBrQVd1RDJlYURZMWFCQ2lDU3ROSmFrdjZi?=
 =?utf-8?B?WDNYTklJbkhSMjB0VmVZTXpycWp1M0o3VHljSHJYS1g2bGF2ZnM1dSt5UmhJ?=
 =?utf-8?B?cmQweXVrdVJEUEU1TmgwSStLV3JwWnhJU2w5QUh6M0xMUHF3QUFLTUFuYjYr?=
 =?utf-8?B?aHVDNUdaMHNxS0RJZDRkdmNabmhxL0lXTzUveUpIR2VTODlsbHk3S0xOMjNl?=
 =?utf-8?B?YU9Zak1haUI0TWFUN2tVWUgrWllPQXYrTDA0M2JydVlNc2Q0ZWtzNDN4RzhQ?=
 =?utf-8?B?am1zNTVJS25zbS9PMm5LUGM5c0xqVHhvQ2pnRzlwZXhTSktrdzVkOUJkZ1M0?=
 =?utf-8?Q?Tc96EbUmuhC30KfqCBPv60Wws=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ff0bdb3-1c2f-479d-d2fe-08db0ac38552
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 17:31:48.2233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0H92YUg29kr993hTMZIufrBfQFHF/QOYX0EgyLVyOgp7Hse8PqxfdsAGn3IlbfMX13hsZqU4R+UrQXKxvZWUqPKOukZiu5yZPTFI9stT28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7444
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-09_13,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302090165
X-Proofpoint-ORIG-GUID: p1GVGur91_r9mRJ-gMpQepC5fNwaUWoh
X-Proofpoint-GUID: p1GVGur91_r9mRJ-gMpQepC5fNwaUWoh
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/8/23 07:44, Thomas Gleixner wrote:
> Eric!
> 
> On Tue, Feb 07 2023 at 11:23, Eric DeVolder wrote:
>> On 2/1/23 05:33, Thomas Gleixner wrote:
>>
>> So my latest solution is introduce two new CPUHP states, CPUHP_AP_ELFCOREHDR_ONLINE
>> for onlining and CPUHP_BP_ELFCOREHDR_OFFLINE for offlining. I'm open to better names.
>>
>> The CPUHP_AP_ELFCOREHDR_ONLINE needs to be placed after CPUHP_BRINGUP_CPU. My
>> attempts at locating this state failed when inside the STARTING section, so I located
>> this just inside the ONLINE sectoin. The crash hotplug handler is registered on
>> this state as the callback for the .startup method.
>>
>> The CPUHP_BP_ELFCOREHDR_OFFLINE needs to be placed before CPUHP_TEARDOWN_CPU, and I
>> placed it at the end of the PREPARE section. This crash hotplug handler is also
>> registered on this state as the callback for the .teardown method.
> 
> TBH, that's still overengineered. Something like this:
> 
> bool cpu_is_alive(unsigned int cpu)
> {
> 	struct cpuhp_cpu_state *st = per_cpu_ptr(&cpuhp_state, cpu);
> 
> 	return data_race(st->state) <= CPUHP_AP_IDLE_DEAD;
> }
> 
> and use this to query the actual state at crash time. That spares all
> those callback heuristics.
> 
>> I'm making my way though percpu crash_notes, elfcorehdr, vmcoreinfo,
>> makedumpfile and (the consumer of it all) the userspace crash utility,
>> in order to understand the impact of moving from for_each_present_cpu()
>> to for_each_online_cpu().
> 
> Is the packing actually worth the trouble? What's the actual win?
> 
> Thanks,
> 
>          tglx
> 
> 

Thomas,
I've investigated the passing of crash notes through the vmcore. What I've learned is that:

- linux/fs/proc/vmcore.c (which makedumpfile references to do its job) does
   not care what the contents of cpu PT_NOTES are, but it does coalesce them together.

- makedumpfile will count the number of cpu PT_NOTES in order to determine its
   nr_cpus variable, which is reported in a header, but otherwise unused (except
   for sadump method).

- the crash utility, for the purposes of determining the cpus, does not appear to
   reference the elfcorehdr PT_NOTEs. Instead it locates the various
   cpu_[possible|present|online]_mask and computes nr_cpus from that, and also of
   course which are online. In addition, when crash does reference the cpu PT_NOTE,
   to get its prstatus, it does so by using a percpu technique directly in the vmcore
   image memory, not via the ELF structure. Said differently, it appears to me that
   crash utility doesn't rely on the ELF PT_NOTEs for cpus; rather it obtains them
   via kernel cpumasks and the memory within the vmcore.

With this understanding, I did some testing. Perhaps the most telling test was that I
changed the number of cpu PT_NOTEs emitted in the crash_prepare_elf64_headers() to just 1,
hot plugged some cpus, then also took a few offline sparsely via chcpu, then generated a
vmcore. The crash utility had no problem loading the vmcore, it reported the proper number
of cpus and the number offline (despite only one cpu PT_NOTE), and changing to a different
cpu via 'set -c 30' and the backtrace was completely valid.

My take away is that crash utility does not rely upon ELF cpu PT_NOTEs, it obtains the
cpu information directly from kernel data structures. Perhaps at one time crash relied
upon the ELF information, but no more. (Perhaps there are other crash dump analyzers
that might rely on the ELF info?)

So, all this to say that I see no need to change crash_prepare_elf64_headers(). There
is no compelling reason to move away from for_each_present_cpu(), or modify the list for
online/offline.

Which then leaves the topic of the cpuhp state on which to register. Perhaps reverting
back to the use of CPUHP_BP_PREPARE_DYN is the right answer. There does not appear to
be a compelling need to accurately track whether the cpu went online/offline for the
purposes of creating the elfcorehdr, as ultimately the crash utility pulls that from
kernel data structures, not the elfcorehdr.

I think this is what Sourabh has known and has been advocating for an optimization
path that allows not regenerating the elfcorehdr on cpu changes (because all the percpu
structs are all laid out). I do think it best to leave that as an arch choice.

Comments?

Thanks!
eric






