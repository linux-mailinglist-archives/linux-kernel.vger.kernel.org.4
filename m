Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAAB5F64F1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 13:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbiJFLLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 07:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbiJFLLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 07:11:50 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB069C2F1;
        Thu,  6 Oct 2022 04:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665054690; x=1696590690;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=+lHjXeTPRFsDwEM2GTjfHhnOPQ/3lTCbvV4Ux6gtyNA=;
  b=LN/wbYuciK4ef34mXLyat1+4M/Afo51zeowjO8SHRTqYIaDMWXQCNWOi
   7PvFM1H4NH5r+t9nBcrPhorI3alNW5ZaKjjgIJ0Ym+gI3NjsRaduF9kYY
   HO20zoYh72PzAzJJCmfgb1W8tTxLaDn8R7W9kAK4FmYBayFrsPC8PnIsY
   8l8XBneaGLcYlOiJg9JqW7uVvL9Cqnc8E8hb0RojZLDnIn2ipCXIm5qeO
   /PuE6bYkhbasw9RJDHBojBb4yuT14XtwFLpKDLRsVUnCgh25OeO0d/OYL
   zZrm9YQrQvlb5l9AF6xDj3vhEjGtmnL6YTy+iYNn+BedON4lNhrfTjQGt
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="365353524"
X-IronPort-AV: E=Sophos;i="5.95,163,1661842800"; 
   d="scan'208";a="365353524"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 04:11:27 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="619813218"
X-IronPort-AV: E=Sophos;i="5.95,163,1661842800"; 
   d="scan'208";a="619813218"
Received: from jnikula-mobl4.fi.intel.com (HELO localhost) ([10.237.66.153])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 04:11:25 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH RFC 0/5] docs: Improvements to our HTML output
In-Reply-To: <20221004201222.281845-1-corbet@lwn.net>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20221004201222.281845-1-corbet@lwn.net>
Date:   Thu, 06 Oct 2022 14:11:23 +0300
Message-ID: <87tu4hp5pg.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 04 Oct 2022, Jonathan Corbet <corbet@lwn.net> wrote:
> For a long time we have rejoiced that our HTML output from Sphinx is far
> better than what we got from the old DocBook toolchain.  But it still
> leaves a lot to be desired; the following is an attempt to improve the
> situation somewhat.
>
> Sphinx has a theming mechanism for HTML rendering.  Since the kernel's
> adoption of Sphinx, we have been using the "Read The Docs" theme =E2=80=
=94 a choice
> made in a bit of a hurry to have *something* while figuring out the rest.
> RTD is OK, but it is not hugely attractive, requires the installation of =
an
> extra package, and does not observe all of the Sphinx configuration
> parameters.  Among other things, that makes it hard to put reasonable
> contents into the left column in the HTML output.
>
> The Alabaster theme is the default for Sphinx installations, and is bundl=
ed
> with Sphinx itself.  It has (IMO) nicer output and gives us the control
> that we need.
>
> So: switch to Alabaster.  Additional patches adjust the documentation and
> remove the RTD references from scripts/sphinx-pre-install.
>
> The final patch changes the way that kerneldoc declarations are rendered =
to
> (IMO) improve readability.  That requires some changes to kernel-doc to
> output a new container block and some CSS tweaks to improve things overal=
l.
>
> It should be noted that I have a long history of inflicting ugly web
> designs on the net; this work is a start, but I think we could do far
> better yet.  It would be great if somebody who actually enjoys working wi=
th
> CSS and such would help to improve what we have.

I admit my wish-list replies to this thread may seem a bit obnoxious,
when I'm not prepared to contribute. Sorry about that. My intention was
not to block any of this, rather muse about what the future direction
might be.

Overall I think this is an improvement.

There's only two things that I'd like to get addressed, not necessarily
now, but eventually:

- As mentioned, the main div width as pixels in the alabaster
  theme. It's really crappy on wide 4K displays. Only a quarter of the
  full screen width is used.

- The function/struct/etc. main descriptions are now displayed in the
  gray background, along with the "declaration", instead of white
  background. Is that an intenational alabaster feature, or is it
  something we do to cause that? Seems like the description gets a bit
  hidden there.


BR,
Jani.


>
> As before, I've put a copy of the rendered docs at:
>
>   https://static.lwn.net/kerneldoc/
>
> To compare the kerneldoc changes specifically, pick a page that includes a
> lot of definitions; for example:
>
>   https://static.lwn.net/kerneldoc/driver-api/media/drivers/frontends.html
>   vs.
>   https://www.kernel.org/doc/html/latest/driver-api/media/drivers/fronten=
ds.html
>
> Jonathan Corbet (5):
>   docs: Switch the default HTML theme to alabaster
>   docs: tweak some Alabaster style parameters
>   docs: update sphinx.rst to reflect the default theme change
>   docs: sphinx-pre-install: don't require the RTD theme
>   docs: improve the HTML formatting of kerneldoc comments
>
>  Documentation/conf.py                  | 27 ++++++++++++-
>  Documentation/doc-guide/sphinx.rst     | 16 +++-----
>  Documentation/sphinx-static/custom.css | 25 +++++++++++++
>  Documentation/sphinx/requirements.txt  |  1 -
>  scripts/kernel-doc                     | 52 ++++++++++++++++----------
>  scripts/sphinx-pre-install             |  8 ----
>  6 files changed, 87 insertions(+), 42 deletions(-)
>  create mode 100644 Documentation/sphinx-static/custom.css

--=20
Jani Nikula, Intel Open Source Graphics Center
