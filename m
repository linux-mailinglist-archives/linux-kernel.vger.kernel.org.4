Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCA86EFC2F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 23:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbjDZVH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 17:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbjDZVHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 17:07:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2899B0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 14:07:42 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33QGxDIW025309;
        Wed, 26 Apr 2023 21:07:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=FlqVLVysV6Sk3zyRmGDB1SHg9m+QJBFnqkK6JtH+9YM=;
 b=XfB1HDi2v2xw1PBeEg3mgU8v5QkCpxNjyAAPm+dOxM64BLabpNKVWODDKrdV2OkxX3PS
 NmqxWzJyPUMjp5gshQkH5rjWi2o59KGywjSvpnAl6KtB2UNIczMSMxhoiI0WMISSq/cU
 XZcSxF/78zuNOn3p9f6bmI1Tw1wKX94HTeLixWvVmmFkt85EzBxSWRrxguRt5Yku3vGO
 rtbjgIHfWjxC1kr85pxOxDBKoC+1vcSm8WM0o2SJXChJZbEl9vTIJXZUb2pMwlTIL67d
 uG4Lx/gPyFdfvK7hdaWNOxnCS5+rm2oV7x0byB/SM5cmhDcyOf/SxixGwHS60LOXkm6y VA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q46622mb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Apr 2023 21:07:14 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33QL6lIt025163;
        Wed, 26 Apr 2023 21:07:12 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q461erm1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Apr 2023 21:07:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n+Dpy9HcgIk8QraRNN3QsPSQJwfEpTNAgoJgtmEngU6+PRPFXr7ZxV2Nayw1Ep+2NTFwB46Twj2I4wQAOaIlwdfaCCHsZZCyhuX6L5XHOPkTW1LbX5areBWn3O4uyX4/tBCWyFUJkLbtoSvH8JaxJXyuWvyhlsaSRnmTPMGQMn4TMsLSQih8szTV2spMxYjRDIMqg7N8ATT9X8S59uUXyxm8lPd9e+KB/VqDoC+X9RPrmsss25d/9Wle+HTTmDleKK0LXz0b3VBfm7wAmvuilah+PM7zx7ty8RtQqK5pLOsHzM71cTZtg4aQ09txyPm7u2MqvAfuxaMmTQwbgi34xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlqVLVysV6Sk3zyRmGDB1SHg9m+QJBFnqkK6JtH+9YM=;
 b=Xum6D3HZILxOLEFALDWFQ3JMHegOA1KLVZq4YEUIolVmXEmDfnPBqxCBbAtv764CPxJBb2v/ZtKveDPOmU/ycnKh5/s63y9uJwe33xYGGMDHxiqn6zapXPT4XjvkjvKWIsLkj30WDWLktVDvrddidn4aiBnj+nPWgDCUdswirsJOEao1pKSb6nMix9HZq16MJo/7YpL/w00DBVdgPzUpAaEHwGDu4+7fNV7/qgZAoUQg51UQX4yueRFK4CZJ37iQrtcSB3ZuEpCNyvhF/o2YtA3awGwH6GYJzYtHrO9EYfmFRBnyHNdjpLTFMNknuNot0xkWoVCwvrehSLksjbqpwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlqVLVysV6Sk3zyRmGDB1SHg9m+QJBFnqkK6JtH+9YM=;
 b=Z4CwVjbv9jQeDoN4ifaTUyie5JbRA58aFMtURC/c/nxGrF2kDbfCjpx87Eqk0kW+/9JG0v0V/tgnF7UEd4dRoSzSgm7/mNm+5qSCDcN8/K3HoYGcK56UsM99FQOXQ1Cd2aVzHNHnFkBdYO6ejxnJRaGSx/MRxGe6NfV4N5oZryk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4510.namprd10.prod.outlook.com (2603:10b6:a03:2d6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 26 Apr
 2023 21:07:10 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6319.034; Wed, 26 Apr 2023
 21:07:10 +0000
Date:   Wed, 26 Apr 2023 17:07:08 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        Wei Yang <richard.weiyang@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 02/34] maple_tree: Clean up mas_parent_enum()
Message-ID: <20230426210708.r2gpnzocxfulz5y5@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        Wei Yang <richard.weiyang@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230425140955.3834476-1-Liam.Howlett@oracle.com>
 <20230425140955.3834476-3-Liam.Howlett@oracle.com>
 <75ebddd7-641f-0274-72c5-415007d60cdd@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <75ebddd7-641f-0274-72c5-415007d60cdd@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0242.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10f::21) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|SJ0PR10MB4510:EE_
X-MS-Office365-Filtering-Correlation-Id: 24bf1680-7fa7-4561-c69d-08db469a338e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4jr3ZaaOdUEHuARZy2xQMgzApJliYC47HP7H1l5LmGck3diEQSltjok/N2mBafQvGaYc6zpDX9cC5FUbtslptnXlGU/jigj+EMdaRmcWW4w35CvQG495hoOmwHXTJg7bGSLhH7JzzhpmLLEDG4v8eekQ70GtH6uDi9k3RigQI3fAOXJRbg3UBrsQ4RV2yCZfnrHvl5AoKp1F4T5o4UDX1sqVU7EdklZiJvlrH7J92b5lu0okSof/RUYHDt9NWmx0vIbVvRFX4DFJ027SWSPQaFSPnfa3bAi8kR+KwCebri0ZTiqINDnu0Cy+jWj4hPaM4jP5Fo/DTl9GcRiNBNKkZnNZZm6YSeb2hPjKBwRIKbkSeJs2fwJVM4LxLEDfJUll1Ez1t+iMrPcbONWENJNCulbRzqJVdcJc00bOvziFaJSXnq2CjDIS7oICkYZ16vhR/AnOVRsWQxXVvMyv/qTxwJqsEqlYy1S9OdybPRWqk76xxiBdCWDhTDjiqGLdqL3zkcTmTAkXieTewJXVwJFPq7Jhdn9BRJfM6sWraWUBgwM205+TOosa3lQtFfmOgN6u
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(39860400002)(376002)(136003)(346002)(366004)(451199021)(66476007)(478600001)(8936002)(8676002)(316002)(4326008)(6916009)(66946007)(66556008)(41300700001)(54906003)(38100700002)(186003)(2906002)(1076003)(6512007)(26005)(33716001)(6506007)(83380400001)(9686003)(86362001)(5660300002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVNyalhTd3pqL01ObGJTaHNmcE1QZnBFNlZuSHBRRC9uN2dyekpmM3NHYjk2?=
 =?utf-8?B?ek0yS3RGMVZKcEpja0NJS1NOOXlsRjQyMVZCNjQyMlVQQk5jU0tqaXNkUTVX?=
 =?utf-8?B?Q3ExKzhKSFlORmVWbUhzU3daOC9FK1BSWm1hZmhMSVpwek1HUHRiT2p0YTlt?=
 =?utf-8?B?NndRUE5sUTE2NitjNkFwKzJwT1hKQmNyOGZrUnJVNHNEMjlpdmVFckhCQnd0?=
 =?utf-8?B?Z1RxQ1dHN1ZzaXFQcTFzOWVsNENZcVFiRWJ1UGRaaERGT2g2cXB6dmNObldJ?=
 =?utf-8?B?eDVjSWIwTGdvTnVyK3JZTUNOWlN6KzBsaEU2aWIxMlFxbkhzMi9rZnZWLzR6?=
 =?utf-8?B?TGduRmJOM2tmK3ZKSkIwQjQ1aDE5TjRxb2EyY0I1a25MZUtzZlYrZENDTU4r?=
 =?utf-8?B?bkltVFlRd204Qkw3MlFQQkZkSHI1QlVwZ0NaRGxuTmg2ZitYVU5LZGZaS2gy?=
 =?utf-8?B?RWRCc2RXdUFSaURRM2dXVWVrLzRyZzFJWmh0bnlidCsweVlPMlFId0gzTmJp?=
 =?utf-8?B?SWEvcHp4SHBQUVVrZWpKNVFkcTZpOEkvVFp0SmltaU5zUlJmQUNUVUZudmxv?=
 =?utf-8?B?V0plMHZML0hKaGkrY0xtZHhLNndZNE51NnQvcW1OamRmd1QycnRuWmQrZ2NP?=
 =?utf-8?B?TW91dS9vSVBEN0tZb1A3cU5Cc0YzbGlzRUVqM2lDdDUrVmlyMzRsbmZtRS9V?=
 =?utf-8?B?TitMdEZYSzd1RzR1ZHJnYWpNS2lYOVVlbkxFTUNCaUg2eGRSWVRwQWlxV240?=
 =?utf-8?B?MGJEMzR6RTBhS0VmZTJMQnNabGt5TE1qRHNTbWNlSWVuUmx6ditCK21ZMG91?=
 =?utf-8?B?c2VDajB3UUZWbkhQdGRIMFExNWFreDhGQzRRdGJOcmwvdmovY3A0dVZGTThr?=
 =?utf-8?B?cHpaczV0MjBhNUh6Y3BRUEtQNE05MWlmRjA3NDMyWVUzRGNpMi9rcVRlM3h6?=
 =?utf-8?B?VkVtSVhrN29MUVpKaGQzTHV0U3BvUU9PeTVVRDExWkVFeC8zZnlTSWZRS3lr?=
 =?utf-8?B?Qm55eEZWY1ZGaVdndTRldzF5clZ1TDljZlpTOU9tT2lPVXVKc1RES05kRHM3?=
 =?utf-8?B?cHVJOHRMSzRsS0VDVHRFU2ZtcVNrbGZRWng2cHJKZXdtTTRZN1cydTlzQ2or?=
 =?utf-8?B?QXJnUC9xbnNKQlp5YTF4QjFVdTJYUUU5MkpHZlcvNFFHU0RicGdnZmIwU2VU?=
 =?utf-8?B?dnRGaE9DTDU3eXFhY1JIZkRLVkNNZnZMczVhWmNVeFh5bWM1RFlLS01jRy9N?=
 =?utf-8?B?STdLUXNYb2I2K1JRbjJ1UnFMWWJXSzYvbVVQTXZNblJTV1ZwTjZjTUZmeWQz?=
 =?utf-8?B?TmNVejNDTk9KV3E0L2VMbHJzZVJMNTFJNmNZYUh4UmZyYm0vQ0ZZNjFGUEVQ?=
 =?utf-8?B?aTEvMGhxZldGLzlQTVlCUjVBWkVVSkZiV0dwYkZTSVkrOG9BekJKcExzbGR5?=
 =?utf-8?B?S25CSmZnWEV5Q2FTWUtSVjZOTS9nUUg1ZE5CT1RxRDBPOGJZN3ZxYzNnVm9Q?=
 =?utf-8?B?aXA5M0FtZjJCWUdvL2E0S2QvSHhJNDdRczhvMjJYUE56U3VrNVl4NWN2YXo1?=
 =?utf-8?B?UkgyQVFaZHc4UTFaQVNxUlRtOE9nMm05bVZ0YUhUU2ZwbU9nQXRPTmF6T0Zu?=
 =?utf-8?B?dFlvMThzbSt4N09JYWVkbDBXVEVXa0YzV1BCNEVxeTVMM0orVm42S21KZlRz?=
 =?utf-8?B?Zk9pWGROUlJUelJqZE5DbmpSM3RNSFBPZ1BwUFFKS0NnRnVJSFF0NHVRUXRL?=
 =?utf-8?B?TWRZbG1WUFh0M3Y0T2t4OGpobVFteG1VTGNWdzNhZk82S0MvY1Y2UzRBQlc2?=
 =?utf-8?B?SHkxKzJGNkIvcS9PQlZKUko3bUsreGFJekFUa1NYQVdWRCt6elJvb3NCaEhm?=
 =?utf-8?B?WUdxWHVZcUtDUUtBdFRIUzRCcHpUSjZXYlZVOHlSSlRoQUNUa1Q1dVZTWHds?=
 =?utf-8?B?NXpEelhYY3ArMWhBVzJ2M0pEMnVXSnFwaklNMTNqVGdOZFhIZ01LRHF6d0VM?=
 =?utf-8?B?QWNSbVlpTHFMM0RjSDhHUkJzNG40bjVlVXduRCttbkp3VUpCNHZEV2dRcU1y?=
 =?utf-8?B?VmpBcEpRNkNRK1d2alJJdTFGb243WTdNbm9jcTRTZVFDNzdWa1NSMThDVlE2?=
 =?utf-8?B?RXVtOVFwRTRiWlE0UUs3TTlOZXNBRndyMHFZclpxVDhnTjVCcllBd0cyVTJU?=
 =?utf-8?B?aEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TG5nK25Mcmd4TERzdStDeFhDVkNtUzM5RVNWMTNib0FZRW5WL1NKNXhIQ2k5?=
 =?utf-8?B?UkZPeVVlMkpCQ0hmVmxtMEdxZmlBb2ZldW9nR01va1RuSWkzdVZMeEplSEhx?=
 =?utf-8?B?Y3pWa09kM0xBUGZyOVRzTlRFamFuZGRrWWpkQ0FOemFKVGxhN1BvUjhTK2cy?=
 =?utf-8?B?MjhaWXBsNjZzTU9kTkNwcDhpY0NZSDRGMGNRcmYwWVZmdmMzSkdFcld5dUJt?=
 =?utf-8?B?MzRvdVlzRExaVVl0dzllZGVadEIyYVd2WFBkakdYZ0RZTThkdGZkdjhaT3BS?=
 =?utf-8?B?dXdVZ1ZYVlBpZTJyM3RSbHJjVjdmeUd3VkZOQUFpQ0pXbCtGbG9VVFg3Ylp0?=
 =?utf-8?B?QjBNcllJS0RDOXZMaFc4UURobGE2UWhvTmIydkkzVUxkRmovY2ErejNUTUVv?=
 =?utf-8?B?ODVjVU81YVZYN0loclM5ZmtCZHZkcjJ6TFVPMC9rdVRDTHYvcU5lOGpRSWVL?=
 =?utf-8?B?MnR0VFhHLy9OMUFvaXJiSUZkWThmOVdMb3V4U3c0ZE9CYWRjam9CYmdickNX?=
 =?utf-8?B?MDRuTTV5aVZqb3h6R3YwUW1rdVJZNXlXRzd4M0x0RGtBYXpsVVBNVDgyRVRW?=
 =?utf-8?B?M2IxaGxqelZ4ZG8wRStrNkk1ZytlR0F0ektBVUo1WmsvNUI1SFUzUDBHUktR?=
 =?utf-8?B?RVltRFkxUXEvUEpGMDRjN2dpVFo0bU5EdzNOY3YvYXRWSEQ0QTF1anVMdkF2?=
 =?utf-8?B?TlVNWTREVWN6dGlUTlU1S2pJQzVERU9mcGovclJING5mbXJHTFA1eExJOWxB?=
 =?utf-8?B?cVphSHNlVDc4RGViUVUwMFVVT093Wmt1VzMrakpINEZ2N0kxdUhHN2l5bTlk?=
 =?utf-8?B?ek1sRy9lNThQNjVjemlpTTYvWUNHRmtDSlBqK3RHRUN2QVpMTG1zanhMQ2VQ?=
 =?utf-8?B?TkIyaG92YnpFRkdFVG1IeU5QbXBEV3hMeVJVci9FTlhvdUQ3WFdDSTMzbXN0?=
 =?utf-8?B?Vm9nZGVkYU9wVk1KYll3d0ZIRjQ5YmlFMHVMQVFBRDBCMnMzYjdxVzlTTTZa?=
 =?utf-8?B?ejFMWWt4aHBYb3ZGYk5VM3BmSEJ4ZXZ1bUtjNjZ3MEs1MWF6YzZsMHpPc2dP?=
 =?utf-8?B?SEJYVGxYczZlNVdDQzFtTUkyQzU2TE9NbDg4b3FtWnJKYXkxRzlKOHlsRlFL?=
 =?utf-8?B?OU0xVzhuV2hNSlllVmdMMXJQUi9vM0Y3dWYvV2dxN1JjcWNGZmJ5QkY3alZF?=
 =?utf-8?B?VGEvMFB6QVdYaFhhaUhMSWdkUUl5R0swZ2VnN0p6Q0lKbDE0RlFTQkZ2WWY1?=
 =?utf-8?B?SkFFY0QwdmNlYlNLWVp1VEZHNkw4Zm85bTB3T0VxU29IeTFkUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24bf1680-7fa7-4561-c69d-08db469a338e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 21:07:10.8114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dxWgWB+LZdf0fuI9rIaSeq0JawXHRMqEPllGX5hgReAnHDhcbCj+bLWGHWTG/0shvDhDwG/6KKFPPKoWESVCdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4510
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_10,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304260183
X-Proofpoint-ORIG-GUID: EYVCYRlzNs5LI-Ro4m6WeTVRMXAkeJ36
X-Proofpoint-GUID: EYVCYRlzNs5LI-Ro4m6WeTVRMXAkeJ36
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230426 00:15]:
>=20
> =E5=9C=A8 2023/4/25 22:09, Liam R. Howlett =E5=86=99=E9=81=93:
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >=20
> > mas_parent_enum() is a simple wrapper for mte_parent_enum() which is
> > only called from that wrapper.  Remove the wrapper and inline
> > mte_parent_enum() into mas_parent_enum().
> >=20
> > At the same time, clean up the bit masking of the root pointer since it
> > cannot be set by the time the bit masking occurs.  Change the check on
> > the root bit to a WARN_ON(), and fix the verification code to not
> > trigger the WARN_ON() before checking if the node is root.
> >=20
> > Reported-by: Wei Yang <richard.weiyang@gmail.com>
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > ---
> >   lib/maple_tree.c | 28 +++++++++++-----------------
> >   1 file changed, 11 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > index 9cf4fca42310c..ac0245dd88dad 100644
> > --- a/lib/maple_tree.c
> > +++ b/lib/maple_tree.c
> > @@ -428,25 +428,23 @@ static inline unsigned long mte_parent_slot_mask(=
unsigned long parent)
> >    * mas_parent_enum() - Return the maple_type of the parent from the s=
tored
> >    * parent type.
> >    * @mas: The maple state
> > - * @node: The maple_enode to extract the parent's enum
> > + * @enode: The maple_enode to extract the parent's enum
> >    * Return: The node->parent maple_type
> >    */
> >   static inline
> > -enum maple_type mte_parent_enum(struct maple_enode *p_enode,
> > -				struct maple_tree *mt)
> > +enum maple_type mas_parent_enum(struct ma_state *mas, struct maple_eno=
de *enode)
>=20
> Do you think it's better to rename this function to mas_parent_type()?
> The meaning of enum is not obvious and there is already a similar
> function mte_node_type().

Yes, thanks. I'll make that change in v2.

>=20
> >   {
> >   	unsigned long p_type;
> > -	p_type =3D (unsigned long)p_enode;
> > -	if (p_type & MAPLE_PARENT_ROOT)
> > -		return 0; /* Validated in the caller. */
> > +	p_type =3D (unsigned long)mte_to_node(enode)->parent;
> > +	if (WARN_ON(p_type & MAPLE_PARENT_ROOT))
> > +		return 0;
> >   	p_type &=3D MAPLE_NODE_MASK;
> > -	p_type =3D p_type & ~(MAPLE_PARENT_ROOT | mte_parent_slot_mask(p_type=
));
> > -
> > +	p_type &=3D ~mte_parent_slot_mask(p_type);
> >   	switch (p_type) {
> >   	case MAPLE_PARENT_RANGE64: /* or MAPLE_PARENT_ARANGE64 */
> > -		if (mt_is_alloc(mt))
> > +		if (mt_is_alloc(mas->tree))
> >   			return maple_arange_64;
> >   		return maple_range_64;
> >   	}
> > @@ -454,12 +452,6 @@ enum maple_type mte_parent_enum(struct maple_enode=
 *p_enode,
> >   	return 0;
> >   }
> > -static inline
> > -enum maple_type mas_parent_enum(struct ma_state *mas, struct maple_eno=
de *enode)
> > -{
> > -	return mte_parent_enum(ma_enode_ptr(mte_to_node(enode)->parent), mas-=
>tree);
> > -}
> > -
> >   /*
> >    * mte_set_parent() - Set the parent node and encode the slot
> >    * @enode: The encoded maple node.
> > @@ -7008,14 +7000,16 @@ static void mas_validate_parent_slot(struct ma_=
state *mas)
> >   {
> >   	struct maple_node *parent;
> >   	struct maple_enode *node;
> > -	enum maple_type p_type =3D mas_parent_enum(mas, mas->node);
> > -	unsigned char p_slot =3D mte_parent_slot(mas->node);
> > +	enum maple_type p_type;
> > +	unsigned char p_slot;
> >   	void __rcu **slots;
> >   	int i;
> >   	if (mte_is_root(mas->node))
> >   		return;
> > +	p_slot =3D mte_parent_slot(mas->node);
> > +	p_type =3D mas_parent_enum(mas, mas->node);
> >   	parent =3D mte_parent(mas->node);
> >   	slots =3D ma_slots(parent, p_type);
> >   	MT_BUG_ON(mas->tree, mas_mn(mas) =3D=3D parent);
