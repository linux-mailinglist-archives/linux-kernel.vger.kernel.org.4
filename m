Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F306D69E00F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 13:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234219AbjBUMPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 07:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbjBUMPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 07:15:49 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2083.outbound.protection.outlook.com [40.107.20.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3337ACA10;
        Tue, 21 Feb 2023 04:15:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SoiGzsh21NJ2Fz4a+EoF+n8bXcSpqQax6Z3y/K3vZxV+tniW/rnT8bGEd1yzDFLLpKmthNNz1qtR3Sz98RhD27ZbGyD/T5kWdXjdNd2rQyc8PC4ucFMTYz7/KV+mWUkVGTMo8LJz4Lya1XoJ/GT/m5pZ+OO53tEwebZOZMMyGbnKWtWfpbMsL82l1nJNBmPZxOqrvt8Bh18CO7gVtqkeBhYgnmZfryOQ/CY/36oE3vk7qpSzDZn8eo5KBuS93Yfbuz4q49W+IxEKT+8OKeefNw/l+CrFFjqXB/1JreVcA1RNxsX88aPQgu6yQTSR8MKbS67zgvFXP0M1p3CzTqjbkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEtP7uToi2WFJemqx7U1gfQXAGPfA5yTmEBRqjWzSOI=;
 b=I3TEtM3CVuvTk/rJqBkbms4XuNl0FBhBV3GMZ1wyw4vDyFbC1g3hZErhdIJ2ytdlJOwjI2Ezw2s0B4wyW7gVzwqgYKqdvWXRJ9fAE6D3prTu/9VjkgsJltDJLL9zRfyMV1oDgdhG9l69UYbKb6bsVSmsQmZxrhke/meTbIDbcsCqcvzke4M6zxISJmZj2cJkr7/3shw8PXKsgElNK1eiEnNF7mvpy7/PKgDk77RQNmFkigxSntQt6+3BQkiI0GqutpCukLaxgZEAv+0mlIPYczzRyxCmlRZjC8M4i7c3nEx3ro+zqXCsl45j0/bpagq79SyxVxxPNveqzblQnNTykQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEtP7uToi2WFJemqx7U1gfQXAGPfA5yTmEBRqjWzSOI=;
 b=VF6jnKn/0fvgJAy0SEhSJ0kvzKLdkcF3M09fAWCGCH6Gz5HT8Nt9/TWwHneYwuP9g4Kb7lV7ntXTN456Ti2chKgttJ+08/jWgRQwQ6Xxtpc0KLitMIhcYMeoBwxW2xbdCvv5L51AG8AdFaBV+XxItHa7PE2LHQkgaashD3xyVY7KDvIUoblVxnXQwbYi6D4zh1Ugd4xhAGt/wnU6rvC+A68wh1ox1VFTJXF7e+j3Tj0xkeyowpytf2csuTU4omZgxDZPF2Fb7t2VXMKViXXM2yO93LTNDJE6SqBUTu5rAVSSPDBFPZIQZNSQWPnt2ofocOcPSjc/I09TlbP8lSyJnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by PAXPR04MB9253.eurprd04.prod.outlook.com (2603:10a6:102:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Tue, 21 Feb
 2023 12:14:32 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::24d3:14a5:eeda:6cdd]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::24d3:14a5:eeda:6cdd%8]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 12:14:32 +0000
Message-ID: <85e042b3-1b59-5ef0-8510-50372cefa197@theobroma-systems.com>
Date:   Tue, 21 Feb 2023 13:14:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH 1/1] pinctrl: rockchip: add support for per-pinmux
 io-domain dependency
Content-Language: en-US
To:     Sascha Hauer <sha@pengutronix.de>,
        Quentin Schulz <foss+kernel@0leil.net>
Cc:     linus.walleij@linaro.org, heiko@sntech.de,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Riesch <michael.riesch@wolfvision.net>
References: <20220802095252.2486591-1-foss+kernel@0leil.net>
 <20220802095252.2486591-2-foss+kernel@0leil.net>
 <20230215102328.GB13829@pengutronix.de>
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20230215102328.GB13829@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::10) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|PAXPR04MB9253:EE_
X-MS-Office365-Filtering-Correlation-Id: a53ee5ff-90fb-407e-260b-08db14053051
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tjSy4/LCyhmcgA7dMoV2CYUTc7zs07zaSLtwgCJRCuFz2JXx98MJWEJ0rxRnAE1qw3xSP8iOUOehkdKYqaCwSGMNSEpPlxwcFthefg55fTaauJnBbBwwqyEdYh5Z9IkNTgHShOqqPjBNx3pTlPI1mZNPXoN68REirz5rPBTVyV209ZleKD6h+0yWOrYCSPyqkDOLNeOiO/9PQjjDq/xZ8xHBCuQWSJWSvZ0V86dgXLrXAeaMb+gtKxpolEsVwnEjnNgvGuxdWmwHj7MBTKn09jTQfU6EPRUUEoSVm86GFLQAPfgwEF90WWmOjw0N42RDyFfHxKXwMi+7L+FENlQV3d9djcTflusbvq1L+lVXEJIRsGOdhqhBRaeuQaWUg0cz9ykG5Z98vol7y0U051xoDGm5bYfXwYkmakLNqM0Qogc88uzKNekF/UjLns4RReZmlul1VxVBzlRHRskKSnn0Q92SFU9op6lRmAoQiCtPL4jLM7UiSZ9YcaxMf3rEsnps6BbpGtS04LeSXhto3QGWzm9VAiLGAYlt2/Qi8K6gjx98TW99qvqi6KsqllswbvkAlCBI13wWOrbUJHJBIeJkThDsLGg6V6c+eyQI1gku+ly+3deuQpj7MIzQi4hGFyYdPaaeL8sa6NoeNHFxVGPhp4kzkMWRgaImRoEEKtnq5z6UAiVrRF+6FW2A55pU9QYUs94eWH8MFSeaVbSCLrlXjtJDAD8BGU1f/xOzFcxSmBg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39850400004)(376002)(136003)(396003)(366004)(451199018)(66899018)(316002)(2906002)(31686004)(41300700001)(44832011)(36756003)(5660300002)(4326008)(66556008)(31696002)(83380400001)(66476007)(8936002)(8676002)(66946007)(110136005)(38100700002)(6506007)(26005)(186003)(86362001)(6666004)(2616005)(53546011)(6512007)(6486002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDNhblBxdXpld3RveGNOZ2YxY1prWFhEZnFUUDNtK3BkTlY3QUN6Wm51SHVo?=
 =?utf-8?B?MFRUMUEvTFpkN3UwSU5XQUg1YVliM3QxS3NXRjBTTjZWRFlWV3JhN3pOd0Nn?=
 =?utf-8?B?OXhyTHJUZlloRXBNNFBickZlSU1RTG85L1UwUEk5V00rK215Vlhkd1VOWFhy?=
 =?utf-8?B?RzU1TER5QTdSM3V3azkzcmRRZHhtY24yclI0b2ttaEJBSkc3Sjh1bW5tOTk3?=
 =?utf-8?B?T3l3V0tLZDJVWnloay9CNXdwZVloVVZDdXVGUDJDL0pHN2pzRitmZGVMdW5E?=
 =?utf-8?B?cFMwdHo4VWhWOVBoK29TQTQrdG11NjlMTFZlV3Bhendpams2QS9YVkljWmJi?=
 =?utf-8?B?eUZtcDNPS3F3LzhUNnR5VnJvbjFVVFdVYzN0cWZtVStFbWZkOGxWSEpvUkto?=
 =?utf-8?B?d0lyYU8rSlB6NTV6NWRhQmpjNlY4TEUzWTlLd0k4UmZQRWVMVyttRjdaM2dD?=
 =?utf-8?B?MHAvdU53RC9odmJUUW82cXFkKzI1SGRNWThIZHo4UUtGLzlldkpLSzVHbnRz?=
 =?utf-8?B?UWxKalovSDdBcjdFRzY1OTgwbHpiaFNpVlJMMHhxWjh3ajhJMVZrTUFhNGt5?=
 =?utf-8?B?M2FxL3pkcDIxRlZCeEdHSmxGdVNrQTgyaGV3dlpLajZGeEpZQzN0WDY1a1pD?=
 =?utf-8?B?T3FBUVBKalk0Uit2Mk90am1qNWtVdmhRR0kxZmppOVRqdC8relZ5SUJCNldo?=
 =?utf-8?B?RnlXelVBSnd3cDd1eUFLRkdXMmt1c3cySXpuY2w1L0hSQVIwaFlvd3hKT3A5?=
 =?utf-8?B?TUNUeWJ4SHJzZG9JeUN4YVZMWXlRSnV1UXZ6SWRzTktIYlo4aStlbzdhWG1v?=
 =?utf-8?B?M2VXaHRBTmMydFV1T2h3QWUreFdnbm9QMytvNTB2YXloWkRwMTIwbzNMSGts?=
 =?utf-8?B?VnFrdG9SSWZlUHBjczR3YTYrajNjWnVwSzRERDlkcU9EeWRyS0F3NlJCOXlQ?=
 =?utf-8?B?c3d0WjZXdnErcUwwNUliNE9BVDNISWd3enZzY1JSZ0VGcW5QaGoyRHdBNzIz?=
 =?utf-8?B?MmFqbWMxMVF4SmYzcHJOaVJvejMxV1NlajdZaHk0ZXpXeld4T0xDUHBkaXRF?=
 =?utf-8?B?dVhwV0FpREVRbnlvdCt1d0VkOG12VHovWW9XZ0tWZGJlWURCYm9nMDdYemZM?=
 =?utf-8?B?R280aHk1S0JmdWRxYmJyblhtZ3JGYmdFbERMMGVTbEgzdVNmSUxYSFpGeHV0?=
 =?utf-8?B?MENtdmhVUklKcGpvTEV5OFBRa3dkbjBxZXNpYk9SazNuTkkzNjlQQUYxc2Fj?=
 =?utf-8?B?REtxMkRNRWlXZ200QUtYVnRqTkFBREhienVubThkaEh4dkRoR1U4b3gyTzAx?=
 =?utf-8?B?WlB1bUZBMGZ0TndJWm1kdHdRREVFWWQ0S2Y0SnBsdWNjU1FuRU8zZFRqOTlC?=
 =?utf-8?B?dnRmc3FoQ0x5SXkzSUpsWHNnemxjMkxFclhvTkVDbTJ6YjhzUlB1Q3E2NUc4?=
 =?utf-8?B?U01jVk5ybFJmSU5FeDJXSmhaRmdOeXUzaGRKM29zVFRCWW93S3N5Ym9hSjQv?=
 =?utf-8?B?YmM4V0RZMG5xZERZd0kzK2QvTG9FNkxTYmVjTFFGZmlnZkhQL0FGREtIcERV?=
 =?utf-8?B?VzVvZTFtS29xeGhWdXF4YUZIVzhkdTY2V1lSN2RDbzljVmdpYmQwTWN4YnVn?=
 =?utf-8?B?Yk5Rd1M0T1J6WkpPWkdUVEFRZ2pKKzFEeThERnlrNXFqNFZKNm1rSktNRTR1?=
 =?utf-8?B?a3BibU5RMnJ0VSt2dklxck1mM1lMSXJNWHhBcFpydUtmaVZscEQrL0dMNkFh?=
 =?utf-8?B?MDhjbmt5Z2g4azBFNEx4Ynh5NkdQcmhvQ2xyNVh5S2RtNUVENnNIWFk1NTEz?=
 =?utf-8?B?V3pGdG9vS2Vxa0dyZ1FnMWg3QWgwYjJLTFRIR2xJcysvRDM2OFFUY1AzNi9r?=
 =?utf-8?B?N1MxaThMT0ZobTlsblIzLzQ5TnRwdEpzVGoySktNeC9yU25uOEFDOHZFLzRo?=
 =?utf-8?B?YzNZcWo2bU0rRjlTNWt4NG9TWGJmTm9tTHBqc2gvRjFIYXpORWVOR244WmpY?=
 =?utf-8?B?L2hDcEppZ09oK1kvMTl2a3MwK2xtV21KeVp4K0ZQR0hsc0hpaEd6VFBKM2tM?=
 =?utf-8?B?RkNXVnp3SnhOWkdxdnZKU3JJSEU3cmpEZHA5bWNBZXpKQUhzZit5Zm41eTBO?=
 =?utf-8?B?aTdZeUhPTFJIc3pUTWpqS2FtNHNnNTRuZ1dWVHBvSHRhcFV2MWpGZFNxeFFw?=
 =?utf-8?Q?xLK9AP9FwjljIy1v1Z3RaOU=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a53ee5ff-90fb-407e-260b-08db14053051
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 12:14:32.2167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tLZkSEODky5JQG8d9bldYErZ6T57f/NqbFPwaySdorZSufq5Mc9307ilpf3CwckKlkQnZS0Ez0TzwEx/6jj6AWFb8zjInG0NfnihdW6gKp/9VPV+Byg0gL+XpIxvvuzV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9253
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sascha,

On 2/15/23 11:23, Sascha Hauer wrote:
> 
> Hi Quentin,
> 
> On Tue, Aug 02, 2022 at 11:52:52AM +0200, Quentin Schulz wrote:
>> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>>
>> On some Rockchip SoCs, some SoC pins are split in what are called IO
>> domains.
>>
>> An IO domain is supplied power externally, by regulators from a PMIC for
>> example. This external power supply is then used by the IO domain as
>> "supply" for the IO pins if they are outputs.
>>
>> Each IO domain can configure which voltage the IO pins will be operating
>> on (1.8V or 3.3V).
>>
>> There already exists an IO domain driver for Rockchip SoCs[1]. This
>> driver allows to explicit the relationship between the external power
>> supplies and IO domains[2]. This makes sure the regulators are enabled
>> by the Linux kernel so the IO domains are supplied with power and
>> correctly configured as per the supplied voltage.
>> This driver is a regulator consumer and does not offer any other
>> interface for device dependency.
>>
>> However, IO pins belonging to an IO domain need to have this IO domain
>> correctly configured before they are being used otherwise they do not
>> operate correctly (in our case, a pin configured as output clock was
>> oscillating between 0 and 150mV instead of the expected 1V8).
>>
>> In order to make this dependency transparent to the consumer of those
>> pins and not add Rockchip-specific code to third party drivers (a camera
>> driver in our case), it is hooked into the pinctrl driver which is
>> Rockchip-specific obviously.
> 
> I don't know the status of this patch, but I haven't found anything
> newer, so please point me to newer patches if the discussion has
> continued somewhere else. Anyway, here are some thoughts about this
> patch

No new version, a bit drowning in work but we are dependent on this 
patchset for an adapter board we want to upstream so I'll have to get 
back to it in the next few weeks/months.

> 
> I think the general approach is fine but could be improved. Right now we
> have one io-domain device with several supplies. That means once one
> consumer needs an io-domain, the supplies for all domains need to be
> probed beforehand.  We could relax this requirement by adding a subnode
> for each domain, so instead of doing this:
> 
> pmu_io_domains: io-domains {
> 	compatible = "rockchip,rk3568-pmu-io-voltage-domain";
> 	pmuio1-supply = <&vcc3v3_pmu>;
> 	pmuio2-supply = <&vcc3v3_pmu>;
> 	vccio1-supply = <&vccio_acodec>;
> 	vccio2-supply = <&vcc_1v8>;
> 	vccio3-supply = <&vccio_sd>;
> 	vccio4-supply = <&vcc_1v8>;
> 	vccio5-supply = <&vcc_3v3>;
> 	vccio6-supply = <&vcc_1v8>;
> 	vccio7-supply = <&vcc_3v3>;
> };
> 
> We could do this:
> 
> pmu_io_domains: io-domains {
> 	compatible = "rockchip,rk3568-pmu-io-voltage-domain";
> 
> 	io_domain_pmuio1: io-domain@ {
> 		reg = <0>;
> 		supply = <&vcc3v3_pmu>;
> 	};
> 
> 	io_domain_pmuio2: io-domain@1 {
> 		reg = <1>;
> 		supply = <&vcc3v3_pmu>;
> 	};
> 
> 	...
> };
> 
> This way we could put a driver on each io-domain. When another device
> needs an io-domain we no longer have to wait for all regulators to
> appear, but only for the regulator that actually supplies that domain.
> 

Mmm, that's something I indeed hadn't thought about. We'd need to handle 
pmu_io_domains probing (and making available) **some** io-domains 
devices and not unregister them if other io-domains devices aren't able 
to probe (e.g. EPROBE_DEFER or invalid configuration for some reason; 
missing supply in board DTSI). Nothing impossible, haven't developed 
such a thing yet (I guess it's just kind of a bus mechanism then).

The other issue I'm thinking about ATM is whether we should support 
upward compatibility (i.e. old io-domain driver with newer dts) and 
backward compatibility (i.e. new io-domain driver with older dts). This 
may make things a lot more complex. This is a maintainer choice though.

> With that we could specify the io-domain dependencies at dtsi or core
> level. A board would only have to make sure that the io-domain that is
> needed to access the PMIC does not itself need a supply from the very
> same PMIC to not get into circular dependencies. The supplies for the
> io-domains are specified at board level anyway, so all that a board
> would have to do is to skip (or replace with a fixed-regulator) the
> supply for the io-domain that provides access to the I2C port the PMIC
> is on. That is not too bad I guess as the regulator that supplies the
> io-domain to access the PMIC needs to be always-on anyway. In the end if
> we would turn that regulator off, we would no longer be able to turn it
> on again.
> 

Correct.

> One thing about putting the "rockchip,io-domains" property into the
> pingroups. We would have to put this property into each and every
> existing pingroup in all dts[i] files and new files would have to be
> reviewed in this regard as well. The pinctrl driver already has
> knowledge about all pins, so I think that would be the natural place to
> also add the knowledge about which io-domain a pin is in. With that in
> place we would get the knowledge if a io-domain is in use and could
> disable unused io-domains. I am afraid that the "rockchip,io-domains"
> property would only be added in places where it actually hurts someone.
> 

The Device Tree is here to explicit the dependencies between HW blocks, 
which is what io-domains and pinctrl devices are and rockchip,io-domains 
the relations between the both of them.

While we know which pin is assigned to which io-domain because it's 
fixed in the silicon, this information is linking two different HW 
blocks and linux drivers (and linux devices actually). I'm wondering how 
exactly you think we should get this link in code without reading the 
Device Tree? Because we'll have to traverse the list of io-domains 
devices and find a way to identify them. This very much seems like 
something DT wanted to avoid? Can you tell me what I'm missing from the 
big picture?

Thanks for the feedback,
Cheers,
Quentin
