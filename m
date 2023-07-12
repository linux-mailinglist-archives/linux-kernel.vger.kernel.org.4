Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F92750002
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 09:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjGLHWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 03:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231916AbjGLHWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 03:22:01 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2073.outbound.protection.outlook.com [40.107.7.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8E1E49;
        Wed, 12 Jul 2023 00:21:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UliDnoODM9IRpV4FkghTWfLcCHQffF2bcV1KVLKcR/GgzKvqV47OvQ9QwdJsfpumtDc/vnyXm/z5kRNg6IGz3LaKCpu6eREkHKivjRZAu1XoKIeiR9EQT9eblKToVrOS1OWCauNKLCFbZdS9eNuduiSNxNDvLdbXzlkiUNrN2SDKt58IzSHyVW9fTKLr4SnYLkig6UA58Xym6Jlt07i0ijnNhORX2dqkiHZBWSsvCENCPC++aIq4+r9bHHYUMpLRfRIC4XHA/u4NQiqn7eeto1u3+b3Im+OHxmmnDS2oeAMUe1YsLf4azOEl5ifANApxovm4+SYzmFCil+Zpjupt+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2gqtwjfdjibzSMjtncdI4n2YrcP8m1Xj2QL4XqozZE=;
 b=GHNhpC3ozP28ySDZeVVzgH6WkbG9kNc2GlavVS96Sl97luwjfWhGawg85L+JpAHTthzz9zaiEzyjeYiSTc9sniWN7He/YwRyWUlbcbKfzrfHGefy0BmVW6DgCVGnZT2pIFH3Rfmwvng+jjeFMnl2KRO4pP+a+3Ek9BQhdrtqnWfcbexDT0RNuJMh/9F7jwxzVceteEgxbK8wQ0DskAsM3wPiGsecJL7LZEILb8J9pc8f5jBdcQxgqxfREidkM6tXSXt4X+4DHdG6j+/Me6AzZKHSa5VQWw8QIEVXj7fOHkrskhRbkX9EPyeL4UFdrUicCt6rU+tBMpNa04586sQ2Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2gqtwjfdjibzSMjtncdI4n2YrcP8m1Xj2QL4XqozZE=;
 b=o4VxsF19W0pcJEmKgcm+z29OJIj52hsxqvivEoKvwcN7Q3fqZ5lMGlL6CjfXccOEPTr5arjRwHNHtf4lsKUIQ2hkvLbBmCVQVEecbnuJNpSWkOvZ0lHvPdSSzpJzWgUdOam3V5OIL4EQfRMOWST5FQ43BYdm4tUGsRafCx+lB1ElT6RN0xxBpBLp9W8HthfLlWTTHL6C7fpdWTv6RVjcDiNGQQMs7Uiww0i0BjuTw8/at2QHHg6EvUKkNTDeTy4Js1j/1g4HThGxvYtY8EqZEHmdhhoOG3nxRYeO6oPn1P46ubpCKHub4YrA2s0ZkVzHrswm/7NdRsOItat5lZGaDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:269::8)
 by DB8PR10MB3242.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:f9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 07:21:53 +0000
Received: from PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29]) by PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a171:a3f2:99b7:5f29%6]) with mapi id 15.20.6565.028; Wed, 12 Jul 2023
 07:21:53 +0000
Date:   Wed, 12 Jul 2023 09:21:47 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Cc:     Tobias Schaffner <tobias.schaffner@siemens.com>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>
Subject: Re: [PATCH 2/2] platform/x86: simatic-ipc: add auto-loading of
 hwmon modules
Message-ID: <20230712092147.061009b2@md1za8fc.ad001.siemens.net>
In-Reply-To: <20230711120842.30044-3-henning.schild@siemens.com>
References: <20230711120842.30044-1-henning.schild@siemens.com>
        <20230711120842.30044-3-henning.schild@siemens.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::13) To PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:269::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5780:EE_|DB8PR10MB3242:EE_
X-MS-Office365-Filtering-Correlation-Id: 1127f031-a1f5-4286-8444-08db82a8aaa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yelzulfM6Re42/uo9o+M0bTYoEiQVQ1UrXQJdjeATcKoOpy383e/f0FBRsoltY+ULj8XMxEC5p17JWBorRZEGRERRARVcYc+CV3ku5vzaEtWEpR6q9F0wFiFP4hA07HCYi1fzwPidUag6XW1dzkpP4gs4BM+OzyPdOir+YsQQUQBBUFenwll7aU3aKPmiAjR9RzjxG0NbmHxWKtXNrtxaMkVcxhGNbHNIYjQcZkHS3vAFpxp3NUOpIYZI7Gp3PQl4SC5GEsXtW38cf2bQhHGPOwmH/w/GKLVd4vB4dAQusDVHVF6gdb7k5qHFgd9y+yuQZwc4YlOU/NX/QAZJujHNDT9dVNdb6rfyJ5MPdT3GrUIhD0vqgll9bInCg46lwZ6/JibnkAge7D0YAsLYxiqdw/xRgbTBzTa/lHBGNCcO6NIAGiKp2lY9fdSHKIIiMeY1QnQsIZxRyDkMg0fPw/BYPx6b0pvoePCOxH9OdiTacZa1tYOKpuEWDIOLjzUU7qdXXrZBnUGIaS5DJPP0HyRkg1Jgz6Le99td/5QDFz0K21QuX4paQME/+QOfFpBQk4O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(39860400002)(376002)(396003)(451199021)(2906002)(6512007)(82960400001)(38100700002)(83380400001)(186003)(107886003)(1076003)(9686003)(86362001)(6506007)(5660300002)(8936002)(8676002)(44832011)(110136005)(54906003)(6666004)(6486002)(478600001)(41300700001)(66556008)(66946007)(66476007)(316002)(4326008)(66899021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9/aOym190VjTk3ctHl7+XUX9xpRbSB6RtgIxiSvLCguaeUiUsuW8Tz2zbujS?=
 =?us-ascii?Q?T9vmeH7THrT8DWi9eI0rvSgtRTNXjrI6gLMlnE255yEDHD5qaE+R411NTJot?=
 =?us-ascii?Q?K2zBL6A8M71hH84yPFAJP9gx7US4OiPpUex+gB5gSFk5YdkZkLVenM2nH+t1?=
 =?us-ascii?Q?+AlzdcN9uwreULXSx2Kii6GidCrj5D7PdRNHHQGHjCYGsmedt9e8U7hdHd5q?=
 =?us-ascii?Q?jFVjaGf/R8iPp41Kq40OJE5RTXsXAVYaCIhxRVxHCtYky6rFa80Df3fGxyY1?=
 =?us-ascii?Q?y+wLMY+Y44lXGZVspuBQ9WQ6ao6Zz+9dwBaChCDHBNvwyB3Dx+T/+KiMiYDU?=
 =?us-ascii?Q?VnfhGTkaU9rgRlOy2g578xPjwcce7DvMU/uoineWDQcCog+diAoj9m2AYixK?=
 =?us-ascii?Q?r1UdIjOlYPA3ANLrNM94yqqgz9RE5kgo5yMeDAYsWftECapb7TTKX/6nBpOr?=
 =?us-ascii?Q?z+UbPvWjqm7h12n4105MGE10Ef9bWXohe45/1T7cIIdUAZz2RP/fmnCFUbE1?=
 =?us-ascii?Q?stO9wWNwm0NaOIi28O7becv+xPxTn8dQz21lcFuHjWLps7yj8YFQag5YQ6H4?=
 =?us-ascii?Q?2XNOKqORloH8C+3euxrp6LQh/iK0lI/Xjhh5TGDOKoBvhZcIT1g6a20JW1Gy?=
 =?us-ascii?Q?JtdXl9F0yvvzpjtiWxcVOx0JwyBqu2wNq8jJqrKKAguqsuvjGFbCA5Wvr872?=
 =?us-ascii?Q?gYXvksvtdowZ7CEy+WivquB+NaBVyvSYIFXS1GFce21TFiyVN2iX7ucunJLk?=
 =?us-ascii?Q?uL1i2VJQXmYM6LL9pUyRSEuYcEORVxiWy69V8Ccd5J5Nb0wy8Ef0Eg3DupyK?=
 =?us-ascii?Q?RzfozMAxpsj3NCyLzEdHa5kewZhvQGLdfxPqDByTpXE7Aton6vQbQ4rD8hT5?=
 =?us-ascii?Q?C/HrTWLS1ODAH/frCArYBkzPMoH0BCoFUroReaExkXTw1i/dlKkYZtvcxezz?=
 =?us-ascii?Q?mLqHdDUX5BkW8stKk34YgELwvblJAq0kBvhsrZ+1RQBhxgWVz1JWdszdAt4j?=
 =?us-ascii?Q?C0Xa69ZM76xE37r5cuHvkLa7MLuzxqtLltp8TeNbCiolMEA/KyAz53LCfgHt?=
 =?us-ascii?Q?LFzMD9eIcTkvoPiL+newdWP0sXsoBh9DcbLOa+7hc+K4aEPwWiXYt0ptq+vB?=
 =?us-ascii?Q?99KdhB1aj3V81djjLu4vKZZkMf8lNSKLVHRCxXp+NoURKwdAkY/TJhGfM444?=
 =?us-ascii?Q?5mWDUkq//PaRm2FW8urV8K1SG0IWiAIGyvEWY79sepVN+OtUbwD082c+G7lj?=
 =?us-ascii?Q?8CMqx8raSjmD6vpeFSxZAwwB+KGZY6oquyrp+8Mc4yT1/AzhWAfA7/m6HvL0?=
 =?us-ascii?Q?zKqcrJ+g73DaTVRyrt8GBN1YvhxDjJ+RKG6u91NlFU1FVDYAbIJwEWu4vnSd?=
 =?us-ascii?Q?N4oZWKKu9Mr6nP87+VD/dPc9G91ru1Rbz2p5EvZC3d8V/fGsedKHkOEo0a05?=
 =?us-ascii?Q?kP6+JR5/L+bTA+gObbyNlT4qi+LTi8UKLw11E7XkzKLxg2IdfnpY+Fise6KO?=
 =?us-ascii?Q?pjUOWLEJPpUOoNXK+P9hOfQHXZJLMbLNb/SirFisZsghSavOgvlnDLS5k+XV?=
 =?us-ascii?Q?pvwG7UPHtxiJmLECHo/3FcVKP7naPoESjYwt6VgCBEVatqg580QOUSeWx5Zq?=
 =?us-ascii?Q?PVIEIGtUGSRY1hGP9oyVjAQTixlbEQDlRl7z+Gs1WJCbNN63C+7FID7NVB6V?=
 =?us-ascii?Q?SSd3uQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1127f031-a1f5-4286-8444-08db82a8aaa6
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5780.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 07:21:53.3361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FgIJjsdTvbRFG5ENSeCAeaL/kUcE4iZKm7BYI3GtdMucOr21qlkCMj77TWzQrfqiJuDmVghtGracyO9ZgPE+5uuyxh1vvnrG4+/4n3IRt5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3242
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Tue, 11 Jul 2023 14:08:42 +0200
schrieb Henning Schild <henning.schild@siemens.com>:

> In order to know which hwmon modules to load one would have to usually
> first probe from user-land i.e. with sensors-detect and create a
> config for each machine. But here we know exactly what machines we
> are dealing with, so we can request those howmon modules without
> user-mode detection and config files.
> 
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  drivers/platform/x86/simatic-ipc.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/platform/x86/simatic-ipc.c
> b/drivers/platform/x86/simatic-ipc.c index 71487216d33f..403dc231bef7
> 100644 --- a/drivers/platform/x86/simatic-ipc.c
> +++ b/drivers/platform/x86/simatic-ipc.c
> @@ -153,6 +153,21 @@ static int register_platform_devices(u32
> station_id) return 0;
>  }
>  
> +static void request_additional_modules(u32 station_id)
> +{
> +	switch (station_id) {
> +	case SIMATIC_IPC_IPC227G:
> +	case SIMATIC_IPC_IPC277G:
> +	case SIMATIC_IPC_IPCBX_39A:
> +	case SIMATIC_IPC_IPCPX_39A:
> +		request_module("nct6775");
> +		break;
> +	default:
> +		request_module("emc1403");
> +		break;

This one will be hard to maintain since every new model would choose
the default path. Requesting emc1403 on a device where that would not
do anything is not a problem, but still. And people might forget to
even look at this and maybe name a module that should be used instead.

I will send a v2 where an array of module names will become part of
device_modes. The array would hold all additional modules which do not
autoload. Then the module w83627hf_wdt used for some models can also be
part of that and no longer be modeled with wdtmode.

Should anyone have objections on the whole idea of requesting additional
modules, please already speak up.

Henning

> +	}
> +}
> +
>  static int __init simatic_ipc_init_module(void)
>  {
>  	const struct dmi_system_id *match;
> @@ -170,6 +185,8 @@ static int __init simatic_ipc_init_module(void)
>  		return 0;
>  	}
>  
> +	request_additional_modules(station_id);
> +
>  	return register_platform_devices(station_id);
>  }
>  

