Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B4072C61F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 15:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235205AbjFLNgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 09:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236502AbjFLNgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 09:36:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60E21A1;
        Mon, 12 Jun 2023 06:36:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BBD4616FD;
        Mon, 12 Jun 2023 13:36:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754D0C4339C;
        Mon, 12 Jun 2023 13:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686576999;
        bh=6t8SLEGkV+2LuUffPXlHIp83vOrBIwLaJMF1fy6qrmo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=to/QjNsRYu8mIPyhEBttCfHICSEZ1ZCL7V9KhsJIIk1PmYlxawzN6TRhxdgHCuNRS
         IaJ9dbbVGsiT5zRDYoFlSOu1gEYEA2pWauiQTsZl63cO6aiejasai/piMfGX/zU87Y
         +mkSpVhhA/4a5oq9JYP/VWvt+eM/QwGxhAWlGtdVRpTiNrn3fB3/NAzLDGlsGARf8J
         RiZcOLamRWgw54EVGUNqaJkykkbgEgqrzJusreiKQtd7NMbRJ41KWhKPzEHKgL8TIQ
         SZrGMEFaOSn2iQwbMZGjENGbl2XLZ6V+GIFEw3ZIxG7ALqU2PjELYWbBdCJZg3854P
         55/IpyjwitbQw==
Date:   Mon, 12 Jun 2023 14:36:33 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Patrick Lai <quic_plai@quicinc.com>
Subject: Re: [PATCH v2 2/2] ASoC: codecs: wsa884x: Add WSA884x family of
 speakers
Message-ID: <bf81773c-8d9d-46bc-b9ba-db7b86600e3d@sirena.org.uk>
References: <20230611102657.74714-1-krzysztof.kozlowski@linaro.org>
 <20230611102657.74714-2-krzysztof.kozlowski@linaro.org>
 <191859d3-42e3-4ef2-87ff-dd56864103f9@sirena.org.uk>
 <421ddd6d-3938-027c-2099-57248a111831@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4W2AYxZZZ8GOZJ6I"
Content-Disposition: inline
In-Reply-To: <421ddd6d-3938-027c-2099-57248a111831@linaro.org>
X-Cookie: If it heals good, say it.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4W2AYxZZZ8GOZJ6I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 12, 2023 at 09:25:44AM +0200, Krzysztof Kozlowski wrote:
> On 11/06/2023 13:57, Mark Brown wrote:
> > On Sun, Jun 11, 2023 at 12:26:57PM +0200, Krzysztof Kozlowski wrote:

> >> +	{ WSA884X_OTP_REG_40,			0x00 },
> >> +	{ WSA884X_OTP_REG_41,			0x00 },
> >> +	{ WSA884X_OTP_REG_63,			0x40 },

> > These appear to be OTP data which suggests that they shouldn't have
> > defaults either since they can be programmed.

> Just to be clear - I don't have access to datasheet so I don't know what
> are these. The downstream driver actually initializes (writes to) two
> OTP registers - 38 and 40.

That's...  counterintuitive given the naming.

> >> +static bool wsa884x_readonly_register(struct device *dev, unsigned int reg)
> >> +{
> >> +	switch (reg) {

> > In general the read only registers probably shouldn't have defaults...

> For the case when regmap is being read before device enumerates (thus
> synced)?

If you're reading read only registers from the cache defaults like that
you may as well cut out the middle man and not bother parsing the
register at all - the value is just hard coded.  Either power up the
device to find out what the values are or use the values directly.

> >> +	/* Speaker mode by default */
> >> +	{ WSA884X_DRE_CTL_0, 0x7 << WSA884X_DRE_CTL_0_PROG_DELAY_SHIFT },
> >> +	{ WSA884X_CLSH_CTL_0, (0x37 & ~WSA884X_CLSH_CTL_0_DLY_CODE_MASK) |
> >> +			      (0x6 << WSA884X_CLSH_CTL_0_DLY_CODE_SHIFT) },
> >> +	{ WSA884X_CLSH_SOFT_MAX, 0xff },

> > Why not just leave as the chip default?

> Sincerely, I don't know. Without any documentation, I am relying
> entirely on downstream driver which has some code like this. I don't
> know whether some parts here make sense only for downstream case or
> shall be applicable also for upstream.

This sounds like someone hard coding their use case TBH.

--4W2AYxZZZ8GOZJ6I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSHH2AACgkQJNaLcl1U
h9CaPwf/aX9WQEFcA6zXSh74pvL2X9EgjCIw0+zTNqo4m9a4OWMHcrlXGqKsi7pm
b/kdJ53Asst3GGbTO+2V6+P3WctJRkxgrZRIswHYUfJVuZRwol07nq2v1T+2qu4l
zPPqa9TNf7WOFJpm4xTEAD12CZsGeNUo8WSCoCR7qotMmqwUA2ZIqp7HsOzHfr2N
C/zvaFTnotbGn73s+oZE6wqtQWF8GGXCu5wMcqGvGMHoxgU6MXcwwRFT3xXz0TkD
j4fy8QoU7907ARX0cy6fMJEQtiZjrg41DJxkIY3GPGDJAS7YUdnI85/44YHga9EC
ePr9Kxof5jGBxa7rDk0NVSwFtNFbyA==
=AnsO
-----END PGP SIGNATURE-----

--4W2AYxZZZ8GOZJ6I--
