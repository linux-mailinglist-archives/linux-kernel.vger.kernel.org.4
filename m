Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4B5718143
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 15:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236089AbjEaNTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 09:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235820AbjEaNTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 09:19:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89FA123;
        Wed, 31 May 2023 06:19:03 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34VDHHMk008119;
        Wed, 31 May 2023 13:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=x4m9Zc9QKKLyweKjaGlfJXQpf3AD5uvwbufiTYBT9E4=;
 b=r1Q/xvKnlAyihReHiW8bSvXUhPSbx9smBWVIEU8TxHKLI/ZA2ABokXQL11xNvATNczhD
 D9d3w8d7TW5at7kPJwSw0vd7VY6pi+WMUOm0Ld4NxE4JdVqEKwGJxneAuFhsVb5dLm1P
 z/RvEa6a1+HrVViVUndJHlHcQ9Fj3BYIam0rwH6FWH4m+jzA9n92QIyzUeMxVsAKTrOs
 tgPN+Oc3KcJcD7HFekSgS5/HWayZ6b4CyPLcCgohV2fuzxbVLALjzKv3YLxrPSU7VmQe
 R1XrVyduRBifm8VdU2GEHROaXEZcWemEHVR7Vy6ToeHiJqbg1L3hSg89AZ8Map5j9f8F ug== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qvhwwdqbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 13:18:36 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34VCkFR0029993;
        Wed, 31 May 2023 13:18:35 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qu8a69232-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 May 2023 13:18:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPWyMU129NFVU2WFWZEMcRo98Cyudk4O5U9cJqrOKHJ75oXaFHLrXTFfvuQ9J1+dxdwHwfQkBgDBcB17Ba+WOkccuy2tBfIspaxmid0/NJ4JZmOO+mXBV0jmghzhdlJSDJddCnSuAvv1Ynu6o1QnSX+cDzG30xgeFfAzug0f5YJexDA2EQE7O13SGXqR9BzQ/k7ORP4jTSx5YAGyMGOZzwYjSwpWVE0+dYcnh9DvimipH4z2NG7ftuuhKKozS+DAO/uhh7AEiC3Lc66KdSNMIwECSArem3bpPu2HlZOLNAqtWNpXzKC7d1GUrGr7qwFUS0KZqnoBRbZg+VmJrOgtaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4m9Zc9QKKLyweKjaGlfJXQpf3AD5uvwbufiTYBT9E4=;
 b=RHUdhfZC7SjDmdrIryOA7vw8KtbUWz6NPWqX3DkTb2bgYZcClYzE3zilgUp9MpovvmcSlNSqvPI7mvB5779lOVIUN8mx1wlQ+MlxwoLZRR5VfEbctRj9633+IfPa+wg/PEvPRlXbLxwe1kbS3YzYU7F9JBCLLunEtm4HuEXEqAjEifsw+gdpYKjq1loK4ePGgCPRgeBxq8H7CtiiGQtgPjMnL1+5pDpaiP9/9GSdYT2sxziI3A3tA8IHc6vwwT1YixQQ2KkHhFySyeRfGnEqvwrxw54akMaCKL2CXK9Xf5pryZyllAxWpEU1jdsEyZiOJiQNMeWerZtTkALX/vWOdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x4m9Zc9QKKLyweKjaGlfJXQpf3AD5uvwbufiTYBT9E4=;
 b=GLJEHOQRPpDra7WQn+PUXfZ8SARMCA+C/W/2LrFqcCwRoPf9gqawa3nlX0dgt7A5jrEXEw8dMW++o4Fn4Qmm5GkBO0EzEVp/bEN6o1RuYTcMRiRnB8lPhARUNQHdFzNoKR1aIheoijfqtyb9PYltIkZl+oW61ayVf5Yk6f2rgGI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6821.namprd10.prod.outlook.com (2603:10b6:8:13e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Wed, 31 May
 2023 13:18:32 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::9d82:8d0:9c53:34c2]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::9d82:8d0:9c53:34c2%7]) with mapi id 15.20.6433.022; Wed, 31 May 2023
 13:18:32 +0000
Message-ID: <c1d8ee9b-4839-1011-4dad-c4777d8f8224@oracle.com>
Date:   Wed, 31 May 2023 14:18:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/7] perf metric: Event "Compat" value supports
 matching multiple identifiers
Content-Language: en-US
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
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <1685438374-33287-3-git-send-email-renyu.zj@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0207.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::14) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6821:EE_
X-MS-Office365-Filtering-Correlation-Id: dfec491d-c0c3-409c-037d-08db61d9883b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t8Iz76RdHvk46dkAgv5B7eND5ys4lOZQZFwr9Hg2AJohQrqATQXy88LfoK9tKcp4iiKKbRzLdnoTfOXouzw5uDwB5kbAi2iVEyYWWEMY8kfdxXogNsHWMiqDqNSUDfz/p8SIBamplo0c6FkETPlPPQfNpGSACAXvJDgncvmqeug2G+C6/F3OuKOZBFXcFneo0L2kInm1HHLxY+E1ESir2lzHdfo62QpA8Lz5EMDh9RY6tBOBw41nGtHuKhO6FEWsl47S363VhKod1mRIDeGRMaU4+2L6ZlqFcbl1I88fKcOvTVLKlk1qyH5HRzLR6p21be6r0rSEn4X+cfltt06CYZH3t+wnZ2iI99JCERU19lmnzXBIZ3UHXUV2E96XMf3Vh9KAKC20QEtYCjHGlERw/GfJ7o24PRdrbCetYdfb5P769k0RPcjZMzWVuHd1X5vHvKfSE82UkUOp4b+rDdqs98EUnK7e+BnINwLBjKifFpS9zq6aJIUxGk0hY6mofobfOK3UtH9JDd/9m1nxnRpamgPENyYOE3ZVgOiZGrC2uPlzfHKOrVhGtrAPqakC/UMR5+++1IIq8pHus1aX6Kvn2Ki86W9EwIaz9oFdycFBji/5wGVaOvLmheIF/QxrgsmStv7Lp4ow9132n3PcQbGWIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(396003)(366004)(376002)(451199021)(316002)(66946007)(31686004)(83380400001)(54906003)(2906002)(110136005)(38100700002)(6506007)(26005)(6512007)(66556008)(66476007)(4326008)(31696002)(86362001)(2616005)(7416002)(478600001)(5660300002)(186003)(6666004)(41300700001)(6486002)(36916002)(53546011)(36756003)(8676002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzNFRXdnTjZ5V2ZudmxMTFRwZ3dVMXh2eTRnZkI2SUpGZ1pZcjVHcGtUeDAw?=
 =?utf-8?B?L3NHWTJqVlM1WDNnNXVQZTljcXlIMnJWcThnZ3FuR3ROOThlUTB4d3AwVG82?=
 =?utf-8?B?SFN5WkhETE4xRU55bUUvWHVuazhpemFxMThneERKNlZuNzZsdWdGb1Jac2ZB?=
 =?utf-8?B?WUk2d2wvMjR3aCtHeGdOL0ptbWtzOXliYjR3RlRvRElkbEhwWXptZ213UlJo?=
 =?utf-8?B?V1VtcmVaY0tTeVYrLzVhZlNlajFaam55Wkd6eUdQYWpqL2FFeHFhNDdaTFJ6?=
 =?utf-8?B?Y3VGMlVJbG1yZGRUV202OEJGWUF3VXNqS1hlZjRRUEhZSXQ3dDU4cmxEeXpB?=
 =?utf-8?B?WGhjNDRwOTRCYTRldDZITmtpaVRScXR4QkVwWXliVlZjZnh3M3FQdGp6UlpV?=
 =?utf-8?B?czAyS1ByUGJwaEZUQXBPOHNyUFlIVXNudUVwYVh6a3YvV0J2c2dXWU1NaDRh?=
 =?utf-8?B?WlhzU0g0aUhVYjhoZElUMGc1YkVJK095VzFmVm9adEJZMGR1QmxzTXRoaUVL?=
 =?utf-8?B?M3A4VmJjOEQ0ZmlURzhvU0lPc2dpR1RRZk1hQXQvemxaU0ZncWkwZ2VlSkZD?=
 =?utf-8?B?R3VibFQxSUF2K25BZ2pFMGhjNERTRHBBVUFyc3V1clIyZWx3aElHR2hGTHpN?=
 =?utf-8?B?NlVTaXY4TE1JM1FGTkUxeEtuTXJGeUlwcVhoanp3eFlBTE1BZWx5dmJyR1pR?=
 =?utf-8?B?eHVlU1ZUaGpxUVV1VXRnOEpGVjUvbEJRRllFVURwc2lPeEFFOVRMR3FNWlVv?=
 =?utf-8?B?UnFISFRCbXY1TkMrTnJVaVFzM2hvMUUzNXZJM0xBV0piaHo0TTBnN1JhOFR0?=
 =?utf-8?B?Vi9Pc28ySC9QRTRlSFBDUy9rNjgzcXdtZDVPSHF0RFI4NGhuMHZnWFNUTU9B?=
 =?utf-8?B?VWRLdnlJMjBPdUNSMDFKckM0ZTB6aEIzMkVUdDN0RkxqQ28xZWQwQkY4MEsr?=
 =?utf-8?B?RmVtR2lYUGRsUE43cEZ1d3NtK0JxT2xDWnFiL3F4dnNZKzRLSmZvcHZFK2ZV?=
 =?utf-8?B?YlQrZWp2MGVLVThXOG0yOXV5SitBazh6TzQ0YVZOZXBuMEJtOEp3ekt5aThI?=
 =?utf-8?B?eTBObzIxeEJrK0ZsQlY3aXN0Q1h3NlFpaVZOdmEzQ09jOEhJWXNwcDdCZHNs?=
 =?utf-8?B?Tno4SHFjTUUrSW4xL3RVUWw4cUp3MkpYWGI2U05paktDbHZsYWU5bWUxeUNv?=
 =?utf-8?B?eXFOd0lTZ1pKSkxrdmg4SkNyQXlpSytZTUM2UjVncDg0Ui9wN3V3V0d1cWZ0?=
 =?utf-8?B?Qi9PUCsyQmxwaVdvYjNSVFQrVU90ei95eVQvbkxiY29hTkljblRYV2lpSDBE?=
 =?utf-8?B?SFFUVkNUcm5jdEc2dmZIaVBDRU15ZWF4V0FKU2YrbVFzRDVUdUtPZ0FNbHZk?=
 =?utf-8?B?dk1hRHZYbENEQWk0dzE1S1o1b25NYjNXdW9hYSthZUdKNVNQSEN3T0pSYWJn?=
 =?utf-8?B?ZEV0WGxRV0lJNm1vTHNoVkI5VXk1YkFsNU9aaW9nUkl0eDNzRmMvWkF6bXdG?=
 =?utf-8?B?TkJGRGs5d3BLR0lZNitsTnVMaThYWWJpazE0TkU3eEZtTHpmcllDbzRwdkd1?=
 =?utf-8?B?Kys2ZEVpZ254eFVtUGt5Z3R4aUthS0x1QXZXSU5yUlNjNXZjSndFa1dILzFj?=
 =?utf-8?B?MDQyam1ZaUhRTG5Rd20wOXhUSnR2S0VjOUpIT3V0cFI1UXB4d0ZvQ0lObTNl?=
 =?utf-8?B?aExsSzVPN3ZSMTB1K2JBUS9vSmZSVGlDeFRvc0JzZUpoL0RnaGdUR2Zkb1ND?=
 =?utf-8?B?ZmtKV1B5dVF4bDZMNS9laVR0VWViVGxzNGRRZEZVNTQxS0E1RWZQdDFjUlVT?=
 =?utf-8?B?SERwR1g4UzdnUGNhWE5oRmNEYnNoZ0pmYXdUUm9yeE55cXMzR2k1ckZNVUI5?=
 =?utf-8?B?R3UvOEZzVGlwQklSTzFFQTdzbTQ1UERRdXQ2cGZmNkxRek1vUExrUHJPbDRx?=
 =?utf-8?B?c0dwRkFVZHVaTUtnLzlxQWNzcnZsRVQ3R2xhaUY3TEZXRnk2d3NwaVVraXBt?=
 =?utf-8?B?WVplNzl0NUNNaWNuMU13ZXcxcitzNVZFVmxCSUgrcmxGOHUrU3kyTUwxcGdu?=
 =?utf-8?B?NForbDVRdEtoNFNJNjhRN0dUaGx4UitVRE5XSFNGTGZNSDAydk5RcGRCZXlC?=
 =?utf-8?Q?B6MdldFp9i9sjqdmnqIAiKagm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?WWd5Q2RvL2YyUk1aYWZCWEhnTEZROUpzRTk5b2x3Y1FHaHFZSllSQzJnRmts?=
 =?utf-8?B?MUNjV2xPV2JkRi9ZN0h4ZmJtcW9qQ01RbFU2UjZ2R2JKWDM3dzJRTEJDd050?=
 =?utf-8?B?b0lZVWJBaW1Fd0FaQmU4cXVmRkZRaUpNVW5XU1g3LzAwNnUxbXBDNjZrTG5Y?=
 =?utf-8?B?RGgvcUxZSzdiamVZaEhWdVpUMmxVb3RrZkYrNW9mNm9pTVVndWV4Z0NRTkRW?=
 =?utf-8?B?bS9zTkVxRmVFeGg4VHI3M0FxRExqcnlmSjYrY0N1eWE3d2c5bndrelNkUDdU?=
 =?utf-8?B?dWdBNWgvMldMZ08yRWVnOFNhVTNrcVkzdmwzRTlZdmRySWlVZHRwOU8zTXIz?=
 =?utf-8?B?YW50aWxnQzl0U3Y2QmsvMllyRXZpeUtMbHM5VTc0c0J5MHhnT1pYOXF4cGJ1?=
 =?utf-8?B?cVpEdDF2aTgySXQ3cGRiUi9KZFZjRHJSdmdDeFRYZWlVSDlVVEt6b3oxK2NL?=
 =?utf-8?B?elZ6N21wZzB3YVlITUdEaFZuOFlwL3R3T20vSHV3ay9nOFBwalpYVlp1amhH?=
 =?utf-8?B?dzdqZGhCcUpMdVI4bVlRSTU2QTFFN2VQOGt3QVErQnJwWWpsRW9RY3U1cGpU?=
 =?utf-8?B?bnUrcS9WckI3bDBHSzI0Vm9zbi9CWmpUQmFrZEJhRlhuM3BqUGNVSlNMcytD?=
 =?utf-8?B?L1BDNzcwZ21PRHBxbGR0dENCSExzeGdOVlRSNlMrcmZiQmRzSTBzM1dWMklh?=
 =?utf-8?B?bEpIWS9hQlpTQ2tJVVpYZmVNWThmMVE1cVA1N01Eckt5aVZNVk9kY2N6TnN2?=
 =?utf-8?B?aHZrOUtOc3IydjAvQklwUGV5alJ5alpreEVlcXZCRHhybzJpc0JzSjYzRlZ4?=
 =?utf-8?B?VXZGaTNWc0pVaFA3cEZHOG5rd2lwaUM4Tkg1NWhaZzNoZUlTb0c3Wm1IWWk2?=
 =?utf-8?B?VVdkSXF3VHUvY051OFF0VGhDSktRT1hycnQ3VkJLV0dqOFRNMUFhbHZiK0xK?=
 =?utf-8?B?LzhyN2RscitSMXBYSGJ4UlhObi8zQXdnR0U5cW9HZmVkMWpHb3BzdmZ3VnF6?=
 =?utf-8?B?RDRWS3RnMG1rWS9pTnY1M2xzc1pndjNkSEhkREtPY3ZrN0Y3TFdPY1VxelBj?=
 =?utf-8?B?WldCaUlWTjVUL09hUHU0a0Nnak1EWTZ3R0pDdzhXYjVETEdyeDgwWHlvQmxW?=
 =?utf-8?B?ekM5L2pIMERuRmVKQWVOOEhjcWRpbzhhOXhnaEJTaTY1am5IdjUvcHM0MWdN?=
 =?utf-8?B?bjNZdEVKbnZ6ZjZYR3VQK0RIejFXUEhwcjJLVVZkWWdSRzY4Uy9POHB0TTZS?=
 =?utf-8?B?a2MxMFNZNUw0M0xWQUVRRHlDdnNLcEJBcVJDVXF2eEc3bkQ1SWVDbGhnNFBJ?=
 =?utf-8?B?aDFDNXFxMTh4VTJKRWNlL0JWT3p6LzIwQ05hYTdLenNaWFh5bDVnakFTZk1r?=
 =?utf-8?B?TUljMGVMaEI4VTN4VG9hWFdHMHRyR1J0WHpQTElIU2hVUzJJem4wNk14YkZQ?=
 =?utf-8?B?UG5CY1JiMlI0ZFljMjZZQmx0cmoyck1yYmJ1dFhzU0NTM01CMysxK0VCdWp0?=
 =?utf-8?Q?qtBqQ8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfec491d-c0c3-409c-037d-08db61d9883b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 13:18:32.6676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bCp1qomljEN6t4gMj2bS3yPKkTkeqkl9BnmV9gStfTtdxqoQyNGDrVGQm0E3s+SouMVlbyExpXuk69uywFjlLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6821
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-31_08,2023-05-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305310114
X-Proofpoint-ORIG-GUID: fCLht8stBWapBlzcfo2FH4Epzz8I_CHr
X-Proofpoint-GUID: fCLht8stBWapBlzcfo2FH4Epzz8I_CHr
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2023 10:19, Jing Zhang wrote:
> The jevent "Compat" is used for uncore PMU alias or metric definitions.
> 
> The same PMU driver has different PMU identifiers due to different hardware
> versions and types, but they may have some common PMU event/metric. Since a
> Compat value can only match one identifier, when adding the same event
> alias and metric to PMUs with different identifiers, each identifier needs
> to be defined once, which is not streamlined enough.
> 
> So let "Compat" value supports matching multiple identifiers. For example,
> the Compat value "arm_cmn600;arm_cmn700;arm_ci700" can match the PMU
> identifier "arm_cmn600X" or "arm_cmn700X" or "arm_ci700X", where "X" is a
> wildcard.

 From checking the driver, it seems that we have model names 
"arm_cmn600" and "arm_cmn650". Are you saying that "arm_cmn600X" would 
match for those? I am most curious about how "arm_cmn600X" matches 
"arm_cmn650".

> Tokens in Unit field are delimited by ';'.

Thanks for taking a stab at solving this problem.

I have to admit that I am not the biggest fan of having multiple values 
to match in the "Compat" value possibly for every event. It doesn't 
really scale.

I would hope that there are at least some events which we are guaranteed 
to always be present. From what Robin said on the v2 series, for the 
implementations which we care about, events are generally added per 
subsequent version. So we should have some base set of fixed events.

If we are confident that we have a fixed set of base set of events, can 
we ensure that those events would not require this compat string which 
needs each version explicitly stated?

Robin, please let us know what you think of this.

Thanks,
John

> 
> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>
> ---
>   tools/perf/util/metricgroup.c | 24 +++++++++++++++++++++++-
>   1 file changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
> index f3559be..c12ccd9 100644
> --- a/tools/perf/util/metricgroup.c
> +++ b/tools/perf/util/metricgroup.c
> @@ -456,6 +456,28 @@ struct metricgroup_iter_data {
>   	void *data;
>   };
>   
> +static bool match_pmu_identifier(const char *id, const char *compat)
> +{
> +	char *tmp = NULL, *tok, *str;
> +	bool res;
> +
> +	str = strdup(compat);
> +	if (!str)
> +		return false;
> +
> +	tok = strtok_r(str, ";", &tmp);
> +	for (; tok; tok = strtok_r(NULL, ";", &tmp)) {
> +		if (!strncmp(id, tok, strlen(tok))) {
> +			res = true;
> +			goto out;
> +		}
> +	}
> +	res = false;
> +out:
> +	free(str);
> +	return res;
> +}
> +
>   static int metricgroup__sys_event_iter(const struct pmu_metric *pm,
>   				       const struct pmu_metrics_table *table,
>   				       void *data)
> @@ -468,7 +490,7 @@ static int metricgroup__sys_event_iter(const struct pmu_metric *pm,
>   
>   	while ((pmu = perf_pmu__scan(pmu))) {
>   
> -		if (!pmu->id || strcmp(pmu->id, pm->compat))
> +		if (!pmu->id || !match_pmu_identifier(pmu->id, pm->compat))
>   			continue;
>   
>   		return d->fn(pm, table, d->data);

