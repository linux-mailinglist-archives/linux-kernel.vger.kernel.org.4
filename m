Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D9367C2D0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 03:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjAZC0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 21:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjAZC0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 21:26:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A86A62D0A;
        Wed, 25 Jan 2023 18:26:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CEBC6B81CC0;
        Thu, 26 Jan 2023 02:26:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545B6C433EF;
        Thu, 26 Jan 2023 02:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674699999;
        bh=hRqabsnyUFGuScHCJ+vG+5iY/BKBmahVGELxsL9cqVI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=uOek77d+d4DOP0WXkE3uKIY7HGNkI3/B+pUaog8LdAfohV8dKQ/aHbC7R9zq3p1XC
         P9YUh9dlaTAAqpqBMoCzJjxFIyWgmdJ2AMkKEunyn7zP9ioKzE9t/W2Zd+elhxEQl7
         pEd3lG5q8HhpWeBj3/bj50JFeyADHfcpTFbumiGI+CgcOoxLWvcgebWAUWmfAdCiiv
         FDe9sy5LlYXhe1dViUHWmMJdA+UjjMLhrDJf/y7QVoyIpDj5CGHJjI0XZv92dsfqb5
         xvmR7mw5MmN95eSYT0OqfBtLaO88CRDR+zmXxdtBwB9rHJ401e/ILICWoc86jrAger
         Vs1k7y+42bSEg==
Message-ID: <2fb3e7dcbedf22d054e3fb48596d41e2.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3dfa96e2dba814930445e8dcfae97e89.sboyd@kernel.org>
References: <20230120092053.182923-1-angelogioacchino.delregno@collabora.com> <3dfa96e2dba814930445e8dcfae97e89.sboyd@kernel.org>
Subject: Re: [PATCH v4 00/23] MediaTek clocks cleanups and improvements
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        fparent@baylibre.com, chun-jie.chen@mediatek.com,
        sam.shih@mediatek.com, y.oudjana@protonmail.com,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        ryder.lee@kernel.org, daniel@makrotopia.org,
        jose.exposito89@gmail.com, yangyingliang@huawei.com,
        pablo.sun@mediatek.com, msp@baylibre.com, weiyi.lu@mediatek.com,
        ikjn@chromium.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mturquette@baylibre.com
Date:   Wed, 25 Jan 2023 18:26:37 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2023-01-25 15:09:40)
> Quoting AngeloGioacchino Del Regno (2023-01-20 01:20:30)
> >=20
> > * Some more spare cleanups here and there.
> >=20
> > All of this was manually tested on various Chromebooks (with different =
MTK
> > SoCs) and no regression was detected.
> >=20
>=20
> Do you want me to pick this up directly? Or is there some mediatek
> maintainer willing to send me a PR? If I don't hear anything soon I'll
> go sweep my inbox for mediatek clk patches and start applying them.

I applied them all locally and will push out to next soonish.
