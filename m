Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08525725AE2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 11:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239434AbjFGJn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 05:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237218AbjFGJnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:43:23 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D491EB;
        Wed,  7 Jun 2023 02:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=971JyQHlSoBOmn1o9U++qoGOP5XyVYimVV+hx5poVjw=;
        t=1686131002; x=1687340602; b=sbwNqqmlSY4aC0Yx0q1VP1bCxLNFINI++hY3QSG/joeKvx/
        tsLrY4pT4LK6GnfIVqqCOLYjFclcV25qBGMZKlgSYjnELdxVYK+6SmclpX+MnVGAcTgh/gpsfz0vB
        q8qfF2SBFRUwKHzG0USG7IfHrOVBMRaJs6PXIk5srZZoUJ5k8oXcKom7ML/ww/HZj9wVv7zi1P/3y
        2Z2JdKMVnDTUgpcf1TwnQDhxPM3zQa9gSId0iK1vpZClGzva3jJdUaujOlyds0wv50YSI7d9lb46e
        U/3S5mJroTQh9IM7GRn0FYmITri9bclhXv7DOuzaB4pUJM5hPtivWVM7euq/mY7w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q6phB-00GVI0-02;
        Wed, 07 Jun 2023 11:43:13 +0200
Message-ID: <4b1c8af737eb5bccba12883f32ec43f9f292f70f.camel@sipsolutions.net>
Subject: Re: Reported-by/Closes tag for uncommitted issues (was: Re: [PATCH
 v2] uml: Replace strlcpy with strscpy)
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Philip Li <philip.li@intel.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Eric Biggers <ebiggers@kernel.org>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Maxim Krasnyansky <maxk@qti.qualcomm.com>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        linux-hardening <linux-hardening@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        kernel test robot <lkp@intel.com>
Date:   Wed, 07 Jun 2023 11:43:11 +0200
In-Reply-To: <ZIBQWytL3zhWFLgd@rli9-mobl>
References: <20230606182410.3976487-1-azeemshaikh38@gmail.com>
         <1833651082.3690424.1686084717406.JavaMail.zimbra@nod.at>
         <CADmuW3WzC61-si1j61kzwfx5EcsvSt4QBaY9VHiybBRWAN3yyA@mail.gmail.com>
         <20230607042340.GA941@sol.localdomain>
         <57443d420183b7a0bcab8041c2dfe3ba44e054f4.camel@sipsolutions.net>
         <2092891129.3692555.1686126895090.JavaMail.zimbra@nod.at>
         <ZIBJadzmheKWCErq@rli9-mobl>
         <a953b19efca20b470759b1d53beb957a11062ba1.camel@sipsolutions.net>
         <ZIBQWytL3zhWFLgd@rli9-mobl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.2 (3.48.2-1.fc38) 
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

On Wed, 2023-06-07 at 17:39 +0800, Philip Li wrote:
>=20
> Is that ok we just take this phrase as a quick improvement for first step=
, which
> is
>=20
> "If you fix the issue in a separate patch/commit (i.e. not just a new
> version of the same patch/commit), kindly add following tags:"
>=20
> This could help remind for most cases if not all. Also this allows us
> not doing "complex" judgement by the bot itself.

Sure, feel free. But yeah, that was the idea, that the decision logic
wouldn't really need to be in the bot, that feels very difficult.

Maybe someone else on the thread will have a better suggestion :)


johannes
