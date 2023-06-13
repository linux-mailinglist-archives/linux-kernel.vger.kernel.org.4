Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E05572E8D2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 18:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbjFMQuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 12:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjFMQud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:50:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B824AEC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 09:50:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 943706364A
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 16:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A759C433F0;
        Tue, 13 Jun 2023 16:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686675031;
        bh=Nv1pXyuTqEu6mOHPgx8NQsMlkyzGVtvusfjtLrcedoY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wmp6ZRO0Qu+0rQJ0/0qe3l7hbvU5M1ltWeIjgpcgqbmyAKZRUiYH0sA6M7b8VPl2D
         9apYHFu4qbMH8R/ZBJQf0Spwff/twYMbFF8zluCYSm46KR1n2r6+lZtytQoA3Hfql3
         Z5zApMApymCOxfUY0+lAfEKPF5ltFqXiCUBSN8i2lWPT0kHCSDyiQ7hU+vFZW2r487
         OXZIPpxC06ZWfNOYmIaWwytWoW80ouCQ+1NBnthlRlJWyZjYDD6/j5eSVnLjT1nZvD
         ATeOwDF4pZwM8DlpfYTE2EOr6yW12Lq7ozwGC22lXmm4C2QHSjSawRtGB6GxD6IWQv
         AlPVN+PRZBO3A==
Date:   Tue, 13 Jun 2023 17:50:25 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Nylon Chen <nylon.chen@sifive.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        jszhang@kernel.org, conor.dooley@microchip.com,
        ajones@ventanamicro.com, aou@eecs.berkeley.edu, palmer@dabbelt.com,
        paul.walmsley@sifive.com, greentime.hu@sifive.com,
        zong.li@sifive.com, nylon7717@gmail.com
Subject: Re: [PATCH] RISC-V: Support 32_PCREL relocation type in kernel module
Message-ID: <20230613-geologist-rasping-e3ff17bf3906@spud>
References: <20230613072644.10487-1-nylon.chen@sifive.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xYzP2JSiD7E4tKSI"
Content-Disposition: inline
In-Reply-To: <20230613072644.10487-1-nylon.chen@sifive.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xYzP2JSiD7E4tKSI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 13, 2023 at 03:26:44PM +0800, Nylon Chen wrote:
> Signed-off-by: Nylon Chen <nylon.chen@sifive.com>

You need to write a commit message chief :/
E.g., explain wasn't this needed before and is now.

Cheers,
Conor.

--xYzP2JSiD7E4tKSI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZIieUQAKCRB4tDGHoIJi
0gLpAQDPRjGUMu1+/upVQjqGeEGrhPoeaMmtMSIOV4D8fcCa6QD/VP9jfr4RQo7S
sVUkaur7Pm2HtETlRNbQRwBAQ1NH2go=
=8bSn
-----END PGP SIGNATURE-----

--xYzP2JSiD7E4tKSI--
