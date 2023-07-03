Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B2B7463BF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 22:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjGCUNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 16:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjGCUNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 16:13:50 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02olkn2057.outbound.protection.outlook.com [40.92.43.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D77E47;
        Mon,  3 Jul 2023 13:13:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EH91yi1MYg5AL0I6Va9a1DNdfai7pHQClvssF4386iFba3Hm0vmPbDH3IMDWt3PomhE99riEoikKFWf6Wla8MPm7DB0uNa6PrmkuKJQ8lxK678QcbtKdwSjfZhNYaP+V6VhZK8IVb3xDRBeg0nFsO2zRpnLofq2XPIb2XdeG9/FzbZH8lZS1aAcF7BJU4fyXWUZva1NboRuU/nkWlVlzqvgGiRweLZLVGQfjUsfiRA1HUOzA2icHJBhN4FW8gaaUmVVF3Ka7xLHO5UOTtNS44UmarzfPpKHVsQgQ7qLuHKaR2fFIERsQnYxTHbnBI8d2g7bGICOJWuNMNteJN2w1LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJpCOCzz8X5hfUNpteUV4HEQGKIkFqNEb6daDwKyrNU=;
 b=ayvmYe3Q6V4eJYrAkFEifbYU9ZXVYIkj44ua4SpnKnrGhRdNL1n6tfmOsV79VfrmMk+QKocVKR70Qewm29QJWkk1XQPZZ0Dmu/9gRafusQ7acuh5tL6v9MKYf4REIjP1Iz61LvHdh4tDl4j8GOB/Aw5AndlidPsWO8g8Vv+c2r9iJQxsCH4Var2K+LMWoEnJMay6tlfgCtc5vjSlbhBDLmLHCXSvd2/sCmExbclrqx3qbm2S4iuJF/w6GN0QpZM7OVegH4gSWqYt7vCuiUDdhhTWkkiRPe/AQBGIbHRCqFQoLjKzjrf6uur5B4kySgsZhnRaFebkAyejpjW15u9uKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJpCOCzz8X5hfUNpteUV4HEQGKIkFqNEb6daDwKyrNU=;
 b=BxH6xmi+5KfCO0a1u4fyenEfm3b5N4e5h8/6NaxQ9j7nrzAeg5+NRGnp4TZrNtmnfh0dyCvCzCiNfZKcV98jSfsnG330e9Ohi+cbApSzZao0gboX2II28pwusBI3DrExBZqfSpRhNxVFvNxEp7XvEz1ZpDESqiDnwC+NyfC5tKKYVkdfac8MW8NfpkJSWE4KMOt4Dw1IOzyOsqo4BqM5cunzAlINBVTvLkkvFhNBV5r6q2qWR3574Sd74Cd8lq1/+0Lu2V51/tRP2NzAgCLjVsa6QiGhrZdclIkx2qkOh/FHwq7aV4J1dgn+6eTkNBi64wOUuv3toOQOEbhC5ACnIg==
Received: from RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM (2603:10d6:10:c9::8) by
 RO2P215MB2581.LAMP215.PROD.OUTLOOK.COM (2603:10d6:10:109::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.24; Mon, 3 Jul 2023 20:13:45 +0000
Received: from RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM
 ([fe80::6c3:80e7:184a:98bc]) by RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM
 ([fe80::6c3:80e7:184a:98bc%4]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 20:13:45 +0000
Message-ID: <RO2P215MB19383189863E11A1B242E02BA729A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
Date:   Mon, 3 Jul 2023 15:13:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: After kernel 6.3.7 or 6.3.8 b43 driver fails
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Cc:     =?UTF-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>,
        kernel test robot <lkp@intel.com>,
        Simon Horman <simon.horman@corigine.com>,
        Kalle Valo <kvalo@kernel.org>
References: <27829c69-515c-36a6-4beb-3210225f8936@gmail.com>
 <b9428e48-f0f9-46f6-892c-4c8834c930c4@app.fastmail.com>
 <RO2P215MB193850DDADD38492BEC8CC2FA720A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
 <a3bc5eb5-9639-8016-36ab-105abc8c0ca3@gmail.com>
 <69b98eb4-2c4e-fe75-90b4-4b08505a595a@lwfinger.net>
 <RO2P215MB193879B2D99DD0BAF59EFA92A721A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
 <e0a08449-554a-4a28-ac50-7051866eb95e@app.fastmail.com>
 <da80b806-de3f-c7ea-0352-cd23e0f6dd65@lwfinger.net>
 <RO2P215MB1938BD13105900F3525E0FE7A721A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
 <67faf4f4-f36c-3ff7-03b8-cd259e4a5548@lwfinger.net>
 <RO2P215MB1938BA68BBB683EC696F4BFAA726A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
 <6afa0ebc-1d3f-8cba-79dc-8ddfe13c296a@lwfinger.net>
 <RO2P215MB193898F3008E0F390CCEBC87A726A@RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM>
 <89429625-5b5a-d0d3-ae82-0b7204262980@lwfinger.net>
Content-Language: en-US
From:   Sardonimous <sardonimous@hotmail.com>
In-Reply-To: <89429625-5b5a-d0d3-ae82-0b7204262980@lwfinger.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [Yb/hbVDHc5YTJxrvphA5UDXemcqBem+KTQwwHJXKIW/eNM5OAPwCwdvYJ1QDNW8+]
X-ClientProxiedBy: CH0PR03CA0397.namprd03.prod.outlook.com
 (2603:10b6:610:11b::30) To RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM
 (2603:10d6:10:c9::8)
X-Microsoft-Original-Message-ID: <840334db-8a70-8ded-5292-c8ef92e4eb4c@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: RO2P215MB1938:EE_|RO2P215MB2581:EE_
X-MS-Office365-Filtering-Correlation-Id: f61c9050-69e6-40ff-337e-08db7c0200d1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R1ZeQh1DYIzHlqyDj5k9VIl2KPjwaCXju5PTWJyCHsk3t/U8B90NQv/E7K9HUXPENFjE8SeMtTmg4NQF2GQapjnKlsoH2tcY+d1c97p4h9MDUAu2eq+N0UlbQD6f6+nrQBvTmXXxN8JRU0qPcE1Ge5UHjpIvXTJuC50gNAbZR8UwwtoF+H4OOoenJOPv0RShqzglnA8ihHfEGQUj2gXhYR+ueyonRv2O0Whivm+4zG7txsfVJiB9rTW/AqoJYc0nLvYq9FUyA7bzw46WvlpLX5T4O32YnWRtnSBXFmDBT0b5gvKkWF8gnjye7ONwL+99brzHWFNmTwSM/T7BDmu3zAcpk1M2KjTWE5uMgPTHAUOfOYGzRftGgmfi7Ek4PnMmwvpD9fmXEEVLPXu3vtsWpAnq1iLUBQyXv+pLPVMBVaDff+DQcAaCf80DCBlllTaHCAzvEjJGL1RclwUAiTSAOjWrCG3cLPZAImyOYVv1N0oiMrQnHGsAtWBHIKpAaWLpX+aztkCalzUTigUlsNzL0aaTXT0PGthOiXREevFG3GkaV40AqLk9OYvF9o5X+q9O
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHBnbXZJcnY4bDhzazN2YnlKTnUrTlhBOUdidVJxUzBSUGZYSWJFNnNSdDc5?=
 =?utf-8?B?VjlEZW01eXlwaUtyWmFUQUJCQUprRy9HUFFDRW10QS9uWTZsMDdGamF6NTJ1?=
 =?utf-8?B?eGpERmVGMkE0Vjl1eFVIV1ZZeGZWSGJlbzdLZUprWStXNDNxVTRZK082bE4w?=
 =?utf-8?B?ZUd4Zk9DQmJsSS93My80UEVYY25HZkQ3WlBGcnZveCtMWFA2YnNNYklhWlFO?=
 =?utf-8?B?L28zdVluL2tpRU5iRHdjMVQ0a0JuT0VpOTZOVk1pQVYzcGpOcFBzUnduMXB2?=
 =?utf-8?B?SUNHWGE1R2YwZ0FNaWlDd3R4VkVTTE5ISStzTHRwalFiTVkrREdBRFlNakhV?=
 =?utf-8?B?ajRlNldtUU9TQ3o1alJwL254M290U0RpeGJXeENReFBNck93NVdqSWpaMDF5?=
 =?utf-8?B?VDlSMWhNbW1UZFlZV3JSVStqUUJ1RjFsbmlFZURQdzFURCtET0VGZ3k0NDJD?=
 =?utf-8?B?RGFna284QWwra2RlQll2TVZNNURiZjQ1TWVQcUhwKzVsZXFpYUZ1ZTE4clE3?=
 =?utf-8?B?UzNRMUF2Wk5GUXlmSHdIaVBRQkdid1B1YUxrK2dqTlUwK3BrN3RJYkEzS2Zq?=
 =?utf-8?B?N3IvdUt0RXd1NzVHTWVvSGJSS2g4bkNvQlFvV1EzTUVSM09zR2JnSDFidVlE?=
 =?utf-8?B?S25YK3AzZHdLMmhxRm44M3BpcjUrb0ltL1FEMHJYMXlCOFkxdjJYNTYzQ1FN?=
 =?utf-8?B?Wkp6d0VjQUQ5QTNJbUZONmtpYzdaOGxVbS9DN3hBNlhjREJMcFcwdFFXOWow?=
 =?utf-8?B?VGlhMDM5MUpYdmJTT3RhdERaL1JESXhxbGZTNWNZL0xOOGdYVlQwV05lc3JC?=
 =?utf-8?B?amtveE8yMmVHSUdVY1NxN091S2xrUmRUbFRYdzAyTU1VdzJXWXhvR0kwYThn?=
 =?utf-8?B?QjlJTW03L1NHQ3hKZW5HOXJST0t2VXI5NTJVc205WXB0YTE2VncwdzZiU2Ni?=
 =?utf-8?B?VkpQOXNuWDB4bS8vNW1abWZkUmVQeWhhSU5kQW50clVRMEZJZWxSc2FMUFpQ?=
 =?utf-8?B?TnVhUUVrL2swUmVaMlIxdktvamo2Mk0xeFhNbzRmZ2ZkSURCVm5qU1RqcTRB?=
 =?utf-8?B?YkkxRHJNcDk2V0JGOVEyYnB3b000SEZmYWxibW4zZS9qU1o3Z2E4SGYrc3NP?=
 =?utf-8?B?Y29QaDFPYndVMGdIMmc1MEJsVG5rS3NrWmhUL2VRTTlUQ1pZalRyUHE5V0dB?=
 =?utf-8?B?ZzFjZXpPMkZraFpReCtNQk04SjlNeHdLTk14NXpMbGJ5RFVLQTlqdFlzVGhn?=
 =?utf-8?B?RG1adE1Ma0dyZk1RcktWVStCNmRnK3grYitlR2xBQXBGR3dlc1BxSm5VY0Ry?=
 =?utf-8?B?LzJEUGFGRjJadkpwbDg2eC9xRkR5eHFMbDdPRjkyMUZ4cndMcmdmTkZZc01G?=
 =?utf-8?B?Wm81T29xUDQ1YzZHbkN5ZDVuaXlvTCtvc2ZKZ3MxSjQ5c0QzT1h1M1RMRzBK?=
 =?utf-8?B?NG02VVNOUnd3STFZSnhpMU51M0M0UFQyUTR6U2JJRjVyM25LajE0YnkvODFh?=
 =?utf-8?B?THpkNWRpU2lEZnJFSW9yRVpINEt0Um5URndIY2RtQUI3WmdYUHdpS3dGR2xW?=
 =?utf-8?B?M011S0w5UFNMZzJVOVJmdFhVSWZWenp4ck8zRmpDbDNta2JSZk4rb1M1ZTlQ?=
 =?utf-8?B?NTI5YmZiS0w1N0lQRXAxbHlKbEV5ZSs5dTk2aktac2hYZmFLT0RaWlFGR1Zt?=
 =?utf-8?B?c2xCVU9SWjczcHczZ1RlNHU4dk13TXhZcW5jRGZhWXJOVXVIalo3QTJzeUVW?=
 =?utf-8?Q?0ze8jqGQjR07OzMOzQ=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-7d2c5.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f61c9050-69e6-40ff-337e-08db7c0200d1
X-MS-Exchange-CrossTenant-AuthSource: RO2P215MB1938.LAMP215.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2023 20:13:45.4559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: RO2P215MB2581
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/3/23 12:35 PM, Larry Finger wrote:
> Sorry that it took so long to get back to you.
>
> For my ppc32, there is no regression. It took a while to learn the 
> pio=1 and qos=0 are BOTH needed. That I do not understand, but with 
> both set, the device works with kernel 6.4 and all earlier kernels 
> that I tried. Fortunately, I did not need to do the entire bisection.
>
> I am working on eliminating the warning that appears with qos=0, but 
> it does not inhibit operations.
>
> @Bagas Sanjaya: Please mark this "regression" as invalid.
>
> Larry
>
I appreciate the time you've spent on this.  I did try 6.4 again (6.4.1 
actually) and wlan0 did eventually come active.  When I tried this 
before, I probably got freaked by the number of WARNINGs when it wasn't 
connecting, but perhaps it was failing for some other reason.  I didn't 
realize they were only warnings.

$ uptime
  15:10:52 up 9 min,  3 users,  load average: 0.11, 0.92, 0.85

$ journalctl --boot | grep "WARNING.*__ieee80211_stop_queue+0xcc/0xe0"  
| wc -l
111

Regards.

