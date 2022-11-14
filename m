Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9D7627FAE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 14:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237668AbiKNNBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 08:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237695AbiKNNBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 08:01:15 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F82A29343;
        Mon, 14 Nov 2022 05:01:12 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AEBfeGR017219;
        Mon, 14 Nov 2022 12:59:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=CSF38ocPhOmE+FPP3AK7nI7CFTIZOvE9aJCgoL67WVw=;
 b=yssw3hchC+Vou8NqnAgP/2vKLfCtuk+D5XTtZrh3ChalsMt4II9aOqK+AfvZBvuBYBA9
 3hKeyubXtKibD+r81hyIeqxre/MF7MtdS4do6zV6AhrnXJxyCCAiEr+L3R2ZUT6m50bn
 DME8QvEvHVek6Xd8BBy+N47LqJvFnZTk2ckyP8eGrow1B9JDqZHVi+x2n9ZYOYfU3CKm
 kSivuNs+7f+QQVzaDU8DjOMKQuOhKiGAFk1oVDIUwKTyNWJvkG9n1xui3s7cfU1hOcCB
 nGlgMh+FxTmD+GRTMqE7h0X1AoXWRCQ5t76lMbl6hf3hjz1oRT6L+AlldQjByeZMPC1B vg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ku1ng1vta-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 12:59:36 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2AECE9F3013280;
        Mon, 14 Nov 2022 12:59:36 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kt1x43c53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Nov 2022 12:59:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byPEQfy1eK1fV82zI2CWrVw362MYSwvKYECaD038E32tAkB9q/5w77Lxr3KgtJWkpa4VCbb78sgqduO5hDcMfKUzuGYnVI4FiBvagtAliRS4OU7sct1SIvSOgQYWrPIr5DF6i//79Vzki+BHWvsa7asUuPe29X/7KKyuivAnnoLOzPU5v8BjW9PaVgpjICcm11LBUdmH7hE2mmurMbwvOn0jVYUCeKkuZ7NYn6Fo6jgwhMlB3CpkehoDS2g/4DnvlO/f7kO1Kc9u/qmN13ODm/VNfMUwzSx82BuZnO57GpwwmPr/NQTexeA4H9I+VvjTONfHcCi0fU/4eCeBqSgt+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSF38ocPhOmE+FPP3AK7nI7CFTIZOvE9aJCgoL67WVw=;
 b=IKhC9JNoeX5lsamGcTyWYL6F/R7a54XnEZNBsBiUIUtcvecT5AjGERVLPEfjzyAp9ZKG8fry+FJl29gvGk01TKmzf42RpQ5P/TtiDdKu6mjkRzkCHpRjqhX58SdB1l29AkfvgUBUeRrkURz2hMz45Mk+4T0ynqRt2BDTbpG0AjLvWjY9LNsMAbX4ipkCeSmeS/tWIpJBkwrz2UDyjp39homV5Ii/5LNuuvgqLnMVEQNWXQ0GklA56upyWneY8dFS+svNT0hQt0CiAvrqFxEiXCXeOV7yVhs5Urg38g04a0yYWiZ+rUFoQ4hsebJ3SuGyNH6voNLitTBm6CxsIcV8EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSF38ocPhOmE+FPP3AK7nI7CFTIZOvE9aJCgoL67WVw=;
 b=vAd8I4xk35ux9/EuBMlWvpOHoGBbUIWletHDiLzaPe8SUrOcnlHSeC/7QTJpoRgOrqfM6r/aPjjPe84TS5SPJDnlUqoJSf95egn9gayUFWtU2XZBF6ZW+jch7OImFKFf30eACDebWF/a0o7RUSEtBoJFpEUssJ0tIDX912/J32I=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MN2PR10MB4208.namprd10.prod.outlook.com (2603:10b6:208:1d7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Mon, 14 Nov
 2022 12:59:33 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::d0c4:8da4:2702:8b3b]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::d0c4:8da4:2702:8b3b%5]) with mapi id 15.20.5813.017; Mon, 14 Nov 2022
 12:59:33 +0000
Message-ID: <590ff032-d271-48ee-a4d8-141cc070c335@oracle.com>
Date:   Mon, 14 Nov 2022 12:59:30 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [External] : [RFC PATCH v2 1/6] perf vendor events arm64: Add
 topdown L1 metrics for neoverse-n2
Content-Language: en-US
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Zhuo Song <zhuo.song@linux.alibaba.com>
References: <1667214694-89839-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1668411720-3581-2-git-send-email-renyu.zj@linux.alibaba.com>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1668411720-3581-2-git-send-email-renyu.zj@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0456.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::11) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MN2PR10MB4208:EE_
X-MS-Office365-Filtering-Correlation-Id: 36997523-b88d-47eb-26d0-08dac6401356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pl51h6+8DQWZzZUUP/a2kttHzfKRCLYh44lFq4hLLW9nz01ZXhHFG7RWBvHa5JCZHAn51lqPWnvULCDB0/9/LHsr2Ap14Il7VPEaoZFE9rWCO8vGW93BvY5wlldSe/exwgzKEE3ldu9+iDUA5Dn2ksIXDAJoSJpePdRPtXzNKOvs7b7MicJXo8hzj2Qb7iPZcx0fYRdN+1Ounk714OzV3K+irsub36xC0+1ShtcklOwA9boQQH9z8+hWcKHD+OzHLD5Qlns5bgwOjPEhIJeNhiXQWnsBMKwbddgS+rhSF4b4PZrJl5c/eIg/ghJ91iMbZxpBq6efMIX4ww016hEVL0X89y+36jsTdag6OZ9w/b4AjSGPT81g6BigjACLg3gRzLUPzFouFOerpyabqzf0H4QFBOvG8dll/1G5FNHbiXEWBE6FqPk1jYvSyxJTooavLVGUUkXLBMzyJaAy91iee28yIMcQSwUMYNKY1R1MR+vXwRKdou0p64tuhkYEjmdDJcQRz6Ksqh5DchezEBK/L31n2UAOY30UvTehW8+H38UE0X8HVosKvVMXuspem8sErxO+bly+CDMlhiTuS8KMTbf6KPcptzMRoJ79yQMIGBoptd+roEPrvZcuqnXJ/ri6U1p8lcqjJbLo/WuFhDV9vpzn2yT10/BJI8gVAghBGdtbHxiz9giNkahCsUPs5dp9EQemrw4y+yI91vqixh97MCJnisBJnUltZVtwMnYgHvq6j/ArBLQ/pbhL1q/pXWiYAQZrhkQhxzjIPfuPx6BqyU+oinRYbAFnbSQkRCk7JUryj/j/+ZVqRtCn0XpfvyDq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(366004)(136003)(376002)(39860400002)(451199015)(6512007)(7416002)(8676002)(5660300002)(26005)(186003)(4326008)(8936002)(66476007)(66556008)(66946007)(2616005)(36756003)(41300700001)(316002)(53546011)(31696002)(38100700002)(86362001)(2906002)(478600001)(6486002)(966005)(6506007)(110136005)(54906003)(36916002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjlIR3V6K09UZ3BCZFR2blB5WnB5V01vOTJPb3BCWjNOYzZ2N3VsNk1zS0ti?=
 =?utf-8?B?d3IvZGZDb01OUVFoTnVSS2FpVkZ6akMxMXYrM2YrbzlNTVM5eklDeGNQMGYy?=
 =?utf-8?B?SVJ4Tm02NWd4dGFXbUVVK1NiSGpobVlaTVBvL0lZbzJ0eXF3d1F3RTBtV0l6?=
 =?utf-8?B?U1d0MzBLZi9qVWhFM0IwK0dhbU5OMWZRYkxHQUQrVTVHQjBaNFhtK2V1Sk5F?=
 =?utf-8?B?RlpTQkdOZlNsb0ZCSHFnMUZ2eTlmaktRaWg4Z0FEUUxkZUdBVnJ1RGQvRlNt?=
 =?utf-8?B?bTF6RG1rbEx2UDFyc1F3K3h1MmJvNk0wYXFTVWpGVjdCTTNjd0NhTUFwNTdL?=
 =?utf-8?B?dEpEdTlqbktHYmdIR1AxNGs4cHNwQ3d3Q0EzVWlvOERSRGZha0dNOTNwRHcz?=
 =?utf-8?B?eE92c0hnK2hwbGRPbTI1ZHZWZk56UTRUYlg3aW1ORW5jS3p5RmZWcWJjT003?=
 =?utf-8?B?Sld5ZFdXa1MzUThVNHU2YTBRRFROOU1keXFhdzZhS01GZTg2Vkp0NEhKbms3?=
 =?utf-8?B?NUFxemRjVGZ0T0FBVk9maTZXOGk0SGdHOWlSOGZHdUZVZElyQk01UGtVaXFF?=
 =?utf-8?B?OWNBWURRMjJwKzFNUlR0TmNYQVQxajFKUWVORU9oeGo3anoxMldtd2pySG5K?=
 =?utf-8?B?ejVsdVNHeWFCMTE3d09jVlY1dXN6K1ZsTFlsVFg5MHV5SS9jU2s3MExnTDht?=
 =?utf-8?B?V0d1NllXWE1aZ24rTG1MWWZSekFEa2VKOHo0WkZvRGRhRXpaTVVkR1Jwam5k?=
 =?utf-8?B?OEdyMFpoOUZvYVpvaFdZalBWaCtUQXhEZFZYZ1BFallDMGFLUExvbmNPaXdn?=
 =?utf-8?B?T1R3Y3h3THQrbTRFYlgwOHI2Y2k3d3E2NDdHZ0hnR2NNS0ppZUtxK1p0dmlL?=
 =?utf-8?B?MXJKNTd1VHRqRldVbG41YWdONk5kdWxUeUIvdTRXWFc0Zmk2aVdhbnRQUW5G?=
 =?utf-8?B?RVg5UjJsbHRtcFh4MzdLQmJKSk5ZWldmeEpsUHVNMFBndmRKM2dzRjY1Z3lx?=
 =?utf-8?B?L2w0Q3pleWtIbG9EM0UrMzdYcGlNR0lrSGNGYkpKNzR0MUhlL21OZmhac3N4?=
 =?utf-8?B?dnRVb1VXRUNGVXM4UzdnR25SZFlSUzlsaHNRazdHMkxzdUhrTXZ0UzgxdmJY?=
 =?utf-8?B?dWtWTVJIYzh4cEZ4cWpjY1lVdUJJeWpRVUlNbUFqMW8xdHFjbFBZdUFjZ1kr?=
 =?utf-8?B?MVN1eWUydk1tQThlRnFNaU9rZC94aXN3WWNwQ1lCSXBPdjYxdm14enhGZHZL?=
 =?utf-8?B?L05uU1JuMmxvQWk2V2JOOXVBNDY5MWxjM1F2Z2J2KzFVWHlqdUtNcGplTFlm?=
 =?utf-8?B?QVdGVUczTUg1bEJ5SThITGJ3YXdPZ0k4dTNBQktWZE82TGVtcDBWNy9MbXEx?=
 =?utf-8?B?WVVzbkZwUlY5dUpTdk1ldHZ1dmh2ZktrMmFscGp2dWtKK0JxbDNFNXBHMlgz?=
 =?utf-8?B?Y05lMnFDaTBnSmN2RkNqR0FsRXVIc2FLbWJsR3J5L3BZUEVjU21vOXZ1WG1v?=
 =?utf-8?B?NHlHc1cxazJHVEg5WUpyOU8xY3V0alg0eThOeGVBZU1YN2JIOTdXREJ3WGVE?=
 =?utf-8?B?enRwV1RMZFVNRUhGYllLTlo5MzNoNXhPL2kwbWtVb3BtdjhxSlZzU2VXc0xU?=
 =?utf-8?B?c2FROG5WL0hxZ3ZUalRXR3ZFTWtOOHByOXV5T3hDLzdNbDd0WnlOTyt3YXVz?=
 =?utf-8?B?RXFGZXpxNHBlYktUcWZOdFVzTUgvc2t5Q3FpWThPa3l5Zk5UWHJmRjY3citC?=
 =?utf-8?B?UDJ1amtQQXIxZHhJMjlDeVQ1cFpwc3ZLUVZtVnNDWE9LK0JGRmRnNEkybXJt?=
 =?utf-8?B?c2s0NFVlZkttSFF1Qm0yZDVDZWZPaHI0aGdacXZZN3VuL2k2eDZEaUZjSVc3?=
 =?utf-8?B?S0VwS2FzK3ZKTDJReVJKdGxDcHovNXRKOWtnTkNnL1RXQis4TTZYakRtK2Na?=
 =?utf-8?B?QXNITThYc3Q4NlNUckk5NFFyVXJ3T0FaU1dyc0lEREpmR0FscE9uV0RKYzNM?=
 =?utf-8?B?OGc4S0NuSTVZTGZNTkxKYVVtYWJXUUJmaFpocldKaWlONWFiV3hqTEpVZjEw?=
 =?utf-8?B?WWlWRWVoR3lMSURTNGFFKzZqTzBVMmhneDhYYmJyK1FuWVdFeWlpdlZRMk1r?=
 =?utf-8?Q?KP+UYOUSHB8+upPS9KYuxts3w?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZjR2YWVxZG9wSWo1UkV1YkNuY1hsYmswWXdaQ25IK2dIUFBtL1VjL0N4eHI2?=
 =?utf-8?B?cFJ0UlY5MWYrU2taZXhPcCtHNDM2K2N5bEEyUm55dGE4cm5Xc1Byd0pTZ0hW?=
 =?utf-8?B?TzZyaTlwK2t2VnlGaXBjZ3hjTUxzY3g1WVNnVjMvbXJtUGxCT0F3UjI5ZjZQ?=
 =?utf-8?B?NG1ZQWkxQzB4WSt4OUZVZW1LNXFNYWtPVUx3bTRiZko3b1NOWlZIRVI1UndD?=
 =?utf-8?B?WDBPVFlnQkEzUDhjeHE2a0d2NHYxc0ZWd2hiYjlyMzlacTIrelg0cDRndjgz?=
 =?utf-8?B?RHdPQTZHaFFjZ2h1WUFvRTNUdGZQN3RRU3B4bXZ0U29rN01pcFkxTXpSak53?=
 =?utf-8?B?ZklRTFVGQUR1UVdnQXhaUWtObG0vbEhkR0xadFVkVXpXVzVKY0dvOFVXVDlC?=
 =?utf-8?B?NWFPaGxTdmNBNElnVDJJaGxSbCs1eEowSWwwd2RFQW1CK1Q0aVJqWXhqZ3Ja?=
 =?utf-8?B?S2E0Tk9uTy9pM01naTYwR3lYU3Q5UW4vYjRDY1VPazJ0aEdZaGhCTlNtekdw?=
 =?utf-8?B?NlVyUnhtbDczREpXUjhWYUNIcHZQQXA4YjFmdkRrZzJOMW1ZaURHdWZhRGRu?=
 =?utf-8?B?RkNqc2wzakxvOVVZRExQSW9IVmJCK1l1QW1zaWc4M0xIbFR0RzR2OWhwYlcy?=
 =?utf-8?B?TDBKMzZkalZVdlZNNnpCTEZpaVIva0NobVNxaFFLQTc1U216T3BhWGVXdkZ6?=
 =?utf-8?B?UmZXaC9wdWMvTzFacEl5cVBnUlBmUm9XWjYvM1MwL29qMUJEYzJYRDlxY2w4?=
 =?utf-8?B?RHV4d2gxaU9SNHhFRjVyTDFUeEYzdHVYQkpaMU9kMVZPYnJxV1Ywc3M2SjFp?=
 =?utf-8?B?TU1qZzZZalVvd25pNjlTVEtnZjVBeEt6NkZrcnhzYlI3N2xRNDk3QnlCU1ZN?=
 =?utf-8?B?SVVVMmxnam5KOFZJdzZ2YnlCUXUySEk1UmFjbDNFMmpNYnVtVjBpWVZLQmYv?=
 =?utf-8?B?Z2EySTFtMmlBVDkya2VKTnRVS2pnVkF3VXI0ckRFQUl1ZzJUUU1GNVFieEdz?=
 =?utf-8?B?aFJSeGh3UElnb3RTTDduMVl4dCtCUnRQN2IrQTl3cllza2pIeUlqd2h4aVEx?=
 =?utf-8?B?b3JHUk93TWgwT2hSa0hwWXNMWjhYbHNTTVRKZGFHMUpITjQxOWJtZTZjRnpq?=
 =?utf-8?B?UmlLRXM0VlhYRGxvb0RrclUvdXFhOGNNV0dCR01QQ2pYNytYbS9nOTBTdktX?=
 =?utf-8?B?SjNxVnpLZ0x2YlA3QXB5Uzh6NU1SRXRhZzM1a2wwY0hLcUVSeGpObUMvYitP?=
 =?utf-8?B?YXNDRzZsbzJNOUFrYTg0akFIWHV3bVM3VW1Jc1Q5NFlhUXdEWEtWQzlBTDB2?=
 =?utf-8?B?UTdlblBWckNqY0lEK05ySTc4RlQ2anhBa041NXJJYUFrMXVGa1VoRVRTZXUy?=
 =?utf-8?B?K1RsSVpJUjA4alBGeGFvekdtTDNKd2xzNmtad0k4bjFHTGpXWkZreWFld2Ja?=
 =?utf-8?B?TnJYRHltYWd4bTNBWkFtbk9VbFh3czZkZUxRbDljU0NqblJKSFNkRFZSM3dR?=
 =?utf-8?B?b1BVYVNiR01OME91cmo5bTBNb2Z3cEhyMSt4QjIvN3NvS29YODFYTWdyQUQ0?=
 =?utf-8?B?NE04L0prTit1SVFoemxOVmdqNDcvS1V6WE5UN3o1SXkyK1RiMkQ0Uk1DZWRq?=
 =?utf-8?B?bkVEQTZSUVA4Q0M3TzhuR0Fxb3cwQ1g0YWVmbU92Tno1ZlJGQk11THdINDlQ?=
 =?utf-8?B?NnBScTJFSGZ0VThud3oyQTBTYlkrM01OVDZ0NHRReDFzYjdpdWY3dlV4TDBl?=
 =?utf-8?B?RjVuUDBJTjVOTVh3KzQwSmVIUmJnWjVNbm9EbkN6ZG9uY1hCWmt3WUhTdWEr?=
 =?utf-8?B?aDk4YTVlNjBaOVdOS3NhNTZuSGFGRk9xbVVxa0tsVEhxUk9pRk5HaGhLTEhV?=
 =?utf-8?Q?ZR37FpgITn13S?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36997523-b88d-47eb-26d0-08dac6401356
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 12:59:33.2997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rPwSFwF8ty6f54X/Czif6cmdXgBI4gOGo/u/zD5yzbZ+jYpt0LB7YxcPYn1UUqqIlsK4RiDV38PNLpimhPxlSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4208
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-14_12,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211140093
X-Proofpoint-ORIG-GUID: Wc01msYbW7CuCicBPOCZ2Cx8VfzRgFmT
X-Proofpoint-GUID: Wc01msYbW7CuCicBPOCZ2Cx8VfzRgFmT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/11/2022 07:41, Jing Zhang wrote:
> The calculation formula of topdown L1 is from the document:
> https://urldefense.com/v3/__https://documentation-service.arm.com/static/60250c7395978b529036da86?token=__;!!ACWV5N9M2RV99hQ!Ll-Jgvfs0LitTCU-hC6i6BKBVJfhke-pbQq2VoO-gmuSAcglQ3ZqMVMd2r0An_5a3ZDPYmn8zXuCrpUbehwnLHplVQ$  

So since this is a from "standard" document, did you consider putting 
these as an arch std event? I think arch std events would work for 
metrics, like they do for regular events.

> 
> However, due to the wrong count of stall_slot and stall_slot_frontend
> in neoverse-n2, the real stall_slot and real stall_slot_frontend need
> to subtract cpu_cycles, so when calculating the topdownL1 metrics,
> stall_slot and stall_slot_frontend are corrected.

Is there a reference to this? It would be indeed useful to pass a link 
to the n2 doc as these metrics are not part of the arm64 arm. At least I 
assume that they are not there.

> 
> Since neoverse-n2 does not yet support topdown L2, metricgroups such
> as Cache, TLB, Branch, InstructionsMix, and PEutilization will be
> added to further analysis of performance bottlenecks in the following
> patches.
> 


Thanks,
John

