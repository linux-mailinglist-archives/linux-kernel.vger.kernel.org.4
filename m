Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5386F4796
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 17:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbjEBPuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 11:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234568AbjEBPuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 11:50:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC0110D
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 08:50:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C8BD61BAF
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 15:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF46BC433D2;
        Tue,  2 May 2023 15:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683042611;
        bh=k8+oW+51xENwgNdUXvTvm47eDCum6/VnO8eP1zVUl+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gy5Lek3tK/bmDJBhthXuIcHMInG9GSwUMxV+5g4hX7itpcVyK0RHc7QX7HQFb1GP4
         jMl484jwz209ishRLILEdEvgqSIKYgSuwTlkaz2758LSrYzBj291ax0IlbKM03f6IJ
         12hNFuPoUTmAl7y7h3B+yQwb96KkVg/jaBsvASpPoLJDEobr05O9TMiaXumiKugH0D
         REruZzwy/++Q+jiBjnf2xcUnPISh8YTXAtDglKlxUD4ImXcy0h653DuYhlb/7yZRnx
         sKPjioqeEoUM5oq05j2Ef0Q6ZuVQTWMb8QDUquLJGBuowubjZ3zHriJLGE7UsLFw33
         AM3B9ogQjM54w==
Date:   Tue, 2 May 2023 16:50:07 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Evan Green <evan@rivosinc.com>
Cc:     kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Conor Dooley <conor.dooley@microchip.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: arch/riscv/kernel/cpufeature.c:34:1: sparse: sparse: symbol
 '__pcpu_scope_misaligned_access_speed' was not declared. Should it be
 static?
Message-ID: <20230502-undrafted-divisive-5d75da090b59@spud>
References: <202305021414.EuPdM9kv-lkp@intel.com>
 <CALs-Hsuw5WCmphzFNEnM5dRzqvoBscppcKb2ukVrU+uyGXBedA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ZPGLtlGzkkJfrFeM"
Content-Disposition: inline
In-Reply-To: <CALs-Hsuw5WCmphzFNEnM5dRzqvoBscppcKb2ukVrU+uyGXBedA@mail.gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPGLtlGzkkJfrFeM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 02, 2023 at 08:42:49AM -0700, Evan Green wrote:
> Conor, this one was fixed by your patch to include cpufeature.h in
> cpufeature.c, right?

Aye. Surprised to see the LKP sparse working, but
"v0.6.4-39-gce1a6720-dirty" probably explains why!

--ZPGLtlGzkkJfrFeM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZFExLAAKCRB4tDGHoIJi
0uheAQDW8toySBi/iUo0e0dMBAG5aFqwm305S4ORRRma5/5kjQD/VMPY54ijhDxs
2aXqYlTsQvIwsjq+k8h8jQWxmrhEEAY=
=I3x2
-----END PGP SIGNATURE-----

--ZPGLtlGzkkJfrFeM--
