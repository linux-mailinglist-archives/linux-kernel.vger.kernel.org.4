Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FB2714F4F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 20:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjE2SUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 14:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjE2SUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 14:20:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4957DD2;
        Mon, 29 May 2023 11:20:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B45DB61A40;
        Mon, 29 May 2023 18:20:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F19C433EF;
        Mon, 29 May 2023 18:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685384445;
        bh=AfMTqnV6KwWgP9v31k1mR5V6z9ajfdSJ5Uc7ep7WELc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qzcuUbHYXi5b8AieT0vvopPB8x1y0ptKWFGt7GXfu21AxNyp+wZAPEeRGfkTorgOK
         je+2oKlEhvKsX11vgIVBXgDnYu30Ja34yTAI691s/NNEEFB7GBjxy0E+xy9yh0CRix
         dkkSD+cO+Mb1ismH3JhFIKH1N38Kp7rBBxzJLvHnl1Knav9Dyc0GzTvlHUxzBvtSMw
         tlnyx6wejkhiE8Tdd0+LEkG4DpHzKaCNfl80r5/jWBzPisoCInzW04zNf9P1mS0nc+
         a4oYS49Pyy6mJoX25WxNvMML7wvIpEAw+Kdd2OCBv8jgC4ZOUXRxI6ip/C0P/p0Xvm
         ZUnfWL5yBmcZA==
Date:   Mon, 29 May 2023 19:20:38 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] dt-bindings: display/msm: qcom,mdp5: Add msm8226
 compatible
Message-ID: <20230529-roundish-illusion-cceae48e06df@spud>
References: <20230308-msm8226-mdp-v1-0-679f335d3d5b@z3ntu.xyz>
 <20230308-msm8226-mdp-v1-3-679f335d3d5b@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fe9MgKxA38lwE2Ic"
Content-Disposition: inline
In-Reply-To: <20230308-msm8226-mdp-v1-3-679f335d3d5b@z3ntu.xyz>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fe9MgKxA38lwE2Ic
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 29, 2023 at 11:44:00AM +0200, Luca Weiss wrote:
> Add the compatible for the MDP5 found on MSM8226.
>=20
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--fe9MgKxA38lwE2Ic
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHTs9gAKCRB4tDGHoIJi
0ocUAP9/IR/9aIDPmdHRZs6ORpYOiGSrg1oL9tZZ6WZEJZyfcwEA4SROMwhv0i2f
/mF0Fxr2WxYpLn4VIY5ctZx937GZCQw=
=u1qd
-----END PGP SIGNATURE-----

--fe9MgKxA38lwE2Ic--
