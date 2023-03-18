Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0097C6BFAF4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 15:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjCROpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 10:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjCROo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 10:44:58 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2127.outbound.protection.outlook.com [40.107.117.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49BA29400;
        Sat, 18 Mar 2023 07:44:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifuPvy+aYpsS3YAHApNNcKmPBGLdqTvSBqOpwTBeDT28Zm8neTQrCkkGiKSWL8mBEgT+tWA+RxUpL2epCQjv51hCrQWZeSfWFdMiOdzOSNVQfLd/73Y0XGD+vdVqnjZHrOltNxehXXhVg5FZCYkhdrmKvfrZ7ZCEIKNm1xBTrx6+8Yv4/eX5S6HEHJ0++aG/ZuFY0/I6SXSHr8ePmYg3eNg0YRyq/eqkH0moiF5VUNZy3+xl6jHlqMwMKxhoppoge2oPxnYKwiruWR6b0HLANC3glFd7QhEl5KrstKsW/lDij4VlzwX7ba8HreAZGCtcocSDEByxJGPmvj0Sc7qBRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdWPrAePIX5gXg748q3W1bLD+b2XDJQ1Z+lyypoPNDU=;
 b=Bn38jlAEXZZQ7UDSiPAyb1xD7WBu9j4vptdJG2I09POKlE1VSg3sPZX9QDloNK7f/maah0g6iX9//2PA5+E5trVmEYfXSh/dVDEtxDoRynMey9EeYRmmEsuaZu7FkjTiQtcbXtLU1ajexT1W1a8KYcHu72MitzpD8jSJLhUvp1vjxeuYFJnbIcqth4B3Ho8v1KD3xOUBB6z2XmjEs1jKxQFhm+Y319uU4PgUTSB8nGHQ8O7g7aFt9oTF+ZW9TcJ5WaALX4vcG+tAxjn+lFIIHG1k0AsZvkr3/sRK72NShbyZ1UzXGxDYkH1Qp7aChsN8zpLEwDqcLbBH7Jj7gSFkYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdWPrAePIX5gXg748q3W1bLD+b2XDJQ1Z+lyypoPNDU=;
 b=beNiwhMd0qF66LrcdqZfpLjRVoeHhA8JAImzegl0Skqv9SaBj9demxauMjHsYjwEThfwmoOvM4ZDrxkvmv9eLKagJVDKnOLWgvv55LtdPa5i/jjn59KdYyeE4/KPXFRoutoaRaTU1r/Q6HVUKhAxSnPZrDBazfnRb6GS88/5e7zC6Wfnj0BRT4M3X0C9tAANT/a1GPDX9ubm/b+QOgUAYsSgqgUDtY8cFU0W1g9yKZyI0gpjFOgCIblwRfJF9aMri9hvYXQJglv1VCul4tXPFv5Cybid29jHkTcDHsKizZpfaswP8R+3OeLYE1jx7D+Yr4VEdRiwOHPfEC900ejusA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5283.apcprd06.prod.outlook.com (2603:1096:400:210::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Sat, 18 Mar
 2023 14:44:51 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.036; Sat, 18 Mar 2023
 14:44:51 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     Guillaume La Roque <glaroque@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] thermal/drivers/amlogic: remove redundant msg in amlogic_thermal_probe()
Date:   Sat, 18 Mar 2023 22:44:06 +0800
Message-Id: <20230318144412.75046-3-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230318144412.75046-1-frank.li@vivo.com>
References: <20230318144412.75046-1-frank.li@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5283:EE_
X-MS-Office365-Filtering-Correlation-Id: dd3cc387-7436-48d2-8d2c-08db27bf54af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KBvBDaoG59gwg3TPaC4IguELAvcixG6Q3mlXU8veS0749SmuuE2p5IQHDxjYLk1fuCiU7+1ZcsP7cW6kOCSx3Im8ZYUV7uB66VRBuSmfAI0khqUcDLG0g9XEk26ViHYY41sSwfahwMujiK4+1VSIPXkRMc8WxFDW1rQIX6wzK6ND8TlR5oEEELtvbLb0y5VVA9CT+U3Rq7Ot2EgcxSWeUXGg0ATcooMK++aET550mNv7DTGHAeLfcov50dqnROkI/Z5YZI1wICy4T2uOyX1tAdg0uXsASJ7Ug0sa5jr4mzm4QsRHN4KEguQ0eCV6oxgIyQECMsTclH6T9xObkRwVWNHGLO9wdEF4o6ToZuHikffUaERJSDn4QRj9zaO2R1nN5JuL04T5eWoT4l1HJdZPi/IP7sPicQN5aD6KzxBIq6szEjhy6pV+2C4FS692s1aQi9FfBBiBVFHfpo/IbV1WnY3GMiKx4fcr3KAFKAN67xnmXje4FPGYpVwN1qt/jTDN2GuFYc0UKTlL5sc5QmPuk8vPyfueJbmP/exa/WMXg3Tlsb1rmbpJuPi/1cIpXioFlNI6w7JqVZCg4UciN//8V9h5NnK/JX7ITxjCuM0PKI4UvkwaNlxmHq+mONkJa6St7jOjDMYCjlKn/HF0MshSpM2ssOAsB9vb8TfPdtvlaGBpyCW92/bzehutZhye4ZradndASrgZqqhHFtEZL2kfAQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(451199018)(86362001)(36756003)(52116002)(316002)(66946007)(66556008)(66476007)(8676002)(4326008)(83380400001)(478600001)(110136005)(186003)(6512007)(6506007)(1076003)(26005)(2616005)(6486002)(6666004)(38100700002)(38350700002)(8936002)(41300700001)(4744005)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?41q87Uf1OgnH4ZGgUJWPGmfALqiZVJ7dyEWOopVuAl7VoMb0KCS4prcAm7E7?=
 =?us-ascii?Q?5NWxhQC1jtsrSfjRA3AcxES6Qdl/KEYqoRcPRhE0AXamC2YHcyYWIx7qcg+o?=
 =?us-ascii?Q?YWepm5V8ecLJRoPcSiAqBsbPv25qUmo9cMzZYOjnWGMoGJBNBP9DN8jyzCas?=
 =?us-ascii?Q?paqU7Drx0GM48PihTztainv+6NUidvlzIVykA+uiecJBNJWYDZyMg2j8Fg/P?=
 =?us-ascii?Q?P/SXh+t2KZhxsd/+DFnSTE0EHhkWdyoICiloG1Iz2x5lQvVCN9FmiURHZIEY?=
 =?us-ascii?Q?97dkf26Qmok+jd6nDx5G8GfhIT2tsFMb11KagOlanlsTY4LkwWSpeD/BuJp3?=
 =?us-ascii?Q?l/2Q7UszK1umpty9ij7yrsVDoVfSZjTc1cqRK78IAJ/DuupmZ7XqAZc73LjF?=
 =?us-ascii?Q?a0LzmPf4+baaFxkgdFlTTEN1WQ6OPDyfaMwIg4JChlvWluMuMZrbPuTlw4dy?=
 =?us-ascii?Q?/3UTZdDxDPrYiuwA7m6HRqYQJrfrRgITJtN2shMlj6DJPfsMOK3FRJqGqGJr?=
 =?us-ascii?Q?BI1lsIpXEQUJ9XR8B7sNbMtEzPkluxpjZz+6S30gv8W8YPeWQ03oXVTTdIZK?=
 =?us-ascii?Q?prwEKVIWRJcLpmi666luMjWAsYxGxz+aGDLPWj/9MetcPTy5zrWkNgVzX9uB?=
 =?us-ascii?Q?0JXyZD98RpSn7FISRTZwztH0sx/58yZmQQ+hjKOPkxILdCx6t5KcRvRQuSpD?=
 =?us-ascii?Q?YCTqz0JwrZi3WkR7oZoMhfxvvxLZhALWzGdYH7NnN249wTu8YD4Yib0oEWJX?=
 =?us-ascii?Q?/2x7nrdrD1t4R/ra06OX0mrhsU9bicIr+cYkv0XG7mJLvz4yS4kprFNUGY9f?=
 =?us-ascii?Q?L0usxss8vnOFvfTDBi/zZ6r90iJeG4765pcugeWa1usShLO25Dhh/RC27Yfs?=
 =?us-ascii?Q?ZTa7YTOoxA0ksEbn7GrkejBe3R8qfUXjRqN+JBJEwB5fCHyygiTgP1PGNPwz?=
 =?us-ascii?Q?a0ghXaPV8mW6qJlRyXNb55Eu+v10H0p+f6XTVLMbubuh3WYS7UwUtkqf0tlf?=
 =?us-ascii?Q?OvME6vdwZncMfLcSGQFDvHHSsgQjCjTmf7GhT+saqKxyk1Jx5fEKXBtA8DrT?=
 =?us-ascii?Q?wFCMQU775ps6NNjtb05lX7UbbJ21Zo1aBwBJtyPAhD7ObMZeJxeHlX9yPkjj?=
 =?us-ascii?Q?0e5PoYcB0Mz0TAW6nJNTdXInjkgHS8RvJ60SSUlv5dgEWRgh8mdDRO7+ru+T?=
 =?us-ascii?Q?R5G1vPTYOvvfeHVHM0tX2jHua/mn4ZNTryd19zqeb4UnYCB1O76AkZ1CSYVP?=
 =?us-ascii?Q?XnyNCw5Q5IWuEgt0rmv5drHcEkL9xH63rFHH2lkN4xJu416BvGp898N360bf?=
 =?us-ascii?Q?Ebd4vIbyu+IZeN8vSgWz3fLz3x0tb3zbgqMKr5dN4oeVWnyCaRJmnarAqMvg?=
 =?us-ascii?Q?Ty6vGJQKgaTLSulu3KRGn+ct6j5XBLNfBfz9GjoBUwmy0rY4baMAXEQNtC59?=
 =?us-ascii?Q?gUkFNuR2cJ5462QmMJUhMobKgcJtQd0ydowtoCIty7bFbB1ImUA1mNQYbMUa?=
 =?us-ascii?Q?J2SwHOcKTqlgUAuaz+66PW4HkLS1KVbBlv0Di3UwMAwC3d76EqnRaPJ9yFys?=
 =?us-ascii?Q?ohdGfE+d3fvEvrznRFo+E9+1La7EyXuIi2RyvuSi?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3cc387-7436-48d2-8d2c-08db27bf54af
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2023 14:44:51.8115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cGwzv5zdIaYoUE0mqu44GHRrew92KUABnaCIXiGACOGU9zUu/jr5IHsfp8z0PgsfWdnHNQ4gQk4ZgKSL+XvWsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR06MB5283
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upper-layer devm_thermal_add_hwmon_sysfs() function can directly
print error information.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/amlogic_thermal.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/amlogic_thermal.c b/drivers/thermal/amlogic_thermal.c
index 4bf36386462f..16e52e26a5d7 100644
--- a/drivers/thermal/amlogic_thermal.c
+++ b/drivers/thermal/amlogic_thermal.c
@@ -285,8 +285,7 @@ static int amlogic_thermal_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	if (devm_thermal_add_hwmon_sysfs(&pdev->dev, pdata->tzd))
-		dev_warn(&pdev->dev, "Failed to add hwmon sysfs attributes\n");
+	devm_thermal_add_hwmon_sysfs(&pdev->dev, pdata->tzd);
 
 	ret = amlogic_thermal_initialize(pdata);
 	if (ret)
-- 
2.35.1

