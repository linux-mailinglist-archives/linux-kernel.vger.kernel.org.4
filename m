Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512D16F91FC
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 14:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjEFM3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 08:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjEFM3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 08:29:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE8A1492A;
        Sat,  6 May 2023 05:29:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 806EA60BA4;
        Sat,  6 May 2023 12:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD99C433D2;
        Sat,  6 May 2023 12:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683376157;
        bh=j9cwmY9NtG4amTk4a1qT7ubgf5DFih5T9cNOvPsUREo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DDGwKoT2T+sm25/C41iscfEklYGdMPO2/m7kBvX7NRAY2tOC7W1HxXhgTbyzUjVmx
         7iGm9YorpstFOvxTU+wgJNziVqNJRp8QMOVJgS4FMtHtGxKKhQpMl62HrQQtMZN4Xv
         phPG3bhMyp0UvPphAjPv+/9e9QJIwUaYqSDdlQpSVgyEHWun/mqm+mLLxafR9Rn68R
         M5a6tszAzniyQOO5YSFdmo1eC2ecrEhJrfE67JdJ5eF12WO4CiJW3Cv5eXe8GiMR7r
         0m49OmDn20L7GHo9ODuO7W/f+xG8YMzdZrcn3hfBAWmo/WbNkbe5BPiRdEPuoYI6Ll
         D8muthNC0cHJA==
Date:   Sat, 6 May 2023 13:29:12 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Changhuang Liang <changhuang.liang@starfivetech.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Walker Chen <walker.chen@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, vkoul@kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [RESEND v2 1/6] dt-bindings: power: Add JH7110 AON PMU support
Message-ID: <20230506-foil-basis-31724c50b30b@spud>
References: <1ac26c1a-1726-515d-6598-849a07ed0b86@linaro.org>
 <5adda0ad-965c-fbf0-878c-9d41d28b5c39@starfivetech.com>
 <86693969-59bf-5bcc-42a3-b6e94a0d6f3e@linaro.org>
 <fcfc8ba4-40a7-da43-3375-712bd7e7f4d5@starfivetech.com>
 <20230504-worshiper-ongoing-5581e1f2c2c4@wendy>
 <2f473307-2219-61a4-fa66-5848fe566cf0@starfivetech.com>
 <20230505-magician-poet-724c96020c2f@wendy>
 <ba6a1a47-d3b1-ee16-4785-f5c61d593127@starfivetech.com>
 <20230506-dating-twiddling-b364de21ed2b@spud>
 <b1965ae2-af2d-b11c-3e34-8129c29333b8@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="p9EN/m3kyGka2NQK"
Content-Disposition: inline
In-Reply-To: <b1965ae2-af2d-b11c-3e34-8129c29333b8@starfivetech.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p9EN/m3kyGka2NQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, May 06, 2023 at 08:26:01PM +0800, Changhuang Liang wrote:

> OK, will replace "starfive,jh7110-aon-pmu" with "starfive,jh100-aon-syscon" in this series.
                                                            ^^^^^
Just make sure you don't propagate my typo here in the process.


--p9EN/m3kyGka2NQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFZIGAAKCRB4tDGHoIJi
0tkdAQDGePU71+pVWUcZa08uxLkEJ5SwKW4PyDZ4uHsqXFegWQEAzoJbhsGCFcjN
83Bp4hlpjAGUO/5CJiD3fGavYjrZ+gY=
=oSlD
-----END PGP SIGNATURE-----

--p9EN/m3kyGka2NQK--
