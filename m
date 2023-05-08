Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CF66FBB04
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 00:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233659AbjEHWZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 18:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjEHWZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 18:25:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4E35B92;
        Mon,  8 May 2023 15:25:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C76C26205A;
        Mon,  8 May 2023 22:25:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF77C433D2;
        Mon,  8 May 2023 22:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683584745;
        bh=CvmAZhQVoRHyGoGJ5fwdxTLzjL0vk9hx7okCexmPS8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AaDiLwKXpM4HTo1v6iJLrnP9yDGrXr1ZYhwv4it+gYDfjB3bAepKcNmnE3RI71rap
         vGuQqWJwofq4Yg91rVk7u5NuFoYQJXf+DgCIX+Y6/haBDaMZSyICIqR63s9qea5NHf
         hqrF1BRSa3XBHj/CIE4SpPZtGgr5MTwbcbFBM0US/Mo3TAXCbI2Cw7qnx4hPb7sezb
         mSpGbWPan69NAsvYqy5prqhsnItJ//1mehE9H83DwpskXzmr0pGqUYFhnD5onVXI/v
         WlDyeE5EKkYlDjXXrE29afArkQdzGAOdMHNmbDb1WnwF0JrfMR11f172ayUg4AG9RV
         l2h+NkI3fcwyQ==
Date:   Mon, 8 May 2023 23:25:39 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.2 000/663] 6.2.15-rc1 review
Message-ID: <20230508-bottling-rinsing-dd595259c719@spud>
References: <20230508094428.384831245@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Fgb9rn3498PUaa1Q"
Content-Disposition: inline
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Fgb9rn3498PUaa1Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2023 at 11:37:06AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.2.15 release.
> There are 663 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20
> Responses should be made by Wed, 10 May 2023 09:42:40 +0000.
> Anything received after that time might be too late.

Other than the bcm63xx build issue:
Tested-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--Fgb9rn3498PUaa1Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFl24wAKCRB4tDGHoIJi
0rAlAP9SdEwRTBofRPzjTdn9H3VfY5rCLLi+1jJmez43t5rb0QD/e9R8Poe+JuUk
duNqn0Mt7r68sAgiaS2EYqUFvTO3oQM=
=Way5
-----END PGP SIGNATURE-----

--Fgb9rn3498PUaa1Q--
