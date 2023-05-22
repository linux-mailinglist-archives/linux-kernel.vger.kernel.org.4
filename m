Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E6670B983
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 11:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjEVJ4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 05:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjEVJ4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 05:56:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD35991;
        Mon, 22 May 2023 02:56:05 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34M8EHr0021365;
        Mon, 22 May 2023 09:56:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=96pQfB9tM3YAd2MGwnivawLsDxG3Zmk/AEvsG3VtkGA=;
 b=PPyhbmdbo361t2H2i+1QfpJwvv9U6RyGo53w/wa4DfbBOUoZoTlZUbUzc3fwDU/IWUJp
 lqlyR24cEcgzLIRmUhvYs4raFEYG+L8M6NSMuAZd+SX9X0dmvDunWOcQwhfipjTiZTIE
 Fj3owkhKnmybtT9knuKUyDqmefVbEizGlWLL8vGrEN38W7BtlO11H7lScjKg6le/kLy+
 QsFJ4iDDOnawsiX54KB8xus4rY/V1x8Clgjht/NPOGgd5UeiPDIstFkOvdWrU3XAQM31
 tZUuSKyoniNc2NJhNyyL9lP5GfKebXrZUTkYCNdbC79rUOA4Emy6SHZXRAphSOKbvweH Ow== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpprtj9x9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 09:56:00 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34M8WU13027071;
        Mon, 22 May 2023 09:56:00 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2byr5u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 09:55:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HSWP37GCHd1jjeFBurpIOmm/Ocr4pP29ZNFAV6RlfjRX3cntriAZhLTyyUz9+9cjzdek80lOYFW3fyCh2FmwDgi5HoQQTILu2+KGXo2LqN37kwtx7jvp6BjR1eA0fhQLalJ9Q8tDr7Yd0JlummSyLQgdekvyoRnpUhAmxeLvmZkrZGL2lgxfuY3c/K6lEnZibMnQQSK7N5zH82gcmO9D0gFOPXwpWX9ih4AvR4UO2Qt4IuXO+D9U4+Tu+5u29/sEdXEvJA7GgkAEdGk0gTCec9TahXZAcGQo/LS2dkUCFKmwU2nIB0rCSmgrU8vCLJUYjqkT2lNcnuxQ1CcKLJZ6FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96pQfB9tM3YAd2MGwnivawLsDxG3Zmk/AEvsG3VtkGA=;
 b=Zr9VR4/TapMAB43C8A/Iwo9z0lzhTLH7ka1VIq95/EF2LF/Y/jGmOIgY/2M5Oy/E7U5scPCqnUZUIl4KXy04wsYahvZjBqlQR6CEGNpbn33T9KeNmhidGc3eBACUChGCQXsJgksIpxuhrkdMpfPjeQwmiTgqA4zBWoGR1OTSxZ9WqWXXlkI5O/kMQnvXgQGFDRS3XeC0WM6wRUd7xBhgjFQ7vL9cd+DmfzLXmr22eFzeFryRaKt8eG53Oo9OsnvxNMauoVBse4ggunabADhmt37zKCxHraSQOYNTHb+LWSwQw0QCas+QJuH/v0ZHY0xqc6MHrdT9r1xrG23TzSUw6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96pQfB9tM3YAd2MGwnivawLsDxG3Zmk/AEvsG3VtkGA=;
 b=Y8kXx8UXetC3jN7e4J80GbqDVRL6PQiLadjyOXW5jOBHkD5w6uvZpI/UaNhYBQZk18BBANwRwHlwzOzx8AJOHadJk41XcvWuFUMqi6ehwnMoiL67G296EdaUrLB1YTkNtd/FoE8yTkplsGuKwqcbujsMEh8PKyrLSdn0aztAMg8=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BLAPR10MB5059.namprd10.prod.outlook.com (2603:10b6:208:327::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 09:55:57 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 09:55:57 +0000
Message-ID: <73e3da3d-ed90-6c38-3c8c-13653bd89944@oracle.com>
Date:   Mon, 22 May 2023 10:55:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] scsi: Let scsi_execute_cmd() mark args->sshdr as invalid
To:     Bart Van Assche <bvanassche@acm.org>,
        Juergen Gross <jgross@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>, stable@vger.kernel.org
References: <20230511123432.5793-1-jgross@suse.com>
 <yq1ttwbsoii.fsf@ca-mkp.ca.oracle.com>
 <6614f626-d174-03d0-0993-79e6f6169b71@suse.com>
 <9d356278-c826-dacf-cbe0-79f512b7970e@oracle.com>
 <60aeffe4-b31d-4ea3-d4ea-f50ae25e0316@suse.com>
 <74879c87-689f-6a8e-a177-8bde4c9c4e51@oracle.com>
 <fb0efbd1-a54f-09d6-bd27-6f665b461e58@acm.org>
 <554bfa20-2228-8655-09e2-492cbfa183fa@oracle.com>
 <c9f0bc23-d5c1-23ba-2752-d89be9fef04a@acm.org>
 <611e1210-d89b-9046-ac3f-68a89af6159e@oracle.com>
 <ff04d098-17cc-42c5-cf72-2128fb43114e@acm.org>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ff04d098-17cc-42c5-cf72-2128fb43114e@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0296.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BLAPR10MB5059:EE_
X-MS-Office365-Filtering-Correlation-Id: a9c67719-bb3e-4174-23de-08db5aaabd99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OWz2hNe3H3OOxvJepWwAsFVtmpWRD9cp/PS9OZbLGbTAuUB4vOvr7NmcFc1YzccB6J2d5wxKBzowz/ZkZvd5l+rXjNu0dMpL3i5WhsQBUP9JsIsaRaGHFIKPk2gvwlq33LYRQjxETBQJ8VWywZ8/Xho4bf+JE3K5GnRCZB2WcgGVa3PwCIe2SODyJrex1JVfmCDrttAG8aSB83OvONPNUzX8PEm9geQbh8EmktVab+TOZAhVqBRFOy3fK+YQYEI9kNCzuqy8PtKQqSwKL3AkDY1WX/3gU3Wi2Cqpu578ZT1ltCL2h/sb6j4qY4MzX5V6f8nstHAMsYcPpM6VxkvTbu5feQ+XTn0jHN7KFBoNFwdrnNS2cQGMAgt0K+EX9WbtlSt0Kn9YM8fbMDa1+oC32gZcU9mS9l5kh1YOEB4RKgZaN3sJWJwb1ln6p3J3zA9Nwt5JOYZyud2R2pChI3aSV0WgTX6J+aE+K1M6HGi9iwMVw/ZsNxyQCis4IwB1/0xYQ0YqvgFPcaj/g17DgjxgfCmKihYp+N7zWo/B45tJYJFDF2f//JbdmPSS8jXx/ZMeXhYUTzFcHlMKSZ4grrMak+BHYQjTtTQbfQZZExwIncsO0lzQCzj6jCHXBxFdKPiNnxZ4aMsVZT5x5KHQ3Fn2SA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(396003)(376002)(136003)(39860400002)(451199021)(8936002)(8676002)(5660300002)(186003)(53546011)(6512007)(6506007)(26005)(2616005)(31696002)(86362001)(38100700002)(41300700001)(6666004)(6486002)(36916002)(66476007)(66556008)(66946007)(316002)(6636002)(4326008)(36756003)(478600001)(110136005)(4744005)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWdFaForN3c4cHNMcTZZRWJSckEvTEMvd0c1L3llV3MyNWlUbVlwRDB1ejdR?=
 =?utf-8?B?ZnJLRHMwT2gwOTl4eE9wZHpybkl4STVLdm1MWmRBbnVoQU1lc2NwcWhvR1JL?=
 =?utf-8?B?REFpNVMwREVjb1BzSlM2bDlaeHJSR3d4QlJKWmcxblNqbTdBZ3hveE9BakJQ?=
 =?utf-8?B?ZVFCSVN0Z09zSWtVbUVuN1ZlVHpWSDAvZStGQmlpWHNDVldCL1RMMW9Zd0x1?=
 =?utf-8?B?WTR1VHhqWXlJbVdkZG1teHZiNVRoMDZ1czFIRUdBaGRUakZ3ZlpuOWkzaTZX?=
 =?utf-8?B?NlF0WlBKclk5Y1FZTVkvQUhscU5Ec0VJRmd4OXRRNFF1SDlWZmZLU3VGL1li?=
 =?utf-8?B?M09CRjdWais1MWhBUWxQc29HQlFKNEVPcWhWY3lxZFhtanVTUUgwTWJEY2Vr?=
 =?utf-8?B?OWo5cmFYY09CNldocDBKTmhLb203RHFvYzk4eUx0MnhPSjgxT040dHZMSHVO?=
 =?utf-8?B?bTRaVExMcWd5Y1hyOU9oemgyTGZrdkNNVDA2MWJvMGlUUDQyYVBONERhSS9x?=
 =?utf-8?B?Y2p5eXdYYW9icjIxeVdRYXBqMTNGbjk1RHdHazhDa25YUjFWdWlDeGpzV3BN?=
 =?utf-8?B?ZTFwbHpDQ212UElOQzN5SXgreTF0VEp1UmQrRmlKT0ljczgyUmZ0d1l1bldD?=
 =?utf-8?B?Z3NyMlBWVCszSTBUZE5XVWY3M2xlR0kzbCt2UzFUalM5S3hPWWJJVWVYYmcy?=
 =?utf-8?B?eEpvZ3R3NjkyWm1pR2JIZFZOc1k3T3Vkd2FoVy9XejN2SzhMcEpleUlRWjFJ?=
 =?utf-8?B?Wk9XNlNDaUduNDJCVTBUZHN6YncwQ0ROUnhLdXk0TDNkaE82TnZpVC8wdGdq?=
 =?utf-8?B?OHJoSnFzVG1CVmhhYnY5OFpQOEN0djFNb2xacVh4QVNxL2JqdGh2NlRWZ3VL?=
 =?utf-8?B?eWlsaStoUjVZcUdXZTBjVkQ4WVM5Ri90SlY2REEvNCt6Ry96VjIzSWtJc0pF?=
 =?utf-8?B?TndvYkJ0VjVxZTI0UUQ5QkZUb0pKSjJ5RTJIb3FSbVRzRTNVaXoxbHFNYVI1?=
 =?utf-8?B?a1VicEt6VzRPdnFLY3lkbnZIYlJkYWVKL2M4M2V2OTJWcFB1SWsvd3AzMjhR?=
 =?utf-8?B?anpRTDJ1d3FSVUZUeFIybmxacFQzNWxZejB2MGNvMHpjb3hpVGQzb0V4MjNM?=
 =?utf-8?B?VElnQjhWOEs4azQyTDUxbHc3UU5qWGw4WWNNejhjeTVqT2tnMlNWQVhXTXB4?=
 =?utf-8?B?a0RkUnFPTTlXdk9YNXErQmZQT1hFZExhRGE0OGt3YjJ3WVV4dEtMNnp3YUVX?=
 =?utf-8?B?Vk11d3QvcjE3Y1Z1b3crSEZHb1NxRXVjNXNoaWd1WjVCb3NCbXNuK3JvcWl1?=
 =?utf-8?B?SlBoZmRsZ1NGUktXcW53R0Jaa1pqeFJNUFJoV0FLdHVvT0wyR2VqS1pDZDFn?=
 =?utf-8?B?ajNjYXYwQUdNYnRnS3FDY1lONVhmZ0NUT3NibTVRT0cwNXVrbmM2NUtlK2VB?=
 =?utf-8?B?ZjE0aEd3Y1FwZGFpOTNTSWJlUjlDMWdQMzkvbHNHd1V3c1FqYWxnVytmUVg5?=
 =?utf-8?B?VW9ZMlZQUEFZdHZLbVZheW9Bakw1N2FBT0RFd0Mwb0pmRHVZZ3FzMWI5cVZV?=
 =?utf-8?B?OG9kSXorQ1NQcTM2cnd6V0ZGMHVjRy9PWFk0eENHUmpDTGR1dkYvUUJHTHRp?=
 =?utf-8?B?WlJMZXZwbng1NU1BZ3VDeGNUTExuMkFLRHBIRUdYcURLc3ZROVRLNDBlZklX?=
 =?utf-8?B?cHcrUUcyYVgrVW40ZWVraVpLM2JkR0VtQVZ4VHhxZXlLaUU0cSt0QWdOYVdP?=
 =?utf-8?B?UW1wbWxjTkJ0UGZ5UTQ3emQvZ2k0bDg3dWEwdzRhNEp5THlGQzllSndIaUFL?=
 =?utf-8?B?bnJvY1orbit3Ujc5K3VuTW9FMDFzTERMYno3SWVRQTB4elIzTFljUzdQbDF5?=
 =?utf-8?B?azJFNWsveCtZSDUrMUx0RXBxMkR6K1d4YVpIcSt4N3d2WUdrWW9oVVAwWEJ3?=
 =?utf-8?B?T1FsTE85YitFNnNOZ28rdEZKeC9pSXJsZDdYcG5XcHJVdkkxN3ROcXIzN1Ns?=
 =?utf-8?B?MUtwVS9scklqRWdMZDZPZXhvS1owazZiU2VLTEF2NXhXako1ZEtxRVVscWFy?=
 =?utf-8?B?UGs2Z09mclM2dWRPelJXYW9yNlZFMEVHb043bHRXbENqVENKMWJzV1prWkN4?=
 =?utf-8?Q?zYeftVq5lURUtFamarw/nRG2m?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ayUXZIRQlla5qakD5S9KQGzRVtgJyc2vWwwe2c11UY357YyRP31E7SrrI0icoPDUiMWrsvD8fqKKTgFCcRLqPfVJ2IMxCnldvYzh/wYNFNAtnL29d2Wj0GQI5pmZY3c3h4KpV5PboU1PfaVOdLz84hbolMibfOaX6df4fV+QReu6w670OWOTeXSlmo5kSRLmjcqG19XVZrpmoaBLmhY2l/fV++ybnbTVeVOZmuzWH31Q3OfmcZM5p8wLLOjWoU8c/ZNIAdP+jOiiU0A5iOyjuCeDK0P3DtVjsIJnc+NetDFqZHs7k6fwy+Ap+btAg6m2744DO4CD0LNRMCiW7UcCrJ7/1D1ddRdAx+Y7ZPUdbSvLmKAzDxRBp8bYk1BPoZoersp9DaKI5e0eFtSNjaXEvovWaHubXUvlpOz+toj/HTkWkNGUyvXAOblGbwp+KwAyTaX/UprA9vtNn95vx5qIbevTSGSVYAo+gGKk1q6Lgt2uSQ/0P/GGNCR3S58+KuJP/OS7HTo+rZZv9sfTgfWk5wavJysk2eOluGhNEfWKVxnqhigmi8snbyINTS5UGdYzVCraNs0Iwl1vDWHbA2ly6JIYaKepqadavCpDRnldKtJsBvoEbiCefgu1slR1Ng2DDB5HrteodT+ED+y5NJBnCj0bLJEpOWKBuhbyNUACfdM6t8kiGPdyJxlzwd5H/93DOGhF3lZhSgwzaRUpe/jlhvYz9PmyFtjwDr2eQmDFz0+WzrbrEnZQmC1WaL5wakTtFg4hVmVUGOyBrMEIkFcTKgtYh9P5FFznM3pNi4fYGbLUvtWHQWiG0FQ1Xv8g9whm5QrADefEAcfhEBZF485iwA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9c67719-bb3e-4174-23de-08db5aaabd99
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 09:55:57.6704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oRHTwc7/ZZlw8DO1SCgodXLphBldm0lPzKbPvwmRTNi4Y/VV/9+tczouuS/aougWWbLD1UG+kkL8rl4MP1BO5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5059
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_06,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305220084
X-Proofpoint-GUID: 6FOzSnAfKNqi1Y1TJA22W7x7OahFsapB
X-Proofpoint-ORIG-GUID: 6FOzSnAfKNqi1Y1TJA22W7x7OahFsapB
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/05/2023 18:39, Bart Van Assche wrote:

Hi Bart,

>        *args->resid = scmd->resid_len;
> -    if (args->sense)
> -        memcpy(args->sense, scmd->sense_buffer, SCSI_SENSE_BUFFERSIZE);
> +    if (args->sense) {
> +        *args->sense = scmd->sense_buffer;
> +        scmd->sense_buffer = NULL;

I think that you will agree that this is not a good pattern to follow. 
We cannot have SCSI core allocating the sense buffer but a driver 
freeing it.

Thanks,
John
