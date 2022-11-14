Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03DB6278A0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 10:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236872AbiKNJFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 04:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236904AbiKNJFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 04:05:38 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150054.outbound.protection.outlook.com [40.107.15.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B10C13E14;
        Mon, 14 Nov 2022 01:04:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZCRgnpXob4BwwgafqvmDW6FHEwe410NpOIGo4BPY8nNi45oCN2Vfk4cR4upNEgURtjZEveGrrf98SK1nhz4gAwZH0essWzhWUAuRambp0J/h+/3tgKNiayoEKz3iZlEcVZVMA3bOSLeXIM/25cSEWn2grGkh2GihTABZN/hEcvIMWhga6eAD0Mfq+O2UJp8/oh1kAxIXlRGbicICic7ghMn93XqiX2qTk+5OuBi76uvpqVveF2NMWrh4XPwFp/48oCAdVezPPvXMHINRPwct3rlGQOY05/zlaS/trg99y/0gsUOnZVaNqrp+UaWor52kBQr5RiMGBOyQ4a+3fTJLdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4joJirRrHtjTREIjMUxBIsT0w2joMqlzkwVuTnpqdGc=;
 b=DofmL9WmNGlcAhRtmuHTEIEumgIqHLQHs+loqto7XdGUgUm2RetsQMsNiXqlc2b0wCY4Z4xc3J/1f3vFqqzk/RXgU0d5YAdchMvDVrD8kaQ9Y2puliosWeQEznceHRXi0gaeGdtX0z65ZSeBWCbbLzHR0vtK1ErD8GjAVLSeRK5W8oL4Jr+VLvjS8yItz4wrQOfwW64I34Gi1jKseq5ShWqxW79ttTgnw+I+bcASoqCukDA/SfmkYJ56n/gv2LtWucuoAkttc9qGw6mYEMBueV3QhJScmNKkAXpIoHcqxewJrJol0bdetvIGTE9YfURlWZbwU2OXZJpZK/mWGmid1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4joJirRrHtjTREIjMUxBIsT0w2joMqlzkwVuTnpqdGc=;
 b=puciGDtzeibaE6G7AzUhcBgEHjfBnFJQNpmBg+UqgsceGlFDBd3WIoZ5P6u1pHKktpJAQYaj0azQRCFK4Lw5b15znZcECGR4qZg3/WsjKifujuPQU6twMxKA+Ui3CJglLDTiREzrXx3ZM6wEpPvwFXdWkEsmkEyUXPliJaeZOvQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by PA4PR04MB7792.eurprd04.prod.outlook.com (2603:10a6:102:c0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Mon, 14 Nov
 2022 09:04:16 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::dcca:b62f:206b:dcf8]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::dcca:b62f:206b:dcf8%3]) with mapi id 15.20.5813.016; Mon, 14 Nov 2022
 09:04:16 +0000
Message-ID: <23be5d9c69ae758602b9de97d47f787fa104961d.camel@nxp.com>
Subject: Re: linux-next: build warnings after merge of the char-misc tree
From:   Liu Ying <victor.liu@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg KH <greg@kroah.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>
Date:   Mon, 14 Nov 2022 17:03:31 +0800
In-Reply-To: <02828ff7-c734-4b55-b86e-5cc777e1a35b@app.fastmail.com>
References: <20221114181752.08a850f0@canb.auug.org.au>
         <02828ff7-c734-4b55-b86e-5cc777e1a35b@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0096.apcprd03.prod.outlook.com
 (2603:1096:4:7c::24) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PR04MB7046:EE_|PA4PR04MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: f11ffcee-782b-45b9-1d93-08dac61f34d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KdqpwhGEp93IWfxtH+tLzcVg+FMTGDx1oVeaKz0Wau0ybmcTyL4AoTVTn2GtvYYsYQ15I692jgWFDhWymVaMQHzzHdjmGG16B8f84WBSI8MkCbkjiNqL5HCwpkxeaXaZ91qOm01gY/tXPB7TV3RV/fuHURnbwj0GHxEukqbwm0i4mYFaV/F0U2bb4EtS6e85cLwHALrAPudPy0DXBcPNtFAAkeO4VKCywBvhjD7jBIylw6lles5O6mJ7CAHqZ1nBEUDfN5s3G6Mb/Dk1FXswcW4x43JX78vc/3X+/Nrmkj9+XpaYnq68xdof2QY++ojyA3wsqNo4s0vMrsu4ggXu/rp+SLVeIAWCSy9wQnsogv3qoXg1Cqfqlwr0yb6djR2JaGHUKaRI8O6XfZa5e7XU5UevbU+o42X6SOFifabSrX2o6BNTQvopurVBkRsMqGKiV6Iz7FlglwindIKP4lLhlGWmsJgUiSr2KcZpTVfnJ8LvqMnTbbaXimwOIkl4TUf+U/iB2yK6Hkdv/xeeF2xnCFQePSEa5sIVtQB0z3+FxSFhX3cPOhHGPX3Np3ovn7vXH4onvGCOeacBdG8c5ggQDqlOCTzUDixokwCgCFTGvgxcMQ/HZ9bvsIC2a8R8a8oP12gZQ9ZB4IZDwaJ8yRJ3ydblMGQvVuCa/4Wex7NBXJVHF7hP3fFLlFFyEjjGFZT2UVxfLex28IRS7lg/gugXwYWF0JOcr62ofqU8wV9Q0Dom/3iifpDjJYwYeL8bLU62QfOnIpkgSZMS/a/1IB17Pg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(451199015)(66946007)(8936002)(36756003)(6506007)(86362001)(2616005)(38350700002)(38100700002)(4001150100001)(2906002)(41300700001)(83380400001)(5660300002)(6512007)(52116002)(26005)(6666004)(186003)(8676002)(6486002)(66556008)(4326008)(478600001)(110136005)(54906003)(316002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnp3Y0duTFZjRzdWZW9FRE9MUTJEbmpMZllLVHRGRkNIWG8xK2licUtraDFu?=
 =?utf-8?B?RElqd1dMcUhjWmdHaDNOT0RKV3hSallweVhNUXdiZEN1R2pVK0pla0RZQ0xT?=
 =?utf-8?B?T3FDV3FYeGNTRXpMenFZYkhNc1F4bGtPeWNraHdaOENuN1hyVnpvUUNwMDRP?=
 =?utf-8?B?bk5lVlFSMTc2NnRoOWxqTjZPOVppN1FkWklTK1ovamFoUEVvZzZ3aGpwT2Zo?=
 =?utf-8?B?N0thT3Z1Mm5WN3M5L29ZYWdPbGhEQkYxQlV5MUJBYy82aDBHVUZNK3hyaSsx?=
 =?utf-8?B?YVdzS1FTNk11bkRhaGpFclAwL2s4UUJPT3FyOFVBeFFrcW5td1ZtK1kyM0F2?=
 =?utf-8?B?aG1QRjRMRmJyb3BqUUUybTZOdm5iVy9XWGp2djJ5VVRCbTdyL1JZR2p1TU4z?=
 =?utf-8?B?NHRpM3RWRnVqelQ5NnArYnBXWmNIRXRUT0pjQlNnRnJoQmx5ZW5mOUgwQ3U2?=
 =?utf-8?B?VXUyQ0dSWlZpa2RTN2laRlNMWXMvUC9kUTROVTBMMWJJOGNKOUcyc3BmK3Vn?=
 =?utf-8?B?cWRpNUxVZ2RHUmk0eURnN3d6MTgySzh6djYySk1uWGdyNUozNDFia05uZUtP?=
 =?utf-8?B?ZnBYS2pPNTBweE5ZclRLQ3FsVUp2bzhtZGwwT2FpdTRuTXA4Tk55WU5GMTNl?=
 =?utf-8?B?Z29UMU1icFhKdndWVlFHSmlzY2tDeEJaRE1OOWwyRFhMMG5mSHhzUHlQTk00?=
 =?utf-8?B?RWdSRThML3NuVTYrSDdtVXlwKzJUeWF5TlV1Mm91Q2EyeXcxRkoxMTBVZWtL?=
 =?utf-8?B?UVdJUFNBek10MjU3UUJHUDlPUFovUllvSDdKZFp0Ync2WFVVV2ZjTVRWWDE0?=
 =?utf-8?B?UXVLb1VhRS9jY2VYV1pQUC81czF2TWc1Y2pTV2lGcytDQkVTNEF5QVpjczB5?=
 =?utf-8?B?Wmc1NlBjcmhtdC9uRlVxL01RbzNVUFlzb3B3bHpmb2x2dmcyM2NzMzlIVVFs?=
 =?utf-8?B?c1lZT1dRSG1IZDZ3YVJkR25TZXhCMjdOYXhTNzZndW4xeFE4bzdGcmszZk4r?=
 =?utf-8?B?K29Fd0F6cHpVaWJ3dmMxMGNyMGFRVUlTNkw4UTJBVXZKRStlQVhBOGdncUNK?=
 =?utf-8?B?aDhId2ZCZlpwcUxGd3V3UDVsNUJGa1JZanF0TGtTa1Ixb29JYWwrSTR3ZlJi?=
 =?utf-8?B?OHlEK2RtbnNMdFNzWStvZkNORlA5bUx1cXBacUdPOHR6WVN4NUJ1OVE3YjJU?=
 =?utf-8?B?cmlHcHo4TXVaSmp2Q2MyV3lPZkh5djJBaERINlZ2aVJKdFFlWkpNSkE1Smti?=
 =?utf-8?B?N0Y5VWRPT3FJbG9xcDUwRHRnNFdTcGF4YnNXSzBuazdGUGFIZWY1Y2hCeDQ5?=
 =?utf-8?B?VUlLbWZEcW0wS05YQlhJZzZXdERxS1hmSS80R3ZvdmdnejRUYnlFRytYRFMv?=
 =?utf-8?B?RGIrcGl0aW5LZUxpWlhINldybVcrZW00T0xnZE9WK1o5S0JML01DWEtnL3F5?=
 =?utf-8?B?bEc5d1ZXU2xhQkRpZTgwQlNTUks0azhQdm9oTjFQMFZFMWZUY3dIa015SGZC?=
 =?utf-8?B?MC81UHcrZ05jYUtyOVdoQnQ3RlRzaHdWNmovNHl6OXRJWTlrT0xzMk1NRE43?=
 =?utf-8?B?N1ZRNkMxTFcyZFlZakt4TmE4Mk5JQzBZOWZoUytVUTZTL0FTbHorTlg2TGJa?=
 =?utf-8?B?cXVvR2c4T3JLUHpiN1FacFYvVWswRUFVNTFvcnpNenloVEE5dkIvK2YzYU1h?=
 =?utf-8?B?ZzhvcjIrYktSYllncVlrMDdianlHNHE5Mm1Dd1NkOVRmNTJVc21jR3NkV2dr?=
 =?utf-8?B?MDdwY0V1TUk4SXNZV0FEWlFjQ0VQUFhUaWlFNk04MmNMZXB1OEltL3phTjJY?=
 =?utf-8?B?NWVTUURTNXVQNUhhdHY0cC94OGMveGJISmM3RTJFRkF2aXNhNUhiTEduWEhH?=
 =?utf-8?B?b2kwNHFua3BraHFQR1JKbHFPM05vYzNxNXRGODBOMG1ScEd5Zmk1ekVrN3ZM?=
 =?utf-8?B?ZlNoV1VuMFJ1cnZwRDZkZDB2NnZlOGFpdTNsdW5WVnY5VGlCVXVJc01DN2Jn?=
 =?utf-8?B?ZStVMzV2THgvRVBuVTRsdk56UTBnUVZ3cjRYblNnZDRqMVVBb1RraFZtWWJy?=
 =?utf-8?B?ZkRNOHZBaldPSFR5eVFBdnlKcVl5a1RGRmc5L2tUbHRwSFhGMkZ1VmJYNVNa?=
 =?utf-8?Q?xGAG9vyAFVPJ6snudo5CWJI6+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f11ffcee-782b-45b9-1d93-08dac61f34d2
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2022 09:04:16.0067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wZNpRrm5668Fy0/GKFQe5yYuM63uC9+zMBxPQdWM/dmZl9kCPuOvTSQMm1y0kcgjGvMxYb7nNra8jCJCIsQ3EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7792
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Mon, 2022-11-14 at 08:33 +0100, Arnd Bergmann wrote:
> On Mon, Nov 14, 2022, at 08:17, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the char-misc tree, today's linux-next build (powerpc
> > allnoconfig) produced these warnings:
> > 
> > drivers/bus/simple-pm-bus.c:96:12: warning: 
> > 'simple_pm_bus_runtime_resume' defined but not used [-Wunused-function]
> >    96 | static int simple_pm_bus_runtime_resume(struct device *dev)
> >       |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/bus/simple-pm-bus.c:87:12: warning: 
> > 'simple_pm_bus_runtime_suspend' defined but not used [-Wunused-function]
> >    87 | static int simple_pm_bus_runtime_suspend(struct device *dev)
> >       |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 
> > Introduced by commit
> > 
> >   882cf4c913d7 ("drivers: bus: simple-pm-bus: Use clocks")
> 
> I see that this is caused by the patch using the old-style
> SET_RUNTIME_PM_OPS/SET_NOIRQ_SYSTEM_SLEEP_PM_OPS macros
> instead of the correct SYSTEM_SLEEP_PM_OPS/NOIRQ_SYSTEM_SLEEP_PM_OPS
> versions.
> 

You meant RUNTIME_PM_OPS/NOIRQ_SYSTEM_SLEEP_PM_OPS macros should be
used, right?

Why not add __maybe_unused to the callbacks like below snippet instead?
This way, the old-style macros may determine those callbacks are NULL
or non-NULL according to CONFIG_PM_SLEEP and CONFIG_PM.
-------------------------------8<-------------------------------------
--- a/drivers/bus/simple-pm-bus.c
+++ b/drivers/bus/simple-pm-bus.c
@@ -84,7 +84,7 @@ static int simple_pm_bus_remove(struct
platform_device *pdev)
        return 0;
 }

-static int simple_pm_bus_runtime_suspend(struct device *dev)
+static int __maybe_unused simple_pm_bus_runtime_suspend(struct device
*dev)
 {
        struct simple_pm_bus *bus = dev_get_drvdata(dev);

@@ -93,7 +93,7 @@ static int simple_pm_bus_runtime_suspend(struct
device *dev)
        return 0;
 }

-static int simple_pm_bus_runtime_resume(struct device *dev)
+static int __maybe_unused simple_pm_bus_runtime_resume(struct device
*dev)
 {
        struct simple_pm_bus *bus = dev_get_drvdata(dev);
        int ret;
-------------------------------8<-------------------------------------

Regards,
Liu Ying

