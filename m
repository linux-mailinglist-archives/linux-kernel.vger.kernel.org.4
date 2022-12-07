Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276906458DC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 12:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbiLGLWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 06:22:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiLGLWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 06:22:10 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE552B62B;
        Wed,  7 Dec 2022 03:22:08 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B79jXur005200;
        Wed, 7 Dec 2022 11:21:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=WUS41q2kMc0LW61NEbpfljNUUFobtKtjFPKwo5lRKCM=;
 b=mpLluhdsn3H/nleYrs4jjZIqib9aEgrvhWLf6o+op2TAEmVYH7wTOhlX8zU13OTxSwJr
 F6wYZCgJM02yrc0DKoS2TWMB5CQDeaUurBkVGNp8MWA6ytVTh+cxekSCk1+iRJfEY2Y4
 jX4xsaTABHCUobMoEYIUQJwfD6vTlT+tRxPNKhvdfofDA8d8sty5wHDL1b+b97mxtG0G
 zz4OMXCpDZkEgAuZF8jSx/3ktjnSeN9OQe2exQU4di+Ah1ADTmIh7YCFOMiKUQWTEuEy
 M+hEQwUgysd2bfNL1hzRLa0JJmjrINAm7UfmYUfL/tATW3bmJZcUw4HuVW4Pkmr4GsNC Fw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7yeqt59q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 11:21:47 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B7BBuqW026001;
        Wed, 7 Dec 2022 11:21:46 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3maa8fde5g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Dec 2022 11:21:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LWZxTLnaAajeJSP43Ma+parLgE1ummp6nUGErRjM30+a3EcLjQBJRTptsSMayqwjHZpVWHWeAl1ZoE5T2Jf53H6Vu01QfxNQf+Y4r+rHXKBJe8lO27aZRPRrDdCiSuziZ87yTdFTIBeaqdWRTWB2ZZiid8//aoXxQQYdBqSD4fcoOoT1oqqJ3/Hmd+v60/AY9u2dTaz0WNWWD2uW5Lae9VS0ftNymxk0/N6g9plOv3ZiI23DH+p2pNKBRSv9GT+Qiv/bsGy3DPtohPH8dl9GZbj1Z7T+4/Xb/Wnz6RQeD+q6FFadqkW3FEaqmHB250NmJ5xv+rknm9q1Y2diEm2r7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WUS41q2kMc0LW61NEbpfljNUUFobtKtjFPKwo5lRKCM=;
 b=POpQfHMDZsbzSYWPJHksbECdHOIXrmxjgLDND2TMK66lKzxvX1xNWdsY5QdLiwzHz+OrFOFd7P7ZdhYDoNPaPx6K6D9vgemn84xl9Ky+y4F7Xa5DkDjIOVrnbt/EPgg+VFk/Afd0Ny5wGwDCIMOCmZ2B74MJYdbx06AwqgbIEzZY1gm3GWVUqRVXziXQSBgyfMXB9AnygVk7/HzKdnw0WRbbWM4STDSb+RlaLpSkJnuZ/6liMrhjmGP17nUUeUktDGZ55yAxxqmpj3nr07i9kPuUNsU6XE0vcUclhqz66xh/tnIlb1W+FSR1+JwkrdsVCf4L/k4YFRCE2ythBHjkWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WUS41q2kMc0LW61NEbpfljNUUFobtKtjFPKwo5lRKCM=;
 b=K69guy6WPa+Hvq4MkitQoCXX9nJI+FZlbDsfUO6J83DnOmBww5FIR/soGQlkuEmq/uOQwh5S3npGk5T1W7BRt0u2BSUEC7XmiskJ1jEQndRrm7rEBHzKP4U4iql83yuN5EjGwdstsr3GMYxmUn7M1PSknaIBYdlM6Hdx6Zc1qIE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB6280.namprd10.prod.outlook.com (2603:10b6:8:bb::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14; Wed, 7 Dec 2022 11:21:44 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::5984:a376:6e91:ac0d]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::5984:a376:6e91:ac0d%8]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 11:21:44 +0000
Message-ID: <dfaf436c-c669-7088-b3b6-dd6dd8b882c7@oracle.com>
Date:   Wed, 7 Dec 2022 11:21:38 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3] perf jevents: Parse metrics during conversion
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
References: <20221201034138.417972-1-irogers@google.com>
 <61e2f5b7-e332-08d1-7ffb-404cecd23ecb@oracle.com>
 <CAP-5=fUMsEExYE+hwZz+fc6LW6PqdPRHq_CYKDb8xL0rHTKgAQ@mail.gmail.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <CAP-5=fUMsEExYE+hwZz+fc6LW6PqdPRHq_CYKDb8xL0rHTKgAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0173.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB6280:EE_
X-MS-Office365-Filtering-Correlation-Id: d8d14f4d-abad-4b52-abf1-08dad845389c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Omhz6OauZTREuzjUcFMzu6gSxiXnJZx+OriUF2kXzK1rXvjI9E5OLysGy53zJFTweV1idRsgweuaJeR3x2ATg5YNnmxULnsAB1KYkNOp/Z6nihfWed1QCVPK3RFUNmjuXGHddH1KMQPp7T4mP+uMr8Aclf/1uuFucVg6wVcL2w2JfXa33FaZaAoS1+H8XtsAsLAvBdZOOqeF4xjHZK3H/zBwv+pR+vCOeKgND4TGzgdsO0YrFQy98epSn03ky5aqnTmqOdfQp9iwCo68nO1snLFP1QkMwExlTsFSoPs/lvEhZxTAZ9uTxBFoMGuhzqNfELYzUbjyb4tir1dEDV3cA1tan4SfJbbSLIHksvpACj8KalFSEswce4+FVxTE4QbmJyerj2EyqJnjRDD0AeDih/taYOES+n2lIyoYcjsi9Mmor83nFDeOoyYxaVCoovZdp2hvzIRr1uGAzTuULaaUehiN2/P9E+sQ4DibzCXwvH4lChOmkksIwqsT8moiRA+ZlJ9hfvOhu+jtc/CQD2Isk4s8zGjIhc5sTpTiDi9aSu63aECTREs6vX7mof0qwyae7Ua+nPtOP9l9zUIae0QX/Buy5EhVeBaHyYj24Az0IJTz4KYIM4RtQTC07IRpXWyaj8hFk+5kyX1x8NyjDDr8IKgM7+AeoR6+5r6lhCXQaZExfivnPshEk+A/TEvqNKAqtVctzRdd5sIJY5p7tF4/+ixFqXnrp+rAbfU6h7r+cAQorAgK42ddxyIci1wXWKlF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199015)(83380400001)(6486002)(5660300002)(8936002)(31696002)(86362001)(2906002)(7416002)(4326008)(41300700001)(6666004)(186003)(26005)(53546011)(6506007)(478600001)(6512007)(66946007)(2616005)(8676002)(66556008)(36916002)(6916009)(54906003)(66476007)(966005)(316002)(38100700002)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzhWK1RhdFBOQTlrbnpaaS9CRmxMMVpkWW5JbCtmYTdKRC9Xd3JISmY1Rmdr?=
 =?utf-8?B?TFdreC9FbUZjcXFhQVJWRjFOUnV4Y0NOV3YyYjBZREovMmllWFM0N2o0emlp?=
 =?utf-8?B?YVppUFREWCsrMUpUclc4Q2Zzc2YzMk5ESWQ0QkVtVTh3SGtxMlF2ZDd2b1dG?=
 =?utf-8?B?aGUwalRPeTF2ZE5LWmpjREpFRlVJVjlaYmY4UWx2QmR5TlNzQ0FVbkhKc1BC?=
 =?utf-8?B?bHpyVzdEd21DbkVCbTFCUGQzY1pFVGdlYXN1N3B6eGtzbWRhMXNZbS80VDJy?=
 =?utf-8?B?QkI5TTgxc2tQdkpXcWNObytrUGM3RXRBQ3JRZHZRbWFJc0NuWklPeEV6M3VP?=
 =?utf-8?B?OHdKQUx2MlB2MUhNbHhrNnZOK0JsK3FXR09LeGQvWVZ4TU8ydEVyaGFhSVpa?=
 =?utf-8?B?YklRdmV5WjNRRHdSQjNNVzN1MFpGem5zVUdkQWxPOFg1eWlBY0ZFZ0dta29l?=
 =?utf-8?B?TmN4T251V2s4RkQvd1hxNHVua1JmUXgzeDFBV0tYTnJrc3VUVkV2YkNEblV2?=
 =?utf-8?B?TVpjck9ZakgxTy9udE1pRjZzK3E0QS9SSjdEYXVSd2lLYVZaT0JCZUhzbkMr?=
 =?utf-8?B?VHRZVlFJTDNqWXhEaXdtenZDeVU5ZnhZS2h6YWFoU1FPWEJpOWNZTkVuN2ho?=
 =?utf-8?B?R0Q5ZkFSNHFpUkhQTUM4bzhwM3Y2ajVMWVQ3UVRHRjFZbEk3U0VPellKam00?=
 =?utf-8?B?OVBPUWgwRUdUeWFENzdjZ0JBK3VzTHJOUDV1MTFLVkxxM1VYak0vVkVNY0hP?=
 =?utf-8?B?NXNNa0JoM3A0ZUNsWVJJcytEYmNQUXN6dXRvOXl2dlhGWVVTUTFKWUhrMXVR?=
 =?utf-8?B?alErUUFSU1pIV3B5djJneDZWYUUxT3Zhek1KdkpGcytNRmNqT3lkRXJkL212?=
 =?utf-8?B?VVFLNGU1QUFVQnMwdzVWVm5UWHpjQnpMakxDcTROcmpsL1BtdjRVN3Q0bkN2?=
 =?utf-8?B?empnWk9kRFA2b1c3S29kMmlieTJ2K0EvQjRTczUzbXBIUjYxSlNYN0NLcm83?=
 =?utf-8?B?WExZV29yN1lGQVM5RFlERS91L3lFZlpFYmVMMHhiL3oxYnFWbXVRNWxlMnpx?=
 =?utf-8?B?Tmw1c3JEVThXLy9qN1FueGwyblVEeXVMTmMyWS9GQ0pOTm9RUkZleHlrd0Ro?=
 =?utf-8?B?Z3lkMklzNnBJQUFMOEtDZ1JVb2dRd1BLUnM1NlNRV2JNejlxOVJ4QjZJKzlO?=
 =?utf-8?B?Q2hhSUFxSS9DSWFhUE91NDhhLytPN3o2d2tjTWRZQjFrRncwbHBMMXhHWHFt?=
 =?utf-8?B?bkwvRkswc3JDcVRMVlVUOFhtY0YxV25oc3E3UUplL0lLMTBUSk1vWGZFUE1R?=
 =?utf-8?B?bDZWcDlRaytjSHBpQ1JsMVJmSUFCY3RPczNvTUhDL2RpUWo1WklGRnNwRUFj?=
 =?utf-8?B?WUFqbEFZVFZOK2QzbnFYYkNEUWpZN3c0NkZWQVpodkpwMkNKNUw3c1ROclR3?=
 =?utf-8?B?eUl0bE5BR1IybjBGOW42cmIrdTludXR5K3hRZ1dJbnR0dGpjTURTSjA2ZmUv?=
 =?utf-8?B?NFpWRFN4bEVIUXpCSEpxaTBUM0NPTkxIc3RuRFZFL1NseEw2L0RBalBnUURP?=
 =?utf-8?B?V1U3OS9RcGZreVVlbkt6bE1EcGRHdCtieWJjWWEvNkdCUjFlY2xPNUkxZlB4?=
 =?utf-8?B?Z00xWk12WG9SbHJ3bEpoMjU0YVlkUzJUUExpTmNOVEVTV0tpRngyYk15ejZL?=
 =?utf-8?B?T25JZFIwM2hsU1NOQXpYdzdXbWpTVjE0aEx3alNBQkpZVnpmOUNncWd4YXRo?=
 =?utf-8?B?K1NGRzdEVDd5UHpTNktjeWNvRWFBNDRMamdDNUJMcG9sMnZLTjhYM2h3MGQ2?=
 =?utf-8?B?YjIybVk2dnF0QnBCek1hYVcvZEpwbkEra1NCL3RiaVdTWUVhVE9xaWorUjRC?=
 =?utf-8?B?cFQ4QWZUZzIxL2hHS3QwU0REUjNOcG5BeGU2S2UyUW5YSTFZc1RueVhJT3M1?=
 =?utf-8?B?dlR2WXd1MGlpTmlPeWFiaEcvQnJzQW9rYnl5Sno5WkRNZGtsd3JaYXhWUC9m?=
 =?utf-8?B?Q1djaUJOclVjeVZhOTRUaldqN2NQaUY3Q0JHSEF1dmU2WHFSV0FUMUtENXV4?=
 =?utf-8?B?VUlzU2w1Mi9wSVEzUHBOYmEzSEM3dmdnVkFwQXg1bEM4aHREWTlNaFJiN2Uw?=
 =?utf-8?Q?CIXiaRFfKYijm0ldV5YhEER50?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Wms5SUQyZjNrMkVkMnNaQVlTSDFDSGRmdGVka29TV3o2VHRlZ0YvNGxTck1m?=
 =?utf-8?B?dWJmVTBpNDhaVjZkUnFubWVhMWZha09iVS9oY2UyTHd3TjdNZXBDUTMyNDFq?=
 =?utf-8?B?T0d0NmdlSjhlbkRiY0l1ZlZoZC9maWQzU1dkZXcyOHlXWHlZeW5GMzVLMUtO?=
 =?utf-8?B?YmZIVm9rQkVKeVE5UWpWZXFyNzRsOW9GVHhXUDlKUjdRUHo4S2lwYjBKajAy?=
 =?utf-8?B?SXRueTE5TTVnUGVyaCtyeWxjcm80Y0wyNUZrM2YzNjdjVW9nekRqNjEzUUgx?=
 =?utf-8?B?bjhldks5QnpWUmh4ckN4V3BucnQyeTR2SzUvUkZ0QkVsVXIwcS93MklVZmh2?=
 =?utf-8?B?ZHpQRVBoVGJXcy9wSGQ4T1pNanJiWllBYzdXLytrRUZtUytNS1YrRTlLSVlx?=
 =?utf-8?B?ZUptdU5LNGNkcHBsRU9hYndNKzJRTUhkaWdlTmZzVEFFbEVjYW5PL28zNFJW?=
 =?utf-8?B?TzFPb0RYTFprQ1lwRHUvamRIY0UrSWlyNzlSeGNibENmMGtoTXg4d3pmMkE3?=
 =?utf-8?B?dE5GWnFrOEdadXIxbGdkbWRjSXFzMExUb0ZIK2FCdUUxZ2dCem9rTFdFVi9B?=
 =?utf-8?B?dWV3b0tETlZYNEZkN3BvT3F4V0NLZTdjVzJaSFYzNUQwK1lrYnFSdmZTcEJK?=
 =?utf-8?B?cE1FZ3h6Z3BvMEJTL1lJQUdkenk4d3ZpSFRBVVlCOG04TmVpS2JQUkFaN2hL?=
 =?utf-8?B?K3lQb3piVzFXS1RrM3lIdVZFYnNsekRLRkNJSzhHZjBKSitLSmRXUzg1QlM2?=
 =?utf-8?B?c1hNUy9SeG5CMFNuRXZYZlVPYmJTN2Z5UHB5QkhldklDYTBMcU13enJlT2Zw?=
 =?utf-8?B?MDB4UUVaVndMSkxOSFpkaWFPdHdJTlNRUlVUU1lHSG9nL2hBUU51OG1QRWNR?=
 =?utf-8?B?ZDJKVjlWeDNFd3VQNFdUWDBVbzEzbnM4eWRHbmhydkFIM1BpYzUySVJrRlZ4?=
 =?utf-8?B?NmxBT1lXc0xOemk0bno1UTd1bjR3TDc0UkNiQjIvc2tUNXRSVEJGbnA1SjZY?=
 =?utf-8?B?OEk3cVdBei9LWmh3SGVCcWFOMjVEOGUwWDFZb3NHUURSMStUMTdBVnBaQmU0?=
 =?utf-8?B?elR6ejhCckR1dkJyVk9lN1F6SFpLVGJsNmpDSmYwYXBhSk9lNWhzTHJBdzFl?=
 =?utf-8?B?cURuSGFHcTJ5VlZ2MmFJZ25PL2M0cWE1TStlZ3cxVHd0WmhuNkVWSnlCMTZs?=
 =?utf-8?B?N0U0RGxYdnBDYXhJT0xBSFpyQ081ZnA4RVBkWWtMQVNOemc0c1duYm5kUC95?=
 =?utf-8?B?ZGRCSUlHTmhoU3ZndEVFd1NmTzJ6K0YvcXZPSmIzbXRqUlZwMjRxYzFRNDNE?=
 =?utf-8?B?SWxaV1ZqQ1RsRVpWZzhqYzg5SkFwbnRwb3k5TXVNS0RZQjZKak1SdGZGT2xW?=
 =?utf-8?B?NnFkN2tMcXMzR25MZUQwemRZejdPMkx5TXp6VUVxMlkvN01zOEhSWjJGRnF6?=
 =?utf-8?B?YmFrVkVRMmdSQWt6bS9jUTUyS2NNd0tLeUJpdHRlRWRaU25obml1OGtoM0xD?=
 =?utf-8?B?UUN2ZW1wL0VPc1hrUTN0Y2dGVkFhcjFtVDVGMVljZ1dRNDJ5RUJUSjg1QVJH?=
 =?utf-8?B?NngyZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d14f4d-abad-4b52-abf1-08dad845389c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 11:21:44.2669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PJHPJaamxJonh0XNyyRLktUE57oLIYUrWXmyxCIFGlGWe0J+ruYwIyfj2sQRyNsjClk7lQa6aKwajz6VESqxwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6280
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_05,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212070097
X-Proofpoint-GUID: blNTDigYEorcVFFoSjzrjeCpc2bROGo5
X-Proofpoint-ORIG-GUID: blNTDigYEorcVFFoSjzrjeCpc2bROGo5
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2022 19:29, Ian Rogers wrote:
> Dec 5, 2022 at 7:24 AM John Garry<john.g.garry@oracle.com>  wrote:
>> On 01/12/2022 03:41, Ian Rogers wrote:
>>> Currently the 'MetricExpr' json value is passed from the json
>>> file to the pmu-events.c. This change introduces an expression
>>> tree that is parsed into. The parsing is done largely by using
>>> operator overloading and python's 'eval' function. Two advantages
>>> in doing this are:
>>>
>>> 1) Broken metrics fail at compile time rather than relying on
>>>      `perf test` to detect. `perf test` remains relevant for checking
>>>      event encoding and actual metric use.
>> Do we still require the code to "resolve metrics" in resolve_metric()?
>> But I'm not sure it even ever had any users.
> We use metrics referencing other metrics for topdown metrics on x86.
> For example:

ok, I just wasn't sure if there were ever any metrics which did require 
"resolving". Now I know.

> 
> https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json?h=perf*core*n34__;LyM!!ACWV5N9M2RV99hQ!PMKcRLro8XREBI-072XYolfLHVvOm4P-HBWTpvu8IxJzkE0NWydgW9wi2PclFvUrdQcuC-4uvubPf5RgWYI$  
>      {
>          "BriefDescription": "This metric represents fraction of cycles
> the CPU was stalled due to Branch Resteers",
>          "MetricExpr": "INT_MISC.CLEAR_RESTEER_CYCLES / CLKS +
> tma_unknown_branches",
>          "MetricGroup": "FetchLat;TopdownL3;tma_fetch_latency_group",
>          "MetricName": "tma_branch_resteers",
>          "PublicDescription": "This metric represents fraction of
> cycles the CPU was stalled due to Branch Resteers. Branch Resteers
> estimates the Frontend delay in fetching operations from corrected
> path; following all sorts of miss-predicted branches. For example;
> branchy code with lots of miss-predictions might get categorized under
> Branch Resteers. Note the value of this node may overlap with its
> siblings. Sample with: BR_MISP_RETIRED.ALL_BRANCHES",
>          "ScaleUnit": "100%"
>      },
> ...
>      {
>          "BriefDescription": "This metric represents fraction of cycles
> the CPU was stalled due to new branch address clears",
>          "MetricExpr": "10 * BACLEARS.ANY / CLKS",
>          "MetricGroup": "BigFoot;FetchLat;TopdownL4;tma_branch_resteers_group",
>          "MetricName": "tma_unknown_branches",
>          "PublicDescription": "This metric represents fraction of
> cycles the CPU was stalled due to new branch address clears. These are
> fetched branches the Branch Prediction Unit was unable to recognize
> (First fetch or hitting BPU capacity limit). Sample with:
> BACLEARS.ANY",
>          "ScaleUnit": "100%"
>      },
> 
>>> 2) The conversion to a string from the tree can minimize the metric's
>>>      string size, for example, preferring 1e6 over 1000000, avoiding
>>>      multiplication by 1 and removing unnecessary whitespace. On x86
>>>      this reduces the string size by 3,050bytes (0.07%).
>> Out of curiosity, did you try the exponent change on its own (to see the
>> impact on size)?
> The file size savings are very modest. Without removing the "1 * " the
> savings were roughly 2KB, perhaps 1KB was shrinking the constant
> exponents.
> 
>> Nit:
>>
>> Unrelated, really, I notice that sometimes we lose the parenthesis and
>> sometimes never had them, like:
>>
>> /* offset=11526 */ "\000\000metrics\000Ave [...] 0\000( 1000000000 * (
>> UNC_CHA
>> /* offset=11207 */ "\000\000metrics\000Ave [...] 0\0001e9 * (UNC_CHA_TOR
>>
>> To me, it seems neater to have the expression contained within (a
>> parenthesis) ever since we moved to this "big string". This seems to be
>> a preexisting feature.
> You can also read the metrics through "perf list --detail", we could
> add parentheses there if it helps readability.

At least being consistent would be nice, whichever way you want to go.

  We can also expand out
> what the big string values are for comments. 

Maybe a comment at the top of the array would be nice to tell which 
member is per column.

> Fwiw, I want to start
> refactoring jevents.py in follow up work and that would impact
> readability. Some thoughts there are:
> 
> 1) we shouldn't parse all json events for all PMUs in prior to parsing
> events, we should initialize a PMU when an event references it and
> then possibly then go through the json events. To facilitate this it
> would be useful to organize events by their PMU.
> 2) metrics and events should be separated at least in the C code.
> Currently on x86 ScaleUnit in the json will apply both to an event and
> its metric, even though the uses of an event and a metric should have
> different units.
> 3) for some operating systems with limited disk, it would be nice to
> be able to have the build exclude models.

Eh, do you mean an option to build just for the host system? If so, 
seems reasonable.

> 
> Let me know if there's anything more outstanding to fix on this patch set.

It seems fine. FWIW,

Reviewed-by: John Garry <john.g.garry@oracle.com>
