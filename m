Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3256EA863
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 12:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjDUKe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 06:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjDUKex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 06:34:53 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2081.outbound.protection.outlook.com [40.107.7.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CCE9EF4;
        Fri, 21 Apr 2023 03:34:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHtyhUm9upcEw40ZE6B9reUXSNgglKjaugUC4dKOL8Zdwx0esONjjbuXeNuwhZoW0xEiz8xD/giCYilAofw28wr/WZmw3w2uX4Edh6Ffhzk1Pp8q1P9RRs1OwDrRQUeLH6n4I0Qp5Yqw/CrtbRRsOGrhJZb2ZO5VEeFjnMieEIKrcox43z893EYASTnC9G5C6So+Bax0JGaJKHK2WZ+3ZiNmnQvaF/BBDjyKh0AgtSAmQ/StAeL1LwhWdMfozu81vn4PkljAOmhOSFooJjWewn1fB+yqdXfDpmDIF4VEEEVnB42LHFsvqwnCM7q/Hy3bJXqhAR4cIQJ1OHDyS7no/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBQk3Pab0QUqpOC1S8BLpmt0kcdz7ojZ/xi4jxmARs8=;
 b=NbSR9XlEdhFWxbkrl1OL8sHYHCfXAE+7DwxYZkqji2Iq2M/bU0qPP0IDjqpxxtowq79rG8qLD1wq3anjCnZmMs/y5pZp2HTbbSi2+//8LW6W6YcqJTLYfrGmpckWz3Nk3wUPMhB5MJT+lQiD3adPso9xGpSFA/CnaFKXqftnMiZGyeZ9pofVaW83EOQ8fu6wSPFBrdDAypwh1ODZsAmXYgZYzMJSFqSFNJMhmK4XQ7OP3Aa5Uor7vCd2FOf+SoVIqk8PLw9pU7Y+Zd6ZDI8EyS85zTKaj6+dT8Pfgp1xTgy/kVxWa9Poca3OL+3HcFpLc7Pj0XvRFSrZyMkl0gmp7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBQk3Pab0QUqpOC1S8BLpmt0kcdz7ojZ/xi4jxmARs8=;
 b=Yni8kgAhbUjaT+Hq385fjbCqvZ2xIzKgWu2EopcbKKEc8YseW53UzsaKVUTrBA2wflaHyUI1z4WdqA1oOkZDnPmjJuA7t7N7QMlFeCnazcd+yx3cLR0I1R5vFhoy3lEu/kJM57XoBLMTgPDHNxT4zbaiNJC28lMeoirGwvbstJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by AS8PR04MB8005.eurprd04.prod.outlook.com (2603:10a6:20b:2ac::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 21 Apr
 2023 10:34:48 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::b6a5:b35f:94f8:ff53]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::b6a5:b35f:94f8:ff53%8]) with mapi id 15.20.6319.022; Fri, 21 Apr 2023
 10:34:46 +0000
Message-ID: <fc400ed5-9e9e-bc68-a372-ac13c3ab9a77@nxp.com>
Date:   Fri, 21 Apr 2023 13:34:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] remoteproc: imx_dsp_rproc: use modern pm_ops
To:     Arnd Bergmann <arnd@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230420213610.2219080-1-arnd@kernel.org>
Content-Language: en-US
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
In-Reply-To: <20230420213610.2219080-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0117.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::34) To DU2PR04MB8774.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8774:EE_|AS8PR04MB8005:EE_
X-MS-Office365-Filtering-Correlation-Id: 72977413-9cd4-459a-183d-08db42540701
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EVvlAA6Nx1wrhF5cb0jeIrJgYcOAJQjpvstbmojeltOzHUWtui48F/zvnLzoIAMDrMkCFVBhUi441w19hCBZXMVy97UJHJR4eMkIrd6lQMRdKP72hyJRcA0TjH9rT9MbNUkC3ygq0J1hTm7pL9g92VSaY4WZ6VAU9SFa2VCZDNkRKwqiNUs/Uv0FshpCHuMLrEW6vUvRsO+OSArMLFz/M+eu6CChYeYbxovxLqwrffvRzD7cEtzGlm3bWR6P+pAeWWlzcSwzqvsro3XGVC8R5WAZa+1NPAM3SVDmb5iyDLBPqtx3DI9lXpufqoADDhuRxHqFy/Iw4PSJtz7qRBSh+YGIsbZYB8CHOTe69/NE3+JJkX0yS+F2ukZdBKSGjROk0bFGlIyCHHd7UDqNq9m+CjXASHTlTbQYyMqkhXbvpFl+H+Ac/smjb1xGUb2VWKNRoWvNPpBzO911+WTP/c4F8BAjeS+5XIs2+vXDTLCDnFhYrYLO5cLXMlDi7lgDrVz8LHwW3/RR/aWZaLhg9uoNA6n63gMsJCvUwReURWJhO+LGVmnr9uG9ueqixylqljFddu65Nuk4m3sm6sqzQIMAzvwC48b7G7zRlPzSDHEy6qWdc78TI1ykC3OJ5mwFOQ1ALslK+VadBg2x6y87F1yeRQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(451199021)(54906003)(110136005)(31686004)(83380400001)(478600001)(2616005)(6486002)(6506007)(26005)(6512007)(6666004)(66476007)(4326008)(66946007)(316002)(66556008)(41300700001)(186003)(53546011)(55236004)(8676002)(8936002)(38100700002)(5660300002)(7416002)(44832011)(36756003)(2906002)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RENnMzIwYlQ0NjdpakcwbXllQVczRksyNHp5bzQxSjVUdjdUaFEva1h1RXRu?=
 =?utf-8?B?cEhKRU5ua1h4b0RoODFFaFVGVFFWTXNLTy9LdlNLRlpld2RtUnFSNkNBdjl4?=
 =?utf-8?B?Z2dLRFRpcXRaQnNndDloMVhxUnBselFyZ0E0UERzc1FFbnVLSE5BMTBGRkFE?=
 =?utf-8?B?UDB0NjIrWXRtVkhIL1dzSm9aeXd4NHNDWWlwNGdWNnY2R3ZmNC9jMkd3SitO?=
 =?utf-8?B?RGE1djkzT1QwMlplTXM3Q3NrL3E0ZmxaSVZRVU1WYnR2akl1UzZjMWtXYlpq?=
 =?utf-8?B?RkZHTjJQb0NtbTJiL1k1SXJlNnJzN0NjRmlkM0hNTDkxU2Qra1NhR0l1bnkz?=
 =?utf-8?B?b2MvamxUSlpPaWxjVXBRUlRSNG1Pa1N3ZXJ5a3pGVlRpUUhnOEVSbnJnbzVO?=
 =?utf-8?B?bjhHcEN0RjIzM3hPa3pWNmdYVmt0bnpTMXpZaGlvOXhyaXNySVNCbWpTTDU4?=
 =?utf-8?B?c2xSbWdJQTJDQkh3ZEx0NUZRYStMMGZmdkNiVGR0Mm0wMGM3UWRPVXVhL0NQ?=
 =?utf-8?B?YTM2dHUyS3VNRitkUkdyQ0F4dVhvUDlCWXRzbW5Wa2JSZkg5UUUvWlNqbjlv?=
 =?utf-8?B?bVpCREEvc2RkNFRsR2d3TURRWldKTDc0SFFmMGFwc3BWU0M5UkZUSkVyekpS?=
 =?utf-8?B?aW9uU256bmJacHpFcFozRnZDYVArNG9HOEhGWlBlNGNtNzZqTGRPd0g1SUdQ?=
 =?utf-8?B?WkNVZjAzTHZoMmJndkdpSWxaYnF0RERIYnFQc1JIcExxL1RiTkMzSnUxVTJP?=
 =?utf-8?B?T25KbXBUSm5DUnUxUVAyS2Z6VStNWVhOamlrTzZmWUdyMDN2bk9vTFd3Tkh1?=
 =?utf-8?B?NU9DZU52dGJlazZrdkFPaDNFRmQraXlXOS9ycU5XblZSZTJSSXlXb3dwa2d1?=
 =?utf-8?B?TFZFN0s3MlpDUGhPWGhLckJuTjlEeEVyQUl4MjdIclJ4R3lvNWJwU3NpaFNw?=
 =?utf-8?B?a2RYVjEwZGZXbkNmR0Q4ckI4Kzh2VnlJV1pSWkpTdTVIOW1WSkQwbndsTEsv?=
 =?utf-8?B?MEt5ODdITXdlQ1E0NHRTWkJWLzdMa2xoQWs1aCtFcVhwSWxwaXpIR0ovRFhx?=
 =?utf-8?B?TXlQTHV6Lytod3RIaVJIVGtuUlJjMFhhM3h0NnYxQjgwSnVYbGZWelJ4TGRK?=
 =?utf-8?B?TDJhNStIZ0hJMjhtT0RHbzJMOVNrV2xoc2dYRjVYd2p5N3pFMlBlWEszb2hP?=
 =?utf-8?B?cjlnZnhiN1BZMXpLejBtcEp6amRRM2hOSXNMK3JRV0IvUHZsQ0J3cllxY1lk?=
 =?utf-8?B?cXltMUNNQ0pGZGFmTjUvZGpwRCs2SFVuT0RRNnZTWVIvYTFqV2VuNnNMczIz?=
 =?utf-8?B?VXZZV0RkZ1RSYnpkUlFadFAxOFFmZjcvcFhSeTFxeG9kQ0tlWEdndkJUaDk0?=
 =?utf-8?B?aDd3TzVreW83UzVDNnp6L1MrQVNFdVZ1ZlJGM21LeU1hMlJxY293T0pVbGVl?=
 =?utf-8?B?d3BORlc4Z24xcGZmRjBYOUh2RmRUaUN1ZGk0emFxMzhVRVR5NlZTNFNJQ01U?=
 =?utf-8?B?ZVFVWWpjVk1FR0ZsdVpxVEM5WGxUVUFzUVZEcDNxMkJreFpFb3VFSGRiRDRl?=
 =?utf-8?B?ZUpSWUwvTzZqalZZS3JsdnBjSGp1S3dHa0p1NUZiNFNXOVhKM1Bia0RnUWxD?=
 =?utf-8?B?NjB5WEFNTmFMbTJaZnBkNTFhdXl4QVlBbU1odndyVW0zNlp3TER2eTh1bmJv?=
 =?utf-8?B?YzJWNTVONU1VMEZ0SS9YOW5ZdGNxSnNaZXV6Y21STC9NbW1nbkJEbFBvV1JJ?=
 =?utf-8?B?dVNWbkZscGFKWHpkN1k3YU43NmZHVlFMdTVCc2tzbGE1b2hWUUUwMGg2RS9Q?=
 =?utf-8?B?RVFMVHBSQjJvVWpDYjJ6UWRJZXdXNkxQajBnTHZ4V0hEVStybVl1QnpiRDQ0?=
 =?utf-8?B?YWtrSnBXOXV1VG5NWmMxQTZHZmNSNWd4SERLbVFJSTlvZUc3eG1UdUkvcGRa?=
 =?utf-8?B?MFBOZGpLWTFjNDBMNWdxb0R3OWs1ZzZ3VkRJeTNiWTZFdkEvNDVTREdkUFZl?=
 =?utf-8?B?RTZxUjdxM25JV3d0SkxwYWpRZ1ExTDFBVGpMY1E3SmNXRUxiQ3czTEN6b0Qz?=
 =?utf-8?B?bnpNcFg0dTZudjJsbkRyREg1YUVzNGdFazUrTGJFR3JSd0ROSHA1MUgzazU4?=
 =?utf-8?B?YXVuaU1ROW96TktzcVpKWGlJN0o4WkUvelp6eXdmdzNFMUIway8yYVZrenVt?=
 =?utf-8?B?V0E9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72977413-9cd4-459a-183d-08db42540701
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2023 10:34:46.7849
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xWSP66u0MNsrQ4edHhdz410k160KrnW0vYtYL7rAKNBJBBI6AkukL1NZxWAkXLocAPFYT6itsmBRz+c4bB5pbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8005
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/21/2023 12:36 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Without CONFIG_PM, the driver warns about unused functions:
>
> drivers/remoteproc/imx_dsp_rproc.c:1210:12: error: 'imx_dsp_runtime_suspend' defined but not used [-Werror=unused-function]
>   1210 | static int imx_dsp_runtime_suspend(struct device *dev)
>        |            ^~~~~~~~~~~~~~~~~~~~~~~
> drivers/remoteproc/imx_dsp_rproc.c:1178:12: error: 'imx_dsp_runtime_resume' defined but not used [-Werror=unused-function]
>   1178 | static int imx_dsp_runtime_resume(struct device *dev)
>        |            ^~~~~~~~~~~~~~~~~~~~~~
>
> Change the old SET_SYSTEM_SLEEP_PM_OPS()/SET_RUNTIME_PM_OPS()
> helpers to their modern replacements that avoid the warning,
> and remove the now unnecessary __maybe_unused annotations
> on the other PM helper functions.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>

Thanks,
Iulia

> ---
>   drivers/remoteproc/imx_dsp_rproc.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
> index cab06dbf37fb..2d75dea43f20 100644
> --- a/drivers/remoteproc/imx_dsp_rproc.c
> +++ b/drivers/remoteproc/imx_dsp_rproc.c
> @@ -1243,7 +1243,7 @@ static void imx_dsp_load_firmware(const struct firmware *fw, void *context)
>   	release_firmware(fw);
>   }
>   
> -static __maybe_unused int imx_dsp_suspend(struct device *dev)
> +static int imx_dsp_suspend(struct device *dev)
>   {
>   	struct rproc *rproc = dev_get_drvdata(dev);
>   	struct imx_dsp_rproc *priv = rproc->priv;
> @@ -1278,7 +1278,7 @@ static __maybe_unused int imx_dsp_suspend(struct device *dev)
>   	return pm_runtime_force_suspend(dev);
>   }
>   
> -static __maybe_unused int imx_dsp_resume(struct device *dev)
> +static int imx_dsp_resume(struct device *dev)
>   {
>   	struct rproc *rproc = dev_get_drvdata(dev);
>   	int ret = 0;
> @@ -1312,9 +1312,8 @@ static __maybe_unused int imx_dsp_resume(struct device *dev)
>   }
>   
>   static const struct dev_pm_ops imx_dsp_rproc_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(imx_dsp_suspend, imx_dsp_resume)
> -	SET_RUNTIME_PM_OPS(imx_dsp_runtime_suspend,
> -			   imx_dsp_runtime_resume, NULL)
> +	SYSTEM_SLEEP_PM_OPS(imx_dsp_suspend, imx_dsp_resume)
> +	RUNTIME_PM_OPS(imx_dsp_runtime_suspend, imx_dsp_runtime_resume, NULL)
>   };
>   
>   static const struct of_device_id imx_dsp_rproc_of_match[] = {
> @@ -1332,7 +1331,7 @@ static struct platform_driver imx_dsp_rproc_driver = {
>   	.driver = {
>   		.name = "imx-dsp-rproc",
>   		.of_match_table = imx_dsp_rproc_of_match,
> -		.pm = &imx_dsp_rproc_pm_ops,
> +		.pm = pm_ptr(&imx_dsp_rproc_pm_ops),
>   	},
>   };
>   module_platform_driver(imx_dsp_rproc_driver);
