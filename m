Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428F572066D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 17:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbjFBPlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 11:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbjFBPlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 11:41:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C010818C;
        Fri,  2 Jun 2023 08:41:49 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 352D6NWf003354;
        Fri, 2 Jun 2023 15:41:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=9X4ikfDZIQjHwie2GHo26VyhgwhIgeTgCMZTABNVNgQ=;
 b=BBN59XB7sU2xhsEyHV3ra2t/9yxRurwKUMkWzyjqcZkm64p3NiDqVnY46KG7gXzPGjNI
 Yd6q099SDO96FP0mTA1DTS3Q+3gLuj6xu4VfMUIqUZobCopfFJPPf/RKUjE5qAU4hKvt
 DR4u+ddL10sF0xfoh6bbOSj+PXFUlX39j+E0mOrOZbGT3Y1zutzYkNfE87bawAeLf+MZ
 CxF8d3R0MelcCWiha17b81vO3OoNNlYNsN8vPO693yDe0eq+eli0YoiO4mikHCpvxmOm
 Z1N3RFMBpmScAXIof9ZF2V8xcHsCKeTeKGK5hoKMXp5gqNiHHjFNyh47XJUvm7pzBlkA ww== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhmju9my-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jun 2023 15:41:11 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 352EA2KM017343;
        Fri, 2 Jun 2023 15:41:10 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qv4ygcrp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jun 2023 15:41:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dXTfoCuMXoeMbYLtD/Dtjqqj+sVGtdFfmI1rPTM1FuzEj6gR2mG491nTrh1updioa1QkX49GnKsjN8xOXBZaHkQpWNvaIeJnaXL2m1I3TBkm0eawkV2NS9MtS+xd51F97F8x+ByYI1oEwcQ7HMtyGs+YeaIPD7x4Ejm33fyHj4P2ti7boNPqqHe0bnsxt3Y9EuH1a6MLX2YGUgvY0KzvsvzlevOginDD8XeBsUgxB5LSx+gvyx8iXxfsKlPoxb2/r9DE+3mUOgBKdDjBq63Wme7mKCT1nlrIbkf4JkNS9MQXEjmaKQEOudDhrF06eoW7uYVgBRqiDtTf6u6bROWtAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9X4ikfDZIQjHwie2GHo26VyhgwhIgeTgCMZTABNVNgQ=;
 b=KNweOe9ok+Y1TS85kD3NNGxn1DcyG1csm7QMFoBjfj1RIlWXcViETpEtJ/W/3gnZhHUTnQDgxrINtq9UowxycIcsYgVpULOczgMs1KBwykKj7hpwnjn9wRVqvanJvRBpEhWqPTPMhIq9wwB4nDX/S5cmC4U1Gu5R3yM3V4pvaSOC1yaiJIJ5T3eTYPR2QFPkCKpsw+rMqAqr81gre+sJHicyxVEhVuzsI0nGFDx3LrAIzqdkmSB0JvoJFZHg6AaLRiSP6wYLuLcGIIxD10neZif5Vu1HQUiuIGcfUBETwnVgR2jS/WW86BO+WDZ8g4AimMoXNyYuQ4XSsILJouJ12Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9X4ikfDZIQjHwie2GHo26VyhgwhIgeTgCMZTABNVNgQ=;
 b=atMyJibhkV3+r/JA/6U+Uhgk6RyZdiNN7GgeipW98O1euLx61npZw1vmWeM9ieBNw/oBN9wFsd7fRH5jebXR6Qs4MuKLEYNJvgROfpXJdi23fusNhfisPZgJNoCAf5QhywL7CLmPV1iICdH1epk0S9ie+6FBZVTWOjfX7blwPic=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by BY5PR10MB4370.namprd10.prod.outlook.com (2603:10b6:a03:20b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Fri, 2 Jun
 2023 15:41:07 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::68c5:330c:d234:3834]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::68c5:330c:d234:3834%7]) with mapi id 15.20.6433.024; Fri, 2 Jun 2023
 15:41:07 +0000
Message-ID: <8baefac2-476d-0ea0-91f3-c960303378a0@oracle.com>
Date:   Fri, 2 Jun 2023 21:10:51 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH 5.15 00/37] 5.15.115-rc2 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de,
        Vegard Nossum <vegard.nossum@oracle.com>
References: <20230601143331.405588582@linuxfoundation.org>
From:   Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20230601143331.405588582@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0195.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::17) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|BY5PR10MB4370:EE_
X-MS-Office365-Filtering-Correlation-Id: 04dd8695-94c2-4707-6b93-08db637fc82b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N8Qs1yHYXDlQdVBTQCQeDM261ZBGOUecR7Jot4NCAW6ACX8Dx1ens/dMUKSMZZxcuAMu+3EWXfE8xRDaPaYiQL9e3vZCfKqP7JOBq9evpW9bZTaFFnB3BZCXR6ykOtUyMp1JKVNocaB3z9ufdXNw7yxHWlZ+fe2TFoCRKYvLDnlMtW97OOpj0BghlMXebfyOTefD2wqcwbryX6HcLv65YzgJBnWcgAGUvm/iaGy4ve6+ehrHQNew2QcSPpiZjp0l08i+D4WiqVY/UO3F8MZ23/cyAZFXiBvc1LkuHbzwvPABD0WWu7XQmPpeul81DzZVgqYKRvs/lVecOs6QXlZ3rFI2GqYuwCof/QFKUi7zz53cYyReia1dqvyXy88Mnrjr0YoFufq/43Npz4a+IKVqlZdOpP7dVWjhMw0Yv1u9adt23tFSJpPjwpIqY8PvUAgxbSZuYPtPRNOFygRLkDVjU6bNd+bHJKnaectg8JfT+Wpow3nLUcXUHRqVoZZmbWu2RHKITDae1iHYMWUSZmt+UsO1NtdCmGxrOGQG8X2L9irc0gZLkhtIHhjggL6XFjQtTurYFY2Wdo6gRShaTvyVWOSm55BO62c9e2n8IeVsjQZLLSFQNuMyd7PLn862kJ4sHAT5b1dKq1EkOFfQI1NhwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(136003)(396003)(39860400002)(451199021)(966005)(186003)(107886003)(41300700001)(38100700002)(2616005)(31686004)(6666004)(6506007)(6512007)(26005)(53546011)(6486002)(478600001)(86362001)(66946007)(66556008)(4326008)(316002)(66476007)(7416002)(5660300002)(8676002)(8936002)(4744005)(31696002)(2906002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TU9ROVYvWVBoLzZnWXc0Ny9xSGxqYXNTdGhLRTVtRDRIZUxTcmx4SE40QjRp?=
 =?utf-8?B?ZDBRMVZIWFZqWmJZbmRvdll4ZVBCK1lvYVhPQlFLM0NJYTZzL3lubkhFS2tD?=
 =?utf-8?B?VExqcU8ybmJCSHhRK1ZiZ2tDaGdFSUFGS01nVkFhVmIwbEJnL1BiUXl0enFp?=
 =?utf-8?B?aWVKM1k0SUdNYUdmaCsvUkFVRndHaXVYdzlaTXp5bmFlRUhzcWZFTWpGNExv?=
 =?utf-8?B?ckRqeVRGQmdUSDQxa3R3NGZxRTVuQmVrNmJ2ajkvNVc4Z0tybzdjbUFvZ3g3?=
 =?utf-8?B?THdBMUNEK09MNWY2QWNCTWZGeGlQMTdKbEU1Vlc5d3AxM1pJQlRQaDZUVXN3?=
 =?utf-8?B?dFJHR3grNGRvb0I0TklSaGQ2ZUxFazBPVDJDVHU5bUhHdzBVZGFjbllDbE9y?=
 =?utf-8?B?a1RzcnovaUZmT2s2NklkM1RsWDd2Z2xKemtXd0N3Y0xBYldrRDIxcU1nUEFR?=
 =?utf-8?B?VGszOGJuYURYU3VtbmRVSVI0dHlPc1BoT3RYTlpLYk82ZElYVWhxbXRyZVNB?=
 =?utf-8?B?YWYzUWRTT3B0TjBWSFR3TjRBdDJ0MVZjK3ovd3QwYi9jTEVYV0VMczVGcC94?=
 =?utf-8?B?cHpGcnJmVW8wN1Ura0tHUEcrWmtScDFjbTJyYVN0eTdkZWhSTjhZcHlCZEVl?=
 =?utf-8?B?VmxYR01GRzZ2SHh0VFY4WEEvMk1BeURrVDJWSnFuemFmZ3FVWUtVR0hBYmNK?=
 =?utf-8?B?aW1qVG1wbmpqY0s3Z3lGckJpbmJFQ0xsS1F6Ui9XWmZ3Nmh1TUs2U0ViZzR5?=
 =?utf-8?B?SzBRdVNxOG9HQkxZUFhEQnJKdnQ5QlRBUzdTdDMwNUNIRTFIK2FGWUJid3ln?=
 =?utf-8?B?djFoTUhTV2V4L1VsS2xPZjREODE2UFR4U01XbGY5SnE3WGNuQnMvS3h4NEZZ?=
 =?utf-8?B?dVlUNEJaam1haDBwdkR2RlpwZzVweG1ZZTVXQitnaFhIZm9GSVgycldHWFpT?=
 =?utf-8?B?U0dpcCs1LzR3TnhFWEdSWmRqT29jR3I2OFFaL3ZHTDBueFFxclZCNmZDWmtO?=
 =?utf-8?B?bUNTUlNrdnM5MjhKSDE4VzdBZWhUZ2FPaEVWdGp1c1lueDl2dEhBN1FocDN6?=
 =?utf-8?B?alBZVHlqRER6V1l4RHE0R2R4L3J6QXcyOXQ3Ni9ZK1pXNkZlaGRKOFJhZXh5?=
 =?utf-8?B?RHdNdXNDQmVkUEQ4T3A4YXZhaklZc1Yxbnd2TE1QUDYreHZXVkdSWnFtcWdP?=
 =?utf-8?B?WlhmNmNoeXpKV1Rxanc5ditIbWR4RkxDbHdPOTFJOHJHUXF3TDdYZmJqemxU?=
 =?utf-8?B?dVM0NlNNKzNWek9OMU0vdEJ3eGowNSs5aEtRbldmN2FncnhsaFp0WmYyYjNE?=
 =?utf-8?B?M2pod0tZcW9yVGZvLzdEVm5HSFBhZklpWDVGaUpjWWpWeHY5WDZwYW9tS21B?=
 =?utf-8?B?MkMyRFkrZzAyekpRdU4zVGNUalVqdW5VT2d1YkJQUkFTRXJmUUtZRUFHYTlK?=
 =?utf-8?B?a3NvODFaQlhoQUIvNC9veTVvenBkUmg2bzRFY1ZGanR1eWlSa3lMcUtvRjJt?=
 =?utf-8?B?T2UwcWtOdW1tYkFJT0g0T083c1oxSkVuaVZSVjczazhGT0lGaGVuT2s0VGlj?=
 =?utf-8?B?VVNiUlJYZjdTRG01NzZDZm5BbG13M1E4T3k2SWtCY0FPODBzV0xKNVpGU2xQ?=
 =?utf-8?B?SjgrVU9TSTJHVEk2MEF6djMxZUU2VU50U3pwSWF6dnpjMUhKMElyTEM3WEVo?=
 =?utf-8?B?K09EWDVwQkRzYUlRRlFFeVdzTWFQMnRuVFhicWw1RjQ2Yi9wQ1R4OTQvenQz?=
 =?utf-8?B?RUY1bnZEMjhyOVF2T3I3dFl2YWZMVVFhTGk3a05FeFJLRDNBRFNWeUQ1RVVJ?=
 =?utf-8?B?YWMydGM1TFpxVitpMElDUHNkZDRrbHBZZWY5eXF5dEg4eTUzdlFSNGZqcFVX?=
 =?utf-8?B?aS9XUnIyc1lSWktiTHZPRHFXT2t4cmU2YTlEdHZ3aCtvS0F6eGxNQW9XNUlZ?=
 =?utf-8?B?blZwN2RibCtIOEpMUCtsZmhTelF5b2RCVHJQMld4YlB3SXNJVG1ZMVhyenRH?=
 =?utf-8?B?UmR1RFBHbGcvRTBQc1JWOExxemdsZWFJbjFncjl3QnNDMGZlQmFpL2N4NjZy?=
 =?utf-8?B?UVc4Z0tFVjRmQlcxY3RxWEtJcTIvdXhITW1qVTgwU2FsazBMTmZkZkJTcWVk?=
 =?utf-8?B?UFd3RGVid0ljZ1ZHZWFwUy9pdTJxUU9iQ0RQaXhOR3YxUy92eTNkRzVoTFNL?=
 =?utf-8?Q?DC8Fe0gehPaBqhAohyMZjJ0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VlhhYUIySERuZUl4dE5LNlZiRGZVNVFiZXZNRUNNOGlhT2lGNHJsN0ZvUGF0?=
 =?utf-8?B?QUxvcjFCMjJrdzB4c3U5S2JWYVYvZzJEY1pLMjMxckh3U2ZERThNRCtJek9u?=
 =?utf-8?B?N2V3UXJINDdjRlpxWDR4ZFRXQjJ6NDJsSjdVdDZLdlE0S1Q2NThXMUlMd2sr?=
 =?utf-8?B?bmdDaWRvdVlzc0NBT3FuS0x4VlRaRDhLWGFjT0x6WGJEWDM0bWRDSnloOEdh?=
 =?utf-8?B?TEpqNS9ialVqeFlhZnhUSUJFeXc5YmttMlhJbFNwMGNqNW9BNmJiRFJ3OHBK?=
 =?utf-8?B?RjlMTzlnK1kycmVMN1VDbGl2SUxFTno1NWhjcHo5ZXEwNTdnTWFnSE03b0d2?=
 =?utf-8?B?clJFMnRZREZLK2JycVEraW9sVWRSTXltNXNFNjBFMXNoMHlTYlNBb1lWeHVJ?=
 =?utf-8?B?TFVYUDM0YndjNHV4Y2F0T09KcDZyb2FFRjJLU0lEQi84OVVGZEpGMnE1OTd1?=
 =?utf-8?B?YVd0cm9sRkMrV1Q5RFArOVg1L3lmVVZZa2lrT0xVSDJMR2taTUVWNDczMUJx?=
 =?utf-8?B?ZUJiUFBPZy9hY2tIWGRLeVhPTnptUHI5bmZIOU5zaVlUM1RtVTNrRm5Fb2tm?=
 =?utf-8?B?RVVtdkdYU2xPSHkySjVFMVhxLzR4U29TR3dZN1R5NTJXTlcyTTc0NjVBOEx4?=
 =?utf-8?B?bEpGWTE0VExyOHpNZ1prSCtZRnp3eFdoZGVqd2dFWFdMQ0JIMDVBMitUcHZ3?=
 =?utf-8?B?WERQKzVTSlVkTUk5RFRHOEE3Tjh2OGt4QlhmY3pmUEhYQjd3Q2N2Nm9odUd2?=
 =?utf-8?B?MjAxcUFOa1FRWDBtRDFXb0xOSlF3UmZMRVY5UlRITjN4WFB0cnBXeTlHcUJP?=
 =?utf-8?B?ZE9wWE5tOURjVCtqVjJBbkxaMW5mRWJRK2E1bWRRSnhHZ0FVNlM2NXVxUUdz?=
 =?utf-8?B?NUFOK2wzQWxZRlRXSW1UU1YwRWg3aHNKVFE5ZVlkTHNGRkVWTmpFNTV2bnd2?=
 =?utf-8?B?cks4ODFVRDZibE9Ic01KQVJPRERyWGVZU1htZXU1eTg3WmxSSDBvckFGenhq?=
 =?utf-8?B?L05yaUYzOER3MExsenVEWjZVNHhhQWF5dzZsVG9mVDhIWVpDVjNPVGJyVDdI?=
 =?utf-8?B?NDFjTHJhL2pxZFZnOW5RKzAwaWt6aXBOcTFvVkNJN1YxaWIxUGhrQzlwU0Fr?=
 =?utf-8?B?dE1zRm0rNThHdGd1WlhtUFJlSmxYallpZWxWN01IdGlYUXEwa0pBWlNnZTVn?=
 =?utf-8?B?dEg5VHhVWGNXd3M2THRCaGVCNEQxVC9ZN2hRU3VQSWRBUGNGM2R1dXBHdksv?=
 =?utf-8?B?TlJhVGREcy84emNLMC83dFdTOFZEc0pSVDZSVnpiQXorTkhEL1JHNVJXOTU5?=
 =?utf-8?B?NWNiNW13YkgvYjZQZExKSkNwanFiTWtSd25tSGhiVUdheUk5a291a0p6TUtH?=
 =?utf-8?B?YVZ3Szc5ckU4Rk1wMTJ0TlFWTWlIQVRCVnFoVXI4ak90OUg5M21PeU02Rlor?=
 =?utf-8?B?akc2MmhCWHhRVUNISUU2aUVtMW5qSE1pOWJjcm55N0lkSVZaRFM2WStmUU12?=
 =?utf-8?B?ZFpuNlpaemkweFhuMWlrVDZyd1lUZFNrOHJnQUNyY0dGaUhZdTdYSXRYaTJ3?=
 =?utf-8?Q?eUi6YoVJ46WdRWri4kfFloSZuxK7IRDRdyHWH3/DG7eily?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04dd8695-94c2-4707-6b93-08db637fc82b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2023 15:41:07.5875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PjJNIePJUrUZsKRLN6jdgzu9BD6rdDqwvL9X8EQDJhiJkh8VxuVAaJ317r53l0tGgd0RRnAQph0mE1BsAcQ6Usf2R0LFKRUDesN+IeNlz0D50T39tDXtyHnrehoM5nNz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4370
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_12,2023-06-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306020119
X-Proofpoint-ORIG-GUID: 6zLh83goHgNH_apDdTKLbdHbmZ_reg6I
X-Proofpoint-GUID: 6zLh83goHgNH_apDdTKLbdHbmZ_reg6I
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 01/06/23 8:06 pm, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.115 release.
> There are 37 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 03 Jun 2023 14:33:22 +0000.
> Anything received after that time might be too late.
> 

No problems seen on x86_64 and aarch64.

Tested-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Thanks,
Harshit

> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.115-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
