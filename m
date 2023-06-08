Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F5672788B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbjFHHRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbjFHHRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:17:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96CA9E;
        Thu,  8 Jun 2023 00:17:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 466FB60C50;
        Thu,  8 Jun 2023 07:17:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26DEEC433EF;
        Thu,  8 Jun 2023 07:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686208649;
        bh=DgNy7Z0KKn8MMOgxNGldNvVHSpHtF7LqXA6FiWXacwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KS66tAZlXQrUKAebbEfqLOkWE5Pz7Q2p9tPKdNpc1SniYL0900czyqPb2TaiYL7Ye
         DEwwMeIHAFnTj3cuw0BHO6UhjnLImLhIn2eACfmDVwIugq4cLOt2rL4KNLPyATWDs4
         T241J5sSwtzNEssZf8WdI7orYGadgjn/4DOibGpQoAnMl2tdxT1niTSxkyln1UeY52
         vRl3eimY0u7D4eKKGd+Sh78Dd1OujFDZsoLARWFlVlw1+PYKmz9FF/UGSEfz5TkjTh
         bC2AboPTkpyqXTixmVaorks6BN2QLX7MmtpaHyVSW+LV0jcCIpXqR7elwdjGHU6pKz
         O9NmFP7cxLMTQ==
Date:   Thu, 8 Jun 2023 09:17:26 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        linux-kernel@vger.kernel.org, hsinyi@google.com,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        yangcong5@huaqin.corp-partner.google.com,
        linux-arm-msm@vger.kernel.org,
        Chris Morgan <macroalpha82@gmail.com>
Subject: Re: [PATCH v2 00/10] drm/panel and i2c-hid: Allow panels and
 touchscreens to power sequence together
Message-ID: <jehxiy3z4aieop5qgzmlon4u76n7gvt3kc6knxhb5yqkiz3rsp@mx27m75sx43r>
References: <20230607215224.2067679-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dfmbtdcuvmsnsbt5"
Content-Disposition: inline
In-Reply-To: <20230607215224.2067679-1-dianders@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dfmbtdcuvmsnsbt5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Douglas,

On Wed, Jun 07, 2023 at 02:49:22PM -0700, Douglas Anderson wrote:
>=20
> The big motivation for this patch series is mostly described in the patch
> ("drm/panel: Add a way for other devices to follow panel state"), but to
> quickly summarize here: for touchscreens that are connected to a panel we
> need the ability to power sequence the two device together. This is not a
> new need, but so far we've managed to get by through a combination of
> inefficiency, added costs, or perhaps just a little bit of brokenness.
> It's time to do better. This patch series allows us to do better.
>=20
> Assuming that people think this patch series looks OK, we'll have to
> figure out the right way to land it. The panel patches and i2c-hid
> patches will go through very different trees and so either we'll need
> an Ack from one side or the other or someone to create a tag for the
> other tree to pull in. This will _probably_ require the true drm-misc
> maintainers to get involved, not a lowly committer. ;-)
>=20
> Version 2 of this patch series doesn't change too much. At a high level:
> * I added all the forgotten "static" to functions.
> * I've hopefully made the bindings better.
> * I've integrated into fw_devlink.
> * I cleaned up a few descriptions / comments.
>=20
> This still needs someone to say that the idea looks OK or to suggest
> an alternative that solves the problems. ;-)

Thanks for working on this.

I haven't seen in any of your commit messages how the panels were
actually "packaged" together?

Do a panel model typically come together with the i2c-hid support, or is
it added at manufacture time?

If it's the latter, it's indeed a fairly loose connection and we need
your work.

If it's the former though and we don't expect a given panel reference to
always (or never) come with a touchscreen attached, I guess we can have
something much simpler with a bunch of helpers that would register a
i2c-hid device and would be called by the panel driver itself.

And then, since everything is self-contained managing the power state
becomes easier as well.

Maxime

--dfmbtdcuvmsnsbt5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZIGAhgAKCRDj7w1vZxhR
xXYWAP9FSFylcQPn7fz6xgDKld7G4GeHoOUOkRIHq74ilGrD7QEA/4Zn/Rzcqgwa
aYb2ySZimrrn0J5IOURj78PWDxWA7QY=
=aUVL
-----END PGP SIGNATURE-----

--dfmbtdcuvmsnsbt5--
