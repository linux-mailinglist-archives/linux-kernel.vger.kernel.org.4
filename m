Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C258B700F89
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 22:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238746AbjELUDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 16:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjELUDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 16:03:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2479526BF
        for <linux-kernel@vger.kernel.org>; Fri, 12 May 2023 13:03:23 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF48h8032463;
        Fri, 12 May 2023 18:22:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Y4ZbLEM4kDOHNEOeYFcsm3MLN017hWG4H5SM40i7zJ8=;
 b=gqnklfIPbSqcYT4jnm4BFzrXtem/6b77bEacqWwBQfb/jDGhgYL2puFddsSEwuVyUC7V
 A/O3/X3rNpRbLuCawSKp2CnoAlBjVbe1g7MzbexnTn03IUeqdSHsHZj6yLEbNAtsBe7D
 xXbW+dtEIdB9/O3EknLJsaxbnaHI8I59rGg0rXueFM9w7j0CyhtdCouVOS0ALGwOJDwQ
 LMdS4JxTWXw3+XnYgiK5JxMQ/v1YVxQfbm5y7XZwkvtyo9anj2BHxIrp6tkKPRWbxnLY
 M/HHKBfFE6S2wkqHe+GrM5jj19iuFqmh4JsQj5Z+j/MP1GPZ8yGizaBXiTjnG85PuAZz pQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf777bm4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:22:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CGoFFd024387;
        Fri, 12 May 2023 18:22:17 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf7y8gufd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 18:22:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9KArgcefeskMEoT/CFlwQNr5/Ah/HroQtqli1YPEIIyKO265V0TQvGijudK3L73KoVTt20lKPVE9uHs/ieVZLcG77C2vdRBkzesrOHEqWB8ceRHXLOntwif1wNb1kUB/YVNJw6iluHrUolDcaePLqZIYX5GF43H12ocMbFhW8P+CW1TiDxOvn0CzXMbWiLjpyRdZGIxdJQTNHKfEEe0v9p/+CYI3TDwCA20P2TppYQrQUhQWpJmWu5h/bN/ttf5k4Oe4io420HZeIpUL0AyeZZYts0Ix9iDXiuXVhTWkvuVRA0PhaqQcNXLbPnMHiV21uxDKEEzmdEehXaI1xMLqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y4ZbLEM4kDOHNEOeYFcsm3MLN017hWG4H5SM40i7zJ8=;
 b=MB5Q8hPKhHr9agqi4KsQxbGktI6/JmfaSQQWa+aTGPVh1j2jahU7T9C+mwrxSh7aTzcHZwUP3m3/hDWQ/xde2EXdvZ4VACH+ky0ocrOrDe3iFLNpVOzWKJB1pzJtHi0B8UhPs0JT5DLJL6y/UqI+xhuuDoNJXZExEC23iU0NYKVc3uFfil5MzeDLNshjqa5pwLxxdk9eVyD9qYO3ZIwWkeVk1vN8AX3JA2CWsh1cDV9OB6j0/NQzKwZpwr9l9NoHfSfsxHHnyYuKh/7gO+DVnojE/wEZqD2wFzBmzfwdzYI3t3ilZyfaJ7put7yg+Dh8ECMSMYIO8jm0L7/5bsTugA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y4ZbLEM4kDOHNEOeYFcsm3MLN017hWG4H5SM40i7zJ8=;
 b=hikbgOyZqCFg7S5bLttXAIPA32T079Zv+TKZu6GUVUYHqPCjHAv/bejOHGiymLE8vb/pdhAIT5vF4cpq09i2/gkfD0ycXT+GVcKsRmA1nt4Ou6GjZJAzEPW9Lf2rI+4mJ6x8ILwStOSx3VKztPXFUEWejhkYAt9+FdiQiVNQFwg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5211.namprd10.prod.outlook.com (2603:10b6:610:df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Fri, 12 May
 2023 18:22:14 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c478:d218:8f15:37c%6]) with mapi id 15.20.6363.032; Fri, 12 May 2023
 18:22:14 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 33/35] maple_tree: Update testing code for mas_{next,prev,walk}
Date:   Fri, 12 May 2023 14:20:34 -0400
Message-Id: <20230512182036.359030-34-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512182036.359030-1-Liam.Howlett@oracle.com>
References: <20230512182036.359030-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0037.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::10) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|CH0PR10MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a36f20c-3442-4124-6a18-08db5315cf92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Le9EChzxOC72TICqmLJOXxvfCGgYEvtMnxrw7kEPboCzCMud+5RMEOnYxY+1SzFyh1qKgmQnXKRXFJcCm6uD3HeOUU9Hhu5EGUVrVbjQRNRvJ+zAMUXlE4GZxZDH9D0n6GZCzKNeDX5aei9uOkvLibETyVmN9U6UAdguHb8QpspHR+Uf9zFpDKs4nb2o3otV/yJ3WDsIX9+2nUK6J0mm+QyziUy/B5ZLUpOj7NPre8CEpYEIkd4pB/y0EiC4vNUuOApwYA1Lj+1hTf6alLoYkXVpyiwg6JrJe1R9suTbZJV3sdAbW8nAN/uSR8M6SwyUos2xu9fh6iSddfu756MuYI347e7kJOKlroleeLLQtPl06CdClGooW8hV805J9CyoYZQDb2D85cXXusn2qlvbcHUeDzWgHeaNo16V841/xmx2gg5Wx3t5gcodT8s68P9BZGIaNhSgr68+EY8prwG/vmHUmv3w+Jo3mF5oB0Lelz+j9n5elZ7FRswF3+3BYnGxaIIsxKviJ8ezcjMHNLVwlXeUqAdJUNY1g/pmMFRym/bFfmPxSjwCqyk3Ndn4z1s6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(366004)(136003)(39860400002)(451199021)(2616005)(8936002)(8676002)(6506007)(38100700002)(26005)(6512007)(478600001)(1076003)(36756003)(186003)(4326008)(2906002)(66556008)(66476007)(6916009)(30864003)(15650500001)(66946007)(83380400001)(5660300002)(6486002)(316002)(107886003)(6666004)(86362001)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXBwRHFyaE90V3J2T0hubm5PeVlrNlRDNm42MldLREZXb1J2VXBHa0ZNWW9I?=
 =?utf-8?B?ZFVJYkRnRE5mZ0YyNlhBY1h6aER5alNnUlV1eFBZWlRZSW5wVzRNTW9nR2Nr?=
 =?utf-8?B?RnZtelZZcW52T3BtQ2tDanVSR05INXFvMVhEd3dXNmVWbjdKanRaM0d1M2hQ?=
 =?utf-8?B?N0F1ZFlmK2RlQ2tTcWhLNVBFWDB6OFIydzB4Wk5EbTFFU29aZUtoNkJJcWFP?=
 =?utf-8?B?NFhBK25TemdYQlllVEZ6c0IvMWZFN2VUTjBjclpuUXhqQnBUR05vVW1XZGhj?=
 =?utf-8?B?R3BrVmxoWUVxbVZKcFFrTTJ0WUFSWEV2WmtBcno5djYvR1BmZWk5UkE1Vjl1?=
 =?utf-8?B?d29pUjFzMENoNWhGQ0hFT3p0d1prQWNkc2J6c21NRFVQZ1RJOE1EajhWbnhw?=
 =?utf-8?B?ZDVxUWNVcUV0MVJ3M0kzWTdyN2g2cHlLWk5OaU10a3Yrbk55dTRZRXBpZm9y?=
 =?utf-8?B?N011UUE1bzdSbFhPRTN5N1YyV0pQYUloQi9HZUxUVENKcHhSbkk2UnY5ai9B?=
 =?utf-8?B?ak41eHg5dWdJNWw4SDhobkFFa0lkbWFjOU1EamJzNU51ZzAvbWtxTU14TjhK?=
 =?utf-8?B?cjFQaDEwY3dlbjBybTBWZVBuTW1YdEsvZ0RSSVphemo1SHNrVk8xenhMSEx1?=
 =?utf-8?B?UTlqbmNxWTRwaWE0NTdyaHVZQ1JqUFFuZDZsbnp3c1VNRTR0V3BFSTlOMzV0?=
 =?utf-8?B?UU5zdmhFVUhDZVdJVU55cyttV2RpUVpxYklZYXZ2VzJ5ZUZacEdzWUFEbW5Z?=
 =?utf-8?B?OEVwV3dtTGVxNUNRNGtVdVQ2TXlwM2tEaER4dTc4dHE2Uk45TC9qQXpSbS9Z?=
 =?utf-8?B?ZW83bVg0SzNnQWNIUjFiaW4xYXdnT21TNnJBYzJSZzVyYWRFN1Q0RktZYmNK?=
 =?utf-8?B?Qkl3d1hKNnZBZ0xJYmQxTHdPUzZpay9qMklJMGJKUHNzR0w1L1NGWkNnQWR3?=
 =?utf-8?B?L0x4UkVmTU9sUGhrMzZiMDhwdGVZRTZqSnlOcUFzbFpBM0tEYWg1eUkzL3dU?=
 =?utf-8?B?MU9VbWlsNlU5bzU0dGFOdkNJRW42Q1VJdXJranFUQzlUVzZUazdMbEVMZFBy?=
 =?utf-8?B?Y3dxRERUQnJ5RCt6bHQ2dGRJRXZic3ltYmIvdWdrbGlYWDFla1NiNjVmMjQx?=
 =?utf-8?B?ZUM4aHF4TE1kek9iRG5BbkMwazlucm16NUxCTjQwOC9PMXpXTEJ2Y3EreEx3?=
 =?utf-8?B?TUtLbWhxSWhCQUdkMytKZ0srWGZSaHBhTHNKS1hpelBnWFR4RmU1WWVuQ290?=
 =?utf-8?B?ZnRaTGF2Q1lFTDMrMmduVUd1SlZnRmRmM3pYODBkWTAzQTlEVW5PWElTamdz?=
 =?utf-8?B?MG1wY29Qd0VjTkN4Rjh3aytYZXBmZ05pMnd2SlVhZXB3Qmw1N1gxdXVwaW5u?=
 =?utf-8?B?emxFNU5TSTd3TzJSa0RPR1lDMm42VEVpTjE1L2w4NkF5YzdEZnBaR1BIczJW?=
 =?utf-8?B?UjFhSkNZQ2JRbEUwYlYybmV3M3U5UkpHMXRLaTQxb0JFOCttUk9pQXBReEhx?=
 =?utf-8?B?RmdnYU1VSENFNDRzOVNtTHpPVHh1R05mcE1UdWVoMUVmTHEycXd2TFA1UWNX?=
 =?utf-8?B?VWJBYkh6a2ZHeTNGbDFaOWtZZFR2bnR5TUl6SXA3ck1oM1F0Tlg2OVBMcTIy?=
 =?utf-8?B?c2xPUVgwVkpyZ0tBYk9QdTRrOWRDSWhNN2hjbTRWMFZnSDNWS0wyTXVnUnZs?=
 =?utf-8?B?WmQvSjViRHJYalJldFlQeTZZUmJWS3Z1dTZuV1F4Q1pFc3l4TmU0Nk1HcWs1?=
 =?utf-8?B?RDJkTDBrbmdyVUk1c0xqbTVCdSt3Njk1Uk5ySGdWS24veUFMa0kyQnJwREQ5?=
 =?utf-8?B?N2NUeWJud3ZNWVhiblUyM2hUMVJjUlFxWlhiRDJSQkk3dERPVXh4R2V6Z0ZH?=
 =?utf-8?B?OTdNOG9vaEoxUFIzRXNDbk9PYitGbXpLZ2ZDV1BYWG9pOGJ3RXlWc3F1bHg2?=
 =?utf-8?B?VzlpcVdlaU9rYkNmYkFJTG9wZzlWb2tYbTRIbWFLSk0zT3B0STd0N0xUWXBi?=
 =?utf-8?B?d0tRUGh6NSs3QlFXRWxIckJVa2VtQmFIOVR3TVoxRVVwTlZhU0toTTJ0akhi?=
 =?utf-8?B?N1RlcTFSNU5GZTcyVEI5TGxjZDZKMSsvWCtKek1XdzFmR0w3UnJIcWxVbmNO?=
 =?utf-8?B?SmFYOFRsZzMzSi9CTlVzckVyU2lrK1V5bWwzQXdnSE85SnRKTUYzNGdiUG1a?=
 =?utf-8?B?RkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BVo8PZbdvrPxLmcNR9KXq4ADrZYt+n2L0gAxOYN++eNCRO+DDLJPqV6NuiX8bQvhyvMdItuPkqkRTrQTNwOQdIhtohCHKm45K17f0eBJKwcCpI44xxQcfWHoCtmWVrXTVlVmraerf2owCtW0j+S4xZQkqnmoDD6L2aMYTfEmvO1LahEXrLNSkx8vLFH7/p7uVuWwqyVrp1x/9TIgPvNRE9frmHqeNC3T811mr9hahAccAhMqV8DSy1ksGiI9JFVYz8rxazyeJPY4LPFwV3lFs5rou+1DLWsjVB3uMAkxyDQBUuPaFNXpc5KwD0Sd3otZ21yZIghEC2yu0ZRP5Ob4e7uTbV2EsRzyyblR+RAYBlPjg7I9nFtGLTyAwUemJJXn18COG69l6sLB+z+o8jFJa/DnC76KoRoZ5ab8DxETscA5BevdSDy+nNZszv8Sv3Qo0AsWrM53WPEHZa+jXfDIJncPfQb7gci2wIhMWXum7z8iesYV6huwBxk9LpGYT3tA1DRl9kCw5FawHiksHr4XeHsY86g8cgdU5RCvV+C8/89cUSU99mlFyxlIdsfMv5M0QZC/eZOp/+bjDrV3xGyb78HboDAqHYJLNWXgk0QoyW92l2IScWlNtb5qvKDqR83huf67S55dBu/r+U5oQ/wxxR/f5sqRzaHajWzlo3oWxOa0dBLUMNQqNmSTbsbFHAj22QOpUMKNbXvMYOSgdBYJRBC7xHGRXGccNVUONsSRaPq3OBrYFanAW3NcrQTz70uewC14oHf6VBC+LOXVjfK84HWeA58tg9LG+FyGk8zkXze1no2tdr/A51PJOf6J7O6IVOivcFnyHEJmJc6b2TglBRJO/DvTTkbg1ew+6bgu5EKQtNt6T7bU9WgFWVlpS/jRnn6YrSTaX21D5oDGyMDjPQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a36f20c-3442-4124-6a18-08db5315cf92
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 18:22:14.6838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DZRwC3okNpvESvc4Aw1RMLtSqjgPOxEIMCBYmZW5kk/o24XOGtY9cYkTZSWRRE08fPVc0op1tD+6l3ZcIollKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5211
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_11,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120153
X-Proofpoint-GUID: t3i5xZhAahXm4x8oEC-VbYzBOyQpa_pT
X-Proofpoint-ORIG-GUID: t3i5xZhAahXm4x8oEC-VbYzBOyQpa_pT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the functions have changed the limits, update the testing of
the maple tree to test these new settings.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/test_maple_tree.c | 638 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 633 insertions(+), 5 deletions(-)

diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
index d295fdee2faeb..9939be34e516e 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -1322,6 +1322,7 @@ static noinline void __init check_root_expand(struct maple_tree *mt)
 	mas_lock(&mas);
 	mas_set(&mas, 3);
 	ptr = mas_walk(&mas);
+	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, ptr != NULL);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != ULONG_MAX);
@@ -1391,7 +1392,7 @@ static noinline void __init check_root_expand(struct maple_tree *mt)
 	mas_store_gfp(&mas, ptr, GFP_KERNEL);
 	ptr = mas_next(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, ptr != NULL);
-	MT_BUG_ON(mt, (mas.index != 1) && (mas.last != ULONG_MAX));
+	MT_BUG_ON(mt, (mas.index != ULONG_MAX) && (mas.last != ULONG_MAX));
 
 	mas_set(&mas, 1);
 	ptr = mas_prev(&mas, 0);
@@ -1800,7 +1801,6 @@ static noinline void __init check_iteration(struct maple_tree *mt)
 			mas.index = 760;
 			mas.last = 765;
 			mas_store(&mas, val);
-			mas_next(&mas, ULONG_MAX);
 		}
 		i++;
 	}
@@ -2011,7 +2011,7 @@ static noinline void __init next_prev_test(struct maple_tree *mt)
 
 	val = mas_next(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, val != NULL);
-	MT_BUG_ON(mt, mas.index != ULONG_MAX);
+	MT_BUG_ON(mt, mas.index != 0x7d6);
 	MT_BUG_ON(mt, mas.last != ULONG_MAX);
 
 	val = mas_prev(&mas, 0);
@@ -2035,7 +2035,8 @@ static noinline void __init next_prev_test(struct maple_tree *mt)
 	val = mas_prev(&mas, 0);
 	MT_BUG_ON(mt, val != NULL);
 	MT_BUG_ON(mt, mas.index != 0);
-	MT_BUG_ON(mt, mas.last != 0);
+	MT_BUG_ON(mt, mas.last != 5);
+	MT_BUG_ON(mt, mas.node != MAS_NONE);
 
 	mas.index = 0;
 	mas.last = 5;
@@ -2047,7 +2048,7 @@ static noinline void __init next_prev_test(struct maple_tree *mt)
 	val = mas_prev(&mas, 0);
 	MT_BUG_ON(mt, val != NULL);
 	MT_BUG_ON(mt, mas.index != 0);
-	MT_BUG_ON(mt, mas.last != 0);
+	MT_BUG_ON(mt, mas.last != 9);
 	mas_unlock(&mas);
 
 	mtree_destroy(mt);
@@ -2750,6 +2751,629 @@ static noinline void __init check_empty_area_fill(struct maple_tree *mt)
 	mt_set_non_kernel(0);
 }
 
+/*
+ * Check MAS_START, MAS_PAUSE, active (implied), and MAS_NONE transitions.
+ *
+ * The table below shows the single entry tree (0-0 pointer) and normal tree
+ * with nodes.
+ *
+ * Function	ENTRY	Start		Result		index & last
+ *     ┬          ┬       ┬               ┬                ┬
+ *     │          │       │               │                └─ the final range
+ *     │          │       │               └─ The node value after execution
+ *     │          │       └─ The node value before execution
+ *     │          └─ If the entry exists or does not exists (DNE)
+ *     └─ The function name
+ *
+ * Function	ENTRY	Start		Result		index & last
+ * mas_next()
+ *  - after last
+ *			Single entry tree at 0-0
+ *			------------------------
+ *		DNE	MAS_START	MAS_NONE	1 - oo
+ *		DNE	MAS_PAUSE	MAS_NONE	1 - oo
+ *		DNE	MAS_ROOT	MAS_NONE	1 - oo
+ *			when index = 0
+ *		DNE	MAS_NONE	MAS_ROOT	0
+ *			when index > 0
+ *		DNE	MAS_NONE	MAS_NONE	1 - oo
+ *
+ *			Normal tree
+ *			-----------
+ *		exists	MAS_START	active		range
+ *		DNE	MAS_START	active		set to last range
+ *		exists	MAS_PAUSE	active		range
+ *		DNE	MAS_PAUSE	active		set to last range
+ *		exists	MAS_NONE	active		range
+ *		exists	active		active		range
+ *		DNE	active		active		set to last range
+ *
+ * Function	ENTRY	Start		Result		index & last
+ * mas_prev()
+ * - before index
+ *			Single entry tree at 0-0
+ *			------------------------
+ *				if index > 0
+ *		exists	MAS_START	MAS_ROOT	0
+ *		exists	MAS_PAUSE	MAS_ROOT	0
+ *		exists	MAS_NONE	MAS_ROOT	0
+ *
+ *				if index == 0
+ *		DNE	MAS_START	MAS_NONE	0
+ *		DNE	MAS_PAUSE	MAS_NONE	0
+ *		DNE	MAS_NONE	MAS_NONE	0
+ *		DNE	MAS_ROOT	MAS_NONE	0
+ *
+ *			Normal tree
+ *			-----------
+ *		exists	MAS_START	active		range
+ *		DNE	MAS_START	active		set to min
+ *		exists	MAS_PAUSE	active		range
+ *		DNE	MAS_PAUSE	active		set to min
+ *		exists	MAS_NONE	active		range
+ *		DNE	MAS_NONE	MAS_NONE	set to min
+ *		any	MAS_ROOT	MAS_NONE	0
+ *		exists	active		active		range
+ *		DNE	active		active		last range
+ *
+ * Function	ENTRY	Start		Result		index & last
+ * mas_find()
+ *  - at index or next
+ *			Single entry tree at 0-0
+ *			------------------------
+ *				if index >  0
+ *		DNE	MAS_START	MAS_NONE	0
+ *		DNE	MAS_PAUSE	MAS_NONE	0
+ *		DNE	MAS_ROOT	MAS_NONE	0
+ *		DNE	MAS_NONE	MAS_NONE	0
+ *				if index ==  0
+ *		exists	MAS_START	MAS_ROOT	0
+ *		exists	MAS_PAUSE	MAS_ROOT	0
+ *		exists	MAS_NONE	MAS_ROOT	0
+ *
+ *			Normal tree
+ *			-----------
+ *		exists	MAS_START	active		range
+ *		DNE	MAS_START	active		set to max
+ *		exists	MAS_PAUSE	active		range
+ *		DNE	MAS_PAUSE	active		set to max
+ *		exists	MAS_NONE	active		range
+ *		exists	active		active		range
+ *		DNE	active		active		last range (max < last)
+ *
+ * Function	ENTRY	Start		Result		index & last
+ * mas_find_rev()
+ *  - at index or before
+ *			Single entry tree at 0-0
+ *			------------------------
+ *				if index >  0
+ *		exists	MAS_START	MAS_ROOT	0
+ *		exists	MAS_PAUSE	MAS_ROOT	0
+ *		exists	MAS_NONE	MAS_ROOT	0
+ *				if index ==  0
+ *		DNE	MAS_START	MAS_NONE	0
+ *		DNE	MAS_PAUSE	MAS_NONE	0
+ *		DNE	MAS_NONE	MAS_NONE	0
+ *		DNE	MAS_ROOT	MAS_NONE	0
+ *
+ *			Normal tree
+ *			-----------
+ *		exists	MAS_START	active		range
+ *		DNE	MAS_START	active		set to min
+ *		exists	MAS_PAUSE	active		range
+ *		DNE	MAS_PAUSE	active		set to min
+ *		exists	MAS_NONE	active		range
+ *		exists	active		active		range
+ *		DNE	active		active		last range (min > index)
+ *
+ * Function	ENTRY	Start		Result		index & last
+ * mas_walk()
+ * - Look up index
+ *			Single entry tree at 0-0
+ *			------------------------
+ *				if index >  0
+ *		DNE	MAS_START	MAS_ROOT	1 - oo
+ *		DNE	MAS_PAUSE	MAS_ROOT	1 - oo
+ *		DNE	MAS_NONE	MAS_ROOT	1 - oo
+ *		DNE	MAS_ROOT	MAS_ROOT	1 - oo
+ *				if index ==  0
+ *		exists	MAS_START	MAS_ROOT	0
+ *		exists	MAS_PAUSE	MAS_ROOT	0
+ *		exists	MAS_NONE	MAS_ROOT	0
+ *		exists	MAS_ROOT	MAS_ROOT	0
+ *
+ *			Normal tree
+ *			-----------
+ *		exists	MAS_START	active		range
+ *		DNE	MAS_START	active		range of NULL
+ *		exists	MAS_PAUSE	active		range
+ *		DNE	MAS_PAUSE	active		range of NULL
+ *		exists	MAS_NONE	active		range
+ *		DNE	MAS_NONE	active		range of NULL
+ *		exists	active		active		range
+ *		DNE	active		active		range of NULL
+ */
+
+#define mas_active(x)		(((x).node != MAS_ROOT) && \
+				 ((x).node != MAS_START) && \
+				 ((x).node != MAS_PAUSE) && \
+				 ((x).node != MAS_NONE))
+static noinline void __init check_state_handling(struct maple_tree *mt)
+{
+	MA_STATE(mas, mt, 0, 0);
+	void *entry, *ptr = (void *) 0x1234500;
+	void *ptr2 = &ptr;
+	void *ptr3 = &ptr2;
+
+	/* Check MAS_ROOT First */
+	mtree_store_range(mt, 0, 0, ptr, GFP_KERNEL);
+
+	mas_lock(&mas);
+	/* prev: Start -> none */
+	entry = mas_prev(&mas, 0);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.node != MAS_NONE);
+
+	/* prev: Start -> root */
+	mas_set(&mas, 10);
+	entry = mas_prev(&mas, 0);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0);
+	MT_BUG_ON(mt, mas.last != 0);
+	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+
+	/* prev: pause -> root */
+	mas_set(&mas, 10);
+	mas_pause(&mas);
+	entry = mas_prev(&mas, 0);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0);
+	MT_BUG_ON(mt, mas.last != 0);
+	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+
+	/* next: start -> none */
+	mas_set(&mas, 0);
+	entry = mas_next(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, mas.index != 1);
+	MT_BUG_ON(mt, mas.last != ULONG_MAX);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.node != MAS_NONE);
+
+	/* next: start -> none */
+	mas_set(&mas, 10);
+	entry = mas_next(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, mas.index != 1);
+	MT_BUG_ON(mt, mas.last != ULONG_MAX);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.node != MAS_NONE);
+
+	/* find: start -> root */
+	mas_set(&mas, 0);
+	entry = mas_find(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0);
+	MT_BUG_ON(mt, mas.last != 0);
+	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+
+	/* find: root -> none */
+	entry = mas_find(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 1);
+	MT_BUG_ON(mt, mas.last != ULONG_MAX);
+	MT_BUG_ON(mt, mas.node != MAS_NONE);
+
+	/* find: none -> none */
+	entry = mas_find(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 1);
+	MT_BUG_ON(mt, mas.last != ULONG_MAX);
+	MT_BUG_ON(mt, mas.node != MAS_NONE);
+
+	/* find: start -> none */
+	mas_set(&mas, 10);
+	entry = mas_find(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 1);
+	MT_BUG_ON(mt, mas.last != ULONG_MAX);
+	MT_BUG_ON(mt, mas.node != MAS_NONE);
+
+	/* find_rev: none -> root */
+	entry = mas_find_rev(&mas, 0);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0);
+	MT_BUG_ON(mt, mas.last != 0);
+	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+
+	/* find_rev: start -> root */
+	mas_set(&mas, 0);
+	entry = mas_find_rev(&mas, 0);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0);
+	MT_BUG_ON(mt, mas.last != 0);
+	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+
+	/* find_rev: root -> none */
+	entry = mas_find_rev(&mas, 0);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0);
+	MT_BUG_ON(mt, mas.last != 0);
+	MT_BUG_ON(mt, mas.node != MAS_NONE);
+
+	/* find_rev: none -> none */
+	entry = mas_find_rev(&mas, 0);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0);
+	MT_BUG_ON(mt, mas.last != 0);
+	MT_BUG_ON(mt, mas.node != MAS_NONE);
+
+	/* find_rev: start -> root */
+	mas_set(&mas, 10);
+	entry = mas_find_rev(&mas, 0);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0);
+	MT_BUG_ON(mt, mas.last != 0);
+	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+
+	/* walk: start -> none */
+	mas_set(&mas, 10);
+	entry = mas_walk(&mas);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 1);
+	MT_BUG_ON(mt, mas.last != ULONG_MAX);
+	MT_BUG_ON(mt, mas.node != MAS_NONE);
+
+	/* walk: pause -> none*/
+	mas_set(&mas, 10);
+	mas_pause(&mas);
+	entry = mas_walk(&mas);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 1);
+	MT_BUG_ON(mt, mas.last != ULONG_MAX);
+	MT_BUG_ON(mt, mas.node != MAS_NONE);
+
+	/* walk: none -> none */
+	mas.index = mas.last = 10;
+	entry = mas_walk(&mas);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 1);
+	MT_BUG_ON(mt, mas.last != ULONG_MAX);
+	MT_BUG_ON(mt, mas.node != MAS_NONE);
+
+	/* walk: none -> none */
+	entry = mas_walk(&mas);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 1);
+	MT_BUG_ON(mt, mas.last != ULONG_MAX);
+	MT_BUG_ON(mt, mas.node != MAS_NONE);
+
+	/* walk: start -> root */
+	mas_set(&mas, 0);
+	entry = mas_walk(&mas);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0);
+	MT_BUG_ON(mt, mas.last != 0);
+	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+
+	/* walk: pause -> root */
+	mas_set(&mas, 0);
+	mas_pause(&mas);
+	entry = mas_walk(&mas);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0);
+	MT_BUG_ON(mt, mas.last != 0);
+	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+
+	/* walk: none -> root */
+	mas.node = MAS_NONE;
+	entry = mas_walk(&mas);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0);
+	MT_BUG_ON(mt, mas.last != 0);
+	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+
+	/* walk: root -> root */
+	entry = mas_walk(&mas);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0);
+	MT_BUG_ON(mt, mas.last != 0);
+	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+
+	/* walk: root -> none */
+	mas_set(&mas, 10);
+	entry = mas_walk(&mas);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 1);
+	MT_BUG_ON(mt, mas.last != ULONG_MAX);
+	MT_BUG_ON(mt, mas.node != MAS_NONE);
+
+	/* walk: none -> root */
+	mas.index = mas.last = 0;
+	entry = mas_walk(&mas);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0);
+	MT_BUG_ON(mt, mas.last != 0);
+	MT_BUG_ON(mt, mas.node != MAS_ROOT);
+
+	mas_unlock(&mas);
+
+	/* Check when there is an actual node */
+	mtree_store_range(mt, 0, 0, NULL, GFP_KERNEL);
+	mtree_store_range(mt, 0x1000, 0x1500, ptr, GFP_KERNEL);
+	mtree_store_range(mt, 0x2000, 0x2500, ptr2, GFP_KERNEL);
+	mtree_store_range(mt, 0x3000, 0x3500, ptr3, GFP_KERNEL);
+
+	mas_lock(&mas);
+
+	/* next: start ->active */
+	mas_set(&mas, 0);
+	entry = mas_next(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* next: pause ->active */
+	mas_set(&mas, 0);
+	mas_pause(&mas);
+	entry = mas_next(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* next: none ->active */
+	mas.index = mas.last = 0;
+	mas.offset = 0;
+	mas.node = MAS_NONE;
+	entry = mas_next(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* next:active ->active */
+	entry = mas_next(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != ptr2);
+	MT_BUG_ON(mt, mas.index != 0x2000);
+	MT_BUG_ON(mt, mas.last != 0x2500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* next:active -> active out of range*/
+	entry = mas_next(&mas, 0x2999);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0x2501);
+	MT_BUG_ON(mt, mas.last != 0x2fff);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* Continue after out of range*/
+	entry = mas_next(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != ptr3);
+	MT_BUG_ON(mt, mas.index != 0x3000);
+	MT_BUG_ON(mt, mas.last != 0x3500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* next:active -> active out of range*/
+	entry = mas_next(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0x3501);
+	MT_BUG_ON(mt, mas.last != ULONG_MAX);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* next: none -> active, skip value at location */
+	mas_set(&mas, 0);
+	entry = mas_next(&mas, ULONG_MAX);
+	mas.node = MAS_NONE;
+	mas.offset = 0;
+	entry = mas_next(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != ptr2);
+	MT_BUG_ON(mt, mas.index != 0x2000);
+	MT_BUG_ON(mt, mas.last != 0x2500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* prev:active ->active */
+	entry = mas_prev(&mas, 0);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* prev:active -> active out of range*/
+	entry = mas_prev(&mas, 0);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0);
+	MT_BUG_ON(mt, mas.last != 0x0FFF);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* prev: pause ->active */
+	mas_set(&mas, 0x3600);
+	entry = mas_prev(&mas, 0);
+	MT_BUG_ON(mt, entry != ptr3);
+	mas_pause(&mas);
+	entry = mas_prev(&mas, 0);
+	MT_BUG_ON(mt, entry != ptr2);
+	MT_BUG_ON(mt, mas.index != 0x2000);
+	MT_BUG_ON(mt, mas.last != 0x2500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* prev:active -> active out of range*/
+	entry = mas_prev(&mas, 0x1600);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0x1501);
+	MT_BUG_ON(mt, mas.last != 0x1FFF);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* prev: active ->active, continue*/
+	entry = mas_prev(&mas, 0);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* find: start ->active */
+	mas_set(&mas, 0);
+	entry = mas_find(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* find: pause ->active */
+	mas_set(&mas, 0);
+	mas_pause(&mas);
+	entry = mas_find(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* find: start ->active on value */;
+	mas_set(&mas, 1200);
+	entry = mas_find(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* find:active ->active */
+	entry = mas_find(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != ptr2);
+	MT_BUG_ON(mt, mas.index != 0x2000);
+	MT_BUG_ON(mt, mas.last != 0x2500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+
+	/* find:active -> active (NULL)*/
+	entry = mas_find(&mas, 0x2700);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0x2501);
+	MT_BUG_ON(mt, mas.last != 0x2FFF);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* find: none ->active */
+	entry = mas_find(&mas, 0x5000);
+	MT_BUG_ON(mt, entry != ptr3);
+	MT_BUG_ON(mt, mas.index != 0x3000);
+	MT_BUG_ON(mt, mas.last != 0x3500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* find:active -> active (NULL) end*/
+	entry = mas_find(&mas, ULONG_MAX);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0x3501);
+	MT_BUG_ON(mt, mas.last != ULONG_MAX);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* find_rev: active (END) ->active */
+	entry = mas_find_rev(&mas, 0);
+	MT_BUG_ON(mt, entry != ptr3);
+	MT_BUG_ON(mt, mas.index != 0x3000);
+	MT_BUG_ON(mt, mas.last != 0x3500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* find_rev:active ->active */
+	entry = mas_find_rev(&mas, 0);
+	MT_BUG_ON(mt, entry != ptr2);
+	MT_BUG_ON(mt, mas.index != 0x2000);
+	MT_BUG_ON(mt, mas.last != 0x2500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* find_rev: pause ->active */
+	mas_pause(&mas);
+	entry = mas_find_rev(&mas, 0);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* find_rev:active -> active */
+	entry = mas_find_rev(&mas, 0);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0);
+	MT_BUG_ON(mt, mas.last != 0x0FFF);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* find_rev: start ->active */
+	mas_set(&mas, 0x1200);
+	entry = mas_find_rev(&mas, 0);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* mas_walk start ->active */
+	mas_set(&mas, 0x1200);
+	entry = mas_walk(&mas);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* mas_walk start ->active */
+	mas_set(&mas, 0x1600);
+	entry = mas_walk(&mas);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0x1501);
+	MT_BUG_ON(mt, mas.last != 0x1fff);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* mas_walk pause ->active */
+	mas_set(&mas, 0x1200);
+	mas_pause(&mas);
+	entry = mas_walk(&mas);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* mas_walk pause -> active */
+	mas_set(&mas, 0x1600);
+	mas_pause(&mas);
+	entry = mas_walk(&mas);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0x1501);
+	MT_BUG_ON(mt, mas.last != 0x1fff);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* mas_walk none -> active */
+	mas_set(&mas, 0x1200);
+	mas.node = MAS_NONE;
+	entry = mas_walk(&mas);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* mas_walk none -> active */
+	mas_set(&mas, 0x1600);
+	mas.node = MAS_NONE;
+	entry = mas_walk(&mas);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0x1501);
+	MT_BUG_ON(mt, mas.last != 0x1fff);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* mas_walk active -> active */
+	mas.index = 0x1200;
+	mas.last = 0x1200;
+	mas.offset = 0;
+	entry = mas_walk(&mas);
+	MT_BUG_ON(mt, entry != ptr);
+	MT_BUG_ON(mt, mas.index != 0x1000);
+	MT_BUG_ON(mt, mas.last != 0x1500);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	/* mas_walk active -> active */
+	mas.index = 0x1600;
+	mas.last = 0x1600;
+	entry = mas_walk(&mas);
+	MT_BUG_ON(mt, entry != NULL);
+	MT_BUG_ON(mt, mas.index != 0x1501);
+	MT_BUG_ON(mt, mas.last != 0x1fff);
+	MT_BUG_ON(mt, !mas_active(mas));
+
+	mas_unlock(&mas);
+}
+
 static DEFINE_MTREE(tree);
 static int __init maple_tree_seed(void)
 {
@@ -3011,6 +3635,10 @@ static int __init maple_tree_seed(void)
 	mtree_destroy(&tree);
 
 
+	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
+	check_state_handling(&tree);
+	mtree_destroy(&tree);
+
 #if defined(BENCH)
 skip:
 #endif
-- 
2.39.2

