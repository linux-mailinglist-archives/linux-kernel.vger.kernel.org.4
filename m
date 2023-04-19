Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D28D6E74E9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 10:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjDSIWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 04:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbjDSIV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:21:58 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2078.outbound.protection.outlook.com [40.107.104.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498FDC66A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:21:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCTtJxcthvxwoUcdsIYc1UxM7/R8ECtdaiCy/WXr1W/bIocmu472XYdj1Bvke5ng1nX5hBEMHBRaeuRXz0faPiiVqVKBfy+9H/kjMW27xSaTHmHQLHifrvNpyDM/9IDLXXW+raV3Ur4exRBdLRM0iN+GQWg8XiinjO4tunL93Cu+Aty/fWuOIRxL9rGZKk3RjvbGYrm6dqVhUEg9dv86wp3Oalmsx0n+Pso4I7FnjOf8YTFG4CXZLX8PxEFeGVfuni2QXhXFnC8kgXtPvL35F3xyfSrhWDl+T8AUZU7so4dqnVc/UZDxaFjvd8TO21Jpcnelx8xPttYrjuENevfuNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfmLBMUXbtZubXb305pb389gS3q7FcVhk5nxqkVXu0Q=;
 b=D0H5E9+arZ/naZJ+y0kydke8JkaTK5HF3XMTTXKI99ibPwvoCbW5YbS9qMHrXK1Yy2ZnpLDiBau+WFNdapjSOg/+dwVbzkzfWzOf1mbqfoYx1RvLgNcAK873XfPQ4FDJmZXsm2tFGPSnJtYTGS8xW216TQ8CXgqDR0dabLGrn0cg+LPLw59fur/+F1hppbC5qC/5o1SRzEya59rQHV84CfhrTaIya1n6qtNKOLLBipYAo6Lm3ffQ2JKUDjQTYX5jLntOvKEGGb+n5QLip0Mnpelb3Vaxnv3G6lzfTOQcT7ql6pH294Ifn4qi5k2Qq8BtUo9NTrbmHasBKHgr+kR1iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfmLBMUXbtZubXb305pb389gS3q7FcVhk5nxqkVXu0Q=;
 b=YzsRkWM+8pvHqS7+O8jyrDUeMG2PzTOosndmBRp1tFVn+/fR5KpuwitRdp6+CeOQultLeZJvI4kAtdhuNQFDTPM87RANrQLHpFQ4HIM+MBjdV2v+sn/QJCDl+3XAp++80cbmmNy7vwuoUaJAvbNQg/u2M7iHbMChGCCUEV5gAEs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by AS8PR04MB8820.eurprd04.prod.outlook.com (2603:10a6:20b:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.21; Wed, 19 Apr
 2023 08:21:47 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::b6a5:b35f:94f8:ff53]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::b6a5:b35f:94f8:ff53%8]) with mapi id 15.20.6319.022; Wed, 19 Apr 2023
 08:21:47 +0000
Message-ID: <b98ca138-c020-cfd0-510d-30916120734d@nxp.com>
Date:   Wed, 19 Apr 2023 11:21:44 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] ASoC: fsl_sai: Fix pins setting for i.MX8QM platform
To:     Chancel Liu <chancel.liu@nxp.com>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, shengjiu.wang@gmail.com,
        Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com
References: <20230418094259.4150771-1-chancel.liu@nxp.com>
Content-Language: en-US
From:   Iuliana Prodan <iuliana.prodan@nxp.com>
In-Reply-To: <20230418094259.4150771-1-chancel.liu@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR07CA0033.eurprd07.prod.outlook.com
 (2603:10a6:20b:46b::19) To DU2PR04MB8774.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8774:EE_|AS8PR04MB8820:EE_
X-MS-Office365-Filtering-Correlation-Id: 3134499d-58e0-4d92-7f60-08db40af1e53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xrAxSNLgzPGB9WBS/AkFR9S+FYqg6kQKSVJ7K3eH1vzq6ZKwdTPZBwWlYzhTs61L804EVVV2dORa6wJyxuWxh+Ef1kWV7ttTIGDFhALJjdSKmZYWOZkiay4wiHRCDXlfJpFEi3PuruonB/GrRr8kucU7Az3JxpO3sPURCgotk/n46x8HnrEYWMFTSt+Dt/5/S6bYg8RXCgyw41JnWXFIrr7nFm/kmvw5wp/HhCub5Gl4G6HCwg1aLL0PE6rIBsfrT8evJupGkFbUlFkvhGwtFO4+TdZJzpWCWLSGRjCMCQHUwl0mGLZLxAAIfaFRxAhjbPcAN2e58MKQaWCUpL11MGe3WxwYFVwWLkbqfYm6QYfxO80YR1ptCwxUZbrvMwoc3xDm1HBrn1VM0OJxQvmaS86sRpojDG8Arzu11Cfc5MPRShBovKY1FXRRjH2B7eqi7QAxVM2oIHBHWbUiowyzx6ASD6WQbyFfWkQkKVIpt/YKfIFfIhCRDPRzwXi/qdVnGvjTaHNoHI+qTZbMJsAoGJXSjPpGzieOmNJhOrALmJCb9I/luytY47NxhyCXw1cVGP2FI62nGdpBcfdudUfgIbyibwXnyxyswJIxYo0pPjpGFZbz4r7ofWwdICoOjijfg2YLWt6yHUQ8BSnIZc7QplV11LFsJwaISOHQBUiyc8s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(451199021)(316002)(26005)(186003)(41300700001)(31696002)(6506007)(6512007)(53546011)(6666004)(478600001)(66476007)(66556008)(66946007)(6486002)(2906002)(4744005)(38100700002)(36756003)(921005)(31686004)(2616005)(44832011)(7416002)(8676002)(5660300002)(86362001)(8936002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGFseG5ubmd6S0lmeXZ3anF1UUZQQmNta29UV0doZTBxazNoMy9ieXhxOUM5?=
 =?utf-8?B?YVpNK3ExT0l2VkRWYkVEdDdQRTlWdDFYdDBRdzJqa2crZ1BIWUpCZUJkdWFI?=
 =?utf-8?B?c2llemtxOTRaaEMwRytMQlVwRFJDcUpkQWpvZElxYURmQjhCNnVKWW9SUlZ5?=
 =?utf-8?B?bTR3ZkhYQWY3YisxMFZXd3hCWnFXY3lOT1gwMC9GbFpqelo0RXE3UzFGekxj?=
 =?utf-8?B?U0JYVXZDUjJUakVlZWJvNG9DTkVSbkJmTnQxakFXSTIyaitZS1F6cTJnYmNH?=
 =?utf-8?B?Rm11bmtkRERmb2JkY2xaRlRvRE4reFk1TmlTUjRqb0dJTWVHSnFZVGg0WHJR?=
 =?utf-8?B?SWdrQjNVZno2d1A1UVlCMzVoeG85MlFOTysxUnVWd3BRZjZ5Mlp1K2d5S2tj?=
 =?utf-8?B?MWVLaCt1cWcvYzBmYmNsNkZ3L2l4Ui9xazBxREJnSUR0dFBaenZ4eTlDUncx?=
 =?utf-8?B?dXJCdmFQTjRUVlRsem9JdDNRdzlYcmhod2VPMnpCcEZxdFRhRGpuQ281ZUN0?=
 =?utf-8?B?N1U2VVBpUCswNml3QW9KVTVBdERJNExNckM4Nk05Nkp6WithRGlGQ3JONE5R?=
 =?utf-8?B?MHdVQXVkeDVmcHZwNC9jNjBkbnBBZVdZVkI5bUowdFFaR2oyYlNXSUFHdmFS?=
 =?utf-8?B?R2dtVk81SmV1ZEd1bEdXaWVMTFhmeklSMnBBTjNOM2sxT2FRMWJWdFY3a2F5?=
 =?utf-8?B?eHNlVXlZck1pT3BsNEhBVFFaWHZJblNFSGhYWVZ3cGFhNS9uVzlORUpjL2li?=
 =?utf-8?B?QnhhZUp5RUF2Sk9oMldvczJkUG1WOWprTitxdDZGMzFsbzMzOUJ6cnpXbTcv?=
 =?utf-8?B?NzZTblVrK0FTa2ZoTnYvSFBEZzloNFZjSU1hN3F6YXRRcnRHYjJsSkxpRTJq?=
 =?utf-8?B?S041SVFMZTJuQWY3b1B1ZlZHcW8zbGV4NWNUbnQ4VG5ML2VkVkhxdXROaGJK?=
 =?utf-8?B?OWF0MFdVaEFmc3lVd0YxdDRxd0NPcEFqRnhxZllvM0QrSlgzclEzYXlMOFg0?=
 =?utf-8?B?aGVrbTNYM1dwbU9qaGdBQ1kzVnk5ZnV6Q1lNc3NHRjlyS0hKNlc1S1NGS0pK?=
 =?utf-8?B?UkxMd2owQzZxTkZxWkc2R2dtZytNcFlXbFdGVS9NaXdqZjFTcVNZQXJ3RWkv?=
 =?utf-8?B?RjZwZ2ZWWFVCWDZScTdzQ1Z3SlpWZk1BMmQzSzdQMzdvTXRDenZjQ0VGclBV?=
 =?utf-8?B?NGV0WUJYSmdqcE5jd0lBWkR1RGdJRGVDTkZUSWlXRkZRZWxiZW8xYnJZaWIv?=
 =?utf-8?B?OWorTlBjblFxY3AybjR6Y2FObzRnUnFXL3g2NmxweVRKZjBCUHB4WWZtdkRW?=
 =?utf-8?B?clpzQnNKZk1IcUQ3ZFdCOU9rMEY3WnRjWTNoVzN2a1N4RTNZa2o0UzdGampz?=
 =?utf-8?B?bExWaHFMejQ5ajdocTRVdmdPZEhUSis5WWl5cnYwSFR3Ym8rY1o2bUtiQU9N?=
 =?utf-8?B?eGhyanlDNlBuT3NNcmszWUVLMVhWSUFobVlmYkRaaUU3WFNTWFYvZmxIOTB2?=
 =?utf-8?B?NkZVMW96c0Q0RkY3elllczREcTJkak9KbWRYNXZRYi90ZUJNa1d3WmtrelFC?=
 =?utf-8?B?dS9VYUt1U3lscTE1a21IZ1YwVDlMdDBtKzFqMnd6N2VMTWhiUVB6S2d1MVBN?=
 =?utf-8?B?VGlIdVE4MDJEVzl3M25zU2pYbi9HSUlRWlc4OGZJZGhzNWlwcWZ4QmZBMGc4?=
 =?utf-8?B?eXYrUmpSeDlwMHpIWGQ3L1B0dy9UeHdJbDhuQzFIUXQrK2kzZklrdHgxaTB6?=
 =?utf-8?B?dHl5VmxmVGw0UTJZVDNRbW4xTXRLTE1pVk9DVk5KTVUxL25pQkZTMU1JM0VM?=
 =?utf-8?B?TFhxL3FrWjFoWjViV1AzZy8wQUFSZFpKSjZwTm9TZllRb2JyZkhubW92cGhT?=
 =?utf-8?B?WFhsbUpCZ3dvQ0Vzc0ZUVjEvc0dEOWRPRW5hMmxaUTd0NnlQZ2x6elVWdDFq?=
 =?utf-8?B?Qmk3bmZlR2oyWU5xNUlvaXJRS20vSE4yYTk4czZUbmFqaW5SQW83bEtRcVo5?=
 =?utf-8?B?NTMxZ1JkWVJWQVFyaDJYSUJ6QUFtK0FtNllWOVMxNGx5a05RUFY3R3F3aVlI?=
 =?utf-8?B?MjhUa0t0US9WV3U0Q3ZaeFNXV0F0K21xazhPUEx2cHY0QStUUEZGTnVlUzR3?=
 =?utf-8?B?L01wcE9jOGtzV0htWUd6OTFRTGRRanVaRGo1QWFESStpeHE4NkZJeUFuZFdW?=
 =?utf-8?B?bHc9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3134499d-58e0-4d92-7f60-08db40af1e53
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 08:21:47.6673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wzgx3Q1j2+SM5GPX4ErImQQZ8ngZKn24HgSfl0+TlC0/9ecRBVh2bIGNBwrRyogihL/zaxzRQuTYrtfTpThOog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8820
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/2023 12:42 PM, Chancel Liu wrote:
> SAI on i.MX8QM platform supports the data lines up to 4. So the pins
> setting should be corrected to 4.
>
> Fixes: eba0f0077519 ("ASoC: fsl_sai: Enable combine mode soft")
> Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
> ---

Reviewed-by: Iuliana Prodan <iuliana.prodan@nxp.com>

Thanks,
Iulia

>   sound/soc/fsl/fsl_sai.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 07d13dca852e..abdaffb00fbd 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -1544,7 +1544,7 @@ static const struct fsl_sai_soc_data fsl_sai_imx8qm_data = {
>   	.use_imx_pcm = true,
>   	.use_edma = true,
>   	.fifo_depth = 64,
> -	.pins = 1,
> +	.pins = 4,
>   	.reg_offset = 0,
>   	.mclk0_is_mclk1 = false,
>   	.flags = 0,
