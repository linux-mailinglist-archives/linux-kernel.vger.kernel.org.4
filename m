Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B17750362
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 11:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbjGLJjy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 05:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbjGLJjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 05:39:00 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4006E1709;
        Wed, 12 Jul 2023 02:38:43 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36C79xUV018432;
        Wed, 12 Jul 2023 09:37:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ov1qkor8/kjJkvRC2EgaXfspZgK16qxha6tcdAH6ziU=;
 b=Jcn3VDss6BpVpgnCQQX083AP7QkZhtPpCSUS6+w3+MqMbhH8OSgpPx/nq+GXyTQSlG1u
 USkDZR6StAp8N68xgfTXAVeJRgNR1gh972xt4+C+zkjFGzwtnGNQEMUTcSI9gCEUtwLB
 TLAQ/GDtvLvjmRy+A68pZ/sTQormC68wT14Qz/5yNLjU5gaXAFJdzfTjr7uRni7gsxM4
 t5JbfPDMQuTpeq98PdmpBl8nkPXkiDNM5E5vEtS/7BUHFTXKZ59Yg68Ult6qEdomqwRx
 z8tfuLHdiGzYvOZPnZ5iWx5OaFptTxpaZLYJvYyTwK4uAeBvIvFxjcRxbhsCnLKcXua1 gA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpydtxtuk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 09:37:44 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36C7jDeL008505;
        Wed, 12 Jul 2023 09:37:43 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx8chs44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 09:37:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jyUGoGpoa8ypBz4o2J8e3eEUkCfqpGIpdarOHcivbXaWeWHy3l5+AWpgsQm/WDx60MAmTBNp5An4trnnAPuT6AWdlInu4KHeBF4JlVc4lyMFyzePK76fr1wXUhp430IW00jwsBab0IJYR2BqCCfBh9AnC5l4YuM6bjcdgZa8v22Cs7TtyhO9wqfeC5VwJOQZx2m91ZI784UgLJLtQyIHzRuv8uhdpMU6XWdZnJBifbQ9daWn6MNJ1Rfjc3+Dys9kvd553xSNkSCoxQFdurwvuZZC/L0zVXm/ZGQphbLrK8aUT8H/PgNckHzoq15EAd2D+fpkzbwZCwU+usFXVCW6DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ov1qkor8/kjJkvRC2EgaXfspZgK16qxha6tcdAH6ziU=;
 b=E6dKE94hYXn9hbNpuNe4wr/8I/tfEm41lihEsT8ow6uDXG0J+Lj71l28k1CLoNnzUvhZdwC3mQ+Dn4UECuZeEqWfXD7FFUwk7W8ssFQ36baNhG6GYOqe7t/7+7ZIkJzOqVj5hr5fatFuTw5RRqmeb25Nn5oTC2FcQI39cA/VSOWhH23+F/wa0qpTN67t6PIEywdwDQW0BlM3BuPIP1cxmZtkf65bgky9BzJ15PVnkiaZinXDNKYagQZOsl9Kl3suVHAYNJcb5sfKL3mhLophmTM9LsSmluLZ2gvDLGze415FJ+aQxEkuEUMnl4xMxyK45ST5qwmAHFFj1MfirRF6Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ov1qkor8/kjJkvRC2EgaXfspZgK16qxha6tcdAH6ziU=;
 b=Kchi3VMyJg4Wlxz+6erImIIvnFQCiEUQDODCa+vOdLHbmbQDrygSv3YOx8miOPzfCquKV/lN+g39XWYiJ5QHtGZ+eT4feqv3HLPkjkg8KkLxHcU8mLhrGiPzKX7wTq/Eu5Lhhh1bSJZEKm7MdN19rNt+Rqw9mKzWDJrbHZcAyCQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4797.namprd10.prod.outlook.com (2603:10b6:a03:2d8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Wed, 12 Jul
 2023 09:37:41 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 09:37:41 +0000
Message-ID: <5f38981f-2911-c3e3-28d3-0e7b5d63228b@oracle.com>
Date:   Wed, 12 Jul 2023 10:37:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH RFC 2/9] perf metrics: Don't iter sys metrics if we
 already found a CPU match
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>
Cc:     acme@kernel.org, namhyung@kernel.org, jolsa@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        renyu.zj@linux.alibaba.com, shangxiaojing@huawei.com,
        zhangshaokun@hisilicon.com, qiangqing.zhang@nxp.com,
        kjain@linux.ibm.com, kan.liang@linux.intel.com
References: <20230628102949.2598096-1-john.g.garry@oracle.com>
 <20230628102949.2598096-3-john.g.garry@oracle.com>
 <CAP-5=fWB9H0KWrXYouepUiAbnfH3u29XuRVN6KXVw3CNbD4xrA@mail.gmail.com>
 <bb828dd4-3c22-7383-008e-ab4f860ed686@oracle.com>
 <CAP-5=fWZj-vzmF4=iNEw=8DdJetB4HWtHYSzCCvqms9iKdaZ6w@mail.gmail.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAP-5=fWZj-vzmF4=iNEw=8DdJetB4HWtHYSzCCvqms9iKdaZ6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0072.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::21) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4797:EE_
X-MS-Office365-Filtering-Correlation-Id: 0816d69c-1a99-4e29-34de-08db82bba35a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oXbWWG7gzro2CUZwYRlVW7YZp2wHQTNuFlQY0kA929DUylkavSCOQYpHU28BNESh20W9zpTlEC4AWJxppG7oSU057xhOYS9G0w9Ginl7l950cQPQbQSyqyPF7pS3J0+eFIc3Z4lCnncP0uPt678YlhFl3p2EHTHK/qeD3P+O04G68CZzmqjGAjaBFlqdEz852ij7vGNWz8plPeD/ysjf8MLsSFMZxIb4laIt1BY/WeG4xgPnuRxwyG19gFFoUNibRC0VuO9oTBeeVcb1yLxYjshGwPIFm3VrVZ83pgjUOp5p2ph+hy1j4Xdxm8HAMe1MDw5HzFooXtDXT0xBFS0ZhwtCr4ewamhOkiIXOKETSnKAevhSslBvWu3e1cpAxEqVSUqjF/B/Y/WOyRiOkPsf0RMjuexpFavnQnvwN4qOGrDuwy0OdLoQJ5Ft9wX6hncrFISSsH8XrJZwexXuoJyvzUaa5oEcH960m1x6gZSr6X23tbciLmk7CFSadMo2BYDt07KEAFgUD3PZMaXzxcC5m8ZpQ3jh3iLt+c7jl2qitUujxHd2d8lEyyAuTCWEBd7RazNylGce9Rw87iwsjKZHlv7qfHXZzXt+mB5YFyVdZtCbnNrKJlYnYzl2qlO9ojRERp9qwNG0mWFOO2LstyGLX52GIC9bBTIiBw9nrXPOlV8gI79qgi9oCJZSVbRhDJEU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(136003)(396003)(346002)(366004)(451199021)(6506007)(186003)(26005)(2616005)(6512007)(53546011)(478600001)(966005)(2906002)(83380400001)(41300700001)(4326008)(66556008)(316002)(7416002)(5660300002)(8676002)(66946007)(6916009)(66476007)(8936002)(6486002)(36916002)(6666004)(36756003)(38100700002)(86362001)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmxGa0RWdlZEU0dxUlVPQjFrNjNNdTBrWGRzVUh4L25RdElPMzRXZS9yWDJi?=
 =?utf-8?B?ZDdTZUk0dTluY0Uyd0Irb0pHdjJFb0NkT3lkMEJnZXYrQTFHRWVlcEROcVVD?=
 =?utf-8?B?ejlJeHV6T1ZMZVk1QTBpbzRZZEdiVU9iOUxZdUxZYkdaQXZybkt2K0g2elNH?=
 =?utf-8?B?SVMzQkl3MVhtdmw3ZE1pbHhSM2w1b0hxVU1FNWFDSVo4bjRCVG9rUU9yZlBK?=
 =?utf-8?B?cHEvZUYyY0pJTkNKK21JL0pXR2J6R1hwTWpFMmE2cGNDdGxWdGVPTVY5a045?=
 =?utf-8?B?QXlkd0Jma29lMExHMENVYjY0Zk8rRFRlbkhHakROWS9FZXhmRmpYTkZyQkZC?=
 =?utf-8?B?Si85Rml3R3lrOUV5SlJIRnNDclVJMFFpNkhKNzhsdHFFeFhCR0h0UzRTQVg4?=
 =?utf-8?B?czdydTdPUEZwbi80Y3F3cFRSaHRLWmlucFg3YzUydUFiMjFiUTd4OWtVWUFw?=
 =?utf-8?B?eFg2RUNnSk1OMnF0MnhYYVlSNnptT1ZZK0RTRDIwR1ZoTi9tU1BoR2FmMVZu?=
 =?utf-8?B?WmRVVFNZeERVTjVCTFBGenE2Z1FrZXVkSG4yR0Q3ZWNWUWx4cStGM3JldXF6?=
 =?utf-8?B?ckl3b3ZzTzh5ODMwa1lVMVlNalB1WlcvalY3Ti85LzRzdHlWY2ladTA5dFpw?=
 =?utf-8?B?ZEdUVERJS1J6eUdOcy83TW1pa3hRYVZ1SGQ4elhmRnNkcnFUTnFPMmRhczV0?=
 =?utf-8?B?cEdlVEh0alZyYWJwdXZ4MXB4MXJqM0MyZ0FwZWRJUTJEZVh0RXVZREZlY1FR?=
 =?utf-8?B?WWg2VjFyVGx4MnV0cXUrN1hXalF0bDBSZGRYYThWem01S0pzRkxJbFVBdlB6?=
 =?utf-8?B?dUY0azdpVFpRYVh0bDVDcnp1OU5sV081ZUpjdG0rdXE0aFpid1g3L1RxbDB2?=
 =?utf-8?B?VEV1OVhtUU4ybkJsaWFwR0lKdGI0Q2k3c0JjQ29MM3N3c0hob0ZmUDVka05D?=
 =?utf-8?B?Sktnci9FcHhRajZxczRQS0ZHZ1k3N0FKUXNQSmlmaFNzdU42Yk9YUGJ0K1kx?=
 =?utf-8?B?cjNkUkpuSHdtRGRBRnJkeXEzS05sZEt3b3VqQVVtR1dvMTlhRzJmUEFpTE8y?=
 =?utf-8?B?Qm8yUGY2UTVocDlzaUNVcFZuOHNaSnAyV1dUOTdhZ0lrcDdBU1UxdFl1NEJQ?=
 =?utf-8?B?OXpDc2kxS254bUc5aW5rZHVDR1lnU1czbzd0aFdJQmY5Yy9IQTJsNTIrZFZB?=
 =?utf-8?B?bmJIcTd1RE1UcUNHL3hoakFYZUQrREY0UEkwdDV0dFFmR0ZHZTJ4STZPb1h1?=
 =?utf-8?B?bGhWOUxYek1zQkloZFFGQjluZzBTc0Q4Wkw3N1RYWTNiSWFJYlpMVDNtNWZ2?=
 =?utf-8?B?My9ueXZ1Wnc0dFMvbklWYi81ZjRIVitQL0RZRFpSSHM4YWJ5Sy9vQzEyRC9G?=
 =?utf-8?B?dEduazMzNVFOWTV5NHMvMXpIMmxYNXpQMCtyYVYwc002UzhaZ0E2eFBCRHU3?=
 =?utf-8?B?d1lhK3p1MHhMV3FhalVockkybCtqdTJkZG9aWXNiU3dWelpKcFpwOTU3SGFG?=
 =?utf-8?B?eGZlRlhRQy8wU2lKcW11UmVySEl2clJZOHJrYjFoK1pzTmkzOXB0RXlSV3BF?=
 =?utf-8?B?Y3JFMG5OM05reFpNK3ZRR0tESzBiK1hkaEh2T1ZiOGJteDFkbzlXVmc2Mzda?=
 =?utf-8?B?aW9tWlgvSjF0MlFVWUtiRU5yekd3K1ZwMk1FaEYrQ091cTF6dUZhdG9qekww?=
 =?utf-8?B?MmRhOGhLMTJ6Q1lpdjlYQ1k5MzBweWlqcHA3bTROQnVVTndiSkFrRTJqb3Na?=
 =?utf-8?B?MUJocGxwQUQ4c084MW1XRlorbldwZEFCNGdjelVaNUdESWRya1FwYzF0M2hX?=
 =?utf-8?B?ei96RFhlTzF1cC9JWWtQT3N2V3YvU0RPNVRRUlMyalpyTEdNeTQ0dFVyMjg2?=
 =?utf-8?B?bXFlazNxOVJoWlo0c01MVzVDcG9VOFVQL0kyalFwaTNIb1FnejN1TUk0aDhD?=
 =?utf-8?B?SlRqTWF6cHJNbFVPemhwUnJvV1R5dkdrSEppNEZObHA0K2tuOEo4d2RtWncw?=
 =?utf-8?B?NWl6cWVRRUZUU2dRQVNHR0hkR2VRNEpHV2Qyc1ZaRk5FT2VPWU8xWlBpWFZH?=
 =?utf-8?B?enBtMHpLbnFZbDZiQ2ErZm9wT0dHZzBOb1hkcWtFbXJINTcwekJuVmQ5TmY4?=
 =?utf-8?Q?PQ9k3lTnFTszEGhV44toNjYLe?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?LytEaTRKbGhOVDQzNjdqZHNBMXNXZkY4d3hGemhkK0hEYVBtMFBMQkZuaUV1?=
 =?utf-8?B?SEVReDlyOXI3cW5tbmdKd0lyc0JrQlQ4U3BQa09EWjdEa3VUVEpFbm5GU0l2?=
 =?utf-8?B?TjROSDdWbXdLN0poV3JMWS94aTg0VVd2bHdTQTIxekZzSmpEQWh1ME9TTDJP?=
 =?utf-8?B?U1NUeFdqamZnVmRWaTBPSkxRcVladWJZajZnUkNXbDZ4b0ZsQ3BlWU1ETnY2?=
 =?utf-8?B?VGZraGRhMW9Dd3dKeVFqbDFxdHYxWVk4MGp1cTlVWlBkSlRkYVNpZUlOY2cv?=
 =?utf-8?B?MWhlWUNjb2x0aXpjTTRPQTAvRWIyNGd2eFJhY2lsVk52TEZpTGhqL1dlVHZp?=
 =?utf-8?B?NnRiVFhoTDNOWUh0TVNMeTVIRU1oM1IvRitOUVNLMFNJRjhHV0JOZ0FXVzNs?=
 =?utf-8?B?dW0yZ1JLVGVacGdHYk1tRmxpNWZmUnVTNW1QcVRhczBwVE5MM0NiK1dnUVV5?=
 =?utf-8?B?WjB3UmlZK3JsdXFMVkdlSkhyZk4rb01DRVdYRmtiZ2QrVFJ1aEZ3T0V2dldh?=
 =?utf-8?B?TWVDdWFIWUVjcmd5NjRsYndoMTBQYmpwYktIUnQwTkpKVWFwd1N3Z09tdXl2?=
 =?utf-8?B?RWRnU2JzVU55cUZrSzNWc3Y2WTF5dXpWb3BVNEFZV05GaXJMcWY2dTdYTlM5?=
 =?utf-8?B?VU1NOEtrbG84NFAvRlJNempIQUs3UHd5YVFvWlhRbDhLOEluTlFPZFZmLzVV?=
 =?utf-8?B?KzB5eUhESzBtYWR0WCtPR2hNTlJkenMzMDd0dDlYRDlYV3dDMDVvYjVnbnlL?=
 =?utf-8?B?Y2VYTENzWHZtMWpxcnZoWmFPclF3cUdMSzN5SGtqS2hjeHVjNG1KbDdlREJV?=
 =?utf-8?B?UmMrQzBXOElYdnlPa21CbW4yR3luR3RwbG4vaCs1UWR6eG5ZeHNSMTMyQTM1?=
 =?utf-8?B?eVBXK2xrelcyelAxbjRYVDdldlhQbWpvbTltSTIwbXEvU0dkREhWd2dZVFZl?=
 =?utf-8?B?THlqR2V2ckVEa0w0RmxGSkMrU09xVkhYemVTaDVCR3hVQkkyVG1jbFo1Tzdu?=
 =?utf-8?B?N2R6Qll5TVpuNW5QYzN4aE5XWUtUMk9PazBaR29kZERvK0VKMGpIczhua2Rn?=
 =?utf-8?B?bWhBS0cwN0xnWDNzMlIzRUNCenNIWFQ1bTBKVGRSbEplK2lTU2JFanhWZHE2?=
 =?utf-8?B?R3hLajBBb3JweDB4UkcyQ3piOWRzRnZ6TVUyUjRLbEhMeXJNMmFtb3NJTVBQ?=
 =?utf-8?B?eXYwNWFkOEt0Z1Q2d1JuQ2M3Q0FFY0NQbVJ2WTlmM04zREloU1pYSjhSUFBy?=
 =?utf-8?B?ajU0T2xtMXNwNmJsNUZFMWp0QzJKM1NpTDdCY0ErUUdUdFNjR0pGNENpdE5q?=
 =?utf-8?B?bVJyZ3IvR0p3TWVOV1YyTklveHNCMkVNOGJacEdJbElOU3Mvem52NTZ4ODg2?=
 =?utf-8?B?RnNSVmVIbVBSWnNqMGVjYTlvK3YrQ2c3UVBHTTJ0S08vU3RmUU5WOE5uV0dS?=
 =?utf-8?B?TWtBenU4WW5MMUdxU0NJdVczaE94R3NJMUlkWEVRPT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0816d69c-1a99-4e29-34de-08db82bba35a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 09:37:41.6322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+LT1KHx/YsZiCvRaDQkH/xt/FRJulmYpuEQe8BONA6rRWF3Q1K/jSJNXbZc2cy5x+9IGQwpm//DwaK0Q5suGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4797
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_06,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307120084
X-Proofpoint-GUID: eyAqpX5ZTtBWcPbrVtiMbtIy--OrRX_d
X-Proofpoint-ORIG-GUID: eyAqpX5ZTtBWcPbrVtiMbtIy--OrRX_d
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

On 12/07/2023 06:40, Ian Rogers wrote:
>> A few points to make on this:
>> - Currently we don't have any same-named metrics like this, so not much
>> use in supporting it in the code (yet).
> We have same named metrics for heterogeneous CPU PMUs:
> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json?h=perf-tools-next*n304__;Iw!!ACWV5N9M2RV99hQ!MyvM7oyC6FgOVgDn2-Ot_TJNh4TF_VM9SlIVwv2AOTkJGdmDJ2NYf5WXh-yLcG1dRxLKdXWZVTzsoOo5yDk$  
> cpu_atom
> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/pmu-events/arch/x86/alderlake/adl-metrics.json?h=perf-tools-next*n1125__;Iw!!ACWV5N9M2RV99hQ!MyvM7oyC6FgOVgDn2-Ot_TJNh4TF_VM9SlIVwv2AOTkJGdmDJ2NYf5WXh-yLcG1dRxLKdXWZVTzsL1dVM3Q$  
> cpu_core
> 

I meant that we have no same-named events for sys PMUs compared to 
uncore/CPU PMUs.

>> - Even if we had some same-named metrics, I am not sure if it even works
>> properly. Do we have any uncore PMU metrics which have same name as CPU
>> metrics?
> So I was thinking IPC was a generic concept that would apply to a
> co-processor on a network card, a GPU, etc.
> 
>> - Further to the previous point, do we really want same-named metrics
>> for different PMUs in the future? I think event / metric names need to
>> be chosen carefully to avoid clash for other PMUs or keywords. For your
>> example, if I did ask for IPC metric, I'd like to be able to just know
>> I'm getting IPC metric for CPUs or some other PMUs, but not both.
> At the moment if you request an event without a PMU, say instructions
> retired, we will attempt to open the event on every PMU - legacy
> events (PERF_TYPE_HARDWARE, PERF_TYPE_HW_CACHE) only try the core
> PMUs. It would seem consistent if metrics tried to open on every PMU
> like most events.

OK, fine. I can drop this change if you prefer. But, to reiterate my 
main point, I still think that there is not much point in looking for 
metrics which currently would not exist.

Thanks,
John

