Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17592738F00
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 20:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjFUSlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 14:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjFUSls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 14:41:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5273D185;
        Wed, 21 Jun 2023 11:41:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D95916169F;
        Wed, 21 Jun 2023 18:41:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F37C433C0;
        Wed, 21 Jun 2023 18:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687372906;
        bh=6KYc2c7oOXRFu/RZ/MRT/iHTPpfsspYLvcXsDKK4hIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OGDacF/ao4XnsWMMhLyxJ/uT4j5P7EXb4aQf6lEEUMhsmXn70wxs3di7suICOdVtl
         ekD4+GH1CSJujpJh3ZzPklVMoJXRZwQgXQPMdm1axhHl/zfNBhmCZaxyFNdBoce7KF
         cSA2Gifa8WlgJvXjBwVrDz7PiGevwvy6VsSIJMBXlYvEmDnEoog9T8ZgY0JdV6BTAq
         REBNkULqbbUuNJ9ImJZR8aPHk8QiktVVBRXgFq1ljZfvDJjEv/mp/mYh70YkMEVont
         4Kv81FZaPzeyd54oLvqq0p4WoBpG6NV28rX8S94/ead3rPrrSAHXKRk8ALqc46eUGa
         g/tL0sAA9/bCw==
Date:   Wed, 21 Jun 2023 19:41:42 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Guo Ren <guoren@kernel.org>, wefu@redhat.com
Subject: Re: linux-next: Tree for Jun 21 (riscv/errata/thead)
Message-ID: <20230621-sandal-jogger-5dd9618daa85@spud>
References: <20230621145917.3635a2f1@canb.auug.org.au>
 <14aa23d6-b4c2-190f-0d6c-22a82befa04d@infradead.org>
 <20230621-playoff-wireless-0dcfce9711ff@spud>
 <ab38f6af-cb68-a918-1a63-2e7c927a8ffc@infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="n8FVmxrgiZgPXLh3"
Content-Disposition: inline
In-Reply-To: <ab38f6af-cb68-a918-1a63-2e7c927a8ffc@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n8FVmxrgiZgPXLh3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2023 at 11:40:31AM -0700, Randy Dunlap wrote:
> On 6/21/23 11:31, Conor Dooley wrote:
> > On Wed, Jun 21, 2023 at 11:25:14AM -0700, Randy Dunlap wrote:
> >> On 6/20/23 21:59, Stephen Rothwell wrote:
> >>> Hi all,
> >>>
> >>> Changes since 20230620:
> >>>
> >>
> >> on riscv 32-bit:
> >=20
> > Is XIP_KERNEL enabled? And if so, does this fix it?
>=20
> Yes. and Yes.
> Thanks.
>=20
> for your patch:
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Great, thanks Randy. I'll do the needful.

--n8FVmxrgiZgPXLh3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZJNEZgAKCRB4tDGHoIJi
0jlTAP4/F12XTZhuHgwt102bym8iyOdB1MY/FBYlYRfBpSwHgwEAzZvzJlTGAENb
KBXx9mVrEzkGqnq1LlGiSrhthEc7TQk=
=Um3f
-----END PGP SIGNATURE-----

--n8FVmxrgiZgPXLh3--
