Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681DB6CF690
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 00:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjC2Wrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 18:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjC2Wrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 18:47:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD4D10C3;
        Wed, 29 Mar 2023 15:47:39 -0700 (PDT)
Received: from mercury (unknown [185.209.196.239])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 513A36603170;
        Wed, 29 Mar 2023 23:47:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680130058;
        bh=GlKdC9Vyz/FZyEE9Yl5UDhAdLZpTF5B1FyIJmbb/pKc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ceUCbbVSvDwE3eakCvEsLwfxmXkLU3nNSUBRF4Y/Uia+HfB+A+0YFfuwfrkPQO4/d
         szdElL7MtJ2lMHb5+aLbEQeVb5YQqFu0vyiMrZqOhe7XIADYMEzyKq1eJYbXX3uHv5
         Jx7pXFp437rkTKfCB31YpIDwb84sm9Io79m+9HT4MCsrZg5O6k+B1gx+9hfsDJceJE
         TEt2PtP8SnI4CEh2k843ui3hF703oye54WOoAjqVOyDHiv7ytLzyySqkNWR1aVNmsc
         2uldq2549jhRG7baycnOxCEKIl7oshZWNeaTAP4D9Yrjvcx+ZVrckxgzfQobm6kX7u
         e4P8Z6kzTL1TA==
Received: by mercury (Postfix, from userid 1000)
        id 67C701062665; Thu, 30 Mar 2023 00:47:36 +0200 (CEST)
Date:   Thu, 30 Mar 2023 00:47:36 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Alistair <alistair@alistair23.me>, ye.xingchen@zte.com.cn,
        pali@kernel.org, sravanhome@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: power_supply_show_property Kernel Oops
Message-ID: <20230329224736.qzidpkzkdth2lvuq@mercury.elektranox.org>
References: <0dcc1aac-9a6a-4d17-be68-a895cb6120da@app.fastmail.com>
 <CACRpkdZSJCZZEkD0V_wint+a1XKsbCQFuArFvPdFP8RSDsGLMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qzkccpmqhu6ctnn7"
Content-Disposition: inline
In-Reply-To: <CACRpkdZSJCZZEkD0V_wint+a1XKsbCQFuArFvPdFP8RSDsGLMQ@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qzkccpmqhu6ctnn7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 29, 2023 at 04:43:19PM +0200, Linus Walleij wrote:
> On Wed, Mar 29, 2023 at 1:16=E2=80=AFPM Alistair <alistair@alistair23.me>=
 wrote:
>=20
> > [    2.466136]  string from vsnprintf+0x158/0x424
> > [    2.470603]  vsnprintf from vscnprintf+0x10/0x24
> > [    2.475241]  vscnprintf from sysfs_emit+0x50/0xac
> > [    2.479975]  sysfs_emit from power_supply_show_property+0x1d0/0x26c
> > [    2.486269]  power_supply_show_property from add_prop_uevent+0x30/0x=
8c
> > [    2.492815]  add_prop_uevent from power_supply_uevent+0xb4/0xe4
> > [    2.498753]  power_supply_uevent from dev_uevent+0xc4/0x21c
> > [    2.504352]  dev_uevent from kobject_uevent_env+0x1cc/0x510
> > [    2.509953]  kobject_uevent_env from power_supply_changed_work+0x7c/=
0xb4
> > [    2.516675]  power_supply_changed_work from process_one_work+0x1e8/0=
x3e8
> > [    2.523396]  process_one_work from worker_thread+0x2c/0x504
> > [    2.528986]  worker_thread from kthread+0xcc/0xec
> > [    2.533716]  kthread from ret_from_fork+0x14/0x24
> > [    2.538443] Exception stack(0xf0dadfb0 to 0xf0dadff8)
>=20
> This looks like running a worker before something this worker is
> accessing has been set up.
>=20
> > As it's on a consumer device I don't have a way to connect a debugger. =
So I'm
> > a little stuck on what the problem is. The only related change I see be=
tween
> > 6.2 and 6.3-rc4 is commit a441f3b90a340e5c94df36c33fb7000193ee0aa7
> > "power: supply: use sysfs_emit() instead of sprintf() for sysfs show()"=
, but
> > that doesn't look like it would cause this oops.
>=20
> Did you try reverting it?

Does not look like a race condition with a worker to me. The patch
adds a couple of properties to the power-supply in an incorrect way.
I did not look deeply, but it's at least missing an update to
power_supply_attrs. I guess you were 'lucky' that it did not crash
with v6.2.

None of the extra properties are acceptable upstream btw.:

POWER_SUPPLY_PROP_CURRENT_MAX2:
    The driver seems to use CURRENT_MAX2 for input current;
    POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT should be used for that

POWER_SUPPLY_PROP_CHARGER_MODE:
    OTG should be handled via a regulator

POWER_SUPPLY_PROP_STATUS_EX:
    Use extcon for connectors

Greetings,

-- Sebastian

--qzkccpmqhu6ctnn7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmQkv/8ACgkQ2O7X88g7
+poDug//Y4VmYx0Yo+rmeruHUGilW77ymPfnckdCSKkZrxvwZj1w5zKbOpsg3Twv
14lqZ1y18QfGyNsq77YKNjgllBAfiZ0buzzozWtvm7xYoFXU92IP6ruc4oBfRR+Q
IJLzg9BAvxFfa8f201BdbPWBoyeuJc28j48eGPzGyA2LW/Sol5nSukFuZXD8T5eD
uCdp/Hv2DDBo/jHL7Yj8c7jQWhWQasDAHZdqqDfUO4mRk2bNBODxBj5AkmnYWiOT
Kd8TnOelr+t0SsfkN8Pwp5OcwVJ60FHRcXTpuS5+1Vjijn+MAFFXgNMvYSXAAve/
QlfGJ48v163eHffjeMplwt5COKLyDFxJXskvCInS+nVsEjSneIkDf6GC640DT7qq
fu6RBTXBYYsx2b4c7AG3VGHuHp5sswQ6CJY+ApeLkqkL6PSiJjjwzuRu6R6QYFyA
qWDtua86lLYFFYk8sEaAGDwF7lVFE+1wbCtgMxso0jN1Ddfyz1tmQGCXNcFtnlTg
0I4fzTUGZSIAv6eW3cGplTr4SV3pA5PzVMStU8PhTKHWaIlXHFJoSl6AfosMQPpR
1S0ynp71ftwL2tfPswEjUCrwEBYfwiG1ByzfOF4fDhlRyz6i1mi1bLWZ+ASf6pgZ
DqAsUIDTuY6vWhiYhnCWeFUYY4BwyU324cBq5w9VbDTemL7F0q0=
=wWQb
-----END PGP SIGNATURE-----

--qzkccpmqhu6ctnn7--
