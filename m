Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB5D6B038D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 10:59:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjCHJ7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 04:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjCHJ7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 04:59:05 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF2D5D89A;
        Wed,  8 Mar 2023 01:58:45 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3288EJ9B031019;
        Wed, 8 Mar 2023 09:58:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=bC7fJvrUyFyS4I0pXbQo0iCRjKjGmmY4B0D1or6RvdU=;
 b=AYQHCVoGdXLrJmJvmget0ev1EceaDyLI3rC+wHfTJTefkZlPucZxsCc1vcSXOoIXCp0K
 KKTIzH7BDSHaPiIg4I/4x1l3NlaHYdwOFKUMRVKDw7vOytLUNLz31vKMGLsw4XzLEebC
 h2clceLwbSQma3V1KvW28eq1K1aoeDalIi++yjxgP6NFyt1VkRaqSFGPl67DFNeUOwMZ
 ZMi5WwIrMcn7UXn5+MDlDaLZ033U2zFVyyR3mFwc4el7koQLlvZHJjOasS69ms+yJReD
 9SZxjWGvgDg1Qzx5oerTB95XQNf4RrKOnK1twGSNDGyc3XxNXeEZ6k7ieYxeC2U/y+Cj BQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p416wqqn6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 09:58:24 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 3288DbAv015688;
        Wed, 8 Mar 2023 09:58:23 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3p6fem1aya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 09:58:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4MiHN0BCJZVyTLcNrvOTWEtV3Bm+BFON/T461x15fDNpo8klkM2pfxoH1leP3MyMugjNujdTdJQtTjb4yvEsDJz5V6AJNeJD0NSZv4xIW+OXHfn73OrxKJngtYyRf2Q6t2vcNicoZ4c48DoTaB8/E2qu30S9Ex5A6W3aSm5KX0i9Q98mnUEtZ6bf5MXuIFVfp/wI1PYBS4nG4uh3doJldRvVp7A5b+xhKiIR5MdOpb/vrBH+vEeQELMWxs8InqLRwNjDaSwzXyg0339R95g4UwVs9onw1oYphh/mAT6JTWX4jeh07AVN681HYLNRjUhcF9T3rqr1fS4jInpMBpKwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bC7fJvrUyFyS4I0pXbQo0iCRjKjGmmY4B0D1or6RvdU=;
 b=PGuLh0Y7SW66IFa3D5gW611ZjVlZiXTI35qkLDjC8z2TKHnOpmYMse3zlWSNkFff8sTJcX5kChZp52kFTaaaRDdkgFh8vcnkdjlK8n6gDDi3lP3Z+UPsRTwyo9+15fA+59tcQjfeA3ftnz3nJ6ZTwsflkBuYX0SQftW5xIVD60LgC9RIGw+SJeBCyiiu7G8DMuC8J5kKwtlHvBfzUJbvecgfcqpZBvnoBbSiFtmXBp6mmrfrL/BdP+JllOH3HW0lvSmrIj7OjlZLzeXkQSCHTHlggZSLW8QPBwAAr7VXdlWSXJNmuun35SIgiqM6aK0K1FZ+lEOUqp3NRUTzj61/6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bC7fJvrUyFyS4I0pXbQo0iCRjKjGmmY4B0D1or6RvdU=;
 b=JYhNy5Z83JVeP/ZlZm75ylsjyg6VP0nRqX53NGG33mJc309/kbNSFfnc/d6WJ9qicK1GGY/UkUluzZU6CKSRG7naNVxA/zccuueCadpuLc3f530rh9oMBVa44bAmYqy5P6IfzM+H3CyK39kx/f/paBGfWVOOTPEyL/GvwTyfubo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB6758.namprd10.prod.outlook.com (2603:10b6:208:42e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.27; Wed, 8 Mar
 2023 09:58:21 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::7276:bc4c:17a0:7267%4]) with mapi id 15.20.6178.017; Wed, 8 Mar 2023
 09:58:21 +0000
Message-ID: <eae0bd08-b18b-a9e2-ebc6-04c94534dfc3@oracle.com>
Date:   Wed, 8 Mar 2023 09:58:16 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1] perf test: Fix "PMU event table sanity" for
 NO_JEVENTS=1
Content-Language: en-US
To:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230308002714.1755698-1-irogers@google.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230308002714.1755698-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0078.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB6758:EE_
X-MS-Office365-Filtering-Correlation-Id: 873fd8c0-1fc0-4098-7d41-08db1fbba673
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8fAUb8Meawsxy0p7YluREe6Xo4oUEmPj0LsAZm0I1J+BT3xdHcx29ZsXoHoQc4p9dzHDZdUJ+DaNpLjUL06sBIr08aAiqEN6GhRckcRaxEa3hmYmim/sP4p9XtesMAlHLKRAdmZXzwFWxzbNjuLQBv+9zNd2/3rCZ3LLr4Www5Af4MAOa4YWrQVGdhrNiQPWCZkhgs+BRAyvcvHFQ6hqiXu+CUj8wVLcLu+Sb5qnZBlwmt4ja7CwRvC6HBlFPXxHWKvU4FmuzxrJ3U52dOqkE5hjvg0izg/qvX6E7unwjx3a70+8DXgDp1E9sQxv9abebv7APcjS0E0mFC/0gPl2SNIuWJk3irvuFlj/Nx3xPYSkX4e3JEFBzCcBYUqkLYNl6VUvbyBJeNTK8c3oS7/81lsyl1uu5D7hEPXs2+wlc4n16B5GQZPfw79pTxz1/ayEbiGRnj4coNuxF/emfQ04mukUpohweqYEK8+O8cx72isBCtuYdq5BYGu6NIfvo7ujsgEkqBuWOYFePsNZakUpnzWYrmO+5Fyk29rGgtxX/NL3zUH5eUXiiShy0ayMDwuCXJEc+8qPeRIFYCJAv+ALTGcSt/U2+me50Y8TC9zpC/dTEjHCM9k+iR5IrVPfvKWJW5lEO0cYq3a7eH1uXZWWW1vXMdwsO5Wbm34ys2OxAToroQcQ2hTh1/Be4bVPUJPwvGYdv1HVoKTxWqlHftuXG1KCFR9pd72uQaWKwp4A+xt2FVW3F4f2BVOKbSlThJKJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(376002)(136003)(396003)(346002)(451199018)(31686004)(316002)(38100700002)(31696002)(66946007)(36756003)(921005)(2616005)(2906002)(86362001)(186003)(36916002)(66556008)(8676002)(66476007)(6512007)(26005)(53546011)(8936002)(7416002)(6506007)(5660300002)(110136005)(41300700001)(83380400001)(478600001)(6486002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bUdYeHlNcDdnaXluMnFacEY5R3lpQlBKbWZTNUtNRzRIdzY3eExmblpVZnFs?=
 =?utf-8?B?Z2p2VUJEVzJTbkhBVDkyUERiY0N0UURQWWhUQWthQ2gxWCtsY0dtN3VCSFR4?=
 =?utf-8?B?amtxZmRoOFhlTUhTMzN5VzZyZWxVRmhXdEhLaWNaNTd4RmdNYWxLMXQzU2sr?=
 =?utf-8?B?ZUE2cW9PajMrUXNxRHZrbVhvUUpvOWZEUmNoTnJ6aHFWV3dadGEvTTZEeG5x?=
 =?utf-8?B?SDF0VHY0aGQ2NkZIWTNtUXY2ZzYvZWZWVTZQME8wYmp5RzViMURSM21EdEFR?=
 =?utf-8?B?TUJEMDJDWFIrZ2FxQ3hVaWI1NjBLOVdHY2ZBbkU2OHpPdFkxMlNwR1puSTlp?=
 =?utf-8?B?bHBNaldDeHpYdGZ2eUt4dVAzRVgraEhlOWU5S1R3TXhzWVg0N1M4ZFp5Mm1m?=
 =?utf-8?B?S2Ftb0c2dEY2S0ZkanlzTWozNHdQSlE3WkpMbU1MditFUkxGUTh1UlhhMTVZ?=
 =?utf-8?B?SkErREludGFBR0lXTkRXNHVlUzAvWEtpdmthL2pmckRmc1pDZ3k1UzNNSHFt?=
 =?utf-8?B?U1pzL2xVd01hRktCZ0VnUVg1OWxaNTZRWTVyWDRUdWxBM0lJd2ZmNEtrMzAy?=
 =?utf-8?B?cW02YUxOc1BsTk5pSzQyYnBtOVZlU0pCbG40dVZNclR1dzRzcG1QNnJzWUwv?=
 =?utf-8?B?STJQcXQvTDJlclJSZjdCMGo4Y2xLRlFQbGJLT1kwblBSamsvQ3krU2F1MHJR?=
 =?utf-8?B?U3V5SGMwbmJZMUp1dnVuKzZYdHlBckE5VmloKytjaFRpOHJ5WWg2ZXJCUCtn?=
 =?utf-8?B?YjJkWlpGOStzUGoycmt3VDNZT3BEZlRQVWJYcXBpMC9rcHZoNlpVSGgrNlht?=
 =?utf-8?B?WU1YVVdNbEs3bW92b3BobWQ4YWsrS0FMdmdzRmdXWjllRFpqSTVvT09KVTZQ?=
 =?utf-8?B?SHNzM2t2YzhQaWpsMWxvbWNtWHJYNzljelIwVC9QM2RXcVlCT1RNc3kxS0ZP?=
 =?utf-8?B?Mm5odndUQk5ERXhxczZBQ0I1YStULzBjRTVyMnFROVBCa0JkaGNQUGRERmR3?=
 =?utf-8?B?SEo2WDZxY3l0VVhjRFZQNlhzblYyVHJsaFhZMGN0Z2pRclJmZVo3YitqS2ZE?=
 =?utf-8?B?VEhhVnRCZThNR1VLU3pYSjh0ck9wY2xyK0lieXdCMkxVWFJnSGU5bnlHbUNn?=
 =?utf-8?B?OEp6bDgrdFhUdTFFUlVJWXdnSG1RcUVFQzk5dlpuMTZocnh3T2pPRXVvR3Vp?=
 =?utf-8?B?cmkrY05JdUYxRmRsaW45bEc2S3lDSHd3ckxPS3htbDlBU3kvUjlkYzFrRGFa?=
 =?utf-8?B?Mnc5NWdNalJZVDlxRjRUY1ltOG5WbVlLTFZMZmlKZGJVemJvTGVRTXg1dlRI?=
 =?utf-8?B?WCtEWVVPM3lVbVJjZFVSeDVheC9sVFU4M2JjeFJMYjhGLysrdVdSc1NMWWpP?=
 =?utf-8?B?T2JXYSttNFpYOTN3NStUQ1pUSUJoRXljZGtOU1JUNFRGT2IyaWdGRW9ZMC84?=
 =?utf-8?B?cXlQMzByaGV6dHc5VTlkWlBtZ1ZORFJDbGlyMGp5R0IreGF0bFNIYlV5RVIx?=
 =?utf-8?B?NXJ6NUhyd1NaTWdiczBoK0sra2wrb2ppREUvUE5ER29OWWdiNnUyZGJaS3Q1?=
 =?utf-8?B?Y3RuTWFydi9EU3p0cHBnUmlpb1dFTEdCSXM4VTV5WTZnTldSUjk0MTI0dmxh?=
 =?utf-8?B?VUhvSGJBRWpXQlYwWGVJUjhDcnhsUFZmSC9BMWQ5S0NwKzVrWmw0d1FnWE1O?=
 =?utf-8?B?NTAwMjRwaXg3akV1Tm5RWkZ2NzhLVzAwejNBblJ2RFdraGRDSWxrcnQ1cFlp?=
 =?utf-8?B?MVBmb3pZbFc0ZnZaUG9wTUpBbmJFY1Q1Y1I3WW1aUlpKWklOMGJZNVJDN1lu?=
 =?utf-8?B?NU5PK1NtUmVXR3MyMWdRc0FmaXFCbGdXU1l4SUdyYWxWSC9SdENzdVZrSUZW?=
 =?utf-8?B?bEhmYi96dTdZUlVmNGl2UDFLN3ZYWTJyVHBCRGVhTWo2T3NzbXczbWkxckZK?=
 =?utf-8?B?Y1JWWTBQRVR1SXM5ZmN5SzdLNmZVOHhYTWh6M0JNN3VzbnVxM2JaM0tkQzcr?=
 =?utf-8?B?eHgwT2hjd0lLU0xQTzZQZnREQm5PSGxyQWNZUWl4S0ZqRytCYXhYUGFocnVM?=
 =?utf-8?B?NldFdzVCK2NiQVFxaUViR0t4dHdWeUwza2VYanhlVXE3L1VZdThBTUFsak1L?=
 =?utf-8?B?bHBQZFowTzdKdG12T3UxMmZmVktCZHVYSmhiZVFhZXJjQkxyb0dUMU5URk1j?=
 =?utf-8?B?UXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?R1FkR290bEh0VDFuaUxDQ3RwN2FrS2VONzhzMDBMNThlODlmZmtBVWZqbjAr?=
 =?utf-8?B?bVFISzl1Z2hoQWFHTEZOTE1VYVovc01EZVlVOHVkRFl2cUk5VmhHREYzNEZK?=
 =?utf-8?B?clFpY0Vkd1hYSTM5VEdPSjh4VWpEaldjS0VWTzkwOGhzRmRsVk9NQk5nMnpF?=
 =?utf-8?B?QnN6dGhINlZVdVJBbjZVZC9qWDl0TFkxZWp6TWxSODkrZ0lUdVJDajRRaFBn?=
 =?utf-8?B?ZVdIbHpEaGhRbVVEZk1iMlJkRFNnWkpYcnhEVVBjdkZyYWQreU1FblNENEZj?=
 =?utf-8?B?RGoxdE5WNWRDS0cyYkZ6TEFIdTVEbitZZ1NoUTRVRkZLRnU2Z0lGOGZZREY3?=
 =?utf-8?B?ei9LYnZvaEpmN0FPV1ZodXR4RmRDTDVmbnpobytCZkxFZFQyY09Wbk9jdFRE?=
 =?utf-8?B?VmxXdnpwZnZ4NkpWUEtRK2hHbkZSaHBxZ1dSOVBPTXZ3UHNUajY5NFFscHBt?=
 =?utf-8?B?TFhNNWVVUUxBQkpsZUNiU1gxN1JKd0pyMG1taGdKeTVMc0FsWnlMdFg5Z1hw?=
 =?utf-8?B?alJ0MGFURlQ1VTRJMUhkcFV3NlNzekdCVjU0N2o5VXVEU2lOWENHMS94NGpa?=
 =?utf-8?B?MHBEdkZRaUxKakNnbXo1WjR2dGdsUzZqd3lwUEFPRnVreFdYUTVCeGdzT0tS?=
 =?utf-8?B?Wk9UY3RnVndJZVUxUXBqZ01KdmIwcmR3b3gzM1hjdll1SlFaTWRsS1F2NHg3?=
 =?utf-8?B?RU96Z0dQRVYydVAvRTVkNDdEQUZmbWhUSjIrR1NoaFFyZVhSZm4xNFhjUlFt?=
 =?utf-8?B?Q1pZVzJReFpPbFdyejhzN0NOeStDME9zck9UaVZKSit0ZmY2Z3lSKzIyWDFa?=
 =?utf-8?B?SVBaQ1BuTFZTYU43ZGorYlo0N1JESnFkU2VERFJidzh6b1BrRWkxMzVUdGFM?=
 =?utf-8?B?Tys1bEF4Mm1kZWdheDFyL3UrUlZxK21ZeDhhdUkrZitpUzV3eXQrSFJ2Vm5k?=
 =?utf-8?B?eTNZam92VHQyNE1RRHF2Mk9DZXY4cmswSHE0MDFlOUMrem4zSmZBTzg1Unlq?=
 =?utf-8?B?RzBJcDBNYW56WkdZbG5GS3I0VW9HY2pta3g4NFQwL042bjl2eU1EVnFJT3Q1?=
 =?utf-8?B?WUovSzc5TnlSdFYrMzJRRlYxWWJ3enRNaUJWRWhBd2VDYklRZWUwOXpGc091?=
 =?utf-8?B?REttN2s2L2pQY1RRTGxRRVhhSTVLa2RUdXVCOFpHaWxvakc0eHkzZ21OcVFt?=
 =?utf-8?B?WWlMTFhqZXlkR2dBSHgwaUhFa0hVdElyaVl1T1IzZ2FuUEhIL0l0YUFIT1dT?=
 =?utf-8?B?TVlFcmtIOFUwT2QwWitPcTRjY2VUOUlid0J2akZpMEN3Vmh3R1FITitwK0Vm?=
 =?utf-8?Q?0jVgbjK2vOwFA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 873fd8c0-1fc0-4098-7d41-08db1fbba673
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 09:58:21.7019
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v99vXaa3eC2p8mY5W2z3o4dASdMUhYKmCUz3YMP0OK9aUt0rokcqqZPAbOCuzJD58z1RuoCnFeYgUiy+Nk3ANg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6758
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_04,2023-03-08_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303080086
X-Proofpoint-GUID: eAJNUnjJBpubHgo3EtI1HrHwRHf_ytgA
X-Proofpoint-ORIG-GUID: eAJNUnjJBpubHgo3EtI1HrHwRHf_ytgA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 00:27, Ian Rogers wrote:
> A table was renamed and needed to be renamed in the empty case.
> 
> Fixes: 62774db2a05d ("perf jevents: Generate metrics and events as separate tables")

This looks ok, so:

Reviewed-by: John Garry <john.g.garry@oracle.com>

But a comment, below.

> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>   tools/perf/pmu-events/empty-pmu-events.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/pmu-events/empty-pmu-events.c b/tools/perf/pmu-events/empty-pmu-events.c
> index a938b74cf487..e74defb5284f 100644
> --- a/tools/perf/pmu-events/empty-pmu-events.c
> +++ b/tools/perf/pmu-events/empty-pmu-events.c
> @@ -227,7 +227,7 @@ static const struct pmu_events_map pmu_events_map[] = {
>   	},
>   };
>   
> -static const struct pmu_event pme_test_soc_sys[] = {
> +static const struct pmu_event pmu_events__test_soc_sys[] = {

Would it make sense or even possible to put these table names in macros 
in a common header?

Thanks,
John

>   	{
>   		.name = "sys_ddr_pmu.write_cycles",
>   		.event = "event=0x2b",
> @@ -258,8 +258,8 @@ struct pmu_sys_events {
>   
>   static const struct pmu_sys_events pmu_sys_event_tables[] = {
>   	{
> -		.table = { pme_test_soc_sys },
> -		.name = "pme_test_soc_sys",
> +		.table = { pmu_events__test_soc_sys },
> +		.name = "pmu_events__test_soc_sys",
>   	},
>   	{
>   		.table = { 0 }

