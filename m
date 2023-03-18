Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45956BFAF0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 15:44:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjCROor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 10:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjCROoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 10:44:44 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2135.outbound.protection.outlook.com [40.107.117.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443685266;
        Sat, 18 Mar 2023 07:44:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzZ5X5HCXsWVOPhAuFzSN1UwD8jJZ8RLIfnAa1ggxH5+k54MksDWjELvwVEPkPEfNJSyu/j51Sm8LXZVbXElsjODI62dZ39rz4rKzASwuXJs5p08XZBy8dqNsK4fZUfYjqJ3X/7DVYwmAXgGjn7YH2kglU5nHzSHiuUO3mfL0iotGUH7tVoSdxwcdlzdaVR/gQHtNQz2G1puCk0GaEOcs3/DkYzTGx7MkIfGyDcAvldNyyUiYgYSLfenPqd6Oi3Os4bukO5GjABykVN09k5M8DS8amT+0XAn0lIBLiptlSTwBSfQc8IQAT7VCZGMbASs7vEBjcv3uTLduL2QVkTFsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g+NlqBmxA2Og63Ol9FtrEG4L5yzQxZAUCyz9v4IE/T8=;
 b=HH7JLXwPyvHgyvjysnVfjh7mx7K6oxOc/Y+Cb+mHLxAic6mJpz2kLZqyNoaGwzSKI3f4QKv/h29zDTIAFRBzRjK+uScjQIbV3Cs3tbZW5Gb+ZXC4qZeXVAb/3KiT+IMhCnk1ILWYXgFPxKJafssuICCPJuhpGMLZmLf25A8J7YEOxB1C+MJhE9XZYR2+zNiX2QZgkR4z9Fs7uZ8nS4A4H3clVxFMFu1B4Ehi+HPNQ3Qk4bYCnSmyug8CybM8Kx6lG0Am5I6UJ/Nn/hGTl12vsCScw5wfWycq887bBrxtH8QJVidTowba/5CAf8gBEYF1bZRcnJAHCx1aoT+NCUQdZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g+NlqBmxA2Og63Ol9FtrEG4L5yzQxZAUCyz9v4IE/T8=;
 b=h6fzTLp2udDZTlPvUPq2p2Po6M4G0VCWzfha8c04oefpEI48Ga/N1MIWeQviF5UAdL154WtSYSCO4jWfGgDA5yl/eZISE23NjowepoU7d1xgAKohLB08uaGQRyG6ShlKquPXNBEBLFmgRCcn1OWImws8p9MRa9Lpk2uqsRQ+F6+iNKcGcjZ1lEjO8dLDhjfno2gYndUR3Fd4DSJg9ldTKtDZwgYccJwErJhLs3oGTCnTnsyTCidegDH8fho4Dd0yS0HKZqy8jG//yojIFRsgKwK3HiqXG4SGdIE5Ix0oW/CQfOX0pmHJxCix2g1wAhNNAQSYZZwF/X/+zEUI4HEBeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com (2603:1096:101:78::6)
 by TY0PR06MB5283.apcprd06.prod.outlook.com (2603:1096:400:210::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Sat, 18 Mar
 2023 14:44:35 +0000
Received: from SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869]) by SEZPR06MB5269.apcprd06.prod.outlook.com
 ([fe80::daf6:5ebb:a93f:1869%9]) with mapi id 15.20.6178.036; Sat, 18 Mar 2023
 14:44:35 +0000
From:   Yangtao Li <frank.li@vivo.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Yangtao Li <frank.li@vivo.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] thermal/hwmon: Add error information printing for devm_thermal_add_hwmon_sysfs()
Date:   Sat, 18 Mar 2023 22:44:04 +0800
Message-Id: <20230318144412.75046-1-frank.li@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To SEZPR06MB5269.apcprd06.prod.outlook.com
 (2603:1096:101:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5269:EE_|TY0PR06MB5283:EE_
X-MS-Office365-Filtering-Correlation-Id: e8c128b2-e4f6-4ff1-a026-08db27bf4af5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t3UaLwJACAcC4JNZYxz8UHvaA47GfR2Snl57Moq92aVGaxrjB/XSe95G/yRY+SqySFGmEaGj+oakMqbmm/oQ1OXK7r55LSV2USw2TEHV6bjfnROjKG02z4ng68ZsQvWvXzdT9fJNK/ZIfaGF3hP3HlTd05WnM0zZyX6MbeJpQAHki5svPyqHiLzrou9KBwjeCunAdQEEbLRIcPY4UiCrDQMyph0COD46qcsB9/XWvdhFnjtK22lVdwtP1yA4ZAXGi+BrIDiQXz30GxYzcGYSy+QiLoIEcwE7ZV+kzC4z0Yod0vk1wlQwfXBLYu9iNl2upQZiyeje7W0N/2TG1tqiucfNgXBzuJWzkKp2DUcfR6LRDOdV0ssIO1QV6DRasEwiEuol/9CHczef97iX47fK3TbklrHdfiBbhyW6DicgLu9YYMPHqlOwdEjNedmv3LvKtdo75KE6Du/SeDiXGOXhy5MZx+NWoCKADOn8N29/8HJ7ijRM62GdmeTaYXxcnmMNiNm5KHv/Fw6vQURCINzcqjQoqWNFXe7n+LgGc1QRTBlVhcn9wDQ3I2N5UcVHz/vLtdqVAM0z24W3iE+sKqG0vphoCm0ht9dQ0huqj3jNbpUzhNEhbZAFfL/szOxkNW86BLtlQ8T0YOadwk/MIrabIBms8u0NOjq+zPsxQvlzGaBpVz5wxeAsEw0emotOgHbV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5269.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(451199018)(86362001)(36756003)(52116002)(316002)(66946007)(66556008)(66476007)(8676002)(4326008)(83380400001)(478600001)(110136005)(186003)(6512007)(6506007)(1076003)(26005)(2616005)(6486002)(6666004)(38100700002)(38350700002)(8936002)(41300700001)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xx0csyT05QBAYQlt94arwS/NSxUH5JWAXjIhQ+e80HhoQ3waqf3Y8qLH8NZL?=
 =?us-ascii?Q?MQTXbWXprOIR+7QaPrDXN4Qnv1b+aLO7h4+pu8qjhxuc2f4uKM9Dx5Uo40ZU?=
 =?us-ascii?Q?GtvTPVMxi+RGkFYYd4vbutYT30jSuaatyA7tnx2POuTfpUfARL564QOSjpso?=
 =?us-ascii?Q?O2gTBQcRM+8qwcEtYbx0QRJeI4NXVPV3XAI84H5B+qvOUDrKGmsOxdti+Npu?=
 =?us-ascii?Q?urya0Dx7TtzvsqO7sFKPmZLgFS9S/5rev9RJpOG6dNdlVStqhyJohXFItZfx?=
 =?us-ascii?Q?7sEsFVpzfwjtvr3bBTjbzR+4mhjyuG/3YZNHeZOZK3DwKLqYvNyUZgZ5lz97?=
 =?us-ascii?Q?flIlCUVGYiM5RY992lNUJAYY0sv0ADWu/pIZGZ0vCfRPeRfbH8KuwGFgJZt4?=
 =?us-ascii?Q?JEtL9GiSsPGN+VlWjjvfUH14SpOGoTMXxe0XZxOEwXJMUfsZKWYWEXmGfdA/?=
 =?us-ascii?Q?KgxCvE75wGJ2a4ofRcvn8S3AELmdfHBUXUUz76NuGuYYb6kNBGZPwnGh7e7n?=
 =?us-ascii?Q?hH7f/3hR+t6oghecDTGErULFdVfE0DlgDjGgoeE9E/dyK6bjJ/Jr6ppW9NsT?=
 =?us-ascii?Q?BREcl9oFA7TnFhYWiUcYeK8Vurb+c/0TnZgZMA40+XTrn08TH0iJ0uXNiOcz?=
 =?us-ascii?Q?KTtsoorIr3ppogzDanpyWx0LHKBmUzNOOzL2oBiYp2PHd+ShqH0BevGK3wr/?=
 =?us-ascii?Q?gofvunUl9anvzmMZt0p/4LIuLugmTqUNaVo64ShiVJWHNDnORFXiVFMMriaL?=
 =?us-ascii?Q?0MHVeAB8efLuaRhlk9gIjtKh1MHT7o4pjIcIb8FidGQ77TaT0+CF0vercLZV?=
 =?us-ascii?Q?yeHWSHpfr5avW5tK+QrmkOeya+kdsx91AcRwVIP+cul9fC4q4wyNIWF2U7dL?=
 =?us-ascii?Q?FUW3g1/imY2ADV00E8Lv79yMYfm5qtebNfkXAkp0Vcxx8Q4wEVuBkk/BjhZf?=
 =?us-ascii?Q?l3lZNu0CMOCAfMuGUZj/YSYzpE1yq7Wu3Lg6JwPH7uJqDJkPaubJ+zPXbK62?=
 =?us-ascii?Q?0xUVJg6F92jzsdTr7cIJqC9vG3NRMowIS0aCNN0zPdNoDfmzIAu5Hbv3nv4U?=
 =?us-ascii?Q?WlQvDZOZ6qIlOea0PhZP6evvtEbNhXaLZXXiL3f0re5JyLrngn6vUAkhr9qs?=
 =?us-ascii?Q?+X4oBbLBG5CgIHpJxwKmqmockAKgBIKtjPX+WmylqVznp0rIKIKaapIZF3Bp?=
 =?us-ascii?Q?2P7GzY7o9d/GTreMDOh1KY/ss1PHws5j/bVhGuucZsUcOimH2q4Zx1dTSXSI?=
 =?us-ascii?Q?FPibyJZzLG4zb4eTRPA6KA2OZAvCM4/h9RTz+r+D0ERipLvjtRBtqquSuMSU?=
 =?us-ascii?Q?RL+I5y3Er6GotiFYY+i655gAp164FMJymLXZfp5T3+jGgm1I0eGYKq3qRIUw?=
 =?us-ascii?Q?lB0emT+qn3uSpNfGEfkMKsXUrrrISPYrj0TzTX2e5LnCJ1AAI+Y0wk7V7pEY?=
 =?us-ascii?Q?xJELCNtCFxvNSszjkMUXnYpkxXBj9hoGoXfE2MPwRmRA1xze/IZ2D14Wrkxe?=
 =?us-ascii?Q?UuzPnnKuGJOyC9LqzHl5oIy3Xp3lefRzxzveSvkU2+OrdAOa6ForL26RBAKH?=
 =?us-ascii?Q?XsPimgBMUp9BkxENo77bVbvD0SB9oKPR7Incb6pw?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c128b2-e4f6-4ff1-a026-08db27bf4af5
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5269.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2023 14:44:35.5573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N62YFwcwJejKkuKHP2912b4WJVCmJ/iYNHlrEfjcYS9AsWCfIhm0aZt/inQoPvCxmRx2ZtARoMApq2VFMLV2bg==
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

Ensure that all error handling branches print error information. In this
way, when this function fails, the upper-layer functions can directly
return an error code without missing debugging information. Otherwise,
the error message will be printed redundantly or missing.

Signed-off-by: Yangtao Li <frank.li@vivo.com>
---
 drivers/thermal/thermal_hwmon.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/thermal_hwmon.c b/drivers/thermal/thermal_hwmon.c
index c59db17dddd6..ae87401b1a1d 100644
--- a/drivers/thermal/thermal_hwmon.c
+++ b/drivers/thermal/thermal_hwmon.c
@@ -271,11 +271,15 @@ int devm_thermal_add_hwmon_sysfs(struct device *dev, struct thermal_zone_device
 
 	ptr = devres_alloc(devm_thermal_hwmon_release, sizeof(*ptr),
 			   GFP_KERNEL);
-	if (!ptr)
+	if (!ptr) {
+		dev_err(dev, "Failed to allocate device resource data\n");
 		return -ENOMEM;
+	}
 
 	ret = thermal_add_hwmon_sysfs(tz);
 	if (ret) {
+		dev_err(dev, "Failed to add hwmon sysfs attributes\n");
+
 		devres_free(ptr);
 		return ret;
 	}
-- 
2.35.1

