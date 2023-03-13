Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B8D6B7B43
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjCMO5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjCMO5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:57:21 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA85074322;
        Mon, 13 Mar 2023 07:56:37 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 28B473200950;
        Mon, 13 Mar 2023 10:55:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 13 Mar 2023 10:55:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1678719344; x=1678805744; bh=/9rmj+X4kyyPjr1ToYiOfSGGJWOhFJxQ0AY
        AN3zcuF8=; b=Z30vp8pjhtPsUTh33yZDWWjEYIhgMJUC5fCJaHRS8bFVH9NS6V9
        KdxSCrOIUhl/9uj6XvBmcckbpQN0aspwOq02Y+c4rjyBKwTmWIhH9Ewxq8s7FLI0
        gAREDAhhvzxzJ6hp5JHuP22GF6FjpmkXt3g32Nt7A2h90qSrne0O2XqbVn3NOhlF
        gEUlUfk8VIJNP7SgnJAVwdL2jXhlZETQ5LZ2mOA1T73OAAzBEASaJ5YZ9pDZK7Ho
        fJS9IKna98iCWl2AEMr57BWrpzYBGTzKm8b8GJrDyEfi+e/tfIalyGjjunVfy1Yf
        V+Ozg5t9dhNeeFJPCifFvKYyeUoHSOiLCxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1678719344; x=1678805744; bh=/9rmj+X4kyyPj
        r1ToYiOfSGGJWOhFJxQ0AYAN3zcuF8=; b=cByl0WwZ2OV5bDnoA+JbcKRUnnVrD
        op7gLDuT2Kpr+3Cfm9s+0DTWVP3YRcJT5cmQ/nIqHjTUhf0jaULqpTC9/CapU/49
        IwfLKuIcUO0+hwfQBKIY9GOBYw1np9SolAtD6/RzOOPe6QlMUni8ANhJ8UbArRnG
        pFd/YMwstcXqrHHCbrZpc2N+145vgdgpriPzeGlCfQJYIyljfuZIfmKfXNAXB/HJ
        P0V5fqYarVzLcMIopXolnTG4njSLl+OBQa/MaigjygUu12VVBrqFCtxcRyJGcl/L
        MFqmmXxqA9ocI4oLwjoucjgsDyBC8hY+LGxq8/4hqoCYgvpmoEgBZEcBQ==
X-ME-Sender: <xms:cDkPZIVTpz9LyD43duvsMoLfpjFgVwI17N57732HCGfStqiQ3XYLxQ>
    <xme:cDkPZMkp2gsQ_29YKFQk8EXfQOXJ59AwXn8rZBNQ0BVeRDyBAr7DdWt12jt4jmq8z
    qI0fUlB83huzFo>
X-ME-Received: <xmr:cDkPZMa4GtitvxSfxhgIyDXcMz7r1gN9UHmOpxF99Ul2Gu1BrU97b-nqZ4rmYOZdmiYsTJsJ-lyViyfLi2RFEbAS0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddvgedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffggfuvfevfhfhjggtsehgtderredttdejnecuhfhrohhmpefuihhmohhn
    ucfirghishgvrhcuoehsihhmohhnsehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtg
    homheqnecuggftrfgrthhtvghrnhepfedtfeduledtvefhheekfefhuedthfffudegteff
    vdfgheefkefhteegvdeugffgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsihhmohhnsehi
    nhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomh
X-ME-Proxy: <xmx:cDkPZHX8zVT1hFDBk1Qfjm_RL-w_crwcZJgqk2OU4Y1zPyJexKgESA>
    <xmx:cDkPZClgpZoDZzPjaLaEfyaY3F3rdmkCy3ytHR8bj9lsessDAotcRg>
    <xmx:cDkPZMdjgSFI0IcGaoe8B32qTBV_OSgXDftKmgK6qjlY5OzCXKydhQ>
    <xmx:cDkPZGtBmiEw8MBcn821x5PaVFv0fXQLa4WJ4PG7nwJzU-_haGBqtA>
Feedback-ID: idc5945a3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Mar 2023 10:55:42 -0400 (EDT)
Message-ID: <dd9d2291-8452-0f9e-d7b1-cef14c6c667f@invisiblethingslab.com>
Date:   Mon, 13 Mar 2023 15:56:10 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] ACPI: s2idle: Don't ignore error when enabling wakeup IRQ
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230313125344.2893-1-simon@invisiblethingslab.com>
 <CAJZ5v0jahjt58nP6P5+xRdtD_ndYPvq4ecMVz6nfGu9tf5iaUw@mail.gmail.com>
Content-Language: en-US
From:   Simon Gaiser <simon@invisiblethingslab.com>
In-Reply-To: <CAJZ5v0jahjt58nP6P5+xRdtD_ndYPvq4ecMVz6nfGu9tf5iaUw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------N09i4IsF07IhZeoawzn9TkNo"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------N09i4IsF07IhZeoawzn9TkNo
Content-Type: multipart/mixed; boundary="------------eYSF43eSJSkFS83Zjm0T0Q8d";
 protected-headers="v1"
From: Simon Gaiser <simon@invisiblethingslab.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <dd9d2291-8452-0f9e-d7b1-cef14c6c667f@invisiblethingslab.com>
Subject: Re: [PATCH] ACPI: s2idle: Don't ignore error when enabling wakeup IRQ
References: <20230313125344.2893-1-simon@invisiblethingslab.com>
 <CAJZ5v0jahjt58nP6P5+xRdtD_ndYPvq4ecMVz6nfGu9tf5iaUw@mail.gmail.com>
In-Reply-To: <CAJZ5v0jahjt58nP6P5+xRdtD_ndYPvq4ecMVz6nfGu9tf5iaUw@mail.gmail.com>

--------------eYSF43eSJSkFS83Zjm0T0Q8d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Rafael J. Wysocki:
> On Mon, Mar 13, 2023 at 1:54=E2=80=AFPM Simon Gaiser
> <simon@invisiblethingslab.com> wrote:
>>
>> enable_irq_wake() can fail. Previously acpi_s2idle_prepare() silently
>> ignored it's return code, potentially leaving a system that never
>> wakes up.
>>
>> Discovered when trying to go into s2idle under Xen. This leads to a
>> system that can't be woken, since xen-pirq currently doesn't support
>> setting wakeup IRQs. Real s2idle support for Xen is another topic,
>> but now at least the user gets an error and the system doesn't needs
>> an hard reset.
>>
>> Signed-off-by: Simon Gaiser <simon@invisiblethingslab.com>
>> ---
>>
>> Note that I'm unfamiliar with the code so when reviewing please
>> carefully check if ignoring the error was indeed unintended.
>=20
> No, it wasn't.
>=20
> First, in the majority of cases in which ACPI SCI is used, the IRQ
> chip in question has IRQCHIP_SKIP_SET_WAKE set, so enable_irq_wake()
> cannot fail for it.
>=20
> Second, even if it could fail, it is preferred to let the system
> suspend anyway, as long as there is at least one other wakeup source
> in it and that is the case as a rule (for example, wakeup is enabled
> for the PS/2 keyboard IRQ for all systems that have it).
>=20
>> If there are indeed cases where the error should be ignored I would
>> submit a patch that at least logs the error, although the error
>> message would be hard to see with broken wakeup.
>=20
> Logging an error would be fine, but failing suspend may not be.  Of
> course, suspend should be aborted if there are no other usable (and
> enabled) wakeup sources, but currently there's no infrastructure for
> verifying that.

Ah, ok, that's a bit unfortunate. Anyway sent a v2 that only logs. That
way it should at least make debugging for someone else that runs into
such a case a bit easier.

https://lore.kernel.org/linux-acpi/20230313144710.3516-1-simon@invisiblet=
hingslab.com/

--------------eYSF43eSJSkFS83Zjm0T0Q8d--

--------------N09i4IsF07IhZeoawzn9TkNo
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE3E8ezGzG3N1CTQ//kO9xfO/xly8FAmQPOYwACgkQkO9xfO/x
ly9jlRAAjheJOjaRxkimwJT/iKwkr4L8vS2/aViD/b6meODbO3HE7hLtf2jff4sh
aUxwZXalP30Py7XGj0txkRKe4bGvNtUi3vHkVuB3bE2Ld9aJj277RrOeLsTvSUO2
cxob/dhnacbSOrNFrEzT76UmXMdpPJdN7wlZH9m4ZgvURA+rfrNoQDgenmHkfYj+
WnhHBsX6wRjVEtLE3Vo4zwqcOj6ghVAEEC5YkLpmDbV2ay4JgDkoAe9N7E8s1SvS
5/OU43orb2gw/tyDHJVWGtjV/aNyMcwz7IswULHTFQuwVHeYDwgyd2Mdsf8y5kTU
n84+8sfoiOmtIYR481EW5nqAmvlQuBwCEYrG8eojMmQ3uR8t677b8Gzi5fw+MPXy
Q01R7DrxMVvo98l+K1LrTnV1o+Jac/qzP3cHR+eJad7Jy7UpyMrpZ4vd0Y1W3lsK
6DdCqlpnk8Xp/IifE/6I3KzkWMbZq0oZ35OKL3aXUXJueTXPyTGHt//HMVangMZU
RcpnMkm2bh0sUvqbwK+7Gf686PvtefedsbhpE1Fft8xlJVIxLDZIvhOOF5oVVMnD
8xRyL8n7cDYZUkk6TUecNapeeoeDPDIYEcyIvhKAA67cBe1hgdzMGelxO7hLGshk
j83aiKGVuCLzB0+p8CsxrS91iKqXBpUXqnJMm4YrE4/t6BIi0XE=
=pbfw
-----END PGP SIGNATURE-----

--------------N09i4IsF07IhZeoawzn9TkNo--
