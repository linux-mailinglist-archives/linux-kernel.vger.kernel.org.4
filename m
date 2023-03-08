Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40AAE6B0A97
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:09:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjCHOJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbjCHOIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:08:09 -0500
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314E01B2E5;
        Wed,  8 Mar 2023 06:07:25 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id CCD3720002;
        Wed,  8 Mar 2023 14:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678284444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=33EBWkqEWMsTEF83ZPwNzzm0AxSe+La9Qde3jKBW+ZQ=;
        b=l3bc+md3Q6sI36R/w2cStuusZFECsF7l5/UpgaA0ZIboxFlTikDg3ZBG7J2VPCiiou9ob5
        rErf5MpCDMq9d3LRfrm/n3SgFZ/SyI0hikw0oEZNDnZE0k+fsW+69dbxGcqdvk3C1NiKka
        2aXVHAIWcagMio9MG6jHn7xEMpJjqTHhPjAvLzj6JwhM8OfhcGZSt+KEveAZa9jibMRg3S
        f/iQN0i0qEZ9b2HHNR7wwT1/dsCuVfLNDmrnrFWaCaIMvWdJwlNI+G+QeCNsZGoBn9Vuv4
        k+etjelvtMXxN4gMFwjUl2uOC0eLt5axMvPKN8Bv7DbnSmkYMNtjLSW0Kaxc6g==
Date:   Wed, 8 Mar 2023 15:07:21 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Colin Ian King <colin.i.king@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>
Subject: Re: [PATCH v2 08/21] dt-bindings: nvmem: Fix spelling mistake
 "platforn" -> "platform"
Message-ID: <20230308150721.59ea37a7@xps-13>
In-Reply-To: <167823407854.511949.8644806672046927604.robh@kernel.org>
References: <20230307165359.225361-1-miquel.raynal@bootlin.com>
        <20230307165359.225361-9-miquel.raynal@bootlin.com>
        <167823407854.511949.8644806672046927604.robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

robh@kernel.org wrote on Tue, 7 Mar 2023 18:08:54 -0600:

> On Tue, 07 Mar 2023 17:53:46 +0100, Miquel Raynal wrote:
> > From: Colin Ian King <colin.i.king@gmail.com>
> >=20
> > There is a spelling mistake in platforn-name. Fix it.
> >=20
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  .../devicetree/bindings/nvmem/layouts/onie,tlv-layout.yaml      | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >  =20
>=20
>=20
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
>=20
> If a tag was not added on purpose, please state why and what changed.
>=20
> Missing tags:
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

I am absolutely sorry for dropping that tag, I took the patches from
the mailing list directly after an e-mail listing a set of patches that
have been dropped right before the merge window. I did not remember that
Ack when I performed that painful cherry-pick.

Thanks,
Miqu=C3=A8l
