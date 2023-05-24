Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BCB70FE2A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 21:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjEXTDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 15:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbjEXTDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 15:03:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AA712E;
        Wed, 24 May 2023 12:03:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45B0963F15;
        Wed, 24 May 2023 19:03:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A722C433EF;
        Wed, 24 May 2023 19:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684954998;
        bh=UQc7sqI+omtijBWOP3aJiUq6sJnEgSYIqfC+1+bdXDo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bllWg1WKAYqSqpLR6Y6TS6A6BpF6BUITfN1spBb+rsL5wyoiY5wIr9Jy5kq6sQiIL
         /eywATv83ejYaXUBdQLeAspAg8Rh2TUVtPnesyOoD1MIxmJg0ZLx3oRav6wWax2OIg
         75JXJNWFGwkzgc0eKMf5AubycsSIsfF1S3c1ZyNL7YQkQfEh5IagYbTIRELGKJEvJs
         lPsHYPziTAl6i1qnbHqQWCcA5JD23fvWxH/aqSe6uJmqiVyaj4x8spqx8yW6x79JVV
         pZu3N2eci+uSE/6u7NsmM72ASBf7lmUpaW8QOX/5/cuWmGtHL25i+/n3Z0tyScseVE
         9gjAcEqV1r5qQ==
Date:   Wed, 24 May 2023 20:03:12 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jagadeesh Kona <quic_jkona@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
Subject: Re: [PATCH V2 1/3] dt-bindings: clock: qcom: Add SM8550 graphics
 clock controller
Message-ID: <20230524-blimp-hyperlink-6b235104028b@spud>
References: <20230524181800.28717-1-quic_jkona@quicinc.com>
 <20230524181800.28717-2-quic_jkona@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oY3pL3KuASb4J59F"
Content-Disposition: inline
In-Reply-To: <20230524181800.28717-2-quic_jkona@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oY3pL3KuASb4J59F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 24, 2023 at 11:47:58PM +0530, Jagadeesh Kona wrote:
> Add device tree bindings for the graphics clock controller on
> Qualcomm SM8550 platform.
>=20
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--oY3pL3KuASb4J59F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG5fcAAKCRB4tDGHoIJi
0oKTAQDoK99KS4eJud5cuC1zJi3DX/YYbzcwmOusRVfhUZwhdQEA2QVqOx7Vw9if
cKgmaH9u5n6WZQK1w+OGMe5lsQVRFw0=
=iU0j
-----END PGP SIGNATURE-----

--oY3pL3KuASb4J59F--
