Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6EC9617DB9
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 14:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbiKCNUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 09:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiKCNUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 09:20:48 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80083.outbound.protection.outlook.com [40.107.8.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D896546;
        Thu,  3 Nov 2022 06:20:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bX36UEan3FddEaroEw9pxLQLZPLtgk7X9JjPO0w92837gDKo5NOaJ15fDXIXXxTxbgsa/DYGlnmcQwQSaiSmF8s0U8hnWhYyv4MVylNRgaQGYRAswGCPeemfgBsoQxVimifpYbB1Mbjwchjbo82W3RwEsiNTQzUXNjpGej1gAwh7LFI9wre1lTgCjwPxhoLDZBGQUr3me590jg+2qkFtVfbpYHnDDkkUVe49F6CVRaRQtNf24JvmS3lMmZjtOJOICalAoCAva3YECgOMCYTAvp8E4qDRoW7U0+xojrBbGK0cbrDziPWS7+sR8J7dzzyWwuK6vAxqTK4UdqEzMTMqDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NhORwKUSMm6rm0T/lmL77q3kwYcGB8pDsQM1xwzwcvM=;
 b=EEoi7SbEXnud2UixYsaqkLVaq1a7FN236ocjZtlXJ2Lll5oQ9j/bfzlhCnuoh39xuYuQh3Lu/EgojZSIntapF6mbz52Bvvh6SnEXzzf6rfHYCf9O7Ua4jAz+rjwLeRZfsfe59x0N9xuT13os06P//14Nx0skJQJP9sM7SFLJfdPR7yoY3/VnlPuDwc556/MWjJ5TxI0AG5HGmLKVuy5yVUrUQbKwBTm91a276Wa8i3lskn8uO/S7UF+NyIdv7Oka1UWaXv+NdXyVYzaquAIS/CFIXp+5wchY6x3mp0SPvDNGUnxSOlWJ3+NolfR/a27rsNB+N7QpE8PNAfVxxz32+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NhORwKUSMm6rm0T/lmL77q3kwYcGB8pDsQM1xwzwcvM=;
 b=SElmZrroW6h82szI+LTeJ7SzcsGZGfbXC2cMM9pwsiv/Z30Eaiiiv/i47tJCqqPbbAG0++JGEffyStvl/eZiQva0iROLtrs36ZxmFgkdHjf2HkaMkbqclBDjpU/inHgGOth15MFOYqYIuhqsbkVuCobudefFFr3DBZXPSIsMDSsqEi6M+UEQXcidrhAZu+le+/XdYvm2EUswwW8aJ64t2SUBZqSkyfe+GlKKoXbFuhlGP6I7/coqtV26GB0crcSeQLI4OTEUoD1tW8K+HZq+8kopB0bMmI38TqxwkLkh41totEsKziEcoBzuI1+ZVHuElaKK9xLpxzPB0AUGP1Nizw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PAXPR10MB5184.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:287::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Thu, 3 Nov
 2022 13:20:44 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::84b7:f886:9bed:1fb7]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::84b7:f886:9bed:1fb7%9]) with mapi id 15.20.5791.020; Thu, 3 Nov 2022
 13:20:44 +0000
Message-ID: <8a8c7b5f-22f0-02f1-b34e-672da5630610@siemens.com>
Date:   Thu, 3 Nov 2022 14:20:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 00/11] AM65x Disable Incomplete DT Nodes
Content-Language: en-US
To:     Andrew Davis <afd@ti.com>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bryan Brattlof <bb@ti.com>, Le Jin <le.jin@siemens.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221028142417.10642-1-afd@ti.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20221028142417.10642-1-afd@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:610:52::36) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PAXPR10MB5184:EE_
X-MS-Office365-Filtering-Correlation-Id: a3372b87-07b8-4d67-fa6f-08dabd9e3678
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KQ8iMn9KigkhZA7fhlX3ZSnvXX5zeZ22Tk7WQzPVp8siQOcChmah7hSXBdiWkRvPXsH2232M9/eeZkf2Di3cLh6XptgsGitmAIk0C6p6tzMlzqBRwwUPN8YmsFxFFWlaH6xitJ9R0SQ6A5CH5L9/8o+ly64E8uqhzE+nA5eydgAZK9KeMvE7HrC54KKgZQ40OKyt4+HqockdK8XxG79h94yuv64tYVrS6os/olSUnjsZ1jJCdxvh/rywp7Z+Kb4wG751iobFLX72CxU9Qo5bs4v/Gs92wzvWF70xK00PuVQpp1DgLAC/MqmjKZcLDlntfv3Ikb5GpPLZaPqLDA5e+7LjBWX6zdFhcgeCXckj1x0TBqvLuGjhQKcIMA6OqpMzpuLRNGkjSR/nKhVhHTrifN9P8y6+37VzwYto555T5ru87/M52VoldFwHbLQ+CzhOmae8iZ89CrIqBu9w0q0n23zB0KwHZrqRro2D0vNBYdCZ0nkal9HnHPr9saK+aYkIgp++NvWqADOfOzhvEcI0r4jnNrgPyg8XisQa9b3b2acvhXm9qnkfRlYuJNmB8LHLm9reRmfG9zLyUHyf7yNZReziCYmX7QrreBCJaligKyZMdofmLIrMFhQlqgb5uXvD5Q1jxYLA6bKsRkLUbzUBUC4vsOzePNFCLLnotaWLWqrm+1JBpQfqQK8LqY7Aii1bBAfC0Nxx+p5jE6sb33zAOPkUVnR+k4NeN798oYXXnNCCxBBwyjVQbezWzGGmdoZbfYrYkxyACPACIQDj0H0rgf3CCjHdVMYkJjEoXW4tLGRMAjxLUyQdYj0mt7/n6DsPXYzO8PwNTQEMFI8fQERtwg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(451199015)(186003)(66899015)(36756003)(31696002)(86362001)(31686004)(82960400001)(38100700002)(44832011)(2906002)(6512007)(6506007)(110136005)(26005)(83380400001)(2616005)(53546011)(6666004)(41300700001)(66556008)(478600001)(66946007)(4326008)(5660300002)(7416002)(316002)(8676002)(8936002)(66476007)(966005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sm1xemMzWWg4L2dqaFZDS09iaEpXMnVFZ2FseVdsSDh0M2NEYm9iRUxQMEZN?=
 =?utf-8?B?Y2hsRDU0RFVxMVQ3MGpLNzZIRTM4ZmhCbys3dVZQTERiS0ExSTc0bmRZY2RM?=
 =?utf-8?B?eVJyWnJMdmhoNUx1dk11VEpQVTYrMWVaaTk1NFkxa2RKQUdLMXlqNkJwVmhB?=
 =?utf-8?B?eGhWVVR1dElqZkhZc0FwN3oySWRERXpadkw4ckp4ci9hdVVLV21ObE92VDg2?=
 =?utf-8?B?bnhTU3E1TzRlUWliN0s3NWQwVGk5M1RobmdTbnJjL3lGSHc2OFJlRWExTFUy?=
 =?utf-8?B?QVc1Z3paTlpWSlY5UVJoeU5CMVlVa0ZHcGR2aS81Ulp0WWNKbTM1cHdWUm1j?=
 =?utf-8?B?QzZkUUxUMXBpKzRyek01d2VDbVNJUkYvc3pGcDBZc3RiVjVLV1hUckRRc2lz?=
 =?utf-8?B?dHhwbTBLOFg0TnV6MW9LN044TkZhL3B4RER6eG16bVFwcjZzOVRWYVBiY0JI?=
 =?utf-8?B?MDd0LzNOYm8zbzdVREFYdXFFZjV3bUhQTEdDRExSZjJBay9XRnphS2JSOUw4?=
 =?utf-8?B?d01qOFdNc25pd2NGMW9VeTJiRklqOW16Z0MzaWsvMGNpTzZXMVlETGRxQWxO?=
 =?utf-8?B?L3hmQzdyeitrUUUvQzdVRkF3MzNMc2RVODlDT2JDM1l0TXJSdVp1em9TRmE2?=
 =?utf-8?B?T2wyQWlxR0x2algrSnpITWhRdEEyWXBNY2NHaEREbEc1MXpRQ2pMODNqOEIr?=
 =?utf-8?B?ZTM2ajU5MHFCWlowN29BUUxsU09ZN3ppUlpYOTRCY0FUWnRDdzhnSGpLakI2?=
 =?utf-8?B?Y1orYmR2OHhjWUF1UkhNdnJXT29VUDhweTRCNjhXZkFUNHh5c2JtSlIwd2cr?=
 =?utf-8?B?TTJ4dlpRSUZnczJnaDA1Ykc1VG5icnBqb1R6OW00VEE1by9zV1ZNaldsbG1E?=
 =?utf-8?B?K2pScEFtaitCNm44M0lYd1UwMFhYdm5OdDN6b2FEV0N0VzNhMWFTeDIvWHpv?=
 =?utf-8?B?amxhUEQrYmRBUG5PM2lwQUFVejRsZk8vVExaVXBCNTRRemR1WUxZYldzR05s?=
 =?utf-8?B?QVZJVG5zeTZSYVUzeWplc1JTemgyU1hDdGVVcVVpT3Bud0xwdkJHcUtZWjB2?=
 =?utf-8?B?T0RIUDVxQzNNOTg2cHlzd2FOaVRGcFg1ZS8wbVlZb1Q4U0gzMUE1ZjhZSlQw?=
 =?utf-8?B?VkRjZU93bGNSNEpDV2x6bHBRQi9kbHdZSGhtMVloOTVZeVcxb3YyVWJLNEQ1?=
 =?utf-8?B?aXRQY2oxdEg0ZkJIZ3FLWURiR2gxMUNZTjVDVWxpTUZ0SGtVUE9IaS9RTFlC?=
 =?utf-8?B?Yy9haEJ6S1ZCaWdJTU5DTUQzNmRJcDU4M0ttT3dyTDJuZFlUdG1KM2VJbGQ2?=
 =?utf-8?B?aEVBWTY1K2JlL1hLL2V5K1prTk95M2ViTEFPZlhXMXJSR1VPZHozSHcvR0NK?=
 =?utf-8?B?d0syaHFzRDNZcjdmdWI3cTNhSzBtVFpCczFFYkREYk9LQmhGbFI2REVUb2V4?=
 =?utf-8?B?eXhwbUZnZ0laQ1p1Zzd5bk5BSWhaS2NKdU5aYk1TZzlqYXE2USt1Rzdvalhh?=
 =?utf-8?B?eTNRdGpranYyVmhmc0diVExJbVhhOVFhRmNzUGl6d0dTYkU3RWdzQzllZGVR?=
 =?utf-8?B?V3FldU13cVFNWVphd1pIb3VnM0lSVnBjWkE1Ky9iMFNNMU5LU2RFQkFtcTNx?=
 =?utf-8?B?WWhUNTlvbVhTVFlDV3drTHNySFc5WVVXalYvTS9RdnZtSGRvZnc3RmI2V2sr?=
 =?utf-8?B?anhWVW1ndTlYT1RESEF5b0RQQUdINGNqSXBDWTBla3N5TmVjaVk3QXlXN1FM?=
 =?utf-8?B?T3FxakxyVW1NbU1PNk80U0xRWnVNcEZ5SXFlYXZML0pLdk1qbVJXcm1Hdi9E?=
 =?utf-8?B?aWNQdDJRRkEzOWNZbkY3anNkTWR0S0crcmtuWnZBMlhXTDJwVXJmaEp0bGU5?=
 =?utf-8?B?TTY0UnVKVms0a1pZTk1PMVVxcTY1eVNxaldDaGZMdG5PeG5CKzUzRE9Uemw5?=
 =?utf-8?B?SEtpYlVYSW9yUkMwdGtiUkZLSFdLbHhRL2RmME11enJyajIraTVLQ0ZCVEtW?=
 =?utf-8?B?ZEdXTjRqQ0FvTnAydUNlWW5rTThKWGh4UWV6ODFXNTVydFFQOE53MndKWGVC?=
 =?utf-8?B?ckMzbDh3ZnpiMjBGYjd1VW9QdHUyR2NKekNLSVd5M2p2QVc4UHdhYWYwT29B?=
 =?utf-8?B?d3RVTUZKUWV6MEc3Rm5UektPL1dqVDhIckM5NEZZUHprdkRqYTZadHByR3Ba?=
 =?utf-8?B?MHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3372b87-07b8-4d67-fa6f-08dabd9e3678
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 13:20:44.3520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WpqjTcS+rjXZUqoPIxdVIKhMvDfpW43RL11ET19gmoL0HfFoSARdmFllv5LwLbNAv/WxAUk8z8cDk6s+1/hPhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5184
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.10.22 16:24, Andrew Davis wrote:
> Hello all,
> 
> Same story as for AM64x[0], AM62x[1], and J7x[2].
> 
> Last round for AM65x, but there are some boards that I do not have
> (Simatic IOT2050), so testing very welcome!
> 
> Thanks,
> Andrew
> 
> [0] https://www.spinics.net/lists/arm-kernel/msg1018532.html
> [1] https://www.spinics.net/lists/arm-kernel/msg1018864.html
> [2] https://www.spinics.net/lists/arm-kernel/msg1019544.html
> 
> Andrew Davis (11):
>   arm64: dts: ti: k3-am65: Enable UART nodes at the board level
>   arm64: dts: ti: k3-am65: Enable I2C nodes at the board level
>   arm64: dts: ti: k3-am65: Enable SPI nodes at the board level
>   arm64: dts: ti: k3-am65: Enable EPWM nodes at the board level
>   arm64: dts: ti: k3-am65: Enable ECAP nodes at the board level
>   arm64: dts: ti: k3-am65: MDIO pinmux should belong to the MDIO node
>   arm64: dts: ti: k3-am65: Enable MDIO nodes at the board level
>   arm64: dts: ti: k3-am65: Enable MCAN nodes at the board level
>   arm64: dts: ti: k3-am65: Enable PCIe nodes at the board level
>   arm64: dts: ti: k3-am65: Enable Mailbox nodes at the board level
>   arm64: dts: ti: k3-am65: Enable McASP nodes at the board level
> 
>  .../boot/dts/ti/k3-am65-iot2050-common.dtsi   | 101 ++--------------
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi      |  41 +++++++
>  arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi       |  18 ++-
>  arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi    |   2 +
>  .../ti/k3-am6528-iot2050-basic-common.dtsi    |   1 +
>  .../arm64/boot/dts/ti/k3-am654-base-board.dts | 113 ++++--------------
>  .../ti/k3-am6548-iot2050-advanced-common.dtsi |   4 -
>  7 files changed, 94 insertions(+), 186 deletions(-)
> 

(widely)
Tested-by: Jan Kiszka <jan.kiszka@siemens.com>

We are still seeing some likely unrelated issue on our latest board with
mainline. Not all aspects could be tested for that reason, but I
strongly suspect that this series won't break those.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

