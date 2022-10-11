Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A825FBBC6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 22:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiJKUFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 16:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiJKUFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 16:05:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38ECD1A059;
        Tue, 11 Oct 2022 13:05:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBBAA612A4;
        Tue, 11 Oct 2022 20:04:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC19C433D6;
        Tue, 11 Oct 2022 20:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665518699;
        bh=lZdtachIj4SguIU4KUmVCxArIO0ITnyfMOz4z/5Eny0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IYv2c9d6TcE9C3a4xz9PSlRD0zfOfnmldeIy5rtOweO9txr0oGX5SFHP0EtZlMOx9
         xIHZbRP/UuTOb2YwS3lEeo6eLnGMSJG3PKtHwgqhxqHN6y9NsdoHca55T8QXpDRJi3
         IxGzWMhj5MCFy+tNfngaVly00+KtnBgE2AxdSLDBO0IzzS1tr8010H8EucEx8U0scq
         4cV7eRXgItc96nGFaxthH6NjkdmdgRWWqsHTVdNF/JLsmbIBPT/0UQXoH6guv9a9jW
         E+VuONuaozpsmwKlAATrKUIuJLmmH3Ljcm44y8b9B1u9HJTJa+7fvJRt+BnI5pexQV
         1wI4zGT2bYtRA==
Date:   Tue, 11 Oct 2022 21:04:50 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v2 0/6] docs: Improvements to our HTML output
Message-ID: <20221011210450.6eb13ec6@sal.lan>
In-Reply-To: <20221011190047.749145-1-corbet@lwn.net>
References: <20221011190047.749145-1-corbet@lwn.net>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 11 Oct 2022 13:00:41 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> For a long time we have rejoiced that our HTML output from Sphinx is far
> better than what we got from the old DocBook toolchain.  But it still
> leaves a lot to be desired; the following is an attempt to improve the
> situation somewhat.
>=20
> Sphinx has a theming mechanism for HTML rendering.  Since the kernel's
> adoption of Sphinx, we have been using the "Read The Docs" theme =E2=80=
=94 a choice
> made in a bit of a hurry to have *something* while figuring out the rest.
> RTD is OK, but it is not hugely attractive, requires the installation of =
an
> extra package, and does not observe all of the Sphinx configuration
> parameters.  Among other things, that makes it hard to put reasonable
> contents into the left column in the HTML output.
>=20
> The Alabaster theme is the default for Sphinx installations, and is bundl=
ed
> with Sphinx itself.  It has (IMO) nicer output and gives us the control
> that we need.
>=20
> So: switch to Alabaster.  Additional patches adjust the documentation and
> remove the RTD references from scripts/sphinx-pre-install.
>=20
> The penultimate patch changes the way that kerneldoc declarations are
> rendered to (IMO) improve readability.  That requires some changes to
> kernel-doc to output a new container block and some CSS tweaks to improve
> things overall.
>=20
> It should be noted that I have a long history of inflicting ugly web
> designs on the net; this work is a start, but I think we could do far
> better yet.  It would be great if somebody who actually enjoys working wi=
th
> CSS and such would help to improve what we have.
>=20
> As before, I've put a copy of the rendered docs at:
>=20
>   https://static.lwn.net/kerneldoc/
>=20
> To compare the kerneldoc changes specifically, pick a page that includes a
> lot of definitions; for example:
>=20
>   https://static.lwn.net/kerneldoc/driver-api/media/drivers/frontends.html
>   vs.
>   https://www.kernel.org/doc/html/latest/driver-api/media/drivers/fronten=
ds.html
>=20
> -------
> Changes from the initial version:
>=20
> - Tweak more alabaster style parameters, including the maximum page width.
>   There will surely be disagreement over what the right value should be,
>   but at least it's defined in units independent of screen resolution.
>=20
> - Remove "classic" theme configuration and a bunch of other conf.py cruft.
>=20
> - I've tried to answer all of the other comments, but a couple remain.  T=
he
>   sidebar contents are unchanged; making that more useful will require so=
me
>   thought and work.  The gray background on function prototypes that Jani
>   pointed out is actually something I did intentionally, with the idea of
>   making each declaration stand out better in the wall of text.  I still
>   think it's better but am not married to it if the world disagrees.
>=20
> - I've tested PDF and epub builds (no changes) and Sphinx back to v1.7.
>=20
> In the absence of objections I'll be putting this into docs-next after the
> merge window closes.  We can (and surely will) tweak this forever, but at
> least it, I hope, shows a direction in which we can go.

No objections from my side. Surely more things could be tweaked. In
particular, I didn't like having two ToCs at the index (a complete one
and a second one pointing to where we are at the docs), but that's a lot
better than before, so, I'm OK with that.

Feel free to add my ack to the patches:

Acked-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Regards,
Mauro

>=20
> Jonathan Corbet (6):
>   docs: Switch the default HTML theme to alabaster
>   docs: tweak some Alabaster style parameters
>   docs: update sphinx.rst to reflect the default theme change
>   docs: sphinx-pre-install: don't require the RTD theme
>   docs: improve the HTML formatting of kerneldoc comments
>   docs: decruft Documentation/conf.py
>=20
>  Documentation/conf.py                  | 204 ++++---------------------
>  Documentation/doc-guide/sphinx.rst     |  16 +-
>  Documentation/sphinx-static/custom.css |  28 ++++
>  Documentation/sphinx/requirements.txt  |   1 -
>  scripts/kernel-doc                     |  52 ++++---
>  scripts/sphinx-pre-install             |   8 -
>  6 files changed, 91 insertions(+), 218 deletions(-)
>  create mode 100644 Documentation/sphinx-static/custom.css
>=20
