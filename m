Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B89F60542D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 01:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbiJSXoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 19:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiJSXok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 19:44:40 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81ABEC7B;
        Wed, 19 Oct 2022 16:44:35 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mt6lL01Hxz4xGQ;
        Thu, 20 Oct 2022 10:44:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1666223070;
        bh=x0RgKnz7Y9YQsYhqM2LlgOqoZFKMw57hZtvsm2Qs5D4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CqgqMTm9e5IuoYvHW46rxJatrieSd36vLWa3qLWwifdreo81G0GB45hh85rTnQdQ6
         lBp8amcXIx3MfmHns1rOimfMGl9nmECBWCb5FiLNQPWVWJ12LS1/klv21tE3BVd/AQ
         Ly1Hg6Gg0Iky1XJIe/gdtM3uSGhcpap3Z3OQ67nsGXE+MG8HEHxM8RIqlWi2rXlLzE
         j9q5IqsdMEVkwocjlbfemmPxkxnsyNkU/A+EHTJU+5KjYuHOpU/Iv3xWLXExMo5wcO
         bwjAT9RFv7Ysh2AUj2BAMeECfe93EMdAcpbnmYJdaxtH2Pc9u5g392vePjaIi5fEBK
         Kju2J8UUGh9rg==
Date:   Thu, 20 Oct 2022 04:14:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Wireless <linux-wireless@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Ilan Peer <ilan.peer@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the wireless-next tree with Linus'
 tree
Message-ID: <20221020041440.3f6c1e46@canb.auug.org.au>
In-Reply-To: <20221019162324.2baaa7e8@kernel.org>
References: <20221020032340.5cf101c0@canb.auug.org.au>
        <20221019162324.2baaa7e8@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LcIzqIFp5mJE7yx7ZDUkKaD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LcIzqIFp5mJE7yx7ZDUkKaD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Wed, 19 Oct 2022 16:23:24 -0700 Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Thu, 20 Oct 2022 03:23:40 +1100 Stephen Rothwell wrote:
> > Today's linux-next merge of the wireless-next tree got a conflict in:
> >=20
> >   net/mac80211/util.c
> >=20
> > between commit:
> >=20
> >   ff05d4b45dd8 ("wifi: mac80211: fix MBSSID parsing use-after-free")
> >=20
> > from the origin tree and commit:
> >=20
> >   ff05d4b45dd8 ("wifi: mac80211: fix MBSSID parsing use-after-free") =20

This should have been commit

  45ebac4f059b ("wifi: mac80211: Parse station profile from association res=
ponse")

> Dunno if this is a glitch or real problem. But it reminds me - I see
> there is direct wireless -> wireless-next merge without going via
> Linus's tree. I think you may have mentioned it to us, but not sure
> if I said this clearly - let's try to avoid such merges. Linus certainly
> doesn't like when we do net -> net-next merges without sending net to
> him first and forwarding. I'm not 100% sure why (maybe Steven knows)
> - whether it's an aesthetic thing or avoiding real issues thing, but
> either way it's _a_ thing :S

Has Linus really complained about you merging the net tree into the
net-next tree?  The only reason that would be a problem is if (as
happened only once that I remember) Linus rejects the net tree merge
due to some problem.  So, yes, wait until after the net (or wireless)
tree has been merged by Linus, but then there should be no reason to
not just merge the net tree (rather than Linus' tree).

--=20
Cheers,
Stephen Rothwell

--Sig_/LcIzqIFp5mJE7yx7ZDUkKaD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNQMIAACgkQAVBC80lX
0Gzt7wf/WQt+e2UMggTtfQpFWbl+CONJy5SEJPwMNg7krQCt+6IAVXollzTkAUG1
DYeklX8jFqxNC8nAAXVt/rr3YHRt5q3a80RDKpXR7qTpZ5iDLVKGGGw3j3upk1R0
nk7XDEtPqdR9jzFhxsydFpleeLwZQsmB8uTaEyoxCgLLXjh0SnyVl0mSO2IdFIHl
sUYTw2R36KySLsWBS+N46kRjFg1UtkwjQoayCjjx6+8aZsBR9FyhC+J1mTtd3LzP
3ls7PWiiyYAaTJ0kiNiokBgnYnddDlnxQm8dycOAbJJ8nNtpfqdVPHw5YJxLtzwO
ckxVC9qY1D/nhHQ8xJuXjjw6V7iclg==
=LUyp
-----END PGP SIGNATURE-----

--Sig_/LcIzqIFp5mJE7yx7ZDUkKaD--
