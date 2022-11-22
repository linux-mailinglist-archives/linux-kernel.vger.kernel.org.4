Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2D1633937
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbiKVJ6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:58:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233118AbiKVJ6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:58:15 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70083.outbound.protection.outlook.com [40.107.7.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF6F1837C;
        Tue, 22 Nov 2022 01:58:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Py8Oxzr1YEKtTTQsqmcWF416xyKhxEdaTD7dG+gNZdU+rYz1if1/CvDQWs0t9r17O4ucYB7FUEkYK9DxTV3H6ttv2EbTJc7+KJ/RtYo1Ff3rPhXqe9GdssBpXTrCUgy4NJcCbBlPIsuG11YF/5sS96z4cFbKaLYaOVdQWzT2vKlAoszQQYpToa81fOZu3Bnf6mRM9/Ilck7gqwfHJXh85yyiwD4+XmhzlYO/iUb6FGBoriqJoG4h/mvX3Su1FdZlpnoF3+vaJSVZdYgS9WsiYAZJWllBvWCWBn+wpJcnnKRX2IAVmCampzU7KgKb805VgC5UkTz67rp5T0x5RXyn8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/hENMccd+KTw8gubTKuRmFL3iFfthy/54EQz3mj55mg=;
 b=HVJHJv+V0H/8xq03St/S7LB5RL59j7I2hR46xEQwvOXyU6jVB1VQRhznX0dsNDJvHNWIhACRDZ/sZyfUn4MMMNXUAzNbA4tWVazvMjotgEZy0+bnwhnboSE+fpfaRurDjf2iCjArzf9YJvjFl7RFKqSQ2gBoep+ghxvoZ0gxQO0Vg4DcDuifNSkqLv6gVMMn2QmQ9MovwkUHPRv/5mnyr4u7wVuhYCKSTdIiXGOVlCoSKuxbJOZSBS8AbttjkDWe8P9q+0NhS3rVc2kTXyoN2PMdbh2dMGVCYSCqaNzIrWRMZkFez7ULAs4XDy7MegXj9ui+TXmeEDwGlSNYGXaQ6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hENMccd+KTw8gubTKuRmFL3iFfthy/54EQz3mj55mg=;
 b=Ln+dJSEZuGiwLCNEZxxnXBtMljv90/rPT0PIecGEO+mMzM5MD1RAgf8Fy+YmncLqp3PwRIOAG8a3oDeFCUIIqJVIf+Ni0M1aVEzZPREwsIYfJEP2lpiaCHG4FogXcvnD2oRTU80JgApBhUV5WUKkE8vfJpL/xsxj+7J+k1ID4gLZ8j8+3Jh/Pn0Lmz0d7O7wzN1UxNOrn+KFB2uLQYEuSGmtCS5djsyuhHwEzOmN2nemoonqrUj3llq29Nh2KqDWSV/E4hsPdFjjWBtq0BJC8pw4UpjmDgbNGUshcIeQTSAGdEwfATigdbqDma/wmbE8AqI1bH8CAEhchoR9CWoLGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AM7PR04MB7061.eurprd04.prod.outlook.com (2603:10a6:20b:114::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Tue, 22 Nov
 2022 09:58:10 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::9584:94ee:73c6:bed4]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::9584:94ee:73c6:bed4%5]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 09:58:10 +0000
Message-ID: <907b9321-14dc-dc99-80fc-e1a20ee33a1e@theobroma-systems.com>
Date:   Tue, 22 Nov 2022 10:58:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH RFC v2 5/7] arm64: dts: imx: fix touchscreen reset GPIO
 polarity
Content-Language: en-US
To:     David Jander <david@protonic.nl>,
        Fabio Estevam <festevam@gmail.com>
Cc:     Quentin Schulz <foss+kernel@0leil.net>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Samuel Holland <samuel@sholland.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Bastien Nocera <hadess@hadess.net>,
        Chen-Yu Tsai <wens@csie.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        devicetree@vger.kernel.org
References: <20221103-upstream-goodix-reset-v2-0-2c38fb03a300@theobroma-systems.com>
 <20221103-upstream-goodix-reset-v2-5-2c38fb03a300@theobroma-systems.com>
 <CAOMZO5BzWsHAy7KjZe+KEiXVq-Mfpggqjk0vswuzx7nkups3gA@mail.gmail.com>
 <20221122081851.6cb762d8@erd992>
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20221122081851.6cb762d8@erd992>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0035.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::8) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AM7PR04MB7061:EE_
X-MS-Office365-Filtering-Correlation-Id: 5db0580e-cf59-42b5-5ef7-08dacc701017
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j+1cx3UKXocW68svWPR9vcnWo94KsF3cdBMjrtOFn5RY2WztbmMh04Yaxue5Q2pfr87BF9/T8N0/dj70lQvJAAORMiSpwzTvSXu3DxhefedtxWv0ufTHn/JIaQKzptHOeKZx3QXMyip3nxjsjPh0KOR7KIKqLhTDYPWJqEDwIlc6th36yuw6bUh3NEQT4ZnwTeSuJZkyx38MiHGlNT07OwHqED4nvPSEa8P0EmmqasH7KXX6ckHPCKH87mvYd8CkIJRjDwcA6AjDuTr4sxduh45i9D7qxdzoRsCI4egDmEoy9WwYxcQ/oTQDxRtrgVWfdrXiWg2ZScWQgrzu+WEf6FukhkrtpFbfz5c6r+EAoAkgJjDp+oZ1/5f4UPxwYKfGifAU8A5J0YtVKJJ4u78QSDKCPWnCOPEQpL9PrwHrqIqAV1AhUNVcQ1zDgHRvPEqPe3LG1ivbQ3RkIUWznnj4o7q5gfZiTCTBIIolbtNIQvzfBqi5cBSdJbFua6MdRT2fqgBJz+ffUOliE2iHZJmk17iJK27+TleR9utut+TiqSsalcjN2aaiiBveAPpxqeMW7fg6tvFRZH6IwOvYM7DncIgLvGpzZ1PLaXWc4nruUuyt7/IHLjp2obcpl7+bQRt8LCc0Bjgjn9oayBuLa7cKkiOa5PnM6puZPGyaX7Ea0ccPV+zWcHBeUQChhAgUfqYGkj6oFPY7HkJhA5BzqqLzrzaOyNRo4XVRNou9+6GH3xkoumyQLijY1sWwEjW/6qb8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(376002)(346002)(396003)(366004)(39840400004)(451199015)(478600001)(31686004)(966005)(6666004)(6486002)(2616005)(8936002)(36756003)(66476007)(4326008)(66946007)(110136005)(186003)(7416002)(53546011)(41300700001)(8676002)(316002)(5660300002)(66556008)(44832011)(26005)(6506007)(54906003)(31696002)(86362001)(83380400001)(6512007)(38100700002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?US9RMmdDWTlnZU95ekJZeStlbmpTK0RJOVFEVndqMnp3RFE4WmtEMmRLelJE?=
 =?utf-8?B?NVJDT0FJUTQzMmlNbyt4akNYTlBtVGxVb3c3S1VqN3RPNFlXN2tWZ3dQWnR6?=
 =?utf-8?B?eThMTUdNYkpUbGEvWHZpeEVJdnRPWFZ5cXBDQ2IyeDYxeENnb1BuVFNta3hm?=
 =?utf-8?B?b0pHZE1nK0x4dmJBSElhSTNYUzBTVjMxMFRtUGYxUW16TzRSaVNmY1V2N2JD?=
 =?utf-8?B?Q1BNYXFleGNlYzN6WStjSXVjenBYd2tNYlRQbGNXQ3Z4aG14RG85NkUvTmtq?=
 =?utf-8?B?ZVVDNDVNYk5rRFNyeFFsOUd0emhKZ2UyblBXbFFwRzVXWXpNb255ZGRqOUkr?=
 =?utf-8?B?a0NwbEZVa3VyNTdkK09BRWFjR3FQWGs5T2trQ2twTXJER3lIbnMwbTlKTFRF?=
 =?utf-8?B?b3Z1NEszSWhHZ1lub25sdU9oWk9qNzBwK0pldXh1clVLNlZJUjh1L0pidDhh?=
 =?utf-8?B?Z1hsek80UWlPVTJxcWVQbzVsYVc4d0g2T1BoNGlBNTd3dWtuTytyVGtLWk5w?=
 =?utf-8?B?dXZuM0N6WXRlRGpsU1V1MjZUU0dscE5IaC9kUk40OXRaVnRUUFFsQmlVcUsz?=
 =?utf-8?B?UHhGV2ZRY2FhUzRYL0JoN2lMVDBqSUJRZUVFc1MwWEJvODIrQnBaWHZJRlVw?=
 =?utf-8?B?SHV2ckd1Zm9oOHZzbmphSlR1K1RtTXJIN3dQODkraHZzTnVTU0tlMCs2eFZZ?=
 =?utf-8?B?cGVmUFhvVmVKM1ZCNnhDejY0R21sT2UvdUZ1cTI3bDR0VnIyaHppQ3U4U21h?=
 =?utf-8?B?REVOTTJYekkxakxxTVlIeC9ycnh5RkpHRFpWMzZzNUYyQTJvR2tYdmVGTXR6?=
 =?utf-8?B?a3JPek5FRFdtZHpVUmtZSFF1YUhoU3MyUFhLdEtOMWRzcUY4K3FmQVFBTE9O?=
 =?utf-8?B?Y0Y5K3EyenJZTUdmdWl4UEtvcVJ6T3Y2bXNkY0IxNnVHNnFRWkM1SzVwenNl?=
 =?utf-8?B?OUtPOWNONkhESDZTRURPclFNa0JqY1k4aUhUTGRmWjYzcHdmaUVLdWJBK0Rt?=
 =?utf-8?B?MHQ1dXp3UWtkc1RaNUpMVEpLdHRyTWJOaFR1QWxFczhGNVlMY084ZTZCbVpV?=
 =?utf-8?B?bDNOZVRnMDJBSmUwMVJsaTE3TUtMT3NESDFkUEdBdElDYXZmSGJpUVUwVmpr?=
 =?utf-8?B?aHpNMDVmZXY3MThVc3dRNDVsR1pnQVZFMm5vYlQwMVJ6MlY2RkkrRjBNYk1i?=
 =?utf-8?B?blRmSkxDWXdRc0YyUytuclRFcWlTVzMzSmdjc0R4WkgwNlYrMzROc1BlRFFH?=
 =?utf-8?B?Tlg2blFTWG1LV205dmszNmVZcXBGR1d1czNtRVlpSmtqTVZGcC9KVllveXEw?=
 =?utf-8?B?SFlTYWM5M0NGeTVSRnRPbE5Fczk5aVI0aWhZekdmbWdGdm1DYmh4U1pqQTFB?=
 =?utf-8?B?UE9OWUtaRjBtZVJLME0xZEEyMmFVa2FyOU1ta0xsdVRSeW1YWnNCbVRyUUhr?=
 =?utf-8?B?NC9ldWZvaG9jRnhIMDk5MHdUb3dKVHJ2bGZpMjNtT09xNHhlYURXRnlXZVdI?=
 =?utf-8?B?NHhkQ2NYNlJlbzArSURQQmtVTysvU0EzNkx1U1J1aGtjRjNKc3g2Z1lacE5q?=
 =?utf-8?B?R0lOV2tsNmN5cTgxRTBIWStkM2lvdk50WDA3UWY0dUJrQ1dmUk9McXY0QkJl?=
 =?utf-8?B?WHVLNnN0VWEyc1BGYXRrVEMvdTdkbm9uYisvRzArVkUrRGZMazV2OWlmaEZR?=
 =?utf-8?B?d1ExQlhXdUc3M2VkVFJoUk16ODBMVTJvVWdkbnNLMEN6UmJXZWI4aVR5Wmkv?=
 =?utf-8?B?TTJvOE9QTGY3T05MNVJjeUk4NWw3UzEyTDlDa3FBdlpXdXZnckthbCtVTTA1?=
 =?utf-8?B?cXNiMkdmMy9ESDB6UFBScUV4M3JzaUhiWnBVbWVSZnZIaE1VRjM3S1BpaG9E?=
 =?utf-8?B?cW1UT3JxYnZPSmpNOFYxemJKUEtvRFZqL0gwakpiZnROZXJRS3lIbHFWUDZN?=
 =?utf-8?B?ckc0VlFtUWJMVWhVSk5Kb3BmMUY2T0IzL2ZMZlA3QnBiTjJVaE5lS3pYSGRy?=
 =?utf-8?B?OFBUZ0hwNmFHZWdScEVTR3pKeTRoaVp0TlV0Q2lpZVphSWRMRHJtQzBsanZR?=
 =?utf-8?B?U1kvUFRPWms3TG4raExpdEdRcjJUc3A4cTBDSURDSHc2ejlnQVdoTDBFcmNL?=
 =?utf-8?B?Qy9QM1FhZTl4SlNrOVFIczlZTk1OUWpmRFhMWjNTYWNGWXJMU1FGUmNwZy9p?=
 =?utf-8?Q?6zf1BEfyIlmWfO4qhmwwJy0=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5db0580e-cf59-42b5-5ef7-08dacc701017
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 09:58:10.6904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aWvdZLvwKxSSCsCzFYrKAnuxgYTzWmgAq8f91Iw+hxeRQJ7tNtF943U/DGN3GAp6INFcVqYCCY/kAoQSPZtD0P1EZ3ykJn/7B1hDfNdjuFznCRsWj3BS3c5DCC9Ofmog
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7061
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Thanks Fabio for the Cc.

On 11/22/22 08:18, David Jander wrote:
> On Mon, 21 Nov 2022 15:18:32 -0300
> Fabio Estevam <festevam@gmail.com> wrote:
> 
>> [Adding Angus and David]
> 
> Thanks. This was apparently necessary ;-)
> 
>> On Mon, Nov 21, 2022 at 3:12 PM Quentin Schulz <foss+kernel@0leil.net> wrote:
>>>
>>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>>
>>> The reset line is active low for the Goodix touchscreen controller so
>>> let's fix the polarity in the Device Tree node.
>>>
>>> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>> ---
>>>   arch/arm64/boot/dts/freescale/imx8mm-prt8mm.dts         | 2 +-
>>>   arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 2 +-
>>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/freescale/imx8mm-prt8mm.dts b/arch/arm64/boot/dts/freescale/imx8mm-prt8mm.dts
>>> index 9fbbbb556c0b3..df7e5ae9698e1 100644
>>> --- a/arch/arm64/boot/dts/freescale/imx8mm-prt8mm.dts
>>> +++ b/arch/arm64/boot/dts/freescale/imx8mm-prt8mm.dts
>>> @@ -107,7 +107,7 @@ touchscreeen@5d {
>>>                  interrupt-parent = <&gpio1>;
>>>                  interrupts = <8 IRQ_TYPE_NONE>;
>>>                  irq-gpios = <&gpio1 8 GPIO_ACTIVE_HIGH>;
>>> -               reset-gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
>>> +               reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
> 
> NACK!
> 
> The PRT8MM has an inverter in the reset line. The reason for that is that the
> reset line needs to be inactive when the driving side is unpowered.
> The DT was correct, this change will break it.
> 

The DT was correct. The implementation in the driver is changed (the 
polarity is swapped) in this patch series, therefore the DT isn't 
correct anymore, hence this patch.

See 
https://lore.kernel.org/linux-input/20221103-upstream-goodix-reset-v2-0-2c38fb03a300@theobroma-systems.com/ 
for the whole patch series.

This DT patch alone is obviously incorrect, but the context around it 
matters. I could/should have made it all into one big patch, the 
question is then how this big tree-crossing patch would be merged into 
Linux (if there's consensus). We're not there yet.

For some additional background on the discussion that was had in the v1:
https://lore.kernel.org/all/267de96a-0129-a97d-9bf6-e1001b422a1a@theobroma-systems.com/
I messed up the Cc list in the v1, apologies for the missing context in 
the archived mails, I think one should be able to understand the 
important bits by reading the answers in-mail. There, Dmitry, Hans and I 
discussed the meaning of the active level of GPIOs/reset lines and I 
expressed the reasons for such a change (which are also listed in the 
cover letter of this patch series).

As stated in v1 cover letter, no implementation will satisfy every one. 
We either make the DT binding implementation specific (which is what it 
shouldn't be), or we swap the polarity in the Linux implementation and 
thus the DT but then break DT backward compatibility.

Cheers,
Quentin
