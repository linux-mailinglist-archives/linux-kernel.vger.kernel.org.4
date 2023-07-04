Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A6A74784D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 20:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjGDS3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 14:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGDS3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 14:29:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CF9FE72;
        Tue,  4 Jul 2023 11:28:59 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 364HAiKg003481;
        Tue, 4 Jul 2023 18:28:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=X9AF2hV/+fzYxfOnYrP83WWZNYw+E0+FFP9w3izoXTA=;
 b=CISI1dtTaMl8nojogJmts+PNcy2+VX2cv4RSK2XSRXzvSM9ImNgBgxIyassaxf8Tyb/O
 v3Gxrvwt/GLmog2vUCWk+wNjcELI6O7cuJ57uY1CY5tV3xhs1ekAvv1Q8b0rYMxkBalG
 TuZyp2MUd6IDb+7GsfEVOVW3TU8aHEaKKgSEHJAlylmFvZHdRok709/qQcMV/Qwd3FZa
 WDXI0xkmpNIG1eGmr2eJXi2lV+dEwYkH7eYA1q0aIEdaqtbK81lY/mX5hzyTk033Hdut
 LBXXCjHhVYBb8gxohQPnve2A5kudDObhC0L4xNSaeLLRYnklIy4hLKMf7UV7V7n74JjY Cg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjajdd1xh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jul 2023 18:28:53 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 364FqKuC010859;
        Tue, 4 Jul 2023 18:28:52 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak4wejs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jul 2023 18:28:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/ds9F3omP8taxNHu1EcA3QcV/pY2nO1pUGavFuOCxhcy6iYiu4PPTIDPdA8qRUrjLBoI3zD3aEsajyY0D4TgeLXMJqfU+42aaoa4/cvxNHj2a+lB9+874LG9J2Xq1D7rVpapzeqP/CVO/EXQJVyxA0UBz7lsGOiwF/5+a1UhP9Fz+WXzlpXLP6MU7zj31f9TswqQJKMQd9DPbDC4c6Q/NdFD2hT+G8NvG2F+6M7m9iK5NVJ2YSQkFHKAoEh8KIEZCd/b2g+7zzzc6KSCMO+KUW3N+6vH+AiqriJz6JSsw7KSOtfQSkZOR/nvJWXUUnsmx5kbxvVzhgW2FmbMtJDng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9AF2hV/+fzYxfOnYrP83WWZNYw+E0+FFP9w3izoXTA=;
 b=KqqCODSLsd3N9aTrB1dbusjhti3lDNnA6+hqi94P7BW6iEyGa5hBp2cKnrDqoWwCUnfeM3JsKzf0swtHavG0hBPVJIzjFihxBbrwu8FTq1T/Wr6NiB13iNFC4vBB3nl0ZDNmTxdZG1Sp/QzXlznuBNH04iDf96jqrGuraXfcc2zJ+Ei+Z3szETaLyNxgtWzS0TJG5LBlCly/RNL/ayFjhY6otfpCaePw4NMXNW3ULYw9ve9iohhPQxUl5oVkGqJK8Jl1rL9c2lKsxANhNM7Cm6aldv9NSNhh877tiZXX4TAsG0n8L0NEM1dPdtdtbsmD10HeKTu6h9UGdcvisGkIXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9AF2hV/+fzYxfOnYrP83WWZNYw+E0+FFP9w3izoXTA=;
 b=d8JLuWEIn6hCEPoo7ny0FLbcx8kuk3WxejnEahTjX6YTQg81b+ZD1cKaOXCorSO6UeuZzYvRimYzffwG0s+advmfIQoIf9g4hwXdh31tuYaCkFgCm/iBsquWDfbT6hzGQgZgTkva1bT7hwCrvtuNbrwjrS8r54oZVXni+fR6InM=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by IA0PR10MB6769.namprd10.prod.outlook.com (2603:10b6:208:43e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 18:28:49 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::f116:2b2f:4f20:3567]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::f116:2b2f:4f20:3567%4]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 18:28:49 +0000
Message-ID: <4650691f-a025-0a93-33ec-a99ff0ede157@oracle.com>
Date:   Tue, 4 Jul 2023 20:28:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] module: always complete idempotent loads
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        George Kennedy <george.kennedy@oracle.com>,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        syzbot+9c2bdc9d24e4a7abe741@syzkaller.appspotmail.com,
        Johan Hovold <johan@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Rudi Heitbaum <rudi@heitbaum.com>,
        David Hildenbrand <david@redhat.com>
References: <20230704092309.22669-1-vegard.nossum@oracle.com>
 <20230704100852.23452-1-vegard.nossum@oracle.com>
 <CAHk-=wgy2q9viwq-bAqaq8X_WQHNqDsu1AzfeYXAcDQRZmCoAw@mail.gmail.com>
From:   Vegard Nossum <vegard.nossum@oracle.com>
In-Reply-To: <CAHk-=wgy2q9viwq-bAqaq8X_WQHNqDsu1AzfeYXAcDQRZmCoAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0212.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:374::9) To PH0PR10MB5433.namprd10.prod.outlook.com
 (2603:10b6:510:e0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|IA0PR10MB6769:EE_
X-MS-Office365-Filtering-Correlation-Id: 016e34c8-23a8-4084-7d2d-08db7cbc826a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3GwoS1GzmdE9rpILARFbtZi7wY978bD7s+abjfVYMHiKw59q5PpYRuxeRouphrOw6wdJC/4Y7WVzRi0XDS+X57dSqiH3JBKkrSboR+9HXl5vJ6HjUt7JSSMpto3akGJV33mq+YS3tCm+kBw/o4XCTV2PI3Xbma3bhkqx8MP3uCLUs380OYhJz/ZHnLNozkJ4uy5615pq3dOOV3RgxHQ8tVsuNV3tDnUqWeO0iMdLdkuJl1b4W6TJRSXx5VG9hDLOYAvWgBDB725BfM76uk7JCRSaYwx6PSkhDyuWphz9UvWCKyJNjMTyLq4eDuswyUEGtGeUGSVOb2uCEuKhKtQHpslZymrT9Mnon6QuILVby7iXtSbD7jnSShHUGf3IigGFTSgDWQ+ztL+8ICsQ00FfnrB82fo9NDoLPU3hDakWNk1MhzukL3KrR4ZK6h0Y1HJVcI+P98xPLXRtr/AAYy01kTDBVK3GIPHMRxifekMF8ykfiWW/35EHcHIb4MfyrkNpwHVsFkrFPR9saaZJKYzEEPGWdPWxGctHUbzQnmgpP8hDPD7YaVlVFM2su0TEjYKBS61+cXIDJ8vs0wDng25tfFtgms/xJU6q9XmoWNIKv7v42qnbKyt5KbHrMLPfq9iwVN42KYriu8GamNooEjU/iA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199021)(4744005)(2906002)(41300700001)(8676002)(8936002)(44832011)(36756003)(5660300002)(86362001)(31696002)(186003)(2616005)(31686004)(478600001)(26005)(6506007)(6512007)(6666004)(6486002)(316002)(53546011)(66556008)(4326008)(6916009)(66946007)(38100700002)(66476007)(54906003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWRRbUZjZGZFbG0wa1ZQYmZoNURYbVo5YXVsSlF3MmJuZUhrNnlXQTNDNE1B?=
 =?utf-8?B?bGxIa3dZWXJDT1MwQXJNMHVUcXVZdW9YTGt5eTNTRVNXQWVuc2ttdy9VYlJl?=
 =?utf-8?B?RFF2YXpKeFNKWE9USFFhZ2lwTW82K3NNbncyZHpneEJjb0lXcElISDFnVys5?=
 =?utf-8?B?eE0wMmVHYytYS1BNSi8yVExyYzBIOFdrUlU0SFRhRCtpSnQvNHZleVljaTl1?=
 =?utf-8?B?bTZQeTIwc0U0ZWl3Ky93RWpqZUEyRHdjUjdsSGZXUFZDR0pBNENJL2szRTNz?=
 =?utf-8?B?bWl6czU3am9ZbjdwTXpxSFBKK1JBbVRMbzhFZW5vWng5eTJ2SU11emhmbXRl?=
 =?utf-8?B?T1VmeG1ndTd4dnFoeTRNVkQzT3NZcWo2aU1OVGhBT2JsYUpjRU1pdjV1T0dS?=
 =?utf-8?B?OHpFVlNHbkFuT24yanBOd3ozSjVNVC8wdURZR3ROMzE3eTY3YXBqd0tnQkJO?=
 =?utf-8?B?c1htUWdab1lwbG9DSG1kWnVRbklFL0M1Y1NoVzB1L1pydjVDMUxYSzBCQWhK?=
 =?utf-8?B?eGt1NDNZQ2RoTDRkT0RacjQ3ZkdVTk51Y3BSTFVWSDRDb25FSkZFUis3VENw?=
 =?utf-8?B?WUpwelFUT0VYWGZIQXV1VXZNZ0RBWFZ1VVkzUWRRMTI2UE1sdnQ1M3h0dDc4?=
 =?utf-8?B?T3p5UHMzR3RKNlZHVnJmdStZVVRYZ1ZiUllHWXhsVHVmUENCODdBemZrWVk4?=
 =?utf-8?B?ZEJHRjhyeXdzR2R4OUh5TmxMNWJmR05iaEZTcmtjZWZVNTIreEw1RDNVTDBk?=
 =?utf-8?B?K1RpMjlIaUxwOVFORW1ORlhmMFVSYXRqVGdzL2JiSUNSZEpSeThHNGRiV0ps?=
 =?utf-8?B?MmF0alIyUW5qNjh1dDhNWmNmdVhlZ21sVXZVOXZvZFJ6WmtZbTVnVUdQTjd0?=
 =?utf-8?B?aEo0aTB4TDhMNDlDMnhtQ0ZtUE1zR2xQN01OR1ExNzZsYWFYTUlyaTJGa1F2?=
 =?utf-8?B?NUVqMDFCTmJTZTZ0M0VrLzdTeDJDQjE5eHVES1B6citCQy9QTVM1d0xIdkpU?=
 =?utf-8?B?WVRoZkNhaTk1c3JhRElGY3VvclFKc0liYy9MNDc5cVR2bGNoSjN4QVlYQkdM?=
 =?utf-8?B?Qlg3THlsL3hDTDJVMWw2UHJuZEczNXZPdnpmOXRrVWlmcXVaMmlFQk1MWnkr?=
 =?utf-8?B?QnBUalBlaHI2NTRmOXJVR0VNR3hFUldEWi9NVkNxMnh2NUxJakdSOEMvUWVs?=
 =?utf-8?B?VmhrMkh4ZnBvdkhaWFNKOGsyQ3dQQzZDTlBWWmE5Z2d1UTd6NHI3WE14VlVJ?=
 =?utf-8?B?dTlCRnZybDNyMnhlcytyQW5CR2xJamJ0SWxzRU1sWlFwTWszZEVoM3ZNTzk3?=
 =?utf-8?B?d3prN0hyUkNkVVZWQmVscGtxWXlCSDVEMzU2ZERNNkdJajQ4cUcwejhTMWQv?=
 =?utf-8?B?clRSWHZIeXB1NWVhZkhlNllERnhGVFc4YWF6VDZhK3JMR2p3aGZ3L25ZQTA4?=
 =?utf-8?B?SkhqaHRqeG0wU3lzYXhMcjAzOEtLbk5VTm9aL0tlcEN3d2xUNGk5WlBZUmZE?=
 =?utf-8?B?aDZpV2o2ZnBITktqRkhsMm1uRkdCVEZzckVJYXBFMzMyZm5zMTZ2N1FZWlNI?=
 =?utf-8?B?cWNZNDRzczhzUjl3Ti9MaTJBY2ExTFV5T09XTmtEQ2ViQmovVlNVZ2NvVHNF?=
 =?utf-8?B?L1NxYlk1RVFvMFBQTVJCc0VXSHBodDBGNTNJTnhVWVhQN3lXbFhJWVBYODVQ?=
 =?utf-8?B?eW8xajlpcUR4WTMvYURRU0JLSkNQMnJ4MWxaYzZLejdNcUErbHhqRTBMT3VJ?=
 =?utf-8?B?VlFFUGNqZFJzdzFvZXQyNldTeURRRGROR2VEN05Pek9JdlVuaFY1aHYvcnl4?=
 =?utf-8?B?V0h5cTdyTFBnMWdyU3FpcUh6SThxVlNGQmliaW8xTURYdlVQVXJwQlBFM0xQ?=
 =?utf-8?B?QTBqVEx1ZzJjZytUOUd1aUViRVNDaDhVaXpiN0ZCWFNHUFBQY3FVUUY5cXIx?=
 =?utf-8?B?d2w5Z1NQSnd1VzQxYTZhbTUvK2ZnRDd0ay8wdFBXMjZ1Vm9NU2ZSMjdpbk0r?=
 =?utf-8?B?bG5xVzY3SkI2TE0zQ1kvaWRBVjJpMU5YczNvbUxJZVVNNWtxWHRPMGhoZVNU?=
 =?utf-8?B?aEJNc1hpNjJ5ZjIxRE91aEcwVUNZemNKQU93bXg1b1phdGRjVmZldjdxQ2hY?=
 =?utf-8?Q?T6wT6EwP9AvyNdz7m9arVtplo?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?OW1YNFpxYmsvRC9ZUFZ5NGZ4RTg5SEVnc1BwYkl2UFYwdVFrdGVmUnVWMTVX?=
 =?utf-8?B?ZmIvOFh0Y3RJSzVwdGhRM3RqOGFEYU9QRmhIdGRmbWkrekJ0ZnAwSlQrKzNJ?=
 =?utf-8?B?aDgyZVBkczVPTjJsRDNvbWtYenFEZmZUK2FFbExqTkU2djBpanUxcjFLTjk0?=
 =?utf-8?B?SkdsMlRCSWdyNWJ3TlVhVEt1ZG5kSTNLaXY5cVg0WHg3ZDZDVjh3cGFFY1Nh?=
 =?utf-8?B?aUk2U0xicUl3VmhOODFjVlZ6bThLWmJEdFJNSmFXL1A0ZXNaYXcxTUVyQXZU?=
 =?utf-8?B?Y3diQkQxVk10czlzLzV5VzdDYmxHUUNMZUhBdHdiWlVUUzJpN0owaTBpcWsr?=
 =?utf-8?B?ZkhmUEcwTmJCbGhQaVlZNWc4WUNpWDg3SFJIVHUwNnprSlpHTHdtNDFGWmZv?=
 =?utf-8?B?R1JvQ1R5TnZ5b1doNU12eDBaWWRncXZ3Q3VzaUZoOHE1TjlyeUh1NmdGWE8x?=
 =?utf-8?B?ZmhyYWRSTUNsRTNsQUlPVjRXTlVjc2ppTW9kVDJIWFQzOVBxL3hXRHpvZkgw?=
 =?utf-8?B?RnZ5d01USndkcUg3NEhDWkdXVXc2ZTVpTnFvQmhEM2krLzRBaHVMZlVQOGxj?=
 =?utf-8?B?bVk2SUJTZmNDWnJKQlowZXZKcHI2dW54Sy92QmxhVldUajU0NFZYcyt1aWgx?=
 =?utf-8?B?Y0RLSlA4V1lBcTIwRG10aDBDaElNei81b2VZWUdDc0srdS9TZXhaRWtMSlkv?=
 =?utf-8?B?eGhEQ2dnR2NXRE1pMEVPcmU4NnVreWpFS3I2T0VCTml3ZTJ6VHdQNDFpMEk3?=
 =?utf-8?B?MmtqUTB1OU1yRmh5cHZDZVRvV2JpYXp0cEhVdWp6SkJaMjdESXZDODJnOGVL?=
 =?utf-8?B?ZFB1dEthVWV4L3ZEZVZoSUxZWnNZZGhUeEpKMFQzWkViaVVscXFScHdXcG1F?=
 =?utf-8?B?RkF2WGM4eDJQQzhYT3hvZzhydkt0QW5jY2dZWklDQVZPTEtCVlhZQzJnZi9a?=
 =?utf-8?B?MnRDZGpZcFNIU25oQUZQV1kxbUt6WGZPMHJOS2syb0FPMkMyd1Z2S0VSK2Ft?=
 =?utf-8?B?U2gxQnFYdW02L2VDaFB3eDBKUmFUZForNElPbnFSeUt0YnhLUnBuU1NSMndB?=
 =?utf-8?B?ZjRIOXptNFVLamZMN2RVbjhEdGhKYzIrQzhZMGRCZDVUaUMveDNvSkxXWWx6?=
 =?utf-8?B?N3c4YmhBZnAxcW41L3NsV1dGdzlMeWZrTVJ2U0dXakNmNWZWeVNZU1YrVTBG?=
 =?utf-8?B?V2RjdEplWjNUS1NDTnNjb0dzRzFudnlmalVOT0VGcnNOSFN1UXpGRURkYjVY?=
 =?utf-8?B?dkpQY1FiMjV5ZmlZV1FJQzJWbkpYMHlWTkVicVBwbmdzQm1BTUZwTXFlZzNp?=
 =?utf-8?Q?Tm/D3HEnKTknQfFSwGQhODH+Z1zTwnsk9j?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 016e34c8-23a8-4084-7d2d-08db7cbc826a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 18:28:49.4862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7f8OO3bMASC0FuOwIFeYuXgd2e130U0hbzzmNOUZeU2U3pP2wAloBte/c954QwCYGtE/lFrpZTpEzQUBS9NCIVUcygpKPfoy0DBAx7/EM2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6769
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_12,2023-07-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307040160
X-Proofpoint-ORIG-GUID: kSoWf7srYuo8Wcig_c_VtAS0EXD_HU9s
X-Proofpoint-GUID: kSoWf7srYuo8Wcig_c_VtAS0EXD_HU9s
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/23 15:37, Linus Torvalds wrote:
> On Tue, 4 Jul 2023 at 03:09, Vegard Nossum <vegard.nossum@oracle.com> wrote:
>>
>> Commit 9b9879fc0327 added a hashtable storing lists of concurrent module
>> loads. However, it didn't fix up all the error paths in
>> init_module_from_file(); this would lead to leaving the function while an
>> on-stack 'struct idempotent' element is still in the hash table, which
>> leads to all sorts of badness as spotted by syzkaller:
> 
> You are of course 100% right.
> 
> However, I'd rather just use a wrapper function and make this thing
> much clearer. Like I should have done originally.
> 
> So I'd be inclined towards a patch like the attached instead. Works for you?

Harshit tells me there's still a crash... and indeed, with your wrapped
version we call file_inode() on a NULL pointer before checking the
fdget() return value.

It's likely you already changed this with the f_mode changes I commented
on, so maybe it's no longer a problem, though.


Vegard
