Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5DF724544
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237632AbjFFOHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237367AbjFFOHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:07:00 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD50E73;
        Tue,  6 Jun 2023 07:06:59 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 9E9185C0126;
        Tue,  6 Jun 2023 10:06:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 06 Jun 2023 10:06:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1686060418; x=1686146818; bh=ZW
        YxLXpwIqN3lIMQiG+E5JZqyRLLSTTKr6hHGJz4eoE=; b=ZhoFiBBHHqozMl9Xww
        zRPvoHzC8QjfO6bUoKb2inXskBsCb2mW4AvRnoEqNu613rWkesu7KcbB+kB9QHVt
        IF+2F5cYxFNi5CwiY17uvG8fIRXHskN5nwBTv8adKDO1qPsF6n/qSA5UcBFSstTU
        7q3IfGGI5nUCF9LcbD66nQJ09yq2Dg5aqehsXZhaTj5MwG5a2sgXh9kwJuY4mZFX
        McgXwdaPRm2/y62UkxxFXCXwWjJDbQWAXpikj6TdVNl9Tr3ixPsNin637A4XfGdq
        dacf49TCUxwwHJmlS5xhX64mlOWkSf1VGf5tIzXg5VTLn4Gn3/pk7m9eyWZeDMrn
        03Jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686060418; x=1686146818; bh=ZWYxLXpwIqN3l
        IMQiG+E5JZqyRLLSTTKr6hHGJz4eoE=; b=JpwJNUVdXVsxn2WdGNaUEgdefIsUI
        XvuRzFyYQIgrLatcR8dqWsaBrgK0UrIEMTsjHsn1v62fsZyuXn88kQojEWcDo3FE
        YfEVkHuKy4Jtj+sU/ltpmnalMjl8Als2J270bLELESrOP5USxbAZZaqK04dGaelA
        lRThb49T5z7yKXi5phLCpNtIZQJFuWFKNwefDZeVn6a9EY0lRYgpmnjYSHOhiH2v
        wgIwVnIMfewM8G2pr/bqbv3od99LAs4WqJiYCMimpRs3K6SHgMEfOyz0DNyioQs+
        EXPj7YAi5bN+Wf4a3LLQQUzz6AZ3MCXL5H4MSY17NupNbYamCiOI3m0Yw==
X-ME-Sender: <xms:fz1_ZCfDySLyL_ascxriCuNl-DITBWZqCTlSH_B_uBtbdAAmn4Pu7A>
    <xme:fz1_ZMM9JxdNifLIFJmaA_5aWWlZ13PNbGdav2_IXIUG_SDvvaoOPijQJX-NNaUpV
    MnUoNzVYUJQYqZ8_rs>
X-ME-Received: <xmr:fz1_ZDjWVh5pnApQVmt_XFCCIGEpUWggIi8oNS5-rTnwWWCTQ4slx0gRKBlMhKV3TL6A0B1pP8_4EoUS_E9w_fGDY0qFfYIkP88>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtuddgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlvdefmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredt
    tddvnecuhfhrohhmpefrrghtrhhitghkucghihhllhhirghmshcuoehprghtrhhitghkse
    hsthiftgigrdighiiiqeenucggtffrrghtthgvrhhnpeejgfdtleelvdeftdeggefffeeu
    feevgeejkeelgeeujeevveeufeeigfeivdejjeenucffohhmrghinhepkhgvrhhnvghlrd
    horhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    phgrthhrihgtkhesshhtfigtgidrgiihii
X-ME-Proxy: <xmx:fz1_ZP_x8j94IUAq0vNyR--OT7lFlwK9TFpUvg1K56xZcitv68Czmw>
    <xmx:fz1_ZOvnM_WOkMoEXeEB_oNE60FCsQLt2yfDw9BP1DTMi35M-aJz_A>
    <xmx:fz1_ZGF9ASGzJLIK4Ovp90snm2ez2OOOK8CygX3TrBHfF3aTq0uqSg>
    <xmx:gj1_ZJlCPLmAZUWPyl-uhUyIS8zVcWFKRo_Gjfn06js8Abw7ubQhAg>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jun 2023 10:06:55 -0400 (EDT)
Date:   Tue, 6 Jun 2023 09:06:53 -0500
From:   Patrick Williams <patrick@stwcx.xyz>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Billy Tsai <billy_tsai@aspeedtech.com>, jdelvare@suse.com,
        linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        lee@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, corbet@lwn.net,
        p.zabel@pengutronix.de, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [v5 3/5] dt-bindings: mfd: Add aspeed pwm-tach binding
Message-ID: <ZH89fXknZlhGmM_H@heinlein.vulture-banana.ts.net>
References: <20230606094535.5388-1-billy_tsai@aspeedtech.com>
 <20230606094535.5388-4-billy_tsai@aspeedtech.com>
 <35bf0a69-bcf6-ae35-eb3c-e74cfcf9c571@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="b9kntY5Oezf+TuoA"
Content-Disposition: inline
In-Reply-To: <35bf0a69-bcf6-ae35-eb3c-e74cfcf9c571@linaro.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b9kntY5Oezf+TuoA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 06, 2023 at 12:49:04PM +0200, Krzysztof Kozlowski wrote:

Hi Krzysztof,

Thank you for reviewing this from Billy.

The Aspeed chip is heavily used by the OpenBMC community and the 2600
has been used in production systems for almost 2 years now.  Many
companies are having to carry previous versions of these as patches, and
some of the APIs changed since the last revision from Billy.  So, I had
asked him to submit the latest patch set with as many revisions as he
understood what to change, since the conversation seemed to have died
since last time he submitted. =20

I don't believe Billy is intentionally ignoring your feedback and he is
motivated to get this patch set wrapped up into an acceptable state.

> On 06/06/2023 11:45, Billy Tsai wrote:
=20
> NAK. You got here clear comment. You cannot have simple MFD with
> resources. It is not simple anymore.
>=20

In fairness, Billy asked for clarification from you on this point and didn't
receive it.

https://lore.kernel.org/lkml/24DD1FEB-95F3-47BE-BE61-8B0E6FBDE20F@aspeedtec=
h.com/

He felt what he was trying to accomplish met the documented
expectations.  Are there some changes that need to be done in mfd.txt to
further clarify when to use it and when not to?

Again, we appreciate the time you've spent reviewing this patch set
already.  Thank you.

--=20
Patrick Williams

--b9kntY5Oezf+TuoA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmR/PXsACgkQqwNHzC0A
wRmTsQ//bK2vzp9XFuY+GPUMQGpWDdqT6j7sDHCU+IAOEkrOpM88FfU4PErhYBFO
VT5MWDXKbLBGB5PBE/lyGPYw4pyEEuBl9tSnVfPxQCcV+nvWabeW9HibdoG6J2au
Dm3A7FDm2wuBhdF6R9kI6vUxSMs4709R5vLr+iqFyUSPo065p8eK85LE23avU1SF
MnQZPcM+nP5HeWTLKOwjEOQ6ouQnGv+CmQAr21ZFuz4KajnMHBbXRDV6fouqLwgI
zXyDhK7iK843VRU8/dQDBmAI86XqZqkTG9hcSJjfWUyHmhMN7o3URTEP3ci6xae7
tIfdqQp3aiRhzHMI4oqJRs1kMDSSdRUk826AifALKRNM+ip6/WlIUqoE9VcZr3mN
fw4btAjo3NzkbRvrCbI9i+1pWk8wOqBQ8vx8TIyv6uAaRMCEQggtVDTJIiJttSPk
oKQgTdhI1fbFn7A4K1oHIA9MMsu5+imNYbMNtpGrXz8T2Gx1XRx+6B/vEz8EYHBB
4tbx4d0ziIeGs45mqSiIznBR8Wedo3XOe4eJJaWkUjaq4KQKiXj39S9H+XD4ASS+
EvUUqtHy/kblFWr500FtCp6lGri8iNJ4RrgpfPpEi9L/+cchbcT6AZIpN2R7wuL6
g5JsTh1Pr1XPkNqpHN/rHz8GB3bTIpz6rPBCqv4RJZr21sp/AMA=
=loqp
-----END PGP SIGNATURE-----

--b9kntY5Oezf+TuoA--
