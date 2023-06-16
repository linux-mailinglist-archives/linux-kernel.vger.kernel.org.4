Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB6B733084
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344266AbjFPL4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344681AbjFPL4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:56:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D552D67
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 04:56:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47ED660EB0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 11:56:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67CA3C433C8;
        Fri, 16 Jun 2023 11:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686916565;
        bh=Cefq0nhQ5+KvwZkN7+opbg79I2XubmqBgE72Y6hj+rY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a0Oq79zw6rjdIS59w8GBa8hCRA6XQ22iHGti0I4SUc8HJE67VHiY+6RqYZZVx3JWP
         qqg4CFTHRtfRci/CeIlsuXGUwNetOJZ6HdlntcvnBqbBlz71poBAr7MxIISHB76wbZ
         DjTEpml4uo09DSJRX7HzUZpoBZ3IY0kQxnoGg6/jryDz1ePpLJfdIoKIU4jRpEtk4B
         LwSVT5EbqMiGPRGvlo3ykAnBWJa0a0Fm8ImLAmd5eP22N3x8z8dA9M4kv+TQ1XY3T0
         V7D5UBo56g3KqZGCBZO9i6n2TIaWIrI0obUA5ybqu4pve9gq6oMYxA3w1qFjOefKeu
         dAgPAWGAYBZrg==
Date:   Fri, 16 Jun 2023 12:56:00 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rander Wang <rander.wang@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        =?iso-8859-1?Q?P=E9ter?= Ujfalusi 
        <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Subject: Re: sound/soc/soc-pcm.c:2089:5: warning: stack frame size (2064)
 exceeds limit (2048) in 'dpcm_be_dai_trigger'
Message-ID: <caea391c-f10a-4979-92c3-75964ed7497a@sirena.org.uk>
References: <202306160240.ahGjvPqw-lkp@intel.com>
 <c5ce23fc-db87-6f11-0708-85cc4ba2a46c@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HCxw+tlxQuwCrK6z"
Content-Disposition: inline
In-Reply-To: <c5ce23fc-db87-6f11-0708-85cc4ba2a46c@linux.intel.com>
X-Cookie: P-K4
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HCxw+tlxQuwCrK6z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 16, 2023 at 12:21:13PM +0200, Pierre-Louis Bossart wrote:
> On 6/15/23 20:34, kernel test robot wrote:

> >>> sound/soc/soc-pcm.c:2089:5: warning: stack frame size (2064) exceeds limit (2048) in 'dpcm_be_dai_trigger' [-Wframe-larger-than]
> >    int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,

> Not sure what causes this warning to show up, the code hasn't changed in
> 1.2 years, nor what to do about it....

One of the sanitisers is doing things which explodes the stack size.  I
wouldn't worry about it, one of the toolchain people will probably get
to it at some point if they didn't already (sometimes these things are
done by tuning the compiler flags).

--HCxw+tlxQuwCrK6z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSMTc8ACgkQJNaLcl1U
h9A7OAf6AgtQcEPXuFb0M6xmtaQTE76Xb+GZtm13l3OadG+W1Dt9iWZ7TkgsRJsn
9SNNxVV4MNvTBDnMdaIub6laD2Z9ZVrJGl8LdzaKB9+knR8P728hF+w4XY1F20lc
WqHIRocELOJocfPAta9UrJfzPlpKjtFysCsaEzwSkDz5pYuSwqvJ2bGgVy2cVaze
Sn6jchA2BXu3D1n1+FPVvUrOFD7aLyCVJjh8eLT9rsAQDB02Ok9k3AXtfPj2BXw7
+6V25NqO/UGYYfwAFxPUNFiEkaqXh++eRwJs6rFkHTNej3GyxifySHfFGwojCXaH
JJcS9oKg3P9+3CPmYoPQtExmpmujBQ==
=9AO/
-----END PGP SIGNATURE-----

--HCxw+tlxQuwCrK6z--
