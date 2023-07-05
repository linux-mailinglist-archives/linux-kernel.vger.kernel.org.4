Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933E8748EB1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 22:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbjGEUQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 16:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjGEUQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 16:16:40 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0DCF173F
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 13:16:39 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 365JA96N026944;
        Wed, 5 Jul 2023 20:16:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=KAQIYxCflCVTmAXBOsxHX8nDzbThxqpxCgAyOoKnEoY=;
 b=k1shEyes1oQt/yGnuySJN9aKH8WSwKcPoOtaVOIJ/UVWk4R4Y4mG/P9zshyFAwdb1crW
 stM+fuzOFi5D5MS+jVtWU3+DE0qha1ItwDAeHHrZYcc13uYWwshhzZbHv1KTX6vtfHnO
 87ZBlsrM5ONLAhJmyC1SpxIsJlGO9A7Pou5BlCSxGmh7mtNvEbVrn3KVL2Sk8JCH0Jlq
 lmdd83UTiSsMh5zAMrWxoZ9r0c1qjSuitaso+omV9Yg8z45nRa6vGEwnwtqfXq7xL1TE
 4bXrS7GreB+kSfuFxUjS476lS43Bj4hp/3VPn4xKTJ9AgUgW4CPW891ekGSFmJn1joSJ Qg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjcpufar3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jul 2023 20:16:32 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 365ImNRZ013430;
        Wed, 5 Jul 2023 20:16:30 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2047.outbound.protection.outlook.com [104.47.56.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak63ft8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jul 2023 20:16:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVLZkQIfleVgUGOk87P7Kg0Ui/OlyjQjAcHJ/ittD/aKUCKoTsMTNeikTiIUixXpLYcdATWwc+FRIR5nuVLKoU7q6Y48CLd+PUs0H3h1y61Nl3ULgF3ucO1lg/3X2WPrSNudZbtt2QwGhsLuI66mGHAinQVBLe/ezAfVI4O1b64c4KrZ5ewNhGhVl+paOUZsCsXMUsvWZFjHh03XYFFuXlT1gtvtEL66Yo9+iwKjqxCjx+E1hTdpDweDlWmNUZN7dBpmfDzqZcYLZSH0SQoBzFGvtoR7cIEVNWwjOHpyLmZQXlUA4btU6ddVgpNZzpopEtKTYa1jKWeJO7aTwZbEzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KAQIYxCflCVTmAXBOsxHX8nDzbThxqpxCgAyOoKnEoY=;
 b=IvwBFR6W2ANnPrqR31oo05EOaz8JPscnqt/a7smcvBRn9NnmWAvqDB2UfdOYrQk371VYo/v4LR3gjXym0pLl3qfn6ziUECpqLavHlPOfDeWq4oL8yNutnXduC1wwoFwvyQ9HIMnr6jqAjQBm0cFtaYMMIHiZpfov5Ea28XR5gkm5AJmOQ12p0wUc+M/tqElbWu1XJ+mwA9ryP9PZinp07lwnjYJzyNrPdOAprg/ajG6A587Bi/OPzhma26zpzIl0pzMR48kDsQApHE5yNLxxC6LgeEcrvkM/s5AwAVEEMHeldDRk1Xqi2FDIX8+1b04vjp/7rNDR0u8GT6VKQQnhVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KAQIYxCflCVTmAXBOsxHX8nDzbThxqpxCgAyOoKnEoY=;
 b=CC3XlnEa7mZFSMaVfP1GL+3QtiCVjRSjyKHc6ivdhV+pl8yIlMYYwGCOEIUsABkNsdkAgTPLSqSJDlaF5/FPxkDlAzpD4WQ+ok77hXxNVYlEYi2ojt9OcNhntnzDY7x25QvdNPTS46wPdahcR2cJuU9MQ9scA0AqACvUPC5kIiA=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by CH3PR10MB7716.namprd10.prod.outlook.com (2603:10b6:610:1ba::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 20:16:29 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d9c0:689a:147b:ced5%5]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 20:16:28 +0000
Message-ID: <b6e056d7-5b35-bcfa-4661-ebeb8cffd1c4@oracle.com>
Date:   Wed, 5 Jul 2023 13:16:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 3/4] mm/memory: convert do_shared_fault() to folios
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org
References: <20230705194335.273790-1-sidhartha.kumar@oracle.com>
 <20230705194335.273790-3-sidhartha.kumar@oracle.com>
 <ZKXO0/2sC3/dvLO7@casper.infradead.org>
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <ZKXO0/2sC3/dvLO7@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0088.namprd05.prod.outlook.com
 (2603:10b6:a03:332::33) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|CH3PR10MB7716:EE_
X-MS-Office365-Filtering-Correlation-Id: d1dd0aa4-e38e-4675-b034-08db7d94b738
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0+hpACZ2daA8njKTZx42kpDaY9SIYwPJbxeilQT231zccsiarQvEugi1RHXGEAt1Gl6oWB6KLyu+N4HfwxpQI9o007y/COrmWzMupU8ruyrdbblrXh8/zlucXuYOvFaHauld6CTH5YIsAeuPECGk3nh20Ot4GVxlG/Tg+RzyDtrunex3vlr1duQcOeAsXYuRl4hy//Dzh2MIEwjWlXF2zO8bwnrz+Tl3Q+GfxNXwSL/zo7ln+LEU50zzd3SSUb5S0d07vKPGl47MEVabavTTno/g+TY7KnCswt2yWoWdRGKtdwAsNFQ2KkJvyWR4CdgLzI3hpwaunPCpiF+YE/xK02+EaQAuVjWqNlSqE5TOl49fke7nRiLzLMCKRfbgqirqKB2g+Xv5mgfwyPfYo6Co1h942kvA66Jtr+ed9a5ESMTV3/ji+8WW7bG8ZE0LZbFuW0oFfWsaieseifNcNRt8EHZDA+hc14ot3Y2myHlLxBed2P69gLkNW6GG6W7uy/JaPFjlk43pdF/Zv+U1AI1hdPqQsDFnPv4BD145NZBKtom/VwIqdAXpR1Wvm3ZUG1ginaX4x1w6EDOSVTiAxxVqn/Mg+i88o7mBD2i5HM6ijP84YhfbBAGwTUV4vpl/dJyHSFcmyfw/A/sirTVNB7u3Dw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199021)(66476007)(66556008)(4326008)(6916009)(66946007)(2616005)(186003)(38100700002)(86362001)(31696002)(6506007)(53546011)(83380400001)(6666004)(478600001)(6512007)(6486002)(36756003)(41300700001)(8936002)(8676002)(31686004)(2906002)(5660300002)(316002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnBtYUdMWkVlNE9NQ1NYR3duL2lCYUhGVW05VHQrdDNxNjY1cmhKNUNjdGJt?=
 =?utf-8?B?VlQxM2ZQZGk4Z3NWeDZKVDVNTCtMdDRDT05yUXRJdW83WVd4ampSc2NBWHFi?=
 =?utf-8?B?RWRoTDRvYkJXVWc0MERsa1Iwcy83UTFuWlQzL0JLaEtFSXZxMzRvTDZ1S1Ry?=
 =?utf-8?B?ejlxbDFCa29veU11VVJJNVlGbGtVTFB1aWVrQlpVRFY1Q3o4SjNKeWc0ZEdR?=
 =?utf-8?B?YXVVa1d4Zzc1VzBsQnlHQWZMTnVYY2NjQUhPWWpkVFRoczA3UmxUTTVGTUYw?=
 =?utf-8?B?SlZCRXE0OVdRTmFGek5pL3Z1djJNUDJVdUJNZDJUWWxKVG1HaytPZHJRQjNl?=
 =?utf-8?B?QnV5cVFwWitqWTB4emx2djlZUTJXNXZqZzJhU3JzcGlZYy9iblJZVWxEd21U?=
 =?utf-8?B?L0dEVFlIaXlwaWR3WTVnNWxOZzluNDlWM3FGWnBpb1dwQVVkWkdEbk1aYXp5?=
 =?utf-8?B?cHFTZlJoL0hFb2c4L0VKVU9VVW9SNWtUaEdUYjhaL1Q0VXk1OCtsd05ucXow?=
 =?utf-8?B?d2JJb3V6eVhQUFlsWTJKeC81allTWnd4QkUzY2pzQ0p0RVlTdEFiTFpCUjRT?=
 =?utf-8?B?aWthTkFNUUFneVJsUnE0c1dGQ1pzRzlPUHRKWDNONkgvY3lpZ2w0cW9OQWVr?=
 =?utf-8?B?VmNKZDJqOXhQNHhNeURaOERDUCtOM3ZoZm9hanpoRVJmUzdpR2hZVWhjVjd3?=
 =?utf-8?B?aVBSdjVQNStsOE5lOFhOSVRaaXBLR3piVk9WbjdtWEdxVVhtVnNXdHRKLzdr?=
 =?utf-8?B?WnRRMDQ3TlZrQTZEU1BGcWd2bWxzWHVpc2FvSUp6L05qcHZWREUrN1N4Qloy?=
 =?utf-8?B?WnhId0dPM08xU0xGdXEvNnc4ZzRxQ3FTUWY1ZjdSekMyWnI1ZVptWXJkeTlt?=
 =?utf-8?B?WnFPblJpbFVza1hKRTI2UVhNNS9CMXovZUt5SE94Mk1HNllYbW51aU05cWJE?=
 =?utf-8?B?dTNFNHNYd05yVTBoL3Zza0tzU2xoVXpIRXBKeExESHdZZk9YMWk0OHJDdm9Q?=
 =?utf-8?B?RGNKQzlkNnZ4cDNSWS83NEV1ZFo3NG5rdVRtVUlzcVNKLzJsdXBzQnJIeVVY?=
 =?utf-8?B?eUVOR20zZmphNUdkSmR4SnowTTRWUW9aL3VOTWhOZUw2V2VpQWJiajU1Vi85?=
 =?utf-8?B?Sm42ZTVqY2ZVMnlSZnJvbkNBdGc3K1U0QWc0OG04T1Q3czlKNVpuTTAxYUhG?=
 =?utf-8?B?VVNZZEV2S1BZQ2Zvdk15RWpwaENubVQycjNRT0xNTDJNNnB3SGlka1M2Zld3?=
 =?utf-8?B?L210akI2RFpnMUxHSnp2c2Z3R3FWdGRzNmthV0x4RkdQMUVmYlJTZ01wYUM3?=
 =?utf-8?B?dXA3aFBQRnhYcXJ6TXJsU28vMTdXQVlTVHhCOVhudWxGZ3pjZ1JOMG9VbTEv?=
 =?utf-8?B?YkNOeHhaVGs4YisvOVg4ZmoxbXhEeVh1QS96RkZzam5KWXFzbVd2aWEzbTJ6?=
 =?utf-8?B?N0RXTWdnK2dKWjZzVyt6ZmdkakNPVlowSGg2QmZlNmg2MENDVUN2Zjl2c2wz?=
 =?utf-8?B?NWIyS0tweWJicmZRakJpWkk3U1M4TkxSeEVZd2xIRmxSQkNLUGdlMEJkOWFC?=
 =?utf-8?B?STlwaTNsZ3dLbUs0cHlGMnQ0YlkrK1BvK2FlSHdoQktwZXpRY0gzTmVZQ1Yr?=
 =?utf-8?B?dUtuNGMyV1YwWVozUVVpUXRqWDFod0poTmxEaXdVaVd2U0dHVWpUeHBKTlMr?=
 =?utf-8?B?eWRUblBHR1ZTWGEwZHVYSTErK3ZXUWgxNzlXMHF2OGdPbFB3M2k3ZVlGNUM5?=
 =?utf-8?B?ZzBtYkVSV0xJTTR2VTd2bTVIK3BZMVN4MWViQzliUkhBeGg2dVhkQ0JyRFpr?=
 =?utf-8?B?L1prUXlFeWhKOGZxaDRaMHQ5Y3B0VmsyYU9YdXJ4UXEyMWxjajVvdXVWLzJ6?=
 =?utf-8?B?TktsRWR3WFliUFF6b0NaaDkxWldndEtWa0RhVnhpcFJpUzJQbDBZbFpMb0ZU?=
 =?utf-8?B?Q0JEa0pOV2dDbFVWZDlWV3d5UFV5bXZIWGtlNjhpR0s0Nkdrem83OXFDTGV0?=
 =?utf-8?B?eTdKNkRLZVhsYVRJMEpXUGVNMXZTZDBYRi9mVTExZDdvZXQwellwRWdYUEpo?=
 =?utf-8?B?aEtkWm1TNzArWlFudVhMYmV0M0x3eWdwdUltTkVPUm5pbXRSV3RHckJBMXVk?=
 =?utf-8?B?b0o5QSs2Vzg4cW9LbE9QaWFhVGg4NmVuQjFONDN1TldWa25qaWVZSDJjYnpz?=
 =?utf-8?Q?zjr5JXq1z9+RMi36pyQzzwc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tZXY72+9VVI2YpkTOdT+xRfV9Tm7kvwG/RfmJzPG9Rz/dtUEo71QOLhwwpVg83DRjNf6Rc6uaJTcafLWfANuI6bTv/0GFIgLMnrXXLcZ3u7575QR2ULxz7MTNzwTaSVfXWFSkCk4c0JdGSwBgwfip9EO9xmK2ehHVzTMoG5hPa8CrahuoMCSFdvJTmQbjEKH1coiIe2guZnC5jPEDF1LjGJcXg+KihHdAIyGnHIQ+Dv48DSTMtsoznh0AnKL7G2HMPzjEJfiVA5QaR7gpLjg3KAO/EQpuagqER57pfNZru0kCwG3aQGmgKh7YfjOgOYHhZqBGnenizjWEGaSVAwKV6MPcCg74pQPbdTqqVyjhrq4EHp0s0CSUHsl1UeWbZfNU0UpNRaMxt55NynekYXrelI8w24etQRcWf1q+MptxbzXF0ThWnAC99S1swu9RWoLjbTuNEoaEHUYJnHra7bpQdDGexr+/kBzbPBv15dbBSRWm75RQ/4DfpSB+0lDPBcry7CnBPiD7AgK+GbzQhG/JM3eeyXvFxR6YsuQrltboGGb9DlmBVeyFgL0yREHLZ4DoIls3sE7TFcmP2YLIqSFDom70iHWkaXrov9kGchyTLEnkwplwPtcdHfCTemva+iPmvW8wFGLcZzlDVCJFua5KC8K9GN8fdTZZqmJI2GkD9bAGE3zxBGxW7+yppJDRZxlhdwimAFAAFOaArj+kZD1t4AmD+3Gya9WRkDUzqrwwNB7CGaM3UOIjTVe4NqETHhgn93Kh5e6RrFHuE1MDTsoNpyDJ4KrwjQCzM7FmUUcb05YxBkoA8rdIba+jurF4DCqJdhT1Wv7c/uTnPEWkhD3yiNPrDiX2LDcO/in4rm3i8vEcD4BQJ3qI08uB5DP8r28
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1dd0aa4-e38e-4675-b034-08db7d94b738
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 20:16:28.7366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HgZQoZ2RN+CoY/gwPUTIZrkeNS3wbJ8tDgG/deva8RybBWyqag3UKRF5mom35ZNIqSe7NLw09NU1TirwKb/a5GntG/ekjQ2R3EGXn6Jiosc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7716
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-05_11,2023-07-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=980 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307050185
X-Proofpoint-ORIG-GUID: 2JzXUCU-CTiUa5MLlTUU8nTSFx_aKu55
X-Proofpoint-GUID: 2JzXUCU-CTiUa5MLlTUU8nTSFx_aKu55
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/23 1:13 PM, Matthew Wilcox wrote:
> On Wed, Jul 05, 2023 at 12:43:34PM -0700, Sidhartha Kumar wrote:
>>   	/*
>>   	 * Check if the backing address space wants to know that the page is
>>   	 * about to become writable
>>   	 */
>>   	if (vma->vm_ops->page_mkwrite) {
>> -		unlock_page(vmf->page);
>> +		folio_unlock(folio);
>>   		tmp = do_page_mkwrite(vmf);
>>   		if (unlikely(!tmp ||
>>   				(tmp & (VM_FAULT_ERROR | VM_FAULT_NOPAGE)))) {
>> -			put_page(vmf->page);
>> +			folio_put(folio);
> 
> This is _probably_ OK.  However, do_page_mkwrite() calls
> vm_ops->page_mkwrite(), and I think it's theoretically possible for the
> driver to replace vmf->page with a different one.  The chance of them
> actually doing that is pretty low (particularly if they return error or
> nopage!), but I'm going to flag it just in case it comes up.
> 
> Also, should we pass a folio to do_page_mkwrite() instead of having it
> extract the folio from vmf->page?

I can take a look at doing this in a follow-up patch.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Did you mean for this to be reviewed-by?

Thanks,
Sidhartha Kumar

