Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5C1A71689F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbjE3QFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233193AbjE3QEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:04:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60193C5
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 09:04:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BD7A6151F
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:04:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EFAC433EF;
        Tue, 30 May 2023 16:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685462658;
        bh=Yj69QmTWwK6cmsHTZFVFghAHG3NQrjqLp245ggwaSko=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F1Xwpl1QOZYc5ci7nXYqKDdlB8S4ZH6uz7o3lQGZAZD1cb5YTh9CBESw1MwBgYTCX
         SKQtnh+f9FH7tXpKmOWaPhjMK52r8hjO01ISa6zr0L9vnyLq0ru6L6Iw/4qw85u4R3
         fjOxEdT7phXlDABBTDq3mPZTB+h6Qvd6l+uuWbo0gdyOjD7wd25YeHRWONeDlnzacz
         5Scd+VmqqQggYRS793X7K7+6aQ4Jqtobxl7w1arcnk2arH2zneSdszdPMsfKxsmAdA
         HSLrC97IXggqagAoM1pg052p8o541U9IfLpG+O+uSR5eBefqT3yAGzxDifL6QIysDB
         Ws33qky6/gBcA==
Date:   Tue, 30 May 2023 17:04:14 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Andy Chiu <andy.chiu@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        greentime.hu@sifive.com, vincent.chen@sifive.com,
        paul.walmsley@sifive.com, palmer@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH] riscv: vector: Fixup modules compile error
Message-ID: <20230530-static-smith-96cf543bfda2@spud>
References: <20230529073845.2859178-1-guoren@kernel.org>
 <20230529-jasmine-amigo-6d01f6852b35@wendy>
 <CAJF2gTRSoZbexqka=_7nf4+dHZW2FGf++BiTMypfTbeoGAbUiA@mail.gmail.com>
 <CAJF2gTTzUfp7xDr8myA+xMcxGNEQ+XLEYMfoR91NShdBAQMu7Q@mail.gmail.com>
 <CABgGipXu7iq-J5v6GVMPrnHiGVLuMxabB0_hPb+o+04T2MAwpw@mail.gmail.com>
 <CAJF2gTR2fAkk1532VWmsWP5DSYN17ib80wa5QwwT=DC0LY9gGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wKgep0VmQpKYzP+E"
Content-Disposition: inline
In-Reply-To: <CAJF2gTR2fAkk1532VWmsWP5DSYN17ib80wa5QwwT=DC0LY9gGw@mail.gmail.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wKgep0VmQpKYzP+E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 30, 2023 at 11:37:38PM +0800, Guo Ren wrote:
> I just found Linux-next build is broken, so I sent the patch. It seems
> you've solved that. That's okay.

Are you sure that linux-next is broken because of this?
This series should not be in linux-next...

--wKgep0VmQpKYzP+E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZHYeewAKCRB4tDGHoIJi
0kXVAP9/me+cpNZ2EoHOp2pibeknmgHE+6JiDocXGYnp7HMhFwEA3/A7JlICORpJ
NaChZKEUEcSooaCXzu7RtqxCX7Fenwk=
=f3bL
-----END PGP SIGNATURE-----

--wKgep0VmQpKYzP+E--
