Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94544656AE5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 13:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbiL0MXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 07:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiL0MXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 07:23:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BD3D10D
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 04:19:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4CCC5B80F91
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 12:18:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C8AC433D2;
        Tue, 27 Dec 2022 12:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672143533;
        bh=X+nWZewsPZi5jNva7XDOfTTkTv/8B1D3eHlqIFDb1U4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CiOXFuLegsNSE6MQHX1/c5nNMDWtt+Va/LS6d7WmXx3Pb1M2vIzqknOm2J3l6peC2
         fZsEiPu0sSAOtq/OIjwL5mnxC9XHwR8CWTqSPeT19UwPbPjNVcqj5vh+mKuHeC0Wop
         ZauEtBY6rfLgzhJhBw85cEkumJEqQXDPvYagpeB55YZ825ueE+H6mCynICheDqYCZV
         RKH9Rnin6xpUAJvUYA0KjLrwrzUWi46sHx0Vkhouzmo4r9LFSocwfl4uJMpd5vnF9u
         d/TB4wbKqNcH9wwkOpx6IkvwhuUx5INH+jzyuFUYaAZhRpj+Awt00PIHtxJwkHv04V
         RszDDPbEz+pxQ==
Date:   Tue, 27 Dec 2022 12:18:48 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Icenowy Zheng <uwu@icenowy.me>
Cc:     Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] riscv: errata: fix T-Head dcache.cva encoding
Message-ID: <Y6riqKjhKhDqPp8d@spud>
References: <20221227020258.303900-1-uwu@icenowy.me>
 <CAJF2gTSGvEnTqEqR9f+zU8T3VS8FoCtsgSk=9hz6cWxAL630zQ@mail.gmail.com>
 <2c3bf520dec7e368f5b98d7c17811f027921dfa8.camel@icenowy.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cA3k6P0AnyBAVulW"
Content-Disposition: inline
In-Reply-To: <2c3bf520dec7e368f5b98d7c17811f027921dfa8.camel@icenowy.me>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cA3k6P0AnyBAVulW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Icenowy,

I can't find this patch on lore or patchwork, (although the replies made
it). Would you please resend it once the discussion has died down?

Thanks,
Conor.


--cA3k6P0AnyBAVulW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY6rimQAKCRB4tDGHoIJi
0gfVAQDWi8TDIgS+3ggBNtzQLu6IvFpAh32T0jjw1ehKU703UAD+Je2ehtZz4KXC
yRPdYcnr5urETjAbgmqNytV0BXf92wc=
=kYz1
-----END PGP SIGNATURE-----

--cA3k6P0AnyBAVulW--
