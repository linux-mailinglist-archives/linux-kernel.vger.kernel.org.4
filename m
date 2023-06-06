Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D795B724860
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 17:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237380AbjFFP6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 11:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237960AbjFFP6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:58:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089DF10F0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 08:58:06 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 356DE449027032;
        Tue, 6 Jun 2023 15:57:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=gvGMU2MI3Wu3SZEDCZzS8/X3XX/f3Ki/khHAgpW9VNA=;
 b=JUBXiC812VmCGvMaArlCU1i1Uia568piisgCAbqkeXimfcT7BGNR+DxtI4632LbBSLkD
 Zk5ilsoECbkOzncNBGZiUERbP/pQsHqGBILQa5cm9H9u+mP99WkLTB1T/bPOQ1bFXwU4
 Zy5EUl7mnjHf3Zk5ytfL4LVsPKl8x7jrLp7tjhKD2u/nek0vhQ+bqiAnv6h9MpEgnJ0C
 5AnXVGWmiUjCNnEK4RtcHMPASgWK6wRulP3jJVFJBKJ2EBxFWCViQh/HkjG/vhm6xJji
 BsAhSXaLgWHN3iCZTjBR29C6R7//eeQp4prQLvv2qARyidy1kPxxOoKHUkCvcIuIP7d2 +g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qyxh9nnst-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jun 2023 15:57:51 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 356F3eEq024105;
        Tue, 6 Jun 2023 15:57:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r0tkhb9ts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jun 2023 15:57:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czH3vDzrOl6jqvG9Dye6EZvL0+zLO0899muAZqpFGGlk1zP/2vfbudlzJb8tHL3leDAQN/j6HWceNk0VlcikP3zQ0oQb+toqWBK3ba1o+oH638Uv42s1/NPwEIfR4W1vJjqGcDIJ1xSw35MHwbGY8Motj2lGiZK4MEBgyNCRfVaDwwaE0fkLGj9pBJNRW4j6hGsIcYUjAOtHxKfovX0M6cH6J3MrQ68KThn7NBkiLQR194lAf3yJQNEnfC5OHWkJPMWnZhh8WRRS+rAR3zKJX9ugCk4Wb3zDQ8Sm+/BgBFTZfUtjaYps/vzN//T33S6th9Z9CuHc6GLodMNp8VnK7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvGMU2MI3Wu3SZEDCZzS8/X3XX/f3Ki/khHAgpW9VNA=;
 b=ETawhsWqfz8F0i5w2uVpJkkwSNaziacvNxRLdRzGC7Pam6oZFC+CiGOkR3SOY6S9qfu5RjIo59sYsujy66KlsLjv3QQvOyUsuQGik2JzCXeRN1Nhj+W96+TX+tnQ70XE/S9nwazWwiYF96KqcqG1l2KRitwDyt67DtAvqIaBVBUm3IgzkhFd3AXtHi+GhzpdX1h2Q3ebv00jG+1dvXaJ79I6VNnH8Nm+5DW7ENRifeWxKLOHdhN9UwkN96qfRThwcy4ZORTwQZp4GN1GDS8YfAcrtBEvBBSn8nr0VLo8wH7bBe9Y8bjEJybN7u1D9NEzqfBwFouHZoTEW5cCLhQ6Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvGMU2MI3Wu3SZEDCZzS8/X3XX/f3Ki/khHAgpW9VNA=;
 b=kDV2FbtsSoZtLBnxOg0lmQCwrIJn9fnPoobIkFwoSGLHfHGB+1Q2Hyt2kWXXWN5ePkFMH6ux/PPjsj6P/jA/hCaAhO5+jJTFfLjpUsJlQ9IzfYKzzdcyvDZr9pmNhWx2ClmwjghN+WUzgcZrGWl9m8HLKmc8lmqav09CFNA1/tM=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CH0PR10MB5019.namprd10.prod.outlook.com (2603:10b6:610:c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 15:57:48 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 15:57:48 +0000
Message-ID: <39f5913c-e658-e476-0378-62236bb4ed49@oracle.com>
Date:   Tue, 6 Jun 2023 10:57:46 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [CFT][PATCH v3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>, linux@leemhuis.info,
        nicolas.dichtel@6wind.com, axboe@kernel.dk,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
References: <20230601183232.8384-1-michael.christie@oracle.com>
 <20230602192254.GD555@redhat.com>
 <87r0qt18qq.fsf_-_@email.froward.int.ebiederm.org>
 <ae250076-7d55-c407-1066-86b37014c69c@oracle.com>
 <20230605151037.GE32275@redhat.com>
 <03c07f48-8922-f563-560c-f0d4cc3e1279@oracle.com>
 <20230606121643.GD7542@redhat.com>
Content-Language: en-US
From:   Mike Christie <michael.christie@oracle.com>
In-Reply-To: <20230606121643.GD7542@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR10CA0030.namprd10.prod.outlook.com
 (2603:10b6:5:60::43) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CH0PR10MB5019:EE_
X-MS-Office365-Filtering-Correlation-Id: 17d66576-13c4-40a1-2da5-08db66a6c668
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KdNsJ9C65wL8b1PrwM9dVUOu5zeS3SKVm7093psGrIREvIO0xH2OkltVVkYrBEJx9pn4pcFFl054wiTUkf7VkdWVdN2R0//XdJfSY2sYjsWr79wSlUutLZ08vqKK7PrYGflVlDH7XhLy75nPN5KpStaVvlNQwRARJtCALpRCLFOFr60BWMoUK36CpkGMZHqprI41THILp/ZvaXx0HXHXm2z7cpjNQnOw033Yi8a16fsPMaHhdiWcDQzxvGg3QHgdvCYS1dwOfc28FjUs+e9Fy3CHqVEIb5a3hrbCOH4276tLXWRmPYiEGn+7o6fXYvC+Y7PgpDJvnKV8V193H4v05Jdpt7dnVMtS7LencPbrzkEudauvJuNbsvA/ipJEjRnQkUIyro5ldNJdFYUdorOl9dI5gpGdIN0bFSffWyFckCeMcMHAJnOwEcosUK2UoBZENxHeGXAMP2kognYdu5f4AhsfkEXiVD1Flcn2sR+UIveZVGPh9FHghrbk2seIefS9JKOZ1akk84MMXc/cZS4omBf9VzO3uOOPOZO8rPZDjRbkpK9FztKSW8ZfWPzpdSOBMHwhWxL31QD/Dy5z4RnRqc4NgryA2Ooi+iZcqa8VQTrqYkKRKt5gVZWAoLRrgD/a2V278tda1MmNkqVCoWZ5gw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(136003)(39860400002)(346002)(376002)(451199021)(478600001)(2906002)(6486002)(966005)(36756003)(83380400001)(2616005)(53546011)(86362001)(6506007)(26005)(31696002)(186003)(38100700002)(6512007)(5660300002)(31686004)(316002)(7416002)(8676002)(8936002)(66946007)(66556008)(4326008)(66476007)(6916009)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnRQZXNpUDRmT1IwOS9IanpUbkhUcGlkT3B0andnK0tZb01TdVk3SEFVSHhv?=
 =?utf-8?B?bGhxMEg3RTk1S0ovQmF1MTRoeElLT0wrekU2SlZKa0NqVUlCMlhjSGdrYTJ0?=
 =?utf-8?B?NmFGUnMxenRPMmtUTXVQOEozU29ZSEdWRDB3dW92N09odjhIWldXdU1QU0dX?=
 =?utf-8?B?Z0ZzQWtLa1VnSDNDQ3lBT25HMHhpVGtCZ29LNVdTZzVJdDdFcnNzTnVZSmRC?=
 =?utf-8?B?ZGpiMjkyQnRZZTNJYkVuVGEzeXA0M3ZTYkIwZytlOHVndjh5cDJWL3BOM2lT?=
 =?utf-8?B?bDBKc0Y2Zm1HNS9IcDFrSGtsQlFIS2pBTERKV3NUT2d1U0ZTS1N2cTdPVkxC?=
 =?utf-8?B?dlcvRjM0UDEyOUZDSU5uNmFKcytpaVdRUjgvNU9XTjhFU2dnY0JIcVFIMnRa?=
 =?utf-8?B?RHlTV1RXV0lEUGFyWFVHT21PU0pteW1haGc3WVNELy92NW5jbk9jakhZT3Fa?=
 =?utf-8?B?alJTYzBLa05CRlkyQ29ldDJsM0svWnRUSFdXY3ovbGQ3L0FBY3VGblVTL1U0?=
 =?utf-8?B?NmFaSlJ0NDJCdjExMFhaK0x3Mlk4VWN1elZ0dVcxOGg3MTRFZFJMajFNS1Uw?=
 =?utf-8?B?YXNLei9yM0IwTkhXZUl4Qi9pUlpVakExTEhSVklBVmlJY2tKN2xJRTdTcnVn?=
 =?utf-8?B?dmJWcCtnamNiU05YTmNzYWFvaGVGZjFQS0pEL01PbEU1RWhucEdBSnFVRHBG?=
 =?utf-8?B?Vkkvd3BMNFI4Q2lwMjN3clVsNnROTUV6RE1UWjBOWTd2L20yNGEybzlObW5M?=
 =?utf-8?B?SUlMVURKQUJsemlhUHZxZzhUMmlzVllXY1RlUjVqK3IwUmdEOUU0Vms5YkRC?=
 =?utf-8?B?dXIrcm1sNk9vZm5NQW5vTmtMS3YxaW1uMTRLbTdMeVZ4T3l2TkhnbnpEQ082?=
 =?utf-8?B?aHV6ZWpNaXNrL3ZBMUFjTlNoUnVQY1B5L3RpRmh4WlcxWllDcTFaZE83RVFw?=
 =?utf-8?B?aHoyZEVueTZIYUgvVjZOREl0dmxyWEpQZGVIdmpCTlA3RmxnOVV2NTJSS3Jn?=
 =?utf-8?B?Y2EwWlU1UmhidUFleHJ4Q0M0ZXQ0REUzY3pPcnRpNTF4UlJxYnp1ZzRjSnl1?=
 =?utf-8?B?YmRvR1NOQzkrWmJCTCtqSjRXMHUwQjZMMFlUWWlPaGYvVXp6bW5JaTh2WVM5?=
 =?utf-8?B?L1VPbGFKNm81L2FhY0NGVkFNVUpuSGhMbWc3UitEV211aU9HOGFJbTAyK3Fw?=
 =?utf-8?B?UjE2MVJiY3hpNjVnbXkvRWI4emUvZUxIMHRtR1lZeG9BT1ArUFE0R0FsbHBY?=
 =?utf-8?B?aDJib3YzK1UwNFUxdGFDaVlOV3l5RjV6ZVNHeGFqYUZQMHhCY0RYalFkV1Fa?=
 =?utf-8?B?NDhQYXcvRVNmWTZMUnZtZGM5UmRxSm9pdFR6b3NzRGhrUEdoKzhDQXhucXIy?=
 =?utf-8?B?SWNQL3RUS0ZMcGFSY1Q2VklLbXVuNlhlbG5SZlFGWnN0bE5HbExTTm8zN1R2?=
 =?utf-8?B?LzlIS0tPRU1PLy92U0tFWHZYOWgwQ0xVcEc2RkxwQWlqelJPbk1JT2I2UVNr?=
 =?utf-8?B?UXIrZFFhVWNidjI5Vm9lT3dBSldmWUlYVjVFcWxrRHFvcXpXRmRUMFFYY3FB?=
 =?utf-8?B?cjIwZVBUMnVUc2toUHpSNThjUFRpeDM2WDJTWHhYbVdySW1Xcy9sT3VKNjlB?=
 =?utf-8?B?NmNjeGRVWkhsdk1vQVNNVGNmR0dxNjd5S2JUNlNqQnQrRDBBcW8xYnpnWVM0?=
 =?utf-8?B?LzA5eWpscTFTZzF0QjB2bmV2N2IrdmRJVm9uY2duVUMvNExlMFBtZ01QVGh0?=
 =?utf-8?B?bURsM1V6bkg0ZE5LWE05eWNDNDVrcnpOaEJHWlM1bmtzYkQ3UjFLdFFHV0Zx?=
 =?utf-8?B?aUNrbGtTajdkbTdXRXp0UStwWjc3REdQcElJemhMdGZBWDR4WmFVOThEWTJ1?=
 =?utf-8?B?Um54VVZrdWZhaFlJeGQ1Z1prTE15czhHdE9oQnlvMTUvbWhrcFNSSVZhb1B5?=
 =?utf-8?B?dEVUek9TSzRoUzhFOEJNMEFIQkNYSk9SWkdtbVpxdWtXMkFIanR2L1ZMelVh?=
 =?utf-8?B?TUJaNXVqMjBBTC82d0phV2FuWnBmaktoQWZNK1JvYjY1MDByODRGRjRXSjR5?=
 =?utf-8?B?azgwMmRidE8xdHQ1SE03SjEwWUsySFFJbjgyZFdKaTNjdWk3OFNINWU4SThF?=
 =?utf-8?B?bVR5WWZVRlJ4MVhLanMzVmdKN0xObFZvaStaUFVVM05ReHp4OHA1Uk84NXNw?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZW12bEl3NEExZUpsUHg1UG91LzhFbGFHZlNzNVZPYnBOeENuVGdDMGJ4UjA3?=
 =?utf-8?B?c2FoRmJpTktmZjV5dXp0QTRPdWVGb2pFTENYT2pxSElBMDBuUzJQSFord2l5?=
 =?utf-8?B?NEo0SXJFaHgyeU91SkdLTEcxSTZQaTZSTUkvUGNPZXBSSzN4MzM1a25WZWlw?=
 =?utf-8?B?anZGVlBWSkRHQ2pzcGp4eDFwcXRKN0pDY3NlcVBJT0tpRytxTkM4VnNDZkNN?=
 =?utf-8?B?REtJeGdldG0xZjJNa2hGbmdpQ29vRmJjWTQwUWtYRjlUVWhhZGYzS3FnMGJw?=
 =?utf-8?B?NDRQUVhYYzhwMUZTRXBpSFFRa211dm5hRHpHcFROeTliY0JOSWl4WnJWWHVu?=
 =?utf-8?B?OEVVSmNPQ3JXVjV5ZncyMmhoc0daNzgxcVFIQ1ZwT2R2djBFWHZ4QnlWeSt1?=
 =?utf-8?B?ekFJTUJrcHVsbnVTR3dzMHF0RlhDYXE2NkMvWG9HWEdYYWVRRzQ2aEVNU3RJ?=
 =?utf-8?B?c0NrUW4zOW1jRGZDMU45aDMyOFNCb2lncmNNMjZNRUYrTDlaU3psYm9NUFdW?=
 =?utf-8?B?d3B4d3dRZFRRYTlLSTFraEgxamFSdjNFTlZ1OUF5VDNmK0tYQkRIZ3grUXZ2?=
 =?utf-8?B?R2VRVUxtQjhaL2NxVWZOV3Fhbm8vak9DZ21vL1lWeFNGTXk4TkZQTXNjK3dr?=
 =?utf-8?B?NmZtYnNCTlF5S2Z3T09Ua1JaZkRRNklyOFBzZk1zbWlIRll0TXBlYVNLMGt3?=
 =?utf-8?B?Wld6MWFCSERjZXVaU0k4bjIybVhLUzBoL1BBT3NFK0pDVFdoZkU5MlBOcitH?=
 =?utf-8?B?ZU1Gd255bk5welM0S3V1bUpFeU05QVMvdWFzdEpzVFExSklsdXkxNk5xbitr?=
 =?utf-8?B?UHBMY1V2UjNXYjdMZExxOEpDVjZ3bWl1SCsvc285b3hTamFvZldnVzRUM1Fp?=
 =?utf-8?B?R3c4dFZjTTVZU01hZnIxZmczc2lSeGlvMnVMNThXODFxVGhLNUdTejB0VExZ?=
 =?utf-8?B?YnQramJMWVloanl3RmV0M2FsbXliQnA3NlMxTlR3S2xWODdFMW9VVjFZRjBP?=
 =?utf-8?B?WFpXSG5aRkNqaU5CZGprNmltdlc1V3pOeExCVXkvWUNpS3NtbysvQlc2U241?=
 =?utf-8?B?TXo1MkFvdFJvYTlGR3pKdVh4eDNtMUZHMXFZMHBBcVlvdEZsNlBSa1JSTEJL?=
 =?utf-8?B?citMTnYyU3c4djlULzNpbjk0dkFNdFZpQ0JFeTU0ZGJjV0NjVStTZW5HZERI?=
 =?utf-8?B?TzZKZ3RZM0pVTlZzczZLS1RhcEhhbnZ3MjMyandkNm8zN1BYUitQZEx4UGty?=
 =?utf-8?B?dzZ3bmQyZkpGQllEY3F3ZmRteUFWVUNlTGtGamVTdDQxY3J0cUZacG9GTWZw?=
 =?utf-8?B?ZWd6a3ptZ3ZETzZTUDhiRHBBUGMrRFZYc2FvTDl0eTBGYy9NbmdqdzdTNmFs?=
 =?utf-8?B?TXUzTmFzVDJ0d0JTSThiWGlnRlBkU1J0cEl3M1ZtWCtscENPdVNyazNyYTdK?=
 =?utf-8?Q?9/OJ1G2l?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d66576-13c4-40a1-2da5-08db66a6c668
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 15:57:48.4004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ro/s/RgPSAGs3u/mPugp6zvzqhrVxHOoejM26Mw+ZkHnyCTi0FwnUujpaZqiViy44Up5JlDWfkPqRTQkipqIQ8ebmHYKZWc56b9KsCwXD2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5019
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_11,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxlogscore=992 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306060136
X-Proofpoint-ORIG-GUID: Dq7MiarnG1K0T6nea3W6ZbxnkCJ83tha
X-Proofpoint-GUID: Dq7MiarnG1K0T6nea3W6ZbxnkCJ83tha
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/23 7:16 AM, Oleg Nesterov wrote:
> On 06/05, Mike Christie wrote:
>>
>> On 6/5/23 10:10 AM, Oleg Nesterov wrote:
>>> On 06/03, michael.christie@oracle.com wrote:
>>>>
>>>> On 6/2/23 11:15 PM, Eric W. Biederman wrote:
>>>> The problem is that as part of the flush the drivers/vhost/scsi.c code
>>>> will wait for outstanding commands, because we can't free the device and
>>>> it's resources before the commands complete or we will hit the accessing
>>>> freed memory bug.
>>>
>>> ignoring send-fd/clone issues, can we assume that the final fput/release
>>> should always come from vhost_worker's sub-thread (which shares mm/etc) ?
>>
>> I think I'm misunderstanding the sub-thread term.
>>
>> - Is it the task_struct's context that we did the
>> kernel/vhost_taskc.c:vhost_task_create() from? Below it would be the
>> thread we did VHOST_SET_OWNER from.
> 
> Yes,
> 
>> So it works like if we were using a kthread still:
>>
>> 1. Userapce thread0 opens /dev/vhost-$something.
>> 2. thread0 does VHOST_SET_OWNER ioctl. This calls vhost_task_create() to
>> create the task_struct which runs the vhost_worker() function which handles
>> the work->fns.
>> 3. If userspace now does a SIGKILL or just exits without doing a close() on
>> /dev/vhost-$something, then when thread0 does exit_files() that will do the
>> fput that does vhost-$something's file_operations->release.
> 
> So, at least in this simple case vhost_worker() can just exit after SIGKILL,
> and thread0 can flush the outstanding commands when it calls vhost_dev_flush()
> rather than wait for vhost_worker().
> 
> Right?

With the current code, the answer is no. We would hang like I mentioned here:

https://lore.kernel.org/lkml/ae250076-7d55-c407-1066-86b37014c69c@oracle.com/

We need to add code like I mentioned in that reply because we don't have a
way to call into the layers below us to flush those commands. We need more
like an abort and don't call back into us type of operation. Or, I'm just trying
to add a check where we detect what happened then instead of trying to use
the vhost_task we try to complete in the context the lower level completes us
in.
