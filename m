Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CA267C2A7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 03:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjAZCHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 21:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjAZCHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 21:07:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0CA3D09E;
        Wed, 25 Jan 2023 18:07:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB6666171A;
        Thu, 26 Jan 2023 02:07:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42852C433D2;
        Thu, 26 Jan 2023 02:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674698854;
        bh=F9namJy2H7fXeX9apQRVPaLcYLheAotswZx/3mZWdJk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ffGT4D6kPViviUTwSZ8BlwETgHtu2rGL/6yh5gVjCjxwvq5fAmOpf31iXyHwljbIH
         jwC2R7OpQdOETNo8LAPlmA83wlpq/P818izEeyitg3d0IZPCEQA1Xy5jrQsJBRfTpe
         vBsBINStVguX31vOtvT6n6v5Da0W6DVF4W4fxZFKbsn7+SkzXdqQjdBRnlfyds5SeX
         A8nfdUnyGMOyPXEQhG7nx8Tl4i5eBYH9P0vO/aj2UWXZVUY3NosLUSVi6Te1Oxxm2i
         +ykZoT4gnyoub/b/5S+1iRyUo+BQoknb2cBUYI2lQe+/1N083eo8zEnrcSPVRgI0M9
         Wo0/iSIZPLAIw==
Message-ID: <5036f36916e12429d6f853049a2e5836.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221222155147.158837-1-angelogioacchino.delregno@collabora.com>
References: <20221222155147.158837-1-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v1 0/6] MediaTek Frequency Hopping: MT6795/8173/92/95
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        edward-jw.yang@mediatek.com, johnson.wang@mediatek.com,
        wenst@chromium.org, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, rex-bc.chen@mediatek.com,
        jose.exposito89@gmail.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mturquette@baylibre.com
Date:   Wed, 25 Jan 2023 18:07:32 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting AngeloGioacchino Del Regno (2022-12-22 07:51:41)
> This series adds support for Frequency Hopping (FHCTL) on more MediaTek
> SoCs, specifically, MT6795, MT8173, MT8192 and MT8195.
>=20
> In order to support older platforms like MT6795 and MT8173 it was
> necessary to add a new register layout that is ever-so-slightly
> different from the one that was previously introduced for MT8186.
>=20
> Since the new layout refers to older SoCs, the one valid for MT8186
> and newer SoCs was renamed to be a "v2" layout, while the new one
> for older chips gets the "v1" name.
>=20
> Note: These commits won't change any behavior unless FHCTL gets
>       explicitly enabled and configured in devicetrees.

Can you resend this? It conflicts with your latest cleanup series.
