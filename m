Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392DB709C83
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjESQeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjESQeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:34:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C534F183;
        Fri, 19 May 2023 09:33:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52B846591F;
        Fri, 19 May 2023 16:33:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692D1C433EF;
        Fri, 19 May 2023 16:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684514031;
        bh=A6Qznu4RwjjSJ3P9gf7FuMDKLW+BNK4Y2l7NFlm80sk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o/dl6s+rBeqLWNomON1doXuY/5l9/w8E8A9BJp/XxBgX72+C0SCOEZiokwpBWvOGD
         vla1KGTxWVV3DePl8O8O8XqJYNCUnSxvJ5uZfrah42RfNdsd7hJlyd4KTFDctLt9tE
         cFThHzG0P2NB4szutzoLRGrBnR1ZwW/xlYpJD1ZSgcLxHYwYu2Go0sP/4zDXTICCRG
         T5EFrlEmThQyGMpms6NrEviCRk28MNfTHj2xTKJM+rwztfT/foRbhtdB1drnj3Ms83
         Dm4xFO5lTMrqbC95jOk8iK35yDPzwguykzSfjTmUdy2WMlo7qDZ0mJ2aSLfXbqsHWy
         gf8hgszIOaK5w==
Date:   Fri, 19 May 2023 17:33:45 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Poovendhan Selvaraj <quic_poovendh@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_devipriy@quicinc.com
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: document AL02-C9 board based
 on IPQ9574 family
Message-ID: <20230519-outwit-habitant-2dd4cac87a59@spud>
References: <20230519103128.30783-1-quic_poovendh@quicinc.com>
 <20230519103128.30783-2-quic_poovendh@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xwf96lIcaNxAGYmB"
Content-Disposition: inline
In-Reply-To: <20230519103128.30783-2-quic_poovendh@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xwf96lIcaNxAGYmB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 19, 2023 at 04:01:27PM +0530, Poovendhan Selvaraj wrote:
> From: POOVENDHAN SELVARAJ <quic_poovendh@quicinc.com>

> Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.


--xwf96lIcaNxAGYmB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZGek6QAKCRB4tDGHoIJi
0mfRAP9aG9HkrPxBCKYOQ+y8FlEKvDLatlxnfrF/xCOzX6cnFQD+P4sfbIFtbStI
MY7irpZGC1Ba/diAq/SKK68PxVcN+go=
=gheO
-----END PGP SIGNATURE-----

--xwf96lIcaNxAGYmB--
