Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D6C704104
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 00:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245653AbjEOWhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 18:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjEOWhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 18:37:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15530A5E4
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 15:37:02 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FJsJIt015373;
        Mon, 15 May 2023 22:36:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=kPaYGumn6WiNbAo8NofavdEH/9/RDPWB7AkuuB07d6s=;
 b=o//NFleIaTSx4f+0iZ4LTSoRjN8HMmBboW+RiwzFBQdcVe18cSOaA6TXBXOBgZrS1+Pg
 VRVo6fejxnw+RvweW1rGfTwxedZ9iucLNhXhOSo1BFaPBH4S7d0nOh3yjsGxwJIMWd62
 5mK9rd4/ufBImZENLIVNTu8xvlNCWbyRbDR/5DbfFYKoCEx204HzRLqJHSzD9Gy9fg6t
 KgFWetYaqKNHcP/N4W/ObFA/q62cYAQBb5whpI2niA8eoZ3TBZmGzqHLpJXj7XssKcBG
 DaVizWnfVkjV8g/c8crz5r43ahF59ALZXtR9aCk1rHk7zVPEnjgjR1DTpaac4FZhClQ/ 3g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj33us3d1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 22:36:44 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34FKG1Oq022023;
        Mon, 15 May 2023 22:36:43 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj109hpcd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 22:36:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMZxW+Gd3yGJmAvL+I324S40DtebBkn2uN/d7BZoN7KwPzuqUGYbSY+TuvHA0yM0n+FKkByAxeI47tPmk+Le9kRb4I9ZBfy70TZ3k249R/ZXowbeURJ60D1WkGjM8fP36aXXS3zFfGVZ51o2ZIgYTjdnawgGAC1MUGl4Iugi5OA0HA3vrZQbdp1WaYAbfjcz8tu4BzCreoVIGtpnINqWBbAdyd8NNJMuw/jEqQCnjYsiQRqDvNhYTvlolHvZHeGiMt77/nOfI7E6e9v5jN3Rb872wFR80xtDRDp4VYO/r4JdPy6h3aRadOV8d0FPKNf+gUCn8yRcOhXNPTYlvcmZLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPaYGumn6WiNbAo8NofavdEH/9/RDPWB7AkuuB07d6s=;
 b=XKO98K0zaSLUlzUT44JbmqUAGIg+Cv+2A8hDGihzUqh3uPX5ZhurfVDT7mXlG/M6RG/eIzEdOjIYlOfpLUgkG4AU9m0cvKSq/63C2nmbVdOatEn/b3+fZRlwC0b0cjndegtaQeMOSVgmhd+OdNRbZhhygXOEpi6ld8RdDKltJvYFOzlVpMqqjG9RsjIg2eSk82RrTlX16nMD+D58nw63FoAbJ1mUg858l8ztct6leDXhCfaSD4am7VUMil2puS5IY4uGvD4Mtv0+6Qukm4MV1WV9E49HsUDnJiEvsvmwk6MQ4NkyqZjECGQZJHNnv/3lKIjD/wmX7mJCbq1drz938A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPaYGumn6WiNbAo8NofavdEH/9/RDPWB7AkuuB07d6s=;
 b=C2dthC8uBPoFj9MihEpac7IN71GDjq01lBxJ6CR4bP0ohlGfY4mQrR74IBO0VELYu/4n2lIaOkviia6LlT2v0II44ujdPldw7AZx3WaZ1lH1SI6XMir5QvwYjW+0Vd6WFr2oc5DrDZ/poyuB/cLWFivHLifhx2ukki3IRZvgkwQ=
Received: from CH3PR10MB6810.namprd10.prod.outlook.com (2603:10b6:610:140::15)
 by SN4PR10MB5557.namprd10.prod.outlook.com (2603:10b6:806:200::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 22:36:39 +0000
Received: from CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ba49:e5dd:6a80:37ae]) by CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ba49:e5dd:6a80:37ae%6]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 22:36:39 +0000
Message-ID: <2e78645d-73bd-5687-c272-bd6b5e67be21@oracle.com>
Date:   Mon, 15 May 2023 16:36:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] mm, compaction: Skip all non-migratable pages during
 scan
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Steve Sistare <steven.sistare@oracle.com>,
        Khalid Aziz <khalid@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
References: <20230512190000.103737-1-khalid.aziz@oracle.com>
 <871qji7zhm.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Language: en-US
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <871qji7zhm.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0041.namprd08.prod.outlook.com
 (2603:10b6:a03:117::18) To CH3PR10MB6810.namprd10.prod.outlook.com
 (2603:10b6:610:140::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6810:EE_|SN4PR10MB5557:EE_
X-MS-Office365-Filtering-Correlation-Id: 5356e06e-7286-49d6-8213-08db5594d956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WdQF45rX/J9732v5mBCA5QWjpfOANmbvIvlOwTXcS1hdnOeZLmidZqbsqJn1DQ1ZwExe3BGUDoX5qaqZ0H2rcyzd22euhOmVME6KWbmBWn6I/nEMG5Vg3qttMxIM2fKiqnTlFed4qhuw3XiIxEgmz0zO1qjP4fAclBH0bIlf8ebGZZF8mlRkRooUyST5d23eo73dkWIPJ4Vr+ArrRbYkApjgZ+NHVvYugV6VjqZi3xDlSeJQ/Xye08djTC+dvQM5bsPNyNIWwv/ftLnplBevgijcIemixlKGdu3401FxD8sevFbzbUVAPUmNNayAWSUKk9YdW6PsGv2DnKB5RBs5HD1GA/ZFs7+KzP4oeGVjkoMYRBKpgWZUgLuktDOAuLFQEPKZA2F7U0G/ZF7uN5Ojc8kZAtTvAmky+naZHFSJ0r0jbmey6rHVVjTYj1zaLON7c7Zw2iZosdGPWeVnAsuE8N01EaI8U3pYN+H++S3riGqgxakjmHVuVFQf+aFJsFqRgM27dftGcDPad7bRhLk19B51t5gRf3PzDbYR8EN9rBe7XSbiNzzX/e9bL7hopksk3meO9QQdskDaVy2YCBApdWeWhzdBYLF9wjxiMxm9NDnUJAqos5ik2DGrj3gnPvlDAp8hmW5Krkg+f1VD3DejRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6810.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199021)(36756003)(86362001)(54906003)(316002)(66476007)(66556008)(478600001)(6916009)(4326008)(66946007)(6486002)(8676002)(8936002)(5660300002)(2906002)(6666004)(44832011)(38100700002)(41300700001)(31696002)(2616005)(6512007)(26005)(53546011)(186003)(6506007)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFFUK1g3Uk0rU2xtWUhHeFR0cGZ3S1JFUlVXSW9KeUFuSGVVUjRVYkl2ZWda?=
 =?utf-8?B?MGxsb3l0WWxDU0ZseWhMRjFaSXNXby90L2Z4dU03QlRhNy96V1pZQXJZa1dQ?=
 =?utf-8?B?czJlWlE0enRaQytlR0J0bHZ0Sk5Zb3hLU0c5bUljYWNpSE0rN0FvMTlnOW10?=
 =?utf-8?B?K1RPZDNyak4vMXV0U0huWlh1eWRqbDRScUwraXNybW5RcmlNL01sbW5xTHpz?=
 =?utf-8?B?d2tpVkRIR2dDV2s5RXVJQ0U1OFdOZjV4T3RON0ZUd3doaFlLMnBEY2dvZTQ1?=
 =?utf-8?B?a3ZoRUg0YmJQc3c4cS9nWUlRWkl3YTViSjRHTFV0QUkxK2RPdlpKTnJ5Nkdz?=
 =?utf-8?B?S1p0a0pJVTk5dW41ZE02RjZBcldvQXlkWHhuYm1RbnlPWkNmN055cTZ6aG1r?=
 =?utf-8?B?UWR1SGU4eS9QZkJLWlpRd0ppODhjQmdndkFGYWVJa0FVQWdwbWVzZ3FQTWtG?=
 =?utf-8?B?T1l4NGRRWW0rMUE2RER6OVA0QWFYdW94WGdUSm5YWnpnVk1odldlYzB1blZY?=
 =?utf-8?B?ZHFXS2ZCa3NVdkh2WWNySnRYMVVPMDdsS1p0aXF1TXB5ZFY4MmxWbXRwUXJk?=
 =?utf-8?B?UDNROHAxZytUNEk2YmdJQ0lkcDczU0ZtWXNUc3YxWXpnUXBUUnBzWERTMG1t?=
 =?utf-8?B?dlAwZSttUy80L291cUo0ckh1eS9CTU55UkVCaHpQa3h6M2RFZGx1azJIU3NU?=
 =?utf-8?B?YmYwL0FnK3pKRXcrdElIcHhmbWFOQjZ4NHlpQ0h1YXYvY3hFZzZDVER1ZEIr?=
 =?utf-8?B?cktIOGd6Qnl4STIyQVcvSkM3N2RaeTlhVUZKelo4T1hmakc4Vk5wUTZzOHlI?=
 =?utf-8?B?K01RdnVYRDYvOHVvYzBhY2ZoNTdnN0M5aVZwTnhUdjZZQ3RuUjJuNkkrTWRX?=
 =?utf-8?B?T1JZQUk2RDBJcmhzSlpMbGx2VUltOE5EZ0JOcTNiMEpLUEh0c1lTdFFRSTA2?=
 =?utf-8?B?Y1ltRVE1NC9VSG50ZERGLyt3QUZqRzgrWjZML3ordjV6dFErRHBIRjVOeEpW?=
 =?utf-8?B?N1FJK292R2I2aXNOeSs3eDZ3bzhRZ0NJajM3TkMvektEMEdaallSYlo4K0w1?=
 =?utf-8?B?aUk0b0RlVGt4UFNmTGF1dENSbmM5MmNpVDRQTlFRN0VWUUxhWHlDVHJiYlAy?=
 =?utf-8?B?OXRJOENGcWlNSWxOaGg1b3ZmRCtya1ZhK0FBVVNoRDBjM0Z6ZitFeVFHUDVp?=
 =?utf-8?B?R0trK1hObFJyNDF2Si9JS1ErYnZRT1Z6SDNKcVZHM2dIZTg3OHJERFlLTzNQ?=
 =?utf-8?B?N0Y2S2ZLME5SRkNVU0dUS1NlTVhUSklDYVRLaTV2VHEzbGQvdzdua2ZlTHdM?=
 =?utf-8?B?c1BUWXoycXVDeFo2eXR2S08xM2pOZVp6KzVZbVM5MVRlUWVwakYzTnVuY2Zo?=
 =?utf-8?B?Y1o2Z3p6TE9NRFhxQ1I1U0srZXJ3U1dxL2t3OUZpZFlwTHlTc3N4ZmpEYkM5?=
 =?utf-8?B?b25pbjU3bFhsUzFETnZBT05DekJuU1hjbzRHSlVyazFTeHRCYVVWMW5DMzBM?=
 =?utf-8?B?ZHoyYnBFZnNYbnBMSVhKUjJ1L1YzZkIyQVpTTVdzZ1V5WGFLaFFYcUhGMGtH?=
 =?utf-8?B?R3BDSXlRK0IxTGF0a09CRXczdDBzbjhPUDMyMnpKZ2pKR0pkbmxGcHJwQ1Nm?=
 =?utf-8?B?VU1nNjNYNWJ5a3NxQjdIYUd5UENQSzE0dFRtRUVnWUI2T1djdE5QSDF5bUdH?=
 =?utf-8?B?TjdkRVZQNzNoV2s0T2cxYkxLMStHQUJQRzVKTFZxRjlFRmdCM1V5alFaZ2dk?=
 =?utf-8?B?V0t2L2Q2VHBTZzY5M2tlVGpsdzZjM1hJclpMRzZtb01NblVXWW9ydWF6aGM5?=
 =?utf-8?B?TDJQUnBjN2V4OWlJVHlLNTk3ck5CNFNrM082clFyUy93b0xzOWZub0t3a281?=
 =?utf-8?B?Qm80a0xTNTJnNjlHZUNNYThnK1R6ejluUFRRbmxMc1lJQXUxRGZJOVNqNE5M?=
 =?utf-8?B?QnNZVWpKT2Y3Q2Z6SWdEK2VwVDBrRDVtNmZRNmlpclpTNTUxVlgyZ29CU3Q5?=
 =?utf-8?B?dzUwWDNwQy8yK0xwaWRvT0JvampIVFBvKzQ0dzlBZ3Nlc3BVTnBZbm5peFgx?=
 =?utf-8?B?MVQ2cHhRc3hPTUVWUVljVEFtZHlmTFMwV2Y4WWNtYlVhZnc4WjAyRmI5cERF?=
 =?utf-8?Q?mUYuqHTh4hxSeQrPjJMvSdMC7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?V1FDWmRZaVVSZnN6MmN2eGQ4QkdiWStUV0NoZUpQUElmRmdyM2YwaEN4dEt2?=
 =?utf-8?B?Wm94TE53UDBqQUhhWVlsNlFKY2hoY3krYlNINnZrSyt6TXlJVlhyVlN3Nk5U?=
 =?utf-8?B?TlF5cDlJU2lwYWo1dTU5djVpalIraHI2azBiK1hKK1kzdHMzbVpnVWpxa1RN?=
 =?utf-8?B?RkJSS29zREMycDVJY0E1WTl2NllCVFdybGVTa2dnSXFQb2VBZGVBOS95RUgv?=
 =?utf-8?B?Wnp1eDd2eUdwSWhLSXYwY00rTnEwdXgyUnhPd0xEUUpqRit2V1JNYVpNWndF?=
 =?utf-8?B?emVaZGtNU0tiUCtKVkxMaEZlNmljVVFXSkVVaTFpaEo5L01YZi9OMWd6Y1Ji?=
 =?utf-8?B?QndRZUhXMEw4NVhUWVgzNHZXS3NLNk1VYlZkNlBZVTZJeWlwcU1tSTZLOEcy?=
 =?utf-8?B?d0llVkdPMzVvTjI4WkNHZjYrZWh2bTMzRXNjMy9wQlF0NWdFb2FHRk9wQnhB?=
 =?utf-8?B?VDA3bzlLdVJWZnFId3VUSUdVUFJzVm1oODhkanZ2MDhMZUJPRFNNQ21BUkFh?=
 =?utf-8?B?MG50L3k1WjdRK25HQmNBUi9wU1hkNGRBUWNNdlB1VU1BQ0FtSjFOd1BWaFJH?=
 =?utf-8?B?ZHMvanExeU03clR1NUhsano4eEc1NUpwY25VR3dvU213YXJsSnEyOHZIb3Y4?=
 =?utf-8?B?WjdFV3hLdU9LWVdESjYrSkhLajJmUlZjbnRxcHdObjQxYVQ1UWxGUWhqMmFv?=
 =?utf-8?B?enNIQzVGNFQ2eHRsUm1DQ1diWWF0OTEydnlRb055MnpvY2NKYWg4WkxEMDha?=
 =?utf-8?B?dmNtNzluSDRaaFlGS1J6akVWams5dUVLTUVJWmdUUGRMbjkzZktsbnNzd2dn?=
 =?utf-8?B?MmhKNnhUU2d1ZmhTNi9kMm8ydlNSVDZoNnJhOG5XTkNIYUprc0RHZU02V1RB?=
 =?utf-8?B?NGdoRGthdW95alB1ZUF4Njd1L3Y2RGpDa0x3Q0IzWEhJUmRDcGRjUnE0OSt4?=
 =?utf-8?B?eG13ZnNSK1lwUHJRakhWU055NzVSbnYyVkdHSzBINFdUN2l2Qytxbk4yTWNi?=
 =?utf-8?B?aXhyZ1pwaE9mNXVYKzh4aTVZZzV2Y1NFekgvZlM0L3NVYzJtajBBVzU4REor?=
 =?utf-8?B?eEl5MStYUmxzZTlBSFcxVERVYUx2djR2WUVKYXQwOTdiMXpoMzVWOGxZUkxV?=
 =?utf-8?B?YUp6T0lWTVVFZUJ0SVJQR1oreWR6NDNOUmpPODZySytJMEhyeFpPVHlxUkcw?=
 =?utf-8?B?bXNja094YjljTGJ3ZzAvWThISW14TzRmdjlmRDRkSGFqSFg0S1dGcmhCZHI0?=
 =?utf-8?B?ZWRFZXlTdGFrNmx1VmRBL2diaGtFbEwrL3JaME16RUw1SFVpS05MVjJZSU1x?=
 =?utf-8?Q?nKK9Gft1lv3Ts=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5356e06e-7286-49d6-8213-08db5594d956
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6810.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 22:36:39.6006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 300Nx5OE8bWUPGdCLsmr2rUvKPFfhF5O52H26JC+lwx51BoesmCt/QmaqcFFUoFAF008Ujg/OCCjz5JYTw5Bnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5557
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_19,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=945 spamscore=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305150184
X-Proofpoint-GUID: trsAQKpZfC9tYHe_diMdKoNm31cr4SiW
X-Proofpoint-ORIG-GUID: trsAQKpZfC9tYHe_diMdKoNm31cr4SiW
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/23 02:47, Huang, Ying wrote:
> Hi, Khalid,
> 
> Cced Mel.
> 
> Khalid Aziz <khalid.aziz@oracle.com> writes:
> 
>> Pages pinned in memory through extra refcounts can not be migrated.
>> Currently as isolate_migratepages_block() scans pages for
>> compaction, it skips any pinned anonymous pages. All non-migratable
>> pages should be skipped and not just the anonymous pinned pages.
>> This patch adds a check for extra refcounts on a page to determine
>> if the page can be migrated.  This was seen as a real issue on a
>> customer workload where a large number of pages were pinned by vfio
>> on the host and any attempts to allocate hugepages resulted in
>> significant amount of cpu time spent in either direct compaction or
>> in kcompatd scanning vfio pinned pages over and over again that can
> 
> s/kcompatd/kcompactd/

Thanks for the review. I will add the missing "c".

> 
>> not be migrated.
> 
> With the patch below, the cycles for kcompactd disappeared?

Yes, the test showed cpu time accumulated by kcompatcd during test run dropped significantly.

> 
>> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
>> Suggested-by: Steve Sistare <steven.sistare@oracle.com>
>> Cc: Khalid Aziz <khalid@kernel.org>
>> ---
>> v2:
>> 	- Update comments in the code (Suggested by Andrew)
>> 	- Use PagePrivate() instead of page_has_private() (Suggested
>> 	  by Matthew)
>> 	- Pass mapping to page_has_extrarefs() (Suggested by Matthew)
>> 	- Use page_ref_count() (Suggested by Matthew)
>> 	- Rename is_pinned_page() to reflect its function more
>> 	  accurately (Suggested by Matthew)
>>
>>   mm/compaction.c | 36 ++++++++++++++++++++++++++++++++----
>>   1 file changed, 32 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index 5a9501e0ae01..837f20df2bbb 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -764,6 +764,34 @@ static bool too_many_isolated(pg_data_t *pgdat)
>>   	return too_many;
>>   }
>>   
>> +/*
>> + * Check if this base page should be skipped from isolation because
>> + * it has extra refcounts that will prevent it from being migrated.
>> + * This function is called for regular pages only, and not
>> + * for THP or hugetlbfs pages. This code is inspired by similar code
>> + * in migrate_vma_check_page(), can_split_folio() and
>> + * folio_migrate_mapping()
>> + */
>> +static inline bool page_has_extrarefs(struct page *page,
> 
> Better to be named as page_has_extra_refs()?

Sure, I can do that.

> 
>> +					struct address_space *mapping)
>> +{
>> +	unsigned long extra_refs;
>> +
>> +	/* anonymous page can have extra ref from swap cache */
>> +	if (mapping)
>> +		extra_refs = 1 + PagePrivate(page);
>> +	else
>> +		extra_refs = PageSwapCache(page) ? 1 : 0;
> 
> IIUC, mapping != NULL if PageSwapCache(page) is true.  Please check the
> implementation of page_mapping().

which should work out for refcount since it would go to if part of conditional which will add a 1 for swap cache 
reference, but this code could be written better. I will work on it.

> 
> And even if mapping == NULL, the extra_refs should be 1, because we have
> elevated the page refcount in isolate_migratepages_block() before
> checking whether the page is pinned.  IIUC, this is the original
> behavior.  Or, we can add "- 1" in the following checking.
> 

You are right. There is a get_page_unless_zero() earlier in the code. I will compensate for that.

>> +
>> +	/*
>> +	 * This is an admittedly racy check but good enough to determine
>> +	 * if a page is pinned and can not be migrated
>> +	 */
>> +	if ((page_ref_count(page) - extra_refs) > page_mapcount(page))
>> +		return true;
>> +	return false;
>> +}
>> +
>>   /**
>>    * isolate_migratepages_block() - isolate all migrate-able pages within
>>    *				  a single pageblock
>> @@ -992,12 +1020,12 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>>   			goto isolate_fail;
>>   
>>   		/*
>> -		 * Migration will fail if an anonymous page is pinned in memory,
>> -		 * so avoid taking lru_lock and isolating it unnecessarily in an
>> -		 * admittedly racy check.
>> +		 * Migration will fail if a page has extra refcounts
>> +		 * preventing it from migrating, so avoid taking
>> +		 * lru_lock and isolating it unnecessarily
>>   		 */
>>   		mapping = page_mapping(page);
>> -		if (!mapping && (page_count(page) - 1) > total_mapcount(page))
>> +		if (page_has_extrarefs(page, mapping))
>>   			goto isolate_fail_put;
>>   
>>   		/*
> 
> Best Regards,
> Huang, Ying

Thanks,
Khalid
