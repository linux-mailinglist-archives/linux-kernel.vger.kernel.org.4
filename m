Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992F46B8116
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbjCMSrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbjCMSro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:47:44 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E5385A44;
        Mon, 13 Mar 2023 11:47:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 05615CE1140;
        Mon, 13 Mar 2023 18:47:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E3CDC433D2;
        Mon, 13 Mar 2023 18:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678733242;
        bh=ljsypJpBXhvMBP8K/2+k16E6BKcRzVE1HpkZG0IWuSw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=h93YxbKXox6YIBETRmCrd9KyjNMlZHbKBdsNYTHsyWKKLeuq1TEwwKXQys18O+OKH
         7abYeakeGMa21U7gOBR/aznxVoXzaXpEdDo28qQ55VWkWzdDyvlWxm1O0+jPZjYloP
         nZcRNV35j66R+0ALMl62zeKk2SCh2aZ47SR9XrrBj5lXEjxV3zsob8WNlnrRzwdKzu
         lDrftMi1sWsBixZoifFke6lTmFRDMNTbkPi9kQhpWGMuYbg9JHuqhT5SZhCXuvloHR
         IvDj03iW7LF9BXfBJ/ev/oyyTv+DRJfFWWOluos3ithP/lbDljPm3suL71yb7DseE2
         YoDj9qQAToUcQ==
Message-ID: <c5388593e1d4320901208fe3f21fda1d.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230206100105.861720-4-angelogioacchino.delregno@collabora.com>
References: <20230206100105.861720-1-angelogioacchino.delregno@collabora.com> <20230206100105.861720-4-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v3 3/7] dt-bindings: clock: mediatek,mt8186-fhctl: Support MT6795, MT8173/92/95
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
Date:   Mon, 13 Mar 2023 11:47:20 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting AngeloGioacchino Del Regno (2023-02-06 02:01:01)
> MT6795, MT8173, MT8192 and MT8195 support Frequency Hopping: add the
> compatibles for them.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---

Applied to clk-next
