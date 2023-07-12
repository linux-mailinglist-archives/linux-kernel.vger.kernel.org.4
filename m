Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E72E750543
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 12:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjGLK4U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 06:56:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjGLK4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:56:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BAC11D;
        Wed, 12 Jul 2023 03:56:14 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36C74mC1018425;
        Wed, 12 Jul 2023 10:55:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=2swIhMZ9KbIZP0URmeg2dmFMcC+rI5ojpL/2v4SA5hM=;
 b=kWrM0Eyu+TO7nBBMOkIY6AKx30WsHJiTUXVrDJmLCuTOj+sP2FjruP+btsTOhqQFyosj
 WddkGOtlO2WzkM88KbfGIWZb3r8Xis52OsmNdeSw6zk9np91TF3KwpJ86EWhs0+H7tgN
 DhPP+grzMyUm04xO7awt+YUScZ3uFTkdCxTMecgHT0yh4SGy/kXE1uENjUa7ldVmx3Bl
 FKAwqePtWUQyMxd2ockRrzJYuMwPF5lgzDODoO1nj3g4GxO/oDrNbfazstHzNSNUOyjz
 IdCTTgl3VP7Hus7L+OMfqeJ3jXJXQulcsMbcftei70CP8/VUhY4TAGEEUng9+JW3dgvc 8g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpydtxxd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 10:55:31 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36C9kYuR008312;
        Wed, 12 Jul 2023 10:55:30 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx8cmhtu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 10:55:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I48fULjTcJGdhzcQDQbTDQ8MDfyO8l6mQhQjvpU0g9pNwz5Phm5fvY5Z21phG1PR0utOgrNGXb/+1kXgGYPNY0hOiT6N4vqwTHSqJFtfstyxYDEdvR8pJb8AbOHH1P0oB7z5yAtiMDAl3bmxx/9dSRDcE5aY/RulDMuR+VpXQth8bqEMyJFwVqQS+B+LOln+8dHTNA6m7xuaGaOH/I9X10axTlkqZhuEhE63cSojJpHDYJ14zQDAG12vq1IWOsF6FfT7DkZW7YKS6Riq6WczvyVTglcLkK/lS7KzX/UQF+eosp8bA5hXtVsSQSfHbAyQRjRER8XrT+uabcIwhBBH8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2swIhMZ9KbIZP0URmeg2dmFMcC+rI5ojpL/2v4SA5hM=;
 b=W3vUoro/vHyT+SLb78NoDf0JgtJjKcFkW3WQjCIWuzOZsxYEfvQPRtReOmIQaC+rRk9+SBV+qoWq5xEMoqC00mcb3EgFWXVX6HNrnG0eNVC+hyYoNxOE9sXLwfoBiNN7qAlrkTOaEhrwFgw/LwuI9mDyWtD+I9T93xPAmMYzfEbRYSJVaS6uGPEvTo41D3Ufrc0BQ4L9dAJtHSORkrsdsTkPEz/C1uthIkmKdv3jK8VtL/GWRsR0pnYpLsIBYpEh3shDlBbb7A9sjumJIW1e6oM+i6OEDTyWd0ARyu6I1ue6HA8RcuGYv8b0Q/4YYxTZaLZARwwtT+U8v3a2P225mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2swIhMZ9KbIZP0URmeg2dmFMcC+rI5ojpL/2v4SA5hM=;
 b=nqfHyW0Vm/YcK5BqCOfleQrgceZtf1twQxX/1WtF/vlPvJC+5EvTAD3mXO1xfdLQQAWsDmCDbXazgQnm4+HaO1dmjvFETyj13NmXcopFIZaufk5/s7fa8uGFXHh70QxV4uSZjfXOCf6WEdlI1QShQKa0srqCFNmy/QTcItECwHo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BLAPR10MB5252.namprd10.prod.outlook.com (2603:10b6:208:328::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Wed, 12 Jul
 2023 10:55:27 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 10:55:27 +0000
Message-ID: <897dcf1d-6a04-33d3-9c4f-ea9d1706cdad@oracle.com>
Date:   Wed, 12 Jul 2023 11:55:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RFC 4/9] perf jevents: Add sys_events_find_events_table()
To:     Ian Rogers <irogers@google.com>
Cc:     acme@kernel.org, namhyung@kernel.org, jolsa@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        renyu.zj@linux.alibaba.com, shangxiaojing@huawei.com,
        kjain@linux.ibm.com, kan.liang@linux.intel.com
References: <20230628102949.2598096-1-john.g.garry@oracle.com>
 <20230628102949.2598096-5-john.g.garry@oracle.com>
 <CAP-5=fXa24_LEiyni0Ncyfa5hKwC1GE6y-zi2u8M98M9SwHX+g@mail.gmail.com>
 <CAP-5=fUs=u3PKYP3mVDdzNB8+=GAHaEXG3SGfWJpMELYYqO_hA@mail.gmail.com>
 <d59b6e7c-cead-24d4-a9cb-6552b3154d84@oracle.com>
 <CAP-5=fUu6xgVDQT4tq=vmRLDMe3ddMLywP11uOLvKSu8Lc6BjQ@mail.gmail.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAP-5=fUu6xgVDQT4tq=vmRLDMe3ddMLywP11uOLvKSu8Lc6BjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0021.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BLAPR10MB5252:EE_
X-MS-Office365-Filtering-Correlation-Id: 43f99597-4520-4df6-e955-08db82c6805a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DvMbG+QXHMpaZgsN0dKXHm+NF5Yx5pFBPg027kewhQJakRM/S/vrL4qK5axi5H8DJ/v5dAVLROtdrs+KpLKhVOFC/ge5ZTc0oIvcTt0RqdKmSjgeKtUXNYSm5Tv+iv3eneZXfFcRjE7v6TmX/qcwMcQKMXc6vfK0HL49fJvEXr0hTzAZDbnwLD/RoIuc5IKcB9IVh6WCrxisj/cDSQCNBilk27wOlMmtqCbqtLw8MXzhe/dBDIBk58brZNd8ddYVFg1jXi7uroOGNKVhBMJwamBdHirHmdUZ7HEQc4XUP/MSzFU6ldZovcQmRfhXyeb8x5W9EwJKvz55jb0J5DWBJP4ah14RUpH6r3dyaXXCF5l5FhkStRHnSsOK35itPxkGD9xNgsRkrA2QWMOfUzVAOY7GdTBGxDe2N+xeX9brQSwzHRePuqlwickf8iOAJxyr8sCvxFdnZQicYCPXWT22VgeE+067uhaVSJI1CybpUbMHb4UZNzgwWLjdmFOHYW9G2pxI/pTdAuf5bs0pk0/lZe8qesBm3qS1IVeu1+FytTvxRouZv11etF0FIDwM1S5hFbN1VpRIDGAeVsJ5afYjBau6dvbeVnojR5T8BRktK3pPDOEnzW8q3kOePegcoDtVO/jLzTJZVg2ppJtEd55+Xw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199021)(41300700001)(316002)(7416002)(31686004)(8936002)(8676002)(5660300002)(2906002)(66556008)(66476007)(6916009)(66946007)(4326008)(26005)(86362001)(6506007)(38100700002)(6512007)(31696002)(966005)(83380400001)(6486002)(6666004)(36916002)(36756003)(2616005)(478600001)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T1d3ZnFZNTVzcXlDRkl6M2thS0oySGlMZGhiTUlZalo5amJBWmNRZTdsM1RZ?=
 =?utf-8?B?d3k0c3EzM25Kb1VqZUFHRVg3K1UrRkZwVThSV0l0MjQwa1RwajFiMnhhRFJs?=
 =?utf-8?B?MnZ2b1lISHgxSGJrZ0FER2ZqYjJPbXlSNkI2UUp2UXl2L21Gb1JjZ1lVdTFx?=
 =?utf-8?B?ZWFzdis3eE9QSnFKMVFUSUVhRlBZbGlBZGNpdHpYMzR3WDVkQ2YzQXhUSXVB?=
 =?utf-8?B?b2U1a29KVTlkNU03UVBxQlYzS2N0c0liUEpKMHl4L2dNR0Mwc3VWMG9mVEp4?=
 =?utf-8?B?WDl4L294WmhNSDVQVzI2S2hOS3NIMEhzWkwrdXdFTDhiTlZWTGxUOXh2VTlM?=
 =?utf-8?B?azc1eHI2amFpUjdXc0VndG80SVBXUjZheXZLc1g0b05UVUZqd1RVckdONjBp?=
 =?utf-8?B?S29XYmhKVGp0YjBBek92RWduVkI1NmxGTFIyNkxuZlZha0prcXpISFVMNFI0?=
 =?utf-8?B?Mkw1VFU5Q0xqRytmZ2piNUVmVXBYL29nQmp0YWswenM4ZFZPUkZ6U0ovZ0Zn?=
 =?utf-8?B?V3hIUlpGajJLcm11M3psWjFxOVdaTHhnTWRrdkFDYmpDQnFPMi9MNlh1Q2px?=
 =?utf-8?B?clVnV0hJWmRHU2xqUjdiZ2dlRWhqMm5YN0x3ZUlvRFRaZjRqOGVLWUQ0eUZF?=
 =?utf-8?B?VURLR0RsS2FzWVhpelhwYUpjU2pkcExrNGM1dDFaUldvN3dWYzZSQ2M0aEMv?=
 =?utf-8?B?VVh4b1NiNU9kVEFMTWhzU0lHdkxKVHVBK0RObm9PQk1xRWFRa1RVM2o5MHc3?=
 =?utf-8?B?NEhieFdwYnZ2U3d1MmJvN09RVGVUdFlGSUdybFFhdmh5UmNYM29iTGpaNWg4?=
 =?utf-8?B?cnZWMGVQeUp3dTNsaVdVWlM5MU5IQ2hoR3gvSUpqVzJDR1p0ek45U3FibEF2?=
 =?utf-8?B?OWlib01obmpOekNEbkNUdVo3OWZZUTZiZFd5Rk84ZEd2TzR4UnJlQ2svOFly?=
 =?utf-8?B?eVAwNHlDTnBPWTNYbnI3OC9ZZHoxbm1zVEoxbHZ0MFZOdzJ3N1JySEdySGZK?=
 =?utf-8?B?eW5kSnlGVzA1NG9iT1d3WmVkMFMxSXdlVjloMTZzMEZqREFJb3h2V0c0ZnJt?=
 =?utf-8?B?ckJ0TklLcTYwa3pTdnp4MUVkSUNuUVBEcGx3cENFY1ZjSWNNTThqWGptSy9H?=
 =?utf-8?B?VmlRYnRvRnNmOXZROHM1R2pFdWVHTWxUK0ZHeUpBT3RaL3lMNU12WW45bnh4?=
 =?utf-8?B?ZHN2d0g0T2FxY01Bd1FkenBSU2ZPQUFyUmxIeWVRMDc1WktoZFNxUEhvMFFT?=
 =?utf-8?B?cEF6TCsvSlVyVUJPMk9qQXBxUklwbVIwdXYrTHY5bVY4SGpxV0hOTFdMNFZk?=
 =?utf-8?B?dU9lZU9ncTMwMmY1TlVjTVNJOGNodTVWRmlka0RueXc2ZTJOd2pBeFRXb0VB?=
 =?utf-8?B?SFVGdC9RR2ZpWW4vNS8vd2c2RmRxbE9Cb240OCtQNWUvMjdmU2RoM0VUNFht?=
 =?utf-8?B?MVZiazA3ZzlWbTd3TUVpVlFEaG0rak80UGJTSGJoRml0bzJSQTdXdk1GNG4y?=
 =?utf-8?B?UWZVT3pVU0ZwODhRY2o2RUNGQ0Fkc2h4K21sUDZDTXNNWW1ya0xIVkpKMjFl?=
 =?utf-8?B?Y1AyempLQkcvRG5oMHdEbys0ZXZWOERsSXFEMXIrVDMySzdaNTJvck8rVnpI?=
 =?utf-8?B?YUlQczJvUHpaUW95a3ZybjExdjNjRHNWWTJsYlN0eHJqREhyVmlra3J3VFky?=
 =?utf-8?B?aUc4MWJaSjRCaWR1UnVXTEdoZlpybFg1dlFuaUxXY1dNL1ZFcjg3YW5LdFNG?=
 =?utf-8?B?ZmlXNHljSVNyZDRhYTg1ZzlIMEhtVTMvV1pDMmpEZnU1Ylc4ckI4OU00ZHJJ?=
 =?utf-8?B?RWZJZzRNYlhBNTZPYTdyeFBSY2ZjVFFiandKUVllNmYwd2xwdExVdW01emJt?=
 =?utf-8?B?SUdSb3FOS3VXV1JWSGF1djhiNEs0dFRUTzFDc3Rrajl1MFNXMDZuamFOYm8z?=
 =?utf-8?B?RGFKSkIycjBkb0VlSENCVU11S3B1K1NwUzZjaWNYb0d1czdWZjRuNTJDU3BM?=
 =?utf-8?B?b21yTkgzSFNUNkJHSitYM2lRekxHRU9aMUlkSWVHbktGVGFzamdEQ21jQStu?=
 =?utf-8?B?cHVXZFRNOGppVDV6Sms2bmVOaExLY0tmZkJSeVo5eEFhQmFNU2RoelFYTXc3?=
 =?utf-8?Q?xZ3L4GLphxu58MLg78n4HPaOW?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?blJiZkQ3NUwwRGNwaHBPWTdpN2JSM1dTd0o3SjlRV3VqUEdtRGhpNjVmQVlh?=
 =?utf-8?B?cnloYytJazY1MUdqVktiS1JFVG1nQ3hZWjlIVFNWNDhObGlINDdVNmRvSUhp?=
 =?utf-8?B?cm0xeWZxQUxjOGx4Ui81RURMWGEwd1p0ZFp3NUEwUG1wSVpWWWlEaW9rZEJF?=
 =?utf-8?B?bHkwQjhBdFVyeWpick55YU96R2M4TU92U29kMVZlQU1pK2l3a1p3TWZCM3gy?=
 =?utf-8?B?UkFITGhTY29oTUtFUDN6cWpXZVFTb2drMEFxY0l6Q1VnZnVFb29IbUFSVFZD?=
 =?utf-8?B?Q01QVzl1Q1lEZ3h4L0NEMzIxVTBPSk01SVRncDNIdnNwRld5WVE3RGhlbm8r?=
 =?utf-8?B?ZXVxZlljaE1IWHhNc0twbFIyaVZ4Q0dMY3ZxK0JNNEZscVdkMmNsZUtiSXZT?=
 =?utf-8?B?R3RERmJpQVhxNGx0YnhLM1IwU1BpejhFb0NWT0VLVGlpU2FXcy9XdkVOSS83?=
 =?utf-8?B?ZVM0cHRBZ1pYSE1xd2g2Z3RuUDZFTGJVUGMvUTkzeG56c3p5Y0FuR1ppR0xW?=
 =?utf-8?B?YnpCTi9zQnRmS2pTK2Vlc3BWU2JFb1dndTdES3VsbGxDZWN1MElnL0ZjUkNv?=
 =?utf-8?B?SG9MV21wK3RVeEIxNW9Vek9NeVRhOExUZDQ4T0FFa090Uk4vTVNIZDdndHNo?=
 =?utf-8?B?MHREMjBNbHlmc29FSEhYQWRKVzZOTEJWOUEvSjNETFdRbjZYWC9kWnRPa1c0?=
 =?utf-8?B?WFNNYzlVaEYrbzRLR05MdUpzVmJ5dmEwS0V2bmNjZzBzaDhlc0xxWENtQzRa?=
 =?utf-8?B?SkNDQlRPL1RlNjc1ZlNLNDVSazZRc25FOENDcGJpZmFyczB0dkFUVzk5OHlI?=
 =?utf-8?B?OTV6RXFvdytLR2pmWmNWQUNSZlgwM2dseDJ6NWtJOXg5Tm9iQWJRWXJiVHk4?=
 =?utf-8?B?Z2hWL2xMbnd6QkVGU1NCL1U3OU9rOHIyUHVqOGtzcWRKY1d4eGM2a0F0azhD?=
 =?utf-8?B?d1Uxc05wZ1F1M2FPeG15Zjd3aVdMUDl4WXZwWGYwaFkrR0FobzdBUHF2VDVR?=
 =?utf-8?B?RWpKVEtvemNlTU0rekxsN2ZKK1BKM2NQbVphVXZucUEreDg5YmtEZ2QvQUc4?=
 =?utf-8?B?UjBkanlibmJ5bW15bHNnbWZBUWYya0hWSzc3Mm5BSmFHN0pTWU5JdHRJaGFQ?=
 =?utf-8?B?QTJlYlFjVGwzYXRjV2RzaEZxSy9DbkdsVU9qemh2NXZPbzZRcnVDRXRRdXhH?=
 =?utf-8?B?bmwzb1djaERUVzdOcHpzTGlZM1U4SkY5T0FtWit0bTdoci9pWjZjRWZaMU1V?=
 =?utf-8?B?bGlWa0JSZXNpSmNPMXU0cHEvc21sZTZMenBJSDhYd2JmYlA3T0tITXpvODU1?=
 =?utf-8?B?MDNSTWIyRmpuK1BtWVVKcU5MZVkrQ1dxdkRTSjN6NVRJUk8wcHVERVRkT3A0?=
 =?utf-8?B?OGlFTklzc2F4YUE9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f99597-4520-4df6-e955-08db82c6805a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 10:55:27.3856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U6ySOugJTY90QtxQSCyV22OtWowNmBdZNtJo8HQ+3qsjHUu15JNesJ4t6o7OZQ8XzPtvkLbxZwBnA+xBC9+8Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5252
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_06,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307120097
X-Proofpoint-GUID: _9PMIVHCoKmoq6LBLYJ1riKQW7TrmmO9
X-Proofpoint-ORIG-GUID: _9PMIVHCoKmoq6LBLYJ1riKQW7TrmmO9
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


>>>> MetricExpr: "cpu_core@instructions@ / cpu_core@cycles@",
>> I did not know that it was possible to state that an event is for a
>> specific PMU type in this fashion - is this feature new? Does it work
>> only for known terms, like cycles and instructions?
> It has been in metrics a long time (I didn't choose that @ was the /
> replacement 😄 ). It should work for all events.
> 

Good to know.

>>>> The @ is used to avoid parsing confusion with / meaning divide. The
>>>> PMUs for the events are explicitly listed here. We could say the PMU
>>>> is implied but then it gets complex for uncore events, for metrics
>>>> that mix core and uncore events.
>> So this works ok for IPC and CPU PMUs as we want the same event for many
>> PMU types and naturally it would have the same name.
>>
>> I am still not sure that sys event metrics need to specify a PMU.
> There was a similar thought for hybrid metrics. The PMU could be
> implied from the PMU of the metric. I think there can be confusion
> from an implied PMU, for example the cycles event without a PMU will
> open two events on a hybrid CPU. If we imply the PMU then it can mean
> just 1 PMU, but if the PMU doesn't have the event presumably it means
> the multiple PMU behavior.
> 
> In parse-events there is existing logic to wildcard events but to
> ignore those that don't match a given PMU. This is used to support the
> --cputype option in builtin-stat.c, there is a similar option for
> builtin-list.c. We can use this so that events in a metric only match
> the PMU of the metric. Currently there are core metrics but whose
> events are all uncore like:
> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json?h=perf-tools-next*n1802__;Iw!!ACWV5N9M2RV99hQ!MjhanGd4AVsAl6d8weFktNHgeOptrgeBDyooXlpeW-J1TQ0e2BwzvqO4BTFEjs_gRzuWTPfnhW_jLx1pIJc$  
> 
> So we'd need to move these metrics to be on the appropriate uncore
> PMU. Supporting >1 PMU

To be crystal clear, when you say ">1 PMU", do you mean ">1 PMU instance 
of the same type" or ">1 PMU type"?

  in a metric wouldn't work though as it would
> appear the event was missing. Having the metric specify the PMU avoids
> these problems, but is verbose.

The message I'm getting - correct me if I am wrong - is that you would 
still prefer the PMU specified per event in metric expr, right? We don't 
do that exactly for sys PMU metrics today - we specify "Unit" instead, like:

MetricExpr: "sys_pmu_bar_event_foo1 + sys_pmu_bar_event_foo2"
Compat: "baz"
Unit:"sys_pmu_bar"

And so you prefer something like the following, right?
MetricExpr: "sys_pmu_foo@bar1@ + sys_pmu_foo@bar2@"

If so, I think that is ok - I just want to get rid of Unit and Compat.

Thanks,
John
