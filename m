Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C92D6F82DC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 14:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbjEEMYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 08:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbjEEMYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 08:24:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AD51C0DD;
        Fri,  5 May 2023 05:24:50 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3456YXxd011393;
        Fri, 5 May 2023 12:24:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=CRME0kuVbH9PV0OCC9XpD8m5BkCBA7YwplCrv35Wdes=;
 b=aR6CZl5XJY5aEuPyJpvC/T7mkAW8zu1i3w8kWSAdRAzM8uM5ppvF1bD2OOJRA/+cbH4V
 fv3uxJonVbVfmrgCa6yo3t9rUShbQ1cGyuSjpCmXZYdEYlnqr6DDOayjSAFmJDDiTci9
 YqqMGi6tC5VPuAGTtESXwtCLiXZosOhqFNqrKkElKeWhZDXH6r7Gx3uaMrhL1sdTC8Zt
 hho9PQaUqlL6Pbk4II9/muF/89GO41uM+tYep0sFixWOnb8ggr8c78ZOz4FWHm+0LoPc
 pdfm6XeRmvWkLtXNt36UVd4emeFWkrm9pqEB4vY9bJ2OukNUV1zXhPILTSPOTUs43Kl5 kg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8t5fvnfv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 12:24:33 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345BqNru024982;
        Fri, 5 May 2023 12:24:33 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2175.outbound.protection.outlook.com [104.47.73.175])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spa1n47-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 12:24:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATIz3PlIzzFBwkgtPhME3PwzDYQqHi8gaeB0kudLx2Hi6WP9AgLWMz8oaS3JsQhudO9FuD3OItiX3iYUskpE6gZBhQRw+dRprDj8cUmo15VBOBA5hpbFmCbmiokndcIQvq37RA5SgTRAnVLfM+k9sWxB4cFNfXYU0dMniTTs0eVlJcHmG9Ti+rI6U8ie6IhxTonRH9X6pmrHV6ru/krjBnM/6xbJjIUlpxLWEVa30ldAQfziu6qj0thZOWCk1uAhs1Mmu4gkBGWncQjcSR/dznYmuMfVUKjS9OIOxHHpW9tmi2qnqtYGCmYomcHkCKpkdWW7J7DYbsYrjx2MiuTbBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CRME0kuVbH9PV0OCC9XpD8m5BkCBA7YwplCrv35Wdes=;
 b=U1DowW9/ZiotdPEnachjIlh997ksf2hyMlrfvVdLNX2Khr1/zlZ5ndLtd2mbrBEYVdA4nMbEjxMQj30lc0Tc2IhwjiCVPlSsdr2laQOba6navae0H2mnBm/XAGJb6hJKw7rSm42u+h8rzIx7xgvDrMq7nzm6S5qUuJlFpfLZptF9tOJAI/SMbE+thAK8mBJARMWU1P5lyz+sqDFkFvPoFHr3qE5lhArsNRL8Tawu6hs3j7My29v8CRhuHJwX4Ep3TrDjU9TGJ3qoRBy4ireSmO9vRYZ6+TfljwNRJ4XvIHY7+oAtAkg+zHEZfzpMBaHyqkRoSv0vDweRgoIR6e6YSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRME0kuVbH9PV0OCC9XpD8m5BkCBA7YwplCrv35Wdes=;
 b=dEXUicKvjBfDRXYOKqOwpBUoa8yiXFwNz6gGfzVkzABtfLY9MkMCPYOjO2ckAaFF2WqYrCoCtzfcw0J8zbC2+UtKf65pkuWqSOk3sTQZIuvjllLFoH+3RBHkPIKqdsnStHuGmaS1R6CKioKc2UwgFqip+9BJTPVeGSWL+vCHBRQ=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB6664.namprd10.prod.outlook.com (2603:10b6:806:2b3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 12:24:30 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6363.027; Fri, 5 May 2023
 12:24:30 +0000
Message-ID: <98eaaa87-ae33-5479-dee0-71e42bc5d798@oracle.com>
Date:   Fri, 5 May 2023 13:24:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/5] driver/perf: Add identifier sysfs file for CMN
To:     Robin Murphy <robin.murphy@arm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>
References: <1682329456-19418-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1682329456-19418-2-git-send-email-renyu.zj@linux.alibaba.com>
 <df63b597-4355-b9fc-6002-5a390b1a56f5@oracle.com>
 <12bf4a7f-e99c-47cf-e8e4-e2700db6c5c9@arm.com>
 <da55ef21-e199-79c3-5b65-d51edb2e754b@oracle.com>
 <6bb7eaee-2d00-46f5-89ff-95133aea9a5d@arm.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <6bb7eaee-2d00-46f5-89ff-95133aea9a5d@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGXP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::14)
 To DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB6664:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d54c51b-39fa-4e6c-1317-08db4d63ace0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fcz1y7Z8S3YnzPcc0QxtXZNSmmn4FYO27onTRoNt22P9UOc8dnraYvM8l/J8Jqo0Lvt9LZ6j2cydHgkHwYfv+QFsC0N4xkDIejC5H/TNmcDMxWsVL2mA0GbBeoTkZWSe6WLgn0WpmFasHIs2GOvKm6L5sEIom/STsrUXAuahzGDudH+pAPe2F8zS/KBaCJa9lsmyG6taZiHOcU68sGx8cZD2c7fzVuovCH9DtTmkhIQwc5vdACriZGH+UWPnEQ2VSgnH7x8A4xdD9JH3ldEbX5h9Af7TxkrufHwTWHHCC+1sasOZWvETlOoxKb/b4HIx+slJybTwrK///xDqs46UEMzWqQLmMKRPAUWkDegjp16oy25N0yiQn/ZF15x9g0UQNMamkD47/95bxz6nhTvZ+0pERnHY9R4yzi4vJMnKhOpEDmNpTbcggLhy9e1VuVyag5CCQap0Grx3PG2SvvIDQwC7dvI+bo348dVnRkHhCI6+tXpv0/qHimP6VoivkBkR8RmbVxJH0+GyH0Gt+Tok/9Ihdn63NDrWnxXyAwaZEHjJnVZk+cg4ejRYLP47tMd63zBtvsqt1AVdhC90eoqwXRKE2osuH2FtDx3k5tptwirV8imhGlx13yT3JoBv3oaHQh54rFdFw1+6FWdh0VWVjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199021)(31686004)(36916002)(66946007)(66556008)(66476007)(4326008)(478600001)(6486002)(316002)(110136005)(54906003)(36756003)(6666004)(86362001)(31696002)(2616005)(53546011)(6512007)(6506007)(26005)(8676002)(8936002)(5660300002)(41300700001)(7416002)(2906002)(186003)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlZtYzFlZzFRUGJEYjVoZDF3WW13cE1JUHhldGVCcktYUzdFWGZGcW1zZk1h?=
 =?utf-8?B?a0ZtTDZsakgyRFExcFNidGVOSFdCMmRXcGVFK1JFZzVxbWQ2c2NhMUdtcHNV?=
 =?utf-8?B?ekNQU1o5Z2x6ZGdGUmxTRmhJTXNPZ0ZESVRKZmVPVFNpVE5ERTM5ZGF3UnBW?=
 =?utf-8?B?K3UrcWlVRDQwaFNIQkxmYmZMTzZpdDFtYlhvbEhKMTA3V1BqVkpVZXlWWE5K?=
 =?utf-8?B?RDdBYnF0bTNYc0lsanNlbnB2ajdWNXpQVEQ3ZFdGWlBtUUZPQlNtbU1wS2x4?=
 =?utf-8?B?cUFicFlNb3RFZzBkZkg4d0szU3dzdmFFd2tEc3JXekpyV1JQeHRkbFE4VU5u?=
 =?utf-8?B?MStQZ0RQR3AxWnNmbDM1TjRaNzExMnROQmFUc3ZuMHdyaEhCa1kxYzBPVHBs?=
 =?utf-8?B?K0lqQlRrSnVDRXNEZTY5RFZNcmFQSndyNVdTNm01WERCQnFGMkdZVVVRakVP?=
 =?utf-8?B?RjFJdDdadSt6WmtkZFJIL2M0bkJoQnZKOE1HeTlLT0pvdWtBUGpjN01SYWhx?=
 =?utf-8?B?WTZTMTZ3Mm1jcGpJWUxhR3h0T2hFQjN6NzMxSGpYd3lueTNPVDErRnNHSFg1?=
 =?utf-8?B?U3N2Z3RkVEh2amNYdGNNRFArZUJnVTF3cWN1U1BxQ3hLTitMQXJCNk41NGRH?=
 =?utf-8?B?alVCMTJQUVNXKzd5SHY3S002dmV0OFBiK2NlZnJiKzBUMzNRTDYyNTg4M2Yx?=
 =?utf-8?B?QU1lWk1wWnIreXViZ1l1S3RrNEtxblpBZVc3cDZSbmd4b3lmR2ZLNFZuK2RG?=
 =?utf-8?B?bkpXaWNydEVhNGRuYXE0Z0RObkxUV2wyd1FUUmJRUTUvbjJjTytJRFZPV1dO?=
 =?utf-8?B?d0RzeU41VWhhZXBub3hBMEY2M2NXalJPWUh5UE1FSmQxTmxHbnY1dis2SHR1?=
 =?utf-8?B?T2ROV0VPbzF4V0V0U0VIUmRFVGxoTXRoQ1BySjlMUGkrd1ZPbjJtWW94OWdR?=
 =?utf-8?B?dCtRaGF5RlBsVlNBQnlZa1B4RDNXTE1aWUlOeUdLeElqOGFZM0t4QW85NEtG?=
 =?utf-8?B?ajVsZnV2RzcrRGhwc3gxZXd4STJXVEZvV0pUWDBTRENTRnpZYVZUd3RuMmJy?=
 =?utf-8?B?aUxEVm5HMEJWVGRsY2FaUzRIQkw3c1h0NVFSa2s4V1JnaVFzd29OWmx4ekRs?=
 =?utf-8?B?RU9oeDhIVENOODNOYXZYNEV0SUNKdiswa3h3Zk9YQ3RrZlVpN2dYbHBRYnln?=
 =?utf-8?B?RkxOSk1uMi9tR0x4TlFzNFF3aXV1VEhKWkVTR013NXZ3bWMvMzdBUllaTGda?=
 =?utf-8?B?WDQ5ZndhdkROcGRFMTNUcW9vbkRkdjFOdzNjSDdabWlnaW8ySVB1OFpsY2hh?=
 =?utf-8?B?Z29KcjNRZ0dxYzJDbTBNODJHU1U3b0JOd3VMSk5IOHZhaFNNN3d4ZHVoZVJE?=
 =?utf-8?B?Nk1UMnNxUWlGME5wZ1FzUmh2REhwZjhGelFrYVFNL2UxVEc3VEgzajBRVzZ0?=
 =?utf-8?B?djkzWm1TSUNjMnVjei9JN0dFODVQTWN3bUlYUkFaYU0vYWkvNDVVRlUvTVE3?=
 =?utf-8?B?bWI1a2RKSmZDZVB0Y2p3TEFWMHVsdnhoU3p0My9aV2lja0kwQXdzV1k3SWdH?=
 =?utf-8?B?TVZQdlJ3eFF0L25mbTdYQURjY29jQVJtd2pMU3YxbVQ4WWV3bXNFSEM5Zm9r?=
 =?utf-8?B?MGZyTWlCbTkwZFVVbmNnT1Fmb1Zzajh3Y3Z6TkZJLzlONEZPTFA2bURlWUxo?=
 =?utf-8?B?WEVkTC9jaFNjYUl1SDEvZDQ0bjVBelFnWHcxMHNQYXBOS0tNRnI2UFhOZ2V4?=
 =?utf-8?B?UGovR3RnUlN1dlR3cFo3SndiTTdqU2k4SUM1a0UyWXhZd3dTUE81TW9LVkFN?=
 =?utf-8?B?N0NxRWR5NUpmWWo0NUw3RlZSdlFxUlNmS3lUaEhJSldHU1FEbGR4djdBUmlS?=
 =?utf-8?B?SFNCb2lmeFIwc2JYdXFNM2ZPbUF1QStaL2pqQUI5cXZCWlh3UWpBYWNkMk93?=
 =?utf-8?B?UjN3QWxia2pHWGdUeEpneCt3dVZ5NFkrdlpiRlpqWGNKL1F0bDV6MEprMWgw?=
 =?utf-8?B?YmlUeVZ0WkYwaTdPVmJ6d2xOTzJSejhQZGlyNU5FZVErREVrSER6dnhSVFpa?=
 =?utf-8?B?ZTJPWTlxdlV5VUkzQ3luYzJxTXFGNXNNbUtydzRXcWlCK3ZGaW9kU0UxRW5N?=
 =?utf-8?Q?erg67kPglnaqkGDCMCXjT1qs7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?a1gwZ3BPbnlXSVpKeGJkLzRQa0Q5M1M4MW95V0s2NUZRZDUyVnovTzlIcTlL?=
 =?utf-8?B?VlVXNHNPN24reWJzN3BTbHpFV2ZEbmtUeU5VNlQ4UDRhZThXRlVpSUxEejI0?=
 =?utf-8?B?QnNoV0R5OVgzam5yWWtrdjVXVC8reWRsL2YvekZ1QW5TOGJlR003OE1uNFdU?=
 =?utf-8?B?dWx6OFViSjI2UG5sMGh3M3dUV2poMTByQWthR0VTTlBLZGo3eFZzOWxhSFZt?=
 =?utf-8?B?ZjArUk9XV2xwZ2hWaUt5WVF6eEZVaW1mSDV5S3Rnc1J2K3JnRUFoeGRNRHhw?=
 =?utf-8?B?QW11UjZPMlU2SWFSR3c2T20rempQc2wrbjY0MjBhRmU0N24vYmsvV0E5b3B5?=
 =?utf-8?B?ZVlHcjhaeW5GZUpOYythVzRpdy80dHU2UmhJMjVQTVF2c3p4S1ByM1kxVHBN?=
 =?utf-8?B?TmhhcGxDV3J3bjNuQ0JvOHZaQzh3dnFXeE01cFgxa2N5NXRKeVd3NnZ3UGhx?=
 =?utf-8?B?VzU1RDhqbVl4aDdzazB1L3pORWRkNDU0YlFlQzN1QUxWTFFNODhHOVVoYVNU?=
 =?utf-8?B?Y3VhUmFTMFo5TjBqZU4zY0JjNlk3c045elNqbUZMbEVSaEoxajlLeE05dFZq?=
 =?utf-8?B?OU5xWUpsMCtwNHdveEJ1dlNEbVJvNDRUU1ZhRTZpcndaeTdMT3VUUGJ2TzBs?=
 =?utf-8?B?dVNCb1MxcGZoaXlYL3lDbURjUkh4bS9HSGg5U3pUWERwY1d4UGZONGU5anVq?=
 =?utf-8?B?UmE4V1E3czdTSG8yTVpnckdCUmRFdWRoekwzV2VYSUluTkphSnU4bnp4VTJh?=
 =?utf-8?B?Qmt1NGppZnRpUFR1Q2FkNDJkaXVJcklQeFVLU1VBeHNFVGwzNXdtb0RGV2Zu?=
 =?utf-8?B?M1kweUgrVTdJT01teVB3aTJUcHpsRi9BYTdRV2FVNUpJUjlKams3TzNMUlZN?=
 =?utf-8?B?ZjlKbW0xd042bEdGbk5SY1JUOVpMUWpPMnJUVm0rR0EzZUJ2cmMzWm9Pc1NQ?=
 =?utf-8?B?SDQzWG14TUh1YitVdDMrNHEwSjNhVGNsMGdBOVhDRGFUWGZOcGVERzE4MThz?=
 =?utf-8?B?UDJOTHNkdW1jQTNkMy9iSU5XVVlJM2RMRjNuTTlxckZmZ2xLYUdTR2NuRjJD?=
 =?utf-8?B?NHpOdmJIbjdTQU9JUkFhWThKUEpFYmFnaWE4YmkwclJ6ZkpheURSdG1Razl0?=
 =?utf-8?B?KzVzRXR6anZqTGN4Z0xncVU5SHRTV2lqMEhBZHlnM0VVSEVUenF4dkZtVFpW?=
 =?utf-8?B?K0JSdXVrTER2ejJiMERGMVhycDVEOHJVSkN3clZkaVJ2bTM5Wm0vdVE2Sm1m?=
 =?utf-8?B?aVhleXhsN2VEWmtELzIyWE56ckNFOThHcGhvbE5vUXNsOEE0N0tOU0J4aUxW?=
 =?utf-8?B?SzZOUnZzOENVQ1RPNUxrSXBIajFTVXI5TkRXVUYwaVFqR0Npd1ZHdU5vcENp?=
 =?utf-8?B?Skp2aTlOcGxNMVhGeWpjbWdRTjRkNUY4TFBnWFJ0K0dBLzlWUjRtWHhmUHJY?=
 =?utf-8?B?endEMUVVUlZsdDVnS0w3d2hoNFpCU0YzOGQ4NEdWR2EyYXRvQld0dmpjYzlP?=
 =?utf-8?Q?Qjtgb0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d54c51b-39fa-4e6c-1317-08db4d63ace0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 12:24:30.3867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQhYCnWe/vOr/Cra1+cGXRV+mC4cx1S3KvSItsW6qS2sffa1H0SyNBLFt8LcYOrbRu7zbWYqkKq7a8DIzh6dMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6664
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_19,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305050102
X-Proofpoint-GUID: 6O5zfVXUsd-PK2Kk3BMsIjBvlfE5oj-B
X-Proofpoint-ORIG-GUID: 6O5zfVXUsd-PK2Kk3BMsIjBvlfE5oj-B
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2023 13:15, Robin Murphy wrote:
>>
>> ok, I see, that's what I was asking about in the cmn-700 JSON review; 
>> and from what you say, it is not the case that we always have the same 
>> events for every revision. So we need a more fine-grained identifier.
> 
> Yes, it's mostly just a case of new events getting added as the 
> microarchitecture evolves over the product's lifetime,

I might have mentioned this before: Currently userspace matches both the 
PMU sysfs name and this HW identifier for creating these event aliases. 
For fixed events - like those non-IMPDEF ones on the PMCG - userspace 
could just assume those standard ones are implemented and not need to 
check the HW identifier. Maybe this will help with scalability of JSONs 
for CMN PMU implementations. Or even HW identifier wildcard matching. 
However, as you might anticipate, we may need to add some sort of 
userspace support for times when HW implementations get messed up...

> but there has 
> been at least one event ID which had a meaning in very early versions of 
> CMN-600, was subsequently removed, and then got reused for a *different* 
> event a couple of revisions after that.
> Thankfully I believe those 
> earliest versions only ever existed on FPGA internally, and the TRMs 
> were never made public, so upstream doesn't care about that specific case.

ok, good

> 
>> For DT support, I suppose per-revision compat strings could be added, 
>> but I would not be sure what to do about ACPI.
> 
> We know the version from the ID registers, that's no problem - it's 
> already used to manage visibility of the sysfs event aliases. In 
> principle we *should* have a model code in CFGM_PERIPH_ID_0 as well, and 
> be able to compose an identifier exactly the same way as 
> smmu_pmu_get_iidr() does in the SMMUv3 PMCG driver, but as I mentioned 
> before I'm not entirely confident in the implementation: I do happen to 
> know what codes have been nominally assigned for each product, but the 
> TRMs claim otherwise 🙁

Thanks,
John
