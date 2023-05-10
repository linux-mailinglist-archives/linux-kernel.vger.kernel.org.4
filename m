Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8C36FE781
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 00:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjEJWuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 18:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235456AbjEJWuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 18:50:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 737B835A0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 15:49:58 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34AL4Q5a009384;
        Wed, 10 May 2023 22:49:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=dKmb9DNjJsfD+cZTLVVlGuoJrA0ORGSXX2KwHnTxsaU=;
 b=hdXspAm1P3HfvwEFVMGczTXsDydag6T3tQgHdVduWXMXE7HFUhAomKW5vDB3m1sqC98o
 Xn5E7Ws3WOm3fiRAKXw2PdGdp4tKp4VzuMaIZZehqZt5naMSD2mm6TzZ8HzWtY+I74dM
 Nslod/J1hb35b8mIfeZIobmfVjaQDSye/DVhRR1mS3KMrn3cDhIAx7e49cwMEg/wBsnu
 uYWuQZOuRwUtjSU6VNEX+H0X1R3hXglUrGPY7P3dnle9GmObNG1NtCoEtbK28Q5d+Kax
 s9nqD/b3wBaWIAmUNljZdrfXXNeE2nttpCGZZIQbpGsbPYQbfUoROgDtuhBddIg82uIR og== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf7755sq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 May 2023 22:49:20 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34AKZs8o030528;
        Wed, 10 May 2023 22:49:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf81gcvxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 May 2023 22:49:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FnQH/5OfCpThOmrX9kYRIVvkRnnGxa4hMCDbxS+NGoApxxOUYenqEoSUQ78s0Qn9lRspEdaKt/07eEoKNaPPpj2IEFXyu9BtzLuOF19eveVpMgB+dE2maiuvSqNtPFLf/35c172TDSXcE3NUUUp0Pf/s8FrNz33Cf2P/MBmiG66fbVgP7agNEdkvOPNeR5dfwq4NL6Gcx80rD4f1SacliqDvqgVcgeT+yJ3nwJVGiSb/oqJdotSDjGLuOItjMXCh4fRd2kkKyPVPstYnAza4qOLWANVrerXDoQSlwLzzEdQ1ekWOKy8XDAkdezMUIfBzM9qZprC7kqvsQvJpFGvsfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKmb9DNjJsfD+cZTLVVlGuoJrA0ORGSXX2KwHnTxsaU=;
 b=CnURsukhHgm9hslRki4zG/GPIds6s13g0nLRIZvVIwepYb0gGK7iNq9HsJgIf1pOcNv93Qkn5s+Us7GCHoQd4T1wDh8bTcS87iTdnIJRTe8SIFv93y6xb1KS9jt6GdpbGWB1R6RElCxrStuDVTXzzzYQqoqGVVugVNHzXj9xe/YKBTbEbB5VAwMFo4p/jYa3NdywdyWORB6cMhpNwoFU23zx+s9zDnhJJ0rAu+nLTZTpdbi+2+I0E7S6XcvS0kfCO9pgndmjPuxeHDv1RL8LC76YTrgcDnbZLfMooW5o6OG7wmr/m0tOrUsGjwvudG+j1cqlxljZ99/nvZ9SRd+OvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKmb9DNjJsfD+cZTLVVlGuoJrA0ORGSXX2KwHnTxsaU=;
 b=qPpI3qkx1p8oowBk06RvaV+Fo8HQCtx0mg45h47lUrCdg7K6hnlnZg82pX/hLBDuBJ8NtJfCJG1jmvgutxq+D65nEWLSLAXL5M0z9Au/fHqb1csG6CvJBArBBVdlVr7B0an0l1O8/PoJKHwQcDCQ3/S7mn4stnFODrhNZGAKMuM=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CH3PR10MB7284.namprd10.prod.outlook.com (2603:10b6:610:131::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.19; Wed, 10 May
 2023 22:49:16 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::ac1a:bf88:bdbf:2573%5]) with mapi id 15.20.6387.020; Wed, 10 May 2023
 22:49:16 +0000
Message-ID: <27c3815a-cd3b-5a7f-debc-b379ccc0195c@oracle.com>
Date:   Wed, 10 May 2023 17:49:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v22 8/8] x86/crash: optimize CPU changes
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20230503224145.7405-1-eric.devolder@oracle.com>
 <20230503224145.7405-9-eric.devolder@oracle.com> <878rdxyvs7.ffs@tglx>
From:   Eric DeVolder <eric.devolder@oracle.com>
In-Reply-To: <878rdxyvs7.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0263.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::28) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|CH3PR10MB7284:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cf15a93-73f5-4a81-9ab4-08db51a8c842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TrpxuCvojRW8IL5oYvuJxUsEZI9AU/EOwgjl9n2v2U16Ns5zPN8fNSBqIgEilAVb3Zb9Yu+qBOBa6kEKTJTZAPQOmcAO4lZTU6GgIHRm62Kvl1RSTWoDeecKvJTYXQezjADzdi2j20Aa8bTSGsc/ua2FIQDnVor0fMlPO0IukfDIzVhsJ2q2t4VN/K6He5m9Kb2zkUn59Y+PeEO6CZNk4djHZ5QowbMpmFOqV3jOIldgho3/UhWSzJnNM5WPLpFnKJd1tH27qKf08QW+7f36Izj/VBk9b0Cf5XXcska3azwwvvhJqW5DiJTkuGub66hFH3wb/HG7RbnY8F4SNxcdzz/0ZBm8GJ2/6eaapw2AlOfJwVg9z3u1tDc6jrfZq4ibzcthrbwu5QLvJwuEfNH3FnD8Nqmw1j7DWtxV02X2xTP/ljYqudeOgaftmPHIdsozECdExtvyFkqjW3XxfRMyTKjWNTaoweNIKxGCGYsAIcy7ew6QcncVO9gPRziifVFucBhny9MXvofqHVEU5A8QMRYK5wxBynECkhoPjrP1vIWprMF0R+XBla5grq8UjA9IFgMy/9HRVMZ17JjARLULNdmRhnFCGM8HjEoTi7omdKKie/gMW4+cxaFEVP+95No/GxVuS3oksOv9kx9orLxxHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(39860400002)(366004)(346002)(451199021)(186003)(31696002)(86362001)(36756003)(478600001)(6486002)(6666004)(966005)(38100700002)(8676002)(8936002)(7416002)(5660300002)(66476007)(66556008)(41300700001)(66946007)(2906002)(6512007)(316002)(4326008)(6506007)(53546011)(26005)(107886003)(2616005)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzcrM1VKaGdHaGliWHpyZ2d2S05rWk1xcEdiVVNrSnl6YkJ3TlVHN0NRTzll?=
 =?utf-8?B?dkxXSlpIMWZuK1hld29ZZzJkK1RlMFc3cFhrUC9Pc3B0SEs0RklSbi9IZVJV?=
 =?utf-8?B?TjRVUzA1NzQyUis3N2VqQXBkbDhxRWNMVlh1ZHF4T2ppeG4vUitpTHA1ZkNz?=
 =?utf-8?B?UkdrRUNtMjJqSXZiZ2RLSC9Gdi9ON3NOOXFGcFVkTXUwN0NHZWMxVjJhK0da?=
 =?utf-8?B?OTJHUzZENjBvMWx4SHQrcVptNlJqblo4N1RaRDNsc3M0K0xhU0NyZXdCYVFt?=
 =?utf-8?B?M0tYd0t0clByYW43Nkp6eHdQRmo1czVQRzltRldscmd2enJVR0Y2Q25wUHVn?=
 =?utf-8?B?TXNQWkttTlIvcUtJTU1qcy9ramY3cUtXUnhacFV1V3dLTU9jcHJjRkhPcG5D?=
 =?utf-8?B?c28wUDR6Tks1aXdGRC9XdUd6dFJTNmxwL1ZmL29ZV2taWFdyck8rNDVRR2pr?=
 =?utf-8?B?RVdqRjhYZEhleFU3SHVzZllIN05RNDlnR2IxOGdGYnM3UXBKc2Y5Vkp6d2o5?=
 =?utf-8?B?azVVRklqSVA4cTBrcVlOVEt3d1Vza1BTaXlNWUZmcTMvRmQxa1cvcWtlZjBI?=
 =?utf-8?B?OUJXdjJITGlmZ1pTTndGU3RnWjAwMnl6NElYV21jWHc3cit0VGU3cGhDbmNl?=
 =?utf-8?B?Y3VLRy9qUE5qZE4wOW5iS1pDUDlwcmNnNDFFNXlxaWlYeU5kK3l4WjNWdU9U?=
 =?utf-8?B?NXNqWmJYSlFDejAwNGpFdUlrNyttUHNmWmpZV1AwaEhxaWVkYWNrTHppV2hC?=
 =?utf-8?B?aDQrVm1Tb0xRWlFNekNobDMvelBsTmcxREdaRnhRUG1QdVlIRVlNVTcweE11?=
 =?utf-8?B?bysxaHJTdXJncWU0TW01dmtoeGhXbFcvY0tzekxSVkt3ZU5HQVBMclVac1g5?=
 =?utf-8?B?SkVKOWxQRjhmcS81MlFUUmxpalpQMy9JNXJZYXBZTnZBc1pmbkVXM3hPVFUx?=
 =?utf-8?B?WUduUDNsektjU0dFa1JkczVMeFpyTUNVcElxcjZtK1BVbUxFN21pUHRnZjM2?=
 =?utf-8?B?d0E4dGxyYi9kcmVpekNWOGdXVzBIZjlPNTRpUWZCVm5xTEwvSnVqZ3pjNHBw?=
 =?utf-8?B?SHlTYjNocFhtZkJVMmNxZzIzdzFYc1dpUHBqSVlRdDIybHVTQXpHVjZhcTlF?=
 =?utf-8?B?WUVxVlA2MHRrelVFaCtiSmdscmhJR0RyMTV5b3hlSThXM2pETkU4VUJXcmtq?=
 =?utf-8?B?dWlPNkdnNFJRWlEvOEk2ZTF0WWwwakh4R2UzTCtyaUtMTVpWcUxuVEFTT005?=
 =?utf-8?B?Y0I1NTVIb0c0cEIxMzhybVN6MlpGKzZ0ZlpWSm1BWU1VKzdrRkNsd1NuSmMy?=
 =?utf-8?B?WnFZNjlidUtGYlQxMDVpUGQxc2NWbFhzWkk4bGRQemhzMGt4NVhBRGZ6a1Ew?=
 =?utf-8?B?bWNzcWJxNnJCUlVSbXNsbU5nT05SNlNNSDFJQ0FxWHhFL0huSWFVYmlqMlJW?=
 =?utf-8?B?NWJ4cG81L1RMbEpzOTJ3UVJMdUhXcVBrd3VEU3gxVWc4d1NYQm1vb0RqODdQ?=
 =?utf-8?B?KzYrVXZISFdxQlNEaGRTdExFaWc2empFWENxeHc2Y1BuTVhPM085c01LQVo2?=
 =?utf-8?B?Qml0eTNQMzZKOFBhR2lyY09HRzVLMThidTNuSWhVU0FSM1V1RU14aHZ3S28z?=
 =?utf-8?B?ZW01NUlBWEROVEdkeEFQNWovMnRvVHNvejcya3N2SGNhc2ZKTk1UL0pUQXhU?=
 =?utf-8?B?NThJS3dPY1FWQ3RRL2ZQTk1LWjZsUkNlbXV3eEhSQjUwRC9aUFNXaUxObUxS?=
 =?utf-8?B?Uk92azEwdHJha3JKclRSVmE0WUJaY09JR0VPRG10b1ZWN0NxZGQ4V3I2TVFj?=
 =?utf-8?B?QVZmdXZMQTdWMWxLN3ZDVmxlNUhEK2tFY1M3WEV1cTNKa3BIcXE0alhoTllq?=
 =?utf-8?B?TjVqTU9HM0hBaVlqV0dvNXViZWxnVUhwKzJOb0djMkxOT25tbnh4Y0tPRDNG?=
 =?utf-8?B?RUtKN2ZPNTFBdnI5QUpVdlAvTWZBMm95SWgrWmpYL0NWNjA1ZGo5SDhKWlNN?=
 =?utf-8?B?SGx6RkVvZTJZMUVFUUtCejZhOFhnVjJjUHF6ckg1b0RmNmxnNWZpZ2s4eGcx?=
 =?utf-8?B?WHB4S2VTTEZKWVl2cTZZT1l6Z0JkUy9RdWVHdExVODE4RFc4T2psWm1LNGQy?=
 =?utf-8?Q?K+g+8UxCnik/LcAVnGdgn/AJF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bGNlL2crMi93TTNUem1JUDZXSlJDeXdpMFRvMmlUR1pMdGFBOFJSclFsRGtK?=
 =?utf-8?B?WE96VFBDNTFvNmFlQ0xycm5jVksxNGlFZElvUlpyT3o4MWZRM1VGWTBjNDVv?=
 =?utf-8?B?cmtjbkV0cC9VL3dYTy9ybmhONmpRTVFKWDJXcWZTTEIrVnpCdU01ZFNTOUw0?=
 =?utf-8?B?V0lCbm5VaU5zQmttMkhDTTNMRUpPelI4TjQ5WWVkT1o5WTdpOWZCdjlnT1BO?=
 =?utf-8?B?RTZkOE93LzcvTjhtQjJYeksyencyQ2ZQNlM5TDB3QzNBM3prcXlZQktWRGpP?=
 =?utf-8?B?WnR0K2I0S3NLZi9jZ1FxSEtTajJna3cvaHB5UDVoVFlKWWxNVHR1RzVubkZC?=
 =?utf-8?B?Tlpac3htTUVIamFLU0RkeDYzSE1QYnM1N0trcTlLMTkxQnRBSXpKdmxya3Y1?=
 =?utf-8?B?eFB6ZlQ1d2pqbnZ0L2dQNThleStKRWY0S1hGRm1MdU5MaXRncFZOR1BXem9P?=
 =?utf-8?B?SmNIbUtPTDV4ZFM1V1hIMnRoaTRqMUlRWUJEVHEwMmpCdjg2TUhsZE9FR2ti?=
 =?utf-8?B?VTB0Z3IrRG1hK3ZBckZqK0R0L0l3UWRBSFhUZUxwQXEzOHU3SC82VHFHcnVn?=
 =?utf-8?B?UEU3dVJ1RkFkMkJ3ajRsbEpmamVMMmdsZ21KMjU0amt3K2dnZjFFYW5XcVN4?=
 =?utf-8?B?TGVxRTVBV3padVpaSGRnQVQyaS83VVY1bUNYMTNXT0Q0K05zZTBxOFlXS2dm?=
 =?utf-8?B?d1FWbW5IQkJtS2RSdFhQTnc2L0ZLb0dFQXlnYUM4V3JucXU1dFhLS20yNkFY?=
 =?utf-8?B?TnBEZXFMRjNLS1ZPNjJvd0JrY0k2WTZxZmQwdDFkdlB5Qk5yTkJ6S3RENi9D?=
 =?utf-8?B?QllOSWhkTkZtT05Xa0ZDcmJkUjJXQU9zc002Y3Bqa3pUdm5NT0htNHdnMm1E?=
 =?utf-8?B?RWZIR0M3T0xkNExzaCt5K0tlcGVmQlc3QWQ5OEZseEoxYzl3WnV6akU3dE5r?=
 =?utf-8?B?aUlrcG9tdnpnNFlPeGNZaXFBQ3c0VlU3T21WVzg0cTMrM3Jjc08vU2tkUVZ0?=
 =?utf-8?B?Z0xZZTZWYi9QS1luOFRoOW9WZy9LQmJxQWxnbVBoNVFuUXJtUWlnek9GWUNU?=
 =?utf-8?B?dmR0SDdSK1ZwOU9RaExoeEE4QmNyU0paZi9Ja2pnZHYyVHFrZWdqQnNpb3dp?=
 =?utf-8?B?NnlXc21jNk8wWll2bERFK2YyMjdBSERSTFdYeHBGZGUvNFo1ZU5Cbk1NVU16?=
 =?utf-8?B?VzFWdW14Tkt6WmhWdXducTQ4bEx3d1ZnMExaWVk0VEFmdnJoRDUrN2c3SWdQ?=
 =?utf-8?B?OTRDWlhhTlA3QTFUZERVNSswYUVFSTJuY1FzWFNScnRjK1QrSER6UGFUVXlM?=
 =?utf-8?B?OWY0eXhDOXN5MW01YWY1eVhzWnJ3STdTK0pRaTQ5UVZHOGtQZEhEN2lGNmZM?=
 =?utf-8?B?YStjNHZiNEFxQnU0bnZUeHlacGsyUTlHbU5IOVlvbEJXd0tQbjlRMWVtRTRQ?=
 =?utf-8?B?b1Rja0NCZjhZQzV1Yk9EeTVzT2k2ZGRCMjlhQ3d2UjE0TEpwalN5c3J2MjZS?=
 =?utf-8?B?UW5qNWNMNlBTWGdnYVdPS2RZNGM1Y2R1SDNSay9pUkN1amJnbGtYaGxWYmtl?=
 =?utf-8?Q?wFWFv3iqPn0vzWOqvZhJHel2I=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf15a93-73f5-4a81-9ab4-08db51a8c842
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 22:49:16.2261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4VbeYw7HfM2r4aRfsI3shVssGCT8J6IpMvd7/tLMy5afcGg4NgY+zO07Bvu4xoHWdhLIC0jJepJEqolSNFZN0VCtWfQ9KBzCEYVSZ3E7vgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7284
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305100189
X-Proofpoint-GUID: Yp6S3EwvO2vUfUC-vnedYQ6QTpFtVYfD
X-Proofpoint-ORIG-GUID: Yp6S3EwvO2vUfUC-vnedYQ6QTpFtVYfD
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/9/23 17:39, Thomas Gleixner wrote:
> On Wed, May 03 2023 at 18:41, Eric DeVolder wrote:
>> This patch is dependent upon the patch 'crash: change
> 
> Seriously? You send a patch series which is ordered in itself and then
> tell in the changelog of patch 8/8 that it depends on patch 7/8?
> 
> This information is complete garbage once the patches are applied and
> ends up in the git logs and even for the submission it's useless
> information.
> 
> Patch series are usually ordered by dependecy, no?
> 
> Aside of that please do:
> 
> # git grep 'This patch' Documentation/process/
> 
I'll remove, and re-examine the messages to use imperative tone.

>> crash_prepare_elf64_headers() to for_each_possible_cpu()'. With that
>> patch, crash_prepare_elf64_headers() writes out an ELF CPU PT_NOTE
>> for all possible CPUs, thus further CPU changes to the elfcorehdr
>> are not needed.
> 
> I'm having a hard time to decode this word salad.
> 
>    crash_prepare_elf64_headers() is writing out an ELF CPU PT_NOTE for
>    all possible CPUs, thus further changes to the ELF core header are
>    not required.
> 
> Makes some sense to me.

How about this?

crash_prepare_elf64_headers() writes into the elfcorehdr an ELF
PT_NOTE for all possible CPUs. As such, subsequent changes to CPUs
(ie. hot un/plug, online/offline) do not need to rewrite the elfcorehdr.

> 
>> This change works for kexec_file_load() and kexec_load() syscalls.
>> For kexec_file_load(), crash_prepare_elf64_headers() is utilized
>> directly and thus all ELF CPU PT_NOTEs are in the elfcorehdr already.
>> This is the kimage->file_mode term.
>> For kexec_load() syscall, one CPU or memory change will cause the
>> elfcorehdr to be updated via crash_prepare_elf64_headers() and at
>> that point all ELF CPU PT_NOTEs are in the elfcorehdr. This is the
>> kimage->elfcorehdr_updated term.
> 
> Sorry. I tried hard, but this is completely incomprehensible.
> 
How about this?

The kimage->file_mode term covers kdump images loaded via the
kexec_file_load() syscall. Since crash_prepare_elf64_headers()
wrote the initial elfcorehdr, no update to the elfcorehdr is
needed for CPU changes.

The kimage->elfcorehdr_updated term covers kdump images loaded via
the kexec_load() syscall. At least one memory or CPU change must occur
to cause crash_prepare_elf64_headers() to rewrite the elfcorehdr.
Afterwards, no update to the elfcorehdr is needed for CPU changes.

>> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
>> index 8064e65de6c0..3157e6068747 100644
>> --- a/arch/x86/kernel/crash.c
>> +++ b/arch/x86/kernel/crash.c
>> @@ -483,6 +483,16 @@ void arch_crash_handle_hotplug_event(struct kimage *image)
>>   	unsigned long mem, memsz;
>>   	unsigned long elfsz = 0;
>>   
>> +	/* As crash_prepare_elf64_headers() has already described all
> 
> This is not a proper multiline comment. Please read and follow the tip
> tree documentation along with all other things which are documented
> there:
> 
>    https://www.kernel.org/doc/html/latest/process/maintainer-tip.html
> 
> This documentation is not there for entertainment value or exists just
> because we are bored to death.
> 
I'll fix it; unintentional. Should checkpatch.pl catch this (it did not)?

>> +	 * possible CPUs, there is no need to update the elfcorehdr
>> +	 * for additional CPU changes. This works for both kexec_load()
>> +	 * and kexec_file_load() syscalls.
> 
> And it does not work for what?
> 
I'll remove this.

I keep using phrases like this since kexec_file_load() is wholly controlled by the kernel code, 
where as kexec_load() has userspace dependencies. In this case,the sentence isn't warranted; it
will work; no exceptional cases.

> You cannot expect that anyone who reads this code is an kexec/crash*
> wizard who might be able to deduce the meaning of this.
> 
> Thanks,
> 
>          tglx

Yes, thanks for the fresh eyes!
eric
