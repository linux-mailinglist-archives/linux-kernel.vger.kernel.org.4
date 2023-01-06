Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518DA65FFD6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 12:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233828AbjAFLzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 06:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232688AbjAFLzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 06:55:00 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2126.outbound.protection.outlook.com [40.107.249.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627C872895
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 03:54:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R0vuYIoMDkYMOr2m2rImcmKyg9iKA9q3/+D3CSWY/1X9KMkIzxfcUw5iMkTMwwXrtJNlrzJG1jjgAhbLezr09uh+i8Dv40Rlbht0mFJ7kXnyWUvmj/jsGSxBfCjb1MY79yCSouhCLDjG/WArwALfKTRKAjX0YGt7unNw7Grt2tTgTBTXVHNB9dwRBTnTcFOHXFfpo+WnHNBDZig4fRcEeP48hexpUhR6tVxFI5IIQPgedWSmRClOWB6VxY7LJ6XTv7G/jGd9Swhw6AfSiqeQnPaOOrGY1IOc1whUGqAqY2o3F7hmKUjitIRtcGZRkfyuOLVHzXYyYHoQIe4klJQLlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxvM4lUxTJMNdCUS6Mr9oBrJ2qyMA/5E+sPyOM5XcCI=;
 b=csnLlLCJHK11t1gbXmw3y3lin8XPcGY1IWkl2PahBBjoTEMEwVx5EFFTzh8wkZ+28VtI4b4YFxkThkfgl0HfB88+ALtIvG6ZcxypA8q+A6LlD5/GEJGgY5FiGv30rwOFjls6qwvgDmSbs51yREpy+GH+SVOOEQ6mZF93ZEiL7zc3XFDZMui2BATrmEwSl+goV7Khmnur+C8Qk/rvv7821ZwyUnyFz+VtkwOc3GGUU5SjzTS4ybyRxfhVR7oxA4yXvDSuHsBohC5sZM8Eul+C6CnUvWaG4VRPOWAxs9ghQbvtlMH0wxQUn2+dFZKqk9xFZ2ULrYPcYKjVOIneac8/9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxvM4lUxTJMNdCUS6Mr9oBrJ2qyMA/5E+sPyOM5XcCI=;
 b=mfzuqIvc0oKywjUHA24EW15lO4i62FTVyips4Sm+eCM6fkrbmSgAt60PJgvSffAJ0Dz+7cTtvWdXveEhGSewcmw3bc/Pfc2GgVIKTXPkQ0uWvU0Iy+/gILqvwbnJJb17HaZ24vTIxedNFbOxWHiwFMpvNcuG510Xmv3XaPfno00=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34a::22)
 by GV2PR10MB6305.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:78::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Fri, 6 Jan
 2023 11:54:46 +0000
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::722b:5d41:9862:10e5]) by DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::722b:5d41:9862:10e5%9]) with mapi id 15.20.5944.019; Fri, 6 Jan 2023
 11:54:45 +0000
Message-ID: <5ae757aa-5b0e-be81-e87c-134e2ba5205d@prevas.dk>
Date:   Fri, 6 Jan 2023 12:54:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US, da
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Li Jun <jun.li@nxp.com>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: commit 3497b9a5 (usb: dwc3: add power down scale setting) breaks
 imx8mp
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0040.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::11) To DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:34a::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR10MB5266:EE_|GV2PR10MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: 05b2a985-f158-4dbf-0ffb-08daefdcce2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SRNzyVCd0pqor1K3h43VpXfrzrXMvVGvg45yQcDq6iDpEMbOYowHQLVBXWXHmdyA7igMGXcw3ghr5lkQ1PA2+J9MgEKmFpsinBv2V15EcblBEjfERVWqfLSWqKKTL7dnNUSqi2halIsxC1vhz/hfNYv9J9N2QXbG9V1/oJkVnzbTwTYSgIk1vikUooew7BML4nk3riT3bXqRHrTonxyZyr3xaSAHcyfDfcyNOisKK8luMZXqoTjphocF1P41oSo+WzB+lUSHMJZPZwd34/NusJzTD+uG/9/Y4oXIhh0aP+x14VOmuFsS/jSsTIune7C8kjyg6PSMk5FT3s4Qhp8wMxq6OkRiGSu4/0qhVOj/gspHBRROEzaDuvj7l7EaNnoE9qzEOecm8LJo1ngMZawHFRIbTSRpAGZeMOUsUY799qziFDMsLJisjC/QoQJpja0TtF/MDiOlciNSbTgnqMno5qt9r6d++v2S7O5z1zoneqsc4eo0B4TR3K3fDjlGp4urugsrnZVDGkLACnAJh/fdFaXwJZYwMoVmeW+uDLe6dM77Qylz4lUuo6IYHhpVHuK1RqU8vs6YH2ojGhV8I+n7Q1AMmvHulDjBAI0ns2aj7bwK7JTuoPDheVI01+QyEaeLGgyKldPS9bkN95yutEFRh3cOltkQNwsBTElkKD2gdkYA3tCiCT9FfEjJi66SX/Pofy++0deWXjzyJVNggEScwUvkV/YfWDaONS5mmlkFWpCTAKwRi6i+MASzITCrHvnmD+cKXIREw+yUzZn0dL2dKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(366004)(39840400004)(396003)(136003)(451199015)(186003)(83380400001)(26005)(6512007)(86362001)(31696002)(36756003)(38350700002)(38100700002)(2616005)(44832011)(2906002)(31686004)(110136005)(4326008)(8676002)(66946007)(41300700001)(5660300002)(8936002)(316002)(8976002)(66476007)(478600001)(6486002)(66556008)(52116002)(6506007)(32563001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czlCYjhWMzN1WGhub3B1SmhUODlmOWxKT0J2aDNhVFBLeWZnT2ExRXZJRlE4?=
 =?utf-8?B?TnZHbFdPSWhuNE8zMmR6eHgvWTVrd2l6WW4vbkxHSE81YU16bElQQk0yU0JH?=
 =?utf-8?B?M2k0Z1Q2Y1E3a3FFZFA5VVdRbXQ3UzBZMXNBcVhDTElUMDQ0QjNqWVZMZzl6?=
 =?utf-8?B?b1pueG9qaGJsd2UveEZRT2RVN1VTeXo3Vzh0c2Q3aGUwenZjcjNTN2JwMUJz?=
 =?utf-8?B?K3FRSWZtTHFPQjVlSWN3c0w4QW1aMFNSd2owcmVtSmVtQ2hTVnVkM3RzQlF6?=
 =?utf-8?B?K1owL3kvRElxS3VjMENBUjFQN3RCS2lxbnZKaVpGbis4MGcyUlVzSm54SGhO?=
 =?utf-8?B?MkNwNWxqaDVISWowbktnUkdPc0Q1M3dRMnFFeHM0ckUyUFJwdEpIYzVHK0Jw?=
 =?utf-8?B?SEhNV1NDZENSSkIyMWQ2U0xjTDIxL0JKS1pUUmNSTHVmazF5QVJHaWd6Q0RK?=
 =?utf-8?B?QmV3SjZ6OFlGOUI3TGRDQkpzQTZUMzdvNFNtalMwbXgzYWZuWCtpVWVweklM?=
 =?utf-8?B?WmF6blhSSndMY0dPL3o2ME1YcWF1UnlXNUduOVF1ckJHZFpXZ1J3cVdsV0w3?=
 =?utf-8?B?aTJWQWl6YnVHczlUcmIvZTFtM3h3emtjT2VWam91Uk0xV0tJazZoNzlzcVJZ?=
 =?utf-8?B?dU9JYlR1UXRwclpqK0ZHK1Z6SUhsSTAyR3RPUmJqNGVIcUh1SEhvNjNaRi8v?=
 =?utf-8?B?YlZFODZ4bWNYUkc4VTdaWDVoTHpJeHBIT0hhR0xUdENpQ1prUHB5aW1vc0N3?=
 =?utf-8?B?UVNhY1RvSm9zQi9UbW1yQWJ2RThsRC80L3lzTHVhbEdHYkprYlgrUURqYXdI?=
 =?utf-8?B?ZkRCQVR0S1JFWHVWSG5BZERoSUs0T3F1d1FseDhvd0RSRlc1eURycVN4YjNn?=
 =?utf-8?B?VFJtRHdReENSckVZUTFFaDlnR1BEVlJEYTJvdVFXVVl4SFg4L2NnUUovaUZy?=
 =?utf-8?B?MUUyVnNUWGhRczNTdWU0TkxOalJlVEpNUkpRelJ3dllNRnRudU84T29wZExO?=
 =?utf-8?B?MDYrZk43QXlQUXB2cnQ2TTBONkZMQnQxM3lkQ1lzd3RMU2J5ajdEc2t6QlhW?=
 =?utf-8?B?N01JZ1RjWnFlT09vUFVXNDNmNkpyUDRqS0RzeUR3TGI1M05leGg3QThaTEcr?=
 =?utf-8?B?czliaUJHTzczMVJxRXQ1MmxLY0lycEZLZElqZEs5dVdxVi9sQ2pQNXJ5NXIr?=
 =?utf-8?B?bmZCalJYVEUrR1ZwQlpFTkRnUk5zQml1M1YzUHFUaVFHR2w1S244cmwvUkx6?=
 =?utf-8?B?aXJxUmdiSDQ2VjUrNTZkL2xXV2hqU0hjZktBaGxETExET0YySUNkTEgrdzM1?=
 =?utf-8?B?QnI3MVhaY1p0OFNmSVVUU0x3Q0Ewc1hWeXNvRXY0cHNiYitnMXE1VE85NE45?=
 =?utf-8?B?YlJZcjNYVU5PdTVBSkFTN3JIZXUrYU1POFZ1N284TWc3d0hpbXVFeEY3R05N?=
 =?utf-8?B?NHRTYlFMREVyekxXSDFVZjArQ0RDUWVuV1hsTlE0cWhUek1iNGpMTVRISmN2?=
 =?utf-8?B?OGk5MGFPeEpEVXd0NkpGWWdnNHorRWU3N1JPSDNwcTVmMDFWVWpKOUdGN0ov?=
 =?utf-8?B?OThLQjNEbGJGTEhFS2N0S2VuRFl6V2hDYWlTVVhQaG0xaTdQKzhqWDlrU3M0?=
 =?utf-8?B?cFZaNU1aZ3RML0JHWVU5eG1DMlRacFI2akZGTmdZTHVlcmQ1UmM3QXV2MUJP?=
 =?utf-8?B?Y2I0c2M0WjdGbkxzNnVSNTcvY080bUVvRDk0YXVaYmlSUEw3VnhnWEZBUU1n?=
 =?utf-8?B?b3ZtSXVrRE55dVZzUDFONDBsSlF1d1h2OWcvcVFYY1ZEbVNqK3haZVorODQw?=
 =?utf-8?B?Uk9mYURlaXo2Z1RmeGMzZlZ3dmVMSzNYamVRanVyaVRCREFEcmhyOVlSRkJV?=
 =?utf-8?B?ckFycG9BeEg2eDhEeS9ybUUxSkdoaG5zOXRZaVlHNWZSeDJ3NHdKSVVVTy9V?=
 =?utf-8?B?NDRmWDNtUzREMzllVDdVcExUdFNlS0NUTlBhaFpWOFpERGhsck9XeHpzTllS?=
 =?utf-8?B?VU16OC9pdmJwZEo4RndwU1NJWEtXUVhBVTY2S1dYbXQ5dGp3cmpkSHNqaWw5?=
 =?utf-8?B?azMxNHEzM1FtQlFhdmR1dHRPaWV5TWY4b3dVTUprNlBjNFY1dDhWREhzamZm?=
 =?utf-8?B?UlBUdnJFdit5U1ZXUEpFQzJtdUhJMkZpRy85NFdsdU90NzlkWFNYalZJakpl?=
 =?utf-8?B?VFE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b2a985-f158-4dbf-0ffb-08daefdcce2b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2023 11:54:45.8536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jMsNUWzn1hEGYNWQmkhLmdzQFpI082Tmduljd8Ra20BxlUrXA7yyyTWRFaJmvZ3jacBp6P7eI2HYo4qmXu2GN5jouAQu4vJMag2zRorHtPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6305
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have an imx8mp board with a lan7801 usb ethernet chip hardwired on
the PCB, which is used as the host port for a Microchip KSZ9567 switch.

While trying to update the kernel to 6.1.y, I found something quite
weird: When the switch was being probed for the second time (the first
ends with a standard -EPROBE_DEFER), the board would spontaneously reset.

Now when I disable the switch driver in .config just to see how far I
could otherwise get, the lan7801 device didn't appear until about 47
seconds after boot. Bisecting unambiguously points at 3497b9a5, and
digging in, it's pretty obvious why that is bogus at least for imx8mp.

The .dtsi file lists IMX8MP_CLK_USB_ROOT as the "suspend" clk, and
clk_get_rate() of that returns 500000000 ; divided by 16000 that's
31250, which certainly doesn't fit in the 13-bit field GCTL_PWRDNSCALE.
But I assume the .dtsi file is wrong, because imx8mq.dtsi has
74bd5951dd3 (arm64: dts: imx8mq: correct usb controller clocks), and it
seems likely from the commit log of 3497b9a5 that it was at least tested
on imx8mq.

Now I have no idea if the right clock for imx8mp is also some 32kHz clk,
but it would certainly make sense; unlike what the reference manual
claims, it seems that the reset value of the GCTL register is
0x00112004, amounting to a pwrdwnscale value of 0x00100000>>19 == 2 ==
32kHz/16kHz, and that could explain why things worked just fine without
3497b9a5.

Li Jun, please either revert 3497b9a5 or figure out if imx8mp.dtsi is
broken and needs a fix similar to 74bd5951dd3.

Rasmus
