Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032AA6CFD95
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 10:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjC3IBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 04:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjC3IAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 04:00:47 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8857218F;
        Thu, 30 Mar 2023 01:00:45 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 771605C01D8;
        Thu, 30 Mar 2023 04:00:42 -0400 (EDT)
Received: from imap43 ([10.202.2.93])
  by compute5.internal (MEProxy); Thu, 30 Mar 2023 04:00:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1680163242; x=1680249642; bh=cEgPEEQ4kN26ix6pExSumSO0g
        nk7kWVfo0bEea0dNxg=; b=eADNOUhhAz5X6FgGl9I1Fnk83j04G8z/wKNtkaLW/
        DZK5zyXVga7nVQiqmcUwDWupypYuAOj5vD1JEFwpG3mzMm7v3vbeUs8HOL85WTxz
        /cgCJ+seVu84H/hXGhPs1Vzql2qXDM6V9o0RF9ceU7WVqNybkZ6w2mnucDr4M16K
        PcthPHkpmFhg7kaXvYyxRrXw2/W2IvKO+gh/Pzz1aqA6sGtJc+s0P270x0M0Ba4q
        B7nyfnlrSO2I3Q9Q7PKM4bRz5ES57x4dT9NZ77K0XXtJpiyCVagxO3hI4fDOWwZt
        Rzpkc+jF5SYlyx3V3kjI3KreXaRO2OBNjLLfLlzklcZoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680163242; x=1680249642; bh=cEgPEEQ4kN26ix6pExSumSO0gnk7kWVfo0b
        Eea0dNxg=; b=af7CjvCuzTZn3w7tGfhH3m7ySj2TEb9+zAWCU0kAML1oMGv+7fL
        kcNVQXBHLZBPwnq1/BmlVLqGwmd4R8siPOO60ko7jziqp1Vjz9skYinM9ViJ7OXQ
        DPKoEu2wsL9x7qvCeCEJpWjjhzy80bJ4eTB9WMc7t0uwcrm12abWCoqwSC4iE+1z
        f4QgTyMDc6XSsddSpOfQHdurgYAWKLL9xykv5JY7KoyCegwBrwY/QykB7Jx35ORC
        7Mc9Brvn3nQXFm6ww9BOTdhWSugbmNBll5QXAHHZMETeBb0WqpyrUmZRlaWUB5m8
        ukNXbLMnMSVuqGjoJYbNvWt83Rqb+qCU4EQ==
X-ME-Sender: <xms:qUElZANc9Su93DqM73QR5lOc5ZJlcFppjYbfwu-K0llA_dIh3pVvEw>
    <xme:qUElZG_73NzPd1MS8EOot0a5K11TC7S17Oahs2rTZlgM9zCncY1_sul2qXYv2YTVs
    vhL1lQkZzwQViK-VVI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehjedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpeet
    lhhishhtrghirhcuoegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvgeqnecugg
    ftrfgrthhtvghrnhepheeiveffhfduieeitdfffeeiiefgledtvdejtefgieekjeeugfff
    ueejveeiieffnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhs
    thgrihhrvdefrdhmvg
X-ME-Proxy: <xmx:qUElZHQgsZfbU9BQr7Jct7obqOzSDY1BqWkJ4XKLGMacEcfhZ_SsLw>
    <xmx:qUElZIt1ZoFtWLQQPlf0D8RuCnzhUkevtOf3PbyU23ecFpADwZbnzQ>
    <xmx:qUElZIeyokiIO4NalbjGwUlmGOQ-IjdVdrd6RrZQH9PBP2-9kLOIfw>
    <xmx:qkElZH7lp0SMzsAZtWOSNrGoOdh4tLFFXYIPS7BEPtqnpXSKfLsNpw>
Feedback-ID: ifd214418:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 643F42D40090; Thu, 30 Mar 2023 04:00:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-238-g746678b8b6-fm-20230329.001-g746678b8
Mime-Version: 1.0
Message-Id: <3cd2ef19-f902-4493-ad90-00c410aca176@app.fastmail.com>
In-Reply-To: <20230329224736.qzidpkzkdth2lvuq@mercury.elektranox.org>
References: <0dcc1aac-9a6a-4d17-be68-a895cb6120da@app.fastmail.com>
 <CACRpkdZSJCZZEkD0V_wint+a1XKsbCQFuArFvPdFP8RSDsGLMQ@mail.gmail.com>
 <20230329224736.qzidpkzkdth2lvuq@mercury.elektranox.org>
Date:   Thu, 30 Mar 2023 18:00:41 +1000
From:   Alistair <alistair@alistair23.me>
To:     "Sebastian Reichel" <sebastian.reichel@collabora.com>,
        "Linus Walleij" <linus.walleij@linaro.org>
Cc:     ye.xingchen@zte.com.cn, pali@kernel.org, sravanhome@gmail.com,
        linux-pm@vger.kernel.org,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: power_supply_show_property Kernel Oops
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2023, at 8:47 AM, Sebastian Reichel wrote:
> Hi,
>=20
> On Wed, Mar 29, 2023 at 04:43:19PM +0200, Linus Walleij wrote:
> > On Wed, Mar 29, 2023 at 1:16=E2=80=AFPM Alistair <alistair@alistair2=
3.me> wrote:
> >=20
> > > [    2.466136]  string from vsnprintf+0x158/0x424
> > > [    2.470603]  vsnprintf from vscnprintf+0x10/0x24
> > > [    2.475241]  vscnprintf from sysfs_emit+0x50/0xac
> > > [    2.479975]  sysfs_emit from power_supply_show_property+0x1d0/0=
x26c
> > > [    2.486269]  power_supply_show_property from add_prop_uevent+0x=
30/0x8c
> > > [    2.492815]  add_prop_uevent from power_supply_uevent+0xb4/0xe4
> > > [    2.498753]  power_supply_uevent from dev_uevent+0xc4/0x21c
> > > [    2.504352]  dev_uevent from kobject_uevent_env+0x1cc/0x510
> > > [    2.509953]  kobject_uevent_env from power_supply_changed_work+=
0x7c/0xb4
> > > [    2.516675]  power_supply_changed_work from process_one_work+0x=
1e8/0x3e8
> > > [    2.523396]  process_one_work from worker_thread+0x2c/0x504
> > > [    2.528986]  worker_thread from kthread+0xcc/0xec
> > > [    2.533716]  kthread from ret_from_fork+0x14/0x24
> > > [    2.538443] Exception stack(0xf0dadfb0 to 0xf0dadff8)
> >=20
> > This looks like running a worker before something this worker is
> > accessing has been set up.
> >=20
> > > As it's on a consumer device I don't have a way to connect a debug=
ger. So I'm
> > > a little stuck on what the problem is. The only related change I s=
ee between
> > > 6.2 and 6.3-rc4 is commit a441f3b90a340e5c94df36c33fb7000193ee0aa7
> > > "power: supply: use sysfs_emit() instead of sprintf() for sysfs sh=
ow()", but
> > > that doesn't look like it would cause this oops.
> >=20
> > Did you try reverting it?
>=20
> Does not look like a race condition with a worker to me. The patch
> adds a couple of properties to the power-supply in an incorrect way.

Thanks for that.

It appears that these two drivers cause the problem:

https://github.com/alistair23/linux/blob/rM2-mainline/drivers/power/supp=
ly/max77818-charger.c
https://github.com/alistair23/linux/blob/rM2-mainline/drivers/regulator/=
max77818-regulator.c=20

as removing those two fixes the oops.

> I did not look deeply, but it's at least missing an update to
> power_supply_attrs. I guess you were 'lucky' that it did not crash
> with v6.2.

Do you mind pointing to an example that does this correctly? I don't see
anything obviously wrong compared to the in-tree max* drivers.

Anything to help point me in the right direction would be greatly
appreciated :)

>=20
> None of the extra properties are acceptable upstream btw.:
>=20
> POWER_SUPPLY_PROP_CURRENT_MAX2:
>     The driver seems to use CURRENT_MAX2 for input current;
>     POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT should be used for that
>=20
> POWER_SUPPLY_PROP_CHARGER_MODE:
>     OTG should be handled via a regulator
>=20
> POWER_SUPPLY_PROP_STATUS_EX:
>     Use extcon for connectors

Thanks! I figured as much. These are just taken from the vendor tree, I =
need to
clean everything up for upstreaming. I just wanted to have a working bas=
e point
to start.

>=20
> Greetings,
>=20
> -- Sebastian
>=20
>=20
> *Attachments:*
>  =E2=80=A2 signature.asc
