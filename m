Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 028CB74F356
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbjGKPZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbjGKPY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:24:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27929E;
        Tue, 11 Jul 2023 08:24:52 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36B8Ksww004918;
        Tue, 11 Jul 2023 15:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=yiW0NGPykK6XKFexB1A5ZHp+4hjbupsZB5o3eqZt6j8=;
 b=CIwnUROJUD0Vy0dDj2OcJ+PppVlrOvrOWeVf4WA9T2indzK4th2wA4y67xq99AW9tyY2
 DxHwG27XItfNsYo1KaLWpnB54Ig1/5CRsx7jUAsD80ibb1N0pTyJxaMSDiaC9XDKK33z
 BLryMwG+9f1Z9j+wgBM1iyZNlbbkQZZPGj3KdoOUJ1aOIhkT/chw6bYe5LupKM64wIGd
 WJ82kUDYfehKPLLvvdf79zSGZTPzd144vDTjSs58IMKhFZ8XKRAG9UfWei0tpzNDeos+
 oy+bROkgzpgAEzXdTkx8qZLy08kgxY2uwHiTbCTbnl4H93V324Sw+kDme5dpy3KXLFhl cg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rr5h13qtp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 15:24:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36BF4Tln026913;
        Tue, 11 Jul 2023 15:24:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx851esu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jul 2023 15:24:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNQ5HPeW8PDInBC3z2FZ7Ql37Ih/3cSHF5is5goZhBVY+lK7rB1svGDvCsiHhaTMkKmfSmSD7OULox8cZGPeER64QxXjAbtE94jQ9lgfB89h/lAfemzak+qYFua3fuGoDaqYLxsbR2C2+r5NVb8+nLIKoh7JYB55fEFaLIOU8CSg+fP2VWuQwSbm6j3btdE1b8SY+z3WllweS0X9ptMHl9HXs9ghAAI2hNZgiyywL6EtaYqhgvoqIPZV/wJIn+Dmdfl78mzVpOGrpNRprSZvIb9VjYzeEqHvTpnO+uA7ERc411Q4Y1n2/6P+vT2Sop+jCbL9uqayjhp7PY179EtJlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yiW0NGPykK6XKFexB1A5ZHp+4hjbupsZB5o3eqZt6j8=;
 b=dbBg1QVoV84D60GYBXr12LA+4LO2i/UipPJIEiVjgckUUf4oHqbwTBBhRMDNB2QQCYk55BNiu88f4Yc+X7ARbAC78KVT7ORTJ9EbGGMdpFdHayv5ZJJej5jopkWgTswh0a+LiJSHRNt8r9hjy6n7tSJbBFCN6ERLWN/yG3gBfNHuEnN5Cq/w4+0js9AVFYPhtLJlmgqROqMEApiplkKTx0tQ5aXs2lz/aOohC1Ii4bSD4ro1iJsKo3ucmQlLY1KyE0/hdGzAQlx88VAzY8cHcEnhJNs5EAhGXaHTreUSXx68WIF+Qr0KbHiGzh2syQFvFyaXeqgCTmTUM2k5EHaz3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yiW0NGPykK6XKFexB1A5ZHp+4hjbupsZB5o3eqZt6j8=;
 b=YEQ4iOaGYsCXkc3uXHsXHKVJlBUYG3V2k3YAMGwOTWkuPlpOVo42WokvARMzbXsP6mVwhw4Qp++qsUJ1DILOpKZHahpbmi4CL3J1k3G/GNv0xrV7pXbM53qbUlHrGCJ5zPHvUKTX8pJ0HnkQUdevX9kmkPhadZfzYevxdp8nrBs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB4905.namprd10.prod.outlook.com (2603:10b6:610:ca::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Tue, 11 Jul
 2023 15:24:27 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6565.028; Tue, 11 Jul 2023
 15:24:27 +0000
Message-ID: <cd5814af-8ab0-6ab9-9b3c-b5081e54f199@oracle.com>
Date:   Tue, 11 Jul 2023 16:24:22 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 0/3] perf list: Remove duplicate PMUs
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230711055859.1242497-1-irogers@google.com>
 <182675ca-0905-0ed2-de94-0f7d4a256082@oracle.com>
 <CAP-5=fXrOvkwrbEB0GGv6Xr5JOdrW7dzjOL=MkDdxX2McfnzYA@mail.gmail.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAP-5=fXrOvkwrbEB0GGv6Xr5JOdrW7dzjOL=MkDdxX2McfnzYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P250CA0017.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB4905:EE_
X-MS-Office365-Filtering-Correlation-Id: e70a723e-8321-4b05-253d-08db8222ea4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: klxJpGtkSZtdLIJGDe8t4bTIe21gmE8CxFUShyBPvGghHof86ejEWBtgMRoEias++dnmT5ffGK0+MqsaTVKjFUJ3cD0ib/rryGxNgNIwhTbmnLPkB37+9QjRE39veW6mmWFJ3abPAFd/HA5HOp3nOElVnNkUNuEn8OaP8T2yjNnjtRdHiB+cFp1P9+SXlVWRaRWY2TWJj2pQC2PYhjGUcqAWQLVlMVvKvucFoaYYfHtCWQFpdNLQ/Mie8YPRXlZacrOnhn4d0eNPtiqPAe6Xeyo6oJx40tMf0qqnAP+bByyhIqq/qwb1/OkIGPseGGs82eCk0G3b+lFGoUQllIfR3rSzqdoI8v0YrBNxgg77lrNK6eLdXO0X+txllvOYTjQD+6bA+Sve7DY3DoxT4rlcgn+Ql1JwJc4SMAXXh/ScQheKIEqGJTrsgdcW8HHydvaHXSdmQOq+Q0D6keDrHDdHIkrJPWG2ZQ+4jyAckl8DDhJE2Snj2icbuRyadEqrzk/RbG/kNog1syKZOHjAf031+m+sZ+E7JyZEMyMvVx4plWkJQ3c4/B5LeBpvJXUogHpoLNPVjGp8qahbkT5tmbFkkv03+4onfBcSR4TMaSzQbOj3Cgj/8ZRmIoMbZZ9BrZaBrpwkm+zbGMIPycTxcjknjgaH/4SL0SRBZC3fDjhlhI8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199021)(36756003)(86362001)(31696002)(38100700002)(478600001)(6666004)(54906003)(36916002)(6486002)(966005)(6512007)(8676002)(316002)(7416002)(5660300002)(2906002)(6916009)(4326008)(66476007)(66556008)(66946007)(31686004)(41300700001)(8936002)(2616005)(26005)(6506007)(186003)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N1JNc1BUS1dwU1VWZTV2ZndmWmx4OWVEUElMR2dDOGRKZDhscGJyNW5BRFlt?=
 =?utf-8?B?VEtEblBqK0VSNzlEMkJEUkMzcG4zRVVCaEhhQjU3bTFSQUxpa3liSFlEWGxP?=
 =?utf-8?B?OUVBeHVad3E5enRHUC9JWGZKa2dObHc0NFpXbk0xN0tWTVBHVVh5b2tPTFho?=
 =?utf-8?B?SXNhbDZPR05TUXBUZXl6RjYvbGFEcTlzczZMZXRaV0VacjRPUlc1WHNRU3px?=
 =?utf-8?B?UmxJT0FNeklVREswL0FwdnZhRWl0dFpoMkRkSDlVKzdOMUd5bFUxcnJKTFBl?=
 =?utf-8?B?OWpocDhlSkdWTG9QSkN1Lzd1VllBdjF0YmVCb2J1V2E4V3B5OUdHNXAvenpN?=
 =?utf-8?B?SzZXakRpMGEwQlFYa1REQUVTTUMrajBoU1huNDBYUWhTbTFkSUcvRytvVDhv?=
 =?utf-8?B?L015WVdENTAyaUx5R1BPSzRaWXdJcFMxNm5jczIxTGhmU2JoeUZuei9rZGk1?=
 =?utf-8?B?cjhhVFg1KzQ5aWg2UUtQTkZTU1gwUE1wU3dQeTZBS1dsWDZ4c2JSSk1IL3d0?=
 =?utf-8?B?YzkxL000WHE1NXorT0ZvUk9qbGJwU3VaNkl5R2NKRVZsYnVQa1ZWaVBYb0FJ?=
 =?utf-8?B?d1JsQ0c5OEVmT2dXSHFRQ2JvcjJjVmIyalBDcGVTSk5JcGZpMExPOThQb3VH?=
 =?utf-8?B?VnBWbzJUYSszdWRoNFRQdm5qMzFtdHBCalJQcGx6dFpqbFpIeEtSRldFT3cv?=
 =?utf-8?B?U2NZMVFTUVlLd3B0bEc4LzhZWDd3Vjl6REFZdE56Z3gybmhBQnBhVDBOWmhC?=
 =?utf-8?B?VS9CdFNKcmRwUHVFRkNkSW9OMVYxM2tnYk9FZnNhaUNMa3ZyeHhyaHRwQTlx?=
 =?utf-8?B?SHNtM09ZZUcyNDdZWWxKT2ZwZllVOGxpc0FMWDBGWVR0YVlQTGhaWVJpR3Iw?=
 =?utf-8?B?REN1MHpWcnlzNlJqNjhiUHI5SENMdFQvb1FBU1lGVEdCUEFkeSszN1M4dHpQ?=
 =?utf-8?B?N1RkbnR0S1FHOGEwTTZvLzVuWG51dSt5Vys5cmI2YkI1YTVIek9KRS9ha0Nw?=
 =?utf-8?B?NHFLaTJ6Rm9PMDRTODhrQ01IcFF3ZG9sTWxrR094UloraTVqbGFPZGxsQ0xx?=
 =?utf-8?B?aEYwQ2NxTEtCNTBIemdWSW5nVmtVNTlVcFlZSC9obXE3VDBwSCtJM0dTeHlH?=
 =?utf-8?B?NmhaMnNpKzJ3ZktCZllKN3ZGRUFiSW4wMEFzU1kxVFlDcWdrbkVQYVNyTzc3?=
 =?utf-8?B?QWU2dGJBR3JxQXFNVk96VFAwMTMvZU5zYko5aVJ4VHhuWjhUbWlyayt2WUV6?=
 =?utf-8?B?R0Y5UFV3V2V2OW5BZEVnMm5PSEJuM1BhM1Q1MUFzYmQreEVpS21jL2dpZ2tH?=
 =?utf-8?B?T3FHbnZIVEVvWElXK0pzVHkwa0F2aGs5RzhURUdtWDFzUVFteDdZcThuVmJo?=
 =?utf-8?B?a0NCRXVJMEE4Z0RpYnc1M1hNZUt1VlhOaDVSVlpZT3Jmd1c0RzgvdjZNajZY?=
 =?utf-8?B?U0cwWW1WWDZSMGZWeStZbC9QQzZnYzdkMmcwa01Telp5ckhlNmVrRzEwZFA1?=
 =?utf-8?B?UWNzcitwbWVpanpTQ1RsazMwSDF2MVJnL1J0MlByN1JlS01oZ2NHRDQ0dkd1?=
 =?utf-8?B?YkJPM1dpZzJadERIK0ZMVm03QU1qRTkxZmRzTGNtc0JZM25BTlJKMXpXNWtF?=
 =?utf-8?B?eTNGUE9FR3lRTTlPWGJ2MzZ1R2tYRW0rck9PNitwbG9KTitIYzQ1eHYxa1A0?=
 =?utf-8?B?REcyNFZsMEZTT0ptRTZnNGllMGZMV2dtREdUNlUxQUp5Wmw3WHNLVkxBTTdT?=
 =?utf-8?B?ckZrNEpOc09sSXZkNDFLRzhRWTVGZ1c0ckFhWHFxTVpyMGlXeDZyYUllLzRk?=
 =?utf-8?B?dTFkMkxGRHlHRlJPYTk3OEZKTXI3QWNueVdjRnlCWEFyMnRRcFhRbWlBQ2Rq?=
 =?utf-8?B?NW5EanY0RU4wODZ1UEREMDAvdlBqNmdzZGNSSERiT2dMWUtoYXFLRzNCbW1D?=
 =?utf-8?B?eXRyaDBpQkVTeHVock1WaEtEYmRPUkhKV216ZnVrbksvL0hjY1pRQkIxNWZN?=
 =?utf-8?B?cWlhNG95WGZ6L3RZRDd4T3BQVGh4ZFM0UkxIb3RXT2RqOEFMNGpMT1BkTXJi?=
 =?utf-8?B?b096UkRoeHFvSTlwNlJSaS8zQkJKWEs4SXFEUlY3NFA4cUxubU1zaXhHQVhx?=
 =?utf-8?B?MzVwREpBRXFXaUNLU0dXWmd6RkQ4K3BLNWpRL2VBZlBaWnNuSG91QmpVZm5Q?=
 =?utf-8?B?cEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Uk92cFJSa1l0Y1lCTExxRnZqSXhqRENORVJ2WmRNS3lMUkV3Q3NrM3piaWRi?=
 =?utf-8?B?d2dPYjAzbmtqYkY4UDhNRHBIUkJCZk9rcWZXQmpScEpENDBmRlNRNUY0bFNO?=
 =?utf-8?B?MGZGUFF2dktZalNHTm9sQU4rTGQrNDlMaHloQ1RIb2kyMG5WTlh0SFcxUzF0?=
 =?utf-8?B?QzJrb1lkVThtQkhWZTR3RlhBeTE4SHJuMGFUUDI4bitqUTF5Vk1EaW9VMG1h?=
 =?utf-8?B?OTdyRzZyY01qQnViVmxRaWIrejBXa08vbjlrKzlHVmJIZFJQc1R1Y0taWnNF?=
 =?utf-8?B?MnhOOEZIeTRla0xGa3doUGw4dStCWGV3N2FDSHpXT3hyRWNjOVh6d1NyOXhY?=
 =?utf-8?B?eDJwQnFSSlpITktQNlNVYXNwYjFaR1NpU2Q0UlFsUkFlNU9GM2JHZXhldS9p?=
 =?utf-8?B?SHBBbktTbEVDc3hBTkhkRDQrSmhNcmMzYklWaXM4N1FkbjJwd3k5SzluUWZq?=
 =?utf-8?B?L2FXUjJGMldTSWdvUXZNY1NSaFFwVkZJK2tFbm1GVlJtL2w2eElsUHVvczRS?=
 =?utf-8?B?MUNrRjFFYzdodjhRRWxlcXdpc3NpTzJSYTRCUmxxeG9ZNFo1T2tEd3JxbDVp?=
 =?utf-8?B?eG03REJIc0M2SDZXcm9ZaXhESEUrelhVRldZaytkZTk2d0JqdTQzakJzUG1D?=
 =?utf-8?B?SVFDWk9nQVVZK3Q0amNtVTM4QUhyVHF2R2R3aXBPcWZCSFZkNnR0clZiamRL?=
 =?utf-8?B?ZUM0YTl5OWY4MVVsWjNjbWJFcW03Qmh3V3BoVmZEeVFVZndiUUtEL0ZOK2Jl?=
 =?utf-8?B?aEtTak5BblZ0STdsRURwSmR3M0YydHY3ZlN1elhES0VIQisvNHYxUUwxcEpX?=
 =?utf-8?B?OWlxZGI0Ti9GLzhMWU1BSzUwb2NON2hpalM2bkVtc1piUURYNG5sUnY5bE5I?=
 =?utf-8?B?UWF5V1FCdWNDYWVFa2lIUUY1UCtYODhkUHlET1ZQb296UCs5czVxS1VzSDlt?=
 =?utf-8?B?N0RoaC9mc1B2cUFIM0kvS0FFTDNqQ3BKWEp5QVorWE81bDlwRStLTXI5RFRw?=
 =?utf-8?B?NU52L2RLdysyQUdHRVJVem9YOHN0MUltWktBYWozc2ZhdW43UGZobDdFelB0?=
 =?utf-8?B?U1Y0WlJaaHVFQzBGeTRHa0JMNmZBRitucTVseFkzd0NWOFFmU1BRN1hBb1BR?=
 =?utf-8?B?Mk11LzJaVmVKUWFlcnZyRFlWZ3RQM05LT2Ezdk5HUS9xbm9tMlZrbVRNcEZt?=
 =?utf-8?B?YmVWcGpaK0RndkdUdmU1b3p1UWJhdmdhNVlxcS9WTmllb1crMWIxRDc1R1FZ?=
 =?utf-8?B?OUJkcEQxMkZLcnZldDBCSkJKTmM3V2ZBT0Y4R2JaSlk2Z3pIa1VDcmRHTXFj?=
 =?utf-8?Q?3mL7Dtv+l8Nangn0hb9usHNU/7YmeXDIcv?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e70a723e-8321-4b05-253d-08db8222ea4d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 15:24:27.7169
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JCWqXFKSopw8cx63XTkv6noOzHJ6A8l2XqVWF8+Y1+iUv6l3wUHYZtZQOzj7eEpldYugiTTjaXkJ6NUKRgmqog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4905
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_08,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307110138
X-Proofpoint-ORIG-GUID: qynC8ZW0LSAnpBcByzPgGIu1_Z5Ogj3b
X-Proofpoint-GUID: qynC8ZW0LSAnpBcByzPgGIu1_Z5Ogj3b
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> ```
>>> $ perf list
>>> ...
>>>     uncore_imc_free_running_0/data_read/               [Kernel PMU event]
>>>     uncore_imc_free_running_0/data_total/              [Kernel PMU event]
>>>     uncore_imc_free_running_0/data_write/              [Kernel PMU event]
>>>     uncore_imc_free_running_1/data_read/               [Kernel PMU event]
>>>     uncore_imc_free_running_1/data_total/              [Kernel PMU event]
>>>     uncore_imc_free_running_1/data_write/              [Kernel PMU event]
>>> ```
>>>
>>> After:
>>> ```
>>> $ perf list
>>> ...
>>>     uncore_imc_free_running/data_read/                 [Kernel PMU event]
>>>     uncore_imc_free_running/data_total/                [Kernel PMU event]
>>>     uncore_imc_free_running/data_write/                [Kernel PMU event]
>> So with this change can we run something like:
>>
>> perf stat -e uncore_imc_free_running/data_read/
>>
>> ?
> It is a long standing behavior of the event parser that we match the
> numeric suffixes, so:

I guess that I missed this as I assume that it would not handle more 
complex names, like hisi_sccl1_ddr3, which I was then interested in.

> 
> ```
> $ sudo perf stat -e uncore_imc_free_running/data_read/ -a sleep 1
> 
> Performance counter stats for 'system wide':
> 
>           6,969.93 MiB  uncore_imc_free_running/data_read/
> 
>        1.001163027 seconds time elapsed
> ```
> 
> The "uncore_" at the beginning is also optional, I kind of wish the
> "free_running" was too. The code doing this is:
> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/parse-events.y?h=perf-tools-next*n316__;Iw!!ACWV5N9M2RV99hQ!JduVayRc--qLXHsoXWTlMUsO4NBUoBnKQHqP2sx7VuwZiZzfVXaQZNBZuzO2Ie-twWQ1xu7nycBNFJ13LGk$  
> adding a * after the PMU name in:
> asprintf(&pattern, "%s*", $1)
> Then using fnmatch here:
> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/pmu.c?h=perf-tools-next*n1707__;Iw!!ACWV5N9M2RV99hQ!JduVayRc--qLXHsoXWTlMUsO4NBUoBnKQHqP2sx7VuwZiZzfVXaQZNBZuzO2Ie-twWQ1xu7nycBNa2_VzYE$  
> 
>> If so, does that match all PMUs whose name beings with
>> "uncore_imc_free_running" (and give aggregate result for those PMUs)?
> Yep. As we're matching with a filename '*' glob then it will actually
> potentially grab a bunch more. I think this should likely be made a
> lot more precise.
> 
> The merging of the counters happens throughout the code, but it is set up here:
> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/stat.c?h=perf-tools-next*n559__;Iw!!ACWV5N9M2RV99hQ!JduVayRc--qLXHsoXWTlMUsO4NBUoBnKQHqP2sx7VuwZiZzfVXaQZNBZuzO2Ie-twWQ1xu7nycBNiVEZvEE$  
> 
> I didn't write this behavior, it has pre-existed my contributions. I'm
> hoping to change the perf list behavior as we're seeing large server
> systems with getting on toward 100 PMUs, the events are replicated for
> each one and the perf list and testing behaviors are somewhat
> exploding in size.

Sure, that is why I was advised PMU kernel drivers event names to be 
unique per PMU, so that we can add an event alias in a JSON and then 
kernel events are matched and removed from perf list.

I suppose that your changes are an alternative to the problem of 
mushrooming kernel event list.

Thanks,
John
