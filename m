Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6349A6C0302
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 17:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjCSQKZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 19 Mar 2023 12:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjCSQKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 12:10:22 -0400
X-Greylist: delayed 8760 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 19 Mar 2023 09:10:16 PDT
Received: from 19.mo582.mail-out.ovh.net (19.mo582.mail-out.ovh.net [188.165.56.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3DD144AC
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 09:10:15 -0700 (PDT)
Received: from director10.ghost.mail-out.ovh.net (unknown [10.109.156.39])
        by mo582.mail-out.ovh.net (Postfix) with ESMTP id 74488243F7
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 13:44:13 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-vk2nn (unknown [10.110.103.232])
        by director10.ghost.mail-out.ovh.net (Postfix) with ESMTPS id A395D1FE33;
        Sun, 19 Mar 2023 13:44:09 +0000 (UTC)
Received: from sk2.org ([37.59.142.105])
        by ghost-submission-6684bf9d7b-vk2nn with ESMTPSA
        id IxRwI6kRF2SLKQEA5A//1w
        (envelope-from <steve@sk2.org>); Sun, 19 Mar 2023 13:44:09 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-105G006adb33e03-d5be-4371-a698-f6a54d8109e0,
                    9CCC51F2D7DAB1FB7350B438D1071C8867680B66) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
Date:   Sun, 19 Mar 2023 14:44:08 +0100
From:   Stephen Kitt <steve@sk2.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Helge Deller <deller@gmx.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Antonino Daplas <adaplas@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miguel Ojeda <ojeda@kernel.org>, Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-staging@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 12/15] auxdisplay: ht16k33: Introduce
 backlight_get_brightness()
Message-ID: <20230319144408.03045c50@heffalump.sk2.org>
In-Reply-To: <2857575f6ec206f79cc21d423fde7d17@protonic.nl>
References: <20230107-sam-video-backlight-drop-fb_blank-v1-0-1bd9bafb351f@ravnborg.org>
        <20230107-sam-video-backlight-drop-fb_blank-v1-12-1bd9bafb351f@ravnborg.org>
        <CANiq72mFMJuec+r=T6xYtLpuU+a1rOrAhrHiecy_1Jpj2m4J=g@mail.gmail.com>
        <Y7qM+ZlG5gQiOW4K@ravnborg.org>
        <2857575f6ec206f79cc21d423fde7d17@protonic.nl>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Ovh-Tracer-Id: 1273674272938165894
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefiedgheejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeeludetkeehffejieetveeltddttdeftedtvdegkeffueefvefgieetvddtieehfeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvdejrddtrddtrddupdefjedrheelrddugedvrddutdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeoshhtvghvvgesshhkvddrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkedvpdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 09 Jan 2023 11:12:02 +0100, Robin van der Gracht <robin@protonic.nl>
wrote:
> On 2023-01-08 10:29, Sam Ravnborg wrote:
> > On Sat, Jan 07, 2023 at 10:02:38PM +0100, Miguel Ojeda wrote:  
> >> On Sat, Jan 7, 2023 at 7:26 PM Sam Ravnborg via B4 Submission Endpoint
> >> <devnull+sam.ravnborg.org@kernel.org> wrote:  
> >> >
> >> > Introduce backlight_get_brightness() to simplify logic
> >> > and avoid direct access to backlight properties.  
> >> 
> >> Note: Stephen sent this one too a while ago (with some more details in
> >> the commit message, which is always nice); and then he sent yesterday
> >> v2 [1] (to mention the functional change with `BL_CORE_SUSPENDED`
> >> [2]).  
> > Thanks for the pointers. I will try to move forward with Stephen's
> > patches.  
> >> 
> >> Anyway, if it goes via drm-misc, feel free to have my:
> >> 
> >>     Acked-by: Miguel Ojeda <ojeda@kernel.org>
> >> 
> >> Though it would be nice to have Robin test the change.  
> > 
> > Robin - can I get your ack to apply Stephen's original v2 patch to
> > drm-misc?  
> 
> done! see: 
> https://lore.kernel.org/lkml/0b16391f997e6ed005a326e4e48f2033@protonic.nl/

As far as I can tell, this never got applied to drm-misc, and I don’t see it
anywhere else. I guess it slipped through the cracks ;-)

Regards,

Stephen
