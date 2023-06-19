Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E71C734C1D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 09:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjFSHIm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 03:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjFSHIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 03:08:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D90F4;
        Mon, 19 Jun 2023 00:08:38 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35J0xCSt028503;
        Mon, 19 Jun 2023 07:08:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=ZQ1u81EoO/DwMf/XjEbD1d4ha9rq4ck4DRT0xeGndWs=;
 b=0TbmFPYxMFnnaF60arrZzq7x+cJfbJqx44vnI2AhTVCMKFnTcl5ASrYI4SzqymBjvJ0d
 41TRew5l3juQfTLnupCituk+nPPDtpaK5fhBnWSeR94xnLMLT7VOS4CwY3W6m6zouuPM
 G8lB1dmW1uvU9zxs8Zyl0rsdmXfAR2WfJZjkDHuS+BVbZWw81qjoiYzYtsKBSu6b7nYY
 pfg4a/Z2IZB2ULzUQjXAEkjMD/KRgKNauVXrqr6st1J0KbOhhwwwhPJaH1yyV70j+ggz
 70Ju85IP4M6xA1gKQwungzc3GQtdbRmtc3HntCF6P2DS23VghRy4ZgRe51n5PvJ/+oec pQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94qa2177-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jun 2023 07:08:17 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35J6Ujtx028897;
        Mon, 19 Jun 2023 07:08:15 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2046.outbound.protection.outlook.com [104.47.51.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r939900pe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jun 2023 07:08:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIktOS1XwJSfsrnvckZ7PfjbRlfG71quYYJftLbl7wEGMz0IqKoGy+m/cxosrSwkYREFsWxt1z2oTp32py+PiXK5LSsoYvbwUvvHNoJmSkVcYnvHkCespWXsyS3NVqywVnxQNZgwkbWBGAd8ntYoWYyYSj3GfIY8zglYrPAZf4GvzqXr5COoUmuZ16Ssqscoxr320gaC0S+bqWVwOImYISxKBSgeh54M7N3ohmY1JInWapJBe3O9+x9kLO5ZWSlmsSp8h2LWxYjOPy0rJqvtm1QW1Po/n2CBZMWoUM05n78pcOm51rh45vPFvibkHufHgNZ0CMCgA+G0LojTJS5GZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZQ1u81EoO/DwMf/XjEbD1d4ha9rq4ck4DRT0xeGndWs=;
 b=VowgYV5/557X52+DNlWdxj2O5bdQ7nxkRxy21wTSyCWqRMEZAY0yaBs6dto5gSi1KV+Nr+J0xl7l5wFdWz2efBIimI6EgKGU/giVNwvNU4YlcZ75qEhZ1b0mYhr/0q6OEtIp1QEVebpVmWQj+Az204tObZvuQUdII94JrAlsYuZSkn2H0JmulHDEXdeBaEnNBJhflcx+CfkcrXu9axWXm8Oqy0fJJ17jM4BPpAcsz7pofDkCfd/+8qZX0wei52U8jRCEaWNl0lQkqZghZsvYslXb2nUEXk65eLlWk6ddH/YFKhuU4hIeaXrO6tcOCm4IDbt574MStA4C8yMR+qPfgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZQ1u81EoO/DwMf/XjEbD1d4ha9rq4ck4DRT0xeGndWs=;
 b=WKjJqOBoSQVdsat1dT8yechW3shljmGXAoiDWw3HVChUEABcs9ysmSq8e96bZjimJUyPIH/Z7/NsUeL0A7piH9hZkG/KXLdvp+rw+CIN39HJpEac3fn3MImEANwvorEWwqXxWbpW+kgARj95HMdVfXnsBRxBgYBE2jipgNsDBB0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB6577.namprd10.prod.outlook.com (2603:10b6:510:204::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Mon, 19 Jun
 2023 07:07:55 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%7]) with mapi id 15.20.6500.036; Mon, 19 Jun 2023
 07:07:55 +0000
Message-ID: <d1ab4947-6bdf-2b9c-5b26-52c572611ca6@oracle.com>
Date:   Mon, 19 Jun 2023 08:07:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 2/7] perf metric: Event "Compat" value supports
 matching multiple identifiers
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Robin Murphy <robin.murphy@arm.com>
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
References: <1685438374-33287-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1685438374-33287-3-git-send-email-renyu.zj@linux.alibaba.com>
 <c1d8ee9b-4839-1011-4dad-c4777d8f8224@oracle.com>
 <452e724b-2a2c-52fd-274b-60db7a7f730e@linux.alibaba.com>
 <c4b2fca8-602d-9c76-90a7-3eafd92da8bc@oracle.com>
 <76fcb062-61a8-5f90-b39d-b5fb6da35652@linux.alibaba.com>
 <5f38ef6c-8c50-5df9-19dd-c3c9fe590452@oracle.com>
 <e4be7189-a1ba-7758-bff3-e7b8d8ff1419@linux.alibaba.com>
 <892f57c7-8ce2-634c-26f3-4d4ab8b2f2ce@oracle.com>
 <079d7920-2030-2e00-a833-5ec6d450f7dc@oracle.com>
 <552eebae-76bb-a2fe-ccdc-11e8a01717da@linux.alibaba.com>
 <045a49c9-b9ae-bf0e-c4be-858d905bcc55@oracle.com>
 <7c765e0f-ca76-d212-0496-f9c56369e389@linux.alibaba.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <7c765e0f-ca76-d212-0496-f9c56369e389@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0554.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::9) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB6577:EE_
X-MS-Office365-Filtering-Correlation-Id: ba75b6e2-1904-4bb2-f08c-08db7093e775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dj9B3A4MNEAeOinM9c7SLd2LKdwV3BriQW9oDh3zaYQq9fPaRYltDPYjWz9sMmYmfQSW+RbPh+ZQ/FiSyv29iZ/cNbNurnRoXfAU9jcSQ7SuIsjzMZ6P3nHsRppCJVYq0IuQ6PQ0IrcC0dGt7yxyswmBInEeO69gEBfV6WhQP5sLSHJo/DLFvpj2g/2ZGwNOYSryranJmyoJvwMI9DaL9580SVCc0saw9syXywM7j5UUoFIQ2CXRtsa2D2OVKOcNUeXglnsUm7bBWGKyFLoFDOOWBQyiQj5GpBfe9cMnXp8GQo1nFfu3mxgjlzYH4bWeKazhQ0sGPlhHFiLhDHSOqbu04lVlGd5fsBEr/VEgdM8GHMciulapw2Z+iTPG6sRFXHbBlSQyX+jDY6uXFntW3naHNFzy626IyqIlvXURGuxJsoY+so9rDK/rBYq4tdCKRGmgrwNpwXN+6goeS6bMO4Pd9XP6DaXVIw1Qb9Hx8VeiEIawKicQSoe6U8lC9znSCfkyrb4UckCxqUzaOLOiWZjEf8/99YFmtXCotdy4mxGMFzcXhO8HjPv2Tt0awBPHqI89jZPpuU5cDTOw3othM4Gfd0WkqKctkvTgWAAJGqyTmRY5ezwZiXtNps/+ofa6mH6zrwVCXUvhCEXNZ80kXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(346002)(39860400002)(136003)(376002)(451199021)(186003)(8676002)(8936002)(66946007)(66556008)(66476007)(5660300002)(110136005)(54906003)(19627235002)(4326008)(6666004)(6486002)(316002)(38100700002)(478600001)(41300700001)(36756003)(26005)(53546011)(6506007)(6512007)(36916002)(7416002)(86362001)(31696002)(83380400001)(31686004)(2906002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEovb21UVzVJNnZDU3lJUVRQdHI2c1A0YjVWRmZIQTZnRUtEYVo4dWZuN2JB?=
 =?utf-8?B?cFhCZWtmeXRrRjlZUk9aL2JVeVV5aVZHTnBibjFjeGswTEpxNklVMVlNVGVY?=
 =?utf-8?B?clN0Q0pidEJWTnRlUXFEMXBnQjU2RUROcEVTb3FzWHZpSGhsWTdhZFBqbFZN?=
 =?utf-8?B?Zml5T1F0NlJqTVFMSU1sS01iY0RJRmVWSEZmdXlHczhsdm1WWGxISEppSVJI?=
 =?utf-8?B?SUZVQklBbUhIUzJ2UzVGanE2dGRJYWN0bzJVQjVmM3N1Rml2THlhSTI3TXZj?=
 =?utf-8?B?OXdvR1IzSEsrVjJKZHd3NGZ1RzJXRlZ2NzJJNGVJUUhzUjZIbzdTRmxpUGJS?=
 =?utf-8?B?WHRJcU44d1VMc0hLeU5TNm10RFM3bEJTTXZTdkdlZVRtYW9IWHpNZldsSmtB?=
 =?utf-8?B?bFE4WHFEZzBDVC8xK2tma0tmcmQyWlBvTHRQQU5LdGdWY2pYaFEvTFZGNHFN?=
 =?utf-8?B?SGgvYmlCUDd4OHE3ZUcwbldiYUhwSzFsaDMydTZOMnVZSUIxRDkxZ3J0L1Uz?=
 =?utf-8?B?RVJoRmpsN0xneTUzTzdOQkNMaG5sMW5ZNjdoem5wWXBDdkpNU2xKa1NqclJn?=
 =?utf-8?B?ZUlVZDlwZlVqWGdtQ2taNDhMZmpQdVduUjIvNEVGendGR25XQmc5QWV2Uloy?=
 =?utf-8?B?bXNQVTNMZEVtZmZQVzhvRUNRTTZ5clh6dHBaMkRnUFI0dXlOdVJjNk51SmtT?=
 =?utf-8?B?WDcrZTc1VHBJVisxdlI0RVcweXFiK0tWYWhrWkNDem91c1NnVEhSbzJ3UWs5?=
 =?utf-8?B?VGFQUmVoeFV3ank2cUcrbWZJTU5Xb3JyTVllSDRFK0svQlFNdWJMaG0zSUJ1?=
 =?utf-8?B?U3JhT1FoMnFaVTZMeXdjU3l5ZUE2V25sK3hNUENHZFV1N1hvVWNKTmZHZzhG?=
 =?utf-8?B?eHhockNuSEZjY256WWc5UWsrZHdrakJENUJianZYbkxaT3FlbE02c1dvOWZL?=
 =?utf-8?B?a3dBWmt2S3FVNmVQajJIczY3SkRSbVJiMGVUcWxyODFEWXdNbVZPMFlONG1I?=
 =?utf-8?B?Z3ppNUxNeUhsanhmaExMREpzTjhzVlE3Z1lzZmIwWnZ4NEdncmY0U1VSZnF4?=
 =?utf-8?B?TGdVaUVTYXI5K2ZIc0JvclZWL0Z3dDM5eGlvd0g4SUt0cGEvankxQlBFRzhp?=
 =?utf-8?B?Sy9Sck5xSnZrSUo3L0VIMWxrb25td0tRVzlmQ2NrdTZJSFNkc0RHTXhiNWdV?=
 =?utf-8?B?MDBuUEZ2VFRFQnZVclNkMC90amxISWNMZWEzaWlidmFUWlR6UG9wQ2oyMThJ?=
 =?utf-8?B?aWNmN1h3c2xsek5VTUNxZ3VJalpabFQ0bTlvZDhmVUx4MnI1VVIzMk5lVG1Y?=
 =?utf-8?B?RVFpUW9wUzNJODhWL3EzSnFJdjUxMUpPUnNUWmJGaHVHbEhwWUludFVKS2M1?=
 =?utf-8?B?RVdMYXlod1YvODNsaDg1SlNsUTkwVnBmc1RHUHdIOUZ1Z2tsUzdJT2ZJNE5R?=
 =?utf-8?B?ckRXZ0RlSEo1NVlSVUJpWVZWZmtmdytQb0ZqeXZhZWY4U1pWeHY3d2lDc1dT?=
 =?utf-8?B?Qit2SWFlYzlSYmFON25vYU5sVk1QdzBiNCs5VFBjbFhiWTEzbkl3TFVFUzRz?=
 =?utf-8?B?L09SbDhtN25YWDFhcEFHTExBLzRRekV4VzJPMjBjdXZEa1p3RW1aOEpQMlpK?=
 =?utf-8?B?MUIwQVUvcEpTYlBlaFNqSmV3SG5nd3Vsb1l6YzhRdlpIaURiSXAyaWtBL3RC?=
 =?utf-8?B?Zi9OVERRcytGSndkaFVCUkhzdngrRkpFWXN2ZmRnMFVKOGNtZENSRkNtbUR6?=
 =?utf-8?B?YXpyVUJHQ3Bqc3FPWEpjWUpGbk8zZmY0Sm5FK2U2MHFsV1dOcW44d0JzT1Nw?=
 =?utf-8?B?RVhRbUIwaU44QUh1Y3p6aUlTeDFwQjBJQmY3REIxOEJlelVXeFRKSDJZdDl4?=
 =?utf-8?B?QWMvdGFmQ0tYRk5reTJMbENjcm9SZ1BydG11MTM3bU5kczhJTnlRemEwN3hN?=
 =?utf-8?B?WUJYT01zQ0NpandRbE1FMkZYSE8xZnQ2cTNadVliYjRqOG9KMEV6eFEvM2dh?=
 =?utf-8?B?bExQeDBtNFlrbUJ1bGIvbDhtcWM5clhGWFVuaXBXZVAxNE12WXR5TTRKSXhv?=
 =?utf-8?B?dENTN1lmVStyU0hra1kyWnA2dzNONjJYY3ZGeXZUWVJGVTlUYTc1cU1TcFdW?=
 =?utf-8?Q?x8m6smCMYM2h1HUO2DlMZLI5Q?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?SXhBNHIrNlVHbVpzUTFtdEp2emFpRWRnbFhUb2JCMERQODIwWUlXUUxSYjFs?=
 =?utf-8?B?bEdRSXd0cndzNXhCeW45S0xmdElPbWpxMWpEcC9YcmxuZjlJdTVIT0oyVDRC?=
 =?utf-8?B?N21DTU1sTURBY3lFSjEvazRrbjhKNWlpZU9SdFRFTlhtZWJ4S1Z2OW9vMGVp?=
 =?utf-8?B?cCt5VlVKSFJseUdtRFMxelBPcCtQcTFZQTZEV3NnZmhxdy9EdTd1Nno4Y1Jx?=
 =?utf-8?B?UDNibWlkenJ3TlZLQXJoQ2ZVYkpmK2FJOE5MVzRGRGZEYlFNUlMyM3c2SVBr?=
 =?utf-8?B?R25JQjBwL280bG5OQytRSXl4Z0Jkd05JV1RWcEhMWjB3RDVXckpsVzl1MTdC?=
 =?utf-8?B?elR5eUZQYWVwb04ySFl5dEtBRkZaQVk3bTFrTk9TVnpkVW01Vk1HTTBBRys5?=
 =?utf-8?B?OXJyV0N0RW9UWTdSUnlsbzdRaXhaeGY2NWlWUFBxVkxGVTZmVkFTYW5UdWZx?=
 =?utf-8?B?SDNZZkYxUnp4ZlVjenZMNzZqbzZBdlRLTG9ZV0hSU0VXWldSZlBRaU5jREw2?=
 =?utf-8?B?Qm83Y1Zzdmxqejg0N05QQXAwVVY5YThsK2xrQTdpUFk0ZHFzRFFUOGh6UnRq?=
 =?utf-8?B?OWR4RXhkWUtYTTRXMDk5V2U0VXR0Zm95WWJpZ1RvbVhxM1o5NzJ4ckZod2Fh?=
 =?utf-8?B?cUhlbGdLQnpFajZkZGpQdUpRTmpVYVQwK1BPRXpETjlNNEVTNzBOSEszZDEw?=
 =?utf-8?B?WUxnQ1lWdWVLU1hUV0o5aVM0bTM3aldQRTdQMStoYUJBUVZrRDYzQ2ZTMEtw?=
 =?utf-8?B?cjZuWnJLSDRVSnkyb1BLSWtYZHRVc1hucm8zc0FJTGR5azMvQTZqdVVIL0NO?=
 =?utf-8?B?UElwWGtra0lZVGcxY1dmL2Y3ZTdRbENsSzlLSzVXZjBsOW42UW1aM0ZMUCtZ?=
 =?utf-8?B?SGljQUVtYTY5dWxweDVzc0RJTlpFUzVJWmY1REZxWFpJelZXTlhzdVp4d0JM?=
 =?utf-8?B?a21Va3l1OG5KdGtBU21WTUNYdVhXcGpJcHhIU0hNWHF0MHI4OC9QenRSZUhO?=
 =?utf-8?B?VDBaNDgybFhyS21tNW8wYzVQYTkvOGUvTG9ndUVLOWlLL3hwUzl2aVA5K1JS?=
 =?utf-8?B?VExuOUFzU1V1eC9yY01IR3V3WFo0YW1BZjYzMU1WZ2psOVI1NHB3MEdVeWpU?=
 =?utf-8?B?VXBiaURiZXRIRi9YUFFuWDZsckJXZGNjemc3S1hrN1ExT0luQ2IrVG43bWZC?=
 =?utf-8?B?TDZLc3pheE1POVpHc3NzTGs2OXBmWHFuNHA5VDRyM1lXeWtkR1ZaZXI4dnY0?=
 =?utf-8?B?dE9kYmNWZnlQK0V4SG5ybTMxakN0dHZBbnN4cDlRdjdFTnpzd1hhUm9yQkhH?=
 =?utf-8?B?VFNmQ2RhVnFyMVAvMXN1WFFFYm9hT1B6Ymp3ckdyRVVsSDBZZDdicjNOK1Rp?=
 =?utf-8?B?K1JWUEtEWDVIR1IrK3RldXhDb0VoeHdjNFRESlRkTWhVN2hlTXB6dVFwcmw1?=
 =?utf-8?B?WERPUEVMSEluSWk0Z3M1NWtGTk5hTE80QkdGWU4xNjYvUTJ3Ui8xZFhWQytR?=
 =?utf-8?Q?f6klpg=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba75b6e2-1904-4bb2-f08c-08db7093e775
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 07:07:55.0933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pyVUAdg9xEzzfvQcrAx1nmT7kwO3+yO+0wcbhoZOaAyFvo4ifzNt7hW0BM/5eeVPjPsV79mMm2FfFgtcQTEYPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6577
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-19_04,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306190065
X-Proofpoint-GUID: XUASMc7VhBB9NOTuiiAzQXzdNX_boQPh
X-Proofpoint-ORIG-GUID: XUASMc7VhBB9NOTuiiAzQXzdNX_boQPh
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/2023 03:58, Jing Zhang wrote:
>> +++ b/tools/perf/pmu-events/arch/arm64/arm/cmn/sys/metrics.json
>> @@ -0,0 +1,74 @@
>> +[
>> +    {
>> +        "MetricName": "slc_miss_rate",
>> +        "BriefDescription": "The system level cache miss rate include.",
>> +        "MetricGroup": "arm_cmn",
>> +        "MetricExpr": "hnf_cache_miss / hnf_slc_sf_cache_access",
>>
>> So this expression uses event aliases hnf_cache_miss and hnf_slc_sf_cache_access - where are they defined in a JSON?
>>
> Hi John,
> 
> I defined the aliases for these events in the JSON file during the RFC version. However, I later removed the alias
> definitions for these events in subsequent versions due to the possibility of non-uniqueness and difficulty in defining
> their EventCode. But this does not affect their usage in metrics. In other words, metrics can use the aliases without
> defining event aliases in the JSON file.

Really? So how can we resolve the event aliases when we try to run the 
metric?

Please verify running these metrics with 'perf stat', like 'perf stat -v 
-M slc_miss_rate'

> 
> In the past, I always thought that the function of the alias was to explain the meaning of these events in the perf list.
> Or maybe I'm missing something?

Event aliases do give the ability to describe the event in perf list. 
But we can also run them for 'perf stat', like:

./perf list uncore
List of pre-defined events (to be used in -e or -M):

   uncore_cbox_0/clockticks/                          [Kernel PMU event]
   uncore_cbox_1/clockticks/                          [Kernel PMU event]
   uncore_imc/data_reads/                             [Kernel PMU event]
   uncore_imc/data_writes/                            [Kernel PMU event]
   uncore_imc/gt_requests/                            [Kernel PMU event]
   uncore_imc/ia_requests/                            [Kernel PMU event]
   uncore_imc/io_requests/                            [Kernel PMU event]

uncore cache:
   unc_cbo_cache_lookup.any_es
        [L3 Lookup any request that access cache and found line in E or 
S-state. Unit: uncore_cbox]
...

sudo ./perf stat -v -e unc_cbo_cache_lookup.any_es
Using CPUID GenuineIntel-6-3D-4
unc_cbo_cache_lookup.any_es -> uncore_cbox_0/event=0x34,umask=0x86/
unc_cbo_cache_lookup.any_es -> uncore_cbox_1/event=0x34,umask=0x86/
Control descriptor is not initialized
^Cunc_cbo_cache_lookup.any_es: 14361103 1853372468 1853372468
unc_cbo_cache_lookup.any_es: 14322188 1853360415 1853360415

  Performance counter stats for 'system wide':

         14,361,103      unc_cbo_cache_lookup.any_es 

         14,322,188      unc_cbo_cache_lookup.any_es 


        1.853388227 seconds time elapsed


Thanks,
John
