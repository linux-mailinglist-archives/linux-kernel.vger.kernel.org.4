Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F74F70550F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 19:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjEPRbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 13:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjEPRbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 13:31:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F53F7;
        Tue, 16 May 2023 10:31:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C2C9763D32;
        Tue, 16 May 2023 17:31:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7A5C433EF;
        Tue, 16 May 2023 17:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684258287;
        bh=O4YCJG68eu92BmKTe3gmBdrC6C2hQNIQNPO+2Any71s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O6vdKgG9z1S02cZ6qZ7e9/DT9oP2g1MBYb0DgKlT+rxJw7/JLUOjV3UyHrp0wdRLF
         glGDaGGaSQySYZvg8xzLQVer59yrBLl+iS33AzAmzbeR/sE2e8UtMxdQtY5cu+Dsd+
         qxjAud31uJvZhC4V21lBoynN3vRKjMJd5AGhWN4rbwvurOwirF5mQHwpJVewEWrnCC
         hQ4dmb/9eZc54JsirgyJNmrrgW2ySj1khIspPRYGq4kOLHmjjscgRSTi9ZAzhMZMa9
         u8hR3p7WGjs0V1YtCfnYvF8CeZvngsJXDBFGJq8taoOvrwzPV2REtn/qYJX4yHHuYc
         Z/AoVzk2IAAhA==
Date:   Tue, 16 May 2023 18:31:21 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Fenglin Wu <quic_fenglinw@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        "Signed-off-by : Abel Vesa" <abel.vesa@linaro.org>
Subject: Re: [PATCH 1/3] dt-bindings: leds: qcom,spmi-flash-led: add PM8550
Message-ID: <20230516-blinking-improving-c2c21a8825e9@spud>
References: <20230516150202.188655-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RKKWDGIE5MJe8g8S"
Content-Disposition: inline
In-Reply-To: <20230516150202.188655-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--RKKWDGIE5MJe8g8S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 16, 2023 at 05:02:00PM +0200, Krzysztof Kozlowski wrote:
> Document compatible for PM8550 Torch and Flash LED controller.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--RKKWDGIE5MJe8g8S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGO96QAKCRB4tDGHoIJi
0qw9AP4wk3ZemA2rluuaN80SorF/sOknrETktXUeXXe7BM8AUAEAtrKv/LNTXrcT
Xc7wGfgInqUMoCahhCdKTZxMHHuUUQc=
=zgic
-----END PGP SIGNATURE-----

--RKKWDGIE5MJe8g8S--
