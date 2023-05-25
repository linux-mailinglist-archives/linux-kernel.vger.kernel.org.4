Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6F2711521
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242005AbjEYSrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242573AbjEYSou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:44:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A60126AD
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 11:41:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A960860B37
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 18:39:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD99CC4339C;
        Thu, 25 May 2023 18:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685039997;
        bh=OkYQrOPk4PyK08Uym+XIxvDDLcqyKIRZcZ+rbE78SC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dp1Ur0bqJyfLFJbG2S67Ujk/FXHuqKGqnRUxLVhqBXx7hh+HRvzW1YdZ6bCWmnO1z
         BL/LkECCriwQnFZpLt8PYiB0U+YwEO/PZ5OOfOGALYctBYqQKZ1FKoVWasNDEH9+sa
         3xra4uDwx9azEuN9ZiYepBEhza6dGDYCkAl0w5lQ0jCmlE9B2O12AmYeGZT4yKAKyQ
         pjka0kA2D0NPmAPgUhZ5bD3dHQ51g8uOPKlgrrP6N8j/xi/11ptBYICCbu5QGyEbny
         s/uoD5eMVfpfqqOObrgbXCnj98eNhpF9c2cNoC+LGVYfMuu5iSgYUhFTk8m/9yxsxb
         yhOU/GT+XRAow==
Date:   Thu, 25 May 2023 19:39:51 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Atish Patra <atishp@atishpatra.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Anup Patel <anup@brainfault.org>,
        Anup Patel <apatel@ventanamicro.com>,
        Alexandre Ghiti <alex@ghiti.fr>, robh@kernel.org,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        jeeheng.sia@starfivetech.com, linux-kernel@vger.kernel.org,
        palmer@rivosinc.com, leyfoon.tan@starfivetech.com,
        mason.huo@starfivetech.com, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Song Shuai <suagrfillet@gmail.com>,
        linux-riscv@lists.infradead.org,
        Andrew Jones <ajones@ventanamicro.com>
Subject: Re: Bug report: kernel paniced when system hibernates
Message-ID: <20230525-desecrate-imposing-d97ab34e06ad@spud>
References: <20230525-guacamole-swimmer-68048a73baac@wendy>
 <CAK9=C2WUyLxZwQO37cN-i+V+A3yxmEoaj=uE8yR8nseYTDW7oQ@mail.gmail.com>
 <20230525-postnasal-monopoly-98adb96ffaa1@wendy>
 <CAAhSdy06nQh4H1FP_K_-VF462mhj+F2M=4AV4QSCUGe5XVqX0g@mail.gmail.com>
 <20230525-shrapnel-precut-26500fca4a48@wendy>
 <CAAhSdy3SqeLdAfaojUki=ht21nr4ZUPMkW_t9M6ntQCt6Ds4Nw@mail.gmail.com>
 <20230525-citric-waged-a2f78d27eb0c@wendy>
 <CAOnJCULfC0jmiucLNMeJZwJf4QbGAN6r4B-ubUbP16KVpxrCfA@mail.gmail.com>
 <20230525-flaring-trading-f2bf0713ae26@spud>
 <CAOnJCUK_EgX-En1QNS8yX1WA1nj8w2kpvXMQcvgWuR3dvzEQYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="iJ4+DQXsDg97Xef1"
Content-Disposition: inline
In-Reply-To: <CAOnJCUK_EgX-En1QNS8yX1WA1nj8w2kpvXMQcvgWuR3dvzEQYw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--iJ4+DQXsDg97Xef1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 25, 2023 at 11:37:40AM -0700, Atish Patra wrote:

> Any testing of hibernation still needs to revert the patch until we
> have the proper fix.

"the patch" is what exactly? I assume you don't mean depending on
NONPORTABLE, since that is a Kconfig option.

--iJ4+DQXsDg97Xef1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZG+rdwAKCRB4tDGHoIJi
0kJsAP9eqnY5SZu39gUcRNcAWMbMCXWw7Ec+mpD4rdvpRQvt7QEAqHgS2ADQ+RHj
6zsURS+xf694dQKGktiCuRbJdHQGLAY=
=6hRR
-----END PGP SIGNATURE-----

--iJ4+DQXsDg97Xef1--
