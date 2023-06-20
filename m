Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7197C737684
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 23:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjFTVRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 17:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjFTVRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 17:17:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616A21730
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 14:17:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F201C6122E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 21:17:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1C7CC433C9;
        Tue, 20 Jun 2023 21:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687295825;
        bh=VSt5kV5zA9koKw+yON45/sHrnzDV4SzSWC86WRbHIeY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KQGv0q9HX7IhJ8yP+50t80IdMhMWRtzzvDXTZEhNbTJH3ZV0WdqcrShRSDg5Bjkwb
         BTfnQyNnkTAdD/JNyDqbqt13s6bOKsk62tuunQgHrTk+xC/nfCTIaBRLSkiJxXRAGN
         NgJfGtEduvDnd42gkm4qnCjJXNx4dsGlR0ca9gWwldikrLKFCKnzLnP+aXsaoD2Jtw
         Jz4VrM7ZNsxFA8G2eUm+xCa4UuUSQnlwsYr2afi+fFcitbgsPR+HoEthmk7IR9eWDO
         Z5RXRSQ5lagEeDiSAwmqS3wdbvWGwS4SHLfpc8dxuOA1QIKLZxOGIV6V2N8wCRk0nC
         BXhQjK+JT8RDg==
Date:   Tue, 20 Jun 2023 23:16:59 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Jesper Dangaard Brouer <jbrouer@redhat.com>, brouer@redhat.com,
        Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Eric Dumazet <edumazet@google.com>,
        Maryam Tahhan <mtahhan@redhat.com>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next v3 3/4] page_pool: introduce page_pool_alloc()
 API
Message-ID: <ZJIXSyjxPf7FQQKo@lore-rh-laptop>
References: <c06f6f59-6c35-4944-8f7a-7f6f0e076649@huawei.com>
 <CAKgT0UccmDe+CE6=zDYQHi1=3vXf5MptzDo+BsPrKdmP5j9kgQ@mail.gmail.com>
 <0ba1bf9c-2e45-cd44-60d3-66feeb3268f3@redhat.com>
 <dcc9db4c-207b-e118-3d84-641677cd3d80@huawei.com>
 <f8ce176f-f975-af11-641c-b56c53a8066a@redhat.com>
 <CAKgT0UfzP30OiBQu+YKefLD+=32t+oA6KGzkvsW6k7CMTXU8KA@mail.gmail.com>
 <699563f5-c4fa-0246-5e79-61a29e1a8db3@redhat.com>
 <CAKgT0UcNOYwxRP_zkaBaZh-VBL-CriL8dFG-VY7-FUyzxfHDWw@mail.gmail.com>
 <ZI8dP5+guKdR7IFE@lore-desk>
 <CAKgT0UfFVFa4zT2DnPZEGaHp0uh5V1u1aGymgdL4Vu8Q1VV8hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IDE08eaH4RavKRtY"
Content-Disposition: inline
In-Reply-To: <CAKgT0UfFVFa4zT2DnPZEGaHp0uh5V1u1aGymgdL4Vu8Q1VV8hQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IDE08eaH4RavKRtY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]

> > I did some experiments using page_frag_cache/page_frag_alloc() instead =
of
> > page_pools in a simple environment I used to test XDP for veth driver.
> > In particular, I allocate a new buffer in veth_convert_skb_to_xdp_buff(=
) from
> > the page_frag_cache in order to copy the full skb in the new one, actua=
lly
> > "linearizing" the packet (since we know the original skb length).
> > I run an iperf TCP connection over a veth pair where the
> > remote device runs the xdp_rxq_info sample (available in the kernel sou=
rce
> > tree, with action XDP_PASS):
> >
> > TCP clietn -- v0 =3D=3D=3D v1 (xdp_rxq_info) -- TCP server
> >
> > net-next (page_pool):
> > - MTU 1500B: ~  7.5 Gbps
> > - MTU 8000B: ~ 15.3 Gbps
> >
> > net-next + page_frag_alloc:
> > - MTU 1500B: ~  8.4 Gbps
> > - MTU 8000B: ~ 14.7 Gbps
> >
> > It seems there is no a clear "win" situation here (at least in this env=
ironment
> > and we this simple approach). Moreover:
>=20
> For the 1500B packets it is a win, but for 8000B it looks like there
> is a regression. Any idea what is causing it?

nope, I have not looked into it yet.

>=20
> > - can the linearization introduce any issue whenever we perform XDP_RED=
IRECT
> >   into a destination device?
>=20
> It shouldn't. If it does it would probably point to an issue w/ the
> destination driver rather than an issue with the code doing this.

ack, fine.

>=20
> > - can the page_frag_cache introduce more memory fragmentation (IIRC we =
were
> >   experiencing this issue in mt76 before switching to page_pools).
>=20
> I think it largely depends on where the packets are ending up. I know
> this is the approach we are using for sockets, see
> skb_page_frag_refill(). If nothing else, if you took a similar
> approach to it you might be able to bypass the need for the
> page_frag_cache itself, although you would likely still end up
> allocating similar structures.

ack.

Regards,
Lorenzo

--IDE08eaH4RavKRtY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZJIXSAAKCRA6cBh0uS2t
rLojAP4vEPyrpT81w5Pjsfhued/eWj+HL/TUK74YFhQg7gHJ7gD/TpqIHLpG45Tn
cY88letgy76oS6jrFFZlVyzqmkuDXwk=
=dC3S
-----END PGP SIGNATURE-----

--IDE08eaH4RavKRtY--
