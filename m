Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16415F15DE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 00:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbiI3WLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 18:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbiI3WLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 18:11:48 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC902F2768;
        Fri, 30 Sep 2022 15:11:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DB499CE26BE;
        Fri, 30 Sep 2022 22:11:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74E6C433D6;
        Fri, 30 Sep 2022 22:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664575901;
        bh=jWEB/rLB4YuBED/9tszyVWJroTsFU3+z5EIjhz2gcPM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=HnYwT9bjmJ7KKe1kNE30DKjtaqP/oXYtkzYva1LOArVN3YvMC7/GD68i/sxbMxNTP
         7KmlnErLQHN0p9ONKqM9XzBXxVMpWJxxa5l91UE3g+F6pAGCz1nakEjApj7Cc7qIGZ
         hRYYC+5XvF17a2pIwP9uEFjZOPUJlpm2Y7xraptoXMCiK5UXaPduvSvJyyr3lug/pM
         8ga0OPv6HrOTmwPzQTQ6setSxsGezc+loy2bdS6ofbCW04RR+bMkNW0tOvAYcfpAh2
         fqIKyOrq9wUR6SGSFMe1GzqovpGFIiVHgpkwKYRpvd8CrpEphso6SgYpwp03rFTtTZ
         ABIX2UiZ7Uj0Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220822152652.3499972-2-msp@baylibre.com>
References: <20220822152652.3499972-1-msp@baylibre.com> <20220822152652.3499972-2-msp@baylibre.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: clock: mediatek: add bindings for MT8365 SoC
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <parent.f@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Fri, 30 Sep 2022 15:11:38 -0700
User-Agent: alot/0.10
Message-Id: <20220930221140.D74E6C433D6@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Markus Schneider-Pargmann (2022-08-22 08:26:49)
> From: Fabien Parent <fparent@baylibre.com>
>=20
> Add the clock bindings for the MediaTek MT8365 SoC.
>=20
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---

Applied to clk-next
