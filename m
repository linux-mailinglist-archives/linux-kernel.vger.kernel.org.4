Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDDA6B12E6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 21:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjCHUVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 15:21:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjCHUVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 15:21:42 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7B9BA848;
        Wed,  8 Mar 2023 12:21:40 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 328JwfZi021972;
        Wed, 8 Mar 2023 20:21:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=FNG/Qqt2iYv7TX6Ke0WfLv/5xqSlXz2vv4TC6ihwxPc=;
 b=K1RmnSu/u9D4KtDXqfXG0eJsffkhDYYY/6MB6rW+qmw1U7xtmz4z/uW3SGgMJwAN6sWH
 Xlo1PPpc18OwMUpGxP1K8WD1YoXSexMT/DFH7OTliJc3xSoZLdCOfGBH9AmHTBj7JShX
 KwBU8sMJlaKAbXCoisIusfSOvZOhxqOdIbbdZucv77pa25Mfa2nMoRVI5S41QYqEa1vn
 sL5D7Q0KjNP99SML3RG88exltYUF4+gD3JEl6I6IhDt8JzZfPpuKERVE92b452Ofld+G
 nw6PzSAxd1Pq2Ec4D0EZBQXqc0wX4fxr4FUohgIaBHp6CZcPR5FWllN/tp+CLQS9uKAI Qg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p4168s58y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 20:21:32 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 328KAke0036520;
        Wed, 8 Mar 2023 20:21:31 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p6g460bwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Mar 2023 20:21:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eghfgm8Yj875UlQeaQCzk/2+wU1MIxOwX7z2kn83dspYvNBIS97ia/+iA6VAFW8QC49HnHvLaAO20ebDSiIQK+KP4EmZNBMpqWhiwf+MkF6yFd7FHgDU3+ncnVtCZwcmYsodpMkAmaQvNg1pQ1VaVbSPt0OLMLEyUOfCL84OoaKu3MK7fsBff8/aoLuIP+JD9Gue7HUFtGYGoWoSehvpf5El8bXq609ts1tpLbtZiNk1fq60hSY2bRDNHkLCNIP+HbP/+uxzcDhl7CCOqCIEjPGpyQBbKFm2dYLeQTIJSYAw/SYKtYPxibcqDlvb1+iPQSazLidacK+AIwCGublLDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNG/Qqt2iYv7TX6Ke0WfLv/5xqSlXz2vv4TC6ihwxPc=;
 b=e5/CdATLn7mYZl7AV25aeVvQ750zLX34EPEBHPxnCvJ6cZ+DpCsev3uaIj7Ql1Smg7Ki+Gx1oXcEC6PCCRtojpVWZeBNRUKvZp8h9oF0Bs7twFyAkN0Kmm1Kz0pXWgqORRbVZ1j4P3oEp86laeq9DWidBNaayj49XDPdmIQhWpq28T1jfEzYWrQXqR5MJA9ed8hEpi7q+uqtG9g97u4IF4Dn5CrAH9VAtBtVoB07LqNm891U8jJ74lqf7t0f/L+0ZCjZ6/XLL7/db/fzXcxQlFiE/v41frwQhnihHb3R+XbIYmaOueGWwo4tWCIby5fhFX6Tec9O56HbLhJXLVc62w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNG/Qqt2iYv7TX6Ke0WfLv/5xqSlXz2vv4TC6ihwxPc=;
 b=litXDmxqyrRoVlBSaEDbf8YekM/k+Ugst/nrYkN56iMEnKhjcc6LwWbFmOjqFlKqlJHXAPlD3ntB2OrHdAt4OBKED/SCwBl3ifCH0DOX9EH2R4ID5ZvQOE3VOikSjz74u3J3s672gW/JbEYGoyZFV59TS6iEgW6FNHi/oxgTGi8=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by PH8PR10MB6551.namprd10.prod.outlook.com (2603:10b6:510:225::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Wed, 8 Mar
 2023 20:21:29 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%4]) with mapi id 15.20.6156.027; Wed, 8 Mar 2023
 20:21:29 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     lee@kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
Subject: [PATCH 1/2] memory: tegra: remove MODULE_LICENSE in non-modules
Date:   Wed,  8 Mar 2023 20:21:16 +0000
Message-Id: <20230308202117.426808-1-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0196.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::21) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|PH8PR10MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: 5500fede-e63d-4087-e51d-08db2012b36f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8sLT8WjHlVPJNgkyx0SNQmqdJXtvi0igMOmLRDzdefoTvgj4No1AdLc4S4b04DAAWDvAL/Mu7UEteSxVkVXkxE757AnikqR+t4hMIy3+58yN+lV+7DdcfCBvzbhCodUMIFfg7oCjzhne0lzParz76lzMVktso9Nrvbva28BQ4w+jX4m28nQf6XeDN0/fyviCUHdDvQrFhvXLswxY9CGLS+69EzGe1PUhXi71fFq2iM+QCBHj+u8SUk9LvBgvrhhwmyLwNa8gnJUlTw3u7MnT4CWQY0/hoaj/acQTzgHiIRQcTzWdWUgyrHIJWfYoGQUyj1RouWcjDEJ0EA04kSx/NGbE43mzK2GvCnygueA4d41UoTsk9KYaxS7qveD9Ok42zDYYqH047KFLUQV/+gw8gjKV5/BwQqzCWobP+R7zC3Lu07XkAuvpEr06USql4n+Jbp0060vYgI+9BH8BTv87ZxF51q20DlwgrhbbI/K8qH4EbH1qI7jYKzdc70nWhUuXjk2ke93TK15tv+iz0sHtnhS0W22VLUteJx9L6+VsnOcCI95pc/vOV+ZvLDgCBoFoOs08DmlB9LK3aU1qMDuhZe8jCr5xyQVG/3pIlJRlnssgK+/i5rDph2B/7x0SHX2YBcBOvqEj914xIcUPsTeWmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199018)(66476007)(66946007)(66556008)(316002)(54906003)(186003)(2616005)(5660300002)(8676002)(86362001)(8936002)(6916009)(36756003)(4326008)(2906002)(44832011)(41300700001)(1076003)(6666004)(6506007)(6486002)(478600001)(38100700002)(83380400001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g7UrmlexNISj2kGWDWLmKx7YvUjaWoUol+WPKwZN6oNlh2H43ugmf60Vfl5C?=
 =?us-ascii?Q?EJe65sqgiUU8svrHk42llBed6wNwOeGe2bCHCq6xIgjEUVAPPvaYo1XTTIdN?=
 =?us-ascii?Q?EaLH4xD8sXYecuVEtFc6rFdGD45FFXJQr8Bb72bN+57t88OinnBTAdt5L/tH?=
 =?us-ascii?Q?dDUBuqDRTvIV0CuYWYA6Y4SMBtCwiBVy6vJVwVCbm0DuIiCmJi/vrfm8FmCa?=
 =?us-ascii?Q?kNmYvzYQ4DmSSbqdal1fNI+ydjcXRTH2CY7heyGn0yb3nQI0YdjvsmtYzmUv?=
 =?us-ascii?Q?ySkslCdEJIcIdFIq2YTK4N9HsHmAZq12yrlOJtmIhmu2ANWl3YxtA6emBOkE?=
 =?us-ascii?Q?hpVoVDBmcmGXNQNACyXimivuK2/Po/8DEQYSjRBf8lqewBiVFEUETCCmEHIU?=
 =?us-ascii?Q?YEmvtFoQpa9RupkVc97i3NbRB0eTwbG/sO5+nrCOKOfZDFZL3tOUcKdwai5K?=
 =?us-ascii?Q?gt0qL8w1p422lJb+wjKrtVtu5KU39wiDDPLEVVnukzS9F68j/WdjGgtw2l6Z?=
 =?us-ascii?Q?sEnKFWnG/R5L7bfHhVmmzYpBFr7HyuVL1XZGxHwgLhWw4YCo8KSGle9hPK3C?=
 =?us-ascii?Q?996BrCvXi80UTcA27l0iWqYgrLhcLQlrUU8/3vmqMe2hxbbbtfkegAjvaPci?=
 =?us-ascii?Q?SMGXKdPxW1NorEPDkhpHdRWWifJa7dia5aeQahVM3VV568edGNF68DuHoMHy?=
 =?us-ascii?Q?AUudSThg5fWXo5DJozaTG99wOO8GJmizYnA70Zf/4/k5h4R8wOlB0JcqUEwi?=
 =?us-ascii?Q?p4BIXvK7pQpXhBpx+A1lc3muELIbECEO9T6GQGFEw2idaFwi+Yj5o8Ua1ScO?=
 =?us-ascii?Q?3Xx837Q/TiA+pNxH57U8unOiwbBk72VIkKkYYWaVgW3G+/pqreEM0iKrRRgC?=
 =?us-ascii?Q?kJ4K2fhWfYnsW6vK38UEn1vssdUV8EMNmtUr1pJ02rx77yrVl5DC0p/YkE0I?=
 =?us-ascii?Q?O3uWTLIqWOMXhtT6T+MhvgqOB+WsZKUD7xc1XZOF7SesuPDEXA0Bnlp8yN9F?=
 =?us-ascii?Q?Ea/6RfEvkLWqePOCDaAr55utK5vCq3YL5bmAl/aOmx8zF9OcTlNG2fbeLTZH?=
 =?us-ascii?Q?fLw404c5KdMkKGqVXFv3tChgXt0mKAaHzIisvAcm6+was2Qrv1Xn4E2plFeU?=
 =?us-ascii?Q?z9lR572b0jRwMpbyVt6nJukivf9kTSPvtKpxIAorMTm99QfkXVZBxfw+O/7u?=
 =?us-ascii?Q?DCoVclA5/hW3tlpnsgtoVGazBbR0vTNuEMEqZoiE6JLJj4Zm55KqeMRQQqNC?=
 =?us-ascii?Q?lWpRDKnXZdHtcg8kO75Z0SGwq61K2wbQ/eluGmf4sNNjNbLJ6ttvbOgc9Ixn?=
 =?us-ascii?Q?F7L+CntMSbPJ8WGnD6mgbZcXswcITF0+8LFd3ZWz+H73EWhSivl36wek7Dpx?=
 =?us-ascii?Q?/AJczcfZQ1mcyO5JsBtoUhIUGKpZ5c/+2DAxkmdFwkmWT5pLndzIzawOGj9a?=
 =?us-ascii?Q?R+MzLYqa4Ky1PRAnJziSGbIMYXlXIye6U0FymSFv1xmmjUXSZxK2yQqJ0sFi?=
 =?us-ascii?Q?v+PK62ZiZbPf7HK4MADMyuVcEoXT1uAJ743VcEuAdgkQT92wNZ9MhrmRycs9?=
 =?us-ascii?Q?iG38swkAY3+2ANHRTO7p+Rh0cfeoe+GMJNysqHmEMdJHQBQ7zfaKYuKPrUXx?=
 =?us-ascii?Q?ond42DKNTwh48YUlsmCltnY=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: UGH09eneoFcAkOuxgF/cytOU5v0YsEI6LXi48TCS/Jilo4+gEE2uVT2i58ZBzHso/f6JY1NitFAzdLtT8F5fS1ogtyXorTcIub2kuG3dMQp8AYfgrEvwi3qIa3Mwul0/hyvyeRa38XkdHpvJ4kzHSzjOYA+JidmvdI4dIMuRnrJf6DyiImjQXTB9y6rAO9U/MqgRrjrvoYsbUQmvAl+InMYywTKuRziOgspoMnFnos2HEvhgNPlcieypEB+zM9QN4oBPvpIyvF6le7XV0E1AVzU6Map7ERwsojxjZ/7/p+/f8NBDP/tAChJrGTDcgRmmMoeGm4KnKez+57wruy+esiVOU3s7zlWQsH6gKjEVDL4y2342+6bwuYvuGaIcHAgVx//4Vj6koS3nXBu/Z/1Ah3kYIM1OIgH+e1JjcnCKjcMylzH3aihMWBrfcKqlNcdo86iuwLh6yc3xvZt6mcytK4OwDzQY02+8rOnovl4bVh2WhZBlssSc7b/dgvGv7bwIHaQ2RXPGsN0pR2ysLbYl9D+Cmcq+xlCLS6vIgU2KMVzYIzPwtigIrvIBNLUVJ4CxGKSti7MgfOw6+4f9U7FJY9WC/EGoEGGxnwYgSVhLjKY6bEXu3ujZDGS5d4ujestbXTWojpjkgV0+WshSwZmaW+HcRW+q6ouf3SMH4d0RBKDYyIDz32f1P8zHHUhjEUgWs78Yf2KhRjBYo2K4S+u8pEVFLT+yaKNWqQn1nHbOgbWh0Gyb5WBTo5JHhA++i24cndPWNuvhv46oOCvdHX9d+KTHNsamc/RqO/waIP46x02vP3JGdM+PiiyPwXZ9zIPqlcFv5LL5deeh/W9cIaPRFv3tfWlkjYrKo+v0PaucbAueKU+Cmm4vaJK8qjtMrcvQb4lF0J7mM/0yCQREMgY+lQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5500fede-e63d-4087-e51d-08db2012b36f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2023 20:21:29.7199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C17Guk4wW3/kaNYCNF7fmUmFi0p3d3YWBOugq4zDIjovb0g1VXr69K/yDYFITyQ+Yr6P6egczWVf53MdmKS9sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6551
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_15,2023-03-08_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303080170
X-Proofpoint-GUID: lSap93nzIH3fTrbCkrVZOxPvhnk2nhUO
X-Proofpoint-ORIG-GUID: lSap93nzIH3fTrbCkrVZOxPvhnk2nhUO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 8b41fc4454e3 ("kbuild: create modules.builtin without
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
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org
---
 drivers/memory/tegra/mc.c           | 1 -
 drivers/memory/tegra/tegra186-emc.c | 1 -
 2 files changed, 2 deletions(-)

checkpatch-clean and fused together now.

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 5cd28619ea9fb..9082b6c3763dc 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -983,4 +983,3 @@ arch_initcall(tegra_mc_init);
 
 MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
 MODULE_DESCRIPTION("NVIDIA Tegra Memory Controller driver");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/memory/tegra/tegra186-emc.c b/drivers/memory/tegra/tegra186-emc.c
index 26e763bde92a7..e935ad4e95b68 100644
--- a/drivers/memory/tegra/tegra186-emc.c
+++ b/drivers/memory/tegra/tegra186-emc.c
@@ -280,4 +280,3 @@ module_platform_driver(tegra186_emc_driver);
 
 MODULE_AUTHOR("Thierry Reding <treding@nvidia.com>");
 MODULE_DESCRIPTION("NVIDIA Tegra186 External Memory Controller driver");
-MODULE_LICENSE("GPL v2");
-- 
2.39.1.268.g9de2f9a303

