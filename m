Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8BA6BD977
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 20:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjCPTpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 15:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCPTpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 15:45:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21817968FF;
        Thu, 16 Mar 2023 12:45:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A17C962100;
        Thu, 16 Mar 2023 19:45:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B3BC4339B;
        Thu, 16 Mar 2023 19:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678995942;
        bh=E92zL3S0Wimh6vAEN3pu2tsbqcS9PJeZ980curFNxDw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WyyxY3xocNQCtRBg1YQrT+Cz8DKbNuzwPfWzDf065WBxlGrLsjulPnLsjOTyfA6q/
         6u837by1tGT7oPBCZDwafix+nDv9IyehzoThti0i/N6zs6ntjZHTQzz2oHl7y7P5au
         O8D+8O354Y7cCA2Jj2UDdehrYqxRRlVE3lWf8+YsR7o7VE2h3L0EmEVe2GIseAqkRy
         QUPNyTL4u93xYJqfrJSmNKr8koqaF2X14/VxKPJxoytiD4JdzCKyDq0Vufc8nkEns3
         26HP9+8W32ymNo7AM2qVaGFqxUMQJpU2pINSoWGawLnPAtC5SvQE+V3FLOCBFmre4L
         lHke2x04q10JA==
Date:   Thu, 16 Mar 2023 19:45:36 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vijaya Anand <sunrockers8@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH v2] ASoC: dt-bindings: adi,adau17x1: Convert to DT schema
Message-ID: <1cfd50ed-f7fc-46c0-9e6b-5a35b1a9572d@sirena.org.uk>
References: <20230315231055.3067-1-sunrockers8@gmail.com>
 <167897628543.92626.6326219364017588458.b4-ty@kernel.org>
 <a3f7b1bf-b37a-1e42-1e43-02b82fbd895b@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZgF76LVo/Z0d02h/"
Content-Disposition: inline
In-Reply-To: <a3f7b1bf-b37a-1e42-1e43-02b82fbd895b@linaro.org>
X-Cookie: ... I have read the INSTRUCTIONS ...
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZgF76LVo/Z0d02h/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 16, 2023 at 08:16:29PM +0100, Krzysztof Kozlowski wrote:

> There was a warning from Rob's bot. Can you drop the patch or you expect
> follow-up?

A followup would be easiest.

--ZgF76LVo/Z0d02h/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQTcd8ACgkQJNaLcl1U
h9DsTAf8COhC2pYYz9C1xAjzWXwZ7K7F9iiVeuAZ8EkgtUw7oU9A1EzLHrmK/xBA
0KLVVpsysPJzNlEExUN2c96lB7iz+4zA/IAlFYZN9vuDWIdbPUpyFdr9jl8gpy44
VUL5UFsT0/aGqya1VCWErVJ3nsGjN1Mw6SM2P74OVpn9kn34Ewxk/2LKiO54Nr44
ZJ5giEg5jp6aMSx1FPeauRjm1hkHVkuucFfbTxsu5y+4q4UvCCkNnc46Zy5AWZfm
CbqlKPNYRruRvkdGq5Zi4xJw8SDI9fhS75pyTklnIvMSNGt2W4E/0rc2xno38hHM
QDfeuev0Bi7MhuNoAxVH8akMzTtZyQ==
=Cjpn
-----END PGP SIGNATURE-----

--ZgF76LVo/Z0d02h/--
