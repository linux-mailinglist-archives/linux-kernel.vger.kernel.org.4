Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029A5637F07
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 19:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiKXSjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 13:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiKXSjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 13:39:02 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2124.outbound.protection.outlook.com [40.107.105.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2E71255F7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 10:38:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtVdTeYA+qH40YzERQ1Y5HLDigxUWXvY/ugg9CLD3vAnKrQa4urNzG+6Y7c5ye+6vLmYlLAqEqgu5pLrm5AnpOPEKCME+BT2dzhGkNypLXRRI4KmsxowtLeyDN9eLEyCFu0Ga8jfFTqh3HKxrJq2bdR9OpibfHeuO6lsiX+4Bhfr8Eu5WFUxd1RbtEXCMzpLeIDxhWlBPT/+mbwRd6Ci0MNSvPdk0ofIbZt1PLY/ft7qaKx9rthuQBOPbhxz3USWmHcgXvO9p2C/qlinof6kNbT0FbpWSfg3+53c1ewihGxE6FdnxmGJ3vJHrAA5g+S4xISYanOZhVc+9CTX8w4Dqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTDvPQv97PHO6VtHikMfGw8uQLOY1XJ1MSSeLgEjz6Q=;
 b=ePvVMdY5C4STAX0aiGqgkmTq6l+W7DD18rTlcW6+yLKYANsxKq6Hrg9czvi7t+4dHIkoHAgSLt9J4l9pQjN8Z1hlFj5howcM1KKkTGJWl85juaxcxwMJ81Wa5bzx4XJasWj4AuVJEDPqkPB/v4/xLbPNLdS07wJOXsR4Iy8zV0OjxGwvxggSbNiDtmr3/Xe7tHmiJPK3/baG0n4EHw0LjG3uAheSpaDs6Ca14qmfPLOLf7SZ5yCqt4pBr+pIJzd4iXA9uiHI2hYeH2GJtIMPqhT2XX+j19t4ikK5V4FMi7GeY0EfgJ1o9asMFB4OR13vwowTvhtNRN6WO9Q079fpsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTDvPQv97PHO6VtHikMfGw8uQLOY1XJ1MSSeLgEjz6Q=;
 b=iPZdV1CE1x37XE2uph1rpNJ/vvyTz13zbSTJRRNM7zrmldjEfudW/5o1eJ1ZVDk7Tm8p50JC33G06pnhAz+l/ZXYBdnB/2yJn1r11Tmsq9kkGbn36HGUacdfoVJxqo4EqmSskMuiiIBU7lmHh8m/g+fUCAOkzFRQNqWZqc9GUdE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from VI1PR0701MB3005.eurprd07.prod.outlook.com
 (2603:10a6:800:87::19) by VI1PR07MB6607.eurprd07.prod.outlook.com
 (2603:10a6:800:181::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Thu, 24 Nov
 2022 18:38:57 +0000
Received: from VI1PR0701MB3005.eurprd07.prod.outlook.com
 ([fe80::bacd:11a2:15e2:7339]) by VI1PR0701MB3005.eurprd07.prod.outlook.com
 ([fe80::bacd:11a2:15e2:7339%11]) with mapi id 15.20.5857.019; Thu, 24 Nov
 2022 18:38:57 +0000
Message-ID: <16a20fd7-1449-70d0-a7e6-38502531434e@nokia.com>
Date:   Thu, 24 Nov 2022 19:38:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        hpa@zytor.com
From:   Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>
Subject: [PATCH v4] x86/rtc: Remove __init for runtime functions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0701CA0066.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::34) To VI1PR0701MB3005.eurprd07.prod.outlook.com
 (2603:10a6:800:87::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0701MB3005:EE_|VI1PR07MB6607:EE_
X-MS-Office365-Filtering-Correlation-Id: efd72343-81db-4439-fcea-08dace4b2586
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TTlTuDsxegFw8Kn1mazMqnhouFOnKAp6QAgDjugiaPH4W37Ah/wVc46eCHzi1ui84I12MuV0Z4PRiiE+b2uBOj68bQN/2E4QgVb8nojPR0fHPEp1/QUGFSWdrqehNqrQe9BF+AlbydDGvJv/j4Edry4clSnSp9Z/it3nmbEG2j4wbsaLUb6AKFvgPDDhzdqmutEpU2N8gfEE7NV/OAIZCuXC/HeQalAoWk8/5pK8FPih1fVmmQBSOa1Zie49CAqRct7cHSCMsTtBCTMUQAD2hehia5NHfnkCzWJB9z3No905tfoRlKPYWhTTIa5vscrg53U4K2vO/8uK0kjEKbUhcxSu8GKrRl77bKdDeQHprN+q9/rPn+0QJ5+XkkL0h3clMS+NnYXaRFuLJLRqsLTWbCRV7XoZdPJd2vasRhr9ynUl+2HibLeENlxMw+6L+q55KUux6bn/Us1ACMorfBjqo3yI9KpHnvXj+/rY+3dkmm61AI0R7s86IH9H3nIXaaFBC7AWnlNWCiAaFUNfKqlPg6AtV/qA7uuZ13n9ws1u1ou1LMtmkJeWwd/eXQ2j0YQgK1e9XG8XWmRCagor+D2PaJqAQzXLZFEuVdPbgK4UZGoUYswvfSr0L8In0hmF5BRyhLrqCYk4o3eZsz501+e3ZYWxHxGAbrrMUUV8dxVP2Vzj2TCpqs2FnjPcNVplGSDgEDKaJT5N8WOkAsEPKAWOXW2ApH0WZdBGk09sXmaBVLs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0701MB3005.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199015)(6512007)(26005)(83380400001)(82960400001)(186003)(38100700002)(31696002)(2616005)(2906002)(41300700001)(8676002)(5660300002)(8936002)(66476007)(6506007)(55236004)(316002)(66556008)(478600001)(66946007)(6486002)(6666004)(86362001)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkI5Y2luenM4WVZKdWl4Z1IzT1hKZ3ZuT091ZCthQUxvUDlTajNycEdwcXAz?=
 =?utf-8?B?VnZwODdNVWZ6a2ZFSkhhZVNIV0VjY0kvei84Q0ZzamJmK25XcjhaTUdQZzFq?=
 =?utf-8?B?OUViQ1RCdmhUMkhDUEdqRERjYjB0ckxCazFObGNRZ0tBdTdPekRaWTVpeW5o?=
 =?utf-8?B?UGtyWGlMQzU3ZGVxYnAraksvZHNlRkZIYkI5T3RjTEpqY05WOCs4Q3llNThv?=
 =?utf-8?B?VGh2NCs2WTh0Q3pteVN4NUlJU1NDR3ltVmcwQXJjeUNaUmQ5cmhEUS8wYmxi?=
 =?utf-8?B?YUYrbHB5by9yM2JaL0pDcExqZ25TdHIyOUppbnl3VmlFQXhRK3JXd3pPTDc1?=
 =?utf-8?B?ZGZiVlBUUnBRU1YzWnJPajVlOVQrZmxkQ2Y0am56dm9JeDFvL1ZQWmh4T1Rt?=
 =?utf-8?B?bExsTUk3ekppODR2V0U5dVpnYm9VZzdFdzg0amRyZ1h5a0dpb21ZTjNjQXps?=
 =?utf-8?B?OXRscWhDZmZ1UGtMN2lHM3ZxUmlxMUF2aDhpSlg5VGl3QVFnckt1L2NXd0Vq?=
 =?utf-8?B?SFdsU21HaFdCMWU3TXdHNmZMeWRXamprZHBOSGVkTnRIRHJUKzFGb0lrTUJr?=
 =?utf-8?B?Rjg1bURya1NsdXdoSW5wbFRwUFBrL2xFQlVZUUw1WDd5MCtBeUtVeTh2NUxB?=
 =?utf-8?B?UmR2WWpaZ2ZQMW92OHp5RDFTUnFwcjNyWHpXamYxNTZEZi9FWHlmVzBZN205?=
 =?utf-8?B?N0FkS2d5RXQ5T21LbW44d1IwY2orR0RmSHFtQXoxNkRBVWNHbUhBcGluQm5l?=
 =?utf-8?B?b0l1R28yWlprNHRCWEpqb3QxTGZTUVFNbWY0c3lSL1lNZG9CWFMwWWVxWklK?=
 =?utf-8?B?UkVQaUVPSXI2enV1TDI2anFDNkJZbkdsYWNkZ283b1MwT2JtbldNcmdwN2Vy?=
 =?utf-8?B?UlIwdVFBTmxsZnIwdFR6emNJbTVUdDR5V1JJVFExSWFFK2dFYjYvNmRUckpi?=
 =?utf-8?B?TVE3eHM3YjNwTXZNTEF1cU9UUmtPbFlzU1c4Q0lDRm1Td3NmWW9tUExabjBQ?=
 =?utf-8?B?bFExbGFtN0htNHdQS0Y0bzE4ODllY29Edm5uc3M0MWFPUU1uOTRFRWovVUs1?=
 =?utf-8?B?aFVZemZUNDhhMS9yaE9vNW5yWDY0SU5OL05zQ0lLMlhyd0VZSGplR1Z1dG9p?=
 =?utf-8?B?d1FzN2N3THkzd1NJemlQSU1wRjRQd2xRSElVaC9CUXFBSUxuTHBEdzk3TVhy?=
 =?utf-8?B?VlJNdytGeXFmcU5TcCtUNWt6cjZHRms1T0RTekw1QnFlS1dvMTI1aDdkQWdj?=
 =?utf-8?B?YVllRTYrYW1Uc2k1VnlUekhUYTRKTkU4S3JxU0ROOVdFdUlUQ0tzT2xkQW1U?=
 =?utf-8?B?Zi9yNE5TcXRBQ0pvc2krMi9WTkF4ajc5eU1wT29Ib0FhTkdGQk04MHRKN0p5?=
 =?utf-8?B?VThoUGgxZGdDQitjVHNYcitDRGEyeU1sNFh6czFtUk9GclJrSDV5U2N3dUNX?=
 =?utf-8?B?NURxVzNOUDBjc0Y0REF1cVRjVElNK2I1VTc3NU9BV1ZTTURJeFYzZUhBS2p1?=
 =?utf-8?B?RkwyNW9MZ1JuNHZDT3psME1LK2J3VVMxbVFLK2hRdXlZY2dRVWxKVkgvdlc0?=
 =?utf-8?B?dWhOSDdubFBXUDQwNStydjA2dVlFeTVrVXNpdUdWQ3U5c1ZjSEN5dlZYZ0lI?=
 =?utf-8?B?ZEJNdHNjVXovWmRMWWo5dDk0SFRSbEwxemswZEpSbGllZ1U4WDlLcUc5VnVQ?=
 =?utf-8?B?YnFGNG4yRVBUY3M5aS9FV2lJbFA3MXd0SHZmYldEdzY1a3A0WGVpdVRzOXBU?=
 =?utf-8?B?Ymc5aHFtOUtmc1NLN00yd1c5SmJCUHNGdGdvTkhyU2lFLzhYa0xsSU9GZUY4?=
 =?utf-8?B?TVJMZXRsZWFZTEM5Ukp1OHQxWk5iTVhicURaKzNHUnFLZndLRnFBS3c4Njdu?=
 =?utf-8?B?OXZEWHJsL1lZY3Y5RmxEVWIwMS82VlRGSHlmNDcxeEh5UXFrcnVQU3hXL3Yx?=
 =?utf-8?B?QTU5OFl6RE05UkV4WE5SWjlTUENvaVZUYXdMZVFCOUM3YUZMUk95bnhTOU5V?=
 =?utf-8?B?L1FzOE42L3dqbWN2Tjc3Qko5b0tzRnIrajhZbVFCL3R1TDNWQ2o0dzVuZzBj?=
 =?utf-8?B?WFlkOTM5VGtQV0g4ZHNrTXJWNUgwY2w2MCtvZVpid2UrMm9jd2dESDZYdzJm?=
 =?utf-8?B?aUJvZWN2cHltOHVwTEExRmpIM3JEcHNDU1pyRzBiSGI4emRMRCt4SEhPN3VO?=
 =?utf-8?Q?khyGe2ckex8mPQRQBsBMPU8=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efd72343-81db-4439-fcea-08dace4b2586
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0701MB3005.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 18:38:57.5381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJYSgODxf3F1FLpY9BC4LPihLk9rRni59Y/eYB6VRH+46LFPf/4TX7ij09GfStkdnLvqxfP7Wu5YSSrzJRI1OphyXDFGAXVYjYx8vBdt500KEF4UhAW+oQpkpXEgq3y+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6607
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set_rtc_noop, get_rtc_noop are used runtime, therefore need init removed.
Crash was observed on x86 platform where cmos rtc is unused and disabled
via device tree. Function was triggered from ntp: sync_hw_clock, although
CONFIG_RTC_SYSTOHC=n, however sync_cmos_clock doesn't honour that.

  Workqueue: events_power_efficient sync_hw_clock
  RIP: 0010:set_rtc_noop
  Call Trace:
   update_persistent_clock64
   sync_hw_clock

Fix by dropping __init and making set/get_rtc_noop available runtime.

Fixes: c311ed6183f4 ("x86/init: Allow DT configured systems to disable RTC at boot time")
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>
---
v4: Update commit subject and message based on Andy's comments, resend to proper addresses
v3: Update commit message based on Andy's comments (further trim to backtrace, proper tag)
v2: Update commit message based on Andy's comments

 arch/x86/kernel/x86_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 57353519bc11..0ab707bbefe2 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -32,8 +32,8 @@ static int __init iommu_init_noop(void) { return 0; }
 static void iommu_shutdown_noop(void) { }
 bool __init bool_x86_init_noop(void) { return false; }
 void x86_op_int_noop(int cpu) { }
-static __init int set_rtc_noop(const struct timespec64 *now) { return -EINVAL; }
-static __init void get_rtc_noop(struct timespec64 *now) { }
+static int set_rtc_noop(const struct timespec64 *now) { return -EINVAL; }
+static void get_rtc_noop(struct timespec64 *now) { }
 
 static __initconst const struct of_device_id of_cmos_match[] = {
 	{ .compatible = "motorola,mc146818" },
-- 
2.31.0
