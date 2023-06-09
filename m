Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4F372937C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239120AbjFIInI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:43:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241052AbjFIImr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:42:47 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E540B1BD3;
        Fri,  9 Jun 2023 01:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=XD9OkuqOMsNTdtH8ubJ6y9hV2Du3mkBOHolDgReSNN4=;
        t=1686300166; x=1687509766; b=nVIuZiOlZucVrHZ+tc3TICiIHKUAUy2Esi9vKnD9Y11kBVx
        qysRcVw5XfsNGSOdsIf3oLqAOCzVxdvyiBpyb6m0tiJOmZrGH2mWpOEH0TQnjhRZh/jl1wb5jaSO2
        LSYH4FS7W8koTyzqpSA4uNp10GX/N/NUBHNfgE0gVAcy+43aTxnP5HIbh9TSFObf0ruS25Lunemhk
        0WzJNLkqV+D73GgPRoVjJII3YmnckXsVYcSb2k2y0hpX9d9sIANkM7KqHwW4XT/iDyuwTyduRl8a+
        MebfGJ6dWshuk+rO87w2/baudp0uiFyUPGy1HRCwOaUSepqDa3V3KtNXPNbEVtnQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q7Xhk-000sTj-0B;
        Fri, 09 Jun 2023 10:42:44 +0200
Message-ID: <4d93871f8b87c9d1e384f52619fe14433c5bc6a0.camel@sipsolutions.net>
Subject: Re: [PATCH v2 1/2] kernel-doc: don't let V=1 change outcome
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Date:   Fri, 09 Jun 2023 10:42:42 +0200
In-Reply-To: <CAK7LNAROju1ob-5VKEsu_UOfCNoMRE-QU27JE3Ndh-M7pBraSw@mail.gmail.com>
References: <20230606105706.60807b85ff79.I21ab3b54eeebd638676bead3b2f87417944e44f3@changeid>
         <CAK7LNASe+HWuufyANGJJ0dajzSC4LFy=x2N6erGis0+ZQkAAXA@mail.gmail.com>
         <2017a6dba12cc7cd05aec33e8066cb7038a89a31.camel@sipsolutions.net>
         <CAK7LNAROju1ob-5VKEsu_UOfCNoMRE-QU27JE3Ndh-M7pBraSw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-06-08 at 08:51 +0900, Masahiro Yamada wrote:
> >=20
> > > cmd_checkdoc =3D $(srctree)/scripts/kernel-doc -none \
> > >               $(KDOCFLAGS)
> > >=20
> > >=20
> > > Then, users can do
> > >=20
> > >   $ make KDOCFLAGS=3D-Wall
> > >   $ make KDOCFLAGS=3D-Wreturn
> >=20
> > I'd rather call it KDOC_FLAGS if you don't mind to align with
> > KDOC_WERROR which we have already, but sure, can do.
>=20
>=20
> I just tried to be consistent with
> CPPFLAGS, CFLAGS, AFLAGS, CHECKFLAGS etc.
> (CHECKFLAGS is for sparse) because
> you apparently mimick compiler flags in kernel-doc.


OK, sure, works for me. I made it mimic compiler flags because it was
already doing it for -Werror :)

> BTW, kernel-doc is invoked from Documentation/Makefile too.
>=20
> Do we need to pass the same flags to both of them?

It doesn't look like we _can_ in that case, at least not from the build
system, it'd have to be in kerneldoc.py or something. I also didn't
think it was that important, so I left it.

johannes
