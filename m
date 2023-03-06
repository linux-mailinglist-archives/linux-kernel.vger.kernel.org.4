Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C4B6AD00E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 22:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjCFVSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 16:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjCFVSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 16:18:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E6E6EBE;
        Mon,  6 Mar 2023 13:18:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85C47B80FE3;
        Mon,  6 Mar 2023 21:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86E3C433D2;
        Mon,  6 Mar 2023 21:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678137514;
        bh=AxsVbuTwD9lcAnQSfFTEOvc+VhNCMa+HpFqJypkBt0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=owU5F1dBzl1UY142Ecej4ZNLS+vSVLIEXpquSYfLOKDDfeSoyxtj8WTOQ3IK/uLW+
         kyCwiewSs2RPsW5StQntBvNpumdvYaOGSolVMZUKApbzQqefTSqATPomdRZ7Ri5rpq
         pZqTYHUBUCoZIh8us2Ydqc2U8PfssIo4LGqm06JBgJ/OpYFMs4hsob8Dne5NPR8rll
         kA9D42AUrXNaIwGUAozx3BsYx7NNBj0zMJtFAfG7jPEPCI6J8CtevHL85MVUdDCuRW
         LtiGA9LiQIwcc6s0LULPb+1OF/YXlQiB2D/zwsoSur35EOy28pmoIkCeU1blqtlS8I
         ZpNEWbx5ClT8g==
Date:   Mon, 6 Mar 2023 21:18:28 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Sunil V L <sunilvl@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Anup Patel <apatel@ventanamicro.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Patra <atishp@rivosinc.com>,
        'Conor Dooley ' <conor.dooley@microchip.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH V3 19/20] RISC-V: Enable ACPI in defconfig
Message-ID: <91cf4ebd-f22c-4cf9-9fb4-fa6349ea00ab@spud>
References: <20230303133647.845095-1-sunilvl@ventanamicro.com>
 <20230303133647.845095-20-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oiK0djp9YUeJc/e1"
Content-Disposition: inline
In-Reply-To: <20230303133647.845095-20-sunilvl@ventanamicro.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oiK0djp9YUeJc/e1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--oiK0djp9YUeJc/e1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZAZYpAAKCRB4tDGHoIJi
0gqPAQCEd5ofg+gQPDBDKWon4HPq/76ep5PMObYQ6wu4ecu2tAEAlaiu6jQSgrVT
f8AT4d+fR8d2MHS4Dwh74nQBrfzfRQI=
=55B+
-----END PGP SIGNATURE-----

--oiK0djp9YUeJc/e1--
