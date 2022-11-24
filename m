Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD288637DD9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 17:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiKXQ5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 11:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKXQ5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 11:57:40 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70138.outbound.protection.outlook.com [40.107.7.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601CA19025
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 08:57:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M7vvZCd25Fmpgqco4qd7pyEEkoi6c4YSGsUczvini8YuOv6CPKz9qw2Ufu5nXQQvbJ8ktiIYQAn0DrwtIx6ApjuwkSO4LftTrswDzB8ax/N2q2C8nUBNmFAfHEvWrCXWT6uJFtkIdsMe8OXDg9jd2VZIOm0BA9jgJc25TfnCMKo0j4i2ZAg4IWsbTa6VJx5T+V8hKlR9KKnNzjLn5bTmyybfKtPRypCC59T2Xu2YNaCv88GFKD3RecPo+nUaROY2JNH9+Bipt6lJSv39gqYJsy0zeUuXbxFbz/0RpYqZj/zoZOBXerPOZyD4+JxQe0TVDjlUf3kyOO5g0mR5Zvqgcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ps+MmI7qpyQuhyJADB9Mcwnkj2bX3JzgUnOXFL9zBt0=;
 b=EHJbeSxy9Wu6ts1GSBBTIgYbAZjboJf7phxhKfv221w6hh8EibE3232DqQrgCA33XWnPQjW8JTZXX+d1MGFGp+9hfMm9TgvDI/hNHasclmOyM3Jaxqvd5yE5Oq/qh9qGdybJRXQDJXxWTiNLWyEV9ethmOROiwGn99RB1H7aa+8dlo1YQO09bfOLyytzb/gI3qgmJCpfj6m2CQqlfeXkGnUHCpGEA+D21+2jJhWSF3WNVtnWbb9h07rWzH8UQs1eHUpBgwxiKr0iv44mF/WCE4ErbeBk88ip4O7YKf4rivCjHJ6p4Tu2tgPoFqs6mg2vvuuUQ1vTvhenbK4Sm7iMuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ps+MmI7qpyQuhyJADB9Mcwnkj2bX3JzgUnOXFL9zBt0=;
 b=mGe6i84Mt3bs/rEqBOLhshHtVBmBT3OlQUGTgDLXVCp6GiCrzTCrgKeCP7Huah4tkn2oLP+4Zn/ToekyYEzP1jrcWSyanZK8ndMRNRgERNdBkhW1R+fE28nhBWyJh9EapfmLZ9o+s9XYAKwhwf5NnxZ+VPwPHo6n6onxd2JGNJw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from VI1PR0701MB3005.eurprd07.prod.outlook.com
 (2603:10a6:800:87::19) by DB5PR07MB9514.eurprd07.prod.outlook.com
 (2603:10a6:10:48f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 16:57:35 +0000
Received: from VI1PR0701MB3005.eurprd07.prod.outlook.com
 ([fe80::bacd:11a2:15e2:7339]) by VI1PR0701MB3005.eurprd07.prod.outlook.com
 ([fe80::bacd:11a2:15e2:7339%11]) with mapi id 15.20.5857.019; Thu, 24 Nov
 2022 16:57:34 +0000
Message-ID: <af226986-c6ba-5192-4544-b878fd3140c8@nokia.com>
Date:   Thu, 24 Nov 2022 17:57:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>, hpa@zytor.com
From:   Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>
Subject: [PATCH v3] x86/rtc: Remove __init for runtime functions
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0902CA0042.eurprd09.prod.outlook.com
 (2603:10a6:7:15::31) To VI1PR0701MB3005.eurprd07.prod.outlook.com
 (2603:10a6:800:87::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR0701MB3005:EE_|DB5PR07MB9514:EE_
X-MS-Office365-Filtering-Correlation-Id: 88386094-14b0-4fd7-ec2d-08dace3cfbb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oA2G8sbhSCX9qRzNdQJg0UtTJaVe/1Gl6I/x9FpOwoLa8Vjo9X8SN3mHr/s97iabto+u045SZGG0Xj0NjebacYpEha1qNYTU/AD9u+y42HdFnvyfcga8aH6IYIXxcTCOfECQvTDIUTqk70c3rkuIj8ovx+XgoJ6LaMFof/ms/r2e1GFE+PK/bX9medTeqDeC0oDWH1oKMe8s/nNoGHktG+TQ/nkiSWD0qWYdUq9WxWeaG5Nvei/ucFCK5mVhIHKfQwUXdCQH8IbUiEhv7eB03iRmITSy0pU+BwfvvaBwCXJ7rm6Y+2MYkVLbj1akT27LITVKXxX7KGP7/+LUCr6bUafHptTrynH2BbmlxglCuygl2frBSIpVc6C7cQzdB9SxojAk91dSM5kaJDZmeLmarpfWKfdhgfmKnr6HsAnC7uhEIZiFlwWYs6sIcSnSiGI+2cRT2vDHdwxT0xDCbwPGr+vlkhJMIVarg9BroEsYMltQtGFAxy/FgTnGkVIpXLknPglVymMVcW1mboubTetTl0zicY9ExulqQ0PWJ5VdOuSx2tPFHxlJRvsctYO9C13XhtuFsevTGHvLBXPUi23e9aQ6QVuBTGiZYcCmrVhYAYm4M2O5RTm1kfab5HM3I6SOd+phW5sDC5SC4kVw4YAnRZ7YTrHbSFYljJQMZ4LGtp0Ev+z0Vr4LHozX2+CBBNtyQaOftQxH2ehR8h64Gp/lW9jU0DxIss5JJ/P6DMJVjFA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0701MB3005.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199015)(6506007)(26005)(6486002)(36756003)(6666004)(110136005)(41300700001)(2616005)(5660300002)(186003)(2906002)(83380400001)(8936002)(66476007)(6512007)(66556008)(316002)(86362001)(55236004)(8676002)(31696002)(66946007)(82960400001)(478600001)(31686004)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWdTSjkzSEw3cmtwYlRQVENydllzUzR2Q0xlN2IzSFR0Yld5Z3U4U3JXdkNB?=
 =?utf-8?B?V1oxTGVBUkNpWHQycTIyMUNpcWMzT1Y0aGdPdHcxN1dGZDEzZ1Y0MDBybnlW?=
 =?utf-8?B?akRrNTRIZDB1bHBXeUhXS1lnR25BeGtUbWZsNk5wQmtQQWZZWkh1TmloNE8v?=
 =?utf-8?B?cmF3VlNBQXJqM3NEZFBzRjVDTjhDZllaRGlPTWxZVWp5QmdTczFtaTRMaWxQ?=
 =?utf-8?B?VHFxcXpoem5ZaEhsKzlMenoxN3JnZzV1UjMyb25zS1V3K0VxWjhWbUNaNFlz?=
 =?utf-8?B?dnBDcFFyUDNXMU5sZUZnYTgwL3JhK1dnL0xRMzZLOHBGRks4QmFlUEsyNGM4?=
 =?utf-8?B?QkhUcnFDdUc1NENGOVovSi9KMHB4ODJTcGhUa1ZkbHp3OWhZN0cxK0JTeE4v?=
 =?utf-8?B?bjUxdXJEV2w5SlNYVUI4dFgxZUZhMHp3b3lsSkZRNkpraVBxdXFPdUZuUmxW?=
 =?utf-8?B?ckZhUWIrY2w1d0RZZ0RtaXc2OHl2Uk05cWRvK3N3V1NlYVBwbldYUnMrRjAx?=
 =?utf-8?B?OVdCdW1ZeHNSNWNvODBSY0lQKy8yR3BXWE80cHJ2eFFPV2pQSGtYdENkTEdv?=
 =?utf-8?B?NTRJTWlLTC9Lb0pMVTR1SThEa0Jnclp0bzZwUWlMK1dKbU4yRUkydk14Q0Qv?=
 =?utf-8?B?L1YvMjlZSy9CUWJ4ZE9vcjBUeFkzWXY5K3VGSitFQ0FSS3JSUExGeWdTMjlr?=
 =?utf-8?B?b1R0cjhKeTNhSDY4YnBkcW5OZk95OVpVL3hqMEtySmxJOURJRnFCN0MyZUxt?=
 =?utf-8?B?R3N1QmlicXZuU0dQYkwxbzRYWnJWd3hFeXU0RU4yNndOVUh0ZUg5Vi9ndWNv?=
 =?utf-8?B?aithZXA4RDd4VG9CZ3JFTVpZYWkzTDhKVHl4M3pLOVBjZHUySG5QRS9Ia3VD?=
 =?utf-8?B?aU05RnhEYk9aNW0wcFk4YW5aelZnYkF0VEZVcjR0ajE3dGhHNHd2NCtPSXVj?=
 =?utf-8?B?blZYdHp6eEMzM1dkYWxIdmJ6K3oreWIyZnJVRGM0SWRWVlpGQSs5elZtMkpG?=
 =?utf-8?B?MXoyUFMvRVBDSG5ORlZWK1NTQjlwZGxCVnA4T3ZCeXdTOTNrTXZoV2tlQXVY?=
 =?utf-8?B?OXRCNm1hbzFLemJRMGMrdEN2NDdLdDZ5ejZacGhDUkV3ZW40c0FCQUJockhS?=
 =?utf-8?B?Y2w3bmwrNWN5T2hMZ1pCM0hUbnBTNnJkdjZkb1V2Y3BMZURITUV4Tk85VWpF?=
 =?utf-8?B?ZkQ4bm5ROXNVamkrYVpvakR1Q01RbFNmRjFxRnhiWDhjd2tKVk84ellnK3dW?=
 =?utf-8?B?aGR3VldON2pIR0hFUDllcWFmTDVVUzBnc2ZCcDdJWHJEQTUyS2xFRGZHYXIw?=
 =?utf-8?B?SGVDMXlPRi9NNWRlMkVmdFFxTjJacTFRemxrK25ISmdXU0d2MU9ZTG42L0ZV?=
 =?utf-8?B?dGd6NDhKeXkvelNZMC92bjlwTkZQOEVQeVVKNmhVcHVlWkJtK1Bpb0kzMFNm?=
 =?utf-8?B?aHNWYnd1ajdDbnNnQUdGMVV4MUY2S3dZWWVIMEdYRTJoQ3RlTkpMV1lZL1p4?=
 =?utf-8?B?Y3BHMy9IVGpMV1RZM3JWMUxRNkIwY3VSTUtyTXE3ZjFja0FEdXdscEpwckcw?=
 =?utf-8?B?SFBBMWEyNkc2UVBGa3NoTXRXYmo2RXZNdEtYTzBCZGtuTjF4d1V4NVVVSHdL?=
 =?utf-8?B?ZlM2ZjQrcXlkcHpJOTh2alhtN0JWbFVFaEdSb1Z4TzdoZU0yWTJBQ3VUWE9r?=
 =?utf-8?B?cnJKcThic0lTN0RKdGxTaEdzTWx3eVExQWt5YWhHT2s4VStBQ25jQm9PS2xM?=
 =?utf-8?B?Sm1SM2ZJQ1pHbytzSERDeWUyODJCN3YwazhIblRkSG5wazM3a0cvN3RvYTVn?=
 =?utf-8?B?WkJrbjFLcVdRa3FHMzJ0QUdJbjVQUCtpcC9rWUE3NjhTdTNvZmhKb2JuR0x6?=
 =?utf-8?B?OVNkeFZUemZKRlkrRGk5dlAyM0FZZE9pZERBa041UXA3bDlSeDVsWERJRVdD?=
 =?utf-8?B?bmduSFAvZldKRCs4Q2E4UlFLd0EzZTJLdFo0UHFxMlRtVEJpMkl0Q2tyK2g5?=
 =?utf-8?B?ME9TbWhJQzBKYWhvRTkyUFd0S3ZkTlZPbUhhYU42a0MwcEZEYTRieVdLNG8x?=
 =?utf-8?B?VUQ3SFIxL2d5aDRXVytmSm1hbFgxZkhzbUllYnRzaTM3YStsSWF5VFRVcmta?=
 =?utf-8?B?RzRDNEpTaW5Jb3NsYzJhOXptMzVVQzRzUURGS3NVbm1DdDJRSHlnUDRIV3o5?=
 =?utf-8?Q?QNOdrkxLd54x0A1PYxPy3QM=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88386094-14b0-4fd7-ec2d-08dace3cfbb9
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0701MB3005.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 16:57:34.4378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lx++tWupuyoO07+JSzLaO9CLef3Z5ij0t+fHAMvb3wWjwT04wbgxHv6CrMo1MuaTItpVjPgeOFyp7eKkvthrqxht7tLrCQcFknGBHiiF8gcw0qIMFnPIKrEiNiWW6aZb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB9514
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
