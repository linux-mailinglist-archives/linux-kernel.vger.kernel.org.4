Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B83B722C48
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 18:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234898AbjFEQMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 12:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbjFEQMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:12:39 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01olkn2068.outbound.protection.outlook.com [40.92.64.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797CDF7;
        Mon,  5 Jun 2023 09:12:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wx5WaknvSozbkKTuCwnKL/yZOqj8V3xBHRNWoiu7RHYLj3d1bFjV0lApI/BkBl3L5TGKDOTzICCLuPCz4M2rZiWbnpbkPq5IhMmoVTfkH+0Rm+cReX1GBzMMkwS1M79lwWdfV1H40obZkeMeCOWlvgq4pH5esfParXgAVVXvO3M2yW8vhW4SrfJ1mIuYyo9uIMyPuf3d2EqeSS2Q/n3arzi1tpVeR/H+g8S06qXsv9B9PTq3tzUu+a43SDtHczAr1GB5O7XkbglEFx7vLwCLzW1eihXQRhzeZZqNXCs+KZHY/2h5wQHv1PoIm8/oG0B0fR0GEZIW4e1vAohXaDZQ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6+oHIVonsmSNprk30DBRxfADmZiGHHbgnu7EaJI6WA=;
 b=bpu653GlhE5b03sdF532r7T6e5dSOvwAW7cUfYhRne6aJH9ym5ptpPztWnlG2Jg26fDqooWZvE9JMGhrKZUItSVSET7PknelmebNjwEecUV+tpioMPSaQO1J5jaMb5V6rAK673ROB8WEX2BZRpFn6attTTWD5eOn+O3o16vClRns5b6xonBmZNLp9LeZjFfvtqzU1DbX/hv3IivCzm4HMUosAk+MEoWMLiQCzn+zo5OzKW+VTTy4v35PmQ+S3sNE/BYz2+k30PvmCF7oCu38w9vU8c9tJ+NwrEDZmzJRk6O3BMF3DqFTHx/TQwjgbwYrJRtAxJ658+fz24X6LRguXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PAXP190MB1631.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:1c0::8)
 by PR3P190MB0938.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:80::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 16:12:35 +0000
Received: from PAXP190MB1631.EURP190.PROD.OUTLOOK.COM
 ([fe80::3519:4745:1283:abd3]) by PAXP190MB1631.EURP190.PROD.OUTLOOK.COM
 ([fe80::3519:4745:1283:abd3%4]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 16:12:35 +0000
From:   timo.gr@hotmail.de
To:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Timgrau <timo.gr@hotmail.de>, Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH] lib/Kconfig.debug: fix grammar in RUST_BUILD_ASSERT_ALLOW
Date:   Mon,  5 Jun 2023 18:12:23 +0200
Message-ID: <PAXP190MB1631B7C90A99FCEBB1594AAE8B4DA@PAXP190MB1631.EURP190.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [5kVxFmp9KVqaKUyCsNIKJuWTAeCF1oONG5RCUyMdD7t8Z5ECClGDea5cAn0LsLiQ]
X-ClientProxiedBy: FR2P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::11) To PAXP190MB1631.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:102:1c0::8)
X-Microsoft-Original-Message-ID: <20230605161223.52759-1-timo.gr@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXP190MB1631:EE_|PR3P190MB0938:EE_
X-MS-Office365-Filtering-Correlation-Id: 15cd20a3-720b-44e7-ff38-08db65dfacb4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QSDCo208MsgXISp+uJXJT8C0KW1LM3V9QrZ21QBg8tythxVTzxkcAPz/B5BjyUMQtjSmye5OroXimGgLPkS2651YQnsvp0bXUshewBOsjW9vDu5HzMne2picjzbD2tT+fm9bibLNm8gQXRtJN8feoG/Tt+7WCyEef2kjTfKECWrvDMb9lNjPBTeFYo1NiAzgNoiGwcULNQCGYhAH3PQsHSYgcD71OcqL5d84Ev1EB8tjBoa2S8sBG6NgtIMavT19P4dfrIhn/oMlb1C4j6nl4gC4iafbELjEqem+RI1zl6Zo5aHHeyk9fGnP1rMPkCY8IrPmeVaUGdYTiZsSAk4sjZtiB8Jy+VZCiqmyrazYUYEgPe7vP3mCQucqNVeoNhV4tbLJiBFMFZfRSfpt0jtxQlqLohHvNBajnL2C4bFhS47vy7z3N+lEngq+B5L7btH+c/b7LM02bXV8v8bi8FwTttr4GbSCjv9fR6d+a07gGWAWW5X2V5c7J/WTbTE16FJ1uTj4fLFCeO0+FdM4EH1IwFsmoKA5YwCM4q4bAY0bip2KQVwxcKPqcXd02JTncDx7mFuiJsDmzvvdtSxhcpcwX0r85AQBnIMERMyBQN+mCCA=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DPfNtR3X2TfmjTRBj/r0iZNNRfiA2ptnLXQgGJOnJ4ZSCw8U0uv4JZtckbyv?=
 =?us-ascii?Q?rmocquTr7h8DdYZwxsVXW6z1JeEKwHHQt9bvTBNpS7yIEC7OWtNI1H3XjxpF?=
 =?us-ascii?Q?OBbXsQU+v1s17WpXlvckHTHDivb725YIyD7guhDXHyHaQkc8fi9OA1/pImt7?=
 =?us-ascii?Q?+s489sp11pGa8lPgUpv0IkUsWLfzozkZKM/K9MHUSM6t2TBhi0SIYR/nxrys?=
 =?us-ascii?Q?D0I2jAB13juRAvvp2OLh3B9mQlfq0K+vTngVc2gwWOmbZyJ7WftCpYH4V7fb?=
 =?us-ascii?Q?ldOQMUxyN0YUCeCctiLWdJ6gh/E0DYcvNtkiQr1KcdXV90RKfmmFQj18QIoV?=
 =?us-ascii?Q?BaV941RSLScZvY0sdCF3ACsijVDnAMo4Loj7SkhC0kLI86l6Qm3l3nxIuN2l?=
 =?us-ascii?Q?HiJQa9Mhyi0TqK2MC8wlMGd4cCN6UWZnATu0smaIkk2fMkaja4/0Oje8fGx8?=
 =?us-ascii?Q?SMfbssXDNgmMk4n2eUIsOJOondZS+ofe7w3n0uQ8YUtHdDLGYmYqGJZEnGZg?=
 =?us-ascii?Q?7tVnkouJH66Iqi+OFLZtTI+CDCi7GMCybm3DnPvSGerK5LV5tWvvpxATu03i?=
 =?us-ascii?Q?GqXRkG7+q0LulxiJucAIrJYS7VL4PtEIS7UubjOQomlXDAqLEk4TNVdnrWoD?=
 =?us-ascii?Q?IRuZ6H7axbnfR/3AXLtKKvSfcnbJykr+bEFPTfRzzce9TwQFJ+2BOp4d1U6w?=
 =?us-ascii?Q?cTmL61ZcpiVUTsDYRSiAmUwqXOhItXNLzHxedDl5gvqTPzxDzffy0YR/YqvZ?=
 =?us-ascii?Q?kgJLI8bezAfjj5RyqYT8T/I0u9bBdGcre1unSBqLmgbUZoHme1eyaPSV49JU?=
 =?us-ascii?Q?GTrTqG44mFfugWfXZnyzgPujwpVcHu9fNT3DX4MAo1Lzzwm5CDtc+uWvRKbg?=
 =?us-ascii?Q?t9ihAi3hlioyGUiALqTIWKDTHLoFmZ/WAl1rJ+fDKvtsaywjPMFAgiqeCqwq?=
 =?us-ascii?Q?U7hlWTQu2w44VOd+C5Qcp5J/4B5SDhlfvIiNAqW6ZwCGnCW3qGIzFy+HyZFe?=
 =?us-ascii?Q?OVnfJjLwmv6Qnl5QKcYh/CuUyf3canGeyzC6MyezfdER6gzxsntMuSR1QouF?=
 =?us-ascii?Q?kFWvxvsIfCQm/7zOBVW0C3N2dBsWVBJ8THrPIVdv99hUhpM0gscnLuKSdxwW?=
 =?us-ascii?Q?/WU0m8luDRhN58lKlqt5G56RO/XP0FpA1cN32Eq03ZyJqicvdTW8W/DOcsOh?=
 =?us-ascii?Q?Cfsdrb3cCG9e8IcjBablL819QNLuyeCUIGpMx8paayFfhSrKFChmyWe8wgXd?=
 =?us-ascii?Q?s8UXFXwssrjSpLT+mK6E6TaL0wDUjFgPGYrUYV4kRg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-91991.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 15cd20a3-720b-44e7-ff38-08db65dfacb4
X-MS-Exchange-CrossTenant-AuthSource: PAXP190MB1631.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 16:12:35.5463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P190MB0938
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Timgrau <timo.gr@hotmail.de>

Just a grammar fix in lib/Kconfig.debug, under the config option RUST_BUILD_ASSERT_ALLOW.

Signed-off-by: Timgrau <timo.gr@hotmail.de>
Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Link: https://github.com/Rust-for-Linux/linux/issues/1006#issue-1696318406
Closes: https://github.com/Rust-for-Linux/linux/issues/1006#issue-1696318406
---
 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ce51d4dc6803..a56b9b368e78 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2899,7 +2899,7 @@ config RUST_BUILD_ASSERT_ALLOW
 	bool "Allow unoptimized build-time assertions"
 	depends on RUST
 	help
-	  Controls how are `build_error!` and `build_assert!` handled during build.
+	  Controls how `build_error!` and `build_assert!` are handled during build.
 
 	  If calls to them exist in the binary, it may indicate a violated invariant
 	  or that the optimizer failed to verify the invariant during compilation.
-- 
2.40.1

