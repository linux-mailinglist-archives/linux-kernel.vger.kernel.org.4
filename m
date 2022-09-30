Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775FD5F15E4
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 00:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbiI3WMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 18:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232333AbiI3WMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 18:12:08 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9591806EB;
        Fri, 30 Sep 2022 15:12:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D04BECE26C7;
        Fri, 30 Sep 2022 22:12:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347A1C43149;
        Fri, 30 Sep 2022 22:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664575920;
        bh=5FOBauGLSRI6nRQGji3Nik9GE2yRR+ndKDzxdKAeRKs=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=VQI8DvnFx2T3AOKXu1uJsb0qvHn3DPqndnUi7Odq3Imeyrr//G6ZB1FKxz3gpOd1L
         c/UsF7Vm9XNCvff2CxnYvNoHahfqrlOnyEDcXsVQ7on1J+soVK8fvpyLPTBfehEIfX
         mrZwZO3ySFpMfU2UGjba1dXC09YcWolpg0Y0ta3neV7pxgornf9Ic7E3wwA394f/m8
         fYgff7bneV2314Ee4R/P+hn5t1EOGNzf17WP5lFf6bbp5if2vXwKuheQJXTNaFRMJ/
         P2O8tCE1OjOTp31R4I+QybrCVRKXmQvJ8gEJkPsXSV3I+MCGi6nr84vSLUKR5VGLlq
         CWc1P/nDMcGxw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220822152652.3499972-4-msp@baylibre.com>
References: <20220822152652.3499972-1-msp@baylibre.com> <20220822152652.3499972-4-msp@baylibre.com>
Subject: Re: [PATCH v4 3/4] clk: mediatek: Export required common code symbols
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Markus Schneider-Pargmann <msp@baylibre.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <parent.f@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Fri, 30 Sep 2022 15:11:58 -0700
User-Agent: alot/0.10
Message-Id: <20220930221200.347A1C43149@smtp.kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Markus Schneider-Pargmann (2022-08-22 08:26:51)
> To make clk-mt8365 compilable as a module there are a few function
> symbols missing. This patch adds the required EXPORT_SYMBOL_GPL to the
> functions.
>=20
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---

Applied to clk-next
