Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A2E6F89ED
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 21:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjEET7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 15:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjEET7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 15:59:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B601B4
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 12:59:28 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345HhDlx005916;
        Fri, 5 May 2023 17:45:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Hn/nYxar4IbaGMbj+8NY36CmuEVAYXoKwA+YmgSPKBY=;
 b=FIZk3YcI8kszIVwhxxHtUjb2aN4UudYyZ1xYhAST25N5cwIhyIVdglor31xtexENAj7g
 eavAy62BBF/CNXhN3UMag0O4ER2Ob2BkoR4FoUN/6vyE2XWTg11Th+9DhorrteRO+D/6
 kz8LpNzzcwQ1rkWeFLKDI+yawW3kM10IjWhUebpD+adJYUqwFhezRA+OXdaOIxHKKFEz
 Q0iuGWgM3/Fap/GXrxnCyhuHZiHHjDPubC24A7wKn2KBQ8zWsiXNrcH4KUMUCnCoYWOx
 76kz4zIREELYUpvVdkQmzh7p5brtjPS/NpNqgIdzLxHPMiaresMEIC2buOfrkX8YKvSo Xg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8u4awa0u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:45:03 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345GWSfs020775;
        Fri, 5 May 2023 17:45:02 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spa5fve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 17:45:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZvOeC/n6kdWBA15jDJY0PEk+RKglmgZhDwqwVsevl+V4/Su3lUyRTJscDg7z/UNNWJStKvcEWHos+eRscB/IoBC58Bm45yE7UStSSSsnRfv4mRwiVignHE/WgUOA9NWKrfRA0Lfm2VaQ5sHUbBImRbPVX0gFNsPVHErgHLmEmJwYa771jNQ71x0veR9CdA1uGUqjhYk5BR3imXxx817CNYd2kd5GS63jYmWI2AqCUDZ5FqL30mAyzLQq6mcCunXvVnR4k/fi6NRdSn/AtRpS+7FJyFGRfYzyqOzqcDrPCL9cK2E1Vij4KI9c+8OAGA6wskfQxlSLQEx1RMnMR3C9eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hn/nYxar4IbaGMbj+8NY36CmuEVAYXoKwA+YmgSPKBY=;
 b=cJEKos4OVTk8mLrCCHI01qmHPGSu0YreLaGuwX53Dzo7KPCcPxEo2/G5Gtj4uQCsxbES+MLIHW8A7zVMfiqjmuCrKDMQOTrtfguVmKZJVV31KlU4ZDnuk5Rlk0oAIWj7hK9c+vyuN2lZKBtk+5QUxh4Us0a28ay8YrDc1gDq7dgRl7c+eLQT1y6dzTxsD4h+UnrdiMdaPQLDv8f38R3eE64vT0a5d8FWqPaKKAWx3nHHxdxSpgJPckpDkS/iNsKIV2IWBUS2gS8344JJFY1i5sM3VRHAC9kYqmnMeZG5bPsaT1SB7Oeq/30CmneMLFRVtTM5lgAIt6AJi9YDWzcfGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hn/nYxar4IbaGMbj+8NY36CmuEVAYXoKwA+YmgSPKBY=;
 b=OGrvmqdjsCGFaIMFS6RFEBroNr4usdhRTW4HQSXrl5m+4TOCewila9hk4aXdO46YgHyWC8B9kraL3razBel/AzWro1z56vg/9k7Z8LTVrH6egXbCc7ofQ195zIFo2Rk/4k5ryuTTg7fh2AIEHDgZ2eMt6ksKlXZ+IfTeDil8B60=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS0PR10MB6895.namprd10.prod.outlook.com (2603:10b6:8:134::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.27; Fri, 5 May
 2023 17:44:59 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6363.022; Fri, 5 May 2023
 17:44:59 +0000
From:   "Liam R. Howlett" <Liam.Howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v2 33/36] maple_tree: Update testing code for mas_{next,prev,walk}
Date:   Fri,  5 May 2023 13:42:01 -0400
Message-Id: <20230505174204.2665599-34-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
References: <20230505174204.2665599-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1P288CA0017.CANP288.PROD.OUTLOOK.COM (2603:10b6:b01::30)
 To SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS0PR10MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b0d458e-83e3-4b2f-88c3-08db4d90729a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IuRMSR0OXhz8RrvBq2oiGflK9f/xd0qDnZCdu+dBgXEsD6Uzv6bHO13q83vV54zcgpSubqqJviBIsbRcc8qLp3Bl6gfRQMImGX6VIeGPEAwRrxXXGpJhy3Hm1pWgDlIcf9JWK6fr3fFBSCdOoGuRolz4XA4oWQu3C32RmlevCCzj3XFPmE0zXxXu0+qoxLh05K5B/y7yfw6+qzVj66fFPXA2tDmuAXSLeg8xaV0CGqny4wB7xt5kxwTACKohrno2QQs8n4BIMqPlRR5z+L2xBJXsMdS+Tfv+lqzw1ZO8wwSbk8m9EUPc2Rd53NiThsUJD4ij2brYZKtFm5q87xCyEzNBLGHtuGzQX2wx++PonG9xu5c2b+VvgsgguYjtamANhN7c8yntUwB8Lg7xKyuhuZOjjLH+JaZqCK/jZ2j+ULD6zhPkWka5sKtXPSVv4oFeSdvPUFEy56Ya3dKIDf5EUURqFeUmanZ0Pl0lgzE++1ZFgPuxavbaiLxBHWUaCY5/KnOkwLgua3GjB2miRFH6uDCK/S9ppnLM0HZdhQ3S3VxyKn7vpET9BCyzaBjnhq2g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(4326008)(6916009)(66946007)(66476007)(66556008)(41300700001)(8936002)(5660300002)(8676002)(6512007)(26005)(6506007)(15650500001)(1076003)(316002)(478600001)(6666004)(6486002)(107886003)(2906002)(30864003)(186003)(2616005)(83380400001)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1N5ZllqeGRHWUc4dnVOMjI3cmsxRkdIN3NtMTRrYUVEajRrQ0hGM1phZFRX?=
 =?utf-8?B?dVpSQzFrSnBYYWJXeFdTa1huQzExd0hFTERzQ3Z2VzdybEFJL0FkTjVlbGxI?=
 =?utf-8?B?TWNlT09BbXNRMmpaNE9Hcjc1dW1KSUgyWjVzbmtGemE0cEpsSjZySlppeXdx?=
 =?utf-8?B?a0JZbFlTNSsxN2dCVjNqVC9zYzRqRDYyVlZRRzN1MlZocDREb3JtWi9zREtp?=
 =?utf-8?B?S0tsNTJjNlJ3TytieU9qOTJmT2FpYjZRVHF1YmhvMkg5UmFGbS9yOG95TFJM?=
 =?utf-8?B?ZTQyN29weGNOMXZ2R3RNbXBqUU1SMTFibmZpemRyaXJtTWR4Q2RIOWJBU3Zy?=
 =?utf-8?B?TFNaSG01L0J4emhmNGZMN3l3MEYrZDE2YThiOXN3VmFnRUlKeXNzdkxLZmNE?=
 =?utf-8?B?MVM4Q1U0VnJKWGxYS1drR0dKaitDRUhRQ211Vkdkako4Tm1YV3VaRE5vcVdv?=
 =?utf-8?B?RVJFQXFVcDRtaVV6M0EwT1p3ZnFkcE5iT1ZyWjEwdkgzSkR5YU8vVlpJQW9D?=
 =?utf-8?B?TTBrK3JKWVluNTVLN2MxOHR6WDRtaHQ0bkdQeVFGUHhwMG5VTjNXbHVQNk1q?=
 =?utf-8?B?YWhiUm1ERERDcm1nZS92eUNldWhrSlhocCtCYnN6ZTBNa2FTMVhWallRLzVw?=
 =?utf-8?B?RGZNa2Uzb2R2Q3F3c3RGRzB1VEhlT28waS9uRTM0bXcwUWJtbk9HV1QvOEh5?=
 =?utf-8?B?MXpPbEtrZVlQR0N5RjZFNERrSGNwZWNNOFNVdk9zakZlTk9mbmNWQUQ4SWov?=
 =?utf-8?B?SVA3MWFQeU5ZQjhQeExpQ1hMeml4YUdZeEplRDBUa2ZwWlhkcDUwbnlEOVlu?=
 =?utf-8?B?MTgycVh5dEU0YUxtK3ZkemRJbHY0T1E3QzNYQ2tRMDRhclZLV3NGWGJ3c1N3?=
 =?utf-8?B?RHpsOSt2bnN0eW1mVmZ3V0NRck1NT2tESE1ZVUpEeWtqRmZ3aGtkV1M0SjNY?=
 =?utf-8?B?cmI1NzZLeW55ZXY3WjFRM3Nka2ZUeHpkSjhGVFJMc3doTVA3OW5rVXBoZUpF?=
 =?utf-8?B?RGhsWmZOclRJdHM0TS8yK0I3NkM5MExpT2lUZDVEcmVRODFjSDZHaUU2aUw1?=
 =?utf-8?B?UCtGOVhQVkkvMEs4Q2c4V2hKTHdJa01tb21PcUpUclNpODVuWUZ4cURGWTBw?=
 =?utf-8?B?UTN2R25peVd5SXNUMFgzMHJIZXNYSzIyVjFjdlF3YTg2Q0lkNTBNTHJROEhJ?=
 =?utf-8?B?a1VQaGptWFAzMi8wYVBhNTNVM1ZPb0JYUnlOVGIvcFRrY0F5VzdVb1dZNElW?=
 =?utf-8?B?dkI3bHMvWWVOSTVVL05GQWpNcVpsZ3ZYSEpaU2ZPZTgrMXNqMkV5aS9YZWs2?=
 =?utf-8?B?dWQ1YTJXT1FCdXg2b2Z1M0t0eXJOMHFKTnJUdTVqczZyMmlPQXdJUVpSOUli?=
 =?utf-8?B?eGlhK1FBcVhzUFdKcGVDUlgvcnBjbTlZb2RTd2FDcDFLZ3FBN2FnbFA4a09R?=
 =?utf-8?B?M1BHMFRSVHZhOTNaRjJDUTN1MjUwVjcramJORmNzaTd2dWVWSkFPVk9ITFJ3?=
 =?utf-8?B?WnVRUFN4ODk2U1NyUWwxbkpNb3VHemhUVkdYdlgyR1hCK051NzA0QjdqWXEy?=
 =?utf-8?B?VTFvcWtEQTFXb3NPSW02Y25NbkJLNmQwbnpyeTN5Q1VyN2tkSU1WZGVlZG93?=
 =?utf-8?B?NTVXYmoybDlwdzBDTDJXZFdlMlVWZDgvVXpoNmlSckVua1Z1Y2VrK1hpRVlH?=
 =?utf-8?B?alpqR3lZcU5KK1pnbDIzcnR0UzJ2b2kvdkpzMGFnUWUxNWluVVZFUjJBWUgr?=
 =?utf-8?B?alBUbGFjQ3k0TndFNWg2QmI5SFZRbmNqZ3lHbGpERkFiS1pUdVVXZ3Zwanhv?=
 =?utf-8?B?OHpKWGpHd1N2Q3o4YjFQNUtjREdXamlIS2xrLzR4ZEpqRjFSYUZ1OEVTc3Zx?=
 =?utf-8?B?TDcvL0pubysva0wxYWpGdEgyWFo4bVF2czZ1RkZxdEVMeDFBczVVYVNHWUMv?=
 =?utf-8?B?dGcvV1pxRUxrYTlWSWZyaTRRQ0hwQXowamFZcjIzL3NSWXdERXFLRDNRTzhD?=
 =?utf-8?B?N2NEUnU5Sk4zK0w1c2RjdXZuSXVmN1JDeVo3V3I4Nkl3SUh4by9nWXNEU1VT?=
 =?utf-8?B?blo0YzRvRTZ2RUgxTXBtd21RWW5xNXlObnJLMnhXT3dPb2JSN2syYlRDZWVy?=
 =?utf-8?B?cldmeTNXYmx6UUIvTFFTSUR2dCt0Mm9EWkRFM1lCWXdXcHVZeGpYbzMwaHFq?=
 =?utf-8?B?V2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hO2miMZ7U9apwHGfcPX8SRzZ9Gd46SY6ZJty/eTDa9S+N+fzpAHvqPVByIY34zAGL3mbDwZlr/Dckm9whHEgXkDo714FFqMdDTcPQfn2nPDgurdCDOZTgvl3XQWo5YZ0PPyzKNeBwYkn9AkrUqgLo9e+/5vHEfFLxLlnlwgNrs9WMYXb7XjS9acoKRJJ34+QL95KQg+U7zXnPmHsgNSikpPMWnb9dbY7uh6ESRNdZgB2KldvdTRoRO2oRRUQoYrh1ZPZNxAjh0rouFJVjF145IcgAkxJojhcb8lWTtzCoUgr/9Q6czBiHz5IzWcpKY4pDPICKfy8wYxknqmxKlmO5/DkomB5wH70Ec/WA8xyQP0+RU1WUQ4JLpX4O3LxE0IkuPt1X12vcjjf//VL5JPhon2rT5/Llx3lbz7fdyJ3bBau3pENp1FGetb/206fID+84SuJnAUfyZky99s//1B2UPmvXy0rNJhf1M0xaLL2Oh9MnFMn+/djubtULfC7Aj9yodbFJoakyaKOx/tqo7IXhVaSTWtbLJSPLJCOpbi1CmyoBJnTZVN7WhG0qfnHZrj3OYy0uE6xP9JC9qi+crTSnPpAIxhCAqf0LuEEsLEE5/9tGyW+5ca6k7pxS+ouHJKOCA9g6BhPVlGu8gmvNavmS2uwgKa1e16NMn0aiGsQv6xaBiYKgG42FqxW5VmQGRsNGTYdJ/ciNxcvrFqJwA3hcBP5B4x5/yS6hS74j2IQJHZKwf9Ayvcj8CW4q/5IN0+tqGksZhGuW04aDucDn3FJycHEQZaKx2R27JhlNYRbA6hKDu8kxq2lq52/YHistTKYb2yQZS8iDvhhR5oPpTzKR3xcLos9WKOftEAvVqQo/0ysTvsGtxHHia6eo1WZk0csG3XZt+cxLZ2JShEdfogw6A==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b0d458e-83e3-4b2f-88c3-08db4d90729a
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 17:44:59.8204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3engNdS7npSA2LJY9nDPZAJ/I81xM6K+Khxv842ovWcWtuofWlJqsjb5IowAlRmRLmpuWsMH/dV5ZTOW2G9GGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_24,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050146
X-Proofpoint-GUID: w2KiPniuZ02oUGLGtcYhsRB9Z_swudA4
X-Proofpoint-ORIG-GUID: w2KiPniuZ02oUGLGtcYhsRB9Z_swudA4
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 48bc4ad984c86..aa3c4fb9175ed 100644
--- a/lib/test_maple_tree.c
+++ b/lib/test_maple_tree.c
@@ -1321,6 +1321,7 @@ static noinline void __init check_root_expand(struct maple_tree *mt)
 	mas_lock(&mas);
 	mas_set(&mas, 3);
 	ptr = mas_walk(&mas);
+	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, ptr != NULL);
 	MT_BUG_ON(mt, mas.index != 0);
 	MT_BUG_ON(mt, mas.last != ULONG_MAX);
@@ -1390,7 +1391,7 @@ static noinline void __init check_root_expand(struct maple_tree *mt)
 	mas_store_gfp(&mas, ptr, GFP_KERNEL);
 	ptr = mas_next(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, ptr != NULL);
-	MT_BUG_ON(mt, (mas.index != 1) && (mas.last != ULONG_MAX));
+	MT_BUG_ON(mt, (mas.index != ULONG_MAX) && (mas.last != ULONG_MAX));
 
 	mas_set(&mas, 1);
 	ptr = mas_prev(&mas, 0);
@@ -1799,7 +1800,6 @@ static noinline void __init check_iteration(struct maple_tree *mt)
 			mas.index = 760;
 			mas.last = 765;
 			mas_store(&mas, val);
-			mas_next(&mas, ULONG_MAX);
 		}
 		i++;
 	}
@@ -2010,7 +2010,7 @@ static noinline void __init next_prev_test(struct maple_tree *mt)
 
 	val = mas_next(&mas, ULONG_MAX);
 	MT_BUG_ON(mt, val != NULL);
-	MT_BUG_ON(mt, mas.index != ULONG_MAX);
+	MT_BUG_ON(mt, mas.index != 0x7d6);
 	MT_BUG_ON(mt, mas.last != ULONG_MAX);
 
 	val = mas_prev(&mas, 0);
@@ -2034,7 +2034,8 @@ static noinline void __init next_prev_test(struct maple_tree *mt)
 	val = mas_prev(&mas, 0);
 	MT_BUG_ON(mt, val != NULL);
 	MT_BUG_ON(mt, mas.index != 0);
-	MT_BUG_ON(mt, mas.last != 0);
+	MT_BUG_ON(mt, mas.last != 5);
+	MT_BUG_ON(mt, mas.node != MAS_NONE);
 
 	mas.index = 0;
 	mas.last = 5;
@@ -2046,7 +2047,7 @@ static noinline void __init next_prev_test(struct maple_tree *mt)
 	val = mas_prev(&mas, 0);
 	MT_BUG_ON(mt, val != NULL);
 	MT_BUG_ON(mt, mas.index != 0);
-	MT_BUG_ON(mt, mas.last != 0);
+	MT_BUG_ON(mt, mas.last != 9);
 	mas_unlock(&mas);
 
 	mtree_destroy(mt);
@@ -2749,6 +2750,629 @@ static noinline void __init check_empty_area_fill(struct maple_tree *mt)
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
@@ -3010,6 +3634,10 @@ static int __init maple_tree_seed(void)
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

