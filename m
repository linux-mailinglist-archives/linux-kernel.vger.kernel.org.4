Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEF1A66B9ED
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjAPJLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbjAPJLD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:11:03 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2041.outbound.protection.outlook.com [40.107.22.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116B986B5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 01:10:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzyR7wWpxw55J1ro3Ge6xw+isVGwV/OhXJyhwbSLBltwF7wMFgp+jki1eDYoFuWbaFz562w1uq8JLjXcWtG2f+li2iv0WUOe9PjnZ9jLvrR8D2Z4Ad/iZYA6iYDhoEbS35YcCLh927YubBGmJ1KXutImVtp57jT+GxOqc9f2FzgINZFb1f8FGPetgWbyHfYOFg+Q0ULcPYELB2kia3BW1WBSHa6tvVYuUMqV+X8IGobrkVhK5abDYslpip3MIlDlFfFUvSLaPFLgU6q11j7T0mJPvB4kePoKSlr33YxgGHORPXUHYWkJBMBOMSMOA6t4BXpXeI070kdYrgfx91xpfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxUT/0RYYPC3a4dBEvINWfyYWpnozSftqohcbPpG7yE=;
 b=fqhWKNJlg9ptq0cEjf7kjiXrw+VDezXj4NiLGkm2dn9uygNaQ9+bXEyNkesnL7Xjj7T0kNAdmQ9hEAm5J/5lKcUdDWYhIgf3m4ab3f34D9yMjXZWxupuuwgFDvIP+zm0E2k8BP+X6xM3eqjZ2gwcpoXBt6h8sI1QIk3l43PK9AHwQGhpMUT6EYH3y1sZ7RnXhyPu0g6NG1Vi3yBW3XXA5vzCrNKMIFO4kS5DYNiSKKRY6r7u02DmLYoqk0sZJcSb2FfsBAloVDzpmrK9hEtQgxWh82yELjQjVNm9h1vH1KcAD4NWj7d3v5vfIOz0Ot2EzLpjdfZBGz932yyWCHNuxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxUT/0RYYPC3a4dBEvINWfyYWpnozSftqohcbPpG7yE=;
 b=WIXpaWB1e7/hknzbsuAozfbQodl9JPSe+HM4e+QwFcnUvlubKEYLAnq5K4+SlF6AxukwJr/K8rEEOfmFRLlsQeOgKZpS5wASF7I8a/tFLZRMnkuysxrftiNxNtHim8qxLZCtwJ+4tZGUYxIuwoskcUkVTXdOZsygJOcaZ8NupO4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com (2603:10a6:10:30b::14)
 by DU2PR04MB8613.eurprd04.prod.outlook.com (2603:10a6:10:2d8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Mon, 16 Jan
 2023 09:10:24 +0000
Received: from DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886]) by DB9PR04MB9628.eurprd04.prod.outlook.com
 ([fe80::aec2:20b6:cf99:2886%4]) with mapi id 15.20.5986.019; Mon, 16 Jan 2023
 09:10:24 +0000
Message-ID: <7837afc3-e5f0-646b-ccae-b196d4e0b522@nxp.com>
Date:   Mon, 16 Jan 2023 11:10:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] ASoC: fsl_sai: initialize is_dsp_mode flag
To:     Shengjiu Wang <shengjiu.wang@nxp.com>, nicoleotsuka@gmail.com,
        Xiubo.Lee@gmail.com, festevam@gmail.com, shengjiu.wang@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <1673852874-32200-1-git-send-email-shengjiu.wang@nxp.com>
Content-Language: en-US
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
In-Reply-To: <1673852874-32200-1-git-send-email-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0169.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::38) To DB9PR04MB9628.eurprd04.prod.outlook.com
 (2603:10a6:10:30b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9628:EE_|DU2PR04MB8613:EE_
X-MS-Office365-Filtering-Correlation-Id: 328e8c4a-c00b-4336-7610-08daf7a18037
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lty/bDQG9AwHEfODeAu7/fLNUF28pgcCy3GV5BwvHeW76GXiMEGqSRHdX9o6BtfloF0lmJC8VKCE5+gjRTrcmI0gjBOHY0B0+eailzVOO7kakKnFapCnwVDcjbmWfZcBAPKwwjRe+dnvfoPiP3wZvmGZIre0ZJ2Z0SatYFzd+gJ9S3lW+VS/7n8m6eBuj1HyAH4h7iEQ1yR/XzUJFZai9KppIQ+tvUp4FEDO1FfKZ9XljvXvO1BbPaCsys7ZsFnUshRz9aZXWZVp6/V2rSM/1tSqxfLQQw2u0kkU4RhA5qwkHI5bs3dklqA0OAA2BGE9y+7PNQY0WlHQXFD68VZ8SzT8qBn8MKviPOdtf2XX5mwnW3koKUomBrWU8fbzFIXAl3AXVMUZa0Y3mLRZt8tJNRv5w1El+hP2gpsh1fWHk/EWHSDn0EgKD6DalnLH3jmmDC7qR8HygEH0PN3Dh1Q4bm2HiIC8SWNQWCu9nrwhk/z58HzgBNB3squVG9L9HOvzHHTCjDCiqeyDrEhZNeK3Tc9ihplXzTEw1t4mJWyijeSFiIdTCVuFrvIPomIViCA9O8P3HJAp+IstTMARnODgKvEoUWp45MHJtfNohe0tDQBRgqD4dTAD96is3Kb6UuTpLvCmhgi4pe8QLSZeQTAHEO7cbtjascBAO38UHQnrQIlxloHFq3Io/0zjzmpFMY9F1k7Htto7wqkDwOzPY9I2BA8aQmkYibeF1jx4jIPgCARUlFU6ktp0LNXJzOWivZz8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9628.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(136003)(376002)(346002)(396003)(451199015)(31696002)(86362001)(38100700002)(921005)(2906002)(7416002)(41300700001)(44832011)(5660300002)(8936002)(66556008)(8676002)(6486002)(478600001)(6506007)(186003)(6666004)(26005)(6512007)(66946007)(66476007)(53546011)(316002)(4326008)(2616005)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UCtMNlM2cnZhTkNhc3VTWlZwOVZoZzVkVXJ3UDFnM2NaQkNjV1ZSOU1mRXdx?=
 =?utf-8?B?eDM0QnhsbEFsVWlaRXN3cWhheDA4Qm40NzVIaU5KZUFwTGVWZHVKNTBGMjRv?=
 =?utf-8?B?WTdXN0RnWC9aSGtlZDVGWWxMUjFuRXZmMlRId014Z0M3cGwzVkhTS1B2UXBj?=
 =?utf-8?B?Um9EdWZSVlhGVnhPYkpLWnIyNWdwSG1oUStNbHpQdlJHY0VHSWN2UzhRNHla?=
 =?utf-8?B?M3k3c3p5MU1TYnFSOEdvd1lqdVpyZzZEam82T2toenVWT05xY1FHU0pGTXNp?=
 =?utf-8?B?Q1BsWkh5NTc1S0ZpTUxvMk02ZUV5eFNtdUlic0RhQjhDQUg0Z3czR25XUlBL?=
 =?utf-8?B?QXZPQS92aVJrSGo4OHhWMEh1ZXlDdUEvN0dxUUIwRkd3QmJ2VFU4c3h4cGpx?=
 =?utf-8?B?SnJLcTdHTnlqZVNlVXVlNnlpRUptZGFKNjdvVzEwMkdlbXpsRHdLcnBQdDJX?=
 =?utf-8?B?SlNEWjgyNUFBNWdQYUFkREhvZ1NsR0sxMDlnN28yOUlRTjRvUVNDWStza3lu?=
 =?utf-8?B?SGZyWTNPMGlRVUtyQ2RVRU5sVU9NSkdtWnRPZTg0TndzYmd4OXp5YjRxM2l0?=
 =?utf-8?B?aGsrKzlERzFUTGRUODNRam9tbzdQMWpEaWlEQnNFSFhpM29PRlNSZmJRTEJr?=
 =?utf-8?B?K29PMTB1VFFmeUZDN1lTNm00QUd1N3RZOUpKQm9aRGdQUDdjNHczNVluMjRl?=
 =?utf-8?B?WEtSbUMrSGNCb1d0eU4veXh0bDlnWkNKelgzNS9mNDhHUTFPWkVxR3FjTUlQ?=
 =?utf-8?B?Y2pycHY2U3R3UlBvOUlndTllbkxCWGt5M3N2dWt6cEVCalEzZnNSQW1WRDY2?=
 =?utf-8?B?b1J6RXN5UmJUeC9OaVlOWVVYQmx0bFgyVkpWR3hubW5RbnVoSkJFOW9zTFo1?=
 =?utf-8?B?bU11Ym1COHhaTmxDOHBMVlpEOGZwaVllbHcya0tNSDhLN0lCb0NjUFJra09m?=
 =?utf-8?B?WlFCTXJhQ3U2T21ZV2IvaFUxcWNTbzd3Nk80VkNIQ2FrOFJiSlNvWFR3Undz?=
 =?utf-8?B?bzFlZmRUQ3JoNENsRlFnb1JGQ3VyN2ZjSko5Wi9XS09NSTdNa2o0c2owREN6?=
 =?utf-8?B?SktkQXVjVm42bnVYeXFDL0Vna3dmQnIxVUNSL1I1ejJ3WXFPWkEycEtiZ3k2?=
 =?utf-8?B?MDNaQW1hZFhscis5QVlvUUF3NERsMGttVFoxZFdXVlpjSFRieG43ODUxQ1Rl?=
 =?utf-8?B?cDBGSEZaNjVUVllab2dBSDJlVDN0Y0tnQ1ZKYzJoL2NLYnZDRkp2a3RDRmxx?=
 =?utf-8?B?czBHMktPU2xmdzVYazBCdjN1ZENVWDd2bUFkMTRybVNpN3F5VFlBS1J0WG8v?=
 =?utf-8?B?TVpuL2F5TW13NzQ3MjFObWZFVWhxWmJKZUZmZ2hzNzBoUm5SaGp5RHRNZnUr?=
 =?utf-8?B?ckhyRzIrZG9DN0tXcThVbGlOa0QwdHpTbEdQWms1c0ZFdlNOMGgwbzBCSGs1?=
 =?utf-8?B?Q1J1SXdkdmlkZnZXdmZlRkZJeGx5d2xHQVRMTkdTRlZwd0ZQUk9Va1lKYzln?=
 =?utf-8?B?ZjdVTUsyK29tTXh1NWh1Z3pLNHc2RVJycWdYSjU4OHl4SjA2czM2c1dHbnBV?=
 =?utf-8?B?SzhEcjBncngyKzNUYmpLSjB0REJnNW9LYzR2VzYrZ0xpSFAraXpRcFVMUk5h?=
 =?utf-8?B?aEpSNnRGVXZjRTRxL0xhQW03Sm1oRTh0UmhJa2FBYkZ3Uyt6V3RmNW1hNkd1?=
 =?utf-8?B?SEV0UVhOcldoeVV2dnRtS3pHR3dtVHFmR1d3WWVUQWJnMUx6dE9NKzR1U1BO?=
 =?utf-8?B?c3R5SHRGaW1wLzBlSGJzdVBpcHFHQUVGK1c3ME1BY2crYkREZnNBNEZlaFhQ?=
 =?utf-8?B?MGlxbTNXQ1FOaE1Hcko3aHQ1Nm9MUnJrYVFhVFY3Uk9HeVkwLy9xcDcxWWJu?=
 =?utf-8?B?bEdDMzBjem9xTHpLZkdXMHoxSGMwUm1qOUt1WkdvUzl1dmFrK0VUcitaYmZQ?=
 =?utf-8?B?TjVocFJBNXhKclBJY0pwSVVhOVhyYXNZMlk4K2RHVmc4d29yYzB6V3Y3TlJN?=
 =?utf-8?B?N1VQMjVGalV4V1d3dHl2Y0ZtcDdDYVN3ZGpsa2JKa0EvdzRLcFV4VXFVSzEz?=
 =?utf-8?B?cjZHQWN5NEUyV012WGx4UFZjQTNSM3p3TWZIS0lSZFZkU2xNeUNPMWMyS0hG?=
 =?utf-8?B?YVB1MFV5VFNLU2dDOVZOZ0dYWmNucTB2TytSUEZSVG5UdnJmVVVQUTNlb3dH?=
 =?utf-8?B?T2c9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 328e8c4a-c00b-4336-7610-08daf7a18037
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9628.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 09:10:24.1851
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gMfGbaT5bawtbkXbzDluUSxcqJzKVguVKZBWzBH74JHaoR1x6gQtQ7dV0ZECQ1DJbhxYRmrrwKjFVGduC9xZ4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8613
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/2023 9:07 AM, Shengjiu Wang wrote:
> Initialize is_dsp_mode flag in the beginning of function
> fsl_sai_set_dai_fmt_tr().
>
> When the DAIFMT is DAIFMT_DSP_B the first time, is_dsp_mode is
> true, then the second time DAIFMT is DAIFMT_I2S, is_dsp_mode
> still true, which is a wrong state. So need to initialize
> is_dsp_mode flag every time.
>
> Fixes: a3f7dcc9cc03 ("ASoC: fsl-sai: Add SND_SOC_DAIFMT_DSP_A/B support.")
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>

Thanks,

Iulia

> ---
>   sound/soc/fsl/fsl_sai.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 1c9be8a5dcb1..355ef29af48c 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -281,6 +281,7 @@ static int fsl_sai_set_dai_fmt_tr(struct snd_soc_dai *cpu_dai,
>   		val_cr4 |= FSL_SAI_CR4_MF;
>   
>   	sai->is_pdm_mode = false;
> +	sai->is_dsp_mode = false;
>   	/* DAI mode */
>   	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
>   	case SND_SOC_DAIFMT_I2S:
