Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943686CF225
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 20:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjC2S3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 14:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjC2S3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 14:29:21 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 714916E96
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 11:28:48 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32TEjG8Z026132;
        Wed, 29 Mar 2023 18:28:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=X6VvD2ykoqqjZn9iODy1KVHuJWrysje63Wv9WEZHEE0=;
 b=kmqqzXQzcqip/hSclfBaXQfxMItcPLNtXtPZQ4niHmgGo3Uo9bDt5VBYFuRwOGmLHEXG
 0aUib68f/d2j1x/KaZKhqFXwk2XLXHVQbVfQCpyLCmrjG5ORTpRlsS/gKnYKGkGvqpCj
 IiwYLlBL7+SGeQJJWs+SD3J1GKcSKEmwecZoGxsGs8lSpfLlUKT4oNCjDqepkoOVQ+NJ
 CVyJtjKCY+N57QDwEygG5iMYR92E8z1L3W3Hg8rrMcMbAuwBobXv4/cOPtTV9rf6uOAh
 o5W+NKzafnpOWIzk9HO7QQZndTuucEU+XidoTsZwzVvGSE+V0L7wtE3GFpLm3qt0JE07 zA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pmqbyrn58-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Mar 2023 18:28:40 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32THVipo010695;
        Wed, 29 Mar 2023 18:28:39 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3phqd8evp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Mar 2023 18:28:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WiBD9b3soQXfA5f112CLF8go/tZfWOnqaoevUBzbH0oj9Ts8gKt5RUShR8pnKHOt3YBcR2LEegp4PP7pGZ7n8Z8rVeCj5mqWtq649XyE29xiPLLp2fk3EKpciGdDkKIXqTRsNgs8K7+1cEI60Zw6SZLx6EU8HKf9hEl2sACaKvEc1NnIhyCMaLO41uAJSdWwbNQRKYCI1a07XIGhZ9TrXGiP1Icb/Ok5GpHueyekv/oJtYtWf+LKI8vpJuG21xjKCBgj4vlhQPB5WOLlf6UmQeKWECRXWs2RjpTFJiAW3g6Ruobv0bg3PgK6nYYMA8SaxYlwFatYjGdAmqWMSekSzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6VvD2ykoqqjZn9iODy1KVHuJWrysje63Wv9WEZHEE0=;
 b=OQrrnIqmRRxMgbrqGIWkBDYbQqFwm7xc0K2MBAlnjiPTTlfCHoM8vVbUIq87itOS3N4cZzHUQydx+hjo4b2eX4r8iAHc7Lyh7+RkO4faUX8BySJl/EC3nkdASXkYmJZMUTgYCJTdsFe5e17KgAVqsBKSwKA5+aq0hTz0sqSyaMkLejhhUaUz0AYMFEesUvpkq+GGl/imRVgxhCiXDCPScH03Azz6hRg+0Q/p3guQTTe2LdFU0YJ29RTCmQNKeF9Dh08T/SsSAnDmGX1T5NveX7Xw9RUfWi519oNTnpuh8SN+hYL/uxlDOqJlH19+dvjJu745VP69aij4crwQisfHfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6VvD2ykoqqjZn9iODy1KVHuJWrysje63Wv9WEZHEE0=;
 b=qNRI9bTO6MxtV9va1fblk80jitPI7vkAvmk0mnETMT8sbbdvKKeJ2jf5POr/dItS9J3hg+4GLi+Ht6eT7nMiahvOnW2Ch7Rixv6x9ZeVWcIwelnnWsmw+dWPamP9S8cBUyOya7SH6id65cqGCdnqmbDzRki075pKygLhMgicaiM=
Received: from CO1PR10MB4705.namprd10.prod.outlook.com (2603:10b6:303:96::11)
 by SJ1PR10MB5932.namprd10.prod.outlook.com (2603:10b6:a03:489::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Wed, 29 Mar
 2023 18:28:34 +0000
Received: from CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::ab8d:2bb:c060:7d73]) by CO1PR10MB4705.namprd10.prod.outlook.com
 ([fe80::ab8d:2bb:c060:7d73%6]) with mapi id 15.20.6222.035; Wed, 29 Mar 2023
 18:28:34 +0000
Message-ID: <d1fbf2d4-8989-effd-c908-2784f386fb8d@oracle.com>
Date:   Wed, 29 Mar 2023 14:28:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] sched/numa: Fix divide by zero for
 sysctl_numa_balancing_scan_size.
Content-Language: en-US
To:     linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        peterz@infradead.org, vincent.guittot@linaro.org
References: <20230329162610.4130188-1-chris.hyser@oracle.com>
From:   chris hyser <chris.hyser@oracle.com>
In-Reply-To: <20230329162610.4130188-1-chris.hyser@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0097.namprd03.prod.outlook.com
 (2603:10b6:208:32a::12) To CO1PR10MB4705.namprd10.prod.outlook.com
 (2603:10b6:303:96::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4705:EE_|SJ1PR10MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dc4f7ba-cb9b-4612-deda-08db308367ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aYD8szP36e78EWIyhJy9aZaIPdBvUumxTsr7wWDgIaZryhzec1gfV8RII5W4L923jq7iY9wm4PsIL6SVu1kN8RfxZXRdp6ouezKXYVHJW3RaXyi9lKNs8aDXffae0M1MVKfzLE8UkZ2pcKOCiMdWcrqd37fMD/mlffUw6wvb2cmCtjN8FTH2BDC8jVuBFtA/YSlIF/8D7F5WvZG3a6oSy7XLz1eTYkSk+eZh7uItnufc2lg1rg/OIhn61SC/62Sl9KOF1ADZZ3cwndoE0DtuhAJrg6GfTECUoF3XWyIcKEiXncStwB9ELXLuShNyFXFK+fGooAhaHTB6YWQ1Md3u34Y9EZeNcT+Ml/WRyzbjggMzdNjT2XD5AEywixLIY5gBXmCLStUOrK23JaW+FpestJVsPTgASkbDytiGq0PN8MBOvo9ZNC505f9zK/h+y873gGT9m7Tbv/EaZC6+EhI2TNnFsQp/g4LOZ8MfuIBY1bpViWksuMh8mNJRYcWC36MDLNTveFTvB5bxNkOHz3OYsoddtKzgNPGuQ2EIQFlH+uUwsK6+yQXH5RzOjTNy4OmoxfUqECYwI6SRJjMN9ocNn6BxJJOZGkBDUyCrmFakLAACjNzXvg+eRwgcLuAVnTn5jvYry4LqSuwA575o+seu0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4705.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(39860400002)(366004)(136003)(346002)(451199021)(316002)(478600001)(31696002)(86362001)(8936002)(36756003)(5660300002)(66556008)(38100700002)(66476007)(66946007)(8676002)(2906002)(6506007)(41300700001)(186003)(6666004)(53546011)(6512007)(26005)(2616005)(83380400001)(31686004)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1BJU08xbmhrVUhBV2EyREY4YUpQM2xzbEJsVGJvYTgydjkvdElLOVZoZkE2?=
 =?utf-8?B?SmlkZDVPZ2NocWlwNXFDajFsNExNOGlVRTlqZW53amRxWm9oWnNvY1VUVXVR?=
 =?utf-8?B?Zm9CVDlOYm94YUdsVVdJd1ZzZnM4WUIvM29kS24ySTYzdnJNWDlFb1pweUNu?=
 =?utf-8?B?NXRPVVVoWVRmZVhKcm0rMWp3T29ER25nMklaU0lIVVVVdTR3R3RCckVGNXk3?=
 =?utf-8?B?a2JGU1phSFpzb0JOckFDNitOK3dFTEJaUWJFWjJscWE2MDNMQlI2SXdGSjVH?=
 =?utf-8?B?Y0xXR0hKTnRnZkY3ck5CUHlFWFpJaUFEbEtUSDVvcjZOekE1MGtla2NwenVv?=
 =?utf-8?B?dGMrVWJ5M2tBMmlScC9USjFST2ZIekVQTElEY1EyOE1XWHZNQWRBeXVGa28x?=
 =?utf-8?B?UGZqU1pnMW80YmI4RzFHelhGMkNnNVE1emdTSnAydzRERVpQZnYrMkx1c21J?=
 =?utf-8?B?Z2R4dHVSTUk3YjBvSXZUTkpEbHliRk1KYVlCcFpkRC9keERSTVRra1NTTHJF?=
 =?utf-8?B?MUJWdkZoWHA3L2lQWktiY1FpcXpvc0xtOG15dUg4YUpSR2RsWkVIc0lUNzRw?=
 =?utf-8?B?Y2lpSTBRdXZWcjZHMjAzTTVWeGc2UklXNHBPRUJnV21sWm5HWS9UMXJkSitm?=
 =?utf-8?B?UDVuM3JJN2tEd2ZwZmJDOUh0dHN3ZDBKVnpHaE1DQ1ViZjRWSnpIWitxVHBQ?=
 =?utf-8?B?WGtNR0RRVEp6d2xRVzZSRmNOaUtzbzlBbGw4LzdHNVlnZUx1eHdlK3J6SXh2?=
 =?utf-8?B?M3ZhNzBZeFdDMmRJMGJvYkVpZnVXVGcyWEJjcTFuK0hTUGNxVTNaT3VvbVhx?=
 =?utf-8?B?Y2JjVWVzdFMyek82SkdIbnNpOVNsYlNweVVWZFQ1ck9jalAvQlNYdld3ZjB0?=
 =?utf-8?B?c1Q4aXV4am9hQ2s5eFc3WTc1WXd3VTNUd21zdk1FZjNHTy9pVy85SERzRjBa?=
 =?utf-8?B?V3B2SDVLL0lIZkdmODg0YVN4dmpodlpubjdOYVV4bWpHRGx1Y1drOHl2NTFN?=
 =?utf-8?B?M3dIOGZtSlNwS2Y2RlcvYjk0akVqOFZJT0Z5WFFmMFNRM0xOdDRmSThmWmdK?=
 =?utf-8?B?blFjTzVzcFhjeVNhZHQzeEZVK0dMcUU5VnhHc1ZWWUFYUEprSEQ4cnZaeTF2?=
 =?utf-8?B?MHh5dHVnVk5SSWRqTEgrbW9SUjhJMEpWSTBxTWVnbWNNRkNocW9RY0tuWVVt?=
 =?utf-8?B?Y1FQL0taeG9lMDl0c0NRR3B4YktjanBrdmFibXV3a21GanNxWGxwTHJzbDh4?=
 =?utf-8?B?Um9GWHJLM1FHa1JqYnVQMytHWG9LdUlNZmNFWncwYlpRQUw0dHM5ZHE2VGgw?=
 =?utf-8?B?WTI3b2FOdjZmNVNHLzkrWFZZMVRTeW1qam9GNlF3dWJPanFBY0NEbVhQNnlE?=
 =?utf-8?B?Y1dYT3pnMExseGZBaDcyK0ZzbnAvVi9PbkF2RTVmemJzeW5ubElHMDlGSFdj?=
 =?utf-8?B?SmdBTWJNNnZhVmpRb2dqd0YxWXdCRmIyWE5oSUU5OFhUWERlZUw0cmZFYVFQ?=
 =?utf-8?B?UllZTlFoMWpRWGxQRFBNc1hnZEEyQTBLR3licm5SSGRWaFFzTWdzSi9EZ2R3?=
 =?utf-8?B?VVlEc0Z4SEQ4S3h3MVFvL0FzQURTbEp0OFVuZHdnRUJxWHZNb3cxUS90TXNp?=
 =?utf-8?B?SWxqdVliakZNZHhQWXZtazdBOU9SZFpGbFFPbXB3ckxGQzdPdGxsY1dhOHds?=
 =?utf-8?B?dGZTUFgrY0dtcVRNdVdIU0x5bFozcWNwRlBTdzNJOEFFZCtiRkdON014bWpu?=
 =?utf-8?B?MVpVWlBxYTNRSTZiSjFQSkNqSUNvclB6RFdQVWgwekFhclRuTFBzRnF2Sm1h?=
 =?utf-8?B?Y1ZNN2lGRVNkUzU5UXpyRWZseU4xQlQ3WXFzU3Y5NlAzSTk1dkNiK01TVlFi?=
 =?utf-8?B?QWhZT1pKQzFwTDVnb09NWk53d09nRHY3SER4VjNYelRlSW5sR1NUc3FWVHR4?=
 =?utf-8?B?Q2ZBdWVCWWsxbVBkcEd5VWtlUHdJZFRrMzRCQldVNjA3K2krZS91eHQ2ODhL?=
 =?utf-8?B?YzdjdHpRODk1ZUpQMU1QVitMQkhOSUJaMVozdjJOdm9RVENob3VTTHhONTAv?=
 =?utf-8?B?MmtkMHJ4aFQvSEFQamNrbTZHMTdWYXp4ZG0xY0VXTnZtNFdjeEozNTVlbi9F?=
 =?utf-8?B?UjFBdFoyY3dHZTdHaUZ3STlBQXRoK1BUNmZtZUtGdVk2dXlQUHRVbWo3S3FU?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LKdSd1QN7TMuiLarwPqwtI+lbSwvI351wjJKvyFnAM5ano+jeyfBjN1VbtD2nlOMPrvyFO1hFu2GVVRCMc4nIIRpdZYPXqKyWqCt6cxtXXb7Kkbw+pYE871qazsdMkYbAAM3Qu/uGn1BvkpJnngNBYRktGsto8YgBnqbz2OlBx9lVppzcculxSZ+pYso/tkiePTKOXrtxhmnql5Wd7FGBWgBCzNQ8XUwErzIgJhezH6JjjrsEZjeyqEzvHIdr7JouTToS1sGTS9AJBen1BROoIGGSI3vesyoLTNPtcEAlLMR+Xbnwd0TWS929ulExkpeXpaO1SzUywNPYZrTcFzzyumrmPbcr9N7Wp2LwsKHnF/7SY4rn3qysMIihWNqQykwilsfKo2Y37KR+y9etThAZyheYTTBoQJTdRRKjIxhegWgQ0f5GN+T4QPpLm2CxrCgl5CMcDtYpHBtTAyYd15EnPkVjhXgJRkuH6f2JnZj3jGC8ovoAE5jejdS6N0lM9Q2OsbopHDincknd8R5FFDkT3TzwSwviK6iOaVfg/rtgNdINnKLYK86yhP4z/qGxIkvXL02BQxUOPHTCCabTofXjONsZZY5UT2DJMkryNgBKUnaaZ4aSUaetIQbRpVuJOkf9Kms1HiivVETaaIa925Pztoj+MCD/uTJP2j3Ff5s7pEJNgNcRhyJW+bmjhMA1qpqE+JMG5vvEMPGnkJuuTr5XeTk9/NgAy7Bw5HjpSBCts01rj4jhGojoASU6AWxyFNLPhF6O1ASRWjJAn266ODy9z3BvQEW2OzuCXm8lVbAvNvTYZRzZrWO1NbgBjb41h01ca25ME5Q2KEHcstTq4d2aaQWBdVGHfkIrlcc1516lc4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc4f7ba-cb9b-4612-deda-08db308367ee
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4705.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 18:28:34.7553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FscwasXmArvCr+FlwoCxqXvy/42UVhoSYL/S91goTodOfl+9NvK+fbuJVTwHA+DhYXXVQdA42Sxful3RofWiMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5932
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-29_12,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303290141
X-Proofpoint-GUID: XCa2FHaSKSeUJbC42aLIjHuG-_bFhex6
X-Proofpoint-ORIG-GUID: XCa2FHaSKSeUJbC42aLIjHuG-_bFhex6
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/23 12:26, Chris Hyser wrote:
> From: chris hyser <chris.hyser@oracle.com>

Apologies. Something in my email chain put this in, but I think I 
figured it out and sent a version 1.

-chrish

> 
> Commit 6419265899d9 ("sched/fair: Fix division by zero
> sysctl_numa_balancing_scan_size") prevented a divide by zero by using
> sysctl mechanisms to return EINVAL for a sysctl_numa_balancing_scan_size
> value of zero. When moved from a sysctl to a debugfs file, this checking
> was lost.
> 
> This patch puts zero checking back in place.
> 
> Signed-off-by: Chris Hyser <chris.hyser@oracle.com>
> ---
>   kernel/sched/debug.c | 50 +++++++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
> index 1637b65ba07a..dfd0fe6123ec 100644
> --- a/kernel/sched/debug.c
> +++ b/kernel/sched/debug.c
> @@ -278,6 +278,54 @@ static const struct file_operations sched_dynamic_fops = {
>   
>   #endif /* CONFIG_PREEMPT_DYNAMIC */
>   
> +#ifdef CONFIG_NUMA_BALANCING
> +
> +static ssize_t sched_numa_scan_write(struct file *filp, const char __user *ubuf,
> +				     size_t cnt, loff_t *ppos)
> +{
> +	char buf[16];
> +	unsigned int scan_size;
> +
> +	if (cnt > 15)
> +		cnt = 15;
> +
> +	if (copy_from_user(&buf, ubuf, cnt))
> +		return -EFAULT;
> +	buf[cnt] = '\0';
> +
> +	if (kstrtouint(buf, 10, &scan_size))
> +		return -EINVAL;
> +
> +	if (!scan_size)
> +		return -EINVAL;
> +
> +	sysctl_numa_balancing_scan_size = scan_size;
> +
> +	*ppos += cnt;
> +	return cnt;
> +}
> +
> +static int sched_numa_scan_show(struct seq_file *m, void *v)
> +{
> +	seq_printf(m, "%d\n", sysctl_numa_balancing_scan_size);
> +	return 0;
> +}
> +
> +static int sched_numa_scan_open(struct inode *inode, struct file *filp)
> +{
> +	return single_open(filp, sched_numa_scan_show, NULL);
> +}
> +
> +static const struct file_operations sched_numa_scan_fops = {
> +	.open		= sched_numa_scan_open,
> +	.write		= sched_numa_scan_write,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= single_release,
> +};
> +
> +#endif /* CONFIG_NUMA_BALANCING */
> +
>   __read_mostly bool sched_debug_verbose;
>   
>   static const struct seq_operations sched_debug_sops;
> @@ -332,7 +380,7 @@ static __init int sched_init_debug(void)
>   	debugfs_create_u32("scan_delay_ms", 0644, numa, &sysctl_numa_balancing_scan_delay);
>   	debugfs_create_u32("scan_period_min_ms", 0644, numa, &sysctl_numa_balancing_scan_period_min);
>   	debugfs_create_u32("scan_period_max_ms", 0644, numa, &sysctl_numa_balancing_scan_period_max);
> -	debugfs_create_u32("scan_size_mb", 0644, numa, &sysctl_numa_balancing_scan_size);
> +	debugfs_create_file("scan_size_mb", 0644, numa, NULL, &sched_numa_scan_fops);
>   	debugfs_create_u32("hot_threshold_ms", 0644, numa, &sysctl_numa_balancing_hot_threshold);
>   #endif
>   

