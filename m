Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63544694C4E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjBMQT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjBMQTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:19:06 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2090.outbound.protection.outlook.com [40.107.104.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E7A1EBDB;
        Mon, 13 Feb 2023 08:19:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JScIOrh6M1raN46+y1LlZSVjT8hY2jiTR2uTp8eTZy7MrrCHA7kfVQuOb07fCce73nyjHPGjQ7VA0QGT1x5ueHUAdgloyc9xzqbWrsKXuaZSk1VLxUQBRYpOL+TiTRHtQAhSdQUqgLy10MXrp22VhyQFtNKaijY+Eoyj1BDDHb2TdGZRxkOLflXNtolmXs+RtHbQ01YGSNnldky341KqleIMlKN7gl2ZDdEaeg1nQcOZujjMF/JzYD4TGLKRZP9FRDaTtIl2pw7mW8KAydcwQf+6WUqsTs1/Gcg3G0yUWwYWjcT6EEd1vrpxYV5y/GeqOAZxHxNHf5tg5zQAuauovw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ptf2R6bi/ckOWix09d6Y4bblFSkoF5lT4pRfCA1Owqk=;
 b=jO9j6RoDQEm326lTPQJ38VPsUdKy249mMadfU4aeTTQfcBDmfb1o3zFQREzad5POHny7HXybzgLmzUYQ7FmAPliJiIslc/QJAyRN5PIOY8XoSWAr0Ex2WkVYGkrGKlBXk5ruoCaoj6pXQSiWN9GCBh6dvntRS34bfHcCvw3B3c6p9QfRjy5XVbOjKODzBcwXz290gF9v8y7VDKHzOAF7DTcTdcPyspz9oOwRjgFHlKyjoGsdWiRwnB/xRJgI4x/BgkC8sCWktjdHleBQujBuyF7NKxqD5xAMfS7wP1AkIfK9zUk/ZMZvXtbJOEmxC7CQpTK00pW2xlyuPIuDWBPQzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ptf2R6bi/ckOWix09d6Y4bblFSkoF5lT4pRfCA1Owqk=;
 b=YfO/RSketvSArJkWNb9r3Zfh3YgC8HqUJCuOnaL5praSCRKAd7Y7ZWWGIM897KoqgdGjVP5hFyHM0eHjxXg843CPNXlmxP1ztxadSLviH6g+2hQCEZ5oF12BPpyJ/0jl6PyQSVsXRWHmmNfVmpdCf7z4k7DstXSMOcjJGF+dGxU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by PAWPR10MB7221.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2e4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Mon, 13 Feb
 2023 16:18:59 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::59e9:ea90:b6ea:3863]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::59e9:ea90:b6ea:3863%9]) with mapi id 15.20.6086.023; Mon, 13 Feb 2023
 16:18:59 +0000
Message-ID: <0a1b1338-1d0a-d794-0c1d-9611713eb6fd@kontron.de>
Date:   Mon, 13 Feb 2023 17:18:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 6/6] arm64: dts: imx8mm-kontron: Add support for reading
 SD_VSEL signal
Content-Language: en-US
To:     Marco Felsch <m.felsch@pengutronix.de>,
        Frieder Schrempf <frieder@fris.de>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@denx.de>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Fabio Estevam <festevam@gmail.com>
References: <20230213155833.1644366-1-frieder@fris.de>
 <20230213155833.1644366-7-frieder@fris.de>
 <20230213161548.ucaqpza65byyqvfo@pengutronix.de>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20230213161548.ucaqpza65byyqvfo@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0152.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::10) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|PAWPR10MB7221:EE_
X-MS-Office365-Filtering-Correlation-Id: ceb9d3c5-8d48-44fc-438f-08db0dde0350
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n7oso5SXcNg7vNUOwRbmWeM+v3af6M9bIEiIZW8mOeUCjKOfk6zN1pnJGDbLNiPJH1e6ZapcXcJR6AjMk9FwZvaZSufmawUUcvUd1kt7FcSOqjLRxsZTbzrKF+u+rlH+PignIQl1hg1/62+Rmn1cVLYDTvVsWn3iYhtehP4RnV7ho6hr1Jk+d/DJY9vzhTiOvq3wkJB6xaFq9hNjxT4M1KxoDub+xxpRMMVGNNp6jacVqB25BnqJ93xvsNImIld5u8vLNP6dAxPoBEk2GeLAk/atdtdQLhfDwDvCWWBkfXsiR/SI7+osuQOo2Wys7lIIstsRSLc64gY6I6OoiU/TlNsJjt+8IDhkSWITYFgN8JZHkOOPoTUCdyIKMoJ1TVDY/5ft5W5RzmS7sa/E0dxt+KJZvayIHYRNU46PSflTr67BQ3aP4j5A4/t3dSGbD/P3JzctooXhcpBBKHrCZEFirunvert+V8pxO1sVrYQfvNE3bg2N/wVaaHmaGNejC9aI24WOhFip1hdjOB/cq9hQt+cEu1KbGl2M4Ubngpeoeij4zTE/+uRyBklBNmqMW0erA737U4VeFAZAXt00gdByAhknauzvcG6ckNZA6AM/eZVwNn1LbKOe4ZeY0DvlxVcKiZLG89vnHerUgh5Rr7SUzgtTs0yraSYejXEW9B7L2kGBvR9kQuL6eYktSHitdXQPbqshR6NMBHkRMRtOk9CcK015LLynu8Mt8NLhnZvwDpAYFyZRzGk9VbIcVyMnp78W
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(376002)(366004)(136003)(346002)(396003)(451199018)(110136005)(316002)(54906003)(66476007)(66556008)(8676002)(4326008)(66946007)(41300700001)(6506007)(8936002)(5660300002)(7416002)(44832011)(6666004)(31686004)(2906002)(6486002)(478600001)(2616005)(6512007)(186003)(36756003)(26005)(53546011)(83380400001)(38100700002)(31696002)(86362001)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWhHSFJMR1M0WHgwbEhEUUYwRTlQdGZLRU5uS2huOUJ6UFBnM1VFcG5tS093?=
 =?utf-8?B?NVg0UlhkN0RXWCtYZHpEUWhna2t6Njl0MjQ2MUxhK1luN0dWRGk5a2JBOGdq?=
 =?utf-8?B?MFNpU01jZVlxL1BUSDZNZE14M3I0TVBqZ0xzREt6SlpSaDh5cmR3Vm8vNll4?=
 =?utf-8?B?TTlBV3o0TTBSWFJidkZtS0JzcmxWK2o1S0V0TW5MZGpmbCtqaVNYdTZvUFBC?=
 =?utf-8?B?YlROa3YyUmMzR3NueGRhVURQb1A5RnIzajlBVEoxdzRheVdxNUxBUmN4QlZu?=
 =?utf-8?B?VlpuejEvNnJRMmdBc0Voa2N2REdyU0F0eFdLMDVRc2NJaXFwVlRHTC8xeDFH?=
 =?utf-8?B?Z0cxalB6SlF5cjBHYTFPbzBsQWRKenRNNDFsRnBOa0RCMENtTU5CRmNPNnY2?=
 =?utf-8?B?ZHJBcHkzSWtVaFE4dEpCaVI1QW1WWmhJeFdkRHlkUzY3dlI4ZGFjbkRGK1BJ?=
 =?utf-8?B?N3ZGclRiZDVZMWY2UHpEMS9IWXprRjZSTC9sNGJGM2M1NEFSYUpYM0NSQkQw?=
 =?utf-8?B?UzNpbmFqcWVvU29EQUJpTVloZWFBdi9YdkZvNGx6SlNMVVkxMC91YmZvMTJR?=
 =?utf-8?B?ak5VR2toYWpQZUhDdjNwQTd6ZGhZRHo5K2M2cWVXS3hYYncxejAzSjNlQWl2?=
 =?utf-8?B?NWhnTFIwaXd6UEVLajdvbTdpYjFKeUtFellKd3hUL1BjNzRBblRsSTZSRVhV?=
 =?utf-8?B?aFdTbVUrZGtJNVpyQ2Y2K2lVOUNIMS9QMDQ2ZkpDOGNnRHV5SjRyT3ZrdXlX?=
 =?utf-8?B?YjdGVWxFQzcrcGFmeklqODNnQk9LZjJPTkFiZ0M5VXVEeURZVDJQQmFuczN0?=
 =?utf-8?B?Qyt0S3U4YUJGeHowclpaYzBxWnhFT094V3F5R0tmKytZN2VFSnIvRGl6b0gz?=
 =?utf-8?B?bTNVTFhvTnIyTW5YbFBZb0h1bktubHBHNHNGNXVrWEJqZkhoRFR6SkJBQU5y?=
 =?utf-8?B?UWhSWEI3TDhCTmdRcU9rOUNXWkNKSC9OenlMbTRWYkxLSTVCWnZPNFNVcWdX?=
 =?utf-8?B?eGpBSHdZc2wreExvalZtOFd1Y1BOZUh1dEczdkRPSVFhN3lNMU44UVpicXFm?=
 =?utf-8?B?ZEpBdWFUMWtYdTlpNFJCajZBU1JtN21qMTQrTFIrK04wWFo2amdHeUl5U1hx?=
 =?utf-8?B?ZE1rL2NGZllJN0dJeVRjZUhaT3NCZlNuMjhnaklFM2lYTzcwLzZ4aWhZOG5X?=
 =?utf-8?B?Yzl4T3NmK2hRKzZuVnZKQTlUOXNYSmt3V3ptekM1L3NDMTFTZE1ac0FEVzZq?=
 =?utf-8?B?RlYzWTN5MHEyTkVUUWk5Z3RUMGZCVnV6UFV0dVhaaC9PYlVaR2p5WXJPelF2?=
 =?utf-8?B?WmFkcXdpTmllNGJiUkM3OExUSGs3bmljZ2dqYmdsRk5pUU4wTUJLQ0o2UGkz?=
 =?utf-8?B?VW9rZ2ZMYzFySGFMUi9Hd29YdEJFN1VXR2VOamxpK2J2ZEV3ODRSSmdYRmJS?=
 =?utf-8?B?VGtrZXFVNmkzanVqdW11ZDJMWUI0NnFUeWF6cjJmc09zY1MrTkNMUmxvOS9I?=
 =?utf-8?B?L3JpTGs1L3Fib0N1Mkg3N1VjclFabnBIME5ldWJiUjRVbmlWR1BuamlHZ2dQ?=
 =?utf-8?B?ckl2czNrYU9yVlNqWkw1QXVoR3NXQ0xaOHpFdWlUdnA5eGllZGJhNk1ucnR2?=
 =?utf-8?B?QmZxS3RiR2VBRVJSOFZmTDNzeE1RVlFpSFBTeHEyQTNsSXZNeVBOWEZPMWkw?=
 =?utf-8?B?NXVHaUhuS3JtUnJXVURva0ZvS0hjWU1zRytqVldnUGE0ZU91Vm90VVF5Tndk?=
 =?utf-8?B?M2w2bEtVSm41NSt1U3hsTlM1NllOZHVIVlBHdUR4cHk1V2l1NVRqQ1JQY1h2?=
 =?utf-8?B?UG1uSTJkd05LcTRaK3d3TUowVXZqUXFWeFVxTExxRTc3MmpoU2gzVFNyeC82?=
 =?utf-8?B?d2FLVmZQVlpNdEdZN2toMkFnV0gxTDZzNS8yU2U0c3BFS0ZXcVZXb2U0bDh4?=
 =?utf-8?B?VnprZDJHaUZBZjA2UFVET2N2YVdmL2ZOZ0tHaHpVaDhuVmNNaDMwUVM4d012?=
 =?utf-8?B?aUp4RXpOcys1eUZUUWVQNmlyZC9xZDZENjN4bUpEeWtjN3B4SS9jaC9PQlJG?=
 =?utf-8?B?aUIrTklNK3JFTVRWeEtBdlBUT0J5eThhZDFjZkxBbk5zQVB1YllVcVVoWlRl?=
 =?utf-8?B?R1BIMG1ZUXQ1OG5OZlhXMWxRMXRDdmVybElKVWdJajljWDhSdGdORGJkcTFi?=
 =?utf-8?B?WEE9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb9d3c5-8d48-44fc-438f-08db0dde0350
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2023 16:18:59.3955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i2mPdZCekGGYpacnlpR3QXxzCd5PXYE8ExioPM9UoVWirBc8a46v0ddRipwklyYdofaW1buhkkqyCN7EhKu91dNFfm7q9H43RYSJKoxguy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7221
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.02.23 17:15, Marco Felsch wrote:
> Hi Frieder,
> 
> thanks for the patch.
> 
> On 23-02-13, Frieder Schrempf wrote:
>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>
>> This fixes the LDO5 regulator handling of the pca9450 driver by
>> taking the status of the SD_VSEL into account to determine which
>> configuration register is used for the voltage setting.
>>
>> Even without this change there is no functional issue, as the code
>> for switching the voltage in sdhci.c currently switches both, the
>> VSELECT/SD_VSEL signal and the regulator voltage at the same time
>> and doesn't run into an invalid corner case.
>>
>> We should still make sure, that we always use the correct register
>> when controlling the regulator. At least in U-Boot this fixes an
>> actual bug where the wrong IO voltage is used.
>>
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
>> ---
>>  arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts | 6 +++---
>>  arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts       | 6 +++---
>>  arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi   | 1 +
>>  arch/arm64/boot/dts/freescale/imx8mm-kontron-sl.dtsi      | 1 +
>>  4 files changed, 8 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts
>> index 8b16bd68576c..bdcd9cd843c7 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts
>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl-osm-s.dts
>> @@ -344,7 +344,7 @@ MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d0
>>  			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d0
>>  			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d0
>>  			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
>> -			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0
>> +			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x400001d0
>>  		>;
>>  	};
>>  
>> @@ -357,7 +357,7 @@ MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d4
>>  			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d4
>>  			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d4
>>  			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
>> -			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0
>> +			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x400001d0
>>  		>;
>>  	};
>>  
>> @@ -370,7 +370,7 @@ MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d6
>>  			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d6
>>  			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d6
>>  			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
>> -			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0
>> +			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x400001d0
>>  		>;
>>  	};
>>  };
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
>> index a079322a3793..ba2a4491cf31 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-bl.dts
>> @@ -321,7 +321,7 @@ MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d0
>>  			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d0
>>  			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d0
>>  			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
>> -			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0
>> +			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x400001d0
>>  		>;
>>  	};
>>  
>> @@ -334,7 +334,7 @@ MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d4
>>  			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d4
>>  			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d4
>>  			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
>> -			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0
>> +			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x400001d0
>>  		>;
>>  	};
>>  
>> @@ -347,7 +347,7 @@ MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d6
>>  			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d6
>>  			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d6
>>  			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
>> -			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0
>> +			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x400001d0
> 
> The VSELECT pin should be driven by the (u)sdhc core...
> 
>>  		>;
>>  	};
>>  };
>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
>> index 5172883717d1..90daaf54e704 100644
>> --- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-osm-s.dtsi
>> @@ -196,6 +196,7 @@ reg_nvcc_sd: LDO5 {
>>  				regulator-name = "NVCC_SD (LDO5)";
>>  				regulator-min-microvolt = <1800000>;
>>  				regulator-max-microvolt = <3300000>;
>> +				sd-vsel-gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
> 
> and by using the sd-vsel-gpios property the IOMUXC_GPIO1_IO04 have to be
> muxed as GPIO, which is not the case. So I think that u-boot have a bug
> within the (u)sdhc core.

No, we don't mux the signal as GPIO. We still use the VSLECT mux option,
but enable the SION bit, so we can read back the current state of the
VSELECT signal via the GPIO.
