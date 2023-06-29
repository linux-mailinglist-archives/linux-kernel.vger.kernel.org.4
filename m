Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B749B742DA1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjF2TXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbjF2TWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:22:53 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E243AA8;
        Thu, 29 Jun 2023 12:22:44 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35TJ41L7028737;
        Thu, 29 Jun 2023 19:21:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=OCr5zrFqhJdkDnvbZF8hy5NfQnLo1d6CmVojxbAKj4s=;
 b=ZGMxP+vTZsdYZdmeybOmL9iQqSXJJIz0DKguLZ3EYTC3Yz2F8VhdejUaASvQ4j29pKF9
 wruc2JBrCp2NKxHtzIFT4IGM1I9PVP7B2Qm/dKcf3/HYFdIYmlusb9TVwPdKDLBT/hH2
 uS/7Mk2KbbYZA+L0w/N4kcV1Aa6mvnSC2inWh9AFQ3Nd89BFC32H5LLkBAxM/byEOOn/
 j/rLscN7alALW6smrUEe2fWNuBpGrPUAqH5vgKfAmHahb+KOlNkyD7//zGQTqXptxZzV
 XkTU9sziHi8PMHWOWaWlUePjUu78ak1cHhJUWPH03X77xXK2kjVfSpKti1juzw7QioKB 6Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rdpwdnggj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 19:21:50 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35THcaI3029658;
        Thu, 29 Jun 2023 19:21:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpx7tspd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 19:21:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUWrZdAfjOBGz/GeQvct7tDxJzYCWO7VJscRb/RXXCMRRt0IMH5cZiVZCTtCZiLziw5ssJmX6i9hium5M6h83xTYLbJlOCGyH/g+8DsqEPMK1ucpowpuvZQYSkKOVilNSvDKBrGsJLp0JdPYIQJi6EItNf0pM0a4RymSxMgmTuegTYJ5y9MgHh7rdjg4+jbRLaqSGrAdTZqI/CKibYz0ommd5VkjVwwuNlJ/3TmI98qFTTEIiBpEq4ecl7QxDMAF7zfQqffZfbNZJKSopC7LyzcCnOsivl49Q+KoIfurkP1vAMLluTw0TE5WeWHTJe/KGaJcDJipuxzNUXeaweovzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OCr5zrFqhJdkDnvbZF8hy5NfQnLo1d6CmVojxbAKj4s=;
 b=VCFr7VgeiXmsVADNNg34zU2FUal/dWBaB2TjZg/6K4Yg2gx8ZpbSzi0RycB6OHkxn6xXDOrWKkn69e/9k1G42pSUPAyHMlzqPUSSGhusD3a3XykHWka8oCpO4jNRBz5twE2YpL2PJXuhVjN09r2aiTTD8exn06mGRi11kwsqJxG5LNLCqKFvF2KQcHnvKkt/K44m8ijOIEZXhXMB4LnY4pX4iuB5OeHY8AMSVtu8fk3O42HAUUhGtboHw5+BDyYrzU+UG8P4tBrSHEUuOF5SsJcSDcfkEs0UtCUVMXdA78xej5Ir5ZpBWWT696skM00x2Muz0pJB6jWHDeWg+FPkvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCr5zrFqhJdkDnvbZF8hy5NfQnLo1d6CmVojxbAKj4s=;
 b=NAYTXuywcIXZ6TMYVwaqDlWDNwTPttPmAf9o/ArOkin+6aHiNSdf3PxUhQu9XKyNeV274Eb3F+DOkgf7Jh0WcGR0iNYemPpgHjgbQ1PvekRwAWQpL+NIziOjBjT1KXxa5aRPviSd6OMa3M5c9CIG32aWezd+5z27T9bR+P0Zxp4=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by IA1PR10MB7200.namprd10.prod.outlook.com (2603:10b6:208:3f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Thu, 29 Jun
 2023 19:21:46 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048%5]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 19:21:46 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org
Cc:     hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        vgoyal@redhat.com, dyoung@redhat.com, lf32.dev@gmail.com,
        akpm@linux-foundation.org, naveen.n.rao@linux.vnet.ibm.com,
        zohar@linux.ibm.com, bhelgaas@google.com, vbabka@suse.cz,
        tiwai@suse.de, seanjc@google.com, linux@weissschuh.net,
        vschneid@redhat.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v25 07/10] x86/crash: add x86 crash hotplug support
Date:   Thu, 29 Jun 2023 15:21:16 -0400
Message-Id: <20230629192119.6613-8-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230629192119.6613-1-eric.devolder@oracle.com>
References: <20230629192119.6613-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:5:100::32) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|IA1PR10MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: a386ef27-224f-4cf8-1e58-08db78d6146e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SLu83oT9AqshE6vv0tCtRfqMleANcZRqFJYJcnXR5R+kPuekLcZlcJVRfwCp3mnvaM++YBfmoS/QvJeWca4jQs0QQNqkRrbT+2NfP8HQDG2DsQpdkLXH/YKJU6fyUJr79CTxSIFCTo/9zdAS9ExsfIIv0U7waAJwDHOzVlR7D1qhEAwzhbSEHoJv3v3NCNr5Qs/rUHHv5jGk46kZsl2Fm+rkUqDqRD3gRBnhA3u/E5I7qpFD1u7BZ2cO2m9MlERnebSyLe8me3/OGtSdQ7mafv/Gq0eUl9L8cKQYLDRLu3P7YVkzjqf38R0N4k+HJtgXa8U+d+DOkSqgm2I9WyBb9XK8dYlZPWAaUNIAqeVz0hC0/n1hMgWeACqyeboqQSbA7Aw/ZjfOkX8fMpiEXjKnL4CV7yVs4C58d36h1UQ8je5PkqWacCTibe/sNrPfOHtk76BFhsZpVm16Gf0Q4Hj6Q6oV+AqBNcvfOhqxuco2ivzdL489a1lbeaNzI6UI155GKOoS0VKesZl+PyyU1N2y1Z5zl7Ly4k3oVk2yJ+C6GRGBNqJfQQZwbHVeP3xZy5BR5BNleYOueOhnDeTo+617s4iXA7YQlyvEpJeKR92/6yU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199021)(83380400001)(316002)(6666004)(8676002)(4326008)(8936002)(6486002)(41300700001)(36756003)(86362001)(38100700002)(921005)(2616005)(7416002)(7406005)(66556008)(6512007)(5660300002)(66946007)(66476007)(478600001)(2906002)(186003)(26005)(1076003)(107886003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6e5u/x/khUBh0RHl64T/vAY52RTw8h7K9jI97tZ0tv7H1AeghCuj5CJHQvFG?=
 =?us-ascii?Q?+5dqFfp8Cxtjx0nip/+0ERngv/CIkorYwPa4mSzqga7Ku54Ly/28Iu+wgrgP?=
 =?us-ascii?Q?UEhWAR+HFkp2z+u7Zp1NcdfkMDS8Mr0iOgNXGTdOQccQEF70bZ0VH221faC5?=
 =?us-ascii?Q?8lQS20hCg+1/cxSXs6uhdkFn/tL8xAuQmq+hV8DA6qgMNDhLXpBI4f84iuIi?=
 =?us-ascii?Q?B/LwzECf1mOJn+Ur2aZO8CjWXw88Tde1eCxhPyFIYm2TRy+vLFAEE5kerIF7?=
 =?us-ascii?Q?93anSN1zmrN8BN2jz79+KHhkmR2hs1/kY9/CgujUwY08E7WkQcZEE2i5IvFr?=
 =?us-ascii?Q?rH/aRQmH463zkH9L4mWZBo8bNsDtUQa1CVKc2w8lEbzdkeJQ1KZjVvi8V6lG?=
 =?us-ascii?Q?DU3M/8uFqfScIDB4j65b1Anb4qag/QeVVbVW8GofrOIOnVwJ6O1POKG2tz2w?=
 =?us-ascii?Q?+oVfOPUNzhcI8KQYcHafudlVDSrZgcIKqvNnTEDumg1c+B/hyGWc63CSxX/f?=
 =?us-ascii?Q?6KLFooHSq2mFOZnBzPxTb+NRY0qw5xWEAjkeqhrSzLcQOjXTgSzhr2Kq69tm?=
 =?us-ascii?Q?CU+WunJR3iRhdsKBk7ZEEYQySlXOjHaBypm9vdjz+XTXv1BobtiZPY/kJUru?=
 =?us-ascii?Q?CMpn3+VO55pdd2mNu1CeOOo8JhrczCidc1jDhH0GhbXy0vpN/TLQOX+T79Tf?=
 =?us-ascii?Q?lIJQkM3w/12AegCbDrxuQc+B6V07wBE7vHIFXbUONBShHcvNyn1y8VHxi9qT?=
 =?us-ascii?Q?0PjWnWEx9Ah+xGLROj7+SnKzPLFae6d3xrI20xoPxWCjkJq0Er0nja9dhWiG?=
 =?us-ascii?Q?U8hwIVN0Dw66eVhz9JhLEEe7hYWOPJc1NvN0JXTM5vXPdK1BWpoaAeQ3lmnD?=
 =?us-ascii?Q?/QAs7A8TtLTJsOWNw/oJuZo47K0T4J7hmyinN4brtYBBUZoaszcPsHuBycyG?=
 =?us-ascii?Q?9O/cTexubwS/LNhrNJrl6CNDd7DwBdq2xCAsth6Qg3GOyfUMw+duiYTnhhZW?=
 =?us-ascii?Q?+6FYUUTMcR2cDMQwFtWFKsMqIYwohCKYuDU+Wl5adkzH6z7EyjCrGX9e6oeU?=
 =?us-ascii?Q?KonsNP3euCfbYuToImLAZv5c+9UQT965fJec3tr/fXSDrvp5NGLsUaX4BFVG?=
 =?us-ascii?Q?mRjVPsCOdzR2yf1CHvffMzlrQvEj6hasl+fyKALLGsSw3Kforq1Ey19hF9RA?=
 =?us-ascii?Q?rd+18nTZhT7WM5RsQOpaklyNgmRHqdTjQOGjNUIiGpgSU/xUccGLjnQgQDpN?=
 =?us-ascii?Q?UpHTwSkGmTUKh3/yUa9/yxAjMDkjE2j0vd8uXZXT2zO+W25PA8femuIT+JN2?=
 =?us-ascii?Q?geTlVQSEmjULfpv3sQeTVHWUWj40/+AmL3CWa3pmCV+eThCErLLiT+x07UYV?=
 =?us-ascii?Q?XQmZtI1Fr+XOGBquKQhiYDkpBlb6SmP7E+C3Z0En+if51VLdwmnvZZstBmcU?=
 =?us-ascii?Q?YS+J1yr12QRYtTLk6NDPHBe6Z4r6UVhJgsKfzeAE2cyssbLVaHFY02Nb7A/5?=
 =?us-ascii?Q?WQUDYIySOwqmRAiAbtmJf7sU/YCvNETOvcZ1jkZGUtiOmFeSlj/t9u9gcEwD?=
 =?us-ascii?Q?adhsIolGlru2Qgn7F1wObeXRMnDROQS8DVL7HgrhK72ot3zrnheQ0mqZklqk?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?egX63gTQD7FjHFwhoaQlNMIf9UjYf2TAN505lZB0aoN1tolw2I4CNrg4g84j?=
 =?us-ascii?Q?0T8lroQKn0QTdIoGbAVdCKiPw4Sk3NWhaT4rZSFQFTFWxWpJ96nTx0dUntfv?=
 =?us-ascii?Q?p9T/mXzNkj2TS+T7KibAW65f/+qiAjfN3P7Frcx0vG/dndVCog2z8rsHhmtj?=
 =?us-ascii?Q?SJsfcmai/mElKlraeMVck5MlfkGNEgzNM9Cnv7EJ2BpxHdCp2N3ZjGwGoPLx?=
 =?us-ascii?Q?pvttxCgXfeBP8R2OgpyGbLIMlwZnjdpkdKhtmofjbRgwhhr1QHcBzEERt8e4?=
 =?us-ascii?Q?nmMhuVTv121gywZd+pfHAFq1gnIiTtH3xtxD0Lc7u2xk4IQZO1NDhWZmAIuT?=
 =?us-ascii?Q?EKSBX1F2EcnBClCW7A+FaiQDjU2r1azgFnC5ZP0kW9LzCXYZJm0cJiHUPZMU?=
 =?us-ascii?Q?2D+BoSKUfM6SzzrIpeTi105li1+K4wg9TRp7FqU1Khb1gG6HuKk7VV9i52Jc?=
 =?us-ascii?Q?7UjZGrNBJOG+4JNKX2UcaL9KeqJ4LGM2xFkvWT7eZjVAJ+K6VwfZHdXk/kZR?=
 =?us-ascii?Q?TNl1acI9Shx12HksW1yFwO409vNYFgFlp4lKOBVKcofDog4Uw9ie2DUsVh5O?=
 =?us-ascii?Q?LiDELieTlYO97Jdx5152cDHdYat6mUUmAk9iJBYTVltBs2ebdxDZ48HVAHQ0?=
 =?us-ascii?Q?0m6/LXBKRNhf83fMH6DjFNBrojS2YmjZY+oWh8l5YRORzC1BdcQmJhuv2IyB?=
 =?us-ascii?Q?K5DszbHhVdbORCaVGOxwmjbFy5ZPjePpGyxTXYpuormpP8RxzgC+4ym18ZRV?=
 =?us-ascii?Q?trtyLvxqEXfyjulanf9ejXI1T3TYKWp6a6kuB74tjh+CLS4ptu8rwNZ2K4Qq?=
 =?us-ascii?Q?Lm1J17NnKS2MJnstWoQqOdWSbRBa4n7/Zb8JcMCJ2mixYnx9Je4UnH28hjyw?=
 =?us-ascii?Q?AoBnDQDkrA5OH/JsgG62xHyNWh+o3hN8mNohFjH75axc59pLmywe3shINJUh?=
 =?us-ascii?Q?Gf7PebAsKRjtHxinftn/XF1gT+h/UcodJLLXhEhp+0PuUD8uTJD1mNq7GL3K?=
 =?us-ascii?Q?TavYNkrXBREBZiHjiakj7DiRbRC3pYqtKrN56IIo4+EcvsIdhFrfMo3kKYGJ?=
 =?us-ascii?Q?vEc4tAuiMAgBopapthK9fHRqXhPYEAskvLqGopzQZab2NeMPTM5DeqtOAb87?=
 =?us-ascii?Q?LcyVdzLy31iJept7Ux05pEZPOaRjWZhAbnQu/MkEcC5FlcydY9AXsn9bmePr?=
 =?us-ascii?Q?5MSZVdWZN4GC0o7sDmuZQVOujaA9DYQvI72L3RgARhgbBpO5bbl0s1DG6gmc?=
 =?us-ascii?Q?Omcm1iItG68UKpwC/zMGIdcCxxWtof9PyphNWHTSV6w3OUANyuA4MchXLGq/?=
 =?us-ascii?Q?c19dH+P/3C3voSu3h0OphXH99qqWsY4KNc9nyaNVMIxTFZWCn/tUd7XXVNGs?=
 =?us-ascii?Q?rR61GZSzcPy3e79oTSlgaw5EDH0aTyV3pGALggbsC/Jb94LVZJ8ly2cVMJOQ?=
 =?us-ascii?Q?Lab4OXU26MQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a386ef27-224f-4cf8-1e58-08db78d6146e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 19:21:46.5856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TZVQUDaNi43piufRDXbJMH0UsxkJIghEtC6Kse8GkBHR3gdKjuR4B/+WFJhRIyVcLIgJ+O+B5JM79hm1MBYBjPvoQygE76r3P5THouYvw2U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7200
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_06,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290174
X-Proofpoint-GUID: ei0G87BwGhVzQ84_a_0wrQLqI5_N0OKH
X-Proofpoint-ORIG-GUID: ei0G87BwGhVzQ84_a_0wrQLqI5_N0OKH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CPU or memory is hot un/plugged, or off/onlined, the crash
elfcorehdr, which describes the CPUs and memory in the system,
must also be updated.

A new elfcorehdr is generated from the available CPUs and memory
and replaces the existing elfcorehdr. The segment containing the
elfcorehdr is identified at run-time in
crash_core:crash_handle_hotplug_event().

No modifications to purgatory (see 'kexec: exclude elfcorehdr
from the segment digest') or boot_params (as the elfcorehdr=
capture kernel command line parameter pointer remains unchanged
and correct) are needed, just elfcorehdr.

For kexec_file_load(), the elfcorehdr segment size is based on
NR_CPUS and CRASH_MAX_MEMORY_RANGES in order to accommodate a
growing number of CPU and memory resources.

For kexec_load(), the userspace kexec utility needs to size the
elfcorehdr segment in the same/similar manner.

To accommodate kexec_load() syscall in the absence of
kexec_file_load() syscall support, prepare_elf_headers() and
dependents are moved outside of CONFIG_KEXEC_FILE.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/Kconfig             |   3 +
 arch/x86/include/asm/kexec.h |  15 +++++
 arch/x86/kernel/crash.c      | 103 ++++++++++++++++++++++++++++++++---
 3 files changed, 114 insertions(+), 7 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 06a4472d0fc0..42c083da7ce4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2058,6 +2058,9 @@ config ARCH_SUPPORTS_KEXEC_JUMP
 config ARCH_SUPPORTS_CRASH_DUMP
 	def_bool X86_64 || (X86_32 && HIGHMEM)
 
+config ARCH_SUPPORTS_CRASH_HOTPLUG
+	def_bool y
+
 config PHYSICAL_START
 	hex "Physical address where the kernel is loaded" if (EXPERT || CRASH_DUMP)
 	default "0x1000000"
diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 5b77bbc28f96..9143100ea3ea 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -209,6 +209,21 @@ typedef void crash_vmclear_fn(void);
 extern crash_vmclear_fn __rcu *crash_vmclear_loaded_vmcss;
 extern void kdump_nmi_shootdown_cpus(void);
 
+#ifdef CONFIG_CRASH_HOTPLUG
+void arch_crash_handle_hotplug_event(struct kimage *image);
+#define arch_crash_handle_hotplug_event arch_crash_handle_hotplug_event
+
+#ifdef CONFIG_HOTPLUG_CPU
+static inline int crash_hotplug_cpu_support(void) { return 1; }
+#define crash_hotplug_cpu_support crash_hotplug_cpu_support
+#endif
+
+#ifdef CONFIG_MEMORY_HOTPLUG
+static inline int crash_hotplug_memory_support(void) { return 1; }
+#define crash_hotplug_memory_support crash_hotplug_memory_support
+#endif
+#endif
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_KEXEC_H */
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index cdd92ab43cda..c70a111c44fa 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -158,8 +158,6 @@ void native_machine_crash_shutdown(struct pt_regs *regs)
 	crash_save_cpu(regs, safe_smp_processor_id());
 }
 
-#ifdef CONFIG_KEXEC_FILE
-
 static int get_nr_ram_ranges_callback(struct resource *res, void *arg)
 {
 	unsigned int *nr_ranges = arg;
@@ -231,7 +229,7 @@ static int prepare_elf64_ram_headers_callback(struct resource *res, void *arg)
 
 /* Prepare elf headers. Return addr and size */
 static int prepare_elf_headers(struct kimage *image, void **addr,
-					unsigned long *sz)
+					unsigned long *sz, unsigned long *nr_mem_ranges)
 {
 	struct crash_mem *cmem;
 	int ret;
@@ -249,6 +247,9 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 	if (ret)
 		goto out;
 
+	/* Return the computed number of memory ranges, for hotplug usage */
+	*nr_mem_ranges = cmem->nr_ranges;
+
 	/* By default prepare 64bit headers */
 	ret =  crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
 
@@ -257,6 +258,7 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 	return ret;
 }
 
+#ifdef CONFIG_KEXEC_FILE
 static int add_e820_entry(struct boot_params *params, struct e820_entry *entry)
 {
 	unsigned int nr_e820_entries;
@@ -371,18 +373,42 @@ int crash_setup_memmap_entries(struct kimage *image, struct boot_params *params)
 int crash_load_segments(struct kimage *image)
 {
 	int ret;
+	unsigned long pnum = 0;
 	struct kexec_buf kbuf = { .image = image, .buf_min = 0,
 				  .buf_max = ULONG_MAX, .top_down = false };
 
 	/* Prepare elf headers and add a segment */
-	ret = prepare_elf_headers(image, &kbuf.buffer, &kbuf.bufsz);
+	ret = prepare_elf_headers(image, &kbuf.buffer, &kbuf.bufsz, &pnum);
 	if (ret)
 		return ret;
 
-	image->elf_headers = kbuf.buffer;
-	image->elf_headers_sz = kbuf.bufsz;
+	image->elf_headers	= kbuf.buffer;
+	image->elf_headers_sz	= kbuf.bufsz;
+	kbuf.memsz		= kbuf.bufsz;
+
+#ifdef CONFIG_CRASH_HOTPLUG
+	/*
+	 * The elfcorehdr segment size accounts for VMCOREINFO, kernel_map,
+	 * maximum CPUs and maximum memory ranges.
+	 */
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		pnum = 2 + CONFIG_NR_CPUS_DEFAULT + CONFIG_CRASH_MAX_MEMORY_RANGES;
+	else
+		pnum += 2 + CONFIG_NR_CPUS_DEFAULT;
+
+	if (pnum < (unsigned long)PN_XNUM) {
+		kbuf.memsz = pnum * sizeof(Elf64_Phdr);
+		kbuf.memsz += sizeof(Elf64_Ehdr);
+
+		image->elfcorehdr_index = image->nr_segments;
+
+		/* Mark as usable to crash kernel, else crash kernel fails on boot */
+		image->elf_headers_sz = kbuf.memsz;
+	} else {
+		pr_err("number of Phdrs %lu exceeds max\n", pnum);
+	}
+#endif
 
-	kbuf.memsz = kbuf.bufsz;
 	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	ret = kexec_add_buffer(&kbuf);
@@ -395,3 +421,66 @@ int crash_load_segments(struct kimage *image)
 	return ret;
 }
 #endif /* CONFIG_KEXEC_FILE */
+
+#ifdef CONFIG_CRASH_HOTPLUG
+
+#undef pr_fmt
+#define pr_fmt(fmt) "crash hp: " fmt
+
+/**
+ * arch_crash_handle_hotplug_event() - Handle hotplug elfcorehdr changes
+ * @image: a pointer to kexec_crash_image
+ *
+ * Prepare the new elfcorehdr and replace the existing elfcorehdr.
+ */
+void arch_crash_handle_hotplug_event(struct kimage *image)
+{
+	void *elfbuf = NULL, *old_elfcorehdr;
+	unsigned long nr_mem_ranges;
+	unsigned long mem, memsz;
+	unsigned long elfsz = 0;
+
+	/*
+	 * Create the new elfcorehdr reflecting the changes to CPU and/or
+	 * memory resources.
+	 */
+	if (prepare_elf_headers(image, &elfbuf, &elfsz, &nr_mem_ranges)) {
+		pr_err("unable to create new elfcorehdr");
+		goto out;
+	}
+
+	/*
+	 * Obtain address and size of the elfcorehdr segment, and
+	 * check it against the new elfcorehdr buffer.
+	 */
+	mem = image->segment[image->elfcorehdr_index].mem;
+	memsz = image->segment[image->elfcorehdr_index].memsz;
+	if (elfsz > memsz) {
+		pr_err("update elfcorehdr elfsz %lu > memsz %lu",
+			elfsz, memsz);
+		goto out;
+	}
+
+	/*
+	 * Copy new elfcorehdr over the old elfcorehdr at destination.
+	 */
+	old_elfcorehdr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
+	if (!old_elfcorehdr) {
+		pr_err("mapping elfcorehdr segment failed\n");
+		goto out;
+	}
+
+	/*
+	 * Temporarily invalidate the crash image while the
+	 * elfcorehdr is updated.
+	 */
+	xchg(&kexec_crash_image, NULL);
+	memcpy_flushcache(old_elfcorehdr, elfbuf, elfsz);
+	xchg(&kexec_crash_image, image);
+	kunmap_local(old_elfcorehdr);
+	pr_debug("updated elfcorehdr\n");
+
+out:
+	vfree(elfbuf);
+}
+#endif
-- 
2.31.1

