Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CABB6C52E9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:44:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjCVRoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbjCVRns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:43:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4C113DD5;
        Wed, 22 Mar 2023 10:43:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD4E0B81D7D;
        Wed, 22 Mar 2023 17:42:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2224C433EF;
        Wed, 22 Mar 2023 17:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679506960;
        bh=OcsrKnzki4a9lwOH45aqmVNP8I1F76AaxK2/K4GQegw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fi2ZrtRz/ikyvPo0/GL2HXtR1ipANItLggD55ea/dm3Dv7tC3EbIS+4U/z4Y4KfeH
         5o9i/VmrRAoXwCVnkmh+9xDiq9oL/masEjSb5CJ7cAIHgRHgc52K2WiqgCoRDMa8tG
         l+Pb5jNWez+J8x/LO2xsARN/h1/+mWCODeuMANOJ3jqdu7gwSbQB2zPbVfk1Yf5vB2
         7QyjcFZPLTNzd6CVGdq/5QH4sJJU+BbzMxlgOsSuQzvr99XDYA0ndpraliSJGiIa7T
         BM9P3J4ItPhA8kr1f8XmMLL5TegV6oqZrtyXDunlWLeWLQZedOgiCmrHYAgpCE6Czg
         VcHwwwBbpk0ZQ==
Date:   Wed, 22 Mar 2023 17:42:33 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] dt-bindings: mailbox: Drop unneeded quotes
Message-ID: <1a780ce4-a34a-4d56-8e23-62c6ed383442@spud>
References: <20230322173449.3970718-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s7OkovLInhHlrXlo"
Content-Disposition: inline
In-Reply-To: <20230322173449.3970718-1-robh@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s7OkovLInhHlrXlo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2023 at 12:34:48PM -0500, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

>  .../devicetree/bindings/mailbox/microchip,mpfs-mailbox.yaml   | 4 ++--

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--s7OkovLInhHlrXlo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZBs+CQAKCRB4tDGHoIJi
0ljnAP9M6xcNRHWqsKP8m9DmhUIoAK2N9I8ntVPvgXgkDbXKNwEAmcuSgyWAzynP
jPQ9MIFEOPL9QVs0mQsmgjpm9NEXvwY=
=z625
-----END PGP SIGNATURE-----

--s7OkovLInhHlrXlo--
