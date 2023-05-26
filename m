Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59AD9712C95
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 20:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235984AbjEZShH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 14:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjEZShF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 14:37:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DAB171A;
        Fri, 26 May 2023 11:36:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A354C6527E;
        Fri, 26 May 2023 18:35:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0ACC433D2;
        Fri, 26 May 2023 18:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685126142;
        bh=VDDmjHyy+iR3Og6KPq9UzqSzR9nA/ikwlfukRRfxXHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=An16OMJhq21wwMXZl1NioR7ndRPIXTD7voG2vWPxcHN4t4Poiohtz+oOVj32GmMBc
         nxsESat9w4Ia6m91rbojyR0At/ojg07sFyJqVQTwd4dPsYpipfB/InH6EwGtaDPmvx
         ke/r48WGEmHoH2gAhGJPVdPC3TBozcPqxypFTku8Io3x4+i+YnLB/HknHeuY4ghb4S
         8cIAIW+FE5cRbHUpeVbPbjgrekKQOEPJhtUNV1bnd1RQMKinphY+avJ876E0cNDghI
         HHj4hajn8h3TkfEx1mPwVyh9yT1rEhP0KvALzhAz/tkLv3nUiPgG8DuZWrIsGMN360
         FccPdUOQKS+pA==
Date:   Fri, 26 May 2023 19:35:37 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Kathiravan T <quic_kathirav@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: nvmem: qfprom: add compatible for few
 IPQ SoCs
Message-ID: <20230526-romp-stunned-9b3e9eb40d1e@spud>
References: <20230526070421.25406-1-quic_kathirav@quicinc.com>
 <20230526070421.25406-2-quic_kathirav@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rFsBBuqS+Nmcrkb3"
Content-Disposition: inline
In-Reply-To: <20230526070421.25406-2-quic_kathirav@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rFsBBuqS+Nmcrkb3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2023 at 12:34:18PM +0530, Kathiravan T wrote:
> Add the QFPROM compatible for IPQ5332, IPQ6018 and IPQ9574
>=20
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--rFsBBuqS+Nmcrkb3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHD7+QAKCRB4tDGHoIJi
0t9vAQCFE8PJYbehdCJWON2Smf814mrVBpoIxIqPwfJP2yLlcQD+OQ8BmNH2q+bm
Z4vfJvNqu9wcm5U5yCiWx5jI7lAcjw4=
=RVe1
-----END PGP SIGNATURE-----

--rFsBBuqS+Nmcrkb3--
