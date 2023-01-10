Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5405664CDA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 20:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbjAJTzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 14:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbjAJTzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 14:55:43 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9C012D06;
        Tue, 10 Jan 2023 11:55:42 -0800 (PST)
Received: from [IPv6:2a00:23c7:6883:e501:329c:8425:8e97:eae9] (unknown [IPv6:2a00:23c7:6883:e501:329c:8425:8e97:eae9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: obbardc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 475C66602D29;
        Tue, 10 Jan 2023 19:55:41 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673380541;
        bh=h93q8fATA0vHzK9NLlM/VLoX4onwSG8abSVypH1iTYw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Ggj9DrDoeacXy6btIJ3KG/jZAoLaHc7MpPJquOq6+Wto41mowzJsa50R4CqkbvEEE
         y1NGMesA6FS1tV0pyWIfevQRKGf3iZf4kcEh4kKJTjRxD6IgCeIZAdsqVY6BbOSRT7
         eetXxAhoOBh6QwFx4NH8JIhtjY2jTHPW64V+vKGRKECvaCCtsrxD8yi7MC9tAI8/m9
         hlk6CdL11N80ywYqixomMXlAJPtRd80NZDgOXT64Mlxn3aSVV8nHQFEhY/Pl+bGH/z
         GyiF0VOcdU7uVVGjT7E/j982Xco1aL68S2FxGqhDiclry0tPQYRx3ULjAftkaxnjgN
         5MCgn0dr1yo7A==
Message-ID: <7843211667a5f8451bfe5f37533c9b5896b589ac.camel@collabora.com>
Subject: Re: [PATCH v1 1/3] arm64: dts: rockchip: Update sdhci alias for
 rock-5a
From:   Christopher Obbard <chris.obbard@collabora.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Date:   Tue, 10 Jan 2023 19:55:39 +0000
In-Reply-To: <615a84c8-0b5a-8f3f-517b-af1feea6d005@linaro.org>
References: <20230110155252.189300-1-chris.obbard@collabora.com>
         <20230110155252.189300-2-chris.obbard@collabora.com>
         <615a84c8-0b5a-8f3f-517b-af1feea6d005@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-01-10 at 20:21 +0100, Krzysztof Kozlowski wrote:
> On 10/01/2023 16:52, Christopher Obbard wrote:
> > In the previous version, the sdhci alias was set
> > to mmc1: an artifact leftover from the port from
> > vendor kernel. Update the alias to mmc0 to match
>=20
> Please wrap
> commit
> message
> according
> to
> Linux
> coding style / submission process (neither too early nor over the
> limit):
> https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/s=
ubmitting-patches.rst#L586

thanks
for
the
hint - I sent V2 and will hopefully make less awful Haikus in future ;-
)
