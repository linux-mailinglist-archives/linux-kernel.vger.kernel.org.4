Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDF92714F43
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 20:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbjE2SU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 14:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjE2SUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 14:20:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C40E90;
        Mon, 29 May 2023 11:20:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A69DC614D9;
        Mon, 29 May 2023 18:20:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9D2C433D2;
        Mon, 29 May 2023 18:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685384424;
        bh=7MpIpDU1CNrNOt/ZqprpU9B3GzC0GmpemsVfLWbSRfY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FQBSoGk13CHPbD1i+HoYN6Fd98SK4Kx5bnt7Ri64EZ6xyz5Q693vqQtrt6z8lR/z0
         eynffBTcoPELDuQHSHHIdBh9jBP6/PfhK+SUpBnITDG4kT/h7XqSUd+tEFXEs4vLAi
         bLhAvNEqRZpg+JIeDf01H/W6jN0sK33G9x5DspLs8QuFfuYMd8BBoW5ivH1xTQyuZu
         Kj7vGzaWAlW7LKpRnJG5hNeoUw/UOnuDYHN+bkkrtsZDcTY17vQABztP4CLytE2C+9
         YRvRSTSBtVHteNCsXxzSTvZUjX/Rqe+mOAaqygHHI7wc/J1LMA1C3jobFC2CFxlIBb
         yZ86Z+RUIJrwA==
Date:   Mon, 29 May 2023 19:20:17 +0100
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
Subject: Re: [PATCH 2/7] dt-bindings: display/msm: dsi-controller-main: Add
 msm8226 compatible
Message-ID: <20230529-opossum-powdered-b60cc970f512@spud>
References: <20230308-msm8226-mdp-v1-0-679f335d3d5b@z3ntu.xyz>
 <20230308-msm8226-mdp-v1-2-679f335d3d5b@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KvERIVUtKpYboQE3"
Content-Disposition: inline
In-Reply-To: <20230308-msm8226-mdp-v1-2-679f335d3d5b@z3ntu.xyz>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KvERIVUtKpYboQE3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 29, 2023 at 11:43:59AM +0200, Luca Weiss wrote:
> Add the compatible for the DSI found on MSM8226.
>=20
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--KvERIVUtKpYboQE3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHTs4QAKCRB4tDGHoIJi
0gJxAP9g6+VXCSHKqz1Dcy+kVMyFENy8a9usGNKOXK3mcW573QEAzDGitMkl6s4w
uEoqf99Wl2Wpn+Nz3yXyk0bHQnA0ow8=
=9WvT
-----END PGP SIGNATURE-----

--KvERIVUtKpYboQE3--
