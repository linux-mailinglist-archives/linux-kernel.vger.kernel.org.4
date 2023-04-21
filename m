Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70906EA974
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 13:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjDULkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 07:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjDULkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 07:40:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E11BB8D;
        Fri, 21 Apr 2023 04:40:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DA5A64F07;
        Fri, 21 Apr 2023 11:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53D1C433D2;
        Fri, 21 Apr 2023 11:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682077214;
        bh=wCHuUBF9AL3TW0Lp9cVkBSjUPDIH4u2zFJIc/u4LnIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kLHoFpxQYbkRcCbKHyPuyjpjy/IrQMOfXEW6R470c0p7LKNTUEPAi0qI//MUl9wWc
         MJCVvGpy9MoGJttgB4l33G/d8Tg6jvtr3BBbf75nm3CSt9y+0AQ6Wz4DiNyBhLddFv
         SZN/HzXA05+9vlLc2iEXQmaymmeYQQHc6F3xKn981u77QVc7cj463fqSrBHWZDCfpH
         H6ZNFbvChLwrQBmKdCiwex43l1S4sAuaMiYgaqWF/9/3iC069w1nl3F1YC/p10CMOX
         mFWbmn+cmMCEKAR/7hE8KFPz4BFSUd2t9Exg1BkQU85KGcQk2usABy+BdhoAg0h4dk
         bYp8VfoRAtNVA==
Date:   Fri, 21 Apr 2023 12:40:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul@pwsan.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: linux-next: manual merge of the risc-v tree with the
 risc-v-fixes tree
Message-ID: <1db8bb94-022d-4b5c-af8e-f0dfd1e694a9@sirena.org.uk>
References: <20230420124048.65232-1-broonie@kernel.org>
 <CAHVXubjeMX2Z2jX4kYfXRqb+DiR6-E8PGb+m0MnVN-aTW4hfkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SOxGwS+eI0rZpAoZ"
Content-Disposition: inline
In-Reply-To: <CAHVXubjeMX2Z2jX4kYfXRqb+DiR6-E8PGb+m0MnVN-aTW4hfkQ@mail.gmail.com>
X-Cookie: Hailing frequencies open, Captain.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SOxGwS+eI0rZpAoZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 20, 2023 at 03:23:55PM +0200, Alexandre Ghiti wrote:

> This does not look correct, fixmap setup should not be in
> create_linear_mapping_range() function.
> Please find below the diff I would apply:

OK, if it's opportune (basically doesn't require redoing huge amounts of
work) I'll replace the merge with your suggestion but I'm not sure if
that'll happen or not.  Probably best to highlight when sending the pull
request to Linus.

--SOxGwS+eI0rZpAoZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRCdhYACgkQJNaLcl1U
h9DXnQf/ehoXVw3yHA/rG/uIW+Pt4AeaDAz1WdyJmwCyC66SyLRIU56r8UtXDObo
7FqEvZdjC1hY803ifuhVim1oQw/t0a33u9pgzoWFgKoUukaB3TpAYAnR/dh4n6GW
jNT4uVCxO0Uy3aV204BLx1nqV7DUW9EBWGs+ZzTJ70Xc5HgjuA2szvdnd6Rbfk9Y
3xxs/Kkhx0+HEuGdapsc5Esvq9/hL4u5wtVM1mJdp8BMflAgSHl3Y1MLD3/3+Zka
aShOASaj0aHNNc0DTlyp9LTJmcVPyPZWoM/n9tT9rivaO/RGRrKg0EhVvdCOtslG
1kaI2bQpj4VvukTHD5p8w0cjc31+Eg==
=w8AR
-----END PGP SIGNATURE-----

--SOxGwS+eI0rZpAoZ--
