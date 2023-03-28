Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC276CBF5C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjC1Mki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjC1Mkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:40:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255DEAD1D;
        Tue, 28 Mar 2023 05:40:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1DAC0B81C24;
        Tue, 28 Mar 2023 12:39:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B67C433D2;
        Tue, 28 Mar 2023 12:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680007189;
        bh=nn16LIw9EpfaFwQcYGSQXqCsTKCycE7P4pZUOcy3MEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z94os27u37AHs2V+iQFwJVIyYT1Wm28MhI8Vsj+UhKMTabj0WZUDVHZ1uZQd2QAcM
         qkvCdJMw4cVw8D9LoT4Hf0VKdoQuoKyNiKONj5Z2hGOSPh0ObxZFGEQ4zD2UVdPxxC
         QT6QJlLPSO9mu+bGrX2ZQGYhHymipMt07rGSKGCr599/nvYNOUo6/7gi4V6GN6/GKb
         ynrtyX85nUAjR+1z5pQpsJ2B9wgS3GnhJMP5aL2PYfAGK9UbH5BS1WjWJpagc+S/dp
         qgttq8533Bs0h4QnlK9bKJdhdLJMb1+Amosic0f/lWa5d7iretgHtQkQtZ1EhFqNMe
         aaEAnWBP3W8Hw==
Date:   Tue, 28 Mar 2023 13:39:43 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Richard Leitner <richard.leitner@linux.dev>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ladislav Michl <ladis@linux-mips.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benjamin Bara <benjamin.bara@skidata.com>,
        Benjamin Bara <bbara93@gmail.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Richard Leitner <richard.leitner@skidata.com>
Subject: Re: [PATCH v2 0/3] Add "mclk" support for maxim,max9867
Message-ID: <55392d3d-6173-4add-9476-434c0ca1d4a5@sirena.org.uk>
References: <20230302-max9867-v2-0-fd2036d5e825@skidata.com>
 <167810953075.75807.14829875612499629879.b4-ty@kernel.org>
 <20230328055916.GA11037@g0hl1n.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/KU+3QWGeX5Ws/r4"
Content-Disposition: inline
In-Reply-To: <20230328055916.GA11037@g0hl1n.net>
X-Cookie: Oh, wow!  Look at the moon!
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/KU+3QWGeX5Ws/r4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 28, 2023 at 07:59:16AM +0200, Richard Leitner wrote:

> As Krzysztof requested some changes on the clocks property dt-bindings
> patch (#2) commit message... How should I handle this?

> The changes requested on the patch content (dts example) should be sent
> as incremental patch to the original series, I guess?

If it's just the commit message it's too late.  Otherwise incremental
patches against current git.

--/KU+3QWGeX5Ws/r4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQi4A4ACgkQJNaLcl1U
h9ALMQf+P/8cuhcsUKZkbi/0fDs7f4PbP2NnFRxf9cjyrqVri3bryJPse+80sqsp
5KRlX4Pjo/76Nx9BPt3gBCInn5aVZTsn8aGZIVOVYy7/+IoNzYTT+xdPdvlcYp6V
ChEkJOWSUINT7tLQ2VD4YVEapJB/xKGssTroBpMbh8meoPvGhwUJhleiPrpomf9F
3ChCECzZMgDFvbfkPXAR8mqkssYgWVugRbhYAY50uc8deZ0QIrqYGATNFdox+MEI
8QoKLzT78vf2pnr7q6lWDzJtlqFgBDGF16Rok9rvTYKOf9qKIZZjUJ8Ly00ozXx6
GzYgmU5F4xBJiTITtVMYThWCRQ58Ag==
=Sgms
-----END PGP SIGNATURE-----

--/KU+3QWGeX5Ws/r4--
