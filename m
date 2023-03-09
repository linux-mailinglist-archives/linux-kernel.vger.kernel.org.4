Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E2E6B2D52
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 20:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjCITD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 14:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjCITDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 14:03:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CC1E503F;
        Thu,  9 Mar 2023 11:03:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01EE661CD0;
        Thu,  9 Mar 2023 19:03:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80E3CC4339B;
        Thu,  9 Mar 2023 19:03:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678388633;
        bh=ev9ApdQFK9HxvCMF1QnE29vmlVWk2V34cqvfeT2lmfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cviH78OvgsBynRidrNp7ft2hOZArdY02vmEf8L7DPyz8fFudbcjraleqFqpsdguV5
         DLEkDrB74UfKEbwB38xqDoHOAFnCSIvpr2mC/kT7akdykxLwGpoIWLh1FGmR5kS3hg
         88VKplnlLSESwFFRVP9GF4BEuzIaeaMo4zUhPBYU6EMSLEARHcFvSQSHbdvinY5Os5
         cwGshD+rnD27ruM2KnHGl/hJQpRiixhydVz5KSZK9UVki1MbzMALenqqD3HbmkDbrn
         D7pma45JR7Vmvmh8oIiHzw3EEgAFQCKwo6VIcctDskFlGvUEhJx5JkZF8JI2ycmnMW
         8S4xbxD1EaCaw==
Date:   Thu, 9 Mar 2023 19:03:47 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     Hal Feng <hal.feng@starfivetech.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Dooks <ben.dooks@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/19] Basic clock, reset & device tree support for
 StarFive JH7110 RISC-V SoC
Message-ID: <23111c4b-2bee-4f04-b0e6-bddea553d260@spud>
References: <20230221024645.127922-1-hal.feng@starfivetech.com>
 <3a605bc8-104e-0935-4fd8-2da16ab9053b@starfivetech.com>
 <ZAb7JVghuiwZF1Q5@wendy>
 <2f03dfb2-5cf8-e954-913c-f0c27db6bcf5@starfivetech.com>
 <ZAh/UeSlUeGoKxki@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <4c071642-e3c8-4716-a580-5b42e25efb1c@spud>
 <ZAoOLIERMYI8UVlA@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <09630acb-f1ae-4dbd-9c9c-9adb1743bfe4@spud>
 <ZAosTc6VNco1okyR@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7VG2qaNb2wp6qtrg"
Content-Disposition: inline
In-Reply-To: <ZAosTc6VNco1okyR@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7VG2qaNb2wp6qtrg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 09, 2023 at 07:58:21PM +0100, Tommaso Merciai wrote:

> I'm able to boot the board using nfs ;)
> (without issue)

Sweet, glad you got it working. If you'd like to provide a Tested-by:
for the series that'd be wonderful too :) No pressure haha



--7VG2qaNb2wp6qtrg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZAotkgAKCRB4tDGHoIJi
0qrYAQCoESXCeNmtpXU+5dNKYxyNusF7HGsBVqTMKuOe9O5fpgEA1LPxd5+mlff6
egqx99j+fyCuoUTh9ATU0tJ3o9ZIDQo=
=qK0s
-----END PGP SIGNATURE-----

--7VG2qaNb2wp6qtrg--
