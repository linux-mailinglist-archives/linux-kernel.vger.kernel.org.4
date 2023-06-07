Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F56726E67
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 22:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbjFGUuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 16:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235116AbjFGUtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 16:49:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A426226A1;
        Wed,  7 Jun 2023 13:49:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83EED646F0;
        Wed,  7 Jun 2023 20:49:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9EFC433EF;
        Wed,  7 Jun 2023 20:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686170970;
        bh=5n8uz7/OdoveYJZFYQcsiPzaefRRvV8mnA90h29ZFuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EL7Hqwj7fU/ewEGQULixw5yNU9qW6YPCQ52Jo4fOjOcwTMO7n4lT/HOg1vkfnKW/F
         x5o+mwPKgQB9VnE7eYpTBVi9eEtgeznyXi1aiem966NiucNWp3lpn4VNgpuPN07bWM
         6KSzfFNsNK6Od4gt5wXe6o82zTUKrpwwU6WevDEhjBi6vUS3lyO9FKNGpt+adMyJJd
         dliH2tEPl6CMkop7NmjaWIVxkv4WQMEL4o9YExNsrO6OxNvbZD1FKcOlyqPgGeeUka
         G5zv2JsPq7JrTkhX8qM5/l+KxzXJI2Ba0zsYupLRweDFO77wxSF0HX8keVKfnzCNQh
         Hqi9HvkOI5rhQ==
Date:   Wed, 7 Jun 2023 21:49:26 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: misc: qcom,fastrpc: drop unneeded quotes
Message-ID: <20230607-promenade-yesterday-e1c0c2412856@spud>
References: <20230607184147.420352-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="qakZvi7HjRW1Dgal"
Content-Disposition: inline
In-Reply-To: <20230607184147.420352-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qakZvi7HjRW1Dgal
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 07, 2023 at 08:41:47PM +0200, Krzysztof Kozlowski wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--qakZvi7HjRW1Dgal
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIDtVQAKCRB4tDGHoIJi
0knbAQCat0P71T2mjheUiPreYTP+aGiFXhON8Hhn0RLntASI3AD6A8y1H0yTgxLN
Y4i2870aGDg2CkVEDTcsB5nrN1Z5+gM=
=ZIfs
-----END PGP SIGNATURE-----

--qakZvi7HjRW1Dgal--
