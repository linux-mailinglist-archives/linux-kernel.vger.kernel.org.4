Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81517696D0B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 19:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbjBNSgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 13:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231269AbjBNSf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 13:35:58 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B186A4D
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 10:35:57 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EHwlgX027967;
        Tue, 14 Feb 2023 18:35:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=s5S0sx2oDlOA1LtjTXr5uJnvayKcc5Ao9kt4OMlpsqM=;
 b=T1XjqkSHsKM3oI1CGgzEbRfp7Yy2QjGaM2Ta3CXKo4pZ7FBVuh/spHJXsu276sJH+uxD
 +5cF0NoOTcLHZoTlMRlmEwtznv7YLz0nNVip+lsziLBqVZMdwu6+fvItnFPbkdoqqo6s
 G0OR82u4n7AVWxXnmA9EajB0grF7rR2sfBQCdWsZT04sNj+3kO4Jbq7r5ITsDxCmnA32
 Atnqla0+/834pDo/jkoV4nzGLiIaV9+Rv86mDS5YoLI1LrnExHNxGLY3tOUkiZW+zMXf
 /XZ4Q3VPGHjCB8baTxmCd7j92CIR0jAPfKA7MiLCbYr2wLCqvISZIosXkOqGK94BeZZF Gw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3np1t3e6pw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 18:35:40 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31EHs8SM027090;
        Tue, 14 Feb 2023 18:35:40 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3np1f60jsg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 18:35:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2Niqp16mcg3DmcYMwYo0DuK1FKWPDDaOZzE+WTrToYX+zoTSh1f00qYYkbiDlxiyDHEvyfcFWbbeGQAmYe6gWPGuZ+WRnehVjKkGjVTbXSgnvScmesXtPyhTIrDaXiCqUsZaqRxQOJSqkB4k4x3KLGbNdmX44yUsf1QAY31RhfY+2C3OZt+jUlRTczPqSMdIBqrNkAxKtPaG+NB/dz/cfvUHRlh/WvZp75CoPPbMiYonhAsc67YJov2q187c+oKaD32NSoW4CnrL6lZN9aJEZ29YDfI5NdsWFsMTxKjGQa16kDuxAR4qJ8pP6woZ+zZ0oY9qHDlyOOkbG9FazgM6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5S0sx2oDlOA1LtjTXr5uJnvayKcc5Ao9kt4OMlpsqM=;
 b=li97EADbVfc2QHIyAtUhm5zbOK8b2/BOXrA4a13CaOIZK6b/oZPksI80A1aI6vB3q6QipECS4x4iZyWbj/xDh5DpQxuOoB5pRrZZigiuJd/fd/6kZlH7149CnhvLBT2iA63kMS96BQOKlHW7abXxQFq3aJTESDp+yZ4Oeuh3Wp8ek6snrcGnL2HsPbU/uaT1XiaP4KgYH0fr7EvOk4KPsXiP07phO1UX6SYUlJx3EWpgBGo2eBruOOPd63h9ohThSyqjlXtE3Db0+x6xxkksWrdp29roP+GXJ3/vf85cT1qicqo21MBa28QKUt5SkensqUP0357hE34l1dSBu0urMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5S0sx2oDlOA1LtjTXr5uJnvayKcc5Ao9kt4OMlpsqM=;
 b=JVRPeWndihVkoL/Zsd8oRkQBcKWxRNaP2urFc1O9dO4QWhREsJVuHP8z8hosMFbExQQBTx7BFz62/cGiAmTaiReIrFIVG8p3/4TJTmyWgUJNt5HVjQn8WbQQ4oLXTzXfiC9acV1hSHs2WCnzHNO2GDwAbWCGRPXkFbpfQzk6vtQ=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by PH8PR10MB6292.namprd10.prod.outlook.com (2603:10b6:510:1c3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.10; Tue, 14 Feb
 2023 18:35:38 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d7a6:8396:4519:9cd5]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::d7a6:8396:4519:9cd5%6]) with mapi id 15.20.6111.010; Tue, 14 Feb 2023
 18:35:38 +0000
Message-ID: <ce84bac6-b868-76f9-4678-d3eeed42eae3@oracle.com>
Date:   Tue, 14 Feb 2023 10:35:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: Query on mm/folio-compat: pagecache_get_page
To:     Deepak R Varma <drv@mailo.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, willy@infradead.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
References: <Y+vRpvwNgwDB4MS0@ubun2204.myguest.virtualbox.org>
Content-Language: en-US
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <Y+vRpvwNgwDB4MS0@ubun2204.myguest.virtualbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0054.namprd07.prod.outlook.com
 (2603:10b6:a03:60::31) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|PH8PR10MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: dc3eec90-88a5-4aa7-3ff6-08db0eba4476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L5IQRYy23/9g8GTriItofrbODtL+eCx+HEzD4GIdnNsqP1HFv1Gr2o8aE9x9ooUTqxd300fF3KVnFlUXIu1h/iKyL1AT5iNozU2jBp56kZKtlfeLcgU2o5tjQ8KpxtZQvtgrCst6p0vS7wq7bvemxg2snd2fVRa0M+O67R4xESwSoeITjnQAIRGYuelApYIFOlN/6yit9myJ3ifZBCcPZa8LvtinZ73e3H71m0cQnS5G4xlO1V2zxd47CCUaROCfxWwNvy9fifq8fMe+HPsOaJMBqcvhFH39MtGEYPOOBSW7hhuZ0C3tq8ubyezu/z+bBD76w2mqYfOB3paXabn1/DQ9ruelUriszdHa4axYOGYrGDjLD2jAKN07h8eOm/WvRUPhSqNzCEKESWHjhtNB/lVrRMaHKfFsgYgXgXzFcmxdR1U2Dr4Dm9wJ1OrOE6sTsMR5AiMKwp3YWwu7iv1hi6TcC1JlvgGxBFa9Ruxb5uxmyIJjQ+QVFUzDEn6GWJmI84hDSRe+B7Jr+z9LPa7aovGSUfignmZ1Blj5uVZML/KXYY1ogNa0AudzjBZWhE1KHo1Sqar5V4prQAgH99zuW7RbFHdNGq+fQD3JJ/WJKR+Dk8sm3KClIrY5M+HWOtF8N2D05B1XGJfwqW1LCBxsuAfvDvzEgrEWsd+iBCHUZJ4N73NK/lXiYGbIkhbHK4C+dkr7ElBZRh5CVlpE/fFWvw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199018)(6666004)(38100700002)(2616005)(66556008)(41300700001)(66476007)(8676002)(4326008)(8936002)(66946007)(5660300002)(44832011)(2906002)(4744005)(478600001)(316002)(966005)(31696002)(86362001)(54906003)(83380400001)(110136005)(6486002)(36756003)(31686004)(186003)(6512007)(53546011)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0YrZDlzMkltQzZqdWpxMjUwMmI1SjEvMHVjZ1BnUjQ0ZzVybUhMUVhkZXV4?=
 =?utf-8?B?WDZ2NGxsWUVZUUNPdkFWR1pjMVlkVVVFQzFjaHlBSm1jVG9yRUFWWVgwQWZM?=
 =?utf-8?B?MTB3R2NBYk9UcUszMFIzOVlZWlhzMVJ0ZE41dFpubm9rMHpPdTNJRG1abWxF?=
 =?utf-8?B?RUZkNGdXUHdFd1hGUXBoUmMyZk1aNDdNZ2VZam1lUnJ1NEkycld6WVJxL3Uy?=
 =?utf-8?B?RDhwSE56RFZjQ1lyNXlBdytCQjNlUmdGc0FkZ3RGbFZlbHYwRUZ2dmhPU0Q5?=
 =?utf-8?B?bTFrR1VSajJDZXBKbUFKdDZRN0RJZGIya0V3NnFxdWJDVjBxKzhFaEtnWEZU?=
 =?utf-8?B?R3BYZjBDTnJRTW85QmpHUERKSlFScVdzWHozSjk4bHZROTRtbXAxTXJSQ2tw?=
 =?utf-8?B?Vm01NFpPWGJoTlY1V1BKdE9GUUhacHNpWUJWcE9BMzRXTUlweFgyb28zWEhs?=
 =?utf-8?B?aGdyVlh4R2V0ekxhb3FYME1kR2E2RjF1YUdFeDk3cDdTcTZhS0lwRjlIMjJq?=
 =?utf-8?B?T1hhUzR3ZHRJdC93bDYxZUhrNVpIZGRvN01JRGcvNmNaSjF4YUlyR29oeWxu?=
 =?utf-8?B?cVRpWGk3TkI3bmlxeUNHVWZEek1TK3lsK2NBc0xCdjlYcXNPRnMxbk1oUkd1?=
 =?utf-8?B?ZEMrYnNpUHMwQk5hQTIxSlA2a2hvaFdOTnJLMUdsQjVVY3Z6NHc5Tk8wUkxl?=
 =?utf-8?B?eWg5RlV0Z2paaDNwM3VCdXR3Yzc2QWcrTHlxL20xemQ3bWZlMDlESzhzYkts?=
 =?utf-8?B?aDZUYSsyaEl6YSt5U0hyU2hsNlhremJNeWFacmVLcjFwbCtjcjcySE5yZ2Yy?=
 =?utf-8?B?cmZkNzZRcmxpeSt2dmVHU3hqNWtMNWM1NU9NTnp4cTlWTUs4QzZWbmF3bXVQ?=
 =?utf-8?B?NXZsODlqclVJVVNpK3dBazZLcFFDUERXcHRhQWUyZVJ4aVF6RHlSdWhyVGMx?=
 =?utf-8?B?RklpWjczNGJjOW44eXh1b2dCckF1dXZCWm8wWFFNVVI0M1JQSndpdFJaY3FY?=
 =?utf-8?B?NmdkOXpvcjQyS21LQVF5L0lYdDYxUlZ1SXdmZElXdEw5MHRkMGsvWW9zRW5U?=
 =?utf-8?B?N2J5ZVVXT1lNMnM2SUVlTmFGWm52Q3FMK3hJNEYrR3NBNlZYTlpYaVluaTl0?=
 =?utf-8?B?VlRlYlF1L0hrenRBdjJVNHZxT0RFaFl6VFJlalA5MHJtcVY4TmZkc1Q1aEFO?=
 =?utf-8?B?TzdzOS9xZ1M5Ykp4cFZrendKTEVSYTNZOWVpbFN0V1BCRWZyY3NiUUlXUDF6?=
 =?utf-8?B?dndiYmtkcTJ2bElNYjRKNjVLcklrWExjemdTL0JWb0FnRkFMekl2dW5lb2U4?=
 =?utf-8?B?VmYxNXI1MmFWQ3pXTEdWeGJrc1liQng4SFFPS3BkeWVJZ0ZjVDJ4bTY0Q2Er?=
 =?utf-8?B?aVo4NUk3R0pPdGhtU3B0VGVrRHVLd1VaVU5UWmdEWWF4RmlsVHk4NTZETjdK?=
 =?utf-8?B?T1g0eTVxcDZCT3NGalFWbGdoamFXNXZ6Q2VOM3JyMWlCMzJnUlNvV2QxanJj?=
 =?utf-8?B?M3ZZN3YxeG4vZ3UrVkxaRkxaTUlZdXBwbDNSV0hOUGxYcnFJUzBBWGVNWUVx?=
 =?utf-8?B?cG1uc3krMm1hNEoyQVJFQ0pUYXhjNGwwTG5VUCtGSnh0UEc0Uzluc0FPcTdj?=
 =?utf-8?B?cXRGZU8xRk1WYW9BaGtqanRRSU1QZmVwOUFpUzNsalVOLzYwZGhNSXVmOEhs?=
 =?utf-8?B?cmd2WGNXR1NxLy9nSngvRmU0ZGdLdkJPeUZqdzkrakpuRzNocG9LZVV4UjNL?=
 =?utf-8?B?ZzluSnkwYU9JRnY1a250OTNJckRyMGw2TEdnUGdQZXFVblczMWVqUmQ2cjhX?=
 =?utf-8?B?TmcveG8wRFY4bUJBekkvZ1FjS2h1czhYL2xxUllXSkFsT2xjWTBzc25XaDJF?=
 =?utf-8?B?U1hhd0twNTVBUVB3eVBNVGt6cGpyTnFrV3NPQk9qUUVKTHNSRFRlRHpwZWVl?=
 =?utf-8?B?VExOYTZER1dXdTF6YU5TVVRnQ0ozZnBReDhIdHRpOEw1UytQdzlIb1R3dkxE?=
 =?utf-8?B?VDVrcitOY2MyakhHZW9vajZSazBURS84MTZDejVIUmxtK2VWY3NhUmEwOFhC?=
 =?utf-8?B?QW1vMllVd2RLMG5RRjhja3MwQnpnWnZzMDllZDA1S1NWYUVJa2VIVVoySyto?=
 =?utf-8?B?VHoyam9yamg4THpLLzFmY0FsSzBzSFRqTnpVcnBXRTgzOUxnbERLcUZsby9o?=
 =?utf-8?B?dmRXdjFrRE45Tmllc01hQ2FWMERDM3pPTnl1NFkrc3NhMnBQMWduYzBLY1Y5?=
 =?utf-8?B?aXJTU1VXZVZVUWNMMUdKRkFOTzZnPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RU9BN2RXNWx0UzVCVi85ejF3c0FudGhvb0dIYURjejFSSUpvNHNtRFRteUFJ?=
 =?utf-8?B?MU5WUHFkbi9sWStvS01tbTZRRFFKSm5BZUFiVzRXZ0VnT3k2eVFTYzZleSt3?=
 =?utf-8?B?dnJtUmYyK2FHclZDNFp1RWFvSS8yc2NNUndoekdaRmNOME5GNG1hSWphazZk?=
 =?utf-8?B?cHBvWEJDSXlLQzIwdUJlLzdqckxFMjNIVnIyZFBQaVkrMDdHYUdKaEY0MnVo?=
 =?utf-8?B?R0tFL2hXQ1lpdHR5NFUzcEV4cHpkZkZhTGZkS3FpVW5SaUsrN3dWNHVGaFhm?=
 =?utf-8?B?NE5jQWJ2UXJuVitTSnE3VDlXWEZJam5jeE5PNFhkNEh5aG9qWW1vZHRCYUl3?=
 =?utf-8?B?RlBmZkxuVjIxOE1HUG1OalpscnhCdEZ3Q3J5V0JTN2ZLNmZRZi9mMGxTcEJo?=
 =?utf-8?B?dk56ZGpWZTk5eWc3bVZiVTJzNmFoeDUwaEc5OEp5SCs5Y0UvWXB3YWtBWmJs?=
 =?utf-8?B?aDl5VE5Ya1BZbks1M3BkMG5OZ0szM0xtcDVWZVlaV3lGM28xanZoQlB6cmNv?=
 =?utf-8?B?Y1hOR0VPZXd6QUtlZzM2UkhqWXlrWXF1OXJDd0NJN1FCYWlzRURKaklUTlI0?=
 =?utf-8?B?UTZ0VDFkMlFxZlR5bFJTZmV1allMZ21VNERibFlBenZWZ016L0NXMm93N05h?=
 =?utf-8?B?dzE1dVBXN2s3QzdQYWpJa3FFYW82Y0tvV1dzOGNUYW1jKzAycVVzYVo2ZS9r?=
 =?utf-8?B?bU5LWTV6RTFmWjFEeG85OHBoaXk2UzhOTjg3NGZUNnJ6SWxZTVpGTm9hZDBH?=
 =?utf-8?B?SWZwV0FZZzBrVUk1L2VvTjZJaEdYT0FCQng3TFRmYjNpWGVOcTdxaFA0OGs3?=
 =?utf-8?B?Nm1HK3QwUEd4U250Ny9paUoyMHk3aCtMKys5TmdTREovTjBwS055b2JsMldH?=
 =?utf-8?B?Y1Rzb001TXQyajFhbFZYeU4zNmpCSjlKVlU2TXF2NE4xSmxyRWxkS2ZFU1U3?=
 =?utf-8?B?ZmJBckFScW1ZcE1ZWkZ2eXdKL1lvRUNlbXVzeVY2enk2MHhGSnE2NWlZR2h2?=
 =?utf-8?B?cUdoeEdDNmV3OWhnNDJLT1pnOGh6RW9aSi9rWHRoZ2FacG1xaWZMZEozUjdy?=
 =?utf-8?B?RE16VTlvZWYzMktVRmlKWWZ2dnNKNkZRbld4RS94NnBxWWdqRmNISFRpNUpN?=
 =?utf-8?B?Y0xXWkNsZ05CNUpLckJ5QlRpS1FlczZDODByM1NWdHMzRlNyQUt0M2UxVlJk?=
 =?utf-8?B?aGxTTHhXWDJwQXZ3TDBMRG9RZ1ZaL3RBbmhpQkFUOEgzYlBJQm11ZjVIQTdG?=
 =?utf-8?B?ckMwMVZjWU9LbkVlZWx5UWxKWlZkSFUxbzcvclkvdkkwZXloSEJBeGkrYThw?=
 =?utf-8?Q?4GmNRwmcPCjTYvZpYbPBpaCaNApkZBYjn4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc3eec90-88a5-4aa7-3ff6-08db0eba4476
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 18:35:38.0238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jRz3svH6wmV49t8RZOQMebiUuMIXPwOLWxfyrZlZ2EYhyvpaANNLg2FqwtiJ5yChZxGVOVIsg9qXkOIV0Rz/iXyr9JSG4dWXpqtJGtEt1j4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6292
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_13,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302140160
X-Proofpoint-GUID: bdlrSCtuM8TCRPVGTVf5KbOiDugzrE_t
X-Proofpoint-ORIG-GUID: bdlrSCtuM8TCRPVGTVf5KbOiDugzrE_t
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/23 10:23 AM, Deepak R Varma wrote:
> Hello,
> Could someone comment if it is safe to access the page member variable as
> written on line #100 when folio is NULL as returned from the

It is safe to access the page member variable when folio is NULL because 
the offset of page within struct folio is 0.[1]


[1] https://lore.kernel.org/lkml/Y7h4jsv6jl0XSIsk@casper.infradead.org/T/

Thanks,
Sidhartha Kumar

> __filemap_get_folio() function call? Is this kind of intentional page-fault
> trigger for the system to handle a new/fresh page allocation?
> 
> 	  2         folio = __filemap_get_folio(mapping, index, fgp_flags, gfp);
> 	  1         if (!folio || xa_is_value(folio))
> 	100                 return &folio->page;
> 	  1         return folio_file_page(folio, index);
> 
> The code is part of commit ID c5255b421fd04
> 
> Thank you,
> ./drv
> 
> 
> 

