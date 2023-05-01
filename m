Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DBA6F35F3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 20:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjEASl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 14:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjEASlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 14:41:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4B419B0
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 11:41:17 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 341HNsM2017740;
        Mon, 1 May 2023 18:35:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=oPp6OBeqRThFWi53gQ/GVE2PfDM46+8svSThcQEFXPY=;
 b=q7WUuptZss/ypgvejSyUVb41wITLnx+SzEQBEhA9CY34NVX+xgVAHczm1RQbIYiCucUf
 +s3V6cASjMHQxr9h/osVwsWEI/7hezVot4bS2tBdqD2RoTvR1oZPUk6/DQiDo7npMMYM
 zzHCG0aRPoW3Zswdu4YBCZR3ewxpgfe7i+OegLLB4jMokQc09gQPJX2qv4/+JVzeoATi
 DPJZAWIV2rf1ifk+f8fVkahY3vflrb6zb9q9eXcacmUtgFGWNN/hjR8NIv7tO6PIhjWR
 D/lwNLzIQ9sNcX8tYu+w2mZS7yIXzBsLoecsekwpYnpiK1A0s05IehAra30cZ0H78cC0 LA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8sne3094-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 May 2023 18:35:55 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 341ILnIS013641;
        Mon, 1 May 2023 18:35:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp58pqb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 May 2023 18:35:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fVzRlssUaVyKVbiSowJEVOpzmeARRJqS67ZPxzsp7N+4qSmb+i8RFSBg/oUr9TyeZUHoOJczJBZJUYgmix+VHeim36V/Cy1Cjad9wUPufQHf81SOoCHxcxPIvugOLW/iD9SgF5+baC+X0OY+dGQadOlgZV6mN1SkCsPzx+axscq5Kw7yHKrIDZtJl0r/x3wlzj1LYsEjCq0TWCku3cBjZBnacBbHSpNTbzMg/kp2yCfv2a9aU8n3Fo83+/+j7rWnDonAjT7tBuXYk2IPKvSvaqa5lVz0eSogysmze68RwyzhrMe0qyF0FLDNr/cua3E+ZoO5A5WVYrRARXAE0z8Abw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPp6OBeqRThFWi53gQ/GVE2PfDM46+8svSThcQEFXPY=;
 b=bsz4DuEBvO4WxYFhrpYJX7DNx50M9W1BsHELsHXL9GLMyOFKlxjByJD9cOkDFQygSFZWafWI4M/uUxb0JYt7u0MjY1N+IQFTUXSnLyEcgYzbWim72Aox/R+6D+sOtwDz4tnzzOBuWHscfAE+ao6kUBsY/MIIdxT0td9Oz+z9Jb8msEM0lnp5/jZxlrUtZj1je1tpcT7qsr9t76aBza/Kz0RXKnTAvY94X+apWcICa31L7j6iPaE7G7NZYtuxNR/mYTb0zpmEoDyLK2tbK4F9VEI1SalgN+zQsRz6i8CvNGxynPbonQOiXflwt7agd2xE5R/AavdNkqZt52oO9fpksQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPp6OBeqRThFWi53gQ/GVE2PfDM46+8svSThcQEFXPY=;
 b=Z0cZltXsWJ27REsuKLeaWGkc7F428Ns/7Zc3ScbxKLwmB7kH8FZ4W3muVrH55Tpi39ZvUqgjhay1wq4cBnUvVQinAPKWfb4lcO0X5+fjHFeR//f42f9UdTG1oSexz3z4o6+HZUX6SuYGxJPIiSMCCIPdoIeb1NAMBo4fheNJi5c=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by SJ0PR10MB5804.namprd10.prod.outlook.com (2603:10b6:a03:428::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.30; Mon, 1 May
 2023 18:35:51 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573%5]) with mapi id 15.20.6340.024; Mon, 1 May 2023
 18:35:51 +0000
Message-ID: <81cc2721-7a56-6142-5189-a572848d115d@oracle.com>
Date:   Mon, 1 May 2023 13:35:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v21 0/7] crash: Kernel handling of CPU and memory hot
 un/plug
Content-Language: en-US
To:     Hari Bathini <hbathini@linux.ibm.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20230404180326.6890-1-eric.devolder@oracle.com>
 <2bc7d559-d827-bae9-33e0-4b7ca172ce5d@linux.ibm.com>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <2bc7d559-d827-bae9-33e0-4b7ca172ce5d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0388.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::16) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|SJ0PR10MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: dc1e603f-8b8b-4410-6e75-08db4a72e38f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eAe+avZXwRM81cHd1uoYsypIvXTahFC/GBkqxlPi+z/A29Q+D99Wt6gGefkH7gcYeVtYSkNZmk+NMgjxgixTw9RDX7IJCQns4qEmZlj7CoRpYDruXoD6JDqc+yGQCRhJEjsQggXHW89MCQO4WEAosOCRojvOY/yMlTXq2wYKnRo5UVq2w5JNHfAlv4omFOChOLLzGjapE+o01UOA+uWsj21wW2GHvi50s1vGI2I4Mu0EdtBFiyTgH2SuPV0LjbGXsomPiZpk1luiREf6aKwx2HC0lwmHpz+/gJkhcKmb4eR9gIn2gcpBoOC4xB6LTCBkEHrEbLfmt9Nn4h/HNQ6sV+i8/d6MJ5e2sOOceTSZ+40H2WCSdcs1R7R3rueWU5ImMgDmX0u/ce3jfyaGYFZIuP5UYQNqU/RVPZWvonWnK3lC02Ba59yOs0pmO5vbbGN0OLC/T51Ap+tRRnHUaT3pzcEY6tQIfr6ycfLsl/x/kJRpV/fCMj8LUlT1r5dLn9pPyv9BILNVhU15oTpORRgOtJ6AQs6dkNginA8fOmmUr7V0Z4SkTBIzmzEecofCZm972HkTW1PBH/YvetzNzJMFulo1bVqgFVM9j5OsK0k7D9yL4DIdz/QM/+1yASHThnQX/prAvDmzQ7zCt0Kz0oWxqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(39860400002)(366004)(376002)(451199021)(2616005)(478600001)(107886003)(83380400001)(31686004)(186003)(4326008)(66556008)(66476007)(53546011)(6666004)(6486002)(966005)(26005)(6506007)(6512007)(316002)(8676002)(8936002)(5660300002)(66946007)(41300700001)(7416002)(2906002)(38100700002)(86362001)(31696002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dzFkRkFXVkJDak0zN2xCVG5CdTBUVFp6WTBhUy81b0NibU9FbUtyRUU5WjBH?=
 =?utf-8?B?MGgxTHVCcGxGZk5HTGJMakVORE0ydnc2ZHFzUkRDOUZyWFY3alNaUjBSelVZ?=
 =?utf-8?B?T21Kb2Y1ZTgzeEJUQit2QkN4MVF0Ly9lZHJqMHRvcEhZZkw0SEtFRko5dlVH?=
 =?utf-8?B?bDZ1L3VGYmducGFDZXRVd0pWSi9EVGdySlBwcmR4MXhZT2FKNmQrd05Bd3FG?=
 =?utf-8?B?RmxwNzJWaXViRmZZUFplTVBkQjBBbWRLKzJEQTluU3VTNzlscXdWeC9hL1RS?=
 =?utf-8?B?WUpHbEI0bFBkZ2FnVGpMU1htWjBWSHJjODQyeEJOM2hCQ1c3TDg5R09WWXpi?=
 =?utf-8?B?RmxGL0hkaDVXR1RGKzdnUE9VcXk3VjRVWjYySXk3TWp1RnQ2bklZd1BjQlRI?=
 =?utf-8?B?UWJDUThOZnFwMCtQT05TNnpUck9yWi9kaXUxbUJtYm1QcHdXcStoVjZIcjll?=
 =?utf-8?B?Q1NnN3VpVjJOcG41OG45bVQ2TjBUbStCZHREbEN4VVRjNnJCVTR1NmRHQXFM?=
 =?utf-8?B?NnN5Nm82S2NQQ1J4b3ZiTHRBdDc2V1BucnZtVDlVbnJDQTN4anlSeFBxZEtR?=
 =?utf-8?B?dG5RZzJPQktxMmpQeVYwbWR0Y0tuRUt5TmxEaXZ1YmhKTWpORmlCQjI5Vm1p?=
 =?utf-8?B?NWNISWpwYXpac08xZ2ZlVUtHd0hYWUdiUlNZSndUSzBuSkM1YWxzVVZESnFr?=
 =?utf-8?B?YmtOQk1Qa1hOUTkwYWxKamo5RUQ3dmlDaWwrTFN0VytmUkROaHBkaVlUcmZv?=
 =?utf-8?B?RFN5SHo1d3FxRGY1YlVVbWg4ZTBCdVhUMXhxclJiSUY5QW5KMExPaHlMdkth?=
 =?utf-8?B?cjMyalc0MG92dVFMbkZzcE9tNk5xenNtc25sZzZjKzI4eWRocGRLUjFjK21G?=
 =?utf-8?B?TzAxM3BwQkFDanRLcTgrQTBDdjNrV1cxMnBCSjFvWkRmeGpHdGFOdzBQSkIx?=
 =?utf-8?B?Q0xad0VvNXJ0R1k4NlpnRFV6RWhmV2FRYmRqTWVEVDNKbG1kRzdjcys2TDNn?=
 =?utf-8?B?Uk4yRTJ3T1U3Q1JvQkF3N1ZTVU1Na3dic3UrVlh5QXFwSGlwSGV3bWtYQ0U3?=
 =?utf-8?B?SlRZVzJyMkVZMUNneDI5QUhtRVRhbC9uWG1ldDF2SnV4NkhzNmJsMjRYWVA5?=
 =?utf-8?B?ejVYRURhaHdDSHNVeDdIeTh6eXIyNGpSazUrazhGV1ZjbXFOR2VpSkZCLzEw?=
 =?utf-8?B?RVFveUowdHNuRDRHVVdwQTAybVJtNGVqQVNybGIzL0Q0Q04xME9pZXZIc3Av?=
 =?utf-8?B?SXRLNDJ1UjZ1aFo5TUtQcnNuVzE5czl2MGlNd2tMc2xKL00xMm1NWFNjVjF4?=
 =?utf-8?B?NTNOVmhvUVFHbG9rNlgwSHJtdmdtd2I1UHNvbnJzRnAvRXNXZVRnK0FRN2dj?=
 =?utf-8?B?RnFsNGlJQXRYWmVvbXBMRWpkSkVNc3dwMkhvSFhDbGtvRVRBZTBORndDUS9h?=
 =?utf-8?B?YXFzV3pPd2lvQVdNZWJZMXZPb3NNQVU3VDdBWEVHUjJMcXlIcTcrWHBpSVdn?=
 =?utf-8?B?ejNmNnVsOTJkdjU1Z1huTVkvK0F4R3dqdWlQemFXUUFJWjVxL25sbjNsdFE3?=
 =?utf-8?B?d25YMHI1QnhyNWwrWERKeGl6d2szY1NXaVJWWHhNN2gwb1FiNGdQZ2R3N205?=
 =?utf-8?B?ZXoxNnRNdFgraDFoRzlIWkhzd0hUYXR4clhHTU9JVklxamtSUWc4SlBXaGpk?=
 =?utf-8?B?RWRKZzdmNVlDNW9xYzBjZC9xdlgxeVlTK2p2cHJZY1ViL0hheGh4L2doTnpI?=
 =?utf-8?B?allOYXNtRmpGL2RpWklyOTZiVTdjTVdlU3B6WGZWaWpWdVpBa3lMTmp0U1h5?=
 =?utf-8?B?K0thNENwRFRTbFN1bTVkdlNvMUgvOTltVUxTUWNaV1RrZGZha21naHRqSHlr?=
 =?utf-8?B?Y2V5ZDhCMEFVVzhjWStnVmt6SlkvQUxPVnNnUmFkdTRtVmtWS3NtOER3UXZi?=
 =?utf-8?B?WFlNTjgycmQ1VGdSazR1UG5NQ2h6aHlLRjJFMzZueGR5MjdFMmJRc3FZZlBQ?=
 =?utf-8?B?ZTZHNVIrUjZMODZLY2hrRjlKOVpiVG5KNVdFTldIbjJ6Y1lTLzJiVzhQbzR5?=
 =?utf-8?B?bmE2SVVVTWQvZUZibUtVT3RHMnE4VDFKMU91Z3l1R0N0eVozYXhueXJZeHdU?=
 =?utf-8?B?RkpUb0ZYS3VneUxYWEc1TCt1MmNwZXN1aEVpRmpyVzZmYWh2NFA0L3hKZllD?=
 =?utf-8?B?d3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dDdGN2hWUkdtbnBUOHF5QXZ5WFVPd0FoNUJBRVpxa3JUUnZiQ0FqMnRKcDdo?=
 =?utf-8?B?MUVrWVZsUTc5OGszZ1VwZURQN044OXFNTWtQZW5CN01LV0JLRFVUZlc5dmo3?=
 =?utf-8?B?ZXRHMGY1L0N3MldzZitwZloxTmpUeXRzZG56MnErTG42dkZSZ1RncTJ6TEVI?=
 =?utf-8?B?VmtHT0hDcDEyYmsrdWc4eUhhVlA0dkxzOUNEWDVEWGNxTWRsQ2NGdEZMamVl?=
 =?utf-8?B?NXhHNm9nY3lLbVlNU0Z0QSt0NEh1c2NNV2ovMGVuMTRWZVBxQkVBNldwUmNS?=
 =?utf-8?B?YUhTTnZYL3RORkZFbzBIZFZnUHBhNXF3cFZSOGEyZnZVWUVQOXZEN2dtelM3?=
 =?utf-8?B?aU5haDlubUxVUjMzQVlKck1rR3JTWnFUM2liRGZBSzVtOXRFTzkxRis5eTY3?=
 =?utf-8?B?TjZJeDdFUGJVQjNHUUJiOFdtVzdOMEdiWmpuL1JoQTlCQVR1VGgvVnh1dGpW?=
 =?utf-8?B?eHlZc1lnSWRnL3NTazhFQmN4OG1PUDBUblBKUWt5Qis2Y1NsK2ZDdlBidjhE?=
 =?utf-8?B?djhTQWtYM0tkc2xOVE9rNHNQcjh1MXlaQXBYZE02blVBMEhyVThmczVQbEpO?=
 =?utf-8?B?T0xIM292ekh1NmVzR2pGbGhtU0VUYlZ3N05iNTBwNjE2TGZJclB4S3FKcmN1?=
 =?utf-8?B?VTBmYjczb1NIbm12Tm1Mem85RGdBQkFtOG8vNDhDY1R3aEJQQTdvNUhjcXdk?=
 =?utf-8?B?K1BRQVh1b3dYSWxpNlhWYzhSR1E5LzFhZzdGb1h2OW5VM1dVMHZWajQ1dFZI?=
 =?utf-8?B?Wk4xSzMycVBmNXNrU0lFR3pqVGw0NUkzRHdRM2RzYWx1ak5tbnU2R0F4Rklt?=
 =?utf-8?B?emxqS3JIN3lvNTQxckttdUJ3TmtjZWtrYUc2aDA4Mi85cWU5N1NMQlVnM1BS?=
 =?utf-8?B?Vndtc2g4cDg3cENnckNoRkpHU29aZjAwWjNrcHNPUmRpSEFwUVFobXd5YzRq?=
 =?utf-8?B?OUcvcmtaSE84N3Ficy9YVWw5Q05qaWpwKzNMSE9CYnNuWXBtSklwZzBVZXB4?=
 =?utf-8?B?a2FWcEtJRDhRY1c4a0FDalcwcUtQbWZyYklHTjNuQWhFVm9GZVd5UzJsUTk0?=
 =?utf-8?B?MHV1V3lQUkZYcDhzcWNhQWpUSXhwcUdDTXFxZjZoTGhJQ0tLNU9EOTIvZVlB?=
 =?utf-8?B?QzJ5QmlyM0x6WEdGMnhTNjRPMTRZbWxac2hxVEZQdERDdlA4bEpCUXp0MGht?=
 =?utf-8?B?QjZ4SFg5a3RIWGtpVWRadUtMcndmbjBRU0NubVh6WUVMM0Z3eCtWd0RwU0gw?=
 =?utf-8?B?Q3p4cTJHR3BwOTN3alZFWVhQZ3NUa2d4MVNzeDlZa2wxa0FXbWtUbkdReDk2?=
 =?utf-8?B?b2FLSFBTYjVpOXllNkpmc09XY0pya0YyU3Z3QUc3NWJ0dGxCOXlNK1FDNWZI?=
 =?utf-8?B?WnVWYmZVd0lSU3JsZnFjb2NsemsxTVpCNXpWOXhtalptZlBpNGgvM2JHajJG?=
 =?utf-8?B?TkEra3JEUDBtdTNVVC9iOVRKYmo1MWJsKzFtRDZUcDVab21iUzdTVlZMLzlt?=
 =?utf-8?B?K2pjeDlBRklWRnAyQzJJZVhwTERUY3J1dVRQZHhDOVZ3ckV4K2tpL0M5VUta?=
 =?utf-8?Q?P+4Qcq0Uj2bsYuvP8pzExwy5o=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc1e603f-8b8b-4410-6e75-08db4a72e38f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2023 18:35:51.1488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yCpuN2vkKQVPTScfSwnb1GidchO0JN4jGQl11qKAHv7hc+rxEcxmhEBKCuasdG5rsISFVNiU4zlAOaIuBSeZ43pnq81bkDcKnydqO8Hm8zk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5804
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-01_11,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305010152
X-Proofpoint-GUID: xrNP2ss1v8sRBrPtuH1EdtJUTTzEbsFQ
X-Proofpoint-ORIG-GUID: xrNP2ss1v8sRBrPtuH1EdtJUTTzEbsFQ
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/27/23 02:08, Hari Bathini wrote:
> Hi Eric,
> 
> On 04/04/23 11:33 pm, Eric DeVolder wrote:
>> Once the kdump service is loaded, if changes to CPUs or memory occur,
>> either by hot un/plug or off/onlining, the crash elfcorehdr must also
>> be updated.
>>
>> The elfcorehdr describes to kdump the CPUs and memory in the system,
>> and any inaccuracies can result in a vmcore with missing CPU context
>> or memory regions.
>>
>> The current solution utilizes udev to initiate an unload-then-reload
>> of the kdump image (eg. kernel, initrd, boot_params, purgatory and
>> elfcorehdr) by the userspace kexec utility. In the original post I
>> outlined the significant performance problems related to offloading
>> this activity to userspace.
>>
>> This patchset introduces a generic crash handler that registers with
>> the CPU and memory notifiers. Upon CPU or memory changes, from either
>> hot un/plug or off/onlining, this generic handler is invoked and
>> performs important housekeeping, for example obtaining the appropriate
>> lock, and then invokes an architecture specific handler to do the
>> appropriate elfcorehdr update.
>>
>> Note the description in patch 'crash: change crash_prepare_elf64_headers()
>> to for_each_possible_cpu()' and 'x86/crash: optimize CPU changes' that
>> enables further optimizations related to CPU plug/unplug/online/offline
>> performance of elfcorehdr updates.
>>
>> In the case of x86_64, the arch specific handler generates a new
>> elfcorehdr, and overwrites the old one in memory; thus no involvement
>> with userspace needed.
>>
>> To realize the benefits/test this patchset, one must make a couple
>> of minor changes to userspace:
>>
>>   - Prevent udev from updating kdump crash kernel on hot un/plug changes.
>>     Add the following as the first lines to the RHEL udev rule file
>>     /usr/lib/udev/rules.d/98-kexec.rules:
>>
>>     # The kernel updates the crash elfcorehdr for CPU and memory changes
>>     SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
>>     SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
>>
>>     With this changeset applied, the two rules evaluate to false for
>>     CPU and memory change events and thus skip the userspace
>>     unload-then-reload of kdump.
>>
>>   - Change to the kexec_file_load for loading the kdump kernel:
>>     Eg. on RHEL: in /usr/bin/kdumpctl, change to:
>>      standard_kexec_args="-p -d -s"
>>     which adds the -s to select kexec_file_load() syscall.
>>
>> This kernel patchset also supports kexec_load() with a modified kexec
>> userspace utility. A working changeset to the kexec userspace utility
>> is posted to the kexec-tools mailing list here:
>>
>>   http://lists.infradead.org/pipermail/kexec/2022-October/026032.html
> 
> With the in-kernel update, the size is anyway getting calculated in
> kernel for kexec_file_load case, how about passing the recommended size
> for elfcorehdr segment and any other segment that needs an in-kernel update as a sysfs attribute 
> instead of kexec-tools having to do the
> calculation again in the userspace  (get_elfcorehdrsz()) for kexec_load
> case. That makes segment size calculation less error prone.
> 
> Thanks
> Hari
Makes sense, I'll add that to v22.
Thanks!
eric
