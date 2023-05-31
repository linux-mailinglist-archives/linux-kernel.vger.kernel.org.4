Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDD6718D97
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 23:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjEaVxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 17:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjEaVxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 17:53:37 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2105.outbound.protection.outlook.com [40.107.14.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1461F12F;
        Wed, 31 May 2023 14:53:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahmcRu7+el/fS3aYyixtJCcXmMnXMXp0Zv+KqXp5Hn3XsxBxqVd/gictQAWT+QIW9x3eROzQ+StxmenDkPePcWtYXc/DkZRJEQEq9eUhwhTRVrVptuWBG56yvgJ4c9kvHnBgGoNVBGwlsaaai4wyFs0wQHD6TpraNIyNc/dep857wtRWHlEey/jaSYaOnsR+ne+sZHNhvjmRQgOraiIWDMNnDBbVbDVBHCgf6mHOsv36yLDatvS59aUyu7DSyKtYN4dtj7i3BDANaCE73kuE300pUc99w/w/7wvgmm6DEaKoFmFyeA0xXAA6ufcSzBnFv2lz5NYRYZK2alsffMscFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3GcN5weOiED80XjQf3IBDI/MC+ZU6buzm61KcH0//ig=;
 b=SE/WBsZD5AZ9gYYXl7e+kfiESI3MBihIw8l1hOocSIXPEdwOEIWYL1PK0oD+qBA+RqaVxmbVmiil1I2E0XKMooovn3unVxufEBMQ/cNFXhKhI+n1TrN5iWFbC4AaHHoFwEEG4eSZ7SG3DNI1piSCg5SPFGV+L1KowUKGbmsH+FbDtnt199icVpLU1Wo/Su43JTOX2c840Y/FOP0UDu3D5cBqS+rE0JPyzV8lZNLS+9tVI4iyFFi7AYQd+SQtBh/isdrgDiO1NMDCVK/5qeNDe2SSro9dJtldUWnCcqY56QwDVeKGo64fOGIse0K5NdAnNLU4BNSTdap/cWly17KADA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GcN5weOiED80XjQf3IBDI/MC+ZU6buzm61KcH0//ig=;
 b=aIpJW3AHgGPDDJ3zEil2VIiRKM9wpWd9F101o2lTHNC6+Cf2SguxlOttgHitOqt1/T5k2kqqlxZMjR8ie2UHbKfQGJRt3FD2B8BUtIe6p4hQeUpmCZj1bOFPhFDggW6esxxK3ILTs0CfV1kBCvQ+vBW+dOvvvbAg59kOaHe4OMo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com (2603:10a6:208:ed::15)
 by PAWPR02MB9854.eurprd02.prod.outlook.com (2603:10a6:102:2e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 21:53:30 +0000
Received: from AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::f54c:7d45:d4a3:841]) by AM0PR02MB4436.eurprd02.prod.outlook.com
 ([fe80::f54c:7d45:d4a3:841%4]) with mapi id 15.20.6433.024; Wed, 31 May 2023
 21:53:30 +0000
Message-ID: <bc790b4e-1cb4-4ef5-3da8-9d0e6b613bc7@axentia.se>
Date:   Wed, 31 May 2023 23:53:27 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: sv-SE
In-Reply-To: <1149c073-b761-8ad3-2930-3ef10ea7cf0b@axentia.se>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
From:   Peter Rosin <peda@axentia.se>
Subject: [PATCH 1/2] mux: mmio: drop obsolete dependency on COMPILE_TEST
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0105.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::14) To AM0PR02MB4436.eurprd02.prod.outlook.com
 (2603:10a6:208:ed::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB4436:EE_|PAWPR02MB9854:EE_
X-MS-Office365-Filtering-Correlation-Id: e4fe1372-e615-4d1d-7615-08db62217876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6F88LapSKkUNbjycW5nouFu0zIVhcVwbQp52S0i/JBFR6MxCGk8wnBwZ1rMnfuqmiav4M5hO+/1qNGPgeMu6QpBBqkyQu1VUZryTMFgFpMRzj/dlC6HOKN2BB3I0/tEMlUAixuYTqtRycNyYtrdcTZzzzxLGZmVH/kqaPPU1KT4GsBx95WtY6kcXTQYsi4f7HmZosb1Dba7xGG8yz1Nv1KNQNaeJvdLSgaL06kAciAFK1SfKV+nmLjHrkRL6PEf7B1CSfMbchXBCn5dUZZU/V51+TzJBtEvimmOOa+fm+JmVjnw6cjJiHS2UWLsx2Xc8qQq6eUbXrvAWp6yDSjtn8PgcznaA6o9k6B8Qjdy90f3crXvV1mmlOpnip37hebqR7xLAf2R/iWJOY1ZNm/c80GDpE6K65b/WNkCzn1HvTSVJ5K/wafpMAQrCJ1/sU5EgwQd4lqlsVRRftJGmKTxk/Aho8hJrY10CNF1rkWegxVFmwsEho9MY+Yrs0w6pWk3HjsdChFXbupkNXpds0yp/lCAsaP9tnt44FzIKUrF9jJ74ClNgvxaSuwhBi6wa8WhJm1SB/hyNBnXSgFz7j/IL2n192akZL49j+rZJ9FVtZFcNbYcZd/IZf+/KPHABxxITs6TlTPX8zDsAXlO8ouBe8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB4436.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(39840400004)(346002)(376002)(366004)(451199021)(83380400001)(66946007)(6666004)(316002)(5660300002)(36756003)(66476007)(4326008)(6916009)(66556008)(86362001)(31696002)(38100700002)(41300700001)(8936002)(8676002)(6486002)(2616005)(54906003)(2906002)(6506007)(186003)(31686004)(6512007)(478600001)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmRPZWdtTnV1dkpzQXA1emo3aTNWcjcra2RZUDIrOTNEKzVuTUFYUnc1VjJr?=
 =?utf-8?B?TkM2MlV2T2VDV3Q2aVZTdXNyTVFqYWdlYW53a1hJTVVtcmxvMVp3aWZKWWs4?=
 =?utf-8?B?TllWQWlBRGFXTmFnMmNBWWZOTytuSHN6L3JKdEQ1d2dmdHlncDg3dktyejd4?=
 =?utf-8?B?OWdUTDBJTmdkSUxENzBhN3VUaVRQdUsyam9relpGUUxoMmxXV2ZiRFRKVFVX?=
 =?utf-8?B?MUxXb0RBcWluMW9yVkhwVmRsWGZ5VlRlMFRLSVRXcVlMTmxVTENMM2tsNzUr?=
 =?utf-8?B?L1VKS0RmNnpmNDNrSEs4V24yVitXbG0rQ24xd3h4VzBBTzI1QmFMZlk3dWt4?=
 =?utf-8?B?SHZQSEl6RDdpbGtuMWErYVlXbmpGQlpBNVJrTzJLVTRYL1ZuVFd6WldRUkVH?=
 =?utf-8?B?TGdXQzA4YWo0czU1R25Hamx1MFlKblVMNVZ3VGk5NkJyd2cxd3pNSWhnMy9Y?=
 =?utf-8?B?cVdsK2R1S1B6bHBabXlGRDRRQTNaaE8wN0gvWTh3akFhZ05KQ2pjV1htYU91?=
 =?utf-8?B?OW5aUzN3WXhYQ3NHd1hjOTI3ZURDemVDQUNxMUw1Zys0OTVmS0FDK2xpdkk5?=
 =?utf-8?B?YTdwNnl5cjhac1BWRmtkRVdudm1tZGF1SDVTaHYreU9pSHJzb3MyWmV2RXha?=
 =?utf-8?B?TTNNUG51UkJHZWpHcG5YZzQzZTN0Z3pMZytqejBicCtNVVVpRmllQjBKYW5X?=
 =?utf-8?B?Y1BYU3VhUEhwcGF3U0JDR0lDM0dUKzBBaHFUelhLL21EdXorcys2MVNNaHl2?=
 =?utf-8?B?Z3ZwTlFWNWI2Z2Vta0MzLzFwSHVUdW9QaFZWRlNxTkxKRnZWdTN2N2N4WXpS?=
 =?utf-8?B?KzNXRGFIRzJDY1RHdks1TDBBa1ZDdFBqQ0NRblVvRXM0a2lxUERwaldUVFlX?=
 =?utf-8?B?R1dDNld6Rmo0VHRRaEpxelJTY0xxTGJSSmxwWXhmQlVaaVNjWEFhb0UzYmU0?=
 =?utf-8?B?RWtvSjd0T0pNNE9ZcEN5dnlrZVhPaXFtUkxXVWNmYi9aTmErWkxvMlV6WER5?=
 =?utf-8?B?bWo4ZGJScjVnYmpsMVQ5QnVkRTEvaVRXN1ZlVU9pdEkveWR2QTZjZGdHeEJE?=
 =?utf-8?B?anlDQitiU0E3Ui9IZWF5d3N2T3JOY0JERENMWGRyWC9qbm52dzlGTUpkUHla?=
 =?utf-8?B?V1V3bGVMZlphSXBKdmlYY3JEM2dwMTEwWG5RWXhOQ1BIeWRrLzhpUHlsK2Ux?=
 =?utf-8?B?YTFsK2tGb3NmZTlPUmV6VlMxVnkrK0FOVnN4QnFLS2JGMmhrREZkYW1FcFpr?=
 =?utf-8?B?NkU1bk9JS2hMd3p5eUxCV2R2dm1RMzBoUmpBTlVFQW0yRm9QdmROZ2xMSGkx?=
 =?utf-8?B?QWN3b1U3Q05zRmRDNnhmNlh6VHpQeW0wZGRwQnBFbTJqQzl1SUNXdGRKYWpm?=
 =?utf-8?B?ODMxTktTd1lpcFREcGV1ZUlmVHZUalJqL0RpSlc1bEhkTUtod2J1cXRkbWZG?=
 =?utf-8?B?MUpNdjJaa2NIMi83NmxGV2RJVWJMbUNyWTdMUGVhT1cxZUZsa1NHT3Noc2d1?=
 =?utf-8?B?Y3BFWHBXYUtOWTQ0bW44ZUpqZHNFTDk0Y1NqUUNxL1p4UUYrMnJuMFZSVWlY?=
 =?utf-8?B?MEU2L0diWGJxY1ZUUnJIQjVLcVZRd0Vha2lCT3pud2JvTHFsY0k0VGd1U1RR?=
 =?utf-8?B?V0YzUlJEWmdxc29WcXA3akNWWWFMU21Ca3ZNWmcxV21YbkNzSjhRWmJYeXhy?=
 =?utf-8?B?UGVDNGUrU1dXTWVTUXlIS1hDSjRnWkgwWGRGZ1dWckhCSXgvU1JwS0ZhUGE0?=
 =?utf-8?B?UmFqdFE3cGdqL21sMGs1bXFTQU56NHRYNGM3eERNdUM5aDFzLzErTzVBNG5z?=
 =?utf-8?B?bEpNSXZpajQ0cTdwaGdBc24yTWp0R0wwL3B0NDBoK3h5YkNZcDRrSmROems0?=
 =?utf-8?B?cEhaQ0gwekFkU2dKOVFqUEFsU3dGN3UrVnVRMHB3Ry9mMzVCRkF5WHNPRmEr?=
 =?utf-8?B?UXpPUTV2bk1TK29KaVRzNGl6YVJlaFg4emlwMldoTkdzTisrRks5SmN1VHM1?=
 =?utf-8?B?bnZ1K2x4N0pmZzh1Z1QycHVTL0w2U2tlYUtDUVZaMnNSM0NmWmw5WWJhR3Zw?=
 =?utf-8?B?dnIyQVFmS21iRXh3aGV4Q3NsYTJXTHdNcGZBYmN3SURYMHJGUXlDZjdCTTcv?=
 =?utf-8?Q?Ou+AVQq2P36mEfngksh2XNchW?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: e4fe1372-e615-4d1d-7615-08db62217876
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB4436.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 21:53:29.9832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /jlbXNBbMUIDHc2SFODLWufQeJ2a2HmOA6DeZ00hzYAr+3KguRoDqfEGYw/QKJfG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR02MB9854
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jean Delvare <jdelvare@suse.de>

Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
is possible to test-build any driver which depends on OF on any
architecture by explicitly selecting OF. Therefore depending on
COMPILE_TEST as an alternative is no longer needed.

It is actually better to always build such drivers with OF enabled,
so that the test builds are closer to how each driver will actually be
built on its intended target. Building them without OF may not test
much as the compiler will optimize out potentially large parts of the
code. In the worst case, this could even pop false positive warnings.
Dropping COMPILE_TEST here improves the quality of our testing and
avoids wasting time on non-existent issues.

As a minor optimization, this also lets us drop of_match_ptr(), as we
now know what it will resolve to, we might as well save cpp some work.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/mux/Kconfig | 2 +-
 drivers/mux/mmio.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
index e5c571fd232c..80f015cf6e54 100644
--- a/drivers/mux/Kconfig
+++ b/drivers/mux/Kconfig
@@ -47,7 +47,7 @@ config MUX_GPIO
 
 config MUX_MMIO
 	tristate "MMIO/Regmap register bitfield-controlled Multiplexer"
-	depends on OF || COMPILE_TEST
+	depends on OF
 	help
 	  MMIO/Regmap register bitfield-controlled Multiplexer controller.
 
diff --git a/drivers/mux/mmio.c b/drivers/mux/mmio.c
index 44a7a0e885b8..245bc07eee4b 100644
--- a/drivers/mux/mmio.c
+++ b/drivers/mux/mmio.c
@@ -131,7 +131,7 @@ static int mux_mmio_probe(struct platform_device *pdev)
 static struct platform_driver mux_mmio_driver = {
 	.driver = {
 		.name = "mmio-mux",
-		.of_match_table	= of_match_ptr(mux_mmio_dt_ids),
+		.of_match_table	= mux_mmio_dt_ids,
 	},
 	.probe = mux_mmio_probe,
 };
-- 
2.20.1

