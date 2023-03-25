Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B84E6C8DB1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 12:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjCYL5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 07:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjCYL5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 07:57:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E20125BB;
        Sat, 25 Mar 2023 04:57:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5A7B1B801C0;
        Sat, 25 Mar 2023 11:57:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4F9C433EF;
        Sat, 25 Mar 2023 11:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679745438;
        bh=SO6La1Bfj9RCTD1Pb6AjuC2LMQRpiSJIGJOAvIQKZek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GlAdcNwQVVQaacGPFavVd/KFp8a0sMdwyt+fSpMxrmmd5oHAp5ftvsmyU24+e7P7Z
         0f319zF0lY4r76PkEOwUF0wDszpC1KBVRDcNib5PuFS3htIbAkE/3vxac1XjSff6F7
         nD5kFxI5aBsx1Z+8TqnCuY2ftpaVsu2lFLtQffhuZYsr82Y4dQOFvkIi5aZ3FH6dbI
         KZvXNkqo6k+J7mu83D4P4uUfQDSgfuoP0XXSh6Pt+enVk+DojL2FrvXBYByDd3WUAr
         +23ciwdshyyN2KKVv7fhaiUMov5gDFv+gzWZo3ZrJNKw4s29JKg8mnK7IgBgPsIJOy
         ngdVCGj6ZrmBA==
Date:   Sat, 25 Mar 2023 11:57:13 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Jesse Taube <mr.bossman075@gmail.com>
Cc:     linux-riscv@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yimin Gu <ustcymgu@gmail.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Waldemar Brodkorb <wbx@openadk.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH v3 0/3]  Add RISC-V 32 NOMMU support
Message-ID: <f7df17e4-e05e-4b66-8b53-72b90d13eecf@spud>
References: <20230301002657.352637-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EDBkoLcIyrEpbBAz"
Content-Disposition: inline
In-Reply-To: <20230301002657.352637-1-Mr.Bossman075@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EDBkoLcIyrEpbBAz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 28, 2023 at 07:26:54PM -0500, Jesse Taube wrote:
> This patch-set aims to add NOMMU support to RV32.
> Many people want to build simple emulators or HDL
> models of RISC-V this patch makes it possible to
> run linux on them.

> Jesse Taube (1):
>   riscv: configs: Add nommu PHONY defconfig for RV32
> Yimin Gu (1):
>   riscv: Kconfig: Allow RV32 to build with no MMU

For these two:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

I'll add an rv32 nommu build to the patchwork CI once this lands I
suppose!

Thanks,
Conor.


--EDBkoLcIyrEpbBAz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZB7hmQAKCRB4tDGHoIJi
0lF/AP0Y0rYosV/eXnRN2ahOEPdVLjpABAgV4zSCmtNkuR6BjQD+O9RhKOyYg0N8
fkPU2E1AIcKWuhjQStoFFCCEgX5hjAc=
=ShSr
-----END PGP SIGNATURE-----

--EDBkoLcIyrEpbBAz--
