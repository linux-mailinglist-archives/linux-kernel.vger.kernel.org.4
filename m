Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E4D7220CF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 10:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjFEITH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 04:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjFEITF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 04:19:05 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57126A9;
        Mon,  5 Jun 2023 01:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=KubJxH4hHn+hbxhkRtiPesgcbwDHTIqMMOrkNxFfH1E=;
        t=1685953143; x=1687162743; b=pyEhq2QG0FePUqaQGbC7yp2AdpfYcVDkYjRxPOUdY5FC50P
        SBqwzkgCerym621cSzFmJe1qznUf9w5Dzzg26UFT3JiFQJjFmM6L42VHQwMbUjnJ2xyPbwMaz7FT7
        HXo3dhpgQ2+/Z/+AZTD1vJgl28YGPYjyQ0Vmi0Ty8zAKfES65oKD1FaQ4u3KFzy88WCybLdAsOm/o
        Puy02TXWrSnEtLtM++DI2wrzu3RyMJ9twq7i47MJNuWsFcTRkU/Jwj1RRVAIGpc32BCHtQwSFNwUQ
        VGLr2pFWGIXOM0h8Rv2elBfQCItakm1XcnlzScO4YETAdzV8iVEJw8mbHYSaA03g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q65Qa-00ELtr-2S;
        Mon, 05 Jun 2023 10:19:00 +0200
Message-ID: <70071209bfa07b38df576c59341b935b9b95ae28.camel@sipsolutions.net>
Subject: Re: [PATCH 1/2] kernel-doc: don't let V=1 change outcome
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org
Date:   Mon, 05 Jun 2023 10:18:59 +0200
In-Reply-To: <CAK7LNAQ87U202fgqkd5T9G82h4F6sNOMW2=vH1HmgAoVA48CMw@mail.gmail.com>
References: <20230602230014.a435aab03cee.I21ab3b54eeebd638676bead3b2f87417944e44f3@changeid>
         <CAK7LNAQ87U202fgqkd5T9G82h4F6sNOMW2=vH1HmgAoVA48CMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.2 (3.48.2-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-06-05 at 09:36 +0900, Masahiro Yamada wrote:

> > +if (defined($ENV{'KDOC_WRETURN'})) {
> > +       $Wreturn =3D "$ENV{'KDOC_WRETURN'}";
> > +}
> > +
> > +if (defined($ENV{'KDOC_WSHORT_DESC'})) {
> > +       $Wshort_desc =3D "$ENV{'KDOC_WSHORT_DESC'}";
> > +}
> > +
> > +if (defined($ENV{'KDOC_WCONTENTS_BEFORE_SECTION'})) {
> > +       $Wcontents_before_sections =3D "$ENV{'KDOC_WCONTENTS_BEFORE_SEC=
TION'}";
> > +}
> > +
> > +if (defined($ENV{'KDOC_WALL'})) {
> > +       $Wreturn =3D "$ENV{'KDOC_WALL'}";
> > +       $Wshort_desc =3D "$ENV{'KDOC_WALL'}";
> > +       $Wcontents_before_sections =3D "$ENV{'KDOC_WALL'}";
> > +}
>=20
>=20
>=20
> Adding an environment variable to each of them is tedious.

Agree. And adding one for -Wall is especially tedious because you have
to spell out the list of affected warnings in two places :)

> If you enable -Wall via the command line option,
> these lines are unneeded?
>=20
> For example,
>=20
> ifneq ($(KBUILD_EXTRA_WARN),)
>   cmd_checkdoc =3D $(srctree)/scripts/kernel-doc -none \
>          $(if $(findstring 2, $(KBUILD_EXTRA_WARN)), -Wall) $<
> endif
>=20

Yes, that should be possible.

I feel like maybe we should still have individual settings for the three
different classes, because you might want to have -Wshort-desc without
the extra -Wcontents-before-sections (which I thought about removing
entirely, kernel-doc seems to parse just fine that way, what's the point
of it?)

But we could even move the env var handling _completely_ to the Makefile
if you don't mind, and then we don't have to have two places in the
script that need to be aligned all the time.

johannes
