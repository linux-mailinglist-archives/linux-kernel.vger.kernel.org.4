Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045CD7430ED
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 01:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjF2XNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 19:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjF2XN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 19:13:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9AE12F;
        Thu, 29 Jun 2023 16:13:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A30761659;
        Thu, 29 Jun 2023 23:13:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FBEC433C8;
        Thu, 29 Jun 2023 23:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688080407;
        bh=2awjKHX4Yc3J7yyhiD16O0HE9smL0d+ZJRJ1b6FGCdY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gBH4/tNSFm9WdrCxJAuarB7CnL3BK0WdGtrqTNPsZqRhSlGAZJDcQd0DMPa4DtvIG
         LYvI6Z/5NK2aZIxKi8CV2byiwJ3qf4QMUkCdZUeewOzTELM85xY/PTMKSmOf+hhB0k
         cflm3hh5CoMderrowZQszFa0whC6mZ1k2UV9Pykl3U3/dKnJemasvh73P+KO1e3FGN
         SbtLQgHCKyQNw7etW0PGrUWvwzUHKB/6AjPtxOJkoVLRzR/t3wN07wzN3Cqm8n5uoM
         j11KT46ptOs5+I2fNvi7NhXOCIN4ql3jalKUb3FxuhwkHAhseYNlwVX8k6zO8tE7CD
         xnzJSyG++LBVg==
Date:   Fri, 30 Jun 2023 00:13:22 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Evan Green <evan@rivosinc.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>, palmer@dabbelt.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrew Jones <ajones@ventanamicro.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Sunil V L <sunilvl@ventanamicro.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/10] RISC-V: don't parse dt/acpi isa string to get
 rv32/rv64
Message-ID: <20230630-detection-jogger-c60ea71ee6b6@spud>
References: <20230629-rebuttal-vagueness-a699deb7c7b3@wendy>
 <20230629-fruit-syndrome-74e32af9c8ad@wendy>
 <CALs-HstMTxJFHEoSCaAUtYzT+a-2RSYAhWMQmkVw2+WE=y0agQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Op4eXmT/eGWY9/iV"
Content-Disposition: inline
In-Reply-To: <CALs-HstMTxJFHEoSCaAUtYzT+a-2RSYAhWMQmkVw2+WE=y0agQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Op4eXmT/eGWY9/iV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 29, 2023 at 04:10:48PM -0700, Evan Green wrote:

> > +               print_mmu(m);
>=20
> Did the indent get wonky here or am I just seeing it wrong because gmail?

Nope, you're right. Thanks!

--Op4eXmT/eGWY9/iV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJ4QEgAKCRB4tDGHoIJi
0vq+AP98TaZYGhjpm9uC0HHIvRVzFL0ZATKN5slrUBu8PZ27QQD/VZKNm18gMlPa
SPpca1cy7ZS/8C5V+Sui5QYuupbzFAo=
=6I9B
-----END PGP SIGNATURE-----

--Op4eXmT/eGWY9/iV--
