Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9E665C88D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 22:03:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbjACVDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 16:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230166AbjACVC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 16:02:58 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B8F2FD;
        Tue,  3 Jan 2023 13:02:57 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id F1F675C009F;
        Tue,  3 Jan 2023 16:02:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 03 Jan 2023 16:02:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwcx.xyz; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1672779776; x=1672866176; bh=pYyngyFrs7
        Swu2i/2VlLaaGYAQBCdORNkfqDSR3xksM=; b=l/YmnnipeDZZ5+YFg8xP+ROkZJ
        XdH1uUol2A8EGoopgsT7zwcBYik06W9s+VwVq2YREmDVQyKtD9ndW2I6hBkGKhPI
        8X1Q6+G7Cl5VkLSn7zA5Qe27NVuWEycb4alBhZqPyXheAVP+5H93S4KfJkFLiZkI
        lo4nmIlUsslEGZ3yPCO6H7xUlxUbxdoYycAQwev0LN4YpTye7oKsun3uX83DTTA8
        RUkkPW0NN6hqKxaPeiE6lB5kxB1hcD3UH+gUYjGrT8+igIlNL4n6fKZAkJPyOGPb
        oH/qAe81tUbxJOb0fxTCpdZkUARiBWtAEFmN94ZuETEycRvc2BTPJbL5E5fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1672779776; x=1672866176; bh=pYyngyFrs7Swu2i/2VlLaaGYAQBC
        dORNkfqDSR3xksM=; b=OqWdDdubCRRQivWCgD/irou7XUaCrVBTQd1rlVLf7orn
        QtBM1ts4nX59h6TDVQInr/znV8xCvFRbG+bflakrj6ljW5+YzX9/cSZIl4mv2SjW
        d/ZFFi0IViTEXBeRl1oKfVuyC9PiohN1id2LfukvRVKHsvNP7mu6bQ3zp5oXUc43
        UPa237dYO3TaW9szEeRQkOxzZnVrv9WXB21Dh+mO7+3xoB7wyHgx3EsYcWaOPMHX
        2pqZT2DbR24InzlDkFfTlaJHvTJH/pg5zZNocIuK5SY+o2WxV1nD3AAQdAYlAyXd
        IkV1qCMLorwIkrmV7ZLeI+Vkz+ULlssiCKP9JFO9KQ==
X-ME-Sender: <xms:AJi0Y7ali3MMr3ifZpRVdX9g5eQ9vS3ZF7GQpv8DJms1NOo-zA6WqQ>
    <xme:AJi0Y6YuFYkmVtQ6Rs9u4P6OjXoL8_n4HxOzh5Uy_pubS7ZELwyWrOJ5m7rMqy0lp
    ieEqqDdq7Yw8WKK1Kc>
X-ME-Received: <xmr:AJi0Y99YVlJcNszWitpGukskxBoSfwPM7tNgV8pjN43V_inzf8uUxERuw8frHUjcYvxYgkWgmCQG9CTq0VaYlzIFO7zw_0gaVwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeeggddugeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredt
    tddvnecuhfhrohhmpefrrghtrhhitghkucghihhllhhirghmshcuoehprghtrhhitghkse
    hsthiftgigrdighiiiqeenucggtffrrghtthgvrhhnpeehfeejheeftdejiedvfeekffeh
    ledukeduleelffekgfdtleduledvtdegtdehkeenucevlhhushhtvghrufhiiigvpedune
    curfgrrhgrmhepmhgrihhlfhhrohhmpehprghtrhhitghksehsthiftgigrdighiii
X-ME-Proxy: <xmx:AJi0YxqdEzdiXugT3g7nBMtQbSKEwCAtc4cgNhxTQZ9q3FYakoJ2Cg>
    <xmx:AJi0Y2oEu67kFDFixCyzh_q4JZBtlCGT8o3mbMSuWkvQi6mY7Td1Zg>
    <xmx:AJi0Y3S5NuqdR3Sb7_xc28stzxso6-dsEnv5S3XCP07RGgA6Btwf0A>
    <xmx:AJi0Y2KuX059OQLVvgIf-H15Qo4IkUSXrCzViYyA9VsyOt5Bs8HCxA>
Feedback-ID: i68a1478a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jan 2023 16:02:56 -0500 (EST)
Date:   Tue, 3 Jan 2023 15:02:55 -0600
From:   Patrick Williams <patrick@stwcx.xyz>
To:     Potin Lai <potin.lai.pt@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] ARM: dts: aspeed: bletchley: Update Bletchley
 devicetree
Message-ID: <Y7SX/6bsztulhw7/@heinlein.taila677.ts.net>
References: <20221226054535.2836110-1-potin.lai.pt@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UVVO6PfiOY+k50jH"
Content-Disposition: inline
In-Reply-To: <20221226054535.2836110-1-potin.lai.pt@gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UVVO6PfiOY+k50jH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 26, 2022 at 01:45:33PM +0800, Potin Lai wrote:
> Update Bletchley BMC devicetree.
>=20
> Potin Lai (2):
>   ARM: dts: aspeed: bletchley: rename flash1 label
>   ARM: dts: aspeed: bletchley: enable wdtrst1

Series is

Reviewed-by: Patrick Williams <patrick@stwcx.xyz>

>=20
>  arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> --=20
> 2.31.1
>=20

--=20
Patrick Williams

--UVVO6PfiOY+k50jH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEBGD9ii4LE9cNbqJBqwNHzC0AwRkFAmO0l/8ACgkQqwNHzC0A
wRnGEw/9GLCKw18/9q0D6SO1hROCCBqvYbyo4jUuPidxkMqJEe4Zl5/b4mh4qpqK
iDABYd4KO+tpTE2AAA2m0Z8LKuUcORzPOcXFuVQ8xZTVidjO1DDDx/YJGEU40/bI
MgEX7MCK02p99OAHOs1ycdRMkf4/dSv59x++ArFP4ngC6+Qxe81Y27gZUKk3kpK1
yVeCTeBpjNTgKdjaGdwymCTbD19VWYAs2+OaJS/GGsvGnIPNozFUb3jlXl7HdaU9
MgGsSpd7B4FHN+l2EDDPboqznpekOJfsSAd0bEnMoIcIShnng+0p9mGbL3+AI6Cr
iGkG1jkLJoXhS51WJp3RvOnNRJsU/+NxndYLPBOi0WoG1CSKWrUG0XroM2JSgOZN
fQLVe+Qkk70kgtUduB1Hf26ew6uhcZXFFMBRCGYBGeDKFz040LSsDNxexDm9AHkK
DjNgrPhXfgUhvqJkKf3RlA17qI6QVdXlMMt1IDc623vewSSgz/+itrz0nQ8i2TnN
zzipth+eN3ulI/CSi5I6BhdGhSIFVBq3VnWEC/32RwhJcbJSYZJp1JqPGkS3kr1D
gjIgRy6taxKzxZxlSTjaaiGr7P+YeZkvAZZmGkbSnx5mkJv4z5G1c2/LKpKMXljP
3cAHZ8XlasHm5xmzswRFz8QQqBnNiHwLT4jGuhfFky1niI84F4M=
=03aC
-----END PGP SIGNATURE-----

--UVVO6PfiOY+k50jH--
