Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B2EC6EA9D5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 14:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbjDUMAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 08:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjDUMAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 08:00:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5218E;
        Fri, 21 Apr 2023 05:00:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64D2E6501B;
        Fri, 21 Apr 2023 12:00:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B322C433EF;
        Fri, 21 Apr 2023 11:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682078400;
        bh=2wci7r9WH9t7CX0RAg9raWznjhJH00a3SCz5xvr2M6I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DYYm/zOnCWvyrbUwywcgEA2F7liP6NWxK8bPC4jd34t6XcPHysXR5WFocWIjCyuJW
         lz+WvETboPI3fGBtTpG5o2OgSjuaRgDB8ZZeU0C6anj8SRE8byTq61cV1cNKVuwZ1l
         V06FVptO6B8KE1ZNgaoXdYIQrTybue4VGdtBx/pWxO89SP40rtkXBT7GbAYs6fTGpX
         jW3/Cg+4Z3UUFNYDXQ7GJ8vgnni3AZFXTyPU5is1Uu0cVyUWTu4R0YQzlgvP9W3/Te
         bSYYucXlL5ExFFUqQA0rMomvfI0/PUgcoYEGgDKAwR71U1vUKXC4ucf0Zz7P7tZmtn
         VIKI9pcosP9Ag==
Date:   Fri, 21 Apr 2023 12:59:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul@pwsan.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: linux-next: manual merge of the risc-v tree with the
 risc-v-fixes tree
Message-ID: <9e8160e9-0c59-4567-aa5e-de6a563f631a@sirena.org.uk>
References: <20230420124048.65232-1-broonie@kernel.org>
 <CAHVXubjeMX2Z2jX4kYfXRqb+DiR6-E8PGb+m0MnVN-aTW4hfkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Bw2wcQW5FAv6qDBp"
Content-Disposition: inline
In-Reply-To: <CAHVXubjeMX2Z2jX4kYfXRqb+DiR6-E8PGb+m0MnVN-aTW4hfkQ@mail.gmail.com>
X-Cookie: Hailing frequencies open, Captain.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Bw2wcQW5FAv6qDBp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 20, 2023 at 03:23:55PM +0200, Alexandre Ghiti wrote:

> This does not look correct, fixmap setup should not be in
> create_linear_mapping_range() function.
> Please find below the diff I would apply:

There's actually another conflict in the riscv tree come up today so
I'll roll this in.

--Bw2wcQW5FAv6qDBp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRCeroACgkQJNaLcl1U
h9CD3Af9FciQnqt/9gLGtd2EgVqkmooXNSztJLD7i5hgZ2AwNKFLeKcj28Y+LpSi
jVOYYQtQIbcQmdlt60vgvJRz0Ud3bfL9ak+2twchVwGWZjcxfsQdVjEDq8lGLGkx
yVvrukok9xfV9E3ijT1fewZL8X+NSnOhQxSrOIZvyaV3koIesnIgMrwl5iYyCGN1
Fc/rNj635JEF4F/RnZXLEd5TG5zFVPyTSxJvAhc7oBgvnBqDrNaLMbDVaSHmxWmQ
GDzSbA0u/pUBQ/HdQBeWMHJaKpVngmEsSsFaNd6PZAVzY42kiSjeijmj7PIg8GpK
qwMNTkmFk81LRkCHZfOLPC89PsKpNA==
=2fMy
-----END PGP SIGNATURE-----

--Bw2wcQW5FAv6qDBp--
