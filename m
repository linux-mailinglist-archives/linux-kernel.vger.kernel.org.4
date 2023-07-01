Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A14744AF9
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 21:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjGATug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 15:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjGATuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 15:50:35 -0400
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DE2126;
        Sat,  1 Jul 2023 12:50:33 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.west.internal (Postfix) with ESMTP id 878362B001A6;
        Sat,  1 Jul 2023 15:50:28 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Sat, 01 Jul 2023 15:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1688241028; x=1688248228; bh=6d
        Cnl4ZTF8uORmf2fPXyceI7W8KdAWxXDE+eMKfbdsc=; b=EuPIMujiOgmweN5zQ4
        crII5t37NrRYoCFwz4GJsEYoKiAGWvT1g++SGSNqLDkEvTtMQCLftzB8zZ8iQiEc
        Tp5RvpBkZVIjB6ZZMeS2qCXCefqV/aROpQrh4BuXQc6n3voGGct0P2d82XfxnWTT
        u8cf5F91Wxo0ikIcjH1/1W5Uqbx+8XjJxGoiGNCze7gotZsEzFbEonoJzoSuckrv
        LRKn1bA5FFZoEXdHvrz/Y2FUUZrOStJaCDVjW/Txr+rC68+RuEeQ96UfhGdrotKX
        z7qKHmoP9u+3xMUWEJYm3WP2rXZ23NaID4aUT93u8cG2KtkeDF6bLTbDqJJHv4h4
        W1Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1688241028; x=1688248228; bh=6dCnl4ZTF8uOR
        mf2fPXyceI7W8KdAWxXDE+eMKfbdsc=; b=lNLk9ZpKQ9qyqC/7+FaBoP8KOZ8C4
        6Z2C8ka1Gru6VrqNUvo3gCUmuiWqCB56jEFH68ZHGbgd4Swlgqcv7cs32C1zodJg
        p9bBET9HQU/spwrIENIcD9bmgxUk6e8vKyJIWFgosVtsOd+UltkPnYSqNlTM3v/c
        HPoDxRKvGSJxxGnOVf0UilsmgfTdN/Q9r9cWB8w0SkMqMWRzxtI4SGP4ZYZYk5xU
        zxUeAjF8UR1DBQuDGAqGsfYep05Ip8VFE+rM0LXKOYh0nTovu2Z37cfTQoSYdAHC
        hUn57cMYqgDTjpRn0AttzGJzKbXbAFi6MWmZ4U8GMLwRBPZU9nPI2Z4Og==
X-ME-Sender: <xms:goOgZI2UG6wH86x7mQuPgLfnF-OPVD97GEllQ3wFbgXHtcAd6tjjtQ>
    <xme:goOgZDEKJ4-GWsl1Cdr8huqVPa1g6taEVaQdJGdK1ZC6enqFdV3p1yajz1FcO_db5
    ldb8GWA9gOJHuXyknM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrtdekgddufeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:goOgZA61U-H1IUVUUERsQrRuoc3g_kUE4nCZpeoONghOGzme-gLV8A>
    <xmx:goOgZB0XGncFROqierv-5lhHrE1kH7xt7utf33Cv70ZgQGBSZvtjOw>
    <xmx:goOgZLGp39fIVlyHgl3l2ILPbCxyxF_SN2lwX_vZs478_DtWnAfqcA>
    <xmx:hIOgZJ9k9iVSIXXK-_Bxysyn0-cEbs86ejTx0hSHiMnGhQWEKcrXtYLJZUc>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 68FE3B60086; Sat,  1 Jul 2023 15:50:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-499-gf27bbf33e2-fm-20230619.001-gf27bbf33
Mime-Version: 1.0
Message-Id: <956bbdce-c766-4fba-9a71-3d6a388b258b@app.fastmail.com>
In-Reply-To: <d231d0fe-c5f5-073a-3b8c-9441e1674c24@suse.de>
References: <20230629225113.297512-1-javierm@redhat.com>
 <d231d0fe-c5f5-073a-3b8c-9441e1674c24@suse.de>
Date:   Sat, 01 Jul 2023 21:49:56 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Javier Martinez Canillas" <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "Dave Airlie" <airlied@gmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, "Helge Deller" <deller@gmx.de>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        "Maxime Ripard" <mripard@kernel.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Sam Ravnborg" <sam@ravnborg.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH 0/2] Allow disabling all native fbdev drivers and only keeping DRM
 emulation
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023, at 13:19, Thomas Zimmermann wrote:
> Am 30.06.23 um 00:51 schrieb Javier Martinez Canillas:
>> This patch series splits the fbdev core support in two different Kconfig
>> symbols: FB and FB_CORE. The motivation for this is to allow CONFIG_FB to
>> be disabled, while still having the the core fbdev support needed for the
>> CONFIG_DRM_FBDEV_EMULATION to be enabled. The motivation is automatically
>> disabling all fbdev drivers instead of having to be disabled individually.
>> 
>> The reason for doing this is that now with simpledrm, there's no need for
>> the legacy fbdev (e.g: efifb or vesafb) drivers anymore and many distros
>> now disable them. But it would simplify the config a lot fo have a single
>> Kconfig symbol to disable all fbdev drivers.
>
> I still don't get the point of this change. We've disabled the fbdev 
> drivers once. And they are off now and remain off.
>
> The patchset now introduces FB_CORE, which just adds more options. But 
> you're not reducing the code or compile time or any thing similar.
>
> I'd like to suggest a change to these patches: rather then making FB and 
> DRM_FBDEV_EMULATION depend on FB_CORE, make them select FB_CORE. That 
> will allow the DRM subsystem to enable framebuffer emulation 
> independently from framebuffer devices. If either has been set, the 
> fbdev core will be selected.

I agree with making FB_CORE a hidden option that gets selected by FB
and DRM_FBDEV_EMULATION, without that we will get a whole lot of new
build regressions for people that don't update their defconfigs,
like we had when we removed the 'select FB' in DRM.

Aside from that, the changes look very useful to me.

      Arnd
