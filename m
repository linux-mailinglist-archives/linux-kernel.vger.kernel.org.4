Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC01E73FCBF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 15:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjF0NXE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 09:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjF0NWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 09:22:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F044810FC;
        Tue, 27 Jun 2023 06:22:37 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35RDBh8S030826;
        Tue, 27 Jun 2023 13:21:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-03-30;
 bh=ZRtoZJjCHS6795vahpZRjPH8xqpkl7eJhQWDakJQ/OE=;
 b=EKiLqyrRFm0N0BWlwq5KmFusNL3lIiz9EGCQHThgQidR8MppbKDNQArW3Hzt2mA3/5+7
 MUDDP3OwJlDRdR55gtI+Mtfbw6P8eU6NWlXgrJo0Rt2S1Um+RYHlx3GtZW1t2FZDKgjb
 C2sBHndPmtb3ycisdSkJ7Zddf6f6AJM+UxbYFdhAnXVytmBXTui+5DpmYSdItllM6GYt
 uEwj2DolUTtVNrBdB+Iw8hTmXY3YAY6c8twYIckujKFY8oQRTcS+7yrCoua9rBe849Ns
 rrOaqK5XdUVUSWZSL1y5E2uGU5aoEM/yZcgsv5jnBDP4cclTnAD30jTgiDBu1Q3RtdXD Gw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdq934xay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jun 2023 13:21:48 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35RBtFaM020111;
        Tue, 27 Jun 2023 13:21:48 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxa8pd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jun 2023 13:21:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ByKaN90sUwaAcpyenbow5L6x4vZydQMEF6g7kkkT9S95NdNhRz7KAQ1orvocWqVq5DZtuvMQ2SkBXKXTpElFExveDCcxzjBXaEiMFw2iQ1nRZExQHDMYosiCEwHLf/orp6lV1q0UmmTxfHArNlGbFmhB7BVu1d1rW5/aX/y0JlAarkuDwiVD9L6axVMdjW8rL02yIPQALnnh9hgYZOkuqEq6uWezO+qV5FOzkxlWiFbE2NmeQg+sUkgDtMok+SMS25e8EkqwCxC3I04rNBxcx32wQXrYiZ7Zak4imUoxPZltcFSqHpe/7F5bCUGcNBu2FnjM2FL+MDzjWtDWVyu0Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRtoZJjCHS6795vahpZRjPH8xqpkl7eJhQWDakJQ/OE=;
 b=gqxar6aOqCgu/ZPwZ+c0UGpOX38dZTLf9gHC5qxxkkBRrHojQewTEWh2RK7DUHHxzR4bpXV94kuPEnaFjSLTgOMR5a3C/J05s9wApNOLMkDqT1TR73hwyWCintEtCzXB4HJMf+A1/On59QhqXtIup01HkEJIhAU2KTD4IHAo1gPZPnYZG7Z3MBD0yIYBvmEi25/INvuo/HlfrxeEyTZ1rgmQYBXSq0LPoZW9K4A/0lZXAOjRLsBzTpGtUlR/tfeUI4BQdhBszq6uMD/QYe/aBJCWPf1m5TMoTkmY1N1yRMqMq6CesF99SF/zBClyKY5771kD8BluXkjQzXTTa2JXvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRtoZJjCHS6795vahpZRjPH8xqpkl7eJhQWDakJQ/OE=;
 b=lfKh71AJ0ZJIy1C///mhPn5m4F3sreIdqdeL1hwSEKwK2fWAErJd/qhoW2WcaFgoWIvu25C+O+JWi5Dspb+2yZxdVLzfbruMWP7a7CAa6zjFcYbowKPj9S4BtzOOxADST6RyN71aqV5PRwCZjIG8YxBTmzAcqkjOfa0rAEEpBF0=
Received: from DM5PR1001MB2153.namprd10.prod.outlook.com (2603:10b6:4:2c::27)
 by MW6PR10MB7552.namprd10.prod.outlook.com (2603:10b6:303:23f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 27 Jun
 2023 13:21:45 +0000
Received: from DM5PR1001MB2153.namprd10.prod.outlook.com
 ([fe80::519a:c7a8:90cf:81]) by DM5PR1001MB2153.namprd10.prod.outlook.com
 ([fe80::519a:c7a8:90cf:81%4]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 13:21:44 +0000
From:   Julian Pidancet <julian.pidancet@oracle.com>
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Rafael Aquini <aquini@redhat.com>,
        Julian Pidancet <julian.pidancet@oracle.com>
Subject: [PATCH] mm/slub: disable slab merging in the default configuration
Date:   Tue, 27 Jun 2023 15:21:31 +0200
Message-Id: <20230627132131.214475-1-julian.pidancet@oracle.com>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0060.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::24) To DM5PR1001MB2153.namprd10.prod.outlook.com
 (2603:10b6:4:2c::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2153:EE_|MW6PR10MB7552:EE_
X-MS-Office365-Filtering-Correlation-Id: beb30e1a-066e-456f-f361-08db771173cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fXNqc3g9LE99ZkaTbGk3EjFqMNdXlnQHdeKthy+1TsOR3DlHc2W3FRt/Bz3L0/goMSEXGi/kLP0VX603BHRF4YEUqOwRtW64xlF/aYwPV/kaN9Ez+dhZ8sFgvw9ZfqTzRRPHY7pq+4FFK6yfRhjnpSO9+Vz72ekiNDXQrxK7tKONbr57i/bSZWFIWwmLyp+N2yFcbDTmaY4ZcgGkQORj2dincuz3iluhWpDBNhsVtKhrU7aHehHcU3Pb/G0F5P0SZfikI30fXza5NtmtZvSdjPaobRRnBcvQVZnL5ejuEFdf/0pUJiKAmv9pHDJTlt3VhrNRPYRol3BNokFwQJbW42aahtobnEL2M+KlK2Sog0gKXyN9YAEubVJ1bT+B9Ejc1dkYAj4F6kNG83e/FQEO3JXIO4iTSEphGvPs4I0W1lE//earx7+GbD1CXsMN4eD/iNetV52p5uM/8up7jZ0qdye3CZO4bFmFr6jBTi0iXwNqENvWoz5H5czu2NTvegzgb1fUAABsVwMvXpGXIUfJoDzCiuPHkptMMCTbq8KnlGyY3jwDKra7Rfm0XFmIi7c6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1001MB2153.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(366004)(39860400002)(396003)(346002)(451199021)(83380400001)(110136005)(54906003)(478600001)(6486002)(6666004)(1076003)(2906002)(6512007)(66556008)(66946007)(107886003)(186003)(66476007)(6506007)(316002)(7416002)(44832011)(41300700001)(38100700002)(8676002)(5660300002)(8936002)(36756003)(4326008)(86362001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmpTQS9nWHcvSWJwRU0ybDVmd3JJcnlaSEtSZjBkTERJaFE5aEZHNmk1bGk3?=
 =?utf-8?B?d0VYelVQZjFkM293ZVpHb2FYVmZpZzdiSk54OU00Z1UzRGppYks1eUMwakRC?=
 =?utf-8?B?QjVXbmxHVC9iZkRPUXVnSFlLQnphMjFWRmxhV2U1R3VqdmJsWFozMXV5Zi9u?=
 =?utf-8?B?aWtmeUMwaTJ2SlM1WjdZR1RYQkltQTVNbjBLWUg5MklNOUp2Qk5FZnBJTDRw?=
 =?utf-8?B?REphbEZNdldlSGg3VUVtdmY4dzJEVlZnblg3UXk4YkRIVmd6Z2FsUmxPN0N2?=
 =?utf-8?B?cFhNUEUzclBia0tBeGduZXlqUEh0Zit2Sm1FSFc4U3paZWhNeklRK1dWaWV1?=
 =?utf-8?B?Mld5TmFSREdKWkUwaldSTjYvMHRHaHBzL3ZpczRIbU9DYVZVT0xnQWIrWUov?=
 =?utf-8?B?QWNINGZ3blB4KzkwdmIyWWo1MU1pdDBwT2xZWm1hRzJaNHppcy90dEh5bUZV?=
 =?utf-8?B?VVB0czRPdHRUWE14d3VuRzhQUEVhWG5sUGg1aWRRYXdkMU1lR1N6dFZaZ243?=
 =?utf-8?B?eGp6Y082aWVDWEJzejNMQ3BNOFk0UnIwdzE3L2JYanFUUGpOOFJWTW5xRi9Z?=
 =?utf-8?B?UnVhRjl1cTQ1QXExSjJGaFBJMTZrMkdQL01BUjdsbFk4RkROSFpkeEdpdlRo?=
 =?utf-8?B?RXM0WFdWeElHZEpkNGZPdVFpUE56ODRtOGlydWtlNkUwanRCa0xoY01zeCtG?=
 =?utf-8?B?QWdJd0ZwU1pWbjVkL1JuMFlWdDFyd3dxRG1KQW8xTFcwdkx4czhLVXd2eXdr?=
 =?utf-8?B?SXVpSlk3UENIK1dXSjR0VHhIaVd0ZmRJbWQ2SVU5eFZ6RHVjdjhNamk4Mkp1?=
 =?utf-8?B?NTBOcFpsRDA1bW1qMnd0WkRSOGxwMWZUWmpnVm1GUWhtelRoaTA2bVFrZFlF?=
 =?utf-8?B?eU1YNFlrdzNYaUQ2aVdML2xHY3JxK2Z2WGNmZktteitlcllza3pZUVl6ZHRP?=
 =?utf-8?B?VFo0L1NyQ0EwSGw4SGhiL3lNQS9sbncwM0ZYclBweVV5ZWtzaGVRN0lqUGxB?=
 =?utf-8?B?Vzl0UkZtUG1zT3k5K0hZSkdjeExHb0R1OHMwcE1rak16WXBPbk82OVRJWVBV?=
 =?utf-8?B?WndBZ1ZUMUtLb2grSHBvWGo3TzdGNFp6ZXBVWEpDb25ZT2hodUxzb0U3Q3lD?=
 =?utf-8?B?dHJFYWJxaHR3eWNJY0w0bzl5ZXlscGt0WWFqUTYwdTZtV0Y5bjhDM2ZhSmgy?=
 =?utf-8?B?anZENG1SbS9PNENSd3BtOFZJWjNTdDdlV2F1QW1zZmFJb3h4OFZHeWlVeWhl?=
 =?utf-8?B?Wm1GamF0OC9NMVIyTDFrRWw4d2pGM2RYMGdrU2U5QlExMHNqVy8wWGpMbUs5?=
 =?utf-8?B?TnR1dmVHRnRpdXAxYk5QblVHY1lWV0MxaUZ4dmtYL3ZaRlBvaVdId2Vqb1d5?=
 =?utf-8?B?NlZJdDJxZE5vdWR1aU5lLzdxUzNWeTkwUGZicEN4bkZmUmc2ODlpM29mU2Zu?=
 =?utf-8?B?T2lHVTloK091ZFZSdjdheGFoYlBRSkZNc2pwS2UyWlZ2NmpsZHpxVk9GMDgv?=
 =?utf-8?B?MElxQjNFOTJnQVVUaEowVUxVeTJQNkFaUGY5NmFIaWlSd0dnUmpRdlhwVHBW?=
 =?utf-8?B?VEdCbGsyZ1hmREVPNEtZQ2dQeGwyZXJ4akR2OUxtMGRXTXk0QzZneWk2QnFJ?=
 =?utf-8?B?MHFRSCswRFQ3RnhTTXJCL3d5ek1SUHBibFAxSEFoVXZYMTNnMTVXNFprMjhT?=
 =?utf-8?B?Q1Bva3JjU0R6a3B0THJKNUZqbnRTVWxPR1c3QXV6SEUvT2RzK2xsUDJIbHdT?=
 =?utf-8?B?ZFZ0UG5EOXFYQ0tQcHVGSXdHY09FbEIrRjlFMFBLR3hOWUJvSHd6YXVWUitB?=
 =?utf-8?B?aVppbW5lcE05bGd0dXB2V3B2dzVUWjh2N3BaVEZrT1RVeW5vTkV4dkFXNlRN?=
 =?utf-8?B?eGxZTUpLWjYxL1JYNHJ6QVdoR09paVFnU3ovOStiUVVmdUJvamgwM3JTamx6?=
 =?utf-8?B?cENoTFI3LzloUHZESytLbEVIU3BqRW1IdHpRb1hEakVGSjY3cUxuUXNSRmhy?=
 =?utf-8?B?akJob1BCVExvT0huTTRGdDJaUzVhaEJDbnA5czRsei9LOGl0Q05mQ0hCVVdT?=
 =?utf-8?B?b2FVYlBTeE9KbktXRjgxd2hzaE1xRGQrbWlKeHgzU0tOaC9yRVcxRktwdWFE?=
 =?utf-8?B?TERFOFVHeGVrZG94ZitWWnBjOGsrRmdJdmN0NHd3WDNUZEJvdURLL2NxK0dP?=
 =?utf-8?Q?MDCXhmC1LWF9vPXpBT9foWQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VktWNEp5TDBOVHdsakhneXdjcXJpcjFqbkV0d2hMK24vOTUyeW56Rit5dXV6?=
 =?utf-8?B?RGRzMDYwUEJOb210emZOYkQxL0pOY2lWRGIvbjRqNW5vNnZXNy9lU3N1LzBJ?=
 =?utf-8?B?bTFndXV4eXdNR2drMVM1VHFoNnJRU0FOdHErOFZkcmdjc1pxRlpRNGMrRkhn?=
 =?utf-8?B?aFYxSGpiaWc5VTBPR0xPNk9uT3orTGo5OGFwbmwxWDhTaUpWaUdEREREM3Fl?=
 =?utf-8?B?N3RnZ0xZQVAwSDhhVEZxU1dpc3RrLzhKOXFCWVc1bnJSYXJEc2F4VWo5Ym5F?=
 =?utf-8?B?WVJEQUppdWRuaWQwbFVzanU4UVU0U0ZzTXdSZjZ2bnl6bmtEczhhYThOQWZT?=
 =?utf-8?B?YnNwcWJLdUF6Uk1BWmd4UWlYVVQ5b0tqbkZLaFp6TVRGWWxsSU00YmVjSktF?=
 =?utf-8?B?YURubG10bk1IR25LS0xYZDEyenVFdGRzZnM3cEhTVFVJc25nbmphZzJiaTlp?=
 =?utf-8?B?aVQ0eTB0ek5EQjRxbjFxNDN3RGh4V3h2T0M3Vk14bVBqSnEzMHZnck9CZUx0?=
 =?utf-8?B?cXZ4UDZPeHB4Z25FQlplVlZjb3pIYlQwT0NTUlNoM0dYTUM4MTJsYjBsdFJS?=
 =?utf-8?B?TkUvYVZDKzVEK3crazByMW9MZit2OE5FcmtjcGFxNk5tVHNUTHFHYXpHT2xp?=
 =?utf-8?B?eUtpQnE1TjRqMDhsNDRDUGs2RlhHaXVidDI1UXlHTllVY3V6WDkrSU1TRWEv?=
 =?utf-8?B?U01mVGtFczVLRnhlTWlnR2U5NGxIL2Fpa25GTXh2M2xKTFc1V1JWcHgrcU0y?=
 =?utf-8?B?ZDd3OGZjcE5iSU96Y0I0UVE2dG4yYmg5bjZXMzJjOFFFbmNBWmJQVXIwaVpI?=
 =?utf-8?B?VEJCRWdwaVRiWFB1Rzdsa3VTd2ExZmJMdlM1SG1yQlFEMk1kc1ZHVG9QdUEw?=
 =?utf-8?B?dlhmM3JsaHozL25EZnZoV2x4aDd2VGlHRVIvVHdBS01zbUlCKzUxWG84cmQr?=
 =?utf-8?B?T1BlRGtvVFIyVDdUY0ZMa1h3a0xiRXVmU0RtTzFMQnBDODBLem8vTmUwbWpv?=
 =?utf-8?B?b3RoMWEraHg1T0Q5RWFmQjkvNWUyK2NZVXpOSTlUekF2aWMwTTYraWwybmNT?=
 =?utf-8?B?a256NVZOTWpYRUhyZlFQUlBFVFVGLzZjRExZS2s1WEErS29oMldCYmhpc25M?=
 =?utf-8?B?NEc3MmJXVW9zb1JFdlFkZDRZNWZqM3AwZDlMSjZpb0poMnYwallmMmpTUHJ6?=
 =?utf-8?B?S2RGL2dBR05mV1hWM2N6d2pVWjBtSktUSlFxNUNCemw5YytxSlg3bDV2WU4y?=
 =?utf-8?B?ZmhsbkorUzhaeUlPb3NkUFR2UUhHeWlqSmdCc0JVZWI0a0tSNGtIZHlDY1FM?=
 =?utf-8?B?Y2JZelQvVzF6TGdQT2RoeHJoejJkUG9TL2RmUEVaQjY1UkthS3RSbWZkRmMz?=
 =?utf-8?B?OE4yZFNQMG91bUQ5K2xhMWVXYWNiVzhDOWhvWGxVU3F1THAxODB5eC9zR01O?=
 =?utf-8?B?ZHZBT05aOWhOMm5HNWxsZVJ5VFZqVlJnSjVGM3A4ODBTNEJYV3Q2UXNURFlv?=
 =?utf-8?B?STU3bnFaT1gxN3VZWjZVYW8rRkFoNWtmK0ozODNaSEl2T2tveW9SSkplczZO?=
 =?utf-8?B?MFh2QT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: beb30e1a-066e-456f-f361-08db771173cd
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1001MB2153.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 13:21:44.8449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uzgD6SLhdP71WzsOiffU07gN7k+rbnPnJZ3sF9ak6eA+OwOptROHNQTBQVeAWI1fQpDlzybGDsGF5WzDP2E7DP3nkN6sX3FlKBM+60WM/gs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7552
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_09,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306270124
X-Proofpoint-ORIG-GUID: ZjnY10BdDKAvexO7TeMvEBIR3FaEJSpg
X-Proofpoint-GUID: ZjnY10BdDKAvexO7TeMvEBIR3FaEJSpg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make CONFIG_SLAB_MERGE_DEFAULT default to n unless CONFIG_SLUB_TINY is
enabled. Benefits of slab merging is limited on systems that are not
memory constrained: the overhead is negligible and evidence of its
effect on cache hotness is hard to come by.

On the other hand, distinguishing allocations into different slabs will
make attacks that rely on "heap spraying" more difficult to carry out
with success.

Take sides with security in the default kernel configuration over
questionnable performance benefits/memory efficiency.

Signed-off-by: Julian Pidancet <julian.pidancet@oracle.com>
---
In an attempt to assess the performance impact of disabling slab
merging, a timed linux kernel compilation test has been conducted first
using slab_merge, then using slab_nomerge. Both tests started in an
identical state.  Commodity hardware was used: a laptop with an AMD Ryzen
5 3500U CPU, and 16GiB of RAM. The kernel source files were placed on
an XFS partition because of the extensive use of slab caches in XFS.

The results are as follows:

      | slab_merge       | slab_nomerge     |
------+------------------+------------------|
Time  | 489.074 ± 10.334 | 489.975 ± 10.350 |
Min   |          459.688 |          460.554 |
Max   |          493.126 |          494.282 |

The benchmark favors the configuration where merging is disabled, but the
difference is only ~0.18%, well under statistical significance.

 .../admin-guide/kernel-parameters.txt         | 29 ++++++++++---------
 Documentation/mm/slub.rst                     |  5 ++--
 mm/Kconfig                                    |  6 ++--
 3 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9e5bab29685f..5fbf6ed3c62e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5652,21 +5652,22 @@
 
 	slram=		[HW,MTD]
 
-	slab_merge	[MM]
-			Enable merging of slabs with similar size when the
-			kernel is built without CONFIG_SLAB_MERGE_DEFAULT.
-
 	slab_nomerge	[MM]
-			Disable merging of slabs with similar size. May be
-			necessary if there is some reason to distinguish
-			allocs to different slabs, especially in hardened
-			environments where the risk of heap overflows and
-			layout control by attackers can usually be
-			frustrated by disabling merging. This will reduce
-			most of the exposure of a heap attack to a single
-			cache (risks via metadata attacks are mostly
-			unchanged). Debug options disable merging on their
-			own.
+			Disable merging of slabs with similar size when
+			the kernel is built with CONFIG_SLAB_MERGE_DEFAULT.
+			Allocations of the same size made in distinct
+			caches will be placed in separate slabs. In
+			hardened environment, the risk of heap overflows
+			and layout control by attackers can usually be
+			frustrated by disabling merging.
+
+	slab_merge	[MM]
+			Enable merging of slabs with similar size. May be
+			necessary to reduce overhead or increase cache
+			hotness of objects, at the cost of increased
+			exposure in case of a heap attack to a single
+			cache. (risks via metadata attacks are mostly
+			unchanged).
 			For more information see Documentation/mm/slub.rst.
 
 	slab_max_order=	[MM, SLAB]
diff --git a/Documentation/mm/slub.rst b/Documentation/mm/slub.rst
index be75971532f5..e2549f4a98dd 100644
--- a/Documentation/mm/slub.rst
+++ b/Documentation/mm/slub.rst
@@ -122,8 +122,9 @@ used on the wrong slab.
 Slab merging
 ============
 
-If no debug options are specified then SLUB may merge similar slabs together
-in order to reduce overhead and increase cache hotness of objects.
+If the kernel is built with ``CONFIG_SLAB_MEGE_DEFAULT`` or if ``slab_merge``
+is specified on the kernel command line, then SLUB may merge similar slabs
+together in order to reduce overhead and increase cache hotness of objects.
 ``slabinfo -a`` displays which slabs were merged together.
 
 Slab validation
diff --git a/mm/Kconfig b/mm/Kconfig
index 7672a22647b4..05b0304302d4 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -255,7 +255,7 @@ config SLUB_TINY
 
 config SLAB_MERGE_DEFAULT
 	bool "Allow slab caches to be merged"
-	default y
+	default n
 	depends on SLAB || SLUB
 	help
 	  For reduced kernel memory fragmentation, slab caches can be
@@ -264,8 +264,8 @@ config SLAB_MERGE_DEFAULT
 	  overwrite objects from merged caches (and more easily control
 	  cache layout), which makes such heap attacks easier to exploit
 	  by attackers. By keeping caches unmerged, these kinds of exploits
-	  can usually only damage objects in the same cache. To disable
-	  merging at runtime, "slab_nomerge" can be passed on the kernel
+	  can usually only damage objects in the same cache. To enable
+	  merging at runtime, "slab_merge" can be passed on the kernel
 	  command line.
 
 config SLAB_FREELIST_RANDOM
-- 
2.40.1

