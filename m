Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026777129DA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 17:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244013AbjEZPpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 11:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244221AbjEZPpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 11:45:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB1E13D
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 08:45:03 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34QEpw0r024519;
        Fri, 26 May 2023 15:44:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=HfDHO+1/G1nyanxqcVlO7StO8Q4cTx3V+C2bjd9NKwo=;
 b=oD6DEpiIOQ0FAd2Pg9l/6gjePs6YcZ2HkKDUoYSGIV4d3Qp81B5yck1v+0KSvdi040HB
 TF2si6MVxQ0FGjrhRsAOdTcueqRR7cCqHdpQJK3uToMBPBKTMxZTeyIZTFpL6y5UwMbA
 e1QR7Iv86PongfqUN07kJWyYyxtD1Q3ri4wNAWFlYunwV1eCTEWw45Eh8XYLAzPHL3km
 PtaTIKTi4gK1E4FLPDTjfRYnpWysJTI2HugwJWFymr1hZoppKh0M7GNyXW9cMbdLuyc3
 aMjXZ6hda2eIrYR1/8y7wbup+3tDiAXb4pi1ftI8+PEaLYsQzUnI52HFS0GFG1XO5vKB EA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qtxbv083h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 May 2023 15:44:42 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34QEImSY023970;
        Fri, 26 May 2023 15:44:42 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2049.outbound.protection.outlook.com [104.47.51.49])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk8ynj7t-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 May 2023 15:44:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sw5K/YZ13eMQp0O6VYq67Z79QkUZm70XPfIDNuuEqzh8k9gMK7bIxQG4HX5NpVkNFisfpWDS5i8/53TeCFA09G18ylN5e69AxldzxyfFNDC6Qcgr2VXBXxLRZaP6eziopMKNbIBIqYVOY8o/lpCJPLqpXaQ1BZ86zcBiXpsD8hJgyfED7SJUX0zZjV8p5LCOd6rB2/4M2t4fakSl7fpVj/BFQRSlaSXrcJuKooMoKXkknHhjYvdSMxpYaWhj1u8NXOklXAv6W5q/CXsCkTZEYijpbuaKFan/vKFvX5YODQCCxk73PXjjB5h6nUxu4HiPBkjUkcH5VQzXxB1HVtKv1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HfDHO+1/G1nyanxqcVlO7StO8Q4cTx3V+C2bjd9NKwo=;
 b=Nu0HKsAfx2/5OxjDyeqMyVr4ui5Nd8apMPGKEjuZAWEx403htjV1HlB3EA+1lszJfjqjWvHTwoEEhzLdZcYFSM7iFJx4Nbq418sNDB28HyluO4WwD5QJH4Ob8Qu0xGvtok+AfTSEJd381rWTxyuArppY3zzr/Kb5zmS/eRQwh4vQRXtlSw3DYNcs1kW3yuGFf4Amhw3eJAGjKJ55Tcosp0+r7sIHsOZqcfskrIGRirvecTdJt6ZHG6zVEyVxqWKQ2bPFztwAngFTBZaRxfh3WneDNXfpI3M80JhUOvN9kmpWg9F4yNlUiO3KgPYkvxNM4c/DF+0qxs/Z+zrZsreRPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfDHO+1/G1nyanxqcVlO7StO8Q4cTx3V+C2bjd9NKwo=;
 b=XMCRla/Y5jH/g82xSpIM1usilYYpY72HZfCChVMiapmMUlrN56MHGICOPj/jXQuWCTxZIEC9lpFlTSXC7Qjl0vuTPcKW/7d2zP8CdYJrRqMECTNn7e4B4WiRAmRFbtchHi6mhUwFq2XZKn01e2M1FFFhYnLNxA5B+X9Q2iHD50M=
Received: from CH3PR10MB6810.namprd10.prod.outlook.com (2603:10b6:610:140::15)
 by MN2PR10MB4318.namprd10.prod.outlook.com (2603:10b6:208:1d8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Fri, 26 May
 2023 15:44:37 +0000
Received: from CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ba49:e5dd:6a80:37ae]) by CH3PR10MB6810.namprd10.prod.outlook.com
 ([fe80::ba49:e5dd:6a80:37ae%6]) with mapi id 15.20.6433.018; Fri, 26 May 2023
 15:44:37 +0000
Message-ID: <60367660-f4a3-06dc-4d17-4dbdc733ef74@oracle.com>
Date:   Fri, 26 May 2023 09:44:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4] mm, compaction: Skip all non-migratable pages during
 scan
To:     Matthew Wilcox <willy@infradead.org>,
        Steven Sistare <steven.sistare@oracle.com>
Cc:     akpm@linux-foundation.org, david@redhat.com, ying.huang@intel.com,
        mgorman@techsingularity.net, baolin.wang@linux.alibaba.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Khalid Aziz <khalid@kernel.org>
References: <20230525191507.160076-1-khalid.aziz@oracle.com>
 <ZG+99h3zg7POIits@casper.infradead.org>
 <ee093583-71c3-51ba-980f-0facb03b0e23@oracle.com>
 <ZG/I7tYY4uV/32hP@casper.infradead.org>
 <ZG/To8Z3StoVoenU@casper.infradead.org>
Content-Language: en-US
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <ZG/To8Z3StoVoenU@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0026.namprd21.prod.outlook.com
 (2603:10b6:a03:114::36) To CH3PR10MB6810.namprd10.prod.outlook.com
 (2603:10b6:610:140::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6810:EE_|MN2PR10MB4318:EE_
X-MS-Office365-Filtering-Correlation-Id: 756d4947-5918-4f7c-a1f4-08db5e001c0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TcrdRNFWInGiflqIX9YbQ4FhGlKtrCR6GF+zKQho8UFtQcSJ/uugS4BLv2RASMW0AqooyDkDFRcnrrYpHKzo6aKa4As+GC86m+VFGFSiGw97ND0A7Ozz2UdnvOYTiicSYiSLbLymvrRNMcVhxZEKR8z9RVVeeGh1WxdCWn+bssQ+3FO4+a/cv+2vt7gC49aqyp1cqRn6TG8Tg/HA5ga4ilCImS5gYlz/PWJIuFF9EOIjKpyuv9GDU9q0d0tDd7R0VbEnx60Txa7u5WYszzVErbvcVB4Un4xmzqK+GAJy0HXA/CXzPL2jW6wxQh1i+c1OqePNzLoUQjnqj0rNvwMI4WuRtzfyTfZz3Vt1m/k0xdDVz4mwPmVivg1ySJO9U5W2OLDsBCKCnwYGGkXZhz/nv/cPSb7eY0Xcx+N4xgtx2zBt4XldF7jV+IOlsvSyLxgg31pzKJu7Prjr9yKHQ4wmphrgVx66ezPf+wCQ3GJmV2KFGZAHsSsnfq2xbwpXuWYT0SrmQaUSX6SvCKxBw/y68bJGTowtFyj6PKezR2JyxhizThw3WJko2qe5ArscaWEJgj4T4MyP5BsQXRK0VIHQM5ANpbJ8Ll93buTYuGJOZDn0dv1q6vMGer4vxh5qSn2Aufmf6PG3PX6uh/y362K2QA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6810.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199021)(316002)(6666004)(6486002)(41300700001)(83380400001)(6506007)(26005)(186003)(6512007)(53546011)(2906002)(31696002)(2616005)(86362001)(38100700002)(8676002)(44832011)(8936002)(36756003)(66556008)(66946007)(4326008)(66476007)(6636002)(31686004)(110136005)(5660300002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXhzalliTkVxTUR2UUFGYmZoWjBmMjMyNHBsNXdSTlJjOGY0VnVFMG5iY2cy?=
 =?utf-8?B?WjViMjRBQzJEMGxleitDT0NHWDczS3pIS3dvTVBvSHNoVmRkcVNOR0gyaHlE?=
 =?utf-8?B?T1pnc0tERVdMaWZoeElCWUlUS2pydXEwTXNBNFZGK3Q2YXJYVlFrMGFCVG5j?=
 =?utf-8?B?Q0l6Zm50a1NzMDkxazJiNHBpcFk5ZTN2THFudXV6RTVTd2gzRnlpaHZNak15?=
 =?utf-8?B?Nkc2cUJqS2dVR2IxOU1iL1NYTmdkT2F6TlRZQmcxN3hmYjFMeEZoaFkxZDNa?=
 =?utf-8?B?czAydnQwWUdaNWZTcVRsZmJYWFcrRjArSUFDT1NVQTBMelE4Sm81ZEJFZHdL?=
 =?utf-8?B?bXM1V2h5ZXREWnBYSmVuQWpyRC8xOE0vWU5rM2Q1TTZXL1loS3FDdjFaREps?=
 =?utf-8?B?clhPeUVVZC9mdXZqMnZBb0huVUNUcnRrVG8ya0NGaWdjc0JEQThQN0J0d2FN?=
 =?utf-8?B?QXFnNW1QZDRQa1A0MnA1OG1NbGFyUXdlODZuMytzeVNrUTV4dmMveG1IZU5o?=
 =?utf-8?B?K1F5RjI2ai9MczFJTjN1TWdHWkNoZFQxUzZXZFZ0b3pPbzVxZFQ5QTM2bXRU?=
 =?utf-8?B?Q3lldHUxRFhXZTd2RnJmVnpoK051Lyt0cXU0dFlhd3liK0JuQjM3NVJLbEV3?=
 =?utf-8?B?UXc1amhJWEd5WXE5bTNYb2NxOUtuc1ZjTnJTUkVUdk1lZHMyNWRSUUJ6VjVE?=
 =?utf-8?B?TElvZTltcGFDWU16OHcwSlVqUFYwdkZ2S2VWNnRGRGhaVzVITmdJaFc4UWhx?=
 =?utf-8?B?d3hnRHRqd3R3cmhDV2pxdDBCdEZDKzlIVXNRaXZDS0s3dFZQRkI3QnJPd0th?=
 =?utf-8?B?SnU1UlJKMHZpTytJcVZDNWlHZ0dpcmF4a1UrYlRaWnpiOC90U3NQMzJPVEZt?=
 =?utf-8?B?b2hWUThEeEhFTHRmMjJQZVdiZWNkZkM2Q1d4VzBCUGhJU09EeWRNSnlvOGRx?=
 =?utf-8?B?cDFHdElSS3dPVGVsN0h5b2oxODBZZUJFWW9LUXZEcUd6d09lRnJjV3M5ZGtn?=
 =?utf-8?B?M0JHamdUZmZSOENHT2tkZVUxTGFVbmJaL20zVXRsODUyREw4eUxMNnlqa0dQ?=
 =?utf-8?B?ZEFJNXlxQ3BCVHhTaTNsOUR3ekNFNTFUeHNiSG5ySW42Q2VtN2ZBVUVSSnRo?=
 =?utf-8?B?TWRrWjhKUERNVTM3SEw3MjNPaVZwNFVxTFF5bXNnQTFIS3BQUjYwUlNZS21J?=
 =?utf-8?B?dU1TVlpXSlpJWVBtMVVXa21jSklKSWd5YTdKcDE1ZGp3V0xhY0ZFVWlQSThZ?=
 =?utf-8?B?Y08xSzYwWlB2MUY5TVVWTXYxQkRvNnpCMzVGcVFEalhPbzVSL3c0NXdoSkUz?=
 =?utf-8?B?R1VMWEY1M21HQkcvZ3czV2NkMEszR2ZzRHZOYzZCSDlSZU5KWEh5Q21aK3lv?=
 =?utf-8?B?Z3dmQmxzNjY3V1NrY29OM21ud2UvNUx1Sm02dG1vTUhnUTU3VUU3T1UwUUNC?=
 =?utf-8?B?b3d0RFltYW95Q1FTNWxFdUQ4eUpWcEFwMGlLU3V6NDJTbUo0UTFWL3dyblpJ?=
 =?utf-8?B?Y2c4TFQyYXBXcXVjTHNkVUJaMWdOd0U3cDlzQzVMTlpwVnZJT3NnQ3pwQ00y?=
 =?utf-8?B?QnV2OUw5ZVlROWgrQ0p2SGI2Y2NONjRVTzNudFFvM3Ewa3VRdCtvQ2EzRUQ3?=
 =?utf-8?B?NWFUMno2K3k2ZXYrcU9Lby82N0tGNGxpMHJTZjNjK2srUVBYVStpV2oxbTRo?=
 =?utf-8?B?bVRuY2hwc3ZiaklTdGhDait1b0pkZmU3bi9qQVU3L3hRaVBqSkJOVm9SVUJz?=
 =?utf-8?B?Z3VkWWJwZXk4SGdDcWEzUkdaN0xoU3JXY1JBNjJCQllmK2t6S3laS0szaVpN?=
 =?utf-8?B?UUNaUHorNGZIOGRBRE1Cem5vcXlHdVA2a2o2a05GbGw3c2RiR3lIclJEeEo3?=
 =?utf-8?B?Wmdld3oyNU9GcmxDSzJxdXZhLy9PMFJaVnR6ZGJRbkl2cFhwY09DM3p3QVFp?=
 =?utf-8?B?ODR3N0pSWTlROHpMcWRDYWMrMzVQY3lUS3dLNDR2OHRWSDBmSjRzRWRMczVG?=
 =?utf-8?B?V2lZZ3p4VlFIWG5keWIyWTFIYk1VaWIvZVpkRllDUDdkWVNBL2NLaG9lSFVa?=
 =?utf-8?B?Z0lxMFlSQm9UZ3BNU0ZWR3M3cFU1cWZpQWRudVJzeWZxazBxTFlSZjZoalAz?=
 =?utf-8?Q?vqQWnjO4tfjqF1i9VKahrliod?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MnlnVkhEa2hxaUU0ZlVnTDFURW9CTUlqcUdLTm5YOG1YcXZJdERUTk9OYjJI?=
 =?utf-8?B?a0ZSdlZFMVdCWE9hL29zV3loNlJuZkd1bTJKYUtZOUREd0IyclZIZ0NNa2V3?=
 =?utf-8?B?T1BZbVFKRUVRRTQrQkEwZDVqTWtwYUJRejIreXovR2VxM2QrUWNNdFhyNVBC?=
 =?utf-8?B?M1l5blVXNTBNaXorQ2RielltZS9mbjlTRjdQSXZwSkRRVzlUWTZuSk1iaW5J?=
 =?utf-8?B?MFFHeW5keDkvQjRjVjBuVVZ3bm1kWWgrR25TaGNpcVBVekJydXFUbTI0MmM0?=
 =?utf-8?B?UWllRDcwSFZQL3lqT3YxQTVtU1NKaWU4cVZVN0VLdi9ndHlKWURrRituNjc2?=
 =?utf-8?B?U3AwcXFvUy96dzhXc2RMRUY0bk1QSkF5MUYrWWJCQWdpalYwYnhyY0JsOGgz?=
 =?utf-8?B?NE5JSXF3QzMzUHF3MnVQWDFTZmxZcEI0dkV0ZWJJdGw4RUpmdENKTW42RUdn?=
 =?utf-8?B?Ty85WmZKM2FwZEFqUEtKQkgyOVNMRldRTnEvS3RwWllEV3gvTVJZNmd4VXl2?=
 =?utf-8?B?cnJTZUJ0WkFiK245YVd2aHNwMHBMclNSL2tOM1JUK2FNMDJobks3NnRxVkV5?=
 =?utf-8?B?NHRPTE1xZk5lWU5BN2JpQm1MU1U4TnBzdEhQSmZ0Ukl6OFlyRlZJMi9zdWk3?=
 =?utf-8?B?blhBUVc5UGdEM29nRGdmTXJzRnhtTmlZcXVKS1o2bndZTXdMMmJOd28vME5a?=
 =?utf-8?B?SXJKYmVMMm5DT2NPOUc5NXBxeFZaRW0rcW1pVWx3MUIvSkFGQWwrQjNMOW1o?=
 =?utf-8?B?b3dwMnNyZ1lLbXJzUHFxN25SUzlUOHFNQkJYY294KzZqVlRpUVZJNEZRTHl5?=
 =?utf-8?B?QXpzWW13UGNQdEtWdjRCZmtPbmMzZzd0WjNKSXVoa2orUmZzRXhxcjBnbjhs?=
 =?utf-8?B?VGRmRm41RTFJSmp6R3VRNlpSbEdYWWE3VFBWdU8yOHRpVFEzNWFQZ3VwOEpo?=
 =?utf-8?B?dlN4OERTaEVQTzA3ZktERE5lUFdzUWtsZ0hrSEc3YkxvMmI2K3A3TVFlRXNp?=
 =?utf-8?B?OVNabGV3QnlRekU3S0lQZUpFVmNzMDlaK09SNFRmeE5YbzhQbEE3cERhdktF?=
 =?utf-8?B?d3FhOWpaSllpQ05HYysxR2hHTVBwcitEOHdta0pxbGhMTTFQOHJjWFN0VmJW?=
 =?utf-8?B?Y2FTVE55ZTl1MEhtZEM1ZFlLYjB1K0JKN3R6ckVrcm1iSnp3V1ZWOTFlODMz?=
 =?utf-8?B?TUNSemUweHBZM01QZWwrYmhleXVrb3dMdkNVUGFzL1JITk1DclFkcXo5UE9V?=
 =?utf-8?B?OTBOOFNQUnA0QWExSmdxeEJvRVVaZDM5WmV4L3pDWnZYWWZqQU5KZVpRdDZO?=
 =?utf-8?B?OFYyY0JDSjJkOERBaTFvcW16SnFaekhGOTJYUkIrTFdmMHJEWUl2Z1dSQ2Jw?=
 =?utf-8?B?elA1NW1EczE5bDhxSGhNNEZLWkhYZEtQUFNQY2xVZm9TNzU4MmgzLytnSzBx?=
 =?utf-8?Q?uSiXLYRE?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 756d4947-5918-4f7c-a1f4-08db5e001c0e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6810.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 15:44:36.9931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f3wRVk2Go8Y0AexnqLjMTptBIutSK5hvQI1BHG9DlATsF4u7RYCjr3klLcUI88O5/jFlj1TrY9pwEew7tZfkow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4318
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_06,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305260133
X-Proofpoint-ORIG-GUID: Zsl-_67mWvgPN0Y5uIizsHr5hVpqVOjU
X-Proofpoint-GUID: Zsl-_67mWvgPN0Y5uIizsHr5hVpqVOjU
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/23 15:31, Matthew Wilcox wrote:
> On Thu, May 25, 2023 at 09:45:34PM +0100, Matthew Wilcox wrote:
>>>> Isn't "long term pinning" the wrong description of the problem?  Long term
>>>> pins suggest to me FOLL_LONGTERM.  I think this is simple short term
>>>> pins that we care about here.
>>>
>>> vfio pins are held for a long time - Steve
>>
>> So this is a third sense of "pinned pages" that is neither what
>> filesystems nor the mm means by pinned pages, but whatever it is that
>> vfio means by pinned pages?  If only "pin" weren't such a desirable
>> word.  Can somebody explain to me in small words what a vfio pin looks
>> like because I've tried reading vfio_iommu_type1_pin_pages() and I
>> don't recognise anything there that looks like pinning in either of
>> the other two senses.
> 
> Oh, I think I found it!  pin_user_pages_remote() is called by
> vaddr_get_pfns().  If these are the pages you're concerned about,
> then the efficient way to do what you want is simply to call
> folio_maybe_dma_pinned().  Far more efficient than the current mess
> of total_mapcount().

vfio pinned pages triggered this change. Wouldn't checking refcounts against mapcount provide a more generalized way of 
detecting non-migratable pages?

Thanks,
Khalid
