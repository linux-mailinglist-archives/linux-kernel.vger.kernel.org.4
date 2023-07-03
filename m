Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0554746061
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 18:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjGCQH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 12:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjGCQH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 12:07:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6AAE7B;
        Mon,  3 Jul 2023 09:07:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C82260FA1;
        Mon,  3 Jul 2023 16:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DE3C433C7;
        Mon,  3 Jul 2023 16:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688400441;
        bh=/t4bQlsk7xnRgW8XpOC9D4rZ/S3S1+1wPJq5/gWltfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hd1CyQhuwjkID275F9lv2ZfvGFrB07WnYUM/pUcb4Ya6OVtH2gAUXM7dxxJGvLQi/
         M8WI4GtTS/dyZ/0wOUcrn1sv1td5ycs4andVDFOtTyPYfxMVrIiHm34BeZA4vpABfT
         +AAKHwl/Xhy+mfhuv7RJYRVI+9xCQZv2ZCBDzqbGh1FLV190r4uyg21b9P3id4BifD
         kmMQ/kWvr7lCaxtnSgbOWOK5nH2ums7gO1M894XDsQqdZUoYOPUE1mWEiKa2khH3IR
         u1ySuiFrOJv+t6bsltsLUJr7rgsNAHccQCvP7rLImsCgIwxQcjbcLXE2kjnrT2G0kX
         onlrCKE92x3WQ==
Date:   Mon, 3 Jul 2023 17:07:17 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: pmu: Add Cortex-A520, Cortex-A715,
 and Cortex-A720
Message-ID: <20230703-overpower-disk-72fb10245996@spud>
References: <20230630185602.2175559-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pn12REmklruElrMZ"
Content-Disposition: inline
In-Reply-To: <20230630185602.2175559-1-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--pn12REmklruElrMZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 30, 2023 at 12:56:01PM -0600, Rob Herring wrote:
> Add compatible strings for the Arm Cortex-A520, Cortex-A715, and
> Cortex-A720 CPU PMUs.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--pn12REmklruElrMZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZKLyNQAKCRB4tDGHoIJi
0kt7AP9Y4TQ8LnGJhfyK6tTTpelM+kjen9oNMuV+GCVO6NnxuQD/U0/4kOqflPFB
THBGtPIqT/0oMEOF4uF+sYFENYw9FAM=
=KszT
-----END PGP SIGNATURE-----

--pn12REmklruElrMZ--
