Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BDD648CA3
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Dec 2022 04:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiLJDGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 22:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLJDGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 22:06:34 -0500
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2070.outbound.protection.outlook.com [40.107.14.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B563720C;
        Fri,  9 Dec 2022 19:06:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZXwMV1ZH4LdQUp4vnjoEvUzmJtVE0JRlWkrZtCWyp3hgVueXDMPaWUE1df2JRpVIjLn9NXD4Xe8+QAPFadIdKzCD/BMJ4JEFQYhT6/jHRWKL0Shpnko+wbvZ/wh8Id40NDAjULUClXONaEntUgMARp+plBWTrtIiV0ym4J3IbD38RO+ewPZuDkWabIDFLbwivIL7BopGn8yeKai8kglDgBHD3pWiMaQWrOK03aEpLjCYUG0smK3UFsHrYLKGbzAjhrXHMukQVfRYGWfbZcUSsdkLBnEpyQiClrGoGZk6lGQTEiICE0ulgBfepn5Ab5uYM+NcRX7hOQeQvdz8tVsjEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PDvO5eg/qRBT7mGQAnUmsqeyz6zm9NcfeVHWZTXOGjg=;
 b=dJzHRJBBYXx+C5yKzhncfLypi5c95dKp5nGw3a+hw5M6M3NGHqhAL7gjSFc7vCJ6bkN4PV+JlH+++W/MV4QXAu5jvDGlY3kRV3vUZ8PZTHxVDPnMIZGdTqvfnjF06hVYHkYvccN8wzwFT/VwpxaDaDmQHhezlTmHBbqIi48WRcTLjWAhldN4mrUvkoxOrmyXq3nb6UwdySPO5k6KUMV3PL6PViJ/tQG9xZ1wOzQPO7r58/FbJI2m/6P0rxW6/8Rl5xiKMN5gBLgCGwQGfpdv04BgkhbXwvXygSmgSoj2kIUJhB+QQLpvn9hKhbC+y81x+MOCKUUosOU3z5EhuuO0mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDvO5eg/qRBT7mGQAnUmsqeyz6zm9NcfeVHWZTXOGjg=;
 b=ja0m18498MMLQjX8rdHe9qH+BufvjTV1tjTl3VCYk4cMTcBXYmuH+BSqQC7d1LT/DD1mekz18oL4HwY1rImSw8rwkY3viIimo+/lhwLh4RzsypMfWeb+iLmaqjGcdC+rE0Zm7kdg+1EkmjbefG4/G71nqidmUDD2cSg9RfMBU9k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS1PR04MB9581.eurprd04.prod.outlook.com (2603:10a6:20b:470::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.8; Sat, 10 Dec
 2022 03:06:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e33c:46f9:ef88:8973]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::e33c:46f9:ef88:8973%4]) with mapi id 15.20.5880.019; Sat, 10 Dec 2022
 03:06:29 +0000
Message-ID: <24361a63-ee96-4291-175e-f25c1380cd49@oss.nxp.com>
Date:   Sat, 10 Dec 2022 11:06:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0
Subject: Re: [PATCH] remoteproc: elf_loader: Update resource table name check
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-remoteproc@vger.kernel.org, agross@kernel.org,
        andersson@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, quic_plai@quicinc.com, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        quic_rohkumar@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski@linaro.org, mathieu.poirier@linaro.org
References: <1669897248-23052-1-git-send-email-quic_srivasam@quicinc.com>
Content-Language: en-US
From:   Peng Fan <peng.fan@oss.nxp.com>
In-Reply-To: <1669897248-23052-1-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0134.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS1PR04MB9581:EE_
X-MS-Office365-Filtering-Correlation-Id: 46d18b3c-f9dc-414e-efbf-08dada5b878f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e9X3PAU/uXR3P6zvZSX376cEQu5K6/lKhRUdv8f8r4STU/7eBLoumuRda2u0n1FLXaA5NpAIgXzLJU7V/5t+q12n8eWnuvPo+IGp3bd3XzaKXSr5HLsfwgos6/5YCWLATWqYi3iiP7iDmUNmE5UXQloYTQH6CXcYl2w3qKkNZYFOd1c8QfMapZmwsC4txZyQQeH6kDrgUiJX3AmoHBAHubhK2DO0YXhcWTAhpB/xd1WvaouDUe0z2A7tb/BZ/14ismuRDe4IMJ52buNdUvfS7MxP6uDHEBHWdBNehOymkauVGlWni/NC+8xMiE5dJKJHni33G9PT+5fRY898iG9E533vQ3pTBJZ2q2LWEFQVX2oatRP2wbs8UjhG2Yug2AQYRzbYFeAYpRqk18HWsdO6gzi5JhliP9Y4lM0cBZB8h3PoFdGkLZPP8ih2/Na1i2QC5Y5JrXObd8AebvDrI/JhusEJC62esCFOtpe6sL+sOhBLDpECRcqOPy0OHKimeckLtU47B/9h4PLohrlDDNa3skiq9APqlodpjCzSz8fCMbG8S3V1fzOBY5DqrhUq5q2yGkv5E2y/pa13CXwGUOH17zPCWS4PZak0SCFazXBSLF/0UGTSVHXacUTmi2BV2HzC+UZPz/OqsmydH1Jky1xg/3kUVuSmjkE28z54wk2ktxUvpDARujXJ6jqBvMmDDOw3JqHgVPtZCqfIDOOEcR92ntz/Kc5xZ1bJVrvwREMN0nOhNSrpVOFdxaRVo+I98LmtXy/VsS5x+hQxWXNUaBy5BQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(39860400002)(376002)(346002)(366004)(451199015)(86362001)(15650500001)(31696002)(2906002)(44832011)(2616005)(186003)(83380400001)(26005)(478600001)(6486002)(6666004)(6512007)(52116002)(53546011)(6506007)(41300700001)(38350700002)(38100700002)(7416002)(5660300002)(8936002)(921005)(66476007)(66556008)(66946007)(316002)(8676002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1dXVlZTTG1OdXZUZGFTUnk0Q21RemFqOHVuekNOMnpGa3QwK3VqZmhrdUdW?=
 =?utf-8?B?M1ZjNXlsNXBvamRLRUptWkRpYUZ2K1V0NEdXN3RXaGVVeG0wOG1jMThGMXB1?=
 =?utf-8?B?T01IanM3OXo0RkVqajRRQVVsWUluWjhvak9jUU1lU0Z3RWRtbWtjNVpra2wx?=
 =?utf-8?B?ektFQXhRcCttekJpNkJiVk9kTVhwSXBWQVIzRUVQMEc5Y3B0dUVDamhVUmVr?=
 =?utf-8?B?NDI4My92bTJkNnI2SXYwN0lxUW1QWkhaL2lhbGRId2RSVmNBUk1XOVBNdGVv?=
 =?utf-8?B?M2F0TXFpbVBkTk96Q3FRalRrejlQSXk3ekRyZDRIVXBUWERIbSsrRVlBRWtK?=
 =?utf-8?B?aWRNanRHNWdKYXVqWVZBbDRoKzZDQVEwRmF3Q3JxeWdJREh0dlA3dllxbU5j?=
 =?utf-8?B?dTF4ZTNoUWI1bnZZR2MyZW9lS2o4NU50QWx6SWlYdHBraVFFSWlBOVFDbUNl?=
 =?utf-8?B?ZHM4TXM0QStWNlROa1BGd0FxM0NYSllKaS95b3cyd1VxSWhMZXM5enZKN3dD?=
 =?utf-8?B?aEg4VWhhaCtWYWMvbE5mMWh1R3BOM21yVlgwaEJ1RUUzbFpYajgrUWkvaGkr?=
 =?utf-8?B?TGU0akFZUnp4azRKK1YwcFJaVFQxV1hESG1XRmJ3L1FmbzkzblQzelg0czl3?=
 =?utf-8?B?RVMxVzgyWjNXRkhROCtuK0lzbGJ4OFJucUR4K1JRMVczMGJGZWEwNVFHVFpm?=
 =?utf-8?B?SjRkL1ZxNTBGb3pETjJXMnFzR0lzV0x2c1lMcU5DOXlyTUFSQXV2U0Z0dXRo?=
 =?utf-8?B?VHhaVlNxcE9KTzBsNzBzUldDYzJMUWMwTDJkczZnamxDMjdqNUFlZVlpZzhk?=
 =?utf-8?B?d3BTckQxNVhDdDhkUUdQUXZ5emxMMW1hM0NORy9wd2cxT3RxZWdQYlFDTkJl?=
 =?utf-8?B?SkhuTjEzaXZaaERuS3ZhWDR1RFk0amdORmpTQ0o2T1NoVmt6YjFMK2xaeG1H?=
 =?utf-8?B?ZEp4R1dSbmUwYVhzMitCd3pDc0tsNno2WVdnR0p0RjRUUkJlZjVHTGJvL2Ey?=
 =?utf-8?B?SktIUmFNSGtIVVIwVFZ0aGNBblpkdDlMbnhHVmxnYjg3VFZ1SW45bXBxUTll?=
 =?utf-8?B?NGU2cjhzYWNYeEQySWdON2pyQVYyek1SeFNWejJuRUxvSWZhdS9pWEhTWXNG?=
 =?utf-8?B?NXdvcFR6SlRRNHhqUXNMUEk4UkYvTURPZ2M4UjVQc2ExNzdKT2FoS1ZCUkcz?=
 =?utf-8?B?RFkvYjR5Z2J0Z2xrVWlvdEYwc1MzSUYvOS8rY015aVBuL3Q2cXBLYk5zS3RW?=
 =?utf-8?B?Nzl2bXN5ZWFGUkl0bjdKZU80V1ZYbzJPQVJCUkNKL3hMSExOTE1NeVpGQ3Jv?=
 =?utf-8?B?c2Y4QXhtN2pnTDk3cWlieU8zdTZrbC8yZi9QRlhuN0ZCaWVaWkp0L3AzaW5D?=
 =?utf-8?B?NUxRbi93eCtjNjNIZ05tRFpobVBvaU9YdmtISHVvSTdvTUh6aG5VYjI1L1Nz?=
 =?utf-8?B?M3g4d3VBTGo3b1ZPbzl6YnVRUWFueUllcVk2VUI0VVh6U0F2Q2gyT2xQM3FR?=
 =?utf-8?B?RTlFVUJ5R1BpRGJSRmZzbFo2empBNzVQaEw2bFFDSkQwL3BIVHM5ZFhzTGhX?=
 =?utf-8?B?bkUwQmVvMmwwRUh1SDF5ZXp1MlpidW5qMVF2V3FDVWhnN09hd2htMGRYU05W?=
 =?utf-8?B?YnN1UzdJN0xnT28wYnkrZ1ducUNLQ3Rlbk5BZDBra3dUMEdTNmlIUFd1ZzFo?=
 =?utf-8?B?c1lsTjVlalYxRnFBZHpVbHBadU1NUFFXd3g0N0lhcGdUWDd2NDhWZmpCS2RC?=
 =?utf-8?B?ekZCUXltT1BSaFpiSC9sQmwxL2Mrckw1SHorRUlYVzB6YVREVFhZNFd0TGJj?=
 =?utf-8?B?LzBVM0g1RkhkMU1CQ1psUWhlWXNUT2NzRGJUNkZldlJacnhTRVRPenlmb0N6?=
 =?utf-8?B?Vjk5bWlLT0drRXhJUy90NUtINTBDYkFCTWgrd2drazBTNVBGOVB0YUlmRGpM?=
 =?utf-8?B?ZzJHN2xXQS9FM3FZeE1RWGNleUZ2VExDVGFGckhraG00KzRiWmJ4Vm1GNUlZ?=
 =?utf-8?B?Z3hRYTAvRzE1bDBod0plZWlQaG9EZnBFVXFKMzQ5b1ZFWmZ0b0FyWTBwbDQz?=
 =?utf-8?B?TDRWRDh2VnJsMnFleWN0Q3hpSE9KOXdCT3JzV2lyMk4zRnhuakhqK2JtVWJs?=
 =?utf-8?Q?bPZmfxB/P918qekTaQ0jK3guA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d18b3c-f9dc-414e-efbf-08dada5b878f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2022 03:06:29.4322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P3nqRpTm+VH5dIa91y45q5EvnB/Khce6zg574KgNgpEH5qvKwk5r4YWCMZ8NuqNt5XijfX6yUijNxJCl392Mzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9581
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/1/2022 8:20 PM, Srinivasa Rao Mandadapu wrote:
> Update resource table name check with sub string search instead of
> complete string search.
> In general Qualcomm binary contains, section header name
> (e.g. .resource_table), amended with extra string to differentiate
> with other sections.
> So far Android adsp binaries are being authenticated using TZ,
> hence this mismatch hasn't created any problem.
> In recent developments, ADSP binary is being used in Chrome based
> platforms, which doesn't have TZ path, hence resource table is
> required for memory sandboxing.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> ---
>   drivers/remoteproc/remoteproc_elf_loader.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_elf_loader.c b/drivers/remoteproc/remoteproc_elf_loader.c
> index 5a412d7..0feb120 100644
> --- a/drivers/remoteproc/remoteproc_elf_loader.c
> +++ b/drivers/remoteproc/remoteproc_elf_loader.c
> @@ -272,7 +272,7 @@ find_table(struct device *dev, const struct firmware *fw)
>   		u64 offset = elf_shdr_get_sh_offset(class, shdr);
>   		u32 name = elf_shdr_get_sh_name(class, shdr);
>   
> -		if (strcmp(name_table + name, ".resource_table"))
> +		if (!strstr(name_table + name, ".resource_table"))
>   			continue;

How about ?
	if (strcmp(name_table + name, ".resource_table")) {
		if (strstr(name_table + name, ".resource_table"))
   			break;
		continue;
	}

Regards,
Peng.
>   
>   		table = (struct resource_table *)(elf_data + offset);
