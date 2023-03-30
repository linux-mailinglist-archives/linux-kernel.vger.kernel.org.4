Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15856D0309
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbjC3LYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjC3LYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:24:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6AF9ED2;
        Thu, 30 Mar 2023 04:24:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55511B82774;
        Thu, 30 Mar 2023 11:24:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802BBC433EF;
        Thu, 30 Mar 2023 11:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680175442;
        bh=+O/4Jtp+dl/IIuHbyONVfOFQ6UfRkWjCdWEVcgKsFv4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZSPYxjaXNMzNbi0WjrpdMNgWglmyaH0cSYLGv+wBCwlhIPJw1/zL5yAHXXSuHFCIK
         IIsg41kI0KBmZidbqZ0DjIadziM3haAVTDLf7TED2ddzSsXX2hKcjUSufJE0APdci1
         rlosasyH5JYavK/woAvnwY+Fslq/OKhBp8gr5BWkPHDez+7R8RwCKKDTeXq/BvgH3c
         xq/NgJ9F1sH88M9lmVz738//zhVdL8h1DB6bwmecyRYtqNT4BZm32CI/CpX+g6BAQ1
         TecAafDThZakMcWN831ummz8l5GcBua81Otx8+jrnW4sfWs6RNIpaeJPyamTuYPnXI
         vcMzmq781H3Ew==
Date:   Thu, 30 Mar 2023 12:23:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] ASoC: dt-bindings: qcom,lpass-va-macro: Add missing
 NPL clock
Message-ID: <ZCVxTlb+qQXXuaay@sirena.org.uk>
References: <20230330070342.19448-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RgQFrAdnCXJBeoOK"
Content-Disposition: inline
In-Reply-To: <20230330070342.19448-1-krzysztof.kozlowski@linaro.org>
X-Cookie: Misuse may cause suffocation.
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RgQFrAdnCXJBeoOK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 30, 2023 at 09:03:42AM +0200, Krzysztof Kozlowski wrote:
> Several devices (e.g. SC8280XP and SM8450) expect a NPL (Near Pad Logic)
> clock.  Add the clock and customize allowed clocks per each variant.
> The clocks are also required by ADSP in all variants.

This doesn't apply against current code, please check and resend.

--RgQFrAdnCXJBeoOK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQlcU0ACgkQJNaLcl1U
h9BSwwf/XGc3O2Ze+FtjmLmXgxQEKai10eNESrZmVzpj3RTtlNWMEkrFh3zqxV2G
TRgvWI4/DLWAjR6snW0DzmVpOZpMow+4GQ+fwf58GgWCbeuHcyNzgwF+qb1ZpScW
YbroKR7kauxV9lx9u0Wae13RZlFCGF8tY9hDO6V+xTlR/L5MsUhxzujfj6uSTgWY
GasGIjTXmTA6t/jueX9VSYp+sRo6oFKvVqGzi37IFfk6fEUW5GPaETJJIiPgwpfM
OSMTmrjzSs87TdH0bn+Hm510sG69v4kDVwroL3buMjs9p3Wh31R05FfaGCpKkHEA
IV7aWC6+fWOItuI+qx7D24t8AfCd/A==
=VdUt
-----END PGP SIGNATURE-----

--RgQFrAdnCXJBeoOK--
