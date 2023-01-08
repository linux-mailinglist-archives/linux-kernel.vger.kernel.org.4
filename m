Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E08661418
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 09:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbjAHIEW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 8 Jan 2023 03:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjAHIEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 03:04:20 -0500
X-Greylist: delayed 606 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 08 Jan 2023 00:04:18 PST
Received: from 17.mo561.mail-out.ovh.net (17.mo561.mail-out.ovh.net [87.98.178.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FFC12AD1
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 00:04:18 -0800 (PST)
Received: from director10.ghost.mail-out.ovh.net (unknown [10.109.138.180])
        by mo561.mail-out.ovh.net (Postfix) with ESMTP id 280C123EDF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 07:47:29 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-p7xcs (unknown [10.110.208.152])
        by director10.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 23C671FEA6;
        Sun,  8 Jan 2023 07:47:24 +0000 (UTC)
Received: from sk2.org ([37.59.142.102])
        by ghost-submission-6684bf9d7b-p7xcs with ESMTPSA
        id GxvpAgx1umMSjQcAO+84Ug
        (envelope-from <steve@sk2.org>); Sun, 08 Jan 2023 07:47:24 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-102R004f3b2dc6e-40e0-46d7-b496-fab2440419aa,
                    5128B599F7D401446F64D4771BE19AB2B9CD7A8B) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 37.167.47.239
Date:   Sun, 08 Jan 2023 08:47:21 +0100
From:   Stephen Kitt <steve@sk2.org>
To:     Sam Ravnborg <sam@ravnborg.org>
CC:     Sam Ravnborg via B4 Submission Endpoint 
        <devnull+sam.ravnborg.org@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Helge Deller <deller@gmx.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Antonino Daplas <adaplas@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>, Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-staging@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_01/15=5D_video=3A_fbdev=3A_atm?= =?US-ASCII?Q?el=5Flcdfb=3A_Rework_backlight_handling?=
User-Agent: K-9 Mail for Android
In-Reply-To: <366FC0B8-21E2-4642-A5A5-CF4B6AB046B0@sk2.org>
References: <20230107-sam-video-backlight-drop-fb_blank-v1-0-1bd9bafb351f@ravnborg.org> <20230107-sam-video-backlight-drop-fb_blank-v1-1-1bd9bafb351f@ravnborg.org> <553AE999-CAF1-4E59-9F3F-68591ED192DE@sk2.org> <Y7nb2q6SDota/rTU@ravnborg.org> <366FC0B8-21E2-4642-A5A5-CF4B6AB046B0@sk2.org>
Message-ID: <0342789A-88E6-4A3C-84DF-0F1FEB21F25C@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Ovh-Tracer-Id: 8435523578534069894
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrkeefgdduuddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevufgfjghfkfggtgfgsehtqhhmtddtreejnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeevieelieekfeelhfduffdvgfduvdegkeeljeejhfdtkeeujeeileekgeeugefhhfenucffohhmrghinheplhhkmhhlrdhorhhgpdhkvghrnhgvlhdrohhrghenucfkphepuddvjedrtddrtddruddpfeejrdehledrudegvddruddtvdenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehsthgvvhgvsehskhdvrdhorhhgqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheeiuddpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 January 2023 08:45:46 CET, Stephen Kitt <steve@sk2.org> wrote:
>On 7 January 2023 21:53:46 CET, Sam Ravnborg <sam@ravnborg.org> wrote:
>>Hi Stephen.
>>
>>On Sat, Jan 07, 2023 at 09:36:47PM +0100, Stephen Kitt wrote:
>>> On 7 January 2023 19:26:15 CET, Sam Ravnborg via B4 Submission Endpoint <devnull+sam.ravnborg.org@kernel.org> wrote:
>>> >From: Sam Ravnborg <sam@ravnborg.org>
>>> >
>>> >The atmel_lcdfb had code to save/restore power state.
>>> >This is not needed so drop it.
>>> >
>>> >Introduce backlight_is_brightness() to make logic simpler.
>>> >
>>> >Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
>>> >Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
>>> >Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
>>> >Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
>>> >Cc: linux-fbdev@vger.kernel.org
>>> >Cc: linux-arm-kernel@lists.infradead.org
>>> >---
>>> > drivers/video/fbdev/atmel_lcdfb.c | 24 +++---------------------
>>> > 1 file changed, 3 insertions(+), 21 deletions(-)
>>...
>>> 
>>> Hi Sam,
>>> 
>>> I’d submitted quite a few more of these previously (and you’d reviewed them), see e.g. the thread starting at https://lkml.org/lkml/2022/6/7/4365, and yesterday, https://lkml.org/lkml/2023/1/6/520, https://lkml.org/lkml/2023/1/6/656, https://lkml.org/lkml/2023/1/6/970, https://lkml.org/lkml/2023/1/6/643, and https://lkml.org/lkml/2023/1/6/680. There are a few more, I can find them if it’s any use.
>>
>>The patches from yesterday was what triggered me to resurrect an old
>>branch of mine where I had done something similar. I had lost all
>>memory of reviewing similar patches from you.
>>
>>
>>Helge - could you pick the reviewed patches from:
>>https://lore.kernel.org/all/20220607192335.1137249-1-steve@sk2.org/
>>[This is the same mail as Stephen refer to above - looked up via lore].
>>
>>Stephen - I expect Daniel/Lee to take care of the patches from yesterday.
>>If you can look up other pending patches from you please do so, so we
>>can have them applied.
>>Preferably with links to lore - as this makes it easier to apply them.
>>
>>Review of what is unique in this set would be appreciated.
>>
>>	Sam
>
>Hi Sam,
>
>Here are my pending patches from last June on lore:
>
>* https://lore.kernel.org/lkml/20220607190925.1134737-1-steve@sk2.org/
>* https://lore.kernel.org/lkml/20220608205623.2106113-1-steve@sk2.org/
>* https://lore.kernel.org/lkml/20220607192335.1137249-1-steve@sk2.org/
>* https://lore.kernel.org/lkml/20220616170425.1346081-1-steve@sk2.org/
>
>I’ll send reviews of your other patches later today or tomorrow.
>
>Regards,
>
>Stephen

And the auxdisplay patch, v1:

https://lore.kernel.org/lkml/20220607180406.1116277-1-steve@sk2.org/

and v2:

https://lore.kernel.org/lkml/20230106143002.1434266-1-steve@sk2.org/

Regards,

Stephen
