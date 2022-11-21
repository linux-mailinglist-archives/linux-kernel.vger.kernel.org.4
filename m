Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20F663278B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbiKUPNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbiKUPMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:12:15 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2069.outbound.protection.outlook.com [40.107.249.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D74CE9CE;
        Mon, 21 Nov 2022 07:06:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/PDXPNlAGsIYkq1Js0zndVIvFTxdraTDH4ZiQ6vdL3s+sea4EPtgoVtnfhh3/xmkpDOazKUogXIenkv5giP0kDPrt8LONtS0bxa1pidwPAOj9k82CQ+ZDBAWjE8BnjQeUVdlK4P81dmSkcV4vC+V7QFkQaJlpK1V0rBH1G7BPIDdd03bLWUbVfuZscRXgh7D4OnmHuqu+pcotWC4YoHAgDeQQlELzNOBQL/TehHgpbh742FtHG6RApkRO/GkmNSwNr+xP5bXb3Ox73hXk3osO9zsdd1VUxd8Y+dpwAgm5SgH66++O9hpas1oTlRzlyuo+r4/zu0wiAvyYgM9o3nMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MnWyj62NcKJV3lMx1a2GL7iSreG69GEIV7KEqcVjpSY=;
 b=MDz8odE+r8lCW5qTGIZErynEpBALBtw50ZcggYdrzHgC+8ZEa4/OUN8tpJUL5QkS8cJQWpqSBCv06fchhGgReGZJGUpcHCruC3WzBUAvjijBNqxOUdl8bjTjRf66DCIrY9tmp90VB1xk0ud5UTPQSLl2n2/trH1Rfcq0/tEggf5KouXccR+V8ONyWnX5cxJwJk15YN08RVmKFRaGSCeYSHJmUUItUZYQmZEIIVMrbdNAsc0fwbrETdTcB3oELELHiQxlm0OX2c0rp2x/gwI82w9pMhL5tYy5BKsvVNWx2QB3g6tUF9r+qhVGsU8rnLx3XeC4LqEgPNFn6GjaKQ74qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnWyj62NcKJV3lMx1a2GL7iSreG69GEIV7KEqcVjpSY=;
 b=Dv9vzzJL/zE6rtOfYJelk+JyOBy8o869+Cx+5WpkaD9tF9LkGByocY75UYDR1C/waIBN6lr3QvTfvxwpJ5AJDP5CN1sfpC1bfu8RplJdPd9VbmD4e4QaJR1hSYL9RKTgvwc++EI9NRwVEdbGXBbBuLDoO1EhaiRWOASNjJBYzRNUINqscHXN41480GbCMyTgYUvpa21UhxbU/MmBI24gCDZ2I2i4T+npRNZ009RBoY6MkKFrbYSnu+1TOv+c9mHEPBcLZWOw0sg8O+41NixOu2+iGQ1LBTl7Q02ePEzHmVeluS2P60TDlJiNhJVGqqZuZB5ngQ0SovNoHnyqKYRMfQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AM8PR04MB7828.eurprd04.prod.outlook.com (2603:10a6:20b:24e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Mon, 21 Nov
 2022 15:06:24 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::9584:94ee:73c6:bed4]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::9584:94ee:73c6:bed4%5]) with mapi id 15.20.5834.015; Mon, 21 Nov 2022
 15:06:24 +0000
Message-ID: <554ebf0a-2304-6fd0-555a-0ce1b4615bf0@theobroma-systems.com>
Date:   Mon, 21 Nov 2022 16:06:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFC PATCH 1/7] Input: goodix - fix reset polarity
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Quentin Schulz <foss+kernel@0leil.net>, hadess@hadess.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        heiko@sntech.de, linux-input@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        linux-sunxi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
References: <20221103-upstream-goodix-reset-v1-0-87b49ae589f1@theobroma-systems.com>
 <20221103-upstream-goodix-reset-v1-1-87b49ae589f1@theobroma-systems.com>
 <1fa371bd-78a6-bb7c-4692-1d8132ec2ab1@redhat.com>
 <Y2P7SsPa04975Rkm@google.com>
 <692fd16e-4183-d58d-802e-2b83563aee4b@redhat.com>
 <267de96a-0129-a97d-9bf6-e1001b422a1a@theobroma-systems.com>
 <16c7f876-102c-60e1-4a81-3378b6c726fb@redhat.com>
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <16c7f876-102c-60e1-4a81-3378b6c726fb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::16) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AM8PR04MB7828:EE_
X-MS-Office365-Filtering-Correlation-Id: c76cd158-6702-4f2e-52e1-08dacbd1f4c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v8zzdJq8DrZGLB9eh6u/mEab3yfavChL2mtng1N5mf8cLeT63lF4ZQ7UGM/b5Knz4moiU4p2fT/SpHGoXmo0Icv9ID8jXDzUzNZljO6XuNakdJRBXHVstW2Yp6cthUmKJPEgfzFDfXih2twDGoZYFSF80oadjoNxYFKzh/71mYO/THuhL71nP/UNbfP2NbiCbMpkWiRjACL3Pu65V1HdMYt0nuwu8oJ7113LS4e0NqpfJWIdSFLNSzVsv9X+h+R3t2NU9bvnRhrbxWcytvlP/UoUViJB5CHnATpUp8SWrMgph7jkK+BcA8S+PvleW5SfmsKgSCblu17Ut9KS4zkzzPtdPqtqOj+WX6LUTBrrVPSn0o/ftX9WYSQcO8lnSVSxpFxMWv/XG3dGykpIJ9V97GTWyvSddTR+HrtHirufx3jMArXfu1xe/nYqNVCcrN/CiIGOiaFZqWChtr2kKOyAJNPn4SBzVxhD+/B38mMLrkNeZb6EL3C1aGCytjNbffAK6oft8g1njsR5oMuQcCo3szbZ65D/Mq8zayz8PCHETITJu+aD0kdcd5pgbhEdIEhhrnxv1yHmsFNkV/G3nSONJUhuzyf6EC5/W18BEKtaWaxJaA7IC9krvPzgKUkeLFbVybdh7VqpJBm20Hysl6Tmn+/e2e9rkq+hBqjOfrl6moQfEGWaLv1qH+ae+qN9Xgrli2TuG8JE/YYP5+eDF7gIqyNKeSlDTZ+3wsiTBhMgFWeI3OoQYjI2bAAzjJcXMJ7w42BLE4Pwkfi0+WFLEiNA3FG9XwXoXKkeNRnUxesk4/g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(136003)(366004)(39850400004)(396003)(451199015)(86362001)(31686004)(31696002)(4326008)(2906002)(7416002)(8936002)(83380400001)(38100700002)(316002)(54906003)(8676002)(6486002)(6506007)(2616005)(36756003)(66476007)(186003)(966005)(478600001)(66946007)(66556008)(41300700001)(44832011)(110136005)(5660300002)(6512007)(53546011)(26005)(6666004)(10944003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDdVSEc5SkZqV2RBbTNRNkdnbStEUnFnSERpTys5YURZQ2RnM3Y0NVRMMkt5?=
 =?utf-8?B?alo1Z0I1VDhzSzBYUlFTR0ZoNXlLM1ZURno3S2NCb2RzMlRURHRMMXh0ZHlF?=
 =?utf-8?B?QXNEajUvT285L2g5NXRaNXJuVG1PQXo3TTRXMllDT3FqV0laNis1VlVoTFhv?=
 =?utf-8?B?Y0VJRVN3S3NmR3RUd1hnT3JoMk5XSWx5SC9MNmFPdVZTdzd2dnVZdzJOdHBK?=
 =?utf-8?B?MG9UZWxrU3J0SlZFTmZCV0gvRUw4Qi9oQVIyM1FHOGFhTVJBbm5zUWw2OXVp?=
 =?utf-8?B?UjVPR2h3dWZtNnZpN24zVS83bmZzVVdzaW5wd0NXTW95UCtUUy9xWEF5TWQz?=
 =?utf-8?B?c3hVaFZ6K1pVS2p3blM0TVRtQ1huR2Fwb0FxcUNvZERXVlpFQUtLWkNJVUVC?=
 =?utf-8?B?Sm1STTYzWGRCQWc3aHFnenJTbHYvdjU0Nm9wZTFUK0dOQndiRTAzSGZpN2dH?=
 =?utf-8?B?VWVZQ29xSUZLUE83RldWMDhiKzJHYnViUythcExrWTAxQXd5ZG4vdWNlNFUr?=
 =?utf-8?B?SEI2ZUxzN0U3RWFHemsyM1pyQy9QcWNIYkNEVHp2RGlYdUVyeWREMjhRK2Nx?=
 =?utf-8?B?Ymo0ZlZvRnZ2L0NmbGdMbTVCM0xzTXVwbTh5ZHhNYlliSVFlREtqUEFKd1lV?=
 =?utf-8?B?QnNlcnBQV1hjcnJyODQ3SlF1NUFNT0JPam41aDBkcjJTdlZYVVQ0NC9BeEZW?=
 =?utf-8?B?SkZ0dVQ3K3dxUkRXUWUxYm9vcUZEaFJoTmhxL0tDSm1IUG8rYkUwRWx5ZzUx?=
 =?utf-8?B?VUtsVnBhZWp3NkFuVXdBZmlnS3NKT2FaRnlvRVBHSEV0ZXdmWFEvS0JHRC91?=
 =?utf-8?B?aTJRNVAxWXczNW92dTNoUnFlRVV4TlJxZFVkRGRTQ1JTb2tkd0NqQlk1U0ZN?=
 =?utf-8?B?RnE0d2JxTUFNQkkrK01OdjhsWWxkQVZMOUpnOVZ4bm0yaHQ1NEV4bXlMTjl4?=
 =?utf-8?B?MkI1Z2JXVmpNblVmd3BkMjM1WTlYOFdEakFDN0JVN1Z4dk52K1RCWE5hd1N4?=
 =?utf-8?B?KzI1RmVONmJRZmFWVzk5cEFzSkdDakR6ZWV6WnhmWGxMRkFZY2cxeVF6aG5I?=
 =?utf-8?B?dExuSVlVY3Jaa2VibTNnZzFwTS90TmIzRWNzQVhXSkdjZFpuUmV2OE5yV1hu?=
 =?utf-8?B?ZVJxb2xuSlZRZ1V2emhBOXc0QlpyVlpWRmp5ZUg0NGJ3VlNLRGhTRkJ4NVZp?=
 =?utf-8?B?VisxTWx3TnZEUXN3d3J4ZWxYV3NCMWhuSWR5VDNabjVSakppR0p4UEFOMVFa?=
 =?utf-8?B?Ny9zQytER0FrWDd6WThpemFJa0cyRzF0b2lKTFF5SURtU0NURVNsZS9pWFpS?=
 =?utf-8?B?d2VyN1MvNWx2eWx1MWlTb29EWHI4d0I2N2hRZ3BBRHZIRjZLdzlnQ3lqMDFR?=
 =?utf-8?B?bys5OHE4d3lVMW5rR1RRUkVZclJyVmZIbXRsZGRjMktjN3Z0ZUU3Zk1Pb2VH?=
 =?utf-8?B?YWtJSUZSTjA1TkZ2M1Q4c1F5UHRTb2FpU2tIQlpRNFpCZXlVOTFaVU1SU0Zv?=
 =?utf-8?B?ZDVzVlk4cmVSQ1N4bUNXSHV2N0tPY09DcTBDaVhOY2JYSEdML0ZKSWhiQ0tM?=
 =?utf-8?B?cXdhVFdMMktobUVFVDJ4Vi9vbUhzc1dMTHlaeHNuWFFOUzE4Y2ZrNzJLbGhk?=
 =?utf-8?B?RGFMaWxacVIxa1hxeDZVcHFVUUJQR2IzVkptSnd2NFhPcDNtV0c5OFhxcmZw?=
 =?utf-8?B?TjdDbzMvdnY0Z08rNkFXQ0hjWXQrMVBiR1dmejZXN1N3aFZ2NEgyN1hGSDRt?=
 =?utf-8?B?dVZNbWlKdnd4a0cvbDg3ektOdVRDRFNuQ2c3R1JTeDUrWXRUSHFMYy9HSFJF?=
 =?utf-8?B?UDdUY1NmcVE0TEwvMUFLTmh3eGt0YkZjWUgvTnVRemFrdHE2VXdMNm5HWnRP?=
 =?utf-8?B?VUxPWFQwUndONlRZZVlSNXJHbXEzQ3JVT3RFVFJtWVM1V3FpS2JtSjJqd1Jh?=
 =?utf-8?B?S1RmRTJ1bFdXVnVHazRleXcvQ1I1T2xMa0x3TWEyaTlCNkRWT1RPS2JHbWVn?=
 =?utf-8?B?Uk9IZlVsQnJ4Y0RmN1ZQU1IxQklTVzByVnFGbXFxd3VpMStRYWQrcElMd3Qr?=
 =?utf-8?B?M1Y4UTVramc1YVA3Q0NveitOOUd4TGJ4ekFXcmoxaVpEaUpwQzZyTTkzL25u?=
 =?utf-8?B?eVRVWFdyWUlnU0RQcUNweVFtcnBpZUVUQ0RINHRnenBwQWVTWHVLQ1dndGZR?=
 =?utf-8?Q?Z1q0pj/3fEVoP7Mix2iExqo=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c76cd158-6702-4f2e-52e1-08dacbd1f4c7
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 15:06:24.3371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yxXXLmFaYoCRjGVAMOBcAUfzK6kj/68zH8cCiFNMnG9IcH/topCPvDzAqEVwkkfOGKzuaS56N6x5Hn8oooyAszxl4+y5exXakVh23yZtmKTi/iaHhi+53sUPrVl+GhSW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7828
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

Sorry for the delay.

On 11/3/22 20:28, Hans de Goede wrote:
[...]
> Ok, so I've been taking a look at how we can invert the 'x' passed
> to the gpiod_direction_output(ts->gpiod_rst, x) calls and not break
> things with ACPI.
> 
> The rst pin is looked up through a acpi_gpio_mapping which
> contains acpi_gpio_params as one of the per pin parameters
> and that does have an active_low flag.
> 

I just read the kernel docs about GPIO and ACPI and I'm not entirely 
sure this is always 100% safe to do:

https://docs.kernel.org/firmware-guide/acpi/gpio-properties.html

Specifically:
"""
The GpioIo() resource unfortunately doesn't explicitly provide an 
initial state of the output pin which driver should use during its 
initialization.

Linux tries to use common sense here and derives the state from the bias 
and polarity settings. The table below shows the expectations:

=========  =============  ==============
Pull Bias     Polarity     Requested...
=========  =============  ==============
Implicit     x            AS IS (assumed firmware configured for us)
Explicit     x (no _DSD)  as Pull Bias (Up == High, Down == Low),
                           assuming non-active (Polarity = !Pull Bias)
Down         Low          as low, assuming active
Down         High         as low, assuming non-active
Up           Low          as high, assuming non-active
Up           High         as high, assuming active
=========  =============  ==============
"""

But since we actually override this during our devm_gpiod_get_optional 
by passing forcing the flag to be either GPIOD_IN or GPIOD_ASIS, we 
should be good for this driver IIUC?

Thanks for the pointers,
Cheers,
Quentin
