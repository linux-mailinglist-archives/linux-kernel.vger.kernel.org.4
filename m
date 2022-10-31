Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95331613C6E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 18:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiJaRpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 13:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiJaRpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:45:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B88FE7A;
        Mon, 31 Oct 2022 10:45:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA53361321;
        Mon, 31 Oct 2022 17:45:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E40C433C1;
        Mon, 31 Oct 2022 17:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667238341;
        bh=rjgTmcKDAxlJvcA5pJN0GLaEBlB1F2FJMD5/TrTeCcY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PlPNNrhZwkAPoXfoFBoHE24FZegbfX4RPmDLvF32wytSKL+5GayI9elwxUjb7hFye
         sc/na08t+pYUHeBh3KzGckCFZ0BGPMCKITUMReinZsnonraMvgnACiin/Y3yCRPIcU
         YTWszstpQzJnxxb5LzCXvqGssoB5Ne1nM17i3mZ3IJzALDhEvkgtAK5sZlEW+7rIOb
         t2h/1Adjoot082UANFdXDUkWxMowwHGZ84+Lsrw3ZHmGdgOmre+y5lsKYaoZyHgkgs
         daB8fQ5HE38Z2PLCTlK5m0PxAf7lrrcM4NQJUt26FrUgi2gg0Njspqi9EFYU2g3NA1
         v+6QOh6nNACSw==
Date:   Mon, 31 Oct 2022 17:45:34 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        afd@ti.com, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/3] regulator: dt-bindings: qcom,usb-vbus-regulator:
 change node name
Message-ID: <Y2AJvt0SnHTnU7G0@sirena.org.uk>
References: <20221031173933.936147-1-luca@z3ntu.xyz>
 <20221031173933.936147-2-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iE2RTExTjAExk+11"
Content-Disposition: inline
In-Reply-To: <20221031173933.936147-2-luca@z3ntu.xyz>
X-Cookie: Sign here without admitting guilt.
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iE2RTExTjAExk+11
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 31, 2022 at 06:39:32PM +0100, Luca Weiss wrote:
> usb-vbus-regulator is a better generic node name than dcdc to change the
> example to match.

You've not copied me on the rest of the series so I've no idea what's
going on with dependencies.  When sending a patch series it is important
to ensure that all the various maintainers understand what the
relationship between the patches as the expecation is that there will be
interdependencies.  Either copy everyone on the whole series or at least
copy them on the cover letter and explain what's going on.  If there are
no strong interdependencies then it's generally simplest to just send
the patches separately to avoid any possible confusion.

--iE2RTExTjAExk+11
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNgCb4ACgkQJNaLcl1U
h9BikggAhJyyRzQkdokSQKyPACIFit3CNqmGUEgsngrl7YDroJ99vbkYS2XRV8xw
GnrOvxJwKddDz9puHdwqjv/PTcXHVvxzC2WCd+o9Ml/ap5KPQI837SK3tXDiiYQ4
tXfRB9Qa0cHBzXPWU/wlE69sgtJ3Mez8KmiY0hjVqmRyYmbjLuhX30L8Qpjyiz+t
3mvDg9sARu/v+bigaAtI1LrNyklEIjCbTh9SK9VXz7DqouL102rWuoCx5/j7/YSh
CxGHK0oatlE+weK2khC3tHYXlO/OhWlSOKzggl8X+tRivcT9E9A6k7zD+jdIHyJm
i0+STwz8Jmp4TvewVdp1O9d2hrLIrQ==
=yhLt
-----END PGP SIGNATURE-----

--iE2RTExTjAExk+11--
