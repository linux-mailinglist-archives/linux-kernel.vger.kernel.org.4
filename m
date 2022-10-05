Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED1A5F5BA9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 23:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbiJEVYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 17:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiJEVYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 17:24:00 -0400
Received: from resqmta-c1p-024061.sys.comcast.net (resqmta-c1p-024061.sys.comcast.net [IPv6:2001:558:fd00:56::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC1B816B2
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 14:23:57 -0700 (PDT)
Received: from resomta-c1p-023411.sys.comcast.net ([96.102.18.231])
        by resqmta-c1p-024061.sys.comcast.net with ESMTP
        id g8x5oTWNWovHsgBrxoPuHt; Wed, 05 Oct 2022 21:23:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20211018a; t=1665005037;
        bh=6nswR+3d/gnwoaF8K8U30+q9DQCaCZojzetu+lImvbk=;
        h=Received:Received:Received:Date:From:To:Subject:Message-ID:
         MIME-Version:Content-Type;
        b=MRvNNV90DHMgWz6rL6ZmC7gjlnU4ZShmGi8KfzDiRTVzD5vyNEXbwQgEi5C+r1u+x
         QQqhjSQswHaSCq7GGVafFMxkj/8DH19vL/LhGRbn2LAtN6+s6mIWf4T1nLKH49zaFz
         +HRRSoS/V3cVxzc8lx5MO3xOcs7qHQlK6GxpmYwPI4ntqljRs4g74gKNB15DOIOWyq
         XnzJLGhmG6krLTxcJ+k+H2fhLUkQSeafKQLvJth+uWdU/bpJIUsUdwDC02JMQcYTnV
         KsRmNcPVL9fQD52hdPKJyhVTnjm9CK00+61YtOUHUyL7nfr1uAu4MJbAdxCXOxrqb+
         T3gbWgSO15+gA==
Received: from Outgoing.brak ([69.249.67.241])
        by resomta-c1p-023411.sys.comcast.net with ESMTPSA
        id gBrZoG0Iq563TgBrZo9LmJ; Wed, 05 Oct 2022 21:23:35 +0000
X-Xfinity-VAAS: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeifedgudehlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucevohhmtggrshhtqdftvghsihdpqfgfvfdppffquffrtefokffrnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfghrlhcuvffnffculddvfedmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgruhhlucffihhnohculfhonhgvshcuoehprghulhesshhprggtvghfrhgvrghkudekrdighiiiqeenucggtffrrghtthgvrhhnpeffieeijedvffekteevtdehffeffeetvdehfeehkeehieevtedthfeuveeugefgveenucffohhmrghinhepghhithhhuhgsrdgtohhmpdifihhnvghhqhdrohhrghenucfkphepieelrddvgeelrdeijedrvdegudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopefquhhtghhoihhnghdrsghrrghkpdhinhgvthepieelrddvgeelrdeijedrvdeguddpmhgrihhlfhhrohhmpehprghulhesshhprggtvghfrhgvrghkudekrdighiiipdhnsggprhgtphhtthhopeehpdhrtghpthhtoheprghnshhsihdrhhgrnhhnuhhlrgesihhkihdrfhhipdhrtghpthhtohepjhhikhhosheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqihhnphhuthesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnh
 gvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhushgssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-Xfinity-VMeta: sc=-77.00;st=legit
Received: from localhost.localdomain (unknown [172.18.18.119])
        by Outgoing.brak (Postfix) with ESMTPSA id EE639B38E564;
        Wed,  5 Oct 2022 21:23:32 +0000 (UTC)
Date:   Wed, 5 Oct 2022 21:30:21 +0000
From:   Paul Dino Jones <paul@spacefreak18.xyz>
To:     Anssi Hannula <anssi.hannula@iki.fi>
Cc:     jikos@kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] usbhid: Interpret 0 length ff effects as infinite
 (0xffff) length effects
Message-ID: <20221005213021.adhxibb5ipbrjdnn@localhost.localdomain>
References: <20221001221657.gexisc2egjn3mpog@localhost.localdomain>
 <93f708f3f9ac8b5c94e6d0b86c1efaa3@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93f708f3f9ac8b5c94e6d0b86c1efaa3@iki.fi>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FROM_SUSPICIOUS_NTLD,SPF_HELO_PASS,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, and thank you for considering this.

Yes, Wine 7 breaks a lot of stuff for me, and I've been using Wine 5.x
and 6.x through Proton which isn't ideal when trying to isolate
problems.

It seems there is atleast some precedence in other force feedback
drivers for using 0 as some sort of indicator for an infinite effect:

https://github.com/gotzl/hid-fanatecff/blob/next/hid-ftecff.c#L724

https://github.com/berarma/new-lg4ff/blob/master/hid-lg4ff.c#L762

We also discussed this issue at this thread:

https://github.com/berarma/ffbtools/issues/26

I've also read some indication that the SimCube wheel works on Linux, so
I'd be interested in how that is handling this situation.

---
Paul Dino Jones


> Paul Dino Jones kirjoitti 2022-10-02 01:16:
> > Greetings,
> 
> Hello, and thanks for looking into this!
> 
> > I started using my Accuforce V2 sim wheel on Linux. I was getting no
> > response from racing simulators through wine, while native linux test
> > tools worked properly. It appears that many real-world applications will
> > send 0 as the replay length, which was resulting in the behavior I was
> > observing (nothing). The PID document does not explicitly state that 0
> > length effects should be interpreted as infinite, but it does mention
> > null effects being infinite effects.
> 
> Actually, it is Wine that is translating 0xFFFF from the application to
> 0x0000 for the Linux FF API:
> https://gitlab.winehq.org/wine/wine/-/blob/master/dlls/winebus.sys/bus_udev.c#L1124
> 
> Unfortunately "infinite" duration is not actually specified at all in our
> API currently.
> input.h just says that the all durations are in msecs and values above
> 0x7fff cause unspecified results.
> 
> We have three places where the duration is handled:
> - ff-memless: Considers 0 as infinite (in ml_get_combo_effect() and
> calculate_next_time()).
> - iforce-ff: Just passes the duration to HW as-is - it is unknown what
> counts as infinite, if any.
> - pidff: Just passes the duration to HW as-is, so using the
> unspecified-by-API 0xffff results in infinite duration (per USB HID PID
> spec).
> 
> So we probably want to specify some value to work as infinite, likely either
> 0 or 0xFFFF, and explicitly document that in input.h.
> I suspect that ff-memless devices are currently the most popular, and e.g.
> Wine already assumes 0 is infinite, and I can't think of a reason to have an
> "actual" 0-duration effect, so I guess 0 would be the most sensible value.
> 
> Since iforce is an "ancestor" of HID PID of sorts, it may also support
> 0xffff = infinite.
> I'll try to get hold of one to test, though it may take a couple of weeks...
> 
> 
> > This patch will interpret 0 length force feedback effects as 0xffff
> > (infinite) length effects, leaving other values for replay length
> > unchanged.
> > 
> > Signed-off-by: Paul Dino Jones <paul@spacefreak18.xyz>
> > ---
> >  drivers/hid/usbhid/hid-pidff.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hid/usbhid/hid-pidff.c
> > b/drivers/hid/usbhid/hid-pidff.c
> > index 3b4ee21cd811..70653451c860 100644
> > --- a/drivers/hid/usbhid/hid-pidff.c
> > +++ b/drivers/hid/usbhid/hid-pidff.c
> > @@ -301,7 +301,7 @@ static void pidff_set_effect_report(struct
> > pidff_device *pidff,
> >  		pidff->block_load[PID_EFFECT_BLOCK_INDEX].value[0];
> >  	pidff->set_effect_type->value[0] =
> >  		pidff->create_new_effect_type->value[0];
> > -	pidff->set_effect[PID_DURATION].value[0] = effect->replay.length;
> > +	pidff->set_effect[PID_DURATION].value[0] = effect->replay.length ==
> > 0 ? 0xffff : effect->replay.length;
> >  	pidff->set_effect[PID_TRIGGER_BUTTON].value[0] =
> > effect->trigger.button;
> >  	pidff->set_effect[PID_TRIGGER_REPEAT_INT].value[0] =
> >  		effect->trigger.interval;
> 
> -- 
> Anssi Hannula
> 
