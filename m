Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6F168BD7A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 14:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjBFNFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 08:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjBFNFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 08:05:52 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA104C2A;
        Mon,  6 Feb 2023 05:05:50 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 316CwiU8011430;
        Mon, 6 Feb 2023 13:05:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=kjhpdNE4rGb/srjBopdmqIphxbP/ZSwg70X6wQBLJ9E=;
 b=1ql9km/NZfEXZkolNt9MTibSMA5G4o7nXQrM+1kQwueR7fITHuFwL5z6mvOFDXgpOflL
 XtkSBbWIyaE4UV6PKkn0tP8R5+e6UuxiwHCRtDR1TYPStjDnkFXLr9RE6AE9GrN+xTPs
 VRkD0q0XYD+oU+nUxEMMOjmDt2gwTfHxY/q9BJXmaK+zWD8M3BqrwXwh9BSf82ucjhM9
 1KTTW0vh2CrTYFLlvA/CmPAQ0XRvuseFEXOR2idzLGT40jrM1HD8FBDYLPj3byX6hNSB
 Lqy99jAQqVbn+EInmMNwZSl1gKqgjTChgNtI8Vf7AD15wXr7aY0tNhdaK+pJHrA4MMJD Sw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhdsdjvat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Feb 2023 13:05:33 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 316CvNx4036971;
        Mon, 6 Feb 2023 13:05:32 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdta9h67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Feb 2023 13:05:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMPPfZ5N9CCgeEXHC0I48h/eqXvoj4mQXrPxUMn9NpvQl6Dya2gziGVdppYh16ThNWV+AAswiZuAu52O9QBRIUl/5+gv6Pk2yyeF8ZfTY67yr9XP9j5LtpV3QpNzmIPn6akA+cAHNhnFIFNYfR+DwmOUNYLL7OI+Q4Q+t6IQ7nwaC8d1iWS/Y7YkeWMoTFOQoC6FbhroaV1Q4o5AsNPo551GR2v0TYDx0wiDwQ5ZZERPMlihikLqsDSBRw1e9PMGhQTk5yrA+TD9Vg7oMOQEdNkOu44baZ7MUq5jhLg7qzB5D2Pmbrz9DuYOxzz1qOnqZrKC6juvsb4Rxlm68fGJVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjhpdNE4rGb/srjBopdmqIphxbP/ZSwg70X6wQBLJ9E=;
 b=ai0reVj4qnmLT9AoZS5O6mo9Z+paLHd6xFhx4oYsfeEbMjxOFO200fgawWFuRIF6q2y+VCFMq/4aQQUPZ7CVlRWdmeb1ZXj1OLr0cGGUnpkRDYloWkuhrBxBaYa9anGw+nvloGD49huCfHfbLsyJa36fEIqfzElc9FmUdauT3ZZtXKXtbao5H0HzCcO0EqJiReEmobU4JDqtnGBXPes+4A26PzQIBCzJW8g+fGRmxFCRAktbVqyoS24asKSqzCKZtzjdXwF40PE+L4mo9FHKQ4pW2Ym3Xa6GXqiAW/CgxAha7WJqpklhK/z2BbMfV08LcYgz8lQolAORKZVoobpCcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjhpdNE4rGb/srjBopdmqIphxbP/ZSwg70X6wQBLJ9E=;
 b=i/6ZddA4FqL3G5fm+ayOAei+17wKUvCGIHyhh2Dq3v0R2FeFgDRpOfZ01Zrdk2EGkXHl3otP/qcQL/fo8OiHYhNGU0tCJtqNbQV1ZNDANVYjWwodKYEkTrF0Kl3nvwwneGWaKOzJquGaKB3CrZmhJS1/IyYUkRAVs5uQk/xMx3w=
Received: from PH0PR10MB5895.namprd10.prod.outlook.com (2603:10b6:510:14c::22)
 by PH0PR10MB4806.namprd10.prod.outlook.com (2603:10b6:510:3a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.15; Mon, 6 Feb
 2023 13:05:31 +0000
Received: from PH0PR10MB5895.namprd10.prod.outlook.com
 ([fe80::7dc6:9d07:e82f:3575]) by PH0PR10MB5895.namprd10.prod.outlook.com
 ([fe80::7dc6:9d07:e82f:3575%4]) with mapi id 15.20.6086.015; Mon, 6 Feb 2023
 13:05:31 +0000
Message-ID: <9d11640a-9adf-b1d5-b21a-8cfd5275aa5c@oracle.com>
Date:   Mon, 6 Feb 2023 08:05:28 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [GIT PULL] TTY/Serial driver fixes for 6.2-rc7
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <Y9+Yv1CQKNP0Bwqq@kroah.com>
 <CAHk-=whSQFHVzgQ+s8cbCSyE_yrd+BFuYktHe2=0h-nLXBi__Q@mail.gmail.com>
 <Y+Cuh3LmsF9PGO6z@kroah.com>
From:   George Kennedy <george.kennedy@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Y+Cuh3LmsF9PGO6z@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR1501CA0021.namprd15.prod.outlook.com
 (2603:10b6:207:17::34) To PH0PR10MB5895.namprd10.prod.outlook.com
 (2603:10b6:510:14c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5895:EE_|PH0PR10MB4806:EE_
X-MS-Office365-Filtering-Correlation-Id: 60bae4cf-43c5-47b4-ab70-08db0842d33f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bb/x1DUilZjrq/1OmnE2I+C+lDEKUzn7zSUekKglvN9LLAPQ4gCiNhcDr1Q6O66AeEvvBRLpTKIvo4f0YyyKVVoBXTAzYzKtYmPmYXFzCAQRH1dyvuHAt0TQLH2cu1QJR0SlUMf/EBVbcUD4uQTyBFBNpxMzJAEX9Sw0O24AD3aPdf4WFwH1QDvqjbBApL/xpYChoPPfYrwF+2iej5dxYq+xGujTQZhxnvV2tD9Y0zzOpb6btcdm2rvp9hEbkCjJmnRIe4oloiFTxzcb7XirpHgvfnv1zyiLNrfYCfmqCm2vDo3yJ6dOyZs6N8WMbmpCdxxTRRqJcsGvcongeFrHt3Se4J1tpLnnUuGcoLwcaQSglNjtsSZBbA3XipJEOh6lYOqLg8UxhGrK2niuv25xfKFLY/NB3nyLT8saM8BaTnPSfpCZi6ch8vfYyi8VETmSslF7NBT3JD8Bv3me/QUBSujUZb2j9hA8oxhD2rjWRWAbg3SV4LqsNQOFTe5pTBSBq+5am7uytRC8q0emCnYpt0MGEKpt6jC3X5YCTG6X67Lg38DrE/uOhnDhIXnMoAVk2lRpwKXvgvULWg2TcDmkTMzelTNrxu1R5JLWHKh/bT6yJTyc5tMq86oJBXz7J4Sb3gzKSVtqFZsXP5xPy+3HhUo7UjWSQrjZAhxBbGUJ1cseB91/fcWf8gaP7Jj5cUfJc8oc5SNNrkgo6siXgrYCP+HM0YaQOyvvGyE2hwnbfI8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5895.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199018)(38100700002)(8936002)(83380400001)(5660300002)(4326008)(8676002)(41300700001)(66946007)(4744005)(2906002)(44832011)(53546011)(6506007)(6486002)(478600001)(2616005)(66556008)(6666004)(66476007)(186003)(26005)(6512007)(31696002)(86362001)(316002)(110136005)(54906003)(36916002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnFZNlE0K1czcmpHWWhHQ0txMlllQzJKUlVmOHJWS3cvSURBZGlpMFFoU1Bt?=
 =?utf-8?B?THRxYk80N0c1VXZTazZuR2lLOUM1THdJVkMwd2VmSHVYamVsMVI0Ukp1RDdR?=
 =?utf-8?B?OTBJbDNOaWc0ZHZYK2VpcGZNMEZOdmtuS2U3NGxKay96dm1hZjlNOStONElT?=
 =?utf-8?B?dVNWVmRuQVlZeGJJNmlVdzhsbFpQWmk4TGhUSTZVOW55RkpFRG1GV1FIMXc5?=
 =?utf-8?B?VjVIcW1STWlIYnFYeDFVeFZFdGJiWDZCcVA1YytMd0NCNVQ0RGNlQ0tWTVdS?=
 =?utf-8?B?cThvdDRvclM5amxMaFdhTE9sczIyZnEvczhMNXNWaUs0Z0ZyRGJyMEpaT1VG?=
 =?utf-8?B?allCRDVWbkZDVkxqelJJOTh5K0hpWHJ2MCtmRUtBSWExZHE5Ylhwa0xkT1A3?=
 =?utf-8?B?TS9WazdzeFBiRzMrbzFsbGYzTU0vQXFrSWxFNFRLUS9UY2pES0Z0eGJia1Q5?=
 =?utf-8?B?alpsL2Y1STBBSExxTE1DUjlDcUZjczlVS2hpeXV3dm0xOEd4VnF1am53bUhU?=
 =?utf-8?B?WjZoR0puTVZQN0xidThzWDNVbEUxcTE5YnhQV2RoRVJMa3F4bVIvUm5mR2xB?=
 =?utf-8?B?bjFOcmpCWUVFenZnWExWN3JKUEthTjVrQ0dFeGx6S3RZNHU1TkpNdkJEV3Jh?=
 =?utf-8?B?S1Z3YWh2V2I4bjJNVlErSXF3b0cwbnRKazVNdXNxRkUxKzFyeTFvZDlPeDla?=
 =?utf-8?B?cVhCR2g1dGlRMEMrUnNydk9tVEk0UFNQMThUengwMHpvN21hcS9lR0paYXlN?=
 =?utf-8?B?RE1BRU5lTFBZM3BBV2hTYXNvRU9MNlROZWg2ZFRVbUpoRm16K1RGSXZ1R2kw?=
 =?utf-8?B?WTZmSEZqK3V6d2RLQkVYa3BZM2RoQXZWbzNiRHB2R1Rsd3NXaW53eEN6RmRy?=
 =?utf-8?B?dSt1WW1rRUlZL3plQjQ2ZHJRQm11RXBydnpTckFGbGk4MW9WeWZaTHFkVVZv?=
 =?utf-8?B?MVB6ZWcxM0xuRW9ZVlQxNGJqZytoTmlKSGM5THBacE1NV0xKV3IyTGVpVU9m?=
 =?utf-8?B?QnNNYVZ0Y0k4RFZZWlJkTi9IaVJRd2ZsNk1ydjgvRjRPN0dxdWtnalhpVVh5?=
 =?utf-8?B?REN1eVByQys0L0dhQm0rMWk4ZGxBUDhCc1BpZXdwbDRNQy94Y3pSSmtQcXU3?=
 =?utf-8?B?U2tTMExhSmsvZGVybHRPb2VPeG5SS2YrWCthN2NPRnF4VHFkUVdiOURzWHB4?=
 =?utf-8?B?Tk00YVFzREpzZXY3UVNKazJHWHRBRnY3QUZ5RCtOc2RneUgrK24xNEpxZWgv?=
 =?utf-8?B?c2V5NnRvUzdCMlRKb2dmMy9OR0NHS3YzRWJ1aGF0RjA1RzNXTkpTYnIwMGJp?=
 =?utf-8?B?RHFtQXg0ODdvVkkyNE5TWWxTMkc4Tlk2a1ZxMFI2RkdnWUllc3k2SEdRdys4?=
 =?utf-8?B?NjZnVTR2dnVramF1ZGtTQ1Z0UzJkOG11eFU1ZzJoMkMrRFl0NVZ4NmJQeXhY?=
 =?utf-8?B?am1wOWNXVGtzRUh6UGFPOUhmYzNaMXRSRUJnbENqUDhQZXE4Q2ZOYkVxS1Vw?=
 =?utf-8?B?MnQ3cWFES200TUcxd0JacjBLUzdsOW83K0JsbWZMVlpzSHg1VkZaNFVFc0xo?=
 =?utf-8?B?R0l4bGRwNWNTT0hEVy9ERGVySGVreEV2dU0raUgwdjlOcTVUZElPVnNQLzR0?=
 =?utf-8?B?cjR5V09mSThqYVBWekpvSVlCS3c3eTh1KzVQRHh0Yjg3ak5rclhoT2ZNa2hk?=
 =?utf-8?B?b0ZJWnZkb0lEeGJEd25BdzhNdzlZaWdBajBsQ1NJWXJJTUhUOWlvSFN6V2sv?=
 =?utf-8?B?TVlmT3BYNUltNXpQbHFYNiszOUhJd29LVGNMcGJMNUJOWC9rR1l1aGxYL1lo?=
 =?utf-8?B?TnFuMmd5M1I4T0trQ2FDVnpybnpjaXZjejJEaEM1aDFNbHpkclluWFRlSTh4?=
 =?utf-8?B?L3lHYlVFdE16TllvRHNrZ2lQRGRCWlFWbWZaNGgxdi9EcWJ5U2g2eWNkK2FM?=
 =?utf-8?B?NWcrWmhiOCtJeVJnWkdnWEg3NlpIajlIZGEvbmhvdDRxVHNPb2Q1WTJLa3dQ?=
 =?utf-8?B?ZUliTXRYQW1CQU1UemxWVnN3SllqeGxiVENtOGRCR3RXdnRFajVVMER2NW02?=
 =?utf-8?B?MlRhcWE2WGNDNEhyUXlUTmVNQmYvcHJOSXpOQVU3Ni85S1BGL2UxUCtxeWQ0?=
 =?utf-8?B?bWZFb0VqM1pmSzdMemw0cENBQ0lYeHBJbzNkUytnL05jZEd4ZU9kY3ZVQmVE?=
 =?utf-8?B?RGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MWpSbzhkVzAxRHNYNk1rblFnWmQzNStJdFZ0L1h3eE5NU0NsZHVPcXpraDBs?=
 =?utf-8?B?c043Y2YzMDdOU1NjWktPUGxUajlMcTdhcjJ6d0RVZmJiblF1eEJINTVjNVNU?=
 =?utf-8?B?bVJMYzNweEU3cFl6eFlyM29qeUpDblpmUituaHRsYTNuYXRFbDlMMmJuV0dl?=
 =?utf-8?B?Ums4a2tTWUZtakR2N2RHT1ZRaHBsYnhGc0JnaEllN0dreXk1YjdhZlNaWXBN?=
 =?utf-8?B?NHlwY3hGNlVwMHVuU2JRcThRK0ZuRHp0c2tjL0ZLNzdaam5yUnZRK2lNNXJx?=
 =?utf-8?B?SUZPL0d6TFpWcHBBYlplVFRWYmlqQnRhTzNKNVhUbklhNFpFM3JDSW9wZWN4?=
 =?utf-8?B?b2FmRWVYVU4rVlhxOXlFbjg3R1Fxa1ZzZmxLUFV2c1F4bFRVU2JrL3AvZllI?=
 =?utf-8?B?MU9qWWM2azFTTUFSTEx4TlFLVGpkZjVYK1VxdVdUWDE2cVdodW5kU2Z6MDFv?=
 =?utf-8?B?ZHBKMXNYbEw2SmFTWGo0dytUTkNjSzROU3FxN2dSdUdlem50cm4zQzhIaGFH?=
 =?utf-8?B?VlEzeHdoN3JFOWd4RTRqS21teW1FTGtnVHl0NmYzNW8wb00wWnVkSXpLQ0ZY?=
 =?utf-8?B?SDMzRWtDUnFyaGIxZloyYnl1RVFqd0syZmdmdmcrVXhLaktCM0xXZFliRTEx?=
 =?utf-8?B?aUNVZGZDeUJuNmhzSHd4dmQvQWdQNnR1S0NrRzM4TE05WUlXNUtPcnh4WUt5?=
 =?utf-8?B?ak8wT3NtY1lzMjg1b1FEZWRtZ1gvbUxDbklyMko3N0I3RHpTLzU2N0pNdzh3?=
 =?utf-8?B?WG5MV0E5ZVU3UGRHaEt3NTN2TlJiTEgvK201NEJmVWVXUi95ODQ2YXVWa3BX?=
 =?utf-8?B?UXNOSENIVDZlb1pseGd0eDY1MzhmR1FwZVJkbGtsUXozMmptRDNPZ1FJTTVB?=
 =?utf-8?B?d3FXc0VoOWxVV2o0RnRmSTRrS1lNTjlGMTFuNkRub2RRNjArMy9aTnI1SnpZ?=
 =?utf-8?B?Z3pxT2F5NHEzTVJPWm1NS0tDc3p1VXdBTStwVHdDRUhsam43NnB0U2IvYjJa?=
 =?utf-8?B?ak1QRWswUjZvS1JmQytzaXQwSDFoUGl3Z2VXZVVsbG9vWHFMSDVLOVJrWlF4?=
 =?utf-8?B?WVpoQjFlVnVGN1YvSnlaUnJEYXd4R1Q2U21VM1JYUFZnVHg5YnJIUW54VjlJ?=
 =?utf-8?B?N2ZrRjNkRkVEZ1RjWmxuN3dnbktBM3o5Q2JjVlhRZ2QvMU5tVUFUZ0JpV0xq?=
 =?utf-8?B?UllCMTcrY1lLejZZTTlQVTJ4WWo3Y0dZemxvMmw0UW9Kcnc5ZEU2dUhtUWFL?=
 =?utf-8?Q?t64d5CChI+nAXsb?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60bae4cf-43c5-47b4-ab70-08db0842d33f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5895.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2023 13:05:30.9492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03fayva8IuHv9zvMKuKoDr9rezo869Kym5lEXrW+zSqECd4EHcSsLyltu8INK9coJYjqBwjl2qV6WWNSIw9mSF68BfUs92z2RFaKYv+MhcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4806
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_06,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302060111
X-Proofpoint-ORIG-GUID: QQixqgw1VCqEqKAy2k8E4UpvMIlh_B16
X-Proofpoint-GUID: QQixqgw1VCqEqKAy2k8E4UpvMIlh_B16
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/6/2023 2:38 AM, Greg KH wrote:
> On Sun, Feb 05, 2023 at 12:17:05PM -0800, Linus Torvalds wrote:
>> On Sun, Feb 5, 2023 at 3:53 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>>> George Kennedy (1):
>>>        vc_screen: move load of struct vc_data pointer in vcs_read() to avoid UAF
>> Hmm.
>>
>> I think the "goto unlock_out" should be a "break". A partial read
>> should return the partial success, not an error.
>>
>> That situation didn't exist when the check was outside the loop, but does now.
>>
>> Now, I don't think this matters for any sane situation, but since I
>> looked at this patch I thought I'd mention it.
> Fair enough, George, can you send a follow-on patch to fix this up?
Hi Greg,

Will send a follow-on patch.

Thanks,
George
>
> thanks,
>
> greg k-h

