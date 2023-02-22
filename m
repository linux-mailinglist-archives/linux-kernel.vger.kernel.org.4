Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D17369F450
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 13:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjBVMSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 07:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjBVMRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 07:17:44 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CED83B3C8;
        Wed, 22 Feb 2023 04:16:43 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31M8xGBZ021515;
        Wed, 22 Feb 2023 12:15:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=l+F2KFQMUog9lkNSpQT6WWttm0AtexdcMutERVRbWX0=;
 b=HfD1eqkZYmhb5U/78tD5XvfCPpRGe76RDOMqyB3BfBGJzJ/dq5ZyIizOL7WQUts+DvBQ
 0he9Ba2YVGAjy57bEU2+xp/FKMj9abPoAN345CgRVwygQkGkiqcP6PMRCCEa7kq7oc17
 AHmKmAn2Ln/JdKWA6H7ii7Ck5nn1sRRRDEtQqXbxNJ5GbpT+uYY+bf0Sl+Yx0nEAcH5s
 0fu5WfsHy6fkoINja0vYoqhYZA+Mx8bhqAyjbDaAtLR5YJCszSoh72cgHTQ6/gBd2YpX
 OqLyG+enFbbmg/O+KobTzA+xKf1+B7dZLBd3Z0Wl+TBwIvRV1wBmmvwKBCWOAvenYgOD IA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntnf3fq6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:15:52 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31MBejir027290;
        Wed, 22 Feb 2023 12:15:50 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn46qyfu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Feb 2023 12:15:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXVgYmuqR7dvgILptsxBZGavx7VPuyW86JBTXC2xTw8LwEma5JYj3ictdLnJSOPlbenS5m2qWa8nqiQRbZ7OM/pqDiKLWMAZ4/8wPuyXbK2+2FVTyK/eROyasgIv+6zhfjAGCE8l8qhj48H/C0Ww+t3bKy8VIxKpgXzLURVg8QylOn2dp/V3wGzHtCM9hSyxpkdt0vzNUgfBcRqqCYhOL9l6lpJiTKT6MWweN9yVZ3hu1qaCbFP8gzjTCo2plFwge21vLtvQs1gAgXFnyARZaY80zbM+lTMd6HXHnLHh6xwjAFjgvemPjQ2w9d5C6toDwONmuas6FDa8+ihY0XWNFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+F2KFQMUog9lkNSpQT6WWttm0AtexdcMutERVRbWX0=;
 b=dOAEolK3uT618AhrdOK1FA/mKQgWYOX4aA7tqXnze8tUwielhPenhUhLwy1NDl8fw67riw466zUDDSUSFNc2gcLnvYwaVI4Bt3EwHbS36z1/9OdzEPyGIH/CVWQ3ALRPLlsQj1oUgS1Im7gnfQEXwy54N1xIzVMqTWHtlPFuvwAQmjSquJqMYjS7ewvkcF+YLHEP2yPhrZNRIu1NVEX56zz70E4z0sNy+0I8SBa3MnkrxiCX9Ad/XU2ngC4PxBIUTOz1JjCGtbLUfDeaA2JibxbpOW6H0yYbSw8C+BSwWpN2vfN4UqUOWDisASIj8wkGNEIy9zNG5MxHnTgeGKYjQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+F2KFQMUog9lkNSpQT6WWttm0AtexdcMutERVRbWX0=;
 b=mLKxg1mwlUCVbxyIAOvRpOoIy0l+9OEI7I1aRgWoVxBciim8X1yol7gAgrSRa4kVeiEX5PC8C6a51vBCFUgQd4lvHHJ45sy6hcf0oc6PsWhmYYE0mzNJcf7FqKjfU4TmggLjclr1mL715730Ql9do4jwJyKn/cnBVI5ItlP34rc=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH8PR10MB6412.namprd10.prod.outlook.com (2603:10b6:510:1c7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.17; Wed, 22 Feb
 2023 12:15:46 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 12:15:46 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
Subject: [PATCH 09/27] kbuild, clocksource/drivers/timer-tegra186: remove MODULE_LICENSE in non-modules
Date:   Wed, 22 Feb 2023 12:14:35 +0000
Message-Id: <20230222121453.91915-10-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230222121453.91915-1-nick.alcock@oracle.com>
References: <20230222121453.91915-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0233.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::19) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH8PR10MB6412:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bdd0877-5932-408c-17aa-08db14ce86c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8wK4cvbF/w4KnvGgGWqjXx8+8WcXLFEla3p/xKayKr/GK6Ei8bsuA22gh8sHYq3NhUvPBDRXztENI96EgRcIZxoyJODKAWiqzk0r1NUlVl3v3jdSJLqcsMF0T5CwnVLmoNUbp/KjZod9FuoIXpJ1RQ953w3MwHkV7h+LXOkUWP0xFiafX1hF3DbSwShWpdnPre/o6VWRsCm+j/djH9hDbzqo564V8azvcYk/yxF2JcwPuDOtYxRCDhNA3cWa8VBQHJaX07cHj8KhbwGPwvN6LmFr734hwWRzKPVdWwfpIIcOgDGcyZynMtlOFdCr14eQ1vvVicSBoj345vZNWpGA+G6Qbesg3IwXigSRO8XZ/uWZOchHOAU6M5Hkj7Kg8+b5LFUXNKg9VPwThPliJRDMGvGK21NqmvM6hYEkFEVWeMb7cf///HPLJC5/kqY6cycK3m0oFAbOOyW/XamcOv4vRE70s00N9oAQQ1yiI/nkhuEOvbs4UD8Gn4E7MJb4p40B1LkM3upyIJDQkfeV+BWFrMfwoM0Z4P2Nv6H94BWJbG27ajj9iTXWET9m3BQICghASUAj5PYc/i9K9LuTHhKorluWCZhlDVk/Rf/hkQfD240lWUrwJxwWdSehELTZlcL4YGc4h+IVABN9h+VJnN87MQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199018)(478600001)(86362001)(54906003)(2616005)(6512007)(4326008)(316002)(6666004)(6486002)(1076003)(6506007)(186003)(44832011)(36756003)(5660300002)(8676002)(38100700002)(66556008)(66946007)(41300700001)(66476007)(8936002)(83380400001)(6916009)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?opIMhKcbQMuN35PVG7f4F6aqWqlNGf21I8orD9A6W4Zus5uuleE5H/AvZvqC?=
 =?us-ascii?Q?PpgzQWEKG5OxWcIYPHfnra9rGsVDh0aBgHjeCyPGsWY4A580WMYkTw1YBH3X?=
 =?us-ascii?Q?e5z+8xHXomb/8n+PDZ9ykyVqtnLQ9r4UE1+yprsdbJnqkXwUT0vx4I+QrHWX?=
 =?us-ascii?Q?Sv6S+HFuUK6eMXDqccMFEKXKrvLNejVOeI9If1hfNFK36zhXLE18L6wW76wu?=
 =?us-ascii?Q?MCML3ag7mHd6YVCMReNLLrlbHo9bbPQb7l7AgGLuNc0ROaYFs39YNZ12k51R?=
 =?us-ascii?Q?kxSrXbtt0nWzuv0Q2hld6TZ7nyOVmSdJTz4a6NqQvrIIHSTlTw08revybpSd?=
 =?us-ascii?Q?1G5vTGRwUenPWjetpV8vYao5dtwEJKb93mSGJHEgRHdwuYuCK31KRKqPBXxz?=
 =?us-ascii?Q?BM2Sq+r2d/HSu3f/hbwrBltSkDkwyQ/ds+h4+VIa9WbE2EoMHTdGA7Glf3Y1?=
 =?us-ascii?Q?nfIPyclFgLQSYUbje9aCiInTv98mCVWsmM8kNSS6Mf+389HGP9R5gPBaExw7?=
 =?us-ascii?Q?aHjK7ArdH0BErsYUWjMH89Rn5vRK8odYMFujMmgtQcL94wd9oUpY60HMUhvP?=
 =?us-ascii?Q?i/e18p+7ZE45fMHeNt22140sTh1wdsIHZgiDya6IN9QLPVYqRWZmlVp1Prs7?=
 =?us-ascii?Q?JzXqBqdagBor/55V1ny9ubfOKZo5bl1eIsfPQpRWrnXqqCz7Vym1OZmhgnOw?=
 =?us-ascii?Q?NTS76P0/2TG4tbPOE6dlmqFT3zKdMfG1SNs1djl7S8C+VMkRGthCYF85Hwb8?=
 =?us-ascii?Q?6GVfj+nieJUNZL5aZi5ZAK7gJC8KEroyDJnLZA/efkiu1FkacuKhAMM6Qa0n?=
 =?us-ascii?Q?iOmGFwxe4xBy0quDTvTu7vXtDUAgakefCflYzUm7+S6mTsDmRztvAqr5IOCs?=
 =?us-ascii?Q?9onGAP6kw8oqOm6Z9ay8Lawr1AsnxOd/cxSO7WDJ3sySqHAKNl+EJG+jKXYX?=
 =?us-ascii?Q?8n7ISd1iaJaYzq1RPpa8aARW+t6b2lk0Sdl92X7ovyTetpo1ISd/2mhZQ8ca?=
 =?us-ascii?Q?/8n9vvif0xsHU45/Hc7tZqTNjEc+syqdNw/h6tC6vxeGXr9WCeANSSq0GGPM?=
 =?us-ascii?Q?qdEr3KRsylkBhhxYDgw+ew7NysqcDKwUXjSqyu+G1seLR1cMYKd3UxEzCU1E?=
 =?us-ascii?Q?0inadADVaERrbgQJnt/iFfIPvbudOk6MSbAjzuOXplgf26/WlmCn4OpnNus3?=
 =?us-ascii?Q?tfsRihKsaOww0sEUPC+uunUOaI1KMA7QBV/AWbY2/xrd1djPdYlRr+1wpQFq?=
 =?us-ascii?Q?UlmqnTWkw2cmiCEh5O1WaJJH08rEPIzOsCm4U9xFsOhmBAUmND8xpalDNN94?=
 =?us-ascii?Q?4vNMw/utsAKdLjkhkheHcSoAZ8tZilfrT2q1IDEvJDBBam1dOA9mPDBNn/SL?=
 =?us-ascii?Q?hOUTEt12ApqfivyYW976EbrfGwhDa6K2uS08IKzbc9ILoQxfVvpD47Cn8BOe?=
 =?us-ascii?Q?D1Dw0GugpwomHkH8mug21MAFVUWc/5/zJ/dExMPu3TfFLG64arm/AracNo7Z?=
 =?us-ascii?Q?ybYmbgyLDvLExwHu8Sf6P5m+wBIrqpmNs6Bmx2fT66cliL8l+GsGJatIaLk2?=
 =?us-ascii?Q?LLglkTaK/lF2KQ7xVXr6QDAM0OLNtwByN+u0VK9bvA/pzkfGMF4Qr3Tg3yZP?=
 =?us-ascii?Q?hPAWBp/+ALzrbarAi3hue8U=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?90xrW984rA2gdMwQhRKBEGOqd8D9HaP/5KccGr6fXaA2JRxxzRS2q+QLya9U?=
 =?us-ascii?Q?5HPCCIOiGfREGuDeSZWYSESHSIVR8JyKjXETYN13c2aMP52Gp6xzp4FP0VoH?=
 =?us-ascii?Q?+TGjZpu2Lw98sJ6NfGOUGK/UhCZekieb+RVvGBm8C82CBUKx5SvoWbNbBrqV?=
 =?us-ascii?Q?ZDt/CT6WQveFmUTEcMEtxlZbzZGKTvr4r0HYaRFDcR7lDjpK+x01enVQJFO/?=
 =?us-ascii?Q?8v+rD/JvBwXuCznX5vgqHDKecmdfpMAcIKlIie3QGxkOImJXePKaHZ5oVbOC?=
 =?us-ascii?Q?q3c5uwtUbKk8B8U6vtFUTUQFOfgSzBjttXMSkRoYdDuU/R2IAb6bFoa2ESR+?=
 =?us-ascii?Q?krYuX0b//G5Ntkbcd+0Rr47od68itJRrWJD5NOyIn80omAoOaSOsfPo/47t3?=
 =?us-ascii?Q?3D9FwxpxfKLPDkpGUIaoN9bC7clZt4RTGMaUzhxIoJmo1LJp6zMFJ9MmoSfs?=
 =?us-ascii?Q?KYK8aE06Ktf8J4JQ3e/F7x6ckKJYfXaIrmp1snZfe44yrVOir1TfUEKsE+Yt?=
 =?us-ascii?Q?iQR+dncte/cm+ObDr/y/xvQJI+7oxyjrMlPDHk9i60GrXRGE2tMZK/20cN8j?=
 =?us-ascii?Q?+EOPlPpft9BZCd+DMsYNeAbJfxqMKb0eYG29gFz6Hw4CzHMZgfnhrBS4JNss?=
 =?us-ascii?Q?SRsI4IkLQDyCLkl2HgkJf8Gc7D7QKXHxxfxRRYfGfHEvqM+BH4ljdUvnC2pe?=
 =?us-ascii?Q?iolmK7Qqhyh8S/KO1nB2i7nn/JZvp5QK17JQ2OqF7cLeF9lYpLrhGxFjsr9h?=
 =?us-ascii?Q?DQDe6MO8Ut+pM5boTeF5sTyujE6VKRpRrvBPZHd6S/QygntVBz+Q5AGySL3u?=
 =?us-ascii?Q?jdts/KwonUWtgqALjxWy1S2jka/74gve5skdYbmh6yHLASq6oBXjgO57qwti?=
 =?us-ascii?Q?cWe4/ZsecVryZZtfsWNItYJ2ZInDSaNBiFlIZibtTVtyWKllgeUH3MX9MrJF?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bdd0877-5932-408c-17aa-08db14ce86c7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 12:15:46.1164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G6Lz2IjCYm1s4oLkYN0wICL5qN4JO9CUOdT4kVY7AHuu7uTbI0S6S/+HKgV5KbpYSxPPvySY2o9bWIDpR2xxjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6412
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_05,2023-02-22_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220108
X-Proofpoint-GUID: uzwDNrt2HB4KFR144RfIpPM7mdmchne7
X-Proofpoint-ORIG-GUID: uzwDNrt2HB4KFR144RfIpPM7mdmchne7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8b41fc4454e ("kbuild: create modules.builtin without
Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
are used to identify modules. As a consequence, uses of the macro
in non-modules will cause modprobe to misidentify their containing
object file as a module when it is not (false positives), and modprobe
might succeed rather than failing with a suitable error message.

So remove it in the files in this commit, none of which can be built as
modules.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org
---
 drivers/clocksource/timer-tegra186.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/timer-tegra186.c b/drivers/clocksource/timer-tegra186.c
index ea742889ee06..0c52c0a21830 100644
--- a/drivers/clocksource/timer-tegra186.c
+++ b/drivers/clocksource/timer-tegra186.c
@@ -511,4 +511,3 @@ module_platform_driver(tegra186_wdt_driver);
 
 MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
 MODULE_DESCRIPTION("NVIDIA Tegra186 timers driver");
-MODULE_LICENSE("GPL v2");
-- 
2.39.1.268.g9de2f9a303

