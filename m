Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1DC6CFD92
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 10:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjC3IAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 04:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjC3IAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 04:00:47 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883E1127;
        Thu, 30 Mar 2023 01:00:45 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D9E1F5C01C1;
        Thu, 30 Mar 2023 04:00:43 -0400 (EDT)
Received: from imap43 ([10.202.2.93])
  by compute5.internal (MEProxy); Thu, 30 Mar 2023 04:00:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1680163243; x=1680249643; bh=miY9XyNh6oe35/JBBRarPPFbT
        LrQ+KkGBi44hdf6Vzg=; b=V4JasLOL+O5VArviO0siM2lQZENanQosNf9dIIhcD
        qMUZP5eHK6EDeOPEsr7b77tyo70SHkOnGcx9NfHbmIZBys0kSVdq2ALJd+r4H/AO
        uynpcFEtVivwn9fep3vG2pGfgfhtXE1cwgz9XGDq5F9ByibuUTkRXhxL5Qr5hNAb
        LG58SK2A8dO15HXd++OJBJfKBYKhansKZGC6THfqhVHebHAM2iJMfqAmdz11Qsoa
        UAj48HC9kFukEpvzT6CC74FgoJRnXZ3uUlpia9ZKJSOFIB7wkG8QQtE/Ppls6OcX
        JNbCSkqjPFDjQkwPnii5MCFEMpVEwcqVtAr3RxrL78NSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680163243; x=1680249643; bh=miY9XyNh6oe35/JBBRarPPFbTLrQ+KkGBi4
        4hdf6Vzg=; b=vFb2DkeRSMlZt3A083opEe0mN18huCHYAKPIkTTsF2vt3ncTqO+
        96eYNivKGr0whK2/Q2SwSsPtTqLfDiDcMUdHK4VblriwXatexg0z2Y+RXpWGc21w
        hM89a5IuTvQXWSKKEb2EoVISQnTBp+HmK9A5RcarmCLr+aV6X7TAiqo+1euTTJwi
        cjtMVkIwezJ/7wmbqPbQQORHMAYqgN5wqYf8LptCWV42lz9DvoYRm7/3jH77AjgR
        VkwunUZtaSeKzlPmFQWcBADjDXu1wUHiP8Zv0fQOuuGc68XNld8P93T/31ZjBdvr
        NGz+qL3kmVoUui4/jY0M3RI6BDX1dgAmfVQ==
X-ME-Sender: <xms:q0ElZKazTNJcMORVHMUU9FEgS9V41WGe5OJb9C16cAorAYdsPk2JUg>
    <xme:q0ElZNa9DU2JQt7AKosMpqvGJrVfDUevj2T395wr5EUayimCqh0NI1tn6dDInfSFQ
    WojFH_xQxUPBceF9I8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdehjedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpeet
    lhhishhtrghirhcuoegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhmvgeqnecugg
    ftrfgrthhtvghrnhephfegveetjedvveevvdekveehuedvjeduhfffgfdvhfegueethfef
    tdeuudelfedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghlihhsthgrihhrsegrlhhishhtrghirhdvfedrmhgv
X-ME-Proxy: <xmx:q0ElZE9wELSmbx3177o8YUFXsE97PfrobYe6CntpN7ko_6E4O2xQ6w>
    <xmx:q0ElZMo3nr-DR2y_BU3bQxkZY9DpG00kFO6Q5f1wT6x_i5AouLyuOA>
    <xmx:q0ElZFoB-ZLR17cD4XOdn41_iaoYyG4CDaeiuBs4Sd3vPDI2iwcP6w>
    <xmx:q0ElZOA-ZJg-yK-7CzO9gcjl2oSHmGhoo5BqwdVDJjmttS5ncXII3A>
Feedback-ID: ifd214418:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9DBAE2D40090; Thu, 30 Mar 2023 04:00:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-238-g746678b8b6-fm-20230329.001-g746678b8
Mime-Version: 1.0
Message-Id: <004cfeda-1c40-4fce-b5d5-1ecc02a8909a@app.fastmail.com>
In-Reply-To: <CACRpkdZSJCZZEkD0V_wint+a1XKsbCQFuArFvPdFP8RSDsGLMQ@mail.gmail.com>
References: <0dcc1aac-9a6a-4d17-be68-a895cb6120da@app.fastmail.com>
 <CACRpkdZSJCZZEkD0V_wint+a1XKsbCQFuArFvPdFP8RSDsGLMQ@mail.gmail.com>
Date:   Thu, 30 Mar 2023 18:00:43 +1000
From:   Alistair <alistair@alistair23.me>
To:     "Linus Walleij" <linus.walleij@linaro.org>
Cc:     ye.xingchen@zte.com.cn,
        "Sebastian Reichel" <sebastian.reichel@collabora.com>,
        sre@kernel.org, pali@kernel.org, sravanhome@gmail.com,
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

On Thu, 30 Mar 2023, at 12:43 AM, Linus Walleij wrote:
> On Wed, Mar 29, 2023 at 1:16=E2=80=AFPM Alistair <alistair@alistair23.=
me> wrote:
>=20
> > [    2.466136]  string from vsnprintf+0x158/0x424
> > [    2.470603]  vsnprintf from vscnprintf+0x10/0x24
> > [    2.475241]  vscnprintf from sysfs_emit+0x50/0xac
> > [    2.479975]  sysfs_emit from power_supply_show_property+0x1d0/0x2=
6c
> > [    2.486269]  power_supply_show_property from add_prop_uevent+0x30=
/0x8c
> > [    2.492815]  add_prop_uevent from power_supply_uevent+0xb4/0xe4
> > [    2.498753]  power_supply_uevent from dev_uevent+0xc4/0x21c
> > [    2.504352]  dev_uevent from kobject_uevent_env+0x1cc/0x510
> > [    2.509953]  kobject_uevent_env from power_supply_changed_work+0x=
7c/0xb4
> > [    2.516675]  power_supply_changed_work from process_one_work+0x1e=
8/0x3e8
> > [    2.523396]  process_one_work from worker_thread+0x2c/0x504
> > [    2.528986]  worker_thread from kthread+0xcc/0xec
> > [    2.533716]  kthread from ret_from_fork+0x14/0x24
> > [    2.538443] Exception stack(0xf0dadfb0 to 0xf0dadff8)
>=20
> This looks like running a worker before something this worker is acces=
sing
> has been set up.
>=20
> > As it's on a consumer device I don't have a way to connect a debugge=
r. So I'm
> > a little stuck on what the problem is. The only related change I see=
 between
> > 6.2 and 6.3-rc4 is commit a441f3b90a340e5c94df36c33fb7000193ee0aa7
> > "power: supply: use sysfs_emit() instead of sprintf() for sysfs show=
()", but
> > that doesn't look like it would cause this oops.
>=20
> Did you try reverting it?

I did after I sent this. Reverting the commit doesn't fix the issue.

Alistair

>=20
> Yours,
> Linus Walleij
>=20
