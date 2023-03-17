Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36B3F6BEF3C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 18:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjCQRJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 13:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbjCQRJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 13:09:02 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2070.outbound.protection.outlook.com [40.107.105.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDA341B75;
        Fri, 17 Mar 2023 10:08:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YYmpnBWd2KjaNK7uL6dbuJ8TmAbeDIOkPf/w3vlMg7HHDWlPpqHmUDfWclymZllCG16pw9StlHEhEAM5KukhXpfQyOeDWa+Q4Bve6d39Xo2fpTd8AZy/xNysuyQNsFhSSMSPDCFk/BM0opEkxjYuTzgu0flg5JzF47q7nzMhFpjaIF/KigSZYlyHVkuMCitBF9H8tQW/l6AXeHMPr5lxyJ3gCeWyBGCbNDfNre2r4g7tv7mAYjBuzHrLcwIGE/iQeTMQJI3dC+VbrnwF2EQ2Bfhiv3u4UwIr5PK98xXKB0cOPvO7AT71fFKaEDHYGJCvKzEcFS9kXF/l1kHKw5a0FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ljdmsn2u22jJsNeYuiA3x4XtcNrNsaqcCJb8EU9pcg=;
 b=HTOwIKMlrTSv6dFbveAglK4Zw1zgaFZfG8w8GMv2LSbdOVh/j+AGRkI/xPWFjh09ObxWnmBkW3BP+AAdEXBWAm9erRr49v+q1T8kxa3wrxbve09mgTqgC7RZktgpN9bci64KzuBB/nKyBmtHNVGIYouLHqF8f+JekctufZMtd7Y3qzB1VSCczb0JxnbjN0UqU8zIQCQCkzOjhroyKilKWnWTOXRhvr5o2vP+ryz8vJafUaKsEi+aDIobRhM0GBOfdew1p9yGBuifeUY2z09RZipYxnNoZ2JCJPRfVoP6qyg2EucwS4RcNbPgU98bi312bmGkXaLIaViwTO49yQndYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ljdmsn2u22jJsNeYuiA3x4XtcNrNsaqcCJb8EU9pcg=;
 b=kMAB1wAmW3fAzPa7E1fBD5KUvgXARC8nww0ZoJohN6wWYjziGDapbe8zuyoHSwhUNQ1SKoVmz9u5J74ErBPuzOySNu6DcbGK8i85BLdlZryGws+8/9e+7fehMyyncych8hsbQnlE7bMnibYS+LPUmnHVZI+dZEqUtN04qouVwjJuNLw9hTGJsqbPjXE9lWxuSY44UEaGEL2R1exa2zgiw6BNNNdi7KNwPX83rYDO550o5lqP6TKel3IL7LlhjCTJfntPgZUhlOsMf7bRfosNPq1Q6N9eImccc7/pAKmPdNJfx3+/N97HqIeqOSQKKqay8YLa/1EqvUCiKqjhP97AGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by DB9PR04MB8122.eurprd04.prod.outlook.com (2603:10a6:10:25d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.35; Fri, 17 Mar
 2023 17:08:38 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::c2a3:a621:4621:fc62]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::c2a3:a621:4621:fc62%5]) with mapi id 15.20.6178.033; Fri, 17 Mar 2023
 17:08:38 +0000
Message-ID: <104181cf-0f71-e833-f71a-8fba9fe7fba9@theobroma-systems.com>
Date:   Fri, 17 Mar 2023 18:08:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] usb: dwc2: fix a race, don't power off/on phy for
 dual-role mode
Content-Language: en-US
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>, hminas@synopsys.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        amelie.delaunay@foss.st.com, alexandre.torgue@foss.st.com
References: <20230315144433.3095859-1-fabrice.gasnier@foss.st.com>
From:   Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20230315144433.3095859-1-fabrice.gasnier@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0018.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::28)
 To DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|DB9PR04MB8122:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f221a06-8859-444e-2322-08db270a4040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /lxLuQgJzCoQhO5cVolG5B81pW9zy86/tAg8FRKwEH8c/+f/xn2VGw0NGLwaB4vBCx+ccOW7/wAkoSIACZsqCpTDa2fNrRjRfqy35EakTDEYVFF46M6BYMYpZ5Vr+cg/1v/lN+Pg76IOs9gjdlwUYoFD7TnUA8BL0XpTnlrCpVZBxMCMSunR7BA+63CEdSU2gzDKnMOuINMr6ipM4RlkTeOyNOfMkXMKDyP0aADvvIMp8RzE6UJ5t6Evtt0w7nS2+GG8992hM22QfVlXtVvVVQ/KIkS/8Ba/UqHBEjPndWwZJ7UzP79whKSVNg3CgMimnjzAqnU9SZxU5SASLU8VvVyOWihSwcLUZ/fGS8HFunBB/hX/840FvkHcDtADkZrqx+SgqSRfdfInnsqmNtIuFNf11TmORG55MW9ZYpxMYiLoOrTvEDF/mPi8QKKj0dXQBFTzQuNN9UkZ9woe3YDq7DgB29GL0r8foLyqYpaMR7CqjrOjR4x3XHiuV1fx/ztFjzcLWQygLYvoN5bxXGGxE8DN2HZ8BgMOV69IhvAnRFFGzR1QhTSTp6tbvsbn02hspF0HRPTKy7yZ0uq4scaOUqmLIDTt1PTAnBfaY5iiZmv8FlGlMp81Xa7XCjA8TLKK4EnTbnH/HmRrWELsb2GORJpA1P0JtNPz+owxbyBYUyGIIHis1Unq9Ug67gMlgIRUF9JVQ6JHUqnr+8Vrfydb+OHOWrZGgFjP9G6Q1gljw9g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8536.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(396003)(376002)(346002)(366004)(39850400004)(451199018)(83380400001)(31686004)(2616005)(8936002)(6506007)(5660300002)(53546011)(6512007)(36756003)(2906002)(31696002)(41300700001)(26005)(86362001)(4326008)(8676002)(316002)(66476007)(66946007)(66556008)(478600001)(38100700002)(966005)(6486002)(186003)(44832011)(66899018)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anJXK3ZMTUlOcjNSeE9sVlE1UDUzZ2ZuNmlHWDNIakprM1JYajlJaWNxRVpF?=
 =?utf-8?B?bVJWU1kwTWVyY2pkd3pIdDRtSFB5VWpudUh1SFVOL1htdTF4RTB4YU9rMGk1?=
 =?utf-8?B?YUF1cnhNekxZYmVoMFZIZWR6S3dBZE5vYW1yT1YvY1A2d2VpVlVvdUdGeC82?=
 =?utf-8?B?VVNmZE1aSXlXaVZteTNVZU9OaE5mWXNkdy9Rend1cURoRHNpb0UrNlRCTEx1?=
 =?utf-8?B?TnlhUnRBejF4OTYxcG9JR1hGUE9pRVA0Nkh5RnlTWDlhc1c5eWhob1VvbWdp?=
 =?utf-8?B?bHZoV1VhRDNCUEs0NFFFWnhTa0ZWZ0trZCs5YWI0b2VOSjluZld3di9STTJv?=
 =?utf-8?B?YTNIN1orOWhGZU1yT2dqWHVRUzZkcGhBcFh3NVprNWZaQkN2dVV4L2tQYnR0?=
 =?utf-8?B?U1VHVksrMWtEblo4NzZtV1J5eHdOYVYxTnhpcE44VGZpYzRkRXR1K2Y1OTUv?=
 =?utf-8?B?SGhPTHVxem1JSmc0YldzUTdqcWsvcnV4VmkxeFFMbGVjTlIxV1JyRmZVVWgx?=
 =?utf-8?B?cFEyU1BDbE5TWmhWQkhSbW5kekNTa3loemo2QUVZeUQ5QzlPTWtoU1FtWXJj?=
 =?utf-8?B?UlcwenJHcElvUDlDU3pEdDl3bnFEOG1SUFFPSzNQWTVxb2tpL2JpNWFTRzlu?=
 =?utf-8?B?Y0UxeXJDK0VLTVluTWRwOXV2M1dCMUp6NFAwNVdOZytGQyt6c2pvZnJpQkta?=
 =?utf-8?B?cFFPSUpmb0dYTGtKSGc1Nkp0QnJLekRRNms4UDE3a2tIN3Y3QUpOYi8zejhD?=
 =?utf-8?B?Z3N1Y3FvakNucXJ1VGYzQ1JTRjRTL0g1YTlqM3JzT2huaDNZSGQwU3pmalhm?=
 =?utf-8?B?V1VoRndQTWw2Mnd4S1U4bkR1K2JOTTBuMktNeEdBWFNSMUt4NmpjR05ELzEx?=
 =?utf-8?B?U0JRUTNoYTh1eWxYZU9RN1hlWjhSZ2FyVGdFUit0aUgwTDM3N2s5eHR6RHBr?=
 =?utf-8?B?L01ZZlFVUFF4d1FGU0p2WnZMc1hrSHExME42WEtXOGdvdWZhcWtzdXV1anVo?=
 =?utf-8?B?QmFwdzRqanpjNWdpb1lmekNtdWNFZzhIbDY0Z2VXc3JGSzhMYXJtQjY1TXhD?=
 =?utf-8?B?S2prdVgzZXZ6Wk14NE9uZTJzSzJrUnRlTG1tZCtoMXYrMnZGNXNZM3VCdTlu?=
 =?utf-8?B?S0Z2UkpaQStUTWJmbjFPc2piSjAvQjU0TTRrbFJDL05SZlF6Qys3cVdEZEhp?=
 =?utf-8?B?RDVkSmM1NG03UnBjNDV3M0JRcjE5Z3dESzYwSkVTZ01xRytib3JQNUpjWjBB?=
 =?utf-8?B?bDVFekdZcGdITm5vSGZ5THFuTU1XSk5Cc3VwNGJUWmFvajZuN2RYN3E2WGZR?=
 =?utf-8?B?cWtueTR1RXN1a01kc3pjKzZ3eDFpWXJ5L29kOFpaUWNOVHYvd1dRa01ETCt5?=
 =?utf-8?B?RHh3bkl1WVMzblkzL0tXd1pyZVBXbndOTXZCTlJCZVpxWW81WTdxZUQyNHRO?=
 =?utf-8?B?VzhRbk0rRm5BemZrak1sRzh6NnNlUUhhTlNFSjczbVVybyt6aUIzb0RrNWk0?=
 =?utf-8?B?OGltcm9PK2ZmUzk3SGR0TTBkWGk5bUpZaU9hczYxbi9qV1Z3V2FNNDN6Rlly?=
 =?utf-8?B?dGc3cm9aMlFoaSt4cHVYcmZJekNMZVlJS3lSd25lSFhTSk1XWUFjdHdOdTlK?=
 =?utf-8?B?OUw5TzZoR3pMb3RMellpNWJBVGdDNWg4bUVaNmw0LytHTFF1cmh1TzZJWkV3?=
 =?utf-8?B?eWliMEl5dVFHQ3JETVdnK1hvc2ovaDM1WENzQkg4MXlIeXZpaWV4UXN6bTJM?=
 =?utf-8?B?Qkx6QklhOUZUb0EzamYvc1pKVW4rVTEvaVBzTGFpMlEycEhCV2VEOEwyWDJn?=
 =?utf-8?B?ejdxeWQ3RHFkV09TeEdXcDRkZEV4OG9ndVowV3MxYThwRjZxenNlaml4bmFj?=
 =?utf-8?B?QnpiOWorY2FiK3hrcVlwSDNYalRGR2pUb1h3WWtLbXhDc2xVVFNVNXZsMkxL?=
 =?utf-8?B?bzVJT0JZcUdHbi9GVldIQklMVGc4T1BjUk9tVTc1bFJ6VTdxRDhGdy95VDdD?=
 =?utf-8?B?N0NrcFE1d3R2akV0UlIwZnlzWnZIb0NuMTNFNFp0N1dCZ3lkeE5nVGYwdEpG?=
 =?utf-8?B?cUY4S2ZWTU9VSTJXV1VOYjhKVHZDZXlaSGFIRkR2QUQ5RGF3b1R5K0dMM2RM?=
 =?utf-8?B?M2FpTEV1U3VDQldraEp3cUs2YXlHZzhsQVQrRzdLZmpZNDgyNWNNYXdKTjhQ?=
 =?utf-8?Q?EEhts/Hz7+dswYoiIdDQx/I=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f221a06-8859-444e-2322-08db270a4040
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2023 17:08:38.7908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WYvDiLkI0r3yZGR5/fEqdwM+sSfvDDoZOZH5QbqFuEBmX5i8Rjz3c3yquAbUXO8GC/DqRl0t+yKlIwKpnF3P1oeBlheHDsPupAB/0Ud5Iub2QBd47t1v1VTrIMi+i0gZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8122
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabrice,

On 3/15/23 15:44, Fabrice Gasnier wrote:
> When in dual role mode (dr_mode == USB_DR_MODE_OTG), platform probe
> successively basically calls:
> - dwc2_gadget_init()
> - dwc2_hcd_init()
> - dwc2_lowlevel_hw_disable() since recent change [1]
> - usb_add_gadget_udc()
> 
> The PHYs (and so the clocks it may provide) shouldn't be disabled for all
> SoCs, in OTG mode, as the HCD part has been initialized.
> 
> On STM32 this creates some weird race condition upon boot, when:
> - initially attached as a device, to a HOST
> - and there is a gadget script invoked to setup the device part.
> Below issue becomes systematic, as long as the gadget script isn't
> started by userland: the hardware PHYs (and so the clocks provided by the
> PHYs) remains disabled.
> It ends up in having an endless interrupt storm, before the watchdog
> resets the platform.
> 
> [   16.924163] dwc2 49000000.usb-otg: EPs: 9, dedicated fifos, 952 entries in SPRAM
> [   16.962704] dwc2 49000000.usb-otg: DWC OTG Controller
> [   16.966488] dwc2 49000000.usb-otg: new USB bus registered, assigned bus number 2
> [   16.974051] dwc2 49000000.usb-otg: irq 77, io mem 0x49000000
> [   17.032170] hub 2-0:1.0: USB hub found
> [   17.042299] hub 2-0:1.0: 1 port detected
> [   17.175408] dwc2 49000000.usb-otg: Mode Mismatch Interrupt: currently in Host mode
> [   17.181741] dwc2 49000000.usb-otg: Mode Mismatch Interrupt: currently in Host mode
> [   17.189303] dwc2 49000000.usb-otg: Mode Mismatch Interrupt: currently in Host mode
> ...
> 
> The host part is also not functional, until the gadget part is configured.
> 
> The HW may only be disabled for peripheral mode (original init), e.g.
> dr_mode == USB_DR_MODE_PERIPHERAL, until the gadget driver initializes.
> 
> But when in USB_DR_MODE_OTG, the HW should remain enabled, as the HCD part
> is able to run, while the gadget part isn't necessarily configured.
> 
> I don't fully get the of purpose the original change, that claims disabling
> the hardware is missing. It creates conditions on SOCs using the PHY
> initialization to be completely non working in OTG mode. Original
> change [1] should be reworked to be platform specific.
> 
> [1] https://urldefense.com/v3/__https://lore.kernel.org/r/20221206-dwc2-gadget-dual-role-v1-2-36515e1092cd@theobroma-systems.com__;!!OOPJP91ZZw!gKDR7WKb_MJfqvHDitpGCxrXjMC0sSgfG7hMxQad2X2atPHRu9ePfzJhI8K1frODjhcFQYPQ7xsEs0GqPq6IDFUB4T1EJqsmRojKJrzOiA$
> 

Thanks for adding me to the recipients.

So.. basically Dual Role mode doesn't work on Theobroma Ringneck (based 
on Rockchip PX30) module, at all, without the three patches listed in 
the patch series you linked to.

Now, even with the whole patch series applied, I still get stability 
issues for dual role mode, but at least it **sometimes** works.

I applied your patch and it seems I still have support for forced HOST 
and DEVICE mode on the OTG port. Considering dual role mode is not 
stable anyway and that this patch alone doesn't seem to make things 
better/worse,

Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
Tested-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

I wish I had some access to some datasheet/technical manual or something 
but right now sinking time for Dual Role mode support is not in our top 
priority list so we'll have to live without it. However, any help is 
much welcomed.

BTW, I assume you would want to backport this to stable releases too (v6.2).

Cheers,
Quentin

> Fixes: ade23d7b7ec5 ("usb: dwc2: power on/off phy for peripheral mode in dual-role mode")
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
>   drivers/usb/dwc2/gadget.c   | 6 ++----
>   drivers/usb/dwc2/platform.c | 3 +--
>   2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
> index 62fa6378d2d7..8b15742d9e8a 100644
> --- a/drivers/usb/dwc2/gadget.c
> +++ b/drivers/usb/dwc2/gadget.c
> @@ -4549,8 +4549,7 @@ static int dwc2_hsotg_udc_start(struct usb_gadget *gadget,
>   	hsotg->gadget.dev.of_node = hsotg->dev->of_node;
>   	hsotg->gadget.speed = USB_SPEED_UNKNOWN;
>   
> -	if (hsotg->dr_mode == USB_DR_MODE_PERIPHERAL ||
> -	    (hsotg->dr_mode == USB_DR_MODE_OTG && dwc2_is_device_mode(hsotg))) {
> +	if (hsotg->dr_mode == USB_DR_MODE_PERIPHERAL) {
>   		ret = dwc2_lowlevel_hw_enable(hsotg);
>   		if (ret)
>   			goto err;
> @@ -4612,8 +4611,7 @@ static int dwc2_hsotg_udc_stop(struct usb_gadget *gadget)
>   	if (!IS_ERR_OR_NULL(hsotg->uphy))
>   		otg_set_peripheral(hsotg->uphy->otg, NULL);
>   
> -	if (hsotg->dr_mode == USB_DR_MODE_PERIPHERAL ||
> -	    (hsotg->dr_mode == USB_DR_MODE_OTG && dwc2_is_device_mode(hsotg)))
> +	if (hsotg->dr_mode == USB_DR_MODE_PERIPHERAL)
>   		dwc2_lowlevel_hw_disable(hsotg);
>   
>   	return 0;
> diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
> index 23ef75996823..262c13b6362a 100644
> --- a/drivers/usb/dwc2/platform.c
> +++ b/drivers/usb/dwc2/platform.c
> @@ -576,8 +576,7 @@ static int dwc2_driver_probe(struct platform_device *dev)
>   	dwc2_debugfs_init(hsotg);
>   
>   	/* Gadget code manages lowlevel hw on its own */
> -	if (hsotg->dr_mode == USB_DR_MODE_PERIPHERAL ||
> -	    (hsotg->dr_mode == USB_DR_MODE_OTG && dwc2_is_device_mode(hsotg)))
> +	if (hsotg->dr_mode == USB_DR_MODE_PERIPHERAL)
>   		dwc2_lowlevel_hw_disable(hsotg);
>   
>   #if IS_ENABLED(CONFIG_USB_DWC2_PERIPHERAL) || \
