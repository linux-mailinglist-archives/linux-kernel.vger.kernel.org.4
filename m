Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBA36F5F27
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 21:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjECTdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 15:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjECTdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 15:33:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B74CE
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 12:33:36 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 343HopHa017520;
        Wed, 3 May 2023 19:33:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=P0w7E16fm3qwH7j+akfaTOWIdMptK+gZMbc9nbGI1iw=;
 b=pGyN7iyKCOD5geBLR+tx8hTmrP55bY4mCfzO8HgMCZtyVk9D9g3oU80BHRP2ICV/ikfi
 L7sUqc0IoTsgObTgolyBLq8adgmFLkhe7z7zVMepSLb1fsav6vDIB/5J97w3XyUNfZEL
 AYdpm/b1lS1fCM1UWIipkEvAB5qa1TjYIqfD8mueKuhs1vsqikMCU9vdT6TDZR5hNaHH
 Afp2vMECoj1LJNAnAF934FkULsiJXeqLQW2RS0//EbvfuS+S/ESY77EebPH95hl/P/R8
 WeuXRJRZhKzKQXQQZvJgxr6lKb29truwdiTwCs/Iy0+rqaAYXLjPxStNgejzNguA4YaO fA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u4ar377-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 19:33:25 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 343J5oK0040652;
        Wed, 3 May 2023 19:33:23 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8sp7jxa3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 May 2023 19:33:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkdPQAMVU5ksrlBwSI9Arum0eJrkDG1pdeQRZtgk2i68jSf/g6j4dEbDpDSd1OKkBagoV5MXGd/rBf+M94ziEVC3A6wboIiXhADVfS6naq4wwiAqJqeQy7N3w5hS8xwwySGoLhjHVNgGr8YMcF1qMGkGKDCy5ETzqNFfWtXoTw16vD6arrvrumNJao+Sk4pWEZdCwVj5YJmvqZ9DZej1v/GYB9WrgJKjkueCOBB0WZkdQx9VhgZe1yGIV1kQ6cdU9xT4HQC0+jDb3Oix8PwfwbvjNxcKFQIava/hTW/hzHO8/eB/xiVRfFWXUIMCGC1uKr4QKMD9cc7OmqtYJsv0jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0w7E16fm3qwH7j+akfaTOWIdMptK+gZMbc9nbGI1iw=;
 b=VGQTtEpc1qp1M1BDBA3OlXpyKsTZ9hUTkxOsYuFbg4l+oDhMhpSPRBs43OHesLBgtX3x7wX4fp54oB1jN0/JnkHeGsdAslc5x0//aVok8PFp1EpV3duYiSEiub4oC3DQVvAY2TQLVCFRZdX7NyMgV9vvvOBhLHVeQq+EDaB5mJMr2VECOJzZysmDxRY5TkyQsR9WEdnlaWa5lrA01V9h3ADdPt1As1tE7yukNkBEmY3nQeEywEF3jGj7B5jddOXzsEgUQK14NsIGQwxOsHGnZJPtTrdBwoAV1usI5Lam7YxOC8bVUkkado9YSUH7M+PoDhqgQgAmF/NoyoNshBzeeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0w7E16fm3qwH7j+akfaTOWIdMptK+gZMbc9nbGI1iw=;
 b=lfgy5Wpd9SiZzstxt4hbZ08XtMaQjfqSv0T4L2D8nzDhFVNNklRVN/2DOxZV5naM76T/QSENBxWKr/YpNo5J5X6lnAWlZoKGk1+gokjvWXbL/K1gi6fllN6kf8PhsOdsJjyhmFoVRufaGShhD9Fw1HkBFS0QkykgWZh7V1dJHMk=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB4868.namprd10.prod.outlook.com (2603:10b6:208:333::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.20; Wed, 3 May
 2023 19:33:21 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::7fc1:adad:b2d5:a1aa]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::7fc1:adad:b2d5:a1aa%7]) with mapi id 15.20.6340.031; Wed, 3 May 2023
 19:33:21 +0000
Date:   Wed, 3 May 2023 15:33:18 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org
Subject: Re: [PATCH 11/34] maple_tree: Use MAS_BUG_ON() in mas_set_height()
Message-ID: <20230503193318.3m7qpry4n6fcpton@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
 <20230425140955.3834476-12-Liam.Howlett@oracle.com>
 <20230428121024.1070cd72@meshulam.tesarici.cz>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230428121024.1070cd72@meshulam.tesarici.cz>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0088.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::21) To BL0PR10MB3011.namprd10.prod.outlook.com
 (2603:10b6:208:7e::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR10MB3011:EE_|BLAPR10MB4868:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c209432-c8b3-4d6b-f4ec-08db4c0d40d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WSHRiFiydJCMqEG6AL6Xv8Plk5vAJH1l+xgvKy83uTW81wAw494iaP7gOXtMiB71IquC/yTVHuRptIUn0YfwMQBIxJjke9kfTGt0Xsud6cA2ZxoI5Dk3Jec2ZZiQ/JauHDwqtpLQgdD2nq2XUAyjRNHB/lnYYmcj6q7Or1lRjj37fNpksmL1DtWzeGyBPCq+NPrdmvVC7vPeParllYRvCYb9DeDlOshvtv7IlExEE4NqUP9oeVDItyh2Kj1J+zEiLQB5WMLYnQU26vIsLB8Pyn0bz1FHVC0Lydf/shiEMPTOfodbysEktDjT26rIUuov1hHeLJ6dS4+ebRv8FScN0IS+XRzxHqkKWOttjNbPK1asyWKbhDEg5RSFC6vdH7I5zwyHePXfyDUN0aStQ5fE3kX73G7QKhriLX1m9lhhKIB04dpFjsZF8832NtYPheq2SGUxl2MaDFVZV891dpmfE/xY2kxnd7yzxcf4hhKjElmJn9t3Xr7FyNbTwHIJ8Kt4GKpjPMFqT47bGfzdYkoYHmoir0RZqSPZZkMLMKnmAgR+yUQlQ1PBIGYGAiW7vYRU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(39860400002)(376002)(396003)(136003)(346002)(451199021)(5660300002)(86362001)(33716001)(6506007)(9686003)(186003)(1076003)(26005)(6512007)(38100700002)(8936002)(8676002)(41300700001)(478600001)(6486002)(316002)(6916009)(4326008)(6666004)(66946007)(2906002)(66556008)(66476007)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0duQ0wvVCs0aDB0aldqdWtoNUs2dlFHTVpZTlZWUmVwdVdQYnF4QXQ3bVRh?=
 =?utf-8?B?K0NTYUt6VzBWemFlZ2c3OUN4ZG9wWTVjcW40MVFkd1JLRHZ6bjRWT1JBMGVn?=
 =?utf-8?B?RDVQVVVOc0NFRE9MUHB0cFgxd0NHRE9GZGtCcFVBQXJROUY5R2VjM3ZxN2tY?=
 =?utf-8?B?NnB0bXJsMFJoN1ZzbWdUMnZEVjFiQzY4VWpuaXFUVW1YNWdJWm95U2FINVNR?=
 =?utf-8?B?VXR6RG52NkRDenp5NkdHTjBuN2FFNG9kaGpzc1UzbmFvdTRLdkNxTkh2SFVQ?=
 =?utf-8?B?MmUwdDFHTWwyM3dublNkUktZRlplY3lWOU1oU2NveFFkZjFpT21vanRCMUNv?=
 =?utf-8?B?Ti9OaTRRSEN3a09aRWYrblhPVHJmVTVwSnMzdXlxRXJsYTJRM3JVY3pMcEZa?=
 =?utf-8?B?NVZIREtCaTZGeVViRFFueTF2TVJYT1ZQZFJmaHZQS3hKc0g0Ulczdlk0c3ZT?=
 =?utf-8?B?SW8rS0tMNjVMVzBLZkVEVm5YckdoYVhoY2FKSTljV3d1b0FUV1REY0NwdVNX?=
 =?utf-8?B?MUVsNUpuTFlLVjhxQlRXV2d2YmUvZXJXSnFnblVSUjBUbUlWNnlrME0rRUlm?=
 =?utf-8?B?ME93QWtUMWRZcVlLdUtPZm52MktzWm5CTDE4Z2RKYktFaTBlS0huWmlZdVVJ?=
 =?utf-8?B?eURDTnFKMUF0L2NqaUZEQVhCSE9zUXBPTHRJYU9iTVJpTFkya21Qc0ZXdzg0?=
 =?utf-8?B?ZjYzeitFaXFGNEhtemkvUGVKVHllUDZDQ1FaOHpTMU1rSTVjVXNNbFdwc1N4?=
 =?utf-8?B?V3lad0dhR2FvQ3hHMU9PMlNRVjhWUDR6TzRmK0ZvZzUvd2lOaG5GbFJDTy96?=
 =?utf-8?B?SmNVdGhwa3V3V3Z1MXc1QmVraWE2NCt3dlJEK1Z3Qll1U2dMWW5jU2VRcGVn?=
 =?utf-8?B?UWg2UnZrWTFuTnM1NUJJTWlEOTN5V29JMEdVdFhUdzJBZVBTSUJsSGNLVkJz?=
 =?utf-8?B?UVNlTlNpdXF4S2tYM25jTHd5R0FsN3c4TWUxdjNnWSs5QTNqQlArRnBWeW03?=
 =?utf-8?B?R3MwbHBFSkdhRERNRE5lZE1ESFZ1QnhSTXJ1RE8yWDlQSkVkT2JWRmFQRURM?=
 =?utf-8?B?d204NDU4Z0lQMmFpaWgvWSt3RWlkWjJsM1BYZ05EcjdqVC9XNUVxaE5HR3g2?=
 =?utf-8?B?eHBxUnNoK0RnbDdkMnppQm9vVjBSNDZOUlhmMmYwZEdRSVhBTjNPSXBmSzE5?=
 =?utf-8?B?RTk0c2g1cmJFUzB0YXhuNGJxclIwRFh5RWhQNUkxbEdZVDd6Qjl2bXA4aXNo?=
 =?utf-8?B?NjM4MlpNdldlbVFBdGcrTFpVVE9tN2tOT2JSS1ZzaXdvK2toYUZPNkJ6SE02?=
 =?utf-8?B?SlUvQnFJckMvU3R5dWRNY3RlL3ZSMWRid0U4VXMxZDZ5cWxZb0NZWlF5dEM1?=
 =?utf-8?B?U1VKQ0NzdkVjQnJFamY5RmpvNFZlQVZDdkNQdzByTWp3aUFCK1F5ZVB5bUxr?=
 =?utf-8?B?NjYwZTNwRUQ3aUIyNVF5eEtQMCtydjdSbERxWktOczJTd29reXFjbXJFeXJM?=
 =?utf-8?B?TUVKOVRPSm0xbHdOQkRpQjdQWUxUS3RmYmFhL2lqNThLV0FHYzAwNC90VHkv?=
 =?utf-8?B?OUo5aDhtaXJZd0ppWUNYSzRINVRSVU9xbnVzNmFvVFg5NXpXYkNIMWFUL2Uy?=
 =?utf-8?B?M093Tk02Vk1Fd1VLUEtTLytiN1FETWJrOEFTcUQ4d0hNeWtpcGV1YWV2OENK?=
 =?utf-8?B?RlowZmFTeHcydW9yTEloeWhuOE0xN1F1K1cxMVpJVFlHb01OYU5BUXJSM09Z?=
 =?utf-8?B?Z1l4S0RJODIyTWsrc3I3MFRGakFab1hlVHk0OWhGdlEwdjIralhDc1J0SWRt?=
 =?utf-8?B?NjN2N2JJM2hnK1hEMUhUa2RTdTU5azRYR0didStqcFhrU2JQanBzWTNXUU1Z?=
 =?utf-8?B?bml4UTN0czRQTUQ1WkdqQm90cUhnS3BWZUhNeWl6ZitJWFNLWm1vMlkzNUh5?=
 =?utf-8?B?akx3YjJ6TkFMWTljb1ErOURrdkdyQ1gwdE5POCtEM0VUUDZ5ayswM3pJTGxz?=
 =?utf-8?B?dFBDUDAyWVZZNUF5WTN5RGxOOW5xS3Z1Uno3OVZzaEFIbGpubkpzQXIyUTRV?=
 =?utf-8?B?V0IzR1JsTjNIUU1LUkVRY0l6a3Rvdm9RUEVZMFBzbDdSRUtuVGYrWGFzNHNt?=
 =?utf-8?B?MEVsRUw3ZFl1b2FnQ3RKbFA2WmJ5dHNKOC9ramloMjd4UWppeVg0N2lwQkIr?=
 =?utf-8?B?UkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: LjWzGc21vrI6TCZiC0UrrSP+NQ3oNQ1NPXQl4Fl8MEo9UVfPkzktVJqrW0cadpWd9mGM86gTQehtWtQJD/KZ1wXmP2ET/kPoh2wQsa47JZJt1P4ujGEoT0xag7PUWnHkdcE17Tzvxz1u0r31qZPNOv6VxYUMV9HLiianTXKhZpb6W64PU0UQTLUrnCl0ALkaWgLANcMft9Hx1HoGNlIZMLiA2Wx4e6Q7Dz1kAydUTKBpm+/CxWow4VoSYD0q9d0XoWhHq3A9BAKfBtLWCxdVQsyB0p56V2TPMDtZx7Q339/h6ob7gr9JwUGv9cSbWvW7xp9mK5yM7ZkW43IK9hogNw6hqkzskSiSGMSMr6OZhNeKEEobNrnjiHtcj+5Lz4jbIf5fW9oUXrx6TXIuxmYkDjfc6rGxNwF6jFT0YSsGRY16lq0bazZ3iZwvp4gf1ngLWWBWTVnm71Yu2CaxfCOyiG0a4hYe2r/8C1kFeK+m8Q68hvEyx+E0hyT4+yFFkWIVcyhKd0zBqYEPyauvN35XjZBLxjsE80K0jApZRlwHQEgornj/lkjzAs4aA/O07HRYR0VeJz+JGseYYU4YULQB9HrfKax6VqLAIhaITLx5FNsJvVs66ObNqkXdRR/+y50X/gI41UQRvMhAriEgImyl1WfHHr9CJEQoNnhwNpLJ68fS7v2uxD95FQF3DDBpZBpFd1xQr77S5NA+OXj6/OS/57y65S1uUHgSmH/C3NYXDXcBJ2H13IltJcgwiNJ+HOIIZ3nGDJel/Of/7qBGJyiG0EMT7RxS7aU+prPMgGM9n2BNW8oYSjQTfVg+q0cu9Li6Jnx997MMxaAhFxRbuKuNflFwAMuaR1QEMqWkAO0z02n4HtA+VoAZcM2vas/ilTyuFXK3ZtQzmZK6MTsEHgaZ3A0iJgeLPoluhEi7hxoD0HY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c209432-c8b3-4d6b-f4ec-08db4c0d40d9
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2023 19:33:21.0810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xIGwvpPtdrk5j5+NuOrAhTUtEsUNsnwAzUozDkyV5Azg4V+J7dHprFBD3aLdPjiS2+uE+B2ZD51imNDwVf027A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4868
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-03_14,2023-05-03_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=613
 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305030168
X-Proofpoint-GUID: 5yQNmZm0Mm4Zl54u1mAnHBwRjXeNLI72
X-Proofpoint-ORIG-GUID: 5yQNmZm0Mm4Zl54u1mAnHBwRjXeNLI72
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> [230428 06:10]:
> On Tue, 25 Apr 2023 10:09:32 -0400
> "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:
>=20
> > Use MAS_BUG_ON() instead of MT_BUG_ON() to get the maple state
> > information.  In the unlikely even of a tree height of > 31, try to inc=
rease
>                                 ^^^^
> Again, *event*. Consider buying a new keyboard if your 'T' is broken. ;-)

hanks.  I will fix This in v2. :)

>=20
> Petr T
