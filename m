Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35EB6A1E20
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:09:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjBXPJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbjBXPJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:09:44 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4A76CF21;
        Fri, 24 Feb 2023 07:09:20 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31OEmr4o005509;
        Fri, 24 Feb 2023 15:09:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=BNcFU15NfJElmhuFh25bY87V4OCQ6QuCZr37ORAhor8=;
 b=QwavmYM3Og1u24BXuJNnLjPBUIRqJ+TJ8CXheP45d6276PZ9ec4a0+AFb2p79jbmJmoG
 PmHQbzYnflj8l13BbGo8fAArgXhhBvO1o0nPXaqj2blpYNplDD8tRe02MggOfCbOTiXV
 ADgYe6xVIUgh9/3yZ3ZKmO8JwM1wKjsFZhPF5gT0P6iG/GcK5TjxNvGuArIPGnjVSdMw
 bbeub8eutTOLYCHwzS7yqPee8q5zmzJxcWqVdoDqv+YRbqNdRQZgyzubei5mRmsLq6rA
 XJfb8snvQTgGG7RBvkT0GXnOkGh4SK8pjwLS83CSZeoYkjMryBADxeUoup17YT/Wp0xV 9Q== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntp9tweh1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:09:13 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31ODioFM018042;
        Fri, 24 Feb 2023 15:09:12 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2042.outbound.protection.outlook.com [104.47.56.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn49v8aa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Feb 2023 15:09:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3fMZ6hX7IIDJE0dS5i2FmGjUFPFhiBpneTERzPumwiL5mzjYw6fDczlZpUVzDCBCExtADIA9kvKtJTVMKJ2opjC407LG6qLx4vbr0OBOyaUYVyNvoHyc+754412r61uwLTTUgSHD8+gjlD+O1ZTT0LizswOXzEQqAqs3wHl099zeFGWcbnBe58EZUM/zFvSjaKz4/8v+yki9zpeicQZ38RuyVoE/x2OqeJhtxiXLsB9uwNkMVMR3SJUoeHfiZFbKjMNNi6zpRyvWEmToJXqchO9V0HW2rE/7dMcnEQiqJtbx0ZukpvslBdbxES65xHufWgqcn49rLirh31nKLsHzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNcFU15NfJElmhuFh25bY87V4OCQ6QuCZr37ORAhor8=;
 b=VmXam/iDEGCIMjwtamHnovX8EbQAWKOyjhiCKqDy4c3WrjTRGHu4coa1JIrWr1pO9nX9ReuCWv/CM2CxkUCGGUrJCJ4UhkpuHzK0k6ipX9SmKNDQby2YBOCV/NkX4SSwufniUm0GJxVlQoTTpj7Lpq/juLXfi4wzzAU1KAIPZf8M6dKSyN9c2werDFarGFNJ/HR/wN5PJ1ET6nSA7C+Geydyo1nT2s+u0hRchmSJ8ehI0GWQrYHGFNA5gp5dYIveUCXhOC0H9VgN7qBBxj13u0/AzVAuArQgmoSLNlT8p1X1MWK+y6SzrNSlBzGnfMJwRp8gyRUVdye9KxXLuf+6Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNcFU15NfJElmhuFh25bY87V4OCQ6QuCZr37ORAhor8=;
 b=ke7Nf0DcNEzc+ZwzjM4943m2VNBg4e7GDcRNk+LZh8LaVjfMhQZDQ8X49wqVcGo8m7Qbxxuhzia5ma3yQYK7T4xCO3+gWXYgMp6Fr252b3k0YvvQCCa3tZ/vIr/DgmFAe+VT1910DVEF12ax9+TA1RqrrXsC4Rxtn8sfjHwIuDc=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by BN0PR10MB5303.namprd10.prod.outlook.com (2603:10b6:408:125::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.11; Fri, 24 Feb
 2023 15:09:10 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::d0f7:e4fd:bd4:b760%3]) with mapi id 15.20.6134.019; Fri, 24 Feb 2023
 15:09:10 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        linux-leds@vger.kernel.org
Subject: [PATCH 10/27] leds: remove MODULE_LICENSE in non-modules
Date:   Fri, 24 Feb 2023 15:07:54 +0000
Message-Id: <20230224150811.80316-11-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.39.1.268.g9de2f9a303
In-Reply-To: <20230224150811.80316-1-nick.alcock@oracle.com>
References: <20230224150811.80316-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0027.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::17) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|BN0PR10MB5303:EE_
X-MS-Office365-Filtering-Correlation-Id: c04acc0b-208d-4216-94a5-08db167914f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CrVyYKW0BQwWapnS2mcQRqasHi1szQbH+VQ0/BCMWL5DYfG8DuzBtXorMPJ7ld81fysGNzBpzXreMQEirW4388MdV4TAVygcm31ag28/qlrpMBdEgMkYH8QywGi5mA66qPBRr6CJgYGOVX7p9nOFRtUxSwVRS8C0xT+X1nrhRfciaCSntEkpj/UQk4Qpf+ARkFgco2rnLOSXygzpGEyvj3lVVVmXvHTjCfYe8NrqUA9oDWmhEE0kr3luvTEPRS9KSCyRt/b4hZGVr8rdYVDl1s25vO7ShOM2hy+vigaIgbZadpcjQo4G3e9az8oordIFTQaQrC4ivG3wPOLrCLxftAwrl5Gf3X21JzR4+HATPjESK/unQlolAY0gGZBUzuLDX6XmhpKEOgYHyNRCNRgX8fDt2wEH9pieWdwzeZhf7i7V37iyX8HG7Cty1SbL+7vxqyXWPUjfcK0WE0MoHFx2eyHLI3aTTYJ0pllQgLblMvn4yFMPqZ5JtqXoqRk34Bz5KQwEKDBZ7fOcwQ7jSbiLs1Wq/YZyQ6YW/1dJuidf78rHof9pj52Dq4TUvdTQ8EN1U5W5EeRoGO7yV2JNQ22lisqCAjPUmgSDAbf/0QdkYZhbbpx6odXEYUXS1J5Xxlblx9YJFG3+shw0XcKSG/sc1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(136003)(376002)(366004)(39860400002)(346002)(451199018)(36756003)(6506007)(83380400001)(2616005)(1076003)(6512007)(6666004)(186003)(8936002)(41300700001)(6916009)(4326008)(44832011)(8676002)(5660300002)(2906002)(6486002)(478600001)(66946007)(66556008)(66476007)(54906003)(316002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eY12tJZeelPC31vrF3IkP5k7OpIbjTo/KVksMd84nBXSFm6W+M+zBUIy4YcI?=
 =?us-ascii?Q?jwy5GQ4fQ/4tTezp5kiWItEUpBGg8RoaKzvLwNUT+8hjDc4M4dziWXLQUBlZ?=
 =?us-ascii?Q?KTVmUGmiZOxOLHW6RpnsEbq7t0p3rICVfP2pW9geQBwvDf5QZFH0XHbQkddz?=
 =?us-ascii?Q?h5PjbZx3E3YlTVGONmsZpMDE1EiLLrHBRAeH5gGbLqoEnedGVHQSKPvWYcfA?=
 =?us-ascii?Q?nfxXV+XDS6Z7AR4vJWWy0Q18XfaxXMNKbVnAqSn8H0K2sATVJOwtjvXMaEJF?=
 =?us-ascii?Q?+tvEqkBQPd5gHboD8lQ8l3fdUxM+s45F2pCwwxOP/B3XQzqWj+lfPxEUL+LV?=
 =?us-ascii?Q?OxeSGR6OKknmVdd28UJa17SP6syb4TsikQzaLQlO11UGDI8qik47trMsP0VO?=
 =?us-ascii?Q?BGjj2rzFPk3w+ejppUz8uD8a8AhpLsWSI5sPvlRfmHxIgQU9rf2QQjSWHV+X?=
 =?us-ascii?Q?/viG8Jq3VUgUEsPIkJ1KOBCnFhzbaLZPYq904EHsgeYDNgI4dXHKGtzdANhQ?=
 =?us-ascii?Q?J/IzM6yYBLGj0Pl7J4HmdSDai+TR5n6xi2DYcHF/i7QPP+REyHKQwiqX2j5t?=
 =?us-ascii?Q?8pm2TyNBrUxZ+F04AbccMaEAPyvZYQpeREPJ0vU935J4fHTIslrxIab5yjSt?=
 =?us-ascii?Q?i/lGn6lU5Vi5cd6yGDVaUaYDW/qEBmUQ3NrVG/jgSGqO+F0EbBLK20HqAaPp?=
 =?us-ascii?Q?2/mEcxkLj7TBIydmk/s3nzsNuw6j65d/fTZL8zBPT/kj62bnxo0ETLXyaZjx?=
 =?us-ascii?Q?Vbe+kY48wEPPR3tveMufSu7P4EneVY8TF9/lv6pUnpvvDDDL1XQYwB6i48v4?=
 =?us-ascii?Q?OySd/l6R09cEQF8rFQazputJHmx/HIey07MQU9D/uJLc3qIinSMFt3nJRZj2?=
 =?us-ascii?Q?wcut66dlu7T/Vv/A4VeBiiwZhyp1GBJMxlkgw9VTgEgoeFg+J50iDgkhN6V2?=
 =?us-ascii?Q?tQtFaRrnoXzylXhpyYdN5mMca9MLBSDGCzgkuXvHQMPwcyIn/c4+c20yZzEz?=
 =?us-ascii?Q?JllcLp6Rl+FBrTBn/sYMs0a02yCTIzbm/HoNefAMJCHzrdXisUetDYkuEcAK?=
 =?us-ascii?Q?KriT28BNKca+R1YTMgBsVP6v+afuJaM/GP4bcVD8A4vemA4uIKwZ4g1YBxuk?=
 =?us-ascii?Q?Mc3lSEX5g5KRtyIYP583x09Kctf6Rqejlb4/ly/SK+2xt2vvrJhS5PL2ltL3?=
 =?us-ascii?Q?lKxvLRg70KySbmzYS9jJCFzFdtcR342TnCiZR34o3Lzx0YBJ2FBCE7GyFDQd?=
 =?us-ascii?Q?kaOeFkZMZfmzBvkGoEObb4O2G8FCFu8SjzeYJKHBv5rdUj1xv5UnNP5LdaTk?=
 =?us-ascii?Q?WF83I+YldcbzadJMIgX0Pus64DCgG06Yx6gy66Ox+z4wz6ymrC6bY+MlLSnL?=
 =?us-ascii?Q?E4rBDy2jjtBzIwXp4tXCw2q4k30WApMigaPBIKwWcTnBlS3L+3Au0vnh7BN1?=
 =?us-ascii?Q?eGcbgmYk5Ao4bamIpJgbyOqDyslxQIC0Y0MAs+f6rvdVqtEuoF7cFtlUUxc0?=
 =?us-ascii?Q?cRKtzISHhwvxm9lRfMynVH5wbuB/QHPODrIZjDeXBHJWyqMM/GY9vuI2ABUj?=
 =?us-ascii?Q?Lne2DDwiicn9XMv5dexS6eLVNqwrybp6D0///8ULhv/x1QMJUeYD63Ltnte4?=
 =?us-ascii?Q?5gDd148FZ/SPKpqLh9FrccQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +8iV2RJyWnzd9FsXPFyEspVKTii2wJ9auZ+DkoKkoSzAN47pGiCGjJDQYd7flRy3ZmYe/KTViLWJj/m129PzU7z5t0Yg+9aQX3QaTWXz9NPELhvx/0BgmRb3fjg5myOAfKUMMGxydfHKVrbAXuF0bAvKqMIihsBiJvBig7u6/f9Tydmv+KYAfMQKGd2eRBKevEHZ/P73FFoIm1dEDvjWpWxmmNUu/zKc/6PJ0TOBRT7PxMWYgSPYXKcnX4p8MN6EDd0Cnpj42OYNC0T1Cspt8HfdkUDIsRNqlURE3RnOVmTcAlEAyV1X4kLJlRn8AQia3bSIItopifRUEjn6RZ07dyfpFsqcfZnKWEWd3RVseG3AAfxXFx+2rry8o6MHDD+GVbdbzCrMN6cw3k/vHDd3pZfIBNg6DAMp5S5LOnImUHY1+BTucOuII29ZdwY9hYBoNDbl9BYpxm3/pci68lk92qcy0t/oZSiAyXKORcTi63ZxfyHSrcuJsf3v/gXfOpX+80NdF64/43n+d558u4ESupj7fG/QDHpod5Pb7KHlYh2WF+DtegEsN/QX8PMrUgKA8zB6rDn3QCs6yP5VKlspscmT4k3qwGTSO5a3dSZccKSsX5yz5UWks9Vb6Z9UqmsRKTQNN9r2K3eZkgSKeGesw1EZEGYI8X7cFKGFw5gjlW4Rw6mRkmJj8I+6nlTboiU+YBvE5uyLY3lRv2BHPX4bqCJ3I0QURvTx8HP7IJOKSTojCqUrmrkgoiQDYKmI7Jos4ih779MNsdoKHnQH3YRtg9t1aqJ8c+0w4p4JIBGDLQCiaRkp2YxJJS4dxwsFweJwPjpvtjFU2PUDXLdgpTKi2Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c04acc0b-208d-4216-94a5-08db167914f6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2023 15:09:10.2552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fLkCLQ0iXm8iDGfRQR+MisVie7dH06LxQCvOvsbmH9vPscDwR6kG1REnEWBtBPAIchpDD+s36UT4GfH26TLOSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5303
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-24_10,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302240118
X-Proofpoint-GUID: wjsiGknd0mhG6Msv7jNZFBybNnz91RRu
X-Proofpoint-ORIG-GUID: wjsiGknd0mhG6Msv7jNZFBybNnz91RRu
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
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Lee Jones <lee@kernel.org>
Cc: linux-leds@vger.kernel.org
---
 drivers/leds/leds-asic3.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/leds/leds-asic3.c b/drivers/leds/leds-asic3.c
index 8cbc1b8bafa5..bc7e96c3732a 100644
--- a/drivers/leds/leds-asic3.c
+++ b/drivers/leds/leds-asic3.c
@@ -173,5 +173,4 @@ module_platform_driver(asic3_led_driver);
 
 MODULE_AUTHOR("Paul Parsons <lost.distance@yahoo.com>");
 MODULE_DESCRIPTION("HTC ASIC3 LED driver");
-MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:leds-asic3");
-- 
2.39.1.268.g9de2f9a303

