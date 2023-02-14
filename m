Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A29C6970AB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 23:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjBNWWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 17:22:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjBNWWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 17:22:51 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on061a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0c::61a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E82073C08;
        Tue, 14 Feb 2023 14:22:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9VXLOrHZVW5HTDswO2eZZBpLS7a3jPtkQvZtAJ6tHEGXqB98FA2RgT6c/P9zyMcqsLF5HzuxXhRia0tGOlUrnFfBojvoXQMbktqM4Sm3bULkyGZY3euP9BBfP+FQGaeUtRkXEj6R4pEcaTFsQyNGiIZvg7EkjZe0JuKa6agkW2EzziYESd+uHRcsMruvtQTGFpCqg0qcUvfOR4+yudyVAf/nVTti105XSvRcjKpozNO2rqRycfK6GVDWzmyPknZWPasXhO5JlKbV3/s0NYRu4mAxMJMxFD/sOQjT2Rk21et1nfly1wpNGENwQhpnuBvxZpZP5iTDTsNvaNVRMOmzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIzej2aejIhJnabQ9jp/fvSS53KVTgfAHbqlae9v8No=;
 b=obiWDhEOAkrmoFc1biV/mZDDQVzP71GHfbd/4i7AXa8ZiOI7cjRm/vsiwzqkC+fZgx9IkKbTc0TttAVDP9bK+fDTCIPl4ERQBdbc5DFrrYDiiFss68m8HqmcVjFkdSaLeyAEn2fHxHeyQ1w64oABNfX/798qhz49RKn/gyz/pRnmaYD2pmhAYtL1hPY5hEHvzhhnXWUu3LEXjSbYQPpp2YaLrVbrng0LJzcOErF24PpdrcFqNmt96V7K8vS19Gq/EaP8OnG8H4AXeInyX5HYiallIPZOeR4x+++VrMt8stwd9pZBsfR9Rg6RTu3kw/hU/cU4jLNql/fjDRVxCno2Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIzej2aejIhJnabQ9jp/fvSS53KVTgfAHbqlae9v8No=;
 b=YVNB0VkK8jfy5fHSVF5SxeUxMldMaKrfdfT5bHnqBNRc+Wjdt8+aRFZ23GY68LKnTUIO4AaAfavR9qgP1u3l+rpo2V/eh7YvpG4ipc1fG14CKwtFLU63mIfMZLkaWO7g+EE2W1LDbI1vcSiEOEvV20DuDRF3P3WfpNC4FQ52HEY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com (2603:10a6:10:30b::14)
 by PAXPR04MB8094.eurprd04.prod.outlook.com (2603:10a6:102:1c1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 22:21:40 +0000
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886]) by DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886%5]) with mapi id 15.20.6086.022; Tue, 14 Feb 2023
 22:21:40 +0000
Message-ID: <72c14e53-bfcb-c444-4b5c-98d07fe648e3@nxp.com>
Date:   Wed, 15 Feb 2023 00:21:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [RESEND PATCH v4] remoteproc: imx_dsp_rproc: add module parameter
 to ignore ready flag from remote processor
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20230214163744.16377-1-iuliana.prodan@oss.nxp.com>
 <20230214202506.GA384054@p14s>
Content-Language: en-US
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
In-Reply-To: <20230214202506.GA384054@p14s>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0131.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::48) To DB9PR04MB9628.eurprd04.prod.outlook.com
 (2603:10a6:10:30b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9628:EE_|PAXPR04MB8094:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a86434b-3fca-441b-cefb-08db0ed9d886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sWvm8uBk5UKSbgDh8cs5/uQ6NG0PbwPCOsvUoaFk0R6MteqPmWaMD+JUwasI+Faaz2gGshoq0jbCc3vIJMf9lDUGZktoAGtwQ6nDjJ+FcwtKsc/xXMGMZQKO5YsZjOEtlL2zXHPLM2sgB+9REOH2pJ19rRjuoJCcXCKtuTH8G9UutyuLnhEgxh6Hm6UcoYx5dCOwdx7Prc0i8WWMwzdPXBCmyVgm5mWzwgYbSzjKixoCR/rUgIBt+RFEFn5QpPbzYf8xIRLFpcUioU9d2+RukRZNrtKgkI1ei1Rb8A8eISdfgmYoPsgtfcNoWYDA3P5G2VQRs9TCT1h9kFbhWvXKNmXvzXPg58ICdsNX/WaXZmPF53Asf/WTx3Qz3zLsEVpPtQOCNb5/sb9Ab9YUhaMG/k4vR+jPA72sg9rp3CuywW8XRO9vnHn1Xpi0W78YLbVeydkP6ptUzR1TwzJXKGdNCtoGB717mYq7v5D8DSlpLgdnXnTSffZtNkJzdPz7RFJL6Apk1Dwf/vY/2eetAC8/X/PrnNqhGM06WGS6Z3/33RbSlvw3MZvAazcIDaOwJ9EN7ld4IlrGXUSxTIBishQLqtt4uKhfauE4IFHRAx6Ko/RtBrfxJy/uRmYL7+Y+zPbFpt6UuwiNUGsaYgyDH+mZS6adBkph8+crqpxTI5pV/U41Zzoy7Ba0JllkHym+WcEZ+PShyMSqyacDvBK5At/ZFMVjgSWE8eSmQcLmuHTLhNM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9628.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199018)(5660300002)(31696002)(4326008)(8936002)(4744005)(41300700001)(86362001)(66476007)(66556008)(66946007)(8676002)(36756003)(53546011)(55236004)(6506007)(44832011)(316002)(31686004)(6666004)(478600001)(26005)(6512007)(186003)(54906003)(38100700002)(2906002)(110136005)(2616005)(966005)(6486002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUpHbGpYYVRua0Z1NGpKT3MwR2g1S0FXcWlVQ2hWK3VBdElBcVI2TjNiWkgx?=
 =?utf-8?B?QnVMTVl5eHE0SDVOUUs4Z2hjdTRLVExwNGpDZEN5aFhwRVprRWkwT0RlVHhz?=
 =?utf-8?B?UXBVNmlxdHlKT0pVVy9DWW5VamdBbU02Q01sUHZXRmdrNVk5Tll4T1U0ZCtw?=
 =?utf-8?B?WngreTFVSTlMeVZ4UzhLZWxWcmhGN2ZsTXpEclBHam0xeEovaXFjbGpDNFQ0?=
 =?utf-8?B?ZnZHM0tsajFZU3djN1Jra2NCWkdPVHZiVUVUVkRtRFNMeE9oK3dQZzJ0Zmsv?=
 =?utf-8?B?bTZaSmgvZ3p0ZmtOeGhkbXFVNHgxaVFpRCt1eFJNcWViWWk2T2FIRWFTb2t1?=
 =?utf-8?B?VDc3RzNDaXc3S2REeFBpWmsxNDhWTHdHRUFnTUw2dE54OFpsRDFXTVpnNFRG?=
 =?utf-8?B?bFYvNWgyVEt5bUxBZ2MrNXovcWFyc0I5MWl0aVNvQkg0bkxnVTNQdTB6RVlp?=
 =?utf-8?B?VDVxS01RbHM4UVZPTmNlWEdEa3JYT2Fzd0ZmMzZFYmNiU2lFNExxUEZ3VUNj?=
 =?utf-8?B?cTFtcVdWeU5GdlpvRkFoOUk0bTZpbkorU1RrdU0wTjRqRTNWV3kxVExLcllW?=
 =?utf-8?B?alpQbFlqNUFRRlFCcGVwdVVhY250dUdxRkhWdWMrTlR0ODNyV2dxa1B5ZjdX?=
 =?utf-8?B?d2tSN1ovNkJnT2x6dkFBK0x2QloyNE5wemJ6aHF3QlpQblBPNDQxL0k0OG94?=
 =?utf-8?B?R0JKeWhpTkZVajZkMjlmL2hVS2x0VHgwV015SC93RnZ3ZWQ3aW9YZ0kyZ05V?=
 =?utf-8?B?ZUw0aWJ6KzJGbG41M3pBQjJuRFJPalcveUN0TUtUT1ZZTC9leXlmejVOMjFl?=
 =?utf-8?B?TzZRUjZkOXFsemdsUXZsVXZaQytXSTcwR09mLzBqc1N0RDhPZ2J5dkI4MGh3?=
 =?utf-8?B?RVZpNUhHdC9pTUxrK0hvUHNObXBqLzYxakNOd1pIWnBTTFh2L0d5K3RseXFT?=
 =?utf-8?B?YkFhRDMweWlBSFphZFo3dlVVRUdxQkJMUWpCUTV2OUZnRktIMXovV3Bsbi9W?=
 =?utf-8?B?ZGRNcTlUcDJhME1SeVh0cDNJZXUxUmhrdnk1eGlJTDJVUW84d00yWjlnYmVu?=
 =?utf-8?B?YzNkaGs0VXoyeEZPSEpiRThSc1Nsc21wMEMyWkpkaklJdmVQQngrWGhyTXdY?=
 =?utf-8?B?dmJzQVk3cjZPV2RhRzVrL1RVSURwdk5wd0FzTkhORFl1WEJWV3JKdkUxWElx?=
 =?utf-8?B?RStjM0JLK1FkTlNpZTFQZkdkWW8yTExsMlR3ZzJwcmVwQlRZM05NL3ppRkJM?=
 =?utf-8?B?c3o0ZCs2SHh4ZHBBemx3YUdtVS9OSHVwSHdQSHRaNkxjMTIrSXRqZ2x6cnJx?=
 =?utf-8?B?NzVFbTFxa1lmYk9BMXh3MDIrbllOcGJHWE5JbnNsOWZaZ0d4N09DZGlxdEY5?=
 =?utf-8?B?MTdXVk1nT3l0ZTZEcEhkN3ZMZUdtaUliZ3U1YXZUYm81dnZpejBhVVdFZ0py?=
 =?utf-8?B?TFJQRmZIVE5ESCtEOUphYTB6QWxCT2pHZzM1NUkzSTlvTi8xeGgwNDFmWG5o?=
 =?utf-8?B?VDBraml5cW0yUFlXTVU1ejgrSkVuemNwV1VjekNNdUdRV1JDSGxZUjZvMisy?=
 =?utf-8?B?MnJGVTBoN0ErcnhQQ0k4QmdZbzRDMUxkcUc0RlVXZkVOVUNVUk93Yk9kM05W?=
 =?utf-8?B?WVBVMUo5SHQybk41RVFGQ09rSFpxdnFWV2FyUHBvbGw1VDN0RFI4U3dLK0hG?=
 =?utf-8?B?YUlKUXlMYWNUSG1ud00rS3UxSDFVWkRJVUVUS0hQM0JidTVDL2c2bEdvNVhF?=
 =?utf-8?B?SERNWEp6ekcxRGwwczJDcnhSeVUxcDcwdXMzY0dOZWxxLzJadjJ6ZGsrTExD?=
 =?utf-8?B?Z3BGa2cyNjZNWTJHKzFqZ28xYmhYWFhBRkx6TzdWRTA4RXNEK3dvTnhmbEY1?=
 =?utf-8?B?aG16VWpsL1Q1bGhEUit0elZUdVp2RUlaRjJLaUVRZUIwWHFqeTR0YUwyZjRC?=
 =?utf-8?B?S3Nacm02Q2FzbGRlNm9QQXI2Wk16UWxCdVVQUENHODVhVXpBV01LZkgza25t?=
 =?utf-8?B?bXlDRmRLcmNYd3hja3dlRTVkaXdXOHlqMllDQVJ2UjI2WTRmVUdtbWRKT0xD?=
 =?utf-8?B?aXNMZ0tQUWhXNHlkbFNvV2dkUmlqYnRDNXRtNmlkUElZQktrN2w2eGplMXFM?=
 =?utf-8?B?S3VmSmtiNGlWWVpPN05kdjdQTnM3dGFSd3J2Rzd3TE5yNmtLbE9wVno2QW9H?=
 =?utf-8?B?NEE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a86434b-3fca-441b-cefb-08db0ed9d886
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9628.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 22:21:40.7712
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xGV6RJzEgyFnmnYgixqdHOXJHo9rbMgk1nA5WAUtOrdxMFqC76P3f8cmrz9NZ8cTbPw+iOkg/I3TfQBWldwUZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8094
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
        SPF_HELO_PASS,T_SPF_PERMERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/14/2023 10:25 PM, Mathieu Poirier wrote:
> On Tue, Feb 14, 2023 at 06:37:44PM +0200, Iuliana Prodan (OSS) wrote:
>> From: Iuliana Prodan <iuliana.prodan@nxp.com>
>>
>> There are cases when we want to test a simple "hello world"
>> application on the DSP and we don't have IPC between the cores.
>> Therefore, do not wait for a confirmation from the remote processor
>> at start.
>>
>> Added "ignore_dsp_ready" flag while inserting the module to ignore
>> remote processor reply after start.
>> By default, this is off - do not ignore reply from rproc.
>>
>> Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
>> Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
> This patch is on my review list, as indicated in February 8th's patchset review
> order email.  That said, I haven't seen Daniel's RB on the mailing list.

It was given on v4 - please, see here : 
https://patchwork.kernel.org/project/linux-remoteproc/patch/20230119173940.21143-1-iuliana.prodan@oss.nxp.com/#25172596

