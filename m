Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449B167C2C0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 03:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbjAZCTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 21:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjAZCTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 21:19:47 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3219061D56;
        Wed, 25 Jan 2023 18:19:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 830F2CE227F;
        Thu, 26 Jan 2023 02:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4F0C433EF;
        Thu, 26 Jan 2023 02:19:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674699582;
        bh=3ppops4WANV0M6ju9EQKG+ap2Z8XXMTIGd3hN/S/qEo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=bm2yWbCF4ELyN7Wi4/yG7Pjp9CjQd+35oVmBRjjyCtRsScxsfEm0Cj2sbS4XnA1zh
         CL19mKXSUeZqYqX4HAsDOlqP5cfVFPYMl14yPKUmu7EkT74On8N0hhGmfjhIuFHne8
         E7v70pe1oq2Fndhi1P+hex1za8c95rp8/nOXNRlPdKU4qCygs+vuQtsrbc921OIJ/o
         ri+RLv/q1aKDLc6fpMPpK28qYOsJZWHI+Bgl8qe7MTOsi2M3bVGBbJZuouYZMAF4Rx
         Nv7F2kY/FNwtmgFTaU3A/+oYE/jZdQ/kvHjGyhttxjBQdEUe4EMBPdacS5BjcSecbh
         KODB/X86NBJag==
Message-ID: <fb868ebae274e55614f5bb6e524d6226.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <367c21c111458abf35170b37d51d023a04a04510.1674401764.git.daniel@makrotopia.org>
References: <cover.1674401764.git.daniel@makrotopia.org> <367c21c111458abf35170b37d51d023a04a04510.1674401764.git.daniel@makrotopia.org>
Subject: Re: [PATCH v4 2/3] dt-bindings: clock: mediatek: add mt7981 clock IDs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Jianhui Zhao <zhaojh329@gmail.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Date:   Wed, 25 Jan 2023 18:19:39 -0800
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Golle (2023-01-22 07:43:00)
> Add MT7981 clock dt-bindings, include topckgen, apmixedsys,
> infracfg, and ethernet subsystem clocks.
>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Jianhui Zhao <zhaojh329@gmail.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---

Applied to clk-next
