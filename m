Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B003C733CD7
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 01:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240513AbjFPXWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 19:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjFPXWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 19:22:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE81B5;
        Fri, 16 Jun 2023 16:22:01 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35GLadpn026829;
        Fri, 16 Jun 2023 22:16:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=rN4nV6zwxCpscAHaKPNTdvvNtdNyDY38pcZ54Oce+QQ=;
 b=ct+e/BUyvg/+00GUC5bCmkV/HmX0i8fYeEoxQPOtleZsUPvAM0wVHysvStp3QVXu9x7D
 Zt2ZRGKXQXOmnTrJsGp3WmuyKlC4HsAcmLlDHVx8hViOtsT8983YfZg0KJ9AD1CS+Nnm
 jOSjb9IqCvf109t90whSRQlPgu252BrBH6U0qp9iI8oER3VCezUVCltOZrLsQoNlW10V
 1AJ/i8SmQ8VFxxCDiJYDAMxGZ3gsEtqV6aNPs4vs4ea2MA2dizZHrOH+ipxCYd1OydxU
 aCqZIIeytPXkOwIHgbV8Vxusl/zmYHKSGZ17XPw2WpiSxn06Y0x/c11auk7+Bcc6UXIy AA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4h2aw2gu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Jun 2023 22:16:16 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35GKgtn2040466;
        Fri, 16 Jun 2023 22:16:15 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2048.outbound.protection.outlook.com [104.47.51.48])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm8esjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Jun 2023 22:16:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBzkpv5tpTpbn9JJtCW1EBt1AhaU0zABqAwwnSSDybif7gsj5+1aPWQWVgcFzBAzWFaWMQwkfKXWlee/Wp8oum+sWzqhzEbUYGrnny+5BzXqO3bFB0rFaJ+8mxWm0OECl1cflE+CFQEzTC1rHrwqufjGXqSZf5xNBmv29EqSlsU11RWkPMKpDjlmVyhqbhYRp0W3sMOLQ9IsCVpUOIYXum9KL++agICW4ZK9fA3O79LwpRjCpccvQsuxljpc9qjTbwuCh7cv1PK2jRYt0s/OZPR1Zp/NuAe84MxYK9sG6AjrkK9S7GUwdXKwNS4YIIsRNWVHOKWEPDbdXL5G8+YNOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rN4nV6zwxCpscAHaKPNTdvvNtdNyDY38pcZ54Oce+QQ=;
 b=mL9yK1p9R3W8H3AqO4Wc1NkmxY3d56YgsFUdIdRd7b+CBWAEvjsmjbsXlkcjtP34FsbnmX5+7KQicd8mCmuM+b5muSTk/Ez2qBhYpACCSgK37cxd0EM5PKyF8DGBfKGduYjE0HVHT6nWfR63yu1FkqjHEBktyW13ozCiCi6aYPL+XOLu3MtdqmhPYAW4u3IQV/s35Vt4vpqJ8TLToSvkv+91kV1hI95iNl/qKts5HiCuU/kqX50Wd2mcafqXVi5+uTQigJjYOmrLk3qWuzD5U7I9dfcPQDftInQv9/uGO4iCzSQMVhm508oBY7yZpQAi6S+jlmYiHxZBqVPNYQpDag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rN4nV6zwxCpscAHaKPNTdvvNtdNyDY38pcZ54Oce+QQ=;
 b=vcE8AERxsA2OQdN5MW3VIl+UNhQOJm7mNBGtJpoRp3IW2DbNBRdJHjhi+Fet7Tb/lf2XffqI95B77u28lt8eqR6bg3+d5SLB/ukGq6pMrsBgvhYDwNJ4mJEtiXeNRD9sq7Nlg1CE/P7njMJAoh6PDN0m1tjC052OlNPiUBz546A=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by CYYPR10MB7652.namprd10.prod.outlook.com (2603:10b6:930:bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.27; Fri, 16 Jun
 2023 22:16:13 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::cd78:868d:bb:1c47]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::cd78:868d:bb:1c47%4]) with mapi id 15.20.6455.039; Fri, 16 Jun 2023
 22:16:13 +0000
Message-ID: <6284256f-dacc-e287-fe07-377491f87ca3@oracle.com>
Date:   Fri, 16 Jun 2023 17:16:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] jfs: jfs_dmap: Validate db_l2nbperpage while mounting
Content-Language: en-US
To:     Siddh Raman Pant <code@siddh.me>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Hoi Pok Wu <wuhoipok@gmail.com>
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Anup Sharma <anupnewsmail@gmail.com>,
        syzbot+d2cd27dcf8e04b232eb2@syzkaller.appspotmail.com,
        stable@vger.kernel.org
References: <20230605140151.635604-1-code@siddh.me>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <20230605140151.635604-1-code@siddh.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR07CA0029.namprd07.prod.outlook.com
 (2603:10b6:610:32::34) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|CYYPR10MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: 9653caac-14d8-4a6a-afc5-08db6eb74b53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ydaa9U2b/jnA2JxO72F+9mh7HqLCCAvSe2pwe5kU149NrKAiY4s1aEWzjnnR1TDIVsZRbgeTkCeyPoJDpoTe3ClN1jJDsabYV6M7cIvZ0qRRD5QOfIYH84SVwm+q5vWSV9p56OUWy8Dnbx0y1x4He5FbCTaUeF1ERtQ3suaZr6yCy/hXlTAKksXA8VsrqiI/mnb6R/uX7cFyFUr+zBXxdlHbMY1JTSTcnBVCA7P01VzzFyZ8iUCpo7TDbFbsCkFS/Aq7rUNFrcTQEHeBdERj/UY7ZVFyIiTsDTZxP8MZXEgFyMTyfI0CCZgZ2kId5+MysIiZCPnQZFJh2UW2NRzPW8Xy79sN3rp/WdfaZE95lzSHGI/kGhaiO98JwJ0xkvg2aOufPyV6FYE1JnhKO5qpmCbYs+nzYIANHYeTn/20eWvYdF/5Mu14EWqPWkuZ352Fua0g4bpJOi9OZEYdo36UYZrRsTATVKmASJbvDF4MLr3oZl+Q344iNQDO58BsjGP6lx0Zlf2jnYtGeeFQAlOgyKKdW5wvWks9ei0h5QoEO4xNWdLQqW3GV4Ia4h4JatsyxFwulh9uk5Q2vP66McQewrP8Y9m3KgG5DFQEiDhLsqq2aDWs2uTHnzQg0tP6hVZQ+jCCtOE7VeunVYsHrd1XOmhm3MnMtyP9uIrVqSwLXK4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(396003)(136003)(376002)(366004)(451199021)(5660300002)(478600001)(31686004)(8936002)(41300700001)(316002)(8676002)(6486002)(966005)(6506007)(110136005)(44832011)(186003)(4326008)(66476007)(6666004)(66556008)(66946007)(26005)(6512007)(2616005)(83380400001)(2906002)(38100700002)(31696002)(86362001)(36756003)(99710200001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHh3ZXkzSVVBVFdUV0FSdC95allVSXFib3JmV1Y3TVRySUVXSi9vVFA2TVB3?=
 =?utf-8?B?L3JkcTBzVDlvOHVJOHhYV3NhUnRDUENqSDNibC9OZFZOeEpOa1JMT2xLcldX?=
 =?utf-8?B?eGRKTnlVVVptSjFXSjhBRzRiNzE5NVIrR2Z0OHZ3MkxocUVCV1NJemJQOHdS?=
 =?utf-8?B?bHFnY3RmcEwvR2J5dDh5VE1OSmJhN29NQlJFTHRYdWVpYTU0NW5Jd1JDTG9I?=
 =?utf-8?B?b1UybVZjTVRRSncxcXh6bUp3RkZHaW1kdVRtRHA1TFBRbHZNV2tXK1NJbHBB?=
 =?utf-8?B?YXdVMU80N2xkaGVrMW9zdjkrUjBWNEk5NGN0VjNleVVnNHczR29YdFViNXhM?=
 =?utf-8?B?WVlzTmpTZmsvY21DV1M1K1BGUkpaY0trR2M2TjlqWGxXeWlveDk4UVpjNC9t?=
 =?utf-8?B?UzhXR3E1NWRjRGprakd1VnZ2cm05ek8ybDgxVTVSNGU5WUZaOGlURkFRcjdn?=
 =?utf-8?B?eHRHZnMvVlFEeDJUZER6cWtROFR6WTRIVW11UDM3WnZ1Z3ZHQnRoSWRERWZr?=
 =?utf-8?B?Z3JpWUEyL3hzZmU2Q2YvQ2w1Z1h5dU44WWlDcEplSUF1d0xjZDdVNU9aUVdU?=
 =?utf-8?B?WW1qaDB6QXY2V3g5S3N3L2RadHJFaGtQVzFSek9UWFFoZ1YwSGpoQWdkVVBP?=
 =?utf-8?B?VHcrRVdzNGJ5K0Zib2c5VE9MdERQUkdHNFhtTERlM0xkbHg0bHE5RVVUa3R3?=
 =?utf-8?B?M1R6MkdvOG5hNFFLbzNlS2hzS29seXN0QloxN25tT05UUktyWngrUk8xYk1P?=
 =?utf-8?B?Y3hvUXBnNHRFTkNQNjZ5bWVPbzN3Wm5qaVdlTEcrYjhpUWlWa09hVDVxclVN?=
 =?utf-8?B?MDl0VStjRnBHczhTaTIrMTJtOFpUVjZzYzd4VWxnZWtlN2N6YkZiUFIyTmgr?=
 =?utf-8?B?YWZFTnJwMzRrcnlZanpnNjhKM1dUejBJWjZiTGZUTFozU2R4L1F3QStaT3dG?=
 =?utf-8?B?ZWlzc3MrR3dWN0lnYUVGTmU3NjZLaXhwT0VSS1lkbys3dzkxc1dEM0NDeDFi?=
 =?utf-8?B?U2JLTXk5aURpUEU3OG1CSzJxQzV1TFlacWNtMHRpTDNtZ3hSdSs4S09UMlVV?=
 =?utf-8?B?VXZvMW95WCtvQWplaGVoNFdCWkROYWZQYnRKWlVPd01WZHU0bzJDaDd2Wk1k?=
 =?utf-8?B?c05JSVJQM0g3TnpzR1lTMXQ3UTlmWWs1SXFzVE1qODZrNkRmR1Y1b0Q2MFl4?=
 =?utf-8?B?TzBvbjZKM3hob2NnanZ3elJVZHowSEpLcGZoWWU0U1ZPeS9EYVpLSUNmNEVq?=
 =?utf-8?B?MGJCZDhBL3BTN0FzSkJybnM2L2pPSi9BbEk5Zlo0eWpwcUtqeGlLdmZqLzRR?=
 =?utf-8?B?VEMzVW0zTzJHcldLUVFuWGpHNVZ0Uk53MFpwd0p5ZUFFOHJuOW4vMUpiYWFa?=
 =?utf-8?B?a29mSHZlK1VGSDBlenNlU2ZhYU4rOGNIY1hnRVJIUU50Q3pjRi9jTWVFa2xt?=
 =?utf-8?B?dUdseVEzeHB4ZjFsRHZmTmNDbWVsTTEzZTBKTWpWSWVmb3I1ZGQzVXFxcHRU?=
 =?utf-8?B?bm9JYmRwaVdIMFFEWWhObjMvdkQ2K1ZsYnVIdm1LUDNiVHJsVGRkRVBxUEtp?=
 =?utf-8?B?YmlUMmozdnNtRjRlL0VqTW01SXg3R0J5MXJlUzhsVTlDWXYwSzBMK1g5Zmsw?=
 =?utf-8?B?MnJSekVpem5YdnRBOEtvb09NNjFmWW9KUERNTER0Qlg1YSs4MjdDNHF6bzlx?=
 =?utf-8?B?czlPWU5JYzZJc09oN2RiRWlKV09MNDl0Y1RSUjR4Y040NEJZK0xHNVFsVmJh?=
 =?utf-8?B?SG9HalZ2MysyQkQvSWdxSSthMFVJaEpBVytQSlYyWWF3dVRrVHNWVTRnMFZS?=
 =?utf-8?B?SisyRWpnUWdwS0pwcmRRZmhQRTZBMWora05ibVFpbEpWTDk0Ty85M2dyY3hT?=
 =?utf-8?B?aDd5UHRQemFMckFKRG5kd05DZUJ4NmVhdlI3QnJwOGpaZTQvdlB2akUyY1c0?=
 =?utf-8?B?clF4WDFuRlIveDRzNFdwVnNMcFFibnRqK0FLQnRPQ21SaTdTcHEyVEJ4WmRB?=
 =?utf-8?B?K2FSZldkak9DZEYzZ1VZNDFIMnRRYU9sRGFLbFFmT1k4SnY0eXZZYW92dWgx?=
 =?utf-8?B?SnlUOEwzcWh2d3ZkK0I0M0FuVWh6RjIyWkM4QjdFTGxyeXUvRnhlWC9FSi9t?=
 =?utf-8?B?c2RsaGxkZXh1aGZweGhIYUp5VjVEMjlJR2FrTlZ1TzN0OE1NWmM5Z0R2NG9h?=
 =?utf-8?B?Vmc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aDN5VzdJd1FIWE9uaUk3S3FjWjlYSHV6ZmV5d3U0TUJjOGROemVZU2U2aWNO?=
 =?utf-8?B?V0QvOHJsV292R2RWcVhJM0phdXB1VHRWaUNLMVZla0hIeitDYkU3eXZFcTFG?=
 =?utf-8?B?bHV2bW1kT0pYd1c1WVdqWEE0dHNjcm10QzhtTUhXOTJkU2JBQ1J3TTUrOXZ0?=
 =?utf-8?B?SG5RTm1ORW02YS9VRkprOUxZU0x2K0sweUtSdEEybVNESGtIOFRjTFJTUzdq?=
 =?utf-8?B?WU13WVBtUUpEOHJJQjZtOElqTS9MWUpFdDFJOGhaWnFCWWIwajhmbDR3TE1l?=
 =?utf-8?B?cEhONkgwaGh5eGNaY2haVHVZVjVvNmJVZkJ5U3ZCdDY4QjZhaTNPdGhHcmc3?=
 =?utf-8?B?QUdramxlVUcxSTU4N1M5bFZaTlVBMGgveVJCanVKTUdIZEFlb1VRakoxc0Fa?=
 =?utf-8?B?ZlVLWEFldkFIZGgrOUdLeXB1OG96WStEYmRaUVFkUjdsTmFZVTdNVjlaQUJ0?=
 =?utf-8?B?ZW40S3Q4UkhRcnNRazNjeFo4WE5uNlMwM0VGTEZRMW92eVZCZ3hOVTJGdXZo?=
 =?utf-8?B?TG9ldnhVUnBPTzROSWtJaTdoYlV5UWpWSzRQRG13cFNva0x6ME82M1NMOHNk?=
 =?utf-8?B?ekZmdWRuQndjY3pHUnVGWmx2cXFHNS83TmFzN2R5SExpM0ZsUnNDOHMvMHhj?=
 =?utf-8?B?RUF5RW82b0RER1FqbXlDaEhzTSs3ZVcvT28vT0p6N3E2OVNxUTRTWnJkb0RZ?=
 =?utf-8?B?Nmg3WVJNNTRIR0pzWkVLWnNEblA5eEtlZ2Z2Y1pNOU1NTzRIVmNmRXNKanl4?=
 =?utf-8?B?SjBYNjJrOHoyRzNpbkRGbjJSU0RhbDlMOHFsdXR0TFIraHBsOGpIUURGZXUv?=
 =?utf-8?B?bFE0SU40UGFmcm1CQVJweWlJSjFzSnp1bHNjL3lRTWI0aFFIUjNqdHA0WjJm?=
 =?utf-8?B?MjZjUVE4ZmJoaVp6bExtOXQ3T0hIa1V1WXZhQnJXYzFaS2FPQmthMXlCdDdh?=
 =?utf-8?B?ZjJyY3RYSXdKK0NJNDVmTDh6amV4dVd2NXhVdys1SlJ0b0tzTmN3eUpDSVAr?=
 =?utf-8?B?d3Vvb1JBZVd2K0JrdVQ1VXRYYnh6YU1JL2RqWStWTDRjL1hZdk01SlFpbWRu?=
 =?utf-8?B?Ti9jNXZOVHh5QjZQOWwzcFBtcUlmMlV0T3Y1d09CMy8rSFBKVmJRdDdVVGxt?=
 =?utf-8?B?WUdGelo4aFJORWxWS3NwcllBWmR6aGZlSDBmVWdNQXN1QzdweUZZNm01SjFE?=
 =?utf-8?B?MHNNcTBHSDNnY2UvcU1zOFRaOVc0VDFFT2pzNEFmMU9jaTlzcTRxQStlRk1G?=
 =?utf-8?B?OGdSUlNUTG9WczQ3U3UvUW54NW1OYlFKVGpDMVk5RVlyTWtLQT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9653caac-14d8-4a6a-afc5-08db6eb74b53
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 22:16:12.9634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yi4i+kjO/S3Ee3omobRY+vbu15CD/5gubHSTpEJ4hX/nNrek/CXKG0pPmlUslJFZy8L+fnO8FL+fXY0/ZGiOoouDnrZqCsfdLKPWKtGxCII=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7652
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-16_14,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=944 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306160202
X-Proofpoint-ORIG-GUID: t46Huv8pjs1cWPyqeeSewCWbFf56aB2a
X-Proofpoint-GUID: t46Huv8pjs1cWPyqeeSewCWbFf56aB2a
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/5/23 9:01AM, Siddh Raman Pant wrote:
> In jfs_dmap.c at line 381, BLKTODMAP is used to get a logical block
> number inside dbFree(). db_l2nbperpage, which is the log2 number of
> blocks per page, is passed as an argument to BLKTODMAP which uses it
> for shifting.
> 
> Syzbot reported a shift out-of-bounds crash because db_l2nbperpage is
> too big. This happens because the large value is set without any
> validation in dbMount() at line 181.
> 
> Thus, make sure that db_l2nbperpage is correct while mounting.
> 
> Reported-and-tested-by: syzbot+d2cd27dcf8e04b232eb2@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?id=2a70a453331db32ed491f5cbb07e81bf2d225715
> Cc: stable@vger.kernel.org
> Signed-off-by: Siddh Raman Pant <code@siddh.me>
> ---
>   fs/jfs/jfs_dmap.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
> index a3eb1e826947..62f058822a3a 100644
> --- a/fs/jfs/jfs_dmap.c
> +++ b/fs/jfs/jfs_dmap.c
> @@ -178,7 +178,13 @@ int dbMount(struct inode *ipbmap)
>   	dbmp_le = (struct dbmap_disk *) mp->data;
>   	bmp->db_mapsize = le64_to_cpu(dbmp_le->dn_mapsize);
>   	bmp->db_nfree = le64_to_cpu(dbmp_le->dn_nfree);
> +
>   	bmp->db_l2nbperpage = le32_to_cpu(dbmp_le->dn_l2nbperpage);
> +	if (bmp->db_l2nbperpage > L2MAXL0SIZE) {

Actually the sanity check should be much smaller. The maximum value 
should be L2PSIZE - log2(MINBLOCKSIZE). In reality, I think it's always 
zero.

Shaggy

> +		err = -EINVAL;
> +		goto err_release_metapage;
> +	}
> +
>   	bmp->db_numag = le32_to_cpu(dbmp_le->dn_numag);
>   	if (!bmp->db_numag) {
>   		err = -EINVAL;
