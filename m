Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA54A742F79
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 23:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbjF2VYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 17:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbjF2VYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 17:24:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768733A91;
        Thu, 29 Jun 2023 14:24:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9ABE36164F;
        Thu, 29 Jun 2023 21:23:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765C2C433C0;
        Thu, 29 Jun 2023 21:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688073839;
        bh=zOehGqKX+VYh9hnjIWi/Nq52SHkJn4rPs67np4lrfEg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZELw7XXzZnOk5RfhnLMGd5rmjCOLIlzu82UcPR/O+XEQBVHkbxAqGBQJKtlEbYzmV
         dmij9daTBQNjt+161eT2qunRcdDXVP+CuJlH1S2FE6O+dsdmNzxSbUxshFfpHtra9L
         Uz1crmAGMycMHj1gqCk2qS26QlHAOVgPeJOeIRMl8r9AfVoufbauR99Ng9vQoZqubs
         J+N5xh/KctU0tCATZdxr1yS0ZnF4YVGJs14LdTYGIpF1j7lIfR71gmeDUmsyj5EapA
         i1bW3rNQ57Fbfd+YsaVio0WBv/NVIrR81oTOpHZJAqb8wmM6jDv0/r90JFcpGk8EtO
         yPBmw2T2n9baw==
Date:   Thu, 29 Jun 2023 22:23:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Greg KH <greg@kroah.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        johan+linaro@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, ckeepax@opensource.cirrus.com,
        kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        Stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: qdsp6: q6apm: use dai link pcm id as pcm device
 number
Message-ID: <00ac35ee-b507-43ee-b596-801b76972946@sirena.org.uk>
References: <20230628092404.13927-1-srinivas.kandagatla@linaro.org>
 <c22fcc94-aa41-4ffd-bfe8-f0b9f15a76c0@sirena.org.uk>
 <2023062940-snore-brick-419b@gregkh>
 <9699a960-74b0-4064-b264-6cde06cd16fc@sirena.org.uk>
 <2023062958-thumping-ambulance-7a2f@gregkh>
 <1c1dd19e-cbc4-41fe-9e97-a07cfebdaa4b@sirena.org.uk>
 <2023062905-tiring-bauble-84ef@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lwINwq5DE62imWCd"
Content-Disposition: inline
In-Reply-To: <2023062905-tiring-bauble-84ef@gregkh>
X-Cookie: Surprise due today.  Also the rent.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lwINwq5DE62imWCd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 29, 2023 at 08:48:42PM +0200, Greg KH wrote:
> On Thu, Jun 29, 2023 at 06:38:38PM +0100, Mark Brown wrote:

> > As discussed before your tolerance for risk in stable is *far* higher
> > than mine, if there's any value in doing this at all it's probably
> > within what would get taken but that doesn't mean that it's something
> > that it's sensible to highlight as an important fix like tagging for
> > stable does.  It's extremely unclear that it fits the severity criteria
> > that are supposed to be being applied to stable, though obviously the
> > documentation doesn't fit the actual practice these days.

> It's not a matter of "tolerance for risk", it's a "if this change is
> good enough for future releases, why isn't it good enough for older
> releases as well?"

> As you know, we don't break user interfaces, so either this is a break
> or it isn't, stable trees have nothing to do with it as a normal user
> would "hit" this when updating to run Linus's tree, just as easily as
> they would "hit" it updating their stable kernel version.

You know as well as I do that we have a bunch of interfaces where things
end up getting dynamically numbered as they appear, and provided to
userspace together with identifying information that allows userspace to
figure out what's what in a stable fashion even though the numbers might
change.  Like I said earlier in the thread this is one of them, better
hardware support also has some risk of disturbing things (and some of
the numbering is going to be hotplug dependent, though this patch isn't
likely to run into that particular bit of things).

ABI stability is a continuum, from for example things relying on race
conditions or other timing things that were lucky they ever worked to
changes in interfaces that break clear and documented guarantees.
Reliance on stability is similar, and how much of an issue it is when
something does change and someone notices is going to vary depending on
what changed and why.  While the risk here seems low if the reasoning is
just to make things neater then it's even harder to justify for a stable
kernel than it is for mainline.

Note also that the patch is still under discussion for mainline...

--lwINwq5DE62imWCd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSd9mgACgkQJNaLcl1U
h9AXXwf9EFiOfs5GMkyWdupiHCqH36l3Y4SpOl/P9yNdpyTD2WLSl6757Is4Qp40
fj/P/IN4C+yrSVsiAzviATS3iuHY1iwGc7ScLAyCiPezQjut/W8Wrrqm/bKBUVZ1
jg2piqSGRhiHUW3srfU5oVZ1xRuL4phpD/mLHJzYghgCkS/qUPGuDcillURKktN0
xeI2VFey0BHH4o/KHz/5d9mDrj97JmIGfqf7tTTlaSlG6p+UnpPGbPuPTX/oy+3m
Oi0of1cmCvNP3moP1v0LZFHxZt9Mlo86w+erg9/PyYUT7wq5K+J9n3WmZjHgp/g8
CxokZyuSOyFBktGFiou7KL49zgPM+Q==
=72ZD
-----END PGP SIGNATURE-----

--lwINwq5DE62imWCd--
