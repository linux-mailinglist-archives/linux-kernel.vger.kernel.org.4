Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED84C70CE52
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 00:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbjEVWuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 18:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235002AbjEVWtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 18:49:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80B510FF;
        Mon, 22 May 2023 15:49:04 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34MKNwoe002004;
        Mon, 22 May 2023 22:48:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=8kU2od7tkGprdnlJCk9W0vU8e7D96pNgtGGkWcPxKVs=;
 b=wUENANVgYPFtLjkT/sZYiErSQgK8CPmS8HB424Z6rhQtbZFXONwctZGE++yuvnCyUUOD
 tlyCqDlxXPDbFTe8ZCqCvi2Bq3SgQDZc+p37I9iDD6kvq3dH4s9Lu0LlQp3X1kfYkYob
 jz2u23F6zVkF7xhaWpc7m7pfpDh3Akb8KfEwdABZmWgPIUMHGDvZ2VToLxg4Kc0USZ1s
 rCK63Vm2yV3G6YE6bM4Vzhx6nraYGwTh7ANhUc9Lir6l37s5jSSpde+S+ff+gCtYTkKD
 27M93IlsLjR9N3noIeVFqcC/ChHmmAmSdKUZ6qiV6xhKyPfMWov4rNJ4yc1nhqPx/C+o cw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp44kspw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 22:48:57 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34MMDKnO013556;
        Mon, 22 May 2023 22:48:57 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk7e2qaq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 22:48:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bW2okjc6oIrqZVb9ATbvsR3kQxbV2hJ36ohXrEOO0qepa26bjz+LGr/wYMLlXHoEFtKZ3jZdfunTmT5UJPr6NoNRuibU4JdC2Hy1flmzQghGir+cQKDiFgz59FF++/QtPSPZYxhpFbFgPUco4qSHwRVeri7DvOe09RayRQKmJPe2EJAc/UZ+9jGb5Uhr8bZfShqTZ/dlKZI5kpgVOHXDlF2ro9nw++Qj8Ju1/bGAubmKABfdigdGWhIKx3fZq009B31J5mXatD4HS/CemMC+z6QrGccZFCXmDGCQFvckBeufnA1D97BDbqvhDsQWmG0D6KEPZRtVBPciz9sGecY6SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8kU2od7tkGprdnlJCk9W0vU8e7D96pNgtGGkWcPxKVs=;
 b=T1xM0PEDon2872NR4h6pFGPaUyVYiH+NB7rW9d0O2CtArN7dzWI4JwQo5aa3doIGYNqneKYt/LIPdvJJ/HQm/GZ5wZV6aBjlQhtnWKfqKkYM8zaXarTPy6W0QJ9AYy6C7wEwTBzZSoC2J+0/NVQzU0lvEXVITR3nC5giMwr/HMpmYeRRXU0TDNJkQf1cJpdrum8UIIX5JTBm5yRhu3aeD3EGGzJiCyCE0ELszm4Cj+L/opw+1ir7i7fIGScpoKsha9v1UJA2LZJ0i9iRSQKee1lmCOqNwfEiBbS0rm7T7VSUrCTWj13TolDIdnI60zlfcmnnk62DkI5nD8w4R+tv+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8kU2od7tkGprdnlJCk9W0vU8e7D96pNgtGGkWcPxKVs=;
 b=f35+LjxA5JiaAcaXjbVCEZfdQ4CYNuBgNesf6Em/nhNcP54Ts1/KCg4tfilMrlIWejMW4cd/+2Pr/fW3QwYBRI7uicEF2k1HIJNFzJutRQjYJeobbIkxD9665/A46Dva2Qz6xd0q6XmWjDrVe4emVrje6i18Qz3ddGt8wknjIuY=
Received: from CY8PR10MB7243.namprd10.prod.outlook.com (2603:10b6:930:7c::10)
 by CH0PR10MB4843.namprd10.prod.outlook.com (2603:10b6:610:cb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 22:48:53 +0000
Received: from CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559]) by CY8PR10MB7243.namprd10.prod.outlook.com
 ([fe80::13d6:c3f3:2447:6559%5]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 22:48:53 +0000
Message-ID: <b3939ccc-0da2-9156-551b-dce6ee3e8b5a@oracle.com>
Date:   Mon, 22 May 2023 17:48:50 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH] scsi: Let scsi_execute_cmd() mark args->sshdr as invalid
To:     John Garry <john.g.garry@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
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
 <73e3da3d-ed90-6c38-3c8c-13653bd89944@oracle.com>
 <191c7661-c47f-5aba-97b9-ff698bda4bc7@acm.org>
 <ffb8237c-bd38-e323-0179-4313d9ef0a75@oracle.com>
Content-Language: en-US
From:   michael.christie@oracle.com
In-Reply-To: <ffb8237c-bd38-e323-0179-4313d9ef0a75@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR03CA0064.namprd03.prod.outlook.com
 (2603:10b6:5:100::41) To CY8PR10MB7243.namprd10.prod.outlook.com
 (2603:10b6:930:7c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR10MB7243:EE_|CH0PR10MB4843:EE_
X-MS-Office365-Filtering-Correlation-Id: 86ef26b6-7c70-4560-7b06-08db5b16b787
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0n+9Aj1ZZ8EGDO8afazNIIpctZ0QKcY1eDz5wRAaegzclOZ8Imw/O1SP/cRMFcGf7KLF2MhPdsgKuBjwBTQzRWBh+R6P9O8kwRFLPOgF3X80ogEKL5ZY5v0wmyxe3vgU3K8roQD9TBI5VF9rqCNm0I/3UCsU4o7HzeGIDrc46l5LCF6dMncmgksGQ8J0PxvTJWaCfjB25lW/IFVdgKhg86FEOBkWvgM8r2A587JzQ+OF43l8BjTrW4f5rtbUpEjg7CE6m74g/5isaQOcZ4ShyVIj+8koFGsE+nivhdIIrSjC3fDdhMvbvtZIp0uQ/LVrZVnFzvDfZpioVXgBzzJO8iNd8FrlyiG97Zf50fIcf2AhJ095cduXwlTSGU4d31Tolw1R5sUBLwwGgyIKTA+aNJv1SlOXYj5l1Yt2b2WbAYo+sEPRfKbwjnKfEUwaTEDFZF0mPFZTpinchKlIbUlYFUc7gIQa6vxaZCwZ9xAn+jGvxQB1z3vhSktGFGLxjV2Ua/VczxTbKKEpORO2Yn+GAZpOgsU4JrUUboe8dNzuIyjGc3B7d/M43KHG0fvSZbxDdb4HWb6CzY9mRKdJeB4NjnfVj/zTFSn35fQJ1J9cq8hz4a4EWHCL8teRIc3+9wv2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB7243.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199021)(38100700002)(31696002)(86362001)(36756003)(53546011)(9686003)(6512007)(6506007)(8936002)(8676002)(2616005)(2906002)(186003)(31686004)(478600001)(316002)(4326008)(6636002)(110136005)(41300700001)(26005)(5660300002)(6486002)(66476007)(66556008)(66946007)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlV1YThsU0pDUEowc0dEbFNyOGZtZ1h1OVpvdFkwSXM5MVJkUTJ1RUZYZkxC?=
 =?utf-8?B?ZHlOeXNWL2svUWk1SFU5Nlcwem05cWREQ0N6R2NvQWh1V3lITEhzYWJXUkZT?=
 =?utf-8?B?R3VGMFQ3QjlWUG5INGhPZjY5L1hFL21DRWVURG9ZSENjaVNSVnI5dkx1dll4?=
 =?utf-8?B?Y3dQTGhYTzNYYThUU0Q2VDlCSWlNQ3A0Tlh6bmNPZnk0dGZoTjdJYy96Vi9H?=
 =?utf-8?B?NW1HU0R3RklZSEdiS2pzcmV1NFJLRzBEUXYxNHFOTlRxVHpxbnpVSGI3ejU3?=
 =?utf-8?B?NnZjbHFDMnNDTmpMaktvK2Vxamw2VjFhcll2bmR4cklrZ1hVcjNJdXlXRlJD?=
 =?utf-8?B?UmIwL1VoNEgwK2xEbzFZcjN1Z2Mxa285WFdDMFAwS09oakpvUUEyVHJQVnVs?=
 =?utf-8?B?bEhSU3pEenJNWVpSc2VRWER2ME8xcU1mMnJUZzFWVzlhZEh6LzRpY2g3aW14?=
 =?utf-8?B?c0ZEWWMxRFZ3OVBiQ0F3bU9aR2RhOTBrSlhHUVViT1VNcnJTQTRNTEpvR1VJ?=
 =?utf-8?B?M0Q4OEZZY01BZHc4SFU4SDBCUU1STnpUNUM2OUtRc0FkaUZidmZ3aEZUUUNZ?=
 =?utf-8?B?QTdMSXpiZExZQ0FBVFNWMFUwcDd0ODZmVUFsSGhIZ20zclgwam4yRngybEdv?=
 =?utf-8?B?aWdQR0ZMV1RIWWhpUjVRMUJsOVVHZms3WVBxSjZsVk1BVHByN0paamd5WFhh?=
 =?utf-8?B?Z3BVMk5CSy8ycnQ5OFMzVUM2V1pFVFVjY2VNcGhPVnZzK2VSMXpxVExva2xo?=
 =?utf-8?B?a3ZGcXBUTUllMzhDVmVHRzBVcU92WS8ybXJ5aFNPT2RUbG5TSzV5allqM0Iv?=
 =?utf-8?B?V3ByNkJGMTJ3cG1pM2l0QmpEOUFzR1ZqdEN3Z21aVEVGTnN2RGtiNHVlVEhF?=
 =?utf-8?B?RllIMDc0QUtQcEl1VzU2b0NxMExkM1Y2OWdhN0U0aERYdUlHcjZtaDFsaC9Q?=
 =?utf-8?B?SXpGMEJpbXhGa1k3ZmxoRXlPMFE0M0hLSzFnbDZ3S29vQlg1ck9ob2JJUFJX?=
 =?utf-8?B?czFvdXBmdXYwNmdMZW14bVpTVi9hbjFDK1NnVWNNODIyazluazIwa2w5Mll6?=
 =?utf-8?B?bnoyeXkyeUErUkh4N09SR2VlNFVRMVZXalNEdUhNMUpMN1pFWCtvcmZsUTND?=
 =?utf-8?B?ekRjRjRpcVZldlByL0xsMEtyMVJBVUZDMGhQQndVc216N2tEdW1iMFlGaXRY?=
 =?utf-8?B?YlBDaVRnVUx5U1grcU5GWjVzL1E2QWFyVGRldXIzVExkb05icnh1RjhnNnhs?=
 =?utf-8?B?dXdiYUowMWpjU2VhYkZUY0ovdXdSZXFVcm45bnJKRWhQTVdMM0hRNmpqV2tw?=
 =?utf-8?B?MVVJRUsxMjBjcjdrVEdVZFpDK3ZKaFJPNnRGZ2dhKzU3UU1KUEFMN2JMNnV0?=
 =?utf-8?B?RWJmTkdEWWpRQ3JCZkFDWG41bXVrMDRsczJFdzIxZzhMN0tCN2NBQXVQbFVl?=
 =?utf-8?B?RGJzZ2pRcXhoMVdqNzA3QnBJVXo3VEgzRVJzeXZYM0ZYcHJ1QU5jZ20rT29m?=
 =?utf-8?B?T2Zodzk1RWU0bG1HdUp2UDFKY1FQUWRQMFA0MmdvQ0hETTRWbU55WTBFR3Qz?=
 =?utf-8?B?cm51RjdyS2dsV1ZxUVhYT2hYRFFUSDFaazZmN1FWVmtzYVZPRXNaanJjd2tn?=
 =?utf-8?B?amJHZ2J3bUFETUF1MGR1dmxJc2s0REs4MzZ4QUN5dHRvYkV5SVVFVTUwQmxh?=
 =?utf-8?B?WUQ1Z0hyYndjckdlbUdHQlBTY21pRnU3Q2ExclVscWlIR1d3T2RLNjRUbWdX?=
 =?utf-8?B?TFVQRXVoTVlZTjN3K25XTGJQZURuem5YUWNab1NFaFg4UEVLSUZSMEQ4UXZT?=
 =?utf-8?B?Uk1UZnNIUUFOZHR0OWxTMlJ6OVpVK3BwMFNDL1lKV2hFUGovZ3AyYWJCUG1T?=
 =?utf-8?B?ak5NY1ZpTGpMeUlIbE9KZ21pY2pEOGlOWFEyaGxlakdZNXJUc1FJUnUyanlL?=
 =?utf-8?B?U0Exb09uVlVxdnRVOTB6bUtBY255QXFqcGFnSkhDY3AyUkl2c1hzZ2E2RHdl?=
 =?utf-8?B?bHMrb3RZVXdlZEk4aEc2NGdUNzFYNHE0SUhlbHV3NXdTaXpmRUZ6Um9pNDJk?=
 =?utf-8?B?dWdXcGNwSVBDR3NNcnRBckpMZ2crbmhheExwTGVtSml2Y2dPbFFrN0hYZzFS?=
 =?utf-8?B?UmFBRlNGQjk5NmozOVFOOUFYWEFXU3pYV2VOYURMMGJNMEkvdzV0NEIwL3Nv?=
 =?utf-8?B?NHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TPJ1yeSqxYz7LS1vnSS2DPZWX7YLL9F+OjRlPil8BfjNdoOpuDxslwojhEZuRBnEP4vEmRpZDQqMwhrc8+s+LswAnjf0VOQZCHqYe5sv1R8LZW1ylLfqiH7rLUZpH1seQMH0zQ92VY+40S1UxwmuXnxxpurgv5704/VNVULT2Cm0Yr7JChoj0j2R3s6KBQ7Elhpyd46eJs0Rm8QuAlqDIDuLJoAFUvCnin+eqgMX0y98/0fx694Wx1XDwd8WMkvnxCF4VutNDhX3dQ76mBzAN6FgIwMmJAP4u4YkEZ+E9pS1rcPWrHBSYtMqt0mDyzDeeqxkB0yAENTcD5OgP5GjC9vMKyvqN7lyyf/dZtCYS4yiW4UcFXdUb5GAAL0xA9Kd3CnJW4YTT0pVMcAyaTYBcyirKz+qH6xWdAMcty7OU4SM3VkaN7+ibptjjf9dSkDppHP2Wr5BPvar1QvRrBkD9yjibOxNcP7W8UqP1u0PXCD6kpwD9lyQaJ5B7TmVTQho+Hz1AaanXYaT4+FBr5/TY7WQCSrhUdgXPVdM39TeYayQB6MAtcdz1HxGCpREaQbkZCt+edo+8voOcTkJ11UNw679NgjMaUM3taqhmbePAqWkLxsB3jnUAHUDysD5++OZ+Yo27ohJyigN0q3qDzWBzuOZsWUk0LbzCGHmRuLpMD0083f0RyF01lvTOpArhBIoZcIuSW0Ty2KgoGUgalOtzsczrvoPmQf2GqSHup/fIKF1jJCHVVNNNnbfIXvhAwSZK1j+K1mS604TR5ujN5A+lXjyTF14mJlfkbwpvCpN88jNBWEX20283XTeQvkZTeoRNFqCgjJE8fdRuPb3XINriBRNMrwQ/I+ZkKUwoC5arhc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ef26b6-7c70-4560-7b06-08db5b16b787
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB7243.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 22:48:53.1970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kws9rgmAW0JnVL8A3bRU1IlBt/YZMc5RRoB3mYyso0GYBi8KrIUt2nDwB5+XxAWf2lcLJqJLvUk/RO4Fowzw8Uwb7TRsGdVDBgpE42N0UTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4843
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-22_16,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220193
X-Proofpoint-GUID: v_ojypI6ycpehgXMS5AyKbeRlvUSGPr4
X-Proofpoint-ORIG-GUID: v_ojypI6ycpehgXMS5AyKbeRlvUSGPr4
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/23 10:54 AM, John Garry wrote:
> On 22/05/2023 14:31, Bart Van Assche wrote:
>> On 5/22/23 02:55, John Garry wrote:
>>> On 19/05/2023 18:39, Bart Van Assche wrote:
>>>>        *args->resid = scmd->resid_len;
>>>> -    if (args->sense)
>>>> -        memcpy(args->sense, scmd->sense_buffer, SCSI_SENSE_BUFFERSIZE);
>>>> +    if (args->sense) {
>>>> +        *args->sense = scmd->sense_buffer;
>>>> +        scmd->sense_buffer = NULL;
>>>
>>> I think that you will agree that this is not a good pattern to follow. We cannot have SCSI core allocating the sense buffer but a driver freeing it.
>>
>> Why not? Something similar can happen anywhere in the kernel anywhere reference counting is used.
> 
> Sure, but you are not using ref counting. If you could use ref counting then it would be better.
> 

What about killing the sense buffer arg and doing a callback?

For the retries patchset, one issue we had was scsi_execute_cmd callers for
the most part just wanted to check different sense/asc/ascq codes. However,
there are several places that want to do something more advanced and that's
specific to their use. For them, Martin W and I had talked about a callback.

For this sense case, the callback can look at the sense buffer scsi-ml creates
for all cmds in scsi_mq_init_request, and just copy the values it wants to copy
like in ata_task_ioctl. Something like

scsi_check_passthrough()

	...

	if (scsi_cmnd->failures->check_failure)
		scsi_cmnd->failures->check_failure(scmd, &sshdr)


ata_task_ioctl()
	struct scsi_failure *failures = {
		.check_failure = ata_task_check_failure,
		.check_args = args,
	....

bool ata_task_check_failure(struct scsi_cmnd *cmd)
{
	u8 *args = scsi_cmnd->failures->check_args;
	u8 *sense = cmd->sensebuf;

	.....

	if (scsi_sense_valid(&sshdr)) {/* sense data available */
                u8 *desc = sensebuf + 8;

                /* If we set cc then ATA pass-through will cause a
                 * check condition even if no error. Filter that. */
                if (cmd_result & SAM_STAT_CHECK_CONDITION) {
                        if (sshdr.sense_key == RECOVERED_ERROR &&
                            sshdr.asc == 0 && sshdr.ascq == 0x1d)
                                cmd_result &= ~SAM_STAT_CHECK_CONDITION;
                }

                /* Send userspace ATA registers */
                if (sensebuf[0] == 0x72 &&      /* format is "descriptor" */
                                desc[0] == 0x09) {/* code is "ATA Descriptor" */
                        args[0] = desc[13];     /* status */
                        args[1] = desc[3];      /* error */
                        args[2] = desc[5];      /* sector count (0:7) */
                        args[3] = desc[7];      /* lbal */
                        args[4] = desc[9];      /* lbam */
                        args[5] = desc[11];     /* lbah */
                        args[6] = desc[12];     /* select */

                }
        }

}

	



