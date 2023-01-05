Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A678065E4A7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 05:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjAEEYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 23:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbjAEEY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 23:24:26 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8A52022;
        Wed,  4 Jan 2023 20:24:22 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NnYJc4PM9z4xwq;
        Thu,  5 Jan 2023 15:24:16 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1672892656;
        bh=inJyJCqiWzHk0JzynpeKQP7oe6kxOhHM+/cNAhtPyS4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CiYxeul2kN7IevDLclAcr6iDRS1N/a7r6g9FWCPABDiv/8XNdUGniyC8ZCvCzM6kY
         jQy5W7QbqN+rjiRq6HU2xJvBYtNcsKaTFtrydHKFH48t9xVHpCqfCigT0tLxY93z0f
         oQ61teXAHGd+vSTFc2UhUrZTtFPU6w/3HRrrzCK5W65uS2Yn4tzcb99qqDSL7HBzJ6
         0eds0fhRpTAZ0cu3fs9sM0FPc+oSXIUrcoXLI1PrZ5O5okw8r/qvH/rkLwWBA1wkQJ
         9pHhBvKxDGqRMV+/0cy6LMuHqnP8GqZaiVo13QOwcQyq07jD/tkSjD26GQwNdDDz3S
         nGd2AyhfJ5YKg==
Date:   Thu, 5 Jan 2023 15:24:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kspp tree
Message-ID: <20230105152415.16b25e11@canb.auug.org.au>
In-Reply-To: <202301041920.74A1232709@keescook>
References: <20230105132535.0d65378f@canb.auug.org.au>
        <202301041920.74A1232709@keescook>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/a2YJ3TfZjW_B0xsLZeadwtj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/a2YJ3TfZjW_B0xsLZeadwtj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Kees,

On Wed, 4 Jan 2023 19:22:14 -0800 Kees Cook <keescook@chromium.org> wrote:
>
> Yes, that looks entirely correct. Are you sending that separately, or
> should I carry it in my tree?

Please add it to your tree, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/a2YJ3TfZjW_B0xsLZeadwtj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmO2UO8ACgkQAVBC80lX
0GyR4Qf9GruifbVfdDhyBlqL/ljnsaLWzf9cl8WOsZ5BWDmTmLlMcGXGvZUf19dG
TKEJamDLBuZIx/PJaNVsRimGiM9NYCi/KHea6biCwkNcVIj8CEntBW6vcfyV5wQO
jP/RjdTxw1jqDirMOXS1VsRKkpc24MXCbZ0t58utzK+udizki3n3yS6ph38Ca7ul
7q3wF2LJyaUMVFRnAkA00PYb8JFoHUnQ/4KoY8gszBfesgCvdkIwLJ+8loZts7Ua
VAwtRCwQNgaRqW4EfZJjHCZjbgOh3WGR6pMjJv4X2e0yXCqvZv7jWBpmnD3EKZMN
CUlkf600fOphYO2Xuxv+D6SAJYb+Rw==
=i9XB
-----END PGP SIGNATURE-----

--Sig_/a2YJ3TfZjW_B0xsLZeadwtj--
