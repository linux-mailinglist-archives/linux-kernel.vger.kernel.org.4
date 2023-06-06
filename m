Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715E8724A2E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238743AbjFFR3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238741AbjFFR25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:28:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1DD10F8
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 10:28:55 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 356DDwtB005717;
        Tue, 6 Jun 2023 17:28:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Mcpb/JlyPt8oEkg8Xjb8APUOFuzy1iO3j7eHieH6yKw=;
 b=s57L//6tO6IdmeR3tsePZW3oPB0kdGWGoNrEDosVJdz2EyoYF/gaJpBebnUfpY5f2djh
 +PYyvuw0uhGdocYEEk/bYQVZ0L4j9AlMTk+qXdwKTXAxUTlvEW/22GSAo8nP50FbPO++
 c2+Qw/SdbKK9fMOCuR93CrgjMZPcdO5lSCAaH957PnHldAG406rt6IUBTyjEL2qTUCHp
 xdILpVvvo+kok6FCcTvTbiJuu6YZbDTQH8ktpDVy7zkQyQaOzRBvBNzjAmQDlP35NCvL
 nFIutYSgruQuZHWDP/PQ+0Gg67GYfEBRZWFfbpDaQvU1k5UdMMhFH+ojLhuQzu/T8/UR bQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qyx2wnxfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jun 2023 17:28:24 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 356GTP97001649;
        Tue, 6 Jun 2023 17:28:23 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r0tr0xpbu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jun 2023 17:28:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqDlf7+FoIoL0cvrCGz1DNVFVPu0nyCdDGvpwVVBQkoFD0uwK9leTuLlFtBe+HCJqmmFOhUp6XQwYdcPWrW8wTlL1bxgjDcMtBmn0N/V5WWqIs0pYUAFpfwa2LFbSzrKqw9+N5xJLcKrsUbUIvs/AJEo3ZJVI1WD8PAQ3G/aR6eybou0GpGfvFMpcztqCPOX26ZZRAK845WpxnMTRGQlXZzr6PWbFe1PwUg6hiPiZ43cBIsIbo9YzudJ/jU2N6dPzaRengkiS4X3SBnjdmILyHsev2feilLFXwm9ueawS4UThrqn17CV9eHNB3LciL0bn18EbZSoxh1BgeDO9xWsjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mcpb/JlyPt8oEkg8Xjb8APUOFuzy1iO3j7eHieH6yKw=;
 b=ZCvVDWMj/R9cGrt4i4o8qHkMdfWNTLwkPP3PKKWqQFcutMoTgE/y7VBeQDOBuf0iRciLNa4v26oUQfVVr01TXFuvkDdAI0BXrH5ne1YRBVCSgMdr0RNDZhi8UyeoUxe6IoFA/SuCjrppE+thGaCBVwST0eS2s+rTmXjrmyKYz6gJUHmQ/vcp3h37zAuzC1mWklLkOjVz5T5gmmF4jUzs84xWu1GpFZdLdIujXLIl720R1k57pvcmtCPYyKzqrFMBX/vbnwe6kvXNhZMEHg8rAnHjUdyLyNVSiZ4KKTPYo1RWHJH3U+djeMb7XgO9ic+H7nchlymZQWfAYDl0fyNLqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mcpb/JlyPt8oEkg8Xjb8APUOFuzy1iO3j7eHieH6yKw=;
 b=mQ4YCgZcSS7K3zeHTGq5rEJ+e1Bnwob4HiwjpJ+g7K9+n7wInTQujh2jza4tcR39GH59AxPAyUTQapu94A+fetReKP+8NT+9iE82aOUfluhYm+vnj83aJ8NqONqotyrSCSVO8EAPeTt5ZSAduf8SOb/Qtl26rrMbwfz+5UaQIVE=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CH0PR10MB7462.namprd10.prod.outlook.com (2603:10b6:610:188::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 17:28:16 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5%4]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 17:28:15 +0000
Message-ID: <f7c6308d-e284-db44-1cf5-a0e6f0898e1e@oracle.com>
Date:   Tue, 6 Jun 2023 10:28:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/3] mm/hugetlb: Use a folio in hugetlb_fault()
To:     Peng Zhang <zhangpeng362@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org, mike.kravetz@oracle.com, muchun.song@linux.dev
Cc:     vishal.moola@gmail.com, wangkefeng.wang@huawei.com,
        sunnanyong@huawei.com
References: <20230606062013.2947002-1-zhangpeng362@huawei.com>
 <20230606062013.2947002-4-zhangpeng362@huawei.com>
Content-Language: en-US
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20230606062013.2947002-4-zhangpeng362@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0018.namprd04.prod.outlook.com
 (2603:10b6:a03:217::23) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CH0PR10MB7462:EE_
X-MS-Office365-Filtering-Correlation-Id: 05e730d9-de9f-4a71-1d89-08db66b36964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lcCbG3uIxL9+ncTDCimwJeTCfDOEaVlgWufRhIAW9YYvQBhzmd61fLMm4DaD6+VL713ybV/NwsUiA+8RT8QsXVyGOEk13NIGkayxN4XRRohgBFda2XziH9yReXGZb9TKoQQ6BpIyrNAIo3gwbB/H72E0NUhE6Gf3vrX38D06CnvEBfHsSlvbDl3JxbukBl6JtjZeuXuF+f3C1yUpr5W/G+9Xmc4OpnuoGt0WQFWXi1Va4Q7qz6bCYohePpjaC8dJ9Y5byrn7nqyW25lnAaRWHqcLP9ymfDJjgBbL5cGI25RVl3eQ/uy4KTVA4gVnVQufyIvLDCzSQ7vh9R71LCQ5V32K/7T6+PpSnKHvtMjfVbuskrY1GupZp1xzJsGjfzbjmXhjDMFKLJ6iv6o6EXYDcgLAFvQpepOwF7G9tkgjgsIQkppJhPdq6EIK/jhdqbN6NECD1XsiXPmR+Z/MAxcXhPVgnIRfQpoT2eabXKM21bqflGST7qHUXeih9ydatYt2cbo28QbYxYnq0FzSWosZ+1LbuKXnn2nb3vWIf90Av2OxKKz4BoHSj4Gni1/MmiBPXo1JJ/+neV4rtV4NVHBwSDG3XsF//4rphL4l/x2WWDr1wPLyNwleD0W3mkj5oHXefOHFg/9kOAHQJcfEeFYLIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199021)(26005)(6506007)(53546011)(6512007)(36756003)(83380400001)(31696002)(86362001)(38100700002)(2616005)(186003)(8936002)(41300700001)(44832011)(2906002)(478600001)(66946007)(8676002)(4326008)(316002)(31686004)(5660300002)(6486002)(66476007)(66556008)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzZCWlNHakw5SGRPZm9adkN1VGo5YVFWcnhOeTF3akdXYUFPZ1NRSDN1dldP?=
 =?utf-8?B?TFgya005alpzZ2I1QmxQVjJMNlRpSFJRM084a2kxNlVkeGtvMk9DdUNwbWJX?=
 =?utf-8?B?dnRqc3FmWXlKLzNwTWowWFFmU1kwMlF4QTc1M3pObGRzbWE4Y1JVdXRRVHBX?=
 =?utf-8?B?WEM0eUpERlk3SE1RRXNRUnZneTloclo4Z2FaZnE0YnJRR0RBYnpNcytycmdy?=
 =?utf-8?B?dk5wVkF5RlNNa1FiNEttTDZwcG5zUEhoZVIwRlYrOVBDVTJVcHpNdERBcWxx?=
 =?utf-8?B?RzI4Tmp1SjVlNWxmamJydGI5WWFKRzhQWWlYakpJRVIzSjhDNXJVSlBFV0F5?=
 =?utf-8?B?SzN5UU1Za0t2S203eXFqRGdlbFdFM0xRSFdGOGd0c2xoeERBa1VVVHpuMHhY?=
 =?utf-8?B?UHJXU2d4MTlOQkk0UHB4L2JTYnBJSVhIQTJBdjVYaHdtRkVSekg2UnBsSFBR?=
 =?utf-8?B?Zm5JWURJR0hJRmt3a3MvU3ZiaS9vMFVOZEFoeGhFRlBRQVFtMGd6d2Y4TzNL?=
 =?utf-8?B?YzRuVDNLczFqNWtMZ1lzTEpBN0Z4OHFlVlB6VmpKRGowZGx3cGJWOFVHRE52?=
 =?utf-8?B?UWloNW5CYTRraXc1am1IM1VhZkRZbmFFTC9aM1ZHZ3lXZjBwbm9yV2d3eVlh?=
 =?utf-8?B?dUF4NjE4NVBJTjgzVVFiTW9TZXMyTmdYUm1XRUFyYmhFbjE2Vm1HYzFTanZq?=
 =?utf-8?B?REkxZ1dmNTcrdzJGdk5mZ0xpR2xPcHhiMXNrSmpScTlUbUgrN1QydndnS0ZQ?=
 =?utf-8?B?eEJUNU9rRmlZUlFzMmZNcUJnN3VYMlJRc3k4b1FVMmhOc1pTTnhGZ2xDaDNa?=
 =?utf-8?B?R2FWcEVwMW1xTUxWbWc5SmtBNjZxMS95elpld0RPekp1ZTFURnNtSGUrZ0x4?=
 =?utf-8?B?NjF2T2xxQW5WRnl2RHFEZFU0emlCWDZKbXJsbXJydi93ZDBhWUpSSk4vcjBj?=
 =?utf-8?B?N09Xc2VmVUtEaFoxVTd5ZG43UzhKWnRFNUNaVTR0V1Zkam90M0J6K0dBR0NU?=
 =?utf-8?B?MWg1VEpjMlJydWN0SlZuNG1mNDliaGJKTy83UjB0MU5uRzNQMmNBek5yRUM5?=
 =?utf-8?B?bU9mZnNHUzR4SzlZVlRUNzdIUnBoaEd6OHArZFdoSDQ0dVd4OE1YTHFUYVhH?=
 =?utf-8?B?aTk3ZDJSbWt4S2dTL2xVMU5nejg0SlkzUW1tVDdkcjg5WXVjc0xycFZPTm1C?=
 =?utf-8?B?SndtN2FCMmg4QWRPb28wbmpiT3BGdVZWQnA4bGtiN3Fub2NDNVBwOElLODVO?=
 =?utf-8?B?N2xGbVlHU2MwUkZsS1V3dWFUS1J6QTFKYVVYMlJGdXdBWk1hRi9nSy9ZSW9y?=
 =?utf-8?B?cUdDQWtPWDVXcHI1KzlxMktPcHlMOTJwcjByOFRhOC9obXc1a1Y3TWdOemhT?=
 =?utf-8?B?K0tIQkg5OHk3UmFKNlAxZlBNdExhb1E3bVF2OHhCdjZ2YmhlWUNvZWtZNmVZ?=
 =?utf-8?B?Ti9XRzN2SktlMGRXbW10cG51TnY1eEovME5hdEIwbDZOM3BmdzF1Sm5uZHVx?=
 =?utf-8?B?czRqR2JmU2svNFdER0doTGJ6ZjdiRVovQ3kvTTNQb1VhdEswOExIblhIb3Jt?=
 =?utf-8?B?a1JCUC9oM0pwU3crcmNORGV6azFKajRBQ1R3MmNnNGdoMFZabCtNV1lJVkgy?=
 =?utf-8?B?YUsxcjBJSmY4Wk1pVjJBazl0bU9oRkFiNXN1ZGRUWW9uVFVSNHdpQUVEZUh0?=
 =?utf-8?B?T2N1QVRIWUF4UUFQNW1hNjgzc3pRUkZ0WHE2MnErOG54STE2Uk9yMnNDUW13?=
 =?utf-8?B?bkRtczcvalNTb1N0eUVHdGRpYWh3NVBIL09yY0lmNFl4WTd6cHlEUFlCM2tL?=
 =?utf-8?B?NVhEellKR2kxbGhLbG5JY1lLYm8wRkQ4RHgrRmY3dDExV0RKM3paYSs2R21a?=
 =?utf-8?B?Y2VFS0ZwN09FaGMxdDduWkMwaDU0aGZZc0hNTWtybzdTRFdQNjEyNHlhNk56?=
 =?utf-8?B?Vm41bzNNV05FUEdlakFTbUZDaFk1RlVFaG5SaCtBTjJ2cSs2MkZIcDdXM3dC?=
 =?utf-8?B?SjBSK2JVUnEvWVNLUWliY3RnY0JER05nZFI5cko1SVBQM3lQNThNTXpsV2ts?=
 =?utf-8?B?UmpaYU1ia2JaOXllT0hlNVlUeDVGQ1JWWUNzL1NnUEIyUi9tdmNFMjlVcWh6?=
 =?utf-8?B?eUR0UGROc0NReklsbjZ4c2d1TUFhT2NDZHppUDV3N2pxOU1weTNGZHhsRmZC?=
 =?utf-8?B?N1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bW9xMUdCRGluMS9OdHJ6L29QRTF1bmhCNUwvNXd2STV4OXE0bk9NQnRncmVW?=
 =?utf-8?B?QUZvZWNkQ3RxUXoxdXhrb1p2S1l0blgvRWlaTFlhNTNjRVFiZE90TFFYTWR6?=
 =?utf-8?B?VFRadlVrWTdUa2pqQTlFMldZMHdQazN3VlE2NjM0UWJ5bGo0UGU5RVdWS1Rs?=
 =?utf-8?B?ZzJ5QVQ5NDIxTlFhTExhaXVXbVY3SGkwamtuUVovK09YV0ZTTFpTdVdpa1d5?=
 =?utf-8?B?Z3hPNE5FOGtncVNUZUM3TnM0Q0VFdGNsQlJHN0ZYL0FONXltT1E3ZDlZcmE0?=
 =?utf-8?B?SVA2R0IyMEk4STNyTklCZTZ0anpyN0g5UEY3WFljUFQzV00wb0RUL2xwT2d0?=
 =?utf-8?B?cEhKUFN1YWtScjRkb0ZHamRqUmNrSXlPdGQzZTBUV3pxMWRpL045bXFUNFJs?=
 =?utf-8?B?dXRZV2QzL2M0Z1lyTmdxT1lMNm9ZYUxwYzlsRUJmZTJTTzZtMzhVWlowUVBD?=
 =?utf-8?B?WS9Yb2Q4NE8rSzRGT3hzREh6NmEvMVlZaGd1dEdiSXpBWE5xZk9BN2pySmZM?=
 =?utf-8?B?bzREQmNlQndNYXRUOGlVdmxxRnI5R1NkalV5VmZla2dmREpLcW5GOVNWc1VY?=
 =?utf-8?B?SDV2OUtLRUtXQWtDVWtVa2trWVJLa3BjQWFsbjhWYWpaSjd2OXBNWFdXbzVw?=
 =?utf-8?B?VHpCQU5zK0pobC85SnJnOVJmRDR0WTBMMmQxVlE5YVdvNHBPVGtEQ3JYZHVs?=
 =?utf-8?B?N3lQeGxZMjVGU0oxNHZNWS9OS0lzT3RkM0ZyNUVQVWhOSUhLNFJhQzZMOVpk?=
 =?utf-8?B?MXE2QzhqYVhXYU1HMS9DR2FUdW9qTGNwWEZkamNXMis3TElaMjhvNkVQK0pq?=
 =?utf-8?B?TGtxMXJoUzRodE1tZ1RMVWNqa3o2QTEzMlJMaUgzZ3E1YVd5eStUcStZdnBP?=
 =?utf-8?B?aDFSdnRMYnlNRUNqb2FBRitzcFI5WmJkSVR4T1c0dEdISm5oUGhMRXhMdHo0?=
 =?utf-8?B?NTVZWUFKTnNoNTJNc3RVUkJxNHpWNXZKWFRsWkI1d2Y1WGRjMnplUnFpNXYx?=
 =?utf-8?B?ZnVLcmtMNU5XTGhhUnh6MFNXeWNQeUhVU0ZoVXRTcDYyUFVJK1VReTVla2ls?=
 =?utf-8?B?WFNRbXpTbStCVGphaFVhdXdJaEw4b0NUWjVQbFlsWmp0a2daRStZUkJ4YmY0?=
 =?utf-8?B?U2JsYzBhZkdUYzZYMGt2VWZ6ckJ0c2VLaXdGemdGaXJwMGxZKytPS1ZnNU13?=
 =?utf-8?B?aWpEZFhNRlRCRTVHNVltbU5JQzgxRUZEbGtpVUQyZUtnZTd0b0ZJMXpVYjZ3?=
 =?utf-8?B?djRmdnNoOE5uUGp0RHdaN1hjb0NDbzVsYmhKaXhPaWRzR1l5dz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05e730d9-de9f-4a71-1d89-08db66b36964
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 17:28:15.9074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KW/cYUVfbCOHhJGQzPa/yOn0BDVSCiVuJHNE2e8QG7z/7kmpwQAWk48qOvUEHGgRWuWGJPePH+rgHbvTH6BqdQVJ5n29RYjzeQfett4MJ7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7462
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_12,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306060151
X-Proofpoint-GUID: 3kYejfj_YYyILl4huQwmM9otGqNOUJ4J
X-Proofpoint-ORIG-GUID: 3kYejfj_YYyILl4huQwmM9otGqNOUJ4J
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/23 11:20 PM, Peng Zhang wrote:
> From: ZhangPeng <zhangpeng362@huawei.com>
> 
> We can replace seven implicit calls to compound_head() with one by using
> folio.
> 
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> ---
>   mm/hugetlb.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index e58f8001fd92..e34329e25abe 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6062,7 +6062,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>   	vm_fault_t ret;
>   	u32 hash;
>   	pgoff_t idx;
> -	struct page *page = NULL;
> +	struct folio *folio = NULL;
>   	struct folio *pagecache_folio = NULL;
>   	struct hstate *h = hstate_vma(vma);
>   	struct address_space *mapping;
> @@ -6181,14 +6181,14 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>   	 * pagecache_folio, so here we need take the former one
>   	 * when page != pagecache_folio or !pagecache_folio.
>   	 */

This comment should also be updated as page is no longer a variable in 
this function.

> -	page = pte_page(entry);
> -	if (page_folio(page) != pagecache_folio)
> -		if (!trylock_page(page)) {
> +	folio = page_folio(pte_page(entry));
> +	if (folio != pagecache_folio)
> +		if (!folio_trylock(folio)) {
>   			need_wait_lock = 1;
>   			goto out_ptl;
>   		}
>   
> -	get_page(page);
> +	folio_get(folio);
>   
>   	if (flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) {
>   		if (!huge_pte_write(entry)) {
> @@ -6204,9 +6204,9 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>   						flags & FAULT_FLAG_WRITE))
>   		update_mmu_cache(vma, haddr, ptep);
>   out_put_page:
> -	if (page_folio(page) != pagecache_folio)
> -		unlock_page(page);
> -	put_page(page);
> +	if (folio != pagecache_folio)
> +		folio_unlock(folio);
> +	folio_put(folio);
>   out_ptl:
>   	spin_unlock(ptl);
>   
> @@ -6225,7 +6225,7 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>   	 * here without taking refcount.
>   	 */
>   	if (need_wait_lock)
> -		wait_on_page_locked(page);
> +		folio_wait_locked(folio);
>   	return ret;
>   }
>   

Besides updating the comment.
Reviewed-by Sidhartha Kumar <sidhartha.kumar@oracle.com>
