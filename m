Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72571700F90
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 22:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238735AbjELUNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 16:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjELUNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 16:13:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58DB62701;
        Fri, 12 May 2023 13:13:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E863C64BA7;
        Fri, 12 May 2023 20:13:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04DAFC4339B;
        Fri, 12 May 2023 20:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683922399;
        bh=I4yY6uuFUi8W1ueiAeViUE2wj55FTkfm9RZZf+6X0f0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q29/ukayynPbKu/6JUt2kxopC1ZGjMTdN6TsFu3ZZOgOb+ikInZVkACxWsNO177y/
         YqgyxfocCtZtKJmKJUIdddSTNPyo/9qCHOq3oqufjSsUI1DiawVYaPH2ZkrSJhk/Tb
         miqg/qzkEWfqGJfLx763PqXN+UaMc+tRqtwEd6So8wJX9M3KAURKfdI6JCja3zOM6t
         AyR0u7wLpoC2cGFp/FXsPuWsO3End1MhKjRgpvqv6dE+Aj3t0x8ExZQGc9P+Z41hJQ
         JI4dRGp4yF+xofJgjUoOlh5cAjSw4Vasv4kYpUCBviuvrSAYx6bDw+i/NWCa/RfyD3
         2t6X/moHBpFCA==
Date:   Fri, 12 May 2023 21:13:13 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Jack Zhu <jack.zhu@starfivetech.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>, bryan.odonoghue@linaro.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, changhuang.liang@starfivetech.com
Subject: Re: [PATCH v5 1/6] media: dt-bindings: Add JH7110 Camera Subsystem
Message-ID: <20230512-sasquatch-untracked-1587b55c2008@spud>
References: <20230512102844.51084-1-jack.zhu@starfivetech.com>
 <20230512102844.51084-2-jack.zhu@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w4zIZVr31S7cT4tc"
Content-Disposition: inline
In-Reply-To: <20230512102844.51084-2-jack.zhu@starfivetech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w4zIZVr31S7cT4tc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 12, 2023 at 06:28:39PM +0800, Jack Zhu wrote:

> +description:
> +  The Starfive CAMSS ISP is a Camera interface for Starfive JH7110 SoC. It
> +  consists of a VIN controller (Video In Controller, a top-level control until)
> +  and an ISP.

Just a minor comment here, "until" is a typo, right?
I guess it should be "unit".

--w4zIZVr31S7cT4tc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZF6d2QAKCRB4tDGHoIJi
0oLuAP4smoXjKt3fjMTRLR2osZd+qYUbCAMl2rlKilNrGl2d0AEA5wt5gHQN0k4Q
/c3qxN/AxtV5ZOgirozNHJoV1PmERQY=
=mha/
-----END PGP SIGNATURE-----

--w4zIZVr31S7cT4tc--
