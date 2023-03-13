Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44EE16B8113
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjCMSrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjCMSrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:47:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFF16597;
        Mon, 13 Mar 2023 11:47:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F3966144F;
        Mon, 13 Mar 2023 18:47:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A666EC433D2;
        Mon, 13 Mar 2023 18:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678733231;
        bh=PxjYWjSxJZWB5VRDbYxpA5+lpyvYAO+uDsREZCVGcxQ=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Cu931uiv0GBwRx+Hf7JyRCsBY0NzGuOB5Ooded7UnEa8PcztTKNTZ9lO0FRArXpuW
         hgmMPQX81PgXNZ6ZQ4eZBYd4X8Vglr5Zs7g/LBNublPbEdXqd3oGW9sdsIDbODFHa4
         SymMq30JulQYDGoo+JztWFU3thoyVYchAcmVDSUrhGtBo32Dpy1LPU0uRjf+OE/u+L
         x5C3cGYlbq7QfrTuvgLU0cOyEJooTjLPZ/Nl2EpOClsucohWwxMAjjxJyDw2DD4WB6
         UGxk7lwEn6seYhapfyqzlD+Aczfn0AunQ+Ee4BXx/0rQbUxx5VxJUZTaI53C5OSPRx
         LhzoM7zplvXvw==
Message-ID: <fe1ab22c2c2e33e6757988364ac84199.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230206100105.861720-3-angelogioacchino.delregno@collabora.com>
References: <20230206100105.861720-1-angelogioacchino.delregno@collabora.com> <20230206100105.861720-3-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v3 2/7] clk: mediatek: clk-pllfh: Export register/unregister/parse functions
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        edward-jw.yang@mediatek.com, johnson.wang@mediatek.com,
        wenst@chromium.org, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, rex-bc.chen@mediatek.com,
        jose.exposito89@gmail.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Date:   Mon, 13 Mar 2023 11:47:09 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting AngeloGioacchino Del Regno (2023-02-06 02:01:00)
> These functions are used by the various MediaTek apmixed clock drivers
> that may be built as modules: export the common functions used to parse
> related devicetree properties, register and unregister the PLLFH clocks.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---

Applied to clk-next
